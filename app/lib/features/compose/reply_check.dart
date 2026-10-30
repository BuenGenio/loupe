import 'package:mail_ai/mail_ai.dart';

/// What Loupe could read of a file selected in compose.
enum AttachmentTextState {
  /// Nothing read it: no reader for this kind of file, or none at all yet.
  /// Only its name counts.
  notRead,

  /// Reading it failed: protected by a password, damaged, or a scan without
  /// text. What it contains is unknown.
  unreadable,

  /// [AttachmentText.text] is what it says.
  read,
}

/// The text of a selected file, or why there is none.
final class AttachmentText {
  const AttachmentText.notRead() : state = AttachmentTextState.notRead, text = null;
  const AttachmentText.unreadable() : state = AttachmentTextState.unreadable, text = null;
  const AttachmentText.read(String this.text) : state = AttachmentTextState.read;

  final AttachmentTextState state;
  final String? text;
}

/// A file selected in compose, as Reply Check sees it.
final class ReplyAttachment {
  const ReplyAttachment({
    required this.filename,
    required this.mimeType,
    required this.size,
    this.text = const AttachmentText.notRead(),
  });

  final String filename;
  final String mimeType;
  final int size;
  final AttachmentText text;
}

enum ReplyCheckStatus {
  /// A selected file matches, by its name only or by what it says
  /// ([ReplyCheckItem.basis]).
  included,

  /// A matching file states another period than the one asked for: another
  /// tax year, another month, half a month. Possibly the wrong one.
  wrongPeriod,

  /// Nothing selected matches, and the draft doesn't mention it.
  missing,

  /// It is done somewhere else (in an app, a form at a link, by bank
  /// transfer); attaching a file can't do it.
  external,

  /// The draft says it is done or coming ("I’ll do the ID check tonight"),
  /// or answers it.
  mentioned,

  /// A matching file couldn't be read, so whether it is the right one is
  /// unknown.
  unknown,
}

/// How a file was matched to a request.
enum ReplyCheckBasis {
  /// By its name. Tentative: a name says nothing certain about the contents.
  fileName,

  /// By the text inside it.
  contents,
}

/// How a request is answered.
enum ReplyCheckWay {
  /// By attaching a document.
  attach,

  /// In the reply's own words: an answer, a confirmation.
  answer,

  /// Outside email: in an app, a form at a link, in person.
  outside,
}

/// One request of the original message, against the draft.
final class ReplyCheckItem {
  const ReplyCheckItem({
    required this.request,
    required this.status,
    required this.way,
    this.basis,
    this.file,
    this.asked,
    this.found,
    this.periodConfirmed = false,
    this.wrote,
    this.channel,
    this.attachedAnyway = const [],
  });

  final BriefItem request;
  final ReplyCheckStatus status;
  final ReplyCheckWay way;

  /// How the file of an included, wrong-period or unknown status was matched.
  final ReplyCheckBasis? basis;

  /// The file the status is about.
  final String? file;

  /// The period the request states, as written ("2024/25", "a full month").
  final String? asked;

  /// The other period [file] states, as written ("2023-24"), for
  /// [ReplyCheckStatus.wrongPeriod].
  final String? found;

  /// [file] states [asked] (in its name or, with [ReplyCheckBasis.contents],
  /// inside). False when it states no period at all.
  final bool periodConfirmed;

  /// The draft's sentence that mentions it.
  final String? wrote;

  /// Where it is done, as the message says ("in the Harbour app", a link),
  /// for a step outside email.
  final String? channel;

  /// Files selected for a step outside email that look like what it is about
  /// (a passport scan for an ID check done in an app). Attaching them doesn't
  /// do the step, and sends a private document nobody asked for by email.
  final List<String> attachedAnyway;
}

