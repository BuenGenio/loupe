import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mail_jmap/mail_jmap.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/scripted_jmap.dart';

const _server = ServerConfig(protocol: ServerProtocol.jmap, host: 'mail.example.test', port: 443);

JmapClient _client(http.Client http, {CredentialsCallback? credentials, ServerConfig server = _server}) => JmapClient(
  server: server,
  login: 'alice@example.test',
  credentials: credentials ?? passwordCallback(),
  httpClient: http,
);

TypeMatcher<MailException> _kind(MailErrorKind kind) => isA<MailException>().having((e) => e.kind, 'kind', kind);

void main() {
  group('session', () {
    test('is found through /.well-known/jmap and its redirect, with Basic authentication', () async {
      final jmap = ScriptedJmap();
      final client = _client(jmap.client);
      final s = await client.session();
      expect(jmap.requests.first.url.toString(), 'https://mail.example.test/.well-known/jmap');
      expect(jmap.requests.first.headers['Authorization'], startsWith('Basic '));
      expect(s.url.toString(), 'https://mail.example.test/jmap/session');
      expect(s.primaryAccount(JmapCapabilities.mail), 'c');
      expect(s.has(JmapCapabilities.submission), isTrue);
      expect(s.maxObjectsInGet, 500);
      expect(s.maxCallsInRequest, 16);
      expect(s.apiUrl.toString(), 'https://mail.example.test/jmap/');
      expect(
        s.download('c', 'b1', type: 'image/png', name: 'a b.png').toString(),
        'https://mail.example.test/jmap/download/c/b1/a%20b.png?accept=image%2Fpng',
      );
      expect(s.upload('c').toString(), 'https://mail.example.test/jmap/upload/c/');
      expect(
        s.eventSource(types: 'Email', ping: 60).toString(),
        'https://mail.example.test/jmap/eventsource/?types=Email&closeafter=no&ping=60',
      );
      // Cached until the server says the session changed.
      await client.session();
      expect(jmap.requests, hasLength(2));
    });

    test('URLs relative to the session resolve against it', () {
      final s = JmapSession.fromJson({
        'capabilities': {JmapCapabilities.core: {}, JmapCapabilities.mail: {}},
        'accounts': {
          'A1': {'name': 'me', 'isPersonal': true, 'isReadOnly': false},
        },
        'primaryAccounts': {JmapCapabilities.mail: 'A1'},
        'apiUrl': '/api/',
        'downloadUrl': '/dl/{accountId}/{blobId}?type={type}',
        'uploadUrl': '/up/{accountId}',
        'eventSourceUrl': null,
        'state': 'x',
      }, Uri.parse('https://jmap.example.org/.well-known/jmap'));
      expect(s.apiUrl.toString(), 'https://jmap.example.org/api/');
      expect(s.download('A1', 'B').toString(), 'https://jmap.example.org/dl/A1/B?type=application%2Foctet-stream');
      expect(s.eventSource(), isNull);
      expect(s.maxObjectsInGet, 500);
      expect(() => JmapSession.fromJson({'apiUrl': '/x'}, Uri.parse('https://x')), throwsFormatException);
    });

    test('the well-known URL uses the port, and plain HTTP only without encryption', () {
      expect(
        _client(MockClient((_) async => http.Response('', 404))).wellKnownUrl.toString(),
        'https://mail.example.test/.well-known/jmap',
      );
      final plain = _client(
        MockClient((_) async => http.Response('', 404)),
        server: const ServerConfig(
          protocol: ServerProtocol.jmap,
          host: '127.0.0.1',
          port: 8080,
          security: ConnectionSecurity.none,
        ),
      );
      expect(plain.wellKnownUrl.toString(), 'http://127.0.0.1:8080/.well-known/jmap');
    });

    test('falls back to /jmap/session when the well-known URL is missing', () async {
      final session = fixture('session');
      final client = _client(
        MockClient((r) async {
          if (r.url.path == '/jmap/session') return http.Response(jsonEncode(session), 200);
          return http.Response('not here', 404);
        }),
      );
      expect((await client.session()).primaryAccount(JmapCapabilities.mail), 'c');
    });

    test('a web site instead of JMAP is a clear error', () async {
      final client = _client(MockClient((r) async => http.Response('<html>Welcome</html>', 200)));
      await expectLater(
        client.session(),
        throwsA(_kind(MailErrorKind.server).having((e) => e.message, 'message', contains('No JMAP service'))),
      );
    });

    test('never follows a redirect from HTTPS to plain HTTP', () async {
      final client = _client(
        MockClient((r) async => http.Response('', 301, headers: {'location': 'http://evil.example/jmap'})),
      );
      await expectLater(
        client.session(),
        throwsA(_kind(MailErrorKind.server).having((e) => e.message, 'message', contains('unencrypted'))),
      );
    });

    test('is fetched again when a response names another session state', () async {
      final jmap = ScriptedJmap()..on('Core/echo', (args) => args);
      final client = _client(jmap.client);
      await client.session();
      jmap.sessionState = 'changed';
      final r = JmapRequest()..add('Core/echo', {'a': 1});
      await client.call(r);
      await client.session();
      expect([for (final q in jmap.requests) q.url.path].where((p) => p == '/jmap/session'), hasLength(2));
    });
  });

  group('authentication', () {
    test('a wrong password is an authentication error', () async {
      final client = _client(ScriptedJmap().client, credentials: passwordCallback('wrong'));
      await expectLater(client.session(), throwsA(_kind(MailErrorKind.authentication)));
    });

    test('a password the server refuses as Basic is tried once as a bearer token, and kept so', () async {
      final jmap = ScriptedJmap(password: 'not-this')..bearer = 'api-token-123';
      final client = _client(jmap.client, credentials: passwordCallback('api-token-123'));
      await client.session(refresh: true);
      await client.session(refresh: true);
      final auth = [for (final r in jmap.requests) r.headers['Authorization']!.split(' ').first];
      // Basic, then Bearer for the first request; the redirect and the
      // second session fetch go as Bearer straight away.
      expect(auth.first, 'Basic');
      expect(auth.skip(1), everyElement('Bearer'));
    });

    test('Fastmail API tokens go as bearer tokens at once', () async {
      final jmap = ScriptedJmap(password: 'x')..bearer = 'fmu1-abcdef';
      await _client(jmap.client, credentials: passwordCallback('fmu1-abcdef')).session();
      expect(jmap.requests.every((r) => r.headers['Authorization'] == 'Bearer fmu1-abcdef'), isTrue);
      expect(looksLikeApiToken('fmu1-abc'), isTrue);
      expect(looksLikeApiToken('hunter2'), isFalse);
    });

    test('OAuth tokens are refreshed once when refused', () async {
      final jmap = ScriptedJmap()..bearer = 'fresh';
      final refreshes = <bool>[];
      var token = 'stale';
      final client = _client(
        jmap.client,
        credentials: ({bool forceRefresh = false}) async {
          refreshes.add(forceRefresh);
          if (forceRefresh) token = 'fresh';
          return OAuthCredentials(accessToken: token, refreshToken: 'r', expiresAt: DateTime(2030));
        },
      );
      await client.session();
      // Refused, refreshed, then the redirect with the fresh token.
      expect(refreshes, [false, true, false]);
      expect(jmap.requests.last.headers['Authorization'], 'Bearer fresh');
    });
  });

  group('requests', () {
    test('batch method calls with result references', () async {
      final jmap = ScriptedJmap()
        ..on(
          'Email/query',
          (args) => {
            'ids': ['e1', 'e2'],
            'queryState': 'q',
            'position': 0,
          },
        )
        ..on('Email/get', emailGet({'e1': emailJson('e1'), 'e2': emailJson('e2')}));
      final client = _client(jmap.client);
      final request = JmapRequest();
      final query = request.add('Email/query', {
        'accountId': 'c',
        'filter': {'inMailbox': 'a'},
      });
      final get = request.add('Email/get', {'accountId': 'c', '#ids': query.ref('/ids')});
      final body = request.toJson();
      expect(body['using'], [JmapCapabilities.core, JmapCapabilities.mail]);
      expect(((body['methodCalls']! as List)[1] as List)[1], {
        'accountId': 'c',
        '#ids': {'resultOf': 'c0', 'name': 'Email/query', 'path': '/ids'},
      });
      final response = await client.call(request);
      expect([for (final e in response.of(get)['list']! as List) (e as Map)['id']], ['e1', 'e2']);
    });

    test('method errors become exceptions of the matching kind', () async {
      final jmap = ScriptedJmap()
        ..fail('Email/changes', 'cannotCalculateChanges')
        ..fail('Mailbox/get', 'serverUnavailable')
        ..fail('Email/set', 'forbidden')
        ..fail('Email/get', 'accountNotFound');
      final client = _client(jmap.client);
      final request = JmapRequest();
      final calls = [
        for (final m in ['Email/changes', 'Mailbox/get', 'Email/set', 'Email/get', 'Thread/get']) request.add(m, {}),
      ];
      final response = await client.call(request);
      expect(
        () => response.of(calls[0]),
        throwsA(isA<JmapException>().having((e) => e.type, 'type', 'cannotCalculateChanges')),
      );
      expect(() => response.of(calls[1]), throwsA(_kind(MailErrorKind.connection)));
      expect(() => response.of(calls[2]), throwsA(_kind(MailErrorKind.unsupported)));
      expect(() => response.of(calls[3]), throwsA(_kind(MailErrorKind.authentication)));
      expect(() => response.of(calls[4]), throwsA(_kind(MailErrorKind.unsupported)));
      expect(response.errorOf(calls[0])?.type, 'cannotCalculateChanges');
    });

    test('HTTP failures become exceptions of the matching kind', () async {
      final jmap = ScriptedJmap();
      final client = _client(jmap.client);
      await client.session();
      for (final (status, kind) in [
        (503, MailErrorKind.connection),
        (429, MailErrorKind.connection),
        (500, MailErrorKind.server),
        (400, MailErrorKind.server),
      ]) {
        jmap.apiStatus = status;
        await expectLater(client.call(JmapRequest()..add('Core/echo', {})), throwsA(_kind(kind)));
      }
      final problem = MockClient((r) async {
        if (r.url.path.contains('session')) return http.Response(jsonEncode(fixture('session')), 200);
        if (r.url.path == '/.well-known/jmap') return http.Response('', 404);
        return http.Response('{"type":"urn:ietf:params:jmap:error:unknownCapability","status":400}', 400);
      });
      await expectLater(
        _client(problem).call(JmapRequest()..add('Core/echo', {})),
        throwsA(_kind(MailErrorKind.unsupported)),
      );
      final offline = MockClient((r) async => throw http.ClientException('Connection refused', r.url));
      await expectLater(_client(offline).session(), throwsA(_kind(MailErrorKind.connection)));
    });

    test('uploads and downloads blobs', () async {
      final jmap = ScriptedJmap();
      final client = _client(jmap.client);
      final blob = await client.upload(
        'c',
        Uint8List.fromList(utf8.encode('Subject: x\r\n\r\nhi')),
        type: 'message/rfc822',
      );
      expect(blob.size, 16);
      expect(jmap.requests.last.headers['Content-Type'], 'message/rfc822');
      expect(jmap.requests.last.url.path, '/jmap/upload/c/');
      expect(utf8.decode(await client.download('c', blob.blobId)), 'Subject: x\r\n\r\nhi');
      await expectLater(client.download('c', 'missing'), throwsA(_kind(MailErrorKind.notFound)));
    });

    test('an upload larger than the server takes fails for good', () async {
      final session = fixture('session');
      ((session['capabilities']! as Map)[JmapCapabilities.core] as Map)['maxSizeUpload'] = 10;
      final client = _client(ScriptedJmap(session: session).client);
      await expectLater(client.upload('c', Uint8List(11)), throwsA(isA<PermanentMailException>()));
    });
  });

  group('push events', () {
    test('parses server-sent events and the state changes of one account', () async {
      final stream = Stream.fromIterable([
        utf8.encode('event: ping\ndata: {"interval": 30}\n\n: comment\n'),
        utf8.encode('event: state\ndata: {"@type":"StateChange",'),
        utf8.encode('\ndata: "changed":{"c":{"Email":"s9","Mailbox":"m2"},"d":{"Email":"x"}}}\n\n'),
      ]);
      final events = await parseServerEvents(stream).toList();
      expect([for (final e in events) e.type], ['ping', 'state']);
      expect(stateChangesOf(events[1], 'c'), {'Email': 's9', 'Mailbox': 'm2'});
      expect(stateChangesOf(events[1], 'zz'), isEmpty);
      expect(stateChangesOf(events[0], 'c'), isEmpty);
    });
  });
}
