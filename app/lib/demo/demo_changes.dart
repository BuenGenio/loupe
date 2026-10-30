import 'dart:convert';

import 'package:mail_ai/mail_ai.dart';

/// The built-in demo's answer to `changes.explain` (ChangeExplanationTask): a
/// few rules over the literal line diff instead of a model.
///
/// - A removed and an added line with the same "Label:" and different values
///   are a change, each quoted as written.
/// - One label with two different values in the later message's own lines is
///   a contradiction: the demo doesn't pick the last one.
/// - Added sentences with a request, a date or an amount are new.
/// - Removed bullets and sentences with an obligation, a date or an amount are
///   no longer mentioned, never "cancelled".
///
/// Greetings, sign-offs, signatures, quoted mail and anything near sign-in
/// details are left out. It doesn't understand the mail; the task's parser
/// checks its answer as it would a model's.
String demoChangeExplanation(AiRequest request, DateTime now) {
  final Map<String, Object?> data;
  try {
    data = jsonDecode(request.input.split('\n').first) as Map<String, Object?>;
  } on FormatException {
    return jsonEncode(_nothing);
  }
  final before = _Message(data['before']);
  final after = _Message(data['after']);
  final secrets = [..._secretsIn(before.text), ..._secretsIn(after.text)];
  bool usable(String passage) =>
      passage.isNotEmpty &&
      passage.length <= _maxPassage &&
      !_secretWords.hasMatch(passage) &&
      !secrets.any(passage.contains);
  final removed = [
    for (final l in _strings(data['removed_lines']))
      if (before.own.contains(l)) l,
  ];
  final added = [
    for (final l in _strings(data['added_lines']))
      if (after.own.contains(l)) l,
  ];

  final changed = <Map<String, Object?>>[];
  final news = <Map<String, Object?>>[];
  final gone = <Map<String, Object?>>[];
  final handled = <String>{};

  final removedLabels = <String, _Labelled>{};
  for (final line in removed) {
    if (_Labelled.of(line) case final l? when usable(l.quote)) removedLabels.putIfAbsent(l.key, () => l);
  }
  for (final line in added) {
    final entry = _Labelled.of(line);
    if (entry == null || !usable(entry.quote) || !handled.add(entry.key)) continue;
    final others = [
      for (final own in after.ownLines)
        if (_Labelled.of(own) case final o? when o.key == entry.key && o.fold != entry.fold && usable(o.quote)) o,
    ];
    final earlier = removedLabels[entry.key];
    if (others.isNotEmpty) {
      changed.add(
        _change(
          'contradiction',
          entry.label,
          before: others.first.value,
          beforeQuote: others.first.quote,
          after: entry.value,
          afterQuote: entry.quote,
        ),
      );
    } else if (earlier != null && earlier.fold != entry.fold) {
      changed.add(
        _change(
          'changed',
          entry.label,
          before: earlier.value,
          beforeQuote: earlier.quote,
          after: entry.value,
          afterQuote: entry.quote,
        ),
      );
    } else if (earlier == null && !before.text.contains(entry.quote)) {
      news.add(_change('added', entry.label, after: entry.value, afterQuote: entry.quote));
    }
  }
  for (final MapEntry(key: key, value: entry) in removedLabels.entries) {
    if (handled.contains(key) || after.text.contains(entry.quote)) continue;
    if (after.ownLines.any((own) => _Labelled.of(own)?.key == key)) continue;
    gone.add(_change('removed', entry.label, before: entry.value, beforeQuote: entry.quote));
  }

  for (final line in added) {
    if (_Labelled.of(line) != null || _greeting.hasMatch(line) || line.endsWith(':')) continue;
    for (final sentence in _sentences(line)) {
      if (usable(sentence) &&
          !_pointer.hasMatch(sentence) &&
          (_request.hasMatch(sentence) || _date.hasMatch(sentence) || _amount.hasMatch(sentence)) &&
          !before.text.contains(sentence)) {
        news.add(_change('added', _shortLabel(sentence), after: sentence, afterQuote: sentence));
      }
    }
  }
  for (final line in removed) {
    if (_Labelled.of(line) != null || _greeting.hasMatch(line) || line.endsWith(':')) continue;
    final bullet = _bullet.firstMatch(line);
    final passages = bullet != null ? [line.substring(bullet.end).trim()] : _sentences(line);
    for (final passage in passages) {
      if (!usable(passage) || _pointer.hasMatch(passage) || after.text.contains(passage)) continue;
      if (bullet != null || _obligation.hasMatch(passage) || _date.hasMatch(passage) || _amount.hasMatch(passage)) {
        gone.add(_change('removed', _shortLabel(passage), before: passage, beforeQuote: passage));
      }
    }
  }

  final quoted = <String>{};
  final changes = [
    for (final c in [...changed, ...news, ...gone])
      if (quoted.add('${c['kind']}\n${c['before_quote']}\n${c['after_quote']}')) c,
  ].take(ChangeExplanationTask.maxChanges).toList();
  if (changes.isEmpty) return jsonEncode(_nothing);
  return jsonEncode({'summary': _summary(changes), 'no_change_in_meaning': false, 'changes': changes});
}

