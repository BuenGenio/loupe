import 'dart:async';

import 'package:clock/clock.dart';
import 'package:expr_search/expr_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../shared/bars.dart';
import '../../shared/format.dart';
import '../../shared/grouped_list.dart';
import '../../shared/sheets.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../search/search_session.dart';
import 'include_sheet.dart';
import 'rule_format.dart';

/// Edits a rule, or makes a new one ([ruleId] null), optionally with a
/// condition, a name and actions already filled in ("Make This a Rule" from
/// a search, "Create Rule" from Subscriptions).
class RuleEditorScreen extends ConsumerStatefulWidget {
  const RuleEditorScreen({
    super.key,
    this.ruleId,
    this.initialCondition = '',
    this.initialName = '',
    this.initialActions = const [],
  });

  final String? ruleId;
  final String initialCondition;
  final String initialName;
  final List<RuleAction> initialActions;

  @override
  ConsumerState<RuleEditorScreen> createState() => _RuleEditorScreenState();
}

class _RuleEditorScreenState extends ConsumerState<RuleEditorScreen> {
  late final _name = TextEditingController(text: widget.initialName.trim());
  late final _condition = QueryTextController(text: widget.initialCondition.trim());
  final _conditionFocus = FocusNode();
  late final String _id = widget.ruleId ?? newRuleId();
  Rule? _original;
  bool _loading = true;
  bool _saving = false;
  Set<String> _accounts = {};
  late List<RuleAction> _actions = [...widget.initialActions];
  bool _stop = false;
  bool _enabled = true;
  RuleLocation _location = RuleLocation.device;

  /// Matching messages from the last 30 days, for the condition [_previewFor].
  StreamSubscription<SearchResults>? _previewSub;
  SearchResults? _preview;
  String? _previewFor;
  Timer? _debounce;

  /// What the rule becomes on each server, for the draft [_serverFor].
  Future<List<ServerRulePreview>>? _server;
  String? _serverFor;
  bool _showScript = false;

  @override
  void initState() {
    super.initState();
    _condition.addListener(_conditionChanged);
    unawaited(_load());
  }

  Future<void> _load() async {
    final id = widget.ruleId;
    if (id != null) {
      final rules = await ref.read(repositoryProvider).rules.watchRules().first;
      final rule = rules.where((r) => r.id == id).firstOrNull;
      if (rule != null) {
        _original = rule;
        _name.text = rule.name;
        _condition.text = rule.condition;
        _accounts = {...rule.accountIds};
        _actions = [...rule.actions];
        _stop = rule.stopProcessing;
        _enabled = rule.enabled;
        _location = rule.location;
      }
    }
    if (!mounted) return;
    setState(() => _loading = false);
    _refreshPreview(now: true);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    unawaited(_previewSub?.cancel());
    _name.dispose();
    _condition.dispose();
    _conditionFocus.dispose();
    super.dispose();
  }

  bool get _isNew => _original == null;

  String get _conditionText => _condition.text.trim();

  ParsedQuery get _parsed => parseQuery(_conditionText);

  /// A name from the condition when none was typed.
  String get _defaultName {
    final terms = queryTerms(_parsed.expr);
    if (terms.isEmpty) return context.l10n.rulesDefaultNameEveryMessage;
    return terms.take(2).map(describeTerm).join(', ');
  }

  Rule get _draft => Rule(
    id: _id,
    name: _name.text.trim().isEmpty ? _defaultName : _name.text.trim(),
    condition: _conditionText,
    actions: [
      for (final a in _actions)
        if (a.runsOn(_location)) a,
    ],
    enabled: _enabled,
    accountIds: _accounts,
    stopProcessing: _stop,
    location: _location,
    order: _original?.order ?? 0,
  );

