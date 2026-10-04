import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/help_examples.dart';
import 'support/terms.dart';

ParsedQuery p(String input) => parseQuery(input, now: testNow);

void main() {
  group('help examples', () {
    for (final (input, expected) in helpExamples) {
      test(input, () {
        final r = p(input);
        expect(r.errors, isEmpty, reason: '$input: ${r.errors}');
        expect(r.expr, expected);
      });
    }
    for (final input in unsupportedExamples) {
      test('$input (unsupported)', () {
        final r = p(input);
        expect(r.errors, isNotEmpty);
        expect(r.expr, const MatchAll());
      });
    }
  });

  group('operators and values', () {
    final cases = <(String, SearchExpr)>[
      ('', const MatchAll()),
      ('   ', const MatchAll()),
      ('alice', any('alice')),
      ('"alice smith"', any('alice smith')),
      ('alice "smith"', and([any('alice'), any('smith')])),
      ('toorcc:x', toOrCc('x')),
      ('recipients:team', recipients('team')),
      ('fromtocc:x', participants('x')),
      ('alladdresses:x', participants('x')),
      ('body:"a b"', body('a b')),
      ('subject:""', subject('')),
      ('f:or', from('or')),
      ('f:and', from('and')),
      ('f: alice', from('alice')),
      ('f:s:x', from('s:x')),
      ('from:/^al/', re(TextField.from, '^al', cs: true)),
      ('to:/x/i', or([re(TextField.to, 'x'), re(TextField.cc, 'x')])),
      ('/inv(oice)?/i', re(TextField.any, 'inv(oice)?')),
      (r'/a\/b/', re(TextField.any, 'a/b', cs: true)),
      ('/[/]x/', re(TextField.any, '[/]x', cs: true)),
      ('a:/\\.pdf\$/i', re(TextField.attachment, r'\.pdf$')),
      ('a:no', not(hasAttachment)),
      ('a:N', not(hasAttachment)),
      ('a:1', hasAttachment),
      ('has:attachment', hasAttachment),
      ('is:read', read),
      ('i:new', unread),
      ('u:unread', unread),
      ('status:starred', flagged),
      ('is:marked', flagged),
      ('is:unstarred', not(flagged)),
      ('is:replied', kw(Keywords.answered)),
      ('is:forwarded', kw(Keywords.forwarded)),
      ('is:draft', kw(Keywords.draft)),
      ('is:junk', kw(Keywords.junk)),
      ('is:attachment', hasAttachment),
      ('is:-read', unread),
      ('is:UNREAD', unread),
      ('tag:Work', kw(Keywords.label2)),
      ('l:"to do"', kw(Keywords.label4)),
      ('label:#5', kw(Keywords.label5)),
      ('tag:o', or([kw(Keywords.label1), kw(Keywords.label2), kw(Keywords.label3), kw(Keywords.label4)])),
      ('tag:projectx', kw('projectx')),
      (r'tag:$Label1', kw(Keywords.label1)),
      ('keyword:Work', kw('work')),
      (r'kw:$label2', kw(Keywords.label2)),
      ('header:"List-Id=dev list"', const HeaderTerm('List-Id', 'dev list')),
      ('header:X-Mailer', const HeaderTerm('X-Mailer', '')),
      ('header:"X-Spam=a.b"', const HeaderTerm('X-Spam', 'a.b')),
      (r'h:X-Spam=a\.b', const HeaderTerm('X-Spam', 'a.b')),
      ('hr:"X-Flag=yes"', const HeaderTerm('X-Flag', 'yes')),
      ('before:2026-03-01', before(2026, 3, 1)),
      ('before:2026.3.1', before(2026, 3, 1)),
      ('after:2026-02-28', since(2026, 3, 1)),
      ('after:2026', since(2027, 1, 1)),
      ('before:2026', before(2026, 1, 1)),
      ('date:2026-03-05', on(2026, 3, 5)),
      ('date:2024', and([since(2024, 1, 1), before(2025, 1, 1)])),
      ('date:today', on(2026, 10, 4)),
      ('date:yesterday', on(2026, 10, 3)),
      ('after:yesterday', since(2026, 10, 4)),
      ('before:today', before(2026, 10, 4)),
      ('after:7d', since(2026, 9, 28)),
      ('before:1m', before(2026, 9, 4)),
      ('date:1 Mar 2026', on(2026, 3, 1)),
      ('date:"March 1, 2026"', on(2026, 3, 1)),
      ('date:1-Mar-2026', on(2026, 3, 1)),
      ('older_than:today', before(2026, 10, 4)),
      ('older_than:yesterday', before(2026, 10, 3)),
      ('newer_than:today', since(2026, 10, 4)),
      ('newer_than:yesterday', since(2026, 10, 3)),
      ('newer_than:1d', since(2026, 10, 4)),
      ('older_than:3', before(2026, 10, 1)),
      ('older_than:1m', before(2026, 9, 4)),
      ('age:2y', before(2024, 10, 4)),
      ('larger:2M', larger(2 * mb)),
      ('larger:1G', larger(1024 * mb)),
      ('larger:300B', larger(300)),
      ('larger:1.5kb', larger(1536)),
      ('smaller:100K', smaller(100 * kb)),
      ('account:"Work mail"', const AccountTerm('Work mail')),
      ('only:"tom, jerry"', and([toOnly('tom'), toOnly('jerry'), not(re(TextField.to, '^(?!.*(?:tom|jerry))'))])),
      ('“smart quotes”', any('smart quotes')),
      ('„German quotes“', any('German quotes')),
      (r'"say \"hi\""', any('say "hi"')),
      (r'"back\\slash"', any(r'back\slash')),
      (r'"keep \n"', any(r'keep \n')),
      ('g: f:x', from('x')),
      ('http://example.com', any('http://example.com')),
      ('e-mail', any('e-mail')),
    ];
    for (final (input, expected) in cases) {
      test(input.isEmpty ? '(empty)' : input, () {
        final r = p(input);
        expect(r.errors, isEmpty, reason: '$input: ${r.errors}');
        expect(r.expr, expected);
      });
    }
  });

  group('precedence', () {
    final cases = <(String, SearchExpr)>[
      (
        'f:a or f:b s:c',
        or([
          from('a'),
          and([from('b'), subject('c')]),
        ]),
      ),
      (
        'f:a s:b or f:c',
        or([
          and([from('a'), subject('b')]),
          from('c'),
        ]),
      ),
      ('not f:a or f:b', or([not(from('a')), from('b')])),
      ('-f:a s:b', and([not(from('a')), subject('b')])),
      (
        'f:a and s:b or is:unread',
        or([
          and([from('a'), subject('b')]),
          unread,
        ]),
      ),
      (
        'f:a (s:b or s:c)',
        and([
          from('a'),
          or([subject('b'), subject('c')]),
        ]),
      ),
      (
        'f:a or (f:b or f:c)',
        or([
          from('a'),
          or([from('b'), from('c')]),
        ]),
      ),
      (
        '(f:a s:b) s:c',
        and([
          and([from('a'), subject('b')]),
          subject('c'),
        ]),
      ),
      ('not not f:a', not(not(from('a')))),
      ('--f:a', not(not(from('a')))),
      (
        'NOT f:a OR f:b AND s:c',
        or([
          not(from('a')),
          and([from('b'), subject('c')]),
        ]),
      ),
      ('-alice bob', not(any('alice bob'))),
      ('alice -bob', and([any('alice'), not(any('bob'))])),
      ('f:alice bob s:x', and([from('alice bob'), subject('x')])),
      ('f:(a s:b)', and([from('a'), subject('b')])),
      (
        'f:((a or b) c)',
        and([
          or([from('a'), from('b')]),
          from('c'),
        ]),
      ),
      ('f:a or b', or([from('a'), any('b')])),
      ('(re:a(b)c) f:x', and([re(TextField.subject, 'a(b)c'), from('x')])),
      ('re:/x/ f:y', and([re(TextField.subject, 'x', cs: true), from('y')])),
      ('re: x y', re(TextField.subject, 'x y')),
    ];
    for (final (input, expected) in cases) {
      test(input, () {
        final r = p(input);
        expect(r.errors, isEmpty, reason: '$input: ${r.errors}');
        expect(r.expr, expected);
      });
    }
  });

  group('error recovery', () {
    // (input, best-effort expression, number of errors)
    final cases = <(String, SearchExpr, int)>[
      ('f:', const MatchAll(), 1),
      ('f:alice s:', from('alice'), 1),
      ('(a or', any('a'), 2),
      ('(f:a', from('a'), 1),
      ('((a)', any('a'), 1),
      ('"unterminated', any('unterminated'), 1),
      ('f:"alice', from('alice'), 1),
      ('s:"a b', subject('a b'), 1),
      ('a or', any('a'), 1),
      ('or a', any('a'), 1),
      ('a or or b', or([any('a'), any('b')]), 1),
      ('a and', any('a'), 1),
      ('and a', any('a'), 1),
      ('a )', any('a'), 1),
      (') a', any('a'), 1),
      ('-', const MatchAll(), 1),
      ('a -', any('a'), 1),
      ('not', const MatchAll(), 1),
      ('()', const MatchAll(), 1),
      ('f:()', const MatchAll(), 1),
      ('f:-', const MatchAll(), 1),
      ('is:', const MatchAll(), 1),
      ('is:foo', const MatchAll(), 1),
      ('is:deleted f:a', from('a'), 1),
      ('-is:foo f:a', from('a'), 1),
      ('/abc', re(TextField.any, 'abc'), 1),
      ('/a(/', const MatchAll(), 1),
      ('//', const MatchAll(), 1),
      ('/a/x', re(TextField.any, 'a', cs: true), 1),
      ('f:x or is:', from('x'), 1),
      ('before:2026-13-01', const MatchAll(), 1),
      ('before:2026-02-30', const MatchAll(), 1),
      ('before:soon', const MatchAll(), 1),
      ('older_than:1.5d', const MatchAll(), 1),
      ('larger:abc', const MatchAll(), 1),
      ('tag:#9', const MatchAll(), 1),
      ('has:flag', const MatchAll(), 1),
      ('is:/x/', const MatchAll(), 1),
      ('simple:', const MatchAll(), 1),
      ('re:', const MatchAll(), 1),
      ('re:(', const MatchAll(), 1),
      ('only:,', const MatchAll(), 1),
      ('h:=x', const MatchAll(), 1),
      ('h:X-Spam=/a.*b/', const HeaderTerm('X-Spam', ''), 1),
      ('f: or s:x', subject('x'), 1),
    ];
    for (final (input, expected, errorCount) in cases) {
      test(input, () {
        final r = p(input);
        expect(r.expr, expected);
        expect(r.errors, hasLength(errorCount), reason: '${r.errors}');
        expect(r.isValid, isFalse);
        for (final e in r.errors) {
          expect(e.start, inInclusiveRange(0, input.length));
          expect(e.end, inInclusiveRange(e.start, input.length));
        }
      });
    }

    test('error ranges point at the problem', () {
      expect(p('f:alice s:').errors.single, isA<QueryError>().having((e) => (e.start, e.end), 'range', (8, 10)));
      expect(p('a "bc').errors.single, isA<QueryError>().having((e) => (e.start, e.end), 'range', (2, 5)));
      expect(p('(a').errors.single, isA<QueryError>().having((e) => (e.start, e.end), 'range', (0, 1)));
    });

    test('never throws on hostile input', () {
      for (final input in [
        '(' * 20000,
        ')' * 1000,
        '-' * 1000,
        '"' * 999,
        '/' * 999,
        'f:' * 1000,
        'not ' * 1000,
        'a or ' * 2000,
        '\u0000\uFFFF\uD800',
        'larger:${'9' * 400}',
        'older_than:99999y',
      ]) {
        expect(() => p(input), returnsNormally);
      }
    });

    test('a query being typed keeps matching something useful', () {
      const typed = 'f:alice and (s:invoice or b:"PO 123")';
      for (var i = 3; i <= typed.length; i++) {
        final r = p(typed.substring(0, i));
        expect(r.expr, isNot(isA<MatchAll>()), reason: typed.substring(0, i));
      }
    });
  });

  group('tokens', () {
    test('kinds and ranges', () {
      const input = r'f:alice and (s:"x y" or /re/i) -is:read';
      final tokens = p(input).tokens;
      expect(
        [for (final t in tokens) (t.kind, t.text)],
        [
          (QueryTokenKind.operatorName, 'f:'),
          (QueryTokenKind.value, 'alice'),
          (QueryTokenKind.keyword, 'and'),
          (QueryTokenKind.paren, '('),
          (QueryTokenKind.operatorName, 's:'),
          (QueryTokenKind.quoted, '"x y"'),
          (QueryTokenKind.keyword, 'or'),
          (QueryTokenKind.regex, '/re/i'),
          (QueryTokenKind.paren, ')'),
          (QueryTokenKind.keyword, '-'),
          (QueryTokenKind.operatorName, 'is:'),
          (QueryTokenKind.value, 'read'),
        ],
      );
      for (final t in tokens) {
        expect(input.substring(t.start, t.end), t.text);
      }
    });

    test('rest-of-input values are one token', () {
      final tokens = p('simple:Re: (x) - y').tokens;
      expect(
        [for (final t in tokens) (t.kind, t.text)],
        [(QueryTokenKind.operatorName, 'simple:'), (QueryTokenKind.value, 'Re: (x) - y')],
      );
    });

    test('global prefix is an operator token', () {
      expect(p('g:x').tokens.first.kind, QueryTokenKind.operatorName);
    });

    test('bad values and stray parentheses are error tokens', () {
      final tokens = p('is:foo )').tokens;
      expect(
        [for (final t in tokens) t.kind],
        [QueryTokenKind.operatorName, QueryTokenKind.error, QueryTokenKind.error],
      );
      expect(p('f:').tokens.single.kind, QueryTokenKind.error);
    });
  });

  group('options', () {
    test('custom tag definitions', () {
      const tags = [TagDefinition(keyword: 'client-a', label: 'Client A', colorArgb: 0)];
      expect(parseQuery('tag:"client a"', tags: tags).expr, kw('client-a'));
      expect(parseQuery('tag:na', tags: tags).expr, not(kw('client-a')));
      expect(parseQuery('tag:na f:x', tags: const []).expr, from('x'));
    });

    test('relative dates follow now', () {
      expect(parseQuery('date:today', now: DateTime(2025, 1, 1, 0, 1)).expr, on(2025, 1, 1));
      expect(parseQuery('older_than:1m', now: DateTime(2026, 3, 31)).expr, before(2026, 2, 28));
      expect(parseQuery('older_than:1y', now: DateTime(2024, 2, 29)).expr, before(2023, 2, 28));
    });
  });
}
