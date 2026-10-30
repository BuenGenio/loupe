import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../settings/app_settings.dart';
import '../../shared/grouped_list.dart';
import '../../shared/sheets.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../ai/ai_providers.dart';
import '../ai/ai_settings.dart';
import '../notifications/notification_content.dart' show accountName;

/// A provider's name, as Settings lists it.
String aiProviderName(AppLocalizations l10n, AiProviderKind kind) => switch (kind) {
  AiProviderKind.demo => l10n.settingsAiDemo,
  AiProviderKind.anthropic => 'Anthropic', // l10n-ignore: the provider's name
  AiProviderKind.myServer => l10n.settingsAiServer,
  AiProviderKind.onThisPhone => l10n.settingsAiOnPhone,
};

/// Private AI on the Settings screen: Off, the provider in use, or Not Set
/// Up when the provider picked can't answer yet.
String aiStatusLabel(AppLocalizations l10n, WidgetRef ref) {
  if (!ref.watch(appSettingsProvider.select((s) => s.aiAssist))) return l10n.commonOff;
  final kind = ref.watch(aiConfigProvider.select((c) => c.kind));
  // Still reading the keychain: not yet known to be missing.
  final loading = kind.isNetwork && ref.watch(aiKeysProvider).isLoading;
  return ref.watch(aiProviderProvider) != null || loading ? aiProviderName(l10n, kind) : l10n.settingsAiNotSetUp;
}

String _featureName(AppLocalizations l10n, AiFeature f) => switch (f) {
  AiFeature.search => l10n.searchAskPlainEnglish,
  AiFeature.brief => l10n.settingsAiFeatureBrief,
  AiFeature.actions => l10n.settingsAiFeatureActions,
  AiFeature.rules => l10n.settingsAiFeatureRules,
  AiFeature.changes => l10n.settingsAiFeatureChanges,
  AiFeature.documents => l10n.settingsAiFeatureDocuments,
  AiFeature.replyCheck => l10n.settingsAiFeatureReplyCheck,
  AiFeature.matters => l10n.settingsAiFeatureMatters,
};

String _featureDetail(AppLocalizations l10n, AiFeature f) => switch (f) {
  AiFeature.search => l10n.settingsAiFeatureSearchDetail,
  AiFeature.brief => l10n.settingsAiFeatureBriefDetail,
  AiFeature.actions => l10n.settingsAiFeatureActionsDetail,
  AiFeature.rules => l10n.settingsAiFeatureRulesDetail,
  AiFeature.changes => l10n.settingsAiFeatureChangesDetail,
  AiFeature.documents => l10n.settingsAiFeatureDocumentsDetail,
  AiFeature.replyCheck => l10n.settingsAiFeatureReplyCheckDetail,
  AiFeature.matters => l10n.settingsAiFeatureMattersDetail,
};

/// Anthropic's page on how long it keeps API requests.
final _anthropicRetention = Uri.parse('https://platform.claude.com/docs/en/manage-claude/api-and-data-retention');

/// Test Connection's request: one short sentence, no mail.
const _testSentence = 'unread mail from last week';

/// Settings › Private AI: the switch, the provider and its setup (keys in
/// the keychain), what a request holds, the features, the accounts that keep
/// their mail on the phone, usage, and Delete Derived Results. Turning
/// Private AI off and deleting what it made are separate.
class PrivateAiSettingsScreen extends ConsumerStatefulWidget {
  const PrivateAiSettingsScreen({super.key});

  @override
  ConsumerState<PrivateAiSettingsScreen> createState() => _PrivateAiSettingsScreenState();
}

class _PrivateAiSettingsScreenState extends ConsumerState<PrivateAiSettingsScreen> {
  /// The last Test Connection, and the provider it tested.
  Future<AiRun<SearchTranslation>>? _test;
  String? _testedId;

  AiConfigController get _config => ref.read(aiConfigProvider.notifier);
  AiKeys get _keys => ref.read(aiKeysProvider.notifier);

  /// Whether [kind] has a key in the keychain; false when it can't be read.
  Future<bool> _hasKey(AiProviderKind kind) async {
    try {
      return (await ref.read(aiKeysProvider.future)).containsKey(kind);
    } on Object {
      return false;
    }
  }

