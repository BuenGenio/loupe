import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../settings/app_settings.dart';
import '../../settings/ui_state.dart';
import '../../shared/grouped_list.dart';
import '../../theme/theme.dart';
import '../app_lock/app_lock.dart';
import '../app_lock/app_lock_settings.dart';
import '../app_lock/device_authenticator.dart';
import '../conversation/reader_prefs.dart';
import '../conversation/security/security_provider.dart';
import '../mailing_lists/technical_lists_screen.dart';
import '../search/smart_mailbox_settings_screen.dart';
import 'settings_widgets.dart';
import '../../theme/loupe_icons.dart';

String _readerModeLabel(AppLocalizations l10n, ReaderMode m) => switch (m) {
  ReaderMode.readable => l10n.settingsViewReadable,
  ReaderMode.original => l10n.settingsViewOriginal,
  ReaderMode.plain => l10n.settingsViewPlain,
};

String _undoDelayLabel(AppLocalizations l10n, int seconds) =>
    seconds == 0 ? l10n.commonOff : l10n.settingsUndoSendSeconds(seconds);

/// App Lock's switch. Turning it on asks the user to prove it's them first,
/// and needs a screen lock to check against; the switch stays off until then.
Future<void> _setAppLock(BuildContext context, WidgetRef ref, bool on) async {
  if (!on) return ref.read(appLockSettingsProvider.notifier).setEnabled(false);
  final l10n = context.l10n;
  final result = await ref.read(appLockProvider.notifier).enable();
  if (!context.mounted) return;
  if (result == AuthResult.unavailable) return _explainScreenLock(context, ref);
  if (lockFailureText(result) case final reason?) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.settingsAppLockStillOff(reason))));
  }
}

/// Why App Lock can't be turned on: the phone has no screen lock.
Future<void> _explainScreenLock(BuildContext context, WidgetRef ref) {
  // The system, not the look: the wording and the way to fix it differ.
  final ios = defaultTargetPlatform == TargetPlatform.iOS;
  final l10n = context.l10n;
  return showCupertinoDialog<void>(
    context: context,
    builder: (dialog) => CupertinoAlertDialog(
      title: Text(ios ? l10n.settingsScreenLockTitleIos : l10n.settingsScreenLockTitleAndroid),
      content: Text(ios ? l10n.settingsScreenLockTextIos : l10n.settingsScreenLockTextAndroid),
      actions: [
        if (!ios)
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(dialog).pop();
              unawaited(ref.read(openScreenLockSettingsProvider)());
            },
            child: Text(l10n.settingsOpenSystemSettings),
          ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.of(dialog).pop(),
          child: Text(l10n.commonOk),
        ),
      ],
    ),
  );
}

