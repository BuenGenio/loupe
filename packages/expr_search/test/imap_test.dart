import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/generators.dart';
import 'support/servers.dart';
import 'support/terms.dart';

ImapSearchQuery q(String input) => compileImap(parseQuery(input, now: testNow).expr);

void main() {
  group('compileImap', () {
    // (query, criteria, exact)
    final cases = <(String, String, bool)>[
      ('', 'ALL', true),
      ('f:alice', 'FROM "alice"', true),
      ('tn:bob', 'TO "bob"', true),
      ('t:bob', 'OR TO "bob" CC "bob"', true),
      ('cc:x', 'CC "x"', true),
      ('bcc:x', 'BCC "x"', true),
      ('s:"electric bill"', 'SUBJECT "electric bill"', true),
      ('b:x', 'BODY "x"', true),
      ('alice', 'TEXT "alice"', false),
      ('-alice', 'NOT OR FROM "alice" OR TO "alice" OR CC "alice" OR SUBJECT "alice" BODY "alice"', true),
      ('recipients:x', 'OR TO "x" OR CC "x" BCC "x"', true),
      ('-recipients:x', 'NOT OR TO "x" OR CC "x" BCC "x"', true),
      ('ft:x', 'OR FROM "x" OR TO "x" OR CC "x" BCC "x"', true),
      ('f:a s:b', 'FROM "a" SUBJECT "b"', true),
      ('f:a or s:b', 'OR FROM "a" SUBJECT "b"', true),
      ('f:a or s:b or b:c', 'OR FROM "a" OR SUBJECT "b" BODY "c"', true),
      ('(f:a s:b) or b:c', 'OR (FROM "a" SUBJECT "b") BODY "c"', true),
      ('f:a (s:b or s:c) is:unread', 'FROM "a" OR SUBJECT "b" SUBJECT "c" UNSEEN', true),
      ('-f:a', 'NOT FROM "a"', true),
      ('-(f:a or s:b)', 'NOT FROM "a" NOT SUBJECT "b"', true),
      ('-(f:a s:b)', 'OR NOT FROM "a" NOT SUBJECT "b"', true),
      ('-(f:a (s:b or -s:c))', 'OR NOT FROM "a" (NOT SUBJECT "b" SUBJECT "c")', true),
      ('is:read', 'SEEN', true),
      ('is:unread', 'UNSEEN', true),
      ('is:flagged', 'FLAGGED', true),
      ('-is:flagged', 'UNFLAGGED', true),
      ('is:replied', 'ANSWERED', true),
      ('is:unreplied', 'UNANSWERED', true),
      ('is:draft', 'DRAFT', true),
      ('-is:draft', 'UNDRAFT', true),
      ('tag:work', r'KEYWORD $label2', true),
      ('-tag:work', r'UNKEYWORD $label2', true),
      ('is:forwarded', r'KEYWORD $forwarded', true),
      ('is:junk', r'KEYWORD $junk', true),
      ('tag:na', r'UNKEYWORD $label1 UNKEYWORD $label2 UNKEYWORD $label3 UNKEYWORD $label4 UNKEYWORD $label5', true),
      ('keyword:"a b"', 'ALL', false),
      ('keyword:x]', 'ALL', false),
      ('before:2026-03-01', 'BEFORE 1-Mar-2026', true),
      ('after:2026-02-28', 'SINCE 1-Mar-2026', true),
      ('date:2026-03-05', 'ON 5-Mar-2026', true),
      ('-date:2026-03-05', 'NOT ON 5-Mar-2026', true),
      ('-before:2026-03-01', 'SINCE 1-Mar-2026', true),
      ('-after:2026-02-28', 'BEFORE 1-Mar-2026', true),
      ('date:2026-03', 'SINCE 1-Mar-2026 BEFORE 1-Apr-2026', true),
      ('newer_than:7d', 'SINCE 28-Sep-2026', true),
      ('larger:2M', 'LARGER 2097152', true),
      ('smaller:10', 'SMALLER 10240', true),
      ('-larger:1K', 'NOT LARGER 1024', true),
      ('h:List-Id', 'HEADER "List-Id" ""', true),
      ('header:"List-Id=dev"', 'HEADER "List-Id" "dev"', true),
      ('-h:X-Spam', 'NOT HEADER "X-Spam" ""', true),
      // Widened terms.
      ('re:/x/', 'ALL', false),
      ('f:a re:/x/', 'FROM "a"', false),
      ('f:a or re:/x/', 'ALL', false),
      ('-(f:a or re:/x/)', 'NOT FROM "a"', false),
      ('-re:/x/ f:a', 'FROM "a"', false),
      ('a:yes', 'ALL', false),
      ('a:no', 'ALL', false),
      ('a:pdf', 'ALL', false),
      ('acc:work', 'ALL', false),
      ('only:tom', 'TO "tom"', false),
      ('simple:Re: x', 'SUBJECT "Re: x"', false),
      // Quoting.
      (r's:"say \"hi\""', r'SUBJECT "say \"hi\""', true),
      (r's:"back\\slash"', r'SUBJECT "back\\slash"', true),
      ('f:""', 'FROM ""', true),
      ('s:(a)', 'SUBJECT "a"', true),
      ('s:"(a)"', 'SUBJECT "(a)"', true),
    ];
    for (final (input, criteria, exact) in cases) {
      test(input.isEmpty ? '(empty)' : input, () {
        final r = q(input);
        expect(r.criteria, criteria);
        expect(r.exact, exact);
        expect(r.useUtf8, isFalse);
      });
    }

    test('non-ASCII text needs UTF-8', () {
      final r = q('s:Grüße f:josé');
      expect(r.criteria, 'SUBJECT "Grüße" FROM "josé"');
      expect(r.useUtf8, isTrue);
      expect(r.exact, isTrue);
    });

    test('text that would need a literal is widened', () {
      final r = compileImap(and([subject('a\r\nb'), from('x')]));
      expect(r.criteria, 'FROM "x"');
      expect(r.exact, isFalse);
    });

    test('nothing and empty OR', () {
      expect(compileImap(const SearchNot(MatchAll())).criteria, 'NOT ALL');
      expect(compileImap(const SearchOr([])).criteria, 'NOT ALL');
      expect(compileImap(const SearchAnd([])).criteria, 'ALL');
    });

    test('extra unsupported terms', () {
      bool noBody(SearchExpr t) => !(t is TextTerm && t.field == SearchField.body);
      final r = compileImap(parseQuery('f:a b:x').expr, supported: noBody);
      expect((r.criteria, r.exact), ('FROM "a"', false));
      expect(compileImap(parseQuery('f:a').expr, supported: noBody).exact, isTrue);
    });
  });

  group('semantics against a reference server', () {
    test('every literal, negated or not', () {
      final gen = ExprGen(5);
      final emails = EmailGen(6);
      final messages = [for (var i = 0; i < 80; i++) emails.next(complete: true)];
      for (final t in [...vocabularyLiterals(), for (var i = 0; i < 200; i++) gen.term()]) {
        for (final e in [t, SearchNot(t)]) {
          final compiled = compileImap(e);
          for (final m in messages) {
            final local = matchesEmail(e, m.email, content: m.content, accountLabel: m.account);
            final server = imapMatches(compiled.criteria, (email: m.email, content: m.content!));
            if (local) expect(server, isTrue, reason: '$e\n→ ${compiled.criteria}\n${m.email.subject}');
            if (compiled.exact) expect(server, local, reason: '$e\n→ ${compiled.criteria}');
          }
        }
      }
    });

    for (final seed in [1, 2, 3]) {
      test('superset always, equal when exact (seed $seed)', () {
        final gen = ExprGen(seed * 31);
        final emails = EmailGen(seed * 37);
        var exactCount = 0;
        var checked = 0;
        for (var i = 0; i < 400; i++) {
          final e = gen.root();
          final compiled = compileImap(e);
          if (compiled.exact) exactCount++;
          for (var j = 0; j < 5; j++) {
            final m = emails.next(complete: true);
            final message = (email: m.email, content: m.content!);
            final local = matchesEmail(e, m.email, content: m.content, accountLabel: m.account);
            final server = imapMatches(compiled.criteria, message);
            checked++;
            if (local) expect(server, isTrue, reason: '$e\n→ ${compiled.criteria}');
            if (compiled.exact) expect(server, local, reason: '$e\n→ ${compiled.criteria}');
          }
          expect(compiled.useUtf8, compiled.criteria.runes.any((r) => r > 0x7f));
        }
        expect(exactCount, greaterThan(40), reason: 'exact queries must be exercised');
        expect(checked, 2000);
      });
    }
  });
}
