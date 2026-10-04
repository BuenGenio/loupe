/// What a ManageSieve server offers, and the session interface the rules
/// code works against (the real client, or the simulated server).
library;

import 'package:mail_model/mail_model.dart';

/// A ManageSieve server's capabilities (RFC 5804, section 1.7).
final class SieveCapabilities {
  const SieveCapabilities({
    this.implementation,
    this.extensions = const {},
    this.sasl = const {},
    this.startTls = false,
    this.version,
    this.maxRedirects,
    this.raw = const {},
  });

  /// From the capability lines (`"SIEVE" "fileinto …"`), names upper-cased.
  factory SieveCapabilities.parse(Map<String, String?> raw) {
    List<String> words(String key) => (raw[key] ?? '').split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    return SieveCapabilities(
      implementation: raw['IMPLEMENTATION'],
      extensions: {for (final w in words('SIEVE')) w.toLowerCase()},
      sasl: {for (final w in words('SASL')) w.toUpperCase()},
      startTls: raw.containsKey('STARTTLS'),
      version: raw['VERSION'],
      maxRedirects: int.tryParse(raw['MAXREDIRECTS'] ?? ''),
      raw: raw,
    );
  }

  /// The server software, e.g. "Dovecot Pigeonhole".
  final String? implementation;

  /// Sieve extensions, lower-cased (`fileinto`, `imap4flags`, `body`, …).
  final Set<String> extensions;

  /// SASL mechanisms, upper-cased (`PLAIN`, `XOAUTH2`, …).
  final Set<String> sasl;
  final bool startTls;

  /// "1.0" for servers with CHECKSCRIPT and HAVESPACE's later fixes.
  final String? version;
  final int? maxRedirects;
  final Map<String, String?> raw;
}

/// A script on the server.
final class SieveScriptInfo {
  const SieveScriptInfo(this.name, {this.active = false});
  final String name;
  final bool active;

  @override
  bool operator ==(Object other) => other is SieveScriptInfo && other.name == name && other.active == active;

  @override
  int get hashCode => Object.hash(name, active);

  @override
  String toString() => 'SieveScriptInfo($name${active ? ', active' : ''})';
}

/// A `NO` from a ManageSieve server; [message] is the server's own text
/// (CHECKSCRIPT errors with line numbers, quota messages), shown as is.
final class SieveException extends MailException {
  const SieveException(String message, {this.code, MailErrorKind kind = MailErrorKind.server}) : super(kind, message);

  /// The response code, e.g. `QUOTA/MAXSIZE`, `NONEXISTENT`, `ACTIVE`.
  final String? code;
}

/// A logged-in ManageSieve session. Not safe for concurrent use: one
/// command at a time.
abstract interface class SieveSession {
  SieveCapabilities get capabilities;

  Future<List<SieveScriptInfo>> listScripts();

  /// The script [name]; throws [SieveException] (code `NONEXISTENT`) if
  /// there is none.
  Future<String> getScript(String name);

  /// CHECKSCRIPT: throws [SieveException] with the server's errors; returns
  /// its warnings, if any.
  Future<String?> checkScript(String script);

  /// PUTSCRIPT: stores (or replaces) the script [name].
  Future<void> putScript(String name, String script);

  /// SETACTIVE; an empty [name] deactivates every script.
  Future<void> setActive(String name);

  /// HAVESPACE: whether a script of [size] bytes named [name] fits.
  Future<bool> haveSpace(String name, int size);

  Future<void> deleteScript(String name);

  /// Says LOGOUT (best effort) and closes the connection.
  Future<void> logout();
}

/// Opens ManageSieve sessions.
abstract interface class SieveConnector {
  /// Connects to [account]'s ManageSieve server and logs in with
  /// [credentials]. Throws [MailException]: `unsupported` when there is no
  /// ManageSieve, `connection`, `certificate` or `authentication`.
  Future<SieveSession> connect(MailAccount account, CredentialsCallback credentials);
}
