import 'dart:async';

import 'package:expr_search/expr_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

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
    if (terms.isEmpty) return 'Every Message';
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
    final since = DateTime.now().subtract(const Duration(days: 30));
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
    final choice = await showActionSheet<String>(
      context,
      title: 'Add Action',
      actions: [
        const SheetAction('Move to Folder…', 'move', icon: LoupeIcons.move),
        const SheetAction('Add Tag…', 'tag', icon: LoupeIcons.tag),
        const SheetAction('Remove Tag…', 'untag', icon: LoupeIcons.tag),
        const SheetAction('Flag', 'flag', icon: LoupeIcons.flagged),
        const SheetAction('Mark as Read', 'read', icon: LoupeIcons.markRead),
        const SheetAction('Move to Junk', 'junk', icon: LoupeIcons.junk),
        const SheetAction('Keep in Inbox', 'keep', icon: LoupeIcons.keepInInbox),
        if (_location == RuleLocation.server) const SheetAction('Forward To…', 'forward', icon: LoupeIcons.forward),
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
        title: 'Folder in Which Account?',
        message: 'Mail of the other accounts goes to the folder with the same name there.',
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
      title: add ? 'Add Tag' : 'Remove Tag',
      actions: [
        for (final t in TagDefinition.thunderbirdDefaults) SheetAction(t.label, t.keyword, icon: LoupeIcons.tagFilled),
      ],
    );
    if (keyword == null) return null;
    return add ? AddTagAction(keyword) : RemoveTagAction(keyword);
  }

  Future<RuleAction?> _pickForward() async {
    final address = await showTextPrompt(
      context,
      title: 'Forward To',
      message:
          'The server sends every matching message on to this address, also while this phone is off. '
          'Use an address you own or trust.',
      placeholder: 'name@example.com',
      confirm: 'Add',
    );
    if (address == null || address.isEmpty || !mounted) return null;
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(address)) {
      await _alert('Not an Email Address', '“$address” isn’t an address to forward to.');
      return null;
    }
    final keep = await showActionSheet<bool>(
      context,
      title: 'Keep a Copy Here?',
      actions: const [
        SheetAction('Keep a Copy', true, isDefault: true),
        SheetAction('Don’t Keep a Copy', false, destructive: true),
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
          child: const Text('OK'),
        ),
      ],
    ),
  );

  Future<void> _save() async {
    if (!_parsed.isValid) {
      await _alert('Check the Condition', _parsed.errors.first.message);
      return;
    }
    final rule = _draft;
    if (rule.actions.isEmpty && !rule.stopProcessing) {
      await _alert('Choose an Action', 'Add what the rule does with the messages it matches.');
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
        server ? 'Couldn’t Save the Server Rule' : 'Couldn’t Save the Rule',
        e.message,
        extra: [
          if (canMove)
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _location = RuleLocation.device);
              },
              child: const Text('Run on This Device Instead'),
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
    final ok = await confirmDestructive(context, title: 'Delete “${_draft.name}”?', action: 'Delete Rule');
    if (!ok || !mounted) return;
    await ref.read(repositoryProvider).rules.deleteRule(_id);
    if (mounted) Navigator.of(context).maybePop();
  }

  Future<void> _applyToExisting() async {
    final rule = _draft;
    if (!_parsed.isValid || rule.actions.isEmpty) {
      await _alert('Nothing to Apply', 'Give the rule a condition that works and an action first.');
      return;
    }
    final scope = await showActionSheet<SearchScope>(
      context,
      title: 'Apply “${rule.name}” to Messages in…',
      actions: const [
        SheetAction('Inboxes', MailboxScope(VirtualMailboxRef(VirtualMailbox.allInboxes)), isDefault: true),
        SheetAction('All Mailboxes', AllMailboxesScope()),
      ],
    );
    if (scope == null || !mounted) return;
    final rules = ref.read(repositoryProvider).rules;
    unawaited(
      showCupertinoDialog<void>(
        context: context,
        builder: (context) => const CupertinoAlertDialog(
          title: Text('Finding Messages…'),
          content: Padding(padding: EdgeInsets.only(top: 12), child: CupertinoActivityIndicator()),
        ),
      ),
    );
    List<EmailSummary> matches;
    try {
      matches = await rules.findMatches(rule, scope);
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      await _alert('Couldn’t Search', e is MailException ? e.message : 'Something went wrong.');
      return;
    }
    if (!mounted) return;
    Navigator.of(context).pop();
    if (matches.isEmpty) {
      await _alert('No Messages Match', 'Nothing there matches “${rule.condition}”.');
      return;
    }
    final mailboxes = {for (final m in ref.read(mailboxesProvider).value ?? const <Mailbox>[]) m.id: m};
    final n = matches.length;
    final ok = await showActionSheet<bool>(
      context,
      title: 'Apply “${rule.name}” to ${formatCount(n)} ${n == 1 ? 'Message' : 'Messages'}?',
      message: describeActions(
        rule.copyWith(
          actions: [
            for (final a in rule.actions)
              if (a is! ForwardAction) a,
          ],
        ),
        mailboxes,
      ),
      actions: [SheetAction('Apply to ${formatCount(n)} ${n == 1 ? 'Message' : 'Messages'}', true, isDefault: true)],
    );
    if (ok != true || !mounted) return;
    final changed = await rules.applyRule(rule, [for (final e in matches) e.id]);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Applied “${rule.name}” to ${formatCount(changed)} ${changed == 1 ? 'message' : 'messages'}'),
      ),
    );
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
            title: _isNew ? 'New Rule' : 'Edit Rule',
            leading: BarTextButton(label: 'Cancel', onPressed: () => Navigator.of(context).maybePop()),
            trailing: [
              _saving
                  ? const Padding(padding: EdgeInsets.all(12), child: CupertinoActivityIndicator())
                  : BarTextButton(label: 'Save', bold: true, onPressed: _loading ? null : _save),
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
        header: 'Name',
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
        header: 'When a New Message Matches',
        footer: 'Write it as you would search: from:, to:, s: (subject), b: (body), tag:, has:attachment, larger:2M…',
        children: [_ConditionField(controller: _condition, focus: _conditionFocus, onPick: _conditionChanged)],
      ),
      InsetGroup(
        separatorIndent: 16,
        children: [
          GroupedRow(
            title: 'Accounts',
            detail: _accounts.isEmpty
                ? 'All Accounts'
                : [for (final id in _accounts) names[id] ?? 'Removed account'].join(', '),
            onTap: _pickAccounts,
          ),
        ],
      ),
      InsetGroup(
        header: 'Then',
        separatorIndent: 54,
        footer: shown.any((a) => a is ForwardAction)
            ? 'Forwarding sends every matching message to another address as it arrives, also while this phone is '
                  'off. Some providers limit how much mail may be forwarded.'
            : (hidden > 0 ? 'Forwarding only runs in server rules, so it is left out here.' : null),
        children: [
          for (final a in shown)
            GroupedRow(
              key: ValueKey('action-$a'),
              leading: Icon(actionIcon(a), color: colors.unreadDot, size: 22),
              title: describeAction(a, mailboxes),
              chevron: false,
              trailing: Semantics(
                button: true,
                label: 'Remove ${describeAction(a, mailboxes)}',
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
            title: 'Add Action',
            titleStyle: styles.body.copyWith(color: colors.unreadDot),
            chevron: false,
            onTap: _addAction,
          ),
          SwitchRow(
            title: 'Stop Processing More Rules',
            value: _stop,
            onChanged: (v) => setState(() {
              _stop = v;
              _server = null;
            }),
          ),
        ],
      ),
      InsetGroup(
        header: 'Run On',
        footer: _location == RuleLocation.device
            ? 'This device runs the rule on new Inbox mail each time Loupe checks for mail.'
            : 'The mail server runs the rule as mail arrives, also while this phone is off. Needs ManageSieve, '
                  'as Dovecot, mailcow and Fastmail-style servers offer.',
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
                children: const {
                  RuleLocation.device: Padding(padding: EdgeInsets.symmetric(vertical: 4), child: Text('This Device')),
                  RuleLocation.server: Padding(padding: EdgeInsets.symmetric(vertical: 4), child: Text('Server')),
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
              title: 'Apply to Existing Messages…',
              chevron: false,
              onTap: _applyToExisting,
            ),
            GroupedRow(
              leading: Icon(LoupeIcons.trash, color: colors.destructive, size: 22),
              title: 'Delete Rule',
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
              title: 'Apply to Existing Messages…',
              chevron: false,
              onTap: _applyToExisting,
            ),
          ],
        ),
    ];
  }

  Widget _serverSection(BuildContext context, Map<String, String> names) {
    final colors = LoupeColors.of(context);
    if (!_parsed.isValid) return const SizedBox.shrink();
    return FutureBuilder<List<ServerRulePreview>>(
      future: _serverPreview(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const RuleNotice(text: 'Asking the server what it can do…', icon: LoupeIcons.ruleServer);
        }
        if (snapshot.hasError) {
          final e = snapshot.error;
          return RuleNotice(
            text: e is MailException ? e.message : 'Couldn’t reach the server.',
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
                  text: 'Can’t run on the server${previews.length > 1 ? ' of ${names[account]}' : ''}: $problem',
                  icon: LoupeIcons.warning,
                  tint: colors.flag,
                ),
              if (canMove)
                Padding(
                  padding: const EdgeInsets.only(left: 42, bottom: 6),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: NoticeButton(
                      'Run on This Device Instead',
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
              title: _showScript ? 'Hide Script' : 'Show Script',
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
    final results = _preview;
    final items = [
      for (final e in results?.items ?? const <EmailSummary>[])
        if (_accounts.isEmpty || _accounts.contains(e.accountId)) e,
    ];
    final String header;
    if (!_parsed.isValid) {
      header = 'Matching Messages';
    } else if (results == null) {
      header = 'Matching Messages…';
    } else {
      final more = results.items.length >= 50 ? '+' : '';
      header = '${formatCount(items.length)}$more Matching ${items.length == 1 ? 'Message' : 'Messages'}';
    }
    return InsetGroup(
      header: header,
      footer: _parsed.isValid
          ? 'From the last 30 days. The rule itself only acts on new mail, unless you apply it to existing messages.'
          : 'The condition has an error: ${_parsed.errors.first.message}',
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
                        e.sender?.displayName ?? '(no sender)',
                        style: styles.body.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        e.subject.isEmpty ? '(no subject)' : e.subject,
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
            child: Text('and ${formatCount(items.length - 8)} more', style: styles.footnote),
          ),
        if (results != null && results.isComplete && items.isEmpty && _parsed.isValid)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 11, 14, 11),
            child: Text('Nothing from the last 30 days.', style: styles.footnote),
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
                decoration: const InputDecoration.collapsed(hintText: 'from:alice@example.com s:invoice'),
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
    Widget check(bool on) => on ? Icon(LoupeIcons.check, color: colors.unreadDot, size: 22) : const SizedBox(width: 22);
    return PopScope<Set<String>>(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.of(context).pop(_selected);
      },
      child: GroupedPage(
        title: 'Accounts',
        children: [
          InsetGroup(
            separatorIndent: 16,
            footer: 'A rule for all accounts also covers accounts you add later.',
            children: [
              GroupedRow(
                title: 'All Accounts',
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
