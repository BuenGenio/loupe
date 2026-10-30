import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mail_ai/mail_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../settings/app_settings.dart';
import 'ai_settings.dart';
import 'ai_usage.dart';
import 'demo_ai_provider.dart';

/// The model behind Private AI, or null when nothing may be asked: Private
/// AI is off, or the provider picked in Settings › Private AI isn't set up
/// (Anthropic without its key, a server without its address or model, the
/// on-phone model that isn't there yet). Null never means "try another":
/// features then show no AI part. The keys come from the keychain once
/// ([aiKeysProvider]); until they have, a network provider is null too.
final aiProviderProvider = Provider<AiProvider?>((ref) {
  if (!ref.watch(appSettingsProvider.select((s) => s.aiAssist))) return null;
  final config = ref.watch(aiConfigProvider);
  if (!config.kind.isNetwork) return buildAiProvider(config);
  final keys = ref.watch(aiKeysProvider);
  if (!keys.hasValue) return null;
  return buildAiProvider(config, key: keys.value![config.kind], client: ref.watch(aiHttpClientProvider));
});

/// The adapter for [config], or null when it isn't set up. [key] is the
/// provider's own (Anthropic's is required, a server's optional), sent in
/// the request's header only. Nothing here falls back to another provider.
AiProvider? buildAiProvider(AiConfig config, {String? key, http.Client? client}) {
  switch (config.kind) {
    case AiProviderKind.demo:
      return DemoAiProvider();
    case AiProviderKind.onThisPhone:
      return null;
    case AiProviderKind.anthropic:
      if (key == null || key.isEmpty) return null;
      return AnthropicProvider(
        apiKey: key,
        model: config.anthropicModel,
        client: client,
        // Anthropic has no server-side fallback for Haiku: it answers a refusal itself.
        serverSideFallback: !config.anthropicModel.startsWith('claude-haiku'),
      );
    case AiProviderKind.myServer:
      final uri = config.serverUri;
      final model = config.serverModel.trim();
      if (uri == null || model.isEmpty) return null;
      return OpenAiCompatibleProvider(
        baseUrl: uri,
        model: model,
        apiKey: key == null || key.isEmpty ? null : key,
        client: client,
      );
  }
}

/// What Private AI did on this phone, for Settings › Private AI: every run's
/// record (requests, tokens, which provider and model) and the results kept
/// for reuse. Results are derived mail data: device-local, in memory, and
/// cleared by [clearResults] without touching mail or anything the user
/// decided (a ticked item, an action, a matter).
///
/// With [prefs], the records (never the results) are kept across restarts,
/// the last [maxRecords] of them, as [encodeRunRecord] writes them: no
/// input, no input hash, no answer.
final class AiLedger extends ChangeNotifier {
  AiLedger({SharedPreferences? prefs}) : _prefs = prefs {
    for (final json in prefs?.getStringList(recordsKey) ?? const <String>[]) {
      if (decodeRunRecord(json) case final record?) _records.add(record);
    }
  }

  static const recordsKey = 'ai.usage';
  static const maxRecords = 1000;

  final SharedPreferences? _prefs;
  final _records = <AiRunRecord>[];
  final _results = <String, AiSuccess<Object?>>{};
  bool _disposed = false;

  List<AiRunRecord> get records => List.unmodifiable(_records);
  int get resultCount => _results.length;

  /// How many kept results came from providers [from] accepts (by id).
  int resultsFrom(bool Function(String providerId) from) =>
      _results.values.where((r) => from(r.record.providerId)).length;

  /// Deletes the kept results, or only those of providers [from] accepts
  /// (by id). Features make them again when they are needed.
  void clearResults({bool Function(String providerId)? from}) {
    if (from == null) {
      _results.clear();
    } else {
      _results.removeWhere((_, r) => from(r.record.providerId));
    }
    notifyListeners();
  }

