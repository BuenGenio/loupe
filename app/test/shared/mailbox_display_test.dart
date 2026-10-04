import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/shared/format.dart';
import 'package:loupe/shared/mailbox_display.dart';
import 'package:mail_model/mail_model.dart';

Mailbox box(String path, {MailboxRole role = MailboxRole.none, String account = 'a', bool subscribed = true}) {
  final cut = path.lastIndexOf('/');
  return Mailbox(
    id: MailIds.mailbox(account, path),
    accountId: account,
    name: path.split('/').last,
    path: path,
    role: role,
    parentId: cut < 0 ? null : MailIds.mailbox(account, path.substring(0, cut)),
    isSubscribed: subscribed,
  );
}

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

  test('subscribed folders, roles, and containers on the way to subscribed subfolders', () {
    final boxes = subscribedFolders([
      box('INBOX', role: MailboxRole.inbox, subscribed: false),
      box('Old', subscribed: false),
      box('Old/Mid', subscribed: false),
      box('Old/Mid/Taxes'),
      box('Old/Other', subscribed: false),
      box('Lists'),
      box('Lists/Retired', subscribed: false),
      box('Spam', role: MailboxRole.junk, subscribed: false),
    ]);
    expect(
      {for (final b in boxes) b.path: b.isSelectable},
      {'INBOX': true, 'Old': false, 'Old/Mid': false, 'Old/Mid/Taxes': true, 'Lists': true, 'Spam': true},
    );
    final tree = mailboxTree(boxes, expanded: {MailIds.mailbox('a', 'Old'), MailIds.mailbox('a', 'Old/Mid')});
    expect(
      [for (final n in tree) '${n.mailbox.path}@${n.depth}'],
      ['INBOX@0', 'Spam@0', 'Lists@0', 'Old@0', 'Old/Mid@1', 'Old/Mid/Taxes@2'],
    );

    final all = [box('INBOX', role: MailboxRole.inbox), box('Work')];
    expect(identical(subscribedFolders(all), all), isTrue);
  });

  test('counts have grouping separators; deep folders stop indenting', () {
    expect(formatCount(35722), '35,722');
    expect(formatCount(300), '300');
    expect(folderIndent(2), 36);
    expect(folderIndent(12), folderIndent(5));
  });
}
