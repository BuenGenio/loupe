// The reader's document model: what the pipeline produces and the renderer
// draws. Pure Dart (no Flutter) so it can be built in a background isolate and
// sent back, and serialisable to JSON so snapshot tests can diff it.
//
// Colours are 0xAARRGGBB ints; the renderer adapts them to the theme.

import 'dart:typed_data';

import '../pipeline/redirects.dart' show Redirect;

/// Paragraph alignment. Only short blocks keep a centre/right alignment.
enum BlockAlign { start, center, right }

/// Explicit text direction from a `dir` attribute; [auto] lets the renderer
/// detect it from the first strong character.
enum TextDir { auto, ltr, rtl }

/// Vertical position of a run.
enum ScriptPosition { normal, sub, sup }

/// Marker of a list.
enum ListMarker { disc, decimal, lowerAlpha, upperAlpha, lowerRoman, upperRoman, none }

/// The allowed character styles of a run of text.
final class RunStyle {
  const RunStyle({
    this.bold = false,
    this.italic = false,
    this.underline = false,
    this.strike = false,
    this.mono = false,
    this.scale = 1.0,
    this.script = ScriptPosition.normal,
    this.color,
    this.background,
    this.link,
  });

  static const plain = RunStyle();

  final bool bold;
  final bool italic;
  final bool underline;
  final bool strike;
  final bool mono;

  /// Relative font size: 0.8 (fine print, shown in the secondary text colour
  /// unless the run has its own colour), 1.0, or a larger step up to 1.5.
  final double scale;

  /// Fine print: legal notices, footers, text the sender set clearly smaller.
  bool get fine => scale < 1;
  final ScriptPosition script;

  /// Text colour (0xAARRGGBB), null for the theme's text colour.
  final int? color;

  /// Highlight colour behind the text.
  final int? background;

  /// Index into [ReaderDocument.links].
  final int? link;

  RunStyle copyWith({
    bool? bold,
    bool? italic,
    bool? underline,
    bool? strike,
    bool? mono,
    double? scale,
    ScriptPosition? script,
    int? Function()? color,
    int? Function()? background,
    int? Function()? link,
  }) => RunStyle(
    bold: bold ?? this.bold,
    italic: italic ?? this.italic,
    underline: underline ?? this.underline,
    strike: strike ?? this.strike,
    mono: mono ?? this.mono,
    scale: scale ?? this.scale,
    script: script ?? this.script,
    color: color != null ? color() : this.color,
    background: background != null ? background() : this.background,
    link: link != null ? link() : this.link,
  );

  Map<String, Object?> toJson() => {
    if (bold) 'b': true,
    if (italic) 'i': true,
    if (underline) 'u': true,
    if (strike) 's': true,
    if (mono) 'mono': true,
    if (scale != 1.0) 'scale': scale,
    if (script != ScriptPosition.normal) 'script': script.name,
    if (color != null) 'color': colorToHex(color!),
    if (background != null) 'bg': colorToHex(background!),
    if (link != null) 'link': link,
  };

  @override
  bool operator ==(Object other) =>
      other is RunStyle &&
      other.bold == bold &&
      other.italic == italic &&
      other.underline == underline &&
      other.strike == strike &&
      other.mono == mono &&
      other.scale == scale &&
      other.script == script &&
      other.color == color &&
      other.background == background &&
      other.link == link;

  @override
  int get hashCode => Object.hash(bold, italic, underline, strike, mono, scale, script, color, background, link);
}

String colorToHex(int argb) {
  final rgb = (argb & 0xFFFFFF).toRadixString(16).padLeft(6, '0');
  final a = (argb >>> 24) & 0xFF;
  return a == 0xFF ? '#$rgb' : '#$rgb${a.toRadixString(16).padLeft(2, '0')}';
}

// ---------------------------------------------------------------------------
// Inlines

sealed class Inline {
  const Inline();
  Map<String, Object?> toJson();
}

/// Styled text. May contain `\n` for hard line breaks.
final class TextRun extends Inline {
  const TextRun(this.text, [this.style = RunStyle.plain]);
  final String text;
  final RunStyle style;

  @override
  Map<String, Object?> toJson() => {'text': text, ...style.toJson()};
}

/// A small image (icon) inside the text flow.
final class InlineImage extends Inline {
  const InlineImage(this.image);

  /// Index into [ReaderDocument.images].
  final int image;

  @override
  Map<String, Object?> toJson() => {'img': image};
}

// ---------------------------------------------------------------------------
// Blocks

sealed class Block {
  const Block();
  Map<String, Object?> toJson();
}

final class ParagraphBlock extends Block {
  const ParagraphBlock(
    this.inlines, {
    this.align = BlockAlign.start,
    this.dir = TextDir.auto,
    this.tight = false,
    this.muted = false,
  });
  final List<Inline> inlines;
  final BlockAlign align;
  final TextDir dir;

