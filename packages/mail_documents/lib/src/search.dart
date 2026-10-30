import 'document.dart';

/// Text folded for exact matching, with where each folded character came
/// from, so a match can be shown in the original.
final class FoldedText {
  FoldedText._(this.text, this._origin, this._length);

  /// Folds [source]: lower case, every run of whitespace one space,
  /// typographic quotes and dashes plain, ligatures spelled out. Nothing else
  /// changes: an exact search stays exact.
  factory FoldedText(String source) {
    final out = StringBuffer();
    final origin = <int>[];
    var space = false;
    for (var i = 0; i < source.length; i++) {
      final c = source.codeUnitAt(i);
      if (_isSpace(c)) {
        if (!space && out.isNotEmpty) {
          out.write(' ');
          origin.add(i);
        }
        space = true;
        continue;
      }
      space = false;
      final folded = _fold(c) ?? String.fromCharCode(c).toLowerCase();
      out.write(folded);
      for (var k = 0; k < folded.length; k++) {
        origin.add(i);
      }
    }
    var text = out.toString();
    if (text.endsWith(' ')) {
      text = text.substring(0, text.length - 1);
      origin.removeLast();
    }
    return FoldedText._(text, origin, source.length);
  }

  final String text;
  final List<int> _origin;
  final int _length;

  /// Where folded offset [i] starts in the original.
  int startOf(int i) => i < _origin.length ? _origin[i] : _length;

  /// Where the folded range ending at [end] (exclusive) ends in the original.
  int endOf(int end) => end <= 0 ? 0 : (end - 1 < _origin.length ? _origin[end - 1] + 1 : _length);

  static bool _isSpace(int c) =>
      c == 0x20 || c == 0x0A || c == 0x0D || c == 0x09 || c == 0x0C || c == 0xA0 || c == 0x2007 || c == 0x202F;

  static String? _fold(int c) => switch (c) {
    0x2018 || 0x2019 || 0x201B || 0x2032 || 0x02BC => "'",
    0x201C || 0x201D || 0x201F || 0x2033 => '"',
    0x2010 || 0x2011 || 0x2012 || 0x2013 || 0x2014 || 0x2212 => '-',
    0xFB00 => 'ff',
    0xFB01 => 'fi',
    0xFB02 => 'fl',
    0xFB03 => 'ffi',
    0xFB04 => 'ffl',
    _ => null,
  };
}

/// One place a search matched: the page, where on it, and the passage
/// around it with the match's place in the passage.
final class DocumentMatch {
  const DocumentMatch({
    required this.page,
    required this.line,
    required this.start,
    required this.end,
    required this.passage,
    required this.passageStart,
    required this.passageEnd,
  });

  /// 1-based page number.
  final int page;

  /// 1-based line on the page.
  final int line;

  /// The match in the page's text.
  final int start;
  final int end;

  /// A line or two around the match, on one line, with "…" where it was cut.
  final String passage;

  /// The match in [passage].
  final int passageStart;
  final int passageEnd;
}

/// Finds [query] in [document]'s pages, exactly: case, spacing, line breaks,
/// typographic quotes and dashes don't matter; words, numbers and their
/// order do. At most [maxMatches], in page order.
List<DocumentMatch> findInDocument(ExtractedDocument document, String query, {int maxMatches = 20, int context = 60}) {
  final needle = FoldedText(query.length > 200 ? query.substring(0, 200) : query).text;
  if (needle.isEmpty) return const [];
  final matches = <DocumentMatch>[];
  for (final page in document.pages) {
    if (!page.readable || page.text.isEmpty) continue;
    final folded = FoldedText(page.text);
    var from = 0;
    while (matches.length < maxMatches) {
      final at = folded.text.indexOf(needle, from);
      if (at < 0) break;
      final start = folded.startOf(at), end = folded.endOf(at + needle.length);
      matches.add(_match(page, start, end, context));
      from = at + needle.length;
    }
    if (matches.length >= maxMatches) break;
  }
  return matches;
}

DocumentMatch _match(DocumentPage page, int start, int end, int context) {
  final text = page.text;
  var from = start - context < 0 ? 0 : start - context;
  var to = end + context > text.length ? text.length : end + context;
  // Whole words at the edges.
  while (from > 0 && from < start && text.codeUnitAt(from - 1) != 0x20 && text.codeUnitAt(from - 1) != 0x0A) {
    from++;
  }
  while (to < text.length && to > end && text.codeUnitAt(to) != 0x20 && text.codeUnitAt(to) != 0x0A) {
    to--;
  }
  final lead = from > 0 ? '…' : '';
  final tail = to < text.length ? '…' : '';
  final passage = '$lead${text.substring(from, to).replaceAll('\n', ' ')}$tail';
  final line = '\n'.allMatches(text.substring(0, start)).length + 1;
  return DocumentMatch(
    page: page.number,
    line: line,
    start: start,
    end: end,
    passage: passage,
    passageStart: lead.length + start - from,
    passageEnd: lead.length + end - from,
  );
}

/// Where [quote] is on [pageText], compared like a search (whitespace,
/// case, quotes and dashes don't matter): its start and end in the page's
/// text, or null when the page doesn't say it.
(int, int)? locateOnPage(String pageText, String quote) {
  final needle = FoldedText(quote).text;
  if (needle.isEmpty) return null;
  final folded = FoldedText(pageText);
  final at = folded.text.indexOf(needle);
  if (at < 0) return null;
  return (folded.startOf(at), folded.endOf(at + needle.length));
}
