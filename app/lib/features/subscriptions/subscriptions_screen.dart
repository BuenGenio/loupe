import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../router.dart';
import '../../shared/avatar.dart';
import '../../shared/bars.dart';
import '../../shared/format.dart';
import '../../shared/sheets.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/reader_prefs.dart';
import '../rules/rule_format.dart';
import 'subscription_actions.dart';
import 'subscription_format.dart';
import 'subscription_providers.dart';

/// Mailboxes › Subscriptions: the mail that comes to many people at once.
///
/// Newsletters (and offers, notifications) by sender, "most mail you never
/// read" first, with how often each writes and how much of it is read, all
/// counted on the phone; each can be unsubscribed from, blocked, archived
/// or given a rule. Discussions are the mailing lists people write to, most
/// recent activity first; each opens forum style and can be pinned to
/// Mailboxes.
class SubscriptionsScreen extends ConsumerStatefulWidget {
  const SubscriptionsScreen({super.key, this.initialTab});

  /// The tab to open on (the route's `?tab=`); else the last one chosen;
  /// else Newsletters, or Discussions when there are no newsletters.
  final SubscriptionKind? initialTab;

  @override
  ConsumerState<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends ConsumerState<SubscriptionsScreen> {
  SubscriptionFilter _filter = SubscriptionFilter.all;
  final _text = TextEditingController();
  late SubscriptionKind? _chosen = widget.initialTab;

  SubscriptionActions get _actions => SubscriptionActions(context, ref);

  @override
  void initState() {
    super.initState();
    _text.addListener(() => setState(() {}));
    // Unsubscribe records kept under keys from before mail was grouped by
    // sender move to the subscriptions that took them in.
    ref.listenManual(subscriptionsProvider, (_, next) {
      final subs = next.value;
      if (subs == null) return;
      // Not while the tree builds.
      unawaited(Future(() => mounted ? ref.read(unsubscribeRecordsProvider.notifier).adopt(subs) : null));
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  SubscriptionKind _tab(List<Subscription> all, {required bool loaded}) {
    final chosen = _chosen ?? ref.watch(subscriptionsTabProvider);
    if (chosen != null) return chosen;
    final noNewsletters = loaded && all.isNotEmpty && all.every((s) => s.isDiscussion);
    return noNewsletters ? SubscriptionKind.discussion : SubscriptionKind.newsletter;
  }

  Future<void> _newsletterMenu(Subscription s, {required bool blocked}) async {
    unawaited(HapticFeedback.mediumImpact());
    final record = unsubscribeRecordOf(ref.read(unsubscribeRecordsProvider), s);
    final methods = s.unsubscribe;
    final choice = await showActionSheet<String>(
      context,
      title: s.name,
      message: senderLine(s),
      actions: [
        if (methods.isNotEmpty && (record == null || record.stillSending(s)))
          const SheetAction('Unsubscribe', 'unsubscribe', icon: LoupeIcons.unsubscribe),
        if (s.inboxCount > 0)
          SheetAction('Archive ${formatCount(s.inboxCount)} in Inbox', 'archive', icon: LoupeIcons.archive),
        const SheetAction('Create Rule…', 'rule', icon: LoupeIcons.makeRule),
        if (s.listIds.isNotEmpty) const SheetAction('Treat as Discussion', 'kind', icon: LoupeIcons.mailingList),
        if (!blocked) const SheetAction('Block Sender', 'block', icon: LoupeIcons.block, destructive: true),
      ],
    );
    if (choice == null || !mounted) return;
    switch (choice) {
      case 'unsubscribe':
        await _actions.unsubscribe(s);
      case 'archive':
        await _actions.archiveAll(s);
      case 'rule':
        _actions.createRule(s);
      case 'kind':
        await _actions.setKind(s, SubscriptionKind.discussion);
      case 'block':
        await _actions.block(s);
    }
  }

  Future<void> _discussionMenu(Subscription s) async {
    unawaited(HapticFeedback.mediumImpact());
    final pinned = ref.read(pinnedListsProvider).contains(s.listId);
    final technical = ref.read(readerPrefsProvider).technicalLists.contains(s.listId);
    final record = unsubscribeRecordOf(ref.read(unsubscribeRecordsProvider), s);
    final choice = await showActionSheet<String>(
      context,
      title: s.name,
      message: senderLine(s),
      actions: [
        pinned
            ? const SheetAction('Unpin from Mailboxes', 'pin', icon: LoupeIcons.unpin)
            : const SheetAction('Pin to Mailboxes', 'pin', icon: LoupeIcons.pin),
        if (s.unsubscribe.isNotEmpty && (record == null || record.stillSending(s)))
          const SheetAction('Unsubscribe', 'unsubscribe', icon: LoupeIcons.unsubscribe),
        SheetAction(
          technical ? 'Open in Default View' : 'Open as Plain Text (Mono)',
          'technical',
          icon: LoupeIcons.font,
        ),
        const SheetAction('Treat as Newsletter', 'kind', icon: LoupeIcons.newsletter),
      ],
    );
    if (choice == null || !mounted) return;
    switch (choice) {
      case 'pin':
        await _actions.togglePin(s);
      case 'unsubscribe':
        await _actions.unsubscribe(s);
      case 'technical':
        await _actions.toggleTechnical(s);
      case 'kind':
        await _actions.setKind(s, SubscriptionKind.newsletter);
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(subscriptionsProvider);
    final all = async.value ?? const <Subscription>[];
    final tab = _tab(all, loaded: async.hasValue);
    final text = _text.text;
    return Scaffold(
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          const LoupeTitleBar(title: 'Subscriptions'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CupertinoSlidingSegmentedControl<SubscriptionKind>(
                    key: const ValueKey('subscriptions-tabs'),
                    groupValue: tab,
                    children: const {
                      SubscriptionKind.newsletter: _Segment('Newsletters'),
                      SubscriptionKind.discussion: _Segment('Discussions'),
                    },
                    onValueChanged: (kind) {
                      if (kind == null) return;
                      unawaited(HapticFeedback.selectionClick());
                      setState(() => _chosen = kind);
                      unawaited(ref.read(subscriptionsTabProvider.notifier).set(kind));
                    },
                  ),
                  const SizedBox(height: 10),
                  LoupeSearchField(controller: _text, placeholder: 'Filter'),
                ],
              ),
            ),
          ),
          if (async.hasError)
            SliverFillRemaining(
              hasScrollBody: false,
              child: _Empty(title: 'Couldn’t Count Subscriptions', detail: '${async.error}'),
            )
          else if (!async.hasValue)
            const SliverFillRemaining(hasScrollBody: false, child: Center(child: CupertinoActivityIndicator()))
          else if (tab == SubscriptionKind.newsletter)
            ..._newsletters(all, text)
          else
            ..._discussions(all, text),
        ],
      ),
    );
  }

