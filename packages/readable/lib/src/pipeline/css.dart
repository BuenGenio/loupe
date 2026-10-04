// Just enough CSS to read email inline styles: declarations, colours, lengths
// and font sizes. Anything we can't parse is ignored rather than guessed.

import 'dart:math' as math;

/// Parses a `style` attribute into lower-cased property → value (without
/// `!important`). Later declarations win, as in CSS.
Map<String, String> parseStyle(String? style) {
  if (style == null || style.isEmpty) return const {};
  final out = <String, String>{};
  for (final decl in _splitDeclarations(style)) {
    final colon = decl.indexOf(':');
    if (colon <= 0) continue;
    final prop = decl.substring(0, colon).trim().toLowerCase();
    var value = decl.substring(colon + 1).trim();
    final bang = value.toLowerCase().lastIndexOf('!important');
    if (bang >= 0) value = value.substring(0, bang).trim();
    if (prop.isEmpty || value.isEmpty) continue;
    out[prop] = value;
  }
  return out;
}

/// Splits on `;` outside parentheses and quotes (data URIs contain `;`).
Iterable<String> _splitDeclarations(String style) sync* {
  var depth = 0;
  String? quote;
  var start = 0;
  for (var i = 0; i < style.length; i++) {
    final c = style[i];
    if (quote != null) {
      if (c == quote) quote = null;
    } else if (c == '"' || c == "'") {
      quote = c;
    } else if (c == '(') {
      depth++;
    } else if (c == ')') {
      depth = math.max(0, depth - 1);
    } else if (c == ';' && depth == 0) {
      yield style.substring(start, i);
      start = i + 1;
    }
  }
  if (start < style.length) yield style.substring(start);
}

/// Parses a CSS colour (hex, rgb[a], hsl[a], named, or a legacy `bgcolor`
/// hex without `#`) to an opaque 0xFFRRGGBB int. Transparent and unknown
/// values return null; partly transparent colours are treated as opaque.
int? parseColor(String? value) {
  if (value == null) return null;
  var v = value.trim().toLowerCase();
  if (v.isEmpty) return null;
  // `background: #fff url(...) no-repeat` → first colour-looking token.
  if ((v.contains(' ') && !v.contains('(')) || v.contains('url(')) {
    v = v.replaceAll(RegExp(r'url\([^)]*\)'), ' ').trim();
    for (final token in v.split(RegExp(r'\s+'))) {
      if (token.startsWith('#') || _namedColors[token] != null) return parseColor(token);
    }
    final fn = RegExp(r'(rgba?|hsla?)\([^)]*\)').firstMatch(v);
    return fn == null ? null : parseColor(fn[0]);
  }
  if (v.startsWith('#')) return _hex(v.substring(1));
  if (v.startsWith('rgb')) return _rgbFunction(v);
  if (v.startsWith('hsl')) return _hslFunction(v);
  final named = _namedColors[v];
  if (named != null) return 0xFF000000 | named;
  // Legacy attribute colours ("ffffff").
  if (RegExp(r'^[0-9a-f]{6}$').hasMatch(v) || RegExp(r'^[0-9a-f]{3}$').hasMatch(v)) return _hex(v);
  return null;
}

int? _hex(String h) {
  if (!RegExp(r'^[0-9a-f]+$').hasMatch(h)) return null;
  switch (h.length) {
    case 3 || 4:
      if (h.length == 4 && h[3] == '0') return null;
      final r = int.parse(h[0] * 2, radix: 16);
      final g = int.parse(h[1] * 2, radix: 16);
      final b = int.parse(h[2] * 2, radix: 16);
      return 0xFF000000 | r << 16 | g << 8 | b;
    case 6 || 8:
      if (h.length == 8 && int.parse(h.substring(6), radix: 16) < 0x1a) return null;
      return 0xFF000000 | int.parse(h.substring(0, 6), radix: 16);
  }
  return null;
}

List<String> _args(String v) {
  final open = v.indexOf('(');
  final close = v.lastIndexOf(')');
  if (open < 0 || close < open) return const [];
  return v.substring(open + 1, close).split(RegExp(r'[\s,/]+')).where((s) => s.isNotEmpty).toList();
}

double? _alpha(List<String> args) {
  if (args.length < 4) return 1;
  final a = args[3];
  if (a.endsWith('%')) return (double.tryParse(a.substring(0, a.length - 1)) ?? 100) / 100;
  return double.tryParse(a);
}

