import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:test/test.dart';

void main() {
  const request = AiRequest(
    taskType: 'search.translate',
    instructions: 'Translate.',
    input: 'Sentence: "unread from dana"',
    maxOutputTokens: 300,
    schema: {
      'type': 'object',
      'properties': {
        'expression': {'type': 'string'},
        'note': {
          'type': ['string', 'null'],
        },
      },
      'required': ['expression', 'note'],
    },
  );

  Map<String, Object?> okBody({String text = '{"expression":"from:dana","interpretation":"x","questions":[]}'}) => {
    'id': 'msg_1',
    'type': 'message',
    'role': 'assistant',
    'model': 'claude-opus-5-5',
    'content': [
      {'type': 'thinking', 'thinking': '', 'signature': 's'},
      {'type': 'text', 'text': text},
    ],
    'stop_reason': 'end_turn',
    'usage': {'input_tokens': 120, 'output_tokens': 30},
  };

  http.Response json(Object body, [int status = 200]) =>
      http.Response(jsonEncode(body), status, headers: {'content-type': 'application/json'});

  test('sends one Messages API request with the key, the schema and the fallback header', () async {
    late http.Request sent;
    final provider = AnthropicProvider(
      apiKey: 'sk-test',
      client: MockClient((r) async {
        sent = r;
        return json(okBody());
      }),
    );
    final completion = await provider.complete(request);

    expect(sent.method, 'POST');
    expect(sent.url.toString(), 'https://api.anthropic.com/v1/messages');
    expect(sent.headers['x-api-key'], 'sk-test');
    expect(sent.headers['anthropic-version'], '2023-06-01');
    expect(sent.headers['anthropic-beta'], 'server-side-fallback-2026-07-01');
    expect(sent.headers['content-type'], startsWith('application/json'));

    final body = jsonDecode(sent.body) as Map<String, Object?>;
    expect(body['model'], 'claude-opus-5-5');
    expect(body['max_tokens'], 8192);
    expect(body['system'], 'Translate.');
    expect(body['messages'], [
      {'role': 'user', 'content': 'Sentence: "unread from dana"'},
    ]);
    expect(body['fallbacks'], 'default');
    expect(body.containsKey('thinking'), isFalse);
    final config = body['output_config'] as Map<String, Object?>;
    expect(config['effort'], 'low');
    final format = config['format'] as Map<String, Object?>;
    expect(format['type'], 'json_schema');
    final schema = format['schema'] as Map<String, Object?>;
    expect(schema['additionalProperties'], isFalse);
    final note = (schema['properties'] as Map<String, Object?>)['note'] as Map<String, Object?>;
    expect(note['anyOf'], [
      {'type': 'string'},
      {'type': 'null'},
    ]);
    expect(note.containsKey('type'), isFalse);

    expect(completion.text, '{"expression":"from:dana","interpretation":"x","questions":[]}');
    expect(completion.model, 'claude-opus-5-5');
    expect(completion.inputTokens, 120);
    expect(completion.outputTokens, 30);
    expect(provider.id, 'anthropic:claude-opus-5-5');
    expect(provider.location, ProviderLocation.cloud);
  });

  test('fallback and effort can be turned off; a base URL keeps its path', () async {
    late http.Request sent;
    final provider = AnthropicProvider(
      apiKey: 'k',
      baseUrl: Uri.parse('https://proxy.example/anthropic/'),
      effort: null,
      serverSideFallback: false,
      client: MockClient((r) async {
        sent = r;
        return json(okBody());
      }),
    );
    await provider.complete(request);
    expect(sent.url.toString(), 'https://proxy.example/anthropic/v1/messages');
    expect(sent.headers.containsKey('anthropic-beta'), isFalse);
    final body = jsonDecode(sent.body) as Map<String, Object?>;
    expect(body.containsKey('fallbacks'), isFalse);
    expect((body['output_config'] as Map<String, Object?>).containsKey('effort'), isFalse);
  });

  test('maps API errors: 429 and 529 retryable, 401 and 400 not, with plain messages', () async {
    Future<AiProviderException> errorFor(int status, String type, [String message = 'm']) async {
      final provider = AnthropicProvider(
        apiKey: 'k',
        client: MockClient(
          (_) async => json({
            'type': 'error',
            'error': {'type': type, 'message': message},
          }, status),
        ),
      );
      try {
        await provider.complete(request);
      } on AiProviderException catch (e) {
        return e;
      }
      fail('expected an AiProviderException');
    }

    final rate = await errorFor(429, 'rate_limit_error');
    expect(rate.retryable, isTrue);
    expect(rate.message, contains('rate limit'));
    expect((await errorFor(529, 'overloaded_error')).retryable, isTrue);
    final auth = await errorFor(401, 'authentication_error');
    expect(auth.retryable, isFalse);
    expect(auth.message, 'Anthropic did not accept the API key.');
    final bad = await errorFor(400, 'invalid_request_error', 'max_tokens: too large');
    expect(bad.retryable, isFalse);
    expect(bad.message, 'Anthropic rejected the request: max_tokens: too large.');
    expect((await errorFor(404, 'not_found_error')).message, contains('claude-opus-5-5'));
  });

  test('a refusal and a cut-short answer are errors, not text to parse', () async {
    for (final (reason, expected) in [('refusal', 'declined'), ('max_tokens', 'cut short')]) {
      final provider = AnthropicProvider(
        apiKey: 'k',
        client: MockClient((_) async => json({...okBody(), 'stop_reason': reason})),
      );
      await expectLater(
        provider.complete(request),
        throwsA(isA<AiProviderException>().having((e) => e.message, 'message', contains(expected))),
      );
    }
  });

  test('a timeout and a connection failure are retryable provider errors', () async {
    final slow = AnthropicProvider(
      apiKey: 'k',
      timeout: const Duration(milliseconds: 20),
      client: MockClient((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        return json(okBody());
      }),
    );
    await expectLater(
      slow.complete(request),
      throwsA(isA<AiProviderException>().having((e) => e.retryable, 'retryable', isTrue)),
    );
    final down = AnthropicProvider(apiKey: 'k', client: MockClient((_) async => throw http.ClientException('refused')));
    await expectLater(
      down.complete(request),
      throwsA(isA<AiProviderException>().having((e) => e.retryable, 'retryable', isTrue)),
    );
  });

  test('cancelled before sending: no request leaves', () async {
    var sent = 0;
    final provider = AnthropicProvider(
      apiKey: 'k',
      client: MockClient((_) async {
        sent++;
        return json(okBody());
      }),
    );
    await expectLater(provider.complete(request, cancel: CancelToken()..cancel()), throwsA(isA<AiCancelled>()));
    expect(sent, 0);
  });

  test('works end to end with the runner and the search translator', () async {
    final provider = AnthropicProvider(apiKey: 'k', client: MockClient((_) async => json(okBody())));
    final run = await AiRunner(provider)
        .run(SearchTranslationTask('unread from dana', now: DateTime.utc(2026, 10, 30)));
    expect(run, isA<AiSuccess<SearchTranslation>>());
    expect((run as AiSuccess<SearchTranslation>).value.expression, 'from:dana');
    expect(run.record.providerId, 'anthropic:claude-opus-5-5');
    expect(run.record.inputTokens, 120);
  });
}
