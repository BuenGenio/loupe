import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mail_imap/mail_imap.dart';
import 'package:mail_imap/src/discovery/autoconfig.dart';
import 'package:mail_imap/src/discovery/providers.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

/// A discoverer whose HTTP answers come from [pages] (URL → body) and whose
/// probes succeed for [open] ("host:port").
({AccountDiscoverer discoverer, List<http.Request> requests, List<String> probes}) fake({
  Map<String, String> pages = const {},
  Set<String> open = const {},
}) {
  final requests = <http.Request>[];
  final probes = <String>[];
  final client = MockClient((request) async {
    requests.add(request);
    final body = pages[request.url.toString()];
    return body == null ? http.Response('not found', 404) : http.Response(body, 200);
  });
  final discoverer = AccountDiscoverer(
    httpClient: client,
    probe: (host, port, security) async {
      probes.add('$host:$port');
      return open.contains('$host:$port');
    },
  );
  return (discoverer: discoverer, requests: requests, probes: probes);
}

void main() {
  group('provider rules', () {
    test('Gmail and Microsoft use OAuth', () {
      final g = providerRule('a@googlemail.com', 'googlemail.com')!;
      expect(g.provider, ProviderKind.gmail);
      expect(g.authKind, AuthKind.oauth2);
      expect(g.incoming!.host, 'imap.gmail.com');
      expect(g.incoming!.security, ConnectionSecurity.tls);
      for (final d in ['outlook.com', 'hotmail.co.uk', 'live.de', 'msn.com', 'office365.com']) {
        final m = providerRule('a@$d', d)!;
        expect(m.provider, ProviderKind.microsoft, reason: d);
        expect(m.authKind, AuthKind.oauth2);
        expect(m.outgoing!.security, ConnectionSecurity.startTls);
      }
    });

    test('iCloud, Yahoo/AOL and Fastmail use passwords with a note', () {
      final i = providerRule('a@me.com', 'me.com')!;
      expect(i.provider, ProviderKind.icloud);
      expect(i.authKind, AuthKind.password);
      expect(i.notes, contains('app-specific password'));
      expect(i.incoming!.host, 'imap.mail.me.com');
      expect(providerRule('a@yahoo.co.jp', 'yahoo.co.jp')!.incoming!.host, 'imap.mail.yahoo.com');
      expect(providerRule('a@aol.com', 'aol.com')!.incoming!.host, 'imap.aol.com');
      expect(providerRule('a@aol.com', 'aol.com')!.provider, ProviderKind.yahoo);
      expect(providerRule('a@fastmail.fm', 'fastmail.fm')!.provider, ProviderKind.fastmail);
      expect(providerRule('a@sent.com', 'sent.com')!.incoming!.host, 'imap.fastmail.com');
      expect(providerRule('a@example.org', 'example.org'), isNull);
      expect(providerRule('a@livejournal.com', 'livejournal.com'), isNull);
    });
  });

  group('autoconfig XML', () {
    test('prefers SSL over STARTTLS and skips POP3', () {
      final r = parseAutoconfig(fixture('ispdb_posteo.xml'), 'me@posteo.de')!;
      expect(r.incoming!.host, 'posteo.de');
      expect(r.incoming!.port, 993);
      expect(r.incoming!.security, ConnectionSecurity.tls);
      expect(r.incoming!.username, isNull);
      expect(r.outgoing!.port, 587);
      expect(r.outgoing!.security, ConnectionSecurity.startTls);
      expect(r.oauth, isFalse);
    });

    test('fills placeholders, never picks plain text, reads instructions', () {
      final r = parseAutoconfig(fixture('autoconfig_localpart.xml'), 'jo@example.org')!;
      expect(r.incoming!.host, 'mail.example.org');
      expect(r.incoming!.security, ConnectionSecurity.startTls);
      expect(r.incoming!.username, 'jo');
      expect(r.outgoing!.security, ConnectionSecurity.tls);
      expect(r.notes, 'Enable IMAP access in your account settings first.');
    });

    test('rejects junk', () {
      expect(parseAutoconfig('<html>nope</html>', 'a@b.c'), isNull);
      expect(parseAutoconfig('not xml at all <', 'a@b.c'), isNull);
    });
  });

  group('discovery', () {
    test('provider rules need no network', () async {
      final f = fake();
      final d = await f.discoverer.discover(' someone@gmail.com ');
      expect(d.provider, ProviderKind.gmail);
      expect(d.email, 'someone@gmail.com');
      expect(f.requests, isEmpty);
      expect(f.probes, isEmpty);
    });

    test('ISPDB first, with the Loupe User-Agent', () async {
      final f = fake(pages: {'https://autoconfig.thunderbird.net/v1.1/posteo.de': fixture('ispdb_posteo.xml')});
      final d = await f.discoverer.discover('me@posteo.de');
      expect(d.source, 'ISPDB');
      expect(d.incoming!.port, 993);
      expect(d.authKind, AuthKind.password);
      expect(f.requests.single.headers['User-Agent'], 'Loupe/0.1 (+https://github.com/BuenGenio/loupe)');
    });

    test('then the domain autoconfig, then well-known', () async {
      final f = fake(
        pages: {
          'https://autoconfig.example.org/mail/config-v1.1.xml?emailaddress=jo%40example.org': fixture(
            'autoconfig_localpart.xml',
          ),
        },
      );
      final d = await f.discoverer.discover('jo@example.org');
      expect(d.source, 'autoconfig.example.org');
      expect(d.incoming!.username, 'jo');
      expect(d.notes, isNotNull);

      final w = fake(
        pages: {'https://example.org/.well-known/autoconfig/mail/config-v1.1.xml': fixture('autoconfig_localpart.xml')},
      );
      expect((await w.discoverer.discover('jo@example.org')).source, 'example.org');
      expect(w.requests.every((r) => r.url.scheme == 'https'), isTrue);
    });

    test('a domain hosted by Google switches to Gmail with OAuth', () async {
      final f = fake(
        pages: {
          'https://autoconfig.example-workspace.org/mail/config-v1.1.xml?emailaddress=x%40example-workspace.org':
              fixture('autoconfig_google_hosted.xml'),
        },
      );
      final d = await f.discoverer.discover('x@example-workspace.org');
      expect(d.provider, ProviderKind.gmail);
      expect(d.authKind, AuthKind.oauth2);
    });

    test('guesses confirmed by probes', () async {
      final f = fake(open: {'mail.example.net:993', 'mail.example.net:587'});
      final d = await f.discoverer.discover('a@example.net');
      expect(d.source, 'guess');
      expect(d.incoming!.host, 'mail.example.net');
      expect(d.incoming!.security, ConnectionSecurity.tls);
      expect(d.outgoing!.port, 587);
      expect(d.outgoing!.security, ConnectionSecurity.startTls);
    });

    test('nothing found means manual setup', () async {
      final d = await fake().discoverer.discover('a@nowhere.example');
      expect(d.incoming, isNull);
      expect(d.outgoing, isNull);
      expect(d.provider, ProviderKind.generic);
      expect((await fake().discoverer.discover('not-an-address')).incoming, isNull);
    });
  });
}
