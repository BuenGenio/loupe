import 'dart:async';

import 'package:clock/clock.dart';
import 'package:expr_search/expr_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../shared/format.dart';
import '../../shared/grouped_list.dart';
import '../../shared/sheets.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../ai/ai_providers.dart';
import '../search/search_session.dart';
import 'rule_dry_run.dart';
import 'rule_editor_screen.dart';
import 'rule_format.dart';

/// The accounts Describe a Rule may work for: those whose mail the rules
/// feature may use a model for. Empty means it isn't offered at all.
List<MailAccount> describableAccounts(WidgetRef ref) => [
  for (final a in ref.watch(accountsProvider).value ?? const <MailAccount>[])
    if (ref.watch(aiServiceForProvider((AiFeature.rules, a.id))) != null) a,
];

/// Describe a Rule, from Settings › Rules. A sentence goes to the provider
/// the account may use, as a RuleProposalTask with the account's folder and
/// tag names; the sheet shows the typed draft that came back and a dry run
/// over the mail on this phone. Open in Rule Editor is the only way on, and
/// the editor saves nothing until Save: its own location choice and server
/// checks decide where the rule runs.
Future<void> describeRule(BuildContext context) async {
  final chosen = await showModalBottomSheet<_Chosen>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _DescribeRuleSheet(),
  );
  if (chosen == null || !context.mounted) return;
  final p = chosen.proposal;
  await Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (_) => RuleEditorScreen(
        initialName: p.name,
        initialCondition: p.condition,
        initialActions: p.actions,
        initialAccounts: {chosen.accountId},
        initialLocation: p.location,
        leftOut: p.unsupported,
      ),
    ),
  );
}

typedef _Chosen = ({RuleProposal proposal, String accountId});

class _DescribeRuleSheet extends ConsumerStatefulWidget {
  const _DescribeRuleSheet();

  @override
  ConsumerState<_DescribeRuleSheet> createState() => _DescribeRuleSheetState();
}

class _DescribeRuleSheetState extends ConsumerState<_DescribeRuleSheet> {
  final _sentence = TextEditingController();
  String? _accountId;

  /// The last request: its task, the account it was for and its run.
  RuleProposalTask? _task;
  MailAccount? _askedFor;
  Future<AiRun<RuleProposal>>? _run;

  @override
  void dispose() {
    _sentence.dispose();
    super.dispose();
  }

  MailAccount? _account(List<MailAccount> eligible) =>
      eligible.where((a) => a.id == _accountId).firstOrNull ?? eligible.firstOrNull;

  void _propose(MailAccount account) {
    final sentence = _sentence.text.trim();
    if (sentence.isEmpty) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final now = clock.now();
    _send(
      RuleProposalTask(
        sentence,
        accountName: account.displayName,
        mailboxes: [
          for (final m in ref.read(mailboxesProvider).value ?? const <Mailbox>[])
            if (m.accountId == account.id) m,
        ],
        now: now,
        timeZone: now.timeZoneName,
        language: languageNames[Localizations.localeOf(context).languageCode] ?? languageNames['en']!,
      ),
      account,
    );
  }

  /// Runs [task] for [account] through the provider that account may use;
  /// Retry sends the same task again, to the same provider.
  void _send(RuleProposalTask task, MailAccount account) {
    final service = ref.read(aiServiceForProvider((AiFeature.rules, account.id)));
    if (service == null) return;
    setState(() {
      _task = task;
      _askedFor = account;
      _run = service.run(task);
    });
  }

