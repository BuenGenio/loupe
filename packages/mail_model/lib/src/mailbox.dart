/// The special purpose of a mailbox (IMAP SPECIAL-USE, JMAP roles).
enum MailboxRole { inbox, drafts, sent, junk, trash, archive, all, flagged, important, outbox, none }

/// A folder in an account.
final class Mailbox {
  const Mailbox({
    required this.id,
    required this.accountId,
    required this.name,
    required this.path,
    this.role = MailboxRole.none,
    this.parentId,
    this.unreadCount = 0,
    this.totalCount = 0,
    this.isSelectable = true,
    this.isSubscribed = true,
    this.sortOrder = 0,
  });

  /// Stable local id, unique across accounts.
  final String id;
  final String accountId;

  /// Last path segment, decoded, for display ("Receipts").
  final String name;

  /// Full server path ("INBOX/Receipts"); opaque for JMAP.
  final String path;
  final MailboxRole role;
  final String? parentId;
  final int unreadCount;
  final int totalCount;

  /// False for IMAP \Noselect containers.
  final bool isSelectable;

  /// Subscribed on the server (IMAP LSUB / `\Subscribed`). Like Thunderbird,
  /// the app shows and syncs subscribed folders; mailboxes holding a role
  /// show regardless.
  final bool isSubscribed;
  final int sortOrder;

  Mailbox copyWith({
    int? unreadCount,
    int? totalCount,
    String? name,
    MailboxRole? role,
    bool? isSelectable,
    bool? isSubscribed,
  }) => Mailbox(
    id: id,
    accountId: accountId,
    name: name ?? this.name,
    path: path,
    role: role ?? this.role,
    parentId: parentId,
    unreadCount: unreadCount ?? this.unreadCount,
    totalCount: totalCount ?? this.totalCount,
    isSelectable: isSelectable ?? this.isSelectable,
    isSubscribed: isSubscribed ?? this.isSubscribed,
    sortOrder: sortOrder,
  );

  @override
  bool operator ==(Object other) => other is Mailbox && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Mailboxes that span accounts (the top of the Mailboxes screen).
enum VirtualMailbox { allInboxes, unread, flagged, vip, allDrafts, allSent }

/// What a message list shows: one real mailbox or a virtual one.
sealed class MailboxRef {
  const MailboxRef();
}

final class RealMailboxRef extends MailboxRef {
  const RealMailboxRef(this.mailboxId);
  final String mailboxId;

  @override
  bool operator ==(Object other) => other is RealMailboxRef && other.mailboxId == mailboxId;

  @override
  int get hashCode => mailboxId.hashCode;
}

final class VirtualMailboxRef extends MailboxRef {
  const VirtualMailboxRef(this.kind);
  final VirtualMailbox kind;

  @override
  bool operator ==(Object other) => other is VirtualMailboxRef && other.kind == kind;

  @override
  int get hashCode => kind.hashCode;
}

/// Quick filters on a message list (the Filter button).
enum QuickFilter { unread, flagged, toMe, ccMe, hasAttachment, unreplied, fromVip }
