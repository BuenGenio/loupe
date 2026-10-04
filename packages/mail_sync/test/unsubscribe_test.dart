import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

const _news = 'news@weekly.example';

void main() {
  test('subscriptions come from the synced store', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()
        ..deliver('INBOX', subject: 'Issue 1', from: _news, fromName: 'Weekly', listUnsubscribe: '<mailto:x@y.example>')
        ..deliver(
          'INBOX',
          subject: 'Issue 2',
          from: _news,
          fromName: 'Weekly',
          keywords: {Keywords.seen},
          listUnsubscribe: '<https://weekly.example/u>',
          listUnsubscribePost: 'List-Unsubscribe=One-Click',
        )
        ..deliver('INBOX', subject: 'Personal', from: 'friend@home.example');
      final account = await h.add(server);
      final sub = (await h.repo.watchSubscriptions().first).single;
      expect(sub.key, 'from:$_news');
      expect(sub.name, 'Weekly');
      expect(sub.messageCount, 2);
      expect(sub.readCount, 1);
      expect(sub.inboxCount, 2);
      expect(sub.accountIds, [account.id]);
      expect(sub.unsubscribe.first, OneClickUnsubscribe(Uri.parse('https://weekly.example/u')));
      final emails = await h.repo.watchSubscriptionEmails(sub.key, inboxOnly: true).first;
      expect(emails.map((e) => e.subject), ['Issue 2', 'Issue 1']);
      await h.dispose();
    });
  });

  test('a mailto unsubscribe goes out through SMTP like any message', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()
        ..deliver(
          'INBOX',
          subject: 'Deals',
          from: _news,
          listUnsubscribe: '<mailto:leave@weekly.example?subject=unsubscribe%20weekly&body=please+remove>',
        );
      final account = await h.add(server);
      final sub = (await h.repo.watchSubscriptions().first).single;
      final latest = (await h.repo.watchSubscriptionEmails(sub.key).first).first;
      final method = sub.unsubscribe.whereType<MailtoUnsubscribe>().single;
      await h.repo.send(
        unsubscribeMessage(method, account, receivedAs: [...latest.to, ...latest.cc]),
        undoDelay: Duration.zero,
      );
      await settle();
      final mail = server.sent.single;
      expect(mail.envelopeFrom, 'me@example.com');
      expect(mail.recipients, ['leave@weekly.example']);
      expect(mail.json['subject'], 'unsubscribe weekly');
      expect(mail.json['text'], 'please+remove');
      expect(await h.repo.watchOutbox().first, isEmpty);
      await h.dispose();
    });
  });
}
