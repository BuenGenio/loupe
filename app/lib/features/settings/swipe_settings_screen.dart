import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../settings/app_settings.dart';
import '../../shared/grouped_list.dart';
import '../../theme/theme.dart';
import '../../theme/loupe_icons.dart';

String _actionLabel(AppLocalizations l10n, SwipeAction a) => switch (a) {
  SwipeAction.none => l10n.commonNone,
  SwipeAction.toggleRead => l10n.settingsSwipeToggleRead,
  SwipeAction.toggleFlag => l10n.mailFlag,
  SwipeAction.archive => l10n.mailArchive,
  SwipeAction.trash => l10n.settingsSwipeTrash,
  SwipeAction.move => l10n.settingsSwipeMove,
  SwipeAction.snooze => l10n.settingsSwipeSnooze,
  SwipeAction.more => l10n.commonMore,
};

/// Which actions sit behind a message when it is swiped.
class SwipeSettingsScreen extends ConsumerWidget {
  const SwipeSettingsScreen({super.key});

  static const _options = [
    SwipeAction.none,
    SwipeAction.toggleRead,
    SwipeAction.toggleFlag,
    SwipeAction.archive,
    SwipeAction.trash,
    SwipeAction.move,
    SwipeAction.snooze,
    SwipeAction.more,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final settings = ref.watch(appSettingsProvider);
    final controller = ref.read(appSettingsProvider.notifier);
    final l10n = context.l10n;

    Widget group(String header, String footer, SwipeAction current, AppSettings Function(SwipeAction) apply) {
      return InsetGroup(
        header: header,
        footer: footer,
        separatorIndent: 16,
        children: [
          for (final option in _options)
            GroupedRow(
              title: _actionLabel(l10n, option),
              chevron: false,
              trailing: option == current
                  ? Icon(LoupeIcons.check, color: colors.unreadDot, size: 22)
                  : const SizedBox(width: 22),
              onTap: () => controller.update((_) => apply(option)),
            ),
        ],
      );
    }

    return GroupedPage(
      title: l10n.settingsSwipeActions,
      children: [
        group(
          l10n.settingsSwipeLeft,
          l10n.settingsSwipeLeftFooter,
          settings.swipeTrailing,
          (a) => settings.copyWith(swipeTrailing: a),
        ),
        group(
          l10n.settingsSwipeRight,
          l10n.settingsSwipeRightFooter,
          settings.swipeLeading,
          (a) => settings.copyWith(swipeLeading: a),
        ),
      ],
    );
  }
}
