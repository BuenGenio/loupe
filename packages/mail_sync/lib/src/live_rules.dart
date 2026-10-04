import 'dart:async';

import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';
import 'package:mail_store/mail_store.dart';

import 'util.dart';

/// What [LiveRules] needs from the repository that owns it.
abstract interface class RulesHost {
  MailStore get store;

  /// The repository's own actions (optimistic, offline queue).
  MailRepository get repository;
  DateTime now();
  CredentialsCallback credentialsFor(MailAccount account);
  void reportError(MailException error);
}

/// The live [MailRules]: rules in the store, device rules run on new Inbox
/// mail after each sync, server rules installed with ManageSieve.
final class LiveRules implements MailRules {
  LiveRules(this._host, SieveConnector sieve) {
    _server = ServerRules(
      connector: sieve,
      accounts: _store.getAccounts,
      mailboxes: () => _store.getMailboxes(),
      rules: _store.getRules,
      importRules: _import,
      credentials: _host.credentialsFor,
      now: _host.now,
      reportError: _host.reportError,
    );
  }

  final RulesHost _host;
  late final ServerRules _server;
  final _queues = <String, SerialQueue>{};

  MailStore get _store => _host.store;

  Future<void> _import(List<Rule> fromServer) async {
    final known = {for (final r in await _store.getRules()) r.id};
    for (final r in fromServer) {
      if (!known.contains(r.id)) await _store.saveRule(r);
    }
  }

  // The list --------------------------------------------------------------------------

  @override
  Stream<List<Rule>> watchRules() => _store.watchRules();

  @override
  Future<void> saveRule(Rule rule) async {
    validateRule(rule, now: _host.now());
    final rules = await _store.getRules();
    final old = rules.where((r) => r.id == rule.id).firstOrNull;
    await _server.install(rule, old: old, next: withRule(rules, rule));
    await _store.saveRule(rule);
  }

  @override
  Future<void> deleteRule(String ruleId) async {
    final old = (await _store.getRules()).where((r) => r.id == ruleId).firstOrNull;
    await _store.deleteRule(ruleId);
    if (old != null) await _server.reinstall([old]);
  }

  @override
  Future<void> reorderRules(List<String> ruleIds) async {
    await _store.reorderRules(ruleIds);
    await _server.reinstall(await _store.getRules());
  }

  // Existing messages -----------------------------------------------------------------

  @override
  Future<List<EmailSummary>> findMatches(Rule rule, SearchScope scope, {int limit = 500}) =>
      findRuleMatches(_host.repository, rule, scope, limit: limit, now: _host.now());

  @override
  Future<int> applyRule(Rule rule, List<String> emailIds) => applyRuleTo(_host.repository, rule, emailIds);

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

  /// Runs device rules on the messages that arrived in [inboxId] since the
  /// last run (its watermark), oldest first, and moves the watermark past
  /// them before acting, so no message is handled twice. The first run only
  /// sets the watermark: mail that was there before isn't new. Also retries
  /// a server-script upload that failed.
  Future<void> inboxSynced(MailAccount account, String inboxId) =>
      _queues.putIfAbsent(account.id, SerialQueue.new).run(() async {
        await _server.retry(account);
        final mark = await _store.ruleWatermark(inboxId);
        final stored = await _store.emailsStoredAfter(inboxId, mark?.seq ?? 0);
        final next = _advance(mark, stored);
        if (mark == null || stored.isEmpty) {
          if (next != mark) await _store.setRuleWatermark(inboxId, next);
          return;
        }
        final fresh = [
          for (final (_, e) in stored)
            if (_isNew(e, mark)) e,
        ]..sort((a, b) => _uid(a).compareTo(_uid(b)));
        final runner = RuleRunner(await _store.getRules(), mailboxes: await _store.getMailboxes(), now: _host.now());
        if (fresh.isEmpty || runner.isEmpty) {
          await _store.setRuleWatermark(inboxId, next);
          return;
        }
        final label = '${account.displayName} ${account.email}';
        final outcomes = <(EmailSummary, RuleOutcome)>[];
        for (final e in fresh) {
          Future<EmailContent?> load() async {
            try {
              return await _host.repository.loadContent(e.id);
            } on MailException {
              return null;
            }
          }

          outcomes.add((e, await runner.run(e, accountLabel: label, loadContent: load)));
        }
        // At most once: the watermark moves before anything is done.
        await _store.setRuleWatermark(inboxId, next);
        await applyOutcomes(_host.repository, outcomes);
      });

  static int _uid(EmailSummary e) => MailIds.parseImapEmail(e.id)?.uid ?? 0;

  /// New mail: an IMAP id above the watermark's UID under the same
  /// UIDVALIDITY (a reset mailbox brings renumbered old mail, not new mail).
  /// Other ids count by insertion order alone. A message back from snooze
  /// (marked `$new`) isn't new mail.
  static bool _isNew(EmailSummary e, RuleWatermark mark) {
    if (e.keywords.contains(Keywords.newAgain)) return false;
    final p = MailIds.parseImapEmail(e.id);
    if (p == null) return true;
    if (mark.uidValidity != null && p.uidValidity != mark.uidValidity) return false;
    return p.uid > (mark.uid ?? 0);
  }

  /// The watermark after [stored]: the last seq, and the highest UID under
  /// the newest UIDVALIDITY.
  static RuleWatermark _advance(RuleWatermark? mark, List<(int, EmailSummary)> stored) {
    var seq = mark?.seq ?? 0;
    var validity = mark?.uidValidity;
    var uid = mark?.uid;
    for (final (s, e) in stored) {
      if (s > seq) seq = s;
      final p = MailIds.parseImapEmail(e.id);
      if (p == null) continue;
      if (validity == p.uidValidity) {
        if (uid == null || p.uid > uid) uid = p.uid;
      } else if (validity == null || p.uidValidity > validity) {
        validity = p.uidValidity;
        uid = p.uid;
      }
    }
    return RuleWatermark(seq: seq, uidValidity: validity, uid: uid);
  }
}
