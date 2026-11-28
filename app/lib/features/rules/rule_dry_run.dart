import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';

/// What a draft rule would match in the mail already on this phone. Decided
/// by mail_sieve's [RuleRunner], the code that runs saved device rules on new
/// mail, with the same account label and content loading: the count is the
/// rule's own verdict, not an estimate. Nothing is changed.
final class RuleDryRun {
  const RuleDryRun({
    required this.checked,
    required this.matched,
    required this.matches,
    required this.misses,
    required this.unchecked,
    required this.capped,
  });

  /// Messages looked at: the account's downloaded mail outside Sent,
  /// Drafts, Junk, Trash and All Mail (rules never see those as new mail),
  /// newest first.
  final int checked;

  /// How many of them the rule matches.
  final int matched;

  /// The newest few matches.
  final List<EmailSummary> matches;

  /// A few it doesn't match, near misses first: messages that meet part of
  /// the condition (the sender, but not the subject word).
  final List<EmailSummary> misses;

  /// Messages the condition couldn't be decided for without their text,
  /// beyond what a dry run loads; they count as not matching.
  final int unchecked;

  /// The account has more downloaded mail than was checked.
  final bool capped;
}

const _notIncoming = {MailboxRole.sent, MailboxRole.drafts, MailboxRole.junk, MailboxRole.trash, MailboxRole.all};

/// Runs [rule] as a device rule of [accountId] over that account's
/// downloaded mail, without acting on anything: no server search, at most
/// [limit] messages and [contentLoads] message texts.
Future<RuleDryRun> dryRunRule(
  MailRepository repository,
  Rule rule, {
  required String accountId,
  DateTime? now,
  int limit = 2000,
  int contentLoads = 120,
  int examples = 3,
}) async {
  final accounts = await repository.watchAccounts().first;
  final account = accounts.where((a) => a.id == accountId).firstOrNull;
  // The label device rules use for account: terms.
  final label = account == null ? '' : '${account.displayName} ${account.email}';
  final mailboxes = await repository.watchMailboxes().first;

  final seen = <String>{};
  final mail = <EmailSummary>[];
  var capped = false;
  for (final box in mailboxes) {
    if (box.accountId != accountId || !box.isSelectable || _notIncoming.contains(box.role)) continue;
    final request = SearchRequest(
      expr: const MatchAll(),
      scope: MailboxScope(RealMailboxRef(box.id)),
      includeServer: false,
      limit: limit,
    );
    final results = await repository.search(request).firstWhere((r) => r.isComplete);
    if (results.items.length >= limit) capped = true;
    for (final e in results.items) {
      if (seen.add(e.id)) mail.add(e);
    }
  }
  mail.sort((a, b) => b.receivedAt.compareTo(a.receivedAt));
  if (mail.length > limit) {
    capped = true;
    mail.removeRange(limit, mail.length);
  }

  final draft = rule.copyWith(location: RuleLocation.device, enabled: true, accountIds: {accountId});
  final runner = RuleRunner([draft], mailboxes: mailboxes, now: now);
  var loads = 0;
  var unchecked = 0;
  Future<bool> decide(EmailSummary e) async {
    var undecided = false;
    final out = await runner.run(
      e,
      accountLabel: label,
      loadContent: () async {
        if (loads >= contentLoads) {
          undecided = true;
          return null;
        }
        loads++;
        try {
          return await repository.loadContent(e.id);
        } on MailException {
          undecided = true;
          return null;
        }
      },
    );
    final hit = out.matched.contains(draft.id);
    if (undecided && !hit) unchecked++;
    return hit;
  }

  final verdicts = <bool>[];
  // A few at a time: loading texts may wait on the network.
  for (var i = 0; i < mail.length; i += 8) {
    verdicts.addAll(await Future.wait([for (final e in mail.skip(i).take(8)) decide(e)]));
  }
  final matches = [
    for (final (i, e) in mail.indexed)
      if (verdicts[i]) e,
  ];
  final others = [
    for (final (i, e) in mail.indexed)
      if (!verdicts[i]) e,
  ];

  // Near misses meet one of the condition's AND-ed terms, from what the
  // summary says.
  final parsed = parseQuery(draft.condition, now: now);
  final parts = switch (bindAccountTerms(parsed.expr, label)) {
    SearchAnd(:final children) => children,
    _ => const <SearchExpr>[],
  };
  bool near(EmailSummary e) => parts.any((p) => decideMatch(p, e, accountLabel: label) == true);
  final misses = others.where(near).take(examples).toList();
  for (final e in others) {
    if (misses.length >= examples) break;
    if (!misses.contains(e)) misses.add(e);
  }

  return RuleDryRun(
    checked: mail.length,
    matched: matches.length,
    matches: matches.take(examples).toList(),
    misses: misses,
    unchecked: unchecked,
    capped: capped,
  );
}
