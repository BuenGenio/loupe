// Steps 4–6 of the pipeline: walk the sanitised DOM and build the document
// model. Layout tables are linearised in reading order, only allowlisted
// elements and styles survive, and our own spacing replaces the sender's.

import 'dart:convert';
import 'dart:typed_data';

import 'package:html/dom.dart';

import '../model/document.dart';
import 'css.dart';
import 'limits.dart';
import 'links.dart';
import 'plain_text.dart' show expandTabs, linkify;
import 'sanitizer.dart' show flatText, imageDimension, visibleTextLength;

/// Maps a `cid:` reference to the Content-ID key the host can resolve, or
/// null if no part has it.
typedef CidResolver = String? Function(String contentId);

/// Converts a sanitised `<body>` into a [ReaderDocument].
ReaderDocument convertBody(Element body, {required Budget budget, CidResolver? resolveCid}) {
  final c = _Converter(budget, resolveCid);
  final root = _Sink(c);
  final ctx = c.derive(body, const _Ctx(), 'body');
  root.visitChildren(body, ctx);
  final blocks = root.finish();
  return c.document(blocks);
}

/// Default browser font size; email sizes are relative to it.
const _basePx = 16.0;

/// Inline elements whose background colour is a highlight (block
/// backgrounds are layout and are dropped).
const _inlineTags = {
  'span',
  'font',
  'a',
  'b',
  'strong',
  'i',
  'em',
  'u',
  's',
  'strike',
  'del',
  'ins',
  'mark',
  'code',
  'kbd',
  'samp',
  'tt',
  'small',
  'big',
  'sub',
  'sup',
  'abbr',
  'acronym',
  'cite',
  'q',
  'dfn',
  'var',
  'time',
  'bdi',
  'bdo',
  'label',
  'nobr',
};

/// Elements that start a new block.
const _blockTags = {
  'p',
  'div',
  'center',
  'address',
  'article',
  'aside',
  'footer',
  'header',
  'main',
  'nav',
  'section',
  'figure',
  'figcaption',
  'details',
  'summary',
  'caption',
  'body',
  'html',
  'hgroup',
  'dt',
  'li',
  'td',
  'th',
  'tr',
  'tbody',
  'thead',
  'tfoot',
};

const _headingTags = {'h1': 1, 'h2': 2, 'h3': 3, 'h4': 4, 'h5': 5, 'h6': 6};

/// Elements that make a table cell "block content" (so the table is layout).
const _blockContentTags = {'table', 'ul', 'ol', 'blockquote', 'pre', 'hr', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'dl'};

/// Paragraphs longer than this lose their centre/right alignment.
const _maxAlignedChars = 160;

/// Inherited formatting while walking the tree.
final class _Ctx {
  const _Ctx({
    this.run = RunStyle.plain,
    this.px = _basePx,
    this.align = BlockAlign.start,
    this.dir = TextDir.auto,
    this.pre = false,
    this.muted = false,
    this.buttonAnchor,
    this.buttonBg,
  });

  final RunStyle run;
  final double px;
  final BlockAlign align;
  final TextDir dir;

  /// Whitespace is preserved (`pre`, `white-space: pre*`).
  final bool pre;

  /// Inside a signature: paragraphs are dimmed.
  final bool muted;

  /// An anchor that is the only content of an ancestor with a background
  /// colour: it renders as a button in that colour.
  final Element? buttonAnchor;
  final int? buttonBg;

  _Ctx copyWith({
    RunStyle? run,
    double? px,
    BlockAlign? align,
    TextDir? dir,
    bool? pre,
    bool? muted,
    Element? buttonAnchor,
    int? buttonBg,
  }) => _Ctx(
    run: run ?? this.run,
    px: px ?? this.px,
    align: align ?? this.align,
    dir: dir ?? this.dir,
    pre: pre ?? this.pre,
    muted: muted ?? this.muted,
    buttonAnchor: buttonAnchor ?? this.buttonAnchor,
    buttonBg: buttonBg ?? this.buttonBg,
  );
}

final class _Converter {
  _Converter(this.budget, this.resolveCid);

  final Budget budget;
  final CidResolver? resolveCid;
  final images = <ImageRef>[];
  final links = <LinkRef>[];

  /// Background colour of links that render as buttons.
  final buttonBackgrounds = <int, int>{};
  int blockCount = 0;
  int dataImageBytes = 0;

  ReaderDocument document(List<Block> blocks) {
    final grouped = groupImages(blocks, images);
    var contentImages = 0;
    void countImages(List<Block> bs) {
      for (final b in bs) {
        switch (b) {
          case ImageBlock():
            contentImages++;
          case CarouselBlock(:final images):
            contentImages += images.length;
          case QuoteBlock(:final children):
            countImages(children);
          case ListBlock(:final items):
            items.forEach(countImages);
          default:
        }
      }
    }

    countImages(grouped);
    return ReaderDocument(
      blocks: grouped,
      images: images,
      links: links,
      stats: ReaderStats(
        keptTextLength: visibleBlocksLength(grouped),
        contentImages: contentImages,
        remoteImages: images.where((i) => i.isRemote).length,
        truncated: budget.exhausted,
      ),
    );
  }

