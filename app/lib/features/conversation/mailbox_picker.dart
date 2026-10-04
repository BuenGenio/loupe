import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import '../../theme/theme.dart';
import 'sheets.dart';

/// Icon for a mailbox role.
IconData mailboxIcon(MailboxRole role) => switch (role) {
  MailboxRole.inbox => Icons.inbox_outlined,
  MailboxRole.drafts => Icons.drafts_outlined,
  MailboxRole.sent => Icons.send_outlined,
  MailboxRole.junk => Icons.report_gmailerrorred_outlined,
  MailboxRole.trash => Icons.delete_outline,
  MailboxRole.archive => Icons.archive_outlined,
  MailboxRole.all => Icons.all_inbox_outlined,
  MailboxRole.flagged => Icons.flag_outlined,
  MailboxRole.important => Icons.label_important_outline,
  MailboxRole.outbox => Icons.outbox_outlined,
  MailboxRole.none => Icons.folder_outlined,
};

const _roleOrder = [
  MailboxRole.inbox,
  MailboxRole.drafts,
  MailboxRole.sent,
  MailboxRole.archive,
  MailboxRole.junk,
  MailboxRole.trash,
];

/// Orders [mailboxes] as a tree (special mailboxes first, then folders by
/// name) and returns each with its depth.
List<(Mailbox, int)> mailboxTree(List<Mailbox> mailboxes) {
  final byParent = <String?, List<Mailbox>>{};
  final ids = {for (final m in mailboxes) m.id};
  for (final m in mailboxes) {
    byParent.putIfAbsent(ids.contains(m.parentId) ? m.parentId : null, () => []).add(m);
  }
  int rank(Mailbox m) {
    final i = _roleOrder.indexOf(m.role);
    return i < 0 ? _roleOrder.length : i;
  }

  final out = <(Mailbox, int)>[];
  void visit(String? parent, int depth) {
    final children = [...?byParent[parent]]
      ..sort((a, b) {
        final r = rank(a).compareTo(rank(b));
        if (r != 0) return r;
        final s = a.sortOrder.compareTo(b.sortOrder);
        return s != 0 ? s : a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    for (final c in children) {
      out.add((c, depth));
      visit(c.id, depth + 1);
    }
  }

  visit(null, 0);
  return out;
}

/// Lets the user pick a mailbox of [accountId] to move to. [currentMailboxId]
/// is shown but disabled. Returns the chosen mailbox.
Future<Mailbox?> showMailboxPicker(
  BuildContext context, {
  required MailRepository repository,
  required String accountId,
  String? currentMailboxId,
  String title = 'Move to…',
}) => showLoupeSheet<Mailbox>(
  context,
  expand: true,
  builder: (context) => _MailboxPicker(
    stream: repository.watchMailboxes(accountId: accountId),
    currentMailboxId: currentMailboxId,
    title: title,
  ),
);

class _MailboxPicker extends StatelessWidget {
  const _MailboxPicker({required this.stream, required this.currentMailboxId, required this.title});

  final Stream<List<Mailbox>> stream;
  final String? currentMailboxId;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    return StreamBuilder<List<Mailbox>>(
      stream: stream,
      builder: (context, snapshot) {
        final Widget body;
        if (snapshot.hasError) {
          final e = snapshot.error;
          body = Center(child: Text(e is MailException ? e.message : "Couldn't load mailboxes."));
        } else if (!snapshot.hasData) {
          body = const Center(child: CircularProgressIndicator.adaptive());
        } else {
          final tree = mailboxTree(snapshot.data!);
          body = ListView.builder(
            controller: PrimaryScrollController.maybeOf(context),
            itemCount: tree.length,
            itemBuilder: (context, i) {
              final (m, depth) = tree[i];
              final current = m.id == currentMailboxId;
              final enabled = m.isSelectable && !current;
              return ListTile(
                key: ValueKey('mailbox-${m.id}'),
                contentPadding: EdgeInsetsDirectional.only(start: 20.0 + depth * 20, end: 20),
                leading: Icon(mailboxIcon(m.role), color: enabled ? theme.colorScheme.primary : colors.secondaryText),
                title: Text(m.name),
                trailing: current ? Icon(Icons.check, color: colors.secondaryText) : null,
                enabled: enabled,
                onTap: () => Navigator.of(context).pop(m),
              );
            },
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            ),
            Expanded(child: body),
          ],
        );
      },
    );
  }
}
