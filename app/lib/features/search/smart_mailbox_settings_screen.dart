import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

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

  /// The Sync via value shown in Settings: the home account, or Off.
  static String syncViaLabel(String? home, List<MailAccount> accounts) =>
      accounts.where((a) => a.id == home).firstOrNull?.displayName ?? 'Off';

  static String _accountState(String accountId, SmartMailboxSyncStatus status) {
    if (status.unsupported.contains(accountId)) return 'Not supported';
    if (status.newerFormat.contains(accountId)) return 'Newer format';
    if (status.failed.containsKey(accountId)) return 'Couldn’t sync';
    if (!status.synced.containsKey(accountId)) return status.running ? 'Syncing…' : 'Waiting';
    return switch (status.synced[accountId]) {
      ServerStorage.metadata => 'Server metadata',
      ServerStorage.folder => 'Loupe Settings folder',
      null => 'Nothing stored',
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
    final home = ref.watch(smartMailboxHomeProvider);
    final status = ref.watch(smartMailboxSyncStatusProvider);
    final homeName = syncViaLabel(home, accounts);
    return GroupedPage(
      title: 'Smart Mailboxes',
      children: [
        InsetGroup(
          footer: home == null
              ? 'Smart Mailboxes stay on this device.'
              : 'Smart Mailboxes are kept on your mail server, so your other devices have them too, and so does '
                    'Thunderbird with Expression Search Reloaded. Those that search every account are kept on '
                    '$homeName; those of one folder, on that folder’s account.',
          children: [
            GroupedRow(
              title: 'Sync via',
              detail: homeName,
              onTap: accounts.isEmpty
                  ? null
                  : () => ChoicePage.push<String>(
                      context,
                      title: 'Sync via',
                      footer: 'Choose the same account on every device.',
                      selected: home ?? SmartMailboxSyncVia.off,
                      choices: [
                        for (final a in accounts) (value: a.id, label: a.displayName, detail: a.email),
                        (
                          value: SmartMailboxSyncVia.off,
                          label: 'Off',
                          detail: 'Keep Smart Mailboxes on this device only',
                        ),
                      ],
                      onSelected: (v) => ref.read(smartMailboxSyncViaProvider.notifier).set(v),
                    ),
            ),
          ],
        ),
        if (home != null)
          InsetGroup(
            header: 'On the Server',
            footer:
                'Server metadata (IMAP METADATA) doesn’t show in any mail app. Servers without it get a '
                '“Loupe Settings” folder holding one message; Loupe hides it from Mailboxes.',
            children: [
              for (final a in accounts)
                GroupedRow(key: ValueKey(a.id), title: a.displayName, detail: _accountState(a.id, status)),
              GroupedRow(
                title: 'Sync Now',
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
