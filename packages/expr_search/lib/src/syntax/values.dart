import 'package:mail_model/mail_model.dart';

/// The result of interpreting an operator value.
sealed class Parsed<T> {
  const Parsed();
}

final class Ok<T> extends Parsed<T> {
  const Ok(this.value);
  final T value;
}

/// A value that could not be interpreted, with a message for the user.
final class Err<T> extends Parsed<T> {
  const Err(this.message);
  final String message;
}

// ---------------------------------------------------------------- dates

/// Local midnight of [d]'s calendar day, [days] later.
DateTime dayOf(DateTime d, [int days = 0]) => DateTime(d.year, d.month, d.day + days);

/// [d] moved back by [months], clamping the day to the target month.
DateTime monthsBefore(DateTime d, int months) {
  final first = DateTime(d.year, d.month - months);
  final last = DateTime(first.year, first.month + 1, 0).day;
  return DateTime(first.year, first.month, d.day > last ? last : d.day);
}

/// A run of whole local days, `[start, end)`.
typedef DaySpan = ({DateTime start, DateTime end});

const monthAbbrevs = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

final _isoDay = RegExp(r'^(\d{4})[-/.](\d{1,2})[-/.](\d{1,2})(?:[ T,]+(.*))?$');
final _isoMonth = RegExp(r'^(\d{4})[-/.](\d{1,2})$');
final _year = RegExp(r'^\d{4}$');
final _relative = RegExp(r'^(\d{1,5})\s*([dwmy])$', caseSensitive: false);
final _timeOnly = RegExp(r'^\d{1,2}:\d{2}(:\d{2})?(\s*[ap]m)?$', caseSensitive: false);
final _dayMonYear = RegExp(
  r'^(?:[a-z]+,?\s+)?(\d{1,2})[\s-]+([a-z]+)\.?,?[\s-]+(\d{4})(?:\s+(.*))?$',
  caseSensitive: false,
);
final _monDayYear = RegExp(r'^(?:[a-z]+,?\s+)?([a-z]+)\.?\s+(\d{1,2}),?\s+(\d{4})(?:\s+(.*))?$', caseSensitive: false);
final _clock = RegExp(r'^\d{1,2}:\d{2}(:\d{2})?');

/// Parses a day, month or year, or a day relative to [today]: `today`,
/// `yesterday`, `7d`, `2w`, `3m`, `1y` (that long ago), `2026-03-01`,
/// `2026/03`, `2026`, `1 Mar 2026`, `Mar 1, 2026`. A time after a full date
/// is ignored, since terms compare whole days.
Parsed<DaySpan> parseDaySpan(String input, DateTime today) {
  final v = input.trim();
  final lower = v.toLowerCase();
  Ok<DaySpan> day(DateTime d) => Ok((start: d, end: dayOf(d, 1)));
  switch (lower) {
    case 'today':
      return day(today);
    case 'yesterday':
      return day(dayOf(today, -1));
    case 'tomorrow':
      return day(dayOf(today, 1));
  }
  final rel = _relative.firstMatch(v);
  if (rel != null) return day(ago(today, int.parse(rel[1]!), rel[2]!.toLowerCase()));
  if (_timeOnly.hasMatch(v)) return const Err('Times of day are not supported; use a date');
  final iso = _isoDay.firstMatch(v);
  if (iso != null) {
    if (iso[4] != null && !_clock.hasMatch(iso[4]!)) return Err('Not a date: $v');
    final d = _validDay(int.parse(iso[1]!), int.parse(iso[2]!), int.parse(iso[3]!));
    return d == null ? Err('Not a valid date: $v') : day(d);
  }
  final month = _isoMonth.firstMatch(v);
  if (month != null) {
    final y = int.parse(month[1]!);
    final m = int.parse(month[2]!);
    if (m < 1 || m > 12) return Err('Not a valid month: $v');
    return Ok((start: DateTime(y, m), end: DateTime(y, m + 1)));
  }
  if (_year.hasMatch(v)) {
    final y = int.parse(v);
    return Ok((start: DateTime(y), end: DateTime(y + 1)));
  }
  for (final (re, dayGroup, monthGroup) in [(_dayMonYear, 1, 2), (_monDayYear, 2, 1)]) {
    final m = re.firstMatch(v);
    if (m == null || (m[4] != null && !_clock.hasMatch(m[4]!))) continue;
    final mon = _monthNumber(m[monthGroup]!);
    if (mon == null) continue;
    final d = _validDay(int.parse(m[3]!), mon, int.parse(m[dayGroup]!));
    if (d != null) return day(d);
  }
  return Err('Not a date: $v');
}

