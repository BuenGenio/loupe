import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/app_settings.dart';
import '../../shared/grouped_list.dart';
import '../notifications/app_icon_badge.dart';
import 'settings_widgets.dart';

/// Settings › Notifications: the app icon badge for now; new-mail alerts
/// come with background sync.
class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  static const _syncNote =
      'The badge updates when Loupe syncs. Background sync arrives with notifications; '
      'until then the badge refreshes while Loupe is open.';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badge = ref.watch(appSettingsProvider.select((s) => s.appIconBadge));
    final controller = ref.read(appSettingsProvider.notifier);
    final supported = ref.watch(appIconBadgeSupportedProvider).value;
    return GroupedPage(
      title: 'Notifications',
      children: [
        InsetGroup(
          separatorIndent: 16,
          footer: supported == false
              ? 'This phone’s home screen doesn’t show numbers on app icons. $_syncNote'
              : _syncNote,
          children: [
            GroupedRow(
              title: 'App Icon Badge',
              detail: badgeCountLabel(badge),
              onTap: () => ChoicePage.push<BadgeCount>(
                context,
                title: 'App Icon Badge',
                selected: badge,
                footer: _syncNote,
                choices: [for (final c in BadgeCount.values) (value: c, label: badgeCountLabel(c), detail: null)],
                onSelected: (v) => controller.update((s) => s.copyWith(appIconBadge: v)),
              ),
            ),
          ],
        ),
        const InsetGroup(
          children: [GroupedRow(title: 'New Mail Alerts', detail: 'Coming Soon', enabled: false, chevron: false)],
        ),
      ],
    );
  }
}
