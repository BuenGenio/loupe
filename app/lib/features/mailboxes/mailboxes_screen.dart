import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../router.dart';
import '../../settings/ui_state.dart';
import '../../shared/bars.dart';
import '../../shared/grouped_list.dart';
import '../../shared/mailbox_display.dart';
import '../../shared/sync_status.dart';
import '../../shared/tags.dart';
import '../../theme/theme.dart';
import '../compose/compose_args.dart';
import '../search/search_session.dart';
import '../search/search_view.dart';

/// The first screen: unified mailboxes, each account's folder tree, smart
/// mailboxes and tags. Pull down for search; Edit hides items.
class MailboxesScreen extends ConsumerStatefulWidget {
  const MailboxesScreen({super.key});

  @override
  ConsumerState<MailboxesScreen> createState() => _MailboxesScreenState();
}

class _MailboxesScreenState extends ConsumerState<MailboxesScreen> {
  bool _editing = false;
  bool _searching = false;
  ScrollController? _scroll;
  final _focus = FocusNode();

  /// Replaced to reset the navigation bar's own search state (it can only be
  /// closed by tapping Cancel otherwise), e.g. on Android Back.
  Key _navBarKey = UniqueKey();
  late final SearchSession _search = SearchSession(repository: ref.read(repositoryProvider));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Start scrolled past the search field: it appears when pulled down.
    _scroll ??= ScrollController(initialScrollOffset: searchBarExtent(context));
  }

  @override
  void dispose() {
    _scroll?.dispose();
    _focus.dispose();
    _search.dispose();
    super.dispose();
  }

  void _onSearchActive(bool active) {
    setState(() {
      _searching = active;
      if (active) _editing = false;
    });
    if (active) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focus.requestFocus();
      });
    } else {
      _focus.unfocus();
      _search.clear();
    }
  }

  /// Closes search from outside the bar (Android Back).
  void _closeSearch() {
    setState(() => _navBarKey = UniqueKey());
    _onSearchActive(false);
  }

  void _open(MailboxRef target) => context.push(Routes.list(target));

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    _search.controller
      ..operatorColor = colors.unreadDot
      ..keywordColor = colors.swipeArchive
      ..quotedColor = colors.success
      ..errorColor = colors.destructive;
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
    return PopScope(
      canPop: !_searching,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _searching) _closeSearch();
      },
      child: Scaffold(
        // Search results are a plain list, like the message list.
        backgroundColor: _searching ? null : colors.groupedBackground,
        bottomNavigationBar: _searching
            ? null
            : LoupeBottomBar(
                center: const SyncStatusLine(),
                trailing: BarIconButton(
                  icon: CupertinoIcons.square_pencil,
                  tooltip: 'New Message',
                  onPressed: () => openCompose(context),
                ),
              ),
        body: CustomScrollView(
          controller: _scroll,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            CupertinoSliverNavigationBar.search(
              key: _navBarKey,
              largeTitle: const Text('Mailboxes'),
              backgroundColor: colors.barBackground,
              border: Border(bottom: BorderSide(color: colors.separator, width: 0.5)),
              leading: _editing
                  ? null
                  : CupertinoButton(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(44, 44),
                      onPressed: () => context.push(Routes.settings),
                      child: const Icon(CupertinoIcons.gear, semanticLabel: 'Settings'),
                    ),
              trailing: BarTextButton(
                label: _editing ? 'Done' : 'Edit',
                bold: _editing,
                onPressed: () {
                  unawaited(HapticFeedback.selectionClick());
                  setState(() => _editing = !_editing);
                },
              ),
              searchField: LoupeSearchField(
                controller: _search.controller,
                focusNode: _focus,
                onChanged: _search.onChanged,
                onSubmitted: (_) => _search.submit(),
              ),
              onSearchableBottomTap: _onSearchActive,
            ),
            if (_searching)
              SearchSlivers(session: _search)
            else ...[
              CupertinoSliverRefreshControl(onRefresh: () => ref.read(repositoryProvider).refresh()),
              const SliverToBoxAdapter(child: SizedBox(height: 4)),
              SliverToBoxAdapter(
                child: _VirtualSection(editing: _editing, onOpen: _open),
              ),
              for (final account in accounts)
                SliverToBoxAdapter(
                  child: _AccountSection(key: ValueKey(account.id), account: account, editing: _editing, onOpen: _open),
                ),
              SliverToBoxAdapter(child: _SmartSection(editing: _editing)),
              SliverToBoxAdapter(child: _TagSection(editing: _editing)),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ],
        ),
      ),
    );
  }
}

