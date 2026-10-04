// Contrast-aware colour adaptation. Sender colours are kept unless they would
// be hard to read on the reader's background; then only their lightness moves
// (in OKLCH, keeping hue and as much chroma as fits), so brand colours and
// highlights stay recognisable. In dark mode an offending colour's lightness
// is flipped first, as dark-mode mail clients do.

import 'dart:math' as math;

/// A colour in OKLCH: lightness 0–1, chroma ≥ 0, hue in radians.
typedef Oklch = ({double l, double c, double h});

double _toLinear(int channel) {
  final c = channel / 255;
  return c <= 0.04045 ? c / 12.92 : math.pow((c + 0.055) / 1.055, 2.4).toDouble();
}

double _fromLinear(double c) {
  final v = c <= 0.0031308 ? 12.92 * c : 1.055 * math.pow(c, 1 / 2.4) - 0.055;
  return v;
}

double _cbrt(double x) => x < 0 ? -math.pow(-x, 1 / 3).toDouble() : math.pow(x, 1 / 3).toDouble();

/// sRGB (0xAARRGGBB) to OKLCH.
Oklch toOklch(int argb) {
  final r = _toLinear((argb >> 16) & 0xFF);
  final g = _toLinear((argb >> 8) & 0xFF);
  final b = _toLinear(argb & 0xFF);
  final l = _cbrt(0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b);
  final m = _cbrt(0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b);
  final s = _cbrt(0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b);
  final lightness = 0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s;
  final a = 1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s;
  final bb = 0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s;
  return (l: lightness, c: math.sqrt(a * a + bb * bb), h: math.atan2(bb, a));
}

/// Linear sRGB of an OKLCH colour; may be out of gamut.
(double, double, double) _oklchToLinear(double lightness, double chroma, double hue) {
  final a = chroma * math.cos(hue);
  final b = chroma * math.sin(hue);
  final l = math.pow(lightness + 0.3963377774 * a + 0.2158037573 * b, 3).toDouble();
  final m = math.pow(lightness - 0.1055613458 * a - 0.0638541728 * b, 3).toDouble();
  final s = math.pow(lightness - 0.0894841775 * a - 1.2914855480 * b, 3).toDouble();
  return (
    4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
    -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
    -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s,
  );
}

bool _inGamut((double, double, double) rgb) {
  const e = 1e-4;
  return rgb.$1 >= -e && rgb.$1 <= 1 + e && rgb.$2 >= -e && rgb.$2 <= 1 + e && rgb.$3 >= -e && rgb.$3 <= 1 + e;
}

/// OKLCH to opaque sRGB, reducing chroma until the colour fits the gamut.
int fromOklch(double lightness, double chroma, double hue) {
  final l = lightness.clamp(0.0, 1.0);
  var c = chroma;
  var rgb = _oklchToLinear(l, c, hue);
  if (!_inGamut(rgb)) {
    var lo = 0.0;
    var hi = c;
    for (var i = 0; i < 16; i++) {
      final mid = (lo + hi) / 2;
      if (_inGamut(_oklchToLinear(l, mid, hue))) {
        lo = mid;
      } else {
        hi = mid;
      }
    }
    c = lo;
    rgb = _oklchToLinear(l, c, hue);
  }
  int ch(double v) => (_fromLinear(v.clamp(0.0, 1.0)) * 255).round().clamp(0, 255);
  return 0xFF000000 | ch(rgb.$1) << 16 | ch(rgb.$2) << 8 | ch(rgb.$3);
}

/// WCAG relative luminance.
double luminance(int argb) =>
    0.2126 * _toLinear((argb >> 16) & 0xFF) + 0.7152 * _toLinear((argb >> 8) & 0xFF) + 0.0722 * _toLinear(argb & 0xFF);

