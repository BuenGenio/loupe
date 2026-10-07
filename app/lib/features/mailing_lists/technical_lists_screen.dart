import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/grouped_list.dart';
import '../../theme/theme.dart';
import '../conversation/reader_prefs.dart';
import '../subscriptions/subscription_providers.dart';

/// Settings › Reading › Technical Lists: mailing lists whose messages open
/// as plain text in Mono (with patches shown as diffs) unless the sender
/// has its own remembered view.
class TechnicalListsScreen extends ConsumerWidget {
  const TechnicalListsScreen({super.key});

  static Future<void> push(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const TechnicalListsScreen()));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final lists = ref.watch(discussionsProvider);
    final technical = ref.watch(readerPrefsProvider.select((p) => p.technicalLists));
    // Lists marked before but without mail on the phone now stay listed.
    final known = {for (final l in lists) l.listId!};
    final rows = [
      for (final l in lists) (id: l.listId!, name: l.name),
      for (final id in technical.toList()..sort())
        if (!known.contains(id)) (id: id, name: id),
    ];
    final controller = ref.read(readerPrefsProvider.notifier);
    return GroupedPage(
      title: 'Technical Lists',
      children: [
        InsetGroup(
          separatorIndent: 16,
          footer: rows.isEmpty
              ? 'Mailing lists appear here once their mail arrives.'
              : 'Messages from these lists open as plain text in a monospaced font, with patches shown as '
                    'diffs. The Aa button still switches any message.',
          children: [
            for (final r in rows)
              GroupedRow(
                key: ValueKey(r.id),
                title: r.name,
                subtitle: r.name == r.id ? null : r.id,
                chevron: false,
                onTap: () => controller.setTechnicalList(r.id, technical: !technical.contains(r.id)),
                trailing: CupertinoSwitch(
                  value: technical.contains(r.id),
                  activeTrackColor: colors.success,
                  onChanged: (v) => controller.setTechnicalList(r.id, technical: v),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
