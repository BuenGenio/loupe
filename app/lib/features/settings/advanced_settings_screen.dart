import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../l10n/l10n.dart';
import '../../settings/app_mode.dart';
import '../../shared/grouped_list.dart';
import '../../shared/sheets.dart';
import '../../theme/theme.dart';
import '../../theme/loupe_icons.dart';

/// Demo mode, reset and About.
class AdvancedSettingsScreen extends ConsumerStatefulWidget {
  const AdvancedSettingsScreen({super.key});

  @override
  ConsumerState<AdvancedSettingsScreen> createState() => _AdvancedSettingsScreenState();
}

class _AdvancedSettingsScreenState extends ConsumerState<AdvancedSettingsScreen> {
  late final Future<PackageInfo?> _info = PackageInfo.fromPlatform().then<PackageInfo?>((i) => i, onError: (_) => null);

  Future<void> _reset() async {
    final l10n = context.l10n;
    final ok = await confirmDestructive(
      context,
      title: l10n.settingsResetTitle,
      message: l10n.settingsResetMessage,
      action: l10n.settingsResetApp,
    );
    if (ok) await ref.read(appModeProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(appModeProvider);
    final l10n = context.l10n;
    return GroupedPage(
      title: l10n.settingsAdvanced,
      children: [
        InsetGroup(
          header: l10n.settingsDemoHeader,
          footer: l10n.settingsDemoFooter,
          separatorIndent: 16,
          children: [
            SwitchRow(
              title: l10n.settingsDemoMode,
              value: mode == AppMode.demo,
              onChanged: (on) => ref.read(appModeProvider.notifier).set(on ? AppMode.demo : AppMode.none),
            ),
          ],
        ),
        InsetGroup(
          footer: l10n.settingsResetFooter,
          separatorIndent: 16,
          children: [GroupedRow(title: l10n.settingsResetApp, destructive: true, onTap: _reset)],
        ),
        InsetGroup(
          header: l10n.settingsAboutHeader,
          separatorIndent: 16,
          children: [
            FutureBuilder<PackageInfo?>(
              future: _info,
              builder: (context, snapshot) {
                final info = snapshot.data;
                return GroupedRow(
                  title: l10n.settingsVersion,
                  chevron: false,
                  detail: info == null ? '…' : '${info.version} (${info.buildNumber})',
                );
              },
            ),
            GroupedRow(
              title: l10n.settingsLicences,
              onTap: () async {
                final info = await _info;
                if (!context.mounted) return;
                showLicensePage(
                  context: context,
                  applicationName: 'Loupe', // l10n-ignore: the name
                  applicationVersion: info?.version,
                  applicationIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset('assets/icon/icon_rounded.png', width: 64, height: 64),
                  ),
                );
              },
            ),
            GroupedRow(
              title: l10n.settingsPrivacy,
              subtitle: l10n.settingsPrivacyDetail,
              leading: Icon(LoupeIcons.privacy, color: LoupeColors.of(context).success),
              chevron: false,
            ),
          ],
        ),
      ],
    );
  }
}
