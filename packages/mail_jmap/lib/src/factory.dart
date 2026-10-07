/// The [TransportFactory]s of mail_jmap.
library;

import 'package:http/http.dart' as http;
import 'package:mail_imap/mail_imap.dart';
import 'package:mail_model/mail_model.dart';

import 'discovery.dart';
import 'sender.dart';
import 'transport/jmap_transport.dart';

/// Creates JMAP transports and senders. Messages are composed by
/// [composer], the same MIME composer IMAP accounts use (with OpenPGP and
/// S/MIME around it in the app), and uploaded as they are.
final class JmapTransportFactory implements TransportFactory {
  JmapTransportFactory({required this.composer, http.Client? httpClient, this._discoverer}) : _http = httpClient;

  @override
  final MessageComposer composer;
  final http.Client? _http;
  final JmapDiscoverer? _discoverer;

  @override
  MailTransport createTransport(MailAccount account, CredentialsCallback credentials) {
    if (account.incoming.protocol != ServerProtocol.jmap) {
      throw const MailException(MailErrorKind.unsupported, 'This account doesn’t use JMAP.');
    }
    return JmapTransport(account, credentials, httpClient: _http);
  }

  @override
  MailSender createSender(MailAccount account, CredentialsCallback credentials) =>
      JmapSender(account, credentials, httpClient: _http);

  @override
  Future<AccountDiscovery> discover(String email) {
    final d = _discoverer;
    if (d == null) throw const MailException(MailErrorKind.unsupported, 'No account discovery configured.');
    return d.discover(email);
  }
}

/// IMAP or JMAP, by each account's incoming protocol: the factory the app
/// uses. Discovery looks for JMAP first ([JmapDiscoverer]), then IMAP.
final class CompositeTransportFactory implements TransportFactory {
  CompositeTransportFactory({MessageComposer? composer, http.Client? httpClient, ServerProbe? probe})
    : this.of(
        ImapTransportFactory(httpClient: httpClient, probe: probe, composer: composer),
        httpClient: httpClient,
      );

  /// Around an existing IMAP factory; JMAP accounts use its composer.
  CompositeTransportFactory.of(this.imap, {http.Client? httpClient})
    : jmap = JmapTransportFactory(
        composer: imap.composer,
        httpClient: httpClient,
        discoverer: JmapDiscoverer(imap: imap.discover, httpClient: httpClient),
      );

  final TransportFactory imap;
  final JmapTransportFactory jmap;

  TransportFactory _for(MailAccount account) => account.incoming.protocol == ServerProtocol.jmap ? jmap : imap;

  @override
  MessageComposer get composer => imap.composer;

  @override
  MailTransport createTransport(MailAccount account, CredentialsCallback credentials) =>
      _for(account).createTransport(account, credentials);

  @override
  MailSender createSender(MailAccount account, CredentialsCallback credentials) =>
      _for(account).createSender(account, credentials);

  @override
  Future<AccountDiscovery> discover(String email) => jmap.discover(email);
}
