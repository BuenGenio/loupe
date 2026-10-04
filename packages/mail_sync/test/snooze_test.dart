import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

/// Polls rarely, so only the snooze timer (or an explicit sync) wakes.
const _quietConfig = SyncConfig(
  pollInterval: Duration(days: 1),
  reconnectBase: Duration(seconds: 5),
  reconnectMax: Duration(minutes: 1),
  opRetryBase: Duration(seconds: 10),
  maxOpAttempts: 3,
);

/// For tests that wait for a snooze in the evening.
const _hours12 = Duration(hours: 12);

void main() {
  // fakeTime starts at 2026-09-01 12:00 local time.
  final evening = DateTime(2026, 9, 1, 18);

  Set<String> keywordsOn(FakeServer server, String path, String subject) => server.find(path, subject)!.keywords;

  test('snoozing creates Snoozed, sets the wake time and moves the message, offline first', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'Later', keywords: {Keywords.seen});
      final a = await h.add(server);
      final e = await h.email(a, 'INBOX', 'Later');
      server.offline = true;
      await server.dropConnections();

      expect(await h.repo.snooze([e.id], evening), SnoozeStorage.server);
      expect(await h.subjects(a, 'INBOX'), isEmpty);
      expect(await h.subjects(a, 'Snoozed'), ['Later']);
      final snoozed = await h.repo.watchSnoozed().first;
      expect(snoozed.single.snoozedUntil, evening.toUtc());
      expect(server.mailboxes.containsKey('Snoozed'), isFalse);
      // A failed sync meanwhile keeps the folder that is still to be created.
      await h.repo.refresh();
      expect(await h.subjects(a, 'Snoozed'), ['Later']);

      server.offline = false;
      await settle(const Duration(minutes: 1));
      expect(await h.store.pendingOps(), isEmpty);
      expect(server.log.where((l) => l.startsWith('create:')), ['create:Snoozed']);
      expect(server.subjects('INBOX'), isEmpty);
      expect(keywordsOn(server, 'Snoozed', 'Later'), {Keywords.seen, Snooze.keyword(evening)});
      // The keyword was set before the move.
      final log = server.log.where((l) => l == 'setKeywords' || l == 'move').toList();
      expect(log, ['setKeywords', 'move']);
      expect(await h.subjects(a, 'Snoozed'), ['Later']);
      expect(h.errors, isEmpty);
      await h.dispose();
    });
  });

  test('snoozing again changes the time in place', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'Later');
      final a = await h.add(server);
      await h.repo.snooze([(await h.email(a, 'INBOX', 'Later')).id], evening);
      await settle();
      final tomorrow = DateTime(2026, 9, 2, 8);
      final moves = server.log.where((l) => l == 'move').length;
      await h.repo.snooze([(await h.email(a, 'Snoozed', 'Later')).id], tomorrow);
      expect((await h.repo.watchSnoozed().first).single.snoozedUntil, tomorrow.toUtc());
      await settle();
      expect(keywordsOn(server, 'Snoozed', 'Later'), {Snooze.keyword(tomorrow)});
      expect(server.log.where((l) => l == 'move'), hasLength(moves), reason: 'no second move');
      await h.dispose();
    });
  });

  test('a due message wakes on the next sync: Inbox, unread, \$new, no snooze keyword', () {
    fakeTime((async) async {
      final h = Harness(config: _quietConfig);
      final server = FakeServer()..deliver('INBOX', subject: 'Later', keywords: {Keywords.seen, Keywords.flagged});
      final a = await h.add(server);
      await h.repo.snooze([(await h.email(a, 'INBOX', 'Later')).id], evening);
      await settle();
      await h.repo.refresh();
      expect(server.subjects('Snoozed'), ['Later'], reason: 'not due yet');

      await Future<void>.delayed(const Duration(hours: 6, minutes: 1));
      expect(server.subjects('Snoozed'), ['Later'], reason: 'nothing synced since');
      await h.repo.refresh();
      await settle();
      expect(server.subjects('Snoozed'), isEmpty);
      expect(server.subjects('INBOX'), ['Later']);
      expect(keywordsOn(server, 'INBOX', 'Later'), {Keywords.flagged, Keywords.newAgain});
      final woken = await h.email(a, 'INBOX', 'Later');
      expect(woken.isSeen, isFalse);
      expect(woken.isNewAgain, isTrue);
      expect(woken.snoozedUntil, isNull);
      expect(await h.repo.watchSnoozed().first, isEmpty);
      expect(await h.store.pendingOps(), isEmpty);
      await h.dispose();
    }, limit: _hours12);
  });

  test('while running, a timer wakes the message on time', () {
    fakeTime((async) async {
      final h = Harness(config: _quietConfig);
      final server = FakeServer()..deliver('INBOX', subject: 'Later');
      final a = await h.add(server);
      await h.repo.start();
      final soon = DateTime(2026, 9, 1, 12, 30);
      await h.repo.snooze([(await h.email(a, 'INBOX', 'Later')).id], soon);
      await settle();
      await Future<void>.delayed(const Duration(minutes: 28));
      expect(server.subjects('Snoozed'), ['Later']);
      await Future<void>.delayed(const Duration(minutes: 2));
      expect(await h.subjects(a, 'INBOX'), ['Later']);
      await settle();
      expect(server.subjects('INBOX'), ['Later']);
      await h.dispose();
    });
  });

  test('Wake Now brings it back at once', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'Later', keywords: {Keywords.seen});
      final a = await h.add(server);
      await h.repo.snooze([(await h.email(a, 'INBOX', 'Later')).id], evening);
      await settle();
      await h.repo.unsnooze([(await h.email(a, 'Snoozed', 'Later')).id]);
      expect(await h.subjects(a, 'INBOX'), ['Later']);
      expect(await h.repo.watchSnoozed().first, isEmpty);
      await settle();
      expect(server.subjects('INBOX'), ['Later']);
      expect(keywordsOn(server, 'INBOX', 'Later'), {Keywords.newAgain});
      await h.dispose();
    });
  });

  test('Undo right after snoozing puts it back as it was', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'Oops', keywords: {Keywords.seen});
      final a = await h.add(server);
      final e = await h.email(a, 'INBOX', 'Oops');
      server.offline = true;
      await server.dropConnections();
      await h.repo.snooze([e.id], evening);
      // What MailActions' Undo does: move back, restore the keyword's absence.
      await h.repo.move([e.id], e.mailboxId);
      await h.repo.setKeywords([e.id], remove: {Snooze.keyword(evening)});
      expect(await h.subjects(a, 'INBOX'), ['Oops']);
      expect(await h.repo.watchSnoozed().first, isEmpty);
      server.offline = false;
      await settle(const Duration(minutes: 1));
      await h.repo.refresh();
      expect(server.subjects('INBOX'), ['Oops']);
      expect(keywordsOn(server, 'INBOX', 'Oops'), {Keywords.seen});
      expect(await h.subjects(a, 'INBOX'), ['Oops']);
      expect((await h.email(a, 'INBOX', 'Oops')).keywords, {Keywords.seen});
      expect(await h.store.pendingOps(), isEmpty);
      await h.dispose();
    });
  });

  test('messages snoozed by another client wake here; invalid keywords are left alone', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer();
      server.addMailbox('Snoozed');
      server
        ..deliver('Snoozed', subject: 'Due', keywords: {Snooze.keyword(DateTime(2026, 9, 1, 11))})
        ..deliver('Snoozed', subject: 'Tomorrow', keywords: {Snooze.keyword(DateTime(2026, 9, 2, 8))})
        ..deliver('Snoozed', subject: 'Foreign', keywords: {r'$snoozed-soon', Keywords.seen})
        ..deliver('Snoozed', subject: 'Plain', keywords: {Keywords.seen});
      final a = await h.add(server);
      await settle();
      expect(server.subjects('INBOX'), ['Due']);
      expect(server.subjects('Snoozed'), ['Tomorrow', 'Foreign', 'Plain']);
      expect(keywordsOn(server, 'Snoozed', 'Foreign'), {r'$snoozed-soon', Keywords.seen});
      // Soonest first; those without a valid time last.
      final list = await h.repo.watchSnoozed().first;
      expect(list.map((e) => e.subject), ['Tomorrow', 'Plain', 'Foreign']);
      expect(await h.subjects(a, 'INBOX'), ['Due']);
      await h.dispose();
    });
  });

  test('two devices waking the same message at once leave one unread copy in the Inbox', () {
    fakeTime((async) async {
      final server = FakeServer()..deliver('INBOX', subject: 'Both', keywords: {Keywords.seen});
      final phone = Harness(config: _quietConfig);
      final tablet = Harness(config: _quietConfig);
      final a = await phone.add(server);
      final b = await tablet.add(server);
      final at = DateTime(2026, 9, 1, 13);
      await phone.repo.snooze([(await phone.email(a, 'INBOX', 'Both')).id], at);
      await settle();
      await tablet.repo.refresh();
      expect(await tablet.subjects(b, 'Snoozed'), ['Both']);
      await phone.repo.start();
      await tablet.repo.start();

      // Both wake it at 13:00 while the server is out of reach…
      server.offline = true;
      await server.dropConnections();
      await Future<void>.delayed(const Duration(hours: 1));
      expect(await phone.subjects(a, 'INBOX'), ['Both']);
      expect(await tablet.subjects(b, 'INBOX'), ['Both']);
      // …and replay at the same time, interleaved, when it is back.
      server
        ..latency = const Duration(milliseconds: 150)
        ..offline = false;
      await settle(const Duration(minutes: 2));
      await phone.repo.refresh();
      await tablet.repo.refresh();

      // The snooze, then both devices' wakes reached the server.
      expect(server.log.where((l) => l == 'move'), hasLength(3));
      expect(server.subjects('INBOX'), ['Both']);
      expect(server.subjects('Snoozed'), isEmpty);
      expect(keywordsOn(server, 'INBOX', 'Both'), {Keywords.newAgain});
      for (final (h, account) in [(phone, a), (tablet, b)]) {
        expect(await h.subjects(account, 'INBOX'), ['Both']);
        expect(await h.subjects(account, 'Snoozed'), isEmpty);
        expect(await h.store.pendingOps(), isEmpty);
        expect(h.errors, isEmpty);
      }
      await phone.dispose();
      await tablet.dispose();
    });
  });

  test('a server without keywords keeps the time on this device', () {
    fakeTime((async) async {
      final h = Harness(config: _quietConfig);
      final server = FakeServer()
        ..storesKeywords = false
        ..deliver('INBOX', subject: 'Outlook', keywords: {Keywords.seen});
      final a = await h.add(server);
      expect(await h.repo.snooze([(await h.email(a, 'INBOX', 'Outlook')).id], evening), SnoozeStorage.device);
      await settle();
      expect(server.subjects('Snoozed'), ['Outlook']);
      expect(keywordsOn(server, 'Snoozed', 'Outlook'), {Keywords.seen}, reason: 'no keyword sent');
      expect(server.log, isNot(contains('setKeywords')));

      // Syncs, even one reporting new flags, keep the local time.
      server.setFlags('Snoozed', server.find('Snoozed', 'Outlook')!.uid, {Keywords.seen, Keywords.flagged});
      await h.repo.refresh();
      final waiting = (await h.repo.watchSnoozed().first).single;
      expect(waiting.snoozedUntil, evening.toUtc());
      expect(waiting.isFlagged, isTrue);

      await Future<void>.delayed(const Duration(hours: 6));
      await h.repo.refresh();
      await settle();
      expect(server.subjects('INBOX'), ['Outlook']);
      expect(keywordsOn(server, 'INBOX', 'Outlook'), {Keywords.flagged}, reason: 'unread again');
      expect(await h.store.pendingOps(), isEmpty, reason: 'the device-only snooze is gone');
      expect((await h.email(a, 'INBOX', 'Outlook')).snoozedUntil, isNull);
      await h.dispose();
    }, limit: _hours12);
  });

  test('a device-only snooze is forgotten when the message leaves Snoozed', () {
    fakeTime((async) async {
      final h = Harness(config: _quietConfig);
      final server = FakeServer()
        ..storesKeywords = false
        ..deliver('INBOX', subject: 'Outlook');
      final a = await h.add(server);
      await h.repo.snooze([(await h.email(a, 'INBOX', 'Outlook')).id], evening);
      await settle();
      expect((await h.store.pendingOps()).map((o) => o.type), ['localSnooze']);
      await h.repo.move([(await h.email(a, 'Snoozed', 'Outlook')).id], h.mailbox(a, 'Work'));
      await settle();
      await h.repo.refresh();
      expect(await h.store.pendingOps(), isEmpty);
      expect((await h.email(a, 'Work', 'Outlook')).snoozedUntil, isNull);
      await h.dispose();
    });
  });

  test('a background sync wakes due messages and reaches the server', () {
    fakeTime((async) async {
      final h = Harness(config: _quietConfig);
      final server = FakeServer()..deliver('INBOX', subject: 'Later');
      final a = await h.add(server);
      await h.repo.snooze([(await h.email(a, 'INBOX', 'Later')).id], evening);
      await settle();
      await h.repo.pause();
      await Future<void>.delayed(const Duration(hours: 7));
      expect(server.subjects('Snoozed'), ['Later']);
      await h.repo.syncOnce();
      expect(server.subjects('INBOX'), ['Later']);
      expect(keywordsOn(server, 'INBOX', 'Later'), {Keywords.newAgain});
      await h.dispose();
    }, limit: _hours12);
  });

  test('snoozed messages stay out of Unread until they wake', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'Unread one');
      final a = await h.add(server);
      Future<int> unread() async => (await h.repo.watchVirtualCounts().first)[VirtualMailbox.unread]!;
      expect(await unread(), 1);
      await h.repo.snooze([(await h.email(a, 'INBOX', 'Unread one')).id], evening);
      await settle();
      expect(await unread(), 0);
      expect(await h.repo.watchList(const VirtualMailboxRef(VirtualMailbox.unread)).first, isEmpty);
      await h.dispose();
    });
  });
}
