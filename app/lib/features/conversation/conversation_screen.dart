import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers.dart';
import '../../router.dart';
import '../../settings/app_settings.dart';
import '../../theme/theme.dart';
import '../compose/compose_args.dart';
import 'mail_streams.dart';
import 'mailbox_picker.dart';
import 'message_actions.dart';
import 'message_card.dart';
import 'reader_options_sheet.dart';
import 'reader_prefs.dart';
import 'sheets.dart';

/// A conversation: its messages stacked oldest to newest, the "Aa" view
/// options and an Apple-Mail-style toolbar.
///
/// Works as its own route (`/message/:id`) and embedded in a split view.
class ConversationScreen extends ConsumerStatefulWidget {
  const ConversationScreen({super.key, required this.emailId, this.onClose});

  /// Any message of the conversation; the screen scrolls to it.
  final String emailId;

  /// Called after the conversation was archived, deleted or moved away. By
  /// default the screen pops itself when it is the `/message/:id` route and
  /// does nothing when embedded.
  final VoidCallback? onClose;

  @override
  ConsumerState<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  StreamSubscription<List<EmailSummary>>? _sub;
  List<EmailSummary>? _messages;
  Object? _error;
  bool _markedSeen = false;

  final _known = <String>{};
  final _expanded = <String>{};
  final _content = <String, Future<EmailContent>>{};
  final _keys = <String, GlobalKey>{};

  /// Messages whose remote content the user allowed once.
  final _remoteAllowed = <String>{};

  /// Messages for which Readable mode suggested the Original view.
  final _originalHint = <String>{};

  /// Messages switched to Original from the hint.
  final _forceOriginal = <String>{};

  /// "Aa" choices made on this screen; they apply to every message.
  ReaderSettings? _session;

