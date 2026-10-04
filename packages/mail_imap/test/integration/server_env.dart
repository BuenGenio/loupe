import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

/// Test server settings from the environment (see tool/test-servers/README.md).
final class TestServer {
  TestServer._(this.env);

  final Map<String, String> env;

  /// Null unless LOUPE_TEST_IMAP_HOST is set.
  static TestServer? fromEnvironment() {
    final env = Platform.environment;
    if ((env['LOUPE_TEST_IMAP_HOST'] ?? '').isEmpty) return null;
    return TestServer._(env);
  }

  String _get(String name, String fallback) {
    final v = env[name];
    return v == null || v.isEmpty ? fallback : v;
  }

  String get imapHost => env['LOUPE_TEST_IMAP_HOST']!;
  int get imapPort => int.parse(_get('LOUPE_TEST_IMAP_PORT', '143'));
  ConnectionSecurity get imapSecurity => ConnectionSecurity.values.byName(_get('LOUPE_TEST_IMAP_SECURITY', 'none'));
  String get smtpHost => _get('LOUPE_TEST_SMTP_HOST', imapHost);
  int get smtpPort => int.parse(_get('LOUPE_TEST_SMTP_PORT', '25'));
  ConnectionSecurity get smtpSecurity => ConnectionSecurity.values.byName(_get('LOUPE_TEST_SMTP_SECURITY', 'none'));
  String get user => _get('LOUPE_TEST_IMAP_USER', 'alice@example.test');
  String get user2 => _get('LOUPE_TEST_IMAP_USER2', 'bob@example.test');
  String get password => _get('LOUPE_TEST_IMAP_PASSWORD', 'secret');
  String? get trustedSha256 => env['LOUPE_TEST_IMAP_SHA256'];

  /// Whether SMTP tests should run (LOUPE_TEST_SMTP_PORT set).
  bool get hasSmtp => (env['LOUPE_TEST_SMTP_PORT'] ?? '').isNotEmpty;

  /// Implicit-TLS ports with an untrusted (self-signed) certificate, for the
  /// trust-on-first-use tests; null to skip them.
  int? get imapsPort => int.tryParse(env['LOUPE_TEST_IMAPS_PORT'] ?? '');
  int? get smtpsPort => int.tryParse(env['LOUPE_TEST_SMTPS_PORT'] ?? '');

  MailAccount account(String id, {String? email}) {
    final address = email ?? user;
    return MailAccount(
      id: id,
      email: address,
      displayName: id,
      provider: ProviderKind.generic,
      authKind: AuthKind.password,
      incoming: ServerConfig(
        protocol: ServerProtocol.imap,
        host: imapHost,
        port: imapPort,
        security: imapSecurity,
        trustedCertificateSha256: trustedSha256,
      ),
      outgoing: ServerConfig(
        protocol: ServerProtocol.smtp,
        host: smtpHost,
        port: smtpPort,
        security: smtpSecurity,
        trustedCertificateSha256: trustedSha256,
      ),
    );
  }

  Future<Credentials> credentials({bool forceRefresh = false}) async => PasswordCredentials(password);
}

/// A small RFC 822 message for seeding.
Uint8List seedMessage({required String subject, String from = 'seed@example.test', String body = 'Hello there'}) {
  final id = '${DateTime.now().microsecondsSinceEpoch}.${subject.hashCode.abs()}@example.test';
  return Uint8List.fromList(
    utf8.encode(
      'From: Seeder <$from>\r\n'
      'To: alice@example.test\r\n'
      'Subject: ${_encodeSubject(subject)}\r\n'
      'Date: Mon, 6 Oct 2025 10:00:00 +0000\r\n'
      'Message-ID: <$id>\r\n'
      'MIME-Version: 1.0\r\n'
      'Content-Type: text/plain; charset=utf-8\r\n'
      'Content-Transfer-Encoding: 8bit\r\n'
      '\r\n'
      '$body\r\n',
    ),
  );
}

String _encodeSubject(String s) =>
    s.codeUnits.every((c) => c < 0x80) ? s : '=?UTF-8?B?${base64.encode(utf8.encode(s))}?=';