const _nothing = {
  'summary': 'Only greetings, wording or layout differ, as far as the demo’s rules can tell.',
  'no_change_in_meaning': true,
  'changes': <Object?>[],
};

const _maxPassage = 280;

/// One message of the request: its text, and the lines that are its own
/// words: before a sign-off, a signature or a quote header, and not quoted.
final class _Message {
  _Message(Object? raw) : text = raw is Map<String, Object?> ? (raw['text'] as String?) ?? '' : '' {
    for (final rawLine in text.split('\n')) {
      final line = rawLine.trim();
      if (line == '--' || _signOff.hasMatch(line) || _quoteHeader.hasMatch(line)) break;
      if (line.isEmpty || line.startsWith('>')) continue;
      ownLines.add(line);
    }
    own.addAll(ownLines);
  }

  final String text;
  final ownLines = <String>[];
  final own = <String>{};
}

/// A "Label: value" line, with the value's first sentence when the rest is long.
final class _Labelled {
  const _Labelled(this.label, this.value, this.quote);

  final String label;
  final String value;
  final String quote;

  String get key => label.toLowerCase();
  String get fold => value.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');

  static _Labelled? of(String line) {
    final m = _labelled.firstMatch(line);
    if (m == null) return null;
    final label = m.group(1)!;
    if (label.split(' ').length > 5 || _greeting.hasMatch(line)) return null;
    final value = m.group(2)!.length > 160 ? _sentences(m.group(2)!).first : m.group(2)!;
    return _Labelled(label, value, '$label: $value');
  }
}

Map<String, Object?> _change(
  String kind,
  String label, {
  String? before,
  String? after,
  String? beforeQuote,
  String? afterQuote,
}) => {
  'kind': kind,
  'label': label,
  'before': before,
  'after': after,
  'before_quote': beforeQuote,
  'after_quote': afterQuote,
};

String _summary(List<Map<String, Object?>> changes) {
  int count(String kind) => changes.where((c) => c['kind'] == kind).length;
  final labels = [
    for (final c in changes)
      if (c['kind'] == 'changed') c['label']! as String,
  ];
  final named = [for (var i = 0; i < labels.length; i++) i == 0 ? labels[i] : _lowerFirst(labels[i])];
  final conflicts = count('contradiction');
  final added = count('added');
  final removed = count('removed');
  final parts = [
    if (labels.length == 1) '${named.single} differs',
    if (labels.length > 1 && labels.length <= 3) '${named.take(labels.length - 1).join(', ')} and ${named.last} differ',
    if (labels.length > 3) '${labels.length} values differ',
    if (conflicts == 1) 'one point conflicts',
    if (conflicts > 1) '$conflicts points conflict',
    if (added == 1) 'one thing is new',
    if (added > 1) '$added things are new',
    if (removed == 1) 'one point is no longer mentioned',
    if (removed > 1) '$removed points are no longer mentioned',
  ];
  final text = parts.join('; ');
  return '${text[0].toUpperCase()}${text.substring(1)}.';
}

