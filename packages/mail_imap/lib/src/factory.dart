/// The mail_imap [TransportFactory].
library;

import 'package:http/http.dart' as http;
import 'package:mail_model/mail_model.dart';

import 'compose/mime_composer.dart';
import 'discovery/discoverer.dart';
import 'imap/imap_transport.dart';
import 'smtp/smtp_sender.dart';

/// Creates IMAP transports, SMTP senders and the MIME composer, and runs
/// account discovery.
final class ImapTransportFactory implements TransportFactory {
  ImapTransportFactory({http.Client? httpClient, ServerProbe? probe, MessageComposer? composer})
    : _discoverer = AccountDiscoverer(httpClient: httpClient, probe: probe),
      composer = composer ?? MimeMessageComposer();

  final AccountDiscoverer _discoverer;

  @override
  final MessageComposer composer;

  @override
  MailTransport createTransport(MailAccount account, CredentialsCallback credentials) {
    if (account.incoming.protocol != ServerProtocol.imap) {
      throw const MailException(MailErrorKind.unsupported, 'Only IMAP accounts are supported so far.');
    }
    return ImapTransport(account, credentials);
  }

  @override
  MailSender createSender(MailAccount account, CredentialsCallback credentials) => ImapSmtpSender(account, credentials);

  @override
  Future<AccountDiscovery> discover(String email) => _discoverer.discover(email);
}