int? _rgbFunction(String v) {
  final args = _args(v);
  if (args.length < 3) return null;
  if ((_alpha(args) ?? 1) < 0.1) return null;
  final c = <int>[];
  for (final a in args.take(3)) {
    double? n;
    if (a.endsWith('%')) {
      final p = double.tryParse(a.substring(0, a.length - 1));
      n = p == null ? null : p * 2.55;
    } else {
      n = double.tryParse(a);
    }
    if (n == null) return null;
    c.add(n.round().clamp(0, 255));
  }
  return 0xFF000000 | c[0] << 16 | c[1] << 8 | c[2];
}

int? _hslFunction(String v) {
  final args = _args(v);
  if (args.length < 3) return null;
  if ((_alpha(args) ?? 1) < 0.1) return null;
  final h = double.tryParse(args[0].replaceAll('deg', ''));
  final s = double.tryParse(args[1].replaceAll('%', ''));
  final l = double.tryParse(args[2].replaceAll('%', ''));
  if (h == null || s == null || l == null) return null;
  final sat = (s / 100).clamp(0.0, 1.0);
  final light = (l / 100).clamp(0.0, 1.0);
  final a = sat * math.min(light, 1 - light);
  double f(int n) {
    final k = (n + h / 30) % 12;
    return light - a * math.max(-1, math.min(math.min(k - 3, 9 - k), 1));
  }

  int ch(double x) => (x * 255).round().clamp(0, 255);
  return 0xFF000000 | ch(f(0)) << 16 | ch(f(8)) << 8 | ch(f(4));
}

/// A CSS length in px, or null if it isn't an absolute length (or is a
/// percentage). [fontPx] resolves `em`/`rem`.
double? parseLength(String? value, {double fontPx = 16}) {
  if (value == null) return null;
  final m = RegExp(r'^\s*(-?[0-9]*\.?[0-9]+)\s*(px|pt|em|rem|ex|ch|cm|mm|in|pc)?\s*$').firstMatch(value.toLowerCase());
  if (m == null) return null;
  final n = double.parse(m[1]!);
  return switch (m[2]) {
    null || 'px' => n,
    'pt' => n * 4 / 3,
    'em' => n * fontPx,
    'rem' => n * 16,
    'ex' || 'ch' => n * fontPx / 2,
    'cm' => n * 96 / 2.54,
    'mm' => n * 96 / 25.4,
    'in' => n * 96,
    'pc' => n * 16,
    _ => null,
  };
}

/// True if a CSS length is zero (`0`, `0px`, `0%`, `0.0em`).
bool isZeroLength(String? value) {
  if (value == null) return false;
  final m = RegExp(r'^\s*(-?[0-9]*\.?[0-9]+)\s*[a-z%]*\s*$').firstMatch(value.toLowerCase());
  return m != null && double.parse(m[1]!) == 0;
}

/// Resolves a `font-size` value against the parent's size in px.
double? parseFontSize(String value, double parentPx) {
  final v = value.trim().toLowerCase();
  const keywords = {
    'xx-small': 9.0,
    'x-small': 10.0,
    'small': 13.0,
    'medium': 16.0,
    'large': 18.0,
    'x-large': 24.0,
    'xx-large': 32.0,
    'xxx-large': 48.0,
  };
  final k = keywords[v];
  if (k != null) return k;
  if (v == 'smaller') return parentPx / 1.2;
  if (v == 'larger') return parentPx * 1.2;
  if (v.endsWith('%')) {
    final p = double.tryParse(v.substring(0, v.length - 1));
    return p == null ? null : parentPx * p / 100;
  }
  return parseLength(v, fontPx: parentPx);
}

final _fontShorthandSize = RegExp(
  r'(?:^|\s)((?:[0-9]*\.)?[0-9]+(?:px|pt|em|rem|%)|xx-small|x-small|small|medium|large|x-large|xx-large|smaller|larger)'
  r'(?:\s*/\s*\S+)?(?=\s|$)',
  caseSensitive: false,
);

/// The size in a `font` shorthand (`bold 10px/1.2 Arial`, `8pt Verdana`).
String? fontShorthandSize(String value) => _fontShorthandSize.firstMatch(value)?[1];

