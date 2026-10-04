import 'dart:async';

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
import '../rules/rule_format.dart';
import 'subscription_actions.dart';
import 'subscription_format.dart';
import 'subscription_providers.dart';

/// Mailboxes › Subscriptions: newsletters and other bulk mail by sender,
/// "most mail you never read" first, with how often each writes and how
/// much of it is read, all counted on the phone. Each row can unsubscribe.
class SubscriptionsScreen extends ConsumerStatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  ConsumerState<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends ConsumerState<SubscriptionsScreen> {
  SubscriptionFilter _filter = SubscriptionFilter.all;

  SubscriptionActions get _actions => SubscriptionActions(context, ref);

  Future<void> _menu(Subscription s, {required bool blocked}) async {
    unawaited(HapticFeedback.mediumImpact());
    final record = ref.read(unsubscribeRecordsProvider)[s.key];
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
      case 'block':
        await _actions.block(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final async = ref.watch(subscriptionsProvider);
    final all = async.value ?? const <Subscription>[];
    final records = ref.watch(unsubscribeRecordsProvider);
    final rules = ref.watch(rulesProvider).value ?? const <Rule>[];
    final shown = all.where(_filter.matches).toList();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const LoupeTitleBar(title: 'Subscriptions'),
          SliverToBoxAdapter(
            child: _FilterChips(
              selected: _filter,
              counts: {for (final f in SubscriptionFilter.values) f: all.where(f.matches).length},
              onSelected: (f) {
                unawaited(HapticFeedback.selectionClick());
                setState(() => _filter = f);
              },
            ),
          ),
          if (async.hasError)
            SliverFillRemaining(
              hasScrollBody: false,
              child: _Empty(title: 'Couldn’t Count Subscriptions', detail: '${async.error}'),
            )
          else if (!async.hasValue)
            const SliverFillRemaining(hasScrollBody: false, child: Center(child: CupertinoActivityIndicator()))
          else if (shown.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: all.isEmpty
                  ? const _Empty(
                      title: 'No Subscriptions',
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
                  record: records[s.key],
                  blocked: blocked,
                  onTap: () => context.push(Routes.subscription(s.key)),
                  onLongPress: () => _menu(s, blocked: blocked),
                  onUnsubscribe: () => _actions.unsubscribe(s),
                  onBlock: () => _actions.block(s),
                );
              },
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 24 + MediaQuery.paddingOf(context).bottom),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(LoupeIcons.privacy, size: 16, color: colors.secondaryText),
                  const SizedBox(width: 8),
                  Expanded(child: Text(subscriptionsPrivacyNote, style: styles.footnote)),
                ],
              ),
            ),
          ),
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
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
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

/// One subscription: avatar, name, sender, "≈ 24 / month · read 3%", what
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
  const _Empty({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 24, 32, 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LoupeIcons.subscriptions, size: 52, color: colors.tertiaryText),
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
