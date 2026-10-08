import 'dart:async';

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
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import 'include_sheet.dart';
import 'rule_format.dart';

/// Settings › Rules: every rule in the order they run, with a switch each,
/// touch and hold to reorder, and how server rules stand per account.
class RulesScreen extends ConsumerWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final rules = ref.watch(rulesProvider);
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
    final list = rules.value ?? const <Rule>[];
    final serverAccounts = [
      for (final a in accounts)
        if (list.any((r) => r.location == RuleLocation.server && r.appliesTo(a.id))) a,
    ];
    return Scaffold(
      backgroundColor: colors.groupedBackground,
      body: CustomScrollView(
        slivers: [
          LoupeTitleBar(
            title: l10n.rulesTitle,
            trailing: [
              BarIconButton(
                icon: LoupeIcons.compose,
                tooltip: l10n.rulesNewRule,
                onPressed: () => context.push(Routes.newRule()),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          if (rules.hasError)
            SliverToBoxAdapter(
              child: RuleNotice(text: l10n.rulesLoadError, icon: LoupeIcons.error, tint: colors.destructive),
            )
          else if (!rules.hasValue)
            const SliverToBoxAdapter(child: Center(child: CupertinoActivityIndicator()))
          else if (list.isEmpty)
            SliverToBoxAdapter(
              child: _Empty(styles: styles, colors: colors),
            )
          else
            SliverToBoxAdapter(child: _RuleList(rules: list)),
          if (serverAccounts.isNotEmpty)
            SliverToBoxAdapter(
              child: InsetGroup(
                header: l10n.rulesServerRulesHeader,
                footer: l10n.rulesServerRulesFooter,
                separatorIndent: 54,
                children: [for (final a in serverAccounts) _ServerStatusRow(account: a)],
              ),
            ),
          SliverToBoxAdapter(child: SizedBox(height: 24 + MediaQuery.paddingOf(context).bottom)),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.styles, required this.colors});

  final LoupeTextStyles styles;
  final LoupeColors colors;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(32, 48, 32, 24),
    child: Column(
      children: [
        Icon(LoupeIcons.rules, size: 44, color: colors.tertiaryText),
        const SizedBox(height: 12),
        Text(context.l10n.rulesEmptyTitle, style: styles.sectionHeader),
        const SizedBox(height: 6),
        Text(context.l10n.rulesEmptyText, style: styles.footnote, textAlign: TextAlign.center),
      ],
    ),
  );
}

/// The rules in a card; touch and hold a rule (or drag its handle) to move it.
class _RuleList extends ConsumerStatefulWidget {
  const _RuleList({required this.rules});

  final List<Rule> rules;

  @override
  ConsumerState<_RuleList> createState() => _RuleListState();
}

class _RuleListState extends ConsumerState<_RuleList> {
  /// The order shown until the repository catches up with a drag.
  List<Rule>? _pending;

  List<Rule> get _rules {
    final pending = _pending;
    if (pending == null) return widget.rules;
    final byId = {for (final r in widget.rules) r.id: r};
    return [for (final r in pending) ?byId[r.id]];
  }

  @override
  void didUpdateWidget(_RuleList old) {
    super.didUpdateWidget(old);
    final pending = _pending;
    if (pending == null) return;
    final now = [for (final r in widget.rules) r.id];
    final shown = [for (final r in pending) r.id];
    // Caught up, or rules came or went: show the repository's order.
    if (now.join('|') == shown.join('|') || now.length != shown.length || !now.toSet().containsAll(shown)) {
      _pending = null;
    }
  }

  Future<void> _reorder(int from, int to) async {
    final rules = [..._rules];
    rules.insert(to, rules.removeAt(from));
    setState(() => _pending = rules);
    await _guard(() => ref.read(repositoryProvider).rules.reorderRules([for (final r in rules) r.id]));
  }

  Future<void> _toggle(Rule rule, bool enabled) =>
      _guard(() => ref.read(repositoryProvider).rules.saveRule(rule.copyWith(enabled: enabled)));

  Future<void> _guard(Future<void> Function() action) async {
    try {
      await action();
    } on MailException catch (e) {
      if (!mounted) return;
      await showCupertinoDialog<void>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(context.l10n.rulesChangeError),
          content: Text(e.message),
          actions: [
            CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(), child: Text(context.l10n.commonOk)),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final mailboxes = {for (final m in ref.watch(mailboxesProvider).value ?? const <Mailbox>[]) m.id: m};
    final rules = _rules;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: colors.cellBackground,
              child: ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                buildDefaultDragHandles: false,
                itemCount: rules.length,
                onReorderItem: _reorder,
                proxyDecorator: (child, index, animation) =>
                    Material(color: colors.cellBackground, elevation: 6, child: child),
                itemBuilder: (context, i) {
                  final rule = rules[i];
                  return ReorderableDelayedDragStartListener(
                    key: ValueKey(rule.id),
                    index: i,
                    child: _RuleRow(
                      rule: rule,
                      index: i,
                      summary: describeActions(l10n, rule, mailboxes),
                      last: i == rules.length - 1,
                      onToggle: (v) => _toggle(rule, v),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 7, 16, 0),
            child: Text(l10n.rulesListFooter, style: LoupeTextStyles.of(context).footnote),
          ),
        ],
      ),
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({
    required this.rule,
    required this.index,
    required this.summary,
    required this.last,
    required this.onToggle,
  });

  final Rule rule;
  final int index;
  final String summary;
  final bool last;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final condition = rule.condition.trim().isEmpty ? l10n.rulesConditionEveryMessage : rule.condition.trim();
    return InkWell(
      onTap: () => context.push(Routes.editRule(rule.id)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: last ? null : Border(bottom: BorderSide(color: colors.separator, width: 0.5)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 10, 8),
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: Semantics(
                  label: l10n.rulesMoveRule(rule.name),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(LoupeIcons.reorder, size: 20, color: colors.tertiaryText),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            rule.name,
                            style: styles.body.copyWith(color: rule.enabled ? colors.label : colors.secondaryText),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Flexible: a long badge (another language) shrinks instead of overflowing.
                        Flexible(child: RuleLocationBadge(rule.location)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      condition,
                      style: styles.footnote.copyWith(fontFamily: 'monospace', fontSize: 12.5),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(summary, style: styles.footnote, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Semantics(
                label: l10n.rulesRuleOn(rule.name),
                child: CupertinoSwitch(value: rule.enabled, activeTrackColor: colors.success, onChanged: onToggle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// How server rules stand on one account, with the way to turn them on.
class _ServerStatusRow extends ConsumerWidget {
  const _ServerStatusRow({required this.account});

  final MailAccount account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final status = ref.watch(serverRulesStatusProvider(account.id));
    final s = status.value;
    final (IconData icon, Color tint, String detail, String? subtitle) = switch (s) {
      null when status.hasError => (
        LoupeIcons.error,
        colors.destructive,
        l10n.rulesStatusUnknown,
        l10n.rulesStatusError,
      ),
      null => (LoupeIcons.ruleServer, colors.secondaryText, l10n.rulesStatusChecking, null),
      ServerRulesStatus(state: ServerRulesState.active, viaInclude: true, :final activeScript) => (
        LoupeIcons.check,
        colors.success,
        l10n.commonOn,
        l10n.rulesStatusViaInclude('$activeScript'),
      ),
      ServerRulesStatus(state: ServerRulesState.active) => (LoupeIcons.check, colors.success, l10n.commonOn, null),
      ServerRulesStatus(state: ServerRulesState.inactive, :final activeScript?) => (
        LoupeIcons.warning,
        colors.flag,
        l10n.commonOff,
        l10n.rulesStatusOtherScript(activeScript),
      ),
      ServerRulesStatus(state: ServerRulesState.inactive) => (
        LoupeIcons.warning,
        colors.flag,
        l10n.commonOff,
        l10n.rulesStatusNoScript,
      ),
      ServerRulesStatus(:final message) => (
        LoupeIcons.error,
        colors.destructive,
        l10n.rulesStatusUnavailable,
        message ?? l10n.rulesStatusNoSieve,
      ),
    };
    final canInclude = s != null && s.state == ServerRulesState.inactive && s.activeScript != null;
    return GroupedRow(
      leading: Icon(icon, color: tint, size: 22),
      title: account.displayName,
      subtitle: subtitle,
      detail: detail,
      chevron: canInclude,
      onTap: canInclude
          ? () => unawaited(showIncludeSheet(context, accountId: account.id, accountName: account.displayName))
          : () => ref.invalidate(serverRulesStatusProvider(account.id)),
    );
  }
}
