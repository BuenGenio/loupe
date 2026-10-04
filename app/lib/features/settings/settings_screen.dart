import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';

import '../../providers.dart';
import '../../router.dart';
import '../../settings/app_settings.dart';
import '../../shared/grouped_list.dart';
import '../../theme/theme.dart';
import '../conversation/security/security_provider.dart';
import 'settings_widgets.dart';
import '../../theme/loupe_icons.dart';

String swipeActionLabel(SwipeAction a) => switch (a) {
  SwipeAction.none => 'None',
  SwipeAction.toggleRead => 'Mark as Read',
  SwipeAction.toggleFlag => 'Flag',
  SwipeAction.archive => 'Archive',
  SwipeAction.trash => 'Trash',
  SwipeAction.move => 'Move Message',
  SwipeAction.more => 'More',
};

String readerModeLabel(ReaderMode m) => switch (m) {
  ReaderMode.readable => 'Readable',
  ReaderMode.original => 'Original',
  ReaderMode.plain => 'Plain Text',
};

String undoDelayLabel(int seconds) => seconds == 0 ? 'Off' : '$seconds seconds';

/// Settings, Essentials first; power options live under Advanced.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final settings = ref.watch(appSettingsProvider);
    final controller = ref.read(appSettingsProvider.notifier);
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];

    return GroupedPage(
      title: 'Settings',
      children: [
        InsetGroup(
          header: 'Accounts',
          separatorIndent: 58,
          children: [
            for (final a in accounts)
              GroupedRow(
                key: ValueKey(a.id),
                leading: Container(
                  width: 29,
                  height: 29,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: colors.accountColor(a.colorIndex), shape: BoxShape.circle),
                  child: Text(
                    a.displayName.isEmpty ? '?' : a.displayName.characters.first.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
                title: a.displayName,
                subtitle: a.email,
                onTap: () => context.push(Routes.accountSettings(a.id)),
              ),
            GroupedRow(
              leading: Icon(LoupeIcons.add, color: colors.unreadDot, size: 26),
              title: 'Add Account',
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              chevron: false,
              onTap: () => context.push(Routes.addAccount),
            ),
          ],
        ),
        InsetGroup(
          header: 'Mail',
          separatorIndent: 58,
          children: [
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.swipeActions, colors.swipeArchive),
              title: 'Swipe Actions',
              onTap: () => context.push(Routes.swipeSettings),
            ),
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.conversations, colors.unreadDot),
              title: 'Organize by Conversation',
              chevron: false,
              onTap: () => controller.update((s) => s.copyWith(threaded: !s.threaded)),
              trailing: CupertinoSwitch(
                value: settings.threaded,
                activeTrackColor: colors.success,
                onChanged: (v) => controller.update((s) => s.copyWith(threaded: v)),
              ),
            ),
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.undoSend, colors.flag),
              title: 'Undo Send Delay',
              detail: undoDelayLabel(settings.undoSendSeconds),
              onTap: () => ChoicePage.push<int>(
                context,
                title: 'Undo Send Delay',
                footer: 'Sent messages wait this long, so you can take them back.',
                selected: settings.undoSendSeconds,
                choices: [
                  for (final s in const [0, 5, 10, 20, 30]) (value: s, label: undoDelayLabel(s), detail: null),
                ],
                onSelected: (v) => controller.update((s) => s.copyWith(undoSendSeconds: v)),
              ),
            ),
          ],
        ),
        InsetGroup(
          header: 'Appearance',
          separatorIndent: 16,
          children: [
            SegmentedRow<ThemeMode>(
              title: 'Theme',
              value: settings.themeMode,
              segments: const {ThemeMode.system: 'Automatic', ThemeMode.light: 'Light', ThemeMode.dark: 'Dark'},
              onChanged: (v) => controller.update((s) => s.copyWith(themeMode: v)),
            ),
            SegmentedRow<Density>(
              title: 'Message List',
              value: settings.density,
              segments: const {Density.comfortable: 'Comfortable', Density.compact: 'Compact'},
              onChanged: (v) => controller.update((s) => s.copyWith(density: v)),
            ),
          ],
        ),
        InsetGroup(
          header: 'Reading',
          separatorIndent: 58,
          footer: 'Remote images can tell senders when and where you opened a message.',
          children: [
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.readerView, colors.success),
              title: 'Default View',
              detail: readerModeLabel(settings.defaultReaderMode),
              onTap: () => ChoicePage.push<ReaderMode>(
                context,
                title: 'Default View',
                selected: settings.defaultReaderMode,
                footer: 'You can switch any message with the Aa button.',
                choices: const [
                  (value: ReaderMode.readable, label: 'Readable', detail: 'Clean, legible, follows dark mode'),
                  (value: ReaderMode.original, label: 'Original', detail: 'Exactly as the sender designed it'),
                  (value: ReaderMode.plain, label: 'Plain Text', detail: 'Just the words'),
                ],
                onSelected: (v) => controller.update((s) => s.copyWith(defaultReaderMode: v)),
              ),
            ),
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.font, colors.swipeMore),
              title: 'Plain Text Font',
              detail: settings.plainFont == PlainTextFont.mono ? 'Monospaced' : 'Sans Serif',
              onTap: () => ChoicePage.push<PlainTextFont>(
                context,
                title: 'Plain Text Font',
                selected: settings.plainFont,
                choices: const [
                  (value: PlainTextFont.sans, label: 'Sans Serif', detail: null),
                  (value: PlainTextFont.mono, label: 'Monospaced', detail: 'Keeps ASCII art and tables aligned'),
                ],
                onSelected: (v) => controller.update((s) => s.copyWith(plainFont: v)),
              ),
            ),
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.images, colors.unreadDot),
              title: 'Load Remote Images',
              chevron: false,
              onTap: () => controller.update((s) => s.copyWith(loadRemoteImages: !s.loadRemoteImages)),
              trailing: CupertinoSwitch(
                value: settings.loadRemoteImages,
                activeTrackColor: colors.success,
                onChanged: (v) => controller.update((s) => s.copyWith(loadRemoteImages: v)),
              ),
            ),
            GroupedRow(
              key: const Key('open-links-directly'),
              leading: SettingsIcon(LoupeIcons.openDirectly, colors.swipeArchive),
              title: 'Open Links Directly',
              subtitle: 'Skip click trackers when the destination is known',
              chevron: false,
              onTap: () => ref.read(openLinksDirectlyProvider.notifier).set(!ref.read(openLinksDirectlyProvider)),
              trailing: CupertinoSwitch(
                value: ref.watch(openLinksDirectlyProvider),
                activeTrackColor: colors.success,
                onChanged: (v) => ref.read(openLinksDirectlyProvider.notifier).set(v),
              ),
            ),
          ],
        ),
        InsetGroup(
          separatorIndent: 58,
          children: [
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.notifications, colors.swipeTrash),
              title: 'Notifications',
              onTap: () => context.push(Routes.notificationSettings),
            ),
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.settings, colors.swipeMore),
              title: 'Advanced',
              onTap: () => context.push(Routes.advancedSettings),
            ),
          ],
        ),
      ],
    );
  }
}
