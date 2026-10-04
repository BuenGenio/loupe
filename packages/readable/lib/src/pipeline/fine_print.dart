// Post-processing of text sizes. The converter records sizes below 16 px
// exactly ([provisionalScale]); here they are compared with the message's
// own body size, so text the sender set clearly smaller becomes fine print
// while a newsletter set entirely in 13 px stays at body size.
//
// Footers the HTML doesn't mark smaller (legal notices, company
// registration, privacy pointers, unsubscribe lines) are found by their
// wording at the end of the message and shown as fine print too.

import 'dart:math' as math;

import '../model/document.dart';
import 'css.dart';

/// Resolves the provisional run sizes in [blocks] against the message's body
/// size: clearly smaller text becomes fine print ([finePrintScale]), the rest
/// body size; larger steps stay. Code is never fine print (a small code font
/// is a font choice). Neutral colours of fine print text (black, greys) are
/// dropped so it shows in the reader's secondary text colour; links keep
/// theirs (dropping it would turn a grey footer link into a bright one).
///
/// Footer paragraphs found by [footerScore] at the end of the message (or of
/// a quoted message) are fine print whatever their size; [links] tells their
/// links from a call to action.
List<Block> resolveTextSizes(List<Block> blocks, List<LinkRef> links) {
  final footer = _FooterScan(links)..scan(blocks);
  return _Resolver(bodySizePx(blocks, exclude: footer.matched), footer.finePrint).blocks(blocks);
}