  List<Widget> _newsletters(List<Subscription> all, String text) {
    final records = ref.watch(unsubscribeRecordsProvider);
    final rules = ref.watch(rulesProvider).value ?? const <Rule>[];
    final newsletters = [
      for (final s in all)
        if (!s.isDiscussion && matchesFilterText(s, text)) s,
    ];
    final shown = newsletters.where(_filter.matches).toList();
    return [
      SliverToBoxAdapter(
        child: _FilterChips(
          selected: _filter,
          counts: {for (final f in SubscriptionFilter.values) f: newsletters.where(f.matches).length},
          onSelected: (f) {
            unawaited(HapticFeedback.selectionClick());
            setState(() => _filter = f);
          },
        ),
      ),
      if (shown.isEmpty)
        SliverFillRemaining(
          hasScrollBody: false,
          child: text.trim().isNotEmpty
              ? _Empty(title: 'No Matches', detail: 'No newsletter is called “${text.trim()}”.')
              : newsletters.isEmpty
              ? const _Empty(
                  title: 'No Newsletters',
                  detail: 'Newsletters and other bulk mail show up here once they arrive.',
                )
              : _Empty(title: 'Nothing ${_filter.label}', detail: 'You read some of everything you get.'),
        )
      else
        SliverList.builder(
          itemCount: shown.length,
          itemBuilder: (context, i) {
            final s = shown[i];
            final blocked = isBlocked(s, rules);
            return SubscriptionRow(
              key: ValueKey(s.key),
              subscription: s,
              record: unsubscribeRecordOf(records, s),
              blocked: blocked,
              onTap: () => context.push(Routes.subscription(s.key)),
              onLongPress: () => _newsletterMenu(s, blocked: blocked),
              onUnsubscribe: () => _actions.unsubscribe(s),
              onBlock: () => _actions.block(s),
            );
          },
        ),
      const SliverToBoxAdapter(
        child: _Footnote(icon: LoupeIcons.privacy, text: subscriptionsPrivacyNote),
      ),
    ];
  }

