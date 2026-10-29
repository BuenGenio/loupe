import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'provider.dart';
import 'task.dart';

enum AiFailureReason {
  /// The input doesn't fit the provider. Nothing was sent; the runner never
  /// trims mail to make it fit.
  tooLarge,
  cancelled,

  /// The provider threw. Nothing was sent anywhere else.
  providerError,

  /// Two answers in a row were rejected by the task's parser.
  invalidOutput,
}

/// What happened in a run, kept with the result so a cached value can be
/// reused (same [inputHash], task type and version) or explained (which
/// provider and model answered, what it cost).
final class AiRunRecord {
  const AiRunRecord({
    required this.taskType,
    required this.taskVersion,
    required this.providerId,
    required this.inputHash,
    required this.startedAt,
    required this.finishedAt,
    required this.attempts,
    this.model,
    this.inputTokens,
    this.outputTokens,
  });

  final String taskType;
  final int taskVersion;
  final String providerId;

  /// SHA-256 of the task type, version, instructions and input ([inputHash]).
  final String inputHash;
  final DateTime startedAt;
  final DateTime finishedAt;

  /// Requests actually sent: 0 (refused before sending), 1 or 2.
  final int attempts;
  final String? model;

  /// Summed over the attempts; null when the provider reports nothing.
  final int? inputTokens;
  final int? outputTokens;
}

sealed class AiRun<T> {
  const AiRun(this.record);
  final AiRunRecord record;
}

final class AiSuccess<T> extends AiRun<T> {
  const AiSuccess(this.value, super.record);
  final T value;
}

final class AiFailure<T> extends AiRun<T> {
  const AiFailure(this.reason, this.message, super.record, {this.retryable = false});
  final AiFailureReason reason;
  final String message;

  /// Whether trying the same provider again later makes sense.
  final bool retryable;
}

/// Hex SHA-256 over what the model sees, so an unchanged task on an unchanged
/// input can reuse its result.
String inputHash(AiTask<Object?> task) =>
    sha256.convert(utf8.encode('${task.type}\n${task.version}\n${task.instructions}\n${task.input}')).toString();

/// Runs tasks on one provider: capability check, request, parse, and one
/// repair attempt that tells the model why its answer was rejected. Then it
/// fails. It never retries beyond that, never falls back to another provider,
/// and never changes the input to make it fit.
final class AiRunner {
  AiRunner(this.provider, {DateTime Function()? now}) : _now = now ?? DateTime.now;

  final AiProvider provider;
  final DateTime Function() _now;

  Future<AiRun<T>> run<T>(AiTask<T> task, {CancelToken? cancel}) async {
    final startedAt = _now();
    final request = task.toRequest();
    final hash = inputHash(task);
    var attempts = 0;
    int? inputTokens;
    int? outputTokens;
    String? model;

    AiRunRecord record() => AiRunRecord(
      taskType: task.type,
      taskVersion: task.version,
      providerId: provider.id,
      inputHash: hash,
      startedAt: startedAt,
      finishedAt: _now(),
      attempts: attempts,
      model: model,
      inputTokens: inputTokens,
      outputTokens: outputTokens,
    );
    AiFailure<T> fail(AiFailureReason reason, String message, {bool retryable = false}) =>
        AiFailure(reason, message, record(), retryable: retryable);

    final caps = provider.capabilities;
    if (request.estimatedInputTokens > caps.maxInputTokens) {
      return fail(
        AiFailureReason.tooLarge,
        'The input is about ${request.estimatedInputTokens} tokens; ${provider.id} takes at most ${caps.maxInputTokens}.',
      );
    }
    if (request.maxOutputTokens > caps.maxOutputTokens) {
      return fail(
        AiFailureReason.tooLarge,
        'The task needs ${request.maxOutputTokens} output tokens; ${provider.id} gives at most ${caps.maxOutputTokens}.',
      );
    }

    var current = request;
    String? lastReason;
    for (var attempt = 1; attempt <= 2; attempt++) {
      if (cancel?.isCancelled ?? false) return fail(AiFailureReason.cancelled, 'Cancelled.');
      attempts++;
      final AiCompletion completion;
      try {
        completion = await provider.complete(current, cancel: cancel);
      } on AiCancelled {
        return fail(AiFailureReason.cancelled, 'Cancelled.');
      } on AiProviderException catch (e) {
        return fail(AiFailureReason.providerError, e.message, retryable: e.retryable);
      }
      model = completion.model ?? model;
      if (completion.inputTokens != null) inputTokens = (inputTokens ?? 0) + completion.inputTokens!;
      if (completion.outputTokens != null) outputTokens = (outputTokens ?? 0) + completion.outputTokens!;

      switch (task.parse(completion.text)) {
        case Parsed(:final value):
          return AiSuccess(value, record());
        case Rejected(:final reason):
          lastReason = reason;
          current = request.withInput(_repairInput(request.input, completion.text, reason));
      }
    }
    return fail(AiFailureReason.invalidOutput, lastReason ?? 'The answer could not be used.');
  }

  /// The repair turn: the original data again, the rejected answer (cut
  /// short) and the parser's reason, so the model fixes that one thing.
  static String _repairInput(String input, String previous, String reason) {
    const keep = 600;
    final shown = previous.length > keep ? '${previous.substring(0, keep)}…' : previous;
    return '$input\n\nYour previous answer could not be used: $reason\nPrevious answer:\n$shown\n\nAnswer again, following the format exactly.';
  }
}
