import 'dart:convert';

import 'package:mail_ai/mail_ai.dart';

/// A model's list price, in US dollars per million tokens.
final class AiPrice {
  const AiPrice({required this.input, required this.output});

  final double input;
  final double output;
}

/// The prices Settings › Private AI estimates with: [source]'s list prices
/// as of [asOf]. A model that isn't listed has an unknown cost, and the demo
/// costs nothing. Estimates, not a bill: the provider's own usage page is.
abstract final class AiPrices {
  static const source = 'Anthropic';
  static final asOf = DateTime(2026, 10, 6);

  /// For prompts up to 100K tokens; Haiku costs more above that, which the
  /// estimate leaves out (one message is far below it).
  static const anthropic = <String, AiPrice>{
    'claude-opus-5-5': AiPrice(input: 4, output: 20),
    'claude-sonnet-5-5': AiPrice(input: 2, output: 10),
    'claude-haiku-5-5': AiPrice(input: 0.10, output: 0.50),
  };

  /// The price of [model] as [providerId] served it, or null when unknown.
  /// Only Anthropic's own API has these prices: the same model name on
  /// another server costs what that server charges.
  static AiPrice? of(String providerId, String? model) {
    const prefix = 'anthropic:';
    if (!providerId.startsWith(prefix)) return null;
    final name = model ?? providerId.substring(prefix.length);
    for (final MapEntry(:key, :value) in anthropic.entries) {
      // A dated snapshot (`claude-…-20261001`) has its model's price.
      if (name == key || name.startsWith('$key-')) return value;
    }
    return null;
  }
}

/// What a period's requests cost, as far as can be told.
sealed class AiCost {
  const AiCost();
}

/// Ran on this phone: nothing to pay.
final class AiNoCost extends AiCost {
  const AiNoCost();
}

/// No price is known for the model, or the provider reported no tokens.
final class AiUnknownCost extends AiCost {
  const AiUnknownCost();
}

/// An estimate from list prices. [atLeast] when some requests had no token
/// counts: those are left out, never priced as zero tokens.
final class AiEstimatedCost extends AiCost {
  const AiEstimatedCost(this.dollars, {this.atLeast = false});

  final double dollars;
  final bool atLeast;
}

enum AiUsagePeriod { today, thisMonth, all }

/// The requests one provider and model answered in a period. Token counts a
/// provider didn't report are left out of the sums and counted in
/// [unreportedRequests]: unknown is never shown as 0.
final class AiUsage {
  const AiUsage({
    required this.providerId,
    required this.model,
    required this.requests,
    required this.inputTokens,
    required this.outputTokens,
    required this.unreportedRequests,
  });

  final String providerId;

  /// As the provider reported it; null when it reported none.
  final String? model;

  /// Requests sent: a run's repair attempt is a second request.
  final int requests;
  final int inputTokens;
  final int outputTokens;
  final int unreportedRequests;

  bool get anyReported => unreportedRequests < requests;

  AiCost get cost {
    if (providerId == 'demo') return const AiNoCost();
    final price = AiPrices.of(providerId, model);
    if (price == null || !anyReported) return const AiUnknownCost();
    final dollars = (inputTokens * price.input + outputTokens * price.output) / 1000000;
    return AiEstimatedCost(dollars, atLeast: unreportedRequests > 0);
  }
}

/// When [period] began, at [now]; null for all of time.
DateTime? periodStart(AiUsagePeriod period, DateTime now) => switch (period) {
  AiUsagePeriod.today => DateTime(now.year, now.month, now.day),
  AiUsagePeriod.thisMonth => DateTime(now.year, now.month),
  AiUsagePeriod.all => null,
};

/// [records] started in [period], by provider and model, busiest first.
List<AiUsage> usageIn(Iterable<AiRunRecord> records, AiUsagePeriod period, {required DateTime now}) {
  final start = periodStart(period, now);
  final groups = <(String, String?), List<AiRunRecord>>{};
  for (final r in records) {
    if (start != null && r.startedAt.isBefore(start)) continue;
    groups.putIfAbsent((r.providerId, r.model), () => []).add(r);
  }
  final usage = [
    for (final MapEntry(key: (providerId, model), value: runs) in groups.entries)
      AiUsage(
        providerId: providerId,
        model: model,
        requests: runs.fold(0, (sum, r) => sum + r.attempts),
        inputTokens: runs.fold(0, (sum, r) => sum + (r.inputTokens ?? 0)),
        outputTokens: runs.fold(0, (sum, r) => sum + (r.outputTokens ?? 0)),
        unreportedRequests: runs
            .where((r) => r.inputTokens == null || r.outputTokens == null)
            .fold(0, (sum, r) => sum + r.attempts),
      ),
  ];
  return usage..sort((a, b) => b.requests.compareTo(a.requests));
}

/// The cost of all of [usage]: the estimates added up, at least that much
/// when part of it is unknown.
AiCost totalCost(Iterable<AiUsage> usage) {
  var dollars = 0.0;
  var estimated = false;
  var unknown = false;
  for (final cost in usage.map((u) => u.cost)) {
    switch (cost) {
      case AiNoCost():
        break;
      case AiUnknownCost():
        unknown = true;
      case AiEstimatedCost(dollars: final d, :final atLeast):
        dollars += d;
        estimated = true;
        unknown |= atLeast;
    }
  }
  if (estimated) return AiEstimatedCost(dollars, atLeast: unknown);
  return unknown ? const AiUnknownCost() : const AiNoCost();
}

/// A run record as the phone keeps it: which task ran on which provider and
/// model, when, in how many requests, and the token counts reported. Never
/// the input, its hash or the answer.
String encodeRunRecord(AiRunRecord r) => jsonEncode({
  'task': r.taskType,
  'version': r.taskVersion,
  'provider': r.providerId,
  'model': ?r.model,
  'attempts': r.attempts,
  'started': r.startedAt.millisecondsSinceEpoch,
  'finished': r.finishedAt.millisecondsSinceEpoch,
  'input': ?r.inputTokens,
  'output': ?r.outputTokens,
});

/// [encodeRunRecord]'s output as a record, or null when it isn't one. A kept
/// record has no input hash: that only matters for reusing a result, and
/// results are not kept across restarts.
AiRunRecord? decodeRunRecord(String json) {
  final Object? d;
  try {
    d = jsonDecode(json);
  } on FormatException {
    return null;
  }
  if (d is! Map<String, Object?>) return null;
  if (d case {
    'task': final String task,
    'version': final int version,
    'provider': final String provider,
    'attempts': final int attempts,
    'started': final int started,
    'finished': final int finished,
  }) {
    final model = d['model'];
    final input = d['input'];
    final output = d['output'];
    return AiRunRecord(
      taskType: task,
      taskVersion: version,
      providerId: provider,
      inputHash: '',
      startedAt: DateTime.fromMillisecondsSinceEpoch(started),
      finishedAt: DateTime.fromMillisecondsSinceEpoch(finished),
      attempts: attempts,
      model: model is String ? model : null,
      inputTokens: input is int ? input : null,
      outputTokens: output is int ? output : null,
    );
  }
  return null;
}
