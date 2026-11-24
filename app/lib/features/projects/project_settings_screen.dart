import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../shared/grouped_list.dart';
import '../../shared/sheets.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart' show showSnack;
import '../settings/settings_widgets.dart';
import 'project_settings.dart';
import 'project_tiles.dart' show topicAiErrorText;
import 'topic_ai.dart';
import 'topic_suggestions.dart';

/// Settings › Projects: the Tiles view's Everything Else, suggested topics,
/// and the optional AI server that names them.
class ProjectSettingsScreen extends ConsumerStatefulWidget {
  const ProjectSettingsScreen({super.key});

  static Future<void> push(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const ProjectSettingsScreen()));

  @override
  ConsumerState<ProjectSettingsScreen> createState() => _ProjectSettingsScreenState();
}

class _ProjectSettingsScreenState extends ConsumerState<ProjectSettingsScreen> {
  bool _testing = false;

  ProjectSettingsNotifier get _settings => ref.read(projectSettingsProvider.notifier);

  Future<void> _editServer(ProjectSettings s) async {
    final l10n = context.l10n;
    final value = await showTextPrompt(
      context,
      title: l10n.commonServer,
      initial: s.aiServer,
      placeholder: 'http://localhost:8080/v1',
    );
    if (value != null) await _settings.update(s.copyWith(aiServer: value));
  }

  Future<void> _editKey() async {
    final l10n = context.l10n;
    final secrets = ref.read(projectSecretsProvider);
    final value = await showTextPrompt(context, title: l10n.projectsSettingsAiKey, obscure: true);
    if (value == null) return;
    if (value.isEmpty) {
      await secrets.delete(projectAiKeySecret);
    } else {
      await secrets.write(projectAiKeySecret, value);
    }
    ref.invalidate(projectAiKeyProvider);
  }

  /// The server's models to pick from; typed in when it can't list them.
  Future<void> _editModel(ProjectSettings s) async {
    final l10n = context.l10n;
    List<String> models = const [];
    if (s.aiServer.isNotEmpty) {
      try {
        final key = await ref.read(projectSecretsProvider).read(projectAiKeySecret);
        models = await TopicAi(
          server: s.aiServer,
          model: '',
          apiKey: key,
          timeout: const Duration(seconds: 10),
        ).models();
      } on TopicAiException {
        // Typed in below.
      }
    }
    if (!mounted) return;
    if (models.isEmpty) {
      final value = await showTextPrompt(context, title: l10n.projectsSettingsAiModel, initial: s.aiModel);
      if (value != null) await _settings.update(s.copyWith(aiModel: value));
      return;
    }
    await ChoicePage.push<String>(
      context,
      title: l10n.projectsSettingsAiModel,
      selected: s.aiModel,
      choices: [for (final m in models) (value: m, label: m, detail: null)],
      onSelected: (v) => _settings.update(ref.read(projectSettingsProvider).copyWith(aiModel: v)),
    );
  }

  Future<void> _test(ProjectSettings s) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _testing = true);
    try {
      final key = await ref.read(projectSecretsProvider).read(projectAiKeySecret);
      await TopicAi(server: s.aiServer, model: s.aiModel, apiKey: key, timeout: const Duration(seconds: 15)).models();
      showSnack(messenger, l10n.projectsSettingsAiWorks(s.aiModel));
      await ref.read(topicSuggestionsProvider.notifier).refresh();
    } on TopicAiException catch (e) {
      showSnack(messenger, l10n.projectsAiFailed(topicAiErrorText(l10n, e)));
    } finally {
      if (mounted) setState(() => _testing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    final s = ref.watch(projectSettingsProvider);
    final hasKey = (ref.watch(projectAiKeyProvider).value ?? '').isNotEmpty;
    final dismissed = ref.watch(dismissedTopicsProvider);
    return GroupedPage(
      title: l10n.mailboxesProjects,
      children: [
        InsetGroup(
          footer: l10n.projectsSettingsEverythingElseFooter,
          children: [
            SwitchRow(
              key: const Key('projects-everything-else'),
              title: l10n.projectsSettingsEverythingElse,
              value: s.everythingElse,
              onChanged: (v) => _settings.update(s.copyWith(everythingElse: v)),
            ),
          ],
        ),
        InsetGroup(
          footer: l10n.projectsSettingsSuggestFooter,
          children: [
            SwitchRow(
              key: const Key('projects-suggest'),
              title: l10n.projectsSettingsSuggest,
              value: s.suggest,
              onChanged: (v) => _settings.update(s.copyWith(suggest: v)),
            ),
            if (dismissed.isNotEmpty)
              GroupedRow(
                key: const Key('projects-forget-dismissed'),
                title: l10n.projectsSettingsForget,
                titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
                chevron: false,
                onTap: () => ref.read(dismissedTopicsProvider.notifier).set(const {}),
              ),
          ],
        ),
        if (s.suggest)
          InsetGroup(
            header: l10n.projectsSettingsAi,
            footer: l10n.projectsSettingsAiFooter,
            children: [
              SwitchRow(
                key: const Key('projects-ai'),
                title: l10n.projectsSettingsAiSwitch,
                value: s.ai,
                onChanged: (v) => _settings.update(s.copyWith(ai: v)),
              ),
              if (s.ai) ...[
                GroupedRow(
                  key: const Key('projects-ai-server'),
                  title: l10n.commonServer,
                  detail: s.aiServer.isEmpty ? l10n.projectsSettingsNotSet : s.aiServer,
                  onTap: () => _editServer(s),
                ),
                GroupedRow(
                  key: const Key('projects-ai-key'),
                  title: l10n.projectsSettingsAiKey,
                  detail: hasKey ? '••••••••' : l10n.projectsSettingsNotSet,
                  onTap: _editKey,
                ),
                GroupedRow(
                  key: const Key('projects-ai-model'),
                  title: l10n.projectsSettingsAiModel,
                  detail: s.aiModel.isEmpty ? l10n.projectsSettingsNotSet : s.aiModel,
                  onTap: () => _editModel(s),
                ),
                GroupedRow(
                  key: const Key('projects-ai-test'),
                  title: l10n.projectsSettingsAiTest,
                  titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
                  chevron: false,
                  enabled: !_testing && s.aiServer.isNotEmpty,
                  onTap: () => _test(s),
                ),
              ],
            ],
          ),
      ],
    );
  }
}
