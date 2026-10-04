import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/notifications/new_mail.dart';
import 'package:loupe/features/notifications/new_mail_check.dart';
import 'package:loupe/features/notifications/notification_actions.dart';
import 'package:loupe/features/notifications/notification_content.dart';
import 'package:loupe/platform/instant_runner.dart';
import 'package:loupe/platform/sync_leases.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_icon_badge_test.dart' show RecordingBadge;
import '../features/notifications/fakes.dart';

/// The repository as the service runs it, over [FakeMail].
class FakeInstantMail implements InstantMail {
  FakeInstantMail(this.repository);

  @override
  final FakeMail repository;
  final _synced = StreamController<void>.broadcast();
  bool running = false;
  bool closed = false;
  int flushes = 0;

  /// A sync finished (IDLE brought something, or the poll ran).
  void finishSync() => _synced.add(null);

  @override
  Future<void> run() async => running = true;

  @override
  Future<void> pause() async => running = false;

  @override
  Stream<void> get synced => _synced.stream;

  @override
  Future<void> flushOps() async => flushes++;

  @override
  Future<void> close() async {
    closed = true;
    await _synced.close();
  }
}

void main() {
  late Directory dir;
  late FakeMail mail;
  late FakeInstantMail instant;
  late FakeNotifier notifier;
  late RecordingBadge badge;
  late int stops;
  late InstantRunner runner;
  late SyncLeases app;
  final t0 = DateTime(2026, 10, 4, 9);

  Future<void> start({bool on = true, AppMode mode = AppMode.live}) async {
    SharedPreferences.setMockInitialValues({AppModeController.key: mode.name, 'notifications.instant': on});
    runner = InstantRunner(
      prefs: await SharedPreferences.getInstance(),
      leases: SyncLeases(dir),
      open: () async => instant,
      check: NewMailCheck(notifier: notifier, state: MemoryNewMailStateStore()),
      notifier: notifier,
      badge: badge,
      stopService: () async => stops++,
      debounce: const Duration(milliseconds: 30),
    );
  }

  Future<void> settle() => Future<void>.delayed(const Duration(milliseconds: 80));

  setUp(() {
    dir = Directory.systemTemp.createTempSync('instant_runner_test');
    mail = FakeMail()..account('work');
    instant = FakeInstantMail(mail);
    notifier = FakeNotifier();
    badge = RecordingBadge();
    stops = 0;
    app = SyncLeases(dir);
  });
  tearDown(() => dir.deleteSync(recursive: true));

  test('syncs while the app is away, and the periodic sync stays out', () async {
    await start();
    await runner.tick();
    expect(runner.isActive, isTrue);
    expect(instant.running, isTrue);
    expect(await SyncLeases(dir).tryAcquireBackground(), isFalse, reason: 'the WorkManager job finds it busy');
    await runner.close();
    expect(instant.closed, isTrue);
    expect(await app.isHeld(SyncHolder.background), isFalse);
  });

  test('notifies after a sync brings new mail, and updates the badge', () async {
    await start();
    await runner.tick();
    instant.finishSync();
    await settle();
    expect(notifier.posted, isEmpty, reason: 'the first check sets the watermarks');

    mail.deliver('work', DateTime.now(), subject: 'Within seconds');
    instant
      ..finishSync()
      ..finishSync();
    await settle();
    expect(notifier.messageBodies, ['Within seconds']);
    expect(badge.shown.last, 1);
    await runner.close();
  });

  test('gives the database to the app and takes it back when the app leaves', () async {
    await start();
    await runner.tick();
    await app.renew(SyncHolder.foreground);
    await runner.tick();
    expect(runner.isActive, isFalse);
    expect(instant.running, isFalse);
    expect(await app.isHeld(SyncHolder.background), isFalse, reason: 'the app may sync now');

    // Mail the app shows itself doesn't notify afterwards.
    mail.deliver('work', t0, subject: 'Seen in the app');
    instant.finishSync();
    await settle();
    expect(notifier.posted, isEmpty);

    await app.release(SyncHolder.foreground);
    await runner.tick();
    expect(runner.isActive, isTrue);
    expect(instant.running, isTrue);
    await runner.close();
  });

  test('waits while another background sync has the database', () async {
    await start();
    final periodic = SyncLeases(dir);
    await periodic.renew(SyncHolder.background);
    await runner.tick();
    expect(runner.isActive, isFalse);
    await periodic.release(SyncHolder.background);
    await runner.tick();
    expect(runner.isActive, isTrue);
    await runner.close();
  });

  test('stops the service when switched off or out of live mode', () async {
    await start(on: false);
    await runner.tick();
    expect(stops, 1);
    expect(runner.isActive, isFalse);

    await start(mode: AppMode.demo);
    await runner.tick();
    expect(stops, 2);
  });

  test('runs notification buttons on its own repository', () async {
    await start();
    await runner.tick();
    final email = mail.deliver('work', t0, subject: 'Read me');
    await runner.handle(encodeMailActionRequest(MailAction.markRead, MessageTarget(email.id, 'work')));
    expect((await mail.getEmail(email.id))!.isSeen, isTrue);
    expect(notifier.cancelled, contains(messageNotificationId(email.id)));
    expect(instant.flushes, 0, reason: 'a running repository sends it at once');

    await app.renew(SyncHolder.foreground);
    await runner.tick();
    final other = mail.deliver('work', t0, subject: 'Archive me');
    await runner.handle(encodeMailActionRequest(MailAction.archive, MessageTarget(other.id, 'work')));
    expect(mail.archived, [other.id]);
    expect(instant.flushes, 1, reason: 'paused: sent now, then disconnected');
    await runner.close();
  });

  test('syncsOf fires when an account finishes a sync', () async {
    final statuses = StreamController<List<AccountSyncStatus>>();
    final events = <void>[];
    final sub = syncsOf(statuses.stream).listen(events.add);
    AccountSyncStatus s(String id, SyncPhase phase, [DateTime? at]) =>
        AccountSyncStatus(accountId: id, phase: phase, lastSuccess: at);
    statuses
      ..add([s('a', SyncPhase.syncing)])
      ..add([s('a', SyncPhase.idle, t0)])
      ..add([s('a', SyncPhase.syncing, t0)])
      ..add([s('a', SyncPhase.idle, t0)])
      ..add([s('a', SyncPhase.idle, t0), s('b', SyncPhase.idle, t0)])
      ..add([s('a', SyncPhase.idle, t0.add(const Duration(minutes: 1))), s('b', SyncPhase.idle, t0)]);
    final done = sub.asFuture<void>();
    unawaited(statuses.close());
    await done;
    expect(events, hasLength(3));
  });
}