/// A row of the Mailboxes screen, with Edit-mode visibility toggles.
class _MailboxTile extends StatelessWidget {
  const _MailboxTile({
    super.key,
    required this.title,
    required this.icon,
    required this.editing,
    required this.visible,
    required this.onToggleVisible,
    this.iconColor,
    this.count,
    this.onTap,
    this.depth = 0,
    this.expanded,
    this.onToggleExpanded,
    this.trailing,
    this.reserveDisclosure = false,
  });

  final String title;
  final IconData icon;
  final Color? iconColor;
  final int? count;
  final VoidCallback? onTap;
  final bool editing;
  final bool visible;
  final VoidCallback onToggleVisible;
  final int depth;

  /// Non-null for folders with subfolders.
  final bool? expanded;
  final VoidCallback? onToggleExpanded;
  final Widget? trailing;

  /// Keeps the disclosure column so icons line up in sections with subfolders.
  final bool reserveDisclosure;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final metrics = LoupeMetrics.of(context);
    return InkWell(
      onTap: editing ? onToggleVisible : onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: metrics.groupedRowHeight),
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: (reserveDisclosure ? 12 : 16) + depth * 18.0, end: 12),
          child: Row(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: editing
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          visible ? CupertinoIcons.checkmark_circle_fill : CupertinoIcons.circle,
                          color: visible ? colors.unreadDot : colors.tertiaryText,
                          size: 23,
                          semanticLabel: visible ? 'Shown' : 'Hidden',
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              if (expanded != null || reserveDisclosure)
                SizedBox(
                  width: 18,
                  child: expanded == null
                      ? null
                      : GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: onToggleExpanded,
                          child: Semantics(
                            button: true,
                            label: expanded! ? 'Collapse' : 'Expand',
                            child: AnimatedRotation(
                              turns: expanded! ? 0.25 : 0,
                              duration: const Duration(milliseconds: 180),
                              child: Icon(CupertinoIcons.chevron_forward, size: 14, color: colors.secondaryText),
                            ),
                          ),
                        ),
                ),
              Icon(icon, color: iconColor ?? colors.unreadDot, size: 23),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: styles.body.copyWith(color: editing && !visible ? colors.secondaryText : colors.label),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (count != null && count! > 0 && !editing)
                Text('$count', style: styles.body.copyWith(color: colors.secondaryText)),
              ?trailing,
              if (!editing && trailing == null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8),
                  child: Icon(CupertinoIcons.chevron_forward, size: 16, color: colors.tertiaryText),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

typedef _Visibility = ({bool Function(String key) visible, void Function(String key) toggle});

_Visibility _visibility(WidgetRef ref) {
  final hidden = ref.watch(hiddenMailboxItemsProvider);
  return (
    visible: (key) => !hidden.contains(key),
    toggle: (key) => unawaited(ref.read(hiddenMailboxItemsProvider.notifier).toggle(key)),
  );
}

class _VirtualSection extends ConsumerWidget {
  const _VirtualSection({required this.editing, required this.onOpen});

  final bool editing;
  final void Function(MailboxRef) onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counts = ref.watch(virtualCountsProvider).value ?? const <VirtualMailbox, int>{};
    final v = _visibility(ref);
    const order = [
      VirtualMailbox.allInboxes,
      VirtualMailbox.vip,
      VirtualMailbox.flagged,
      VirtualMailbox.unread,
      VirtualMailbox.allDrafts,
      VirtualMailbox.allSent,
    ];
    final rows = [
      for (final kind in order)
        if (editing || v.visible('v.${kind.name}'))
          _MailboxTile(
            key: ValueKey(kind),
            title: virtualMailboxTitle(kind),
            icon: virtualMailboxIcon(kind),
            iconColor: kind == VirtualMailbox.flagged ? LoupeColors.of(context).flag : null,
            count: kind == VirtualMailbox.allSent ? null : counts[kind],
            editing: editing,
            visible: v.visible('v.${kind.name}'),
            onToggleVisible: () => v.toggle('v.${kind.name}'),
            onTap: () => onOpen(VirtualMailboxRef(kind)),
          ),
    ];
    if (rows.isEmpty) return const SizedBox.shrink();
    return InsetGroup(separatorIndent: 51, children: rows);
  }
}

class _AccountSection extends ConsumerWidget {
  const _AccountSection({super.key, required this.account, required this.editing, required this.onOpen});

