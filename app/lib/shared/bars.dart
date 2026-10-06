import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../features/panes/pane_layout.dart';
import '../theme/theme.dart';
import '../theme/loupe_icons.dart';

/// A translucent bottom toolbar with a hairline on top, like iOS toolbars.
class LoupeBottomBar extends StatelessWidget {
  const LoupeBottomBar({super.key, this.leading, this.center, this.trailing, this.height = 50});

  final Widget? leading;
  final Widget? center;
  final Widget? trailing;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.barBackground,
            border: Border(top: BorderSide(color: colors.separator, width: 0.5)),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  children: [
                    SizedBox(
                      width: 64,
                      child: Align(alignment: Alignment.centerLeft, child: leading),
                    ),
                    Expanded(child: Center(child: center)),
                    SizedBox(
                      width: 64,
                      child: Align(alignment: Alignment.centerRight, child: trailing),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// An icon button in a bar, tinted with the accent colour.
class BarIconButton extends StatelessWidget {
  const BarIconButton({super.key, required this.icon, required this.onPressed, required this.tooltip, this.size = 24});

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      excludeFromSemantics: true,
      child: Semantics(
        button: true,
        label: tooltip,
        child: CupertinoButton(
          padding: const EdgeInsets.all(8),
          minimumSize: const Size(44, 44),
          onPressed: onPressed,
          child: Icon(icon, size: size),
        ),
      ),
    );
  }
}

/// A text button in a navigation bar ("Edit", "Done").
class BarTextButton extends StatelessWidget {
  const BarTextButton({super.key, required this.label, required this.onPressed, this.bold = false});

  final String label;
  final VoidCallback? onPressed;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: const Size(44, 44),
      onPressed: onPressed,
      child: Text(label, style: TextStyle(fontWeight: bold ? FontWeight.w600 : FontWeight.w400, fontSize: 17)),
    );
  }
}

/// Text scaling in the top bars stops here, so titles and buttons stay on
/// one line (iOS limits navigation bars similarly).
const _barMaxTextScale = 1.5;

/// Height of the search row of a [LoupeTitleBar]: the field plus its bottom
/// padding. Lists start scrolled by this much to hide the field until it is
/// pulled down.
double searchBarExtent(BuildContext context) {
  final scaler = MediaQuery.textScalerOf(context).clamp(maxScaleFactor: _barMaxTextScale);
  // CupertinoSearchTextField: 8 + 8 padding around a 17 pt line.
  return (16 + scaler.scale(17) * 1.2).roundToDouble() + 8;
}

/// Whether top bars show a back button. Android has a system back (the
/// gesture or the navigation bar's button), so its bars leave the button out
/// and give the space to the title. iOS has none, so its bars keep it, as do
/// desktops. Follows [ThemeData.platform], so tests can switch it with
/// `debugDefaultTargetPlatformOverride`.
///
/// Modal and full-screen surfaces keep their explicit Cancel or Close.
bool showsBackButton(BuildContext context) => switch (Theme.of(context).platform) {
  TargetPlatform.android || TargetPlatform.fuchsia => false,
  TargetPlatform.iOS || TargetPlatform.macOS || TargetPlatform.linux || TargetPlatform.windows => true,
};

/// A back chevron for a top bar where [showsBackButton] and the route can
/// pop; null otherwise.
Widget? impliedBackButton(BuildContext context) {
  final canPop = ModalRoute.of(context)?.impliesAppBarDismissal ?? false;
  return canPop && showsBackButton(context) ? const LoupeBackButton() : null;
}

/// The back chevron of the top bars (see [showsBackButton]).
class LoupeBackButton extends StatelessWidget {
  const LoupeBackButton({super.key});

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: 'Back',
    excludeSemantics: true,
    child: CupertinoButton(
      padding: const EdgeInsetsDirectional.only(start: 4, end: 2),
      minimumSize: const Size(36, 44),
      onPressed: () => Navigator.maybePop(context),
      child: const Icon(LoupeIcons.back, size: 28),
    ),
  );
}

