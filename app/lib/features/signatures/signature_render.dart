import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

/// Turns a [Signature] (a Quill Delta) into what a message needs: plain text
/// for the text part, the text compose shows, its styles, and HTML with the
/// images as `cid:` parts. Pure Dart, so compose, drafts and tests share it.

/// The values a signature's fields take for one sender.
class SignatureFields {
  const SignatureFields({this.name, required this.email});

  factory SignatureFields.of(Identity identity) => SignatureFields(name: identity.name, email: identity.email);

  final String? name;
  final String email;

  /// The field types: the sender's name and address.
  static const types = ['name', 'email'];

  String valueOf(Object? field) => switch (field) {
    'name' => name?.trim() ?? '',
    'email' => email.trim(),
    _ => '',
  };
}

/// The inline formatting of a run that mail keeps.
class SignatureStyle {
  const SignatureStyle({
    this.bold = false,
    this.italic = false,
    this.underline = false,
    this.color,
    this.size,
    this.font,
    this.link,
  });

  factory SignatureStyle.of(Map<Object?, Object?> a) => SignatureStyle(
    bold: a['bold'] == true,
    italic: a['italic'] == true,
    underline: a['underline'] == true,
    color: _hexColor(a['color']),
    size: _size(a['size']),
    font: switch (a['font']) {
      final String f when fontStacks.containsKey(f) => f,
      _ => null,
    },
    link: switch (a['link']) {
      final String l when _safeLink(l) => l.trim(),
      _ => null,
    },
  );

  final bool bold;
  final bool italic;
  final bool underline;

  /// `#rrggbb`.
  final String? color;

  /// `small`, `large`, `huge` (Quill's names) or a size in points.
  final String? size;

  /// A key of [fontStacks].
  final String? font;

  /// http(s), mailto or tel only.
  final String? link;

  bool get isPlain => !bold && !italic && !underline && color == null && size == null && font == null && link == null;

  /// The font families the editor offers, as CSS stacks for mail clients.
  static const fontStacks = {
    'sans-serif': "-apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif",
    'serif': "Georgia, 'Times New Roman', serif",
    'monospace': "Menlo, Consolas, 'Courier New', monospace",
  };

  /// Relative sizes for Quill's names, as in its editor.
  static const sizeScale = {'small': 0.8, 'large': 1.3, 'huge': 1.7};
}

/// One styled stretch of [RenderedSignature.display].
class SignatureRun {
  const SignatureRun(this.start, this.end, this.style);
  final int start;
  final int end;
  final SignatureStyle style;
}

/// An image of a signature: its bytes, and the width it is shown at.
class SignatureImage {
  const SignatureImage({required this.data, required this.mimeType, this.width});
  final Uint8List data;
  final String mimeType;

  /// Logical pixels; null for the image's own size.
  final double? width;
}

/// [signature] rendered for one sender.
class RenderedSignature {
  RenderedSignature._(this.signature, this._lines);

  /// Renders [signature] with [fields]; a damaged one comes out as its
  /// plain text.
  factory RenderedSignature.of(Signature signature, SignatureFields fields) {
    List<_Line> lines;
    try {
      lines = _parse(jsonDecode(signature.content), fields);
    } on Object {
      lines = [for (final l in signature.plainText.split('\n')) _Line()..pieces.add(_Text(l, const SignatureStyle()))];
    }
    while (lines.isNotEmpty && lines.last.isBlank) {
      lines.removeLast();
    }
    return RenderedSignature._(signature, lines);
  }

  final Signature signature;
  final List<_Line> _lines;

  /// Shown in compose: images are U+FFFC (one each, see [images]), links
  /// only their text, nothing trailing.
  late final String display = _build().$1;

  /// The styled runs of [display].
  late final List<SignatureRun> runs = _build().$2;

  /// The images, in the order of the U+FFFC in [display].
  late final List<SignatureImage> images = [
    for (final l in _lines)
      for (final p in l.pieces)
        if (p is _Image) p.image,
  ];

  /// For plain-text readers: no images, links as `text <url>`.
  late final String plain = [for (final l in _lines) l.plain()].join('\n');

  /// Whether it needs HTML: formatting, images or alignment.
  late final bool isRich = _lines.any(
    (l) =>
        (l.align != null && l.align != 'left') || l.pieces.any((p) => p is _Image || (p is _Text && !p.style.isPlain)),
  );

  bool get isEmpty => display.trim().isEmpty;

  (String, List<SignatureRun>)? _built;

