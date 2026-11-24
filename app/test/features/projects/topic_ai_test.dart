import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/projects/topic_ai.dart';
import 'package:mail_model/mail_model.dart';

/// The AI pass against a fake OpenAI-compatible server: what is sent, and
/// how answers (and failures) come back.

TopicThread _thread(int i, String subject, String from, String name) {
  final e = EmailSummary(
    id: 'a|INBOX|1|$i',
    accountId: 'a',
    mailboxId: 'a|INBOX',
    threadId: 't$i',
    receivedAt: DateTime.utc(2026, 9, i + 1),
    subject: subject,
    from: [EmailAddress(from, name)],
    to: const [EmailAddress('me@home.example')],
    preview: 'secret body text',
  );
  return topicThreads([e], myAddresses: {'me@home.example'}).single;
}

void main() {
  late HttpServer server;
  late List<Map<String, Object?>> requests;
  late String reply;
  var status = 200;

  setUp(() async {
    requests = [];
    status = 200;
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((r) async {
      final body = await utf8.decoder.bind(r).join();
      requests.add({
        'method': r.method,
        'path': r.uri.path,
        'auth': r.headers.value(HttpHeaders.authorizationHeader),
        if (body.isNotEmpty) 'body': jsonDecode(body),
      });
      r.response.statusCode = status;
      r.response.headers.contentType = ContentType.json;
      r.response.write(r.uri.path.endsWith('/models') ? '{"data":[{"id":"qwen3-4b"},{"id":"kokoro"}]}' : reply);
      await r.response.close();
    });
  });
  tearDown(() => server.close(force: true));

  String chat(String content) => jsonEncode({
    'choices': [
      {
        'message': {'role': 'assistant', 'content': content},
      },
    ],
  });

  test('the server address gets a scheme and /v1 when left out', () {
    expect(TopicAi.normalizeServer('mailbox-ai:8080').toString(), 'http://mailbox-ai:8080/v1');
    expect(TopicAi.normalizeServer('https://ai.example/v1/').toString(), 'https://ai.example/v1');
    expect(TopicAi.normalizeServer('http://h:1/openai/v1').path, '/openai/v1');
  });

  test('sends subjects, names, domains and dates only; reads topics from a fenced, thinking answer', () async {
    final threads = [
      _thread(0, 'Mortgage offer', 'lender@bank.example', 'Ana Lender'),
      _thread(1, 'Valuation survey', 'surveyor@survey.example', 'Bo'),
      _thread(2, 'Dinner Saturday?', 'friend@gmail.com', 'Cy'),
      _thread(3, 'Re: mortgage documents', 'lender@bank.example', 'Ana Lender'),
    ];
    reply = chat(
      '<think>hm</think>\n```json\n{"topics":[{"name":"Mortgage","threads":["t0","t1","t3","t9"]},'
      '{"name":"Alone","threads":["t2"]}]}\n```',
    );
    final ai = TopicAi(server: 'http://127.0.0.1:${server.port}', model: 'qwen3-4b', apiKey: 'k-123');
    final topics = await ai.group(threads);
    expect(topics.map((t) => t.name), ['Mortgage'], reason: 'a topic of one, and unknown ids, are dropped');
    expect(topics.single.threads.map((t) => t.subject), ['mortgage documents', 'Valuation survey', 'Mortgage offer']);

    final sent = requests.single;
    expect((sent['method'], sent['path'], sent['auth']), ('POST', '/v1/chat/completions', 'Bearer k-123'));
    final body = sent['body']! as Map<String, Object?>;
    expect(body['model'], 'qwen3-4b');
    final text = jsonEncode(body['messages']);
    expect(text, contains('t0 | Mortgage offer | Ana Lender @bank.example | 2026-09-01..2026-09-01'));
    expect(text, isNot(contains('lender@bank.example')), reason: 'no addresses');
    expect(text, isNot(contains('secret body text')), reason: 'no previews or bodies');
  });

  test('failures say why', () async {
    final ai = TopicAi(server: 'http://127.0.0.1:${server.port}', model: 'llama9');
    final threads = [_thread(0, 'A', 'a@x.example', 'A'), _thread(1, 'B', 'b@x.example', 'B')];
    reply = chat('I could not do it.');
    await expectLater(
      ai.group(threads),
      throwsA(isA<TopicAiException>().having((e) => e.error, 'error', TopicAiError.badAnswer)),
    );
    await expectLater(
      ai.models(),
      throwsA(
        isA<TopicAiException>()
            .having((e) => e.error, 'error', TopicAiError.noModel)
            .having((e) => e.detail, 'detail', 'qwen3-4b, kokoro'),
      ),
    );
    status = 401;
    await expectLater(
      ai.group(threads),
      throwsA(isA<TopicAiException>().having((e) => e.error, 'error', TopicAiError.refused)),
    );
    await server.close(force: true);
    await expectLater(
      ai.group(threads),
      throwsA(isA<TopicAiException>().having((e) => e.error, 'error', TopicAiError.unreachable)),
    );
  });
}