/// The pinned header of a screen, as a sliver: a back chevron (on iOS, when
/// the route can pop; see [showsBackButton]) or [leading], the bold [title]
/// on the same line, left-aligned, and [trailing] actions. It replaces iOS's
/// large-title band, which spent a whole row on the title.
///
/// With a [searchField], a search row sits below the title. It collapses
/// under the title as the list scrolls (lists start scrolled by
/// [searchBarExtent] to hide it until pulled down). While [searching], the
/// title row is gone and the search row stays at the top with Cancel.
///
/// The bar is transparent at rest. Once content scrolls under it, it turns
/// translucent and blurred with a hairline below. It includes the top safe
/// area and grows with the text size, up to a limit.
class LoupeTitleBar extends StatelessWidget {
  const LoupeTitleBar({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing = const [],
    this.large = false,
    this.automaticallyImplyLeading = true,
    this.searchField,
    this.searching = false,
    this.onCancelSearch,
  });

  final String title;

  /// A smaller second line (the account of a mailbox).
  final Widget? subtitle;

  /// Replaces the back chevron (which only iOS shows).
  final Widget? leading;
  final List<Widget> trailing;

  /// The root screen's bigger title (Mailboxes).
  final bool large;
  final bool automaticallyImplyLeading;

  /// A [LoupeSearchField] for the search row.
  final Widget? searchField;
  final bool searching;
  final VoidCallback? onCancelSearch;

  /// Title size: 28 pt on the root screen, 22 pt on pushed ones.
  static double titleSize({required bool large}) => large ? 28 : 22;

  /// The title row's height (below the safe area).
  static double heightOf(BuildContext context, {bool large = false, bool subtitle = false}) {
    final scaler = MediaQuery.textScalerOf(context).clamp(maxScaleFactor: _barMaxTextScale);
    final titleLine = scaler.scale(titleSize(large: large)) * (subtitle ? 1.1 : 1.2);
    final subtitleLine = subtitle ? scaler.scale(13) * 1.15 : 0;
    return math.max(44, (titleLine + subtitleLine + 8).ceilToDouble());
  }

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    final canPop = ModalRoute.of(context)?.impliesAppBarDismissal ?? false;
    final lead =
        leading ??
        // In the wide layout's list pane: the sidebar button.
        (automaticallyImplyLeading && !canPop ? MailPaneScope.maybeOf(context)?.titleLeading : null) ??
        (automaticallyImplyLeading ? impliedBackButton(context) : null);
    final titleStyle = styles.largeTitle.copyWith(
      fontSize: titleSize(large: large),
      height: subtitle == null ? 1.2 : 1.1,
      letterSpacing: large ? 0.2 : 0,
    );
    final titleRow = Row(
      children: [
        if (lead == null)
          const SizedBox(width: 16)
        else ...[
          SizedBox(width: leading == null ? 4 : 8),
          lead,
          const SizedBox(width: 2),
        ],
        Expanded(
          child: Semantics(
            header: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: titleStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                if (subtitle != null)
                  DefaultTextStyle.merge(
                    style: styles.footnote.copyWith(height: 1.15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    child: subtitle!,
                  ),
              ],
            ),
          ),
        ),
        ...trailing,
        const SizedBox(width: 8),
      ],
    );
    return SliverPersistentHeader(
      pinned: true,
      delegate: _BarDelegate(
        topPadding: MediaQuery.paddingOf(context).top,
        titleHeight: heightOf(context, large: large, subtitle: subtitle != null),
        searchHeight: searchField == null ? 0 : searchBarExtent(context),
        searching: searchField != null && searching,
        colors: LoupeColors.of(context),
        titleRow: titleRow,
        searchField: searchField,
        onCancelSearch: onCancelSearch,
      ),
    );
  }
}

class _BarDelegate extends SliverPersistentHeaderDelegate {
  _BarDelegate({
    required this.topPadding,
    required this.titleHeight,
    required this.searchHeight,
    required this.searching,
    required this.colors,
    required this.titleRow,
    required this.searchField,
    required this.onCancelSearch,
  });

  final double topPadding;
  final double titleHeight;
  final double searchHeight;
  final bool searching;
  final LoupeColors colors;
  final Widget titleRow;
  final Widget? searchField;
  final VoidCallback? onCancelSearch;

  /// Space above the search field while searching (no title row).
  static const _searchingTop = 8.0;

  static const _titleKey = ValueKey('title');
  static const _searchKey = ValueKey('search');

  @override
  double get minExtent => topPadding + (searching ? _searchingTop + searchHeight : titleHeight);

