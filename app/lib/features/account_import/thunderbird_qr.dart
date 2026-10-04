/// Reader for Thunderbird desktop's "Export for Mobile" QR codes (format
/// version 1). See docs/thunderbird-qr-format.md for the format.
///
/// Payloads come from a camera or the clipboard, so every value is checked:
/// types, ranges, lengths, hostnames, addresses and control characters.
/// Passwords never appear in exception messages or `toString()`.
library;

import 'dart:convert';

/// Bounds for untrusted payloads.
abstract final class TbQrLimits {
  /// A version 40 QR code holds at most 2953 bytes; Thunderbird aims for 800.
  static const payloadLength = 4096;

  /// Codes in one export (Thunderbird puts three accounts in each).
  static const codes = 50;
  static const accountsPerCode = 20;
  static const outgoingGroups = 10;
  static const identitiesPerGroup = 20;
  static const hostLength = 253;
  static const emailLength = 254;
  static const textLength = 256;
  static const passwordLength = 1024;
}

enum TbIncomingProtocol { imap, pop3 }

enum TbSecurity { plain, startTls, tls }

enum TbAuth { none, passwordCleartext, passwordEncrypted, gssapi, ntlm, tlsCertificate, oauth2 }

/// An incoming or outgoing server as Thunderbird exported it.
final class TbServer {
  const TbServer({
    required this.host,
    required this.port,
    required this.security,
    required this.auth,
    required this.username,
    this.password,
  });

  /// Lower-case ASCII hostname or IP address.
  final String host;
  final int port;
  final TbSecurity security;
  final TbAuth auth;

  /// May be empty.
  final String username;

  /// Null when the export left it out (or it was empty).
  final String? password;

  @override
  String toString() =>
      'TbServer($host:$port, ${security.name}, ${auth.name}, password: ${password == null ? 'none' : 'redacted'})';
}

final class TbIdentity {
  const TbIdentity({required this.email, required this.displayName});

  final String email;

  /// May be empty.
  final String displayName;

  @override
  String toString() => 'TbIdentity($email)';
}

/// One account: incoming server, the first readable outgoing server and its
/// identities.
final class TbAccount {
  const TbAccount({
    required this.protocol,
    required this.incoming,
    required this.outgoing,
    required this.identities,
    required this.name,
  });

  final TbIncomingProtocol protocol;
  final TbServer incoming;
  final TbServer outgoing;

  /// Never empty; the first is the account's address.
  final List<TbIdentity> identities;

  /// Thunderbird's account name, or the first identity's address.
  final String name;

  String get email => identities.first.email;

  @override
  String toString() => 'TbAccount($email, ${protocol.name}, $incoming, $outgoing)';
}

/// One scanned code: part [part] of [total], and the accounts in it.
final class TbQrCode {
  const TbQrCode({required this.part, required this.total, required this.accounts, this.skipped = 0});

  /// 1-based.
  final int part;
  final int total;
  final List<TbAccount> accounts;

  /// Accounts left out because a value was invalid or unknown (a newer
  /// Thunderbird, or a damaged code).
  final int skipped;
}

/// Why a payload can't be read. [message] is for people and never contains
/// payload data.
final class TbQrFormatException implements Exception {
  const TbQrFormatException(this.message);

  static const notThunderbird = TbQrFormatException("This isn't a Thunderbird account code.");
  static const newerVersion = TbQrFormatException(
    'This code comes from a newer Thunderbird. Update Loupe to import it.',
  );
  static const damaged = TbQrFormatException("This Thunderbird code couldn't be read.");
  static const tooLarge = TbQrFormatException('This code is too large to be a Thunderbird export.');

  final String message;

  @override
  String toString() => 'TbQrFormatException: $message';
}

