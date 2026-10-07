import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../router.dart';
import '../../shared/bars.dart';
import '../../shared/format.dart';
import '../../shared/sheets.dart';
import '../../shared/sync_status.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../compose/compose_args.dart';
import '../conversation/reader_prefs.dart';
import '../conversation/sheets.dart' show showSnack;
import '../subscriptions/subscription_actions.dart';
import '../subscriptions/subscription_providers.dart';
import 'list_providers.dart';

/// One mailing list, forum style: a row per thread with its title, who
/// wrote, how many replies, the last activity and a patch-series badge.
/// Muted threads stay out unless shown on purpose.
class MailingListScreen extends ConsumerStatefulWidget {
  const MailingListScreen({super.key, required this.listId});

  /// The List-Id identifier.
  final String listId;

  @override
  ConsumerState<MailingListScreen> createState() => _MailingListScreenState();
}

class _MailingListScreenState extends ConsumerState<MailingListScreen> {
  bool _showMuted = false;

  MailingLists? get _lists => mailingListsOf(ref.read(repositoryProvider));

  /// The list's subscription (its name, address and unread count), when it
  /// is a discussion.
  Subscription? _list() {
    final key = Subscription.listKey(widget.listId);
    return ref.watch(discussionsProvider).where((s) => s.key == key).firstOrNull;
  }

