import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'bars.dart';

/// An iOS inset-grouped section: rounded card, hairline separators inset past
/// the leading icon, optional header and footer.
class InsetGroup extends StatelessWidget {
  const InsetGroup({
    super.key,
    required this.children,
    this.header,
    this.footer,
    this.headerLeading,
    this.headerTrailing,
    this.onHeaderTap,
    this.margin = const EdgeInsets.fromLTRB(16, 0, 16, 24),
    this.separatorIndent = 54,
    this.largeHeader = false,
  });

  final List<Widget> children;
  final String? header;
  final String? footer;
  final Widget? headerLeading;
  final Widget? headerTrailing;
  final VoidCallback? onHeaderTap;
  final EdgeInsets margin;

  /// Where separators start, measured from the card's leading edge.
  final double separatorIndent;

  /// Account-style header (20 pt bold) instead of the small caps label.
  final bool largeHeader;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      rows.add(children[i]);
      if (i < children.length - 1) {
        rows.add(
          Padding(
            padding: EdgeInsetsDirectional.only(start: separatorIndent),
            child: Divider(height: 0.5, thickness: 0.5, color: colors.separator),
          ),
        );
      }
    }
    Widget? head;
    if (header != null) {
      final text = largeHeader
          ? Text(header!, style: styles.sectionHeader, maxLines: 1, overflow: TextOverflow.ellipsis)
          : Text(header!.toUpperCase(), style: styles.footnote.copyWith(letterSpacing: 0.2));
      head = Padding(
        padding: EdgeInsets.fromLTRB(largeHeader ? 4 : 16, largeHeader ? 4 : 0, 4, largeHeader ? 8 : 7),
        child: Row(
          children: [
            if (headerLeading != null) ...[headerLeading!, const SizedBox(width: 8)],
            Expanded(child: text),
            ?headerTrailing,
          ],
        ),
      );
      if (onHeaderTap != null) {
        head = GestureDetector(behavior: HitTestBehavior.opaque, onTap: onHeaderTap, child: head);
      }
    }
    return Padding(
      padding: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ?head,
          if (rows.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              // A Material (not a ColoredBox) so row highlights paint on the card.
              child: Material(
                color: colors.cellBackground,
                child: Column(mainAxisSize: MainAxisSize.min, children: rows),
              ),
            ),
          if (footer != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 7, 16, 0),
              child: Text(footer!, style: styles.footnote),
            ),
        ],
      ),
    );
  }
}

/// One row of an [InsetGroup].
class GroupedRow extends StatelessWidget {
  const GroupedRow({
    super.key,
    required this.title,
    this.leading,
    this.subtitle,
    this.trailing,
    this.detail,
    this.onTap,
    this.onLongPress,
    this.chevron,
    this.destructive = false,
    this.enabled = true,
    this.indent = 0,
    this.titleStyle,
  });

  final String title;
  final Widget? leading;
  final String? subtitle;

  /// Shown before the chevron, in secondary colour (a count, a value).
  final String? detail;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  /// Defaults to showing a chevron when the row is tappable.
  final bool? chevron;
  final bool destructive;
  final bool enabled;

  /// Extra leading indentation (nested folders).
  final double indent;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final metrics = LoupeMetrics.of(context);
    final showChevron = chevron ?? (onTap != null && !destructive);
    final color = !enabled
        ? colors.tertiaryText
        : destructive
        ? colors.destructive
        : colors.label;
    return InkWell(
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: metrics.groupedRowHeight),
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: 16 + indent, end: 14),
          child: Row(
            children: [
              if (leading != null) ...[SizedBox(width: 26, child: Center(child: leading)), const SizedBox(width: 12)],
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: (titleStyle ?? styles.body).copyWith(color: color),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(subtitle!, style: styles.footnote, maxLines: 2, overflow: TextOverflow.ellipsis),
                        ),
                    ],
                  ),
                ),
              ),
              if (detail != null)
                Flexible(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8),
                    child: Text(
                      detail!,
                      style: styles.body.copyWith(color: colors.secondaryText),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ?trailing,
              if (showChevron)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 6),
                  child: Icon(CupertinoIcons.chevron_forward, size: 17, color: colors.tertiaryText),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A grouped row with a switch.
class SwitchRow extends StatelessWidget {
  const SwitchRow({super.key, required this.title, required this.value, required this.onChanged, this.subtitle});

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GroupedRow(
      title: title,
      subtitle: subtitle,
      chevron: false,
      onTap: () => onChanged(!value),
      trailing: Semantics(
        label: title,
        child: CupertinoSwitch(value: value, activeTrackColor: LoupeColors.of(context).success, onChanged: onChanged),
      ),
    );
  }
}

/// A grouped page: grouped background, a [LoupeTitleBar] and slivers.
class GroupedPage extends StatelessWidget {
  const GroupedPage({super.key, required this.title, required this.children, this.trailing, this.bottomBar});

  final String title;
  final Widget? trailing;
  final List<Widget> children;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return Scaffold(
      backgroundColor: colors.groupedBackground,
      bottomNavigationBar: bottomBar,
      body: CustomScrollView(
        slivers: [
          LoupeTitleBar(title: title, trailing: [?trailing]),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          ...children.map((c) => SliverToBoxAdapter(child: c)),
          SliverToBoxAdapter(child: SizedBox(height: 24 + MediaQuery.paddingOf(context).bottom)),
        ],
      ),
    );
  }
}
