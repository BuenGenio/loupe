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
      },
      'required': ['expression'],
    },
  );

  Map<String, Object?> okBody({String content = '{"expression":"from:dana"}', String finish = 'stop'}) => {
    'id': 'chatcmpl-1',
    'model': 'qwen3.5:4b',
    'choices': [
      {
        'index': 0,
        'message': {'role': 'assistant', 'content': content},
        'finish_reason': finish,
      },
    ],
    'usage': {'prompt_tokens': 80, 'completion_tokens': 12},
  };

  http.Response json(Object body, [int status = 200]) =>
      http.Response(jsonEncode(body), status, headers: {'content-type': 'application/json'});

  test('posts a chat completion to the server, asking for a JSON object by default', () async {
    late http.Request sent;
    final provider = OpenAiCompatibleProvider(
      baseUrl: Uri.parse('http://pi.local:11434/v1'),
      model: 'qwen3.5:4b',
      client: MockClient((r) async {
        sent = r;
        return json(okBody());
      }),
    );
    final completion = await provider.complete(request);

    expect(sent.url.toString(), 'http://pi.local:11434/v1/chat/completions');
    expect(sent.headers.containsKey('authorization'), isFalse);
    final body = jsonDecode(sent.body) as Map<String, Object?>;
    expect(body['model'], 'qwen3.5:4b');
    expect(body['max_tokens'], 4096);
    expect(body['messages'], [
      {'role': 'system', 'content': 'Translate.'},
      {'role': 'user', 'content': 'Sentence: "unread from dana"'},
    ]);
    expect(body['response_format'], {'type': 'json_object'});

    expect(completion.text, '{"expression":"from:dana"}');
    expect(completion.model, 'qwen3.5:4b');
    expect(completion.inputTokens, 80);
    expect(completion.outputTokens, 12);
    expect(provider.id, 'pi.local:qwen3.5:4b');
    expect(provider.location, ProviderLocation.myServer);
    expect(provider.capabilities.constrainedOutput, isFalse);
  });

  test('with jsonSchema on, sends the strict schema under an identifier name; a key becomes a bearer', () async {
    late http.Request sent;
    final provider = OpenAiCompatibleProvider(
      baseUrl: Uri.parse('https://api.example.com/v1/'),
      model: 'm',
      apiKey: 'key-1',
      jsonSchema: true,
      location: ProviderLocation.cloud,
      id: 'example',
      client: MockClient((r) async {
        sent = r;
        return json(okBody());
      }),
    );
    await provider.complete(request);
    expect(sent.url.toString(), 'https://api.example.com/v1/chat/completions');
    expect(sent.headers['authorization'], 'Bearer key-1');
    final format = (jsonDecode(sent.body) as Map<String, Object?>)['response_format'] as Map<String, Object?>;
    expect(format['type'], 'json_schema');
    final js = format['json_schema'] as Map<String, Object?>;
    expect(js['name'], 'search_translate');
    expect(js['strict'], isTrue);
    expect((js['schema'] as Map<String, Object?>)['additionalProperties'], isFalse);
    expect(provider.id, 'example');
    expect(provider.capabilities.constrainedOutput, isTrue);
  });

  test('maps errors: 5xx and 429 retryable, 401 and 404 not', () async {
    Future<AiProviderException> errorFor(int status) async {
      final provider = OpenAiCompatibleProvider(
        baseUrl: Uri.parse('http://pi.local:11434/v1'),
        model: 'm',
        client: MockClient(
          (_) async => json({
            'error': {'message': 'nope', 'type': 'x'},
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

    expect((await errorFor(503)).retryable, isTrue);
    expect((await errorFor(429)).retryable, isTrue);
    final auth = await errorFor(401);
    expect(auth.retryable, isFalse);
    expect(auth.message, 'pi.local did not accept the credentials.');
    expect((await errorFor(404)).message, 'Model m was not found on pi.local.');
  });

  test('a cut-short or filtered answer is an error; a missing choice too', () async {
    for (final (body, expected) in [
      (okBody(finish: 'length'), 'cut short'),
      (okBody(finish: 'content_filter'), 'declined'),
      (<String, Object?>{'choices': <Object?>[]}, 'without a choice'),
    ]) {
      final provider = OpenAiCompatibleProvider(
        baseUrl: Uri.parse('http://pi.local:11434/v1'),
        model: 'm',
        client: MockClient((_) async => json(body)),
      );
      await expectLater(
        provider.complete(request),
        throwsA(isA<AiProviderException>().having((e) => e.message, 'message', contains(expected))),
      );
    }
  });

  test('a server that answers with something other than JSON is a provider error', () async {
    final provider = OpenAiCompatibleProvider(
      baseUrl: Uri.parse('http://pi.local:11434/v1'),
      model: 'm',
      client: MockClient((_) async => http.Response('<html>502</html>', 200)),
    );
    await expectLater(provider.complete(request), throwsA(isA<AiProviderException>()));
  });

  test('works end to end with the runner and the search translator', () async {
    final provider = OpenAiCompatibleProvider(
      baseUrl: Uri.parse('http://pi.local:11434/v1'),
      model: 'm',
      client: MockClient(
        (_) async => json(
          okBody(
            content: '{"expression":"from:dana is:unread","interpretation":"Unread mail from dana.","questions":[]}',
          ),
        ),
      ),
    );
    final run = await AiRunner(provider)
        .run(SearchTranslationTask('unread from dana', now: DateTime.utc(2026, 10, 30)));
    expect((run as AiSuccess<SearchTranslation>).value.expression, 'from:dana is:unread');
    expect(run.record.providerId, 'pi.local:m');
  });
}
