/// Running rules on the device: deciding what rules do to a message, and
/// doing it through the repository's normal actions.
library;

import 'dart:async';

import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';

/// What the rules decided for one message.
final class RuleOutcome {
  /// Keywords to add and to remove (lower-cased).
  final add = <String>{};
  final remove = <String>{};

  /// The mailbox to move to (the first move wins).
  String? moveTo;

  /// Mark as junk (moves to Junk; replaces a move).
  bool junk = false;

  /// Ids of the rules that matched, in order.
  final matched = <String>[];

  bool get hasActions => add.isNotEmpty || remove.isNotEmpty || moveTo != null || junk;

  /// A key for batching messages that get the same treatment.
  String get key => '${[...add]..sort()}|${[...remove]..sort()}|$moveTo|$junk';
}

/// True, false, or null when [expr] can't be decided for [email] without
/// more data (the body, attachments, headers): never act on a guess.
bool? decideMatch(SearchExpr expr, EmailSummary email, {EmailContent? content, String? accountLabel}) {
  // matchesEmail counts "unknown" as a match; so does its negation.
  final yes = matchesEmail(expr, email, content: content, accountLabel: accountLabel);
  final no = matchesEmail(SearchNot(expr), email, content: content, accountLabel: accountLabel);
  return yes == no ? null : yes;
}

/// Device rules, ready to run: conditions parsed once, in rule order.
/// Rules that are off, server rules and rules whose condition has errors
/// don't run.
final class RuleRunner {
  RuleRunner(
    List<Rule> rules, {
    this.mailboxes = const [],
    DateTime? now,
    List<TagDefinition> tags = TagDefinition.thunderbirdDefaults,
  }) : _rules = [
         for (final r in [...rules]..sort((a, b) => a.order.compareTo(b.order)))
           if (r.enabled && r.location == RuleLocation.device)
             if (parseQuery(r.condition, now: now, tags: tags) case final p when p.isValid) (r, p.expr),
       ];

  /// Every account's mailboxes, to find "the same folder" in another account.
  final List<Mailbox> mailboxes;
  final List<(Rule, SearchExpr)> _rules;

  bool get isEmpty => _rules.isEmpty;

  /// Runs the rules of [email]'s account on it. [loadContent] is called at
  /// most once, and only when a condition can't be decided from the
  /// summary. Later rules see the tags and flags earlier ones set.
  Future<RuleOutcome> run(
    EmailSummary email, {
    required String accountLabel,
    required Future<EmailContent?> Function() loadContent,
  }) async {
    final out = RuleOutcome();
    var current = email;
    EmailContent? content;
    var loaded = false;
    for (final (rule, condition) in _rules) {
      if (!rule.appliesTo(email.accountId)) continue;
      final expr = bindAccountTerms(condition, accountLabel);
      var verdict = decideMatch(expr, current, content: content, accountLabel: accountLabel);
      if (verdict == null && !loaded) {
        loaded = true;
        content = await loadContent();
        verdict = decideMatch(expr, current, content: content, accountLabel: accountLabel);
      }
      if (verdict != true) continue;
      out.matched.add(rule.id);
      addActions(rule, current, out);
      current = current.copyWith(keywords: {...current.keywords.difference(out.remove), ...out.add});
      if (rule.stops) break;
    }
    return out;
  }

  /// Adds what [rule]'s actions do to [email] to [out] (forwarding is left
  /// to servers).
  void addActions(Rule rule, EmailSummary email, RuleOutcome out) {
    void tag(String keyword, {required bool on}) {
      final k = Keywords.normalize(keyword);
      (on ? out.add : out.remove).add(k);
      (on ? out.remove : out.add).remove(k);
    }

    for (final a in rule.actions) {
      switch (a) {
        case MoveToMailboxAction(:final mailboxId):
          if (out.moveTo == null && !out.junk) out.moveTo = mailboxFor(mailboxId, email.accountId);
        case AddTagAction(:final keyword):
          tag(keyword, on: true);
        case RemoveTagAction(:final keyword):
          tag(keyword, on: false);
        case FlagAction():
          tag(Keywords.flagged, on: true);
        case MarkReadAction():
          tag(Keywords.seen, on: true);
        case MarkJunkAction():
          out
            ..junk = true
            ..moveTo = null;
        case KeepInInboxAction():
          out
            ..junk = false
            ..moveTo = null;
        case ForwardAction():
      }
    }
  }

