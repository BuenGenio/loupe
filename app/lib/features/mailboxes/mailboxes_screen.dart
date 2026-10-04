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
import '../../shared/format.dart';
import '../../shared/grouped_list.dart';
import '../../shared/mailbox_display.dart';
import '../../shared/sync_status.dart';
import '../../shared/tags.dart';
import '../../theme/theme.dart';
import '../compose/compose_args.dart';
import '../compose/compose_recovery.dart';
import '../compose/send_later.dart';
import '../keyboard/mail_commands.dart';
import '../mailing_lists/list_providers.dart';
import '../outbox/outbox_screen.dart';
import '../palette/command_palette.dart';
import '../panes/mail_selection.dart';
import '../panes/message_drag.dart';
import '../panes/pane_layout.dart';
import '../search/search_session.dart';
import '../search/search_view.dart';
import '../snooze/snoozed_screen.dart';
import 'vip_screen.dart';
import '../../theme/loupe_icons.dart';

/// The first screen: unified mailboxes, each account's folder tree, smart
/// mailboxes and tags. Pull down for search; Edit hides items.
class MailboxesScreen extends ConsumerStatefulWidget {
  const MailboxesScreen({super.key});

  @override
  ConsumerState<MailboxesScreen> createState() => _MailboxesScreenState();
}

class _MailboxesScreenState extends ConsumerState<MailboxesScreen> with CommandScopeState<MailboxesScreen> {
  bool _editing = false;
  bool _searching = false;
  final _scroll = ScrollController();
  final _focus = FocusNode();
  late final SearchSession _search = SearchSession(
    repository: ref.read(repositoryProvider),
    onCommit: (q) => ref.read(recentSearchesProvider.notifier).add(q),
  );

