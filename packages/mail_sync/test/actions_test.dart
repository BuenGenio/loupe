import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

void main() {
  test('setKeywords is optimistic, then reaches the server', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'A');
      final a = await h.add(server);
      final e = await h.email(a, 'INBOX', 'A');
      server.latency = const Duration(seconds: 1);
      await h.repo.setKeywords([e.id], add: {Keywords.seen, r'$Label1'});
      expect((await h.repo.getEmail(e.id))!.keywords, {Keywords.seen, r'$label1'});
      expect(server.box('INBOX').messages[1]!.keywords, isEmpty, reason: 'not replayed yet');
      await settle();
      expect(server.box('INBOX').messages[1]!.keywords, {Keywords.seen, r'$label1'});
      expect(await h.store.pendingOps(), isEmpty);
      // A no-op change queues nothing.
      await h.repo.setKeywords([e.id], add: {Keywords.seen});
      expect(await h.store.pendingOps(), isEmpty);
      await h.dispose();
    });
  });

  test('operations made offline replay in order after reconnecting', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()
        ..deliver('INBOX', subject: 'Keep')
        ..deliver('INBOX', subject: 'File')
        ..deliver('INBOX', subject: 'Bin');
      final a = await h.add(server);
      server.offline = true;
      await server.dropConnections();

      final file = await h.email(a, 'INBOX', 'File');
      await h.repo.setKeywords([(await h.email(a, 'INBOX', 'Keep')).id], add: {Keywords.flagged});
      await h.repo.move([file.id], h.mailbox(a, 'Work'));
      // Flagging the moved message by its old id must follow the move.
      await h.repo.setKeywords([file.id], add: {Keywords.seen});
      await h.repo.trash([(await h.email(a, 'INBOX', 'Bin')).id]);

      expect(await h.subjects(a, 'INBOX'), ['Keep']);
      expect(await h.subjects(a, 'Work'), ['File']);
      expect(await h.subjects(a, 'Trash'), ['Bin']);
      await settle(const Duration(seconds: 10));
      expect((await h.store.pendingOps()).map((o) => o.type), ['setKeywords', 'move', 'setKeywords', 'move']);
      expect((await h.status(a)).phase, SyncPhase.offline);

      server.offline = false;
      await settle(const Duration(minutes: 1));
      expect(await h.store.pendingOps(), isEmpty);
      expect(server.subjects('INBOX'), ['Keep']);
      expect(server.find('INBOX', 'Keep')!.keywords, {Keywords.flagged});
      expect(server.subjects('Work'), ['File']);
      expect(server.find('Work', 'File')!.keywords, {Keywords.seen});
      expect(server.subjects('Trash'), ['Bin']);
      // Local ids now point at the server's new copies.
      final moved = (await h.repo.getEmail(file.id))!;
      expect(moved.mailboxId, h.mailbox(a, 'Work'));
      expect(MailIds.parseImapEmail(moved.id)!.path, 'Work');
      expect(await h.subjects(a, 'Work'), ['File']);
      expect((await h.status(a)).phase, SyncPhase.idle);
      await h.dispose();
    });
  });

  test('a permanently failing operation is reverted and reported', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'Stuck');
      final a = await h.add(server);
      server.failAlways['move'] = const MailException(MailErrorKind.server, 'Mailbox is read-only');
      await h.repo.move([(await h.email(a, 'INBOX', 'Stuck')).id], h.mailbox(a, 'Work'));
      expect(await h.subjects(a, 'Work'), ['Stuck']);
      await settle(const Duration(minutes: 2));
      expect(await h.subjects(a, 'INBOX'), ['Stuck']);
      expect(await h.subjects(a, 'Work'), isEmpty);
      expect(await h.store.pendingOps(), isEmpty);
      expect(h.errors.single.message, 'Couldn’t move a message: Mailbox is read-only');
      await h.dispose();
    });
  });

  test('pending keyword changes survive a sync that arrives first', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'A');
      final a = await h.add(server);
      final e = await h.email(a, 'INBOX', 'A');
      server.failOnce['setKeywords'] = const MailException(MailErrorKind.server, 'Try again');
      await h.repo.setKeywords([e.id], add: {Keywords.seen});
      await settle();
      expect(await h.store.pendingOps(), hasLength(1), reason: 'waiting for a retry');
      // Another client flags it; the sync must keep our pending $seen.
      server.setFlags('INBOX', 1, {Keywords.flagged});
      await h.repo.refresh(ref: RealMailboxRef(h.mailbox(a, 'INBOX')));
      expect((await h.repo.getEmail(e.id))!.keywords, {Keywords.seen, Keywords.flagged});
      await settle(const Duration(seconds: 15));
      expect(server.box('INBOX').messages[1]!.keywords, {Keywords.seen, Keywords.flagged});
      await h.dispose();
    });
  });

  test('archive moves to the Archive folder, or explains there is none', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'Done');
      final a = await h.add(server);
      await h.repo.archive([(await h.email(a, 'INBOX', 'Done')).id]);
      expect(await h.subjects(a, 'Archive'), ['Done']);
      await settle();
      expect(server.subjects('Archive'), ['Done']);

      final noArchive = FakeServer()..deliver('INBOX', subject: 'X');
      noArchive.mailboxes.remove('Archive');
      final b = await h.add(noArchive, email: 'b@example.com');
      await expectLater(
        h.repo.archive([(await h.email(b, 'INBOX', 'X')).id]),
        throwsA(isA<MailException>().having((e) => e.message, 'message', 'Work has no Archive folder.')),
      );
      await h.dispose();
    });
  });

  test('Gmail archive removes the Inbox label without duplicating All Mail', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer(gmail: true)..deliver('INBOX', subject: 'G1');
      final a = await h.add(server, email: 'me@gmail.com', provider: ProviderKind.gmail);
      expect(await h.subjects(a, '[Gmail]/All Mail'), ['G1']);
      await h.repo.archive([(await h.email(a, 'INBOX', 'G1')).id]);
      expect(await h.subjects(a, 'INBOX'), isEmpty);
      await settle();
      await h.repo.refresh();
      expect(server.subjects('INBOX'), isEmpty);
      expect(server.subjects('[Gmail]/All Mail'), ['G1']);
      expect(await h.subjects(a, '[Gmail]/All Mail'), ['G1']);
      expect(await h.repo.watchList(const VirtualMailboxRef(VirtualMailbox.allInboxes)).first, isEmpty);
      await h.dispose();
    });
  });

  test('trash moves to Trash, and deletes permanently from Trash', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'Gone');
      final a = await h.add(server);
      await h.repo.trash([(await h.email(a, 'INBOX', 'Gone')).id]);
      await settle();
      expect(server.subjects('Trash'), ['Gone']);
      final inTrash = await h.email(a, 'Trash', 'Gone');
      await h.repo.trash([inTrash.id]);
      expect(await h.subjects(a, 'Trash'), isEmpty);
      await settle();
      expect(server.subjects('Trash'), isEmpty);
      expect(server.log, contains('delete'));
      await h.dispose();
    });
  });

  test('markJunk moves to Junk with \$junk, and back to the Inbox with \$notjunk', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'Spammy');
      final a = await h.add(server);
      await h.repo.markJunk([(await h.email(a, 'INBOX', 'Spammy')).id], junk: true);
      await settle();
      expect(server.find('Junk', 'Spammy')!.keywords, {Keywords.junk});
      await h.repo.markJunk([(await h.email(a, 'Junk', 'Spammy')).id], junk: false);
      await settle();
      expect(server.find('INBOX', 'Spammy')!.keywords, {Keywords.notJunk});
      expect(await h.subjects(a, 'INBOX'), ['Spammy']);
      expect(await h.subjects(a, 'Junk'), isEmpty);
      await h.dispose();
    });
  });

  test('moving across accounts is refused; VIPs round-trip', () {
    fakeTime((async) async {
      final h = Harness();
      final a = await h.add(FakeServer()..deliver('INBOX', subject: 'A'));
      final b = await h.add(FakeServer(), email: 'b@example.com');
      await expectLater(
        h.repo.move([(await h.email(a, 'INBOX', 'A')).id], h.mailbox(b, 'INBOX')),
        throwsA(isA<MailException>()),
      );
      await h.repo.setVip('Boss@Example.com', vip: true);
      expect(await h.repo.watchVipAddresses().first, {'boss@example.com'});
      await h.dispose();
    });
  });
}
