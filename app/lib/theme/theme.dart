import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../settings/app_settings.dart';
import 'loupe_icons.dart';

/// App-specific colours, available as `LoupeColors.of(context)`.
///
/// The values follow the iOS system palette (label, secondaryLabel, grouped
/// backgrounds…) so both platforms get Apple Mail's calm contrast.
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
    this.label = const Color(0xFF000000),
    this.tertiaryText = const Color(0x4D3C3C43),
    this.cellBackground = const Color(0xFFFFFFFF),
    this.fill = const Color(0x1F767680),
    this.barBackground = const Color(0xF0F9F9F9),
    this.destructive = const Color(0xFFFF3B30),
    this.success = const Color(0xFF34C759),
    this.selectedRow = const Color(0xFFE5E5EA),
    this.snooze = const Color(0xFF5856D6),
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

  /// Primary text.
  final Color label;

  /// Placeholders, disabled rows, chevrons.
  final Color tertiaryText;

  /// Rows of an inset-grouped list, on top of [groupedBackground].
  final Color cellBackground;

  /// Search fields, chips and other filled controls.
  final Color fill;

  /// Translucent top and bottom bars.
  final Color barBackground;
  final Color destructive;
  final Color success;

  /// A selected (or pressed) row.
  final Color selectedRow;

  /// Snooze: its swipe action and the "Snoozed" mark (iOS indigo).
  final Color snooze;

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
    label: label,
    tertiaryText: tertiaryText,
    cellBackground: cellBackground,
    fill: fill,
    barBackground: barBackground,
    destructive: destructive,
    success: success,
    selectedRow: selectedRow,
    snooze: snooze,
  );

  @override
  LoupeColors lerp(LoupeColors? other, double t) => t < 0.5 || other == null ? this : other;
}

/// Apple Mail's type ramp: large title 34 bold, list sender 17, subject,
/// preview and date 15. Colours are resolved for the current brightness.
@immutable
class LoupeTextStyles extends ThemeExtension<LoupeTextStyles> {
  const LoupeTextStyles({
    required this.largeTitle,
    required this.navTitle,
    required this.body,
    required this.sender,
    required this.senderUnread,
    required this.subject,
    required this.preview,
    required this.date,
    required this.footnote,
    required this.caption,
    required this.sectionHeader,
  });

  final TextStyle largeTitle;
  final TextStyle navTitle;
  final TextStyle body;
  final TextStyle sender;
  final TextStyle senderUnread;
  final TextStyle subject;
  final TextStyle preview;
  final TextStyle date;

  /// 13 pt secondary text: status lines, section footers.
  final TextStyle footnote;

  /// 12 pt secondary text: badges, small labels.
  final TextStyle caption;

  /// Headers of inset-grouped sections (account names on the Mailboxes screen).
  final TextStyle sectionHeader;

  static LoupeTextStyles of(BuildContext context) => Theme.of(context).extension<LoupeTextStyles>()!;

  @override
  LoupeTextStyles copyWith() => this;

  @override
  LoupeTextStyles lerp(LoupeTextStyles? other, double t) => t < 0.5 || other == null ? this : other;
}

/// Spacing that depends on the Density setting.
@immutable
class LoupeMetrics extends ThemeExtension<LoupeMetrics> {
  const LoupeMetrics({this.density = Density.comfortable});

  final Density density;

  bool get compact => density == Density.compact;

  /// Vertical padding of a message list row.
  double get rowVerticalPadding => compact ? 7 : 11;

  /// Preview lines in the message list (Apple Mail's default is 2).
  int get previewLines => compact ? 1 : 2;

  /// Minimum height of an inset-grouped row.
  double get groupedRowHeight => compact ? 40 : 46;

  /// The left gutter of message rows, where the unread dot and flag sit.
  double get rowGutter => 28;

  static LoupeMetrics of(BuildContext context) => Theme.of(context).extension<LoupeMetrics>() ?? const LoupeMetrics();

  @override
  LoupeMetrics copyWith({Density? density}) => LoupeMetrics(density: density ?? this.density);

  @override
  LoupeMetrics lerp(LoupeMetrics? other, double t) => t < 0.5 || other == null ? this : other;
}

/// Light and dark themes: Apple-Mail-like clarity on both platforms.
abstract final class LoupeTheme {
  static const _accent = CupertinoColors.systemBlue;

  static ThemeData light({Density density = Density.comfortable}) => _build(Brightness.light, density);
  static ThemeData dark({Density density = Density.comfortable}) => _build(Brightness.dark, density);

