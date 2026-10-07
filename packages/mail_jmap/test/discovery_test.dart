import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mail_imap/mail_imap.dart';
import 'package:mail_jmap/mail_jmap.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/scripted_jmap.dart';

AccountDiscovery _imap(
  String email, {
  String host = 'imap.example.org',
  ProviderKind provider = ProviderKind.generic,
}) => AccountDiscovery(
  email: email,
  provider: provider,
  authKind: AuthKind.password,
  incoming: ServerConfig(protocol: ServerProtocol.imap, host: host, port: 993),
  outgoing: ServerConfig(protocol: ServerProtocol.smtp, host: host.replaceFirst('imap', 'smtp'), port: 465),
  source: 'autoconfig',
);

/// Answers JMAP probes for [jmapHosts] the way Stalwart does (a redirect to
/// a session that shows without signing in); every other host has none.
MockClient _web(Set<String> jmapHosts, List<Uri> asked) => MockClient((r) async {
  asked.add(r.url);
  if (r.headers['Authorization'] != null) return http.Response('no credentials expected', 400);
  if (!jmapHosts.contains(r.url.host)) return http.Response('<html>Not found</html>', 404);
  if (r.url.path == '/.well-known/jmap') {
    return http.Response('', 307, headers: {'location': 'https://${r.url.host}/jmap/session'});
  }
  final session = {...fixture('session'), 'accounts': {}, 'primaryAccounts': {}, 'username': ''};
  return http.Response(jsonEncode(session), 200, headers: {'content-type': 'application/json'});
});

void main() {
  test('Fastmail addresses use Fastmail’s JMAP API with an API token, without asking anyone', () async {
    final asked = <Uri>[];
    final d = JmapDiscoverer(imap: (e) async => fail('no IMAP discovery for Fastmail'), httpClient: _web({}, asked));
    final found = await d.discover('me@fastmail.com');
    expect(found.provider, ProviderKind.fastmail);
    expect(found.incoming!.protocol, ServerProtocol.jmap);
    expect(found.incoming!.host, 'api.fastmail.com');
    expect(found.outgoing, isNull);
    expect(found.notes, contains('API token'));
    expect(asked, isEmpty);
  });

  test('a custom domain hosted at Fastmail goes to its JMAP API too', () async {
    final d = JmapDiscoverer(
      imap: (e) async => _imap(e, host: 'imap.fastmail.com', provider: ProviderKind.fastmail),
      httpClient: _web({}, []),
    );
    expect((await d.discover('me@family.example')).incoming!.host, 'api.fastmail.com');
  });

  test('the domain’s own /.well-known/jmap', () async {
    final asked = <Uri>[];
    final d = JmapDiscoverer(imap: (e) async => _imap(e), httpClient: _web({'example.org'}, asked));
    final found = await d.discover('me@example.org');
    expect(found.incoming, isNotNull);
    expect(found.incoming!.protocol, ServerProtocol.jmap);
    expect(found.incoming!.host, 'example.org');
    expect(found.incoming!.port, 443);
    expect(found.incoming!.security, ConnectionSecurity.tls);
    expect(found.source, 'JMAP at example.org');
    expect(asked.first.toString(), 'https://example.org/.well-known/jmap');
  });

  test('JMAP on the host IMAP discovery found (Stalwart publishes IMAP in autoconfig)', () async {
    final d = JmapDiscoverer(
      imap: (e) async => _imap(e, host: 'mail.example.org'),
      httpClient: _web({'mail.example.org'}, []),
    );
    final found = await d.discover('me@example.org');
    expect(found.incoming!.protocol, ServerProtocol.jmap);
    expect(found.incoming!.host, 'mail.example.org');
  });

  test('without JMAP, IMAP discovery’s result stands', () async {
    final d = JmapDiscoverer(imap: (e) async => _imap(e), httpClient: _web({}, []));
    final found = await d.discover('me@example.org');
    expect(found.incoming!.protocol, ServerProtocol.imap);
    expect(found.outgoing, isNotNull);
  });

  test('a site that answers everything with a page, or redirects to plain HTTP, is not JMAP', () async {
    final page = JmapDiscoverer(
      imap: (e) async => _imap(e),
      httpClient: MockClient(
        (r) async => http.Response('<html>Hello</html>', 200, headers: {'content-type': 'text/html'}),
      ),
    );
    expect((await page.discover('me@example.org')).incoming!.protocol, ServerProtocol.imap);
    final plain = JmapDiscoverer(
      imap: (e) async => _imap(e),
      httpClient: MockClient((r) async => http.Response('', 302, headers: {'location': 'http://example.org/jmap'})),
    );
    expect(await plain.probe('example.org'), isFalse);
    final protected = JmapDiscoverer(
      imap: (e) async => _imap(e),
      httpClient: MockClient((r) async => http.Response('Login', 401, headers: {'content-type': 'text/html'})),
    );
    expect(await protected.probe('example.org'), isFalse);
  });

  test('Gmail and other providers keep their rules', () async {
    final d = JmapDiscoverer(imap: (e) async => fail('provider rule expected'), httpClient: _web({}, []));
    expect((await d.discover('me@gmail.com')).provider, ProviderKind.gmail);
  });

  group('the composite factory', () {
    final factory = CompositeTransportFactory(composer: MimeMessageComposer());

    test('picks the transport and sender by the incoming protocol', () {
      final jmap = scriptedAccount();
      final imap = MailAccount(
        id: 'i',
        email: 'a@example.org',
        displayName: 'IMAP',
        provider: ProviderKind.generic,
        authKind: AuthKind.password,
        incoming: const ServerConfig(protocol: ServerProtocol.imap, host: 'imap.example.org', port: 993),
        outgoing: const ServerConfig(protocol: ServerProtocol.smtp, host: 'smtp.example.org', port: 465),
      );
      expect(factory.createTransport(jmap, passwordCallback()), isA<JmapTransport>());
      expect(factory.createSender(jmap, passwordCallback()), isA<JmapSender>());
      expect(factory.createTransport(imap, passwordCallback()), isA<ImapTransport>());
      expect(factory.createSender(imap, passwordCallback()), isA<ImapSmtpSender>());
      expect(factory.composer, isA<MimeMessageComposer>());
      expect(factory.jmap.composer, same(factory.composer));
    });
  });
}
