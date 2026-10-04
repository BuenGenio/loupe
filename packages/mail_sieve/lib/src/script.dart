/// Loupe's own Sieve script: generated from the server rules of one account,
/// and read back to show those rules.
library;

import 'dart:convert';

import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';

import 'compile.dart';
import 'sieve_text.dart';

/// The name of the script Loupe owns on every server.
const loupeScriptName = 'loupe';

const _scriptMarker = '# loupe-script: 1';
const _ruleMarker = '# loupe-rule:';

/// What generating Loupe's script for one account needs to know.
final class SieveTarget {
  const SieveTarget({
    required this.account,
    this.mailboxes = const [],
    this.extensions,
    this.now,
    this.tags = TagDefinition.thunderbirdDefaults,
  });

  final MailAccount account;

  /// Mailboxes of every account: a rule for several accounts files into the
  /// folder with the same path in each.
  final List<Mailbox> mailboxes;

  /// The server's Sieve extensions; null assumes [loupeSieveExtensions].
  final Set<String>? extensions;

  /// Anchors dates in conditions (default: now).
  final DateTime? now;
  final List<TagDefinition> tags;

  String get accountLabel => '${account.displayName} ${account.email}';

  bool has(String extension) => extensions == null || extensions!.contains(extension);
}

/// One rule as Sieve for one account.
final class CompiledRule {
  const CompiledRule({required this.rule, required this.code, required this.requires, required this.problems});

  final Rule rule;

  /// The statement (`if … { … }`), or '' when the rule can't run here, is
  /// off, or can't match in this account.
  final String code;
  final Set<String> requires;

  /// Why the rule can't run on this server (empty when it can).
  final List<String> problems;
}

/// Compiles [rule] for [target]'s server: the condition with
/// [compileSieve] (account terms resolved for this account, dates relative
/// to today reported) and the actions as `addflag`, `fileinto`, `keep`,
/// `redirect` and `stop`.
CompiledRule compileRule(Rule rule, SieveTarget target) {
  final problems = <String>[];
  final requires = <String>{};
  final now = target.now ?? DateTime.now();
  final parsed = parseQuery(rule.condition, now: now, tags: target.tags);
  if (!parsed.isValid) problems.add('the condition has an error: ${parsed.errors.first.message}');
  // Terms that parse differently on another day are relative to today.
  final later = parseQuery(rule.condition, now: now.add(const Duration(days: 400)), tags: target.tags).expr;
  final relative = _differingDates(parsed.expr, later);
  final expr = bindAccountTerms(parsed.expr, target.accountLabel);
  final matchesHere = !matchesNothing(expr);
  String? test;
  if (matchesHere) {
    final compiled = compileSieve(
      expr,
      extensions: target.extensions,
      isRelativeDate: relative.contains,
      tags: target.tags,
    );
    problems.addAll(compiled.problems.map((p) => p.message));
    requires.addAll(compiled.requires);
    test = compiled.test;
  }
  final body = _actions(rule, target, requires, problems);
  if (!rule.actions.any((a) => a.runsOn(RuleLocation.server)) && !rule.stopProcessing) {
    problems.add('the rule has no actions');
  }
  if (problems.isNotEmpty || !rule.enabled || !matchesHere || test == null) {
    return CompiledRule(rule: rule, code: '', requires: const {}, problems: problems);
  }
  final block = body.map((l) => '  $l').join('\n');
  final code = test == 'true' ? body.join('\n') : 'if $test {\n$block\n}';
  return CompiledRule(rule: rule, code: code, requires: requires, problems: const []);
}

