/// Server rules for every account: installing Loupe's script, reading the
/// server's state, and the include proposal. Shared by the live and demo
/// repositories, which keep the rule list.
library;

import 'dart:async';
import 'dart:convert';

import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';

import 'include.dart';
import 'managesieve/session.dart';
import 'script.dart';

/// Checks a rule before it is saved; throws [MailException] with what to fix.
void validateRule(Rule rule, {DateTime? now}) {
  final parsed = parseQuery(rule.condition, now: now);
  if (!parsed.isValid) {
    throw MailException(MailErrorKind.unknown, 'The condition has an error: ${parsed.errors.first.message}');
  }
  if (rule.location == RuleLocation.device && rule.actions.any((a) => !a.runsOn(RuleLocation.device))) {
    throw const MailException(MailErrorKind.unsupported, 'Forwarding works only in server rules.');
  }
  if (rule.actions.isEmpty && !rule.stopProcessing) {
    throw const MailException(MailErrorKind.unknown, 'Choose what the rule does.');
  }
}

/// [rules] with [rule] in place of the one with its id (or added last).
List<Rule> withRule(List<Rule> rules, Rule rule) {
  final old = rules.where((r) => r.id == rule.id).firstOrNull;
  final last = rules.isEmpty ? -1 : rules.map((r) => r.order).reduce((a, b) => a > b ? a : b);
  return [
    for (final r in rules)
      if (r.id != rule.id) r,
    rule.copyWith(order: old?.order ?? last + 1),
  ]..sort((a, b) => a.order.compareTo(b.order));
}

/// Runs tasks one at a time.
final class _Lock {
  Future<void> _last = Future.value();

  Future<T> run<T>(Future<T> Function() task) {
    final result = _last.then((_) => task());
    _last = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }
}

/// Server rules through [connector]: one session per operation, one
/// operation per account at a time. The rule list lives with the caller,
/// which hands it in through the callbacks.
final class ServerRules {
  ServerRules({
    required this.connector,
    required this.accounts,
    required this.mailboxes,
    required this.rules,
    required this.importRules,
    required this.credentials,
    required this.now,
    required this.reportError,
  });

  final SieveConnector connector;
  final Future<List<MailAccount>> Function() accounts;
  final Future<List<Mailbox>> Function() mailboxes;

  /// Every rule, in order.
  final Future<List<Rule>> Function() rules;

  /// Adds rules found in Loupe's script that the caller doesn't have.
  final Future<void> Function(List<Rule> rules) importRules;
  final CredentialsCallback Function(MailAccount account) credentials;
  final DateTime Function() now;
  final void Function(MailException error) reportError;

  final _status = <String, ServerRulesStatus>{};
  final _locks = <String, _Lock>{};

  /// Accounts whose script is out of date because an upload failed.
  final _dirty = <String>{};

  _Lock _lock(String accountId) => _locks.putIfAbsent(accountId, _Lock.new);

  /// Accounts with a server script affected by [changed] rules.
  Future<List<MailAccount>> accountsOf(Iterable<Rule> changed) async {
    final server = changed.where((r) => r.location == RuleLocation.server).toList();
    if (server.isEmpty) return const [];
    return [
      for (final a in await accounts())
        if (server.any((r) => r.appliesTo(a.id))) a,
    ];
  }

  /// Installs [next] (the list with [rule] saved) on the servers [rule] and
  /// its previous version [old] concern. Throws if [rule] is a server rule
  /// that can't run on one of them, or a server refuses the script.
  Future<void> install(Rule rule, {Rule? old, required List<Rule> next}) async {
    for (final account in await accountsOf([?old, rule])) {
      final runsHere = rule.location == RuleLocation.server && rule.appliesTo(account.id);
      await _lock(account.id).run(() => _install(account, next, mustRun: runsHere ? rule.id : null));
    }
  }

