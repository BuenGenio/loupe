import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers.dart';
import '../../router.dart';
import '../../shared/bars.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/conversation_screen.dart';
import '../keyboard/mail_commands.dart';
import '../mailboxes/mailboxes_screen.dart';
import '../mailing_lists/mailing_list_screen.dart';
import '../message_list/message_list_screen.dart';
import '../outbox/outbox_screen.dart';
import '../search/smart_mailbox_screen.dart';
import '../snooze/snoozed_screen.dart';
import 'mail_selection.dart';
import 'message_drag.dart';
import 'pane_divider.dart';
import 'pane_layout.dart';

/// The first route (`/`): Mailboxes on a phone; on wider screens the mail
/// panes, Mailboxes | list | conversation from 1100 dp, list | conversation
/// with Mailboxes in a sidebar from 840 dp.
///
/// On a phone the route stack says what is shown (Mailboxes, a list, a
/// conversation); in the panes [mailSelectionProvider] does, and the stack
/// stays at this route. Crossing the breakpoint turns one into the other:
///
/// * widening (unfolding, rotating a tablet) takes the list and conversation
///   pages above this route into the panes and pops them;
/// * narrowing pushes them again, so Back works as on a phone.
///
/// While wide, a list or conversation route pushed right above this one (a
/// mailbox tapped in the Mailboxes pane, a search result, a notification)
/// opens in its pane instead: the push and the pop happen before the next
/// frame, so the page never shows. Other routes (Settings, Compose, search)
/// cover the panes as on a phone.
class MailHome extends ConsumerStatefulWidget {
  const MailHome({super.key});

  @override
  ConsumerState<MailHome> createState() => _MailHomeState();
}

class _MailHomeState extends ConsumerState<MailHome> with CommandScopeState<MailHome> {
  // The screens keep their state when the layout changes.
  final _mailboxesKey = GlobalKey(debugLabel: 'Mailboxes pane');
  final _listKey = GlobalKey(debugLabel: 'List pane');
  final _conversationKey = GlobalKey(debugLabel: 'Conversation pane');

  GoRouter? _router;
  PaneLayout? _layout;

  /// What the panes showed when the screen got narrow, to push as phone
  /// pages once this route is on top.
  MailSelection? _toStack;
  bool _syncScheduled = false;

  /// The Mailboxes sidebar of the split layout.
  bool _sidebarOpen = false;

  /// Mailboxes shown only while messages are dragged (a closed sidebar, a
  /// hidden column), to drop them on.
  bool _shownForDrag = false;

  @override
  void initState() {
    super.initState();
    // A new list closes the sidebar it was picked from.
    ref.listenManual(mailSelectionProvider.select((s) => s.list), (previous, next) {
      if (previous != next && _sidebarOpen && mounted) setState(() => _sidebarOpen = false);
    });
    // Dragging messages brings Mailboxes out to drop them on.
    ref.listenManual(messageDraggingProvider, (_, dragging) {
      if (!mounted || !(_layout?.wide ?? false)) return;
      final hidden = _layout == PaneLayout.split ? !_sidebarOpen : ref.read(paneWidthsProvider).mailboxesHidden;
      if (dragging && hidden) {
        setState(() {
          _shownForDrag = true;
          if (_layout == PaneLayout.split) _sidebarOpen = true;
        });
      } else if (!dragging && _shownForDrag) {
        setState(() {
          _shownForDrag = false;
          if (_layout == PaneLayout.split) _sidebarOpen = false;
        });
      }
    });
    registerCommands(ref.read(mailCommandsProvider));
  }

  // Keyboard: Esc closes the sidebar, then the conversation.

  @override
  int get priority => 0;

  @override
  bool canRun(MailCommand command) =>
      command == MailCommand.back &&
      (_layout?.wide ?? false) &&
      (_sidebarOpen || ref.read(mailSelectionProvider).messageId != null);