List<String> _actions(Rule rule, SieveTarget t, Set<String> requires, List<String> problems) {
  final flags = <String>[];
  final delivery = <String>[];
  bool need(String ext, String why) {
    if (t.has(ext)) {
      requires.add(ext);
      return true;
    }
    problems.add(why);
    return false;
  }

  const noFileinto = 'the server can’t file messages into folders (no fileinto extension)';
  const noFlags = 'the server can’t set flags or tags (no imap4flags extension)';
  final junk = rule.actions.any((a) => a is MarkJunkAction);
  var moved = false;
  for (final a in rule.actions) {
    switch (a) {
      case MoveToMailboxAction(:final mailboxId):
        // The first move wins (as on the device); junk replaces moves.
        if (junk || moved) continue;
        moved = true;
        final path = _pathFor(mailboxId, t, problems);
        if (path == null || !need('fileinto', noFileinto)) continue;
        var create = '';
        if (t.has('mailbox')) {
          requires.add('mailbox');
          create = ':create ';
        }
        delivery.add('fileinto $create${sieveString(path)};');
      case AddTagAction(:final keyword):
        if (need('imap4flags', noFlags)) flags.add('addflag ${sieveString(sieveFlag(keyword))};');
      case RemoveTagAction(:final keyword):
        if (need('imap4flags', noFlags)) flags.add('removeflag ${sieveString(sieveFlag(keyword))};');
      case FlagAction():
        if (need('imap4flags', noFlags)) flags.add(r'addflag "\\Flagged";');
      case MarkReadAction():
        if (need('imap4flags', noFlags)) flags.add(r'addflag "\\Seen";');
      case MarkJunkAction():
        if (need('imap4flags', noFlags)) flags.add(r'addflag "$Junk";');
        final box = t.mailboxes.where((m) => m.accountId == t.account.id && m.role == MailboxRole.junk).firstOrNull;
        if (box != null && need('fileinto', noFileinto)) delivery.add('fileinto ${sieveString(box.path)};');
      case KeepInInboxAction():
        delivery.add('keep;');
      case ForwardAction(:final address, :final keepCopy):
        final to = address.trim();
        if (!_address.hasMatch(to)) {
          problems.add('“$address” isn’t an email address to forward to');
          continue;
        }
        if (keepCopy && t.has('copy')) {
          requires.add('copy');
          delivery.add('redirect :copy ${sieveString(to)};');
        } else {
          delivery.add('redirect ${sieveString(to)};');
          if (keepCopy) delivery.add('keep;');
        }
    }
  }
  if (rule.stops) delivery.add('stop;');
  return [...flags, ...delivery];
}

final _address = RegExp(r'^[^\s@<>"(),;:]+@[^\s@<>"(),;:]+\.[^\s@<>"(),;:]+$');

/// The path to file into for [mailboxId] in [t]'s account: the mailbox's
/// own path, or the same path in this account for another account's folder.
String? _pathFor(String mailboxId, SieveTarget t, List<String> problems) {
  final box = t.mailboxes.where((m) => m.id == mailboxId).firstOrNull;
  String path;
  if (box != null) {
    path = box.path;
  } else {
    try {
      path = MailIds.parseMailbox(mailboxId).$2;
    } on FormatException {
      problems.add('the folder to move to no longer exists');
      return null;
    }
  }
  final owner = box?.accountId ?? MailIds.accountOf(mailboxId);
  if (owner == t.account.id) return path;
  final here = t.mailboxes.where((m) => m.accountId == t.account.id && m.path == path).firstOrNull;
  if (here != null || t.has('mailbox')) return path;
  problems.add('${t.account.displayName} has no folder “$path”');
  return null;
}

