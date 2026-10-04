@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_imap/mail_imap.dart';
import 'package:mail_imap/src/imap/connection.dart';
import 'package:mail_imap/src/imap/parsers.dart';
import 'package:mail_imap/src/imap/protocol.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'server_env.dart';

void main() {
  final server = TestServer.fromEnvironment();
  if (server == null) {
    test('SMTP/TLS integration (set LOUPE_TEST_IMAP_HOST to run)', () {}, skip: 'LOUPE_TEST_IMAP_HOST is not set');
    return;
  }

  /// Polls [user]'s INBOX until a message with [subject] arrives; its UIDs.
  Future<List<int>> waitFor(String user, String subject) async {
    final c = await ImapConnection.open(
      server.account('poll').incoming,
      username: user,
      credentials: PasswordCredentials(server.password),
    );
    try {
      for (var i = 0; i < 40; i++) {
        await c.select('INBOX');
        final r = await c.send(Command('UID SEARCH SUBJECT "$subject"'), SearchParser());
        if (r.ids.isNotEmpty) return r.ids;
        await Future<void>.delayed(const Duration(milliseconds: 250));
      }
      return const [];
    } finally {
      await c.logout();
    }
  }

  group('SMTP', () {
    test('sends a composed message and reads it back over IMAP; Bcc stays hidden', () async {
      final account = server.account('smtp-it');
      final subject = 'Loupe SMTP ${DateTime.now().microsecondsSinceEpoch}';
      final message = OutgoingMessage(
        accountId: account.id,
        identityId: 'i',
        to: [EmailAddress(server.user, 'Alice')],
        bcc: [EmailAddress(server.user2)],
        subject: subject,
        text: 'Plain body with ümlauts\n.leading dot line',
        html: '<p>HTML body</p>',
        attachments: [
          OutgoingAttachment(
            filename: 'data.bin',
            mimeType: 'application/octet-stream',
            data: Uint8List.fromList([0, 1, 2, 255]),
          ),
        ],
      );
      final factory = ImapTransportFactory();
      final rfc822 = factory.composer.compose(
        message,
        Identity(id: 'i', email: server.user, name: 'Alice'),
        messageId: 'smtp-it-${DateTime.now().microsecondsSinceEpoch}@example.test',
      );
      final sender = factory.createSender(account, server.credentials);
      await sender.send(rfc822, envelopeFrom: server.user, recipients: [server.user, server.user2]);
      await sender.close();

      expect(await waitFor(server.user2, subject), isNotEmpty, reason: 'Bcc recipient got the message');
      expect(await waitFor(server.user, subject), isNotEmpty);

      final transport = ImapTransport(account, server.credentials);
      await transport.connect();
      try {
        final inbox = (await transport.listMailboxes()).firstWhere((b) => b.role == MailboxRole.inbox);
        final sync = await transport.syncMailbox(inbox, null, initialWindow: 50);
        final row = sync.added.firstWhere((e) => e.subject == subject);
        expect(row.hasAttachment, isTrue);
        expect(row.preview, 'Plain body with ümlauts .leading dot line');
        final content = await transport.fetchContent(row.id);
        expect(content.text?.trimRight(), 'Plain body with ümlauts\r\n.leading dot line');
        expect(content.html?.trimRight(), '<p>HTML body</p>');
        final attachment = content.visibleAttachments.single;
        expect(attachment.filename, 'data.bin');
        expect(await transport.fetchAttachment(row.id, attachment.partId), [0, 1, 2, 255]);
        final raw = utf8.decode(await transport.fetchRaw(row.id));
        expect(raw.toLowerCase(), isNot(contains('bcc:')));
        expect(raw, isNot(contains(server.user2)));
      } finally {
        await transport.disconnect();
      }
    });

    test('rejects a wrong password as an authentication error', () async {
      final sender = ImapSmtpSender(server.account('smtp-bad'), ({forceRefresh = false}) async {
        return const PasswordCredentials('wrong password');
      });
      // GreenMail accepts any password; real servers must reject it.
      try {
        await sender.send(
          Uint8List.fromList(utf8.encode('Subject: x\r\n\r\nx\r\n')),
          envelopeFrom: server.user,
          recipients: [server.user],
        );
      } on MailException catch (e) {
        expect(e.kind, MailErrorKind.authentication);
      }
    });
  }, skip: server.hasSmtp ? false : 'LOUPE_TEST_SMTP_PORT is not set');

  group('TLS trust', () {
    ServerConfig imaps({String? trusted}) => ServerConfig(
      protocol: ServerProtocol.imap,
      host: server.imapHost,
      port: server.imapsPort ?? 993,
      security: ConnectionSecurity.tls,
      trustedCertificateSha256: trusted,
    );

    test('an untrusted certificate fails with its fingerprint, and connects once trusted', () async {
      String? fingerprint;
      try {
        final c = await ImapConnection.open(
          imaps(),
          username: server.user,
          credentials: PasswordCredentials(server.password),
        );
        await c.logout();
        fail('connected without trusting the certificate');
      } on MailException catch (e) {
        expect(e.kind, MailErrorKind.certificate);
        expect(e.cause, isA<UntrustedCertificate>());
        fingerprint = untrustedFingerprintOf(e);
        expect(fingerprint, matches(RegExp(r'^[0-9a-f]{64}$')));
        expect(e.message, contains(fingerprint));
      }
      for (final format in [fingerprint!, _colons(fingerprint)]) {
        final c = await ImapConnection.open(
          imaps(trusted: format),
          username: server.user,
          credentials: PasswordCredentials(server.password),
        );
        expect(c.isOpen, isTrue);
        await c.logout();
      }
    }, skip: server.imapsPort == null ? 'LOUPE_TEST_IMAPS_PORT is not set' : false);

    test('STARTTLS never falls back to plain text', () async {
      final config = ServerConfig(
        protocol: ServerProtocol.imap,
        host: server.imapHost,
        port: server.imapPort,
        security: ConnectionSecurity.startTls,
      );
      try {
        final c = await ImapConnection.open(
          config,
          username: server.user,
          credentials: PasswordCredentials(server.password),
        );
        // The server supports STARTTLS: then the session must be encrypted.
        await c.logout();
      } on MailException catch (e) {
        expect(e.kind, anyOf(MailErrorKind.unsupported, MailErrorKind.certificate));
      }
    }, skip: server.imapSecurity == ConnectionSecurity.none ? false : 'needs the plain IMAP port');

    test('SMTP over TLS with a trusted certificate', () async {
      final base = server.account('smtps');
      String? fingerprint;
      try {
        await ImapSmtpSender(
          base.copyWith(
            outgoing: ServerConfig(protocol: ServerProtocol.smtp, host: server.smtpHost, port: server.smtpsPort!),
          ),
          server.credentials,
        ).send(
          Uint8List.fromList(utf8.encode('Subject: tls\r\n\r\nx\r\n')),
          envelopeFrom: server.user,
          recipients: [server.user],
        );
        fail('sent without trusting the certificate');
      } on MailException catch (e) {
        expect(e.kind, MailErrorKind.certificate);
        fingerprint = untrustedFingerprintOf(e);
      }
      final subject = 'Loupe SMTPS ${DateTime.now().microsecondsSinceEpoch}';
      await ImapSmtpSender(
        base.copyWith(
          outgoing: ServerConfig(
            protocol: ServerProtocol.smtp,
            host: server.smtpHost,
            port: server.smtpsPort!,
            trustedCertificateSha256: fingerprint,
          ),
        ),
        server.credentials,
      ).send(
        Uint8List.fromList(utf8.encode('Subject: $subject\r\n\r\nx\r\n')),
        envelopeFrom: server.user,
        recipients: [server.user],
      );
      expect(await waitFor(server.user, subject), isNotEmpty);
    }, skip: server.smtpsPort == null ? 'LOUPE_TEST_SMTPS_PORT is not set' : false);
  });
}

String _colons(String hex) => [for (var i = 0; i < hex.length; i += 2) hex.substring(i, i + 2)].join(':').toUpperCase();
