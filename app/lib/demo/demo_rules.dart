import 'dart:async';

import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';

import 'demo_data.dart';

/// The active script the demo's Fastmail server starts with: filters made
/// elsewhere, as mailcow (SOGo) and Roundcube accounts often have. Loupe
/// never replaces it; it offers to include its own script instead.
const demoFiltersScript = '''
# Filters made in the webmail.
require ["fileinto", "vacation"];

if header :contains "subject" "[SPAM]" {
  fileinto "Spam";
  stop;
}
''';

/// Rules in demo mode, in memory. Device rules run on mail that arrives
/// with a refresh; server rules go to simulated ManageSieve servers.
///
/// - Personal (Gmail) and Work (Microsoft) have no server rules, as in life.
/// - Fastmail's server already runs [demoFiltersScript], so Loupe's script
///   is there but inactive until the user lets Loupe include it.
/// - Mail arriving in an account whose server runs Loupe's script is
///   filtered by the server rules first, as delivery would.
class DemoRules implements MailRules {
  DemoRules(
    this._repo, {
    required List<MailAccount> accounts,
    required List<Mailbox> mailboxes,
    DateTime Function()? clock,
    Duration latency = Duration.zero,
  }) : _clock = clock ?? DateTime.now,
       servers = SimulatedSieveServers(latency: latency) {
    _rules.addAll(_seedRules());
    servers.unavailable[DemoAccounts.personal] =
        'Gmail doesn’t offer server rules (ManageSieve). Rules for this account run on this device.';
    servers.unavailable[DemoAccounts.work] =
        'Microsoft doesn’t offer server rules (ManageSieve). Rules for this account run on this device.';
    final fastmail = accounts.where((a) => a.id == DemoAccounts.fastmail).firstOrNull;
    final server = servers[DemoAccounts.fastmail]
      ..scripts['filters'] = demoFiltersScript
      ..active = 'filters';
    if (fastmail != null) {
      server.scripts[loupeScriptName] = generateLoupeScript(
        _rules,
        SieveTarget(account: fastmail, mailboxes: mailboxes, extensions: server.extensions, now: _clock()),
      ).text;
    }
    _server = ServerRules(
      connector: servers,
      accounts: () => _repo.watchAccounts().first,
      mailboxes: () => _repo.watchMailboxes().first,
      rules: () async => [..._rules],
      importRules: _import,
      credentials: (_) =>
          ({bool forceRefresh = false}) async => const PasswordCredentials('demo'),
      now: _clock,
      reportError: (e) => _errors.add(e),
    );
  }

  final MailRepository _repo;
  final DateTime Function() _clock;

  /// The simulated servers, by account id (tests look inside).
  final SimulatedSieveServers servers;
  late final ServerRules _server;
  final _rules = <Rule>[];
  final _changes = StreamController<void>.broadcast();
  final _errors = StreamController<MailException>.broadcast();

  /// Failures of server updates the user didn't wait for.
  Stream<MailException> get errors => _errors.stream;

  void dispose() {
    unawaited(_changes.close());
    unawaited(_errors.close());
  }

  static List<Rule> _seedRules() => [
    Rule(
      id: 'demo-tracker',
      name: 'Issue tracker',
      condition: 'from:issues.northwind.example',
      actions: const [AddTagAction(Keywords.label2)],
      accountIds: const {DemoAccounts.work},
    ),
    Rule(
      id: 'demo-receipts',
      name: 'Receipts',
      condition: 'from:harborcoffee.example or from:cornerbookshop.example or from:namewell.example',
      actions: [MoveToMailboxAction(MailIds.mailbox(DemoAccounts.personal, 'Receipts'))],
      accountIds: const {DemoAccounts.personal},
      order: 1,
    ),
    Rule(
      id: 'demo-open-garden',
      name: 'Open Garden list',
      condition: 's:[open-garden]',
      actions: [MoveToMailboxAction(MailIds.mailbox(DemoAccounts.fastmail, 'Lists/Open Garden'))],
      accountIds: const {DemoAccounts.fastmail},
      location: RuleLocation.server,
      stopProcessing: true,
      order: 2,
    ),
  ];

  void _notify() {
    if (!_changes.isClosed) _changes.add(null);
  }

