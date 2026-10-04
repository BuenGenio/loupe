import 'dart:math';

import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/generators.dart';
import 'support/terms.dart';

final a = from('a');
final b = subject('b');
final c = body('c');
final rx = re(SearchField.subject, 'x');
const none = SearchNot(MatchAll());

bool noRegex(SearchExpr t) => t is! RegexTerm;

/// Whether negations sit only directly above terms.
bool isNnf(SearchExpr e) => switch (e) {
  SearchAnd(:final children) || SearchOr(:final children) => children.every(isNnf),
  SearchNot(:final child) => child is! SearchAnd && child is! SearchOr && child is! SearchNot,
  _ => true,
};

String kindOf(SearchExpr t) => switch (t) {
  TextTerm(:final field) || RegexTerm(:final field) => '${t.runtimeType}:${field.name}',
  KeywordTerm(:final keyword) => 'keyword:$keyword',
  _ => '${t.runtimeType}',
};

void main() {
  group('toNnf', () {
    final cases = <(SearchExpr, SearchExpr)>[
      (a, a),
      (not(a), not(a)),
      (not(not(a)), a),
      (not(and([a, b])), or([not(a), not(b)])),
      (not(or([a, b])), and([not(a), not(b)])),
      (
        not(
          and([
            a,
            or([b, not(c)]),
          ]),
        ),
        or([
          not(a),
          and([not(b), c]),
        ]),
      ),
      (
        and([
          a,
          and([b, c]),
        ]),
        and([a, b, c]),
      ),
      (
        or([
          a,
          not(and([not(b), not(c)])),
        ]),
        or([a, b, c]),
      ),
      (const MatchAll(), const MatchAll()),
      (none, none),
      (not(none), const MatchAll()),
    ];
    for (final (input, expected) in cases) {
      test('$input', () => expect(toNnf(input), expected));
    }

    test('random expressions: normal form, same meaning', () {
      final gen = ExprGen(7);
      final emails = EmailGen(7);
      for (var i = 0; i < 400; i++) {
        final e = gen.root();
        final n = toNnf(e);
        expect(isNnf(n), isTrue, reason: '$n');
        final m = emails.next();
        expect(
          matchesEmail(n, m.email, content: m.content, accountLabel: m.account, headers: m.headers),
          matchesEmail(e, m.email, content: m.content, accountLabel: m.account, headers: m.headers),
          reason: '$e',
        );
      }
    });
  });

  group('simplifyQuery', () {
    final cases = <(SearchExpr, SearchExpr)>[
      (and([a, const MatchAll()]), a),
      (and([const MatchAll(), const MatchAll()]), const MatchAll()),
      (const SearchAnd([]), const MatchAll()),
      (or([a, const MatchAll()]), const MatchAll()),
      (const SearchOr([]), none),
      (and([a, none]), none),
      (or([a, none]), a),
      (or([none, none]), none),
      (
        and([
          a,
          and([b, c]),
        ]),
        and([a, b, c]),
      ),
      (
        or([
          or([a, b]),
          c,
        ]),
        or([a, b, c]),
      ),
      (not(not(a)), a),
      (not(and([a, const MatchAll()])), not(a)),
      (SearchAnd([a]), a),
    ];
    for (final (input, expected) in cases) {
      test('$input', () => expect(simplifyQuery(input), expected));
    }
  });

  group('widenForServer', () {
    final cases = <(SearchExpr, SearchExpr)>[
      (and([a, rx]), a),
      (or([a, rx]), const MatchAll()),
      (rx, const MatchAll()),
      (not(rx), const MatchAll()),
      (not(and([a, rx])), const MatchAll()),
      (not(or([a, rx])), not(a)),
      (
        and([
          a,
          or([b, rx]),
          not(c),
        ]),
        and([a, not(c)]),
      ),
      (not(and([a, b])), or([not(a), not(b)])),
      (
        and([
          a,
          or([b, c]),
        ]),
        and([
          a,
          or([b, c]),
        ]),
      ),
    ];
    for (final (input, expected) in cases) {
      test('$input', () => expect(widenForServer(input, noRegex), expected));
    }

    test('supported sees bare terms, never Not or compounds', () {
      final seen = <SearchExpr>[];
      widenForServer(
        not(
          and([
            a,
            not(rx),
            or([b, const AccountTerm('w')]),
          ]),
        ),
        (t) {
          seen.add(t);
          return true;
        },
      );
      expect(seen, unorderedEquals([a, rx, b, const AccountTerm('w')]));
    });

    test('nothing supported widens to MatchAll', () {
      expect(widenForServer(and([a, not(b)]), (_) => false), const MatchAll());
    });

    for (final known in [false, true]) {
      test('superset property over random expressions and messages (full content: $known)', () {
        final gen = ExprGen(known ? 11 : 12);
        final emails = EmailGen(known ? 13 : 14);
        final r = Random(15);
        var matched = 0;
        for (var i = 0; i < 1500; i++) {
          final e = gen.root();
          // A random server: supports each kind of term, or not.
          final support = <String, bool>{};
          bool supported(SearchExpr t) => support.putIfAbsent(kindOf(t), r.nextBool);
          final w = widenForServer(e, supported);
          expect(isNnf(w), isTrue);
          for (var j = 0; j < 4; j++) {
            final m = emails.next();
            final content = known
                ? (m.content ?? EmailContent(emailId: m.email.id, text: 'x', headers: const [('X', 'y')]))
                : m.content;
            final original = matchesEmail(e, m.email, content: content, accountLabel: m.account, headers: m.headers);
            if (!original) continue;
            matched++;
            expect(
              matchesEmail(w, m.email, content: content, accountLabel: m.account, headers: m.headers),
              isTrue,
              reason: 'expr: $e\nwidened: $w',
            );
          }
        }
        expect(matched, greaterThan(500), reason: 'the property must be exercised');
      });
    }
  });

  group('bindAccountTerms', () {
    const work = AccountTerm('work');
    final cases = <(SearchExpr, String, SearchExpr)>[
      (work, 'Work <me@work.example>', const MatchAll()),
      (work, 'Home', none),
      (and([a, work]), 'Work', a),
      (and([a, work]), 'Home', none),
      (or([a, work]), 'Home', a),
      (and([a, not(work)]), 'Home', a),
      (and([a, not(work)]), 'WORK', none),
      (const AccountTerm('ME@WORK'), 'Work <me@work.example>', const MatchAll()),
    ];
    for (final (expr, label, expected) in cases) {
      test('$expr in $label', () => expect(bindAccountTerms(expr, label), expected));
    }

    test('matchesNothing', () {
      expect(matchesNothing(bindAccountTerms(and([a, work]), 'Home')), isTrue);
      expect(matchesNothing(and([a, work])), isFalse);
      expect(matchesNothing(const MatchAll()), isFalse);
      expect(matchesNothing(or([none, none])), isTrue);
    });
  });
}