/// The size the message's body text is set in (in px, at most 16): the size
/// holding the most visible characters in the body proper, the blocks before
/// the trailing part ([trailingStart], ignoring rules: a rule under a title
/// would leave too little). Footers and legal notices are often
/// longer than the body, so they don't count, nor do the paragraphs in
/// [exclude]. Headings, code and dimmed (signature) paragraphs don't count
/// either; without any body text, 16 px.
double bodySizePx(List<Block> blocks, {Set<Block> exclude = const {}}) {
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
          if (!muted && !exclude.contains(b)) runs(inlines);
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
  _Resolver(this.bodyPx, this.finePrint);

  final double bodyPx;

  /// Paragraphs shown as fine print whatever their size.
  final Set<Block> finePrint;

  List<Block> blocks(List<Block> blocks) => [for (final b in blocks) block(b)];

  Block block(Block b) => switch (b) {
    ParagraphBlock(:final inlines, :final align, :final dir, :final tight, :final muted) => ParagraphBlock(
      runs(inlines, fine: finePrint.contains(b)),
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

// -- Footers by their wording ------------------------------------------------

/// Score at which a paragraph reads as a footer: one strong phrase, or three
/// weak words together.
const footerThreshold = 3;

/// Phrases that on their own mark legal notices, company registration,
/// privacy pointers and newsletter footers.
final _strongFooterPhrases = [
  RegExp(r'\bintended (solely |only )?for the (use of the )?(named )?(addressee|recipient|individual|person)'),
  RegExp(r'\bintended recipient'),
  RegExp(r'\bif you are not the (intended|named|addressee)'),
  RegExp(
    r'\b(received|receive|got) this (e-?mail|message|communication|transmission)'
    r'( \(?including any attachments\)?| and any attachments?)? (in error|by mistake)',
  ),
  RegExp(r'\bnotify (the sender|us) immediately'),
  RegExp(r'\bregistered (office|address|number|no\b)'),
  RegExp(r'\bregistered in (england|scotland|wales|northern ireland|ireland)'),
  RegExp(r'\bcompany (registration )?(number|no\b)|\bcompany registered|\bregistration number'),
  RegExp(r'\bauthori[sz]ed and regulated|\bregulated by the\b'),
  RegExp(r'\blimited liability partnership'),
  RegExp(r'\bvat (registration )?(number|no\b|reg)'),
  RegExp(r'\bprivacy (policy|notice|statement|centre|center)'),
  RegExp(r'\bhow we (handle|process|use|collect|store|protect)( and (handle|process|use|collect|store|protect))? your'),
  RegExp(r'\bunsubscribe'),
  RegExp(r'\byou( are|.re)? receiv(ed|ing) this\b'),
  RegExp(r'\bthis (e-?mail|message|newsletter) (was|has been) sent (to|by)\b'),
  RegExp(
    r'\b(manage|update|change) (your )?(e-?mail |subscription |communication |notification |mailing )?'
    r'(preferences|subscriptions?)',
  ),
  RegExp(r'\be-?mail preferences'),
  RegExp(r'\bview (this |the |it |our )?(e-?mail |message |newsletter )?(online|in (your |a |the )?(web ?)?browser)'),
  RegExp(r'\ball rights reserved'),
  RegExp(r'\bour mailing address is'),
  RegExp(r'\bto stop receiving'),
  RegExp(r'\bopt[ -]?out\b'),
];

/// Words that mark a footer only together.
final _weakFooterWords = [
  RegExp(r'\bconfidential'),
  RegExp(r'\bprivileged'),
  RegExp(r'\blegally'),
  RegExp(r'\bdisclaimer'),
  RegExp(r'\bimportant notice'),
  RegExp(r'\bregistered in\b'),
  RegExp(r'\bpersonal (data|information)'),
  RegExp(r'\bdata protection'),
  RegExp(r'\bcopyright\b|©'),
  RegExp(r'\bliabilit'),
  RegExp(r'\bvat\b'),
  RegExp(r'\b(llp|ltd|limited|gmbh|inc)\b'),
];

/// How much [text] reads like a footer or legal notice (see
/// [footerThreshold]): 3 per strong phrase, 1 per weak word.
int footerScore(String text) {
  var t = text.length > 4000 ? text.substring(0, 4000) : text;
  t = t.toLowerCase().replaceAll(_blank, ' ').replaceAll('’', "'");
  var score = 0;
  for (final p in _strongFooterPhrases) {
    if (p.hasMatch(t)) score += 3;
  }
  for (final p in _weakFooterWords) {
    if (p.hasMatch(t)) score += 1;
  }
  return score;
}

final _footerLinkText = RegExp(
  r'unsubscribe|opt[ -]?out|preferences|subscription|privacy|cookie|terms|legal|disclaimer|policy|notice|imprint|'
  r'impressum|contact|view (it |this (e-?mail|message) )?(online|in (your |a |the )?(web ?)?browser)|web ?version|'
  r'online version|forward to a friend|profile|manage|mailing list|why did i get|data protection|gdpr|accessibility|'
  r'about us|home ?page|website|sitemap|faq|feedback|complaints',
  caseSensitive: false,
);
final _genericLinkText = RegExp(r'^(click )?(here|this link|link)$', caseSensitive: false);
final _footerLinkUrl = RegExp(
  r'unsub|opt-?out|preferen|privacy|legal|terms|manage|profile|subscription|webversion|browser|cookie|policy|notice|'
  r'gdpr|data-?protection|imprint|disclaimer',
  caseSensitive: false,
);

/// Whether a link belongs in a footer (unsubscribe, preferences, privacy,
/// a website or address) rather than being a call to action.
bool isFooterLink(LinkRef link) {
  final url = link.url.toLowerCase();
  if (url.startsWith('mailto:') || url.startsWith('tel:')) return true;
  final text = link.text.trim();
  if (text.isEmpty) return true;
  // A URL, domain or address written out.
  if (!text.contains(' ') && (text.contains('.') || text.contains('@'))) return true;
  if (_footerLinkText.hasMatch(text)) return true;
  return _genericLinkText.hasMatch(text) && _footerLinkUrl.hasMatch(url);
}

/// Paragraphs this long or shorter can sit between footer paragraphs
/// (addresses, phone numbers, sign-offs).
const _maxFooterLine = 100;

/// Finds the footer paragraphs: in the trailing part ([trailingStart]),
/// walking back from the end through footer-like blocks (footer paragraphs,
/// short lines, link rows, signatures, rules, images) up to the first one
/// that isn't. A footer paragraph with a link that isn't a footer link
/// holds the call to action and keeps its size. Quoted messages have their
/// own footers.
final class _FooterScan {
  _FooterScan(this.links);

  final List<LinkRef> links;

  /// Paragraphs to show as fine print.
  final finePrint = Set<Block>.identity();

  /// Paragraphs that read as footers (fine print or not).
  final matched = Set<Block>.identity();

  void scan(List<Block> blocks) {
    for (final b in blocks) {
      if (b is QuoteBlock) scan(b.children);
    }
    final start = trailingStart(blocks);
    for (var i = blocks.length - 1; i >= start; i--) {
      final b = blocks[i];
      if (b is RuleBlock || b is ImageBlock || b is CarouselBlock) continue;
      if (b is! ParagraphBlock) break;
      final text = inlineText(b.inlines);
      if (footerScore(text) >= footerThreshold) {
        matched.add(b);
        if (_linksOf(b).every((l) => l < links.length && isFooterLink(links[l]))) finePrint.add(b);
        continue;
      }
      final short = text.replaceAll(_blank, '').length <= _maxFooterLine;
      if (!b.muted && !short && !_onlyLinks(b)) break;
    }
  }

  static Iterable<int> _linksOf(ParagraphBlock p) =>
      p.inlines.whereType<TextRun>().map((r) => r.style.link).whereType<int>().toSet();

  static bool _onlyLinks(ParagraphBlock p) =>
      p.inlines.whereType<TextRun>().every((r) => r.style.link != null || r.text.replaceAll(_blank, '').length <= 3);
}