/// The `font-size` of a parsed style, or the size of its `font` shorthand.
String? fontSizeOf(Map<String, String> style) {
  final size = style['font-size'];
  if (size != null) return size;
  final font = style['font'];
  return font == null ? null : fontShorthandSize(font);
}

/// `<font size="…">`: 1–7, or relative (+1, -2) to 3.
double? legacyFontSize(String value) {
  final v = value.trim();
  final n = int.tryParse(v.replaceFirst('+', ''));
  if (n == null) return null;
  final level = (v.startsWith('+') || v.startsWith('-') ? 3 + n : n).clamp(1, 7);
  return const [10.0, 13.0, 16.0, 18.0, 24.0, 32.0, 48.0][level - 1];
}

/// The browser's default font size, which email sizes are relative to.
const defaultBodyPx = 16.0;

/// Text set below this share of the message's body size is fine print. 14 px
/// under a 16 px body (0.875) is secondary text, not fine print; 13 px,
/// `<small>`, 10 pt and `<font size="2">` under 16 px are.
const finePrintRatio = 0.87;

/// The relative step of a font size in px, before the body size of the
/// message is known. Larger sizes map to absolute steps (big text becomes a
/// heading); sizes below 16 px keep their exact ratio to 16 px until
/// [resolveScale] compares them with the message's body size.
double provisionalScale(double px) {
  if (px >= 23) return 1.5;
  if (px >= 19.5) return 1.3;
  if (px >= 17.5) return 1.15;
  if (px >= defaultBodyPx) return 1.0;
  return math.max(px, 1) / defaultBodyPx;
}

/// The final step of a [provisionalScale] in a message whose body text is
/// [bodyPx] (at most 16): fine print or body size; larger steps stay.
double resolveScale(double scale, double bodyPx) {
  if (scale >= 1) return scale;
  return scale * defaultBodyPx < bodyPx * finePrintRatio ? finePrintScale : 1.0;
}

/// The reader's single step below body size.
const finePrintScale = 0.8;

final _monoFamilies = RegExp(
  r'courier|consolas|menlo|monaco|monospace|lucida console|lucida sans typewriter|andale mono|source code|'
  r'fira (code|mono)|dejavu sans mono|liberation mono|roboto mono|sf mono|jetbrains mono|ubuntu mono|inconsolata|'
  r'cascadia|ibm plex mono|noto mono|droid sans mono|oxygen mono|pt mono|space mono',
);

/// True if a `font-family` list names a monospace font first-class enough to
/// treat the text as code.
bool isMonospaceFamily(String family) => _monoFamilies.hasMatch(family.toLowerCase());

