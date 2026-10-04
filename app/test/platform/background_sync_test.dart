import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/notifications/new_mail.dart';
import 'package:loupe/features/notifications/new_mail_check.dart';
import 'package:loupe/platform/background.dart';
import 'package:loupe/platform/background_sync.dart';
import 'package:loupe/platform/sync_leases.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_icon_badge_test.dart' show RecordingBadge;
import '../features/notifications/fakes.dart';

/// The live repository as the background job sees it, over [FakeMail]:
/// [onSync] stands in for what the server delivers.
class FakeBackgroundMail implements BackgroundMail {
  FakeBackgroundMail(this.repository, {this.onSync, this.due});

  @override
  final FakeMail repository;
  final Future<void> Function()? onSync;
  final DateTime? due;
  bool interrupted = false;
  bool closed = false;
  int syncs = 0;

  @override
  Future<void> syncOnce() async {
    syncs++;
    await onSync?.call();
  }

  @override
  Future<void> interrupt() async => interrupted = true;

  @override
  Future<DateTime?> nextSendDue() async => due;

  @override
  Future<void> close() async => closed = true;
}

class RecordingScheduler implements BackgroundScheduler {
  final times = <DateTime>[];

  @override
  Future<void> scheduleWakeUp(DateTime time) async => times.add(time);
}

void main() {
  late Directory dir;
  late SyncLeases leases;
  late FakeMail mail;
  late FakeNotifier notifier;
  late MemoryNewMailStateStore state;
  late RecordingBadge badge;
  late RecordingScheduler scheduler;
  var now = DateTime(2026, 10, 4, 9);

  setUp(() {
    dir = Directory.systemTemp.createTempSync('background_sync_test');
    leases = SyncLeases(dir);
    mail = FakeMail()..account('work');
    notifier = FakeNotifier();
    state = MemoryNewMailStateStore();
    badge = RecordingBadge();
    scheduler = RecordingScheduler();
    now = DateTime(2026, 10, 4, 9);
  });
  tearDown(() => dir.deleteSync(recursive: true));

  Future<BackgroundSync> backgroundSync(
    FakeBackgroundMail background, {
    AppMode mode = AppMode.live,
    Map<String, Object> prefs = const {},
  }) async {
    SharedPreferences.setMockInitialValues({AppModeController.key: mode.name, ...prefs});
    return BackgroundSync(
      prefs: await SharedPreferences.getInstance(),
      leases: leases,
      open: () async => background,
      check: NewMailCheck(notifier: notifier, state: state, clock: () => now),
      badge: badge,
      scheduler: scheduler,
      clock: () => now,
      watchEvery: const Duration(milliseconds: 20),
    );
  }

  test('syncs, notifies about what arrived, updates the badge and lets go', () async {
    // The first run only sets the watermarks.
    final first = FakeBackgroundMail(mail);
    expect(await (await backgroundSync(first)).run(), BackgroundSyncResult.synced);
    expect(first.closed, isTrue);
    expect(notifier.posted, isEmpty);

    now = now.add(const Duration(minutes: 15));
    final background = FakeBackgroundMail(
      mail,
      onSync: () async => mail.deliver('work', now.subtract(const Duration(minutes: 3)), subject: 'Overnight'),
      due: DateTime(2026, 10, 4, 12),
    );
    expect(await (await backgroundSync(background)).run(), BackgroundSyncResult.synced);
    expect(notifier.messageBodies, ['Overnight']);
    expect(badge.shown.last, 1);
    expect(scheduler.times, [DateTime(2026, 10, 4, 12)], reason: 'a queued send gets its wake-up');
    expect(await leases.isHeld(SyncHolder.background), isFalse);
  });

  test('the badge follows the app’s setting', () async {
    mail.vips.add('boss@example.com');
    mail
      ..deliver('work', now, subject: 'a')
      ..deliver('work', now, subject: 'b', from: 'boss@example.com');
    await (await backgroundSync(FakeBackgroundMail(mail), prefs: {'settings.appIconBadge': 'vip'})).run();
    expect(badge.shown.last, 1);
    await (await backgroundSync(FakeBackgroundMail(mail), prefs: {'settings.appIconBadge': 'off'})).run();
    expect(badge.shown.last, 0);
  });

  test('skips while the app syncs in the foreground', () async {
    await leases.renew(SyncHolder.foreground);
    final background = FakeBackgroundMail(mail);
    expect(await (await backgroundSync(background)).run(), BackgroundSyncResult.appActive);
    expect(background.syncs, 0);
  });

  test('does nothing in demo mode', () async {
    final background = FakeBackgroundMail(mail);
    expect(await (await backgroundSync(background, mode: AppMode.demo)).run(), BackgroundSyncResult.notLive);
    expect(background.syncs, 0);
    expect(await leases.isHeld(SyncHolder.background), isFalse);
  });

  test('gives way when the app comes to the foreground, without notifying', () async {
    await (await backgroundSync(FakeBackgroundMail(mail))).run();
    final appBack = Completer<void>();
    late FakeBackgroundMail background;
    background = FakeBackgroundMail(
      mail,
      onSync: () async {
        mail.deliver('work', now.add(const Duration(minutes: 1)), subject: 'Mid-sync');
        await leases.renew(SyncHolder.foreground);
        // The sync runs until the job notices the app and interrupts it.
        while (!background.interrupted) {
          await Future<void>.delayed(const Duration(milliseconds: 10));
        }
        appBack.complete();
      },
    );
    expect(await (await backgroundSync(background)).run(), BackgroundSyncResult.interrupted);
    expect(appBack.isCompleted, isTrue);
    expect(notifier.posted, isEmpty, reason: 'the app shows that mail itself');
    expect(background.closed, isTrue);
    expect(await leases.isHeld(SyncHolder.background), isFalse);
  });

  test('the OS ending the job stops the sync', () async {
    late FakeBackgroundMail background;
    late BackgroundSync sync;
    background = FakeBackgroundMail(
      mail,
      onSync: () async {
        await sync.stop();
      },
    );
    sync = await backgroundSync(background);
    expect(await sync.run(), BackgroundSyncResult.interrupted);
    expect(background.interrupted, isTrue);
  });
}
