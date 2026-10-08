import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../settings/ui_state.dart';
import '../../shared/grouped_list.dart';
import '../../theme/theme.dart';
import '../settings/settings_widgets.dart';

/// Settings › Smart Mailboxes: which account keeps them on its mail server
/// (Sync via) and how each account stands.
class SmartMailboxSettingsScreen extends ConsumerWidget {
  const SmartMailboxSettingsScreen({super.key});

  static Future<void> push(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const SmartMailboxSettingsScreen()));

  /// The Sync via value shown in Settings: the home account, or Off (in
  /// [l10n]'s language, else the device's).
  static String syncViaLabel(String? home, List<MailAccount> accounts, {AppLocalizations? l10n}) =>
      accounts.where((a) => a.id == home).firstOrNull?.displayName ?? (l10n ?? deviceL10n()).commonOff;

  static String _accountState(String accountId, SmartMailboxSyncStatus status, AppLocalizations l10n) {
    if (status.unsupported.contains(accountId)) return l10n.searchStateUnsupported;
    if (status.newerFormat.contains(accountId)) return l10n.searchStateNewerFormat;
    if (status.failed.containsKey(accountId)) return l10n.searchStateFailed;
    if (!status.synced.containsKey(accountId)) {
      return status.running ? l10n.searchStateSyncing : l10n.searchStateWaiting;
    }
    return switch (status.synced[accountId]) {
      ServerStorage.metadata => l10n.searchStateMetadata,
      ServerStorage.folder => l10n.searchStateFolder,
      null => l10n.searchStateNothing,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
    final home = ref.watch(smartMailboxHomeProvider);
    final status = ref.watch(smartMailboxSyncStatusProvider);
    final homeName = syncViaLabel(home, accounts, l10n: l10n);
    return GroupedPage(
      title: l10n.searchSettingsTitle,
      children: [
        InsetGroup(
          footer: home == null ? l10n.searchSettingsLocalFooter : l10n.searchSettingsServerFooter(homeName),
          children: [
            GroupedRow(
              title: l10n.searchSyncVia,
              detail: homeName,
              onTap: accounts.isEmpty
                  ? null
                  : () => ChoicePage.push<String>(
                      context,
                      title: l10n.searchSyncVia,
                      footer: l10n.searchSyncViaFooter,
                      selected: home ?? SmartMailboxSyncVia.off,
                      choices: [
                        for (final a in accounts)
                          (
                            value: a.id,
                            label: a.displayName,
                            detail: a.provider == ProviderKind.gmail ? l10n.searchGmailCantKeep : a.email,
                          ),
                        (value: SmartMailboxSyncVia.off, label: l10n.commonOff, detail: l10n.searchKeepOnDevice),
                      ],
                      onSelected: (v) => ref.read(smartMailboxSyncViaProvider.notifier).set(v),
                    ),
            ),
          ],
        ),
        if (home != null)
          InsetGroup(
            header: l10n.searchOnTheServer,
            footer: l10n.searchServerFooter,
            children: [
              for (final a in accounts)
                GroupedRow(key: ValueKey(a.id), title: a.displayName, detail: _accountState(a.id, status, l10n)),
              GroupedRow(
                title: l10n.searchSyncNow,
                titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
                chevron: false,
                enabled: !status.running,
                onTap: () => ref.read(smartMailboxesProvider.notifier).sync(),
              ),
            ],
          ),
      ],
    );
  }
}
