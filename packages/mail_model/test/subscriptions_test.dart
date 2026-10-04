import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

final now = DateTime.utc(2026, 10, 1, 12);

EmailSummary mail(
  String id, {
  String from = 'news@shop.example',
  String? name = 'Shop',
  String box = 'INBOX',
  String account = 'a',
  int daysAgo = 1,
  bool seen = false,
  String? messageId,
  String? listId,
  String? listName,
  String? unsubscribe,
  String? post,
}) => EmailSummary(
  id: id,
  accountId: account,
  mailboxId: '$account/$box',
  receivedAt: now.subtract(Duration(days: daysAgo)),
  messageIdHeader: messageId,
  from: [EmailAddress(from, name)],
  keywords: seen ? {Keywords.seen} : const {},
  listId: listId,
  listName: listName,
  listUnsubscribe: unsubscribe,
  listUnsubscribePost: post,
);

MailboxRole? role(EmailSummary e) => switch (e.mailboxId.split('/').last) {
  'INBOX' => MailboxRole.inbox,
  'Junk' => MailboxRole.junk,
  'Sent' => MailboxRole.sent,
  'All Mail' => MailboxRole.all,
  'Trash' => MailboxRole.trash,
  _ => null,
};

void main() {
  group('List-Unsubscribe URIs', () {
    test('several URIs in brackets, with comments and folding', () {
      final uris = parseListUris(
        '<mailto:leave@lists.example.org?subject=unsubscribe> (by mail),\r\n'
        '  <https://lists.example.org/u?id=1&\r\n x=2>, <ftp://ignored.example>',
      );
      expect(uris.map((u) => u.toString()), [
        'mailto:leave@lists.example.org?subject=unsubscribe',
        'https://lists.example.org/u?id=1&x=2',
        'ftp://ignored.example',
      ]);
    });

    test('bare URIs without brackets', () {
      expect(parseListUris('mailto:leave@example.org').single.toString(), 'mailto:leave@example.org');
      expect(parseListUris(' https://example.org/u , mailto:x@example.org ').map((u) => u.scheme), ['https', 'mailto']);
      // List-Post: NO, and prose, aren't URIs.
      expect(parseListUris('NO'), isEmpty);
      expect(parseListUris('see https://example.org for details'), isEmpty);
      expect(parseListUris('javascript:alert(1)'), isEmpty);
    });
  });

  group('mailto links (RFC 6068)', () {
    test('subject and body, with a plus kept as a plus', () {
      final link = MailtoLink.parse(
        Uri.parse('mailto:list+leave@example.org?Subject=Unsubscribe%20me&body=remove+me%0D%0Aplease'),
      )!;
      expect(link.to.single.email, 'list+leave@example.org');
      expect(link.subject, 'Unsubscribe me');
      expect(link.body, 'remove+me\r\nplease');
    });

    test('recipients from the path and to=, cc and bcc', () {
      final link = MailtoLink.parse(
        Uri.parse('mailto:a%40example.org,b@example.org?to=c@example.org&cc=d@example.org&bcc=e@example.org&x=y'),
      )!;
      expect(link.to.map((a) => a.email), ['a@example.org', 'b@example.org', 'c@example.org']);
      expect(link.cc.single.email, 'd@example.org');
      expect(link.bcc.single.email, 'e@example.org');
      expect(link.subject, isNull);
    });

    test('no recipient, or not mailto', () {
      expect(MailtoLink.parse(Uri.parse('mailto:?subject=hi')), isNull);
      expect(MailtoLink.parse(Uri.parse('https://example.org')), isNull);
      expect(MailtoLink.parse(Uri.parse('mailto:?to=x@example.org'))!.to.single.email, 'x@example.org');
    });

    test('a bad escape stays as written', () {
      expect(MailtoLink.parse(Uri.parse('mailto:x@example.org?subject=100%25%20off'))!.subject, '100% off');
    });
  });

  group('unsubscribe methods', () {
    test('one-click first, then mail, then the page', () {
      final methods = unsubscribeMethods(
        '<mailto:u@news.example?subject=stop>, <https://news.example/u/abc>',
        'List-Unsubscribe=One-Click',
      );
      expect(methods, [
        OneClickUnsubscribe(Uri.parse('https://news.example/u/abc')),
        MailtoUnsubscribe(Uri.parse('mailto:u@news.example?subject=stop'), MailtoLink(to: const [])),
        WebUnsubscribe(Uri.parse('https://news.example/u/abc')),
      ]);
      final mailto = methods[1] as MailtoUnsubscribe;
      expect(mailto.subject, 'stop');
      expect(mailto.body, '');
    });

    test('one-click needs the Post header and an https URI', () {
      expect(unsubscribeMethods('<https://news.example/u>', null), [
        WebUnsubscribe(Uri.parse('https://news.example/u')),
      ]);
      expect(unsubscribeMethods('<http://news.example/u>', 'List-Unsubscribe=One-Click'), [
        WebUnsubscribe(Uri.parse('http://news.example/u')),
      ]);
      expect(unsubscribeMethods('<https://news.example/u>', 'List-Unsubscribe=Later').single, isA<WebUnsubscribe>());
    });

    test('https pages win over http; credentials in the URI are refused', () {
      expect(unsubscribeMethods('<http://a.example/u>, <https://b.example/u>', null).single.uri.host, 'b.example');
      expect(unsubscribeMethods('<https://user:pw@a.example/u>', 'List-Unsubscribe=One-Click'), isEmpty);
    });

    test('a mailto without subject sends "unsubscribe"', () {
      final m = unsubscribeMethods('<mailto:leave@lists.example.org>', null).single as MailtoUnsubscribe;
      expect(m.to.single.email, 'leave@lists.example.org');
      expect(m.subject, 'unsubscribe');
    });

    test('nothing usable', () {
      expect(unsubscribeMethods(null, null), isEmpty);
      expect(unsubscribeMethods('<ftp://x.example>, <mailto:>', 'List-Unsubscribe=One-Click'), isEmpty);
    });
  });

  group('bulk mail', () {
    test('ESP Message-IDs', () {
      expect(isBulkMessageId('0f0b.123@mail170.atl221.mcdlv.net'), isTrue);
      expect(isBulkMessageId('abc@email.amazonses.com'), isTrue);
      expect(isBulkMessageId('abc@SendGrid.net'), isTrue);
      expect(isBulkMessageId('abc@notsendgrid.net'), isFalse);
      expect(isBulkMessageId('abc@example.com'), isFalse);
      expect(isBulkMessageId(null), isFalse);
    });

    test('keys: List-Id, else the sender of bulk mail', () {
      expect(subscriptionKeyOf(mail('1', listId: 'dev.example.org')), 'list:dev.example.org');
      expect(
        subscriptionKeyOf(mail('2', from: 'News@Shop.example', unsubscribe: '<mailto:x@y>')),
        'from:news@shop.example',
      );
      expect(subscriptionKeyOf(mail('3', messageId: 'x@mcsv.net')), 'from:news@shop.example');
      expect(subscriptionKeyOf(mail('4')), isNull);
    });
  });

  group('Subscription', () {
    test('rates use the last 90 days once three messages arrived then', () {
      const busy = Subscription(
        key: 'from:a@x',
        name: 'A',
        address: 'a@x',
        messageCount: 40,
        readCount: 30,
        recentCount: 9,
        recentReadCount: 0,
      );
      expect(busy.perMonth, 3);
      expect(busy.readRate, 0);
      expect(busy.neverRead, isTrue);
      expect(busy.neglect, 3);
      const quiet = Subscription(
        key: 'from:b@x',
        name: 'B',
        address: 'b@x',
        messageCount: 4,
        readCount: 1,
        recentCount: 2,
        recentReadCount: 0,
      );
      expect(quiet.readRate, 0.25);
      expect(quiet.neverRead, isFalse);
    });

    test('most unread mail a month first', () {
      const a = Subscription(key: 'from:a', name: 'A', address: 'a', messageCount: 30, recentCount: 30);
      const b = Subscription(
        key: 'from:b',
        name: 'B',
        address: 'b',
        messageCount: 90,
        readCount: 90,
        recentCount: 90,
        recentReadCount: 90,
      );
      const c = Subscription(key: 'from:c', name: 'C', address: 'c', messageCount: 50);
      const d = Subscription(key: 'from:d', name: 'D', address: 'd', messageCount: 5);
      expect(([b, d, c, a]..sort(Subscription.compareByNeglect)).map((s) => s.name), ['A', 'C', 'D', 'B']);
    });
  });

  group('summarizeSubscriptions', () {
    test('groups, counts and names', () {
      final subs = summarizeSubscriptions(
        [
          // A newsletter: one copy in the Inbox and in All Mail, read in one.
          mail('1', messageId: 'n1@shop.example', unsubscribe: '<https://shop.example/u/old>', daysAgo: 100),
          mail('2', messageId: 'n2@shop.example', box: 'All Mail', daysAgo: 20, unsubscribe: '<mailto:u@shop.example>'),
          mail('2i', messageId: 'n2@shop.example', daysAgo: 20, seen: true, unsubscribe: '<mailto:u@shop.example>'),
          mail(
            '3',
            messageId: 'n3@shop.example',
            name: 'Shop News',
            daysAgo: 2,
            box: 'Trash',
            unsubscribe: '<https://shop.example/u/new>',
            post: 'List-Unsubscribe=One-Click',
          ),
          // The same sender's mail without List-Unsubscribe isn't bulk.
          mail('3b', messageId: 'r@shop.example', name: 'Shop Orders', daysAgo: 0),
          // Junk and the user's own mail don't count.
          mail('4', messageId: 'n4@shop.example', box: 'Junk', unsubscribe: '<mailto:u@shop.example>'),
          mail('5', from: 'me@home.example', listId: 'dev.example.org', box: 'Sent'),
          mail('6', from: 'Me@Home.example', listId: 'dev.example.org'),
          // A list with two senders; the List-Id phrase names it.
          mail('7', from: 'ann@x.example', name: 'Ann', listId: 'dev.example.org', listName: 'Developers'),
          mail('8', from: 'bob@x.example', name: 'Bob', listId: 'dev.example.org', daysAgo: 0, seen: true),
          // An ESP sender needs two messages; personal mail never counts.
          mail('9', from: 'ping@app.example', messageId: 'a@amazonses.com'),
          mail('10', from: 'friend@home.example', messageId: 'f@home.example'),
        ],
        roleOf: role,
        now: now,
        me: {'me@home.example'},
      );
      expect(subs.map((s) => s.key), ['from:news@shop.example', 'list:dev.example.org']);
      final shop = subs.first;
      expect(shop.name, 'Shop News');
      expect(shop.address, 'news@shop.example');
      expect(shop.messageCount, 3);
      expect(shop.readCount, 1);
      expect(shop.recentCount, 2);
      expect(shop.inboxCount, 2);
      expect(shop.lastReceived, now.subtract(const Duration(days: 2)));
      expect(shop.mailboxIds, ['a/All Mail', 'a/INBOX', 'a/Trash']);
      expect(shop.listUnsubscribe, '<https://shop.example/u/new>');
      expect(shop.unsubscribe.first, isA<OneClickUnsubscribe>());
      final dev = subs.last;
      expect(dev.name, 'Developers');
      expect(dev.address, 'bob@x.example');
      expect(dev.senderCount, 2);
      expect(dev.isList, isTrue);
      expect(dev.listId, 'dev.example.org');
      expect(dev.readRate, 0.5);
    });

    test('an ESP sender with two messages counts', () {
      final subs = summarizeSubscriptions(
        [
          mail('1', from: 'ping@app.example', name: null, messageId: 'a@amazonses.com'),
          mail('2', from: 'ping@app.example', name: '', messageId: 'b@amazonses.com'),
        ],
        roleOf: role,
        now: now,
      );
      expect(subs.single.name, 'ping@app.example');
      expect(subs.single.unsubscribe, isEmpty);
    });
  });
}
