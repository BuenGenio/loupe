/// Finding server settings for an email address.
library;

import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mail_model/mail_model.dart';

import 'autoconfig.dart';
import 'providers.dart';

/// Checks whether a server answers on [host]:[port] with [security].
typedef ServerProbe = Future<bool> Function(String host, int port, ConnectionSecurity security);

/// Finds settings in this order:
/// 1. built-in rules for the big providers;
/// 2. the Thunderbird ISPDB (`autoconfig.thunderbird.net`);
/// 3. `https://autoconfig.<domain>/mail/config-v1.1.xml`;
/// 4. `https://<domain>/.well-known/autoconfig/mail/config-v1.1.xml`;
/// 5. guessed `imap.`/`mail.`/`smtp.` hosts, confirmed by a quick connect;
/// 6. nothing (manual setup).
///
/// Privacy: no MX or SRV lookups (a DNS query for the domain's mail
/// exchanger would tell resolvers which provider the user signs in to, and
/// MX-based ISPDB lookups send that domain to Thunderbird's server), and
/// only HTTPS (a plain-HTTP autoconfig answer could redirect the user's
/// password to another server). Custom domains hosted by Google or Microsoft
/// therefore fall through to guessing or manual setup.
final class AccountDiscoverer {
  AccountDiscoverer({http.Client? httpClient, ServerProbe? probe, this.timeout = const Duration(seconds: 10)})
    : _http = httpClient ?? http.Client(),
      _probe = probe ?? tlsProbe;

  final http.Client _http;
  final ServerProbe _probe;

  /// Per HTTP request and per probe.
  final Duration timeout;

  static const userAgent = 'Loupe/0.1 (+https://github.com/BuenGenio/loupe)';

  Future<AccountDiscovery> discover(String email) async {
    final address = email.trim();
    final at = address.lastIndexOf('@');
    final domain = at > 0 ? address.substring(at + 1).toLowerCase() : '';
    if (domain.isEmpty || !domain.contains('.') || domain.contains('/') || domain.contains(' ')) {
      return AccountDiscovery(email: address, provider: ProviderKind.generic, authKind: AuthKind.password);
    }
    final rule = providerRule(address, domain);
    if (rule != null) return rule;

    final ispdb = await _fetch(Uri.https('autoconfig.thunderbird.net', '/v1.1/$domain'), address);
    if (ispdb != null) return _fromAutoconfig(address, ispdb, 'ISPDB');

    final own = await Future.wait([
      _fetch(Uri.https('autoconfig.$domain', '/mail/config-v1.1.xml', {'emailaddress': address}), address),
      _fetch(Uri.https(domain, '/.well-known/autoconfig/mail/config-v1.1.xml'), address),
    ]);
    if (own[0] != null) return _fromAutoconfig(address, own[0]!, 'autoconfig.$domain');
    if (own[1] != null) return _fromAutoconfig(address, own[1]!, domain);

    final guessed = await _guess(domain);
    if (guessed.$1 != null) {
      return AccountDiscovery(
        email: address,
        provider: providerForHost(guessed.$1!.host),
        authKind: AuthKind.password,
        incoming: guessed.$1,
        outgoing: guessed.$2,
        source: 'guess',
      );
    }
    return AccountDiscovery(email: address, provider: ProviderKind.generic, authKind: AuthKind.password);
  }

  Future<AutoconfigResult?> _fetch(Uri uri, String email) async {
    try {
      final response = await _http.get(uri, headers: {'User-Agent': userAgent}).timeout(timeout);
      if (response.statusCode != 200) return null;
      return parseAutoconfig(response.body, email);
    } on Object {
      return null;
    }
  }

  AccountDiscovery _fromAutoconfig(String email, AutoconfigResult r, String source) {
    final provider = providerForHost(r.incoming!.host);
    // Domains hosted by Google or Microsoft use their sign-in.
    if (provider == ProviderKind.gmail) return gmailDiscovery(email, source: source);
    if (provider == ProviderKind.microsoft) return microsoftDiscovery(email, source: source);
    return AccountDiscovery(
      email: email,
      provider: provider,
      authKind: AuthKind.password,
      incoming: r.incoming,
      outgoing: r.outgoing,
      source: source,
      notes: r.notes,
    );
  }

  Future<(ServerConfig?, ServerConfig?)> _guess(String domain) async {
    final imap = [
      ServerConfig(protocol: ServerProtocol.imap, host: 'imap.$domain', port: 993),
      ServerConfig(protocol: ServerProtocol.imap, host: 'mail.$domain', port: 993),
      ServerConfig(
        protocol: ServerProtocol.imap,
        host: 'imap.$domain',
        port: 143,
        security: ConnectionSecurity.startTls,
      ),
      ServerConfig(
        protocol: ServerProtocol.imap,
        host: 'mail.$domain',
        port: 143,
        security: ConnectionSecurity.startTls,
      ),
    ];
    final smtp = [
      ServerConfig(protocol: ServerProtocol.smtp, host: 'smtp.$domain', port: 465),
      ServerConfig(protocol: ServerProtocol.smtp, host: 'mail.$domain', port: 465),
      ServerConfig(
        protocol: ServerProtocol.smtp,
        host: 'smtp.$domain',
        port: 587,
        security: ConnectionSecurity.startTls,
      ),
      ServerConfig(
        protocol: ServerProtocol.smtp,
        host: 'mail.$domain',
        port: 587,
        security: ConnectionSecurity.startTls,
      ),
    ];
    Future<bool> safeProbe(ServerConfig c) =>
        _probe(c.host, c.port, c.security).timeout(timeout, onTimeout: () => false).catchError((Object _) => false);
    final results = await Future.wait([...imap.map(safeProbe), ...smtp.map(safeProbe)]);
    ServerConfig? first(List<ServerConfig> list, int offset) {
      for (var i = 0; i < list.length; i++) {
        if (results[offset + i]) return list[i];
      }
      return null;
    }

    return (first(imap, 0), first(smtp, imap.length));
  }
}

/// Default probe: a TLS handshake for implicit TLS (any certificate; the
/// real connection checks it later), a TCP connect for STARTTLS ports.
Future<bool> tlsProbe(String host, int port, ConnectionSecurity security) async {
  const t = Duration(seconds: 6);
  try {
    final Socket socket = security == ConnectionSecurity.tls
        ? await SecureSocket.connect(host, port, timeout: t, onBadCertificate: (_) => true).timeout(t)
        : await Socket.connect(host, port, timeout: t);
    socket.destroy();
    return true;
  } on Object {
    return false;
  }
}
