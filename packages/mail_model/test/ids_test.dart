import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

void main() {
  test('IMAP email ids round-trip, including separators in paths', () {
    final id = MailIds.imapEmail('acc1', 'INBOX/a|b', 42, 7);
    expect(MailIds.accountOf(id), 'acc1');
    expect(MailIds.parseImapEmail(id), (accountId: 'acc1', path: 'INBOX/a|b', uidValidity: 42, uid: 7));
    expect(MailIds.mailboxOfImapEmail(id), MailIds.mailbox('acc1', 'INBOX/a|b'));
    expect(MailIds.parseMailbox(MailIds.mailbox('acc1', 'INBOX/a|b')), ('acc1', 'INBOX/a|b'));
  });

  test('addresses format with quoting', () {
    expect(const EmailAddress('a@b.c', 'Doe, Jane').toString(), '"Doe, Jane" <a@b.c>');
    expect(const EmailAddress('jane@b.c').displayName, 'jane');
  });
}