  /// Applies an element's semantics, attributes and allowed styles.
  _Ctx derive(Element e, _Ctx ctx, String tag, [Map<String, String>? styleMap]) {
    final style = styleMap ?? parseStyle(e.attributes['style']);
    var run = ctx.run;
    var px = ctx.px;
    var align = ctx.align;
    var dir = ctx.dir;
    var pre = ctx.pre;

    switch (tag) {
      case 'b' || 'strong' || 'th' || 'dt':
        run = run.copyWith(bold: true);
      case 'i' || 'em' || 'cite' || 'dfn' || 'var' || 'address':
        run = run.copyWith(italic: true);
      case 'u' || 'ins':
        run = run.copyWith(underline: true);
      case 's' || 'strike' || 'del':
        run = run.copyWith(strike: true);
      case 'code' || 'kbd' || 'samp' || 'tt':
        run = run.copyWith(mono: true);
      case 'pre' || 'xmp' || 'listing' || 'plaintext':
        run = run.copyWith(mono: true);
        pre = true;
      case 'small':
        px = px * 0.85;
      case 'big':
        px = px * 1.2;
      case 'sub':
        run = run.copyWith(script: ScriptPosition.sub);
      case 'sup':
        run = run.copyWith(script: ScriptPosition.sup);
      case 'mark':
        run = run.copyWith(background: () => 0xFFFFEB3B);
      case 'center':
        align = BlockAlign.center;
      case 'a':
        // Browsers colour links unless the anchor itself sets a colour.
        run = run.copyWith(color: () => null, underline: true);
      case 'font':
        final color = parseColor(e.attributes['color']);
        if (color != null) run = run.copyWith(color: () => color);
        final size = e.attributes['size'];
        if (size != null) px = legacyFontSize(size) ?? px;
        final face = e.attributes['face'];
        if (face != null && isMonospaceFamily(face)) run = run.copyWith(mono: true);
    }

    // Presentational attributes.
    final alignAttr = e.attributes['align']?.toLowerCase();
    if (alignAttr != null && tag != 'table' && tag != 'img') align = _alignFrom(alignAttr) ?? align;
    final dirAttr = e.attributes['dir']?.toLowerCase();
    if (dirAttr == 'rtl') dir = TextDir.rtl;
    if (dirAttr == 'ltr') dir = TextDir.ltr;
    if (tag == 'body') {
      final text = parseColor(e.attributes['text']);
      if (text != null) run = run.copyWith(color: () => text);
    }

    // Allowed styles.
    if (style.isNotEmpty) {
      final color = style['color'];
      if (color != null) {
        final c = parseColor(color);
        if (c != null) run = run.copyWith(color: () => c);
      }
      if (_inlineTags.contains(tag)) {
        final bg = parseColor(style['background-color'] ?? style['background']);
        if (bg != null) run = run.copyWith(background: () => bg);
      }
      final weight = style['font-weight']?.toLowerCase();
      if (weight != null) {
        final n = int.tryParse(weight);
        if (weight == 'bold' || weight == 'bolder' || (n != null && n >= 600)) run = run.copyWith(bold: true);
        if (weight == 'normal' || weight == 'lighter' || (n != null && n < 600)) run = run.copyWith(bold: false);
      }
      final fontStyle = style['font-style']?.toLowerCase();
      if (fontStyle != null) run = run.copyWith(italic: fontStyle == 'italic' || fontStyle == 'oblique');
      final deco = (style['text-decoration'] ?? style['text-decoration-line'])?.toLowerCase();
      if (deco != null) {
        if (deco.contains('none')) run = run.copyWith(underline: false, strike: false);
        if (deco.contains('underline')) run = run.copyWith(underline: true);
        if (deco.contains('line-through')) run = run.copyWith(strike: true);
      }
      final textAlign = style['text-align'];
      if (textAlign != null) align = _alignFrom(textAlign.toLowerCase()) ?? align;
      final direction = style['direction']?.toLowerCase();
      if (direction == 'rtl') dir = TextDir.rtl;
      if (direction == 'ltr') dir = TextDir.ltr;
      final fontSize = fontSizeOf(style);
      if (fontSize != null) px = parseFontSize(fontSize, px) ?? px;
      final family = style['font-family'];
      if (family != null) run = run.copyWith(mono: isMonospaceFamily(family));
      final ws = style['white-space']?.toLowerCase();
      if (ws != null && ws.startsWith('pre')) pre = true;
      if (ws == 'normal' || ws == 'nowrap') pre = false;
    }
    if (px != ctx.px) run = run.copyWith(scale: scaleStep(px));
    return _Ctx(
      run: run,
      px: px,
      align: align,
      dir: dir,
      pre: pre,
      muted: ctx.muted || _isSignature(e),
      buttonAnchor: ctx.buttonAnchor,
      buttonBg: ctx.buttonBg,
    );
  }

  /// Signature containers of common mail clients.
  static bool _isSignature(Element e) {
    final cls = e.attributes['class'];
    if (cls != null && (cls.contains('gmail_signature') || cls.contains('moz-signature'))) return true;
    final id = e.attributes['id'];
    return id == 'Signature' || id == 'signature' || id == 'AppleMailSignature';
  }

  static BlockAlign? _alignFrom(String v) => switch (v) {
    'center' || 'middle' || '-webkit-center' => BlockAlign.center,
    'right' || 'end' || '-webkit-right' => BlockAlign.right,
    'left' || 'start' || 'justify' || '-webkit-left' => BlockAlign.start,
    _ => null,
  };

  int addLink(String url, String text) {
    final clean = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    links.add(LinkRef(url, text: clean, namedDomain: linkMismatch(clean, url)));
    return links.length - 1;
  }