/// [today] moved back by [n] days, weeks, months or years.
DateTime ago(DateTime today, int n, String unit) => switch (unit) {
  'w' => dayOf(today, -7 * n),
  'm' => monthsBefore(today, n),
  'y' => monthsBefore(today, 12 * n),
  _ => dayOf(today, -n),
};

int? _monthNumber(String name) {
  final lower = name.toLowerCase();
  if (lower.length < 3) return null;
  for (var i = 0; i < 12; i++) {
    final abbrev = monthAbbrevs[i].toLowerCase();
    if (lower.startsWith(abbrev) || (lower == 'sept' && i == 8)) return i + 1;
  }
  return null;
}

DateTime? _validDay(int y, int m, int d) {
  if (m < 1 || m > 12 || d < 1) return null;
  if (d > DateTime(y, m + 1, 0).day) return null;
  return DateTime(y, m, d);
}

/// An age cutoff: `older_than:` means received before [cutoff]; `newer_than:`
/// means received after it, or on it when [inclusive].
typedef Age = ({DateTime cutoff, bool inclusive});

/// The cutoff day for `older_than:` / `newer_than:`: `today`, `yesterday`,
/// or an age (`7`, `7d`, `2w`, `3m`, `1y`).
Parsed<Age> parseAge(String input, DateTime today) {
  final v = input.trim().toLowerCase();
  if (v == 'today') return Ok((cutoff: today, inclusive: true));
  if (v == 'yesterday') return Ok((cutoff: dayOf(today, -1), inclusive: true));
  final m = RegExp(r'^(\d{1,5})\s*([dwmy]?)$').firstMatch(v);
  if (m == null) return Err('Not an age: $input (try 7d, 2w, 3m or 1y)');
  final unit = m[2]!.isEmpty ? 'd' : m[2]!;
  return Ok((cutoff: ago(today, int.parse(m[1]!), unit), inclusive: false));
}

/// `yyyy-mm-dd`.
String isoDay(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

// ---------------------------------------------------------------- sizes

final _size = RegExp(r'^(\d+(?:\.\d*)?|\.\d+)\s*(b|k|kb|m|mb|g|gb)?$', caseSensitive: false);

/// Bytes for a size in KB (desktop default) or with a unit: `500`, `500K`,
/// `0.5M`, `2G`, `1234B`.
Parsed<int> parseSize(String input) {
  final m = _size.firstMatch(input.trim());
  if (m == null) return Err('Not a size: ${input.trim()} (try 500K or 2M)');
  final n = double.parse(m[1]!);
  final mult = switch ((m[2] ?? 'k').toLowerCase()[0]) {
    'b' => 1,
    'm' => 1024 * 1024,
    'g' => 1024 * 1024 * 1024,
    _ => 1024,
  };
  final bytes = n * mult;
  if (bytes > 1e15) return const Err('Size too large');
  return Ok(bytes.round());
}

/// Canonical size text that [parseSize] reads back exactly.
String sizeText(int bytes) {
  const k = 1024;
  if (bytes > 0 && bytes % (k * k * k) == 0) return '${bytes ~/ (k * k * k)}G';
  if (bytes > 0 && bytes % (k * k) == 0) return '${bytes ~/ (k * k)}M';
  if (bytes > 0 && bytes % k == 0) return '${bytes ~/ k}K';
  return '${bytes}B';
}

/// Human size for descriptions: "500 KB", "1.5 MB".
String humanSize(int bytes) {
  const units = ['bytes', 'KB', 'MB', 'GB'];
  var v = bytes.toDouble();
  var u = 0;
  while (v >= 1024 && u < units.length - 1) {
    v /= 1024;
    u++;
  }
  final text = v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);
  return '$text ${units[u]}';
}

// ---------------------------------------------------------------- status