  List<Widget> _discussions(List<Subscription> all, String text) {
    final pinned = ref.watch(pinnedListsProvider);
    final discussions = [
      for (final s in all)
        if (s.isDiscussion && matchesFilterText(s, text)) s,
    ]..sort(Subscription.compareByActivity);
    return [
      if (discussions.isEmpty)
        SliverFillRemaining(
          hasScrollBody: false,
          child: text.trim().isNotEmpty
              ? _Empty(title: 'No Matches', detail: 'No list is called “${text.trim()}”.')
              : const _Empty(
                  title: 'No Discussions',
                  detail: 'Mailing lists you can write to show up here once their mail arrives.',
                  icon: LoupeIcons.mailingList,
                ),
        )
      else
        SliverList.builder(
          itemCount: discussions.length,
          itemBuilder: (context, i) {
            final s = discussions[i];
            return DiscussionRow(
              key: ValueKey(s.key),
              subscription: s,
              pinned: pinned.contains(s.listId),
              onTap: () => context.push(Routes.mailingList(s.listId!)),
              onLongPress: () => _discussionMenu(s),
            );
          },
        ),
      const SliverToBoxAdapter(
        child: _Footnote(
          icon: LoupeIcons.info,
          text:
              'Lists that several people write to. Touch and hold one to pin it to Mailboxes, read it as plain '
              'text, or move it to Newsletters.',
        ),
      ),
    ];
  }
}

class _Segment extends StatelessWidget {
  const _Segment(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
  );
}

class _Footnote extends StatelessWidget {
  const _Footnote({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 24 + MediaQuery.paddingOf(context).bottom),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: colors.secondaryText),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: styles.footnote)),
        ],
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips({required this.selected, required this.counts, required this.onSelected});

  final SubscriptionFilter selected;
  final Map<SubscriptionFilter, int> counts;
  final ValueChanged<SubscriptionFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Row(
        children: [
          for (final f in SubscriptionFilter.values) ...[
            Semantics(
              button: true,
              selected: f == selected,
              label: '${f.label}, ${counts[f] ?? 0}',
              excludeSemantics: true,
              child: GestureDetector(
                key: ValueKey('filter-${f.name}'),
                onTap: () => onSelected(f),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: f == selected ? colors.unreadDot : colors.fill,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        f.label,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: f == selected ? Colors.white : colors.label,
                        ),
                      ),
                      if (counts[f] case final n? when n > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            formatCount(n),
                            style: TextStyle(
                              fontSize: 15,
                              color: f == selected ? Colors.white70 : colors.secondaryText,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
          ],
        ],
      ),
    );
  }
}

