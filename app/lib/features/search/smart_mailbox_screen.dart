import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

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
}) {
  final ownerId = box.accountId ?? home;
  final owner = accounts.where((a) => a.id == ownerId).firstOrNull;
  if (home == null || owner == null) return (LoupeIcons.thisDevice, 'On this device only');
  final name = owner.displayName;
  if (status.unsupported.contains(owner.id)) return (LoupeIcons.thisDevice, 'On this device only: $name can’t keep it');
  if (status.newerFormat.contains(owner.id)) return (LoupeIcons.warning, 'Not synced: $name has a newer format');
  if (status.pending || status.failed.containsKey(owner.id) || !status.synced.containsKey(owner.id)) {
    return (LoupeIcons.syncPending, 'Waiting to sync to $name');
  }
  return (LoupeIcons.synced, 'Synced to $name');
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
    final choice = await showActionSheet<String>(
      context,
      title: box.name,
      message: box.query,
      actions: const [
        SheetAction('Rename', 'rename', icon: LoupeIcons.rename),
        SheetAction('Edit Search', 'edit', icon: LoupeIcons.search),
        SheetAction('Delete Smart Mailbox', 'delete', icon: LoupeIcons.trash, destructive: true),
      ],
    );
    if (!mounted) return;
    switch (choice) {
      case 'rename':
        final name = await showTextPrompt(context, title: 'Rename Smart Mailbox', initial: box.name);
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
    final box = ref.watch(smartMailboxesProvider).where((s) => s.id == widget.id).firstOrNull;
    if (box == null) {
      return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: showsBackButton(context)),
        body: Center(child: Text('This smart mailbox was deleted.', style: LoupeTextStyles.of(context).footnote)),
      );
    }
    final session = _sessionFor(box);
    final colors = LoupeColors.of(context);
    final (syncIcon, syncText) = smartMailboxSyncLabel(
      box,
      home: ref.watch(smartMailboxHomeProvider),
      accounts: ref.watch(accountsProvider).value ?? const <MailAccount>[],
      status: ref.watch(smartMailboxSyncStatusProvider),
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          LoupeTitleBar(
            title: box.name,
            trailing: [BarIconButton(icon: LoupeIcons.moreCircle, tooltip: 'More', onPressed: () => _menu(box))],
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
