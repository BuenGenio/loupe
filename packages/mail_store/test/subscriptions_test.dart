import 'dart:math';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

final now = DateTime(2026, 10, 1, 12);

const _boxes = ['INBOX', 'Archive', 'Trash', 'Junk', 'Sent', 'Work'];

MailboxRole? _role(String path) => standardMailboxes.where((m) => m.path == path).firstOrNull?.role;

/// A bulk (or personal) message [daysAgo] days back.
EmailSummary bulk(
  int uid, {
  String path = 'INBOX',
  String account = accountId,
  String from = 'news@shop.example',
  String? fromName = 'Shop',
  int daysAgo = 1,
  bool seen = false,
  String? messageId,
  String? listId,
  String? listName,
  String? unsubscribe,
  String? post,
}) => EmailSummary(
  id: eid(path, uid, account: account),
  accountId: account,
  mailboxId: mbox(path, account: account),
  receivedAt: now.subtract(Duration(days: daysAgo, minutes: uid % 1000)),
  messageIdHeader: messageId,
  from: [EmailAddress(from, fromName)],
  to: const [EmailAddress('me@example.com')],
  subject: 'Issue $uid',
  keywords: seen ? {Keywords.seen} : const {},
  listId: listId,
  listName: listName,
  listUnsubscribe: unsubscribe,
  listUnsubscribePost: post,
);

/// A synthetic mailbox of [count] messages: newsletters (some with copies
/// in two folders), mailing lists, ESP mail, the user's own mail and
/// personal mail, over two years.
List<EmailSummary> synthetic(int count, {int seed = 42, List<String> accounts = const [accountId]}) {
  final random = Random(seed);
  final out = <EmailSummary>[];
  for (var uid = 1; out.length < count; uid++) {
    final account = accounts[random.nextInt(accounts.length)];
    final kind = random.nextInt(10);
    final daysAgo = random.nextInt(random.nextBool() ? 120 : 730);
    final path = _boxes[random.nextInt(random.nextInt(4) == 0 ? _boxes.length : 2)];
    final seen = random.nextInt(4) == 0;
    final messageId = 'm$uid.$account@mail.example';
    switch (kind) {
      case 0 || 1 || 2:
        // Newsletters: 300 senders, one-click on some.
        final n = random.nextInt(300);
        final message = bulk(
          uid,
          account: account,
          path: path,
          from: 'news$n@brand$n.example',
          fromName: n % 7 == 0 ? null : (random.nextInt(5) == 0 ? 'Brand $n Deals' : 'Brand $n'),
          daysAgo: daysAgo,
          seen: seen,
          messageId: messageId,
          unsubscribe: n % 3 == 0 ? '<https://brand$n.example/u/$uid>' : '<mailto:leave@brand$n.example>',
          post: n % 6 == 0 && random.nextBool() ? 'List-Unsubscribe=One-Click' : null,
        );
        out.add(message);
        // Gmail-style: another copy of the same message in a second folder.
        if (random.nextInt(4) == 0 && path == 'INBOX') {
          out.add(
            bulk(
              uid + 10000000,
              account: account,
              path: 'Archive',
              from: message.sender!.email,
              fromName: message.sender!.name,
              daysAgo: daysAgo,
              seen: seen,
              messageId: messageId,
              unsubscribe: message.listUnsubscribe,
              post: message.listUnsubscribePost,
            ).copyWith(),
          );
        }
      case 3 || 4:
        // Mailing lists: 40 lists, many posters.
        final l = random.nextInt(40);
        out.add(
          bulk(
            uid,
            account: account,
            path: path,
            from: 'person${random.nextInt(60)}@people.example',
            fromName: random.nextBool() ? 'Person' : null,
            daysAgo: daysAgo,
            seen: seen,
            messageId: messageId,
            listId: 'list$l.lists.example.org',
            listName: l % 4 == 0 ? null : 'List $l',
            unsubscribe: l % 2 == 0 ? '<mailto:list$l-leave@lists.example.org>' : null,
          ),
        );
      case 5:
        // ESP notifications without List-* headers.
        final s = random.nextInt(80);
        out.add(
          bulk(
            uid,
            account: account,
            path: path,
            from: 'notify@service$s.example',
            daysAgo: daysAgo,
            seen: seen,
            messageId: 'x$uid@${bulkMessageIdDomains[s % bulkMessageIdDomains.length]}',
          ),
        );
      case 6:
        // The user's own posts to lists.
        out.add(
          bulk(
            uid,
            account: account,
            path: path,
            from: 'me@example.com',
            daysAgo: daysAgo,
            messageId: messageId,
            listId: 'list${random.nextInt(40)}.lists.example.org',
          ),
        );
      default:
        // Personal mail.
        out.add(
          bulk(
            uid,
            account: account,
            path: path,
            from: 'friend${random.nextInt(200)}@home.example',
            daysAgo: daysAgo,
            seen: seen,
            messageId: messageId,
          ),
        );
    }
  }
  return out.take(count).toList();
}

Future<void> insertAll(MailStore store, List<EmailSummary> emails) async {
  for (var i = 0; i < emails.length; i += 2000) {
    await store.insertEmails(emails.sublist(i, min(i + 2000, emails.length)));
  }
}

