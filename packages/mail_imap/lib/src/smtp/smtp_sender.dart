/// [MailSender] over SMTP submission.
library;

import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

import 'smtp_client.dart';

/// Sends messages through the account's outgoing server. Each [send] opens
/// its own session (sending is rare, and a fresh session can't be stale).
final class ImapSmtpSender implements MailSender {
  ImapSmtpSender(this.account, this._credentials);

  final MailAccount account;
  final CredentialsCallback _credentials;

  @override
  Future<void> send(Uint8List rfc822, {required String envelopeFrom, required List<String> recipients}) async {
    final server = account.outgoing;
    if (server == null || server.protocol != ServerProtocol.smtp) {
      throw const MailException(MailErrorKind.unsupported, 'This account has no outgoing (SMTP) server.');
    }
    final to = {for (final r in recipients) r.trim()}.where((r) => r.isNotEmpty).toList();
    if (to.isEmpty) throw const MailException(MailErrorKind.server, 'The message has no recipients.');
    final session = await _login(server);
    try {
      await session.sendMail(envelopeFrom, to, rfc822);
    } finally {
      await session.quit();
    }
  }

  Future<SmtpConnection> _login(ServerConfig server) async {
    final username = server.username ?? account.email;
    var credentials = await _credentials();
    var session = await SmtpConnection.open(server);
    try {
      await session.authenticate(username, credentials);
      return session;
    } on MailException catch (e) {
      await session.close();
      if (e.kind != MailErrorKind.authentication || credentials is! OAuthCredentials) rethrow;
    }
    credentials = await _credentials(forceRefresh: true);
    session = await SmtpConnection.open(server);
    try {
      await session.authenticate(username, credentials);
      return session;
    } catch (_) {
      await session.close();
      rethrow;
    }
  }

  @override
  Future<void> close() async {}
}