const _namedColors = <String, int>{
  'aliceblue': 0xf0f8ff,
  'antiquewhite': 0xfaebd7,
  'aqua': 0x00ffff,
  'aquamarine': 0x7fffd4,
  'azure': 0xf0ffff,
  'beige': 0xf5f5dc,
  'bisque': 0xffe4c4,
  'black': 0x000000,
  'blanchedalmond': 0xffebcd,
  'blue': 0x0000ff,
  'blueviolet': 0x8a2be2,
  'brown': 0xa52a2a,
  'burlywood': 0xdeb887,
  'cadetblue': 0x5f9ea0,
  'chartreuse': 0x7fff00,
  'chocolate': 0xd2691e,
  'coral': 0xff7f50,
  'cornflowerblue': 0x6495ed,
  'cornsilk': 0xfff8dc,
  'crimson': 0xdc143c,
  'cyan': 0x00ffff,
  'darkblue': 0x00008b,
  'darkcyan': 0x008b8b,
  'darkgoldenrod': 0xb8860b,
  'darkgray': 0xa9a9a9,
  'darkgreen': 0x006400,
  'darkgrey': 0xa9a9a9,
  'darkkhaki': 0xbdb76b,
  'darkmagenta': 0x8b008b,
  'darkolivegreen': 0x556b2f,
  'darkorange': 0xff8c00,
  'darkorchid': 0x9932cc,
  'darkred': 0x8b0000,
  'darksalmon': 0xe9967a,
  'darkseagreen': 0x8fbc8f,
  'darkslateblue': 0x483d8b,
  'darkslategray': 0x2f4f4f,
  'darkslategrey': 0x2f4f4f,
  'darkturquoise': 0x00ced1,
  'darkviolet': 0x9400d3,
  'deeppink': 0xff1493,
  'deepskyblue': 0x00bfff,
  'dimgray': 0x696969,
  'dimgrey': 0x696969,
  'dodgerblue': 0x1e90ff,
  'firebrick': 0xb22222,
  'floralwhite': 0xfffaf0,
  'forestgreen': 0x228b22,
  'fuchsia': 0xff00ff,
  'gainsboro': 0xdcdcdc,
  'ghostwhite': 0xf8f8ff,
  'gold': 0xffd700,
  'goldenrod': 0xdaa520,
  'gray': 0x808080,
  'green': 0x008000,
  'greenyellow': 0xadff2f,
  'grey': 0x808080,
  'honeydew': 0xf0fff0,
  'hotpink': 0xff69b4,
  'indianred': 0xcd5c5c,
  'indigo': 0x4b0082,
  'ivory': 0xfffff0,
  'khaki': 0xf0e68c,
  'lavender': 0xe6e6fa,
  'lavenderblush': 0xfff0f5,
  'lawngreen': 0x7cfc00,
  'lemonchiffon': 0xfffacd,
  'lightblue': 0xadd8e6,
  'lightcoral': 0xf08080,
  'lightcyan': 0xe0ffff,
  'lightgoldenrodyellow': 0xfafad2,
  'lightgray': 0xd3d3d3,
  'lightgreen': 0x90ee90,
  'lightgrey': 0xd3d3d3,
  'lightpink': 0xffb6c1,
  'lightsalmon': 0xffa07a,
  'lightseagreen': 0x20b2aa,
  'lightskyblue': 0x87cefa,
  'lightslategray': 0x778899,
  'lightslategrey': 0x778899,
  'lightsteelblue': 0xb0c4de,
  'lightyellow': 0xffffe0,
  'lime': 0x00ff00,
  'limegreen': 0x32cd32,
  'linen': 0xfaf0e6,
  'magenta': 0xff00ff,
  'maroon': 0x800000,
  'mediumaquamarine': 0x66cdaa,
  'mediumblue': 0x0000cd,
  'mediumorchid': 0xba55d3,
  'mediumpurple': 0x9370db,
  'mediumseagreen': 0x3cb371,
  'mediumslateblue': 0x7b68ee,
  'mediumspringgreen': 0x00fa9a,
  'mediumturquoise': 0x48d1cc,
  'mediumvioletred': 0xc71585,
  'midnightblue': 0x191970,
  'mintcream': 0xf5fffa,
  'mistyrose': 0xffe4e1,
  'moccasin': 0xffe4b5,
  'navajowhite': 0xffdead,
  'navy': 0x000080,
  'oldlace': 0xfdf5e6,
  'olive': 0x808000,
  'olivedrab': 0x6b8e23,
  'orange': 0xffa500,
  'orangered': 0xff4500,
  'orchid': 0xda70d6,
  'palegoldenrod': 0xeee8aa,
  'palegreen': 0x98fb98,
  'paleturquoise': 0xafeeee,
  'palevioletred': 0xdb7093,
  'papayawhip': 0xffefd5,
  'peachpuff': 0xffdab9,
  'peru': 0xcd853f,
  'pink': 0xffc0cb,
  'plum': 0xdda0dd,
  'powderblue': 0xb0e0e6,
  'purple': 0x800080,
  'rebeccapurple': 0x663399,
  'red': 0xff0000,
  'rosybrown': 0xbc8f8f,
  'royalblue': 0x4169e1,
  'saddlebrown': 0x8b4513,
  'salmon': 0xfa8072,
  'sandybrown': 0xf4a460,
  'seagreen': 0x2e8b57,
  'seashell': 0xfff5ee,
  'sienna': 0xa0522d,
  'silver': 0xc0c0c0,
  'skyblue': 0x87ceeb,
  'slateblue': 0x6a5acd,
  'slategray': 0x708090,
  'slategrey': 0x708090,
  'snow': 0xfffafa,
  'springgreen': 0x00ff7f,
  'steelblue': 0x4682b4,
  'tan': 0xd2b48c,
  'teal': 0x008080,
  'thistle': 0xd8bfd8,
  'tomato': 0xff6347,
  'turquoise': 0x40e0d0,
  'violet': 0xee82ee,
  'wheat': 0xf5deb3,
  'white': 0xffffff,
  'whitesmoke': 0xf5f5f5,
  'yellow': 0xffff00,
  'yellowgreen': 0x9acd32,
};
