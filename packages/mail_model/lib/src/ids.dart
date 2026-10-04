/// Deterministic local ids, derived from server identities, so transports can
/// produce final ids and the store needs no mapping table.
///
/// Mailbox: `<accountId>|<encoded path>`
/// IMAP email: `<accountId>|<encoded path>|<uidValidity>|<uid>`
/// JMAP email: `<accountId>|jmap|<jmap email id>`
abstract final class MailIds {
  static const _sep = '|';

  static String mailbox(String accountId, String path) => '$accountId$_sep${Uri.encodeComponent(path)}';

  static String imapEmail(String accountId, String path, int uidValidity, int uid) =>
      '$accountId$_sep${Uri.encodeComponent(path)}$_sep$uidValidity$_sep$uid';

  static String jmapEmail(String accountId, String jmapId) =>
      '$accountId${_sep}jmap$_sep${Uri.encodeComponent(jmapId)}';

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

  /// The mailbox id an IMAP email id belongs to.
  static String? mailboxOfImapEmail(String emailId) {
    final p = parseImapEmail(emailId);
    return p == null ? null : mailbox(p.accountId, p.path);
  }
}
