import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readable/readable.dart';

import '../../l10n/l10n.dart';
import '../../theme/theme.dart';
import 'sheets.dart';

/// Opens the "Aa" sheet. Every change is reported at once through
/// [onChanged], so the message behind the sheet updates live.
///
/// [brief] adds Brief to the views: whether the message shows its Brief, or
/// null when Brief isn't offered. [onBrief] hears true when Brief is picked,
/// false when another view is.
Future<void> showReaderOptionsSheet(
  BuildContext context, {
  required ReaderSettings initial,
  required bool remembered,
  required String? senderName,
  required ValueChanged<ReaderSettings> onChanged,
  required ValueChanged<bool> onRememberChanged,
  bool? brief,
  ValueChanged<bool>? onBrief,
}) => showLoupeSheet<void>(
  context,
  builder: (context) => ReaderOptionsSheet(
    initial: initial,
    remembered: remembered,
    senderName: senderName,
    onChanged: onChanged,
    onRememberChanged: onRememberChanged,
    brief: brief,
    onBrief: onBrief,
  ),
);

/// The views of the sheet's first control: the reader's modes, and Brief.
enum _View {
  readable(ReaderMode.readable),
  original(ReaderMode.original),
  plain(ReaderMode.plain),
  brief(null);

  const _View(this.mode);
  final ReaderMode? mode;
}

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
    this.brief,
    this.onBrief,
  });

  final ReaderSettings initial;
  final bool remembered;
  final String? senderName;
  final ValueChanged<ReaderSettings> onChanged;
  final ValueChanged<bool> onRememberChanged;

  /// Whether the message shows its Brief; null when Brief isn't offered.
  final bool? brief;

  /// True when Brief is picked, false when another view is.
  final ValueChanged<bool>? onBrief;

  @override
  State<ReaderOptionsSheet> createState() => _ReaderOptionsSheetState();
}

class _ReaderOptionsSheetState extends State<ReaderOptionsSheet> {
  late ReaderSettings _settings = widget.initial;
  late bool _remember = widget.remembered;
  late bool _brief = widget.brief ?? false;

  void _set(ReaderSettings s) {
    setState(() => _settings = s);
    widget.onChanged(s);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final s = _settings;
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: CupertinoSlidingSegmentedControl<_View>(
              key: const Key('reader-mode'),
              groupValue: _brief ? _View.brief : _View.values.firstWhere((v) => v.mode == s.mode),
              onValueChanged: (v) {
                if (v == null) return;
                final mode = v.mode;
                setState(() => _brief = mode == null);
                widget.onBrief?.call(mode == null);
                if (mode != null) _set(s.copyWith(mode: mode));
              },
              children: {
                _View.readable: _Segment(l10n.conversationReaderReadable),
                _View.original: _Segment(l10n.conversationReaderOriginal),
                _View.plain: _Segment(l10n.conversationReaderPlain),
                if (widget.brief != null) _View.brief: _Segment(l10n.briefReaderView),
              },
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 180),
            child: s.mode == ReaderMode.plain && !_brief
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: CupertinoSlidingSegmentedControl<PlainTextFont>(
                      key: const Key('reader-font'),
                      groupValue: s.plainFont,
                      onValueChanged: (f) {
                        if (f != null) _set(s.copyWith(plainFont: f));
                      },
                      children: {
                        PlainTextFont.sans: _Segment(l10n.conversationReaderSans),
                        PlainTextFont.mono: _Segment(l10n.conversationReaderMono, mono: true),
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
                        label: NumberFormat.percentPattern().format(s.textScale),
                        onChanged: (v) => _set(s.copyWith(textScale: v)),
                      ),
                    ),
                    Text('A', style: theme.textTheme.titleLarge),
                  ],
                ),
              ),
              SwitchListTile.adaptive(
                dense: true,
                title: Text(l10n.conversationReaderKeepColours, style: const TextStyle(fontSize: 16)),
                value: s.keepOriginalColors,
                onChanged: s.mode == ReaderMode.readable && !_brief
                    ? (v) => _set(s.copyWith(keepOriginalColors: v))
                    : null,
              ),
            ],
          ),
          SheetGroup(
            children: [
              SwitchListTile.adaptive(
                key: const Key('reader-remember'),
                dense: true,
                title: Text(l10n.conversationReaderRemember, style: const TextStyle(fontSize: 16)),
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
    // Four views share a phone's width: a long word shrinks rather than breaks.
    child: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(label, maxLines: 1, style: TextStyle(fontSize: 14, fontFamily: mono ? 'monospace' : null)),
    ),
  );
}
