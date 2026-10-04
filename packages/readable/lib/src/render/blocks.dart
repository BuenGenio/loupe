// Block widgets: paragraphs, headings, quotes, lists, pre, tables, buttons,
// images. Our own spacing replaces the sender's margins.

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../color/color_adapter.dart';
import '../model/document.dart';
import '../pipeline/html_to_plain.dart' show alphaMarker, romanMarker;
import 'diff.dart';
import 'images.dart';
import 'inline_text.dart';
import 'scope.dart';

/// Vertical space between two blocks.
double _gap(Block? previous, Block next) {
  if (previous == null) return 0;
  if (next is ParagraphBlock && next.tight) return 0;
  if (next is HeadingBlock) return 20;
  if (previous is HeadingBlock) return 8;
  return 12;
}

/// Quotes and lists nested deeper than this stop indenting further, so
/// hostile nesting can't squeeze the text to nothing.
const maxIndent = 6;

/// A column of blocks. [depth] is the quote nesting (for bar colours);
/// [indent] counts every indenting container (quotes and lists).
class BlockList extends StatelessWidget {
  const BlockList(this.blocks, {super.key, this.depth = 0, this.indent = 0});

  final List<Block> blocks;
  final int depth;
  final int indent;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: blockWidgets(blocks, depth: depth, indent: indent),
  );
}

/// Widgets for [blocks] with our spacing between them.
List<Widget> blockWidgets(List<Block> blocks, {int depth = 0, int indent = 0, Block? before}) {
  final children = <Widget>[];
  Block? previous = before;
  for (var i = 0; i < blocks.length; i++) {
    final b = blocks[i];
    final gap = _gap(previous, b);
    if (gap > 0) children.add(SizedBox(height: gap));
    // Consecutive buttons (Yes / Maybe / No) share a row.
    if (b is ButtonBlock && i + 1 < blocks.length && blocks[i + 1] is ButtonBlock) {
      final row = <ButtonBlock>[b];
      while (i + 1 < blocks.length && blocks[i + 1] is ButtonBlock) {
        row.add(blocks[++i] as ButtonBlock);
      }
      children.add(
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: b.align == BlockAlign.start ? WrapAlignment.start : WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [for (final button in row) _ButtonChip(button, aligned: false)],
        ),
      );
      previous = row.last;
      continue;
    }
    children.add(BlockView(b, depth: depth, indent: indent));
    previous = b;
  }
  return children;
}

/// The top-level blocks of a message. Long messages are built in chunks over
/// several frames, so the first screen appears at once, and each chunk is a
/// repaint boundary, so scrolling doesn't repaint text that didn't change.
class DocumentBlocks extends StatefulWidget {
  const DocumentBlocks(this.blocks, {super.key});

  final List<Block> blocks;

  /// Blocks per chunk.
  static const chunkSize = 40;

  /// Chunks built in the first frame.
  static const initialChunks = 2;

  @override
  State<DocumentBlocks> createState() => _DocumentBlocksState();
}

class _DocumentBlocksState extends State<DocumentBlocks> {
  late int _chunks;

  /// Built chunks, reused across rebuilds: an identical widget lets Flutter
  /// skip the whole subtree when the host rebuilds for unrelated reasons.
  final _built = <Widget>[];

  int get _total => (widget.blocks.length + DocumentBlocks.chunkSize - 1) ~/ DocumentBlocks.chunkSize;

  @override
  void initState() {
    super.initState();
    _chunks = DocumentBlocks.initialChunks;
    _scheduleMore();
  }

  @override
  void didUpdateWidget(DocumentBlocks old) {
    super.didUpdateWidget(old);
    if (!identical(old.blocks, widget.blocks)) {
      _built.clear();
      _chunks = DocumentBlocks.initialChunks;
      _scheduleMore();
    }
  }