/// WCAG contrast ratio, 1–21.
double contrastRatio(int a, int b) {
  final la = luminance(a);
  final lb = luminance(b);
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

/// WCAG AA for body text.
const minTextContrast = 4.5;

/// WCAG AA for large text (headings).
const minLargeTextContrast = 3.0;

/// Button labels: big and bold, and part of the sender's brand, so only a
/// clearly unreadable label (white on yellow) is changed.
const minButtonContrast = 2.4;

/// Adapts sender colours to one reader background. Results are memoised;
/// create one per theme.
final class ColorAdapter {
  ColorAdapter({required this.page, required this.text});

  /// The background behind the message.
  final int page;

  /// The theme's default text colour.
  final int text;

  late final bool dark = luminance(page) < 0.2;
  final _fg = <(int, int, bool), int>{};
  final _bg = <int, int>{};

  /// The highlight colour to draw behind text. In dark mode, very light
  /// highlights are toned down (lightness lowered, hue and chroma kept): a
  /// yellow marker stays a yellow marker without glaring, and the text on it
  /// turns dark.
  int background(int bg) => _bg.putIfAbsent(bg, () {
    if (!dark) return bg;
    final o = toOklch(bg);
    if (o.l <= _maxDarkHighlightLightness) return bg;
    return fromOklch(_maxDarkHighlightLightness, o.c, o.h);
  });

  static const _maxDarkHighlightLightness = 0.78;

  /// The text colour to use for the sender's [fg] (null: the reader's own
  /// [fallback], such as the link or secondary colour, or else the theme text
  /// colour) over the highlight [bg] (null: the page), adjusted until it
  /// reaches the WCAG minimum against the background actually drawn behind
  /// it ([background] of [bg]).
  int foreground(int? fg, {int? bg, bool large = false, int? fallback}) {
    final color = fg ?? fallback ?? text;
    final behind = bg == null ? page : background(bg);
    if (fg == null && fallback == null && bg == null) return text;
    // A pair the sender chose together and that is drawn as sent (white on
    // a red label) is a design decision: hold it to the large-text minimum
    // only. Our own colours on a sender's highlight are not such a pair.
    final chosenPair = fg != null && bg != null && behind == bg;
    return _fg.putIfAbsent((color, behind, large || chosenPair), () {
      final min = large || chosenPair ? minLargeTextContrast : minTextContrast;
      if (contrastRatio(color, behind) >= min) return color;
      // Grey "body text" that fails (dark ink in dark mode, white text from
      // a dark newsletter in light mode) reads best as the theme's text.
      if (bg == null && contrastRatio(text, behind) >= min) {
        final o = toOklch(color);
        if (o.c < 0.035 && (dark ? o.l < 0.36 : o.l > 0.75)) return text;
      }
      return ensureContrast(color, behind, min, flipFirst: dark);
    });
  }

  /// A button's fill: kept unless it vanishes into the page.
  int buttonFill(int bg, {required int fallback}) => contrastRatio(bg, page) < 1.25 && dark ? fallback : bg;
}

/// Moves [color]'s OKLCH lightness away from [bg] until the contrast reaches
/// [min]. With [flipFirst] the lightness is mirrored first (dark mode), then
/// adjusted; otherwise the smallest change wins (light mode).
int ensureContrast(int color, int bg, double min, {bool flipFirst = false}) {
  if (contrastRatio(color, bg) >= min) return color;
  final o = toOklch(color);
  final towardLight = contrastRatio(0xFFFFFFFF, bg) >= contrastRatio(0xFF000000, bg);
  var start = o.l;
  if (flipFirst) {
    final flipped = 1 - o.l;
    // Only flip if it moves the colour the right way.
    if ((towardLight && flipped > o.l) || (!towardLight && flipped < o.l)) {
      final candidate = fromOklch(flipped, o.c, o.h);
      if (contrastRatio(candidate, bg) >= min) return candidate;
      start = flipped;
    }
  }
  final end = towardLight ? 1.0 : 0.0;
  if (contrastRatio(fromOklch(end, o.c, o.h), bg) < min) {
    return towardLight ? 0xFFFFFFFF : 0xFF000000;
  }
  // Binary search for the lightness closest to [start] that passes.
  var lo = start;
  var hi = end;
  for (var i = 0; i < 20; i++) {
    final mid = (lo + hi) / 2;
    if (contrastRatio(fromOklch(mid, o.c, o.h), bg) >= min) {
      hi = mid;
    } else {
      lo = mid;
    }
  }
  return fromOklch(hi, o.c, o.h);
}
