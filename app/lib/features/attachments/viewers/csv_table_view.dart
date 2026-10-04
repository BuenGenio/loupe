import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../csv.dart';

final _numeric = RegExp(r'^[-+(]?[$€£¥]?\s?[\d.,\s]+%?\)?$');

/// A small CSV as a table: the first row as a pinned header, the rest in a
/// lazy list, scrolling sideways when the columns don't fit. Columns are as
/// wide as their widest cell, within limits; numbers align right.
class CsvTableView extends StatefulWidget {
  const CsvTableView({super.key, required this.data});

  final CsvData data;

  static const minColumnWidth = 48.0;
  static const maxColumnWidth = 260.0;
  static const cellPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 7);

  @override
  State<CsvTableView> createState() => _CsvTableViewState();
}

class _CsvTableViewState extends State<CsvTableView> {
  final _vertical = ScrollController();
  final _horizontal = ScrollController();
  List<double>? _widths;
  List<bool>? _numericColumns;
  TextScaler? _scaler;

  @override
  void didUpdateWidget(CsvTableView old) {
    super.didUpdateWidget(old);
    if (old.data != widget.data) _widths = null;
  }

  @override
  void dispose() {
    _vertical.dispose();
    _horizontal.dispose();
    super.dispose();
  }

  void _measure(TextStyle body, TextStyle header, TextScaler scaler) {
    final rows = widget.data.rows;
    final columns = widget.data.columns;
    final widths = <double>[];
    final numeric = <bool>[];
    for (var c = 0; c < columns; c++) {
      // Measure the longest cell only: the widest by far, and cheap.
      var longest = '';
      var numbers = 0, filled = 0;
      for (var r = 0; r < rows.length; r++) {
        final cell = c < rows[r].length ? rows[r][c] : '';
        if (cell.length > longest.length) longest = cell;
        if (r > 0 && cell.trim().isNotEmpty) {
          filled++;
          if (_numeric.hasMatch(cell.trim())) numbers++;
        }
      }
      final head = rows.isNotEmpty && c < rows.first.length ? rows.first[c] : '';
      double measure(String text, TextStyle style) {
        final p = TextPainter(
          text: TextSpan(text: text.split('\n').first, style: style),
          textDirection: TextDirection.ltr,
          textScaler: scaler,
          maxLines: 1,
        )..layout();
        final w = p.width;
        p.dispose();
        return w;
      }

      final w = math.max(measure(longest, body), measure(head, header)) + CsvTableView.cellPadding.horizontal + 1;
      widths.add(w.clamp(CsvTableView.minColumnWidth, CsvTableView.maxColumnWidth));
      numeric.add(filled > 0 && numbers / filled >= 0.8);
    }
    _widths = widths;
    _numericColumns = numeric;
    _scaler = scaler;
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final theme = Theme.of(context);
    final body = (theme.textTheme.bodyMedium ?? const TextStyle()).copyWith(fontSize: 14, height: 1.3);
    final header = body.copyWith(fontWeight: FontWeight.w600);
    final scaler = MediaQuery.textScalerOf(context);
    if (_widths == null || _scaler != scaler) _measure(body, header, scaler);
    final widths = _widths!;
    final numeric = _numericColumns!;
    final rows = widget.data.rows;
    final total = widths.fold(0.0, (s, w) => s + w) + 16;
    final stripe = colors.fill.withValues(alpha: colors.fill.a * 0.5);

    Widget row(List<String> cells, {required TextStyle style, Color? color, bool isHeader = false}) => Container(
      decoration: BoxDecoration(
        color: color,
        border: Border(
          bottom: BorderSide(color: colors.separator, width: isHeader ? 1 : 0.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var c = 0; c < widths.length; c++)
            SizedBox(
              width: widths[c],
              child: Padding(
                padding: CsvTableView.cellPadding,
                child: Text(
                  c < cells.length ? cells[c] : '',
                  style: style,
                  maxLines: isHeader ? 2 : 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: numeric[c] && !isHeader ? TextAlign.end : TextAlign.start,
                ),
              ),
            ),
        ],
      ),
    );

    return SelectionArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Scrollbar(
          controller: _horizontal,
          interactive: true,
          notificationPredicate: (n) => n.metrics.axis == Axis.horizontal,
          child: SingleChildScrollView(
            key: const Key('csv-table'),
            controller: _horizontal,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: math.max(total, constraints.maxWidth),
              height: constraints.maxHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (rows.isNotEmpty) row(rows.first, style: header, isHeader: true),
                  Expanded(
                    child: Scrollbar(
                      controller: _vertical,
                      interactive: true,
                      child: ListView.builder(
                        controller: _vertical,
                        padding: EdgeInsets.only(bottom: 24 + MediaQuery.paddingOf(context).bottom),
                        itemCount: math.max(0, rows.length - 1),
                        itemBuilder: (context, i) => row(rows[i + 1], style: body, color: i.isOdd ? stripe : null),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
