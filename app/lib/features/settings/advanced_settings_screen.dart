import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
    final ok = await confirmDestructive(
      context,
      title: 'Reset Loupe?',
      message: 'This forgets every setting, smart mailbox and recent search, and returns to the welcome screen.',
      action: 'Reset App',
    );
    if (ok) await ref.read(appModeProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(appModeProvider);
    return GroupedPage(
      title: 'Advanced',
      children: [
        InsetGroup(
          header: 'Demo',
          footer: 'Demo mail is a made-up mailbox that lives only on this phone. Nothing is sent anywhere.',
          separatorIndent: 16,
          children: [
            SwitchRow(
              title: 'Demo Mode',
              value: mode == AppMode.demo,
              onChanged: (on) => ref.read(appModeProvider.notifier).set(on ? AppMode.demo : AppMode.none),
            ),
          ],
        ),
        InsetGroup(
          footer: 'Forgets all settings and returns to the welcome screen.',
          separatorIndent: 16,
          children: [GroupedRow(title: 'Reset App', destructive: true, onTap: _reset)],
        ),
        InsetGroup(
          header: 'About',
          separatorIndent: 16,
          children: [
            FutureBuilder<PackageInfo?>(
              future: _info,
              builder: (context, snapshot) {
                final info = snapshot.data;
                return GroupedRow(
                  title: 'Version',
                  chevron: false,
                  detail: info == null ? '…' : '${info.version} (${info.buildNumber})',
                );
              },
            ),
            GroupedRow(
              title: 'Licences',
              onTap: () async {
                final info = await _info;
                if (!context.mounted) return;
                showLicensePage(
                  context: context,
                  applicationName: 'Loupe',
                  applicationVersion: info?.version,
                  applicationIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset('assets/icon/icon_rounded.png', width: 64, height: 64),
                  ),
                );
              },
            ),
            GroupedRow(
              title: 'Privacy',
              subtitle: 'Loupe has no analytics and no tracking. Your mail goes only to your mail servers.',
              leading: Icon(LoupeIcons.privacy, color: LoupeColors.of(context).success),
              chevron: false,
            ),
          ],
        ),
      ],
    );
  }
}