  (String, List<SignatureRun>) _build() => _built ??= () {
    final out = StringBuffer();
    final runs = <SignatureRun>[];
    for (final (i, l) in _lines.indexed) {
      if (i > 0) out.write('\n');
      for (final p in l.pieces) {
        final start = out.length;
        switch (p) {
          case _Text(:final text, :final style):
            out.write(text);
            if (!style.isPlain && text.isNotEmpty) runs.add(SignatureRun(start, out.length, style));
          case _Image():
            out.write(objectReplacement);
        }
      }
    }
    // As compose holds it (a block's end is trimmed): runs end where it does.
    final text = out.toString().trimRight();
    return (
      text,
      [
        for (final r in runs)
          if (r.start < text.length) SignatureRun(r.start, r.end > text.length ? text.length : r.end, r.style),
      ],
    );
  }();

  /// The signature as HTML (no `-- ` line), with its images as parts the
  /// HTML refers to by `cid:`.
  ({String html, List<OutgoingAttachment> inline}) toHtml() {
    final inline = <OutgoingAttachment>[];
    final out = StringBuffer();
    for (final l in _lines) {
      final align = switch (l.align) {
        'center' || 'right' || 'justify' => ' style="text-align:${l.align}"',
        _ => '',
      };
      out.write('<div$align>');
      if (l.pieces.isEmpty) out.write('<br>');
      for (final p in l.pieces) {
        switch (p) {
          case _Text(:final text, :final style):
            out.write(_styledHtml(text, style));
          case _Image(:final image):
            final n = inline.length + 1;
            final ext = image.mimeType.split('/').last.replaceAll(RegExp(r'[^a-z0-9]'), '');
            final id = 'sig$n.${_hash(image.data)}@loupe';
            inline.add(
              OutgoingAttachment(
                filename: 'signature-$n.${ext.isEmpty ? 'png' : ext}',
                mimeType: image.mimeType,
                data: image.data,
                contentId: id,
              ),
            );
            final width = image.width == null ? '' : ' width="${image.width!.round()}"';
            out.write('<img src="cid:$id" alt=""$width style="max-width:100%;height:auto;vertical-align:middle">');
        }
      }
      out.write('</div>');
    }
    return (html: out.toString(), inline: inline);
  }
}

/// What compose's body holds where an image stands.
const objectReplacement = '￼';

/// A whole message as HTML: the user's [before] and [after] (plain text,
/// with quoting) around [signatureHtml], which follows a `-- ` line as
/// Thunderbird writes it (`moz-signature`).
String messageHtml(String before, String signatureHtml, String after) {
  final body = StringBuffer()
    ..write(plainToHtml(before.replaceFirst(RegExp(r'\n+$'), '')))
    ..write('<div class="moz-signature"><br>-- <br>')
    ..write(signatureHtml)
    ..write('</div>');
  final rest = after.replaceFirst(RegExp(r'^\n+'), '');
  if (rest.isNotEmpty) body.write('<br>${plainToHtml(rest)}');
  return '<!DOCTYPE html><html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>'
      '<body><div dir="auto">$body</div></body></html>';
}

/// Plain text as HTML: line breaks kept, `>` quotes as nested blockquotes.
String plainToHtml(String text) {
  final out = StringBuffer();
  var depth = 0;
  for (final line in text.split('\n')) {
    var rest = line;
    var d = 0;
    while (rest.startsWith('>')) {
      d++;
      rest = rest.substring(1);
      if (rest.startsWith(' ')) rest = rest.substring(1);
    }
    while (depth < d) {
      out.write('<blockquote type="cite" style="margin:0 0 0 .8ex;border-left:2px solid #ccc;padding-left:1ex">');
      depth++;
    }
    while (depth > d) {
      out.write('</blockquote>');
      depth--;
    }
    out.write('${_escape(rest)}<br>');
  }
  while (depth > 0) {
    out.write('</blockquote>');
    depth--;
  }
  return out.toString();
}

// Parsing ------------------------------------------------------------------------------

sealed class _Piece {
  const _Piece();
}

final class _Text extends _Piece {
  const _Text(this.text, this.style);
  final String text;
  final SignatureStyle style;
}

final class _Image extends _Piece {
  const _Image(this.image);
  final SignatureImage image;
}

final class _Line {
  final pieces = <_Piece>[];
  String? align;

  bool get isBlank => pieces.every((p) => p is _Text && p.text.trim().isEmpty);

