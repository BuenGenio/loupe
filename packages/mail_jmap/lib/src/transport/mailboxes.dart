/// JMAP mailboxes as Loupe's [RemoteMailbox]es.
library;

import 'package:mail_model/mail_model.dart';

import '../client/request.dart';

/// Properties fetched for every mailbox.
const mailboxProperties = [
  'id',
  'name',
  'parentId',
  'role',
  'sortOrder',
  'isSubscribed',
  'totalEmails',
  'unreadEmails',
  'myRights',
];

/// One mailbox as the server described it.
final class JmapMailbox {
  const JmapMailbox({
    required this.id,
    required this.name,
    this.parentId,
    this.role,
    this.sortOrder = 0,
    this.isSubscribed = true,
    this.totalEmails = 0,
    this.unreadEmails = 0,
    this.mayReadItems = true,
  });

  factory JmapMailbox.fromJson(Json json) {
    final rights = json['myRights'];
    return JmapMailbox(
      id: json['id']! as String,
      name: json['name'] as String? ?? '',
      parentId: json['parentId'] as String?,
      role: json['role'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      isSubscribed: json['isSubscribed'] as bool? ?? true,
      totalEmails: (json['totalEmails'] as num?)?.toInt() ?? 0,
      unreadEmails: (json['unreadEmails'] as num?)?.toInt() ?? 0,
      mayReadItems: rights is Map ? rights['mayReadItems'] != false : true,
    );
  }

  final String id;
  final String name;
  final String? parentId;
  final String? role;
  final int sortOrder;
  final bool isSubscribed;
  final int totalEmails;
  final int unreadEmails;
  final bool mayReadItems;

  MailboxRole get mailboxRole => roleOf(role);
}

/// The [MailboxRole] of a JMAP role (RFC 8621 §2, the IANA IMAP Mailbox
/// Name Attributes registry, lower-cased).
MailboxRole roleOf(String? role) => switch (role?.toLowerCase()) {
  'inbox' => MailboxRole.inbox,
  'drafts' => MailboxRole.drafts,
  'sent' => MailboxRole.sent,
  'junk' => MailboxRole.junk,
  'trash' => MailboxRole.trash,
  'archive' => MailboxRole.archive,
  'all' => MailboxRole.all,
  'flagged' => MailboxRole.flagged,
  'important' => MailboxRole.important,
  _ => MailboxRole.none,
};

/// The account's mailboxes with their paths.
///
/// JMAP mailboxes have opaque ids and a parent, not paths. Loupe's mailbox
/// ids are made from paths ([MailIds.mailbox]), and the Snoozed folder,
/// the documents folder and Sieve's `fileinto` work with names, so a
/// mailbox's path is its name and its parents' names joined with `/` (the
/// hierarchy delimiter of Stalwart, Fastmail and Cyrus over IMAP): `Inbox`,
/// `Archive/2024`. Renaming a mailbox on the server makes it a new one
/// here, as over IMAP. Two mailboxes that would get the same path (a name
/// with a `/` in it) are told apart by the later one's id.
final class MailboxDirectory {
  MailboxDirectory(List<JmapMailbox> mailboxes, {this.state}) {
    final byId = {for (final m in mailboxes) m.id: m};
    final ordered = [...mailboxes]
      ..sort((a, b) {
        final c = a.sortOrder.compareTo(b.sortOrder);
        return c != 0 ? c : a.name.compareTo(b.name);
      });
    String pathOf(JmapMailbox m, Set<String> seen) {
      final known = _pathById[m.id];
      if (known != null) return known;
      final parent = byId[m.parentId];
      // A missing parent or a cycle: shown at the top level.
      final prefix = parent == null || !seen.add(parent.id) ? null : pathOf(parent, seen);
      var path = prefix == null ? m.name : '$prefix/${m.name}';
      if (_idByPath.containsKey(path)) path = '$path (${m.id})';
      _pathById[m.id] = path;
      _idByPath[path] = m.id;
      return path;
    }

    for (final m in ordered) {
      pathOf(m, {m.id});
    }
    for (final m in ordered) {
      _byId[m.id] = m;
    }
    // Stalwart makes no Archive mailbox; one the user made has no role.
    // Over IMAP Loupe recognises it by name, so here too.
    if (!_byId.values.any((m) => m.mailboxRole == MailboxRole.archive)) {
      for (final name in const ['archive', 'archives', 'archiv']) {
        final found = _byId.values
            .where((m) => m.parentId == null && m.role == null && m.name.toLowerCase() == name)
            .firstOrNull;
        if (found != null) {
          _archiveById = found.id;
          break;
        }
      }
    }
  }

  /// A top-level mailbox named Archive that holds the archive role when no
  /// mailbox has it.
  String? _archiveById;

  /// The `Mailbox` state the list is at.
  final String? state;

  final _byId = <String, JmapMailbox>{};
  final _pathById = <String, String>{};
  final _idByPath = <String, String>{};

  Iterable<JmapMailbox> get all => _byId.values;
  JmapMailbox? byId(String id) => _byId[id];
  String? pathOf(String id) => _pathById[id];
  String? idOf(String path) => _idByPath[path];

  /// The first mailbox with [role].
  JmapMailbox? withRole(MailboxRole role) {
    for (final m in _byId.values) {
      if (roleFor(m) == role) return m;
    }
    return null;
  }

  /// The role Loupe gives [m]: its JMAP role, or archive for a top-level
  /// mailbox named Archive when no mailbox has that role.
  MailboxRole roleFor(JmapMailbox m) => m.id == _archiveById ? MailboxRole.archive : m.mailboxRole;

  /// The list for the sync engine.
  List<RemoteMailbox> get remote => [
    for (final m in _byId.values)
      RemoteMailbox(
        path: _pathById[m.id]!,
        name: m.name,
        role: roleFor(m),
        parentPath: m.parentId == null ? null : _pathById[m.parentId!],
        isSelectable: m.mayReadItems,
        isSubscribed: m.isSubscribed,
      ),
  ];
}
