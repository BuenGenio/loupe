import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../shared/bars.dart';
import '../../shared/grouped_list.dart';
import '../../shared/mailbox_display.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart' show showSnack;

/// The name of a role the user can give a folder
/// ([MailAccount.pickableFolderRoles]).
String folderRoleName(AppLocalizations l10n, MailboxRole role) => switch (role) {
  MailboxRole.sent => l10n.mailboxSent,
  MailboxRole.drafts => l10n.mailboxDrafts,
  MailboxRole.trash => l10n.mailboxTrash,
  _ => role.name,
};

/// The folder that holds one of an account's special roles (Settings ›
/// account › Special Folders › Sent, Drafts or Trash): Automatic, the one
/// the server marks or names that way, or any folder that can hold mail.
/// Folders are shown by their server path, which tells two "Sent" folders
/// apart.
class FolderRoleScreen extends ConsumerWidget {
  const FolderRoleScreen({super.key, required this.accountId, required this.role});

  final String accountId;
  final MailboxRole role;

  Future<void> _pick(BuildContext context, WidgetRef ref, MailAccount account, String? path) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(repositoryProvider).updateAccount(account.withFolderRole(role, path));
      if (context.mounted) context.pop();
    } on MailException catch (e) {
      showSnack(messenger, e.message);
    }
  }

  /// Whether [m] can hold [role]: not the Inbox, a container, or a folder
  /// Loupe keeps for itself (Snoozed, Loupe Settings).
  static bool _pickable(Mailbox m) =>
      m.isSelectable && m.role != MailboxRole.inbox && !Snooze.isFolder(m) && !ServerDocuments.isFolder(m);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final account = (ref.watch(accountsProvider).value ?? const <MailAccount>[])
        .where((a) => a.id == accountId)
        .firstOrNull;
    if (account == null) {
      return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: showsBackButton(context)),
        body: Center(child: Text(l10n.settingsAccountRemoved, style: styles.footnote)),
      );
    }
    final mailboxes = [
      for (final m in ref.watch(mailboxesProvider).value ?? const <Mailbox>[])
        if (m.accountId == accountId) m,
    ];
    final picked = account.folderRoles[role];
    final automatic = picked == null || !mailboxes.any((m) => m.path == picked && _pickable(m));
    final holder = mailboxes.where((m) => m.role == role).firstOrNull;
    final check = Icon(LoupeIcons.check, color: colors.unreadDot, size: 22);
    return GroupedPage(
      title: folderRoleName(l10n, role),
      children: [
        InsetGroup(
          children: [
            GroupedRow(
              key: const Key('folder-role-automatic'),
              title: l10n.settingsFolderRoleAutomatic,
              subtitle: automatic ? holder?.path : null,
              chevron: false,
              trailing: automatic ? check : null,
              onTap: () => _pick(context, ref, account, null),
            ),
          ],
        ),
        InsetGroup(
          separatorIndent: 54,
          footer: l10n.settingsFolderRoleFooter,
          children: [
            for (final (mailbox: m, :depth, hasChildren: _) in mailboxTree(mailboxes))
              GroupedRow(
                key: ValueKey('folder-role-${m.path}'),
                // Special mailboxes are pulled out of their containers, so they show their whole path.
                title: depth == 0 && m.role != MailboxRole.inbox ? m.path : m.name,
                indent: folderIndent(depth),
                leading: Icon(mailboxIcon(m.role), color: colors.unreadDot, size: 24),
                chevron: false,
                enabled: _pickable(m),
                trailing: !automatic && m.path == picked ? check : null,
                onTap: _pickable(m) ? () => _pick(context, ref, account, m.path) : null,
              ),
          ],
        ),
      ],
    );
  }
}
