import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/live.dart';
import '../features/notifications/app_icon_badge.dart';
import '../features/notifications/new_mail.dart';
import '../features/notifications/new_mail_check.dart';
import 'background_entry.dart';
import 'foreground_bridge.dart';
import 'instant_runner.dart';
import 'local_notifications.dart';
import 'sync_leases.dart';

/// The Instant Delivery foreground service, as the app controls it.
abstract interface class InstantService {
  Future<bool> isRunning();

  /// Starts the service (only allowed while the app is in the foreground).
  /// Returns whether it runs.
  Future<bool> start();

  Future<void> stop();

  /// Tells a running service to look at the leases now: the app is coming
  /// to the foreground and wants the database.
  void nudge();

  /// Whether Android's battery optimisation may stop the service.
  Future<bool> isBatteryRestricted();

  /// Opens the system list where Loupe can be let run unrestricted.
  Future<void> openBatterySettings();
}

/// No foreground service (tests, platforms other than Android).
final class NoopInstantService implements InstantService {
  const NoopInstantService();

  @override
  Future<bool> isRunning() async => false;

  @override
  Future<bool> start() async => false;

  @override
  Future<void> stop() async {}

  @override
  void nudge() {}

  @override
  Future<bool> isBatteryRestricted() async => false;

  @override
  Future<void> openBatterySettings() async {}
}

final instantServiceProvider = Provider<InstantService>((ref) => const NoopInstantService());

/// Whether this build offers Instant Delivery: on Android. Elsewhere
/// Settings says it is coming.
final instantDeliveryAvailableProvider = Provider<bool>((ref) => false);

/// [InstantService] through flutter_foreground_task: a `specialUse`
/// foreground service with a quiet "Watching for new mail" notification,
/// started again after a reboot or an update.
final class ForegroundTaskInstantService implements InstantService {
  /// Sets the plugin up; call once in the main isolate.
  ForegroundTaskInstantService() {
    FlutterForegroundTask.initCommunicationPort();
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'loupe.instant',
        channelName: 'Instant Delivery',
        channelDescription: 'Shows while Loupe watches your inboxes for new mail',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(showNotification: false),
      foregroundTaskOptions: ForegroundTaskOptions(
        // How often the service looks at the leases and its settings.
        eventAction: ForegroundTaskEventAction.repeat(3000),
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        // IDLE needs the CPU to answer the server and to renew it; this is
        // the battery cost the setting warns about.
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  static const _serviceId = 4711;

  /// AndroidManifest.xml meta-data pointing at the status bar icon.
  static const _iconMetaData = 'io.github.buengenio.loupe.NOTIFICATION_ICON';

  @override
  Future<bool> isRunning() => FlutterForegroundTask.isRunningService;

  @override
  Future<bool> start() async {
    if (await isRunning()) return true;
    final result = await FlutterForegroundTask.startService(
      serviceId: _serviceId,
      serviceTypes: [ForegroundServiceTypes.specialUse],
      notificationTitle: 'Watching for new mail',
      notificationText: 'Instant Delivery is on',
      notificationIcon: const NotificationIcon(metaDataName: _iconMetaData),
      callback: startInstantDelivery,
    );
    if (result is ServiceRequestFailure) debugPrint('Instant Delivery did not start: ${result.error}');
    return result is ServiceRequestSuccess;
  }

  @override
  Future<void> stop() async {
    if (await isRunning()) await FlutterForegroundTask.stopService();
  }

  @override
  void nudge() => FlutterForegroundTask.sendDataToTask('nudge');

  @override
  Future<bool> isBatteryRestricted() async => !await FlutterForegroundTask.isIgnoringBatteryOptimizations;

  @override
  Future<void> openBatterySettings() async => FlutterForegroundTask.openIgnoreBatteryOptimizationSettings();
}

/// The foreground service's entry point.
@pragma('vm:entry-point')
void startInstantDelivery() => FlutterForegroundTask.setTaskHandler(InstantTaskHandler());

/// Runs [InstantRunner] in the service's isolate.
class InstantTaskHandler extends TaskHandler {
  InstantRunner? _runner;
  ForegroundBridgeServer? _bridge;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    final directory = await getApplicationSupportDirectory();
    final prefs = await SharedPreferences.getInstance();
    final notifier = await LocalMailNotifier.initializeInBackground(onBackgroundAction: onNotificationAction);
    final runner = _runner = InstantRunner(
      prefs: prefs,
      leases: SyncLeases(directory),
      open: LiveInstantMail.open,
      check: NewMailCheck(
        notifier: notifier,
        state: FileNewMailStateStore(Future.value(directory)),
        subjects: () => backgroundSubjectDecryptor(prefs),
      ),
      notifier: notifier,
      badge: const PlatformAppIconBadge(),
      stopService: () async {
        await FlutterForegroundTask.stopService();
      },
    );
    // Notification buttons come here while the app isn't running.
    _bridge = ForegroundBridge.serve(runner.handle, name: ForegroundBridge.instantPortName);
    _tick();
  }

  void _tick() {
    unawaited(
      _runner?.tick().catchError((Object e) {
        debugPrint('Instant Delivery: $e');
      }),
    );
  }

  @override
  void onRepeatEvent(DateTime timestamp) => _tick();

  @override
  void onReceiveData(Object data) => _tick();

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    _bridge?.close();
    await _runner?.close().timeout(const Duration(seconds: 10), onTimeout: () {});
  }
}

/// The live repository in the service's isolate. IDLE watches the inboxes;
/// other folders sync every 15 minutes.
final class LiveInstantMail implements InstantMail {
  LiveInstantMail._(this._store, this._repository);

  static Future<LiveInstantMail> open() async {
    final store = await openLiveStore(createKey: false);
    final repository = buildLiveRepository(
      store,
      keys: await backgroundSendKeys(),
      config: const SyncConfig(pollInterval: Duration(minutes: 15)),
    );
    await repository.pause();
    await repository.start();
    return LiveInstantMail._(store, repository);
  }

  final MailStore _store;
  final LiveMailRepository _repository;

  @override
  MailRepository get repository => _repository;

  @override
  Future<void> run() => _repository.resume();

  @override
  Future<void> pause() => _repository.pause();

  @override
  Future<void> flushOps() => _repository.flushOps();

  @override
  Stream<void> get synced => syncsOf(_repository.watchSyncStatus());

  @override
  Future<void> close() async {
    await _repository.dispose();
    await _store.close();
  }
}
