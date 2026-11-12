import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../provider.dart';

/// What the network adapters share: one JSON POST with a timeout, HTTP status
/// and transport failures mapped to [AiProviderException] (408, 409, 429 and
/// 5xx retryable, other 4xx not, timeouts and connection errors retryable),
/// the cancel token checked before and after. Nothing here logs the request,
/// the headers or the body: they carry the key and the mail.
Future<Map<String, Object?>> postJson(
  http.Client client,
  Uri url, {
  required Map<String, String> headers,
  required Map<String, Object?> body,
  required Duration timeout,
  required String Function(int status, Map<String, Object?>? error) describeError,
  CancelToken? cancel,
}) async {
  if (cancel?.isCancelled ?? false) throw const AiCancelled();
  final http.Response response;
  try {
    response = await client
        .post(url, headers: {...headers, 'content-type': 'application/json'}, body: jsonEncode(body))
        .timeout(timeout);
  } on TimeoutException {
    throw AiProviderException('No answer from ${url.host} within ${timeout.inSeconds} s.', retryable: true);
  } on http.ClientException catch (e) {
    throw AiProviderException('Could not reach ${url.host}: ${e.message}', retryable: true);
  } on SocketException catch (e) {
    throw AiProviderException('Could not reach ${url.host}: ${e.osError?.message ?? e.message}', retryable: true);
  } on HandshakeException {
    throw AiProviderException('The connection to ${url.host} is not trusted (TLS).');
  }
  if (cancel?.isCancelled ?? false) throw const AiCancelled();
  final decoded = _decodeObject(response.body);
  if (response.statusCode < 200 || response.statusCode >= 300) {
    final error = decoded?['error'];
    throw AiProviderException(
      describeError(response.statusCode, error is Map<String, Object?> ? error : null),
      retryable: isRetryableStatus(response.statusCode),
    );
  }
  if (decoded == null) throw AiProviderException('${url.host} answered with something that is not JSON.');
  return decoded;
}

bool isRetryableStatus(int status) => status == 408 || status == 409 || status == 429 || status >= 500;

Map<String, Object?>? _decodeObject(String body) {
  try {
    final decoded = jsonDecode(body);
    return decoded is Map<String, Object?> ? decoded : null;
  } on FormatException {
    return null;
  }
}

/// Structured-output dialects differ in small ways. This keeps a task's
/// schema portable: `"type": ["string", "null"]` becomes `anyOf`, which both
/// Anthropic and OpenAI-style servers accept, and every object gets
/// `additionalProperties: false`, which they require.
Map<String, Object?> normaliseSchema(Map<String, Object?> schema) {
  final out = <String, Object?>{};
  for (final MapEntry(:key, :value) in schema.entries) {
    out[key] = switch (key) {
      'properties' when value is Map<String, Object?> => {
        for (final MapEntry(key: name, value: sub) in value.entries)
          name: sub is Map<String, Object?> ? normaliseSchema(sub) : sub,
      },
      'items' when value is Map<String, Object?> => normaliseSchema(value),
      'anyOf' ||
      'allOf' ||
      'oneOf' when value is List => [for (final sub in value) sub is Map<String, Object?> ? normaliseSchema(sub) : sub],
      _ => value,
    };
  }
  if (out['type'] case final List<Object?> types) {
    out.remove('type');
    out['anyOf'] = [
      for (final t in types) <String, Object?>{'type': t},
    ];
  }
  if (out['type'] == 'object' && !out.containsKey('additionalProperties')) out['additionalProperties'] = false;
  return out;
}
