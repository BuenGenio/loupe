/// Where a provider runs, as Settings names it. "My server" is network
/// processing too and is labelled as such; the only route that never leaves
/// the phone is [onThisPhone].
enum ProviderLocation { onThisPhone, myServer, cloud }

/// What a provider can take. These are the provider's own limits, checked
/// before a request is sent; a task's size hint is only for routing.
final class ProviderCapabilities {
  const ProviderCapabilities({
    required this.maxInputTokens,
    required this.maxOutputTokens,
    this.constrainedOutput = false,
    this.foregroundOnly = false,
  });

  final int maxInputTokens;
  final int maxOutputTokens;

  /// Can hold the output to a JSON schema while decoding. The answer is
  /// validated by the task either way: a well-formed answer can still be wrong.
  final bool constrainedOutput;

  /// Only runs while the app is in the foreground (ML Kit GenAI, for one).
  /// Consent, charging or a foreground service don't lift this.
  final bool foregroundOnly;
}

/// One call to a model. [instructions] say what to do, [input] is the bounded
/// data to do it with, and the two are kept apart so a provider can send them
/// as separate turns: mail and sentences in [input] are never instructions.
final class AiRequest {
  const AiRequest({
    required this.taskType,
    required this.instructions,
    required this.input,
    required this.maxOutputTokens,
    this.schema,
  });

  final String taskType;
  final String instructions;
  final String input;
  final int maxOutputTokens;

  /// A JSON schema for the answer, for providers with [ProviderCapabilities.constrainedOutput].
  final Map<String, Object?>? schema;

  /// A rough size for the capability check, about four characters per token.
  int get estimatedInputTokens => (instructions.length + input.length) ~/ 4 + 1;

  AiRequest withInput(String input) => AiRequest(
    taskType: taskType,
    instructions: instructions,
    input: input,
    maxOutputTokens: maxOutputTokens,
    schema: schema,
  );
}

/// A model's answer, with what the provider reported about it. Token counts
/// are null when the provider doesn't report them; they are never shown as 0.
final class AiCompletion {
  const AiCompletion(this.text, {this.model, this.inputTokens, this.outputTokens});

  final String text;
  final String? model;
  final int? inputTokens;
  final int? outputTokens;
}

/// Thrown by a provider when its request was cancelled.
final class AiCancelled implements Exception {
  const AiCancelled();

  @override
  String toString() => 'AiCancelled';
}

/// Thrown by a provider for anything else: no network, a quota, a model that
/// isn't downloaded. [retryable] says whether trying again later makes sense.
/// The runner never answers one of these by trying another provider.
final class AiProviderException implements Exception {
  const AiProviderException(this.message, {this.retryable = false});

  final String message;
  final bool retryable;

  @override
  String toString() => 'AiProviderException: $message';
}

/// Cancels a run. The runner checks it before every request; a provider
/// checks it while a request is in flight.
final class CancelToken {
  bool _cancelled = false;
  bool get isCancelled => _cancelled;
  void cancel() => _cancelled = true;
}

/// A model behind one interface: on the phone, on the user's server or in a
/// cloud of their choosing. Providers receive instructions and data and return
/// text; they get no mail actions, no credentials and no tools.
abstract interface class AiProvider {
  /// Stable, shown beside results ("fake", "anthropic:claude-…").
  String get id;
  ProviderLocation get location;
  ProviderCapabilities get capabilities;

  /// Throws [AiCancelled] or [AiProviderException]; anything else is a bug.
  Future<AiCompletion> complete(AiRequest request, {CancelToken? cancel});
}
