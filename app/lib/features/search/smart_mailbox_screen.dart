import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../settings/ui_state.dart';
import '../../shared/bars.dart';
import '../../shared/mailbox_ref_codec.dart';
import '../../shared/sheets.dart';
import '../../theme/theme.dart';
import 'search_session.dart';
import 'search_view.dart';
import '../../theme/loupe_icons.dart';

/// Where a Smart Mailbox is kept, for its detail view: its icon and text.
(IconData, String) smartMailboxSyncLabel(
  SmartMailbox box, {
  required String? home,
  required List<MailAccount> accounts,
  required SmartMailboxSyncStatus status,
  required AppLocalizations l10n,
}) {
  final ownerId = box.accountId ?? home;
  final owner = accounts.where((a) => a.id == ownerId).firstOrNull;
  if (home == null || owner == null) return (LoupeIcons.thisDevice, l10n.searchSyncDeviceOnly);
  final name = owner.displayName;
  if (status.unsupported.contains(owner.id)) return (LoupeIcons.thisDevice, l10n.searchSyncUnsupported(name));
  if (status.newerFormat.contains(owner.id)) return (LoupeIcons.warning, l10n.searchSyncNewerFormat(name));
  if (status.pending || status.failed.containsKey(owner.id) || !status.synced.containsKey(owner.id)) {
    return (LoupeIcons.syncPending, l10n.searchSyncWaiting(name));
  }
  return (LoupeIcons.synced, l10n.searchSynced(name));
}

/// A saved search, shown like a mailbox.
class SmartMailboxScreen extends ConsumerStatefulWidget {
  const SmartMailboxScreen({super.key, required this.id});

  final String id;

  @override
  ConsumerState<SmartMailboxScreen> createState() => _SmartMailboxScreenState();
}

class _SmartMailboxScreenState extends ConsumerState<SmartMailboxScreen> {
  SearchSession? _session;

  @override
  void dispose() {
    _session?.dispose();
    super.dispose();
  }

  SearchSession _sessionFor(SmartMailbox box) => _session ??= SearchSession(
    repository: ref.read(repositoryProvider),
    initialQuery: box.query,
    scope: box.scope == null ? const AllMailboxesScope() : MailboxScope(MailboxRefCodec.decode(box.scope!)),
  );

  Future<void> _menu(SmartMailbox box) async {
    final l10n = context.l10n;
    final choice = await showActionSheet<String>(
      context,
      title: box.name,
      message: box.query,
      actions: [
        SheetAction(l10n.searchRename, 'rename', icon: LoupeIcons.rename),
        SheetAction(l10n.searchEditSearch, 'edit', icon: LoupeIcons.search),
        SheetAction(l10n.searchDeleteSmartMailbox, 'delete', icon: LoupeIcons.trash, destructive: true),
      ],
    );
    if (!mounted) return;
    switch (choice) {
      case 'rename':
        final name = await showTextPrompt(context, title: l10n.searchRenameSmartMailbox, initial: box.name);
        if (name != null && name.isNotEmpty) await ref.read(smartMailboxesProvider.notifier).rename(box.id, name);
      case 'edit':
        await context.push(Routes.search(box.query));
      case 'delete':
        await ref.read(smartMailboxesProvider.notifier).remove(box.id);
        if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final box = ref.watch(smartMailboxesProvider).where((s) => s.id == widget.id).firstOrNull;
    if (box == null) {
      return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: showsBackButton(context)),
        body: Center(child: Text(l10n.searchSmartMailboxDeleted, style: LoupeTextStyles.of(context).footnote)),
      );
    }
    final session = _sessionFor(box);
    final colors = LoupeColors.of(context);
    final (syncIcon, syncText) = smartMailboxSyncLabel(
      box,
      home: ref.watch(smartMailboxHomeProvider),
      accounts: ref.watch(accountsProvider).value ?? const <MailAccount>[],
      status: ref.watch(smartMailboxSyncStatusProvider),
      l10n: l10n,
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          LoupeTitleBar(
            title: box.name,
            trailing: [
              BarIconButton(icon: LoupeIcons.moreCircle, tooltip: l10n.commonMore, onPressed: () => _menu(box)),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
              child: Row(
                children: [
                  Icon(syncIcon, size: 14, color: colors.secondaryText),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      syncText,
                      style: LoupeTextStyles.of(context).footnote,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              unawaited(ref.read(smartMailboxesProvider.notifier).sync());
              await session.rerun();
            },
          ),
          SearchSlivers(session: session, showSuggestions: false),
        ],
      ),
    );
  }
}