void main() {
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  test('the query agrees with summarizeSubscriptions', () async {
    final store = await seededStore(
      accounts: [
        account(),
        account(id: 'acc2', email: 'other@example.com'),
      ],
    );
    final emails = synthetic(3000, accounts: [accountId, 'acc2']);
    await insertAll(store, emails);
    final me = {'me@example.com', 'alias@acc1.test', 'other@example.com', 'alias@acc2.test'};
    final expected = summarizeSubscriptions(
      emails,
      roleOf: (e) => _role(e.mailboxId.split('|').last) ?? _roleOfId(e.mailboxId),
      now: now,
      me: me,
    );
    final actual = await store.watchSubscriptions(now: now).first;
    expect(actual.length, expected.length);
    expect(actual.length, greaterThan(300));
    for (var i = 0; i < expected.length; i++) {
      expect(actual[i], expected[i], reason: 'rank $i');
    }
    await store.close();
  });

  group('subscriptions', () {
    late MailStore store;
    setUp(() async {
      store = await seededStore();
      await addMails(store, [
        bulk(1, messageId: 'a1@shop.example', daysAgo: 200, seen: true, unsubscribe: '<https://shop.example/u/1>'),
        bulk(2, messageId: 'a2@shop.example', daysAgo: 30, unsubscribe: '<https://shop.example/u/2>'),
        bulk(
          3,
          messageId: 'a3@shop.example',
          daysAgo: 3,
          fromName: 'Shop News',
          unsubscribe: '<https://shop.example/u/3>',
          post: 'List-Unsubscribe=One-Click',
        ),
        bulk(4, path: 'Archive', messageId: 'a3@shop.example', daysAgo: 3, unsubscribe: '<https://shop.example/u/3>'),
        bulk(5, path: 'Junk', messageId: 'a5@shop.example', unsubscribe: '<https://shop.example/u/5>'),
        bulk(6, messageId: 'a6@shop.example', daysAgo: 0),
        bulk(7, from: 'ann@x.example', listId: 'dev.x.example', listName: 'Dev', messageId: 'l1@x', seen: true),
        bulk(8, from: 'bob@x.example', listId: 'dev.x.example', messageId: 'l2@x', path: 'Work'),
        bulk(9, from: 'me@example.com', listId: 'dev.x.example', messageId: 'l3@x', path: 'Sent'),
        bulk(10, from: 'Alias@acc1.test', listId: 'dev.x.example', messageId: 'l4@x'),
      ]);
    });
    tearDown(() => store.close());

    test('counts, names and the newest unsubscribe header', () async {
      final subs = await store.watchSubscriptions(now: now).first;
      expect(subs.map((s) => s.key), ['from:news@shop.example', 'list:dev.x.example']);
      final shop = subs.first;
      expect(shop.name, 'Shop News');
      expect(shop.messageCount, 3);
      expect(shop.readCount, 1);
      expect(shop.recentCount, 2);
      expect(shop.inboxCount, 3);
      expect(shop.mailboxIds, [mbox('Archive'), mbox('INBOX')]);
      expect(shop.listUnsubscribe, '<https://shop.example/u/3>');
      expect(shop.unsubscribe.first, OneClickUnsubscribe(Uri.parse('https://shop.example/u/3')));
      final dev = subs.last;
      expect(dev.name, 'Dev');
      expect(dev.address, anyOf('ann@x.example', 'bob@x.example'));
      expect(dev.senderCount, 2);
      expect(dev.inboxCount, 1);
      expect(dev.listUnsubscribe, isNull);
    });

    test('the messages of a subscription', () async {
      final shop = await store.watchSubscriptionEmails('from:news@shop.example').first;
      expect(shop.map((e) => e.id), [eid('INBOX', 3), eid('Archive', 4), eid('INBOX', 2), eid('INBOX', 1)]);
      final inbox = await store.watchSubscriptionEmails('from:news@shop.example', inboxOnly: true).first;
      expect(inbox.map((e) => e.id), [eid('INBOX', 3), eid('INBOX', 2), eid('INBOX', 1)]);
      final dev = await store.watchSubscriptionEmails('list:dev.x.example', limit: 1).first;
      expect(dev.single.id, anyOf(eid('INBOX', 7), eid('Work', 8)));
      expect(await store.watchSubscriptionEmails('nonsense').first, isEmpty);
    });

    test('updates as mail is read and archived', () async {
      final shop = store
          .watchSubscriptions(now: now)
          .map((subs) => subs.firstWhere((s) => s.key == 'from:news@shop.example'));
      expect((await shop.first).readCount, 1);
      final done = expectLater(
        shop,
        emitsThrough(predicate<Subscription>((s) => s.readCount == 2 && s.inboxCount == 2, 'read 2, inbox 2')),
      );
      await store.updateKeywords([eid('INBOX', 2)], add: {Keywords.seen});
      await store.moveLocally([eid('INBOX', 3)], mbox('Archive'));
      await done;
    });
  });

  test('40,000 messages are summarised in under 200 ms', () async {
    final store = await seededStore();
    final emails = synthetic(40000, seed: 7);
    await insertAll(store, emails);
    final times = <int>[];
    late List<Subscription> subs;
    for (var i = 0; i < 3; i++) {
      final watch = Stopwatch()..start();
      // A different time each run, so drift can't answer from its cache.
      subs = await store.watchSubscriptions(now: now.add(Duration(minutes: i))).first;
      times.add(watch.elapsedMilliseconds);
    }
    final emailsOf = Stopwatch()..start();
    await store.watchSubscriptionEmails(subs.first.key).first;
    final detail = emailsOf.elapsedMilliseconds;
    // ignore: avoid_print
    print('subscriptions over 40k messages: $times ms (${subs.length} groups); one sender: $detail ms');
    expect(times.reduce(min), lessThan(200));
    expect(detail, lessThan(100));
    await store.close();
  }, timeout: const Timeout(Duration(minutes: 5)));
}

MailboxRole? _roleOfId(String mailboxId) {
  for (final path in _boxes) {
    if (mailboxId == mbox(path) || mailboxId == mbox(path, account: 'acc2')) return _role(path);
  }
  return null;
}