  Future<void> _import(List<Rule> found) async {
    final known = {for (final r in _rules) r.id};
    var order = _rules.isEmpty ? 0 : _rules.last.order + 1;
    for (final r in found) {
      if (known.add(r.id)) _rules.add(r.copyWith(order: order++));
    }
    _notify();
  }

  // The list --------------------------------------------------------------------------

  @override
  Stream<List<Rule>> watchRules() => Stream<List<Rule>>.multi((c) {
    c.add(List.unmodifiable(_rules));
    final sub = _changes.stream.listen((_) => c.add(List.unmodifiable(_rules)));
    // Not returning the future: `.first` would wait for it under fake time.
    c.onCancel = () {
      unawaited(sub.cancel());
    };
  }, isBroadcast: true);

  @override
  Future<void> saveRule(Rule rule) async {
    validateRule(rule, now: _clock());
    final old = _rules.where((r) => r.id == rule.id).firstOrNull;
    final next = withRule(_rules, rule);
    await _server.install(rule, old: old, next: next);
    _rules
      ..clear()
      ..addAll(next);
    _notify();
  }

  @override
  Future<void> deleteRule(String ruleId) async {
    final old = _rules.where((r) => r.id == ruleId).firstOrNull;
    if (old == null) return;
    _rules.remove(old);
    _notify();
    await _server.reinstall([old]);
  }

  @override
  Future<void> reorderRules(List<String> ruleIds) async {
    final byId = {for (final r in _rules) r.id: r};
    final ordered = [for (final id in ruleIds) ?byId.remove(id), ...byId.values];
    _rules
      ..clear()
      ..addAll([for (final (i, r) in ordered.indexed) r.copyWith(order: i)]);
    _notify();
    await _server.reinstall(_rules);
  }

  // Existing messages -----------------------------------------------------------------

  @override
  Future<List<EmailSummary>> findMatches(Rule rule, SearchScope scope, {int limit = 500}) =>
      findRuleMatches(_repo, rule, scope, limit: limit, now: _clock());

  @override
  Future<int> applyRule(Rule rule, List<String> emailIds) => applyRuleTo(_repo, rule, emailIds);

  // Server rules ----------------------------------------------------------------------

  @override
  Future<ServerRulesStatus> serverStatus(String accountId, {bool refresh = false}) =>
      _server.status(accountId, refresh: refresh);

  @override
  Future<List<ServerRulePreview>> previewServerRule(Rule rule) => _server.preview(rule);

  @override
  Future<SieveIncludeProposal?> proposeInclude(String accountId) => _server.proposeInclude(accountId);

  @override
  Future<void> applyInclude(SieveIncludeProposal proposal) => _server.applyInclude(proposal);

  // New mail --------------------------------------------------------------------------

  /// Runs the rules on mail that just arrived: the server rules of accounts
  /// whose server runs Loupe's script first (as delivery would), then the
  /// device rules.
  Future<void> runOnArrivals(List<EmailSummary> arrived) async {
    if (arrived.isEmpty || _rules.isEmpty) return;
    final accounts = await _repo.watchAccounts().first;
    final serving = <String>{};
    for (final a in accounts) {
      if (!_rules.any((r) => r.location == RuleLocation.server && r.appliesTo(a.id))) continue;
      if ((await _server.status(a.id)).state == ServerRulesState.active) serving.add(a.id);
    }
    final rules = [
      for (final r in _rules)
        if (r.location == RuleLocation.device)
          r
        else if (serving.any(r.appliesTo))
          r.copyWith(
            location: RuleLocation.device,
            order: r.order - 1000000,
            accountIds: r.accountIds.isEmpty ? serving : r.accountIds.intersection(serving),
            actions: [
              for (final a in r.actions)
                if (a.runsOn(RuleLocation.device)) a,
            ],
          ),
    ];
    final runner = RuleRunner(rules, mailboxes: await _repo.watchMailboxes().first, now: _clock());
    if (runner.isEmpty) return;
    final labels = {for (final a in accounts) a.id: '${a.displayName} ${a.email}'};
    final outcomes = <(EmailSummary, RuleOutcome)>[];
    for (final e in arrived) {
      final out = await runner.run(
        e,
        accountLabel: labels[e.accountId] ?? '',
        loadContent: () => _repo.loadContent(e.id),
      );
      outcomes.add((e, out));
    }
    await applyOutcomes(_repo, outcomes);
  }
}