  MailRepository get _repo => ref.read(repositoryProvider);

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(ConversationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.emailId != widget.emailId) {
      _messages = null;
      _error = null;
      _markedSeen = false;
      _session = null;
      for (final s in [_known, _expanded, _remoteAllowed, _originalHint, _forceOriginal]) {
        s.clear();
      }
      _content.clear();
      _keys.clear();
      _subscribe();
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void _subscribe() {
    _sub?.cancel();
    _sub = _repo
        .watchConversation(widget.emailId)
        .listen(
          _onMessages,
          onError: (Object e) {
            if (mounted) setState(() => _error = e);
          },
        );
  }

  void _onMessages(List<EmailSummary> messages) {
    if (!mounted) return;
    final first = _messages == null;
    final targetIndex = messages.indexWhere((m) => m.id == widget.emailId);
    setState(() {
      _error = null;
      _messages = messages;
      for (final (i, m) in messages.indexed) {
        if (!_known.add(m.id)) continue;
        final isTarget = targetIndex < 0 ? i == messages.length - 1 : i == targetIndex;
        final newer = first && targetIndex >= 0 && i > targetIndex;
        if (isTarget || newer || !m.isSeen) _expanded.add(m.id);
      }
    });
    if (!_markedSeen && messages.isNotEmpty) {
      _markedSeen = true;
      unawaited(_markSeen(messages));
      if (first) _scrollToTarget(messages, targetIndex);
    }
  }

  /// Marks the target and the other unread messages shown expanded as seen.
  Future<void> _markSeen(List<EmailSummary> messages) async {
    final ids = [
      for (final m in messages)
        if (!m.isSeen && _expanded.contains(m.id)) m.id,
    ];
    if (ids.isEmpty) return;
    try {
      await _repo.setKeywords(ids, add: {Keywords.seen});
    } on MailException {
      // Not worth interrupting reading; the list still shows it unread.
    }
  }

  void _scrollToTarget(List<EmailSummary> messages, int targetIndex) {
    if (targetIndex <= 0) return;
    final expandedBefore = messages.take(targetIndex).any((m) => _expanded.contains(m.id));
    if (!expandedBefore) return;
    final id = messages[targetIndex].id;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _keys[id]?.currentContext;
      if (ctx != null && ctx.mounted) Scrollable.ensureVisible(ctx);
    });
  }

  EmailSummary? get _target {
    final m = _messages;
    if (m == null || m.isEmpty) return null;
    return m.where((e) => e.id == widget.emailId).firstOrNull ?? m.last;
  }

  Future<EmailContent> _contentFor(EmailSummary m) => _content.putIfAbsent(m.id, () => _repo.loadContent(m.id));

  ReaderSettings _settingsFor(EmailSummary m, AppSettings app, ReaderPrefs prefs) {
    var s =
        _session ??
        prefs.settingsFor(m.sender?.email) ??
        ReaderSettings(mode: app.defaultReaderMode, plainFont: app.plainFont);
    if (_forceOriginal.contains(m.id)) s = s.copyWith(mode: ReaderMode.original);
    return s;
  }

  RemoteContentPolicy _remoteFor(EmailSummary m, AppSettings app, ReaderPrefs prefs) =>
      app.loadRemoteImages || prefs.allowsRemote(m.sender?.email) || _remoteAllowed.contains(m.id)
      ? RemoteContentPolicy.allow
      : RemoteContentPolicy.block;

  // Actions -------------------------------------------------------------------

  /// Runs [action], shows [done] or the error, and closes the screen if asked.
  Future<void> _act(Future<void> Function() action, {String? done, bool close = false}) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action();
      if (close) _close();
      if (done != null) showSnack(messenger, done);
    } on MailException catch (e) {
      showSnack(messenger, e.message);
    }
  }

  void _close() {
    if (!mounted) return;
    if (widget.onClose case final onClose?) return onClose();
    bool ownRoute;
    try {
      ownRoute = GoRouterState.of(context).matchedLocation.startsWith('/message/');
    } on GoError {
      ownRoute = Scaffold.maybeOf(context) == null;
    }
    if (ownRoute) Navigator.of(context).maybePop();
  }

  void _setFlag(EmailSummary m, bool on) => _act(
    () =>
        _repo.setKeywords([m.id], add: on ? {Keywords.flagged} : const {}, remove: on ? const {} : {Keywords.flagged}),
  );

  void _setSeen(EmailSummary m, bool seen) => _act(
    () => _repo.setKeywords([m.id], add: seen ? {Keywords.seen} : const {}, remove: seen ? const {} : {Keywords.seen}),
  );

  void _archive(List<String> ids, {required bool close}) =>
      _act(() => _repo.archive(ids), done: 'Archived', close: close);

  void _trash(List<String> ids, {required bool inTrash, required bool close}) =>
      _act(() => _repo.trash(ids), done: inTrash ? 'Deleted' : 'Moved to Trash', close: close);

  void _junk(List<String> ids, {required bool junk, required bool close}) => _act(
    () => _repo.markJunk(ids, junk: junk),
    done: junk ? 'Moved to Junk' : 'Moved to Inbox',
    close: close,
  );

  Future<void> _move(EmailSummary from, List<String> ids, {required bool close}) async {
    final target = await showMailboxPicker(
      context,
      repository: _repo,
      accountId: from.accountId,
      currentMailboxId: from.mailboxId,
    );
    if (target == null || !mounted) return;
    await _act(() => _repo.move(ids, target.id), done: 'Moved to ${target.name}', close: close);
  }

  void _reply(EmailSummary m, ComposeMode mode) =>
      openCompose(context, ComposeArgs(mode: mode, sourceEmailId: m.id, accountId: m.accountId));

  Future<void> _replyMenu(EmailSummary m) async {
    final mode = await showActionSheet<ComposeMode>(
      context,
      actions: const [
        SheetAction('Reply', ComposeMode.reply),
        SheetAction('Reply All', ComposeMode.replyAll),
        SheetAction('Forward', ComposeMode.forward),
      ],
    );
    if (mode != null && mounted) _reply(m, mode);
  }

  Future<void> _openLink(Uri uri) async {
    final messenger = ScaffoldMessenger.of(context);
    if (uri.scheme == 'mailto') {
      await openCompose(context, ComposeArgs.fromMailto(uri, accountId: _target?.accountId));
      return;
    }
    final web = uri.scheme == 'http' || uri.scheme == 'https';
    try {
      final ok = await launchUrl(uri, mode: web ? LaunchMode.inAppBrowserView : LaunchMode.externalApplication);
      if (!ok) showSnack(messenger, "Couldn't open the link.");
    } on Exception {
      showSnack(messenger, "Couldn't open the link.");
    }
  }

  Future<void> _onAddressTap(EmailAddress address, String accountId) => showAddressSheet(
    context,
    address: address,
    repository: _repo,
    onCompose: () => openCompose(context, ComposeArgs(to: [address], accountId: accountId)),
    onSearch: () => context.push(Routes.search('f:"${address.email}"')),
  );

  Future<void> _showReaderOptions() async {
    final t = _target;
    if (t == null) return;
    final prefs = ref.read(readerPrefsProvider);
    final controller = ref.read(readerPrefsProvider.notifier);
    final sender = t.sender?.email;
    var current = _settingsFor(t, ref.read(appSettingsProvider), prefs);
    var remember = prefs.settingsFor(sender) != null;
    await showReaderOptionsSheet(
      context,
      initial: current,
      remembered: remember,
      senderName: t.sender?.displayName,
      onChanged: (s) {
        current = s;
        setState(() {
          _session = s;
          _forceOriginal.clear();
        });
        if (remember && sender != null) unawaited(controller.setSenderSettings(sender, s));
      },
      onRememberChanged: (v) {
        remember = v;
        if (sender != null) unawaited(controller.setSenderSettings(sender, v ? current : null));
      },
    );
  }

  Future<void> _showMenu(EmailSummary m, {required bool canArchive, required MailboxRole role}) async {
    final action = await showMessageMenu(context, message: m, canArchive: canArchive, mailboxRole: role);
    if (action == null || !mounted) return;
    final single = (_messages?.length ?? 0) <= 1;
    switch (action) {
      case MessageAction.reply:
        _reply(m, ComposeMode.reply);
      case MessageAction.replyAll:
        _reply(m, ComposeMode.replyAll);
      case MessageAction.forward:
        _reply(m, ComposeMode.forward);
      case MessageAction.toggleSeen:
        _setSeen(m, !m.isSeen);
      case MessageAction.toggleFlag:
        _setFlag(m, !m.isFlagged);
      case MessageAction.tags:
        await showTagsSheet(
          context,
          message: m,
          onToggle: (k, on) =>
              _act(() => _repo.setKeywords([m.id], add: on ? {k} : const {}, remove: on ? const {} : {k})),
        );
      case MessageAction.move:
        await _move(m, [m.id], close: single);
      case MessageAction.archive:
        _archive([m.id], close: single);
      case MessageAction.trash:
        _trash([m.id], inTrash: role == MailboxRole.trash, close: single);
      case MessageAction.junk || MessageAction.notJunk:
        _junk([m.id], junk: action == MessageAction.junk, close: single);
      case MessageAction.headers:
        final messenger = ScaffoldMessenger.of(context);
        try {
          final content = await _contentFor(m);
          if (mounted) await showHeadersSheet(context, content.headers);
        } on MailException catch (e) {
          showSnack(messenger, e.message);
        }
      case MessageAction.source:
        await context.push(Routes.source(m.id));
      case MessageAction.search:
        final query = await showSearchFromSheet(context, m);
        if (query != null && mounted) await context.push(Routes.search(query));
    }
  }

  // Build ---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final app = ref.watch(appSettingsProvider);
    final prefs = ref.watch(readerPrefsProvider);
    final accounts = ref.watch(accountsStreamProvider).value ?? const <MailAccount>[];
    final own = ownAddresses(accounts);
    final target = _target;
    final mailboxes = target == null
        ? const <Mailbox>[]
        : ref.watch(accountMailboxesProvider(target.accountId)).value ?? const <Mailbox>[];
    MailboxRole roleOf(EmailSummary m) =>
        mailboxes.where((b) => b.id == m.mailboxId).firstOrNull?.role ?? MailboxRole.none;
    final gmail = target != null && accounts.any((a) => a.id == target.accountId && a.provider == ProviderKind.gmail);
    final hasArchive = gmail || mailboxes.any((b) => b.role == MailboxRole.archive);
    bool canArchive(EmailSummary m) => hasArchive && roleOf(m) != MailboxRole.archive;

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (target != null)
            TextButton(
              key: const Key('reader-options'),
              onPressed: _showReaderOptions,
              child: const Text('Aa', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: _buildBody(context, app, prefs, own, canArchive, roleOf),
      bottomNavigationBar: target == null
          ? null
          : _Toolbar(
              flagged: target.isFlagged,
              archive: canArchive(target),
              inTrash: roleOf(target) == MailboxRole.trash,
              onFlag: () => _setFlag(target, !target.isFlagged),
              onMove: () => _move(target, _threadIds(target), close: true),
              onArchiveOrTrash: () => canArchive(target)
                  ? _archive(_threadIds(target), close: true)
                  : _trash(_threadIds(target), inTrash: roleOf(target) == MailboxRole.trash, close: true),
              onReply: () => _reply(target, ComposeMode.reply),
              onReplyMenu: () => _replyMenu(target),
              onCompose: () => openCompose(context, ComposeArgs(accountId: target.accountId)),
            ),
    );
  }

  /// The conversation's messages in the target's mailbox: what the toolbar
  /// archives, deletes or moves (copies in Sent stay where they are).
  List<String> _threadIds(EmailSummary target) => [
    for (final m in _messages ?? const <EmailSummary>[])
      if (m.mailboxId == target.mailboxId) m.id,
  ];

  Widget _buildBody(
    BuildContext context,
    AppSettings app,
    ReaderPrefs prefs,
    Set<String> own,
    bool Function(EmailSummary) canArchive,
    MailboxRole Function(EmailSummary) roleOf,
  ) {
    final messages = _messages;
    final error = _error;
    if (messages == null) {
      if (error != null) {
        return _StateMessage.error(
          error,
          onRetry: () {
            setState(() => _error = null);
            _subscribe();
          },
        );
      }
      return const _LoadingConversation();
    }
    if (messages.isEmpty) {
      return const _StateMessage(
        icon: Icons.mail_outline,
        title: 'No Message',
        message: 'This message was moved or deleted.',
      );
    }
    final target = _target!;
    final colors = LoupeColors.of(context);
    return CustomScrollView(
      slivers: [
        if (error != null) SliverToBoxAdapter(child: _OfflineBanner(error: error)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Text(
              target.subject.trim().isEmpty ? '(no subject)' : target.subject,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: 22),
            ),
          ),
        ),
        SliverToBoxAdapter(child: Divider(color: colors.separator)),
        SliverList.list(
          children: [
            for (final m in messages) ...[
              MessageCard(
                key: _keys.putIfAbsent(m.id, GlobalKey.new),
                message: m,
                expanded: _expanded.contains(m.id),
                ownAddresses: own,
                content: _expanded.contains(m.id) ? _contentFor(m) : null,
                settings: _settingsFor(m, app, prefs),
                remoteContent: _remoteFor(m, app, prefs),
                showOriginalHint: _originalHint.contains(m.id),
                onToggle: messages.length < 2 ? null : () => setState(() => _toggle(m.id)),
                onMore: () => _showMenu(m, canArchive: canArchive(m), role: roleOf(m)),
                onAddressTap: (a) => _onAddressTap(a, m.accountId),
                onAllowRemoteContent: ({required bool always}) {
                  setState(() => _remoteAllowed.add(m.id));
                  final sender = m.sender?.email;
                  if (always && sender != null) {
                    unawaited(ref.read(readerPrefsProvider.notifier).setRemoteAllowed(sender, allowed: true));
                  }
                },
                onOpenLink: _openLink,
                onSuggestOriginal: () {
                  if (_originalHint.contains(m.id)) return;
                  // May be called while the body builds.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) setState(() => _originalHint.add(m.id));
                  });
                },
                onUseOriginal: () => setState(() => _forceOriginal.add(m.id)),
                onRetry: () => setState(() => _content.remove(m.id)),
                loadAttachment: (a) => _repo.loadAttachment(m.id, a.partId),
              ),
              Divider(color: colors.separator),
            ],
          ],
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }

  void _toggle(String id) => _expanded.contains(id) ? _expanded.remove(id) : _expanded.add(id);
}