  @override
  void initState() {
    super.initState();
    // Focusing the field (a tap, the keyboard) enters search.
    _focus.addListener(() {
      if (_focus.hasFocus && !_searching) _setSearching(true);
    });
    // Scheduled messages ask for their wake-up again on every launch, in
    // case the system dropped it (this screen lives as long as the app).
    ref.listenManual(outboxProvider, (_, next) {
      final now = DateTime.now();
      for (final item in next.value ?? const <OutboxItem>[]) {
        if (item.status == OutboxStatus.scheduled && item.sendAt.isAfter(now)) wakeUpAt(ref, item.sendAt);
      }
    }, fireImmediately: true);
    // So do snoozed messages, from this device or another one.
    ref.listenManual(snoozedProvider, (_, next) {
      final now = DateTime.now();
      for (final e in next.value ?? const <EmailSummary>[]) {
        final at = e.snoozedUntil;
        if (at != null && at.isAfter(now)) wakeUpAt(ref, at.toLocal());
      }
    }, fireImmediately: true);
    // A message left unsent when Loupe last closed: offer to continue it.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) unawaited(offerComposeRecovery(context, ref));
    });
    registerCommands(ref.read(mailCommandsProvider));
  }

  // Keyboard: / searches every mailbox, Esc leaves search or Edit.

  @override
  int get priority => 10;

  @override
  bool canRun(MailCommand command) => switch (command) {
    MailCommand.search || MailCommand.refresh => true,
    MailCommand.back => _searching || _editing,
    _ => false,
  };

  @override
  void run(MailCommand command) {
    switch (command) {
      case MailCommand.search:
        _focus.requestFocus();
      case MailCommand.refresh:
        unawaited(ref.read(repositoryProvider).refresh());
      case MailCommand.back:
        _searching ? _setSearching(false) : setState(() => _editing = false);
      default:
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    _focus.dispose();
    _search.dispose();
    super.dispose();
  }

  void _setSearching(bool active) {
    setState(() {
      _searching = active;
      if (active) _editing = false;
    });
    if (!active) {
      _focus.unfocus();
      _search.clear();
    }
    // Results start at the top; Mailboxes come back with the field showing.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scroll.hasClients) _scroll.jumpTo(0);
    });
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
        if (!didPop && _searching) _setSearching(false);
      },
      child: Scaffold(
        // Search results are a plain list, like the message list.
        backgroundColor: _searching ? null : colors.groupedBackground,
        bottomNavigationBar: _searching
            ? null
            : LoupeBottomBar(
                leading: _editing
                    ? null
                    : BarIconButton(
                        icon: LoupeIcons.settings,
                        tooltip: 'Settings',
                        onPressed: () => context.push(Routes.settings),
                      ),
                center: const SyncStatusLine(),
                trailing: BarIconButton(
                  icon: LoupeIcons.compose,
                  tooltip: 'New Message',
                  onPressed: () => openCompose(context),
                ),
              ),
        body: CustomScrollView(
          controller: _scroll,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            LoupeTitleBar(
              title: 'Mailboxes',
              large: true,
              trailing: [
                BarTextButton(
                  label: _editing ? 'Done' : 'Edit',
                  bold: _editing,
                  onPressed: () {
                    unawaited(HapticFeedback.selectionClick());
                    setState(() => _editing = !_editing);
                  },
                ),
              ],
              searching: _searching,
              onCancelSearch: () => _setSearching(false),
              searchField: LoupeSearchField(
                controller: _search.controller,
                focusNode: _focus,
                onChanged: _search.onChanged,
                onSubmitted: (_) => _search.submit(),
                onLongPress: () => showCommandPalette(context),
              ),
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
              SliverToBoxAdapter(child: _ListsSection(editing: _editing)),
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

/// A row of the Mailboxes screen, with Edit-mode visibility toggles. In the
/// Mailboxes pane it shows whether [target] is the list beside it, and
/// [dropMailbox] takes messages dragged onto it.
class _MailboxTile extends ConsumerWidget {
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
    this.target,
    this.dropMailbox,
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

  /// What it opens in the list pane.
  final ListTarget? target;
  final Mailbox? dropMailbox;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inPane = !editing && MailPaneScope.maybeOf(context)?.pane == MailPane.mailboxes;
    if (!inPane) return _row(context);
    final colors = LoupeColors.of(context);
    final selected = target != null && ref.watch(mailSelectionProvider.select((s) => s.listOrDefault)) == target;
    Widget tile(bool hovering) => Ink(
      color: hovering
          ? colors.unreadDot.withValues(alpha: 0.18)
          : selected
          ? colors.selectedRow
          : null,
      child: _row(context),
    );
    final drop = dropMailbox;
    if (drop == null) return tile(false);
    return MailboxDropTarget(mailbox: drop, builder: (context, hovering) => tile(hovering));
  }

  Widget _row(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final metrics = LoupeMetrics.of(context);
    return InkWell(
      onTap: editing ? onToggleVisible : onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: metrics.groupedRowHeight),
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: (reserveDisclosure ? 12 : 16) + folderIndent(depth), end: 12),
          child: Row(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: editing
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          visible ? LoupeIcons.selected : LoupeIcons.unselected,
                          color: visible ? colors.unreadDot : colors.tertiaryText,
                          size: 24,
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
                              child: Icon(LoupeIcons.disclosure, size: 14, color: colors.secondaryText),
                            ),
                          ),
                        ),
                ),
              Icon(icon, color: iconColor ?? colors.unreadDot, size: 24),
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
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8),
                  child: Text(formatCount(count!), style: styles.body.copyWith(color: colors.secondaryText)),
                ),
              ?trailing,
              if (!editing && trailing == null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8),
                  child: Icon(LoupeIcons.disclosure, size: 16, color: colors.tertiaryText),
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
    final outbox = ref.watch(outboxProvider).value ?? const <OutboxItem>[];
    final snoozed = ref.watch(snoozedProvider).value ?? const <EmailSummary>[];
    final colors = LoupeColors.of(context);
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
            target: MailboxTarget(VirtualMailboxRef(kind)),
            trailing: kind == VirtualMailbox.vip && !editing
                ? CupertinoButton(
                    padding: const EdgeInsets.only(left: 8),
                    minimumSize: const Size(36, 36),
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const VipScreen())),
                    child: const Icon(LoupeIcons.info, size: 22, semanticLabel: 'Manage VIPs'),
                  )
                : null,
          ),
      // While something is snoozed; Edit can hide it.
      if (editing || (snoozed.isNotEmpty && v.visible('v.snoozed')))
        _MailboxTile(
          key: const ValueKey('snoozed'),
          title: 'Snoozed',
          icon: LoupeIcons.snoozed,
          count: snoozed.length,
          editing: editing,
          visible: v.visible('v.snoozed'),
          onToggleVisible: () => v.toggle('v.snoozed'),
          onTap: () => context.push(Routes.snoozed),
          target: const SnoozedTarget(),
        ),
      // Only while something waits to be sent; it can't be hidden.
      if (outbox.isNotEmpty && !editing)
        _MailboxTile(
          key: const ValueKey('outbox'),
          title: 'Outbox',
          icon: LoupeIcons.outbox,
          iconColor: outbox.any((o) => o.status == OutboxStatus.failed) ? colors.destructive : null,
          count: outbox.length,
          editing: false,
          visible: true,
          onToggleVisible: () {},
          onTap: () => context.push(Routes.outbox),
          target: const OutboxTarget(),
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
    // The Loupe Settings folder holds Smart Mailboxes, not mail; the Snoozed
    // folder shows as the Snoozed mailbox at the top.
    final mailboxes = (ref.watch(mailboxesProvider).value ?? const <Mailbox>[])
        .where((m) => m.accountId == account.id && !ServerDocuments.isFolder(m) && !Snooze.isFolder(m))
        .toList();
    final v = _visibility(ref);
    final showAll = ref.watch(showAllFoldersProvider).contains(account.id);
    final tree = mailboxTree(showAll ? mailboxes : subscribedFolders(mailboxes), expanded: expanded);
    final nested = tree.any((n) => n.hasChildren);
    void toggleExpanded(String mailboxId) {
      unawaited(HapticFeedback.selectionClick());
      unawaited(ref.read(expandedFoldersProvider.notifier).toggle(mailboxId));
    }

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
              onToggleExpanded: () => toggleExpanded(node.mailbox.id),
              editing: editing,
              visible: v.visible('m.${node.mailbox.id}'),
              onToggleVisible: () => v.toggle('m.${node.mailbox.id}'),
              // A container opens and closes like its disclosure arrow.
              onTap: node.mailbox.isSelectable
                  ? () => onOpen(RealMailboxRef(node.mailbox.id))
                  : node.hasChildren
                  ? () => toggleExpanded(node.mailbox.id)
                  : null,
              target: MailboxTarget(RealMailboxRef(node.mailbox.id)),
              dropMailbox: node.mailbox,
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
            child: Icon(LoupeIcons.disclosure, size: 18, color: colors.unreadDot),
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

/// Mailing lists by List-Id, once there is list mail.
class _ListsSection extends ConsumerWidget {
  const _ListsSection({required this.editing});

  final bool editing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(mailingListsProvider).value ?? const <MailingList>[];
    final v = _visibility(ref);
    final rows = [
      for (final l in lists)
        if (editing || v.visible('list.${l.id}'))
          _MailboxTile(
            key: ValueKey('list.${l.id}'),
            title: l.name,
            icon: LoupeIcons.mailingList,
            count: l.unreadCount,
            editing: editing,
            visible: v.visible('list.${l.id}'),
            onToggleVisible: () => v.toggle('list.${l.id}'),
            onTap: () => context.push(Routes.mailingList(l.id)),
            target: MailingListTarget(l.id),
          ),
    ];
    if (rows.isEmpty) return const SizedBox.shrink();
    return InsetGroup(header: 'Mailing Lists', largeHeader: true, separatorIndent: 51, children: rows);
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
              icon: LoupeIcons.smartMailbox,
              editing: editing,
              visible: v.visible('smart.${s.id}'),
              onToggleVisible: () => v.toggle('smart.${s.id}'),
              onTap: () => context.push(Routes.smartMailbox(s.id)),
              target: SmartMailboxTarget(s.id),
              trailing: editing
                  ? CupertinoButton(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(36, 36),
                      onPressed: () => ref.read(smartMailboxesProvider.notifier).remove(s.id),
                      child: Icon(LoupeIcons.remove, color: colors.destructive, semanticLabel: 'Delete'),
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
            icon: LoupeIcons.tagFilled,
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
