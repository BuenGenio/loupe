import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/mail_sync.dart';
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
      // Someone answered the list: a discussion.
      final list = (await h.repo.watchSubscriptions().first).single;
      expect(list.listId, dev);
      expect(list.kind, SubscriptionKind.discussion);
      expect(list.postAddress?.email, 'dev@lists.example.org');
      final threads = await h.repo.watchListThreads(dev).first;
      expect(threads.single.patchBadge, 'PATCH 1/2');
      await h.dispose();
    });
  });

  test('Treat as Newsletter: kept on the device, undone with null', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()
        ..deliver('INBOX', subject: 'Bikeshed', messageId: 'root@x', listId: dev)
        ..deliver('INBOX', subject: 'Re: Bikeshed', inReplyTo: 'root@x', references: ['root@x'], listId: dev);
      await h.add(server);
      Future<SubscriptionKind> kind() async => (await h.repo.watchSubscriptions().first).single.kind;
      expect(await kind(), SubscriptionKind.discussion);
      await h.repo.setListKind([dev], SubscriptionKind.newsletter);
      expect(await kind(), SubscriptionKind.newsletter);
      await h.repo.setListKind([dev], null);
      expect(await kind(), SubscriptionKind.discussion);
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
      expect(await h.repo.watchSubscriptions().first, isEmpty);

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
      final list = (await h.repo.watchSubscriptions().first).single;
      expect(list.listIds, [dev]);
      expect(list.messageCount, 1);
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

  test('the header refetch goes on where it stopped, newest first', () {
    fakeTime((async) async {
      const config = SyncConfig(pollInterval: Duration(hours: 1), initialWindow: 500);
      final h = Harness(config: config);
      final server = FakeServer()..listHeadersInSync = false;
      for (var i = 0; i < 450; i++) {
        server.deliver('INBOX', subject: 'Post $i', listId: dev);
      }
      final account = await h.add(server);
      final inbox = h.mailbox(account, 'INBOX');
      final newestFirst = await h.store.emailIdsIn(inbox);
      expect(newestFirst, hasLength(450));
      await h.store.markHeadersStale(inbox);
      server.listHeadersInSync = true;

      // The first batch of 200 arrives; then the connection drops (or the
      // app is killed).
      var calls = 0;
      server.onFetchSummaries = (_) {
        if (++calls == 2) throw const MailException(MailErrorKind.connection, 'Connection lost');
      };
      await h.repo.refresh(ref: RealMailboxRef(inbox));
      await settle();
      expect(server.summaryRequests, [newestFirst.take(200).toList()]);
      expect((await h.store.getSyncInfo(inbox))!.staleHeaders, isTrue);
      await h.repo.dispose();

      // The app starts again: the refetch goes on after the first batch.
      server.summaryRequests.clear();
      final again = LiveMailRepository(h.store, h.factory, h.credentials, config: config);
      await again.start();
      await settle();
      expect(server.summaryRequests.map((r) => r.length), [200, 50]);
      expect(server.summaryRequests.expand((r) => r), newestFirst.skip(200));
      expect((await h.store.getSyncInfo(inbox))!.staleHeaders, isFalse);
      expect((await h.store.getEmails(newestFirst)).every((e) => e.listId == dev), isTrue);
      expect((await again.watchSubscriptions().first).single.messageCount, 450);
      await again.dispose();
      await h.store.close();
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
