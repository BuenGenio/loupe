import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/platform/foreground_sync.dart';
import 'package:loupe/platform/sync_leases.dart';

void main() {
  late Directory dir;
  late DateTime now;
  late SyncLeases leases;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('sync_leases_test');
    now = DateTime(2026, 10, 4, 9);
    leases = SyncLeases(dir, clock: () => now);
  });
  tearDown(() => dir.deleteSync(recursive: true));

  group('SyncLeases', () {
    test('a lease holds until released or stale; a dead holder never blocks for long', () async {
      expect(await leases.isHeld(SyncHolder.foreground), isFalse);
      await leases.renew(SyncHolder.foreground);
      expect(await leases.isHeld(SyncHolder.foreground), isTrue);
      expect(await leases.isHeld(SyncHolder.background), isFalse);

      now = now.add(const Duration(seconds: 44));
      expect(await leases.isHeld(SyncHolder.foreground), isTrue);
      now = now.add(const Duration(seconds: 2));
      expect(await leases.isHeld(SyncHolder.foreground), isFalse, reason: 'the app was killed');

      await leases.renew(SyncHolder.foreground);
      await leases.release(SyncHolder.foreground);
      expect(await leases.isHeld(SyncHolder.foreground), isFalse);
      await leases.release(SyncHolder.foreground);
    });

    test('survives the process: another instance on the same directory sees the lease', () async {
      await leases.renew(SyncHolder.background);
      final other = SyncLeases(dir, clock: () => now);
      expect(await other.isHeld(SyncHolder.background), isTrue);
    });

    test('a lease from the future (the clock went back) doesn’t hold for long', () async {
      await leases.renew(SyncHolder.foreground);
      now = now.subtract(const Duration(minutes: 5));
      expect(await leases.isHeld(SyncHolder.foreground), isFalse);
    });

    test('garbage in a lease file counts as no lease', () async {
      File('${dir.path}/sync-foreground.lease').writeAsStringSync('hello');
      expect(await leases.isHeld(SyncHolder.foreground), isFalse);
    });

    test('background work gives way to the app', () async {
      expect(await leases.tryAcquireBackground(), isTrue);
      expect(await leases.isHeld(SyncHolder.background), isTrue);
      await leases.release(SyncHolder.background);

      await leases.renew(SyncHolder.foreground);
      expect(await leases.tryAcquireBackground(), isFalse);
      expect(await leases.isHeld(SyncHolder.background), isFalse, reason: 'left nothing behind');
    });

    test('the app waits for running background work, but not forever', () async {
      final real = SyncLeases(dir);
      final background = SyncLeases(dir);
      await background.renew(SyncHolder.background);
      var waited = false;
      final acquired = real
          .acquireForeground(maxWait: const Duration(seconds: 5), poll: const Duration(milliseconds: 20))
          .then((ok) => waited = ok);
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(await real.isHeld(SyncHolder.foreground), isTrue, reason: 'claimed at once, so the background stops');
      expect(waited, isFalse);
      await background.release(SyncHolder.background);
      await acquired;
      expect(waited, isTrue);

      await background.renew(SyncHolder.background);
      expect(
        await real.acquireForeground(
          maxWait: const Duration(milliseconds: 100),
          poll: const Duration(milliseconds: 20),
        ),
        isFalse,
      );
    });

    test('a notification action waits for a background sync, then goes ahead', () async {
      final sync = SyncLeases(dir);
      final action = SyncLeases(dir);
      await sync.renew(SyncHolder.background);
      final started = DateTime.now();
      await action.acquireBackgroundWaiting(
        maxWait: const Duration(milliseconds: 150),
        poll: const Duration(milliseconds: 20),
      );
      expect(DateTime.now().difference(started), greaterThanOrEqualTo(const Duration(milliseconds: 150)));
      expect(await action.isHeldByOther(SyncHolder.background), isFalse, reason: 'its own now');
      expect(await sync.isHeldByOther(SyncHolder.background), isTrue);
    });

    test('only one background syncer at a time; each releases only its own lease', () async {
      final periodic = SyncLeases(dir, clock: () => now);
      final instant = SyncLeases(dir, clock: () => now);
      expect(await instant.tryAcquireBackground(), isTrue);
      expect(await instant.tryAcquireBackground(), isTrue, reason: 'its own lease');
      expect(await periodic.tryAcquireBackground(), isFalse);
      await periodic.release(SyncHolder.background);
      expect(await periodic.isHeld(SyncHolder.background), isTrue, reason: 'not periodic’s to release');
      await instant.release(SyncHolder.background);
      expect(await periodic.tryAcquireBackground(), isTrue);
    });

    test('a lease written before owners counts, as nobody’s', () async {
      File('${dir.path}/sync-background.lease').writeAsStringSync('${now.millisecondsSinceEpoch}');
      expect(await leases.isHeld(SyncHolder.background), isTrue);
      expect(await leases.tryAcquireBackground(), isFalse);
    });
  });

  group('ForegroundSync', () {
    late List<String> log;
    late ForegroundSync sync;
    late SyncLeases real;

    setUp(() {
      log = [];
      real = SyncLeases(dir);
      sync = ForegroundSync(
        leases: Future.value(real),
        pause: () async => log.add('pause'),
        resume: () async => log.add('resume'),
        onBackground: () async => log.add('check'),
        maxWait: const Duration(seconds: 2),
      );
    });

    test('syncs in the foreground, pauses and checks in the background, holding the lease meanwhile', () async {
      await sync.enterForeground();
      expect(log, ['resume']);
      expect(await real.isHeld(SyncHolder.foreground), isTrue);
      expect(sync.inForeground, isTrue);

      await sync.enterBackground();
      expect(log, ['resume', 'pause', 'check']);
      expect(await real.isHeld(SyncHolder.foreground), isFalse);
      expect(sync.inForeground, isFalse);
      await sync.dispose();
    });

    test('waits for a background sync to give way before syncing', () async {
      final background = SyncLeases(dir);
      await background.renew(SyncHolder.background);
      final entered = sync.enterForeground();
      await Future<void>.delayed(const Duration(milliseconds: 400));
      expect(log, isEmpty);
      await background.release(SyncHolder.background);
      await entered;
      expect(log, ['resume']);
      await sync.dispose();
    });

    test('a quick switch back skips the stale steps and keeps the lease', () async {
      await sync.enterForeground();
      log.clear();
      final away = sync.enterBackground();
      final back = sync.enterForeground();
      await Future.wait([away, back]);
      expect(log.last, 'resume', reason: 'ends up syncing');
      expect(await real.isHeld(SyncHolder.foreground), isTrue);
      await sync.dispose();
      expect(await real.isHeld(SyncHolder.foreground), isFalse);
    });
  });
}