  ImageSource? imageSource(String src) {
    final s = src.trim();
    final lower = s.toLowerCase();
    if (lower.startsWith('https://')) return RemoteImageSource(s);
    // Plain http is upgraded: Android blocks cleartext, the Original view's
    // CSP only allows https:, and it leaks less on the way.
    if (lower.startsWith('http://')) return RemoteImageSource('https://${s.substring(7)}');
    if (lower.startsWith('//')) return RemoteImageSource('https:$s');
    if (lower.startsWith('cid:')) {
      var id = s.substring(4);
      try {
        id = Uri.decodeComponent(id);
      } on ArgumentError {
        // Keep it as written.
      }
      id = id.replaceAll(RegExp(r'^<|>$'), '');
      final resolver = resolveCid;
      if (resolver == null) return CidImageSource(id);
      final key = resolver(id);
      return key == null ? null : CidImageSource(key);
    }
    if (lower.startsWith('data:')) return _dataImage(s);
    return null;
  }

  ImageSource? _dataImage(String uri) {
    final comma = uri.indexOf(',');
    if (comma < 0) return null;
    final meta = uri.substring(5, comma).toLowerCase();
    final parts = meta.split(';');
    final mime = parts.first.trim();
    if (!mime.startsWith('image/') || mime.contains('svg')) return null;
    final payload = uri.substring(comma + 1);
    Uint8List bytes;
    try {
      bytes = parts.contains('base64')
          ? base64Decode(payload.replaceAll(RegExp(r'\s'), ''))
          : Uint8List.fromList(utf8.encode(Uri.decodeComponent(payload)));
    } on FormatException {
      return null;
    } on ArgumentError {
      return null;
    }
    if (bytes.isEmpty) return null;
    dataImageBytes += bytes.length;
    if (dataImageBytes > budget.limits.maxDataImageBytes) {
      budget.markTruncated();
      return null;
    }
    return DataImageSource(mime, bytes);
  }
}

/// Paragraph-level attributes of the block element being filled.
final class _ParaAttrs {
  const _ParaAttrs({
    this.element,
    this.align = BlockAlign.start,
    this.dir = TextDir.auto,
    this.line = false,
    this.heading,
    this.pre = false,
    this.muted = false,
  });
  final Element? element;
  final BlockAlign align;
  final TextDir dir;

  /// From a `<div>`-like line: consecutive lines sit without spacing.
  final bool line;
  final int? heading;
  final bool pre;
  final bool muted;
}

/// Collects blocks for one container (the body, a quote, a list item, a cell).
final class _Sink {
  _Sink(this.c);

  final _Converter c;
  final blocks = <Block>[];
  final _inlines = <Inline>[];
  var _attrs = const _ParaAttrs();

  /// The line element that produced the last paragraph, while consecutive
  /// lines can still be tight.
  Element? _lastLine;

  List<Block> finish() {
    flush();
    return blocks;
  }

  void addBlock(Block b) {
    flush();
    if (c.blockCount >= c.budget.limits.maxBlocks) {
      c.budget.markTruncated();
      return;
    }
    c.blockCount++;
    blocks.add(b);
    _lastLine = null;
  }

  // -- Walking ---------------------------------------------------------------

  void visitChildren(Element e, _Ctx ctx) {
    for (final n in e.nodes) {
      if (!c.budget.tick()) return;
      visit(n, ctx);
    }
  }

  void visit(Node n, _Ctx ctx) {
    if (n is Text) {
      _addText(n.data, ctx);
      return;
    }
    if (n is! Element) return;
    final tag = n.localName ?? '';
    final style = parseStyle(n.attributes['style']);
    var inner = c.derive(n, ctx, tag, style);

    if (_attrs.pre && tag != 'img' && tag != 'br' && tag != 'a') {
      // Inside <pre>, everything is inline.
      visitChildren(n, inner);
      return;
    }

    // A block-ish element with a background whose only content is a link:
    // the link is a (bulletproof) button.
    if (!_inlineTags.contains(tag) || tag == 'span') {
      final bg = parseColor(style['background-color'] ?? style['background'] ?? n.attributes['bgcolor']);
      if (bg != null && tag != 'a') {
        final anchor = _soleAnchor(n);
        if (anchor != null) inner = inner.copyWith(buttonAnchor: anchor, buttonBg: bg);
      }
    }

    final display = style['display']?.toLowerCase();
    final displayBlock = display != null && RegExp(r'^(block|flex|grid|table|list-item)').hasMatch(display);

    switch (tag) {
      case 'br':
        _inlines.add(TextRun('\n', ctx.run));
      case 'wbr':
        _inlines.add(TextRun('\u200b', ctx.run));
      case 'img':
        _image(n, style, ctx);
      case 'hr':
        addBlock(const RuleBlock());
      case 'a':
        _anchor(n, style, ctx, inner, displayBlock);
      case 'ul' || 'ol' || 'menu' || 'dir':
        _list(n, inner, style, ordered: tag == 'ol');
      case 'blockquote':
        final sub = _Sink(c);
        sub.visitChildren(n, inner);
        final children = sub.finish();
        if (children.isNotEmpty) addBlock(QuoteBlock(children));
      case 'dd':
        final sub = _Sink(c);
        sub.visitChildren(n, inner);
        final children = sub.finish();
        if (children.isNotEmpty) addBlock(QuoteBlock(children, bar: false));
      case 'table':
        _table(n, inner);
      case 'pre' || 'xmp' || 'listing' || 'plaintext':
        if (inner.muted) {
          // A signature in <pre> (Thunderbird) is lines of text, not code.
          _block(n, inner.copyWith(run: inner.run.copyWith(mono: false)));
        } else {
          _block(n, inner, pre: true);
        }
      default:
        final heading = _headingTags[tag];
        if (heading != null) {
          _block(n, inner, heading: heading);
        } else if (_blockTags.contains(tag) || (displayBlock && _inlineTags.contains(tag)) || tag == 'dl') {
          if ((tag == 'div' || tag == 'p') && _hasTopRule(style)) addBlock(const RuleBlock());
          _block(n, inner, line: _isLine(n, tag, style));
        } else {
          // Inline formatting and unknown elements (o:p, v:*, font, span…).
          visitChildren(n, inner);
        }
    }
  }