/// The date terms of [a] whose value differs in [b] (the same query parsed
/// on another day), by identity. Every date term if the shapes differ.
Set<DateTerm> _differingDates(SearchExpr a, SearchExpr b) {
  final out = Set<DateTerm>.identity();
  var sameShape = true;
  void walk(SearchExpr x, SearchExpr? y) {
    switch (x) {
      case SearchAnd(:final children) || SearchOr(:final children):
        final other = switch (y) {
          SearchAnd(:final children) || SearchOr(:final children) => children,
          _ => const <SearchExpr>[],
        };
        if (other.length != children.length) sameShape = false;
        for (var i = 0; i < children.length; i++) {
          walk(children[i], i < other.length ? other[i] : null);
        }
      case SearchNot(:final child):
        walk(child, y is SearchNot ? y.child : null);
      case DateTerm():
        if (y is! DateTerm) sameShape = false;
        if (x != y) out.add(x);
      default:
        if (x != y) sameShape = false;
    }
  }

  walk(a, b);
  if (!sameShape) {
    void all(SearchExpr x) {
      switch (x) {
        case SearchAnd(:final children) || SearchOr(:final children):
          children.forEach(all);
        case SearchNot(:final child):
          all(child);
        case DateTerm():
          out.add(x);
        default:
      }
    }

    all(a);
  }
  return out;
}

/// Loupe's script for one account.
final class LoupeScript {
  const LoupeScript({required this.text, required this.requires, required this.problems});

  final String text;
  final Set<String> requires;

  /// Rules left out because they can't run on this server, by rule id.
  final Map<String, List<String>> problems;
}

/// Generates Loupe's script for [target]'s account from [rules] (the server
/// rules that apply to it run, in order; the rest are skipped).
///
/// Every rule, also one that is off or can't run here, is kept as a
/// `# loupe-rule:` comment with its JSON, so [parseLoupeScript] gets the
/// rules back exactly.
LoupeScript generateLoupeScript(List<Rule> rules, SieveTarget target) {
  final mine = [
    for (final r in rules)
      if (r.location == RuleLocation.server && r.appliesTo(target.account.id)) r,
  ]..sort((a, b) => a.order.compareTo(b.order));
  final compiled = [for (final r in mine) compileRule(r, target)];
  final requires = {for (final c in compiled) ...c.requires};
  final out = StringBuffer()
    ..writeln('# Loupe rules for ${_oneLine(target.account.email)}. Generated by Loupe, which replaces')
    ..writeln('# this script whenever the rules change: edit them in Loupe, not here.')
    ..writeln(_scriptMarker);
  final require = sieveRequire(requires);
  if (require.isNotEmpty) out.writeln(require);
  for (final c in compiled) {
    final r = c.rule;
    final state = c.problems.isNotEmpty
        ? ' (not on this server: ${_oneLine(c.problems.join('; '))})'
        : !r.enabled
        ? ' (off)'
        : c.code.isEmpty
        ? ' (not for this account)'
        : '';
    final json = r.toJson()
      ..remove('order')
      ..remove('location');
    out
      ..writeln()
      ..writeln('# Rule: ${_oneLine(r.name)}$state')
      ..writeln('$_ruleMarker ${jsonEncode(json)}');
    if (c.code.isNotEmpty) out.writeln(c.code);
  }
  return LoupeScript(
    text: out.toString(),
    requires: requires,
    problems: {
      for (final c in compiled)
        if (c.problems.isNotEmpty) c.rule.id: c.problems,
    },
  );
}

String _oneLine(String s) => s.replaceAll(RegExp(r'[\r\n\t\u0000-\u001f]+'), ' ').trim();

/// Whether [script] is one Loupe generated.
bool isLoupeScript(String script) => script.contains(_scriptMarker);

/// The rules saved in a script Loupe generated, in order, as server rules;
/// empty for anybody else's script (those are never edited).
List<Rule> parseLoupeScript(String script) {
  if (!isLoupeScript(script)) return const [];
  final rules = <Rule>[];
  for (final line in const LineSplitter().convert(script)) {
    final t = line.trimLeft();
    if (!t.startsWith(_ruleMarker)) continue;
    try {
      final json = jsonDecode(t.substring(_ruleMarker.length).trim());
      if (json is! Map || json['id'] is! String) continue;
      rules.add(Rule.fromJson(json.cast()).copyWith(location: RuleLocation.server, order: rules.length));
    } on FormatException {
      // A damaged line; the others still count.
    }
  }
  return rules;
}