/// The counts the collapsed panel shows.
final class ReplyCheckSummary {
  ReplyCheckSummary(List<ReplyCheckItem> items)
    : attachable = items.where((i) => i.way == ReplyCheckWay.attach).length,
      included = _count(items, ReplyCheckStatus.included),
      wrongPeriod = _count(items, ReplyCheckStatus.wrongPeriod),
      unknown = _count(items, ReplyCheckStatus.unknown),
      outside = _count(items, ReplyCheckStatus.external),
      mentioned = _count(items, ReplyCheckStatus.mentioned),
      toAnswer = items.where((i) => i.way == ReplyCheckWay.answer && i.status == ReplyCheckStatus.missing).length,
      byFileName = items.any(
        (i) =>
            i.basis == ReplyCheckBasis.fileName &&
            (i.status == ReplyCheckStatus.included || i.status == ReplyCheckStatus.wrongPeriod),
      );

  /// Requests answered by attaching a document, and how many of them are.
  final int attachable;
  final int included;
  final int wrongPeriod;
  final int unknown;

  /// Steps outside email the draft doesn't mention.
  final int outside;
  final int mentioned;

  /// Questions and confirmations the draft doesn't mention.
  final int toAnswer;

  /// Some status rests on a file name alone.
  final bool byFileName;

  static int _count(List<ReplyCheckItem> items, ReplyCheckStatus status) =>
      items.where((i) => i.status == status).length;
}

/// Reply Check (docs/plan/PLAN-combined.md, section 7): what the original
/// message asked the reader for, against the draft and the selected files.
///
/// The requests come from a Brief of the original; everything after that is
/// rules, so every status can be explained. A file name alone makes only a
/// tentative match. A claim about a file's contents needs its text: a tax
/// calculation for another year doesn't pass because its name says "SA302",
/// and a file that couldn't be read stays unknown. A step done in an app or at
/// a link is never something to attach. Nothing here attaches, sends or holds
/// up sending; the user decides.
abstract final class ReplyCheck {
  /// The requests a reply can answer: what the reader must do or provide.
  static List<BriefItem> requestsIn(Brief brief) => [
    for (final item in brief.items)
      if (item.owner == BriefOwner.me && (item.kind == BriefItemKind.action || item.kind == BriefItemKind.document))
        item,
  ];

  /// Checks each of [requests] against [draft] (the user's own text, without
  /// the quoted original and the signature) and [attachments].
  static List<ReplyCheckItem> check(
    List<BriefItem> requests, {
    required String draft,
    required List<ReplyAttachment> attachments,
  }) {
    final sentences = _sentences(draft);
    final files = [for (final a in attachments) _File(a)];
    return [for (final r in requests) _checkOne(_Request(r), sentences, files)];
  }

  /// The ordinary attachment reminder: [draft] (the user's own text) says
  /// something is attached or enclosed. In the languages most mail is
  /// written in; lines quoting other mail don't count.
  static bool mentionsAttachment(String draft) => draft
      .split('\n')
      .where((line) => !line.trimLeft().startsWith('>'))
      .any((line) => _attachWords.hasMatch(line.replaceAll('’', "'")));

  /// Text inside a file is read up to this length.
  static const maxTextCharacters = 50000;

  static ReplyCheckItem _checkOne(_Request r, List<String> sentences, List<_File> files) {
    final wrote = _mention(r, sentences);
    switch (r.way) {
      case ReplyCheckWay.outside:
        final related = {...r.types, if (r.types.any(_idTypes.contains)) ..._idTypes};
        return ReplyCheckItem(
          request: r.item,
          status: wrote == null ? ReplyCheckStatus.external : ReplyCheckStatus.mentioned,
          way: r.way,
          wrote: wrote,
          channel: r.channel,
          attachedAnyway: [
            for (final f in files)
              if (f.nameTypes.any(related.contains)) f.name,
          ],
        );
      case ReplyCheckWay.answer:
        return ReplyCheckItem(
          request: r.item,
          status: wrote == null ? ReplyCheckStatus.missing : ReplyCheckStatus.mentioned,
          way: r.way,
          wrote: wrote,
        );
      case ReplyCheckWay.attach:
        _Match? best;
        for (final f in files) {
          final m = _match(r, f);
          if (m != null && (best == null || m.rank > best.rank)) best = m;
        }
        if (best != null) {
          return ReplyCheckItem(
            request: r.item,
            status: best.status,
            way: r.way,
            basis: best.basis,
            file: best.file,
            asked: r.asked,
            found: best.found,
            periodConfirmed: best.periodConfirmed,
            wrote: wrote,
          );
        }
        return ReplyCheckItem(
          request: r.item,
          status: wrote == null ? ReplyCheckStatus.missing : ReplyCheckStatus.mentioned,
          way: r.way,
          asked: r.asked,
          wrote: wrote,
        );
    }
  }