  /// Picks [kind] at once, and asks for what it still needs. Not set up, it
  /// stays picked and answers nothing; no other provider takes over.
  Future<void> _choose(AiProviderKind kind) async {
    await _config.update((c) => c.copyWith(kind: kind));
    final config = ref.read(aiConfigProvider);
    if (kind == AiProviderKind.anthropic && !await _hasKey(kind) && mounted) await _editKey(kind);
    if (kind == AiProviderKind.myServer && config.serverUri == null && mounted) await _editServerAddress(config);
  }

  Future<void> _editKey(AiProviderKind kind) async {
    final l10n = context.l10n;
    final anthropic = kind == AiProviderKind.anthropic;
    final key = await _promptSecret(
      context,
      title: anthropic ? l10n.settingsAiAnthropicKeyTitle : l10n.settingsAiServerKeyTitle,
      message: anthropic ? l10n.settingsAiAnthropicKeyMessage : l10n.settingsAiServerKeyMessage,
      placeholder: anthropic ? 'sk-ant-…' : '',
    );
    if (key == null) return;
    if (key.isNotEmpty) {
      await _keys.save(kind, key);
    } else if (!anthropic && await _hasKey(kind)) {
      // A server's key is optional: empty means none.
      await _keys.remove(kind);
    }
  }

  Future<void> _chooseAnthropicModel(AiConfig config) async {
    final l10n = context.l10n;
    final choice = await showActionSheet<String>(
      context,
      title: l10n.settingsAiModel,
      actions: [
        for (final m in AiConfig.anthropicModels) SheetAction(m, m, isDefault: m == config.anthropicModel),
        SheetAction(l10n.settingsAiOtherModel, ''),
      ],
    );
    if (choice == null || !mounted) return;
    final model = choice.isNotEmpty
        ? choice
        : await showTextPrompt(context, title: l10n.settingsAiModelId, initial: config.anthropicModel);
    if (model == null || model.isEmpty) return;
    await _config.update((c) => c.copyWith(anthropicModel: model));
  }

