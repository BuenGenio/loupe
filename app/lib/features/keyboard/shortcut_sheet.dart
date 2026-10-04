import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'shortcuts.dart';

/// The keyboard shortcuts, grouped (Ctrl/⌘+/ or ?).
Future<void> showShortcutSheet(BuildContext context) => showDialog<void>(
  context: context,
  barrierColor: const Color(0x33000000),
  builder: (context) => const ShortcutSheet(),
);

class ShortcutSheet extends StatelessWidget {
  const ShortcutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final apple = appleKeyboard;
    final groups = <String, List<ShortcutEntry>>{};
    for (final e in shortcutTable) {
      groups.putIfAbsent(e.group, () => []).add(e);
    }
    return Dialog(
      backgroundColor: colors.cellBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 8, 6),
              child: Row(
                children: [
                  Expanded(child: Text('Keyboard Shortcuts', style: styles.navTitle)),
                  CupertinoButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                children: [
                  for (final MapEntry(key: group, value: entries) in groups.entries) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 4),
                      child: Text(group.toUpperCase(), style: styles.footnote.copyWith(letterSpacing: 0.2)),
                    ),
                    for (final e in entries)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text(e.label, style: styles.body)),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Wrap(
                                alignment: WrapAlignment.end,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 6,
                                runSpacing: 4,
                                children: [
                                  for (final (i, c) in e.combos.indexed) ...[
                                    if (i > 0) Text('or', style: styles.footnote),
                                    KeyCaps(c.keyLabels(apple: apple)),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Keys drawn as small caps, as on a keyboard: ⌘ N.
class KeyCaps extends StatelessWidget {
  const KeyCaps(this.keys, {super.key});

  final List<String> keys;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final style = LoupeTextStyles.of(context).footnote.copyWith(color: colors.label, fontWeight: FontWeight.w500);
    return Semantics(
      label: keys.join(' '),
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (i, k) in keys.indexed) ...[
            if (i > 0) const SizedBox(width: 3),
            Container(
              constraints: const BoxConstraints(minWidth: 22),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: colors.fill,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: colors.separator, width: 0.5),
              ),
              child: Text(k, style: style, textAlign: TextAlign.center),
            ),
          ],
        ],
      ),
    );
  }
}
