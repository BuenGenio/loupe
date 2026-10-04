// Post-processing of text sizes. The converter records sizes below 16 px
// exactly ([provisionalScale]); here they are compared with the message's
// own body size, so text the sender set clearly smaller becomes fine print
// while a newsletter set entirely in 13 px stays at body size.

import 'dart:math' as math;

import '../model/document.dart';
import 'css.dart';

/// Resolves the provisional run sizes in [blocks] against the message's body
/// size: clearly smaller text becomes fine print ([finePrintScale]), the rest
/// body size; larger steps stay. Code is never fine print (a small code font
/// is a font choice). Neutral colours of fine print text (black, greys) are
/// dropped so it shows in the reader's secondary text colour; links keep
/// theirs (dropping it would turn a grey footer link into a bright one).
List<Block> resolveTextSizes(List<Block> blocks) => _Resolver(bodySizePx(blocks)).blocks(blocks);

/// The size the message's body text is set in (in px, at most 16): the size
/// holding the most visible characters in the body proper, the blocks before
/// the trailing part ([trailingStart], ignoring rules: a rule under a title
/// would leave too little). Footers and legal notices are often
/// longer than the body, so they don't count. Headings, code and dimmed
/// (signature) paragraphs don't count either; without any body text, 16 px.
double bodySizePx(List<Block> blocks) {
  // Characters per size bucket, in half pixels.
  final chars = <int, int>{};
  void runs(List<Inline> inlines) {
    for (final i in inlines) {
      if (i is! TextRun) continue;
      final n = i.text.replaceAll(_blank, '').length;
      if (n == 0) continue;
      final px = math.min(i.style.scale, 1.0) * defaultBodyPx;
      final key = (px * 2).round();
      chars[key] = (chars[key] ?? 0) + n;
    }
  }

  void walk(Iterable<Block> bs) {
    for (final b in bs) {
      switch (b) {
        case ParagraphBlock(:final inlines, :final muted):
          if (!muted) runs(inlines);
        case QuoteBlock(:final children):
          walk(children);
        case ListBlock(:final items):
          items.forEach(walk);
        case TableBlock(:final rows):
          for (final row in rows) {
            for (final cell in row) {
              runs(cell.inlines);
            }
          }
        default:
      }
    }
  }

  walk(blocks.take(trailingStart(blocks, afterRules: false)));
  if (chars.isEmpty) return defaultBodyPx;
  // The most text wins; on a tie, the larger size.
  final best = chars.entries.reduce((a, b) => a.value > b.value || (a.value == b.value && a.key > b.key) ? a : b);
  return math.min(best.key / 2, defaultBodyPx);
}

/// Where the trailing part of [blocks] starts (signature, footer, legal
/// notices): at the first signature delimiter or signature block, after the
/// last rule that follows some text (with [afterRules]), or at the last 30%
/// of blocks, whichever comes first. Never at the first block.
int trailingStart(List<Block> blocks, {bool afterRules = true}) {
  final n = blocks.length;
  var start = (n * 0.7).floor();
  var sawText = false;
  var lastRule = -1;
  for (var i = 0; i < n; i++) {
    final b = blocks[i];
    if (b is RuleBlock) {
      if (sawText) lastRule = i;
    } else if (b is ParagraphBlock) {
      if (b.muted || _signatureDelimiter.hasMatch(inlineText(b.inlines))) {
        start = math.min(start, i);
        break;
      }
      sawText = true;
    } else if (b is! ImageBlock && b is! CarouselBlock) {
      sawText = true;
    }
  }
  if (afterRules && lastRule >= 0) start = math.min(start, lastRule + 1);
  return start.clamp(math.min(1, n), n);
}

/// `-- ` on a line of its own (trailing spaces are already trimmed).
final _signatureDelimiter = RegExp(r'^--\s*(\n|$)');

final _blank = RegExp(r'[\s\u00a0\u200b\u200c\u200d\ufeff]+');

final class _Resolver {
  _Resolver(this.bodyPx);

  final double bodyPx;

  List<Block> blocks(List<Block> blocks) => [for (final b in blocks) block(b)];

  Block block(Block b) => switch (b) {
    ParagraphBlock(:final inlines, :final align, :final dir, :final tight, :final muted) => ParagraphBlock(
      runs(inlines),
      align: align,
      dir: dir,
      tight: tight,
      muted: muted,
    ),
    PreBlock(:final inlines) => PreBlock(runs(inlines, code: true)),
    QuoteBlock(:final children, :final bar) => QuoteBlock(blocks(children), bar: bar),
    ListBlock(:final items, :final marker, :final start) => ListBlock(
      [for (final item in items) blocks(item)],
      marker: marker,
      start: start,
    ),
    TableBlock(:final rows, :final columns) => TableBlock([
      for (final row in rows)
        [for (final c in row) TableCell(runs(c.inlines), header: c.header, colspan: c.colspan, align: c.align)],
    ], columns: columns),
    // Headings are already at their own size; buttons, rules and images
    // carry no runs.
    _ => b,
  };

  List<Inline> runs(List<Inline> inlines, {bool fine = false, bool code = false}) {
    final out = <Inline>[];
    for (final i in inlines) {
      if (i is! TextRun) {
        out.add(i);
        continue;
      }
      var style = i.style;
      final scale = fine
          ? finePrintScale
          : (code || style.mono) && style.scale < 1
          ? 1.0
          : resolveScale(style.scale, bodyPx);
      if (scale != style.scale) style = style.copyWith(scale: scale);
      final color = style.color;
      if (style.fine && style.link == null && style.background == null && color != null && _isNeutral(color)) {
        style = style.copyWith(color: () => null);
      }
      // Runs that now look the same merge again.
      final last = out.isEmpty ? null : out.last;
      if (last is TextRun && last.style == style) {
        out[out.length - 1] = TextRun(last.text + i.text, style);
      } else {
        out.add(TextRun(i.text, style));
      }
    }
    return out;
  }
}

/// Black, white and greys: fine print in these takes the reader's own
/// secondary colour.
bool _isNeutral(int argb) {
  final r = (argb >> 16) & 0xFF;
  final g = (argb >> 8) & 0xFF;
  final b = argb & 0xFF;
  return math.max(r, math.max(g, b)) - math.min(r, math.min(g, b)) <= 24;
}
