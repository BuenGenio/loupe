import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/shared/format.dart';
import 'package:loupe/shared/mailbox_display.dart';
import 'package:mail_model/mail_model.dart';

Mailbox box(String path, {MailboxRole role = MailboxRole.none, String account = 'a'}) =>
    Mailbox(id: MailIds.mailbox(account, path), accountId: account, name: path.split('/').last, path: path, role: role);

void main() {
  test('only one mailbox per account shows a role name', () {
    final boxes = withUniqueRoles([
      box('INBOX', role: MailboxRole.inbox),
      box('Archives', role: MailboxRole.archive),
      box('Archive', role: MailboxRole.archive),
      box('Archive', role: MailboxRole.archive, account: 'b'),
      box('Projects'),
    ]);
    expect(boxes.map(mailboxDisplayName), ['Inbox', 'Archives', 'Archive', 'Archive', 'Projects']);
    expect(boxes.map((b) => b.role), [
      MailboxRole.inbox,
      MailboxRole.none,
      MailboxRole.archive,
      MailboxRole.archive,
      MailboxRole.none,
    ]);
  });

  test('without duplicates the list is returned as is', () {
    final boxes = [box('INBOX', role: MailboxRole.inbox), box('Sent Items', role: MailboxRole.sent)];
    expect(identical(withUniqueRoles(boxes), boxes), isTrue);
    expect(boxes.map(mailboxDisplayName), ['Inbox', 'Sent']);
  });

  test('counts have grouping separators; deep folders stop indenting', () {
    expect(formatCount(35722), '35,722');
    expect(formatCount(300), '300');
    expect(folderIndent(2), 36);
    expect(folderIndent(12), folderIndent(5));
  });
}