  /// `<div>`s, and paragraphs whose margins were zeroed (Outlook's MsoNormal),
  /// are lines: consecutive ones sit without paragraph spacing.
  bool _isLine(Element e, String tag, Map<String, String> style) {
    if (tag == 'div') return !_hasVerticalSpacing(style);
    if (tag == 'p') {
      final cls = e.attributes['class'] ?? '';
      if (cls.contains('MsoNormal') || cls.contains('MsoPlainText')) return true;
      final margin = style['margin'];
      final zeroMargin =
          (margin != null && margin.trim().split(RegExp(r'\s+')).every((v) => isZeroLength(v) || v == 'auto')) ||
          (isZeroLength(style['margin-top']) && isZeroLength(style['margin-bottom']));
      return zeroMargin && !_hasVerticalSpacing(style, checkMargin: false);
    }
    return false;
  }

  bool _hasVerticalSpacing(Map<String, String> style, {bool checkMargin = true}) {
    for (final p in [
      'padding-top',
      'padding-bottom',
      if (checkMargin) 'margin-top',
      if (checkMargin) 'margin-bottom',
    ]) {
      final v = parseLength(style[p]);
      if (v != null && v >= 8) return true;
    }
    for (final p in ['padding', if (checkMargin) 'margin']) {
      final parts = style[p]?.trim().split(RegExp(r'\s+'));
      if (parts == null || parts.isEmpty) continue;
      final top = parseLength(parts[0]);
      final bottom = parseLength(parts.length >= 3 ? parts[2] : parts[0]);
      if ((top ?? 0) >= 8 || (bottom ?? 0) >= 8) return true;
    }
    return false;
  }

  bool _hasTopRule(Map<String, String> style) {
    final top = style['border-top'];
    if (top == null) return false;
    final v = top.toLowerCase();
    return v.contains('solid') && !v.contains('none') && !RegExp(r'(^|\s)0(px|pt)?(\s|$)').hasMatch(v);
  }

  /// Visits a block element: its text becomes its own paragraph(s).
  void _block(Element e, _Ctx ctx, {bool line = false, int? heading, bool pre = false}) {
    flush();
    final saved = _attrs;
    final before = blocks.length;
    _attrs = _ParaAttrs(
      element: e,
      align: ctx.align,
      dir: ctx.dir,
      line: line,
      heading: heading,
      pre: pre,
      muted: ctx.muted,
    );
    visitChildren(e, pre ? ctx.copyWith(pre: true) : ctx);
    flush();
    _attrs = saved;
    // An empty block (`<div><br></div>`, `<p>&nbsp;</p>`) is a blank line:
    // the next line gets paragraph spacing again.
    if (blocks.length == before && line) _lastLine = null;
  }

  // -- Inline content --------------------------------------------------------

  void _addText(String data, _Ctx ctx) {
    if (data.isEmpty) return;
    if (ctx.px <= 0.5) return; // font-size:0 whitespace tricks.
    final text = ctx.pre
        ? expandTabs(data.replaceAll('\r\n', '\n').replaceAll('\r', '\n'))
        : data.replaceAll(_collapsible, ' ');
    _inlines.add(TextRun(text, ctx.run));
  }

  void _anchor(Element a, Map<String, String> style, _Ctx parent, _Ctx ctx, bool displayBlock) {
    final url = safeHref(a.attributes['href']);
    if (url == null) {
      // Not openable (javascript:, relative, a bare name): plain text.
      visitChildren(a, c.derive(a, parent, 'span', style));
      return;
    }
    final text = flatText(a, 400);
    final index = c.addLink(url, text);
    final ownBg = parseColor(style['background-color'] ?? style['background'] ?? a.attributes['bgcolor']);
    final buttonBg = ownBg ?? (identical(ctx.buttonAnchor, a) ? ctx.buttonBg : null);
    final run = ctx.run.copyWith(link: () => index);
    if (buttonBg != null && text.trim().isNotEmpty && text.trim().length <= 60) {
      c.buttonBackgrounds[index] = buttonBg;
    }
    if (displayBlock) {
      _block(a, ctx.copyWith(run: run));
    } else {
      visitChildren(a, ctx.copyWith(run: run));
    }
  }

  void _image(Element img, Map<String, String> style, _Ctx ctx) {
    if (c.blockCount >= c.budget.limits.maxBlocks) return;
    final source = c.imageSource(img.attributes['src'] ?? '');
    if (source == null) return;
    final w = imageDimension(img, 'width', style);
    final h = imageDimension(img, 'height', style);
    final icon =
        (w != null && h != null && w <= 48 && h <= 48) ||
        (w != null && h == null && w <= 32) ||
        (h != null && w == null && h <= 32);
    final alt = img.attributes['alt']?.trim() ?? img.attributes['title']?.trim();
    c.images.add(ImageRef(source, width: w, height: h, alt: alt, link: ctx.run.link, icon: icon));
    final index = c.images.length - 1;
    if (icon) {
      _inlines.add(InlineImage(index));
    } else {
      addBlock(ImageBlock(index));
    }
  }

  // -- Lists -----------------------------------------------------------------

