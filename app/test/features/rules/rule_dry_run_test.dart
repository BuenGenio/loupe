import 'package:expr_search/expr_search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/rules/rule_dry_run.dart';
import 'package:mail_model/mail_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final now = DateTime(2026, 10, 4, 16);
  late DemoMailRepository repo;

  setUp(() => repo = DemoMailRepository.instant(clock: () => now));
  tearDown(() => repo.dispose());

  Rule rule(String condition, {List<RuleAction> actions = const [FlagAction()]}) => Rule(
    id: 'draft',
    name: 'Draft',
    condition: condition,
    actions: actions,
    accountIds: const {DemoAccounts.personal},
  );

  /// The personal account's downloaded mail outside Sent, Drafts, Junk,
  /// Trash and All Mail, as the store has it.
  Future<List<EmailSummary>> incoming() async {
    const skipped = {MailboxRole.sent, MailboxRole.drafts, MailboxRole.junk, MailboxRole.trash, MailboxRole.all};
    final out = <String, EmailSummary>{};
    for (final box in await repo.watchMailboxes(accountId: DemoAccounts.personal).first) {
      if (skipped.contains(box.role) || !box.isSelectable) continue;
      final results = await repo
          .search(
            SearchRequest(
              expr: const MatchAll(),
              scope: MailboxScope(RealMailboxRef(box.id)),
              includeServer: false,
              limit: 100000,
            ),
          )
          .first;
      for (final e in results.items) {
        out[e.id] = e;
      }
    }
    return out.values.toList();
  }

  /// Exactly what [condition] matches, every message's text loaded.
  Future<Set<String>> exact(String condition) async {
    final account = (await repo.watchAccounts().first).firstWhere((a) => a.id == DemoAccounts.personal);
    final label = '${account.displayName} ${account.email}';
    final expr = bindAccountTerms(parseQuery(condition, now: now).expr, label);
    return {
      for (final e in await incoming())
        if (matchesEmail(expr, e, content: await repo.loadContent(e.id), accountLabel: label)) e.id,
    };
  }

  test('counts what the rule matches in the account’s incoming mail, and changes nothing', () async {
    const condition = 'from:"Harbor Coffee" subject:receipt';
    final run = await dryRunRule(repo, rule(condition), accountId: DemoAccounts.personal, now: now);
    final expected = await exact(condition);
    expect(run.checked, (await incoming()).length);
    expect(run.matched, expected.length);
    expect(run.matched, greaterThan(1));
    expect(run.matches, hasLength(3));
    expect(run.matches.every((e) => expected.contains(e.id)), isTrue);
    expect(run.misses.every((e) => !expected.contains(e.id)), isTrue);
    // The newest first.
    expect(run.matches.first.receivedAt.isAfter(run.matches.last.receivedAt), isTrue);
    expect(run.unchecked, 0);
    expect(run.capped, isFalse);
    // A dry run: nothing was flagged.
    for (final e in run.matches) {
      expect((await repo.getEmail(e.id))!.isFlagged, isFalse);
    }
  });

  test('near misses come first: mail that meets part of the condition', () async {
    final run = await dryRunRule(
      repo,
      rule('subject:receipt from:"Corner Bookshop"'),
      accountId: DemoAccounts.personal,
    );
    expect(run.misses, isNotEmpty);
    final first = run.misses.first;
    expect(
      first.subject.toLowerCase().contains('receipt') ||
          first.from.any((a) => '${a.name} ${a.email}'.contains('Corner Bookshop')),
      isTrue,
    );
  });

  test(
    'a condition on the text loads it, like the device runner; past the limit it says what it couldn’t check',
    () async {
      const condition = 'body:"Visa ···· 4417"';
      final full = await dryRunRule(repo, rule(condition), accountId: DemoAccounts.personal, contentLoads: 100000);
      expect(full.matched, (await exact(condition)).length);
      expect(full.matched, greaterThan(0));
      expect(full.unchecked, 0);

      final none = await dryRunRule(repo, rule(condition), accountId: DemoAccounts.personal, contentLoads: 0);
      expect(none.unchecked, greaterThan(0));
      expect(none.matched + none.unchecked, lessThanOrEqualTo(full.checked));
      expect(none.matched, lessThanOrEqualTo(full.matched));
    },
  );

  test('every message, other accounts left out, and a cap that says so', () async {
    final all = await dryRunRule(repo, rule(''), accountId: DemoAccounts.personal);
    expect(all.matched, all.checked);
    expect(all.matches.every((e) => e.accountId == DemoAccounts.personal), isTrue);

    final few = await dryRunRule(repo, rule(''), accountId: DemoAccounts.personal, limit: 10);
    expect(few.checked, 10);
    expect(few.capped, isTrue);
  });
}
