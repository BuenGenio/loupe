import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// App-specific colours, available as `LoupeColors.of(context)`.
@immutable
class LoupeColors extends ThemeExtension<LoupeColors> {
  const LoupeColors({
    required this.unreadDot,
    required this.flag,
    required this.vip,
    required this.separator,
    required this.secondaryText,
    required this.groupedBackground,
    required this.swipeRead,
    required this.swipeFlag,
    required this.swipeArchive,
    required this.swipeTrash,
    required this.swipeMore,
    required this.accountColors,
  });

  final Color unreadDot;
  final Color flag;
  final Color vip;
  final Color separator;
  final Color secondaryText;

  /// Background of grouped lists (settings, mailboxes), like iOS grouped tables.
  final Color groupedBackground;
  final Color swipeRead;
  final Color swipeFlag;
  final Color swipeArchive;
  final Color swipeTrash;
  final Color swipeMore;

  /// Account stripes; index with MailAccount.colorIndex modulo length.
  final List<Color> accountColors;

  static LoupeColors of(BuildContext context) => Theme.of(context).extension<LoupeColors>()!;

  Color accountColor(int index) => accountColors[index % accountColors.length];

  @override
  LoupeColors copyWith({Color? unreadDot, Color? flag}) => LoupeColors(
    unreadDot: unreadDot ?? this.unreadDot,
    flag: flag ?? this.flag,
    vip: vip,
    separator: separator,
    secondaryText: secondaryText,
    groupedBackground: groupedBackground,
    swipeRead: swipeRead,
    swipeFlag: swipeFlag,
    swipeArchive: swipeArchive,
    swipeTrash: swipeTrash,
    swipeMore: swipeMore,
    accountColors: accountColors,
  );

  @override
  LoupeColors lerp(LoupeColors? other, double t) => t < 0.5 || other == null ? this : other;
}

/// Light and dark themes: Apple-Mail-like clarity on both platforms.
abstract final class LoupeTheme {
  static const _accent = CupertinoColors.systemBlue;

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final accent = dark ? _accent.darkColor : _accent.color;
    final scheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: brightness,
    ).copyWith(primary: accent, surface: dark ? const Color(0xFF000000) : const Color(0xFFFFFFFF));
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      splashFactory: NoSplash.splashFactory,
      dividerTheme: DividerThemeData(
        color: dark ? const Color(0xFF38383A) : const Color(0xFFC6C6C8),
        thickness: 0.5,
        space: 0.5,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: dark ? Colors.white : Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      extensions: [
        LoupeColors(
          unreadDot: accent,
          flag: dark ? CupertinoColors.systemOrange.darkColor : CupertinoColors.systemOrange.color,
          vip: dark ? CupertinoColors.systemYellow.darkColor : CupertinoColors.systemYellow.color,
          separator: dark ? const Color(0xFF38383A) : const Color(0xFFC6C6C8),
          secondaryText: dark ? const Color(0x99EBEBF5) : const Color(0x993C3C43),
          groupedBackground: dark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
          swipeRead: accent,
          swipeFlag: dark ? CupertinoColors.systemOrange.darkColor : CupertinoColors.systemOrange.color,
          swipeArchive: dark ? CupertinoColors.systemPurple.darkColor : CupertinoColors.systemPurple.color,
          swipeTrash: dark ? CupertinoColors.systemRed.darkColor : CupertinoColors.systemRed.color,
          swipeMore: dark ? CupertinoColors.systemGrey.darkColor : CupertinoColors.systemGrey.color,
          accountColors: const [
            CupertinoColors.systemBlue,
            CupertinoColors.systemGreen,
            CupertinoColors.systemOrange,
            CupertinoColors.systemPink,
            CupertinoColors.systemTeal,
            CupertinoColors.systemIndigo,
          ],
        ),
      ],
    );
  }
}