  Future<void> _editServerAddress(AiConfig config) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final text = await showTextPrompt(
      context,
      title: l10n.settingsAiServerAddressTitle,
      message: l10n.settingsAiServerAddressMessage,
      initial: config.serverUrl,
      placeholder: 'http://192.168.1.20:11434/v1',
    );
    if (text == null) return;
    if (text.isNotEmpty && AiConfig.parseServerUrl(text) == null) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.settingsAiServerAddressInvalid)));
      return;
    }
    await _config.update((c) => c.copyWith(serverUrl: text));
  }

  Future<void> _editServerModel(AiConfig config) async {
    final l10n = context.l10n;
    final model = await showTextPrompt(
      context,
      title: l10n.settingsAiServerModelTitle,
      message: l10n.settingsAiServerModelMessage,
      initial: config.serverModel,
      placeholder: 'llama3.2',
    );
    if (model == null) return;
    await _config.update((c) => c.copyWith(serverModel: model));
  }

  /// One tiny search translation through the provider in use, on an explicit
  /// tap only. It counts as usage like any other request.
  void _testConnection(AiService service) {
    final task = SearchTranslationTask(_testSentence, now: clock.now());
    setState(() {
      _testedId = service.provider.id;
      _test = service.run(task, reuse: false, keep: false);
    });
  }

  /// Remove Key: the key leaves the keychain and Anthropic gets no more
  /// requests. Anthropic stays picked, not set up; nothing else takes over.
  Future<void> _removeAnthropicKey() async {
    final l10n = context.l10n;
    final ok = await confirmDestructive(
      context,
      title: l10n.settingsAiRemoveKeyTitle,
      message: l10n.settingsAiRemoveKeyMessage,
      action: l10n.settingsAiRemoveKey,
    );
    if (!ok) return;
    await _keys.remove(AiProviderKind.anthropic);
    await _offerToDeleteResults(AiProviderKind.anthropic);
  }

  /// Remove Server: its address, model and key are forgotten, as with
  /// Remove Key.
  Future<void> _removeServer() async {
    final l10n = context.l10n;
    final ok = await confirmDestructive(
      context,
      title: l10n.settingsAiRemoveServerTitle,
      message: l10n.settingsAiRemoveServerMessage,
      action: l10n.settingsAiRemoveServer,
    );
    if (!ok) return;
    await _config.update((c) => c.copyWith(serverUrl: '', serverModel: ''));
    await _keys.remove(AiProviderKind.myServer);
    await _offerToDeleteResults(AiProviderKind.myServer);
  }

  /// After a provider is removed: delete what it made too? Mail and the
  /// user's decisions stay either way.
  Future<void> _offerToDeleteResults(AiProviderKind kind) async {
    final ledger = ref.read(aiLedgerProvider);
    final count = ledger.resultsFrom(kind.owns);
    if (count == 0 || !mounted) return;
    final l10n = context.l10n;
    final ok = await confirmDestructive(
      context,
      title: l10n.settingsAiDeleteItsResultsTitle(count),
      message: l10n.settingsAiDeleteDerivedMessage,
      action: l10n.settingsAiDeleteResults,
    );
    if (ok) ledger.clearResults(from: kind.owns);
  }

  Future<void> _deleteResults(AiLedger ledger) async {
    final l10n = context.l10n;
    final ok = await confirmDestructive(
      context,
      title: l10n.settingsAiDeleteDerivedTitle(ledger.resultCount),
      message: l10n.settingsAiDeleteDerivedMessage,
      action: l10n.settingsAiDeleteResults,
    );
    if (ok) ledger.clearResults();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    final on = ref.watch(appSettingsProvider.select((s) => s.aiAssist));
    final settings = ref.read(appSettingsProvider.notifier);
    final config = ref.watch(aiConfigProvider);
    final service = ref.watch(aiServiceProvider);
    final features = ref.watch(aiFeatureSettingsProvider);
    final localOnly = ref.watch(aiLocalOnlySettingsProvider);
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
    final ledger = ref.watch(aiLedgerProvider);
    final keys = ref.watch(aiKeysProvider);
    final keysLoading = config.kind.isNetwork && keys.isLoading;

    Widget providerRow(AiProviderKind kind, String subtitle) => GroupedRow(
      key: Key('ai-provider-${kind.name}'),
      title: aiProviderName(l10n, kind),
      subtitle: subtitle,
      enabled: kind != AiProviderKind.onThisPhone,
      chevron: false,
      trailing: config.kind == kind
          ? Icon(LoupeIcons.check, color: colors.unreadDot, size: 22)
          : const SizedBox(width: 22),
      onTap: () => unawaited(_choose(kind)),
    );

    return ListenableBuilder(
      listenable: ledger,
      builder: (context, _) => GroupedPage(
        title: l10n.settingsAiHeader,
        children: [
          InsetGroup(
            separatorIndent: 16,
            footer: l10n.settingsAiAssistDetail,
            children: [
              SwitchRow(
                key: const Key('ai-assist'),
                title: l10n.settingsAiHeader,
                value: on,
                onChanged: (v) => unawaited(settings.update((s) => s.copyWith(aiAssist: v))),
              ),
            ],
          ),
          if (on) ...[
            InsetGroup(
              header: l10n.settingsAiProviderHeader,
              separatorIndent: 16,
              footer: service == null && !keysLoading ? l10n.settingsAiNotSetUpFooter : l10n.settingsAiProviderFooter,
              children: [
                providerRow(AiProviderKind.demo, l10n.settingsAiDemoDetail),
                providerRow(AiProviderKind.anthropic, l10n.settingsAiAnthropicDetail),
                providerRow(AiProviderKind.myServer, l10n.settingsAiServerDetail),
                providerRow(AiProviderKind.onThisPhone, l10n.settingsAiOnPhoneDetail),
              ],
            ),
            ?_setup(config, service, keys),
            InsetGroup(
              header: l10n.settingsAiFeaturesHeader,
              separatorIndent: 16,
              footer: l10n.settingsAiFeaturesFooter,
              children: [
                for (final f in AiFeature.values)
                  SwitchRow(
                    key: Key('ai-feature-${f.name}'),
                    title: _featureName(l10n, f),
                    subtitle: _featureDetail(l10n, f),
                    value: features.contains(f),
                    onChanged: (v) => unawaited(ref.read(aiFeatureSettingsProvider.notifier).set(f, v)),
                  ),
              ],
            ),
            InsetGroup(
              header: l10n.settingsAiLocalOnlyHeader,
              separatorIndent: 16,
              footer: l10n.settingsAiLocalOnlyFooter,
              children: [
                for (final a in accounts)
                  SwitchRow(
                    key: Key('ai-local-${a.id}'),
                    title: accountName(a),
                    subtitle: a.email == accountName(a) ? null : a.email,
                    value: localOnly.contains(a.id),
                    onChanged: (v) => unawaited(ref.read(aiLocalOnlySettingsProvider.notifier).set(a.id, v)),
                  ),
                if (accounts.isEmpty) GroupedRow(title: l10n.settingsNoAccounts, enabled: false, chevron: false),
              ],
            ),
          ],
          InsetGroup(
            separatorIndent: 16,
            children: [
              GroupedRow(
                key: const Key('ai-usage'),
                title: l10n.settingsAiUsage,
                onTap: () => context.push(Routes.aiUsage),
              ),
            ],
          ),
          InsetGroup(
            separatorIndent: 16,
            footer: l10n.settingsAiDeleteDerivedFooter,
            children: [
              GroupedRow(
                key: const Key('ai-delete-results'),
                title: l10n.settingsAiDeleteDerived,
                destructive: true,
                enabled: ledger.resultCount > 0,
                detail: ledger.resultCount == 0
                    ? l10n.commonNone
                    : NumberFormat.decimalPattern().format(ledger.resultCount),
                onTap: () => unawaited(_deleteResults(ledger)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// The picked provider's setup: its key, model or server, Test
  /// Connection, removal, and what its requests hold. None for On This
  /// Phone, which can't be picked yet.
  Widget? _setup(AiConfig config, AiService? service, AsyncValue<Map<AiProviderKind, String>> keys) {
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    final hasKey = keys.value?.containsKey(config.kind) ?? false;
    String keyDetail({required bool optional}) => switch (keys) {
      AsyncValue(isLoading: true) => '…',
      AsyncValue(hasError: true, hasValue: false) => l10n.settingsAiKeyUnreadable,
      _ when hasKey => l10n.settingsAiKeySaved,
      _ => optional ? l10n.commonNone : l10n.settingsAiNotSet,
    };
    final test = [
      GroupedRow(
        key: const Key('ai-test-connection'),
        title: l10n.settingsAiTestConnection,
        titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
        chevron: false,
        enabled: service != null,
        onTap: service == null ? null : () => _testConnection(service),
      ),
      if (_test != null && _testedId == service?.provider.id) _testResult(_test!),
    ];

    switch (config.kind) {
      case AiProviderKind.demo:
        return InsetGroup(separatorIndent: 16, footer: l10n.settingsAiDemoDisclosure, children: test);
      case AiProviderKind.onThisPhone:
        return null;
      case AiProviderKind.anthropic:
        return InsetGroup(
          header: aiProviderName(l10n, config.kind),
          separatorIndent: 16,
          footer: l10n.settingsAiAnthropicDisclosure,
          children: [
            GroupedRow(
              key: const Key('ai-api-key'),
              title: l10n.settingsAiApiKey,
              detail: keyDetail(optional: false),
              onTap: () => unawaited(_editKey(config.kind)),
            ),
            GroupedRow(
              key: const Key('ai-model'),
              title: l10n.settingsAiModel,
              detail: config.anthropicModel,
              onTap: () => unawaited(_chooseAnthropicModel(config)),
            ),
            ...test,
            GroupedRow(
              title: l10n.settingsAiAnthropicRetention,
              chevron: false,
              trailing: Icon(LoupeIcons.openIn, size: 20, color: colors.tertiaryText),
              onTap: () => unawaited(launchUrl(_anthropicRetention, mode: LaunchMode.inAppBrowserView)),
            ),
            if (hasKey)
              GroupedRow(
                key: const Key('ai-remove-key'),
                title: l10n.settingsAiRemoveKey,
                destructive: true,
                onTap: () => unawaited(_removeAnthropicKey()),
              ),
          ],
        );
      case AiProviderKind.myServer:
        final uri = config.serverUri;
        final configured = config.serverUrl.isNotEmpty || config.serverModel.isNotEmpty || hasKey;
        return InsetGroup(
          header: aiProviderName(l10n, config.kind),
          separatorIndent: 16,
          footer: [
            l10n.settingsAiServerDisclosure,
            if (uri != null && uri.isScheme('http')) l10n.settingsAiServerUnencrypted,
          ].join('\n\n'),
          children: [
            GroupedRow(
              key: const Key('ai-server-address'),
              title: l10n.settingsAiServerAddress,
              detail: config.serverUrl.isEmpty ? l10n.settingsAiNotSet : config.serverUrl,
              onTap: () => unawaited(_editServerAddress(config)),
            ),
            GroupedRow(
              key: const Key('ai-server-model'),
              title: l10n.settingsAiModel,
              detail: config.serverModel.isEmpty ? l10n.settingsAiNotSet : config.serverModel,
              onTap: () => unawaited(_editServerModel(config)),
            ),
            GroupedRow(
              key: const Key('ai-api-key'),
              title: l10n.settingsAiApiKey,
              detail: keyDetail(optional: true),
              onTap: () => unawaited(_editKey(config.kind)),
            ),
            ...test,
            if (configured)
              GroupedRow(
                key: const Key('ai-remove-server'),
                title: l10n.settingsAiRemoveServer,
                destructive: true,
                onTap: () => unawaited(_removeServer()),
              ),
          ],
        );
    }
  }

  /// Test Connection's outcome: the model that answered and how long it
  /// took, or what went wrong, in the provider's words.
  Widget _testResult(Future<AiRun<SearchTranslation>> test) {
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    return FutureBuilder<AiRun<SearchTranslation>>(
      key: ValueKey(test),
      future: test,
      builder: (context, snapshot) {
        final run = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done || run == null) {
          return GroupedRow(
            key: const Key('ai-test-result'),
            title: l10n.settingsAiTesting,
            chevron: false,
            trailing: const CupertinoActivityIndicator(),
          );
        }
        final record = run.record;
        final seconds = record.finishedAt.difference(record.startedAt).inMilliseconds / 1000;
        return switch (run) {
          AiSuccess() => GroupedRow(
            key: const Key('ai-test-result'),
            leading: Icon(LoupeIcons.check, color: colors.success),
            title: l10n.settingsAiTestOk(record.model ?? record.providerId, NumberFormat('0.0').format(seconds)),
            chevron: false,
          ),
          AiFailure(:final reason, :final message) => GroupedRow(
            key: const Key('ai-test-result'),
            leading: Icon(LoupeIcons.warning, color: colors.flag),
            title: l10n.settingsAiTestFailed,
            subtitle: reason == AiFailureReason.invalidOutput ? l10n.settingsAiTestInvalid : message,
            chevron: false,
          ),
        };
      },
    );
  }
}

/// Asks for a key: hidden as it is typed, no suggestions, never shown again.
/// Returns what was entered (trimmed), or null on Cancel.
Future<String?> _promptSecret(
  BuildContext context, {
  required String title,
  required String message,
  String placeholder = '',
}) {
  final controller = TextEditingController();
  return showCupertinoDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: const EdgeInsets.only(bottom: 10), child: Text(message)),
            CupertinoTextField(
              key: const Key('ai-key-field'),
              controller: controller,
              autofocus: true,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.visiblePassword,
              placeholder: placeholder,
              onSubmitted: (v) => Navigator.of(context).pop(v.trim()),
            ),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(), child: Text(context.l10n.commonCancel)),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          child: Text(context.l10n.commonSave),
        ),
      ],
    ),
  ).whenComplete(controller.dispose);
}