  /// Follows the previous block without paragraph spacing (consecutive
  /// `<div>` lines, Outlook's margin-less paragraphs).
  final bool tight;

  /// Shown dimmed (signatures in plain text).
  final bool muted;

  @override
  Map<String, Object?> toJson() => {
    'type': 'p',
    if (align != BlockAlign.start) 'align': align.name,
    if (dir != TextDir.auto) 'dir': dir.name,
    if (tight) 'tight': true,
    if (muted) 'muted': true,
    'inlines': [for (final i in inlines) i.toJson()],
  };
}

final class HeadingBlock extends Block {
  const HeadingBlock(this.level, this.inlines, {this.align = BlockAlign.start, this.dir = TextDir.auto});

  /// 1 – 6.
  final int level;
  final List<Inline> inlines;
  final BlockAlign align;
  final TextDir dir;

  @override
  Map<String, Object?> toJson() => {
    'type': 'h$level',
    if (align != BlockAlign.start) 'align': align.name,
    if (dir != TextDir.auto) 'dir': dir.name,
    'inlines': [for (final i in inlines) i.toJson()],
  };
}

/// A quotation (with a bar) or a plain indentation (`dd`, without).
final class QuoteBlock extends Block {
  const QuoteBlock(this.children, {this.bar = true});
  final List<Block> children;
  final bool bar;

  @override
  Map<String, Object?> toJson() => {
    'type': bar ? 'quote' : 'indent',
    'children': [for (final b in children) b.toJson()],
  };
}

final class ListBlock extends Block {
  const ListBlock(this.items, {this.marker = ListMarker.disc, this.start = 1});
  final List<List<Block>> items;
  final ListMarker marker;
  final int start;

  @override
  Map<String, Object?> toJson() => {
    'type': 'list',
    'marker': marker.name,
    if (start != 1) 'start': start,
    'items': [
      for (final item in items) [for (final b in item) b.toJson()],
    ],
  };
}

/// Preformatted text: monospace, whitespace kept, scrolls sideways.
final class PreBlock extends Block {
  const PreBlock(this.inlines);
  final List<Inline> inlines;

  @override
  Map<String, Object?> toJson() => {
    'type': 'pre',
    'inlines': [for (final i in inlines) i.toJson()],
  };
}

final class RuleBlock extends Block {
  const RuleBlock();

  @override
  Map<String, Object?> toJson() => {'type': 'hr'};
}

final class ImageBlock extends Block {
  const ImageBlock(this.image, {this.align = BlockAlign.center});

  /// Index into [ReaderDocument.images].
  final int image;
  final BlockAlign align;

  @override
  Map<String, Object?> toJson() => {'type': 'img', 'image': image};
}

/// Two or more consecutive images, shown as a swipeable strip.
final class CarouselBlock extends Block {
  const CarouselBlock(this.images);
  final List<int> images;

  @override
  Map<String, Object?> toJson() => {'type': 'carousel', 'images': images};
}

/// A link styled as a button (an anchor with a background colour).
final class ButtonBlock extends Block {
  const ButtonBlock({
    required this.text,
    required this.link,
    this.background,
    this.color,
    this.align = BlockAlign.center,
  });
  final String text;
  final int link;
  final int? background;
  final int? color;
  final BlockAlign align;

  @override
  Map<String, Object?> toJson() => {
    'type': 'button',
    'text': text,
    'link': link,
    if (background != null) 'bg': colorToHex(background!),
    if (color != null) 'color': colorToHex(color!),
    if (align != BlockAlign.center) 'align': align.name,
  };
}

final class TableCell {
  const TableCell(this.inlines, {this.header = false, this.colspan = 1, this.align = BlockAlign.start});
  final List<Inline> inlines;
  final bool header;
  final int colspan;
  final BlockAlign align;

  Map<String, Object?> toJson() => {
    if (header) 'th': true,
    if (colspan != 1) 'colspan': colspan,
    if (align != BlockAlign.start) 'align': align.name,
    'inlines': [for (final i in inlines) i.toJson()],
  };
}

/// A real data table (receipt lines, schedules); scrolls sideways on its own.
final class TableBlock extends Block {
  const TableBlock(this.rows, {this.columns = 0});
  final List<List<TableCell>> rows;

  /// Number of grid columns (colspans counted).
  final int columns;

  @override
  Map<String, Object?> toJson() => {
    'type': 'table',
    'columns': columns,
    'rows': [
      for (final r in rows) [for (final c in r) c.toJson()],
    ],
  };
}

// ---------------------------------------------------------------------------
// Images and links

sealed class ImageSource {
  const ImageSource();
  Object toJson();
}

/// An `http(s)` image: only loaded when remote content is allowed.
final class RemoteImageSource extends ImageSource {
  const RemoteImageSource(this.url);
  final String url;

  @override
  Object toJson() => url;
}

/// A `cid:` image: resolved from `EmailContent.inlineData` or an attachment.
final class CidImageSource extends ImageSource {
  const CidImageSource(this.contentId);
  final String contentId;

