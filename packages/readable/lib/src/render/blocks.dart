// Block widgets: paragraphs, headings, quotes, lists, pre, tables, buttons,
// images. Our own spacing replaces the sender's margins.

import 'package:flutter/material.dart';

import '../color/color_adapter.dart';
import '../model/document.dart';
import '../pipeline/html_to_plain.dart' show alphaMarker, romanMarker;
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

/// A column of blocks. [depth] is the quote nesting (for bar colours).
class BlockList extends StatelessWidget {
  const BlockList(this.blocks, {super.key, this.depth = 0});

  final List<Block> blocks;
  final int depth;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    Block? previous;
    for (final b in blocks) {
      final gap = _gap(previous, b);
      if (gap > 0) children.add(SizedBox(height: gap));
      children.add(BlockView(b, depth: depth));
      previous = b;
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: children);
  }
}

/// One block.
class BlockView extends StatelessWidget {
  const BlockView(this.block, {super.key, this.depth = 0});

  final Block block;
  final int depth;

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
        if (!bar) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: BlockList(children, depth: depth),
          );
        }
        return Container(
          decoration: BoxDecoration(
            border: BorderDirectional(start: BorderSide(color: styles.quoteBar(depth), width: 3)),
          ),
          padding: const EdgeInsetsDirectional.only(start: 12),
          child: BlockList(children, depth: depth + 1),
        );
      case ListBlock(:final items, :final marker, :final start):
        return _ListView(items: items, marker: marker, start: start, depth: depth);
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
    }
  }
}

class _ListView extends StatelessWidget {
  const _ListView({required this.items, required this.marker, required this.start, required this.depth});

  final List<List<Block>> items;
  final ListMarker marker;
  final int start;
  final int depth;

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
    final markerWidth = marker == ListMarker.none ? 0.0 : (marker == ListMarker.disc ? 18.0 : 28.0);
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
                Expanded(child: BlockList(item, depth: depth)),
              ],
            ),
          ),
      ],
    );
  }
}

class _ButtonChip extends StatelessWidget {
  const _ButtonChip(this.button);
  final ButtonBlock button;

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
    return Align(
      alignment: alignment,
      child: Semantics(
        link: true,
        button: true,
        child: Material(
          color: fill,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => scope.onLinkTap(button.link),
            onLongPress: () => scope.onLinkLongPress(button.link),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 44),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                child: Text(
                  button.text,
                  textAlign: TextAlign.center,
                  style: scope.styles.body.copyWith(color: label, fontWeight: FontWeight.w600, height: 1.25),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _onFill(ReaderScope scope, int? fg, Color fill, Color fallback) {
    final adapter = scope.colors;
    final fillArgb = fill.toARGB32();
    if (adapter == null) return (fg ?? fallback.toARGB32());
    return ensureContrast(fg ?? fallback.toARGB32(), fillArgb, minTextContrast);
  }
}

/// A data table: its own horizontal scroll, columns sized to content (long
/// cells wrap), numbers aligned to the end.
class _DataTableView extends StatelessWidget {
  const _DataTableView(this.table);
  final TableBlock table;

  static final _numeric = RegExp(r'^[\s\-+(]*[$€£¥₹]?\s*[\d.,\s]+%?\s*[$€£¥₹)]?\s*[A-Z]{0,3}$');

  @override
  Widget build(BuildContext context) {
    final scope = ReaderScope.of(context);
    final styles = scope.styles;
    final columns = table.columns;
    final rows = <TableRow>[];
    for (final row in table.rows) {
      final cells = <Widget>[];
      final header = row.every((c) => c.header);
      for (final cell in row) {
        final text = inlineText(cell.inlines).trim();
        final end = cell.align == BlockAlign.right || (_numeric.hasMatch(text) && text.isNotEmpty);
        cells.add(
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 260),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: InlineText(
                cell.inlines,
                style: cell.header ? styles.body.copyWith(fontWeight: FontWeight.w600) : styles.body,
                align: cell.align == BlockAlign.center
                    ? BlockAlign.center
                    : (end ? BlockAlign.right : BlockAlign.start),
              ),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        defaultColumnWidth: const IntrinsicColumnWidth(),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        border: TableBorder(
          horizontalInside: BorderSide(color: styles.divider),
          top: BorderSide(color: styles.divider),
          bottom: BorderSide(color: styles.divider),
        ),
        children: rows,
      ),
    );
  }
}
