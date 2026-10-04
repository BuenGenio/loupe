import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mail_model/mail_model.dart';

import '../../shared/avatar.dart';
import '../../shared/tags.dart';
import '../../theme/theme.dart';
import '../compose/compose_text.dart';
import 'sheets.dart';
import '../../theme/loupe_icons.dart';

/// What the "…" menu of a message can do.
enum MessageAction {
  reply,
  replyAll,
  forward,
  toggleSeen,
  toggleFlag,
  tags,
  snooze,
  wakeNow,
  move,
  archive,
  trash,
  junk,
  notJunk,
  headers,
  source,
  search,
}

/// The "…" menu of [message]. [canArchive]: the account has an archive
/// mailbox and the message isn't in it. [mailboxRole]: where it lives now.
/// [snoozed]: it waits in the Snoozed folder (Wake Now, Change Time).
Future<MessageAction?> showMessageMenu(
  BuildContext context, {
  required EmailSummary message,
  required bool canArchive,
  required MailboxRole mailboxRole,
  bool snoozed = false,
}) {
  final junk = mailboxRole == MailboxRole.junk || message.keywords.contains(Keywords.junk);
  return showLoupeSheet<MessageAction>(
    context,
    builder: (context) {
      void pick(MessageAction a) => Navigator.of(context).pop(a);
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  for (final (action, icon, label) in const [
                    (MessageAction.reply, LoupeIcons.reply, 'Reply'),
                    (MessageAction.replyAll, LoupeIcons.replyAll, 'Reply All'),
                    (MessageAction.forward, LoupeIcons.forward, 'Forward'),
                  ])
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _BigButton(icon: icon, label: label, onTap: () => pick(action)),
                      ),
                    ),
                ],
              ),
            ),
            SheetGroup(
              children: [
                SheetRow(
                  label: message.isSeen ? 'Mark as Unread' : 'Mark as Read',
                  icon: message.isSeen ? LoupeIcons.markUnread : LoupeIcons.markRead,
                  onTap: () => pick(MessageAction.toggleSeen),
                ),
                SheetRow(
                  label: message.isFlagged ? 'Unflag' : 'Flag',
                  icon: LoupeIcons.flagged,
                  onTap: () => pick(MessageAction.toggleFlag),
                ),
                SheetRow(label: 'Tags…', icon: LoupeIcons.tag, onTap: () => pick(MessageAction.tags)),
              ],
            ),
            SheetGroup(
              children: [
                if (snoozed) ...[
                  SheetRow(label: 'Wake Now', icon: LoupeIcons.wakeNow, onTap: () => pick(MessageAction.wakeNow)),
                  SheetRow(
                    label: 'Change Snooze Time…',
                    icon: LoupeIcons.snooze,
                    onTap: () => pick(MessageAction.snooze),
                  ),
                ] else
                  SheetRow(label: 'Snooze…', icon: LoupeIcons.snooze, onTap: () => pick(MessageAction.snooze)),
                SheetRow(label: 'Move…', icon: LoupeIcons.move, onTap: () => pick(MessageAction.move)),
                if (canArchive)
                  SheetRow(label: 'Archive', icon: LoupeIcons.archive, onTap: () => pick(MessageAction.archive)),
                SheetRow(
                  label: mailboxRole == MailboxRole.trash ? 'Delete Permanently' : 'Move to Trash',
                  icon: LoupeIcons.trash,
                  destructive: true,
                  onTap: () => pick(MessageAction.trash),
                ),
                junk
                    ? SheetRow(label: 'Not Junk', icon: LoupeIcons.notJunk, onTap: () => pick(MessageAction.notJunk))
                    : SheetRow(label: 'Move to Junk', icon: LoupeIcons.junk, onTap: () => pick(MessageAction.junk)),
              ],
            ),
            SheetGroup(
              children: [
                SheetRow(label: 'Show All Headers', icon: LoupeIcons.headers, onTap: () => pick(MessageAction.headers)),
                SheetRow(label: 'View Source', icon: LoupeIcons.source, onTap: () => pick(MessageAction.source)),
                SheetRow(
                  label: 'Search from This Message…',
                  icon: LoupeIcons.searchSender,
                  onTap: () => pick(MessageAction.search),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class _BigButton extends StatelessWidget {
  const _BigButton({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: groupFill(context),
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(height: 4),
              Text(label, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

/// The sheet for a tapped address: VIP, new message, copy and search.
Future<void> showAddressSheet(
  BuildContext context, {
  required EmailAddress address,
  required MailRepository repository,
  required VoidCallback onCompose,
  required VoidCallback onSearch,
}) {
  final messenger = ScaffoldMessenger.of(context);
  return showLoupeSheet<void>(
    context,
    builder: (context) {
      final theme = Theme.of(context);
      final colors = LoupeColors.of(context);
      return SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SenderAvatar(address: address, size: 64),
            const SizedBox(height: 8),
            Text(address.displayName, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            SelectableText(address.email, style: TextStyle(color: colors.secondaryText)),
            const SizedBox(height: 16),
            SheetGroup(
              children: [
                StreamBuilder<Set<String>>(
                  stream: repository.watchVipAddresses(),
                  builder: (context, snapshot) {
                    final vips = {...?snapshot.data?.map((e) => e.toLowerCase())};
                    final vip = vips.contains(address.email.toLowerCase());
                    return SwitchListTile.adaptive(
                      key: const Key('vip-switch'),
                      dense: true,
                      secondary: Icon(vip ? LoupeIcons.vipFilled : LoupeIcons.vip, color: colors.vip),
                      title: const Text('VIP', style: TextStyle(fontSize: 16)),
                      value: vip,
                      onChanged: snapshot.hasData
                          ? (v) async {
                              try {
                                await repository.setVip(address.email, vip: v);
                              } on MailException catch (e) {
                                showSnack(messenger, e.message);
                              }
                            }
                          : null,
                    );
                  },
                ),
                SheetRow(
                  label: 'New Message',
                  icon: LoupeIcons.edit,
                  onTap: () {
                    Navigator.of(context).pop();
                    onCompose();
                  },
                ),
                SheetRow(
                  label: 'Copy Address',
                  icon: LoupeIcons.copy,
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: address.email));
                    Navigator.of(context).pop();
                    showSnack(messenger, 'Address copied');
                  },
                ),
                SheetRow(
                  label: 'Search Messages from ${address.displayName}',
                  icon: LoupeIcons.search,
                  onTap: () {
                    Navigator.of(context).pop();
                    onSearch();
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

/// Multi-select of Thunderbird tags; changes apply at once.
Future<void> showTagsSheet(
  BuildContext context, {
  required EmailSummary message,
  required Future<void> Function(String keyword, bool on) onToggle,
}) {
  final defaults = TagDefinition.thunderbirdDefaults.map((t) => t.keyword).toList();
  final keywords = [...defaults, ...message.tags.where((t) => !defaults.contains(t))];
  final selected = {...message.tags};
  return showLoupeSheet<void>(
    context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: SheetGroup(
            header: 'Tags',
            children: [
              for (final k in keywords)
                ListTile(
                  key: ValueKey('tag-$k'),
                  dense: true,
                  leading: Icon(LoupeIcons.dot, size: 14, color: tagColor(k)),
                  title: Text(tagLabel(k), style: const TextStyle(fontSize: 16)),
                  trailing: selected.contains(k)
                      ? Icon(LoupeIcons.check, color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () {
                    final on = !selected.contains(k);
                    setState(() => on ? selected.add(k) : selected.remove(k));
                    onToggle(k, on);
                  },
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Every header field of a message, selectable.
Future<void> showHeadersSheet(BuildContext context, List<(String, String)> headers) {
  final messenger = ScaffoldMessenger.of(context);
  return showLoupeSheet<void>(
    context,
    expand: true,
    builder: (context) {
      final theme = Theme.of(context);
      final colors = LoupeColors.of(context);
      return Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 56),
              Expanded(
                child: Text(
                  'All Headers',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                tooltip: 'Copy All',
                icon: const Icon(LoupeIcons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: headers.map((h) => '${h.$1}: ${h.$2}').join('\n')));
                  showSnack(messenger, 'Headers copied');
                },
              ),
            ],
          ),
          Expanded(
            child: headers.isEmpty
                ? Center(
                    child: Text('No headers', style: TextStyle(color: colors.secondaryText)),
                  )
                : ListView.separated(
                    controller: PrimaryScrollController.maybeOf(context),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: headers.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final (name, value) = headers[i];
                      return SelectableText.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '$name: ',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            TextSpan(text: value),
                          ],
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(fontFamily: 'monospace', fontSize: 12.5),
                      );
                    },
                  ),
          ),
        ],
      );
    },
  );
}

/// "Search from this message": returns a query for the sender, a recipient
/// or the subject.
Future<String?> showSearchFromSheet(BuildContext context, EmailSummary message) {
  String q(String field, String value) => '$field:"${value.replaceAll('"', '')}"';
  final subject = ComposeText.baseSubject(message.subject);
  final to = message.to.firstOrNull;
  return showActionSheet<String>(
    context,
    title: 'Search from This Message',
    actions: [
      if (message.sender case final s?) SheetAction('From ${s.displayName}', q('f', s.email)),
      if (to != null) SheetAction('To ${to.displayName}', q('t', to.email)),
      if (subject.isNotEmpty) SheetAction('Subject “$subject”', q('s', subject)),
    ],
  );
}
