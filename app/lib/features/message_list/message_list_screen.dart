import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../router.dart';
import '../../settings/app_settings.dart';
import '../../settings/ui_state.dart';
import '../../shared/bars.dart';
import '../../shared/format.dart';
import '../../shared/mail_actions.dart';
import '../../shared/mailbox_display.dart';
import '../../shared/message_row.dart';
import '../../shared/sheets.dart';
import '../../shared/swipe_row.dart';
import '../../shared/sync_status.dart';
import '../../theme/theme.dart';
import '../compose/compose_args.dart';
import '../conversation/sheets.dart' show showSnack;
import '../keyboard/mail_commands.dart';
import '../palette/command_palette.dart';
import '../panes/mail_selection.dart';
import '../panes/message_drag.dart';
import '../panes/pane_layout.dart';
import '../search/search_session.dart';
import '../search/search_view.dart';
import '../../theme/loupe_icons.dart';

/// Label of a quick filter in the Filter sheet and the toolbar.
String quickFilterLabel(QuickFilter f) => switch (f) {
  QuickFilter.unread => 'Unread',
  QuickFilter.flagged => 'Flagged',
  QuickFilter.toMe => 'To: Me',
  QuickFilter.ccMe => 'CC: Me',
  QuickFilter.hasAttachment => 'With Attachments',
  QuickFilter.unreplied => 'Unreplied',
  QuickFilter.fromVip => 'From VIPs',
};

IconData quickFilterIcon(QuickFilter f) => switch (f) {
  QuickFilter.unread => LoupeIcons.unread,
  QuickFilter.flagged => LoupeIcons.flagged,
  QuickFilter.toMe => LoupeIcons.person,
  QuickFilter.ccMe => LoupeIcons.people,
  QuickFilter.hasAttachment => LoupeIcons.attachment,
  QuickFilter.unreplied => LoupeIcons.reply,
  QuickFilter.fromVip => LoupeIcons.vip,
};

/// A mailbox's messages: large collapsing title with the search field hidden
/// above the list, swipe actions, Filter button and multi-select. In the
/// list pane of the wide layout ([MailHome]) rows open in the conversation
/// pane.
class MessageListScreen extends ConsumerStatefulWidget {
  const MessageListScreen({super.key, required this.mailboxRef});

  final MailboxRef mailboxRef;