String _lowerFirst(String s) =>
    s.length > 1 && s[1] == s[1].toLowerCase() ? '${s[0].toLowerCase()}${s.substring(1)}' : s;

/// A few words for a passage: its first clause, without "Please" or an
/// article, at most six words.
String _shortLabel(String passage) {
  var t = passage.replaceFirst(RegExp(r'^(please|kindly)\s+', caseSensitive: false), '');
  final cut = _clauseEnd.firstMatch(t);
  if (cut != null && cut.start > 0) t = t.substring(0, cut.start);
  t = t.replaceFirst(RegExp(r'^(a|an|the|your|our)\s+', caseSensitive: false), '').trim();
  if (t.endsWith('.')) t = t.substring(0, t.length - 1);
  final words = t.split(RegExp(r'\s+'));
  if (words.length > 6) t = '${words.take(6).join(' ')}…';
  if (t.length > 50) t = '${t.substring(0, 49).trimRight()}…';
  return t.isEmpty ? passage.substring(0, passage.length.clamp(0, 40)) : '${t[0].toUpperCase()}${t.substring(1)}';
}

Iterable<String> _strings(Object? raw) => raw is List ? raw.whereType<String>() : const [];

List<String> _sentences(String line) =>
    line.split(RegExp(r'(?<=[.!?])\s+(?=[A-Z0-9“"])')).map((s) => s.trim()).where((s) => s.isNotEmpty).toList();

/// The values ChangeExplanationTask's parser treats as sign-in details, so the
/// demo never offers a passage it would reject.
Iterable<String> _secretsIn(String text) => RegExp(
  r'\b(?:password|passcode|pin|otp|one-time code|login code|verification code|access code|code)\b\s*(?:is|:|=)\s*["“]?([^\s"”.,;!?]{4,})',
  caseSensitive: false,
).allMatches(text).map((m) => m.group(1)!);

final _secretWords = RegExp(r'\b(password|passcode|pin|otp|code|login)\b', caseSensitive: false);
final _labelled = RegExp(r'^([A-Z][^:]{0,38}[^\s:]):\s+(\S.*)$');
final _bullet = RegExp(r'^(?:[-*•]|\d{1,2}[.)])\s+');
final _signOff = RegExp(
  r'^(kind regards|regards|best wishes|best|many thanks|thanks|thank you|cheers|yours sincerely|yours)[,!.]?$',
  caseSensitive: false,
);
final _quoteHeader = RegExp(
  r'^(?:On .{4,200} wrote:|-{2,} ?(?:Original Message|Forwarded message) ?-{2,}|Begin forwarded message:)$',
  caseSensitive: false,
);
final _greeting = RegExp(
  r'^(dear|hi|hello|hey|good (morning|afternoon|evening))\b[^.!?:]{0,40}[,!]?$',
  caseSensitive: false,
);
final _pointer = RegExp(
  r'^(please )?(find|see)\b.*\b(attached|enclosed|below)\b|^attached\b|\battached (is|are)\b',
  caseSensitive: false,
);
final _request = RegExp(
  r'^(please|kindly)\b|^(could|can|would|will) you\b|\?$|^(sign|pay|send|complete|fill|book|call|reply|confirm|return|upload|provide|bring|check|choose|let us know|tell)\b',
  caseSensitive: false,
);
final _obligation = RegExp(
  r'\b(has to|have to|must|need to|needs to|required|requires|we need)\b',
  caseSensitive: false,
);
final _date = RegExp(
  r'\b\d{1,2}(st|nd|rd|th)? (January|February|March|April|May|June|July|August|September|October|November|December)\b'
  r'|\b(January|February|March|April|May|June|July|August|September|October|November|December) \d{1,2}\b'
  r'|\b(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)\b|\b\d{1,2}:\d{2}\b',
);
final _amount = RegExp(r'[£$€]\s?\d|\b\d+([.,]\d+)?\s?%|\b\d[\d,.]* ?(GBP|EUR|USD)\b');
final _clauseEnd = RegExp(
  r'[,;:]|\s\(|\s(showing|whether|so that|because|which|that|at|for|from|with|once|if|when)\s',
  caseSensitive: false,
);