  void _conditionChanged() {
    if (_previewFor == _conditionText) return;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), _refreshPreview);
    if (_location == RuleLocation.server && _serverFor != _conditionText) setState(() => _server = null);
  }

  /// Searches the last 30 days for what the condition matches.
  void _refreshPreview({bool now = false}) {
    if (!mounted) return;
    final text = _conditionText;
    _previewFor = text;
    unawaited(_previewSub?.cancel());
    final parsed = parseQuery(text);
    if (!parsed.isValid) {
      setState(() => _preview = null);
      return;
    }
    final since = clock.now().subtract(const Duration(days: 30));
    final expr = SearchAnd([parsed.expr, DateTerm(DateComparison.onOrAfter, since)]);
    _previewSub = ref
        .read(repositoryProvider)
        .search(SearchRequest(expr: expr, scope: const AllMailboxesScope(), text: text, limit: 50))
        .listen((r) {
          if (mounted && _previewFor == text) setState(() => _preview = r);
        }, onError: (Object _) {});
  }

  Future<List<ServerRulePreview>> _serverPreview() {
    final draft = _draft;
    final key = '${draft.condition}|${draft.accountIds}|${draft.actions}|${draft.stopProcessing}';
    if (_server == null || _serverFor != key) {
      _serverFor = key;
      _server = ref.read(repositoryProvider).rules.previewServerRule(draft);
    }
    return _server!;
  }

  // Actions ---------------------------------------------------------------------------

  Future<void> _addAction() async {
    final l10n = context.l10n;
    final choice = await showActionSheet<String>(
      context,
      title: l10n.rulesAddAction,
      actions: [
        SheetAction(l10n.rulesAddMove, 'move', icon: LoupeIcons.move),
        SheetAction(l10n.rulesAddTagMenu, 'tag', icon: LoupeIcons.tag),
        SheetAction(l10n.rulesRemoveTagMenu, 'untag', icon: LoupeIcons.tag),
        SheetAction(l10n.mailFlag, 'flag', icon: LoupeIcons.flagged),
        SheetAction(l10n.mailMarkAsRead, 'read', icon: LoupeIcons.markRead),
        SheetAction(l10n.mailMoveToJunk, 'junk', icon: LoupeIcons.junk),
        SheetAction(l10n.rulesActionKeepInInbox, 'keep', icon: LoupeIcons.keepInInbox),
        if (_location == RuleLocation.server) SheetAction(l10n.rulesAddForward, 'forward', icon: LoupeIcons.forward),
      ],
    );
    if (choice == null || !mounted) return;
    final RuleAction? action = switch (choice) {
      'move' => await _pickMove(),
      'tag' => await _pickTag(add: true),
      'untag' => await _pickTag(add: false),
      'flag' => const FlagAction(),
      'read' => const MarkReadAction(),
      'junk' => const MarkJunkAction(),
      'keep' => const KeepInInboxAction(),
      'forward' => await _pickForward(),
      _ => null,
    };
    if (action == null || !mounted) return;
    setState(() {
      _actions = [
        for (final a in _actions)
          if (a != action && !(a is MoveToMailboxAction && action is MoveToMailboxAction)) a,
        action,
      ];
      _server = null;
    });
  }

  Future<RuleAction?> _pickMove() async {
    final accounts = ref.read(accountsProvider).value ?? const <MailAccount>[];
    final mailboxes = ref.read(mailboxesProvider).value ?? const <Mailbox>[];
    final candidates = [
      for (final a in accounts)
        if (_accounts.isEmpty || _accounts.contains(a.id)) a,
    ];
    if (candidates.isEmpty) return null;
    var account = candidates.first;
    if (candidates.length > 1) {
      final picked = await showActionSheet<MailAccount>(
        context,
        title: context.l10n.rulesMoveAccountTitle,
        message: context.l10n.rulesMoveAccountMessage,
        actions: [for (final a in candidates) SheetAction(a.displayName, a)],
      );
      if (picked == null || !mounted) return null;
      account = picked;
    }
    final id = await showMailboxPicker(
      context,
      mailboxes: mailboxes,
      accountId: account.id,
      accountName: account.displayName,
    );
    return id == null ? null : MoveToMailboxAction(id);
  }

  Future<RuleAction?> _pickTag({required bool add}) async {
    final keyword = await showActionSheet<String>(
      context,
      title: add ? context.l10n.rulesAddTag : context.l10n.rulesRemoveTag,
      actions: [
        for (final t in TagDefinition.thunderbirdDefaults) SheetAction(t.label, t.keyword, icon: LoupeIcons.tagFilled),
      ],
    );
    if (keyword == null) return null;
    return add ? AddTagAction(keyword) : RemoveTagAction(keyword);
  }

  Future<RuleAction?> _pickForward() async {
    final l10n = context.l10n;
    final address = await showTextPrompt(
      context,
      title: l10n.rulesForwardTo,
      message: l10n.rulesForwardToMessage,
      placeholder: 'name@example.com',
      confirm: l10n.commonAdd,
    );
    if (address == null || address.isEmpty || !mounted) return null;
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(address)) {
      await _alert(l10n.rulesNotAnAddressTitle, l10n.rulesNotAnAddressMessage(address));
      return null;
    }
    final keep = await showActionSheet<bool>(
      context,
      title: l10n.rulesKeepCopyTitle,
      actions: [
        SheetAction(l10n.rulesKeepCopy, true, isDefault: true),
        SheetAction(l10n.rulesDontKeepCopy, false, destructive: true),
      ],
    );
    if (keep == null) return null;
    return ForwardAction(address, keepCopy: keep);
  }

  // Saving and the rest ---------------------------------------------------------------

  Future<void> _alert(String title, String message, {List<Widget> extra = const []}) => showCupertinoDialog<void>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        ...extra,
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.commonOk),
        ),
      ],
    ),
  );

  Future<void> _save() async {
    final l10n = context.l10n;
    if (!_parsed.isValid) {
      await _alert(l10n.rulesCheckCondition, _parsed.errors.first.message);
      return;
    }
    final rule = _draft;
    if (rule.actions.isEmpty && !rule.stopProcessing) {
      await _alert(l10n.rulesChooseActionTitle, l10n.rulesChooseActionMessage);
      return;
    }
    setState(() => _saving = true);
    final rules = ref.read(repositoryProvider).rules;
    try {
      await rules.saveRule(rule);
    } on MailException catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      final server = rule.location == RuleLocation.server;
      final canMove = server && !_actions.any((a) => !a.runsOn(RuleLocation.device));
      await _alert(
        server ? l10n.rulesSaveServerError : l10n.rulesSaveError,
        e.message,
        extra: [
          if (canMove)
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _location = RuleLocation.device);
              },
              child: Text(l10n.rulesRunOnDeviceInstead),
            ),
        ],
      );
      return;
    }
    if (!mounted) return;
    setState(() => _saving = false);
    if (rule.location == RuleLocation.server) await _offerInclude(rule);
    if (mounted) Navigator.of(context).maybePop();
  }

  /// After saving a server rule: where another script is active, offer to
  /// include Loupe's (never replacing it).
  Future<void> _offerInclude(Rule rule) async {
    final rules = ref.read(repositoryProvider).rules;
    for (final a in ref.read(accountsProvider).value ?? const <MailAccount>[]) {
      if (!rule.appliesTo(a.id)) continue;
      final status = await rules.serverStatus(a.id);
      ref.invalidate(serverRulesStatusProvider(a.id));
      if (status.state != ServerRulesState.inactive || status.activeScript == null || !mounted) continue;
      await showIncludeSheet(context, accountId: a.id, accountName: a.displayName);
    }
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final ok = await confirmDestructive(
      context,
      title: l10n.rulesDeleteTitle(_draft.name),
      action: l10n.rulesDeleteRule,
    );
    if (!ok || !mounted) return;
    await ref.read(repositoryProvider).rules.deleteRule(_id);
    if (mounted) Navigator.of(context).maybePop();
  }

  Future<void> _applyToExisting() async {
    final l10n = context.l10n;
    final rule = _draft;
    if (!_parsed.isValid || rule.actions.isEmpty) {
      await _alert(l10n.rulesNothingToApplyTitle, l10n.rulesNothingToApplyMessage);
      return;
    }
    final scope = await showActionSheet<SearchScope>(
      context,
      title: l10n.rulesApplyScopeTitle(rule.name),
      actions: [
        SheetAction(
          l10n.rulesApplyScopeInboxes,
          const MailboxScope(VirtualMailboxRef(VirtualMailbox.allInboxes)),
          isDefault: true,
        ),
        SheetAction(l10n.rulesApplyScopeAll, const AllMailboxesScope()),
      ],
    );
    if (scope == null || !mounted) return;
    final rules = ref.read(repositoryProvider).rules;
    unawaited(
      showCupertinoDialog<void>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(l10n.rulesFindingMessages),
          content: const Padding(padding: EdgeInsets.only(top: 12), child: CupertinoActivityIndicator()),
        ),
      ),
    );
    List<EmailSummary> matches;
    try {
      matches = await rules.findMatches(rule, scope);
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      await _alert(l10n.rulesSearchError, e is MailException ? e.message : l10n.rulesSearchErrorUnknown);
      return;
    }
    if (!mounted) return;
    Navigator.of(context).pop();
    if (matches.isEmpty) {
      await _alert(l10n.rulesNoMatchesTitle, l10n.rulesNoMatchesMessage(rule.condition));
      return;
    }
    final mailboxes = {for (final m in ref.read(mailboxesProvider).value ?? const <Mailbox>[]) m.id: m};
    final n = matches.length;
    final ok = await showActionSheet<bool>(
      context,
      title: l10n.rulesApplyConfirmTitle(n, rule.name),
      message: describeActions(
        l10n,
        rule.copyWith(
          actions: [
            for (final a in rule.actions)
              if (a is! ForwardAction) a,
          ],
        ),
        mailboxes,
      ),
      actions: [SheetAction(l10n.rulesApplyConfirm(n), true, isDefault: true)],
    );
    if (ok != true || !mounted) return;
    final changed = await rules.applyRule(rule, [for (final e in matches) e.id]);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.rulesApplied(changed, rule.name))));
  }

  Future<void> _pickAccounts() async {
    final accounts = ref.read(accountsProvider).value ?? const <MailAccount>[];
    final picked = await Navigator.of(context).push<Set<String>>(
      MaterialPageRoute(
        builder: (_) => _AccountsPage(accounts: accounts, selected: _accounts),
      ),
    );
    if (picked != null) {
      setState(() {
        _accounts = picked;
        _server = null;
      });
    }
  }

  // Build -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    _condition
      ..operatorColor = colors.unreadDot
      ..keywordColor = colors.swipeArchive
      ..quotedColor = colors.success
      ..errorColor = colors.destructive;
    return Scaffold(
      backgroundColor: colors.groupedBackground,
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          LoupeTitleBar(
            title: _isNew ? l10n.rulesNewRuleTitle : l10n.rulesEditRuleTitle,
            leading: BarTextButton(label: l10n.commonCancel, onPressed: () => Navigator.of(context).maybePop()),
            trailing: [
              _saving
                  ? const Padding(padding: EdgeInsets.all(12), child: CupertinoActivityIndicator())
                  : BarTextButton(label: l10n.commonSave, bold: true, onPressed: _loading ? null : _save),
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          if (_loading)
            const SliverToBoxAdapter(child: Center(child: CupertinoActivityIndicator()))
          else
            ..._sections(context).map((w) => SliverToBoxAdapter(child: w)),
          SliverToBoxAdapter(child: SizedBox(height: 32 + MediaQuery.paddingOf(context).bottom)),
        ],
      ),
    );
  }

  List<Widget> _sections(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
    final mailboxes = {for (final m in ref.watch(mailboxesProvider).value ?? const <Mailbox>[]) m.id: m};
    final names = {for (final a in accounts) a.id: a.displayName};
    final shown = [
      for (final a in _actions)
        if (a.runsOn(_location)) a,
    ];
    final hidden = _actions.length - shown.length;
    return [
      InsetGroup(
        header: l10n.commonName,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              key: const ValueKey('rule-name'),
              controller: _name,
              style: styles.body,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration.collapsed(hintText: _defaultName),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ],
      ),
      InsetGroup(
        header: l10n.rulesConditionHeader,
        footer: l10n.rulesConditionFooter,
        children: [_ConditionField(controller: _condition, focus: _conditionFocus, onPick: _conditionChanged)],
      ),
      InsetGroup(
        separatorIndent: 16,
        children: [
          GroupedRow(
            title: l10n.rulesAccounts,
            detail: _accounts.isEmpty
                ? l10n.rulesAllAccounts
                : [for (final id in _accounts) names[id] ?? l10n.rulesRemovedAccount].join(', '),
            onTap: _pickAccounts,
          ),
        ],
      ),
      InsetGroup(
        header: l10n.rulesActionsHeader,
        separatorIndent: 54,
        footer: shown.any((a) => a is ForwardAction)
            ? l10n.rulesForwardingFooter
            : (hidden > 0 ? l10n.rulesForwardingHiddenFooter : null),
        children: [
          for (final a in shown)
            GroupedRow(
              key: ValueKey('action-$a'),
              leading: Icon(actionIcon(a), color: colors.unreadDot, size: 22),
              title: describeAction(l10n, a, mailboxes),
              chevron: false,
              trailing: Semantics(
                button: true,
                label: l10n.rulesRemoveAction(describeAction(l10n, a, mailboxes)),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(36, 36),
                  onPressed: () => setState(() {
                    _actions = [..._actions]..remove(a);
                    _server = null;
                  }),
                  child: Icon(LoupeIcons.remove, color: colors.destructive, size: 22),
                ),
              ),
            ),
          GroupedRow(
            leading: Icon(LoupeIcons.add, color: colors.unreadDot, size: 24),
            title: l10n.rulesAddAction,
            titleStyle: styles.body.copyWith(color: colors.unreadDot),
            chevron: false,
            onTap: _addAction,
          ),
          SwitchRow(
            title: l10n.rulesStopProcessing,
            value: _stop,
            onChanged: (v) => setState(() {
              _stop = v;
              _server = null;
            }),
          ),
        ],
      ),
      InsetGroup(
        header: l10n.rulesRunOnHeader,
        footer: _location == RuleLocation.device ? l10n.rulesRunOnDeviceFooter : l10n.rulesRunOnServerFooter,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: SizedBox(
              width: double.infinity,
              child: CupertinoSlidingSegmentedControl<RuleLocation>(
                key: const ValueKey('rule-location'),
                groupValue: _location,
                onValueChanged: (v) {
                  if (v != null) {
                    setState(() {
                      _location = v;
                      _server = null;
                    });
                  }
                },
                children: {
                  RuleLocation.device: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(l10n.rulesLocationThisDevice),
                  ),
                  RuleLocation.server: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(l10n.rulesLocationServer),
                  ),
                },
              ),
            ),
          ),
          if (_location == RuleLocation.server) _serverSection(context, names),
        ],
      ),
      _previewSection(context, names),
      if (!_isNew)
        InsetGroup(
          separatorIndent: 54,
          children: [
            GroupedRow(
              leading: Icon(LoupeIcons.applyRule, color: colors.unreadDot, size: 22),
              title: l10n.rulesApplyToExisting,
              chevron: false,
              onTap: _applyToExisting,
            ),
            GroupedRow(
              leading: Icon(LoupeIcons.trash, color: colors.destructive, size: 22),
              title: l10n.rulesDeleteRule,
              destructive: true,
              onTap: _delete,
            ),
          ],
        )
      else
        InsetGroup(
          separatorIndent: 54,
          children: [
            GroupedRow(
              leading: Icon(LoupeIcons.applyRule, color: colors.unreadDot, size: 22),
              title: l10n.rulesApplyToExisting,
              chevron: false,
              onTap: _applyToExisting,
            ),
          ],
        ),
    ];
  }

  Widget _serverSection(BuildContext context, Map<String, String> names) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    if (!_parsed.isValid) return const SizedBox.shrink();
    return FutureBuilder<List<ServerRulePreview>>(
      future: _serverPreview(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return RuleNotice(text: l10n.rulesServerChecking, icon: LoupeIcons.ruleServer);
        }
        if (snapshot.hasError) {
          final e = snapshot.error;
          return RuleNotice(
            text: e is MailException ? e.message : l10n.rulesServerUnreachable,
            icon: LoupeIcons.error,
            tint: colors.destructive,
          );
        }
        final previews = snapshot.data!;
        final problems = [
          for (final p in previews)
            for (final problem in p.problems) (p.accountId, problem),
        ];
        if (problems.isNotEmpty) {
          final canMove = !_actions.any((a) => !a.runsOn(RuleLocation.device));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (account, problem) in problems)
                RuleNotice(
                  key: ValueKey('problem-$account-$problem'),
                  text: previews.length > 1
                      ? l10n.rulesServerProblemOf('${names[account]}', problem)
                      : l10n.rulesServerProblem(problem),
                  icon: LoupeIcons.warning,
                  tint: colors.flag,
                ),
              if (canMove)
                Padding(
                  padding: const EdgeInsets.only(left: 42, bottom: 6),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: NoticeButton(
                      l10n.rulesRunOnDeviceInstead,
                      onPressed: () => setState(() => _location = RuleLocation.device),
                    ),
                  ),
                ),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(height: 0.5, thickness: 0.5, indent: 16, color: colors.separator),
            GroupedRow(
              title: _showScript ? l10n.rulesHideScript : l10n.rulesShowScript,
              chevron: false,
              trailing: Icon(
                _showScript ? LoupeIcons.collapse : LoupeIcons.expand,
                size: 16,
                color: colors.tertiaryText,
              ),
              onTap: () => setState(() => _showScript = !_showScript),
            ),
            if (_showScript)
              for (final p in previews)
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (previews.length > 1)
                        Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 4),
                          child: Text(names[p.accountId] ?? '', style: LoupeTextStyles.of(context).footnote),
                        ),
                      CodeBox(p.script ?? ''),
                    ],
                  ),
                ),
          ],
        );
      },
    );
  }

  Widget _previewSection(BuildContext context, Map<String, String> names) {
    final styles = LoupeTextStyles.of(context);
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final results = _preview;
    final items = [
      for (final e in results?.items ?? const <EmailSummary>[])
        if (_accounts.isEmpty || _accounts.contains(e.accountId)) e,
    ];
    final String header;
    if (!_parsed.isValid) {
      header = l10n.rulesMatchingHeader;
    } else if (results == null) {
      header = l10n.rulesMatchingHeaderLoading;
    } else if (results.items.length >= 50) {
      header = l10n.rulesMatchingCountMore(items.length);
    } else {
      header = l10n.rulesMatchingCount(items.length);
    }
    return InsetGroup(
      header: header,
      footer: _parsed.isValid ? l10n.rulesPreviewFooter : l10n.rulesConditionError(_parsed.errors.first.message),
      separatorIndent: 16,
      children: [
        if (results != null && !results.isComplete)
          const Padding(padding: EdgeInsets.all(10), child: CupertinoActivityIndicator()),
        for (final e in items.take(8))
          Padding(
            key: ValueKey('preview-${e.id}'),
            padding: const EdgeInsets.fromLTRB(16, 9, 14, 9),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.sender?.displayName ?? l10n.rulesPreviewNoSender,
                        style: styles.body.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        e.subject.isEmpty ? l10n.rulesPreviewNoSubject : e.subject,
                        style: styles.footnote.copyWith(color: colors.label),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  names.length > 1 ? names[e.accountId] ?? '' : formatListDate(e.receivedAt),
                  style: styles.footnote,
                ),
              ],
            ),
          ),
        if (items.length > 8)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 9, 14, 11),
            child: Text(l10n.rulesPreviewMore(items.length - 8), style: styles.footnote),
          ),
        if (results != null && results.isComplete && items.isEmpty && _parsed.isValid)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 11, 14, 11),
            child: Text(l10n.rulesPreviewEmpty, style: styles.footnote),
          ),
      ],
    );
  }
}

