import 'dart:convert';

import 'package:mail_ai/mail_ai.dart';

/// Stands in for a model until one ships. It answers `search.translate` with
/// a few rules over the sentence (status words, "from" / "to" / "about",
/// attachments, periods, months), so Ask in Plain English can be used and
/// tested end to end without a model. It refuses every other task. Its
/// completions carry the model name "demo", and the sheet says so.
final class DemoAiProvider implements AiProvider {
  DemoAiProvider({DateTime Function()? now}) : _now = now ?? DateTime.now;

  final DateTime Function() _now;

  @override
  String get id => 'demo';
  @override
  ProviderLocation get location => ProviderLocation.onThisPhone;
  @override
  ProviderCapabilities get capabilities =>
      const ProviderCapabilities(maxInputTokens: 4000, maxOutputTokens: 400, constrainedOutput: true);

  @override
  Future<AiCompletion> complete(AiRequest request, {CancelToken? cancel}) async {
    if (cancel?.isCancelled ?? false) throw const AiCancelled();
    if (request.taskType != 'search.translate') {
      throw const AiProviderException('The built-in demo only translates searches.');
    }
    return AiCompletion(jsonEncode(demoTranslate(_sentence(request.input), now: _now())), model: 'demo');
  }

  /// The task sends `Sentence: <JSON string>`; a repair turn appends to it.
  static String _sentence(String input) {
    const prefix = 'Sentence: ';
    if (!input.startsWith(prefix)) return input;
    final end = input.indexOf('\n');
    final encoded = input.substring(prefix.length, end < 0 ? input.length : end);
    try {
      return jsonDecode(encoded) as String;
    } on FormatException {
      return encoded;
    }
  }
}

const _stopWords = {
  'a',
  'an',
  'the',
  'and',
  'with',
  'of',
  'me',
  'my',
  'any',
  'all',
  'show',
  'find',
  'search',
  'for',
  'that',
  'those',
  'which',
  'i',
  'got',
  'received',
  'please',
  'containing',
  'mentioning',
  'mail',
  'mails',
  'email',
  'emails',
  'message',
  'messages',
  'sent',
  'anything',
  'everything',
  'something',
  'has',
  'have',
  'is',
  'are',
  'was',
  'were',
};

const _months = [
  'january',
  'february',
  'march',
  'april',
  'may',
  'june',
  'july',
  'august',
  'september',
  'october',
  'november',
  'december',
];

/// The demo's whole intelligence: a left-to-right pass over the words. The
/// answer has the shape SearchTranslationTask expects and only uses operators
/// its parser knows, so a demo result is checked exactly like a model's.
Map<String, Object?> demoTranslate(String sentence, {required DateTime now}) {
  final words = sentence
      .toLowerCase()
      .replaceAll(RegExp(r'[^\p{L}\p{N}@._\-\s]', unicode: true), ' ')
      .split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty)
      .toList();
  if (words.length < 2) {
    return {
      'expression': '',
      'interpretation': '',
      'questions': ['What should the search look for? For example: unread from Dana since September.'],
    };
  }
  final terms = <String>[];
  final said = <String>[];
  final free = <String>[];
  String two(int n) => n.toString().padLeft(2, '0');
  String monthName(int m) => _months[m - 1][0].toUpperCase() + _months[m - 1].substring(1);

  for (var i = 0; i < words.length; i++) {
    final w = words[i];
    final next = i + 1 < words.length ? words[i + 1] : null;
    final month = next == null ? -1 : _months.indexOf(next) + 1;
    final year = next != null && RegExp(r'^(19|20)\d\d$').hasMatch(next) ? int.parse(next) : null;
    switch (w) {
      case 'from' when next != null && !_stopWords.contains(next):
        terms.add('from:$next');
        said.add('from $next');
        i++;
      case 'to' when next != null && !_stopWords.contains(next):
        terms.add('to:$next');
        said.add('to $next');
        i++;
      case 'about' || 'regarding' || 'subject' when next != null && !_stopWords.contains(next):
        terms.add('subject:$next');
        said.add('about "$next"');
        i++;
      case 'since' when month > 0:
        final y = month <= now.month ? now.year : now.year - 1;
        terms.add('after:$y-${two(month)}-01');
        said.add('since 1 ${monthName(month)} $y');
        i++;
      case 'since' || 'after' when year != null:
        terms.add('after:$year-01-01');
        said.add('since $year');
        i++;
      case 'before' when month > 0:
        final y = month <= now.month ? now.year : now.year - 1;
        terms.add('before:$y-${two(month)}-01');
        said.add('before ${monthName(month)} $y');
        i++;
      case 'in' || 'during' when month > 0:
        final y = month <= now.month ? now.year : now.year - 1;
        terms.add('date:$y-${two(month)}');
        said.add('in ${monthName(month)} $y');
        i++;
      case 'in' || 'during' when year != null:
        terms.add('date:$year');
        said.add('in $year');
        i++;
      case 'last' || 'past' when next == 'week':
        terms.add('newer_than:7d');
        said.add('from the last week');
        i++;
      case 'last' || 'past' when next == 'month':
        terms.add('newer_than:1m');
        said.add('from the last month');
        i++;
      case 'last' || 'past' when next == 'year':
        terms.add('newer_than:1y');
        said.add('from the last year');
        i++;
      case 'last' || 'past' when next != null && RegExp(r'^\d{1,3}$').hasMatch(next):
        final unit = i + 2 < words.length ? words[i + 2] : '';
        final suffix = switch (unit) {
          'day' || 'days' => 'd',
          'week' || 'weeks' => 'w',
          'month' || 'months' => 'm',
          'year' || 'years' => 'y',
          _ => null,
        };
        if (suffix == null) {
          free.add(w);
        } else {
          terms.add('newer_than:$next$suffix');
          said.add('from the last $next $unit');
          i += 2;
        }
      case 'unread' || 'new':
        terms.add('is:unread');
        said.add('unread');
      case 'flagged' || 'starred' || 'important':
        terms.add('is:flagged');
        said.add('flagged');
      case 'unreplied' || 'unanswered':
        terms.add('is:unreplied');
        said.add('not replied to');
      case 'replied' || 'answered':
        terms.add('is:replied');
        said.add('replied to');
      case 'attachment' || 'attachments' || 'file' || 'files':
        terms.add('has:attachment');
        said.add('with attachments');
      case 'pdf' || 'pdfs':
        terms.add('filename:pdf');
        said.add('with a PDF');
      case 'today':
        terms.add('date:today');
        said.add('from today');
      case 'yesterday':
        terms.add('date:yesterday');
        said.add('from yesterday');
      // A function word whose pattern didn't match ("from the last week")
      // is not a search word either.
      case 'from' ||
          'to' ||
          'about' ||
          'regarding' ||
          'subject' ||
          'since' ||
          'after' ||
          'before' ||
          'in' ||
          'during' ||
          'last' ||
          'past':
        break;
      case _ when _stopWords.contains(w):
        break;
      default:
        free.add(w);
    }
  }
  if (terms.isEmpty && free.isEmpty) {
    return {
      'expression': '',
      'interpretation': '',
      'questions': ['What should the search look for? For example: unread from Dana since September.'],
    };
  }
  final expression = [...terms, ...free].join(' ');
  final about = free.isEmpty ? '' : ' mentioning ${free.map((w) => '"$w"').join(', ')}';
  final interpretation = 'Mail$about${said.isEmpty ? '' : ' ${said.join(', ')}'}.';
  return {'expression': expression, 'interpretation': interpretation, 'questions': <String>[]};
}
