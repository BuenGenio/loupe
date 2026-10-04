import 'dart:convert';

/// Sample "Export for Mobile" payloads, built to the format in
/// docs/thunderbird-qr-format.md.

/// The format's first example: one IMAP account, no password.
const specSingleAccount =
    '[1,[1,1],[0,"imap.domain.example",993,3,1,"user@domain.example"],'
    '[[[0,"smtp.domain.example",465,3,1,"user@domain.example"],["user@domain.example","Jane Doe"]]]]';

/// The format's second example: part 1 of 2, an OAuth account and a
/// password account, empty passwords.
const specTwoAccounts =
    '[1,[1,2],'
    '[0,"imap.company.example",993,3,6,"user@company.example","user@company.example",""],'
    '[[[0,"smtp.company.example",465,3,6,"user@company.example",""],["user@company.example","Jane Doe"]]],'
    '[0,"imap.domain.example",993,3,1,"jane@domain.example","Jane (Personal)",""],'
    '[[[0,"smtp.domain.example",465,3,1,"jane@domain.example",""],["jane@domain.example","Jane"]]]]';

/// An IncomingServer array as Thunderbird desktop writes it (all eight
/// elements; the password is "" when not exported).
List<Object?> tbIncoming({
  Object? protocol = 0,
  Object? host = 'imap.example.com',
  Object? port = 993,
  Object? security = 3,
  Object? auth = 1,
  Object? username = 'jane@example.com',
  Object? name = 'jane@example.com',
  Object? password = '',
}) => [protocol, host, port, security, auth, username, name, password];

/// An account: its IncomingServer and OutgoingServerGroups.
List<Object?> tbAccount({
  List<Object?>? incoming,
  String smtpHost = 'smtp.example.com',
  int smtpPort = 465,
  int smtpSecurity = 3,
  int smtpAuth = 1,
  String outgoingPassword = '',
  List<List<Object?>> identities = const [
    ['jane@example.com', 'Jane Doe'],
  ],
}) => [
  incoming ?? tbIncoming(),
  [
    [
      [0, smtpHost, smtpPort, smtpSecurity, smtpAuth, 'jane@example.com', outgoingPassword],
      ...identities,
    ],
  ],
];

/// A whole payload: format version, sequence, then the accounts' pairs.
String tbPayload({int part = 1, int total = 1, required List<List<Object?>> accounts}) => jsonEncode([
  1,
  [part, total],
  for (final account in accounts) ...account,
]);
