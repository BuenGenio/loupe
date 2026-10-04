import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/generators.dart';
import 'support/servers.dart';
import 'support/terms.dart';

Map<String, Object?> j(String input) => compileJmapFilter(parseQuery(input, now: testNow).expr);

/// The UTCDate of local midnight starting the day.
String utc(int y, int m, int d) {
  final u = DateTime(y, m, d).toUtc();
  String two(int n) => n.toString().padLeft(2, '0');
  return '${u.year}-${two(u.month)}-${two(u.day)}T${two(u.hour)}:${two(u.minute)}:${two(u.second)}Z';
}

Map<String, Object?> op(String operator, List<Map<String, Object?>> conditions) => {
  'operator': operator,
  'conditions': conditions,
};

bool hasTerm(SearchExpr e, bool Function(SearchExpr) p) => switch (e) {
  SearchAnd(:final children) || SearchOr(:final children) => children.any((c) => hasTerm(c, p)),
  SearchNot(:final child) => hasTerm(child, p),
  _ => p(e),
};

void main() {
  group('compileJmapFilter', () {
    final cases = <(String, Map<String, Object?>)>[
      ('', {}),
      ('f:alice', {'from': 'alice'}),
      ('tn:bob', {'to': 'bob'}),
      (
        't:bob',
        op('OR', [
          {'to': 'bob'},
          {'cc': 'bob'},
        ]),
      ),
      ('bcc:x', {'bcc': 'x'}),
      ('s:"a b"', {'subject': 'a b'}),
      ('b:x', {'body': 'x'}),
      ('invoice', {'text': 'invoice'}),
      (
        '-invoice',
        op('NOT', [
          {'from': 'invoice'},
          {'to': 'invoice'},
          {'cc': 'invoice'},
          {'subject': 'invoice'},
          {'body': 'invoice'},
        ]),
      ),
      (
        'recipients:x',
        op('OR', [
          {'to': 'x'},
          {'cc': 'x'},
          {'bcc': 'x'},
        ]),
      ),
      (
        '-recipients:x',
        op('NOT', [
          {'to': 'x'},
          {'cc': 'x'},
          {'bcc': 'x'},
        ]),
      ),
      (
        'f:a s:b',
        op('AND', [
          {'from': 'a'},
          {'subject': 'b'},
        ]),
      ),
      (
        'f:a or s:b',
        op('OR', [
          {'from': 'a'},
          {'subject': 'b'},
        ]),
      ),
      (
        '-f:a',
        op('NOT', [
          {'from': 'a'},
        ]),
      ),
      (
        '-(f:a s:b)',
        op('OR', [
          op('NOT', [
            {'from': 'a'},
          ]),
          op('NOT', [
            {'subject': 'b'},
          ]),
        ]),
      ),
      ('is:unread', {'notKeyword': r'$seen'}),
      ('is:read', {'hasKeyword': r'$seen'}),
      ('tag:work', {'hasKeyword': r'$label2'}),
      ('-tag:work', {'notKeyword': r'$label2'}),
      ('a:yes', {'hasAttachment': true}),
      ('a:no', {'hasAttachment': false}),
      (
        'h:List-Id',
        {
          'header': ['List-Id'],
        },
      ),
      (
        'header:"List-Id=dev"',
        {
          'header': ['List-Id', 'dev'],
        },
      ),
      (
        '-h:X-Spam',
        op('NOT', [
          {
            'header': ['X-Spam'],
          },
        ]),
      ),
      ('before:2026-03-01', {'before': utc(2026, 3, 1)}),
      ('after:2026-02-28', {'after': utc(2026, 3, 1)}),
      ('-after:2026-02-28', {'before': utc(2026, 3, 1)}),
      ('date:2026-03-05', {'after': utc(2026, 3, 5), 'before': utc(2026, 3, 6)}),
      (
        '-date:2026-03-05',
        op('OR', [
          {'before': utc(2026, 3, 5)},
          {'after': utc(2026, 3, 6)},
        ]),
      ),
      ('date:2026-10-25', {'after': utc(2026, 10, 25), 'before': utc(2026, 10, 26)}),
      ('larger:1K', {'minSize': 1025}),
      ('-larger:1K', {'maxSize': 1025}),
      ('smaller:1K', {'maxSize': 1024}),
      ('-smaller:1K', {'minSize': 1024}),
      // Widened.
      ('re:/x/', {}),
      ('f:a re:/x/', {'from': 'a'}),
      ('f:a or re:/x/', {}),
      ('acc:work', {}),
      ('a:pdf', {}),
      ('only:tom', {'to': 'tom'}),
    ];
    for (final (input, expected) in cases) {
      test(input.isEmpty ? '(empty)' : input, () => expect(j(input), expected));
    }

    test('nothing', () {
      expect(compileJmapFilter(const SearchNot(MatchAll())), op('NOT', [<String, Object?>{}]));
    });

    test('UTCDate format', () {
      final date = j('before:2026-03-01')['before']! as String;
      expect(date, matches(RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$')));
      expect(DateTime.parse(date).isAtSameMomentAs(DateTime(2026, 3, 1)), isTrue);
    });

    test('jmapSupports', () {
      expect(jmapSupports(from('a')), isTrue);
      expect(jmapSupports(hasAttachment), isTrue);
      expect(jmapSupports(attachment('pdf')), isFalse);
      expect(jmapSupports(re(TextField.any, 'x')), isFalse);
      expect(jmapSupports(const AccountTerm('w')), isFalse);
    });
  });

  group('semantics against a reference server', () {
    bool inexact(SearchExpr t) =>
        !jmapSupports(t) || (t is TextTerm && t.field == TextField.any) || t is RegexTerm || t is AccountTerm;

    test('every literal, negated or not', () {
      final gen = ExprGen(41);
      final emails = EmailGen(42);
      final messages = [for (var i = 0; i < 80; i++) emails.next(complete: true)];
      for (final t in [...vocabularyLiterals(), for (var i = 0; i < 200; i++) gen.term()]) {
        for (final e in [t, SearchNot(t)]) {
          final filter = compileJmapFilter(e);
          for (final m in messages) {
            final local = matchesEmail(e, m.email, content: m.content, accountLabel: m.account);
            final server = jmapMatches(filter, (email: m.email, content: m.content!));
            if (local) expect(server, isTrue, reason: '$e\n→ $filter');
            if (!hasTerm(e, inexact)) expect(server, local, reason: '$e\n→ $filter');
          }
        }
      }
    });

    test('random expressions: superset, equal when nothing was approximated', () {
      final gen = ExprGen(43);
      final emails = EmailGen(44);
      for (var i = 0; i < 600; i++) {
        final e = gen.root();
        final filter = compileJmapFilter(e);
        for (var k = 0; k < 4; k++) {
          final m = emails.next(complete: true);
          final local = matchesEmail(e, m.email, content: m.content, accountLabel: m.account);
          final server = jmapMatches(filter, (email: m.email, content: m.content!));
          if (local) expect(server, isTrue, reason: '$e\n→ $filter');
          if (!hasTerm(e, inexact)) expect(server, local, reason: '$e\n→ $filter');
        }
      }
    });
  });
}
