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

/// The Private AI features. Each can be switched off on its own in Settings ›
/// Private AI; with Private AI off, none of them asks a model for anything.
enum AiFeature {
  /// Ask in Plain English, in search.
  search,

  /// Brief, in the reader.
  brief,

  /// Suggested actions for Needs My Action and Waiting on Others.
  actions,

  /// Describe a Rule, in Rules.
  rules,

  /// What Changed, in Compare Messages.
  changes,

  /// Key facts of documents.
  documents,

  /// Reply check, in compose.
  replyCheck,

  /// A matter's latest position.
  matters,
}

/// The features that may ask a model while Private AI is on: all of them
/// until Settings › Private AI turns some off. Features only read this.
final aiFeaturesProvider = Provider<Set<AiFeature>>((ref) => AiFeature.values.toSet());

/// Accounts whose mail never goes to a network provider (Settings › Private
/// AI, per account). Their mail can still use a provider on this phone.
final aiLocalOnlyAccountsProvider = Provider<Set<String>>((ref) => const {});

/// The [AiService] a feature uses for mail of an account (null when the
/// feature isn't about one account's mail), or null when Private AI or the
/// feature is off, or the account keeps its mail on the phone and the
/// provider is a network one. Null means: don't offer the AI part at all.
final aiServiceForProvider = Provider.family<AiService?, (AiFeature, String?)>((ref, use) {
  final (feature, accountId) = use;
  if (!ref.watch(aiFeaturesProvider).contains(feature)) return null;
  final service = ref.watch(aiServiceProvider);
  if (service == null) return null;
  if (accountId != null &&
      service.provider.location != ProviderLocation.onThisPhone &&
      ref.watch(aiLocalOnlyAccountsProvider).contains(accountId)) {
    return null;
  }
  return service;
});
