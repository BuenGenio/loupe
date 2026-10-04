import 'package:mail_model/mail_model.dart';

import '../api.dart';
import 'format.dart' show quoteValue;
import 'lexer.dart';
import 'operators.dart';
import 'values.dart';

/// Completions for the word ending at [cursor]: operator names, `is:` values,
/// tag names, date and size shortcuts.
List<QuerySuggestion> suggestAt(
  String input,
  int cursor, {
  required DateTime now,
  required List<TagDefinition> tags,
  int limit = 10,
}) {
  final c = cursor.clamp(0, input.length);
  bool boundary(int i) => isWs(input[i]) || input[i] == '(' || input[i] == ')';
  var start = c;
  while (start > 0 && !boundary(start - 1)) {
    start--;
  }
  var end = c;
  while (end < input.length && !boundary(end)) {
    end++;
  }
  // Inside a quoted string or a pattern the word is not a term of its own.
  final before = lex(input.substring(0, start));
  if (before.isNotEmpty && before.last.unterminated) return const [];
  if (before.isNotEmpty && (before.last.type == TokType.raw || (before.last.op?.restOfInput ?? false))) {
    return const [];
  }

  var word = input.substring(start, c);
  var neg = '';
  while (word.startsWith('-')) {
    neg += '-';
    word = word.substring(1);
  }
  QuerySuggestion make(String insert, String label, String? detail) =>
      QuerySuggestion(label: label, insertText: '$neg$insert', detail: detail, replaceStart: start, replaceEnd: end);

  final colon = word.indexOf(':');
  if (colon > 0) {
    final name = word.substring(0, colon);
    final op = operatorsByName[name];
    if (op == null) return const [];
    var partial = word.substring(colon + 1);
    var valueNeg = '';
    while (partial.startsWith('-')) {
      valueNeg += '-';
      partial = partial.substring(1);
    }
    if (partial.isNotEmpty && quoteClosers.containsKey(partial[0])) partial = partial.substring(1);
    final lower = partial.toLowerCase();
    return [
      for (final (value, detail) in _values(op, dayOf(now.toLocal()), tags))
        if (_unquoted(value).toLowerCase().startsWith(lower) && _unquoted(value) != partial)
          make('$name:$valueNeg$value', '$name:$value — $detail', detail),
    ].take(limit).toList();
  }
  if (word.contains(RegExp('[^A-Za-z_]'))) return const [];

  final ranked = <(int, OpSpec)>[];
  for (final op in operators) {
    final rank = word.isEmpty
        ? 1
        : op.names.contains(word)
        ? 0
        : op.name.startsWith(word)
        ? 1
        : op.aliases.any((a) => a.startsWith(word))
        ? 2
        : null;
    if (rank != null) ranked.add((rank, op));
  }
  _stableSort(ranked, (a, b) => a.$1.compareTo(b.$1));
  final out = [for (final (_, op) in ranked) make('${op.name}:', '${op.name}: — ${op.summary}', 'e.g. ${op.example}')];

  // "unr" → is:unread, "wor" → tag:Work.
  final lower = word.toLowerCase();
  if (lower.length >= 2) {
    for (final (status, detail) in statusSuggestions) {
      if (status.startsWith(lower)) out.add(make('is:$status', 'is:$status — $detail', detail));
    }
    for (final t in tags) {
      if (t.label.toLowerCase().startsWith(lower)) {
        final value = quoteValue(t.label);
        out.add(make('tag:$value', 'tag:$value — tag', 'tag'));
      }
    }
  }
  return out.take(limit).toList();
}

String _unquoted(String v) => v.startsWith('"') ? v.substring(1) : v;

/// Insertion sort, which keeps equal ranks in table order.
void _stableSort<T>(List<T> xs, int Function(T, T) compare) {
  for (var i = 1; i < xs.length; i++) {
    final x = xs[i];
    var j = i - 1;
    while (j >= 0 && compare(xs[j], x) > 0) {
      xs[j + 1] = xs[j];
      j--;
    }
    xs[j + 1] = x;
  }
}

List<(String, String)> _values(OpSpec op, DateTime today, List<TagDefinition> tags) {
  String day(DateTime d) => '${d.day} ${monthAbbrevs[d.month - 1]} ${d.year}';
  return switch (op.kind) {
    OpKind.status => statusSuggestions,
    OpKind.tag => [for (final t in tags) (quoteValue(t.label), 'tag'), ('na', 'no tag')],
    OpKind.attachment => [('yes', 'has attachments'), ('no', 'no attachments'), ('pdf', 'PDF attachments')],
    OpKind.has => [('attachment', 'has attachments')],
    OpKind.after => [
      ('yesterday', 'today'),
      ('7d', 'the last 7 days'),
      ('1m', 'the last month'),
      ('1y', 'the last year'),
    ],
    OpKind.before => [
      ('today', 'before today'),
      ('7d', 'more than a week ago'),
      ('1m', 'more than a month ago'),
      ('1y', 'more than a year ago'),
    ],
    OpKind.date => [
      ('today', day(today)),
      ('yesterday', day(dayOf(today, -1))),
      (isoDay(today).substring(0, 7), '${monthAbbrevs[today.month - 1]} ${today.year}'),
      ('${today.year}', 'this year'),
    ],
    OpKind.newerThan => [
      ('1d', 'today'),
      ('7d', 'the last 7 days'),
      ('2w', 'the last 2 weeks'),
      ('1m', 'the last month'),
      ('1y', 'the last year'),
    ],
    OpKind.olderThan => [
      ('7d', 'more than a week old'),
      ('1m', 'more than a month old'),
      ('6m', 'more than 6 months old'),
      ('1y', 'more than a year old'),
    ],
    OpKind.larger => [('1M', '1 MB'), ('5M', '5 MB'), ('10M', '10 MB'), ('25M', '25 MB')],
    OpKind.smaller => [('10K', '10 KB'), ('100K', '100 KB'), ('1M', '1 MB')],
    _ => const [],
  };
}
