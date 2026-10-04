import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

void main() {
  Future<bool> subscribed(Harness h, MailAccount a, String path) async =>
      (await h.repo.watchMailboxes(accountId: a.id).first).firstWhere((m) => m.path == path).isSubscribed;

  test('the mailbox list carries the server’s subscriptions', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..addMailbox('Lists');
      server.box('Lists').subscribed = false;
      final a = await h.add(server);
      expect(await subscribed(h, a, 'Lists'), isFalse);
      expect(await subscribed(h, a, 'Work'), isTrue);
      await h.dispose();
    });
  });

  test('setMailboxSubscribed is optimistic, then reaches the server', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer();
      final a = await h.add(server);
      server.latency = const Duration(seconds: 1);
      await h.repo.setMailboxSubscribed(h.mailbox(a, 'Work'), subscribed: false);
      expect(await subscribed(h, a, 'Work'), isFalse);
      expect(server.box('Work').subscribed, isTrue, reason: 'not replayed yet');
      await settle();
      expect(server.box('Work').subscribed, isFalse);
      expect(server.log, contains('unsubscribe:Work'));
      expect(await h.store.pendingOps(), isEmpty);
      // No change, nothing queued.
      await h.repo.setMailboxSubscribed(h.mailbox(a, 'Work'), subscribed: false);
      expect(await h.store.pendingOps(), isEmpty);
      await expectLater(
        h.repo.setMailboxSubscribed(h.mailbox(a, 'Nope'), subscribed: true),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.notFound)),
      );
      await h.dispose();
    });
  });

  test('a change made offline survives the next mailbox list and replays', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..addMailbox('Lists');
      server.box('Lists').subscribed = false;
      final a = await h.add(server);
      server.offline = true;
      await server.dropConnections();
      await h.repo.setMailboxSubscribed(h.mailbox(a, 'Lists'), subscribed: true);
      await settle(const Duration(seconds: 10));
      expect((await h.store.pendingOps()).map((o) => o.type), ['subscribe']);

      // Back online, the list (still unsubscribed) arrives before the replay.
      server.offline = false;
      await h.repo.refresh();
      expect(await subscribed(h, a, 'Lists'), isTrue);
      await settle(const Duration(minutes: 1));
      expect(server.box('Lists').subscribed, isTrue);
      expect(await h.store.pendingOps(), isEmpty);
      expect(await subscribed(h, a, 'Lists'), isTrue);
      await h.dispose();
    });
  });

  test('a refused change is reverted and reported', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer();
      final a = await h.add(server);
      server.failAlways['unsubscribe:Work'] = const MailException(MailErrorKind.server, 'Permission denied');
      await h.repo.setMailboxSubscribed(h.mailbox(a, 'Work'), subscribed: false);
      expect(await subscribed(h, a, 'Work'), isFalse);
      await settle(const Duration(minutes: 2));
      expect(await subscribed(h, a, 'Work'), isTrue);
      expect(await h.store.pendingOps(), isEmpty);
      expect(h.errors.single.message, 'Couldn’t unsubscribe from “Work”: Permission denied');
      await h.dispose();
    });
  });

  test('background syncs skip unsubscribed folders but never the special ones', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()
        ..addMailbox('Lists')
        ..addMailbox('Old')
        ..deliver('Work', subject: 'Opened once')
        ..deliver('Lists', subject: 'List mail')
        ..deliver('Old', subject: 'Old mail');
      server.box('Old').subscribed = false;
      server.box('Archive').subscribed = false;
      final a = await h.add(server);
      // Periodic syncs fill in subscribed folders and roles only.
      await settle(fastConfig.pollInterval * 3);
      expect(await h.subjects(a, 'Lists'), ['List mail']);
      expect(server.log, contains('sync:Archive'));
      expect(server.log, isNot(contains('sync:Old')));
      expect(await h.subjects(a, 'Old'), isEmpty);

      // Opening an unsubscribed folder syncs it on demand.
      h.repo.watchList(RealMailboxRef(h.mailbox(a, 'Old'))).listen((_) {}).onDone(() {});
      await settle();
      expect(await h.subjects(a, 'Old'), ['Old mail']);

      // A folder synced before stops syncing once unsubscribed.
      await h.repo.setMailboxSubscribed(h.mailbox(a, 'Work'), subscribed: false);
      await settle();
      server.log.clear();
      await h.repo.refresh();
      expect(server.log, contains('sync:INBOX'));
      expect(server.log, contains('sync:Lists'));
      expect(server.log, isNot(contains('sync:Work')));
      await h.dispose();
    });
  });
}