  /// [mailboxId] if it belongs to [accountId], else the mailbox with the
  /// same path there (null if there is none).
  String? mailboxFor(String mailboxId, String accountId) {
    final target = mailboxes.where((m) => m.id == mailboxId).firstOrNull;
    final owner = target?.accountId ?? MailIds.accountOf(mailboxId);
    if (owner == accountId) return mailboxId;
    if (target == null) return null;
    return mailboxes.where((m) => m.accountId == accountId && m.path == target.path).firstOrNull?.id;
  }
}

/// Carries out [outcomes] through [repository]'s actions (optimistic, and
/// queued for the server in live mode), batching messages that get the same
/// treatment. Returns how many messages changed.
Future<int> applyOutcomes(MailRepository repository, List<(EmailSummary, RuleOutcome)> outcomes) async {
  final groups = <String, List<(EmailSummary, RuleOutcome)>>{};
  for (final o in outcomes) {
    if (o.$2.hasActions) groups.putIfAbsent(o.$2.key, () => []).add(o);
  }
  var changed = 0;
  for (final group in groups.values) {
    final out = group.first.$2;
    final ids = [for (final (e, _) in group) e.id];
    if (out.add.isNotEmpty || out.remove.isNotEmpty) {
      await repository.setKeywords(ids, add: out.add, remove: out.remove);
    }
    if (out.junk) {
      await repository.markJunk(ids, junk: true);
    } else if (out.moveTo case final target?) {
      final moving = [
        for (final (e, _) in group)
          if (e.mailboxId != target) e.id,
      ];
      if (moving.isNotEmpty) await repository.move(moving, target);
    }
    changed += ids.length;
  }
  return changed;
}

/// The messages in [scope] that [rule]'s condition matches, exactly: the
/// repository's search (local and server) gives candidates, and each is
/// checked, loading its content when the condition needs it. Only the
/// rule's accounts count.
Future<List<EmailSummary>> findRuleMatches(
  MailRepository repository,
  Rule rule,
  SearchScope scope, {
  int limit = 500,
  DateTime? now,
  List<TagDefinition> tags = TagDefinition.thunderbirdDefaults,
}) async {
  final parsed = parseQuery(rule.condition, now: now, tags: tags);
  if (!parsed.isValid) {
    throw MailException(MailErrorKind.unknown, 'The condition has an error: ${parsed.errors.first.message}');
  }
  final accounts = await repository.watchAccounts().first;
  final labels = {for (final a in accounts) a.id: '${a.displayName} ${a.email}'};
  final request = SearchRequest(expr: parsed.expr, scope: scope, text: rule.condition, limit: limit);
  final results = await _complete(repository.search(request));
  final out = <EmailSummary>[];
  for (final e in results?.items ?? const <EmailSummary>[]) {
    if (!rule.appliesTo(e.accountId)) continue;
    final label = labels[e.accountId] ?? '';
    final expr = bindAccountTerms(parsed.expr, label);
    var verdict = decideMatch(expr, e, accountLabel: label);
    if (verdict == null) {
      try {
        verdict = decideMatch(expr, e, content: await repository.loadContent(e.id), accountLabel: label);
      } on MailException {
        verdict = null;
      }
    }
    if (verdict == true) out.add(e);
  }
  return out;
}

/// The first complete emission of a search (or the last one, if the stream
/// ends first). The subscription is cancelled without waiting for it.
Future<SearchResults?> _complete(Stream<SearchResults> stream) {
  final done = Completer<SearchResults?>();
  SearchResults? last;
  late final StreamSubscription<SearchResults> sub;
  sub = stream.listen(
    (r) {
      last = r;
      if (r.isComplete && !done.isCompleted) {
        done.complete(r);
        unawaited(sub.cancel());
      }
    },
    onError: (Object e, StackTrace st) {
      if (!done.isCompleted) done.completeError(e, st);
    },
    onDone: () {
      if (!done.isCompleted) done.complete(last);
    },
  );
  return done.future;
}

/// Runs [rule]'s actions on [emailIds] (no condition check: the user picked
/// them). Returns how many messages changed.
Future<int> applyRuleTo(MailRepository repository, Rule rule, List<String> emailIds) async {
  final runner = RuleRunner(const [], mailboxes: await repository.watchMailboxes().first);
  final outcomes = <(EmailSummary, RuleOutcome)>[];
  for (final id in emailIds) {
    final e = await repository.getEmail(id);
    if (e == null || !rule.appliesTo(e.accountId)) continue;
    final out = RuleOutcome();
    runner.addActions(rule, e, out);
    outcomes.add((e, out));
  }
  return applyOutcomes(repository, outcomes);
}
