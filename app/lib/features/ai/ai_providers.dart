import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_ai/mail_ai.dart';

import '../../settings/app_settings.dart';
import 'demo_ai_provider.dart';

/// The model behind Private AI, or null when it is off (Settings › Private
/// AI). Off means nothing asks a model for anything. Until a real provider
/// ships, on means the built-in demo: a few rules, no model, no network;
/// results say so.
final aiProviderProvider = Provider<AiProvider?>((ref) {
  if (!ref.watch(appSettingsProvider.select((s) => s.aiAssist))) return null;
  return DemoAiProvider();
});

/// What Private AI did on this phone, for Settings › Private AI: every run's
/// record (requests, tokens, which provider and model) and the results kept
/// for reuse. Results are derived mail data: device-local, in memory, and
/// cleared by [clearResults] without touching mail or anything the user
/// decided (a ticked item, an action, a matter).
final class AiLedger extends ChangeNotifier {
  final _records = <AiRunRecord>[];
  final _results = <String, AiSuccess<Object?>>{};

  List<AiRunRecord> get records => List.unmodifiable(_records);
  int get resultCount => _results.length;

  void clearResults() {
    _results.clear();
    notifyListeners();
  }

  void _record(AiRunRecord record) {
    _records.add(record);
    notifyListeners();
  }
}

final aiLedgerProvider = Provider<AiLedger>((ref) {
  final ledger = AiLedger();
  ref.onDispose(ledger.dispose);
  return ledger;
});

/// Runs the features' tasks on the chosen provider. An unchanged task on an
/// unchanged input reuses its earlier result from the same provider; every
/// request actually sent is recorded in the [AiLedger]. Nothing here picks
/// another provider when one fails.
final class AiService {
  AiService(this.provider, this.ledger, {DateTime Function()? now}) : _runner = AiRunner(provider, now: now);

  final AiProvider provider;
  final AiLedger ledger;
  final AiRunner _runner;

  /// The result of an earlier run of [task] on this provider, if there is one.
  AiSuccess<T>? cached<T>(AiTask<T> task) => switch (ledger._results[_key(task)]) {
    final AiSuccess<T> hit => hit,
    _ => null,
  };

  Future<AiRun<T>> run<T>(AiTask<T> task, {CancelToken? cancel, bool reuse = true}) async {
    if (reuse) {
      if (cached(task) case final hit?) return hit;
    }
    final run = await _runner.run(task, cancel: cancel);
    if (run.record.attempts > 0) ledger._record(run.record);
    if (run is AiSuccess<T>) ledger._results[_key(task)] = run;
    return run;
  }

  String _key(AiTask<Object?> task) => '${provider.id}\n${inputHash(task)}';
}

/// The [AiService] for the current provider, or null when Private AI is off.
final aiServiceProvider = Provider<AiService?>((ref) {
  final provider = ref.watch(aiProviderProvider);
  if (provider == null) return null;
  return AiService(provider, ref.watch(aiLedgerProvider));
});
