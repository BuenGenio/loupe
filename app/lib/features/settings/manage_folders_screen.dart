import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../shared/grouped_list.dart';
import '../../shared/mailbox_display.dart';
import '../conversation/sheets.dart';
import '../../theme/theme.dart';

/// Every folder of one account as the server lists it, with a switch to
/// subscribe to it (Settings › account › Manage Folders). Mailboxes holding
/// a role always show, so they have no switch; neither do containers that
/// can't hold mail.
class ManageFoldersScreen extends ConsumerWidget {
  const ManageFoldersScreen({super.key, required this.accountId});

  final String accountId;

  Future<void> _set(BuildContext context, WidgetRef ref, Mailbox mailbox, bool subscribed) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(repositoryProvider).setMailboxSubscribed(mailbox.id, subscribed: subscribed);
    } on MailException catch (e) {
      showSnack(messenger, e.message);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final mailboxes = [
      for (final m in ref.watch(mailboxesProvider).value ?? const <Mailbox>[])
        if (m.accountId == accountId) m,
    ];
    final tree = mailboxTree(mailboxes);
    return GroupedPage(
      title: 'Manage Folders',
      children: [
        if (tree.isEmpty)
          Padding(
            padding: const EdgeInsets.all(32),
            child: Text('No folders yet.', style: styles.footnote, textAlign: TextAlign.center),
          )
        else
          InsetGroup(
            separatorIndent: 54,
            footer:
                'Subscribed folders show on the Mailboxes screen and sync in the background. '
                'Other mail apps on the same account usually follow these subscriptions too.',
            children: [
              for (final node in tree)
                _FolderRow(
                  key: ValueKey(node.mailbox.id),
                  mailbox: node.mailbox,
                  depth: node.depth,
                  colors: colors,
                  onChanged: (v) => _set(context, ref, node.mailbox, v),
                ),
            ],
          ),
      ],
    );
  }
}

class _FolderRow extends StatelessWidget {
  const _FolderRow({
    super.key,
    required this.mailbox,
    required this.depth,
    required this.colors,
    required this.onChanged,
  });

  final Mailbox mailbox;
  final int depth;
  final LoupeColors colors;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final name = mailboxDisplayName(mailbox);
    final fixed = mailbox.role != MailboxRole.none;
    final toggle = !fixed && mailbox.isSelectable;
    return GroupedRow(
      title: name,
      indent: folderIndent(depth),
      leading: Icon(mailboxIcon(mailbox.role), color: colors.unreadDot, size: 24),
      detail: fixed ? 'Always Shown' : null,
      chevron: false,
      onTap: toggle ? () => onChanged(!mailbox.isSubscribed) : null,
      trailing: toggle
          ? Semantics(
              label: 'Subscribe to $name',
              child: CupertinoSwitch(
                value: mailbox.isSubscribed,
                activeTrackColor: colors.success,
                onChanged: onChanged,
              ),
            )
          : null,
    );
  }
}
