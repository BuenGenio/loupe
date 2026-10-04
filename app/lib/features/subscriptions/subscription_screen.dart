import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../router.dart';
import '../../shared/bars.dart';
import '../../shared/format.dart';
import '../../shared/grouped_list.dart';
import '../../shared/mailbox_display.dart';
import '../../shared/message_row.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../rules/rule_format.dart';
import 'subscription_actions.dart';
import 'subscription_format.dart';
import 'subscription_providers.dart';

/// One subscription: how much it sends and how much of it is read, the
/// ways to be rid of it, and its latest messages.
class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key, required this.subscriptionKey});

  /// The `Subscription.key`.
  final String subscriptionKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final async = ref.watch(subscriptionsProvider);
    final s = async.value?.where((x) => x.key == subscriptionKey).firstOrNull;
    final emails = ref.watch(subscriptionEmailsProvider(subscriptionKey)).value ?? const <EmailSummary>[];
    final record = ref.watch(unsubscribeRecordsProvider)[subscriptionKey];
    final rules = ref.watch(rulesProvider).value ?? const <Rule>[];
    final boxes = {for (final m in ref.watch(mailboxesProvider).value ?? const <Mailbox>[]) m.id: m};
    final actions = SubscriptionActions(context, ref);
    final fallbackTitle = subscriptionKey.substring(subscriptionKey.indexOf(':') + 1);
    return Scaffold(
      backgroundColor: colors.groupedBackground,
      body: CustomScrollView(
        slivers: [
          LoupeTitleBar(
            title: s?.name ?? fallbackTitle,
            subtitle: s == null ? null : Text(senderLine(s), maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          if (s == null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: async.hasValue
                  ? Center(child: Text('No mail from this sender now.', style: styles.footnote))
                  : const Center(child: CupertinoActivityIndicator()),
            )
          else ...[
            SliverToBoxAdapter(
              child: _Summary(s: s, record: record, boxes: boxes),
            ),
            SliverToBoxAdapter(
              child: _Actions(s: s, record: record, rules: rules, actions: actions),
            ),
            if (emails.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 16, 7),
                  child: Text('LATEST MESSAGES', style: styles.footnote.copyWith(letterSpacing: 0.2)),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList.builder(
                  itemCount: emails.length,
                  itemBuilder: (context, i) {
                    final e = emails[i];
                    final box = boxes[e.mailboxId];
                    return ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(i == 0 ? 10 : 0),
                        bottom: Radius.circular(i == emails.length - 1 ? 10 : 0),
                      ),
                      child: MessageRow(
                        key: ValueKey(e.id),
                        email: e,
                        location: box == null ? null : mailboxDisplayName(box),
                        onTap: () => context.push(Routes.message(e.id)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32, 16, 32, 24 + MediaQuery.paddingOf(context).bottom),
              child: Text(subscriptionsPrivacyNote, style: styles.footnote),
            ),
          ),
        ],
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.s, required this.record, required this.boxes});

  final Subscription s;
  final UnsubscribeRecord? record;
  final Map<String, Mailbox> boxes;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final folders = {
      for (final id in s.mailboxIds)
        if (boxes[id] case final box?) mailboxDisplayName(box),
    }.toList()..sort();
    final r = record;
    return InsetGroup(
      separatorIndent: 16,
      children: [
        GroupedRow(title: 'Mail', detail: volumeLabel(s) == 'None lately' ? 'None in 90 days' : volumeLabel(s)),
        GroupedRow(
          title: 'Read',
          detail: '${readPercent(s)} · ${formatCount(s.readCount)} of ${formatCount(s.messageCount)}',
        ),
        if (s.lastReceived case final last?) GroupedRow(title: 'Last Received', detail: shortDate(last)),
        if (folders.isNotEmpty)
          GroupedRow(title: folders.length == 1 ? 'Folder' : 'Folders', detail: folders.join(', ')),
        if (r != null)
          GroupedRow(
            key: const Key('subscription-status'),
            leading: Icon(
              r.stillSending(s) ? LoupeIcons.warning : LoupeIcons.check,
              color: r.stillSending(s) ? colors.destructive : colors.success,
            ),
            title: r.stillSending(s) ? 'Still Sending' : 'Unsubscribed',
            detail: r.stillSending(s)
                ? 'since ${shortDate(r.at)}'
                : '${r.via == UnsubscribeVia.web ? 'page opened ' : ''}${shortDate(r.at)}',
          ),
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.s, required this.record, required this.rules, required this.actions});

  final Subscription s;
  final UnsubscribeRecord? record;
  final List<Rule> rules;
  final SubscriptionActions actions;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final methods = s.unsubscribe;
    final r = record;
    final blockRuleId = rules.where((x) => isBlocked(s, [x])).map((x) => x.id).firstOrNull;
    final canUnsubscribe = methods.isNotEmpty && (r == null || r.stillSending(s));
    return InsetGroup(
      separatorIndent: 54,
      footer: methods.isEmpty ? '${s.name} doesn’t say how to unsubscribe.' : null,
      children: [
        if (canUnsubscribe)
          GroupedRow(
            key: const Key('subscription-unsubscribe'),
            leading: Icon(LoupeIcons.unsubscribe, color: colors.unreadDot),
            title: r == null ? 'Unsubscribe' : 'Unsubscribe Again',
            subtitle: methodLabel(methods.first),
            chevron: false,
            onTap: () => actions.unsubscribe(s),
          ),
        if (s.inboxCount > 0)
          GroupedRow(
            key: const Key('subscription-archive'),
            leading: Icon(LoupeIcons.archive, color: colors.unreadDot),
            title: 'Archive ${formatCount(s.inboxCount)} in Inbox',
            chevron: false,
            onTap: () => actions.archiveAll(s),
          ),
        GroupedRow(
          key: const Key('subscription-rule'),
          leading: Icon(LoupeIcons.makeRule, color: colors.unreadDot),
          title: 'Create Rule…',
          subtitle: 'Move or archive its future mail',
          onTap: () => actions.createRule(s),
        ),
        if (blockRuleId != null)
          GroupedRow(
            key: const Key('subscription-blocked'),
            leading: Icon(LoupeIcons.block, color: colors.secondaryText),
            title: 'Blocked',
            subtitle: 'New mail goes to Junk',
            onTap: () => context.push(Routes.editRule(blockRuleId)),
          )
        else
          GroupedRow(
            key: const Key('subscription-block'),
            leading: Icon(LoupeIcons.block, color: colors.destructive),
            title: 'Block Sender',
            destructive: true,
            onTap: () => actions.block(s),
          ),
      ],
    );
  }
}
