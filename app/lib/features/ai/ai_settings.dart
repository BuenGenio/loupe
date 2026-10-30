import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderException;
import 'package:http/http.dart' as http;
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart';

/// The preferences Private AI keeps its settings in, or null in a container
/// that has none: the unit test of a feature that only overrides
/// `aiProviderProvider`. The settings then have their defaults and usage
/// records stay in memory, so such a test needs no preferences of its own.
SharedPreferences? aiPreferences(Ref ref) {
  ref.watch(prefsEpochProvider);
  try {
    return ref.watch(sharedPreferencesProvider);
  } on ProviderException {
    return null;
  }
}

/// The providers Settings › Private AI offers. One is active at a time, and
/// Loupe never moves to another by itself.
enum AiProviderKind {
  /// The built-in demo: a few rules on this phone, no model.
  demo(ProviderLocation.onThisPhone),

  /// Claude, through Anthropic's API, with the user's own key.
  anthropic(ProviderLocation.cloud),

  /// A server of the user's that speaks the OpenAI chat API (Ollama, LM
  /// Studio). Network processing, even on the home network.
  myServer(ProviderLocation.myServer),

  /// A model on the phone. Shown, not available: the device spike hasn't run.
  onThisPhone(ProviderLocation.onThisPhone);

  const AiProviderKind(this.location);

  final ProviderLocation location;

  /// Requests leave the phone.
  bool get isNetwork => location != ProviderLocation.onThisPhone;

  /// Whether a run record's or a result's provider id is this kind's. A
  /// server's ids are `<host>:<model>`, so it owns what the others don't.
  bool owns(String providerId) => switch (this) {
    demo => providerId == 'demo',
    anthropic => providerId.startsWith('anthropic:'),
    myServer => providerId != 'demo' && !providerId.startsWith('anthropic:'),
    onThisPhone => false,
  };

  /// The kind behind [providerId].
  static AiProviderKind of(String providerId) => values.firstWhere((k) => k.owns(providerId));
}

/// What Settings › Private AI chose: the provider, Anthropic's model and the
/// user's server. Keys are not here: they are in the keychain ([aiKeysProvider]).
@immutable
final class AiConfig {
  const AiConfig({
    this.kind = AiProviderKind.demo,
    this.anthropicModel = defaultAnthropicModel,
    this.serverUrl = '',
    this.serverModel = '',
  });

  static const defaultAnthropicModel = 'claude-sonnet-5-5';

  /// The Claude models offered as choices; any other ID can be typed.
  static const anthropicModels = ['claude-opus-5-5', 'claude-sonnet-5-5', 'claude-haiku-5-5'];

  final AiProviderKind kind;
  final String anthropicModel;

  /// As typed: up to and including the API path (`http://pi.local:11434/v1`).
  final String serverUrl;
  final String serverModel;

  /// [serverUrl] as an address the adapter can use, or null.
  Uri? get serverUri => parseServerUrl(serverUrl);

  /// An http or https address with a host, or null.
  static Uri? parseServerUrl(String text) {
    final uri = Uri.tryParse(text.trim());
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https')) || uri.host.isEmpty) return null;
    return uri;
  }

  AiConfig copyWith({AiProviderKind? kind, String? anthropicModel, String? serverUrl, String? serverModel}) => AiConfig(
    kind: kind ?? this.kind,
    anthropicModel: anthropicModel ?? this.anthropicModel,
    serverUrl: serverUrl ?? this.serverUrl,
    serverModel: serverModel ?? this.serverModel,
  );

  @override
  bool operator ==(Object other) =>
      other is AiConfig &&
      other.kind == kind &&
      other.anthropicModel == anthropicModel &&
      other.serverUrl == serverUrl &&
      other.serverModel == serverModel;

  @override
  int get hashCode => Object.hash(kind, anthropicModel, serverUrl, serverModel);
}

/// The provider settings, persisted under `ai.*` (no key: see [aiKeysProvider]).
final aiConfigProvider = NotifierProvider<AiConfigController, AiConfig>(AiConfigController.new);

class AiConfigController extends Notifier<AiConfig> {
  static const kindKey = 'ai.provider';
  static const anthropicModelKey = 'ai.anthropic.model';
  static const serverUrlKey = 'ai.server.url';
  static const serverModelKey = 'ai.server.model';