  /// How [f] answers [r], or null when it has nothing to do with it.
  static _Match? _match(_Request r, _File f) {
    final byName = _related(r, f.nameTypes, f.nameWords);
    final text = f.text;
    final contents = text == null ? null : _Text(text);
    final byContents = contents != null && _related(r, contents.types, contents.words);
    if (!byName && !byContents) return null;

    if (f.unreadable) {
      // A name stating another period is still worth saying; otherwise
      // whether it is the right file can't be told.
      final name = _verdict(r.periods, f.namePeriods);
      if (name.rel == _Rel.different) {
        return _Match(f.name, ReplyCheckStatus.wrongPeriod, ReplyCheckBasis.fileName, found: name.found);
      }
      return _Match(f.name, ReplyCheckStatus.unknown, ReplyCheckBasis.fileName);
    }
    if (contents != null) {
      final inside = _verdict(r.periods, contents.periods);
      // What the file says wins over what its name says.
      if (inside.rel == _Rel.different) {
        return _Match(f.name, ReplyCheckStatus.wrongPeriod, ReplyCheckBasis.contents, found: inside.found);
      }
      if (byContents) {
        if (inside.rel != _Rel.unconfirmed) {
          return _Match(
            f.name,
            ReplyCheckStatus.included,
            ReplyCheckBasis.contents,
            periodConfirmed: inside.rel == _Rel.same,
          );
        }
        // The contents show the document but not the period: the name may.
        final name = _verdict(r.periods, f.namePeriods);
        if (name.rel == _Rel.different) {
          return _Match(f.name, ReplyCheckStatus.wrongPeriod, ReplyCheckBasis.fileName, found: name.found);
        }
        return _Match(f.name, ReplyCheckStatus.included, ReplyCheckBasis.contents);
      }
      // Read, but the text doesn't show what it is (a scan with little text):
      // only the name is left.
    }
    final name = _verdict(r.periods, f.namePeriods);
    if (name.rel == _Rel.different) {
      return _Match(f.name, ReplyCheckStatus.wrongPeriod, ReplyCheckBasis.fileName, found: name.found);
    }
    return _Match(f.name, ReplyCheckStatus.included, ReplyCheckBasis.fileName, periodConfirmed: name.rel == _Rel.same);
  }

  /// Whether a text with [types] and [words] is about [r]'s document: a
  /// shared kind of document, or, for requests that name none, two shared
  /// words.
  static bool _related(_Request r, Set<String> types, Set<String> words) =>
      r.types.isNotEmpty ? r.types.any(types.contains) : _overlap(r.words, words) >= 2;

  /// The draft's sentence that says [r] is done or coming (or, for a
  /// question, answers it), if any. A sentence saying a file is attached
  /// doesn't count: the files themselves show that.
  static String? _mention(_Request r, List<String> sentences) {
    for (final s in sentences) {
      final t = _Text(s);
      final about = r.types.any(t.types.contains) || _overlap(r.words, t.words) >= 2;
      if (!about) continue;
      if (r.way == ReplyCheckWay.answer || _cue.hasMatch(s.replaceAll('’', "'"))) return s;
    }
    return null;
  }

  static List<String> _sentences(String draft) => [
    for (final line in draft.split('\n'))
      if (!line.trimLeft().startsWith('>'))
        for (final s in line.split(RegExp(r'(?<=[.!?;])\s+')))
          if (s.trim().length > 2) s.trim(),
  ];