  void _list(Element list, _Ctx ctx, Map<String, String> style, {required bool ordered}) {
    flush();
    final items = <List<Block>>[];
    _Sink? current;
    void closeItem() {
      if (current == null) return;
      final blocks = current!.finish();
      if (blocks.isNotEmpty) items.add(blocks);
      current = null;
    }

    for (final n in list.nodes) {
      if (!c.budget.tick()) break;
      if (n is Element && n.localName == 'li') {
        closeItem();
        final sub = _Sink(c);
        final liStyle = parseStyle(n.attributes['style']);
        final liCtx = c.derive(n, ctx, 'li', liStyle);
        sub._attrs = _ParaAttrs(element: n, align: liCtx.align, dir: liCtx.dir, muted: liCtx.muted);
        sub.visitChildren(n, liCtx);
        final blocks = sub.finish();
        if (blocks.isNotEmpty) items.add(blocks);
      } else if (n is Text && n.data.trim().isEmpty) {
        continue;
      } else {
        // Stray content (a nested list directly inside <ul>): attach it to
        // the previous item, as browsers render it.
        if (current == null) {
          current = _Sink(c);
          if (items.isNotEmpty) current!.blocks.addAll(items.removeLast());
        }
        current!.visit(n, ctx);
      }
    }
    closeItem();
    if (items.isEmpty) return;
    final type = (list.attributes['type'] ?? '').trim();
    final listStyle = (style['list-style-type'] ?? style['list-style'] ?? '').toLowerCase();
    var marker = ordered ? ListMarker.decimal : ListMarker.disc;
    if (listStyle.contains('none')) {
      marker = ListMarker.none;
    } else if (ordered) {
      marker = switch (type) {
        'a' => ListMarker.lowerAlpha,
        'A' => ListMarker.upperAlpha,
        'i' => ListMarker.lowerRoman,
        'I' => ListMarker.upperRoman,
        _ => switch (listStyle) {
          final s when s.contains('lower-alpha') || s.contains('lower-latin') => ListMarker.lowerAlpha,
          final s when s.contains('upper-alpha') || s.contains('upper-latin') => ListMarker.upperAlpha,
          final s when s.contains('lower-roman') => ListMarker.lowerRoman,
          final s when s.contains('upper-roman') => ListMarker.upperRoman,
          _ => ListMarker.decimal,
        },
      };
    }
    final start = int.tryParse(list.attributes['start'] ?? '') ?? 1;
    addBlock(ListBlock(items, marker: marker, start: start));
  }

  // -- Tables ----------------------------------------------------------------

  void _table(Element table, _Ctx outer) {
    flush();
    // Tables don't inherit text alignment (quirks mode, and what email CSS
    // assumes): a centred outer cell shouldn't centre every paragraph.
    final ctx = outer.copyWith(align: BlockAlign.start);
    final rows = tableRows(table);
    if (isDataTable(table, rows)) {
      _dataTable(rows, ctx);
      return;
    }
    // Layout table: linearise in reading (DOM) order; columns become one.
    for (final caption in table.children.where((e) => e.localName == 'caption')) {
      _block(caption, c.derive(caption, ctx, 'caption'));
    }
    for (final row in rows) {
      if (!c.budget.tick()) return;
      final rowCtx = c.derive(row, ctx, 'tr');
      final cells = row.children.where((e) => e.localName == 'td' || e.localName == 'th').toList();
      if (_isInlineRow(cells)) {
        _inlineRow(row, cells, rowCtx);
      } else {
        for (final cell in cells) {
          visit(cell, rowCtx);
        }
      }
    }
  }

  /// A row of short, inline-only cells (footer links, social icons) becomes
  /// one line instead of a stack of tiny paragraphs.
  bool _isInlineRow(List<Element> cells) {
    var nonEmpty = 0;
    var total = 0;
    for (final cell in cells) {
      final len = visibleTextLength(cell);
      final hasImage = cell.querySelector('img') != null;
      if (len == 0 && !hasImage) continue;
      if (len > 40) return false;
      total += len;
      nonEmpty++;
      for (final e in cell.querySelectorAll('*')) {
        final t = e.localName;
        if (_blockContentTags.contains(t) || t == 'div' || t == 'p' || t == 'br') return false;
        if (t == 'img' && !_looksLikeIcon(e)) return false;
      }
    }
    return nonEmpty >= 2 && total <= 100;
  }

  void _inlineRow(Element row, List<Element> cells, _Ctx ctx) {
    flush();
    final saved = _attrs;
    final first = cells.firstWhere((c) => visibleTextLength(c) > 0 || c.querySelector('img') != null);
    final firstCtx = c.derive(first, ctx, 'td');
    _attrs = _ParaAttrs(element: row, align: firstCtx.align, dir: firstCtx.dir, muted: firstCtx.muted);
    String? previous;
    for (final cell in cells) {
      final text = flatText(cell, 100).trim();
      final hasImage = cell.querySelector('img') != null;
      if (text.isEmpty && !hasImage) continue;
      if (previous != null) {
        final separatorLike = RegExp(r'^[|•·\-–—/]$');
        final sep = previous.isEmpty || text.isEmpty
            ? '\u2003'
            : (separatorLike.hasMatch(previous) || separatorLike.hasMatch(text) || previous.endsWith(':')
                  ? ' '
                  : ' · ');
        _inlines.add(TextRun(sep, ctx.run));
      }
      final cellCtx = c.derive(cell, ctx, 'td');
      visitChildren(cell, cellCtx);
      previous = text;
    }
    flush();
    _attrs = saved;
  }

