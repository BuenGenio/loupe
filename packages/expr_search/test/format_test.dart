import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/generators.dart';
import 'support/help_examples.dart';
import 'support/terms.dart';

final _only = and([toOnly('tom'), toOnly('jerry'), not(re(SearchField.to, '^(?!.*(?:tom|jerry))'))]);

void main() {
  group('formatQuery', () {
    final cases = <(SearchExpr, String)>[
      (const MatchAll(), ''),
      (from('alice'), 'from:alice'),
      (any('invoice'), 'invoice'),
      (any('weekend plans'), '"weekend plans"'),
      (any('or'), '"or"'),
      (any('-x'), '"-x"'),
      (any(r'say "hi" \o/'), r'"say \"hi\" \\o/"'),
      (any(''), '""'),
      (from('a b'), 'from:"a b"'),
      (from('Re: x'), 'from:"Re: x"'),
      (toOnly('bob'), 'tonocc:bob'),
      (toOrCc('bob'), 'to:bob'),
      (recipients('team'), 'recipients:team'),
      (participants('tom'), 'fromto:tom'),
      (attachment('pdf'), 'filename:pdf'),
      (and([from('a'), subject('b c')]), 'from:a subject:"b c"'),
      (and([from('a'), any('b')]), 'from:a and b'),
      (and([any('a'), any('b')]), 'a and b'),
      (and([any('a'), not(any('b'))]), 'a -b'),
      (
        or([
          from('a'),
          and([subject('b'), unread]),
        ]),
        'from:a or subject:b is:unread',
      ),
      (
        and([
          from('a'),
          or([subject('b'), subject('c')]),
        ]),
        'from:a (subject:b or subject:c)',
      ),
      (
        and([
          from('a'),
          and([subject('b'), subject('c')]),
        ]),
        'from:a (subject:b subject:c)',
      ),
      (
        or([
          from('a'),
          or([from('b'), from('c')]),
        ]),
        'from:a or (from:b or from:c)',
      ),
      (not(or([subject('a'), subject('b')])), '-(subject:a or subject:b)'),
      (not(not(from('a'))), '--from:a'),
      (unread, 'is:unread'),
      (not(unread), '-is:unread'),
      (read, 'is:read'),
      (not(flagged), 'is:unflagged'),
      (kw(Keywords.answered), 'is:replied'),
      (not(kw(Keywords.forwarded)), '-is:forwarded'),
      (kw(Keywords.label2), 'tag:Work'),
      (kw(Keywords.label4), 'tag:"To Do"'),
      (kw('projectx'), 'tag:projectx'),
      (kw('work'), 'keyword:work'),
      (kw(r'$mdnsent'), r'keyword:$mdnsent'),
      (not(kw(Keywords.label1)), '-tag:Important'),
      (before(2026, 3, 1), 'before:2026-03-01'),
      (since(2026, 3, 1), 'after:2026-02-28'),
      (since(2026, 1, 1), 'after:2025-12-31'),
      (on(2026, 3, 1), 'date:2026-03-01'),
      (DateTerm(DateComparison.on, DateTime.utc(2026, 3, 1)), 'date:2026-03-01'),
      (larger(2 * mb), 'larger:2M'),
      (larger(500 * kb), 'larger:500K'),
      (smaller(1500), 'smaller:1500B'),
      (larger(0), 'larger:0B'),
      (re(SearchField.any, 'a/b'), r'/a\/b/i'),
      (re(SearchField.subject, r'^\[x\]', cs: true), r'subject:/^\[x\]/'),
      (or([re(SearchField.to, 'x'), re(SearchField.cc, 'x')]), 'to:/x/i'),
      (const HeaderTerm('List-Id', 'x y'), 'header:"List-Id=x y"'),
      (const HeaderTerm('X-Mailer', ''), 'header:X-Mailer'),
      (hasAttachment, 'attachment:yes'),
      (not(hasAttachment), 'attachment:no'),
      (const AccountTerm('Work mail'), 'account:"Work mail"'),
      (_only, 'only:tom,jerry'),
      (not(_only), '-only:tom,jerry'),
      // Non-canonical input is simplified.
      (and([const MatchAll(), from('a')]), 'from:a'),
      (or([from('a'), const MatchAll()]), ''),
      (const SearchAnd([]), ''),
      (SearchOr([from('a')]), 'from:a'),
      (const SearchNot(MatchAll()), '-()'),
    ];
    for (final (expr, text) in cases) {
      test('$expr', () => expect(formatQuery(expr), text));
    }

    test('custom tags', () {
      const tags = [TagDefinition(keyword: 'client-a', label: 'Client A', colorArgb: 0)];
      expect(formatQuery(kw('client-a'), tags: tags), 'tag:"Client A"');
      expect(formatQuery(kw(Keywords.label2), tags: tags), r'tag:$label2');
    });
  });

  group('round trip', () {
    test('help examples format to text that parses back', () {
      for (final (input, expected) in helpExamples) {
        final text = formatQuery(expected);
        final back = parseQuery(text, now: testNow);
        expect(back.errors, isEmpty, reason: '$input → $text');
        expect(back.expr, expected, reason: '$input → $text');
      }
    });

    for (final seed in List.generate(8, (i) => i)) {
      test('parseQuery(formatQuery(e)) == e for random expressions (seed $seed)', () {
        final gen = ExprGen(seed);
        for (var i = 0; i < 250; i++) {
          final e = gen.root();
          final text = formatQuery(e);
          final back = parseQuery(text, now: testNow);
          expect(back.errors, isEmpty, reason: 'seed $seed #$i: $e\n→ $text');
          expect(back.expr, e, reason: 'seed $seed #$i: $e\n→ $text');
        }
      });
    }

    test('formatting is stable', () {
      final gen = ExprGen(99);
      for (var i = 0; i < 200; i++) {
        final text = formatQuery(gen.root());
        expect(formatQuery(parseQuery(text, now: testNow).expr), text);
      }
    });
  });

  group('describeTerm', () {
    final cases = <(SearchExpr, String)>[
      (const MatchAll(), 'All messages'),
      (from('alice'), 'From: alice'),
      (any('invoice'), 'invoice'),
      (not(any('invoice')), 'Not invoice'),
      (not(from('spam')), 'Not from: spam'),
      (toOrCc('bob'), 'To/Cc: bob'),
      (toOnly('bob'), 'To: bob'),
      (participants('tom'), 'Address: tom'),
      (subject('x'), 'Subject: x'),
      (body('x'), 'Body: x'),
      (attachment('pdf'), 'Attachment: pdf'),
      (unread, 'Unread'),
      (read, 'Read'),
      (flagged, 'Flagged'),
      (not(flagged), 'Unflagged'),
      (kw(Keywords.answered), 'Replied'),
      (not(kw(Keywords.answered)), 'Unreplied'),
      (kw(Keywords.forwarded), 'Forwarded'),
      (not(kw(Keywords.forwarded)), 'Not forwarded'),
      (kw(Keywords.label2), 'Tagged Work'),
      (not(kw(Keywords.label2)), 'Not tagged Work'),
      (kw('projectx'), 'Tagged projectx'),
      (kw(r'$mdnsent'), r'Keyword $mdnsent'),
      (before(2026, 3, 1), 'Before 1 Mar 2026'),
      (since(2026, 3, 1), 'Since 1 Mar 2026'),
      (on(2026, 12, 25), 'On 25 Dec 2026'),
      (not(before(2026, 3, 1)), 'Not before 1 Mar 2026'),
      (larger(500 * kb), 'Larger than 500 KB'),
      (smaller(1536 * kb), 'Smaller than 1.5 MB'),
      (larger(300), 'Larger than 300 bytes'),
      (hasAttachment, 'Has attachment'),
      (not(hasAttachment), 'No attachment'),
      (const AccountTerm('work'), 'Account: work'),
      (not(const AccountTerm('work')), 'Not account: work'),
      (const HeaderTerm('List-Id', ''), 'Has header List-Id'),
      (not(const HeaderTerm('List-Id', '')), 'No header List-Id'),
      (const HeaderTerm('List-Id', 'dev'), 'List-Id: dev'),
      (re(SearchField.subject, '^x'), 'Subject matches /^x/i'),
      (re(SearchField.any, 'x', cs: true), 'Matches /x/'),
      (not(re(SearchField.any, 'x')), 'Doesn’t match /x/i'),
      (_only, 'Only to: tom, jerry'),
      (parseQuery('simple:Re: x').expr, 'Subject (exact): Re: x'),
      (or([from('a'), from('b')]), 'From: a or b'),
      (or([from('a'), unread]), 'From: a or Unread'),
      (and([from('a'), unread]), 'From: a, Unread'),
      (
        or([
          and([from('a'), unread]),
          flagged,
        ]),
        '(From: a, Unread) or Flagged',
      ),
      (not(or([from('a'), unread])), 'Not (From: a or Unread)'),
      (not(toOrCc('bob')), 'Not to/Cc: bob'),
    ];
    for (final (expr, label) in cases) {
      test(label, () => expect(describeTerm(expr), label));
    }
  });
}
