import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../data/live.dart';
import '../features/notifications/app_icon_badge.dart';
import '../features/notifications/new_mail.dart';
import '../features/notifications/new_mail_check.dart';
import '../features/notifications/notification_actions.dart';
import '../features/notifications/notification_content.dart';
import '../features/notifications/notification_settings.dart';
import '../settings/app_mode.dart';
import 'background_sync.dart';
import 'foreground_bridge.dart';
import 'local_notifications.dart';
import 'sync_leases.dart';
import 'work_scheduler.dart';

/// The WorkManager jobs' entry point: every job is a background sync.
@pragma('vm:entry-point')
void backgroundTaskDispatcher() {
  Workmanager().executeTask((task, input) async {
    if (task == backgroundSyncTask) {
      try {
        await runBackgroundSync();
      } on Object catch (e) {
        // The next periodic run tries again; retrying at once rarely helps.
        debugPrint('Background sync failed: $e');
      }
    }
    return true;
  }, onTaskStopped: (task, reason) async => _running?.stop());
}

BackgroundSync? _running;

/// Syncs, notifies about new mail and updates the badge (one WorkManager
/// job), unless the app syncs in the foreground.
Future<BackgroundSyncResult> runBackgroundSync() async {
  DartPluginRegistrant.ensureInitialized();
  final directory = await getApplicationSupportDirectory();
  final prefs = await SharedPreferences.getInstance();
  final notifier = await LocalMailNotifier.initializeInBackground(onBackgroundAction: onNotificationAction);
  final sync = _running = BackgroundSync(
    prefs: prefs,
    leases: SyncLeases(directory),
    open: LiveBackgroundMail.open,
    check: NewMailCheck(notifier: notifier, state: FileNewMailStateStore(Future.value(directory))),
    badge: const PlatformAppIconBadge(),
    scheduler: WorkmanagerBackgroundScheduler(WorkmanagerWorkScheduler()),
  );
  try {
    return await sync.run();
  } finally {
    _running = null;
  }
}

/// Archive and Mark as Read on a notification, in the background isolate
/// flutter_local_notifications starts for them.
@pragma('vm:entry-point')
void onNotificationAction(NotificationResponse response) {
  // One at a time: tapping through several notifications queues them.
  _actions = _actions.then((_) => handleNotificationAction(response)).catchError((Object e) {
    debugPrint('Notification action failed: $e');
  });
}

Future<void> _actions = Future.value();

/// Hands the action to the app or the Instant Delivery service if one runs;
/// otherwise opens the database here, applies it, sends it to the server and
/// tidies the notifications.
Future<void> handleNotificationAction(NotificationResponse response) async {
  final action = MailAction.byId(response.actionId);
  final target = NotificationTarget.decode(response.payload);
  if (action == null || action == MailAction.reply || target is! MessageTarget) return;
  // Whoever syncs right now does it: the app, or the Instant Delivery service.
  final request = encodeMailActionRequest(action, target);
  if (await ForegroundBridge.forward(request)) return;
  if (await ForegroundBridge.forward(request, name: ForegroundBridge.instantPortName)) return;

  DartPluginRegistrant.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await prefs.reload();
  if (prefs.getString(AppModeController.key) != AppMode.live.name) return;
  final directory = await getApplicationSupportDirectory();
  final leases = SyncLeases(directory);
  await leases.acquireBackgroundWaiting();
  try {
    final mail = await LiveBackgroundMail.open();
    try {
      await runMailAction(mail.repository, action, target.emailId);
      final notifier = await LocalMailNotifier.initializeInBackground(onBackgroundAction: onNotificationAction);
      await notifier.cancel(response.id ?? messageNotificationId(target.emailId), tag: target.encode());
      await NewMailCheck(
        notifier: notifier,
        state: FileNewMailStateStore(Future.value(directory)),
      ).tidy(mail.repository, NotificationSettings.read(prefs));
      await updateAppIconBadge(prefs, mail.repository, const PlatformAppIconBadge());
      await mail.flushOps().timeout(const Duration(seconds: 40), onTimeout: () {});
      // Offline: a network-bound job sends it as soon as it can.
      if (await mail.hasPendingOps()) {
        await WorkmanagerBackgroundScheduler(WorkmanagerWorkScheduler()).scheduleWakeUp(DateTime.now());
      }
    } finally {
      await mail.close();
    }
  } finally {
    await leases.release(SyncHolder.background);
  }
}

/// The live repository and its store, opened in a background isolate.
final class LiveBackgroundMail implements BackgroundMail {
  LiveBackgroundMail(this._store, this._repository);

  static Future<LiveBackgroundMail> open() async {
    final store = await openLiveStore(createKey: false);
    return LiveBackgroundMail(store, buildLiveRepository(store));
  }

  final MailStore _store;
  final LiveMailRepository _repository;

  @override
  LiveMailRepository get repository => _repository;

  @override
  Future<void> syncOnce() => _repository.syncOnce();

  Future<void> flushOps() => _repository.flushOps();

  Future<bool> hasPendingOps() async => (await _store.pendingOps()).isNotEmpty;

  @override
  Future<void> interrupt() => _repository.dispose();

  @override
  Future<DateTime?> nextSendDue() => nextOutboxDue(_repository);

  @override
  Future<void> close() async {
    await _repository.dispose();
    await _store.close();
  }
}

/// When the next queued message of [repository] is due, if any; the app
/// asks for a wake-up then, in case it isn't running.
Future<DateTime?> nextOutboxDue(LiveMailRepository repository) async {
  DateTime? next;
  for (final item in await repository.watchOutbox().first) {
    if (item.status == OutboxStatus.sending) continue;
    if (next == null || item.sendAt.isBefore(next)) next = item.sendAt;
  }
  return next;
}
