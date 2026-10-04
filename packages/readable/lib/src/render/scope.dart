// What every block widget needs from the reader: the document, the styles,
// the colour adapter, image resolution and the link/image actions.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../color/color_adapter.dart';
import '../model/document.dart';

/// Text styles of the reader, derived from the theme.
@immutable
final class ReaderStyles {
  const ReaderStyles({
    required this.body,
    required this.mono,
    required this.link,
    required this.muted,
    required this.codeBackground,
    required this.divider,
    required this.quoteBars,
    required this.headings,
  });

  factory ReaderStyles.of(BuildContext context, {bool monoBody = false}) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final base = (theme.textTheme.bodyLarge ?? const TextStyle(fontSize: 16)).copyWith(
      color: scheme.onSurface,
      height: 1.45,
      fontSize: 16,
    );
    final mono = base.copyWith(
      fontFamily: 'monospace',
      fontFamilyFallback: const ['Menlo', 'Roboto Mono', 'Courier New', 'Courier'],
      fontSize: 14.5,
      height: 1.4,
    );
    final body = monoBody ? mono : base;
    return ReaderStyles(
      body: body,
      mono: mono,
      link: scheme.primary,
      muted: scheme.onSurfaceVariant,
      codeBackground: scheme.surfaceContainerHighest,
      divider: scheme.outlineVariant,
      quoteBars: theme.brightness == Brightness.dark
          ? const [Color(0xFF64B5F6), Color(0xFF81C784), Color(0xFFFFB74D), Color(0xFFBA68C8), Color(0xFF4DB6AC)]
          : const [Color(0xFF1E88E5), Color(0xFF43A047), Color(0xFFF57C00), Color(0xFF8E24AA), Color(0xFF00897B)],
      headings: [
        for (final (scale, weight) in const [
          (1.5, FontWeight.w700),
          (1.3, FontWeight.w700),
          (1.15, FontWeight.w600),
          (1.0, FontWeight.w600),
          (1.0, FontWeight.w600),
          (0.95, FontWeight.w600),
        ])
          base.copyWith(fontSize: 16 * scale, fontWeight: weight, height: 1.3),
      ],
    );
  }

  /// Paragraph text (Sans, or Mono in Plain mode with the Mono font).
  final TextStyle body;

  /// Code, `pre`, monospace runs.
  final TextStyle mono;
  final Color link;
  final Color muted;
  final Color codeBackground;
  final Color divider;

  /// One colour per quote level.
  final List<Color> quoteBars;

  /// h1 – h6.
  final List<TextStyle> headings;

  Color quoteBar(int depth) => quoteBars[depth % quoteBars.length];

  // Value equality, so the scope only notifies its blocks when the theme
  // really changed.
  @override
  bool operator ==(Object other) =>
      other is ReaderStyles &&
      other.body == body &&
      other.mono == mono &&
      other.link == link &&
      other.muted == muted &&
      other.codeBackground == codeBackground &&
      other.divider == divider &&
      listEquals(other.quoteBars, quoteBars) &&
      listEquals(other.headings, headings);

  @override
  int get hashCode => Object.hash(body, mono, link, muted, codeBackground, divider);
}

/// Provides the reader's state to the block widgets below it.
class ReaderScope extends InheritedWidget {
  const ReaderScope({
    super.key,
    required this.document,
    required this.styles,
    required this.colors,
    required this.imageFor,
    required this.onImageTap,
    required this.onLinkTap,
    required this.onLinkLongPress,
    required this.remoteAllowed,
    required super.child,
  });

  final ReaderDocument document;
  final ReaderStyles styles;

  /// Null when the user keeps the original colours.
  final ColorAdapter? colors;

  /// The image to show for an image index; null when blocked or unresolvable.
  final ImageProvider? Function(int image) imageFor;
  final void Function(int image) onImageTap;
  final void Function(int link) onLinkTap;
  final void Function(int link, {int? image}) onLinkLongPress;
  final bool remoteAllowed;

  static ReaderScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ReaderScope>();
    assert(scope != null, 'No ReaderScope above this widget');
    return scope!;
  }

  /// Applies colour adaptation to a text colour over an optional highlight.
  Color textColor(int? fg, {int? bg, bool large = false, Color? fallback}) {
    final adapter = colors;
    if (adapter == null) return fg != null ? Color(fg) : (fallback ?? styles.body.color!);
    if (fg == null && fallback != null) {
      return Color(adapter.foreground(fallback.toARGB32(), bg: bg, large: large));
    }
    return Color(adapter.foreground(fg, bg: bg, large: large));
  }

  Color highlight(int bg) => colors == null ? Color(bg) : Color(colors!.background(bg));

  @override
  bool updateShouldNotify(ReaderScope oldWidget) =>
      document != oldWidget.document ||
      styles != oldWidget.styles ||
      colors != oldWidget.colors ||
      remoteAllowed != oldWidget.remoteAllowed ||
      imageFor != oldWidget.imageFor;
}

/// Multiplies the platform text scaler (which may be nonlinear) by the
/// reader's own text size setting.
final class MultipliedTextScaler extends TextScaler {
  const MultipliedTextScaler(this.base, this.factor);

  final TextScaler base;
  final double factor;

  @override
  double scale(double fontSize) => base.scale(fontSize) * factor;

  @override
  double get textScaleFactor => scale(14) / 14;

  @override
  bool operator ==(Object other) => other is MultipliedTextScaler && other.base == base && other.factor == factor;

  @override
  int get hashCode => Object.hash(base, factor);
}

/// Direction of a paragraph: explicit, or from its first strong character.
TextDirection? textDirectionFor(TextDir dir, String text) {
  switch (dir) {
    case TextDir.rtl:
      return TextDirection.rtl;
    case TextDir.ltr:
      return TextDirection.ltr;
    case TextDir.auto:
      for (final rune in text.runes) {
        if (_isRtl(rune)) return TextDirection.rtl;
        if (_isStrongLtr(rune)) return TextDirection.ltr;
      }
      return null;
  }
}

bool _isRtl(int c) =>
    (c >= 0x0590 && c <= 0x08FF) ||
    (c >= 0xFB1D && c <= 0xFDFF) ||
    (c >= 0xFE70 && c <= 0xFEFF) ||
    (c >= 0x10800 && c <= 0x10FFF);

bool _isStrongLtr(int c) =>
    (c >= 0x41 && c <= 0x5A) ||
    (c >= 0x61 && c <= 0x7A) ||
    (c >= 0xC0 && c <= 0x24F) ||
    (c >= 0x370 && c <= 0x58F) ||
    (c >= 0x900 && c <= 0x1FFF) ||
    (c >= 0x3040 && c <= 0x9FFF) ||
    (c >= 0xAC00 && c <= 0xD7AF);

TextAlign textAlignFor(BlockAlign align) => switch (align) {
  BlockAlign.start => TextAlign.start,
  BlockAlign.center => TextAlign.center,
  BlockAlign.right => TextAlign.right,
};
