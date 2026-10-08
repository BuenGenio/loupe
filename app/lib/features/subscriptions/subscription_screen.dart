import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../shared/bars.dart';
import '../../shared/grouped_list.dart';
import '../../shared/mailbox_display.dart';
import '../../shared/message_row.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../rules/rule_format.dart';
import 'subscription_actions.dart';
import 'subscription_format.dart';
import 'subscription_providers.dart';

/// One newsletter: how much it sends and how much of it is read, the ways
/// to be rid of it, and its latest messages.
class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key, required this.subscriptionKey});

  /// The `Subscription.key`.
  final String subscriptionKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final async = ref.watch(subscriptionsProvider);
    final s = async.value?.where((x) => x.key == subscriptionKey).firstOrNull;
    final emails = ref.watch(subscriptionEmailsProvider(subscriptionKey)).value ?? const <EmailSummary>[];
    final records = ref.watch(unsubscribeRecordsProvider);
    final record = s == null ? records[subscriptionKey] : unsubscribeRecordOf(records, s);
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
                  ? Center(child: Text(l10n.subscriptionsNoMailNow, style: styles.footnote))
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
                  child: Text(l10n.subscriptionsLatestMessages, style: styles.footnote.copyWith(letterSpacing: 0.2)),
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
              child: Text(l10n.subscriptionsPrivacyNote, style: styles.footnote),
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
    final l10n = context.l10n;
    final folders = {
      for (final id in s.mailboxIds)
        if (boxes[id] case final box?) mailboxDisplayName(box),
    }.toList()..sort();
    final r = record;
    return InsetGroup(
      separatorIndent: 16,
      children: [
        GroupedRow(
          title: l10n.subscriptionsMail,
          detail: s.recentCount == 0 ? l10n.subscriptionsNoneIn90Days : volumeLabel(l10n, s),
        ),
        GroupedRow(
          title: l10n.subscriptionsRead,
          detail: l10n.subscriptionsReadDetail(readPercent(l10n, s), s.readCount, s.messageCount),
        ),
        if (s.lastReceived case final last?) GroupedRow(title: l10n.subscriptionsLastReceived, detail: shortDate(last)),
        if (folders.isNotEmpty)
          GroupedRow(title: l10n.subscriptionsFolders(folders.length), detail: folders.join(', ')),
        if (r != null)
          GroupedRow(
            key: const Key('subscription-status'),
            leading: Icon(
              r.stillSending(s) ? LoupeIcons.warning : LoupeIcons.check,
              color: r.stillSending(s) ? colors.destructive : colors.success,
            ),
            title: r.stillSending(s) ? l10n.subscriptionsStillSendingTitle : l10n.subscriptionsUnsubscribedTitle,
            detail: r.stillSending(s)
                ? l10n.subscriptionsSince(shortDate(r.at))
                : r.via == UnsubscribeVia.web
                ? l10n.subscriptionsPageOpened(shortDate(r.at))
                : shortDate(r.at),
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
    final l10n = context.l10n;
    final methods = s.unsubscribe;
    final r = record;
    final blockRuleId = rules.where((x) => isBlocked(s, [x])).map((x) => x.id).firstOrNull;
    final canUnsubscribe = methods.isNotEmpty && (r == null || r.stillSending(s));
    return InsetGroup(
      separatorIndent: 54,
      footer: methods.isEmpty ? l10n.subscriptionsNoMethod(s.name) : null,
      children: [
        if (canUnsubscribe)
          GroupedRow(
            key: const Key('subscription-unsubscribe'),
            leading: Icon(LoupeIcons.unsubscribe, color: colors.unreadDot),
            title: r == null ? l10n.subscriptionsUnsubscribe : l10n.subscriptionsUnsubscribeAgain,
            subtitle: methodLabel(l10n, methods.first),
            chevron: false,
            onTap: () => actions.unsubscribe(s),
          ),
        if (s.inboxCount > 0)
          GroupedRow(
            key: const Key('subscription-archive'),
            leading: Icon(LoupeIcons.archive, color: colors.unreadDot),
            title: l10n.subscriptionsArchiveInbox(s.inboxCount),
            chevron: false,
            onTap: () => actions.archiveAll(s),
          ),
        GroupedRow(
          key: const Key('subscription-rule'),
          leading: Icon(LoupeIcons.makeRule, color: colors.unreadDot),
          title: l10n.subscriptionsCreateRule,
          subtitle: l10n.subscriptionsCreateRuleDetail,
          onTap: () => actions.createRule(s),
        ),
        if (s.listIds.isNotEmpty)
          GroupedRow(
            key: const Key('subscription-kind'),
            leading: Icon(LoupeIcons.mailingList, color: colors.unreadDot),
            title: l10n.subscriptionsTreatAsDiscussion,
            subtitle: l10n.subscriptionsTreatAsDiscussionDetail,
            chevron: false,
            onTap: () async {
              await actions.setKind(s, SubscriptionKind.discussion);
              if (context.mounted) context.pop();
            },
          ),
        if (blockRuleId != null)
          GroupedRow(
            key: const Key('subscription-blocked'),
            leading: Icon(LoupeIcons.block, color: colors.secondaryText),
            title: l10n.subscriptionsBlocked,
            subtitle: l10n.subscriptionsBlockedDetail,
            onTap: () => context.push(Routes.editRule(blockRuleId)),
          )
        else
          GroupedRow(
            key: const Key('subscription-block'),
            leading: Icon(LoupeIcons.block, color: colors.destructive),
            title: l10n.subscriptionsBlockSender,
            destructive: true,
            onTap: () => actions.block(s),
          ),
      ],
    );
  }
}