  /// Re-uploads the scripts [changed] rules concern, after a change the user
  /// already sees (delete, reorder). Failures are reported and retried later.
  Future<void> reinstall(Iterable<Rule> changed) async {
    for (final account in await accountsOf(changed)) {
      try {
        await _lock(account.id).run(() async => _install(account, await rules()));
      } on MailException catch (e) {
        _dirty.add(account.id);
        reportError(
          MailException(e.kind, 'Couldn’t update the server rules of ${account.displayName}: ${e.message}', e),
        );
      }
    }
  }

  /// Retries a failed upload for [account], if there was one.
  Future<void> retry(MailAccount account) async {
    if (!_dirty.contains(account.id)) return;
    try {
      await _lock(account.id).run(() async => _install(account, await rules()));
    } on MailException {
      // Still out of date; reported when it first failed.
    }
  }

  Future<T> _session<T>(MailAccount account, Future<T> Function(SieveSession s) work) async {
    final SieveSession s;
    try {
      s = await connector.connect(account, credentials(account));
    } on MailException catch (e) {
      _status[account.id] = ServerRulesStatus(
        accountId: account.id,
        state: ServerRulesState.unavailable,
        message: e.message,
      );
      rethrow;
    }
    try {
      return await work(s);
    } finally {
      await s.logout();
    }
  }

  SieveTarget _target(MailAccount account, List<Mailbox> boxes, Set<String> extensions) =>
      SieveTarget(account: account, mailboxes: boxes, extensions: extensions, now: now());

  /// Regenerates and uploads Loupe's script for [account]: HAVESPACE,
  /// CHECKSCRIPT, PUTSCRIPT, and SETACTIVE when no script is active (never
  /// over somebody else's). With [mustRun], fails if that rule can't run.
  Future<void> _install(MailAccount account, List<Rule> list, {String? mustRun}) => _session(account, (s) async {
    final script = generateLoupeScript(list, _target(account, await mailboxes(), s.capabilities.extensions));
    final problems = mustRun == null ? null : script.problems[mustRun];
    if (problems != null) {
      throw MailException(MailErrorKind.unsupported, 'Can’t run on the server: ${problems.join('; ')}');
    }
    if (!await s.haveSpace(loupeScriptName, utf8.encode(script.text).length)) {
      throw MailException(
        MailErrorKind.server,
        '${account.displayName} has no room for Loupe’s rules on the server (its Sieve quota is full).',
      );
    }
    await _upload(s, loupeScriptName, script.text, 'The server didn’t accept the rules');
    var scripts = await s.listScripts();
    if (!scripts.any((x) => x.active)) {
      await s.setActive(loupeScriptName);
      scripts = await s.listScripts();
    }
    _status[account.id] = await _readStatus(account, s, scripts, import: false);
    _dirty.remove(account.id);
  });

  /// CHECKSCRIPT (on servers that have it), then PUTSCRIPT; the server's
  /// errors come back after [what].
  static Future<void> _upload(SieveSession s, String name, String text, String what) async {
    try {
      if (s.capabilities.version != null) await s.checkScript(text);
      await s.putScript(name, text);
    } on SieveException catch (e) {
      throw SieveException('$what:\n${e.message}', code: e.code);
    }
  }

  Future<ServerRulesStatus> _readStatus(
    MailAccount account,
    SieveSession s,
    List<SieveScriptInfo> scripts, {
    required bool import,
  }) async {
    final active = scripts.where((x) => x.active).firstOrNull?.name;
    if (import && scripts.any((x) => x.name == loupeScriptName)) {
      final found = parseLoupeScript(await s.getScript(loupeScriptName));
      if (found.isNotEmpty) await importRules(found);
    }
    var state = ServerRulesState.inactive;
    var viaInclude = false;
    if (active == loupeScriptName) {
      state = ServerRulesState.active;
    } else if (active != null && includesScript(await s.getScript(active))) {
      state = ServerRulesState.active;
      viaInclude = true;
    }
    return ServerRulesStatus(
      accountId: account.id,
      state: state,
      activeScript: active == loupeScriptName ? null : active,
      viaInclude: viaInclude,
      extensions: s.capabilities.extensions,
      otherScripts: [
        for (final x in scripts)
          if (x.name != loupeScriptName) x.name,
      ],
      implementation: s.capabilities.implementation,
    );
  }

