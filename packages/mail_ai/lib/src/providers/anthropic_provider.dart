import 'package:http/http.dart' as http;

import '../provider.dart';
import 'http_support.dart';

/// Claude, through the Messages API, with the user's own key. One request per
/// task: the instructions as the system prompt, the input as the single user
/// turn, the task's schema as a structured-output format. Thinking is left at
/// the model's default and depth is set with [effort]; the key travels only in
/// the header; nothing is logged.
///
/// Server-side fallback is on by default: if a safety classifier declines a
/// request, Anthropic re-runs it on a model suited to the reason instead of
/// returning a refusal. It stays within Anthropic, under the same key and
/// terms; turn it off with [serverSideFallback] to see refusals as errors.
final class AnthropicProvider implements AiProvider {
  AnthropicProvider({
    required this._apiKey,
    this.model = 'claude-opus-5-5',
    http.Client? client,
    Uri? baseUrl,
    this.timeout = const Duration(seconds: 90),
    this.maxTokens = 8192,
    this.maxInputTokens = 200000,
    this.effort = 'low',
    this.serverSideFallback = true,
  }) : _client = client ?? http.Client(),
       baseUrl = baseUrl ?? Uri.parse('https://api.anthropic.com');

  final String _apiKey;
  final http.Client _client;
  final Uri baseUrl;
  final String model;
  final Duration timeout;

  /// The request's `max_tokens`. Thinking counts towards it, so it is well
  /// above any task's output budget.
  final int maxTokens;
  final int maxInputTokens;

  /// `output_config.effort`: low, medium, high, xhigh or max. Extraction over
  /// one message is served well by low; null leaves the model's default.
  final String? effort;
  final bool serverSideFallback;

  static const apiVersion = '2023-06-01';
  static const fallbackBeta = 'server-side-fallback-2026-07-01';

  @override
  String get id => 'anthropic:$model';
  @override
  ProviderLocation get location => ProviderLocation.cloud;
  @override
  ProviderCapabilities get capabilities =>
      ProviderCapabilities(maxInputTokens: maxInputTokens, maxOutputTokens: maxTokens, constrainedOutput: true);

  Uri get _url => baseUrl.replace(path: '${baseUrl.path.replaceAll(RegExp(r'/$'), '')}/v1/messages');

  @override
  Future<AiCompletion> complete(AiRequest request, {CancelToken? cancel}) async {
    final body = <String, Object?>{
      'model': model,
      'max_tokens': maxTokens,
      'system': request.instructions,
      'messages': [
        {'role': 'user', 'content': request.input},
      ],
      if (effort != null || request.schema != null)
        'output_config': {
          if (effort != null) 'effort': effort,
          if (request.schema case final schema?) 'format': {'type': 'json_schema', 'schema': normaliseSchema(schema)},
        },
      if (serverSideFallback) 'fallbacks': 'default',
    };
    final json = await postJson(
      _client,
      _url,
      headers: {
        'x-api-key': _apiKey,
        'anthropic-version': apiVersion,
        if (serverSideFallback) 'anthropic-beta': fallbackBeta,
      },
      body: body,
      timeout: timeout,
      cancel: cancel,
      describeError: _describeError,
    );
    switch (json['stop_reason']) {
      case 'refusal':
        throw const AiProviderException('The model declined this request.');
      case 'max_tokens':
        throw AiProviderException('The answer was cut short at $maxTokens tokens.');
    }
    final content = json['content'];
    final text = StringBuffer();
    if (content is List) {
      for (final block in content) {
        if (block is Map<String, Object?> && block['type'] == 'text' && block['text'] is String) {
          text.write(block['text']);
        }
      }
    }
    final usage = json['usage'];
    return AiCompletion(
      text.toString(),
      model: json['model'] is String ? json['model'] as String : model,
      inputTokens: usage is Map<String, Object?> ? _int(usage['input_tokens']) : null,
      outputTokens: usage is Map<String, Object?> ? _int(usage['output_tokens']) : null,
    );
  }

  String _describeError(int status, Map<String, Object?>? error) {
    final message = error?['message'] is String ? error!['message'] as String : null;
    return switch (error?['type']) {
      'authentication_error' => 'Anthropic did not accept the API key.',
      'permission_error' => 'This API key is not allowed to do that.',
      'billing_error' => 'Anthropic reports a billing problem with this key.',
      'not_found_error' => 'Model $model is not available to this key.',
      'rate_limit_error' => 'Anthropic\'s rate limit was reached; try again in a moment.',
      'overloaded_error' => 'Anthropic is overloaded; try again in a moment.',
      'request_too_large' => 'The request is too large for Anthropic.',
      'invalid_request_error' => 'Anthropic rejected the request${message == null ? '' : ': $message'}.',
      _ => 'Anthropic answered HTTP $status${message == null ? '' : ': $message'}.',
    };
  }

  static int? _int(Object? value) => value is int ? value : (value is num ? value.toInt() : null);
}
