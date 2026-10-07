/// Deterministic local ids, derived from server identities, so transports can
/// produce final ids and the store needs no mapping table.
///
/// Mailbox: `<accountId>|<encoded path>`
/// IMAP email: `<accountId>|<encoded path>|<uidValidity>|<uid>`
/// JMAP email in a mailbox: `<accountId>|<encoded path>|jmap|<encoded jmap email id>`
/// JMAP email without a mailbox (the demo): `<accountId>|jmap|<encoded jmap email id>`
///
/// A JMAP email can be in several mailboxes at once (Fastmail's labels, or a
/// message an IMAP client copied on the same server). The store keeps one row
/// per mailbox, as for IMAP folders and Gmail's labels, so mail_jmap names the
/// mailbox in the id ([jmapEmailIn]): like an IMAP id, it starts with its
/// mailbox's id ([mailboxOfEmail]), moving a copy gives it a new id, and the
/// copies of one email share their keywords on the server.
abstract final class MailIds {
  static const _sep = '|';
  static const _jmap = 'jmap';

  static String mailbox(String accountId, String path) => '$accountId$_sep${Uri.encodeComponent(path)}';

  static String imapEmail(String accountId, String path, int uidValidity, int uid) =>
      '$accountId$_sep${Uri.encodeComponent(path)}$_sep$uidValidity$_sep$uid';

  /// A JMAP email outside any mailbox (the demo's messages). Transports use
  /// [jmapEmailIn].
  static String jmapEmail(String accountId, String jmapId) =>
      '$accountId$_sep$_jmap$_sep${Uri.encodeComponent(jmapId)}';

  /// The copy of JMAP email [jmapId] in the mailbox at [path].
  static String jmapEmailIn(String accountId, String path, String jmapId) =>
      '$accountId$_sep${Uri.encodeComponent(path)}$_sep$_jmap$_sep${Uri.encodeComponent(jmapId)}';

  /// The account id of any mailbox or email id.
  static String accountOf(String id) => id.substring(0, id.indexOf(_sep));

  /// Parses a mailbox id into (accountId, path).
  static (String accountId, String path) parseMailbox(String mailboxId) {
    final parts = mailboxId.split(_sep);
    if (parts.length != 2) throw FormatException('Not a mailbox id', mailboxId);
    return (parts[0], Uri.decodeComponent(parts[1]));
  }

  /// Parses an IMAP email id; null if [emailId] is not one.
  static ({String accountId, String path, int uidValidity, int uid})? parseImapEmail(String emailId) {
    final parts = emailId.split(_sep);
    if (parts.length != 4) return null;
    final validity = int.tryParse(parts[2]);
    final uid = int.tryParse(parts[3]);
    if (validity == null || uid == null) return null;
    return (accountId: parts[0], path: Uri.decodeComponent(parts[1]), uidValidity: validity, uid: uid);
  }

  /// Parses a JMAP email id made by [jmapEmailIn]; null if [emailId] is not
  /// one.
  static ({String accountId, String path, String jmapId})? parseJmapEmail(String emailId) {
    final parts = emailId.split(_sep);
    if (parts.length != 4 || parts[2] != _jmap || parts[3].isEmpty) return null;
    return (accountId: parts[0], path: Uri.decodeComponent(parts[1]), jmapId: Uri.decodeComponent(parts[3]));
  }

  /// The mailbox id an IMAP email id belongs to.
  static String? mailboxOfImapEmail(String emailId) {
    final p = parseImapEmail(emailId);
    return p == null ? null : mailbox(p.accountId, p.path);
  }

  /// The mailbox id of an IMAP email id or a JMAP one with a mailbox; null
  /// for other ids (local placeholders, the demo's).
  static String? mailboxOfEmail(String emailId) {
    if (parseImapEmail(emailId) case final p?) return mailbox(p.accountId, p.path);
    if (parseJmapEmail(emailId) case final p?) return mailbox(p.accountId, p.path);
    return null;
  }
}