  void _dataTable(List<Element> rows, _Ctx ctx) {
    final out = <List<TableCell>>[];
    var columns = 0;
    for (final row in rows) {
      final rowCtx = c.derive(row, ctx, 'tr');
      final cells = <TableCell>[];
      var span = 0;
      for (final cell in row.children) {
        final tag = cell.localName;
        if (tag != 'td' && tag != 'th') continue;
        final cellCtx = c.derive(cell, rowCtx, tag!);
        final sub = _Sink(c);
        sub._attrs = _ParaAttrs(element: cell, align: cellCtx.align, dir: cellCtx.dir);
        sub.visitChildren(cell, cellCtx);
        final colspan = (int.tryParse(cell.attributes['colspan'] ?? '') ?? 1).clamp(1, 12);
        span += colspan;
        cells.add(
          TableCell(
            _flattenToInlines(sub.finish()),
            header: tag == 'th' || row.parent?.localName == 'thead',
            colspan: colspan,
            align: cellCtx.align,
          ),
        );
      }
      if (cells.isEmpty) continue;
      if (span > columns) columns = span;
      out.add(cells);
    }
    if (out.isNotEmpty) addBlock(TableBlock(out, columns: columns));
  }

  List<Inline> _flattenToInlines(List<Block> blocks) {
    final out = <Inline>[];
    void lineBreak() {
      if (out.isNotEmpty) out.add(const TextRun('\n'));
    }

    for (final b in blocks) {
      switch (b) {
        case ParagraphBlock(:final inlines) || HeadingBlock(:final inlines) || PreBlock(:final inlines):
          lineBreak();
          out.addAll(inlines);
        case ButtonBlock(:final text, :final link):
          lineBreak();
          out.add(TextRun(text, RunStyle(link: link, underline: true)));
        case ImageBlock(:final image):
          lineBreak();
          out.add(InlineImage(image));
        case CarouselBlock(:final images):
          lineBreak();
          out.addAll(images.map(InlineImage.new));
        case QuoteBlock(:final children):
          lineBreak();
          out.addAll(_flattenToInlines(children));
        case ListBlock(:final items):
          for (final item in items) {
            lineBreak();
            out.add(const TextRun('• '));
            out.addAll(_flattenToInlines(item));
          }
        case TableBlock() || RuleBlock():
          break;
      }
    }
    return out;
  }

  // -- Paragraph assembly ----------------------------------------------------

  void flush() {
    if (_inlines.isEmpty) return;
    final inlines = _linkifyBareUrls(normalizeInlines(_inlines, keepWhitespace: _attrs.pre));
    _inlines.clear();
    if (!_hasContent(inlines)) return;
    final attrs = _attrs;
    final text = inlineText(inlines);
    final align = text.length <= _maxAlignedChars ? attrs.align : BlockAlign.start;

    if (attrs.pre) {
      addBlock(PreBlock(inlines));
      return;
    }

    // A paragraph made only of button-coloured links is a row of buttons.
    final runs = inlines.whereType<TextRun>().where((r) => r.text.trim().isNotEmpty).toList();
    if (runs.isNotEmpty &&
        inlines.every((i) => i is TextRun) &&
        runs.every((r) => r.style.link != null && c.buttonBackgrounds.containsKey(r.style.link))) {
      final order = <int>[];
      final labels = <int, StringBuffer>{};
      final colors = <int, int?>{};
      for (final r in runs) {
        final link = r.style.link!;
        if (!labels.containsKey(link)) {
          order.add(link);
          colors[link] = r.style.color;
        }
        (labels[link] ??= StringBuffer()).write(r.text);
      }
      for (final link in order) {
        addBlock(
          ButtonBlock(
            text: labels[link].toString().replaceAll(RegExp(r'\s+'), ' ').trim(),
            link: link,
            background: c.buttonBackgrounds[link],
            color: colors[link],
            align: attrs.align == BlockAlign.start ? BlockAlign.center : attrs.align,
          ),
        );
      }
      return;
    }

    var heading = attrs.heading;
    if (heading == null && runs.isNotEmpty && text.length <= 150) {
      // Big text is a heading, whatever tag it came in.
      final minScale = runs.map((r) => r.style.scale).reduce((a, b) => a < b ? a : b);
      if (minScale >= 1.3) heading = minScale >= 1.5 ? 1 : 2;
    }
    if (heading != null) {
      addBlock(
        HeadingBlock(
          heading,
          [for (final i in inlines) i is TextRun ? TextRun(i.text, i.style.copyWith(scale: 1.0)) : i],
          align: align,
          dir: attrs.dir,
        ),
      );
      return;
    }

    final element = attrs.element;
    final last = _lastLine;
    final tight =
        attrs.line &&
        element != null &&
        last != null &&
        (identical(last, element) ||
            identical(last.parent, element.parent) ||
            identical(element.parent, last) ||
            identical(last.parent, element));
    // Long text styled big is body copy, not a heading: keep it near body
    // size so a phone line still holds a few words.
    final body = text.length > 150
        ? [
            for (final i in inlines)
              i is TextRun && i.style.scale > 1.15 ? TextRun(i.text, i.style.copyWith(scale: 1.15)) : i,
          ]
        : inlines;
    addBlock(ParagraphBlock(body, align: align, dir: attrs.dir, tight: tight, muted: attrs.muted));
    if (attrs.line) _lastLine = element;
  }

  /// Bare URLs and addresses in text become links, as other mail apps do
  /// ("copy and paste this URL into your browser").
  List<Inline> _linkifyBareUrls(List<Inline> inlines) {
    if (!inlines.any((i) => i is TextRun && i.style.link == null && _maybeLink.hasMatch(i.text))) return inlines;
    return [
      for (final i in inlines)
        if (i is TextRun && i.style.link == null && _maybeLink.hasMatch(i.text))
          ...linkify(i.text, c.links, i.style)
        else
          i,
    ];
  }

  static final _maybeLink = RegExp(r'https?://|www\.|@', caseSensitive: false);

