import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/app_settings.dart';
import '../../shared/grouped_list.dart';
import '../../theme/theme.dart';
import 'settings_screen.dart';
import '../../theme/loupe_icons.dart';

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
    SwipeAction.more,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final settings = ref.watch(appSettingsProvider);
    final controller = ref.read(appSettingsProvider.notifier);

    Widget group(String header, String footer, SwipeAction current, AppSettings Function(SwipeAction) apply) {
      return InsetGroup(
        header: header,
        footer: footer,
        separatorIndent: 16,
        children: [
          for (final option in _options)
            GroupedRow(
              title: option == SwipeAction.toggleRead ? 'Mark as Read / Unread' : swipeActionLabel(option),
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
      title: 'Swipe Actions',
      children: [
        group(
          'Swipe Left',
          'A full swipe runs this action. Flag and More are always one short swipe away.',
          settings.swipeTrailing,
          (a) => settings.copyWith(swipeTrailing: a),
        ),
        group(
          'Swipe Right',
          'A full swipe runs this action.',
          settings.swipeLeading,
          (a) => settings.copyWith(swipeLeading: a),
        ),
      ],
    );
  }
}
