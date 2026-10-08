import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:mail_model/mail_model.dart';

import '../l10n/l10n.dart';
import '../theme/loupe_icons.dart';

/// Icon of a mailbox by role, as Apple Mail draws them.
IconData mailboxIcon(MailboxRole role) => switch (role) {
  MailboxRole.inbox => LoupeIcons.inbox,
  MailboxRole.drafts => LoupeIcons.drafts,
  MailboxRole.sent => LoupeIcons.sent,
  MailboxRole.junk => LoupeIcons.junk,
  MailboxRole.trash => LoupeIcons.trash,
  MailboxRole.archive => LoupeIcons.archive,
  MailboxRole.all => LoupeIcons.allMail,
  MailboxRole.flagged => LoupeIcons.flagged,
  MailboxRole.important => LoupeIcons.important,
  MailboxRole.outbox => LoupeIcons.outbox,
  MailboxRole.none => LoupeIcons.folder,
};

/// The title of a unified mailbox, in [l10n]'s language (else the device's).
String virtualMailboxTitle(VirtualMailbox kind, {AppLocalizations? l10n}) {
  final strings = l10n ?? deviceL10n();
  return switch (kind) {
    VirtualMailbox.allInboxes => strings.sharedMailboxAllInboxes,
    VirtualMailbox.unread => strings.sharedMailboxUnread,
    VirtualMailbox.flagged => strings.sharedMailboxFlagged,
    VirtualMailbox.vip => strings.sharedMailboxVip,
    VirtualMailbox.allDrafts => strings.sharedMailboxAllDrafts,
    VirtualMailbox.allSent => strings.sharedMailboxAllSent,
  };
}

IconData virtualMailboxIcon(VirtualMailbox kind) => switch (kind) {
  VirtualMailbox.allInboxes => LoupeIcons.allInboxes,
  VirtualMailbox.unread => LoupeIcons.unread,
  VirtualMailbox.flagged => LoupeIcons.flagged,
  VirtualMailbox.vip => LoupeIcons.vip,
  VirtualMailbox.allDrafts => LoupeIcons.drafts,
  VirtualMailbox.allSent => LoupeIcons.sent,
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

/// [mailboxes] with each role held by at most one mailbox per account; the
/// others become plain folders ([MailboxRole.none]) and show their real
/// names. The transports already assign roles that way; this keeps a stale
/// or odd mailbox list from showing two "Archive" folders. The holder is the
/// mailbox named like the role, else the one with the shortest path.
List<Mailbox> withUniqueRoles(List<Mailbox> mailboxes) {
  final holders = <(String, MailboxRole), Mailbox>{};
  int rank(Mailbox m) => (_roleName(m.role) ?? m.name).toLowerCase() == m.name.toLowerCase() ? 0 : 1;
  for (final m in mailboxes) {
    if (m.role == MailboxRole.none) continue;
    final key = (m.accountId, m.role);
    final held = holders[key];
    if (held == null || rank(m) < rank(held) || (rank(m) == rank(held) && m.path.length < held.path.length)) {
      holders[key] = m;
    }
  }
  if (holders.length == mailboxes.where((m) => m.role != MailboxRole.none).length) return mailboxes;
  return [
    for (final m in mailboxes)
      if (m.role == MailboxRole.none || identical(holders[(m.accountId, m.role)], m))
        m
      else
        m.copyWith(role: MailboxRole.none),
  ];
}

/// The English name of the folder holding [role], as servers usually name
/// it; null for roles shown by their own name.
String? _roleName(MailboxRole role) => switch (role) {
  MailboxRole.inbox => 'Inbox',
  MailboxRole.drafts => 'Drafts',
  MailboxRole.sent => 'Sent',
  MailboxRole.junk => 'Junk',
  MailboxRole.trash => 'Trash',
  MailboxRole.archive => 'Archive',
  _ => null,
};

/// Display name of a mailbox: the mailbox holding a role gets its familiar
/// name ("Sent Mail" and "Sent Items" are both "Sent"), in [l10n]'s language
/// (else the device's); see [withUniqueRoles] for why only one per account
/// does.
String mailboxDisplayName(Mailbox box, {AppLocalizations? l10n}) {
  if (_roleName(box.role) == null) return box.name;
  final strings = l10n ?? deviceL10n();
  return switch (box.role) {
    MailboxRole.inbox => strings.mailboxInbox,
    MailboxRole.drafts => strings.mailboxDrafts,
    MailboxRole.sent => strings.mailboxSent,
    MailboxRole.junk => strings.mailboxJunk,
    MailboxRole.trash => strings.mailboxTrash,
    MailboxRole.archive => strings.mailboxArchive,
    _ => box.name,
  };
}

/// The title of a message list.
String mailboxRefTitle(MailboxRef ref, Iterable<Mailbox> mailboxes, {AppLocalizations? l10n}) {
  final strings = l10n ?? deviceL10n();
  return switch (ref) {
    VirtualMailboxRef(:final kind) => virtualMailboxTitle(kind, l10n: strings),
    RealMailboxRef(:final mailboxId) =>
      mailboxes.where((m) => m.id == mailboxId).map((m) => mailboxDisplayName(m, l10n: strings)).firstOrNull ??
          strings.sharedMailboxUntitled,
  };
}

/// The folders the Mailboxes screen shows, like Thunderbird: subscribed
/// ones and those holding a role (Inbox, Sent…). An unsubscribed folder on
/// the way to a subscribed one stays as a container (not selectable), so
/// the subfolder can be reached.
List<Mailbox> subscribedFolders(List<Mailbox> mailboxes) {
  final byId = {for (final m in mailboxes) m.id: m};
  final shown = {
    for (final m in mailboxes)
      if (m.isSubscribed || m.role != MailboxRole.none) m.id,
  };
  final containers = <String>{};
  for (final m in mailboxes) {
    // Role mailboxes are pulled to the top of the tree; they need no parents.
    if (!m.isSubscribed || m.role != MailboxRole.none) continue;
    var parent = byId[m.parentId];
    // Stops at a shown parent or one another subfolder already walked from.
    while (parent != null && !shown.contains(parent.id) && containers.add(parent.id)) {
      parent = byId[parent.parentId];
    }
  }
  if (shown.length == mailboxes.length) return mailboxes;
  return [
    for (final m in mailboxes)
      if (shown.contains(m.id)) m else if (containers.contains(m.id)) m.copyWith(isSelectable: false),
  ];
}

/// Leading indentation of a folder at [depth] in a tree. Deep trees stop
/// indenting after a few levels, so names keep room on a phone.
double folderIndent(int depth) => 18.0 * math.min(depth, 5);

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
