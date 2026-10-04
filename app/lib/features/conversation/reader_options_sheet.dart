import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readable/readable.dart';

import '../../theme/theme.dart';
import 'sheets.dart';

/// Opens the "Aa" sheet. Every change is reported at once through
/// [onChanged], so the message behind the sheet updates live.
Future<void> showReaderOptionsSheet(
  BuildContext context, {
  required ReaderSettings initial,
  required bool remembered,
  required String? senderName,
  required ValueChanged<ReaderSettings> onChanged,
  required ValueChanged<bool> onRememberChanged,
}) => showLoupeSheet<void>(
  context,
  builder: (context) => ReaderOptionsSheet(
    initial: initial,
    remembered: remembered,
    senderName: senderName,
    onChanged: onChanged,
    onRememberChanged: onRememberChanged,
  ),
);

/// The content of the "Aa" sheet: view mode, plain-text font, text size,
/// "Keep original colours" and "Remember for this sender".
class ReaderOptionsSheet extends StatefulWidget {
  const ReaderOptionsSheet({
    super.key,
    required this.initial,
    required this.remembered,
    required this.senderName,
    required this.onChanged,
    required this.onRememberChanged,
  });

  final ReaderSettings initial;
  final bool remembered;
  final String? senderName;
  final ValueChanged<ReaderSettings> onChanged;
  final ValueChanged<bool> onRememberChanged;

  @override
  State<ReaderOptionsSheet> createState() => _ReaderOptionsSheetState();
}

class _ReaderOptionsSheetState extends State<ReaderOptionsSheet> {
  late ReaderSettings _settings = widget.initial;
  late bool _remember = widget.remembered;

  void _set(ReaderSettings s) {
    setState(() => _settings = s);
    widget.onChanged(s);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    final s = _settings;
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: CupertinoSlidingSegmentedControl<ReaderMode>(
              key: const Key('reader-mode'),
              groupValue: s.mode,
              onValueChanged: (m) {
                if (m != null) _set(s.copyWith(mode: m));
              },
              children: const {
                ReaderMode.readable: _Segment('Readable'),
                ReaderMode.original: _Segment('Original'),
                ReaderMode.plain: _Segment('Plain'),
              },
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 180),
            child: s.mode == ReaderMode.plain
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: CupertinoSlidingSegmentedControl<PlainTextFont>(
                      key: const Key('reader-font'),
                      groupValue: s.plainFont,
                      onValueChanged: (f) {
                        if (f != null) _set(s.copyWith(plainFont: f));
                      },
                      children: const {
                        PlainTextFont.sans: _Segment('Sans'),
                        PlainTextFont.mono: _Segment('Mono', mono: true),
                      },
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
          SheetGroup(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    Text('A', style: theme.textTheme.bodySmall),
                    Expanded(
                      child: Slider.adaptive(
                        key: const Key('reader-text-size'),
                        value: s.textScale.clamp(0.8, 1.6),
                        min: 0.8,
                        max: 1.6,
                        divisions: 8,
                        label: '${(s.textScale * 100).round()}%',
                        onChanged: (v) => _set(s.copyWith(textScale: v)),
                      ),
                    ),
                    Text('A', style: theme.textTheme.titleLarge),
                  ],
                ),
              ),
              SwitchListTile.adaptive(
                dense: true,
                title: const Text('Keep original colours', style: TextStyle(fontSize: 16)),
                value: s.keepOriginalColors,
                onChanged: s.mode == ReaderMode.readable ? (v) => _set(s.copyWith(keepOriginalColors: v)) : null,
              ),
            ],
          ),
          SheetGroup(
            children: [
              SwitchListTile.adaptive(
                key: const Key('reader-remember'),
                dense: true,
                title: const Text('Remember for this sender', style: TextStyle(fontSize: 16)),
                subtitle: widget.senderName == null
                    ? null
                    : Text(widget.senderName!, style: TextStyle(color: colors.secondaryText)),
                value: _remember,
                onChanged: widget.senderName == null
                    ? null
                    : (v) {
                        setState(() => _remember = v);
                        widget.onRememberChanged(v);
                      },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment(this.label, {this.mono = false});
  final String label;
  final bool mono;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Text(label, style: TextStyle(fontSize: 14, fontFamily: mono ? 'monospace' : null)),
  );
}
