import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../settings/app_settings.dart';
import '../../shared/grouped_list.dart';
import '../../theme/theme.dart';
import '../../theme/loupe_icons.dart';

/// Settings › Language: the phone's language, or one of the languages Loupe
/// has, each by its own name. The app switches at once, this page too.
class LanguageSettingsScreen extends ConsumerWidget {
  const LanguageSettingsScreen({super.key});

  static Future<void> push(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const LanguageSettingsScreen()));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    final selected = ref.watch(appSettingsProvider.select((s) => s.language));
    final phone = resolveLocale(View.of(context).platformDispatcher.locales, AppLocalizations.supportedLocales);
    final codes = [for (final l in AppLocalizations.supportedLocales) l.languageCode]
      ..sort((a, b) => (languageNames[a] ?? a).compareTo(languageNames[b] ?? b));

    Widget row(String? code, String title, {String? subtitle}) => GroupedRow(
      key: Key('language-${code ?? 'phone'}'),
      title: title,
      subtitle: subtitle,
      chevron: false,
      trailing: code == selected
          ? Icon(LoupeIcons.check, color: colors.unreadDot, size: 22)
          : const SizedBox(width: 22),
      onTap: () => ref.read(appSettingsProvider.notifier).update((s) => s.copyWith(language: code)),
    );

    return GroupedPage(
      title: l10n.settingsLanguage,
      children: [
        InsetGroup(
          separatorIndent: 16,
          footer: l10n.settingsLanguageFooter,
          children: [row(null, l10n.settingsLanguageSystem, subtitle: languageNames[phone.languageCode])],
        ),
        InsetGroup(separatorIndent: 16, children: [for (final code in codes) row(code, languageNames[code] ?? code)]),
      ],
    );
  }
}
