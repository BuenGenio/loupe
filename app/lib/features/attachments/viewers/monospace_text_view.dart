import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../conversation/raw_source_screen.dart' show SourceLines;

/// Text as selectable monospace rows, wrapped or scrolling sideways.
///
/// Rows are built lazily ([SourceLines] splits the text), so multi-megabyte
/// files open and scroll smoothly, and a draggable scrollbar crosses them
/// quickly. The same structure as the message source screen: plain [Text]
/// rows in a [SelectionArea], so selection works without a nested scroll
/// view taking the drag.
class MonospaceTextView extends StatefulWidget {
  const MonospaceTextView({super.key, required this.lines, this.wrap = true, this.header});

  final SourceLines lines;
  final bool wrap;

  /// Shown above the text, outside the scroll view (a "showing the first
  /// 8 MB" note).
  final Widget? header;

  static const style = TextStyle(fontFamily: 'monospace', fontSize: 12.5, height: 1.35);

  /// Every row exactly one line high, whatever fallback fonts it uses.
  static const strut = StrutStyle(fontFamily: 'monospace', fontSize: 12.5, height: 1.35, forceStrutHeight: true);

  @override
  State<MonospaceTextView> createState() => _MonospaceTextViewState();
}

class _MonospaceTextViewState extends State<MonospaceTextView> {
  static const _padding = EdgeInsets.fromLTRB(12, 12, 16, 32);

  final _vertical = ScrollController();
  final _horizontal = ScrollController();

  @override
  void didUpdateWidget(MonospaceTextView old) {
    super.didUpdateWidget(old);
    if (old.wrap == widget.wrap || !_vertical.hasClients) return;
    // Keep roughly the same place in the text: rows change height.
    final p = _vertical.position;
    final fraction = p.maxScrollExtent <= 0 ? 0.0 : p.pixels / p.maxScrollExtent;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_vertical.hasClients) return;
      final p = _vertical.position;
      _vertical.jumpTo((fraction * p.maxScrollExtent).clamp(0.0, p.maxScrollExtent));
      if (widget.wrap && _horizontal.hasClients) _horizontal.jumpTo(0);
    });
  }

  @override
  void dispose() {
    _vertical.dispose();
    _horizontal.dispose();
    super.dispose();
  }

  /// The width of one character of the monospace font.
  static double _cellWidth(TextScaler textScaler) {
    final painter = TextPainter(
      text: const TextSpan(text: 'MMMMMMMMMM', style: MonospaceTextView.style),
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
    )..layout();
    final width = painter.width / 10;
    painter.dispose();
    return width;
  }

  @override
  Widget build(BuildContext context) {
    final rows = widget.lines.rows;
    final wrap = widget.wrap;
    final cellWidth = _cellWidth(MediaQuery.textScalerOf(context));
    final padding = _padding.copyWith(bottom: _padding.bottom + MediaQuery.paddingOf(context).bottom);

    final list = ListView.builder(
      key: const Key('text-list'),
      controller: _vertical,
      padding: padding,
      itemCount: rows.length,
      // Unwrapped, every row is one line: fixed extents keep long files
      // cheap and the scrollbar exact.
      prototypeItem: wrap ? null : const Text('M', style: MonospaceTextView.style, strutStyle: MonospaceTextView.strut),
      itemBuilder: (context, i) =>
          Text(rows[i], style: MonospaceTextView.style, strutStyle: MonospaceTextView.strut, softWrap: wrap),
    );

    // The same structure in both modes, so the list keeps its position.
    final content = LayoutBuilder(
      builder: (context, constraints) {
        final unwrapped = (widget.lines.columns + 1) * cellWidth + padding.horizontal;
        final width = wrap ? constraints.maxWidth : math.max(constraints.maxWidth, unwrapped);
        return Scrollbar(
          controller: _horizontal,
          thumbVisibility: !wrap,
          interactive: true,
          notificationPredicate: (n) => n.metrics.axis == Axis.horizontal,
          child: SingleChildScrollView(
            controller: _horizontal,
            scrollDirection: Axis.horizontal,
            physics: wrap ? const NeverScrollableScrollPhysics() : null,
            child: SizedBox(width: width, height: constraints.maxHeight, child: list),
          ),
        );
      },
    );

    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ?widget.header,
          Expanded(
            child: Scrollbar(
              key: const Key('text-scrollbar'),
              controller: _vertical,
              thumbVisibility: true,
              interactive: true,
              thickness: 6,
              radius: const Radius.circular(3),
              notificationPredicate: (n) => n.metrics.axis == Axis.vertical,
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}
