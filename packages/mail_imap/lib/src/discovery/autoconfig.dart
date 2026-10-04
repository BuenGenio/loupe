/// Thunderbird autoconfig XML (clientConfig v1.1).
library;

import 'package:mail_model/mail_model.dart';
import 'package:xml/xml.dart';

/// What an autoconfig document offers for one address.
final class AutoconfigResult {
  const AutoconfigResult({this.incoming, this.outgoing, this.oauth = false, this.notes});

  final ServerConfig? incoming;
  final ServerConfig? outgoing;

  /// The IMAP server lists OAuth2 authentication.
  final bool oauth;
  final String? notes;
}

/// Parses an autoconfig document; null if it isn't one or has no IMAP
/// server. Plain-text servers are skipped (Loupe never picks them itself).
AutoconfigResult? parseAutoconfig(String xmlText, String email) {
  final XmlDocument doc;
  try {
    doc = XmlDocument.parse(xmlText);
  } on XmlException {
    return null;
  }
  final root = doc.rootElement;
  if (root.name.local != 'clientConfig') return null;
  final provider = root.findElements('emailProvider').firstOrNull;
  if (provider == null) return null;
  final at = email.lastIndexOf('@');
  final local = at > 0 ? email.substring(0, at) : email;
  final domain = at > 0 ? email.substring(at + 1).toLowerCase() : '';
  String fill(String s) =>
      s.replaceAll('%EMAILADDRESS%', email).replaceAll('%EMAILLOCALPART%', local).replaceAll('%EMAILDOMAIN%', domain);

  (ServerConfig, bool)? best(Iterable<XmlElement> servers, ServerProtocol protocol) {
    (ServerConfig, bool, int)? chosen;
    for (final s in servers) {
      final host = s.getElement('hostname')?.innerText.trim();
      final port = int.tryParse(s.getElement('port')?.innerText.trim() ?? '');
      final socket = s.getElement('socketType')?.innerText.trim().toUpperCase();
      if (host == null || host.isEmpty || port == null) continue;
      final (security, rank) = switch (socket) {
        'SSL' => (ConnectionSecurity.tls, 2),
        'STARTTLS' => (ConnectionSecurity.startTls, 1),
        _ => (ConnectionSecurity.none, -1),
      };
      if (rank < 0) continue;
      final auth = s.findElements('authentication').map((e) => e.innerText.trim()).toSet();
      final rawUser = s.getElement('username')?.innerText.trim();
      final user = rawUser == null || rawUser.isEmpty || rawUser == '%EMAILADDRESS%' ? null : fill(rawUser);
      final config = ServerConfig(protocol: protocol, host: fill(host), port: port, security: security, username: user);
      if (chosen == null || rank > chosen.$3) chosen = (config, auth.contains('OAuth2'), rank);
    }
    return chosen == null ? null : (chosen.$1, chosen.$2);
  }

  final imap = best(
    provider.findElements('incomingServer').where((e) => e.getAttribute('type') == 'imap'),
    ServerProtocol.imap,
  );
  if (imap == null) return null;
  final smtp = best(
    provider.findElements('outgoingServer').where((e) => e.getAttribute('type') == 'smtp'),
    ServerProtocol.smtp,
  );
  String? notes;
  final instruction = root.findAllElements('instruction').firstOrNull?.innerText.trim();
  if (instruction != null && instruction.isNotEmpty) notes = instruction;
  return AutoconfigResult(incoming: imap.$1, outgoing: smtp?.$1, oauth: imap.$2, notes: notes);
}