  Future<void> _pickAccount(List<MailAccount> eligible) async {
    final picked = await showActionSheet<String>(
      context,
      title: context.l10n.rulesDescribeAccount,
      actions: [for (final a in eligible) SheetAction(a.displayName, a.id, isDefault: a.id == _accountId)],
    );
    if (picked == null || picked == _accountId || !mounted) return;
    // A proposal is for the account whose folders it used.
    setState(() {
      _accountId = picked;
      _run = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final eligible = describableAccounts(ref);
    final account = _account(eligible);
    final run = _run;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: FractionallySizedBox(
        heightFactor: 0.92,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 8),
              child: Row(
                children: [
                  Icon(LoupeIcons.ask, size: 20, color: colors.unreadDot),
                  const SizedBox(width: 8),
                  Expanded(child: Text(l10n.rulesDescribeTitle, style: styles.navTitle)),
                  CupertinoButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonDone)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                key: const ValueKey('describe-list'),
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                children: [
                  InsetGroup(
                    footer: account == null ? null : l10n.rulesDescribeSentNote(account.displayName),
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    separatorIndent: 16,
                    children: [
                      GroupedRow(
                        key: const ValueKey('describe-account'),
                        title: l10n.rulesDescribeAccount,
                        detail: account?.displayName,
                        chevron: eligible.length > 1,
                        onTap: eligible.length > 1 ? () => _pickAccount(eligible) : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: TextField(
                          key: const ValueKey('describe-sentence'),
                          controller: _sentence,
                          autofocus: true,
                          minLines: 2,
                          maxLines: 5,
                          inputFormatters: [LengthLimitingTextInputFormatter(300)],
                          textCapitalization: TextCapitalization.sentences,
                          style: styles.body,
                          decoration: InputDecoration.collapsed(hintText: l10n.rulesDescribeHint),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    child: CupertinoButton.filled(
                      key: const ValueKey('describe-propose'),
                      onPressed: account == null || _sentence.text.trim().isEmpty ? null : () => _propose(account),
                      child: Text(l10n.rulesDescribePropose),
                    ),
                  ),
                  if (run != null)
                    FutureBuilder<AiRun<RuleProposal>>(
                      future: run,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                const CupertinoActivityIndicator(),
                                const SizedBox(width: 10),
                                Expanded(child: Text(l10n.rulesDescribeWorking, style: styles.body)),
                              ],
                            ),
                          );
                        }
                        return switch (snapshot.data) {
                          AiSuccess(:final value, :final record) => _ProposalView(
                            proposal: value,
                            record: record,
                            account: _askedFor!,
                          ),
                          AiFailure(:final message) => _failure(message),
                          null => _failure(snapshot.error?.toString() ?? ''),
                        };
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// No proposal: the reason, and Retry with the same provider. Nothing is
  /// tried anywhere else.
  Widget _failure(String message) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    return Padding(
      key: const ValueKey('describe-failed'),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.rulesDescribeFailed, style: styles.body),
          if (message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(message, style: styles.footnote),
            ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (_task case final task?) _send(task, _askedFor!);
            },
            child: Text(l10n.commonRetry),
          ),
        ],
      ),
    );
  }
}

/// What the provider proposed, all of it: the reading, the condition, the
/// actions (forwarding, marking read and junk listed like any other, a
/// forward also saying where the mail goes), where the rule would run, what
/// Loupe can't do, questions, the dry run, and who proposed it.
class _ProposalView extends ConsumerWidget {
  const _ProposalView({required this.proposal, required this.record, required this.account});

