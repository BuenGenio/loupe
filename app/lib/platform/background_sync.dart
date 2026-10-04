import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/notifications/app_icon_badge.dart';
import '../features/notifications/new_mail_check.dart';
import '../features/notifications/notification_settings.dart';
import '../features/snooze/snooze_wakeups.dart';
import '../providers.dart';
import '../settings/app_mode.dart';
import '../settings/app_settings.dart';
import 'background.dart';
import 'sync_leases.dart';

/// The live repository as background work uses it.
abstract interface class BackgroundMail {
  MailRepository get repository;

  /// One full sync, including due sends and queued operations.
  Future<void> syncOnce();

  /// Stops a running [syncOnce] soon (the app came to the foreground).
  Future<void> interrupt();

  /// When the next queued message is due to be sent, if any.
  Future<DateTime?> nextSendDue();

  /// Stops syncing and closes the database.
  Future<void> close();
}

enum BackgroundSyncResult {
  /// Demo mode or no account: nothing to do.
  notLive,

  /// The app syncs in the foreground, or Instant Delivery or a notification
  /// button has the database.
  busy,

  /// The app came to the foreground during the sync.
  interrupted,
  synced,
}

/// One background check for new mail (the WorkManager job): sync, notify,
/// update the app icon badge. Skips while the app syncs in the foreground
/// and gives way when it comes back (see [SyncLeases]).
final class BackgroundSync {
  BackgroundSync({
    required this.prefs,
    required this.leases,
    required this.open,
    required this.check,
    required this.badge,
    required this.scheduler,
    DateTime Function()? clock,
    this.watchEvery = const Duration(seconds: 2),
  }) : _clock = clock ?? DateTime.now;

  final SharedPreferences prefs;
  final SyncLeases leases;
  final Future<BackgroundMail> Function() open;
  final NewMailCheck check;
  final AppIconBadge badge;

  /// Wakes the app again for sends that are still queued.
  final BackgroundScheduler scheduler;
  final DateTime Function() _clock;

  /// How often the app's lease is checked while syncing.
  final Duration watchEvery;

  bool _stopped = false;
  BackgroundMail? _mail;

  /// Asks a running [run] to stop (the OS ends the job).
  Future<void> stop() async {
    _stopped = true;
    await _mail?.interrupt();
  }

  Future<BackgroundSyncResult> run() async {
    await prefs.reload();
    if (prefs.getString(AppModeController.key) != AppMode.live.name) return BackgroundSyncResult.notLive;
    if (!await leases.tryAcquireBackground()) return BackgroundSyncResult.busy;
    var lastRenew = _clock();
    final watch = Timer.periodic(watchEvery, (_) async {
      if (await leases.isHeld(SyncHolder.foreground)) {
        await stop();
      } else if (_clock().difference(lastRenew) >= SyncLeases.renewEvery) {
        lastRenew = _clock();
        await leases.renew(SyncHolder.background);
      }
    });
    try {
      return await _sync();
    } finally {
      watch.cancel();
      await leases.release(SyncHolder.background);
    }
  }

  Future<BackgroundSyncResult> _sync() async {
    final mail = _mail = await open();
    try {
      if (_stopped) return BackgroundSyncResult.interrupted;
      final started = _clock();
      await mail.syncOnce();
      if (_stopped) return BackgroundSyncResult.interrupted;
      final repository = mail.repository;
      await check.run(repository, NotificationSettings.read(prefs), since: started);
      await updateAppIconBadge(prefs, repository, badge);
      final due = await mail.nextSendDue();
      if (due != null) await scheduler.scheduleWakeUp(due);
      final wake = await nextSnoozeWake(repository, now: _clock());
      if (wake != null) await scheduler.scheduleWakeUp(wake);
      return BackgroundSyncResult.synced;
    } finally {
      _mail = null;
      await mail.close();
    }
  }
}

/// Puts on the app icon what the app would show: the same setting and
/// counts, from [prefs] and [repository].
Future<void> updateAppIconBadge(SharedPreferences prefs, MailRepository repository, AppIconBadge badge) async {
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs), repositoryProvider.overrideWithValue(repository)],
  );
  try {
    final counted = Completer<int>();
    // Listened, not read: an unlistened stream provider stays paused.
    container.listen<int?>(appIconBadgeCountProvider, (_, count) {
      if (count != null && !counted.isCompleted) counted.complete(count);
    }, fireImmediately: true);
    final count = await counted.future.timeout(const Duration(seconds: 20));
    if (await badge.isSupported()) await badge.show(count);
  } finally {
    container.dispose();
  }
}