  static bool _hasContent(List<Inline> inlines) =>
      inlines.any((i) => i is InlineImage || (i is TextRun && i.text.replaceAll(_blank, '').isNotEmpty));
}

final _collapsible = RegExp(r'[ \t\n\r\f]+');
final _manyNewlines = RegExp(r'\n{3,}');
final _leadingNewlines = RegExp(r'^\n*');
final _trailingNewlines = RegExp(r'\n*$');
final _blank = RegExp(r'[\s\u00a0\u200b\u200c\u200d\ufeff]+');

/// Collapses whitespace the way a browser lays it out, trims line starts and
/// ends, merges runs with the same style.
List<Inline> normalizeInlines(List<Inline> inlines, {bool keepWhitespace = false}) {
  final out = <Inline>[];
  final buf = StringBuffer();
  RunStyle? style;
  var atLineStart = true;
  // Whitespace waiting for the next visible character: '' (none), ' ', or a
  // lone nbsp (which binds and is kept). It keeps the style of the run it was
  // typed in, so a link's underline doesn't extend over the gap before it.
  var pending = '';
  var pendingStyle = RunStyle.plain;

  void emit() {
    if (buf.isEmpty) return;
    out.add(TextRun(buf.toString(), style!));
    buf.clear();
  }

  void write(String s, RunStyle st) {
    if (style != st) {
      emit();
      style = st;
    }
    buf.write(s);
  }

  void flushPending() {
    if (pending.isNotEmpty && !atLineStart) write(pending, pendingStyle);
    pending = '';
  }

  for (final inline in inlines) {
    if (inline is! TextRun) {
      flushPending();
      emit();
      out.add(inline);
      atLineStart = false;
      style = null;
      continue;
    }
    final st = inline.style;
    if (keepWhitespace) {
      write(inline.text, st);
      atLineStart = inline.text.endsWith('\n');
      continue;
    }
    final text = inline.text;
    var i = 0;
    while (i < text.length) {
      final ch = text[i];
      if (ch == '\n') {
        pending = '';
        write('\n', st);
        atLineStart = true;
        i++;
        continue;
      }
      if (ch == ' ' || ch == '\u00a0') {
        var j = i;
        while (j < text.length && (text[j] == ' ' || text[j] == '\u00a0')) {
          j++;
        }
        if (!atLineStart) {
          // A lone nbsp stays; anything else (or next to other spaces)
          // collapses to one plain space.
          final loneNbsp = j - i == 1 && ch == '\u00a0' && pending.isEmpty;
          if (pending.isEmpty) pendingStyle = st;
          pending = loneNbsp ? '\u00a0' : ' ';
        }
        i = j;
        continue;
      }
      flushPending();
      write(ch, st);
      atLineStart = false;
      i++;
    }
  }
  emit();
  return _trimLines(out, keepIndent: keepWhitespace);
}

/// Drops trailing spaces before line breaks, leading/trailing breaks and
/// collapses more than one blank line.
List<Inline> _trimLines(List<Inline> inlines, {bool keepIndent = false}) {
  // Work on a flat string per run, then re-split.
  final out = <Inline>[];
  for (final i in inlines) {
    if (i is TextRun) {
      var t = i.text.replaceAll(RegExp(r'[ \u00a0]+\n'), '\n');
      if (out.isNotEmpty && out.last is TextRun) {
        final prev = out.last as TextRun;
        if (t.startsWith('\n') && (prev.text.endsWith(' ') || prev.text.endsWith('\u00a0'))) {
          out[out.length - 1] = TextRun(prev.text.trimRight(), prev.style);
        }
      }
      if (t.isNotEmpty) out.add(TextRun(t, i.style));
    } else {
      out.add(i);
    }
  }
  // Leading newlines.
  while (out.isNotEmpty && out.first is TextRun) {
    final first = out.first as TextRun;
    final t = first.text.replaceFirst(keepIndent ? _leadingNewlines : RegExp(r'^[\n ]+'), '');
    if (t.isEmpty) {
      out.removeAt(0);
    } else {
      out[0] = TextRun(t, first.style);
      break;
    }
  }
  // Trailing whitespace.
  while (out.isNotEmpty && out.last is TextRun) {
    final last = out.last as TextRun;
    final t = last.text.replaceFirst(RegExp(r'[\s\u00a0]+$'), '');
    if (t.isEmpty) {
      out.removeLast();
    } else {
      out[out.length - 1] = TextRun(t, last.style);
      break;
    }
  }
  // At most one blank line in a row, across run boundaries.
  var newlines = 0;
  final result = <Inline>[];
  for (final i in out) {
    if (i is! TextRun) {
      newlines = 0;
      result.add(i);
      continue;
    }
    var t = i.text.replaceAll(_manyNewlines, '\n\n');
    if (newlines > 0) {
      final lead = _leadingNewlines.firstMatch(t)![0]!.length;
      final keep = (2 - newlines).clamp(0, lead);
      t = t.substring(lead - keep);
    }
    if (t.isEmpty) continue;
    final trailing = _trailingNewlines.firstMatch(t)![0]!.length;
    newlines = trailing == t.length ? newlines + trailing : trailing;
    result.add(TextRun(t, i.style));
  }
  return result;
}

// -- Table classification ----------------------------------------------------

/// The rows of [table] (not of nested tables), in order.
List<Element> tableRows(Element table) {
  final rows = <Element>[];
  for (final child in table.children) {
    switch (child.localName) {
      case 'tr':
        rows.add(child);
      case 'thead' || 'tbody' || 'tfoot':
        rows.addAll(child.children.where((e) => e.localName == 'tr'));
    }
  }
  return rows;
}

