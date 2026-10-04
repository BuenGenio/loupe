import 'package:flutter/cupertino.dart';
import 'package:mail_model/mail_model.dart';

/// Icon of a mailbox by role, as Apple Mail draws them.
IconData mailboxIcon(MailboxRole role) => switch (role) {
  MailboxRole.inbox => CupertinoIcons.tray,
  MailboxRole.drafts => CupertinoIcons.doc,
  MailboxRole.sent => CupertinoIcons.paperplane,
  MailboxRole.junk => CupertinoIcons.bin_xmark,
  MailboxRole.trash => CupertinoIcons.trash,
  MailboxRole.archive => CupertinoIcons.archivebox,
  MailboxRole.all => CupertinoIcons.tray_full,
  MailboxRole.flagged => CupertinoIcons.flag,
  MailboxRole.important => CupertinoIcons.exclamationmark_circle,
  MailboxRole.outbox => CupertinoIcons.tray_arrow_up,
  MailboxRole.none => CupertinoIcons.folder,
};

String virtualMailboxTitle(VirtualMailbox kind) => switch (kind) {
  VirtualMailbox.allInboxes => 'All Inboxes',
  VirtualMailbox.unread => 'Unread',
  VirtualMailbox.flagged => 'Flagged',
  VirtualMailbox.vip => 'VIP',
  VirtualMailbox.allDrafts => 'All Drafts',
  VirtualMailbox.allSent => 'All Sent',
};

IconData virtualMailboxIcon(VirtualMailbox kind) => switch (kind) {
  VirtualMailbox.allInboxes => CupertinoIcons.tray_2,
  VirtualMailbox.unread => CupertinoIcons.envelope_badge,
  VirtualMailbox.flagged => CupertinoIcons.flag,
  VirtualMailbox.vip => CupertinoIcons.star,
  VirtualMailbox.allDrafts => CupertinoIcons.doc_on_doc,
  VirtualMailbox.allSent => CupertinoIcons.paperplane,
};

/// Sort key that puts special mailboxes first, in Apple Mail's order.
int mailboxRoleOrder(MailboxRole role) => switch (role) {
  MailboxRole.inbox => 0,
  MailboxRole.drafts => 1,
  MailboxRole.sent => 2,
  MailboxRole.junk => 3,
  MailboxRole.trash => 4,
  MailboxRole.archive => 5,
  MailboxRole.all => 6,
  MailboxRole.flagged => 7,
  MailboxRole.important => 8,
  MailboxRole.outbox => 9,
  MailboxRole.none => 10,
};

/// Display name of a mailbox: role mailboxes get their familiar names
/// ("Sent Mail" and "Sent Items" are both "Sent").
String mailboxDisplayName(Mailbox box) => switch (box.role) {
  MailboxRole.inbox => 'Inbox',
  MailboxRole.drafts => 'Drafts',
  MailboxRole.sent => 'Sent',
  MailboxRole.junk => 'Junk',
  MailboxRole.trash => 'Trash',
  MailboxRole.archive => 'Archive',
  MailboxRole.all => box.name,
  _ => box.name,
};

/// The title of a message list.
String mailboxRefTitle(MailboxRef ref, Iterable<Mailbox> mailboxes) => switch (ref) {
  VirtualMailboxRef(:final kind) => virtualMailboxTitle(kind),
  RealMailboxRef(:final mailboxId) =>
    mailboxes.where((m) => m.id == mailboxId).map(mailboxDisplayName).firstOrNull ?? 'Mailbox',
};

/// A mailbox with its depth in the account's folder tree.
typedef MailboxNode = ({Mailbox mailbox, int depth, bool hasChildren});

/// The folder tree of one account, flattened in display order: special
/// mailboxes first (pulled out of containers like Gmail's `[Gmail]`), then
/// the user's folders alphabetically with their subfolders. Containers left
/// without visible children are dropped. Collapsed folders hide their
/// subtrees unless [expanded] contains them.
List<MailboxNode> mailboxTree(List<Mailbox> mailboxes, {Set<String>? expanded}) {
  final special = mailboxes.where((m) => m.role != MailboxRole.none).toList()
    ..sort((a, b) => mailboxRoleOrder(a.role).compareTo(mailboxRoleOrder(b.role)));
  final regular = mailboxes.where((m) => m.role == MailboxRole.none).toList();
  final children = <String?, List<Mailbox>>{};
  final ids = {for (final m in regular) m.id};
  for (final m in regular) {
    final parent = ids.contains(m.parentId) ? m.parentId : null;
    children.putIfAbsent(parent, () => []).add(m);
  }
  for (final list in children.values) {
    list.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }
  final out = <MailboxNode>[for (final m in special) (mailbox: m, depth: 0, hasChildren: false)];
  void walk(String? parent, int depth) {
    for (final m in children[parent] ?? const <Mailbox>[]) {
      final kids = children[m.id] ?? const <Mailbox>[];
      if (!m.isSelectable && kids.isEmpty) continue;
      out.add((mailbox: m, depth: depth, hasChildren: kids.isNotEmpty));
      if (kids.isNotEmpty && (expanded == null || expanded.contains(m.id))) walk(m.id, depth + 1);
    }
  }

  walk(null, 0);
  return out;
}
