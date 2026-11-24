import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_platform/mail_platform.dart';

import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart' show sharedPreferencesProvider;
import '../../settings/ui_state.dart' show PrefsStringSet;

/// Settings › Projects, kept on this device.
@immutable
final class ProjectSettings {
  const ProjectSettings({
    this.everythingElse = true,
    this.suggest = true,
    this.ai = false,
    this.aiServer = '',
    this.aiModel = '',
  });

  /// The Tiles view has a tile for the Inbox mail in no project.
  final bool everythingElse;

  /// Topics found on this device are offered as tiles.
  final bool suggest;

  /// An OpenAI-compatible server names and groups the suggestions.
  final bool ai;

  /// Its address, e.g. `http://localhost:8080/v1`.
  final String aiServer;
  final String aiModel;

  bool get aiReady => ai && aiServer.trim().isNotEmpty && aiModel.trim().isNotEmpty;

  ProjectSettings copyWith({bool? everythingElse, bool? suggest, bool? ai, String? aiServer, String? aiModel}) =>
      ProjectSettings(
        everythingElse: everythingElse ?? this.everythingElse,
        suggest: suggest ?? this.suggest,
        ai: ai ?? this.ai,
        aiServer: aiServer ?? this.aiServer,
        aiModel: aiModel ?? this.aiModel,
      );

  @override
  bool operator ==(Object other) =>
      other is ProjectSettings &&
      other.everythingElse == everythingElse &&
      other.suggest == suggest &&
      other.ai == ai &&
      other.aiServer == aiServer &&
      other.aiModel == aiModel;

  @override
  int get hashCode => Object.hash(everythingElse, suggest, ai, aiServer, aiModel);
}

final projectSettingsProvider = NotifierProvider<ProjectSettingsNotifier, ProjectSettings>(ProjectSettingsNotifier.new);

class ProjectSettingsNotifier extends Notifier<ProjectSettings> {
  static const _everythingElse = 'projects.everythingElse';
  static const _suggest = 'projects.suggest';
  static const _ai = 'projects.ai';
  static const _aiServer = 'projects.aiServer';
  static const _aiModel = 'projects.aiModel';

  @override
  ProjectSettings build() {
    ref.watch(prefsEpochProvider);
    final p = ref.watch(sharedPreferencesProvider);
    return ProjectSettings(
      everythingElse: p.getBool(_everythingElse) ?? true,
      suggest: p.getBool(_suggest) ?? true,
      ai: p.getBool(_ai) ?? false,
      aiServer: p.getString(_aiServer) ?? '',
      aiModel: p.getString(_aiModel) ?? '',
    );
  }

  Future<void> update(ProjectSettings next) async {
    state = next;
    final p = ref.read(sharedPreferencesProvider);
    await p.setBool(_everythingElse, next.everythingElse);
    await p.setBool(_suggest, next.suggest);
    await p.setBool(_ai, next.ai);
    await p.setString(_aiServer, next.aiServer.trim());
    await p.setString(_aiModel, next.aiModel.trim());
  }
}

/// Where the AI server's key is kept: the platform keychain, never the
/// preferences.
final projectSecretsProvider = Provider<SecretStorage>((ref) => KeychainSecretStorage());

/// The key's name in [projectSecretsProvider].
const projectAiKeySecret = 'projects.aiKey';

/// The AI server's key, or null when none is set.
final projectAiKeyProvider = FutureProvider<String?>(
  (ref) => ref.watch(projectSecretsProvider).read(projectAiKeySecret),
);

/// Inbox lists show tiles (projects, suggestions, Everything Else) instead
/// of rows.
final inboxTilesProvider = NotifierProvider<InboxTiles, bool>(InboxTiles.new);

class InboxTiles extends Notifier<bool> {
  static const key = 'inbox.tiles';

  @override
  bool build() {
    ref.watch(prefsEpochProvider);
    return ref.watch(sharedPreferencesProvider).getBool(key) ?? false;
  }

  Future<void> set(bool tiles) async {
    state = tiles;
    await ref.read(sharedPreferencesProvider).setBool(key, tiles);
  }
}

/// Suggestions the user answered Not a Topic, by key (`org:…`, `word:…`).
final dismissedTopicsProvider = NotifierProvider<PrefsStringSet, Set<String>>(
  () => PrefsStringSet('projects.dismissedTopics'),
);