  @override
  Object toJson() => 'cid:$contentId';
}

/// A decoded `data:` URI.
final class DataImageSource extends ImageSource {
  const DataImageSource(this.mimeType, this.bytes);
  final String mimeType;
  final Uint8List bytes;

  @override
  Object toJson() => 'data:$mimeType (${bytes.length} bytes)';
}

/// An image attachment that is not referenced from the HTML (gallery only).
final class AttachmentImageSource extends ImageSource {
  const AttachmentImageSource(this.partId);
  final String partId;

  @override
  Object toJson() => 'attachment:$partId';
}

final class ImageRef {
  const ImageRef(this.source, {this.width, this.height, this.alt, this.link, this.icon = false});
  final ImageSource source;

  /// Declared size in CSS pixels (HTML attributes or inline style), if any.
  final double? width;
  final double? height;
  final String? alt;

  /// Index into [ReaderDocument.links] when the image is inside a link.
  final int? link;

  /// Small enough to stay inline with the text.
  final bool icon;

  bool get isRemote => source is RemoteImageSource;

  Map<String, Object?> toJson() => {
    'src': source.toJson(),
    if (width != null) 'width': width,
    if (height != null) 'height': height,
    if (alt != null && alt!.isNotEmpty) 'alt': alt,
    if (link != null) 'link': link,
    if (icon) 'icon': true,
  };
}

final class LinkRef {
  const LinkRef(this.url, {this.text = '', this.namedDomain, this.redirect});
  final String url;

  /// The visible text of the link (plain).
  final String text;

  /// Set when the text names a domain other than the one the link opens (the
  /// destination of a known redirect); the reader warns before opening it.
  final String? namedDomain;

  /// Set when the link goes through a click tracker, a link filter or another
  /// redirect.
  final Redirect? redirect;

  bool get isMismatch => namedDomain != null;

  /// Where the link really ends up when a known redirect carries it: the
  /// destination without tracking parameters. Null otherwise.
  String? get direct => redirect != null && redirect!.known ? redirect!.direct : null;

  Map<String, Object?> toJson() => {
    'url': url,
    if (namedDomain != null) 'mismatch': namedDomain,
    if (redirect != null) 'via': redirect!.services.join(' > '),
    if (redirect?.resolved ?? false) 'opens': redirect!.target,
  };
}

/// What the pipeline removed or found; drives the "Suggest Original" hint.
final class ReaderStats {
  const ReaderStats({
    this.sourceTextLength = 0,
    this.keptTextLength = 0,
    this.hiddenTextLength = 0,
    this.hiddenElements = 0,
    this.trackers = 0,
    this.contentImages = 0,
    this.remoteImages = 0,
    this.truncated = false,
  });

  /// Visible-looking text in the source (before hidden content was removed).
  final int sourceTextLength;
  final int keptTextLength;

  /// Text inside elements removed as hidden.
  final int hiddenTextLength;
  final int hiddenElements;

  /// Tracking pixels removed.
  final int trackers;

  /// Images shown as content (not icons).
  final int contentImages;

  /// Remote images (content or icons), blocked unless allowed.
  final int remoteImages;

  /// An input limit (size, depth, node count, time) was hit.
  final bool truncated;

  /// Readable mode probably does a poor job: most text was hidden, or the
  /// message is mostly remote images (image-only newsletters).
  bool get suggestOriginal {
    if (truncated) return true;
    if (sourceTextLength >= 200 && hiddenTextLength * 2 > sourceTextLength) return true;
    if (remoteImages >= 1 && contentImages >= 1) {
      return keptTextLength < (contentImages == 1 ? 80 : 120 * contentImages);
    }
    return false;
  }

  Map<String, Object?> toJson() => {
    'sourceText': sourceTextLength,
    'keptText': keptTextLength,
    'hiddenText': hiddenTextLength,
    'hiddenElements': hiddenElements,
    'trackers': trackers,
    'contentImages': contentImages,
    'remoteImages': remoteImages,
    if (truncated) 'truncated': true,
    'suggestOriginal': suggestOriginal,
  };
}

/// The rebuilt message.
final class ReaderDocument {
  const ReaderDocument({
    required this.blocks,
    this.images = const [],
    this.links = const [],
    this.stats = const ReaderStats(),
  });

  static const empty = ReaderDocument(blocks: []);

  final List<Block> blocks;
  final List<ImageRef> images;
  final List<LinkRef> links;
  final ReaderStats stats;

  Map<String, Object?> toJson() => {
    'stats': stats.toJson(),
    'links': [for (final l in links) l.toJson()],
    'images': [for (final i in images) i.toJson()],
    'blocks': [for (final b in blocks) b.toJson()],
  };
}

/// Visible text of inlines (images count as nothing).
String inlineText(Iterable<Inline> inlines) => inlines.whereType<TextRun>().map((r) => r.text).join();
