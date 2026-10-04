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
import 'background.dart';
import 'background_sync.dart';
import 'foreground_bridge.dart';
import 'local_notifications.dart';
import 'sync_leases.dart';
import 'work_scheduler.dart';

/// The background jobs' entry point (WorkManager on Android, the
/// BGAppRefreshTask on iOS): every job is a background sync.
@pragma('vm:entry-point')
void backgroundTaskDispatcher() {
  Workmanager().executeTask((task, input) async {
    if (isBackgroundSyncTask(task)) {
      try {
        await runBackgroundSync(budget: task == iosRefreshTask ? iosRefreshBudget : null);
      } on Object catch (e) {
        // The next periodic run tries again; retrying at once rarely helps.
        debugPrint('Background sync failed: $e');
      }
    }
    return true;
  }, onTaskStopped: (task, reason) async => _running?.stop());
}

BackgroundSync? _running;

/// How long an iOS background refresh may sync. iOS gives the job about 30
/// seconds in all (starting the engine included) and ends the app if it
/// isn't done by then; the next refresh carries on.
const iosRefreshBudget = Duration(seconds: 20);

/// Syncs, notifies about new mail and updates the badge (one background
/// job), unless the app syncs in the foreground. With a [budget], stops
/// syncing when it runs out.
Future<BackgroundSyncResult> runBackgroundSync({Duration? budget}) async {
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
    scheduler: platformSyncScheduler() ?? const NoopBackgroundScheduler(),
  );
  final deadline = budget == null ? null : Timer(budget, () => unawaited(sync.stop()));
  try {
    return await sync.run();
  } finally {
    deadline?.cancel();
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
      // Android may freeze this process before the server has it, or there
      // is no network: a sync shortly after sends what is left either way.
      // (iOS has no such wake-up; its next refresh does it.)
      await platformSyncScheduler()?.scheduleWakeUp(afterAction());
      await mail.flushOps().timeout(const Duration(seconds: 40), onTimeout: () {});
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

/// When to sync again after a notification button ran in the background,
/// in case its change didn't reach the server.
DateTime afterAction() => DateTime.now().add(const Duration(minutes: 1));

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
