import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

const dev = 'dev.lists.example.org';

void main() {
  test('mailing lists and their threads come from the store', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()
        ..deliver('INBOX', subject: '[PATCH 0/2] cover', messageId: 'c@x', listId: dev)
        ..deliver('INBOX', subject: '[PATCH 1/2] one', inReplyTo: 'c@x', references: ['c@x'], listId: dev)
        ..deliver('INBOX', subject: 'Not a list');
      await h.add(server);
      final lists = await h.repo.watchMailingLists().first;
      expect(lists.single.id, dev);
      expect(lists.single.postAddress?.email, 'dev@lists.example.org');
      final threads = await h.repo.watchListThreads(dev).first;
      expect(threads.single.patchBadge, 'PATCH 1/2');
      await h.dispose();
    });
  });

  test('muting marks the thread read; its new mail arrives read, here and on the server', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()
        ..deliver('INBOX', subject: 'Bikeshed', messageId: 'root@x', listId: dev)
        ..deliver('INBOX', subject: 'Re: Bikeshed', inReplyTo: 'root@x', references: ['root@x'], listId: dev)
        ..deliver('INBOX', subject: 'Other topic', listId: dev);
      final account = await h.add(server);
      final reply = await h.email(account, 'INBOX', 'Re: Bikeshed');
      expect(reply.isSeen, isFalse);

      await h.repo.setThreadMuted(reply.id, muted: true);
      await settle();
      expect(await h.repo.watchMutedThreads().first, {reply.threadId});
      expect((await h.email(account, 'INBOX', 'Bikeshed')).isSeen, isTrue);
      expect(server.box('INBOX').messages.values.where((m) => m.subject.contains('Bikeshed')).map((m) => m.keywords), [
        contains(Keywords.seen),
        contains(Keywords.seen),
      ]);
      expect((await h.repo.watchListThreads(dev).first).map((t) => t.first.subject), ['Other topic']);

      // A later reply of the muted thread, and one of another thread.
      final late = server.deliver(
        'INBOX',
        subject: 'Re: Re: Bikeshed',
        inReplyTo: 'root@x',
        references: ['root@x'],
        listId: dev,
      );
      server.deliver('INBOX', subject: 'Re: Other topic', listId: dev);
      await h.repo.refresh(ref: RealMailboxRef(h.mailbox(account, 'INBOX')));
      await settle();
      expect((await h.email(account, 'INBOX', 'Re: Re: Bikeshed')).isSeen, isTrue);
      expect((await h.email(account, 'INBOX', 'Re: Other topic')).isSeen, isFalse);
      expect(late.keywords, contains(Keywords.seen), reason: 'pushed to the server');

      await h.repo.setThreadMuted(reply.id, muted: false);
      expect(await h.repo.watchMutedThreads().first, isEmpty);
      expect((await h.email(account, 'INBOX', 'Bikeshed')).isSeen, isTrue, reason: 'unmuting changes no flags');
      await expectLater(
        h.repo.setThreadMuted('acc|INBOX|1|999', muted: true),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.notFound)),
      );
      await h.dispose();
    });
  });

  test('summaries stored before the List-* headers are fetched again once', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()
        ..listHeadersInSync = false
        ..deliver('INBOX', subject: 'Old list mail', listId: dev)
        ..deliver('INBOX', subject: 'Personal');
      final account = await h.add(server);
      final inbox = h.mailbox(account, 'INBOX');
      expect((await h.email(account, 'INBOX', 'Old list mail')).listId, isNull);
      expect(await h.repo.watchMailingLists().first, isEmpty);

      // What the store migration does for every synced mailbox.
      await h.store.markHeadersStale(inbox);
      server.listHeadersInSync = true;

      // A failed refetch leaves the mailbox marked for the next sync.
      server.failOnce['fetchSummaries'] = const MailException(MailErrorKind.server, 'NO try later');
      await h.repo.refresh(ref: RealMailboxRef(inbox));
      await settle();
      expect((await h.store.getSyncInfo(inbox))!.staleHeaders, isTrue);
      expect((await h.email(account, 'INBOX', 'Old list mail')).listId, isNull);

      server.log.clear();
      await h.repo.refresh(ref: RealMailboxRef(inbox));
      await settle();
      expect((await h.email(account, 'INBOX', 'Old list mail')).listId, dev);
      expect((await h.repo.watchMailingLists().first).single.messageCount, 1);
      expect((await h.store.getSyncInfo(inbox))!.staleHeaders, isFalse);
      expect(server.log.where((l) => l == 'fetchSummaries'), hasLength(1));
      expect(server.summaryPreviews, everyElement(isFalse), reason: 'header fields only');

      server.log.clear();
      await h.repo.refresh(ref: RealMailboxRef(inbox));
      await settle();
      expect(server.log, isNot(contains('fetchSummaries')));
      await h.dispose();
    });
  });

  test('the header refetch waits for a foreground sync', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()
        ..listHeadersInSync = false
        ..deliver('INBOX', subject: 'Old list mail', listId: dev);
      final account = await h.add(server);
      final inbox = h.mailbox(account, 'INBOX');
      await h.store.markHeadersStale(inbox);
      server.listHeadersInSync = true;

      // Background work (paused syncers) syncs new mail only.
      await h.repo.pause();
      await h.repo.syncOnce();
      await settle();
      expect(server.log, isNot(contains('fetchSummaries')));
      expect((await h.store.getSyncInfo(inbox))!.staleHeaders, isTrue);

      await h.repo.resume();
      await settle();
      expect((await h.email(account, 'INBOX', 'Old list mail')).listId, dev);
      expect((await h.store.getSyncInfo(inbox))!.staleHeaders, isFalse);
      await h.dispose();
    });
  });
}
