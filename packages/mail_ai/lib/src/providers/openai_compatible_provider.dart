import 'package:http/http.dart' as http;

import '../provider.dart';
import 'http_support.dart';

/// Any server that speaks the OpenAI chat-completions dialect: Ollama and
/// LM Studio on the user's own machine, or a cloud provider with a key. One
/// request per task, instructions as the system message and the input as the
/// user message. What a given server supports varies, so structured output
/// is opt-in ([jsonSchema]); without it the server is asked for a JSON object
/// and the task's parser does the checking, as it does anyway.
final class OpenAiCompatibleProvider implements AiProvider {
  OpenAiCompatibleProvider({
    required Uri baseUrl,
    required this.model,
    this._apiKey,
    http.Client? client,
    String? id,
    this.location = ProviderLocation.myServer,
    this.timeout = const Duration(seconds: 120),
    this.maxTokens = 4096,
    this.maxInputTokens = 32000,
    this.jsonSchema = false,
  }) : _client = client ?? http.Client(),
       baseUrl = baseUrl,
       id = id ?? '${baseUrl.host}:$model';

  /// Up to and including the API prefix, e.g. `http://pi.local:11434/v1`.
  final Uri baseUrl;
  final String model;
  final String? _apiKey;
  final http.Client _client;
  @override
  final String id;
  @override
  final ProviderLocation location;
  final Duration timeout;
  final int maxTokens;
  final int maxInputTokens;

  /// Send the task's schema as `response_format: json_schema` (strict).
  /// Servers that don't support it answer 400; leave it off for those.
  final bool jsonSchema;

  @override
  ProviderCapabilities get capabilities =>
      ProviderCapabilities(maxInputTokens: maxInputTokens, maxOutputTokens: maxTokens, constrainedOutput: jsonSchema);

  Uri get _url => baseUrl.replace(path: '${baseUrl.path.replaceAll(RegExp(r'/$'), '')}/chat/completions');

  @override
  Future<AiCompletion> complete(AiRequest request, {CancelToken? cancel}) async {
    final body = <String, Object?>{
      'model': model,
      'max_tokens': maxTokens,
      'messages': [
        {'role': 'system', 'content': request.instructions},
        {'role': 'user', 'content': request.input},
      ],
      if (request.schema case final schema?)
        'response_format': jsonSchema
            ? {
                'type': 'json_schema',
                'json_schema': {
                  'name': _schemaName(request.taskType),
                  'schema': normaliseSchema(schema),
                  'strict': true,
                },
              }
            : {'type': 'json_object'},
    };
    final json = await postJson(
      _client,
      _url,
      headers: {if (_apiKey case final key?) 'authorization': 'Bearer $key'},
      body: body,
      timeout: timeout,
      cancel: cancel,
      describeError: _describeError,
    );
    final choices = json['choices'];
    final first = choices is List && choices.isNotEmpty ? choices.first : null;
    if (first is! Map<String, Object?>) throw AiProviderException('${baseUrl.host} answered without a choice.');
    switch (first['finish_reason']) {
      case 'length':
        throw AiProviderException('The answer was cut short at $maxTokens tokens.');
      case 'content_filter':
        throw const AiProviderException('The server declined this request.');
    }
    final message = first['message'];
    final content = message is Map<String, Object?> ? message['content'] : null;
    final usage = json['usage'];
    return AiCompletion(
      content is String ? content : '',
      model: json['model'] is String ? json['model'] as String : model,
      inputTokens: usage is Map<String, Object?> ? _int(usage['prompt_tokens']) : null,
      outputTokens: usage is Map<String, Object?> ? _int(usage['completion_tokens']) : null,
    );
  }

  String _describeError(int status, Map<String, Object?>? error) {
    final message = error?['message'] is String ? error!['message'] as String : null;
    return switch (status) {
      401 || 403 => '${baseUrl.host} did not accept the credentials.',
      404 => 'Model $model was not found on ${baseUrl.host}.',
      429 => '${baseUrl.host} is rate limiting; try again in a moment.',
      >= 500 => '${baseUrl.host} had a problem (HTTP $status); try again in a moment.',
      _ => '${baseUrl.host} rejected the request (HTTP $status)${message == null ? '' : ': $message'}.',
    };
  }

  /// `search.translate` → `search_translate`: the dialect wants an identifier.
  static String _schemaName(String taskType) => taskType.replaceAll(RegExp(r'[^A-Za-z0-9_]'), '_');

  static int? _int(Object? value) => value is int ? value : (value is num ? value.toInt() : null);
}