  final MailAccount account;
  final bool editing;
  final void Function(MailboxRef) onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final collapsed = ref.watch(collapsedAccountsProvider).contains(account.id);
    final expanded = ref.watch(expandedFoldersProvider);
    final mailboxes = (ref.watch(mailboxesProvider).value ?? const <Mailbox>[])
        .where((m) => m.accountId == account.id)
        .toList();
    final v = _visibility(ref);
    final tree = mailboxTree(mailboxes, expanded: expanded);
    final nested = tree.any((n) => n.hasChildren);
    final rows = <Widget>[
      if (!collapsed)
        for (final node in tree)
          if (editing || v.visible('m.${node.mailbox.id}'))
            _MailboxTile(
              key: ValueKey(node.mailbox.id),
              title: mailboxDisplayName(node.mailbox),
              icon: mailboxIcon(node.mailbox.role),
              depth: node.depth,
              count: switch (node.mailbox.role) {
                MailboxRole.drafts => node.mailbox.totalCount,
                MailboxRole.sent || MailboxRole.trash || MailboxRole.all || MailboxRole.archive => null,
                _ => node.mailbox.unreadCount,
              },
              expanded: node.hasChildren ? expanded.contains(node.mailbox.id) : null,
              reserveDisclosure: nested,
              onToggleExpanded: () {
                unawaited(HapticFeedback.selectionClick());
                unawaited(ref.read(expandedFoldersProvider.notifier).toggle(node.mailbox.id));
              },
              editing: editing,
              visible: v.visible('m.${node.mailbox.id}'),
              onToggleVisible: () => v.toggle('m.${node.mailbox.id}'),
              onTap: node.mailbox.isSelectable ? () => onOpen(RealMailboxRef(node.mailbox.id)) : null,
            ),
    ];
    return InsetGroup(
      header: account.displayName,
      largeHeader: true,
      // Separators start where the titles do.
      separatorIndent: nested ? 65 : 51,
      headerLeading: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: colors.accountColor(account.colorIndex), shape: BoxShape.circle),
      ),
      headerTrailing: Semantics(
        button: true,
        label: collapsed ? 'Show ${account.displayName}' : 'Hide ${account.displayName}',
        child: AnimatedRotation(
          turns: collapsed ? 0 : 0.25,
          duration: const Duration(milliseconds: 200),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(CupertinoIcons.chevron_forward, size: 18, color: colors.unreadDot),
          ),
        ),
      ),
      onHeaderTap: () {
        unawaited(HapticFeedback.selectionClick());
        unawaited(ref.read(collapsedAccountsProvider.notifier).toggle(account.id));
      },
      children: rows,
    );
  }
}

class _SmartSection extends ConsumerWidget {
  const _SmartSection({required this.editing});

  final bool editing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final smart = ref.watch(smartMailboxesProvider);
    final colors = LoupeColors.of(context);
    final v = _visibility(ref);
    return InsetGroup(
      header: 'Smart Mailboxes',
      largeHeader: true,
      separatorIndent: 51,
      footer: smart.isEmpty ? 'Save a search to keep it here.' : null,
      children: [
        for (final s in smart)
          if (editing || v.visible('smart.${s.id}'))
            _MailboxTile(
              key: ValueKey(s.id),
              title: s.name,
              icon: CupertinoIcons.gear_alt,
              editing: editing,
              visible: v.visible('smart.${s.id}'),
              onToggleVisible: () => v.toggle('smart.${s.id}'),
              onTap: () => context.push(Routes.smartMailbox(s.id)),
              trailing: editing
                  ? CupertinoButton(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(36, 36),
                      onPressed: () => ref.read(smartMailboxesProvider.notifier).remove(s.id),
                      child: Icon(CupertinoIcons.minus_circle_fill, color: colors.destructive, semanticLabel: 'Delete'),
                    )
                  : null,
            ),
      ],
    );
  }
}

class _TagSection extends ConsumerWidget {
  const _TagSection({required this.editing});

  final bool editing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final v = _visibility(ref);
    final rows = [
      for (final tag in TagDefinition.thunderbirdDefaults)
        if (editing || v.visible('tag.${tag.keyword}'))
          _MailboxTile(
            key: ValueKey(tag.keyword),
            title: tag.label,
            icon: CupertinoIcons.tag_fill,
            iconColor: tagColor(tag.keyword),
            editing: editing,
            visible: v.visible('tag.${tag.keyword}'),
            onToggleVisible: () => v.toggle('tag.${tag.keyword}'),
            onTap: () => context.push(Routes.search(SearchTokens.tag(tag.keyword))),
          ),
    ];
    if (rows.isEmpty) return const SizedBox.shrink();
    return InsetGroup(header: 'Tags', largeHeader: true, separatorIndent: 51, children: rows);
  }
}