  static ThemeData _build(Brightness brightness, Density density) {
    final dark = brightness == Brightness.dark;
    Color sys(CupertinoDynamicColor c) => dark ? c.darkColor : c.color;
    final accent = sys(_accent);
    final label = dark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
    final secondary = dark ? const Color(0x99EBEBF5) : const Color(0x993C3C43);
    final tertiary = dark ? const Color(0x4DEBEBF5) : const Color(0x4D3C3C43);
    final separator = dark ? const Color(0xFF38383A) : const Color(0xFFC6C6C8);
    final surface = dark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
    final grouped = dark ? const Color(0xFF000000) : const Color(0xFFF2F2F7);
    final cell = dark ? const Color(0xFF1C1C1E) : const Color(0xFFFFFFFF);
    final bar = dark ? const Color(0xF01D1D1D) : const Color(0xF0F9F9F9);

    final scheme = ColorScheme.fromSeed(seedColor: accent, brightness: brightness).copyWith(
      primary: accent,
      onPrimary: Colors.white,
      surface: surface,
      onSurface: label,
      onSurfaceVariant: secondary,
      outline: separator,
      outlineVariant: separator,
      error: sys(CupertinoColors.systemRed),
      surfaceContainerLowest: surface,
      surfaceContainerLow: cell,
      surfaceContainer: cell,
      surfaceContainerHigh: cell,
      surfaceContainerHighest: dark ? const Color(0xFF2C2C2E) : const Color(0xFFE5E5EA),
    );

    // No fontFamily: the platform's system font (San Francisco, Roboto) applies.
    TextStyle s(double size, {FontWeight weight = FontWeight.w400, Color? color, double? height}) =>
        TextStyle(fontSize: size, fontWeight: weight, color: color ?? label, height: height, letterSpacing: 0);

    final styles = LoupeTextStyles(
      largeTitle: s(34, weight: FontWeight.w700),
      navTitle: s(17, weight: FontWeight.w600),
      body: s(17),
      sender: s(17, weight: FontWeight.w400),
      senderUnread: s(17, weight: FontWeight.w600),
      subject: s(15),
      preview: s(15, color: secondary, height: 1.25),
      date: s(15, color: secondary),
      footnote: s(13, color: secondary),
      caption: s(12, color: secondary),
      sectionHeader: s(20, weight: FontWeight.w700),
    );

    final textTheme = TextTheme(
      displaySmall: styles.largeTitle,
      headlineSmall: s(22, weight: FontWeight.w700),
      titleLarge: s(20, weight: FontWeight.w600),
      titleMedium: s(17, weight: FontWeight.w600),
      titleSmall: s(15, weight: FontWeight.w600),
      bodyLarge: s(17),
      bodyMedium: s(15),
      bodySmall: s(13, color: secondary),
      labelLarge: s(17, weight: FontWeight.w500),
      labelMedium: s(15),
      labelSmall: s(12, color: secondary),
    );

    final cupertino = CupertinoThemeData(
      brightness: brightness,
      primaryColor: accent,
      barBackgroundColor: bar,
      scaffoldBackgroundColor: surface,
      textTheme: CupertinoTextThemeData(
        primaryColor: accent,
        textStyle: s(17),
        actionTextStyle: s(17, color: accent),
        navTitleTextStyle: styles.navTitle,
        navLargeTitleTextStyle: styles.largeTitle,
        navActionTextStyle: s(17, color: accent),
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      textTheme: textTheme,
      cupertinoOverrideTheme: cupertino,
      scaffoldBackgroundColor: surface,
      canvasColor: surface,
      splashFactory: NoSplash.splashFactory,
      highlightColor: dark ? const Color(0x22FFFFFF) : const Color(0x14000000),
      visualDensity: density == Density.compact ? VisualDensity.compact : VisualDensity.standard,
      dividerTheme: DividerThemeData(color: separator, thickness: 0.5, space: 0.5),
      iconTheme: IconThemeData(color: accent, size: 24),
      // Material's own back and close buttons (app bars) use the app's icons.
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (_) => const Icon(LoupeIcons.back),
        closeButtonIconBuilder: (_) => const Icon(LoupeIcons.close),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: label,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        titleTextStyle: styles.navTitle,
        iconTheme: IconThemeData(color: accent),
        actionsIconTheme: IconThemeData(color: accent),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: grouped,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: tertiary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(14))),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: cell,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: dark ? const Color(0xFF2C2C2E) : const Color(0xFF1C1C1E),
        contentTextStyle: s(15, color: Colors.white),
        // The bar is dark in both themes, so the action uses the dark-mode blue.
        actionTextColor: CupertinoColors.systemBlue.darkColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll(Colors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? sys(CupertinoColors.systemGreen) : scheme.surfaceContainerHighest,
        ),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: accent, selectionHandleColor: accent),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: s(17, color: tertiary),
        border: InputBorder.none,
        isDense: true,
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
          flag: sys(CupertinoColors.systemOrange),
          vip: sys(CupertinoColors.systemYellow),
          separator: separator,
          secondaryText: secondary,
          groupedBackground: grouped,
          swipeRead: accent,
          swipeFlag: sys(CupertinoColors.systemOrange),
          swipeArchive: sys(CupertinoColors.systemPurple),
          swipeTrash: sys(CupertinoColors.systemRed),
          swipeMore: sys(CupertinoColors.systemGrey),
          accountColors: [
            sys(CupertinoColors.systemBlue),
            sys(CupertinoColors.systemGreen),
            sys(CupertinoColors.systemOrange),
            sys(CupertinoColors.systemPink),
            sys(CupertinoColors.systemTeal),
            sys(CupertinoColors.systemIndigo),
          ],
          label: label,
          tertiaryText: tertiary,
          cellBackground: cell,
          fill: dark ? const Color(0x3D767680) : const Color(0x1F767680),
          barBackground: bar,
          destructive: sys(CupertinoColors.systemRed),
          success: sys(CupertinoColors.systemGreen),
          selectedRow: dark ? const Color(0xFF2C2C2E) : const Color(0xFFE5E5EA),
          snooze: sys(CupertinoColors.systemIndigo),
        ),
        styles,
        LoupeMetrics(density: density),
      ],
    );
  }
}

/// iOS-style scrolling everywhere: bouncing overscroll (needed for the
/// pull-down search field and pull to refresh) and no Android glow.
class LoupeScrollBehavior extends MaterialScrollBehavior {
  const LoupeScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;
}