  final RuleProposal proposal;
  final AiRunRecord record;
  final MailAccount account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final p = proposal;
    final mailboxes = {for (final m in ref.watch(mailboxesProvider).value ?? const <Mailbox>[]) m.id: m};
    final hasCondition = p.expr != null || p.everyMessage;
    final provider = record.model == null ? record.providerId : '${record.providerId} · ${record.model}';
    return Column(
      key: const ValueKey('describe-proposal'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 6),
          child: Text(l10n.rulesDescribeProposed, style: styles.sectionHeader),
        ),
        if (p.explanation.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Text(p.explanation, style: styles.body),
          ),
        if (hasCondition)
          InsetGroup(
            header: l10n.rulesConditionHeader,
            footer: p.expr == null ? null : l10n.rulesDescribeConditionNote,
            separatorIndent: 16,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: switch (p.expr) {
                  null => Text(l10n.rulesConditionEveryMessage, style: styles.body),
                  final expr => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(p.condition, style: styles.body.copyWith(fontFamily: 'monospace', fontSize: 15)),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [for (final t in queryTerms(expr)) _Chip(describeTerm(t))],
                      ),
                    ],
                  ),
                },
              ),
            ],
          ),
        if (p.hasDraft) ...[
          InsetGroup(
            header: l10n.rulesActionsHeader,
            separatorIndent: 54,
            children: [
              if (p.actions.isEmpty)
                GroupedRow(
                  leading: Icon(LoupeIcons.info, color: colors.secondaryText, size: 22),
                  title: l10n.rulesNoActions,
                  chevron: false,
                ),
              for (final a in p.actions)
                GroupedRow(
                  key: ValueKey('proposed-$a'),
                  leading: Icon(actionIcon(a), color: colors.unreadDot, size: 22),
                  title: describeAction(l10n, a, mailboxes),
                  subtitle: a is ForwardAction ? l10n.rulesDescribeForwardWarning(a.address) : null,
                  chevron: false,
                ),
            ],
          ),
          InsetGroup(
            header: l10n.rulesRunOnHeader,
            footer: l10n.rulesDescribeScopeChoose,
            separatorIndent: 16,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.only(top: 2), child: RuleLocationBadge(p.location)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        p.location == RuleLocation.device
                            ? l10n.rulesDescribeScopeDevice(account.displayName)
                            : l10n.rulesDescribeScopeServer(account.displayName),
                        style: styles.body,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        if (p.unsupported.isNotEmpty)
          InsetGroup(
            key: const ValueKey('describe-unsupported'),
            header: l10n.rulesDescribeCantDoHeader(p.unsupported.length),
            footer: l10n.rulesDescribeCantDoFooter(p.unsupported.length),
            separatorIndent: 48,
            children: [
              for (final part in p.unsupported) UnsupportedPartRow(part: part, accountName: account.displayName),
            ],
          ),
        if (p.questions.isNotEmpty)
          InsetGroup(
            header: l10n.rulesDescribeQuestions,
            separatorIndent: 16,
            children: [
              for (final q in p.questions)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 11, 16, 11),
                  child: Text(q, style: styles.body),
                ),
            ],
          ),
        if (hasCondition)
          _DryRunSection(
            key: ObjectKey(p),
            rule: p.toRule(id: 'describe-draft', accountId: account.id),
            account: account,
          ),
        if (p.hasDraft)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CupertinoButton.filled(
              key: const ValueKey('describe-open'),
              onPressed: () => Navigator.of(context).pop<_Chosen>((proposal: p, accountId: account.id)),
              child: Text(l10n.rulesDescribeOpenEditor),
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Text(
            record.providerId == 'demo' ? l10n.rulesDescribeDemoNote : l10n.rulesDescribeProviderNote(provider),
            style: styles.footnote,
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.unreadDot.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: TextStyle(color: colors.unreadDot, fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }
}

/// "Would match 5 of 312 downloaded messages in Personal", with the newest
/// matches and the nearest misses, from [dryRunRule]: the device rule
/// runner's verdicts on this phone's mail, with that coverage said.
class _DryRunSection extends ConsumerStatefulWidget {
  const _DryRunSection({super.key, required this.rule, required this.account});

  final Rule rule;
  final MailAccount account;

  @override
  ConsumerState<_DryRunSection> createState() => _DryRunSectionState();
}

class _DryRunSectionState extends ConsumerState<_DryRunSection> {
  late final Future<RuleDryRun> _dryRun = dryRunRule(
    ref.read(repositoryProvider),
    widget.rule,
    accountId: widget.account.id,
    now: clock.now(),
  );

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    return FutureBuilder<RuleDryRun>(
      future: _dryRun,
      builder: (context, snapshot) {
        final run = snapshot.data;
        if (run == null) {
          return InsetGroup(
            header: l10n.rulesDescribeDryRunHeader,
            children: [
              if (snapshot.hasError)
                RuleNotice(text: l10n.rulesDescribeDryRunFailed, icon: LoupeIcons.error, tint: colors.destructive)
              else
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const CupertinoActivityIndicator(),
                      const SizedBox(width: 10),
                      Expanded(child: Text(l10n.rulesDescribeDryRunWorking, style: styles.footnote)),
                    ],
                  ),
                ),
            ],
          );
        }
        Widget label(String text) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
          child: Text(text, style: styles.footnote.copyWith(fontWeight: FontWeight.w600)),
        );
        return Padding(
          key: const ValueKey('describe-dry-run'),
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InsetGroup(
                header: l10n.rulesDescribeDryRunHeader,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                separatorIndent: 16,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Text(
                      l10n.rulesDescribeDryRunCount(run.checked, run.matched, widget.account.displayName),
                      style: styles.body.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  if (run.matches.isNotEmpty) label(l10n.rulesDescribeDryRunMatches),
                  for (final e in run.matches) _MessageRow(e, key: ValueKey('dry-match-${e.id}')),
                  if (run.misses.isNotEmpty) label(l10n.rulesDescribeDryRunMisses),
                  for (final e in run.misses) _MessageRow(e, key: ValueKey('dry-miss-${e.id}')),
                ],
              ),
              for (final note in [
                l10n.rulesDescribeDryRunCoverage,
                if (run.capped) l10n.rulesDescribeDryRunCapped(run.checked),
                if (run.unchecked > 0) l10n.rulesDescribeDryRunUnchecked(run.unchecked),
              ])
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 7, 32, 0),
                  child: Text(note, style: styles.footnote),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// A message of the dry run: sender, subject, date.
class _MessageRow extends StatelessWidget {
  const _MessageRow(this.email, {super.key});

  final EmailSummary email;

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 9, 14, 9),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  email.sender?.displayName ?? l10n.rulesPreviewNoSender,
                  style: styles.body.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  email.subject.isEmpty ? l10n.rulesPreviewNoSubject : email.subject,
                  style: styles.footnote.copyWith(color: colors.label),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(formatListDate(email.receivedAt), style: styles.footnote),
        ],
      ),
    );
  }
}