/// The search-language field with chips for its terms and completions.
class _ConditionField extends StatelessWidget {
  const _ConditionField({required this.controller, required this.focus, required this.onPick});

  final QueryTextController controller;
  final FocusNode focus;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    final colors = LoupeColors.of(context);
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final parsed = parseQuery(controller.text);
        final terms = parsed.isValid ? queryTerms(parsed.expr) : const <SearchExpr>[];
        final cursor = controller.selection.isValid ? controller.selection.baseOffset : controller.text.length;
        final completions = focus.hasFocus && controller.text.isNotEmpty
            ? suggest(controller.text, cursor.clamp(0, controller.text.length)).take(4).toList()
            : const <QuerySuggestion>[];
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                key: const ValueKey('rule-condition'),
                controller: controller,
                focusNode: focus,
                autocorrect: false,
                enableSuggestions: false,
                minLines: 1,
                maxLines: 4,
                style: styles.body.copyWith(fontFamily: 'monospace', fontSize: 15),
                decoration: InputDecoration.collapsed(hintText: context.l10n.rulesConditionHint),
              ),
              if (terms.isNotEmpty) ...[
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final t in terms)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: colors.unreadDot.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          describeTerm(t),
                          style: TextStyle(color: colors.unreadDot, fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                  ],
                ),
              ],
              if (parsed.errors.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(parsed.errors.first.message, style: styles.footnote.copyWith(color: colors.destructive)),
              ],
              if (completions.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    for (final c in completions)
                      ActionChip(
                        label: Text(c.insertText, style: const TextStyle(fontSize: 13)),
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          final start = c.replaceStart ?? cursor;
                          final end = c.replaceEnd ?? cursor;
                          final text = controller.text.replaceRange(start, end, c.insertText);
                          controller.value = TextEditingValue(
                            text: text,
                            selection: TextSelection.collapsed(offset: start + c.insertText.length),
                          );
                          onPick();
                        },
                      ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// Picks the accounts of a rule; none ticked means all of them.
class _AccountsPage extends StatefulWidget {
  const _AccountsPage({required this.accounts, required this.selected});

  final List<MailAccount> accounts;
  final Set<String> selected;

  @override
  State<_AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<_AccountsPage> {
  late final _selected = {...widget.selected};

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    Widget check(bool on) => on ? Icon(LoupeIcons.check, color: colors.unreadDot, size: 22) : const SizedBox(width: 22);
    return PopScope<Set<String>>(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.of(context).pop(_selected);
      },
      child: GroupedPage(
        title: l10n.rulesAccounts,
        children: [
          InsetGroup(
            separatorIndent: 16,
            footer: l10n.rulesAccountsFooter,
            children: [
              GroupedRow(
                title: l10n.rulesAllAccounts,
                chevron: false,
                trailing: check(_selected.isEmpty),
                onTap: () => setState(_selected.clear),
              ),
              for (final a in widget.accounts)
                GroupedRow(
                  title: a.displayName,
                  subtitle: a.email,
                  chevron: false,
                  trailing: check(_selected.contains(a.id)),
                  onTap: () => setState(() {
                    if (!_selected.remove(a.id)) _selected.add(a.id);
                    if (_selected.length == widget.accounts.length) _selected.clear();
                  }),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