  static int _overlap(Set<String> a, Set<String> b) => a.where(b.contains).length;

  static ({_Rel rel, String? found}) _verdict(List<_Period> asked, List<_Period> found) {
    if (asked.isEmpty) return (rel: _Rel.none, found: null);
    String? different;
    for (final a in asked) {
      for (final f in found) {
        switch (_relate(a, f)) {
          case _Rel.same:
            return (rel: _Rel.same, found: f.written);
          case _Rel.different:
            different ??= f.written;
          case _Rel.none || _Rel.unconfirmed:
            break;
        }
      }
    }
    return different == null ? (rel: _Rel.unconfirmed, found: null) : (rel: _Rel.different, found: different);
  }

  /// Whether [found] is the period [asked] for. [_Rel.none] when they can't
  /// be compared (a month against a tax year).
  static _Rel _relate(_Period asked, _Period found) {
    _Rel same(bool b) => b ? _Rel.same : _Rel.different;
    return switch ((asked, found)) {
      (final _TaxYear a, final _TaxYear f) => same(a.start == f.start),
      // "2024/25" against "2025", or the other way: possibly not the one meant.
      (_TaxYear(), _Year()) || (_Year(), _TaxYear()) => _Rel.different,
      (final _Year a, final _Year f) => same(a.year == f.year),
      (final _Year a, final _Month f) => f.year == null ? _Rel.none : same(f.year == a.year),
      (final _Year a, final _Range f) => f.years.isEmpty ? _Rel.none : same(f.years.contains(a.year)),
      (final _Month a, final _Month f) => same(
        a.month == f.month && (a.year == null || f.year == null || a.year == f.year),
      ),
      (final _Month a, final _Range f) => same(f.fromMonth == a.month || f.toMonth == a.month),
      // A month's name doesn't say whether it is all of it.
      (_FullMonth(), _Month()) => _Rel.none,
      (_FullMonth(), final _Range f) => same(f.days >= 27),
      _ => _Rel.none,
    };
  }
}

/// A request, read once.
final class _Request {
  factory _Request(BriefItem item) {
    var text = '${item.text}\n${item.evidence.quote}';
    // A deadline isn't the period of the document ("send it by 30 November").
    if (item.due.text case final due? when due.trim().isNotEmpty) text = text.replaceAll(due, ' ');
    final periodText = text.replaceAll(_deadline, ' ');
    final read = _Text(text);
    final url = _url.firstMatch(text)?.group(0)?.replaceFirst(RegExp(r'[.,;:]+$'), '');
    final channel = item.channel?.trim();
    final outside =
        (channel != null && channel.isNotEmpty && _outsideChannel.hasMatch(channel)) ||
        url != null ||
        _outsideText.hasMatch(text);
    final question = item.evidence.quote.trim().endsWith('?');
    final send = _sendVerb.hasMatch(item.text);
    final way = outside
        ? ReplyCheckWay.outside
        : item.kind == BriefItemKind.document || (read.types.isNotEmpty && (!question || send)) || (send && !question)
        ? ReplyCheckWay.attach
        : ReplyCheckWay.answer;
    final periods = _periods(periodText, request: true);
    return _Request._(
      item,
      types: read.types,
      words: read.words,
      periods: periods,
      way: way,
      channel: channel != null && channel.isNotEmpty ? channel : url ?? _outsideText.firstMatch(text)?.group(0),
    );
  }

  _Request._(
    this.item, {
    required this.types,
    required this.words,
    required this.periods,
    required this.way,
    required this.channel,
  });

  final BriefItem item;
  final Set<String> types;
  final Set<String> words;
  final List<_Period> periods;
  final ReplyCheckWay way;
  final String? channel;

  String? get asked => periods.firstOrNull?.written;
}