  void _record(AiRunRecord record) {
    // A run that ends after Reset App belongs to a ledger that's gone.
    if (_disposed) return;
    _records.add(record);
    if (_records.length > maxRecords) _records.removeRange(0, _records.length - maxRecords);
    unawaited(_prefs?.setStringList(recordsKey, [for (final r in _records) encodeRunRecord(r)]));
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

final aiLedgerProvider = Provider<AiLedger>((ref) {
  final ledger = AiLedger(prefs: aiPreferences(ref));
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
  final _running = <CancelToken>{};
  bool _closed = false;

  /// The result of an earlier run of [task] on this provider, if there is one.
  AiSuccess<T>? cached<T>(AiTask<T> task) => switch (ledger._results[_key(task)]) {
    final AiSuccess<T> hit => hit,
    _ => null,
  };

  /// Runs [task], or with [reuse] returns its earlier result. With [keep]
  /// false the new result isn't kept for reuse (a connection test is no
  /// derived mail data); the request is recorded either way.
  Future<AiRun<T>> run<T>(AiTask<T> task, {CancelToken? cancel, bool reuse = true, bool keep = true}) async {
    if (reuse) {
      if (cached(task) case final hit?) return hit;
    }
    final token = cancel ?? CancelToken();
    // A closed service sends nothing: the runner checks the token first.
    if (_closed) token.cancel();
    _running.add(token);
    try {
      final run = await _runner.run(task, cancel: token);
      if (run.record.attempts > 0) ledger._record(run.record);
      if (run is AiSuccess<T> && keep) ledger._results[_key(task)] = run;
      return run;
    } finally {
      _running.remove(token);
    }
  }

  /// Cancels the runs in flight and refuses new ones: Private AI was turned
  /// off, or the provider changed or lost its key. A request already sent
  /// can't be called back; its answer is dropped when it arrives.
  void close() {
    _closed = true;
    for (final token in _running) {
      token.cancel();
    }
  }

  String _key(AiTask<Object?> task) => '${provider.id}\n${inputHash(task)}';
}

/// The [AiService] for the current provider, or null when Private AI is off
/// or not set up. A new provider closes the old service.
final aiServiceProvider = Provider<AiService?>((ref) {
  final provider = ref.watch(aiProviderProvider);
  if (provider == null) return null;
  final service = AiService(provider, ref.watch(aiLedgerProvider));
  ref.onDispose(service.close);
  return service;
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
final aiFeaturesProvider = Provider<Set<AiFeature>>((ref) => ref.watch(aiFeatureSettingsProvider));

/// Settings › Private AI's switch per feature, persisted as the features
/// turned off (`ai.features.off`), so a feature added later starts on.
final aiFeatureSettingsProvider = NotifierProvider<AiFeatureSettings, Set<AiFeature>>(AiFeatureSettings.new);

class AiFeatureSettings extends Notifier<Set<AiFeature>> {
  static const key = 'ai.features.off';

  @override
  Set<AiFeature> build() {
    final off = aiPreferences(ref)?.getStringList(key) ?? const <String>[];
    return {
      for (final f in AiFeature.values)
        if (!off.contains(f.name)) f,
    };
  }

  Future<void> set(AiFeature feature, bool on) async {
    state = on ? {...state, feature} : ({...state}..remove(feature));
    await ref.read(sharedPreferencesProvider).setStringList(key, [
      for (final f in AiFeature.values)
        if (!state.contains(f)) f.name,
    ]);
  }
}

/// Accounts whose mail never goes to a network provider (Settings › Private
/// AI, per account). Their mail can still use a provider on this phone.
final aiLocalOnlyAccountsProvider = Provider<Set<String>>((ref) => ref.watch(aiLocalOnlySettingsProvider));

/// Settings › Private AI's Keep Mail on the Phone, by account id, persisted
/// as `ai.localOnlyAccounts`. Off for every account until switched on.
final aiLocalOnlySettingsProvider = NotifierProvider<AiLocalOnlySettings, Set<String>>(AiLocalOnlySettings.new);

class AiLocalOnlySettings extends Notifier<Set<String>> {
  static const key = 'ai.localOnlyAccounts';

  @override
  Set<String> build() => {...?aiPreferences(ref)?.getStringList(key)};

  Future<void> set(String accountId, bool localOnly) async {
    state = localOnly ? {...state, accountId} : ({...state}..remove(accountId));
    await ref.read(sharedPreferencesProvider).setStringList(key, state.toList());
  }
}

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