/// The bottom toolbar: Flag, Move, Archive or Trash, Reply, Compose.
class _Toolbar extends StatelessWidget {
  const _Toolbar({
    required this.flagged,
    required this.archive,
    required this.inTrash,
    required this.onFlag,
    required this.onMove,
    required this.onArchiveOrTrash,
    required this.onReply,
    required this.onReplyMenu,
    required this.onCompose,
  });

  final bool flagged;
  final bool archive;
  final bool inTrash;
  final VoidCallback onFlag;
  final VoidCallback onMove;
  final VoidCallback onArchiveOrTrash;
  final VoidCallback onReply;
  final VoidCallback onReplyMenu;
  final VoidCallback onCompose;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: colors.separator, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ToolbarButton(
                key: const Key('toolbar-flag'),
                icon: flagged ? Icons.flag : Icons.outlined_flag,
                color: flagged ? colors.flag : null,
                label: flagged ? 'Unflag' : 'Flag',
                onTap: onFlag,
              ),
              _ToolbarButton(
                key: const Key('toolbar-move'),
                icon: Icons.drive_file_move_outline,
                label: 'Move',
                onTap: onMove,
              ),
              archive
                  ? _ToolbarButton(
                      key: const Key('toolbar-archive'),
                      icon: Icons.archive_outlined,
                      label: 'Archive',
                      onTap: onArchiveOrTrash,
                    )
                  : _ToolbarButton(
                      key: const Key('toolbar-trash'),
                      icon: inTrash ? Icons.delete_forever_outlined : Icons.delete_outline,
                      label: inTrash ? 'Delete' : 'Trash',
                      onTap: onArchiveOrTrash,
                    ),
              _ToolbarButton(
                key: const Key('toolbar-reply'),
                icon: Icons.reply,
                label: 'Reply',
                hint: 'Long-press for Reply All and Forward',
                onTap: onReply,
                onLongPress: onReplyMenu,
              ),
              _ToolbarButton(
                key: const Key('toolbar-compose'),
                icon: Icons.edit_square,
                label: 'New Message',
                onTap: onCompose,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.onLongPress,
    this.color,
    this.hint,
  });

  final IconData icon;
  final String label;
  final String? hint;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final Color? color;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    hint: hint,
    excludeSemantics: true,
    child: InkResponse(
      onTap: onTap,
      onLongPress: onLongPress,
      radius: 24,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(icon, size: 25, color: color ?? Theme.of(context).colorScheme.primary),
      ),
    ),
  );
}