/// A selected file, read once.
final class _File {
  factory _File(ReplyAttachment a) {
    final dot = a.filename.lastIndexOf('.');
    final stem = dot > 0 ? a.filename.substring(0, dot) : a.filename;
    final read = _Text(stem);
    final text = a.text.state == AttachmentTextState.read ? a.text.text : null;
    return _File._(
      a.filename,
      nameTypes: read.types,
      nameWords: read.words,
      namePeriods: _periods(stem),
      text: text == null || text.length <= ReplyCheck.maxTextCharacters
          ? text
          : text.substring(0, ReplyCheck.maxTextCharacters),
      unreadable: a.text.state == AttachmentTextState.unreadable,
    );
  }

  _File._(
    this.name, {
    required this.nameTypes,
    required this.nameWords,
    required this.namePeriods,
    required this.text,
    required this.unreadable,
  });

  final String name;
  final Set<String> nameTypes;
  final Set<String> nameWords;
  final List<_Period> namePeriods;
  final String? text;
  final bool unreadable;
}

/// The kinds of document, words and periods of a passage.
final class _Text {
  _Text(String s) : this._(s.toLowerCase().replaceAll('’', "'").replaceAll(RegExp(r'[_\-–—/.,:;()\[\]"“”]'), ' '), s);

  _Text._(String spaced, String original)
    : types = {
        for (final MapEntry(key: type, value: pattern) in _types.entries)
          if (pattern.hasMatch(spaced)) type,
      },
      words = {for (final w in spaced.split(RegExp(r"[^\p{L}\p{N}']+", unicode: true))) ?_word(w)},
      _original = original;

  final Set<String> types;
  final Set<String> words;
  final String _original;

  List<_Period> get periods => _periods(_original);

  /// [w] as a word worth comparing: not a function word, a number, a month
  /// or a day; plurals made singular.
  static String? _word(String w) {
    var word = w.replaceAll("'s", '').replaceAll("'", '');
    if (word.length > 4 && word.endsWith('s') && !word.endsWith('ss')) word = word.substring(0, word.length - 1);
    if (word.length < 3 || RegExp(r'^\d+$').hasMatch(word) || _stopWords.contains(word)) return null;
    if (_monthNumbers.containsKey(word) || _weekdays.contains(word)) return null;
    return word;
  }
}

final class _Match {
  _Match(this.file, this.status, this.basis, {this.found, this.periodConfirmed = false});

  final String file;
  final ReplyCheckStatus status;
  final ReplyCheckBasis basis;
  final String? found;
  final bool periodConfirmed;

  /// Which of several matching files speaks for the request: an included one
  /// first (read inside, then a name with the period), then one that couldn't
  /// be read, then one for another period.
  int get rank => switch (status) {
    ReplyCheckStatus.included when basis == ReplyCheckBasis.contents => 6,
    ReplyCheckStatus.included when periodConfirmed => 5,
    ReplyCheckStatus.included => 4,
    ReplyCheckStatus.unknown => 3,
    ReplyCheckStatus.wrongPeriod when basis == ReplyCheckBasis.contents => 2,
    _ => 1,
  };
}

// Periods ----------------------------------------------------------------------------

enum _Rel {
  /// Nothing to compare: the request states no period, or the two can't be
  /// compared (a month against a tax year).
  none,
  same,
  different,

  /// The request states a period; the file states none to compare with it.
  unconfirmed,
}

/// A period a request or a file states, with the words it was written in.
sealed class _Period {
  const _Period(this.written);
  final String written;
}

/// A UK-style tax year from 6 April of [start]: "2024/25", "2024-25",
/// "24/25", "2024 to 2025", "6 April 2024 to 5 April 2025".
final class _TaxYear extends _Period {
  const _TaxYear(this.start, super.written);
  final int start;
}

final class _Year extends _Period {
  const _Year(this.year, super.written);
  final int year;
}

final class _Month extends _Period {
  const _Month(this.month, this.year, super.written);
  final int month;
  final int? year;
}

