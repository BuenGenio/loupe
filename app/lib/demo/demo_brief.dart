import 'dart:convert';

import 'package:mail_ai/mail_ai.dart';

/// The built-in demo's answer to `brief.message` (BriefTask): a few rules
/// instead of a model. It reads the message's own lines (not quoted mail, not
/// the signature), takes requests from bullet lists under "we need" or
/// "please", sentences that start with "Please", questions put to the
/// reader, promises ("I will…"), conditions ("Once…", "If…") and stated
/// dates, and quotes each passage exactly, so BriefTask's parser checks the
/// answer as it would a model's. Lines with sign-in details are never quoted.
/// It does not understand the mail: a scam's "pay the fee" is listed like any
/// request, which is why the Brief keeps the security warning above it.
String demoBrief(AiRequest request, DateTime now) {
  final Map<String, Object?> data;
  try {
    data = jsonDecode(request.input.split('\n').first) as Map<String, Object?>;
  } on FormatException {
    return jsonEncode({'summary': '', 'nothing_to_summarise': true, 'items': <Object?>[]});
  }
  final text = (data['text'] as String?) ?? '';
  final from = (data['from'] as String?) ?? '';
  final sent = DateTime.tryParse((data['date'] as String?) ?? '') ?? now;
  final items = _items(text, sent);
  final mine = items.where((i) => i['owner'] == 'me' && (i['kind'] == 'action' || i['kind'] == 'document')).toList();
  return jsonEncode({
    'summary': _summary(_senderName(from), mine, items),
    'nothing_to_summarise': items.isEmpty,
    'items': items,
  });
}

String _senderName(String from) {
  final lt = from.indexOf('<');
  final name = (lt > 0 ? from.substring(0, lt) : from).replaceAll('"', '').trim();
  return name.isEmpty ? 'The sender' : name;
}

String _summary(String sender, List<Map<String, Object?>> mine, List<Map<String, Object?>> items) {
  if (items.isEmpty) return 'Nothing in this message asks anything of you.';
  final out = StringBuffer();
  if (mine.isEmpty) {
    out.write(
      '$sender asks nothing of you here, but states ${items.length == 1 ? 'one thing' : '${items.length} things'} to keep track of.',
    );
  } else {
    out.write('$sender asks you for ${mine.length == 1 ? 'one thing' : '${mine.length} things'}');
    final app = mine.where((i) => (i['channel'] as String?)?.contains(' app') ?? false).length;
    if (app == 1) out.write('; one has to be done in an app');
    if (app > 1) out.write('; $app have to be done in an app');
    final deadline = mine
        .map((i) => i['due']! as Map<String, Object?>)
        .where((d) => d['kind'] == 'explicit')
        .firstOrNull;
    if (deadline != null) out.write(', ${deadline['text']}');
    out.write('.');
  }
  if (items.any((i) => i['kind'] == 'next')) out.write(' It also says what happens next.');
  return out.toString();
}

final _signOff = RegExp(
  r'^(kind regards|regards|best wishes|best|many thanks|thanks|thank you|cheers|yours sincerely|yours)[,!.]?$',
  caseSensitive: false,
);
final _bullet = RegExp(r'^(?:[-*•]|\d{1,2}[.)])\s+');
final _secretWords = RegExp(
  r'\b(password|passcode|pin|otp|one-time code|login code|verification code|access code)\b',
  caseSensitive: false,
);
final _requestIntro = RegExp(
  r'\b(we need|we require|please|need the following|to get started)\b',
  caseSensitive: false,
);
final _imperative = RegExp(
  r'^(please\s+)?(sign|pay|send|complete|fill|book|call|reply|confirm|return|upload|provide|bring|check|choose|let us know|tell)\b',
  caseSensitive: false,
);
final _documentWords = RegExp(
  r'\b(statement|calculation|overview|letter|copy|certificate|payslip|passport|licence|license|SA302|P60|invoice|contract|document|report|receipt)\b',
  caseSensitive: false,
);
final _question = RegExp(r'^(could|can|would|will|should|do|did|are|is)\s+(you|we)\b|\?$', caseSensitive: false);
final _promise = RegExp(r"\b(I|we)\s+(will|'ll|shall)\b|\bI'll\b|\bwe'll\b|\bwill (be|then)\b", caseSensitive: false);
final _condition = RegExp(r'^(once|if|when|as soon as)\b', caseSensitive: false);
final _onceClause = RegExp(r'\b(once|as soon as|after)\s+[^,.;:]+', caseSensitive: false);
final _channel = RegExp(r'\b(in the [A-Z][\w-]*(?: [A-Z][\w-]*)* app|by bank transfer|by email|by post|online)\b');
const _monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];
final _date = RegExp(
  r'\b(by |before |until |on |for )?((?:Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday) )?(\d{1,2}) (January|February|March|April|May|June|July|August|September|October|November|December)\b',
);

/// The message's own passages worth listing, as BriefTask items.
List<Map<String, Object?>> _items(String text, DateTime sent) {
  final items = <Map<String, Object?>>[];
  final seen = <String>{};
  final emailOk = RegExp(
    r'everything else can be emailed|can be emailed|email (them|it) to me',
    caseSensitive: false,
  ).hasMatch(text);
  var underRequests = false;

  for (final rawLine in text.split('\n')) {
    final line = rawLine.trim();
    if (line.isEmpty) {
      continue;
    }
    if (line.startsWith('>')) continue;
    if (line == '--' || _signOff.hasMatch(line)) break;
    if (_secretWords.hasMatch(line)) continue;

    final bullet = _bullet.firstMatch(line);
    if (bullet != null) {
      final passage = line.substring(bullet.end).trim();
      if (passage.isEmpty) continue;
      if (underRequests || _imperative.hasMatch(passage)) {
        _add(items, seen, _request(passage, sent, emailOk));
      }
      continue;
    }
    underRequests = line.endsWith(':') && _requestIntro.hasMatch(line);
    if (underRequests) continue;

    for (final sentence in _sentences(line)) {
      if (_secretWords.hasMatch(sentence)) continue;
      final item = _classify(sentence, sent, emailOk);
      if (item != null) _add(items, seen, item);
    }
  }
  return items.take(BriefTask.maxItems).toList();
}

