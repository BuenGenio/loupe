import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Background of a row in a grouped list: white, or #1C1C1E in dark mode
/// (iOS secondarySystemGroupedBackground).
Color groupFill(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark ? const Color(0xFF1C1C1E) : Theme.of(context).colorScheme.surface;

/// A subtle fill for tiles and banners on the plain background: #F2F2F7, or
/// #1C1C1E in dark mode.
Color subtleFill(BuildContext context) => Theme.of(context).brightness == Brightness.dark
    ? const Color(0xFF1C1C1E)
    : LoupeColors.of(context).groupedBackground;

/// One choice of [showActionSheet].
final class SheetAction<T> {
  const SheetAction(this.label, this.value, {this.destructive = false, this.isDefault = false});
  final String label;
  final T value;

  /// Shown in red (Delete Draft, Delete).
  final bool destructive;

  /// Shown in bold.
  final bool isDefault;
}

/// An iOS-style action sheet. Returns the chosen value, or null for Cancel.
Future<T?> showActionSheet<T>(
  BuildContext context, {
  String? title,
  String? message,
  required List<SheetAction<T>> actions,
  String cancelLabel = 'Cancel',
}) => showCupertinoModalPopup<T>(
  context: context,
  builder: (context) => CupertinoActionSheet(
    title: title == null ? null : Text(title),
    message: message == null ? null : Text(message),
    actions: [
      for (final a in actions)
        CupertinoActionSheetAction(
          isDestructiveAction: a.destructive,
          isDefaultAction: a.isDefault,
          onPressed: () => Navigator.of(context).pop(a.value),
          child: Text(a.label),
        ),
    ],
    cancelButton: CupertinoActionSheetAction(
      isDefaultAction: true,
      onPressed: () => Navigator.of(context).pop(),
      child: Text(cancelLabel),
    ),
  ),
);

/// A rounded bottom sheet with a drag handle, sized to its content. Unless
/// [dismissible], it has no handle and closes only from its own buttons
/// (and Back, if it lets it).
Future<T?> showLoupeSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool expand = false,
  bool dismissible = true,
}) => showModalBottomSheet<T>(
  context: context,
  useSafeArea: true,
  isScrollControlled: true,
  isDismissible: dismissible,
  enableDrag: dismissible,
  showDragHandle: dismissible,
  backgroundColor: LoupeColors.of(context).groupedBackground,
  builder: expand
      ? (context) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 1,
          builder: (context, controller) => PrimaryScrollController(controller: controller, child: builder(context)),
        )
      : builder,
);

/// A rounded group of rows on a grouped background, like an iOS inset list.
class SheetGroup extends StatelessWidget {
  const SheetGroup({super.key, required this.children, this.header});

  final List<Widget> children;
  final String? header;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) rows.add(Divider(indent: 52, color: colors.separator));
      rows.add(children[i]);
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
              child: Text(
                header!.toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(color: colors.secondaryText, letterSpacing: 0.4),
              ),
            ),
          Material(
            color: groupFill(context),
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: Column(mainAxisSize: MainAxisSize.min, children: rows),
          ),
        ],
      ),
    );
  }
}

/// One tappable row of a [SheetGroup].
class SheetRow extends StatelessWidget {
  const SheetRow({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.trailing,
    this.destructive = false,
    this.subtitle,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool destructive;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = destructive ? CupertinoColors.systemRed.resolveFrom(context) : null;
    return ListTile(
      dense: true,
      minLeadingWidth: 24,
      leading: icon == null ? null : Icon(icon, color: color ?? scheme.primary, size: 22),
      title: Text(label, style: TextStyle(fontSize: 16, color: color)),
      subtitle: subtitle == null ? null : Text(subtitle!, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: trailing,
      enabled: onTap != null,
      onTap: onTap,
    );
  }
}

/// Shows [message] in a floating SnackBar on [messenger].
void showSnack(ScaffoldMessengerState messenger, String message, {SnackBarAction? action, Duration? duration}) {
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
        behavior: SnackBarBehavior.floating,
        persist: false,
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
}