  @override
  void run(MailCommand command) {
    if (_sidebarOpen) {
      setState(() => _sidebarOpen = false);
    } else {
      ref.read(mailSelectionProvider.notifier).closeMessage();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final router = GoRouter.maybeOf(context);
    if (router != _router) {
      _router?.routerDelegate.removeListener(_routeChanged);
      _router = router?..routerDelegate.addListener(_routeChanged);
    }
  }

  @override
  void dispose() {
    _router?.routerDelegate.removeListener(_routeChanged);
    super.dispose();
  }

  // Routes and panes ------------------------------------------------------------------

  void _routeChanged() {
    if (_syncScheduled) return;
    _syncScheduled = true;
    // After the navigation that called this, before the next frame.
    scheduleMicrotask(() {
      _syncScheduled = false;
      if (mounted) _syncWithStack();
    });
  }

  /// Follows the route stack when it is this route plus mail pages: on a
  /// phone the selection mirrors them; wide, they move into the panes.
  void _syncWithStack() {
    final router = _router;
    if (router == null) return;
    final above = mailPagesAboveHome(router.routerDelegate.currentConfiguration);
    if (above == null) return;
    final selection = ref.read(mailSelectionProvider.notifier);
    final wide = _layout?.wide ?? false;
    if (above.isEmpty) {
      // Back at Mailboxes on a phone: no conversation is open any more.
      if (!wide) selection.closeMessage();
      return;
    }
    final next = selectionFor(above, ref.read(mailSelectionProvider));
    selection.set(next);
    if (next.messageId case final id? when next.threadId == null) unawaited(_findThread(id));
    if (wide) router.go(Routes.mailboxes);
  }

  Future<void> _findThread(String messageId) async {
    try {
      final email = await ref.read(repositoryProvider).getEmail(messageId);
      final thread = email?.threadId;
      if (thread != null && mounted) ref.read(mailSelectionProvider.notifier).setThread(messageId, thread);
    } on Object {
      // Only the list's highlight needs it.
    }
  }

  void _layoutChanged(PaneLayout layout, {required bool onTop}) {
    final previous = _layout;
    _layout = layout;
    if (previous == null) {
      if (layout.wide) _routeChanged();
    } else if (previous.wide && !layout.wide) {
      // Folded: the phone pages show what the panes showed.
      final s = ref.read(mailSelectionProvider);
      _toStack = s.list != null || s.messageId != null ? s : null;
      _sidebarOpen = false;
    } else if (!previous.wide && layout.wide) {
      _toStack = null;
      _routeChanged();
    }
    if (_toStack != null && !layout.wide && onTop) {
      final s = _toStack!;
      _toStack = null;
      WidgetsBinding.instance.addPostFrameCallback((_) => _pushPages(s));
    }
  }

  void _pushPages(MailSelection s) {
    final router = _router;
    if (router == null || !mounted || (_layout?.wide ?? false)) return;
    unawaited(router.push<void>(s.listOrDefault.location));
    if (s.messageId case final id?) unawaited(router.push<void>(Routes.message(id)));
  }

  /// After the conversation was archived, deleted or moved away: the next
  /// one in the list takes its place, as in Apple Mail and Thunderbird.
  void _conversationClosed() {
    final selection = ref.read(mailSelectionProvider);
    final list = ref.read(mailCommandsProvider).latest<MessageListNeighbors>();
    final next = list is CommandScope && (list as CommandScope).acceptsCommands
        ? list?.replacementFor(selection)
        : null;
    final notifier = ref.read(mailSelectionProvider.notifier);
    next == null ? notifier.closeMessage() : notifier.showMessage(next.latest.id, threadId: next.threadId);
  }

  void _toggleSidebar() {
    if (_layout == PaneLayout.threePane) {
      final widths = ref.read(paneWidthsProvider);
      unawaited(ref.read(paneWidthsProvider.notifier).setMailboxesHidden(!widths.mailboxesHidden));
    } else {
      setState(() => _sidebarOpen = !_sidebarOpen);
    }
  }

  // Build -------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final layout = PaneLayout.of(context);
    _layoutChanged(layout, onTop: ModalRoute.isCurrentOf(context) ?? true);
    final mailboxes = KeyedSubtree(key: _mailboxesKey, child: const MailboxesScreen());
    if (!layout.wide) return mailboxes;

    final selection = ref.watch(mailSelectionProvider);
    final widths = ref.watch(paneWidthsProvider);
    final colors = LoupeColors.of(context);
    final messageId = selection.messageId;
    final list = KeyedSubtree(key: _listKey, child: _listScreen(selection.listOrDefault));
    final conversation = KeyedSubtree(
      key: _conversationKey,
      child: messageId == null
          ? const NoMessageSelected()
          : HeroMode(
              enabled: false,
              child: ConversationScreen(key: ValueKey(messageId), emailId: messageId, onClose: _conversationClosed),
            ),
    );
    final mailboxesShown = layout == PaneLayout.threePane ? !widths.mailboxesHidden || _shownForDrag : _sidebarOpen;
    final sidebarButton = BarIconButton(
      key: const Key('sidebar-toggle'),
      icon: LoupeIcons.sidebar,
      tooltip: mailboxesShown ? 'Hide Mailboxes' : 'Show Mailboxes',
      onPressed: _toggleSidebar,
    );
    final hairline = SizedBox(width: 0.5, child: ColoredBox(color: colors.separator));
    final notifier = ref.read(paneWidthsProvider.notifier);

    return PopScope(
      // Back closes the sidebar, then the conversation, as Esc does.
      canPop: !_sidebarOpen && messageId == null,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) run(MailCommand.back);
      },
      child: Scaffold(
        // Each pane is a Scaffold of its own; this one holds the snack bars
        // (once, across the whole width) and fits the keyboard per pane.
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final total = constraints.maxWidth;
            if (layout == PaneLayout.threePane) {
              final mw = mailboxesShown ? widths.mailboxesIn(total) : 0.0;
              final lw = widths.listIn(total, used: mw + (mailboxesShown ? 0.5 : 0));
              final listEdge = mw + (mailboxesShown ? 0.5 : 0) + lw;
              return Stack(
                children: [
                  Row(
                    children: [
                      if (mailboxesShown) ...[
                        SizedBox(width: mw, child: _pane(mailboxes, MailPane.mailboxes, layout, first: true)),
                        hairline,
                      ],
                      SizedBox(
                        width: lw,
                        child: _pane(list, MailPane.list, layout, first: !mailboxesShown, leading: sidebarButton),
                      ),
                      hairline,
                      Expanded(child: _pane(conversation, MailPane.conversation, layout, last: true)),
                    ],
                  ),
                  // Hidden, Mailboxes stays alive (it watches the outbox and
                  // snoozed mail for the whole app).
                  if (!mailboxesShown) Offstage(child: TickerMode(enabled: false, child: mailboxes)),
                  if (mailboxesShown)
                    _handle(
                      at: mw,
                      label: 'Mailboxes width',
                      onDrag: (dx) => notifier.resize(mailboxes: mw + dx),
                      onReset: () => notifier.resize(mailboxes: PaneWidths.defaultMailboxes),
                    ),
                  _handle(
                    at: listEdge,
                    label: 'Message list width',
                    onDrag: (dx) => notifier.resize(list: lw + dx),
                    onReset: () => notifier.resize(list: PaneWidths.defaultList),
                  ),
                ],
              );
            }
            final lw = widths.listIn(total);
            final sidebarWidth = math.min(320.0, total * 0.4);
            return Stack(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: lw,
                      child: _pane(list, MailPane.list, layout, first: true, leading: sidebarButton),
                    ),
                    hairline,
                    Expanded(child: _pane(conversation, MailPane.conversation, layout, last: true)),
                  ],
                ),
                _handle(
                  at: lw,
                  label: 'Message list width',
                  onDrag: (dx) => notifier.resize(list: lw + dx),
                  onReset: () => notifier.resize(list: PaneWidths.defaultList),
                ),
                // The sidebar: over the list, with a scrim that closes it.
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: !_sidebarOpen,
                    child: GestureDetector(
                      onTap: () => setState(() => _sidebarOpen = false),
                      child: AnimatedOpacity(
                        opacity: _sidebarOpen ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: const ColoredBox(color: Color(0x33000000)),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  top: 0,
                  bottom: 0,
                  left: _sidebarOpen ? 0 : -sidebarWidth - 8,
                  width: sidebarWidth,
                  child: ExcludeFocus(
                    excluding: !_sidebarOpen,
                    child: ExcludeSemantics(
                      excluding: !_sidebarOpen,
                      child: TickerMode(
                        enabled: _sidebarOpen,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border(right: BorderSide(color: colors.separator, width: 0.5)),
                            boxShadow: _sidebarOpen
                                ? const [BoxShadow(color: Color(0x22000000), blurRadius: 16)]
                                : const [],
                          ),
                          child: _pane(mailboxes, MailPane.mailboxes, layout, first: true),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _handle({
    required double at,
    required String label,
    required ValueChanged<double> onDrag,
    required VoidCallback onReset,
  }) {
    final notifier = ref.read(paneWidthsProvider.notifier);
    return Positioned(
      left: at + 0.25 - PaneDivider.handleWidth / 2,
      top: 0,
      bottom: 0,
      child: PaneDivider(
        label: label,
        onDrag: onDrag,
        onDragEnd: () => unawaited(notifier.save()),
        onReset: () {
          onReset();
          unawaited(notifier.save());
        },
      ),
    );
  }

  /// [child] as [pane]: safe-area insets only at the outer edges.
  Widget _pane(
    Widget child,
    MailPane pane,
    PaneLayout layout, {
    bool first = false,
    bool last = false,
    Widget? leading,
  }) => MailPaneScope(
    pane: pane,
    layout: layout,
    titleLeading: leading,
    child: MediaQuery.removePadding(context: context, removeLeft: !first, removeRight: !last, child: child),
  );

  static Widget _listScreen(ListTarget target) => switch (target) {
    MailboxTarget(:final ref) => MessageListScreen(key: ValueKey(target), mailboxRef: ref),
    SmartMailboxTarget(:final id) => SmartMailboxScreen(key: ValueKey(target), id: id),
    MailingListTarget(:final listId) => MailingListScreen(key: ValueKey(target), listId: listId),
    SnoozedTarget() => const SnoozedScreen(key: ValueKey(SnoozedTarget())),
    OutboxTarget() => const OutboxScreen(key: ValueKey(OutboxTarget())),
  };
}

/// A page above the first route: a list or a conversation.
sealed class MailPage {
  const MailPage();
}

final class ListPage extends MailPage {
  const ListPage(this.target);

  final ListTarget target;
}

final class MessagePage extends MailPage {
  const MessagePage(this.emailId);

  final String emailId;
}

/// The mail pages above Mailboxes in [config], bottom up. Null when the stack doesn't start at Mailboxes or holds
/// anything else (Settings, search, a sheet's route…).
List<MailPage>? mailPagesAboveHome(RouteMatchList config) {
  if (config.isError || config.matches.isEmpty) return null;
  final first = config.matches.first;
  if (first is! RouteMatch || first is ImperativeRouteMatch || first.route.path != Routes.mailboxes) return null;
  // Imperative matches (pushes) carry their own parameters; the others share the list's.
  final pages = <MailPage>[];
  for (final m in config.matches.skip(1)) {
    if (m is! RouteMatch) return null;
    final params = m is ImperativeRouteMatch ? m.matches.pathParameters : config.pathParameters;
    final path = m.route.path;
    if (path == '/message/:id') {
      final id = params['id'];
      if (id == null) return null;
      pages.add(MessagePage(id));
      continue;
    }
    final target = ListTarget.fromRoute(path, params);
    if (target == null) return null;
    pages.add(ListPage(target));
  }
  return pages;
}

/// The selection that shows [pages] (from [mailPagesAboveHome]), starting
/// from [current].
MailSelection selectionFor(List<MailPage> pages, MailSelection current) {
  var list = current.list;
  var message = current.messageId;
  var thread = current.threadId;
  for (final p in pages) {
    switch (p) {
      case ListPage(:final target):
        list = target;
        message = null;
        thread = null;
      case MessagePage(:final emailId) when emailId != message:
        message = emailId;
        thread = null;
      case MessagePage():
    }
  }
  return MailSelection(list: list, messageId: message, threadId: thread);
}

/// The conversation pane with nothing in it.
class NoMessageSelected extends StatelessWidget {
  const NoMessageSelected({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LoupeIcons.email, size: 56, color: colors.tertiaryText),
            const SizedBox(height: 12),
            Text('No Message Selected', style: LoupeTextStyles.of(context).body.copyWith(color: colors.secondaryText)),
          ],
        ),
      ),
    );
  }
}
