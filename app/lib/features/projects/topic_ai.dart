import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mail_model/mail_model.dart';

/// A topic the AI server proposed: a name and the conversations in it.
typedef AiTopic = ({String name, List<TopicThread> threads});

/// Groups conversations into topics with an OpenAI-compatible server
/// (`POST <server>/chat/completions`), such as a LocalAI or Ollama on the
/// user's own network.
///
/// What goes to the server, per conversation: its subject, the other
/// people's names and organisation domains, and its first and last date.
/// Never addresses, previews or bodies.
final class TopicAi {
  TopicAi({required String server, required this.model, this.apiKey, this.timeout = const Duration(minutes: 3)})
    : base = normalizeServer(server);

  /// The API's base, ending in `/v1` (added when the user left it out).
  final Uri base;
  final String model;
  final String? apiKey;
  final Duration timeout;

  /// [server] as an API base: a scheme (http when none), and `/v1` when the
  /// path is empty.
  static Uri normalizeServer(String server) {
    var s = server.trim();
    if (!s.contains('://')) s = 'http://$s';
    var uri = Uri.parse(s);
    if (uri.path.isEmpty || uri.path == '/') uri = uri.replace(path: '/v1');
    if (uri.path.endsWith('/')) uri = uri.replace(path: uri.path.substring(0, uri.path.length - 1));
    return uri;
  }

  Uri _url(String path) => base.replace(path: '${base.path}/$path');

  /// The prompt's lines: `t<i> | subject | people | first..last`.
  static String describe(List<TopicThread> threads) {
    String day(DateTime d) => d.toUtc().toIso8601String().substring(0, 10);
    return [
      for (final (i, t) in threads.indexed)
        't$i | ${t.subject.isEmpty ? '(no subject)' : t.subject} | '
            '${_people(t).join(', ')} | ${day(t.first)}..${day(t.last)}',
    ].join('\n');
  }

  static List<String> _people(TopicThread t) => [
    for (final MapEntry(key: email, value: name) in t.people.entries.take(4))
      [if (name.isNotEmpty) name, '@${organisationDomain(email)}'].join(' '),
  ];

  static const _system =
      'You sort a person\'s email conversations into projects: groups of conversations about one thing, such as a '
      'house purchase, a mortgage, a client, a trip or an organisation they deal with. Each line is one conversation: '
      'id | subject | other people | dates. Group only conversations that clearly belong together, at least two per '
      'group; leave the rest out. Name each group in two or three words, in the language of its subjects, like a '
      'folder name. Answer with JSON only, no explanation: {"topics":[{"name":"…","threads":["t0","t3"]}]}';

  /// Asks the server to group [threads]. Throws [TopicAiException] when it
  /// can't be reached, refuses, or answers something else than topics.
  Future<List<AiTopic>> group(List<TopicThread> threads) async {
    if (threads.length < 2) return const [];
    final reply = await _post('chat/completions', {
      'model': model,
      'temperature': 0.2,
      'messages': [
        {'role': 'system', 'content': '$_system /no_think'},
        {'role': 'user', 'content': describe(threads)},
      ],
    });
    final choices = reply['choices'];
    final first = choices is List && choices.isNotEmpty ? choices.first : null;
    final message = first is Map ? first['message'] : null;
    final content = message is Map ? message['content'] : null;
    if (content is! String) throw const TopicAiException(TopicAiError.badAnswer);
    return parseTopics(content, threads);
  }

  /// The topics in a model's [content] (JSON, perhaps in a code fence or
  /// after a `<think>` block), with the conversations they name. Ids that
  /// aren't among [threads], and topics left with fewer than two, are dropped.
  static List<AiTopic> parseTopics(String content, List<TopicThread> threads) {
    var text = content.replaceAll(RegExp(r'<think>[\s\S]*?</think>'), '');
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');
    if (start < 0 || end <= start) throw const TopicAiException(TopicAiError.badAnswer);
    text = text.substring(start, end + 1);
    final Object? json;
    try {
      json = jsonDecode(text);
    } on FormatException {
      throw const TopicAiException(TopicAiError.badAnswer);
    }
    final topics = json is Map ? json['topics'] : null;
    if (topics is! List) throw const TopicAiException(TopicAiError.badAnswer);
    final used = <int>{};
    final out = <AiTopic>[];
    for (final t in topics) {
      if (t is! Map || t['name'] is! String || t['threads'] is! List) continue;
      final name = (t['name'] as String).trim();
      final picked = <TopicThread>[];
      for (final id in t['threads'] as List) {
        final i = int.tryParse('$id'.replaceFirst(RegExp('^t'), ''));
        if (i == null || i < 0 || i >= threads.length || !used.add(i)) continue;
        picked.add(threads[i]);
      }
      if (name.isEmpty || picked.length < 2) continue;
      out.add((name: name, threads: picked..sort((a, b) => b.last.compareTo(a.last))));
    }
    return out;
  }

  /// Checks the server: lists its models and confirms [model] is one.
  /// Returns the models.
  Future<List<String>> models() async {
    final reply = await _send('GET', 'models', null);
    final data = reply['data'];
    final ids = [
      if (data is List)
        for (final m in data)
          if (m is Map && m['id'] is String) m['id'] as String,
    ];
    if (model.isNotEmpty && ids.isNotEmpty && !ids.contains(model)) {
      throw TopicAiException(TopicAiError.noModel, detail: ids.take(8).join(', '));
    }
    return ids;
  }

  Future<Map<Object?, Object?>> _post(String path, Map<String, Object?> body) => _send('POST', path, body);

  Future<Map<Object?, Object?>> _send(String method, String path, Map<String, Object?>? body) async {
    final client = HttpClient()..connectionTimeout = const Duration(seconds: 10);
    try {
      final request = await client.openUrl(method, _url(path)).timeout(timeout);
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');
      final key = apiKey;
      if (key != null && key.isNotEmpty) request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $key');
      if (body != null) {
        request.headers.contentType = ContentType.json;
        request.add(utf8.encode(jsonEncode(body)));
      }
      final response = await request.close().timeout(timeout);
      final text = await response.transform(utf8.decoder).join().timeout(timeout);
      if (response.statusCode == 401 || response.statusCode == 403) {
        throw const TopicAiException(TopicAiError.refused);
      }
      if (response.statusCode >= 400) throw TopicAiException(TopicAiError.status, detail: '${response.statusCode}');
      final json = jsonDecode(text);
      if (json is! Map) throw const TopicAiException(TopicAiError.badAnswer);
      return json;
    } on TopicAiException {
      rethrow;
    } on TimeoutException {
      throw const TopicAiException(TopicAiError.timeout);
    } on FormatException {
      throw const TopicAiException(TopicAiError.badAnswer);
    } on Object catch (e) {
      throw TopicAiException(TopicAiError.unreachable, detail: '${e.runtimeType}');
    } finally {
      client.close(force: true);
    }
  }
}

enum TopicAiError {
  unreachable,

  /// 401 or 403: the key.
  refused,

  /// Another HTTP error; [TopicAiException.detail] is the status.
  status,
  timeout,

  /// Not JSON, or no topics in it.
  badAnswer,

  /// The model isn't the server's; [TopicAiException.detail] lists some it has.
  noModel,
}

final class TopicAiException implements Exception {
  const TopicAiException(this.error, {this.detail = ''});
  final TopicAiError error;
  final String detail;

  @override
  String toString() => 'TopicAiException(${error.name}${detail.isEmpty ? '' : ': $detail'})';
}