/// A data table has a header row or a regular grid of short cells; anything
/// else (role=presentation, nested tables, block content) is layout.
bool isDataTable(Element table, [List<Element>? rowList]) {
  final role = table.attributes['role']?.toLowerCase();
  if (role == 'presentation' || role == 'none') return false;
  final rows = rowList ?? tableRows(table);
  if (rows.length < 2) return false;
  if (table.querySelector('table') != null) return false;

  var hasHeader = false;
  final counts = <int, int>{};
  var cellCount = 0;
  var textTotal = 0;
  final filledColumns = <int>{};
  for (final row in rows) {
    var col = 0;
    for (final cell in row.children) {
      final tag = cell.localName;
      if (tag != 'td' && tag != 'th') continue;
      if (tag == 'th') hasHeader = true;
      for (final e in cell.querySelectorAll('*')) {
        final t = e.localName;
        if (_blockContentTags.contains(t)) return false;
        if (t == 'img' && !_looksLikeIcon(e)) return false;
      }
      final len = visibleTextLength(cell);
      if (len > 200) return false;
      if (len > 0) filledColumns.add(col);
      textTotal += len;
      cellCount++;
      col += (int.tryParse(cell.attributes['colspan'] ?? '') ?? 1).clamp(1, 12);
    }
    counts[col] = (counts[col] ?? 0) + 1;
  }
  final columns = counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  if (columns < 2 || columns > 12) return false;
  // Spacer columns (always empty) are layout.
  if (filledColumns.length < columns) return false;
  if (hasHeader) return true;
  final regular = counts[columns]! / rows.length >= 0.75;
  return regular && cellCount > 0 && textTotal / cellCount <= 40;
}

bool _looksLikeIcon(Element img) {
  final style = parseStyle(img.attributes['style']);
  final w = imageDimension(img, 'width', style);
  final h = imageDimension(img, 'height', style);
  return (w != null && w <= 48 && (h == null || h <= 48)) || (h != null && h <= 32 && w == null);
}

// -- Post-processing ---------------------------------------------------------

/// Turns runs of two or more consecutive images into carousels, except
/// stacked full-width slices of one remote picture (image-only newsletters).
List<Block> groupImages(List<Block> blocks, List<ImageRef> images) {
  final out = <Block>[];
  var run = <int>[];

  void close() {
    if (run.length >= 2 && !_areSlices(run, images)) {
      out.add(CarouselBlock(run));
    } else {
      out.addAll(run.map(ImageBlock.new));
    }
    run = [];
  }

  for (final b in blocks) {
    if (b is ImageBlock) {
      run.add(b.image);
      continue;
    }
    close();
    out.add(switch (b) {
      QuoteBlock(:final children, :final bar) => QuoteBlock(groupImages(children, images), bar: bar),
      ListBlock(:final items, :final marker, :final start) => ListBlock(
        [for (final i in items) groupImages(i, images)],
        marker: marker,
        start: start,
      ),
      _ => b,
    });
  }
  close();
  // Rules at the edges or doubled are noise.
  final cleaned = <Block>[];
  for (final b in out) {
    if (b is RuleBlock && (cleaned.isEmpty || cleaned.last is RuleBlock)) continue;
    cleaned.add(b);
  }
  while (cleaned.isNotEmpty && cleaned.last is RuleBlock) {
    cleaned.removeLast();
  }
  if (cleaned.isNotEmpty) {
    final first = cleaned.first;
    if (first is ParagraphBlock && first.tight) {
      cleaned[0] = ParagraphBlock(first.inlines, align: first.align, dir: first.dir, muted: first.muted);
    }
  }
  return cleaned;
}

bool _areSlices(List<int> run, List<ImageRef> images) {
  final refs = run.map((i) => images[i]).toList();
  if (!refs.every((r) => r.isRemote)) return false;
  final widths = refs.map((r) => r.width).toSet();
  return widths.length == 1 && (widths.first ?? 0) >= 300;
}

/// Non-whitespace characters of text in [blocks].
int visibleBlocksLength(List<Block> blocks) {
  var n = 0;
  int text(List<Inline> inlines) => inlineText(inlines).replaceAll(_blank, '').length;
  for (final b in blocks) {
    n += switch (b) {
      ParagraphBlock(:final inlines) || HeadingBlock(:final inlines) || PreBlock(:final inlines) => text(inlines),
      QuoteBlock(:final children) => visibleBlocksLength(children),
      ListBlock(:final items) => items.fold(0, (s, i) => s + visibleBlocksLength(i)),
      ButtonBlock(text: final t) => t.replaceAll(_blank, '').length,
      TableBlock(:final rows) => rows.fold(0, (s, r) => s + r.fold(0, (s, c) => s + text(c.inlines))),
      RuleBlock() || ImageBlock() || CarouselBlock() => 0,
    };
  }
  return n;
}

/// Finds the single link that is the only content of [e] (bulletproof
/// buttons: a coloured cell around one anchor).
Element? _soleAnchor(Element e) {
  Element? anchor;
  final stack = <Node>[...e.nodes.reversed];
  var seen = 0;
  while (stack.isNotEmpty) {
    if (++seen > 200) return null;
    final n = stack.removeLast();
    if (n is Text) {
      if (n.data.replaceAll(_blank, '').isNotEmpty) return null;
      continue;
    }
    if (n is! Element) continue;
    final tag = n.localName;
    if (tag == 'a' && n.attributes['href'] != null) {
      if (anchor != null) return null;
      anchor = n;
      continue;
    }
    if (tag == 'img') return null;
    stack.addAll(n.nodes.reversed);
  }
  if (anchor == null) return null;
  final len = visibleTextLength(anchor);
  return len > 0 && len <= 60 ? anchor : null;
}