/// Settings, Essentials first; power options live under Advanced.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final settings = ref.watch(appSettingsProvider);
    final controller = ref.read(appSettingsProvider.notifier);
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
    final appLock = ref.watch(appLockSettingsProvider);
    final l10n = context.l10n;

    return GroupedPage(
      title: l10n.commonSettings,
      children: [
        InsetGroup(
          header: l10n.settingsAccountsHeader,
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
              title: l10n.settingsAddAccount,
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              chevron: false,
              onTap: () => context.push(Routes.addAccount),
            ),
          ],
        ),
        InsetGroup(
          header: l10n.settingsMailHeader,
          separatorIndent: 58,
          children: [
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.swipeActions, colors.swipeArchive),
              title: l10n.settingsSwipeActions,
              onTap: () => context.push(Routes.swipeSettings),
            ),
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.conversations, colors.unreadDot),
              title: l10n.settingsThreaded,
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
              title: l10n.settingsUndoSendDelay,
              detail: _undoDelayLabel(l10n, settings.undoSendSeconds),
              onTap: () => ChoicePage.push<int>(
                context,
                title: l10n.settingsUndoSendDelay,
                footer: l10n.settingsUndoSendDelayFooter,
                selected: settings.undoSendSeconds,
                choices: [
                  for (final s in const [0, 5, 10, 20, 30]) (value: s, label: _undoDelayLabel(l10n, s), detail: null),
                ],
                onSelected: (v) => controller.update((s) => s.copyWith(undoSendSeconds: v)),
              ),
            ),
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.smartMailbox, colors.swipeArchive),
              title: l10n.settingsSmartMailboxes,
              detail: SmartMailboxSettingsScreen.syncViaLabel(ref.watch(smartMailboxHomeProvider), accounts),
              onTap: () => SmartMailboxSettingsScreen.push(context),
            ),
          ],
        ),
        InsetGroup(
          header: l10n.settingsAppearanceHeader,
          separatorIndent: 16,
          children: [
            SegmentedRow<ThemeMode>(
              title: l10n.settingsTheme,
              value: settings.themeMode,
              segments: {
                ThemeMode.system: l10n.settingsThemeSystem,
                ThemeMode.light: l10n.settingsThemeLight,
                ThemeMode.dark: l10n.settingsThemeDark,
              },
              onChanged: (v) => controller.update((s) => s.copyWith(themeMode: v)),
            ),
            SegmentedRow<Density>(
              title: l10n.settingsDensity,
              value: settings.density,
              segments: {
                Density.comfortable: l10n.settingsDensityComfortable,
                Density.compact: l10n.settingsDensityCompact,
              },
              onChanged: (v) => controller.update((s) => s.copyWith(density: v)),
            ),
          ],
        ),
        InsetGroup(
          header: l10n.settingsReadingHeader,
          separatorIndent: 58,
          footer: l10n.settingsReadingFooter,
          children: [
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.readerView, colors.success),
              title: l10n.settingsDefaultView,
              detail: _readerModeLabel(l10n, settings.defaultReaderMode),
              onTap: () => ChoicePage.push<ReaderMode>(
                context,
                title: l10n.settingsDefaultView,
                selected: settings.defaultReaderMode,
                footer: l10n.settingsDefaultViewFooter,
                choices: [
                  (
                    value: ReaderMode.readable,
                    label: l10n.settingsViewReadable,
                    detail: l10n.settingsViewReadableDetail,
                  ),
                  (
                    value: ReaderMode.original,
                    label: l10n.settingsViewOriginal,
                    detail: l10n.settingsViewOriginalDetail,
                  ),
                  (value: ReaderMode.plain, label: l10n.settingsViewPlain, detail: l10n.settingsViewPlainDetail),
                ],
                onSelected: (v) => controller.update((s) => s.copyWith(defaultReaderMode: v)),
              ),
            ),
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.font, colors.swipeMore),
              title: l10n.settingsPlainTextFont,
              detail: settings.plainFont == PlainTextFont.mono ? l10n.settingsFontMono : l10n.settingsFontSans,
              onTap: () => ChoicePage.push<PlainTextFont>(
                context,
                title: l10n.settingsPlainTextFont,
                selected: settings.plainFont,
                choices: [
                  (value: PlainTextFont.sans, label: l10n.settingsFontSans, detail: null),
                  (value: PlainTextFont.mono, label: l10n.settingsFontMono, detail: l10n.settingsFontMonoDetail),
                ],
                onSelected: (v) => controller.update((s) => s.copyWith(plainFont: v)),
              ),
            ),
            GroupedRow(
              key: const Key('technical-lists'),
              leading: SettingsIcon(LoupeIcons.mailingList, colors.swipeTrash),
              title: l10n.settingsTechnicalLists,
              detail: switch (ref.watch(readerPrefsProvider).technicalLists.length) {
                0 => l10n.commonNone,
                final n => '$n',
              },
              onTap: () => TechnicalListsScreen.push(context),
            ),
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.images, colors.unreadDot),
              title: l10n.settingsLoadRemoteImages,
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
              title: l10n.settingsOpenLinksDirectly,
              subtitle: l10n.settingsOpenLinksDirectlyDetail,
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
          header: l10n.settingsSecurityHeader,
          separatorIndent: 58,
          footer: appLock.enabled ? l10n.settingsAppLockFooterOn : l10n.settingsAppLockFooterOff,
          children: [
            GroupedRow(
              key: const Key('app-lock'),
              leading: SettingsIcon(LoupeIcons.appLock, colors.unreadDot),
              title: l10n.settingsAppLock,
              chevron: false,
              onTap: () => _setAppLock(context, ref, !appLock.enabled),
              trailing: CupertinoSwitch(
                value: appLock.enabled,
                activeTrackColor: colors.success,
                onChanged: (v) => _setAppLock(context, ref, v),
              ),
            ),
            if (appLock.enabled)
              GroupedRow(
                key: const Key('lock-after'),
                leading: SettingsIcon(LoupeIcons.lockAfter, colors.flag),
                title: l10n.settingsLockAfter,
                detail: appLock.lockAfter.label,
                onTap: () => ChoicePage.push<LockAfter>(
                  context,
                  title: l10n.settingsLockAfter,
                  footer: l10n.settingsLockAfterFooter,
                  selected: appLock.lockAfter,
                  choices: [for (final a in LockAfter.values) (value: a, label: a.label, detail: null)],
                  onSelected: (v) => ref.read(appLockSettingsProvider.notifier).setLockAfter(v),
                ),
              ),
          ],
        ),
        InsetGroup(
          separatorIndent: 58,
          children: [
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.notifications, colors.swipeTrash),
              title: l10n.settingsNotifications,
              onTap: () => context.push(Routes.notificationSettings),
            ),
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.rules, colors.vip),
              title: l10n.rulesTitle,
              onTap: () => context.push(Routes.rules),
            ),
            GroupedRow(
              key: const Key('encryption-settings'),
              leading: SettingsIcon(LoupeIcons.e2ee, colors.success),
              title: l10n.settingsEncryption,
              onTap: () => context.push(Routes.encryption),
            ),
            GroupedRow(
              leading: SettingsIcon(LoupeIcons.settings, colors.swipeMore),
              title: l10n.settingsAdvanced,
              onTap: () => context.push(Routes.advancedSettings),
            ),
          ],
        ),
      ],
    );
  }
}
