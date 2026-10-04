import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/terms.dart';

List<String> inserts(String input, [int? cursor]) => [
  for (final s in suggest(input, cursor ?? input.length, now: testNow)) s.insertText,
];

void main() {
  group('operators', () {
    test('an alias completes to its operator first', () {
      final s = suggest('f', 1, now: testNow);
      expect(s.first.insertText, 'from:');
      expect(s.first.label, 'from: — sender contains');
      expect(s.first.detail, 'e.g. from:alice');
    });

    test('prefixes of names', () {
      expect(inserts('fro'), containsAllInOrder(['from:', 'fromto:', 'fromre:']));
      expect(inserts('sub'), ['subject:', 'regex:']); // regex has the alias subre
      expect(inserts('is'), contains('is:'));
      expect(inserts('older'), ['older_than:']);
    });

    test('negation is kept', () => expect(inserts('-fro').first, '-from:'));
    test('empty word lists the main operators', () => expect(inserts('').take(3), ['from:', 'to:', 'subject:']));
    test('unknown words give nothing', () => expect(inserts('zzz'), isEmpty));
    test('limit', () => expect(suggest('', 0).length, lessThanOrEqualTo(10)));
  });

  group('values', () {
    final cases = <(String, List<String>)>[
      ('is:un', ['is:unread', 'is:unflagged', 'is:unreplied']),
      ('is:-un', ['is:-unread', 'is:-unflagged', 'is:-unreplied']),
      ('-is:fl', ['-is:flagged']),
      ('i:rep', ['i:replied']),
      ('tag:wo', ['tag:Work']),
      ('tag:to', ['tag:"To Do"']),
      ('tag:"to', ['tag:"To Do"']),
      ('tag:n', ['tag:na']),
      ('a:', ['a:yes', 'a:no', 'a:pdf']),
      ('has:', ['has:attachment']),
      ('after:', ['after:yesterday', 'after:7d', 'after:1m', 'after:1y']),
      ('before:t', ['before:today']),
      ('date:', ['date:today', 'date:yesterday', 'date:2026-10', 'date:2026']),
      ('newer_than:', ['newer_than:1d', 'newer_than:7d', 'newer_than:2w', 'newer_than:1m', 'newer_than:1y']),
      ('larger:', ['larger:1M', 'larger:5M', 'larger:10M', 'larger:25M']),
      ('sm:1', ['sm:10K', 'sm:100K', 'sm:1M']),
      ('is:unread', []),
      ('from:al', []),
      ('x:y', []),
    ];
    for (final (input, expected) in cases) {
      test(input, () => expect(inserts(input), expected));
    }

    test('date shortcuts describe the day', () {
      final today = suggest('date:to', 7, now: testNow).single;
      expect(today.detail, '4 Oct 2026');
      expect(today.label, 'date:today — 4 Oct 2026');
    });
  });

  group('shortcuts', () {
    test('status words', () => expect(inserts('unr'), contains('is:unread')));
    test('tag labels', () => expect(inserts('wor'), contains('tag:Work')));
    test('custom tags', () {
      const tags = [TagDefinition(keyword: 'x', label: 'Client A', colorArgb: 0)];
      expect([for (final s in suggest('cli', 3, tags: tags)) s.insertText], contains('tag:"Client A"'));
    });
  });

  group('context', () {
    test('word in the middle of the query and its range', () {
      final s = suggest('f:alice unr s:x', 11, now: testNow);
      expect(s.map((x) => x.insertText), contains('is:unread'));
      expect((s.first.replaceStart, s.first.replaceEnd), (8, 11));
    });

    test('cursor inside a word replaces the whole word', () {
      final s = suggest('subj', 2, now: testNow);
      expect(s.first.insertText, 'subject:');
      expect((s.first.replaceStart, s.first.replaceEnd), (0, 4));
    });

    test('after a parenthesis', () {
      final s = suggest('(f', 2, now: testNow);
      expect(s.first.insertText, 'from:');
      expect(s.first.replaceStart, 1);
    });

    test('nothing inside quotes, patterns or rest-of-input values', () {
      expect(inserts('"weekend unr'), isEmpty);
      expect(inserts('/abc unr'), isEmpty);
      expect(inserts('simple:x is:un'), isEmpty);
      expect(inserts('re: is:un'), isEmpty);
    });

    test('out-of-range cursors are clamped', () {
      expect(() => suggest('fro', 99), returnsNormally);
      expect(() => suggest('fro', -5), returnsNormally);
      expect(suggest('', 0, now: testNow), isNotEmpty);
    });
  });
}
