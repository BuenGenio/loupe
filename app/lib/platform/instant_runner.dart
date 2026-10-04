import 'dart:async';

import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/notifications/app_icon_badge.dart';
import '../features/notifications/mail_notifier.dart';
import '../features/notifications/new_mail_check.dart';
import '../features/notifications/notification_actions.dart';
import '../features/notifications/notification_content.dart';
import '../features/notifications/notification_settings.dart';
import '../settings/app_mode.dart';
import 'background_sync.dart';
import 'sync_leases.dart';

/// The live repository as instant delivery runs it: syncing with IMAP IDLE
/// on the inboxes, paused while the app syncs itself.
abstract interface class InstantMail {
  MailRepository get repository;

  /// Starts or resumes syncing (and IDLE).
  Future<void> run();

  /// Stops syncing and closes the connections.
  Future<void> pause();

  /// Fires after each successful sync of any account.
  Stream<void> get synced;

  /// Sends queued operations now (a notification button while paused).
  Future<void> flushOps();

  Future<void> close();
}

/// Instant delivery (experimental): what the foreground service does while
/// it runs. Every [tick] (a few seconds, and when the app nudges it):
///
/// - stops the service when Instant Delivery was switched off or the app
///   left live mode;
/// - pauses while the app holds the foreground lease (the app syncs);
/// - otherwise holds the background lease (the periodic sync then skips)
///   and keeps the repository syncing, so IDLE brings new mail in seconds.
///
/// After each sync it checks for new mail, notifies and updates the badge,
/// like the periodic background sync.
final class InstantRunner {
  InstantRunner({
    required this.prefs,
    required this.leases,
    required this.open,
    required this.check,
    required this.notifier,
    required this.badge,
    required this.stopService,
    DateTime Function()? clock,
    this.debounce = const Duration(seconds: 2),
  }) : _clock = clock ?? DateTime.now;

  final SharedPreferences prefs;
  final SyncLeases leases;
  final Future<InstantMail> Function() open;
  final NewMailCheck check;
  final MailNotifier notifier;
  final AppIconBadge badge;

  /// Ends the foreground service (Instant Delivery was switched off).
  final Future<void> Function() stopService;
  final DateTime Function() _clock;

  /// Bursts of syncs (IDLE, several accounts) make one check.
  final Duration debounce;

  InstantMail? _mail;
  StreamSubscription<void>? _synced;
  Timer? _checkTimer;
  bool _active = false;
  bool _closed = false;
  DateTime? _renewed;
  Future<void> _queue = Future.value();

  /// Whether it syncs right now (holds the background lease).
  bool get isActive => _active;

  Future<void> tick() => _serial(_tick);

  Future<void> _tick() async {
    if (_closed) return;
    await prefs.reload();
    final live = prefs.getString(AppModeController.key) == AppMode.live.name;
    if (!live || !NotificationSettings.read(prefs).instant) {
      await _deactivate();
      // Not awaited: stopping the service closes this runner, which waits
      // for this tick.
      unawaited(stopService());
      return;
    }
    if (await leases.isHeld(SyncHolder.foreground)) {
      await _deactivate();
      return;
    }
    if (_active) {
      if (_clock().difference(_renewed!) >= SyncLeases.renewEvery) await _renew();
      return;
    }
    // A periodic sync or a notification button has the database: next time.
    if (!await leases.tryAcquireBackground()) return;
    _renewed = _clock();
    _active = true;
    try {
      final mail = _mail ??= await open();
      _synced ??= mail.synced.listen((_) => _scheduleCheck());
      await mail.run();
    } catch (_) {
      _active = false;
      await leases.release(SyncHolder.background);
      rethrow;
    }
  }

  Future<void> _renew() async {
    _renewed = _clock();
    await leases.renew(SyncHolder.background);
  }

  Future<void> _deactivate() async {
    if (!_active) return;
    _active = false;
    _checkTimer?.cancel();
    await _mail?.pause();
    await leases.release(SyncHolder.background);
  }

  void _scheduleCheck() {
    if (!_active) return;
    _checkTimer?.cancel();
    _checkTimer = Timer(debounce, () => unawaited(_serial(_check)));
  }

  Future<void> _check() async {
    final mail = _mail;
    if (!_active || mail == null) return;
    await prefs.reload();
    await check.run(mail.repository, NotificationSettings.read(prefs));
    await updateAppIconBadge(prefs, mail.repository, badge);
  }

  /// Archive or Mark as Read, handed over from the notification isolate
  /// while the service runs.
  Future<void> handle(Map<String, Object?> request) => _serial(() async {
    final r = decodeMailActionRequest(request);
    final mail = _mail ??= await open();
    if (r == null) return;
    await runMailAction(mail.repository, r.action, r.target.emailId);
    await notifier.cancel(messageNotificationId(r.target.emailId), tag: r.target.encode());
    await check.tidy(mail.repository, NotificationSettings.read(prefs));
    await updateAppIconBadge(prefs, mail.repository, badge);
    if (!_active) await mail.flushOps();
  });

  /// The service ends: stop syncing and close the database.
  Future<void> close() => _serial(() async {
    _closed = true;
    _checkTimer?.cancel();
    await _synced?.cancel();
    await _deactivate();
    await _mail?.close();
    _mail = null;
  });

  Future<void> _serial(Future<void> Function() step) {
    final next = _queue.then((_) => step());
    _queue = next.catchError((Object _) {});
    return next;
  }
}

/// Fires whenever an account's last successful sync moves on.
Stream<void> syncsOf(Stream<List<AccountSyncStatus>> statuses) async* {
  final last = <String, DateTime>{};
  await for (final list in statuses) {
    var moved = false;
    for (final s in list) {
      final t = s.lastSuccess;
      if (t == null) continue;
      final previous = last[s.accountId];
      if (previous == null || t.isAfter(previous)) {
        last[s.accountId] = t;
        moved = true;
      }
    }
    if (moved) yield null;
  }
}