void _add(List<Map<String, Object?>> items, Set<String> seen, Map<String, Object?>? item) {
  if (item == null || !seen.add(item['quote']! as String)) return;
  items.add(item);
}

Iterable<String> _sentences(String line) =>
    line.split(RegExp(r'(?<=[.!?])\s+(?=[A-Z0-9“"])')).map((s) => s.trim()).where((s) => s.isNotEmpty);

Map<String, Object?> _request(String passage, DateTime sent, bool emailOk) {
  final document =
      !_imperative.hasMatch(passage) &&
      _documentWords.hasMatch(passage) &&
      !RegExp(r'\b(check|form)\b', caseSensitive: false).hasMatch(passage);
  final channel = _channel.firstMatch(passage)?.group(1) ?? (document && emailOk ? 'by email' : null);
  return _item(document ? 'document' : 'action', passage, owner: 'me', channel: channel, due: _dueOf(passage, sent));
}

Map<String, Object?>? _classify(String sentence, DateTime sent, bool emailOk) {
  final lower = sentence.toLowerCase();
  // "Please find attached…" points at something; it asks nothing.
  if (RegExp(r'^(please )?(find|see)\b.*\b(attached|enclosed|below)\b', caseSensitive: false).hasMatch(sentence)) {
    return null;
  }
  // "We will never change our bank details by email" is a warning, not a step.
  if (lower.contains('will never')) return null;
  if (lower.startsWith('please ') || lower.startsWith('kindly ')) {
    return _request(sentence, sent, emailOk);
  }
  if (sentence.endsWith('?') && _question.hasMatch(sentence)) {
    return _item('action', sentence, owner: 'me', text: 'Answer: ${_shorten(sentence)}');
  }
  if (RegExp(r'\b(amount due|is due|are due|balance)\b', caseSensitive: false).hasMatch(sentence)) {
    var due = _dueOf(sentence, sent);
    if (due['date'] == null) {
      final when = RegExp(r'\bdue\s+(.+?)\.?$', caseSensitive: false).firstMatch(sentence)?.group(1);
      if (when != null) due = {'kind': 'conditional', 'text': when, 'date': null};
    }
    final payable = RegExp(r'\bamount due\b', caseSensitive: false).hasMatch(sentence);
    return _item(payable ? 'action' : 'date', sentence, owner: payable ? 'me' : 'unknown', due: due);
  }
  if (_condition.hasMatch(sentence)) {
    final clause = _onceClause.firstMatch(sentence)?.group(0) ?? sentence.split(',').first;
    final yours = RegExp(
      r',\s*(please\s+)?(reply|call|send|let us know|tell)\b',
      caseSensitive: false,
    ).hasMatch(sentence);
    return _item(
      'condition',
      sentence,
      owner: yours ? 'me' : 'them',
      due: {'kind': 'conditional', 'text': clause.trim(), 'date': null},
    );
  }
  if (_promise.hasMatch(sentence) || lower.startsWith('next steps')) {
    final clause = _onceClause.firstMatch(sentence)?.group(0);
    final dated = _dueOf(sentence, sent);
    return _item(
      'next',
      sentence,
      owner: 'them',
      text: _shorten(sentence.replaceFirst(RegExp(r'^next steps:\s*', caseSensitive: false), '')),
      due: clause != null ? {'kind': 'conditional', 'text': clause.trim(), 'date': null} : dated,
    );
  }
  final dated = _dueOf(sentence, sent);
  if (dated['date'] != null) return _item('date', sentence, owner: 'them', due: dated);
  return null;
}

Map<String, Object?> _item(
  String kind,
  String quote, {
  required String owner,
  String? text,
  String? channel,
  Map<String, Object?>? due,
}) => {
  'kind': kind,
  'text': text ?? _shorten(quote),
  'quote': quote,
  'channel': channel,
  'owner': owner,
  'due': due ?? const {'kind': 'none', 'text': null, 'date': null},
};

/// A stated calendar date in [passage], as BriefTask wants it: the wording
/// and the date, never one worked out from "next week".
Map<String, Object?> _dueOf(String passage, DateTime sent) {
  final m = _date.firstMatch(passage);
  if (m == null) return const {'kind': 'none', 'text': null, 'date': null};
  final month = _monthNames.indexOf(m.group(4)!) + 1;
  final day = int.parse(m.group(3)!);
  var year = sent.year;
  if (DateTime(year, month, day).isBefore(sent.subtract(const Duration(days: 60)))) year++;
  final date = DateTime(year, month, day);
  final preposition = m.group(1)?.trim();
  final firm = preposition == 'by' || preposition == 'before' || preposition == 'until';
  return {
    'kind': firm || preposition == null || preposition == 'on' || preposition == 'for' ? 'explicit' : 'suggested',
    'text': m.group(0)!.trim(),
    'date': date.toIso8601String().substring(0, 10),
  };
}

String _shorten(String s) {
  var t = s.trim().replaceFirst(RegExp(r'^(please|kindly)\s+', caseSensitive: false), '');
  if (t.endsWith('.')) t = t.substring(0, t.length - 1);
  if (t.isNotEmpty) t = t[0].toUpperCase() + t.substring(1);
  return t.length <= 90 ? t : '${t.substring(0, 89).trimRight()}…';
}