/// `is:` values. Thunderbird's `new` has no mobile equivalent and means unread.
final Map<String, SearchExpr> statusValues = {
  'read': const KeywordTerm(Keywords.seen),
  'seen': const KeywordTerm(Keywords.seen),
  'unread': const SearchNot(KeywordTerm(Keywords.seen)),
  'unseen': const SearchNot(KeywordTerm(Keywords.seen)),
  'new': const SearchNot(KeywordTerm(Keywords.seen)),
  'flagged': const KeywordTerm(Keywords.flagged),
  'starred': const KeywordTerm(Keywords.flagged),
  'marked': const KeywordTerm(Keywords.flagged),
  'unflagged': const SearchNot(KeywordTerm(Keywords.flagged)),
  'unstarred': const SearchNot(KeywordTerm(Keywords.flagged)),
  'unmarked': const SearchNot(KeywordTerm(Keywords.flagged)),
  'replied': const KeywordTerm(Keywords.answered),
  'answered': const KeywordTerm(Keywords.answered),
  'unreplied': const SearchNot(KeywordTerm(Keywords.answered)),
  'unanswered': const SearchNot(KeywordTerm(Keywords.answered)),
  'forwarded': const KeywordTerm(Keywords.forwarded),
  'draft': const KeywordTerm(Keywords.draft),
  'junk': const KeywordTerm(Keywords.junk),
  'spam': const KeywordTerm(Keywords.junk),
  'attachment': const HasAttachmentTerm(),
};

/// Canonical `is:` names, with a description, for formatting and suggestions.
const statusSuggestions = <(String, String)>[
  ('unread', 'unread messages'),
  ('read', 'read messages'),
  ('flagged', 'flagged messages'),
  ('unflagged', 'messages without a flag'),
  ('replied', 'messages you replied to'),
  ('unreplied', 'messages you have not replied to'),
  ('forwarded', 'forwarded messages'),
  ('draft', 'drafts'),
  ('junk', 'messages marked as junk'),
  ('attachment', 'messages with attachments'),
];

/// The `is:` name for a keyword, or for its negation.
String? statusNameFor(String keyword, {required bool negated}) => negated
    ? switch (keyword) {
        Keywords.seen => 'unread',
        Keywords.flagged => 'unflagged',
        Keywords.answered => 'unreplied',
        _ => null,
      }
    : switch (keyword) {
        Keywords.seen => 'read',
        Keywords.flagged => 'flagged',
        Keywords.answered => 'replied',
        Keywords.forwarded => 'forwarded',
        Keywords.draft => 'draft',
        Keywords.junk => 'junk',
        _ => null,
      };

// ---------------------------------------------------------------- tags

/// What `tag:` means for [input]: an exact label, the labels containing the
/// text, the n-th tag (`#2`), no tag (`na`), or else a raw keyword. The
/// value is null when the term can't narrow anything (`na` without tags).
Parsed<SearchExpr?> resolveTag(String input, List<TagDefinition> tags) {
  final v = input.trim();
  if (v.isEmpty) return const Err('Missing tag name');
  final lower = v.toLowerCase();
  if (lower == 'na') {
    final none = [for (final t in tags) SearchNot(KeywordTerm(Keywords.normalize(t.keyword)))];
    return Ok(none.isEmpty ? null : (none.length == 1 ? none.single : SearchAnd(none)));
  }
  final nth = RegExp(r'^#(\d+)$').firstMatch(v);
  if (nth != null) {
    final n = int.parse(nth[1]!);
    if (n < 1 || n > tags.length) return Err('There is no tag #$n');
    return Ok(KeywordTerm(Keywords.normalize(tags[n - 1].keyword)));
  }
  for (final t in tags) {
    if (t.label.toLowerCase() == lower) return Ok(KeywordTerm(Keywords.normalize(t.keyword)));
  }
  final partial = [
    for (final t in tags)
      if (t.label.toLowerCase().contains(lower)) KeywordTerm(Keywords.normalize(t.keyword)),
  ];
  if (partial.length == 1) return Ok(partial.single);
  if (partial.length > 1) return Ok(SearchOr(partial));
  return Ok(KeywordTerm(Keywords.normalize(v)));
}

/// The label of the tag with [keyword], if one is defined.
String? tagLabel(String keyword, List<TagDefinition> tags) {
  for (final t in tags) {
    if (Keywords.normalize(t.keyword) == keyword) return t.label;
  }
  return null;
}

// ---------------------------------------------------------------- regex

/// The literal text a pattern matches, if it has no special characters
/// (escaped punctuation counts as literal); otherwise null.
String? literalOfPattern(String pattern) {
  const meta = r'.^$|?*+()[]{}';
  final buf = StringBuffer();
  for (var i = 0; i < pattern.length; i++) {
    final c = pattern[i];
    if (c == r'\') {
      if (i + 1 >= pattern.length) return null;
      final n = pattern[i + 1];
      if (RegExp('[A-Za-z0-9]').hasMatch(n)) return null;
      buf.write(n);
      i++;
    } else if (meta.contains(c)) {
      return null;
    } else {
      buf.write(c);
    }
  }
  return buf.toString();
}
