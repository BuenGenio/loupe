/// Connecting accounts to their ManageSieve servers.
library;

import 'dart:io';

import 'package:mail_imap/mail_imap.dart' show WireProtocol, openMailSocket;
import 'package:mail_model/mail_model.dart';

import 'channel.dart';
import 'client.dart';
import 'session.dart';

/// The ManageSieve port (RFC 5804).
const manageSievePort = 4190;

/// Opens ManageSieve sessions on the account's IMAP host, port 4190, with
/// STARTTLS and the account's own credentials (mailcow, Dovecot, Fastmail
/// style setups). A self-signed certificate trusted for IMAP is trusted
/// here too. JMAP accounts use their JMAP host the same way (Stalwart
/// serves ManageSieve next to JMAP).
final class ManageSieveConnector implements SieveConnector {
  const ManageSieveConnector({this.port = manageSievePort, this.timeout = const Duration(seconds: 12)});

  final int port;
  final Duration timeout;

  @override
  Future<SieveSession> connect(MailAccount account, CredentialsCallback credentials) async {
    final server = account.incoming;
    if (server.protocol != ServerProtocol.imap && server.protocol != ServerProtocol.jmap) {
      throw const MailException(
        MailErrorKind.unsupported,
        'Server rules need an IMAP or JMAP account with ManageSieve.',
      );
    }
    if (account.provider == ProviderKind.gmail || account.provider == ProviderKind.microsoft) {
      throw MailException(
        MailErrorKind.unsupported,
        '${account.provider == ProviderKind.gmail ? 'Gmail' : 'Microsoft'} doesn’t offer server rules '
        '(ManageSieve). Rules for this account run on this device.',
      );
    }
    final socket = await _open(server.host);
    final channel = SocketSieveChannel(
      socket,
      host: server.host,
      trustedSha256: server.trustedCertificateSha256,
      timeout: timeout,
    );
    final client = await ManageSieveClient.open(
      channel,
      host: server.host,
      // Only an account the user explicitly set up without encryption may
      // send its password in plain text here too.
      requireTls: server.security != ConnectionSecurity.none,
      timeout: timeout * 1.5,
    );
    try {
      await client.login(server.username ?? account.email, credentials);
      return client;
    } catch (_) {
      await client.logout();
      rethrow;
    }
  }

  Future<Socket> _open(String host) async {
    try {
      return await openMailSocket(
        host: host,
        port: port,
        security: ConnectionSecurity.none,
        protocol: WireProtocol.imap,
        timeout: timeout,
      );
    } on MailException catch (e) {
      if (e.kind != MailErrorKind.connection) rethrow;
      throw MailException(
        MailErrorKind.connection,
        'Couldn’t reach server rules (ManageSieve) on $host, port $port. ${e.message}',
        e,
      );
    }
  }
}
