import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/notifications/new_mail.dart';
import 'package:loupe/features/notifications/notification_content.dart';
import 'package:loupe/features/notifications/notification_settings.dart';
import 'package:mail_model/mail_model.dart';

import 'fakes.dart';

final t0 = DateTime(2026, 10, 4, 9);

void main() {
  late FakeMail mail;
  late MailAccount work;
  late MailAccount home;

  NewMail newMail(String accountId, String subject, {bool vip = false, int minute = 0}) => NewMail(
    mail.deliver(
      accountId,
      t0.add(Duration(minutes: minute)),
      subject: subject,
      fromName: 'Alice Liddell',
      preview: 'Down the <rabbit> hole',
    ),
    fromVip: vip,
  );

  setUp(() {
    mail = FakeMail();
    work = mail.account('work', name: 'Work');
    home = mail.account('home', name: 'Home');
  });

  group('a message notification', () {
    test('shows sender, subject and preview, grouped per account', () {
      final n = messageNotification(newMail('work', 'Quarterly report'), work, hideContent: false, showAccount: true);
      expect(n.title, 'Alice Liddell');
      expect(n.body, 'Quarterly report');
      expect(n.expandedBody, 'Quarterly report\nDown the <rabbit> hole');
      expect(n.subText, 'Work');
      expect(n.when, t0);
      expect(n.groupKey, groupKeyFor('work'));
      expect(n.channel, MailChannel.account(work));
      expect(n.channel.id, 'mail.work');
      expect(n.isSummary, isFalse);
      expect(n.actions, [MailAction.archive, MailAction.markRead, MailAction.reply]);
      expect(n.target, isA<MessageTarget>().having((t) => t.accountId, 'account', 'work'));
    });

    test('with Hide Content says only which account has new mail', () {
      final n = messageNotification(newMail('work', 'Secret'), work, hideContent: true, showAccount: true);
      expect(n.title, 'New message from Work');
      expect(n.body, isNull);
      expect(n.expandedBody, isNull);
      expect(n.subText, isNull);
      expect(n.actions, contains(MailAction.markRead), reason: 'the buttons reveal nothing');
    });

    test('from a VIP uses the VIP channel, in the account’s group', () {
      final n = messageNotification(newMail('home', 'Dinner?', vip: true), home, hideContent: false);
      expect(n.channel, MailChannel.vip);
      expect(n.groupKey, groupKeyFor('home'));
    });

    test('offers Archive only where there is an archive', () {
      final n = messageNotification(newMail('work', 'x'), work, hideContent: false, canArchive: false);
      expect(n.actions, [MailAction.markRead, MailAction.reply]);
    });

    test('names an unnamed sender and an empty subject', () {
      final e = mail.deliver('work', t0, fromName: null, subject: '  ', preview: '');
      final n = messageNotification(NewMail(e, fromVip: false), work, hideContent: false);
      expect(n.title, 'alice@example.com');
      expect(n.body, '(No Subject)');
      expect(n.expandedBody, isNull);
      expect(n.subText, isNull, reason: 'one account: no need to name it');
    });
  });

  group('messageNotifications', () {
    test('leaves out muted accounts, and non-VIP mail when VIP Only is on', () {
      final batch = [
        newMail('work', 'Work mail'),
        newMail('home', 'Home mail'),
        newMail('home', 'Home VIP', vip: true),
      ];
      List<String?> subjects(NotificationSettings s) => [
        for (final n in messageNotifications(batch, accounts: mail.accounts, settings: s)) n.body,
      ];
      expect(subjects(const NotificationSettings()), ['Work mail', 'Home mail', 'Home VIP']);
      expect(subjects(const NotificationSettings(mutedAccounts: {'home'})), ['Work mail']);
      expect(subjects(const NotificationSettings(vipOnly: true)), ['Home VIP']);
    });

    test('shows at most a few per account, the newest', () {
      final batch = [for (var i = 1; i <= 9; i++) newMail('work', 'M$i', minute: i)];
      final shown = messageNotifications(batch, accounts: mail.accounts, settings: const NotificationSettings());
      expect([for (final n in shown) n.body], ['M4', 'M5', 'M6', 'M7', 'M8', 'M9']);
    });

    test('gives Archive to the accounts that can archive', () {
      final shown = messageNotifications(
        [newMail('work', 'a'), newMail('home', 'b')],
        accounts: mail.accounts,
        settings: const NotificationSettings(),
        archivable: {'home'},
      );
      expect([for (final n in shown) n.actions.contains(MailAction.archive)], [false, true]);
    });
  });

  group('the account summary', () {
    const children = [
      ShownNotification(id: 1, title: 'Alice', body: 'Lunch'),
      ShownNotification(id: 2, title: 'Bob', body: 'Report'),
      ShownNotification(id: 3, title: 'Alice', body: 'Re: Lunch'),
    ];

    test('a showing notification knows its target from its tag alone', () {
      final n = messageNotification(newMail('work', 'Tagged'), work, hideContent: false);
      expect(n.tag, n.target!.encode());
      final shown = ShownNotification(id: n.id, tag: n.tag);
      expect(shown.target, n.target);
      expect(const ShownNotification(id: 9).target, isNull, reason: 'someone else’s notification');
      expect(summaryNotification(work, children, hideContent: false).tag, const AccountTarget('work').encode());
    });

    test('counts and lists the messages of its group', () {
      final s = summaryNotification(work, children, hideContent: false);
      expect(s.isSummary, isTrue);
      expect(s.id, summaryNotificationId('work'));
      expect(s.groupKey, groupKeyFor('work'));
      expect(s.title, '3 new messages');
      expect(s.body, 'Alice, Bob');
      expect(s.lines, ['Alice – Lunch', 'Bob – Report', 'Alice – Re: Lunch']);
      expect(s.subText, 'Work');
      expect(s.target, const AccountTarget('work'));
      expect(summaryNotification(work, children.take(1).toList(), hideContent: false).title, '1 new message');
    });

    test('with Hide Content lists nothing', () {
      final s = summaryNotification(work, children, hideContent: true);
      expect(s.title, '3 new messages');
      expect(s.body, 'New messages in Work');
      expect(s.lines, isEmpty);
    });
  });

  test('ids are stable, positive and distinct', () {
    final a = messageNotificationId('work|INBOX|1|1');
    expect(messageNotificationId('work|INBOX|1|1'), a);
    expect(a, isPositive);
    expect(a * 16, lessThan(1 << 31), reason: 'button request codes fit an int');
    final ids = {for (var i = 0; i < 2000; i++) messageNotificationId('work|INBOX|1|$i')};
    expect(ids, hasLength(2000));
    expect(summaryNotificationId('work'), isNot(summaryNotificationId('home')));
  });

  test('targets survive the payload; anything else decodes to null', () {
    const message = MessageTarget('work|INBOX|1|7', 'work');
    final decoded = NotificationTarget.decode(message.encode());
    expect(decoded, isA<MessageTarget>().having((t) => t.emailId, 'email', 'work|INBOX|1|7'));
    expect(NotificationTarget.decode(const AccountTarget('home').encode()), const AccountTarget('home'));
    for (final junk in [null, '', 'hello', '{"k":"x"}', '[1]', '{"k":"m","e":1}']) {
      expect(NotificationTarget.decode(junk), isNull, reason: junk);
    }
    expect(MailAction.byId('archive'), MailAction.archive);
    expect(MailAction.byId('nope'), isNull);
  });
}