/// Parses one "Export for Mobile" payload.
///
/// Throws [TbQrFormatException] when the payload as a whole is unusable.
/// Accounts with invalid or unknown values are left out and counted in
/// [TbQrCode.skipped]; following the format, so are outgoing servers and
/// identities that can't be read.
TbQrCode parseThunderbirdQr(String text) {
  final source = normalizeScannedText(text);
  if (source.length > TbQrLimits.payloadLength) throw TbQrFormatException.tooLarge;
  if (!source.startsWith('[')) throw TbQrFormatException.notThunderbird;
  final Object? root;
  try {
    root = jsonDecode(source);
  } on FormatException {
    throw TbQrFormatException.notThunderbird;
  }
  if (root is! List || root.length < 2 || root[0] is! int) throw TbQrFormatException.notThunderbird;
  if (root[0] != 1) {
    throw (root[0] as int) > 1 ? TbQrFormatException.newerVersion : TbQrFormatException.notThunderbird;
  }

  final misc = root[1];
  if (misc is! List || misc.length < 2) throw TbQrFormatException.damaged;
  final (part, total) = (misc[0], misc[1]);
  if (part is! int || total is! int || total < 1 || total > TbQrLimits.codes || part < 1 || part > total) {
    throw TbQrFormatException.damaged;
  }

  // IncomingServer and OutgoingServerGroups come in pairs.
  final pairs = root.length - 2;
  if (pairs == 0 || pairs.isOdd) throw TbQrFormatException.damaged;
  if (pairs ~/ 2 > TbQrLimits.accountsPerCode) throw TbQrFormatException.tooLarge;

  final accounts = <TbAccount>[];
  var skipped = 0;
  for (var i = 2; i < root.length; i += 2) {
    final (incoming, groups) = (root[i], root[i + 1]);
    if (incoming is! List || groups is! List) throw TbQrFormatException.damaged;
    try {
      accounts.add(_account(incoming, groups));
    } on _Invalid {
      skipped++;
    }
  }
  return TbQrCode(part: part, total: total, accounts: List.unmodifiable(accounts), skipped: skipped);
}

/// Tidies scanned or pasted text: trims it, drops a byte-order mark and
/// repairs UTF-8 that a scanner decoded as Latin-1 (codes carry UTF-8
/// without saying so).
String normalizeScannedText(String raw) {
  var s = raw.trim();
  if (s.startsWith('\uFEFF')) s = s.substring(1).trimLeft();
  final units = s.codeUnits;
  if (units.any((c) => c >= 0x80) && units.every((c) => c <= 0xFF)) {
    try {
      s = utf8.decode(latin1.encode(s));
    } on FormatException {
      // Real Latin-1 text: keep it.
    }
  }
  return s;
}

// Reading ---------------------------------------------------------------------------

/// A value this reader can't accept; the enclosing element is skipped.
final class _Invalid implements Exception {
  const _Invalid();
}

const _invalid = _Invalid();

TbAccount _account(List<Object?> incoming, List<Object?> groups) {
  if (incoming.length < 6) throw _invalid;
  final protocol = switch (incoming[0]) {
    0 => TbIncomingProtocol.imap,
    1 => TbIncomingProtocol.pop3,
    _ => throw _invalid,
  };
  final server = _server(incoming, password: incoming.length > 7 ? _password(incoming[7]) : null);
  final accountName = incoming.length > 6 ? _optionalText(incoming[6]) : null;

  if (groups.isEmpty || groups.length > TbQrLimits.outgoingGroups) throw _invalid;
  // Loupe has one outgoing server per account: the first readable group's.
  for (final group in groups) {
    if (_group(group) case (:final outgoing, :final identities)) {
      return TbAccount(
        protocol: protocol,
        incoming: server,
        outgoing: outgoing,
        identities: List.unmodifiable(identities),
        name: accountName ?? identities.first.email,
      );
    }
  }
  throw _invalid;
}

/// An OutgoingServerGroup, or null when its server or every identity is unreadable.
({TbServer outgoing, List<TbIdentity> identities})? _group(Object? group) {
  if (group is! List || group.length < 2 || group.length > TbQrLimits.identitiesPerGroup + 1) return null;
  final server = group[0];
  if (server is! List || server.length < 6 || server[0] != 0) return null;
  final TbServer outgoing;
  try {
    outgoing = _server(server, password: server.length > 6 ? _password(server[6]) : null);
  } on _Invalid {
    return null;
  }
  final identities = <TbIdentity>[];
  for (final identity in group.skip(1)) {
    try {
      if (identity is! List || identity.length < 2) throw _invalid;
      identities.add(TbIdentity(email: _email(identity[0]), displayName: _text(identity[1])));
    } on _Invalid {
      // Skipped, as the format asks.
    }
  }
  return identities.isEmpty ? null : (outgoing: outgoing, identities: identities);
}