/// "1 to 14 October", "15 August to 14 September".
final class _Range extends _Period {
  const _Range(this.fromMonth, this.fromDay, this.toMonth, this.toDay, this.fromYear, this.toYear, super.written);
  final int fromMonth;
  final int fromDay;
  final int toMonth;
  final int toDay;
  final int? fromYear;
  final int? toYear;

  Set<int> get years => {?fromYear, ?toYear};

  /// Days covered, both ends included.
  int get days {
    final y1 = fromYear ?? 2001;
    final y2 = toYear ?? (toMonth < fromMonth ? y1 + 1 : y1);
    return DateTime.utc(y2, toMonth, toDay).difference(DateTime.utc(y1, fromMonth, fromDay)).inDays + 1;
  }
}

/// "A full month's statement": any one whole month.
final class _FullMonth extends _Period {
  const _FullMonth(super.written);
}

const _monthNames =
    'january|february|march|april|may|june|july|august|september|october|november|december'
    '|sept|jan|feb|mar|apr|jun|jul|aug|sep|oct|nov|dec';

const _monthNumbers = {
  'january': 1,
  'february': 2,
  'march': 3,
  'april': 4,
  'may': 5,
  'june': 6,
  'july': 7,
  'august': 8,
  'september': 9,
  'october': 10,
  'november': 11,
  'december': 12,
  'jan': 1,
  'feb': 2,
  'mar': 3,
  'apr': 4,
  'jun': 6,
  'jul': 7,
  'aug': 8,
  'sep': 9,
  'sept': 9,
  'oct': 10,
  'nov': 11,
  'dec': 12,
};

const _weekdays = {'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'};

final _dayRange = RegExp(
  r'\b(\d{1,2})(?:st|nd|rd|th)?\s*(?:(' +
      _monthNames +
      r')\s*(\d{4})?\s*)?(?:-|\bto\b|\buntil\b|\btill\b|\bthrough\b)\s*(\d{1,2})(?:st|nd|rd|th)?\s+(' +
      _monthNames +
      r')\b(?:\s+(\d{4})\b)?',
  caseSensitive: false,
);
final _taxYear = RegExp(
  r'(?<![\d/\-])(?<!\d\.)((?:20)?\d\d)\s*(?:/|-|\bto\b)\s*((?:20)?\d\d)(?![\d/\-])(?!\.\d)',
  caseSensitive: false,
);
final _yearMonth = RegExp(r'(?<![\d/\-])(?<!\d\.)(20\d\d)[-./](0?[1-9]|1[0-2])(?![\d/\-])(?!\.\d)');
final _monthName = RegExp(r'(\d{1,2}\s+)?\b(' + _monthNames + r')\b(?:\s+(\d{4})\b)?', caseSensitive: false);
final _year = RegExp(r'(?<![\d/\-])(?<!\d\.)(20\d\d)(?![\d/\-])(?!\.\d)');
final _fullMonth = RegExp(
  r"\b(?:a\s+|one\s+)?(?:full|whole|complete)\s+(?:calendar\s+)?month\b(?:'s|’s)?",
  caseSensitive: false,
);

/// Deadlines in a request, which aren't the period of what it asks for.
final _deadline = RegExp(
  r'\b(?:by|before|until|no later than|on)\s+(?:(?:mon|tues|wednes|thurs|fri|satur|sun)day\s+)?(?:\d{1,2}(?:st|nd|rd|th)?\s+(?:' +
      _monthNames +
      r')|(?:' +
      _monthNames +
      r')\s+\d{1,2}(?:st|nd|rd|th)?)\b(?:\s+\d{4})?',
  caseSensitive: false,
);