  @override
  double get maxExtent => topPadding + (searching ? _searchingTop : titleHeight) + searchHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // The search row shrinks first; then content scrolls under the bar.
    final searchShown = searching ? searchHeight : math.max(0.0, searchHeight - shrinkOffset);
    final field = searchField;
    return _BarBackground(
      // Collapsing the search row isn't scrolling content under the bar.
      scrolledUnderOffset: searching ? 0 : searchHeight,
      colors: colors,
      child: MediaQuery.withClampedTextScaling(
        maxScaleFactor: _barMaxTextScale,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding + (searching ? _searchingTop : 0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!searching)
                KeyedSubtree(
                  key: _titleKey,
                  child: SizedBox(height: titleHeight, child: titleRow),
                ),
              if (field != null)
                // Same structure while searching or not, so the field (and
                // its focus) survives the switch.
                KeyedSubtree(
                  key: _searchKey,
                  child: SizedBox(
                    height: searchShown,
                    child: ClipRect(
                      child: OverflowBox(
                        alignment: Alignment.bottomCenter,
                        minHeight: searchHeight,
                        maxHeight: searchHeight,
                        child: Opacity(
                          // Fades out as it slides under the title.
                          opacity: (searchShown / searchHeight * 1.6 - 0.6).clamp(0.0, 1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 0, searching ? 4 : 16, 8),
                            child: Row(
                              children: [
                                Expanded(child: field),
                                if (searching)
                                  CupertinoButton(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    minimumSize: const Size(44, 36),
                                    onPressed: onCancelSearch,
                                    child: const Text('Cancel', maxLines: 1),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // The bar's widgets change with the screen's state (titles, buttons).
  @override
  bool shouldRebuild(_BarDelegate old) => true;
}

/// Transparent while nothing is under the bar; translucent and blurred with
/// a hairline once the scroll position passes [scrolledUnderOffset].
class _BarBackground extends StatefulWidget {
  const _BarBackground({required this.scrolledUnderOffset, required this.colors, required this.child});

  final double scrolledUnderOffset;
  final LoupeColors colors;
  final Widget child;

  @override
  State<_BarBackground> createState() => _BarBackgroundState();
}

class _BarBackgroundState extends State<_BarBackground> {
  ScrollPosition? _position;
  bool _scrolledUnder = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context)?.position;
    if (position != _position) {
      _position?.removeListener(_update);
      _position = position?..addListener(_update);
      _scrolledUnder = _compute();
    }
  }

  @override
  void didUpdateWidget(_BarBackground old) {
    super.didUpdateWidget(old);
    _scrolledUnder = _compute();
  }

  @override
  void dispose() {
    _position?.removeListener(_update);
    super.dispose();
  }

  bool _compute() {
    final p = _position;
    return p != null && p.hasPixels && p.pixels > widget.scrolledUnderOffset + 0.5;
  }

  void _update() {
    final next = _compute();
    if (next != _scrolledUnder) setState(() => _scrolledUnder = next);
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors;
    return ClipRect(
      child: BackdropFilter(
        enabled: _scrolledUnder,
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          color: _scrolledUnder ? colors.barBackground : colors.barBackground.withValues(alpha: 0),
          // In front, so the hairline takes no space from the bar.
          foregroundDecoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _scrolledUnder ? colors.separator : colors.separator.withValues(alpha: 0),
                width: 0.5,
              ),
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// The search field used in navigation bars.
class LoupeSearchField extends StatelessWidget {
  const LoupeSearchField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.placeholder = 'Search',
    this.autofocus = false,
    this.onLongPress,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String placeholder;
  final bool autofocus;

  /// A long press while the field isn't being typed in (the command
  /// palette). Needs [focusNode].
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final field = _field(context);
    final focus = focusNode;
    final longPress = onLongPress;
    if (focus == null || longPress == null) return field;
    return ListenableBuilder(
      listenable: focus,
      builder: (context, child) => RawGestureDetector(
        // Shorter than the field's own long press, so it wins; off while
        // typing, where a long press selects text.
        gestures: focus.hasFocus
            ? const {}
            : {
                LongPressGestureRecognizer: GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
                  () => LongPressGestureRecognizer(duration: const Duration(milliseconds: 400), debugOwner: this),
                  (r) => r.onLongPress = longPress,
                ),
              },
        child: child,
      ),
      child: field,
    );
  }

  Widget _field(BuildContext context) {
    final colors = LoupeColors.of(context);
    return CupertinoSearchTextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      placeholder: placeholder,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autocorrect: false,
      backgroundColor: colors.fill,
      style: LoupeTextStyles.of(context).body,
      placeholderStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.secondaryText),
      prefixIcon: const Icon(LoupeIcons.search),
      suffixIcon: const Icon(LoupeIcons.clear),
    );
  }
}
