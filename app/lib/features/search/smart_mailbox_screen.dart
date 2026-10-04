import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../router.dart';
import '../../settings/ui_state.dart';
import '../../shared/mailbox_ref_codec.dart';
import '../../shared/sheets.dart';
import '../../theme/theme.dart';
import 'search_session.dart';
import 'search_view.dart';

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
        SheetAction('Rename', 'rename', icon: CupertinoIcons.pencil),
        SheetAction('Edit Search', 'edit', icon: CupertinoIcons.search),
        SheetAction('Delete Smart Mailbox', 'delete', icon: CupertinoIcons.trash, destructive: true),
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
        appBar: AppBar(),
        body: Center(child: Text('This smart mailbox was deleted.', style: LoupeTextStyles.of(context).footnote)),
      );
    }
    final session = _sessionFor(box);
    final colors = LoupeColors.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(box.name),
            previousPageTitle: 'Mailboxes',
            backgroundColor: colors.barBackground,
            border: Border(bottom: BorderSide(color: colors.separator, width: 0.5)),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _menu(box),
              child: const Icon(CupertinoIcons.ellipsis_circle, semanticLabel: 'More'),
            ),
          ),
          CupertinoSliverRefreshControl(onRefresh: session.rerun),
          SearchSlivers(session: session, showSuggestions: false),
        ],
      ),
    );
  }
}
