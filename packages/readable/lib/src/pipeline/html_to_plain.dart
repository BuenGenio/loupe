// Plain-text view of an HTML-only message: the readable document flattened
// to unstyled paragraphs, with links as numbered footnotes.

import '../model/document.dart';

/// Converts [doc] to a plain document. Quotes stay quotes (bars); lists get
/// text markers; tables become `a | b | c` lines; each distinct link URL gets
/// a `[n]` marker and a footnote at the end.
ReaderDocument toPlainDocument(ReaderDocument doc) {
  final p = _Plainer(doc);
  final blocks = p.blocks(doc.blocks, 0);
  if (p.footnotes.isNotEmpty) {
    blocks.add(const RuleBlock());
    final runs = <Inline>[];
    for (final (i, url) in p.footnotes.indexed) {
      if (i > 0) runs.add(const TextRun('\n'));
      runs.add(TextRun('[${i + 1}] '));
      runs.add(TextRun(url, RunStyle(link: p.linkFor(url), underline: true)));
    }
    blocks.add(ParagraphBlock(runs, muted: true));
  }
  return ReaderDocument(blocks: blocks, links: p.links, stats: doc.stats);
}

final class _Plainer {
  _Plainer(this.doc);

  final ReaderDocument doc;
  final links = <LinkRef>[];
  final footnotes = <String>[];
  final _linkIndex = <String, int>{};

  int linkFor(String url) => _linkIndex.putIfAbsent(url, () {
    links.add(LinkRef(url, text: url));
    return links.length - 1;
  });

  int _footnote(String url) {
    var n = footnotes.indexOf(url);
    if (n < 0) {
      footnotes.add(url);
      n = footnotes.length - 1;
    }
    return n + 1;
  }

  List<Block> blocks(List<Block> input, int listDepth) {
    final out = <Block>[];
    for (final b in input) {
      switch (b) {
        case ParagraphBlock(:final inlines, :final dir):
          _add(out, _text(inlines), dir: dir);
        case HeadingBlock(:final inlines, :final dir):
          _add(out, _text(inlines), dir: dir);
        case PreBlock(:final inlines):
          _add(out, _text(inlines));
        case QuoteBlock(:final children, :final bar):
          final inner = blocks(children, listDepth);
          if (inner.isNotEmpty) out.add(QuoteBlock(inner, bar: bar));
        case ListBlock(:final items, :final marker, :final start):
          for (final (i, item) in items.indexed) {
            final prefix = '${'   ' * listDepth}${_marker(marker, start + i)}';
            final inner = blocks(item, listDepth + 1);
            var first = true;
            for (final ib in inner) {
              if (first && ib is ParagraphBlock) {
                out.add(ParagraphBlock([TextRun(prefix), ...ib.inlines], tight: out.isNotEmpty, dir: ib.dir));
              } else {
                out.add(ib);
              }
              first = false;
            }
          }
        case RuleBlock():
          out.add(b);
        case ImageBlock(:final image):
          final alt = doc.images[image].alt;
          if (alt != null && alt.isNotEmpty) _add(out, [TextRun('[$alt]')]);
        case CarouselBlock(:final images):
          final alts = images.map((i) => doc.images[i].alt).whereType<String>().where((a) => a.isNotEmpty);
          if (alts.isNotEmpty) _add(out, [TextRun(alts.map((a) => '[$a]').join(' '))]);
        case ButtonBlock(:final text, :final link):
          _add(out, [TextRun(text), ..._footnoteMarker(doc.links[link].url, text)]);
        case TableBlock(:final rows):
          final lines = <Inline>[];
          for (final row in rows) {
            if (lines.isNotEmpty) lines.add(const TextRun('\n'));
            for (final (i, cell) in row.indexed) {
              if (i > 0) lines.add(const TextRun(' | '));
              lines.addAll(
                _text(cell.inlines).map((r) => r is TextRun ? TextRun(r.text.replaceAll('\n', ' '), r.style) : r),
              );
            }
          }
          _add(out, lines);
      }
    }
    return out;
  }

  void _add(List<Block> out, List<Inline> inlines, {TextDir dir = TextDir.auto}) {
    if (inlineText(inlines).trim().isEmpty) return;
    out.add(ParagraphBlock(inlines, dir: dir));
  }

  /// Unstyled runs with `[n]` after each link whose text isn't its URL.
  List<Inline> _text(List<Inline> inlines) {
    final out = <Inline>[];
    int? openLink;
    final linkText = StringBuffer();
    void closeLink() {
      if (openLink == null) return;
      out.addAll(_footnoteMarker(doc.links[openLink!].url, linkText.toString()));
      openLink = null;
      linkText.clear();
    }

    for (final i in inlines) {
      if (i is! TextRun) {
        // Inline images are icons: decorative in plain text.
        continue;
      }
      final link = i.style.link;
      if (link != openLink) closeLink();
      if (link != null) {
        openLink = link;
        linkText.write(i.text);
      }
      out.add(TextRun(i.text));
    }
    closeLink();
    return out;
  }

  List<Inline> _footnoteMarker(String url, String text) {
    final t = text.trim();
    final bare = url.replaceFirst(RegExp(r'^(https?://|mailto:)'), '');
    if (t == url || t == bare || t.isEmpty) return const [];
    return [TextRun(' [${_footnote(url)}]', RunStyle(link: linkFor(url)))];
  }

  static String _marker(ListMarker m, int n) => switch (m) {
    ListMarker.disc => '•  ',
    ListMarker.none => '',
    ListMarker.decimal => '$n. ',
    ListMarker.lowerAlpha => '${alphaMarker(n)}. ',
    ListMarker.upperAlpha => '${alphaMarker(n).toUpperCase()}. ',
    ListMarker.lowerRoman => '${romanMarker(n)}. ',
    ListMarker.upperRoman => '${romanMarker(n).toUpperCase()}. ',
  };
}

/// 1 → a, 26 → z, 27 → aa.
String alphaMarker(int n) {
  if (n < 1) return '$n';
  var s = '';
  var x = n;
  while (x > 0) {
    x--;
    s = String.fromCharCode(97 + x % 26) + s;
    x ~/= 26;
  }
  return s;
}

/// 4 → iv.
String romanMarker(int n) {
  if (n < 1 || n > 3999) return '$n';
  const values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
  const symbols = ['m', 'cm', 'd', 'cd', 'c', 'xc', 'l', 'xl', 'x', 'ix', 'v', 'iv', 'i'];
  final sb = StringBuffer();
  var x = n;
  for (var i = 0; i < values.length; i++) {
    while (x >= values[i]) {
      sb.write(symbols[i]);
      x -= values[i];
    }
  }
  return sb.toString();
}
