import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/notifications/new_mail.dart';
import 'package:loupe/features/notifications/new_mail_check.dart';
import 'package:loupe/features/notifications/notification_content.dart';
import 'package:loupe/features/notifications/notification_settings.dart';
import 'package:mail_model/mail_model.dart';

import 'fakes.dart';

final t0 = DateTime(2026, 10, 4, 9);

DateTime at(int minutes) => t0.add(Duration(minutes: minutes));

void main() {
  late FakeMail mail;
  late FakeNotifier notifier;
  late MemoryNewMailStateStore state;
  late NewMailCheck check;
  const settings = NotificationSettings();

  setUp(() {
    mail = FakeMail()
      ..account('work')
      ..account('home');
    notifier = FakeNotifier();
    state = MemoryNewMailStateStore();
    check = NewMailCheck(notifier: notifier, state: state);
  });

  test('notifies about new mail, with a summary per account', () async {
    mail.deliver('work', at(-30), subject: 'Before');
    await check.run(mail, settings, since: at(0));
    expect(notifier.posted, isEmpty, reason: 'the first check only sets the watermarks');

    mail
      ..deliver('work', at(3), subject: 'W1')
      ..deliver('work', at(4), subject: 'W2')
      ..deliver('home', at(5), subject: 'H1');
    final found = await check.run(mail, settings, since: at(15));
    expect(found, hasLength(3));
    expect(notifier.messageBodies, unorderedEquals(['W1', 'W2', 'H1']));
    expect(notifier.summaryOf('work')!.title, '2 new messages');
    expect(notifier.summaryOf('home')!.title, '1 new message');
    expect(state.state.lastCheck, at(15));

    // Nothing new: nothing posted again.
    final before = notifier.posted.where((n) => !n.isSummary).length;
    await check.run(mail, settings, since: at(30));
    expect(notifier.posted.where((n) => !n.isSummary), hasLength(before));
  });

  test('a silent run only moves the watermarks (the app was open)', () async {
    await check.run(mail, settings, since: at(0));
    mail.deliver('work', at(3), subject: 'Seen in the app');
    await check.run(mail, settings, silent: true, since: at(10));
    expect(notifier.posted, isEmpty);
    await check.run(mail, settings, since: at(20));
    expect(notifier.posted, isEmpty, reason: 'not announced later either');
  });

  test('muted accounts and VIP Only still move the watermarks', () async {
    await check.run(mail, settings, since: at(0));
    mail
      ..deliver('work', at(3), subject: 'Muted')
      ..deliver('home', at(4), subject: 'Ordinary');
    await check.run(mail, const NotificationSettings(mutedAccounts: {'work'}, vipOnly: true), since: at(10));
    expect(notifier.posted, isEmpty);
    await check.run(mail, settings, since: at(20));
    expect(notifier.posted, isEmpty, reason: 'muted mail doesn’t pile up for later');
  });

  test('tidying removes notifications of mail read or moved elsewhere, and their summary', () async {
    await check.run(mail, settings, since: at(0));
    final read = mail.deliver('work', at(1), subject: 'Read on the laptop');
    final moved = mail.deliver('work', at(2), subject: 'Filed on the laptop');
    final kept = mail.deliver('home', at(3), subject: 'Still new');
    await check.run(mail, settings, since: at(10));
    expect(notifier.messageBodies, hasLength(3));

    await mail.setKeywords([read.id], add: {Keywords.seen});
    mail.emails.remove(moved.id);
    await check.tidy(mail, settings);
    expect(notifier.messageBodies, ['Still new']);
    expect(notifier.summaryOf('work'), isNull);
    expect(notifier.summaryOf('home')!.title, '1 new message');
    expect(notifier.cancelled, containsAll([messageNotificationId(read.id), messageNotificationId(moved.id)]));
    expect(notifier.showing.containsKey(messageNotificationId(kept.id)), isTrue);

    // Muting an account clears what it shows.
    await check.tidy(mail, const NotificationSettings(mutedAccounts: {'home'}));
    expect(notifier.showing, isEmpty);
  });

  test('archivable accounts: an Archive folder, or All Mail on Gmail', () {
    final accounts = [
      for (final (id, provider) in const [
        ('a', ProviderKind.generic),
        ('g', ProviderKind.gmail),
        ('n', ProviderKind.generic),
      ])
        MailAccount(
          id: id,
          email: '$id@example.com',
          displayName: id,
          provider: provider,
          authKind: AuthKind.password,
          incoming: const ServerConfig(protocol: ServerProtocol.imap, host: 'h', port: 993),
        ),
    ];
    Mailbox box(String account, String path, MailboxRole role) =>
        Mailbox(id: MailIds.mailbox(account, path), accountId: account, name: path, path: path, role: role);
    final mailboxes = [
      box('a', 'Archive', MailboxRole.archive),
      box('g', '[Gmail]/All Mail', MailboxRole.all),
      box('n', 'All', MailboxRole.all),
    ];
    expect(archivableAccounts(accounts, mailboxes), {'a', 'g'});
  });
}
