import 'package:flutter_test/flutter_test.dart';
import 'package:readable/src/color/color_adapter.dart';

const white = 0xFFFFFFFF;
const black = 0xFF000000;
const darkPage = 0xFF121212;
const lightText = 0xFFE6E1E5;
const darkText = 0xFF1C1B1F;

double hueDistance(int a, int b) {
  final ha = toOklch(a).h;
  final hb = toOklch(b).h;
  final d = (ha - hb).abs() % (2 * 3.141592653589793);
  return d > 3.141592653589793 ? 2 * 3.141592653589793 - d : d;
}

void main() {
  group('OKLCH', () {
    test('round-trips sRGB', () {
      for (final c in [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFF348EDA, 0xFFFFEB3B]) {
        final o = toOklch(c);
        expect(fromOklch(o.l, o.c, o.h), c, reason: c.toRadixString(16));
      }
    });

    test('white and black lightness', () {
      expect(toOklch(white).l, closeTo(1, 1e-3));
      expect(toOklch(black).l, closeTo(0, 1e-3));
    });

    test('out-of-gamut colours are mapped by reducing chroma', () {
      final c = fromOklch(0.9, 0.4, 2.0);
      expect(c >>> 24, 0xFF);
    });
  });

  test('WCAG contrast', () {
    expect(contrastRatio(white, black), closeTo(21, 0.01));
    expect(contrastRatio(0xFF777777, white), closeTo(4.48, 0.01));
    expect(contrastRatio(white, white), 1);
  });

  group('light mode', () {
    final adapter = ColorAdapter(page: white, text: darkText);

    test('readable colours are kept', () {
      expect(adapter.foreground(0xFF1A0DAB), 0xFF1A0DAB);
      expect(adapter.foreground(0xFFD32F2F), 0xFFD32F2F);
    });

    test('white text (from a dark newsletter) becomes the theme text colour', () {
      expect(adapter.foreground(white), darkText);
      expect(adapter.foreground(0xFFEEEEEE), darkText);
    });

    test('light grey is darkened just enough, keeping its hue', () {
      const paleBlue = 0xFFA0C4FF;
      final c = adapter.foreground(paleBlue);
      expect(contrastRatio(c, white), greaterThanOrEqualTo(minTextContrast));
      expect(contrastRatio(c, white), lessThan(6.5));
      expect(hueDistance(c, paleBlue), lessThan(0.15));
    });

    test('large text needs only 3:1', () {
      const grey = 0xFF8A8A8A; // ~3.4:1 on white.
      expect(adapter.foreground(grey, large: true), grey);
      expect(adapter.foreground(grey), isNot(grey));
    });

    test('highlights are kept; text on them is checked against them', () {
      expect(adapter.background(0xFFFFFF00), 0xFFFFFF00);
      final onYellow = adapter.foreground(null, bg: 0xFFFFFF00);
      expect(contrastRatio(onYellow, 0xFFFFFF00), greaterThanOrEqualTo(minTextContrast));
    });

    test('a text/highlight pair chosen by the sender only needs 3:1', () {
      expect(adapter.foreground(white, bg: 0xFFFF0000), white); // 4.0:1
      final onYellow = adapter.foreground(white, bg: 0xFFFFFF00); // 1.1:1
      expect(contrastRatio(onYellow, 0xFFFFFF00), greaterThanOrEqualTo(minLargeTextContrast));
    });

    test('default text without colours is the theme colour', () {
      expect(adapter.foreground(null), darkText);
    });
  });

  group('dark mode', () {
    final adapter = ColorAdapter(page: darkPage, text: lightText);

    test('detects dark pages', () {
      expect(adapter.dark, isTrue);
      expect(ColorAdapter(page: white, text: darkText).dark, isFalse);
    });

    test('dark grey body text becomes the theme text colour', () {
      expect(adapter.foreground(black), lightText);
      expect(adapter.foreground(0xFF202020), lightText);
      expect(adapter.foreground(0xFF333333), lightText);
    });

    test('muted greys flip but stay muted', () {
      final c = adapter.foreground(0xFF666666);
      expect(contrastRatio(c, darkPage), greaterThanOrEqualTo(minTextContrast));
      expect(c, isNot(lightText));
    });

    test('dark blue links flip lightness but keep their hue', () {
      const linkBlue = 0xFF1A0DAB;
      final c = adapter.foreground(linkBlue);
      expect(contrastRatio(c, darkPage), greaterThanOrEqualTo(minTextContrast));
      expect(hueDistance(c, linkBlue), lessThan(0.2));
    });

    test('light colours are kept', () {
      expect(adapter.foreground(0xFFFFD54F), 0xFFFFD54F);
    });

    test('a yellow highlight stays yellow but is toned down, and text on it turns dark', () {
      const yellow = 0xFFFFFF00;
      final bg = adapter.background(yellow);
      expect(toOklch(bg).l, closeTo(0.78, 0.01));
      expect(hueDistance(bg, yellow), lessThan(0.1));
      expect(toOklch(bg).c, greaterThan(0.12));
      final text = adapter.foreground(null, bg: yellow);
      expect(contrastRatio(text, bg), greaterThanOrEqualTo(minTextContrast));
      // Black text on a yellow highlight follows the flipped highlight.
      final ink = adapter.foreground(black, bg: yellow);
      expect(contrastRatio(ink, bg), greaterThanOrEqualTo(minTextContrast));
    });

    test('dark highlights are kept', () {
      expect(adapter.background(0xFF003366), 0xFF003366);
    });

    test('dark-red text on a light-pink highlight is checked as a pair', () {
      // The "Overdue · Jul 12" chips of a task reminder.
      const red = 0xFFB3261E;
      const pink = 0xFFF9DEDC;
      final bg = adapter.background(pink);
      // The highlight is toned down but stays a light pink…
      expect(toOklch(bg).l, greaterThan(0.7));
      expect(hueDistance(bg, pink), lessThan(0.15));
      // …so the text is held against that pink, not the dark page: it stays
      // dark, red, and readable as body text.
      final fg = adapter.foreground(red, bg: pink);
      expect(luminance(fg), lessThan(luminance(bg)));
      expect(contrastRatio(fg, bg), greaterThanOrEqualTo(minTextContrast));
      expect(hueDistance(fg, red), lessThan(0.2));
      expect(contrastRatio(fg, darkPage), lessThan(minTextContrast)); // It would fail on the page itself.
    });

    test('a highlight kept as sent keeps its text dark', () {
      const red = 0xFF8C1D18;
      const rose = 0xFFE07A72; // Mid lightness: kept in dark mode.
      expect(adapter.background(rose), rose);
      final fg = adapter.foreground(red, bg: rose);
      expect(luminance(fg), lessThan(luminance(rose)));
      expect(contrastRatio(fg, rose), greaterThanOrEqualTo(minLargeTextContrast));
    });

    test('our own colours on a sender highlight need the body-text minimum', () {
      // Theme text (light in dark mode) and the link colour are ours, not a
      // pair the sender chose with the highlight: on these mid reds they
      // used to stop at 3:1.
      for (final highlight in [0xFFC0504D, 0xFFD9534F]) {
        expect(adapter.background(highlight), highlight);
        for (final ours in [lightText, 0xFFA8C7FA]) {
          final fg = adapter.foreground(null, bg: highlight, fallback: ours);
          expect(contrastRatio(fg, highlight), greaterThanOrEqualTo(minTextContrast), reason: ours.toRadixString(16));
        }
      }
      // Without a highlight the fallback is checked against the page.
      expect(adapter.foreground(null, fallback: 0xFFA8C7FA), 0xFFA8C7FA);
      expect(adapter.foreground(null, fallback: 0xFF1A0DAB), isNot(0xFF1A0DAB));
    });
  });

  test('ensureContrast falls back to black or white when no lightness works', () {
    const midGrey = 0xFF777777;
    final c = ensureContrast(0xFF7A7A7A, midGrey, 7);
    expect(c == white || c == black, isTrue);
  });
}