/// One newsletter: avatar, name, sender, "≈ 24 / month · read 3%", what
/// became of an unsubscribe, and the button that fits (Unsubscribe, or
/// Block when it can't be done or didn't work).
class SubscriptionRow extends StatelessWidget {
  const SubscriptionRow({
    super.key,
    required this.subscription,
    this.record,
    this.blocked = false,
    this.onTap,
    this.onLongPress,
    this.onUnsubscribe,
    this.onBlock,
  });

  final Subscription subscription;
  final UnsubscribeRecord? record;
  final bool blocked;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onUnsubscribe;
  final VoidCallback? onBlock;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final metrics = LoupeMetrics.of(context);
    final s = subscription;
    final r = record;
    final stillSending = r != null && r.stillSending(s);
    final String? status = blocked
        ? 'Blocked'
        : r == null
        ? null
        : unsubscribedLabel(r, s);
    final Widget? button = blocked
        ? null
        : r == null && s.unsubscribe.isNotEmpty
        ? _RowButton(label: 'Unsubscribe', color: colors.unreadDot, onPressed: onUnsubscribe)
        : r == null || stillSending
        ? _RowButton(label: 'Block', color: colors.destructive, onPressed: onBlock)
        : null;
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: EdgeInsets.only(left: 16, top: metrics.rowVerticalPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SenderAvatar(address: EmailAddress(s.address, s.name), size: 38),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // The name has the whole width; the button sits beside the lines below it.
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(s.name, style: styles.senderUnread, maxLines: 1, overflow: TextOverflow.ellipsis),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      senderLine(s),
                                      style: styles.preview,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(statsLine(s), style: styles.footnote.copyWith(color: colors.label)),
                                    if (status != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          status,
                                          style: styles.footnote.copyWith(
                                            color: stillSending
                                                ? colors.destructive
                                                : blocked
                                                ? colors.secondaryText
                                                : colors.success,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (button != null) ...[const SizedBox(width: 8), button],
                            ],
                          ),
                        ],
                      ),
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
    );
  }
}

/// One discussion list: its name and address, a pin when it is on the
/// Mailboxes screen, its last activity and unread count.
class DiscussionRow extends StatelessWidget {
  const DiscussionRow({super.key, required this.subscription, this.pinned = false, this.onTap, this.onLongPress});

  final Subscription subscription;
  final bool pinned;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final metrics = LoupeMetrics.of(context);
    final s = subscription;
    final unread = s.unreadCount;
    final last = s.lastReceived;
    return MergeSemantics(
      child: Semantics(
        button: true,
        label: [if (pinned) 'Pinned', if (unread > 0) '${formatCount(unread)} unread'].join(', '),
        child: Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Padding(
              padding: EdgeInsets.only(left: 16, top: metrics.rowVerticalPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(color: colors.fill, shape: BoxShape.circle),
                    child: Icon(LoupeIcons.mailingList, size: 22, color: colors.unreadDot),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            s.name,
                                            style: unread > 0 ? styles.senderUnread : styles.sender,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (pinned) ...[
                                          const SizedBox(width: 5),
                                          Icon(LoupeIcons.pinFilled, size: 13, color: colors.secondaryText),
                                        ],
                                      ],
                                    ),
                                    Text(
                                      senderLine(s),
                                      style: styles.preview,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (last != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(formatListDate(last, now: clock.now()), style: styles.date),
                                    ),
                                  if (unread > 0)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        formatCount(unread),
                                        key: ValueKey('unread-${s.key}'),
                                        style: styles.footnote.copyWith(color: colors.secondaryText),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
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

class _RowButton extends StatelessWidget {
  const _RowButton({required this.label, required this.color, this.onPressed});

  final String label;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      minimumSize: const Size(44, 30),
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(15),
      onPressed: onPressed,
      child: Text(
        label,
        style: LoupeTextStyles.of(context).body.copyWith(color: color, fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.title, required this.detail, this.icon = LoupeIcons.subscriptions});

  final String title;
  final String detail;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 24, 32, 48),
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
          const SizedBox(height: 6),
          Text(detail, style: styles.footnote, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