  @override
  AiConfig build() {
    final p = aiPreferences(ref);
    const d = AiConfig();
    if (p == null) return d;
    final kind = p.getString(kindKey);
    return AiConfig(
      kind: AiProviderKind.values.where((k) => k.name == kind).firstOrNull ?? d.kind,
      anthropicModel: p.getString(anthropicModelKey) ?? d.anthropicModel,
      serverUrl: p.getString(serverUrlKey) ?? d.serverUrl,
      serverModel: p.getString(serverModelKey) ?? d.serverModel,
    );
  }

  Future<void> update(AiConfig Function(AiConfig current) change) async {
    final next = change(state);
    state = next;
    final p = ref.read(sharedPreferencesProvider);
    Future<void> put(String key, String value) => value.isEmpty ? p.remove(key) : p.setString(key, value);
    await Future.wait([
      p.setString(kindKey, next.kind.name),
      put(anthropicModelKey, next.anthropicModel),
      put(serverUrlKey, next.serverUrl),
      put(serverModelKey, next.serverModel),
    ]);
  }
}

/// A [CredentialStore] in memory: the demo's, forgotten when Loupe quits.
final class MemoryCredentialStore implements CredentialStore {
  final _entries = <String, Credentials>{};

  @override
  Future<Credentials?> read(String accountId) async => _entries[accountId];

  @override
  Future<void> write(String accountId, Credentials credentials) async {
    _entries[accountId] = credentials;
  }

  @override
  Future<void> delete(String accountId) async {
    _entries.remove(accountId);
  }
}

/// Where the providers' keys are kept: the keychain, through the credential
/// store accounts use (entries `loupe.credentials.ai.<provider>`), or memory
/// in the demo. Never SharedPreferences.
final aiCredentialStoreProvider = Provider<CredentialStore>(
  (ref) => switch (ref.watch(appModeProvider)) {
    AppMode.demo => MemoryCredentialStore(),
    AppMode.live || AppMode.none => SecureCredentialStore(KeychainSecretStorage()),
  },
);

/// The network providers' keys, read from [aiCredentialStoreProvider] once
/// and then kept in memory, so `aiProviderProvider` can stay synchronous.
/// Loading, or with a keychain that can't be read, there is no value, and
/// a network provider counts as not set up. Keys go to their provider's
/// request header and nowhere else: not into prompts, logs or preferences.
final aiKeysProvider = AsyncNotifierProvider<AiKeys, Map<AiProviderKind, String>>(
  AiKeys.new,
  // A keychain that fails now fails again; Settings › Private AI reads it afresh.
  retry: (_, _) => null,
);

class AiKeys extends AsyncNotifier<Map<AiProviderKind, String>> {
  /// The providers with a key: Anthropic's is required, a server's optional.
  static const kinds = [AiProviderKind.anthropic, AiProviderKind.myServer];

  /// The credential store's id for [kind]'s key.
  static String credentialId(AiProviderKind kind) => 'ai.${kind.name}';

  @override
  Future<Map<AiProviderKind, String>> build() async {
    final store = ref.watch(aiCredentialStoreProvider);
    return {
      for (final kind in kinds)
        if (await store.read(credentialId(kind)) case PasswordCredentials(:final password) when password.isNotEmpty)
          kind: password,
    };
  }

  Future<Map<AiProviderKind, String>> _current() async {
    try {
      return await future;
    } on Object {
      return const {};
    }
  }

  Future<void> save(AiProviderKind kind, String key) async {
    final current = await _current();
    await ref.read(aiCredentialStoreProvider).write(credentialId(kind), PasswordCredentials(key));
    state = AsyncData({...current, kind: key});
  }

  /// Deletes [kind]'s key from the keychain: its provider stops at once.
  Future<void> remove(AiProviderKind kind) async {
    final current = await _current();
    await ref.read(aiCredentialStoreProvider).delete(credentialId(kind));
    state = AsyncData({...current}..remove(kind));
  }
}

/// The HTTP client the network providers share; tests answer it with
/// recorded responses.
final aiHttpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
});