/// Host, port, security, authentication and username: elements 1 to 5 of
/// an IncomingServer or OutgoingServer.
TbServer _server(List<Object?> a, {String? password}) => TbServer(
  host: _host(a[1]),
  port: _port(a[2]),
  security: switch (a[3]) {
    0 => TbSecurity.plain,
    // 1 is reserved (Thunderbird's old "STARTTLS when available"): never downgrade it to plain text.
    1 || 2 => TbSecurity.startTls,
    3 => TbSecurity.tls,
    _ => throw _invalid,
  },
  auth: switch (a[4]) {
    0 => TbAuth.none,
    1 => TbAuth.passwordCleartext,
    2 => TbAuth.passwordEncrypted,
    3 => TbAuth.gssapi,
    4 => TbAuth.ntlm,
    5 => TbAuth.tlsCertificate,
    6 => TbAuth.oauth2,
    _ => throw _invalid,
  },
  username: _text(a[5]),
  password: password,
);

int _port(Object? v) => v is int && v >= 1 && v <= 65535 ? v : throw _invalid;

/// C0 and C1 controls, line and paragraph separators, and bidirectional
/// overrides (which could disguise a name or address on screen).
final _unsafeText = RegExp(r'[\x00-\x1F\x7F-\x9F\u2028\u2029\u202A-\u202E\u2066-\u2069]');

String _text(Object? v, {int max = TbQrLimits.textLength}) =>
    v is String && v.length <= max && !_unsafeText.hasMatch(v) ? v : throw _invalid;

/// Null and the empty string both mean "not given".
String? _optionalText(Object? v) {
  if (v == null) return null;
  final s = _text(v);
  return s.isEmpty ? null : s;
}

final _passwordBreak = RegExp(r'[\x00\r\n]');

String? _password(Object? v) {
  if (v == null) return null;
  if (v is! String || v.length > TbQrLimits.passwordLength || _passwordBreak.hasMatch(v)) throw _invalid;
  return v.isEmpty ? null : v;
}

final _label = RegExp(r'^[a-z0-9_]([a-z0-9_-]{0,61}[a-z0-9_])?$');
final _ipv4 = RegExp(r'^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$');

/// An ASCII hostname (IDNs in their xn-- form) or an IP address, lower-cased.
String _host(Object? v) {
  if (v is! String || v.isEmpty || v.length > TbQrLimits.hostLength) throw _invalid;
  final host = v.toLowerCase();
  if (host.contains(':') || host.startsWith('[')) {
    final bare = host.startsWith('[') && host.endsWith(']') ? host.substring(1, host.length - 1) : host;
    try {
      Uri.parseIPv6Address(bare);
      return bare;
    } on FormatException {
      throw _invalid;
    }
  }
  if (_ipv4.firstMatch(host) case final m?) {
    for (var i = 1; i <= 4; i++) {
      if (int.parse(m[i]!) > 255) throw _invalid;
    }
    return host;
  }
  final name = host.endsWith('.') ? host.substring(0, host.length - 1) : host;
  final labels = name.split('.');
  if (labels.every((l) => _label.hasMatch(l)) && !RegExp(r'^[0-9.]+$').hasMatch(name)) return name;
  throw _invalid;
}

final _localPart = RegExp(r"^[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*$");

/// An ASCII address with a dot-atom local part and a hostname domain.
String _email(Object? v) {
  if (v is! String || v.length > TbQrLimits.emailLength) throw _invalid;
  final at = v.lastIndexOf('@');
  if (at < 1 || at > 64 || at == v.length - 1) throw _invalid;
  final local = v.substring(0, at);
  if (!_localPart.hasMatch(local)) throw _invalid;
  final domain = _host(v.substring(at + 1));
  if (domain.contains(':') || _ipv4.hasMatch(domain)) throw _invalid;
  return '$local@$domain';
}