  /// Links once after their text, however many runs it spans.
  String plain() {
    final out = StringBuffer();
    String? link;
    final text = StringBuffer();
    void close() {
      final l = link;
      if (l != null) {
        final shown = text.toString().trim();
        final bare = l.replaceFirst(RegExp(r'^(mailto:|tel:)'), '');
        if (shown.isNotEmpty && shown != l && shown != bare) out.write(' <$l>');
      }
      link = null;
      text.clear();
    }

    for (final p in pieces) {
      if (p is! _Text) continue;
      if (p.style.link != link) close();
      link = p.style.link;
      out.write(p.text);
      if (link != null) text.write(p.text);
    }
    close();
    return out.toString().trimRight();
  }
}

List<_Line> _parse(Object? ops, SignatureFields fields) {
  if (ops is! List) throw const FormatException('Not a Delta');
  final lines = <_Line>[];
  var line = _Line();
  for (final op in ops) {
    if (op is! Map) continue;
    final insert = op['insert'];
    final attributes = switch (op['attributes']) {
      final Map<Object?, Object?> a => a,
      _ => const <Object?, Object?>{},
    };
    switch (insert) {
      case final String s:
        final parts = s.split('\n');
        for (final (i, part) in parts.indexed) {
          if (part.isNotEmpty) line.pieces.add(_Text(part, SignatureStyle.of(attributes)));
          if (i < parts.length - 1) {
            line.align = attributes['align'] as String?;
            lines.add(line);
            line = _Line();
          }
        }
      case {'image': final String src}:
        if (decodeImageDataUri(src) case (final mime, final data)) {
          line.pieces.add(_Image(SignatureImage(data: data, mimeType: mime, width: _width(attributes['width']))));
        }
      case {'loupe-field': final field}:
        line.pieces.add(_Text(fields.valueOf(field), SignatureStyle.of(attributes)));
    }
  }
  if (line.pieces.isNotEmpty) lines.add(line);
  return lines;
}

/// `data:image/png;base64,…` → its type and bytes.
(String, Uint8List)? decodeImageDataUri(String src) {
  final m = RegExp(r'^data:(image/[\w.+-]+);base64,(.*)$', dotAll: true).firstMatch(src.trim());
  if (m == null) return null;
  try {
    return (m[1]!.toLowerCase(), base64Decode(m[2]!.replaceAll(RegExp(r'\s'), '')));
  } on FormatException {
    return null;
  }
}

double? _width(Object? v) => switch (v) {
  final num n when n > 0 => n.toDouble(),
  final String s => double.tryParse(s.replaceAll('px', '').trim()),
  _ => null,
};

String? _hexColor(Object? v) {
  if (v is! String) return null;
  final hex = v.trim().replaceFirst('#', '').toLowerCase();
  // Quill writes #AARRGGBB from its picker.
  if (RegExp(r'^[0-9a-f]{8}$').hasMatch(hex)) return '#${hex.substring(2)}';
  if (RegExp(r'^[0-9a-f]{6}$').hasMatch(hex)) return '#$hex';
  return null;
}

String? _size(Object? v) => switch (v) {
  'small' || 'large' || 'huge' => v as String,
  final num n when n > 0 => '$n',
  final String s when double.tryParse(s) != null => s,
  _ => null,
};

bool _safeLink(String l) =>
    RegExp(r'^(https?://\S+|mailto:\S+|tel:[\d+\-(). ]+)$', caseSensitive: false).hasMatch(l.trim());

String _styledHtml(String text, SignatureStyle s) {
  var h = _escape(text);
  if (s.bold) h = '<b>$h</b>';
  if (s.italic) h = '<i>$h</i>';
  if (s.underline) h = '<u>$h</u>';
  final css = [
    if (s.color case final c?) 'color:$c',
    if (s.size case final size?)
      SignatureStyle.sizeScale.containsKey(size)
          ? 'font-size:${SignatureStyle.sizeScale[size]}em'
          : 'font-size:${size}px',
    if (s.font case final f?) 'font-family:${SignatureStyle.fontStacks[f]}',
  ];
  if (css.isNotEmpty) h = '<span style="${_escape(css.join(';'))}">$h</span>';
  if (s.link case final l?) h = '<a href="${_escape(l)}">$h</a>';
  return h;
}

String _escape(String s) =>
    s.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;').replaceAll('"', '&quot;');

/// A short, stable tag for an image's bytes (FNV-1a), for its Content-ID.
String _hash(Uint8List data) {
  var h = 0x811c9dc5;
  for (final b in data) {
    h = ((h ^ b) * 0x01000193) & 0xffffffff;
  }
  return h.toRadixString(16).padLeft(8, '0');
}
