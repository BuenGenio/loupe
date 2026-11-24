import 'dart:math';

import 'provider.dart';

/// A provider with no model behind it, for tests and the demo repository.
/// Answers come from a list, in order, the last one repeating, or from a
/// [script] that sees each request. Every request is recorded.
final class FakeProvider implements AiProvider {
  FakeProvider({
    List<String> answers = const [],
    this.id = 'fake',
    this.location = ProviderLocation.onThisPhone,
    this.capabilities = const ProviderCapabilities(
      maxInputTokens: 8000,
      maxOutputTokens: 2000,
      constrainedOutput: true,
    ),
    this.model = 'fake-1',
  }) : _answers = List.of(answers),
       script = null;

  FakeProvider.scripted(
    String Function(AiRequest request) this.script, {
    this.id = 'fake',
    this.location = ProviderLocation.onThisPhone,
    this.capabilities = const ProviderCapabilities(
      maxInputTokens: 8000,
      maxOutputTokens: 2000,
      constrainedOutput: true,
    ),
    this.model = 'fake-1',
  }) : _answers = const [];

  @override
  final String id;
  @override
  final ProviderLocation location;
  @override
  final ProviderCapabilities capabilities;
  final String model;
  final List<String> _answers;
  final String Function(AiRequest request)? script;

  /// Every request received, in order.
  final List<AiRequest> requests = [];

  /// Thrown by the next [complete] calls instead of answering.
  Object? failWith;

  /// Waited before answering, so tests can cancel mid-flight.
  Duration delay = Duration.zero;

  @override
  Future<AiCompletion> complete(AiRequest request, {CancelToken? cancel}) async {
    requests.add(request);
    if (cancel?.isCancelled ?? false) throw const AiCancelled();
    if (failWith case final error?) throw error;
    if (delay > Duration.zero) await Future<void>.delayed(delay);
    if (cancel?.isCancelled ?? false) throw const AiCancelled();
    final String text;
    if (script case final script?) {
      text = script(request);
    } else if (_answers.isEmpty) {
      throw StateError('FakeProvider has no answer for ${request.taskType}');
    } else {
      text = _answers[min(requests.length - 1, _answers.length - 1)];
    }
    return AiCompletion(
      text,
      model: model,
      inputTokens: request.estimatedInputTokens,
      outputTokens: text.length ~/ 4 + 1,
    );
  }
}
