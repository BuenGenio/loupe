/// Finding JMAP for an email address.
library;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mail_imap/discovery.dart' show providerRule;
import 'package:mail_model/mail_model.dart';

import 'client/client.dart';
import 'client/session.dart';

/// Notes shown during setup of a JMAP account.
abstract final class JmapNotes {
  static const fastmail =
      'Fastmail connects over JMAP with an API token, not your password: Settings › Privacy & Security › '
      'Manage API tokens, type JMAP, with access to Email and Email submission.';
  static const fastmailHelp = 'https://www.fastmail.help/hc/en-us/articles/5254602856719';
}

/// Fastmail's JMAP settings ([JmapNotes.fastmail]).
AccountDiscovery fastmailJmapDiscovery(String email, {String source = 'provider'}) => AccountDiscovery(
  email: email,
  provider: ProviderKind.fastmail,
  authKind: AuthKind.password,
  incoming: const ServerConfig(protocol: ServerProtocol.jmap, host: 'api.fastmail.com', port: 443),
  source: source,
  notes: JmapNotes.fastmail,
);

/// Finds settings, JMAP first:
/// 1. Fastmail addresses (also custom domains IMAP discovery places at
///    Fastmail) use Fastmail's JMAP API;
/// 2. `https://<domain>/.well-known/jmap`, looked up while IMAP discovery
///    runs;
/// 3. IMAP discovery (provider rules, ISPDB, autoconfig, guesses), and then
///    `https://<IMAP host>/.well-known/jmap`: a Stalwart server publishes
///    IMAP in autoconfig and serves JMAP on the same host.
///
/// Only HTTPS without credentials, and no SRV lookups, like the IMAP
/// discovery (`_jmap._tcp` would need a DNS client and tell the resolver
/// which provider the user signs in to).
final class JmapDiscoverer {
  JmapDiscoverer({required this.imap, http.Client? httpClient, this.timeout = const Duration(seconds: 10)})
    : _http = httpClient ?? IOClient();

  /// IMAP discovery, used when there is no JMAP.
  final Future<AccountDiscovery> Function(String email) imap;
  final http.Client _http;
  final Duration timeout;

  Future<AccountDiscovery> discover(String email) async {
    final address = email.trim();
    final at = address.lastIndexOf('@');
    final domain = at > 0 ? address.substring(at + 1).toLowerCase() : '';
    if (domain.isEmpty || !domain.contains('.') || domain.contains('/') || domain.contains(' ')) {
      return imap(address);
    }
    final rule = providerRule(address, domain);
    if (rule != null) return rule.provider == ProviderKind.fastmail ? fastmailJmapDiscovery(address) : rule;

    final viaImap = imap(address);
    // Errors of IMAP discovery surface below, not here.
    unawaited(viaImap.then((_) {}, onError: (Object _) {}));
    if (await probe(domain)) return _jmap(address, domain);
    final found = await viaImap;
    if (found.provider == ProviderKind.fastmail) {
      return fastmailJmapDiscovery(address, source: found.source ?? 'provider');
    }
    final host = found.incoming?.host;
    if (found.provider == ProviderKind.generic &&
        found.incoming?.protocol == ServerProtocol.imap &&
        host != null &&
        host.toLowerCase() != domain &&
        await probe(host)) {
      return _jmap(address, host, notes: found.notes);
    }
    return found;
  }

  AccountDiscovery _jmap(String email, String host, {String? notes}) => AccountDiscovery(
    email: email,
    provider: ProviderKind.generic,
    authKind: AuthKind.password,
    incoming: ServerConfig(protocol: ServerProtocol.jmap, host: host, port: 443),
    source: 'JMAP at $host',
    notes: notes,
  );

  /// Whether [host] serves JMAP: `/.well-known/jmap` answers with a session
  /// resource (Stalwart shows one without signing in), or asks to sign in
  /// with a JSON problem, or redirects to a `jmap` path that does.
  Future<bool> probe(String host) async {
    var uri = Uri.https(host, '/.well-known/jmap');
    try {
      for (var hop = 0; hop <= 3; hop++) {
        final request = http.Request('GET', uri)
          ..followRedirects = false
          ..headers['User-Agent'] = JmapClient.userAgent
          ..headers['Accept'] = 'application/json';
        final response = await _http.send(request).timeout(timeout);
        final location = response.headers['location'];
        if (const {301, 302, 303, 307, 308}.contains(response.statusCode) && location != null) {
          await response.stream.drain<void>();
          final next = uri.resolve(location);
          if (next.scheme != 'https') return false;
          uri = next;
          continue;
        }
        final body = await response.stream.toBytes().timeout(timeout);
        if (body.length > 1 << 20) return false;
        final json = response.headers['content-type']?.contains('json') ?? false;
        if (response.statusCode == 401) return json || (hop > 0 && uri.path.contains('jmap'));
        if (response.statusCode != 200) return false;
        try {
          final decoded = jsonDecode(utf8.decode(body, allowMalformed: true));
          if (decoded is! Map) return false;
          JmapSession.fromJson(decoded.cast(), uri);
          return true;
        } on FormatException {
          return false;
        }
      }
    } on Object {
      // Unreachable, not HTTPS, too slow: no JMAP here.
    }
    return false;
  }
}
