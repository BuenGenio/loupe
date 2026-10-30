import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../router.dart';
import '../../settings/ui_state.dart';
import '../../shared/format.dart';
import '../../shared/grouped_list.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import 'matter_providers.dart';
import 'matter_sheets.dart';

/// The Mailboxes screen's Matters: each matter with how many conversations
/// it has and when it last had mail, the most recent first, then New
/// Matter…. Only for repositories that keep matters. Edit hides a matter
/// from the list as it hides a folder.
class MattersSection extends ConsumerWidget {
  const MattersSection({super.key, required this.editing});

  final bool editing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(mattersControllerProvider) == null) return const SizedBox.shrink();
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    final activity = ref.watch(matterActivityProvider).value ?? const <String, DateTime>{};
    DateTime latest(Matter m) => activity[m.id] ?? m.updatedAt;
    final matters = [...ref.watch(mattersProvider).value ?? const <Matter>[]]
      ..sort((a, b) => latest(b).compareTo(latest(a)));
    final hidden = ref.watch(hiddenMailboxItemsProvider);
    String key(Matter m) => 'matter.${m.id}';
    final rows = [
      for (final m in matters)
        if (editing || !hidden.contains(key(m)))
          GroupedRow(
            key: ValueKey(key(m)),
            leading: editing
                ? Icon(
                    hidden.contains(key(m)) ? LoupeIcons.unselected : LoupeIcons.selected,
                    color: hidden.contains(key(m)) ? colors.tertiaryText : colors.unreadDot,
                    semanticLabel: hidden.contains(key(m)) ? l10n.mailboxesHidden : l10n.mailboxesShown,
                  )
                : Icon(LoupeIcons.matter, color: colors.unreadDot),
            title: m.name,
            subtitle: l10n.mattersRowDetail(m.members.length),
            detail: activity[m.id] == null || editing ? null : formatListDate(activity[m.id]!, l10n: l10n),
            onTap: editing
                ? () => unawaited(ref.read(hiddenMailboxItemsProvider.notifier).toggle(key(m)))
                : () => context.push(Routes.matter(m.id)),
          ),
      if (!editing)
        GroupedRow(
          key: const Key('new-matter'),
          leading: Icon(LoupeIcons.add, color: colors.unreadDot),
          title: l10n.mattersNewMatter,
          chevron: false,
          onTap: () async {
            final created = await createMatter(context, ref);
            if (created != null && context.mounted) await context.push(Routes.matter(created.id));
          },
        ),
    ];
    if (rows.isEmpty) return const SizedBox.shrink();
    return InsetGroup(
      key: const Key('matters-section'),
      header: l10n.mattersTitle,
      largeHeader: true,
      footer: matters.isEmpty ? l10n.mattersEmptyFooter : null,
      children: rows,
    );
  }
}