class _LoadingConversation extends StatelessWidget {
  const _LoadingConversation();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [BodySkeleton(), SizedBox(height: 24), BodySkeleton()],
    ),
  );
}

/// A centred icon, title and message, for empty, error and offline states.
class _StateMessage extends StatelessWidget {
  const _StateMessage({required this.icon, required this.title, required this.message, this.onRetry});

  factory _StateMessage.error(Object error, {required VoidCallback onRetry}) {
    if (error case MailException(kind: MailErrorKind.connection)) {
      return _StateMessage(
        icon: Icons.cloud_off_outlined,
        title: "You're Offline",
        message: 'This conversation isn\'t downloaded yet. It will load when you\'re back online.',
        onRetry: onRetry,
      );
    }
    return _StateMessage(
      icon: Icons.error_outline,
      title: "Can't Show This Message",
      message: error is MailException ? error.message : 'Something went wrong.',
      onRetry: onRetry,
    );
  }

  final IconData icon;
  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: colors.secondaryText),
            const SizedBox(height: 12),
            Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.secondaryText),
            ),
            if (onRetry != null) TextButton(onPressed: onRetry, child: const Text('Try Again')),
          ],
        ),
      ),
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner({required this.error});
  final Object error;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final offline = error is MailException && (error as MailException).kind == MailErrorKind.connection;
    return Container(
      color: colors.groupedBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(offline ? Icons.cloud_off_outlined : Icons.error_outline, size: 16, color: colors.secondaryText),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              offline ? "You're offline" : (error is MailException ? (error as MailException).message : 'Not updated'),
              style: TextStyle(color: colors.secondaryText, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