  Future<void> _act(Future<void> Function() action, {String? done}) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action();
      if (done != null) showSnack(messenger, done);
    } on MailException catch (e) {
      showSnack(messenger, e.message);
    }
  }

  Future<void> _setMuted(ListThread thread, bool muted) async {
    final lists = _lists;
    if (lists == null) return;
    unawaited(HapticFeedback.selectionClick());
    await _act(
      () => lists.setThreadMuted(thread.latest.id, muted: muted),
      done: muted ? 'Thread muted. New messages in it arrive read.' : 'Thread unmuted.',
    );
  }

  Future<void> _threadMenu(ListThread thread) async {
    unawaited(HapticFeedback.mediumImpact());
    final choice = await showActionSheet<String>(
      context,
      title: listThreadTitle(thread.first.subject, listId: widget.listId),
      actions: [
        thread.isMuted
            ? const SheetAction('Unmute Thread', 'unmute', icon: LoupeIcons.notifications)
            : const SheetAction('Mute Thread', 'mute', icon: LoupeIcons.mute),
        if (thread.unreadCount > 0) const SheetAction('Mark as Read', 'read', icon: LoupeIcons.markRead),
      ],
    );
    if (!mounted) return;
    switch (choice) {
      case 'mute' || 'unmute':
        await _setMuted(thread, choice == 'mute');
      case 'read':
        final repository = ref.read(repositoryProvider);
        final conversation = await repository.watchConversation(thread.latest.id).first;
        final ids = [
          for (final m in conversation)
            if (!m.isSeen) m.id,
        ];
        if (ids.isNotEmpty) await _act(() => repository.setKeywords(ids, add: {Keywords.seen}));
    }
  }

  Future<void> _listMenu(Subscription? list) async {
    final prefs = ref.read(readerPrefsProvider);
    final technical = prefs.technicalLists.contains(widget.listId);
    final pinned = ref.read(pinnedListsProvider).contains(widget.listId);
    final choice = await showActionSheet<String>(
      context,
      title: list?.name ?? widget.listId,
      actions: [
        if (list != null)
          pinned
              ? const SheetAction('Unpin from Mailboxes', 'pin', icon: LoupeIcons.unpin)
              : const SheetAction('Pin to Mailboxes', 'pin', icon: LoupeIcons.pin),
        SheetAction(
          technical ? 'Open in Default View' : 'Open as Plain Text (Mono)',
          'technical',
          icon: LoupeIcons.font,
        ),
        SheetAction(_showMuted ? 'Hide Muted Threads' : 'Show Muted Threads', 'muted', icon: LoupeIcons.mute),
        if (list != null) const SheetAction('Treat as Newsletter', 'kind', icon: LoupeIcons.newsletter),
      ],
    );
    if (!mounted) return;
    final actions = SubscriptionActions(context, ref);
    switch (choice) {
      case 'pin':
        await actions.togglePin(list!);
      case 'technical':
        await ref.read(readerPrefsProvider.notifier).setTechnicalList(widget.listId, technical: !technical);
      case 'muted':
        setState(() => _showMuted = !_showMuted);
      case 'kind':
        await actions.setKind(list!, SubscriptionKind.newsletter);
    }
  }

  void _compose(Subscription list) => openCompose(
    context,
    ComposeArgs(to: [list.postAddress!], accountId: list.accountIds.isEmpty ? null : list.accountIds.first),
  );

  @override
  Widget build(BuildContext context) {
    final list = _list();
    final async = ref.watch(listThreadsProvider(ListThreadsQuery(widget.listId, includeMuted: _showMuted)));
    final threads = async.value ?? const <ListThread>[];
    final unread = list?.unreadCount ?? 0;
    return Scaffold(
      bottomNavigationBar: LoupeBottomBar(
        leading: BarIconButton(icon: LoupeIcons.more, tooltip: 'List Options', onPressed: () => _listMenu(list)),
        center: SyncStatusLine(detail: unread > 0 ? '${formatCount(unread)} Unread' : null),
        trailing: BarIconButton(
          icon: LoupeIcons.compose,
          tooltip: 'New Message to List',
          onPressed: list?.postAddress == null ? null : () => _compose(list!),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          LoupeTitleBar(
            title: list?.name ?? widget.listId,
            subtitle: Text(widget.listId, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          CupertinoSliverRefreshControl(onRefresh: () => ref.read(repositoryProvider).refresh()),
          if (async.isLoading && !async.hasValue)
            const SliverFillRemaining(hasScrollBody: false, child: Center(child: CupertinoActivityIndicator()))
          else if (threads.isEmpty)
            SliverFillRemaining(hasScrollBody: false, child: _Empty(showMuted: _showMuted))
          else
            SliverList.builder(
              itemCount: threads.length,
              itemBuilder: (context, i) {
                final t = threads[i];
                return ListThreadRow(
                  key: ValueKey(t.threadId),
                  thread: t,
                  listId: widget.listId,
                  onTap: () => context.push(Routes.message(t.latest.id)),
                  onLongPress: () => _threadMenu(t),
                );
              },
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

/// A thread of a mailing list: title and last activity on top; the patch
/// badge, who wrote and the reply count below.
class ListThreadRow extends StatelessWidget {
  const ListThreadRow({super.key, required this.thread, required this.listId, this.onTap, this.onLongPress});

  final ListThread thread;
  final String listId;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final metrics = LoupeMetrics.of(context);
    final unread = thread.unreadCount > 0;
    final title = listThreadTitle(thread.first.subject, listId: listId);
    final badge = thread.patchBadge;
    final replies = thread.replyCount;
    return MergeSemantics(
      child: Semantics(
        button: true,
        label: [
          if (unread) 'Unread',
          if (thread.isMuted) 'Muted',
          ?badge,
          replies == 1 ? '1 reply' : '$replies replies',
        ].join(', '),
        child: Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Padding(
              padding: EdgeInsets.only(top: metrics.rowVerticalPadding, right: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: metrics.rowGutter,
                    height: 22,
                    child: Center(
                      child: thread.isMuted
                          ? Icon(LoupeIcons.mute, size: 13, color: colors.tertiaryText)
                          : unread
                          ? Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(color: colors.unreadDot, shape: BoxShape.circle),
                            )
                          : null,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: (unread ? styles.senderUnread : styles.sender).copyWith(
                                  color: thread.isMuted ? colors.secondaryText : null,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(formatListDate(thread.lastActivity), style: styles.date),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (badge != null) ...[PatchBadge(badge), const SizedBox(width: 6)],
                            Expanded(
                              child: Text(
                                participantsLine(thread.participants),
                                style: styles.preview,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (replies > 0) ...[
                              const SizedBox(width: 8),
                              Icon(LoupeIcons.replies, size: 15, color: colors.secondaryText),
                              const SizedBox(width: 3),
                              Text(formatCount(replies), style: styles.caption.copyWith(color: colors.secondaryText)),
                            ],
                          ],
                        ),
                        SizedBox(height: metrics.rowVerticalPadding),
                        Divider(height: 0.5, thickness: 0.5, color: colors.separator),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "PATCH v2 3/3": a small outlined, monospaced label.
class PatchBadge extends StatelessWidget {
  const PatchBadge(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(color: colors.success.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LoupeIcons.patch, size: 12, color: colors.success),
          const SizedBox(width: 3),
          Text(
            label,
            style: styles.caption.copyWith(
              color: colors.success,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              fontFamilyFallback: const ['Roboto Mono', 'Menlo', 'Courier New'],
            ),
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.showMuted});

  final bool showMuted;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LoupeIcons.mailingList, size: 52, color: colors.tertiaryText),
          const SizedBox(height: 14),
          Text('No Threads', style: styles.sectionHeader.copyWith(color: colors.secondaryText)),
          if (!showMuted) ...[
            const SizedBox(height: 6),
            Text('Muted threads are hidden.', style: styles.footnote, textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }
}