  Future<MailAccount> _account(String accountId) async =>
      (await accounts()).where((a) => a.id == accountId).firstOrNull ??
      (throw const MailException(MailErrorKind.notFound, 'This account no longer exists'));

  /// See [MailRules.serverStatus]. A refresh also retries a failed upload
  /// and imports rules another device saved.
  Future<ServerRulesStatus> status(String accountId, {bool refresh = false}) async {
    final cached = _status[accountId];
    if (cached != null && !refresh) return cached;
    final account = await _account(accountId);
    return _lock(accountId).run(() async {
      if (_dirty.contains(accountId)) {
        try {
          await _install(account, await rules());
        } on MailException {
          // Reported when it first failed; the status says the rest.
        }
      }
      try {
        return _status[accountId] = await _session(
          account,
          (s) async => _readStatus(account, s, await s.listScripts(), import: true),
        );
      } on MailException catch (e) {
        return _status[accountId] = ServerRulesStatus(
          accountId: accountId,
          state: ServerRulesState.unavailable,
          message: e.message,
        );
      }
    });
  }

  /// See [MailRules.previewServerRule].
  Future<List<ServerRulePreview>> preview(Rule rule) async {
    final draft = rule.copyWith(location: RuleLocation.server);
    final next = withRule(await rules(), draft);
    final boxes = await mailboxes();
    // Each server answers on its own; a slow one doesn't hold up the rest.
    return Future.wait([
      for (final account in await accounts())
        if (draft.appliesTo(account.id)) _preview(account, draft, next, boxes),
    ]);
  }

  Future<ServerRulePreview> _preview(MailAccount account, Rule rule, List<Rule> list, List<Mailbox> boxes) async {
    final s = await status(account.id);
    if (s.state == ServerRulesState.unavailable) {
      return ServerRulePreview(
        accountId: account.id,
        problems: [s.message ?? '${account.displayName} has no server rules (ManageSieve).'],
      );
    }
    final script = generateLoupeScript(list, _target(account, boxes, s.extensions));
    final problems = script.problems[rule.id] ?? const <String>[];
    return ServerRulePreview(accountId: account.id, script: problems.isEmpty ? script.text : null, problems: problems);
  }

  /// See [MailRules.proposeInclude].
  Future<SieveIncludeProposal?> proposeInclude(String accountId) async {
    final account = await _account(accountId);
    return _lock(accountId).run(
      () => _session(account, (s) async {
        final active = (await s.listScripts()).where((x) => x.active).firstOrNull?.name;
        if (active == null || active == loupeScriptName) return null;
        final before = await s.getScript(active);
        final edit = planInclude(before);
        if (edit == null) return null;
        return SieveIncludeProposal(
          accountId: accountId,
          scriptName: active,
          before: before,
          after: edit.after,
          addedLines: edit.addedLines,
        );
      }),
    );
  }

  /// See [MailRules.applyInclude]: only if the script is still what the
  /// user saw. Loupe's script is uploaded first if the server lacks it.
  Future<void> applyInclude(SieveIncludeProposal proposal) async {
    final account = await _account(proposal.accountId);
    await _lock(account.id).run(
      () => _session(account, (s) async {
        if (!(await s.listScripts()).any((x) => x.name == loupeScriptName)) {
          final target = _target(account, await mailboxes(), s.capabilities.extensions);
          await _upload(
            s,
            loupeScriptName,
            generateLoupeScript(await rules(), target).text,
            'The server didn’t accept the rules',
          );
        }
        if (await s.getScript(proposal.scriptName) != proposal.before) {
          throw MailException(
            MailErrorKind.server,
            '“${proposal.scriptName}” changed on the server meanwhile. Look at the change again.',
          );
        }
        await _upload(s, proposal.scriptName, proposal.after, 'The server didn’t accept the change');
        _status[account.id] = await _readStatus(account, s, await s.listScripts(), import: false);
      }),
    );
  }
}