  void _scheduleMore() {
    if (_chunks >= _total) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _chunks >= _total) return;
      setState(() => _chunks += 2);
      _scheduleMore();
    });
  }

  @override
  Widget build(BuildContext context) {
    final blocks = widget.blocks;
    const size = DocumentBlocks.chunkSize;
    final shown = (_chunks * size).clamp(0, blocks.length);
    if (blocks.length <= size) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: blockWidgets(blocks),
      );
    }
    for (var start = _built.length * size; start < shown; start += size) {
      _built.add(
        RepaintBoundary(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: blockWidgets(
              blocks.sublist(start, (start + size).clamp(0, blocks.length)),
              before: start == 0 ? null : blocks[start - 1],
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: List.of(_built),
    );
  }
}

/// One block.
class BlockView extends StatelessWidget {
  const BlockView(this.block, {super.key, this.depth = 0, this.indent = 0});

  final Block block;
  final int depth;
  final int indent;

  @override
  Widget build(BuildContext context) {
    final scope = ReaderScope.of(context);
    final styles = scope.styles;
    switch (block) {
      case ParagraphBlock(:final inlines, :final align, :final dir, :final muted):
        final style = muted ? styles.body.copyWith(color: styles.muted) : styles.body;
        return InlineText(inlines, style: style, align: align, dir: dir);
      case HeadingBlock(:final level, :final inlines, :final align, :final dir):
        return Semantics(
          header: true,
          child: InlineText(
            inlines,
            style: styles.headings[(level - 1).clamp(0, 5)],
            align: align,
            dir: dir,
            large: true,
          ),
        );
      case QuoteBlock(:final children, :final bar):
        if (indent >= maxIndent) return BlockList(children, depth: depth + (bar ? 1 : 0), indent: indent);
        if (!bar) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: BlockList(children, depth: depth, indent: indent + 1),
          );
        }
        return Container(
          decoration: BoxDecoration(
            border: BorderDirectional(start: BorderSide(color: styles.quoteBar(depth), width: 3)),
          ),
          padding: const EdgeInsetsDirectional.only(start: 12),
          child: BlockList(children, depth: depth + 1, indent: indent + 1),
        );
      case ListBlock(:final items, :final marker, :final start):
        return _ListView(items: items, marker: marker, start: start, depth: depth, indent: indent);
      case PreBlock(:final inlines):
        return Container(
          decoration: BoxDecoration(color: styles.codeBackground, borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: InlineText(inlines, style: styles.mono, softWrap: false),
          ),
        );
      case RuleBlock():
        return Divider(height: 8, thickness: 1, color: styles.divider);
      case ImageBlock(:final image):
        return BlockImage(image);
      case CarouselBlock(:final images):
        return ImageCarousel(images);
      case ButtonBlock():
        return _ButtonChip(block as ButtonBlock);
      case TableBlock():
        return _DataTableView(block as TableBlock);
      case DiffBlock():
        return DiffView(block as DiffBlock);
      case DiffStatBlock():
        return DiffStatView(block as DiffStatBlock);
    }
  }
}

class _ListView extends StatelessWidget {
  const _ListView({
    required this.items,
    required this.marker,
    required this.start,
    required this.depth,
    required this.indent,
  });

  final List<List<Block>> items;
  final ListMarker marker;
  final int start;
  final int depth;
  final int indent;

  String _label(int n) => switch (marker) {
    ListMarker.disc => '•',
    ListMarker.none => '',
    ListMarker.decimal => '$n.',
    ListMarker.lowerAlpha => '${alphaMarker(n)}.',
    ListMarker.upperAlpha => '${alphaMarker(n).toUpperCase()}.',
    ListMarker.lowerRoman => '${romanMarker(n)}.',
    ListMarker.upperRoman => '${romanMarker(n).toUpperCase()}.',
  };