/// The periods [s] states. Each passage counts once: the years of a date
/// range are not also lone years.
List<_Period> _periods(String s, {bool request = false}) {
  // File names put underscores for spaces, and between the years of a tax year.
  var text = s
      .replaceAll(RegExp(r'(?<=\d)_(?=\d)'), '-')
      .replaceAll('_', ' ')
      .replaceAll(RegExp('[–—]'), '-')
      .replaceAll('’', "'");
  final found = <(int, _Period)>[];
  void take(RegExpMatch m, _Period p) {
    found.add((m.start, p));
    text = text.replaceRange(m.start, m.end, ' ' * (m.end - m.start));
  }

  int? month(String? name) => name == null ? null : _monthNumbers[name.toLowerCase()];
  int? year(String? digits) => digits == null ? null : int.parse(digits);

  if (request) {
    for (final m in _fullMonth.allMatches(text).toList()) {
      take(m, _FullMonth(m.group(0)!.toLowerCase().replaceAll(RegExp(r"'s$"), '').trim()));
    }
  }
  for (final m in _dayRange.allMatches(text).toList()) {
    final toMonth = month(m.group(5))!;
    final fromMonth = month(m.group(2)) ?? toMonth;
    final fromDay = int.parse(m.group(1)!);
    final toDay = int.parse(m.group(4)!);
    final fromYear = year(m.group(3));
    final toYear = year(m.group(6));
    if (fromDay < 1 || fromDay > 31 || toDay < 1 || toDay > 31) continue;
    final written = m.group(0)!.trim();
    if (fromMonth == 4 && toMonth == 4 && fromDay >= 5 && fromDay <= 6 && toDay >= 5 && toDay <= 6) {
      if (fromYear != null && toYear == fromYear + 1) {
        take(m, _TaxYear(fromYear, written));
        continue;
      }
    }
    take(m, _Range(fromMonth, fromDay, toMonth, toDay, fromYear, toYear ?? fromYear, written));
  }
  for (final m in _taxYear.allMatches(text).toList()) {
    final a = int.parse(m.group(1)!);
    final b = int.parse(m.group(2)!);
    final start = a < 100 ? 2000 + a : a;
    final end = b < 100 ? 2000 + b : b;
    // Two-digit years only from 2015 to 2049, so "1-14" or "10-11" aren't years.
    if (a < 100 && (a < 15 || a > 49)) continue;
    if (end != start + 1) continue;
    take(m, _TaxYear(start, m.group(0)!.trim()));
  }
  for (final m in _yearMonth.allMatches(text).toList()) {
    take(m, _Month(int.parse(m.group(2)!), int.parse(m.group(1)!), m.group(0)!));
  }
  for (final m in _monthName.allMatches(text).toList()) {
    final name = m.group(2)!.toLowerCase();
    // "May" is only a month next to a number ("1 May", "May 2025").
    if (name == 'may' && m.group(1) == null && m.group(3) == null) continue;
    final written = m.group(1) == null ? m.group(0)! : m.group(0)!.substring(m.group(1)!.length);
    take(m, _Month(month(name)!, year(m.group(3)), written.trim()));
  }
  for (final m in _year.allMatches(text).toList()) {
    take(m, _Year(int.parse(m.group(1)!), m.group(0)!));
  }
  found.sort((a, b) => a.$1.compareTo(b.$1));
  return [for (final (_, p) in found) p];
}

// Words ------------------------------------------------------------------------------

/// Kinds of document, on lower-cased text with punctuation made spaces.
final _types = <String, RegExp>{
  'statement': RegExp(r'\bstatements?\b'),
  'taxCalculation': RegExp(r'\bsa ?302s?\b|\btax calc(?:ulation)?s?\b'),
  'overview': RegExp(r'\boverviews?\b'),
  'payslip': RegExp(r'\b(?:pay|wage) ?slips?\b'),
  'p60': RegExp(r'\bp60s?\b'),
  'passport': RegExp(r'\bpassports?\b'),
  'licence': RegExp(r'\blicen[cs]es?\b'),
  'id': RegExp(r'\bid\b|\bidentity\b|\bidentification\b'),
  'letter': RegExp(r'\bletters?\b'),
  'form': RegExp(r'\bforms?\b'),
  'invoice': RegExp(r'\binvoices?\b'),
  'contract': RegExp(r'\bcontracts?\b'),
  'certificate': RegExp(r'\bcertificates?\b'),
  'receipt': RegExp(r'\breceipts?\b'),
  'illustration': RegExp(r'\billustrations?\b'),
};

