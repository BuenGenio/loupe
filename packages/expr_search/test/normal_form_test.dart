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
      expect(matchesNothing(and([read, unread])), isTrue);
    });
  });

  group('findContradiction', () {
    SearchExpr? of(String query) => findContradiction(parseQuery(query, now: testNow).expr);

    test('a term next to its own negation', () {
      expect(of('is:read and is:unread'), read);
      expect(of('is:unread is:read'), read);
      expect(of('from:alice and not from:alice'), from('alice'));
      expect(of('s:x and (f:a and -s:x)'), subject('x'), reason: 'nested ANDs are flattened first');
      expect(of('not (is:read or is:unread)'), read, reason: 'De Morgan');
    });

    test('an OR only when every branch contradicts itself', () {
      expect(of('(is:read and is:unread) or (f:a and not f:a)'), read);
      expect(of('(is:read and is:unread) or f:a'), isNull);
      expect(of('f:a and ((is:read and is:unread) or (s:x and -s:x))'), read);
      expect(of('is:read and (is:unread or is:unread)'), read, reason: 'each branch against what the AND assumes');
    });

    test('operators that expand to several terms', () {
      // to: is "to or cc"; its negation is "neither".
      expect(of('to:alice and not to:alice'), isNotNull);
      expect(of('to:alice and not from:alice'), isNull);
    });

    test('satisfiable queries have none', () {
      for (final q in ['', 'is:read', 'is:read and is:flagged', 'is:read or is:unread', 'f:alice and not f:bob']) {
        expect(of(q), isNull, reason: q);
      }
    });

    test('sound: what it finds is false for every truth assignment (random queries over three terms)', () {
      final terms = [a, b, c];
      final r = Random(23);
      SearchExpr random(int depth) {
        if (depth == 0 || r.nextInt(3) == 0) {
          final t = terms[r.nextInt(3)];
          return r.nextBool() ? t : not(t);
        }
        final kids = [for (var i = 0; i < 2 + r.nextInt(2); i++) random(depth - 1)];
        return switch (r.nextInt(3)) {
          0 => and(kids),
          1 => or(kids),
          _ => not(and(kids)),
        };
      }

      bool eval(SearchExpr e, Map<SearchExpr, bool> v) => switch (e) {
        SearchAnd(:final children) => children.every((c) => eval(c, v)),
        SearchOr(:final children) => children.any((c) => eval(c, v)),
        SearchNot(:final child) => !eval(child, v),
        _ => v[e]!,
      };

      var found = 0;
      for (var i = 0; i < 3000; i++) {
        final e = random(4);
        if (findContradiction(e) == null) continue;
        found++;
        for (var bits = 0; bits < 8; bits++) {
          final v = {for (final (k, t) in terms.indexed) t: bits & (1 << k) != 0};
          expect(eval(e, v), isFalse, reason: '$e');
        }
      }
      expect(found, greaterThan(100), reason: 'the generator makes contradictions');
    });

    test('what it finds really matches nothing (random terms, complete messages)', () {
      final gen = ExprGen(21);
      final emails = EmailGen(22);
      for (var i = 0; i < 500; i++) {
        final t = gen.term();
        final e = and([gen.expr(2), t, not(t)]);
        expect(findContradiction(e), isNotNull, reason: '$e');
        for (var j = 0; j < 4; j++) {
          final m = emails.next(complete: true);
          expect(
            matchesEmail(e, m.email, content: m.content, accountLabel: m.account, headers: m.headers),
            isFalse,
            reason: '$e',
          );
        }
      }
    });
  });
}