  @override
  Widget build(BuildContext context) {
    final styles = ReaderScope.of(context).styles;
    final flat = indent >= maxIndent;
    final markerWidth = marker == ListMarker.none || flat ? 0.0 : (marker == ListMarker.disc ? 18.0 : 28.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final (i, item) in items.indexed)
          Padding(
            padding: EdgeInsets.only(top: i == 0 ? 0 : 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                if (markerWidth > 0)
                  SizedBox(
                    width: markerWidth,
                    child: Text(_label(start + i), style: styles.body, textAlign: TextAlign.end),
                  ),
                if (markerWidth > 0) const SizedBox(width: 8),
                Expanded(
                  child: BlockList(item, depth: depth, indent: flat ? indent : indent + 1),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ButtonChip extends StatelessWidget {
  const _ButtonChip(this.button, {this.aligned = true});
  final ButtonBlock button;

  /// False inside a row of buttons (the row aligns them).
  final bool aligned;

  @override
  Widget build(BuildContext context) {
    final scope = ReaderScope.of(context);
    final scheme = Theme.of(context).colorScheme;
    final bg = button.background;
    final fill = bg == null
        ? scheme.primary
        : (scope.colors == null ? Color(bg) : Color(scope.colors!.buttonFill(bg, fallback: scheme.primary.toARGB32())));
    final label = Color(
      scope.colors == null && button.color != null
          ? button.color!
          : _onFill(scope, button.color, fill, scheme.onPrimary),
    );
    final alignment = switch (button.align) {
      BlockAlign.start => AlignmentDirectional.centerStart,
      BlockAlign.center => AlignmentDirectional.center,
      BlockAlign.right => AlignmentDirectional.centerEnd,
    };
    final page = Theme.of(context).colorScheme.surface;
    final faint = contrastRatio(fill.toARGB32(), page.toARGB32()) < 1.3;
    final chip = Semantics(
      link: true,
      button: true,
      child: Material(
        color: fill,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          // A white button on a white page still needs an edge.
          side: faint ? BorderSide(color: scheme.outline) : BorderSide.none,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => scope.onLinkTap(button.link),
          onLongPress: () => scope.onLinkLongPress(button.link),
          // At least a 44 px tap target, the label centred in it whatever
          // its size or number of lines: the box is never taller than the
          // label alone would make it without the minimum, and the label
          // sits in the middle of the extra height.
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 44),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: Align(
                widthFactor: 1,
                heightFactor: 1,
                child: Text(
                  button.text,
                  textAlign: TextAlign.center,
                  style: scope.styles.body.copyWith(
                    color: label,
                    fontWeight: FontWeight.w600,
                    // Even leading puts the glyphs in the middle of each line
                    // (the default gives the extra space to the ascent).
                    height: 1.2,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    return aligned ? Align(alignment: alignment, child: chip) : chip;
  }

  int _onFill(ReaderScope scope, int? fg, Color fill, Color fallback) {
    final adapter = scope.colors;
    final fillArgb = fill.toARGB32();
    if (adapter == null) return (fg ?? fallback.toARGB32());
    return ensureContrast(fg ?? fallback.toARGB32(), fillArgb, minButtonContrast);
  }
}

/// A data table: as wide as the screen when it fits (the column with the most
/// text takes the slack), otherwise its own horizontal scroll. Columns are
/// sized to content up to a cap, long cells wrap, numbers align to the end.
class _DataTableView extends StatelessWidget {
  const _DataTableView(this.table);
  final TableBlock table;

  static final _numeric = RegExp(r'^[\s\-+(]*[$€£¥₹]?\s*[\d.,\s]+%?\s*[$€£¥₹)]?\s*[A-Z]{0,3}$');

  /// Widest a column grows to fit its content before its cells wrap.
  static const _columnCap = 260.0;

  @override
  Widget build(BuildContext context) {
    final scope = ReaderScope.of(context);
    final styles = scope.styles;
    final columns = table.columns;
    final rows = <TableRow>[];
    final textPerColumn = List<int>.filled(columns, 0);
    for (final row in table.rows) {
      final cells = <Widget>[];
      final header = row.every((c) => c.header);
      for (final cell in row) {
        final text = inlineText(cell.inlines).trim();
        if (cell.colspan == 1 && cells.length < columns && text.length > textPerColumn[cells.length]) {
          textPerColumn[cells.length] = text.length;
        }
        final end = cell.align == BlockAlign.right || (_numeric.hasMatch(text) && text.isNotEmpty);
        cells.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: InlineText(
              cell.inlines,
              style: cell.header ? styles.body.copyWith(fontWeight: FontWeight.w600) : styles.body,
              align: cell.align == BlockAlign.center ? BlockAlign.center : (end ? BlockAlign.right : BlockAlign.start),
            ),
          ),
        );
        for (var i = 1; i < cell.colspan; i++) {
          cells.add(const SizedBox.shrink());
        }
      }
      while (cells.length < columns) {
        cells.add(const SizedBox.shrink());
      }
      if (cells.length > columns) cells.removeRange(columns, cells.length);
      rows.add(
        TableRow(
          decoration: header ? BoxDecoration(color: styles.codeBackground) : null,
          children: cells,
        ),
      );
    }
    var widest = 0;
    for (var i = 1; i < columns; i++) {
      if (textPerColumn[i] > textPerColumn[widest]) widest = i;
    }
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: constraints.maxWidth.isFinite ? constraints.maxWidth : 0),
          child: Table(
            defaultColumnWidth: const _CappedIntrinsicWidth(_columnCap),
            columnWidths: {widest: const _CappedIntrinsicWidth(_columnCap, flexFactor: 1)},
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            border: TableBorder(
              horizontalInside: BorderSide(color: styles.divider),
              top: BorderSide(color: styles.divider),
              bottom: BorderSide(color: styles.divider),
            ),
            children: rows,
          ),
        ),
      ),
    );
  }
}

/// Intrinsic column width capped at [cap]; with [flexFactor], the column also
/// takes the table's spare width.
class _CappedIntrinsicWidth extends TableColumnWidth {
  const _CappedIntrinsicWidth(this.cap, {this.flexFactor});

  final double cap;
  final double? flexFactor;

  @override
  double minIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) {
    var result = 0.0;
    for (final cell in cells) {
      result = math.max(result, cell.getMinIntrinsicWidth(double.infinity));
    }
    return math.min(result, cap);
  }

  @override
  double maxIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) {
    var result = 0.0;
    for (final cell in cells) {
      result = math.max(result, cell.getMaxIntrinsicWidth(double.infinity));
    }
    return math.min(result, cap);
  }

  @override
  double? flex(Iterable<RenderBox> cells) => flexFactor;
}