/// Proofs of identity: what an ID check is about, whichever is named.
const _idTypes = {'id', 'passport', 'licence'};

/// Words too common to tell two requests apart, as [_Text._word] leaves
/// them ("I’ll" is "ill").
final _stopWords =
    ('the and for from with your you yours our ours their they them this that these those are was were '
            'will would should could can shall may might must have has had does did done not but any all some one '
            'two its into out about after before over under again once also just than then too very more most '
            'what which when where who how why here there please need needs needed send sent sending provide '
            'return copy get got let know showing show shows coming come completed complete full whole month year '
            'day week today tonight tomorrow yesterday now soon later attached attach attaching enclosed thanks '
            'thank dear regards like want wanted yes well still yet answer reply email mail message ill ive dont '
            'cant whether only each every both either other another such own same off per via')
        .split(' ')
        .toSet();

/// Asks for something to be sent: a document, even when no kind is named.
final _sendVerb = RegExp(r'\b(?:send|return|provide|upload|attach|forward|scan)\b', caseSensitive: false);

/// How or where a request is done, when attaching a file can't do it.
final _outsideChannel = RegExp(
  r'\bapps?\b|\bonline\b|\bportal\b|\bweb ?site\b|\bin person\b|\bin branch\b|\bat (?:the|a|our|your) (?:branch|office)\b'
  r'|\bby (?:phone|telephone|post|hand|bank transfer|transfer|card|cheque|check|text)\b|\bphone\b|\bcall\b'
  r'|\bsign(?:ed)? in\b|\blog ?in\b|\blink\b|https?://|www\.',
  caseSensitive: false,
);

/// The same said in a request's own words, when it names no channel.
final _outsideText = RegExp(
  r"\b(?:in|on|via|through|using) (?:the|our|your) [\w'’ -]{0,30}?\b(?:app|portal|website)\b|\bin person\b"
  r'|\bby bank transfer\b',
  caseSensitive: false,
);

final _url = RegExp(r'https?://[^\s)>\]]+|www\.[^\s)>\]]+', caseSensitive: false);

/// A draft saying something is done or coming: "I’ll", "tonight", "done",
/// "sent", "not yet". Apostrophes are made straight first.
final _cue = RegExp(
  r"\b(?:i'll|we'll|will|going to|tonight|tomorrow|today|later|soon|shortly|this (?:week|weekend|evening|afternoon|morning)"
  r'|next (?:week|month)|at the weekend|on (?:monday|tuesday|wednesday|thursday|friday|saturday|sunday)'
  r'|already|done|did|completed?|finished|submitted|filled|sent|uploaded|posted|booked|paid|on (?:its|their|the) way'
  r"|to follow|will follow|don't have|do not have|haven't|have not|not yet|can't|cannot)\b",
  caseSensitive: false,
);

/// "Attached", "enclosed" and their equivalents in the languages most mail is
/// written in. Letters around a match are other words ("unattached").
final _attachWords = RegExp(
  r'(?<!\p{L})(?:attached|attaching|attachments?|enclosed|enclosing'
  r'|anbei|im anhang|angehängt|anhängend' // German
  r'|ci-jointe?s?|pièces? jointes?|en pièce jointe' // French
  r'|adjunt[oa]s?|adjunto|te adjunto|le adjunto' // Spanish
  r'|in allegato|allegat[oiae]' // Italian
  r'|bijgevoegd|in de bijlage|als bijlage' // Dutch
  r'|em anexo|anexad[oa]s?|segue anexo' // Portuguese
  r'|bifogad|bifogat|bifogar' // Swedish
  r'|vedhæftet|vedlagt|vedlagte' // Danish, Norwegian
  r'|w załączniku|załączam|załączeniu' // Polish
  r'|v příloze|přikládám' // Czech
  r')(?!\p{L})',
  caseSensitive: false,
  unicode: true,
);
