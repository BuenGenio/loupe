import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/subscriptions/one_click.dart';

/// Records requests and answers them from [answer].
class FakeTransport implements OneClickTransport {
  FakeTransport([this.answer = _ok]);

  static OneClickResponse _ok(OneClickRequest _) => const OneClickResponse(200);

  OneClickResponse Function(OneClickRequest request) answer;
  final requests = <OneClickRequest>[];

  @override
  Future<OneClickResponse> send(OneClickRequest request, {required Duration timeout}) async {
    requests.add(request);
    return answer(request);
  }
}

class ThrowingTransport implements OneClickTransport {
  ThrowingTransport(this.error);
  final Object error;

  @override
  Future<OneClickResponse> send(OneClickRequest request, {required Duration timeout}) => Future.error(error);
}

final _uri = Uri.parse('https://news.example/u/abc?list=7');

void main() {
  group('the request', () {
    test('a POST of exactly List-Unsubscribe=One-Click, with nothing about the user', () async {
      final fake = FakeTransport();
      final result = await OneClickUnsubscriber(fake).unsubscribe(_uri);
      expect(result.ok, isTrue);
      final request = fake.requests.single;
      expect(OneClickRequest.method, 'POST');
      expect(request.uri, _uri);
      expect(utf8.decode(request.bodyBytes), 'List-Unsubscribe=One-Click');
      expect(OneClickRequest.headers, {'content-type': 'application/x-www-form-urlencoded'});
      for (final name in ['cookie', 'authorization', 'user-agent', 'referer', 'accept-language']) {
        expect(OneClickRequest.headers.keys.map((k) => k.toLowerCase()), isNot(contains(name)));
      }
    });

    test('only https URIs without credentials', () async {
      final fake = FakeTransport();
      for (final uri in [
        'http://news.example/u',
        'https://me:pw@news.example/u',
        'mailto:x@news.example',
        'https://192.168.1.1/u',
        'https://[::1]/u',
        'https://localhost/u',
        'https://printer.local/u',
        'https://router.home.arpa/u',
      ]) {
        final result = await OneClickUnsubscriber(fake).unsubscribe(Uri.parse(uri));
        expect(result.outcome, OneClickOutcome.failed, reason: uri);
      }
      expect(fake.requests, isEmpty);
    });
  });

  group('the answer', () {
    Future<OneClickResult> answered(int status, {String? location}) =>
        OneClickUnsubscriber(FakeTransport((_) => OneClickResponse(status, location: location))).unsubscribe(_uri);

    test('2xx and 303 See Other are done; errors are refused', () async {
      expect((await answered(200)).ok, isTrue);
      expect((await answered(204)).ok, isTrue);
      expect((await answered(303, location: 'https://news.example/thanks')).ok, isTrue);
      final refused = await answered(500);
      expect(refused.outcome, OneClickOutcome.refused);
      expect(refused.message, 'news.example refused the request (error 500).');
    });

    test('redirects are followed with the same POST on the same host only', () async {
      final fake = FakeTransport(
        (r) =>
            r.uri.path == '/u/abc' ? const OneClickResponse(307, location: '/v2/u/abc') : const OneClickResponse(202),
      );
      expect((await OneClickUnsubscriber(fake).unsubscribe(_uri)).ok, isTrue);
      expect(fake.requests.map((r) => r.uri.toString()), [
        'https://news.example/u/abc?list=7',
        'https://news.example/v2/u/abc',
      ]);
      final away = await answered(302, location: 'https://tracker.example/landing');
      expect(away.outcome, OneClickOutcome.redirectedAway);
      expect((await answered(308, location: 'http://news.example/u')).outcome, OneClickOutcome.redirectedAway);
      expect((await answered(301)).outcome, OneClickOutcome.redirectedAway, reason: 'no Location');
      final loop = FakeTransport((_) => const OneClickResponse(307, location: '/again'));
      expect((await OneClickUnsubscriber(loop).unsubscribe(_uri)).outcome, OneClickOutcome.redirectedAway);
      expect(loop.requests, hasLength(4));
    });

    test('no answer', () async {
      final timeout = await OneClickUnsubscriber(ThrowingTransport(TimeoutException('slow'))).unsubscribe(_uri);
      expect(timeout.outcome, OneClickOutcome.failed);
      expect(timeout.message, 'news.example didn’t answer in time.');
      final offline = await OneClickUnsubscriber(ThrowingTransport(const SocketException('Network is unreachable')))
          .unsubscribe(_uri);
      expect(offline.message, 'Couldn’t reach news.example.');
    });
  });

  test('over dart:io: method, body and headers as built, no redirect followed', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    final seen = <(String, String, Map<String, String>)>[];
    server.listen((request) async {
      final body = await utf8.decodeStream(request);
      final headers = <String, String>{};
      request.headers.forEach((name, values) => headers[name] = values.join(','));
      seen.add((request.method, body, headers));
      request.response
        ..statusCode = 302
        ..headers.set(HttpHeaders.locationHeader, '/elsewhere')
        ..headers.set(HttpHeaders.setCookieHeader, 'id=1')
        ..write('<img src="https://tracker.example/pixel.gif">');
      await request.response.close();
    });
    // The transport sends what it is given; the https rule is the
    // unsubscriber's, so a plain loopback server will do here.
    final response = await const IoOneClickTransport().send(
      OneClickRequest(Uri.parse('http://127.0.0.1:${server.port}/u?id=9')),
      timeout: const Duration(seconds: 5),
    );
    expect(response.statusCode, 302);
    expect(response.location, '/elsewhere');
    final (method, body, headers) = seen.single;
    expect(method, 'POST');
    expect(body, 'List-Unsubscribe=One-Click');
    expect(headers['content-type'], 'application/x-www-form-urlencoded');
    expect(headers['content-length'], '26');
    expect(headers['connection'], 'close');
    // No user agent, cookies, encodings or languages.
    expect(headers.keys, unorderedEquals(['host', 'content-type', 'content-length', 'connection']));
  });
}
