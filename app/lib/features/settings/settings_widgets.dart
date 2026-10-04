import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/grouped_list.dart';
import '../../theme/theme.dart';

/// The coloured rounded-square icon of iOS Settings rows.
class SettingsIcon extends StatelessWidget {
  const SettingsIcon(this.icon, this.color, {super.key});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 29,
      height: 29,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(7)),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}

/// One option of a [ChoicePage].
typedef Choice<T> = ({T value, String label, String? detail});

/// An iOS-style list of options with a checkmark; picking one applies it at
/// once and keeps the page open.
class ChoicePage<T> extends StatefulWidget {
  const ChoicePage({
    super.key,
    required this.title,
    required this.choices,
    required this.selected,
    required this.onSelected,
    this.footer,
  });

  final String title;
  final List<Choice<T>> choices;
  final T selected;
  final ValueChanged<T> onSelected;
  final String? footer;

  static Future<void> push<T>(
    BuildContext context, {
    required String title,
    required List<Choice<T>> choices,
    required T selected,
    required ValueChanged<T> onSelected,
    String? footer,
  }) => Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) =>
          ChoicePage<T>(title: title, choices: choices, selected: selected, onSelected: onSelected, footer: footer),
    ),
  );

  @override
  State<ChoicePage<T>> createState() => _ChoicePageState<T>();
}

class _ChoicePageState<T> extends State<ChoicePage<T>> {
  late T _selected = widget.selected;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return GroupedPage(
      title: widget.title,
      children: [
        InsetGroup(
          separatorIndent: 16,
          footer: widget.footer,
          children: [
            for (final c in widget.choices)
              GroupedRow(
                title: c.label,
                subtitle: c.detail,
                chevron: false,
                trailing: c.value == _selected
                    ? Icon(CupertinoIcons.checkmark_alt, color: colors.unreadDot, size: 22)
                    : const SizedBox(width: 22),
                onTap: () {
                  setState(() => _selected = c.value);
                  widget.onSelected(c.value);
                },
              ),
          ],
        ),
      ],
    );
  }
}

/// A grouped row with a segmented control on the right (theme, density).
class SegmentedRow<T extends Object> extends StatelessWidget {
  const SegmentedRow({
    super.key,
    required this.title,
    required this.value,
    required this.segments,
    required this.onChanged,
  });

  final String title;
  final T value;
  final Map<T, String> segments;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: styles.body),
          const SizedBox(height: 8),
          CupertinoSlidingSegmentedControl<T>(
            groupValue: value,
            onValueChanged: (v) {
              if (v != null) onChanged(v);
            },
            children: {
              for (final MapEntry(:key, value: label) in segments.entries)
                key: Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Text(label)),
            },
          ),
        ],
      ),
    );
  }
}
