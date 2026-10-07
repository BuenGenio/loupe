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

  test('JMAP email ids name their mailbox and never parse as IMAP ids', () {
    final id = MailIds.jmapEmailIn('acc1', 'Archive/2024|x', 'M123');
    expect(MailIds.accountOf(id), 'acc1');
    expect(MailIds.parseJmapEmail(id), (accountId: 'acc1', path: 'Archive/2024|x', jmapId: 'M123'));
    expect(MailIds.parseImapEmail(id), isNull);
    expect(MailIds.mailboxOfEmail(id), MailIds.mailbox('acc1', 'Archive/2024|x'));
    expect(id.startsWith('${MailIds.mailbox('acc1', 'Archive/2024|x')}|'), isTrue);
    // Numeric JMAP ids too.
    final numeric = MailIds.jmapEmailIn('acc1', '7', '42');
    expect(MailIds.parseImapEmail(numeric), isNull);
    expect(MailIds.parseJmapEmail(numeric)?.jmapId, '42');
    // IMAP ids, the demo's mailbox-less JMAP ids and mailboxes.
    final imap = MailIds.imapEmail('acc1', 'INBOX', 1, 2);
    expect(MailIds.parseJmapEmail(imap), isNull);
    expect(MailIds.mailboxOfEmail(imap), MailIds.mailbox('acc1', 'INBOX'));
    expect(MailIds.parseJmapEmail(MailIds.jmapEmail('acc1', 'M1')), isNull);
    expect(MailIds.mailboxOfEmail(MailIds.jmapEmail('acc1', 'M1')), isNull);
    expect(MailIds.parseJmapEmail(MailIds.mailbox('acc1', 'jmap')), isNull);
  });

  test('addresses format with quoting', () {
    expect(const EmailAddress('a@b.c', 'Doe, Jane').toString(), '"Doe, Jane" <a@b.c>');
    expect(const EmailAddress('jane@b.c').displayName, 'jane');
  });
}
