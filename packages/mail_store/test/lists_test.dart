import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

const dev = 'dev.lists.example.org';
const users = 'users.lists.example.org';
const devPost = '<mailto:dev@lists.example.org>';

/// A message of the dev list (or [list]); [thread] names its conversation root.
EmailSummary listMail(
  int uid, {
  required String subject,
  String list = dev,
  String? name = 'Example developers',
  String path = 'INBOX',
  String from = 'alice@example.org',
  String? fromName = 'Alice',
  int minutes = 0,
  String? thread,
  bool seen = false,
}) => mail(
  uid,
  path: path,
  subject: subject,
  from: from,
  fromName: fromName,
  minutes: minutes,
  messageId: 'm$uid@example.org',
  inReplyTo: thread == null ? null : '$thread@example.org',
  references: thread == null ? const [] : ['$thread@example.org'],
  keywords: seen ? {Keywords.seen} : const {},
  listId: list,
  listName: name,
  listPost: list == dev ? devPost : null,
  listUnsubscribe: '<https://lists.example.org/u>',
);

void main() {
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  test('list headers round-trip through the store', () async {
    final store = await seededStore();
    await addMails(store, [
      listMail(1, subject: 'Hi'),
      mail(2, listUnsubscribe: '<mailto:leave@news.example>', listUnsubscribePost: 'List-Unsubscribe=One-Click'),
    ]);
    final a = (await store.getEmail(eid('INBOX', 1)))!;
    expect(
      [a.listId, a.listName, a.listPost, a.listUnsubscribe],
      [dev, 'Example developers', devPost, '<https://lists.example.org/u>'],
    );
    final b = (await store.getEmail(eid('INBOX', 2)))!;
    expect(b.listId, isNull);
    expect(b.listUnsubscribePost, 'List-Unsubscribe=One-Click');
    expect((await store.watchConversation(a.id).first).single.listId, dev);
  });

  group('mailing lists', () {
    late MailStore store;
    setUp(() async {
      store = await seededStore();
      await addMails(store, [
        // A patch series: cover letter, three patches, two reviews.
        listMail(1, subject: '[PATCH v2 0/3] Speed up the frobnicator', minutes: 0, seen: true),
        listMail(2, subject: '[PATCH v2 1/3] frob: cache lookups', minutes: 1, thread: 'm1', seen: true),
        listMail(3, subject: '[PATCH v2 2/3] frob: drop the lock', minutes: 2, thread: 'm1'),
        listMail(4, subject: '[PATCH v2 3/3] frob: tests', minutes: 3, thread: 'm1'),
        listMail(
          5,
          subject: 'Re: [PATCH v2 2/3] frob: drop the lock',
          minutes: 30,
          thread: 'm1',
          from: 'bob@example.org',
          fromName: 'Bob',
        ),
        // The same review again, in Archive (one message, two copies).
        listMail(
          5,
          path: 'Archive',
          subject: 'Re: [PATCH v2 2/3] frob: drop the lock',
          minutes: 30,
          thread: 'm1',
          from: 'bob@example.org',
          fromName: 'Bob',
        ),
        // A discussion on the same list, newer.
        listMail(6, subject: 'Release planning', minutes: 60, from: 'carol@example.org', fromName: 'Carol', name: null),
        listMail(7, subject: 'Re: Release planning', minutes: 70, thread: 'm6', seen: true),
        // Another list; a deleted message of it doesn't count.
        listMail(8, list: users, name: 'Example users', subject: 'How do I frob?', minutes: 5),
        listMail(9, path: 'Trash', list: users, name: 'Old name', subject: 'Deleted', minutes: 500),
        // Not list mail.
        mail(10, subject: 'Lunch?', minutes: 80),
      ]);
    });

    test('grouped by List-Id, newest activity first, copies and Trash left out', () async {
      final lists = await store.watchMailingLists().first;
      expect(lists.map((l) => l.id), [dev, users]);
      final d = lists.first;
      expect(d.name, 'Example developers'); // the newest message has no phrase
      expect(d.postAddress?.email, 'dev@lists.example.org');
      expect(d.messageCount, 7);
      expect(d.unreadCount, 4);
      expect(d.accountIds, [accountId]);
      expect(d.lastActivity, base.add(const Duration(minutes: 70)));
      expect(lists.last.name, 'Example users');
      expect(lists.last.messageCount, 1);
      expect(lists.last.postAddress, isNull);
    });

    test('forum threads: first and latest message, participants, replies, patches', () async {
      final threads = await store.watchListThreads('Dev.Lists.Example.org').first;
      expect(threads.map((t) => t.first.subject), ['Release planning', '[PATCH v2 0/3] Speed up the frobnicator']);
      final series = threads.last;
      expect(series.messageCount, 5);
      expect(series.replyCount, 4);
      expect(series.unreadCount, 3);
      expect(series.latest.subject, 'Re: [PATCH v2 2/3] frob: drop the lock');
      expect(series.participants.map((p) => p.displayName), ['Alice', 'Bob']);
      expect(series.patchCount, 3);
      expect(series.patchBadge, 'PATCH v2 3/3');
      expect(series.isMuted, isFalse);
      final talk = threads.first;
      expect(talk.patchBadge, isNull);
      expect(talk.participants.map((p) => p.displayName), ['Carol', 'Alice']);
      expect(await store.watchListThreads(dev, limit: 1).first, hasLength(1));
      expect(await store.watchListThreads('nope.example').first, isEmpty);
    });

    test('muted threads leave the list view and its unread count, and stay muted', () async {
      final series = (await store.watchListThreads(dev).first).last;
      final muted = store.watchMutedThreads().skip(1).first;
      // Every copy: the review also sits in Archive.
      expect(await store.unreadInThread(accountId, series.threadId), hasLength(4));
      await store.setThreadMuted(accountId, series.threadId, muted: true);
      await store.setThreadMuted(accountId, series.threadId, muted: true); // twice is fine
      expect(await muted, {series.threadId});
      expect((await store.watchListThreads(dev).first).map((t) => t.first.subject), ['Release planning']);
      final all = await store.watchListThreads(dev, includeMuted: true).first;
      expect(all.last.isMuted, isTrue);
      expect((await store.watchMailingLists().first).first.unreadCount, 1);
      expect(await store.threadOf(eid('INBOX', 4)), (accountId: accountId, threadId: series.threadId));

      // New mail of the thread is recognised as muted.
      await addMails(store, [listMail(11, subject: 'Re: [PATCH v2 0/3] Speed', minutes: 90, thread: 'm1')]);
      expect(await store.unreadInMutedThreads([eid('INBOX', 11), eid('INBOX', 6), eid('INBOX', 10)]), [
        eid('INBOX', 11),
      ]);

      await store.setThreadMuted(accountId, series.threadId, muted: false);
      expect(await store.watchMutedThreads().first, isEmpty);
      expect(await store.watchListThreads(dev).first, hasLength(2));
    });

    test('a muted thread stays muted when threading merges it into another', () async {
      // Two roots that a later message joins.
      await addMails(store, [
        listMail(20, subject: 'Part one', minutes: 100),
        listMail(21, subject: 'Part two', minutes: 101),
      ]);
      final before = await store.threadOf(eid('INBOX', 21));
      await store.setThreadMuted(accountId, before!.threadId, muted: true);
      await addMails(store, [
        mail(
          22,
          subject: 'Re: both',
          minutes: 102,
          messageId: 'm22@example.org',
          references: const ['m20@example.org', 'm21@example.org'],
          listId: dev,
        ),
      ]);
      final after = await store.threadOf(eid('INBOX', 21));
      expect(await store.threadOf(eid('INBOX', 20)), after);
      expect(await store.watchMutedThreads().first, {after!.threadId});
    });
  });

  group('header backfill', () {
    test('fillHeaders and later syncs fill missing list fields only', () async {
      final store = await seededStore();
      await addMails(store, [
        mail(1, subject: 'Old', keywords: {Keywords.seen}),
      ]);
      await store.updateKeywords([eid('INBOX', 1)], add: {Keywords.flagged});
      final fetched = listMail(1, subject: 'Old');
      final lists = store.watchMailingLists().skip(1).first;
      await store.fillHeaders([fetched, listMail(99, subject: 'unknown id')]);
      expect((await lists).single.id, dev);
      final e = (await store.getEmail(eid('INBOX', 1)))!;
      expect(e.listId, dev);
      expect(e.listPost, devPost);
      // Keywords stay as the store has them.
      expect(e.keywords, {Keywords.seen, Keywords.flagged});

      // Filled values are kept; a summary synced again fills what's missing.
      await store.fillHeaders([listMail(1, subject: 'Old', list: users)]);
      expect((await store.getEmail(eid('INBOX', 1)))!.listId, dev);
      await addMails(store, [mail(2, subject: 'Plain')]);
      await addMails(store, [mail(2, subject: 'Plain', listUnsubscribe: '<https://news.example/u>')]);
      expect((await store.getEmail(eid('INBOX', 2)))!.listUnsubscribe, '<https://news.example/u>');
    });

    test('mailboxes synced after the upgrade start with fresh headers', () async {
      final store = await seededStore();
      await store.applySync(mbox('INBOX'), added([mail(1)]));
      expect((await store.getSyncInfo(mbox('INBOX')))!.staleHeaders, isFalse);
    });
  });

  group('migration', () {
    late Directory dir;
    setUp(() => dir = Directory.systemTemp.createTempSync('mail_store_migration'));
    tearDown(() => dir.deleteSync(recursive: true));

    void create(String path, int version) => createOldDatabase(path, version);

    for (final version in [1, 2]) {
      test('version $version upgrades past 3: list columns, index, muted threads, stale headers', () async {
        final path = '${dir.path}/mail.db';
        create(path, version);
        final store = await MailStore.open(path, encryptionKey: 'k', inBackground: false);
        final old = (await store.getEmail(eid('INBOX', 1)))!;
        expect(old.subject, 'Before the upgrade');
        expect(old.listId, isNull);
        expect((await store.getSyncInfo(mbox('INBOX')))!.staleHeaders, isTrue);

        // The full-text index and its triggers still work.
        final hits = await store.search(const TextTerm(SearchField.body, 'kumquat'));
        expect(hits.map((e) => e.id), [eid('INBOX', 1)]);

        // New list mail, mutes and the backfill work on the upgraded file.
        await store.applySync(mbox('INBOX'), added([listMail(2, subject: '[PATCH] new')]));
        expect((await store.getSyncInfo(mbox('INBOX')))!.staleHeaders, isTrue, reason: 'a sync keeps the flag');
        await store.fillHeaders([listMail(1, subject: 'Before the upgrade')]);
        await store.markHeadersFresh(mbox('INBOX'));
        expect((await store.getSyncInfo(mbox('INBOX')))!.staleHeaders, isFalse);
        expect((await store.watchMailingLists().first).single.messageCount, 2);
        final thread = (await store.threadOf(eid('INBOX', 2)))!;
        await store.setThreadMuted(thread.accountId, thread.threadId, muted: true);
        expect(await store.watchMutedThreads().first, {thread.threadId});
        await store.close();

        final db = sqlite3.open(path)..execute("PRAGMA key = 'k'");
        addTearDown(db.close);
        expect(db.select('PRAGMA user_version').single.values.single, latestSchemaVersion);
        final columns = {for (final r in db.select('PRAGMA table_info(emails)')) r['name'] as String};
        expect(
          columns,
          containsAll(['list_id', 'list_name', 'list_post', 'list_unsubscribe', 'list_unsubscribe_post']),
        );
        final plan = db.select("EXPLAIN QUERY PLAN SELECT id FROM emails WHERE list_id = 'x'").map((r) => r['detail']);
        expect(plan.join(' '), contains('emails_list'));
        expect(db.select('SELECT count(*) AS n FROM rules').single['n'], version >= 2 ? 1 : 0);
      });
    }

    for (final version in [1, 2, 3]) {
      test('version $version upgrades to 4: the partial indexes of unread and flagged mail', () async {
        final path = '${dir.path}/mail.db';
        create(path, version);
        final store = await MailStore.open(path, encryptionKey: 'k', inBackground: false);
        await store.applySync(
          mbox('INBOX'),
          added([
            mail(2, keywords: {Keywords.flagged}),
            mail(3),
          ]),
        );
        final counts = await store.watchVirtualCounts().first;
        // The old message's row has is_seen 0 (the fixture sets keywords only).
        expect(counts[VirtualMailbox.unread], 3);
        expect(counts[VirtualMailbox.flagged], 1);
        expect((await store.getEmail(eid('INBOX', 1)))!.subject, 'Before the upgrade');
        await store.close();

        final db = sqlite3.open(path)..execute("PRAGMA key = 'k'");
        addTearDown(db.close);
        expect(db.select('PRAGMA user_version').single.values.single, latestSchemaVersion);
        final indexes = {for (final r in db.select("SELECT name FROM sqlite_master WHERE type = 'index'")) r['name']};
        expect(indexes, containsAll(['emails_unread', 'emails_flagged', 'emails_list', 'emails_thread']));
        final plan = db
            .select('EXPLAIN QUERY PLAN SELECT mailbox_id, count(*) FROM emails WHERE is_seen = 0 GROUP BY mailbox_id')
            .map((r) => r['detail']);
        expect(plan.join(' '), contains('emails_unread'));
      });
    }
  });
}