  @override
  ConsumerState<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends ConsumerState<MessageListScreen>
    with CommandScopeState<MessageListScreen>
    implements MessageListNeighbors {
  bool _filterOn = false;
  bool _editing = false;
  final _selected = <String>{};
  bool _searching = false;
  bool _loadingOlder = false;
  bool _hasOlder = true;

  /// Whether the list has been scrolled past the search field after the
  /// first rows arrived (while loading, the offset can't stick).
  bool _searchHidden = false;
  ScrollController? _scroll;
  final _focus = FocusNode();
  late final SearchSession _search = SearchSession(
    repository: ref.read(repositoryProvider),
    scope: MailboxScope(widget.mailboxRef),
    onCommit: (q) => ref.read(recentSearchesProvider.notifier).add(q),
  );

  /// The rows last shown.
  List<ThreadSummary> _rows = const [];

  /// The row the keyboard is on (J, K, Enter) on a phone; in the list pane
  /// it is the conversation shown.
  String? _cursor;

  /// Where the conversation shown in the pane was listed, to show the one
  /// that takes its place when it goes away.
  int? _shownIndex;
  final _rowKeys = <String, GlobalKey>{};

  @override
  void initState() {
    super.initState();
    // Focusing the field (a tap, the keyboard) enters search.
    _focus.addListener(() {
      if (_focus.hasFocus && !_searching) _setSearching(true);
    });
    registerCommands(ref.read(mailCommandsProvider));
  }

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

  ListQuery _query(AppSettings settings) => ListQuery(
    widget.mailboxRef,
    filters: _filterOn ? ref.watch(filterCriteriaProvider) : const {},
    threaded: settings.threaded,
  );

  MailActions _actions(AppSettings settings) =>
      MailActions(context, ref, scope: widget.mailboxRef, threaded: settings.threaded);

  void _setSearching(bool active) {
    setState(() {
      _searching = active;
      if (active) {
        _editing = false;
        _selected.clear();
      }
    });
    if (!active) {
      _focus.unfocus();
      _search
        ..clear()
        ..setScope(MailboxScope(widget.mailboxRef));
    }
    // Results start at the top; the list comes back with the field showing.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scroll = _scroll;
      if (mounted && scroll != null && scroll.hasClients) scroll.jumpTo(0);
    });
  }

  void _toggleEditing() {
    unawaited(HapticFeedback.selectionClick());
    setState(() {
      _editing = !_editing;
      _selected.clear();
    });
  }

  /// Whether this is the list pane of the wide layout.
  bool get _inPane => MailPaneScope.paneOf(context) == MailPane.list;

  Future<void> _openRow(ThreadSummary row, {required MailboxRole? role, required MailActions actions}) async {
    final email = row.latest;
    if (role == MailboxRole.drafts || email.isDraft) {
      await openCompose(context, ComposeArgs(mode: ComposeMode.editDraft, sourceEmailId: email.id));
      return;
    }
    if (row.unreadCount > 0) unawaited(actions.setRead([row], read: true));
    if (_inPane) {
      ref.read(mailSelectionProvider.notifier).showMessage(email.id, threadId: row.threadId);
    } else {
      await context.push(Routes.message(email.id));
    }
  }

  // Keyboard and command palette ------------------------------------------------------

  @override
  int get priority => 20;

  MailboxRole? _roleOf(ThreadSummary row) => (ref.read(mailboxesProvider).value ?? const <Mailbox>[])
      .where((m) => m.id == row.latest.mailboxId)
      .firstOrNull
      ?.role;

  int _cursorIndex() {
    if (_inPane) return _rows.indexWhere(ref.read(mailSelectionProvider).shows);
    return _rows.indexWhere((r) => r.threadId == _cursor);
  }

  ThreadSummary? get _cursorRow {
    final i = _cursorIndex();
    return i < 0 ? null : _rows[i];
  }

  /// What row actions apply to: the selection while editing, else the
  /// keyboard's row (phones).
  List<ThreadSummary> get _rowsForAction => _editing
      ? [
          for (final r in _rows)
            if (_selected.contains(r.threadId)) r,
        ]
      : [if (!_inPane) ?_cursorRow];

  @override
  ThreadSummary? neighborOf(EmailSummary email, int delta) {
    final i = _rows.indexWhere(
      (r) =>
          r.latest.id == email.id || r.threadId == email.id || (email.threadId != null && r.threadId == email.threadId),
    );
    final j = i + delta;
    return i < 0 || j < 0 || j >= _rows.length ? null : _rows[j];
  }

  @override
  ThreadSummary? replacementFor(MailSelection selection) {
    if (_rows.isEmpty) return null;
    final i = _rows.indexWhere(selection.shows);
    if (i >= 0) return i + 1 < _rows.length ? _rows[i + 1] : (i > 0 ? _rows[i - 1] : null);
    final was = _shownIndex;
    return was == null ? null : _rows[math.min(was, _rows.length - 1)];
  }

  @override
  bool canRun(MailCommand command) => switch (command) {
    MailCommand.nextMessage || MailCommand.previousMessage => _rows.isNotEmpty && !_searching && !_editing,
    MailCommand.open => !_inPane && !_editing && _cursorRow != null,
    MailCommand.search || MailCommand.refresh => true,
    MailCommand.back => _searching || _editing,
    MailCommand.markAllRead => !_searching,
    MailCommand.reply || MailCommand.replyAll || MailCommand.forward => !_inPane && !_editing && _cursorRow != null,
    MailCommand.archive ||
    MailCommand.trash ||
    MailCommand.toggleRead ||
    MailCommand.toggleFlag ||
    MailCommand.snooze ||
    MailCommand.move => _rowsForAction.isNotEmpty,
    _ => false,
  };

  @override
  void run(MailCommand command) {
    final actions = _actions(ref.read(appSettingsProvider));
    final rows = _rowsForAction;
    Future<void> act(Future<void> Function() action) async {
      await action();
      if (mounted && _editing) _toggleEditing();
    }

    void compose(ComposeMode mode) {
      final row = _cursorRow;
      if (row != null) unawaited(openCompose(context, ComposeArgs(mode: mode, sourceEmailId: row.latest.id)));
    }

    switch (command) {
      case MailCommand.nextMessage:
        _moveCursor(1, actions);
      case MailCommand.previousMessage:
        _moveCursor(-1, actions);
      case MailCommand.open:
        if (_cursorRow case final row?) unawaited(_openRow(row, role: _roleOf(row), actions: actions));
      case MailCommand.search:
        _focus.requestFocus();
      case MailCommand.back:
        _searching ? _setSearching(false) : _toggleEditing();
      case MailCommand.markAllRead:
        unawaited(_markAllRead());
      case MailCommand.refresh:
        unawaited(ref.read(repositoryProvider).refresh(ref: widget.mailboxRef));
      case MailCommand.reply:
        compose(ComposeMode.reply);
      case MailCommand.replyAll:
        compose(ComposeMode.replyAll);
      case MailCommand.forward:
        compose(ComposeMode.forward);
      case MailCommand.archive:
        unawaited(act(() => actions.archive(rows)));
      case MailCommand.trash:
        unawaited(act(() => actions.trash(rows)));
      case MailCommand.toggleRead:
        unawaited(act(() => actions.setRead(rows, read: rows.any((r) => r.unreadCount > 0))));
      case MailCommand.toggleFlag:
        unawaited(act(() => actions.setFlag(rows, flagged: rows.any((r) => !r.latest.isFlagged))));
      case MailCommand.snooze:
        unawaited(act(() => actions.snooze(rows)));
      case MailCommand.move:
        unawaited(act(() => actions.moveWithPicker(rows)));
      default:
    }
  }

  /// J and K: in the pane the next conversation opens beside the list (a
  /// draft shows there too, rather than opening the editor); on a phone the
  /// highlight moves and Enter opens.
  void _moveCursor(int delta, MailActions actions) {
    if (_rows.isEmpty) return;
    final i = _cursorIndex();
    final j = i < 0 ? 0 : (i + delta).clamp(0, _rows.length - 1);
    if (i == j) return;
    final row = _rows[j];
    if (_inPane) {
      if (row.unreadCount > 0) unawaited(actions.setRead([row], read: true));
      ref.read(mailSelectionProvider.notifier).showMessage(row.latest.id, threadId: row.threadId);
    } else {
      setState(() => _cursor = row.threadId);
    }
    _reveal(row, j);
  }

  /// Scrolls [row] (at [index]) into view, jumping near it first when it
  /// isn't built yet.
  void _reveal(ThreadSummary row, int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final ctx = _rowKeys[row.threadId]?.currentContext;
      if (ctx != null) {
        unawaited(Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 120), alignment: 0.5));
        return;
      }
      final scroll = _scroll;
      if (scroll == null || !scroll.hasClients) return;
      final built = _rowKeys.values.map((k) => k.currentContext?.size?.height).nonNulls.firstOrNull ?? 90;
      final estimate = searchBarExtent(context) + index * built;
      scroll.jumpTo(estimate.clamp(0, scroll.position.maxScrollExtent));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ctx = _rowKeys[row.threadId]?.currentContext;
        if (mounted && ctx != null) unawaited(Scrollable.ensureVisible(ctx, alignment: 0.5));
      });
    });
  }

  /// Marks every unread message of this mailbox read (those on the phone).
  Future<void> _markAllRead() async {
    final messenger = ScaffoldMessenger.of(context);
    final repo = ref.read(repositoryProvider);
    final actions = MailActions(context, ref, scope: widget.mailboxRef, threaded: false);
    try {
      final unread = await repo
          .watchList(widget.mailboxRef, filters: const {QuickFilter.unread}, threaded: false, limit: 100000)
          .first;
      if (unread.isEmpty) return;
      await actions.setRead(unread, read: true);
      showSnack(
        messenger,
        unread.length == 1 ? 'Marked 1 message as read' : 'Marked ${unread.length} messages as read',
      );
    } on MailException catch (e) {
      showSnack(messenger, e.message);
    }
  }

  Future<void> _loadOlder() async {
    if (_loadingOlder || !_hasOlder) return;
    setState(() => _loadingOlder = true);
    var more = false;
    try {
      more = await ref.read(repositoryProvider).loadOlder(widget.mailboxRef);
    } on MailException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
    if (!mounted) return;
    setState(() {
      _loadingOlder = false;
      _hasOlder = more;
    });
  }

  bool _onScroll(ScrollNotification n) {
    if (_searching || _loadingOlder || !_hasOlder) return false;
    if (n.metrics.axis == Axis.vertical && n.metrics.extentAfter < 600) {
      // Notifications can arrive during layout; load after the frame.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) unawaited(_loadOlder());
      });
    }
    return false;
  }

  Future<void> _openCriteria() async {
    final current = ref.read(filterCriteriaProvider);
    final next = await showModalBottomSheet<Set<QuickFilter>>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => _FilterSheet(initial: current),
    );
    if (next == null || !mounted) return;
    await ref.read(filterCriteriaProvider.notifier).set(next);
    setState(() => _filterOn = next.isNotEmpty);
  }

  Future<void> _markSelected(List<ThreadSummary> rows, MailActions actions) async {
    final anyUnread = rows.any((r) => r.unreadCount > 0);
    final anyUnflagged = rows.any((r) => !r.latest.isFlagged);
    final choice = await showActionSheet<String>(
      context,
      actions: [
        SheetAction(
          anyUnread ? 'Mark as Read' : 'Mark as Unread',
          'read',
          icon: anyUnread ? LoupeIcons.markRead : LoupeIcons.markUnread,
        ),
        SheetAction(anyUnflagged ? 'Flag' : 'Unflag', 'flag', icon: LoupeIcons.flagged),
        const SheetAction('Snooze…', 'snooze', icon: LoupeIcons.snooze),
        const SheetAction('Move to Junk', 'junk', icon: LoupeIcons.junk),
      ],
    );
    switch (choice) {
      case 'read':
        await actions.setRead(rows, read: anyUnread);
      case 'flag':
        await actions.setFlag(rows, flagged: anyUnflagged);
      case 'snooze':
        // Cancelling the time keeps the selection.
        if (!await actions.snooze(rows)) return;
      case 'junk':
        await actions.junk(rows, junk: true);
      default:
        return;
    }
    if (mounted) _toggleEditing();
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final settings = ref.watch(appSettingsProvider);
    final mailboxes = ref.watch(mailboxesProvider).value ?? const <Mailbox>[];
    final title = mailboxRefTitle(widget.mailboxRef, mailboxes);
    final async = ref.watch(messageListProvider(_query(settings)));
    final rows = async.value ?? const <ThreadSummary>[];
    if (!_searchHidden && rows.isNotEmpty) {
      _searchHidden = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final scroll = _scroll;
        if (!mounted || scroll == null || !scroll.hasClients) return;
        final extent = searchBarExtent(context);
        final position = scroll.position;
        if (position.pixels == 0 && position.maxScrollExtent >= extent) scroll.jumpTo(extent);
      });
    }
    _rows = rows;
    final actions = _actions(settings);
    final selectedRows = [
      for (final r in rows)
        if (_selected.contains(r.threadId)) r,
    ];
    _search.controller
      ..operatorColor = colors.unreadDot
      ..keywordColor = colors.swipeArchive
      ..quotedColor = colors.success
      ..errorColor = colors.destructive;

    return PopScope(
      canPop: !_searching,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _searching) _setSearching(false);
      },
      child: Scaffold(
        bottomNavigationBar: _searching
            ? null
            : _editing
            ? _editBar(selectedRows, actions, mailboxes)
            : _toolbar(rows, mailboxes),
        body: NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: CustomScrollView(
            controller: _scroll,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              _titleBar(context, title, rows, mailboxes),
              if (_searching)
                SearchSlivers(session: _search, thisMailbox: widget.mailboxRef)
              else ...[
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    await ref.read(repositoryProvider).refresh(ref: widget.mailboxRef);
                    unawaited(HapticFeedback.lightImpact());
                  },
                ),
                ..._rowsSlivers(context, async, rows, settings, actions, mailboxes),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Back, the mailbox name (with its account below when there are
  /// several) and Edit, then the search field; in edit mode Select All, the
  /// selection and Done.
  Widget _titleBar(BuildContext context, String title, List<ThreadSummary> rows, List<Mailbox> mailboxes) {
    final colors = LoupeColors.of(context);
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
    final account = switch (widget.mailboxRef) {
      RealMailboxRef(:final mailboxId) when accounts.length > 1 =>
        accounts.where((a) => a.id == MailIds.accountOf(mailboxId)).firstOrNull,
      _ => null,
    };
    final allSelected = _selected.length == rows.length && rows.isNotEmpty;
    return LoupeTitleBar(
      title: _editing ? (_selected.isEmpty ? 'Select Messages' : '${_selected.length} Selected') : title,
      subtitle: _editing || account == null
          ? null
          : Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: colors.accountColor(account.colorIndex), shape: BoxShape.circle),
                ),
                const SizedBox(width: 5),
                Flexible(child: Text(account.displayName)),
              ],
            ),
      automaticallyImplyLeading: !_editing,
      leading: _editing
          ? BarTextButton(
              label: allSelected ? 'Deselect All' : 'Select All',
              onPressed: () => setState(() {
                if (allSelected) {
                  _selected.clear();
                } else {
                  _selected
                    ..clear()
                    ..addAll(rows.map((r) => r.threadId));
                }
              }),
            )
          : null,
      trailing: [BarTextButton(label: _editing ? 'Done' : 'Edit', bold: _editing, onPressed: _toggleEditing)],
      searching: _searching,
      onCancelSearch: () => _setSearching(false),
      searchField: LoupeSearchField(
        controller: _search.controller,
        focusNode: _focus,
        onChanged: _search.onChanged,
        onSubmitted: (_) => _search.submit(),
        onLongPress: () => showCommandPalette(context),
      ),
    );
  }

  List<Widget> _rowsSlivers(
    BuildContext context,
    AsyncValue<List<ThreadSummary>> async,
    List<ThreadSummary> rows,
    AppSettings settings,
    MailActions actions,
    List<Mailbox> mailboxes,
  ) {
    if (async.isLoading && !async.hasValue) {
      // Taller than the screen, so the initial offset that hides the search
      // field stays in range until the rows arrive.
      return [
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: const Align(alignment: Alignment(0, -0.5), child: CupertinoActivityIndicator()),
          ),
        ),
      ];
    }
    if (async.hasError && !async.hasValue) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: _EmptyState(icon: LoupeIcons.warning, title: 'Couldn’t Load Mail', detail: '${async.error}'),
        ),
      ];
    }
    if (rows.isEmpty) {
      final criteria = ref.watch(filterCriteriaProvider);
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: _filterOn
              ? _EmptyState(
                  icon: LoupeIcons.filter,
                  title: criteria.length == 1 && criteria.single == QuickFilter.unread
                      ? 'No Unread Mail'
                      : 'No Matching Mail',
                  detail: 'Filtered by: ${criteria.map(quickFilterLabel).join(', ')}',
                  action: 'Turn Off Filter',
                  onAction: () => setState(() => _filterOn = false),
                )
              : const _EmptyState(icon: LoupeIcons.inbox, title: 'No Mail'),
        ),
      ];
    }
    final colors = LoupeColors.of(context);
    final accounts = {for (final a in ref.watch(accountsProvider).value ?? const <MailAccount>[]) a.id: a};
    final boxes = {for (final m in mailboxes) m.id: m};
    final vips = ref.watch(vipAddressesProvider).value ?? const <String>{};
    final unified = widget.mailboxRef is VirtualMailboxRef && accounts.length > 1;
    final selection = _inPane ? ref.watch(mailSelectionProvider) : null;
    if (selection != null) {
      final shown = rows.indexWhere(selection.shows);
      if (shown >= 0) _shownIndex = shown;
    }
    return [
      SliverList.builder(
        itemCount: rows.length,
        itemBuilder: (context, i) {
          final row = rows[i];
          final email = row.latest;
          final role = boxes[email.mailboxId]?.role;
          final account = accounts[email.accountId];
          final checked = _selected.contains(row.threadId);
          final longPress = _editing
              ? null
              : () {
                  unawaited(HapticFeedback.mediumImpact());
                  unawaited(actions.showMore(row));
                };
          final messageRow = MessageRow(
            key: _rowKeys.putIfAbsent(row.threadId, GlobalKey.new),
            email: email,
            messageCount: row.messageCount,
            unread: row.unreadCount > 0,
            isVip: email.from.any((f) => vips.contains(f.email.toLowerCase())),
            accountColor: unified && account != null ? colors.accountColor(account.colorIndex) : null,
            selected: selection?.shows(row) ?? _cursor == row.threadId,
            editing: _editing,
            checked: checked,
            showRecipients: role == MailboxRole.sent || role == MailboxRole.drafts,
            onTap: _editing
                ? () => setState(() => checked ? _selected.remove(row.threadId) : _selected.add(row.threadId))
                : () => _openRow(row, role: role, actions: actions),
            // In the panes a long press lifts the row to drop on a mailbox,
            // and opens More when put back.
            onLongPress: _inPane ? null : longPress,
          );
          return SwipeActionRow(
            key: ValueKey(row.threadId),
            enabled: !_editing,
            leading: actions.leadingSwipes(row, settings),
            trailing: actions.trailingSwipes(row, settings),
            child: !_inPane
                ? messageRow
                : DraggableMessageRow(
                    // A selected row carries the whole selection.
                    drag: () => MessageDrag(
                      rows: _editing && checked
                          ? [
                              for (final r in _rows)
                                if (_selected.contains(r.threadId)) r,
                            ]
                          : [row],
                      scope: widget.mailboxRef,
                      threaded: settings.threaded,
                      onMoved: () {
                        if (mounted && _editing) _toggleEditing();
                      },
                    ),
                    onLongPress: longPress,
                    child: messageRow,
                  ),
          );
        },
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 64,
          child: Center(child: _loadingOlder ? const CupertinoActivityIndicator() : const SizedBox.shrink()),
        ),
      ),
    ];
  }

  /// Unread messages of this mailbox: the server's count where there is
  /// one (only the newest messages are on the phone), else the rows'.
  int _unreadCount(List<ThreadSummary> rows, List<Mailbox> mailboxes) {
    final local = rows.fold(0, (sum, r) => sum + r.unreadCount);
    return switch (widget.mailboxRef) {
      RealMailboxRef(:final mailboxId) => mailboxes.where((m) => m.id == mailboxId).firstOrNull?.unreadCount ?? local,
      VirtualMailboxRef(:final kind)
          when kind == VirtualMailbox.allInboxes || kind == VirtualMailbox.unread || kind == VirtualMailbox.vip =>
        ref.watch(virtualCountsProvider).value?[kind] ?? local,
      VirtualMailboxRef() => local,
    };
  }

  Widget _toolbar(List<ThreadSummary> rows, List<Mailbox> mailboxes) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final criteria = ref.watch(filterCriteriaProvider);
    final unread = _unreadCount(rows, mailboxes);
    return LoupeBottomBar(
      leading: BarIconButton(
        icon: _filterOn ? LoupeIcons.filterFilled : LoupeIcons.filter,
        tooltip: _filterOn ? 'Turn Off Filter' : 'Filter',
        onPressed: () {
          unawaited(HapticFeedback.selectionClick());
          if (!_filterOn && criteria.isEmpty) {
            unawaited(_openCriteria());
            return;
          }
          setState(() => _filterOn = !_filterOn);
        },
      ),
      center: _filterOn
          ? Semantics(
              button: true,
              label: 'Filter criteria: ${criteria.map(quickFilterLabel).join(', ')}',
              excludeSemantics: true,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _openCriteria,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Filtered by:', style: styles.caption.copyWith(color: colors.label)),
                    Text(
                      criteria.map(quickFilterLabel).join(', '),
                      style: styles.caption.copyWith(color: colors.unreadDot, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          : SyncStatusLine(detail: unread > 0 ? '${formatCount(unread)} Unread' : null),
      trailing: BarIconButton(
        icon: LoupeIcons.compose,
        tooltip: 'New Message',
        onPressed: () => openCompose(context, ComposeArgs(accountId: _accountOfRef())),
      ),
    );
  }

  String? _accountOfRef() => switch (widget.mailboxRef) {
    RealMailboxRef(:final mailboxId) => MailIds.accountOf(mailboxId),
    VirtualMailboxRef() => null,
  };

  Widget _editBar(List<ThreadSummary> selected, MailActions actions, List<Mailbox> mailboxes) {
    final settings = ref.read(appSettingsProvider);
    final role = switch (widget.mailboxRef) {
      RealMailboxRef(:final mailboxId) => mailboxes.where((m) => m.id == mailboxId).firstOrNull?.role,
      VirtualMailboxRef() => null,
    };
    final useTrash =
        settings.swipeTrailing == SwipeAction.trash ||
        role == MailboxRole.archive ||
        role == MailboxRole.all ||
        role == MailboxRole.trash;
    final enabled = selected.isNotEmpty;
    Future<void> run(Future<void> Function() action) async {
      await action();
      if (mounted) _toggleEditing();
    }

    return LoupeBottomBar(
      leading: BarTextButton(label: 'Mark', onPressed: enabled ? () => _markSelected(selected, actions) : null),
      center: BarTextButton(
        label: 'Move',
        onPressed: enabled ? () => run(() => actions.moveWithPicker(selected)) : null,
      ),
      trailing: BarTextButton(
        label: useTrash ? (role == MailboxRole.trash ? 'Delete' : 'Trash') : 'Archive',
        onPressed: enabled ? () => run(() => useTrash ? actions.trash(selected) : actions.archive(selected)) : null,
      ),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({required this.initial});

  final Set<QuickFilter> initial;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late final Set<QuickFilter> _selected = {...widget.initial};

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    const order = [
      QuickFilter.unread,
      QuickFilter.flagged,
      QuickFilter.toMe,
      QuickFilter.ccMe,
      QuickFilter.hasAttachment,
      QuickFilter.unreplied,
      QuickFilter.fromVip,
    ];
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 8, 4),
              child: Row(
                children: [
                  Expanded(child: Text('Filter', style: styles.navTitle)),
                  CupertinoButton(
                    onPressed: () => Navigator.of(context).pop(_selected),
                    child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 4, 16, 6),
              child: Text('INCLUDE', style: styles.footnote),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: colors.cellBackground,
                  child: Column(
                    children: [
                      for (final f in order)
                        ListTile(
                          dense: true,
                          leading: Icon(quickFilterIcon(f), color: colors.unreadDot),
                          title: Text(quickFilterLabel(f), style: styles.body),
                          trailing: _selected.contains(f) ? Icon(LoupeIcons.check, color: colors.unreadDot) : null,
                          onTap: () {
                            unawaited(HapticFeedback.selectionClick());
                            setState(() => _selected.contains(f) ? _selected.remove(f) : _selected.add(f));
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.icon, required this.title, this.detail, this.action, this.onAction});

  final IconData icon;
  final String title;
  final String? detail;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 52, color: colors.tertiaryText),
          const SizedBox(height: 14),
          Text(
            title,
            style: styles.sectionHeader.copyWith(color: colors.secondaryText),
            textAlign: TextAlign.center,
          ),
          if (detail != null) ...[
            const SizedBox(height: 6),
            Text(detail!, style: styles.footnote, textAlign: TextAlign.center),
          ],
          if (action != null) ...[
            const SizedBox(height: 10),
            CupertinoButton(onPressed: onAction, child: Text(action!)),
          ],
        ],
      ),
    );
  }
}
