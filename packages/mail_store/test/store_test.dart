import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  group('encrypted open', () {
    late Directory dir;
    setUp(() => dir = Directory.systemTemp.createTempSync('mail_store_test'));
    tearDown(() => dir.deleteSync(recursive: true));

    test('round-trips with the right key and fails with a wrong one', () async {
      final path = '${dir.path}/mail.db';
      var store = await MailStore.open(path, encryptionKey: "s3cret'key", inBackground: false);
      await store.saveAccount(account());
      await store.close();

      final header = File(path).readAsBytesSync().take(16).toList();
      expect(String.fromCharCodes(header), isNot(startsWith('SQLite format 3')));

      store = await MailStore.open(path, encryptionKey: "s3cret'key");
      expect((await store.getAccounts()).single.email, 'me@example.com');
      await store.close();

      await expectLater(
        MailStore.open(path, encryptionKey: 'wrong', inBackground: false),
        throwsA(isA<MailStoreException>()),
      );
      await expectLater(MailStore.open(path, encryptionKey: 'wrong'), throwsA(isA<MailStoreException>()));
      await expectLater(MailStore.open(path, encryptionKey: ''), throwsA(isA<MailStoreException>()));
    });
  });

  test('schema: tables, FTS index and triggers', () async {
    final dir = Directory.systemTemp.createTempSync('mail_store_schema');
    addTearDown(() => dir.deleteSync(recursive: true));
    final path = '${dir.path}/mail.db';
    final store = await MailStore.open(path, encryptionKey: 'k', inBackground: false);
    await store.saveAccount(account());
    await store.close();
    final db = sqlite3.open(path)..execute("PRAGMA key = 'k'");
    addTearDown(db.close);
    final names = {for (final r in db.select('SELECT name FROM sqlite_master')) r['name'] as String};
    expect(
      names,
      containsAll([
        'accounts',
        'mailboxes',
        'sync_states',
        'emails',
        'email_keywords',
        'contents',
        'inline_parts',
        'outbox_items',
        'pending_ops',
        'vip_addresses',
        'address_book',
        'thread_refs',
        'id_aliases',
        'email_fts',
        'emails_after_insert',
        'emails_after_update_text',
        'emails_after_update_keywords',
        'emails_after_delete',
        'contents_after_insert',
        'contents_after_update',
        'contents_after_delete',
      ]),
    );
    expect(db.select('PRAGMA user_version').single.values.single, 1);
  });

  group('accounts and mailboxes', () {
    test('saves, watches and deletes accounts with their data', () async {
      final store = await seededStore(
        accounts: [
          account(),
          account(id: 'acc2', email: 'b@b.test', name: 'B'),
        ],
      );
      expect((await store.watchAccounts().first).map((a) => a.id), ['acc1', 'acc2']);
      await addMails(store, [mail(1), mail(2, account: 'acc2')]);
      await store.enqueueOp('acc2', 'x', {});
      await store.deleteAccount('acc2');
      expect((await store.getAccounts()).map((a) => a.id), ['acc1']);
      expect(await store.getMailboxes(accountId: 'acc2'), isEmpty);
      expect(await store.getEmail(eid('INBOX', 2, account: 'acc2')), isNull);
      expect(await store.pendingOps(), isEmpty);
      expect(await store.getEmail(eid('INBOX', 1)), isNotNull);
    });

    test('replaceMailboxes orders by role, keeps counts and drops removed mailboxes', () async {
      final store = await seededStore();
      final boxes = await store.watchMailboxes(accountId: accountId).first;
      expect(boxes.map((m) => m.name), ['Inbox', 'Drafts', 'Sent', 'Archive', 'Junk', 'Trash', 'Work']);
      await store.applySync(mbox('Work'), added([mail(1, path: 'Work')], total: 10, unread: 3));
      await store.replaceMailboxes(accountId, standardMailboxes.where((m) => m.path != 'Trash').toList());
      final after = await store.getMailboxes(accountId: accountId);
      expect(after.map((m) => m.path), isNot(contains('Trash')));
      expect(after.firstWhere((m) => m.path == 'Work').unreadCount, 3);
      expect((await store.mailboxByRole(accountId, MailboxRole.sent))!.path, 'Sent');
      expect(await store.mailboxByRole(accountId, MailboxRole.trash), isNull);
    });

    test('the subscription flag round-trips through the server list and the setter', () async {
      final store = await seededStore();
      await store.replaceMailboxes(accountId, [
        ...standardMailboxes,
        const RemoteMailbox(path: 'Lists', name: 'Lists', isSubscribed: false),
        const RemoteMailbox(path: 'Lists/Dev', name: 'Dev', parentPath: 'Lists'),
      ]);
      Future<Map<String, bool>> flags() async => {
        for (final m in await store.watchMailboxes(accountId: accountId).first) m.path: m.isSubscribed,
      };
      expect(await flags(), containsPair('Lists', false));
      expect(await flags(), containsPair('Lists/Dev', true));
      expect((await store.getMailbox(mbox('Work')))!.isSubscribed, isTrue);

      final watched = store.watchMailboxes(accountId: accountId).skip(1).first;
      expect(await store.setMailboxSubscribed(mbox('Work'), subscribed: false), isTrue);
      expect((await watched).firstWhere((m) => m.path == 'Work').isSubscribed, isFalse);
      // Unchanged and unknown mailboxes.
      expect(await store.setMailboxSubscribed(mbox('Work'), subscribed: false), isFalse);
      expect(await store.setMailboxSubscribed(mbox('Nope'), subscribed: true), isNull);

      // The server's list wins again on the next sync.
      await store.replaceMailboxes(accountId, standardMailboxes);
      expect((await store.getMailbox(mbox('Work')))!.isSubscribed, isTrue);
    });

    test('unsynced mailboxes: subscribed ones and role holders, not Trash or Junk', () async {
      final store = MailStore.memory();
      await store.saveAccount(account());
      await store.replaceMailboxes(accountId, [
        for (final m in standardMailboxes)
          RemoteMailbox(path: m.path, name: m.name, role: m.role, isSubscribed: m.role == MailboxRole.inbox),
        const RemoteMailbox(path: 'Lists', name: 'Lists'),
        const RemoteMailbox(path: 'Old', name: 'Old', isSubscribed: false),
        const RemoteMailbox(path: 'Box', name: 'Box', isSelectable: false),
      ]);
      await store.applySync(mbox('INBOX'), added([]));
      expect(await store.unsyncedMailboxIds(accountId), [mbox('Drafts'), mbox('Sent'), mbox('Archive'), mbox('Lists')]);
    });
  });

  group('applySync', () {
    test('adds, updates keywords, removes vanished and stores state and counts', () async {
      final store = await seededStore();
      final inbox = mbox('INBOX');
      await store.applySync(
        inbox,
        added([
          mail(1),
          mail(2, keywords: {Keywords.seen}),
        ], hasOlder: true),
      );
      var box = (await store.getMailbox(inbox))!;
      expect((box.totalCount, box.unreadCount), (2, 1));
      expect((await store.getSyncInfo(inbox))!.hasOlder, isTrue);

      await store.applySync(
        inbox,
        MailboxSyncResult(
          state: const MailboxSyncState({'v': 2}),
          keywordUpdates: {
            eid('INBOX', 1): {r'$Seen', Keywords.flagged},
          },
          vanishedIds: [eid('INBOX', 2)],
          totalCount: 40,
          unreadCount: 7,
        ),
      );
      final e1 = (await store.getEmail(eid('INBOX', 1)))!;
      expect(e1.keywords, {Keywords.seen, Keywords.flagged});
      expect(await store.getEmail(eid('INBOX', 2)), isNull);
      box = (await store.getMailbox(inbox))!;
      expect((box.totalCount, box.unreadCount), (40, 7));
      expect((await store.getSyncInfo(inbox))!.state.data, {'v': 2});
    });

    test('resetAll drops the mailbox before adding', () async {
      final store = await seededStore();
      final inbox = mbox('INBOX');
      await store.applySync(inbox, added([mail(1), mail(2)]));
      await store.putContent(EmailContent(emailId: eid('INBOX', 1), text: 'cached'));
      await store.applySync(
        inbox,
        MailboxSyncResult(state: const MailboxSyncState({}), resetAll: true, added: [mail(1, validity: 2)]),
      );
      final ids = await store.emailIdsIn(inbox);
      expect(ids, [eid('INBOX', 1, validity: 2)]);
      expect(await store.getContent(eid('INBOX', 1)), isNull);
    });

    test('re-adding a known message keeps its thread and content', () async {
      final store = await seededStore();
      await addMails(store, [mail(1, messageId: 'a@x')]);
      await store.putContent(EmailContent(emailId: eid('INBOX', 1), text: 'body'));
      final thread = (await store.getEmail(eid('INBOX', 1)))!.threadId;
      await addMails(store, [
        mail(1, messageId: 'a@x', keywords: {Keywords.seen}),
      ]);
      final e = (await store.getEmail(eid('INBOX', 1)))!;
      expect(e.threadId, thread);
      expect(e.isSeen, isTrue);
      expect((await store.getContent(e.id))!.text, 'body');
    });

    test('feeds the address book from senders and sent recipients', () async {
      final store = await seededStore();
      await addMails(store, [
        mail(1, from: 'alice@example.com', fromName: 'Alice Liddell'),
        mail(2, path: 'Sent', from: 'me@example.com', to: ['bob@example.org']),
        mail(3, path: 'Junk', from: 'spam@spam.test'),
      ]);
      expect((await store.suggestAddresses('ali')).single.email, 'alice@example.com');
      expect((await store.suggestAddresses('lid')).single.name, 'Alice Liddell');
      expect((await store.suggestAddresses('bob')).single.email, 'bob@example.org');
      expect(await store.suggestAddresses('spam'), isEmpty);
      expect(await store.suggestAddresses('%'), isEmpty);
    });
  });

  group('threading', () {
    Future<String?> thread(MailStore s, String id) async => (await s.getEmail(id))?.threadId;

    test('groups by References and In-Reply-To in any arrival order', () async {
      final store = await seededStore();
      await addMails(store, [
        mail(3, messageId: 'c@x', inReplyTo: 'b@x', references: ['a@x', 'b@x'], minutes: 3),
        mail(9, messageId: 'z@x', subject: 'Other', minutes: 4),
      ]);
      await addMails(store, [mail(1, messageId: 'a@x'), mail(2, messageId: '<b@x>', inReplyTo: '<a@x>', minutes: 2)]);
      final t = await thread(store, eid('INBOX', 1));
      expect(await thread(store, eid('INBOX', 2)), t);
      expect(await thread(store, eid('INBOX', 3)), t);
      expect(await thread(store, eid('INBOX', 9)), isNot(t));
    });

    test('merges two threads joined by a later message', () async {
      final store = await seededStore();
      await addMails(store, [mail(1, messageId: 'a@x'), mail(2, messageId: 'b@x', subject: 'Unrelated')]);
      expect(await thread(store, eid('INBOX', 1)), isNot(await thread(store, eid('INBOX', 2))));
      await addMails(store, [
        mail(3, messageId: 'c@x', references: ['a@x', 'b@x'], minutes: 5),
      ]);
      final t = await thread(store, eid('INBOX', 3));
      expect(await thread(store, eid('INBOX', 1)), t);
      expect(await thread(store, eid('INBOX', 2)), t);
    });

    test('falls back to the subject for replies within 30 days only', () async {
      final store = await seededStore();
      await addMails(store, [mail(1, messageId: 'a@x', subject: 'Quarterly plan')]);
      await addMails(store, [
        mail(2, messageId: 'b@x', subject: 'Re: [team] RE: Quarterly  Plan', minutes: 60),
        mail(3, messageId: 'c@x', subject: 'Quarterly plan', minutes: 90),
        mail(4, messageId: 'd@x', subject: 'Re: Quarterly plan', minutes: 60 * 24 * 45),
      ]);
      final t = await thread(store, eid('INBOX', 1));
      expect(await thread(store, eid('INBOX', 2)), t);
      expect(await thread(store, eid('INBOX', 3)), isNot(t), reason: 'not a reply');
      expect(await thread(store, eid('INBOX', 4)), isNot(t), reason: 'too far apart');
    });

    test('keeps server thread ids', () async {
      final store = await seededStore();
      await addMails(store, [mail(1, messageId: 'a@x', threadId: 'gm1'), mail(2, messageId: 'b@x', threadId: 'gm1')]);
      expect(await thread(store, eid('INBOX', 2)), 'gm1');
    });
  });

  group('lists', () {
    late MailStore store;
    setUp(() async {
      store = await seededStore();
      await store.setVip('VIP@example.com', vip: true);
      await addMails(store, [
        mail(1, messageId: 'a@x', subject: 'Plan', minutes: 1, keywords: {Keywords.seen}),
        mail(
          2,
          messageId: 'b@x',
          subject: 'Re: Plan',
          inReplyTo: 'a@x',
          from: 'bob@x.test',
          fromName: 'Bob',
          minutes: 2,
        ),
        mail(3, messageId: 'c@x', subject: 'Lunch', minutes: 3, cc: ['alias@acc1.test'], to: ['other@x.test']),
        mail(4, messageId: 'd@x', subject: 'VIP note', from: 'vip@example.com', minutes: 4, hasAttachment: true),
        mail(5, messageId: 'e@x', subject: 'Flag', minutes: 5, keywords: {Keywords.flagged, Keywords.seen}),
        mail(6, path: 'Sent', messageId: 'f@x', subject: 'Re: Plan', references: ['a@x'], minutes: 6),
        mail(7, path: 'Trash', messageId: 'g@x', subject: 'Old', minutes: 7),
        mail(8, path: 'Drafts', messageId: 'h@x', subject: 'Draft', minutes: 8, keywords: {Keywords.draft}),
      ]);
    });

    List<String> subjects(List<ThreadSummary> list) => [for (final t in list) t.latest.subject];

    test('threads a mailbox newest first with counts and participants', () async {
      final list = await store.watchList(const RealMailboxRef('acc1|INBOX')).first;
      expect(subjects(list), ['Flag', 'VIP note', 'Lunch', 'Re: Plan']);
      final plan = list.last;
      expect((plan.messageCount, plan.unreadCount), (2, 1));
      expect(plan.participants.map((p) => p.email), ['bob@x.test', 'alice@example.com']);
      expect(plan.threadId, isNotEmpty);
    });

    test('unthreaded lists every message, with a limit', () async {
      final list = await store.watchList(RealMailboxRef(mbox('INBOX')), threaded: false, limit: 3).first;
      expect(subjects(list), ['Flag', 'VIP note', 'Lunch']);
      expect(list.every((t) => t.messageCount == 1), isTrue);
    });

    test('quick filters', () async {
      Future<List<String>> run(Set<QuickFilter> f) async =>
          subjects(await store.watchList(RealMailboxRef(mbox('INBOX')), filters: f, threaded: false).first);
      expect(await run({QuickFilter.unread}), ['VIP note', 'Lunch', 'Re: Plan']);
      expect(await run({QuickFilter.flagged}), ['Flag']);
      expect(await run({QuickFilter.toMe}), ['Flag', 'VIP note', 'Re: Plan', 'Plan']);
      expect(await run({QuickFilter.ccMe}), ['Lunch']);
      expect(await run({QuickFilter.hasAttachment}), ['VIP note']);
      expect(await run({QuickFilter.fromVip}), ['VIP note']);
      expect(await run({QuickFilter.unread, QuickFilter.toMe}), ['VIP note', 'Re: Plan']);
      await store.updateKeywords([eid('INBOX', 3)], add: {Keywords.answered});
      expect(await run({QuickFilter.unreplied}), ['Flag', 'VIP note', 'Re: Plan', 'Plan']);
    });

    test('virtual mailboxes and their counts', () async {
      Future<List<String>> run(VirtualMailbox v) async =>
          subjects(await store.watchList(VirtualMailboxRef(v), threaded: false).first);
      expect(await run(VirtualMailbox.allInboxes), hasLength(5));
      expect(await run(VirtualMailbox.unread), ['VIP note', 'Lunch', 'Re: Plan']);
      expect(await run(VirtualMailbox.flagged), ['Flag']);
      expect(await run(VirtualMailbox.vip), ['VIP note']);
      expect(await run(VirtualMailbox.allDrafts), ['Draft']);
      expect(await run(VirtualMailbox.allSent), ['Re: Plan']);
      final counts = await store.watchVirtualCounts().first;
      expect(counts[VirtualMailbox.allInboxes], 3);
      expect(counts[VirtualMailbox.unread], 3);
      expect(counts[VirtualMailbox.flagged], 1);
      expect(counts[VirtualMailbox.vip], 1);
      expect(counts[VirtualMailbox.allDrafts], 1);
    });

    test('virtual mailboxes show one copy of a message in several mailboxes', () async {
      await store.replaceMailboxes(accountId, [
        ...standardMailboxes,
        const RemoteMailbox(path: 'All Mail', name: 'All Mail', role: MailboxRole.all),
        const RemoteMailbox(path: 'Label', name: 'Label'),
      ]);
      await addMails(store, [
        mail(1, path: 'All Mail', messageId: 'c@x', subject: 'Lunch', minutes: 3),
        mail(1, path: 'Label', messageId: 'c@x', subject: 'Lunch', minutes: 3),
      ]);
      final unread = await store.watchList(const VirtualMailboxRef(VirtualMailbox.unread), threaded: false).first;
      final lunch = unread.where((t) => t.latest.subject == 'Lunch').toList();
      expect(lunch.single.latest.mailboxId, mbox('INBOX'));
      expect((await store.watchVirtualCounts().first)[VirtualMailbox.unread], 3);
    });

    test('All Inboxes and Unread counts follow the server counts', () async {
      // The server has many more unread messages than are stored: 3 of
      // 35,722 in the inbox, 1 of 40 in Work; Trash's 900 don't count.
      await store.applySync(mbox('INBOX'), added(const [], total: 90000, unread: 35722));
      await store.applySync(mbox('Work'), added([mail(20, path: 'Work', subject: 'Report')], total: 100, unread: 40));
      await store.applySync(mbox('Trash'), added(const [], total: 1000, unread: 900));
      var counts = await store.watchVirtualCounts().first;
      expect(counts[VirtualMailbox.allInboxes], 35722);
      expect(counts[VirtualMailbox.unread], 35722 + 40);
      // The Unread list itself shows what is stored.
      final list = await store.watchList(const VirtualMailboxRef(VirtualMailbox.unread), threaded: false).first;
      expect(list, hasLength(4));

      // Reading a stored message lowers both.
      await store.updateKeywords([eid('Work', 20)], add: {Keywords.seen});
      counts = await store.watchVirtualCounts().first;
      expect(counts[VirtualMailbox.unread], 35722 + 39);

      // Without a server count, the stored messages are counted.
      await store.applySync(mbox('Work'), added([mail(21, path: 'Work', subject: 'Memo')]));
      counts = await store.watchVirtualCounts().first;
      expect(counts[VirtualMailbox.unread], 35722 + 1);
    });

    test('streams update on changes and stay quiet otherwise', () async {
      final emissions = <List<ThreadSummary>>[];
      final sub = store.watchList(RealMailboxRef(mbox('INBOX'))).listen(emissions.add);
      await pumpEventQueue();
      expect(emissions, hasLength(1));
      await store.setVip('nobody@x.test', vip: true);
      await store.applySync(mbox('INBOX'), const MailboxSyncResult(state: MailboxSyncState({})));
      await pumpEventQueue();
      expect(emissions, hasLength(1));
      await store.updateKeywords([eid('INBOX', 3)], add: {Keywords.seen});
      await pumpEventQueue();
      expect(emissions, hasLength(2));
      expect(emissions.last.firstWhere((t) => t.latest.subject == 'Lunch').unreadCount, 0);
      await sub.cancel();
    });

    test('conversation is oldest first, includes Sent, skips Trash copies', () async {
      await addMails(store, [mail(9, path: 'Trash', messageId: 'z@x', inReplyTo: 'a@x', subject: 'Re: Plan')]);
      final conv = await store.watchConversation(eid('INBOX', 2)).first;
      expect(conv.map((e) => e.id), [eid('INBOX', 1), eid('INBOX', 2), eid('Sent', 6)]);
      final fromTrash = await store.watchConversation(eid('Trash', 9)).first;
      expect(fromTrash.map((e) => e.id), contains(eid('Trash', 9)));
      expect(await store.watchConversation('nope').first, isEmpty);
    });
  });

  group('optimistic updates', () {
    test('keywords adjust unread counts and can be reverted', () async {
      final store = await seededStore();
      await store.applySync(mbox('INBOX'), added([mail(1), mail(2)], total: 2, unread: 2));
      final prev = await store.updateKeywords([eid('INBOX', 1), eid('INBOX', 2)], add: {Keywords.seen});
      expect(prev.keys, hasLength(2));
      expect((await store.getMailbox(mbox('INBOX')))!.unreadCount, 0);
      await store.restoreKeywords(prev);
      expect((await store.getMailbox(mbox('INBOX')))!.unreadCount, 2);
      expect((await store.getEmail(eid('INBOX', 1)))!.isSeen, isFalse);
      final none = await store.updateKeywords([eid('INBOX', 1)], remove: {Keywords.seen});
      expect(none, isEmpty);
    });

    test('moves, renames and keeps old ids resolvable', () async {
      final store = await seededStore();
      await store.applySync(mbox('INBOX'), added([mail(1, messageId: 'a@x')], total: 1, unread: 1));
      await store.putContent(EmailContent(emailId: eid('INBOX', 1), text: 'pineapple'));
      final prev = await store.moveLocally([eid('INBOX', 1)], mbox('Archive'));
      expect(prev, {eid('INBOX', 1): mbox('INBOX')});
      expect((await store.getEmail(eid('INBOX', 1)))!.mailboxId, mbox('Archive'));
      expect((await store.getMailbox(mbox('INBOX')))!.unreadCount, 0);
      expect((await store.getMailbox(mbox('Archive')))!.unreadCount, 1);

      await store.renameEmails({eid('INBOX', 1): eid('Archive', 77)});
      final moved = (await store.getEmail(eid('INBOX', 1)))!;
      expect(moved.id, eid('Archive', 77));
      expect((await store.getContent(eid('INBOX', 1)))!.text, 'pineapple');
      expect(await store.search(const TextTerm(SearchField.body, 'pineap')), [moved]);
      final conv = await store.watchConversation(eid('INBOX', 1)).first;
      expect(conv.single.id, eid('Archive', 77));
    });

    test('rename drops the old row when the new id is already synced', () async {
      final store = await seededStore();
      await addMails(store, [mail(1, messageId: 'a@x'), mail(5, path: 'Archive', messageId: 'a@x')]);
      await store.moveLocally([eid('INBOX', 1)], mbox('Archive'));
      await store.renameEmails({eid('INBOX', 1): eid('Archive', 5)});
      expect(await store.emailIdsIn(mbox('Archive')), [eid('Archive', 5)]);
    });

    test('restoreMailboxes and delete/restore', () async {
      final store = await seededStore();
      await addMails(store, [mail(1), mail(2)]);
      final prev = await store.moveLocally([eid('INBOX', 1)], mbox('Trash'));
      await store.restoreMailboxes(prev);
      expect((await store.getEmail(eid('INBOX', 1)))!.mailboxId, mbox('INBOX'));
      final gone = await store.deleteEmails([eid('INBOX', 2)]);
      expect(await store.getEmail(eid('INBOX', 2)), isNull);
      await store.restoreEmails(gone);
      expect(await store.getEmail(eid('INBOX', 2)), isNotNull);
    });
  });

  group('content cache', () {
    test('caches content and inline parts within caps, indexes body text', () async {
      final store = await seededStore();
      await addMails(store, [mail(1)]);
      final small = Uint8List.fromList([1, 2, 3]);
      final big = Uint8List(maxInlinePartBytes + 1);
      await store.putContent(
        EmailContent(
          emailId: eid('INBOX', 1),
          html: '<p>Hello <b>zebra</b></p><style>.x{}</style>',
          headers: const [('List-Id', '<news.example.com>')],
          attachments: const [Attachment(partId: '2', mimeType: 'application/pdf', filename: 'invoice-42.pdf')],
          inlineData: {'small': small, 'big': big},
          isFlowed: true,
        ),
      );
      final c = (await store.getContent(eid('INBOX', 1)))!;
      expect(c.inlineData.keys, ['small']);
      expect(c.isFlowed, isTrue);
      expect(c.headers.single, ('List-Id', '<news.example.com>'));
      expect(c.attachments.single.filename, 'invoice-42.pdf');
      expect(await store.search(const TextTerm(SearchField.body, 'zebra')), hasLength(1));
      expect(await store.search(const TextTerm(SearchField.attachment, 'invoice')), hasLength(1));
      expect(await store.evictContent(DateTime.now().add(const Duration(days: 1))), 1);
      expect(await store.search(const TextTerm(SearchField.body, 'zebra')), isEmpty);
      await store.putContent(EmailContent(emailId: 'unknown', text: 'x'));
    });
  });

  group('outbox and pending ops', () {
    test('outbox CRUD with claim and take', () async {
      final store = await seededStore();
      final msg = OutgoingMessage(
        accountId: accountId,
        identityId: 'acc1/default',
        to: const [EmailAddress('bob@x.test', 'Bob')],
        subject: 'Hi',
        text: 'Hello',
        attachments: [
          OutgoingAttachment(
            filename: 'a.bin',
            mimeType: 'application/octet-stream',
            data: Uint8List.fromList([0, 255]),
          ),
        ],
        references: const ['a@x'],
        mode: ComposeMode.reply,
        sourceEmailId: eid('INBOX', 1),
      );
      await store.putOutbox(
        OutboxEntry(id: 'o1', accountId: accountId, message: msg, sendAfter: base, createdAt: base),
      );
      final got = (await store.getOutbox('o1'))!;
      expect(got.message.attachments.single.data, [0, 255]);
      expect(got.message.to.single.name, 'Bob');
      expect(got.message.mode, ComposeMode.reply);
      expect((await store.claimOutbox('o1'))!.status, OutboxStatus.sending);
      expect(await store.claimOutbox('o1'), isNull);
      expect(await store.takeOutbox('o1'), isNull, reason: 'being sent');
      await store.updateOutbox('o1', status: OutboxStatus.failed, attempts: 1, lastError: 'boom');
      expect((await store.outboxEntries()).single.lastError, 'boom');
      expect((await store.takeOutbox('o1'))!.id, 'o1');
      expect(await store.outboxEntries(), isEmpty);
    });

    test('scheduled entries keep their status and can be rescheduled unless being sent', () async {
      final store = await seededStore();
      final msg = OutgoingMessage(accountId: accountId, identityId: 'acc1/default', subject: 'Later');
      final later = base.add(const Duration(days: 1));
      await store.putOutbox(
        OutboxEntry(
          id: 'o2',
          accountId: accountId,
          message: msg,
          sendAfter: later,
          createdAt: base,
          status: OutboxStatus.scheduled,
        ),
      );
      final updates = <List<OutboxStatus>>[];
      final sub = store.watchOutbox().listen((e) => updates.add([for (final x in e) x.status]));
      expect((await store.getOutbox('o2'))!.status, OutboxStatus.scheduled);
      await store.updateOutbox('o2', status: OutboxStatus.failed, attempts: 1, lastError: 'boom');
      final evening = base.add(const Duration(hours: 6));
      expect(await store.rescheduleOutbox('o2', sendAfter: evening, status: OutboxStatus.scheduled), isTrue);
      final moved = (await store.getOutbox('o2'))!;
      expect(moved.sendAfter, evening);
      expect(moved.status, OutboxStatus.scheduled);
      expect(moved.lastError, isNull);
      expect(moved.attempts, 1);
      await store.claimOutbox('o2');
      expect(await store.rescheduleOutbox('o2', sendAfter: base, status: OutboxStatus.queued), isFalse);
      expect(await store.rescheduleOutbox('nope', sendAfter: base, status: OutboxStatus.queued), isFalse);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(updates.last, [OutboxStatus.sending]);
      await sub.cancel();
    });

    test('pending ops keep order and update', () async {
      final store = await seededStore();
      final a = await store.enqueueOp(accountId, 'setKeywords', {
        'ids': ['x'],
      }, now: base);
      await store.enqueueOp(accountId, 'move', {
        'ids': ['y'],
      }, now: base);
      await store.updateOp(a, attempts: 2, lastError: 'later', nextAttemptAt: base.add(const Duration(minutes: 1)));
      final ops = await store.pendingOps(accountId: accountId);
      expect(ops.map((o) => o.type), ['setKeywords', 'move']);
      expect(ops.first.attempts, 2);
      expect(ops.first.payload, {
        'ids': ['x'],
      });
      await store.deleteOp(a);
      expect((await store.pendingOps()).single.type, 'move');
    });
  });

  test('VIPs', () async {
    final store = await seededStore();
    await store.setVip('A@x.test', vip: true);
    await store.setVip('b@x.test', vip: true);
    await store.setVip('b@x.test', vip: false);
    expect(await store.watchVipAddresses().first, {'a@x.test'});
  });
}
