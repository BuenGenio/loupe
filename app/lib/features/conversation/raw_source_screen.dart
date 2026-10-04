import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:share_plus/share_plus.dart';

import '../../providers.dart';
import '../../shared/format.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import 'sheets.dart';

/// Decodes a raw message: UTF-8 if valid, otherwise Latin-1 (8-bit parts in
/// legacy charsets).
String decodeRawSource(List<int> bytes) {
  try {
    return utf8.decode(bytes);
  } on FormatException {
    return latin1.decode(bytes);
  }
}

/// A raw source split into display rows: one per line, with lines longer
/// than [maxLineLength] split into several rows so no row lays out a huge
/// paragraph. [columns] is the widest row, counting non-ASCII characters
/// twice (CJK and emoji take two cells in a monospace font).
final class SourceLines {
  SourceLines._(this.rows, this.columns);

  factory SourceLines.parse(String text, {int maxLineLength = 2000}) {
    final rows = <String>[];
    var columns = 0;
    var start = 0;
    while (start < text.length) {
      var end = text.indexOf('\n', start);
      final next = end < 0 ? text.length : end + 1;
      if (end < 0) end = text.length;
      if (end > start && text.codeUnitAt(end - 1) == 0x0d) end--;
      var from = start;
      do {
        final to = math.min(end, from + maxLineLength);
        final row = text.substring(from, to);
        var width = row.length;
        for (var i = 0; i < row.length; i++) {
          if (row.codeUnitAt(i) > 0x7f) width++;
        }
        columns = math.max(columns, width);
        rows.add(row);
        from = to;
      } while (from < end);
      start = next;
    }
    return SourceLines._(rows, columns);
  }

  final List<String> rows;
  final int columns;
}

typedef _Source = ({Uint8List bytes, SourceLines lines, bool cut});

/// The raw RFC 822 message as selectable monospace text, with line wrapping
/// on or off, copy and share (as an .eml file).
///
/// Rows are built lazily, so multi-megabyte sources open and scroll
/// smoothly; a draggable scrollbar crosses them quickly. Plain [Text] rows in
/// a [SelectionArea] keep selection working; a [SelectableText] here would
/// bring its own vertical scroll view, which takes the drag from the page
/// with the app's always-scrollable physics and springs back to the top.
class RawSourceScreen extends ConsumerStatefulWidget {
  const RawSourceScreen({super.key, required this.emailId});

  final String emailId;

  @override
  ConsumerState<RawSourceScreen> createState() => _RawSourceScreenState();
}

class _RawSourceScreenState extends ConsumerState<RawSourceScreen> {
  /// Longer sources are cut for display; copy and share use everything.
  static const _displayLimit = 8 * 1024 * 1024;

  static const _style = TextStyle(fontFamily: 'monospace', fontSize: 12.5, height: 1.35);

  /// Every row exactly one line high, whatever fallback fonts it uses.
  static const _strut = StrutStyle(fontFamily: 'monospace', fontSize: 12.5, height: 1.35, forceStrutHeight: true);

  static const _padding = EdgeInsets.fromLTRB(12, 12, 16, 32);

  late Future<_Source> _source = _load();
  final _vertical = ScrollController();
  final _horizontal = ScrollController();
  bool _wrap = true;

  Future<_Source> _load() async {
    final bytes = await ref.read(repositoryProvider).loadRawSource(widget.emailId);
    final cut = bytes.length > _displayLimit;
    var end = bytes.length;
    if (cut) {
      // Cut at a character boundary, so valid UTF-8 stays valid.
      end = _displayLimit;
      while (end > 0 && (bytes[end] & 0xc0) == 0x80) {
        end--;
      }
    }
    final text = decodeRawSource(cut ? Uint8List.sublistView(bytes, 0, end) : bytes);
    return (bytes: bytes, lines: SourceLines.parse(text), cut: cut);
  }

  @override
  void didUpdateWidget(RawSourceScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.emailId != widget.emailId) _source = _load();
  }

  @override
  void dispose() {
    _vertical.dispose();
    _horizontal.dispose();
    super.dispose();
  }

  void _toggleWrap() {
    // Keep roughly the same place in the source: rows change height.
    final p = _vertical.hasClients ? _vertical.position : null;
    final fraction = p == null || p.maxScrollExtent <= 0 ? 0.0 : p.pixels / p.maxScrollExtent;
    setState(() => _wrap = !_wrap);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_vertical.hasClients) return;
      final p = _vertical.position;
      _vertical.jumpTo((fraction * p.maxScrollExtent).clamp(0.0, p.maxScrollExtent));
      if (_wrap && _horizontal.hasClients) _horizontal.jumpTo(0);
    });
  }

  Future<void> _copy(Uint8List bytes) async {
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: decodeRawSource(bytes)));
    showSnack(messenger, 'Source copied');
  }

  Future<void> _share(Uint8List bytes) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile.fromData(bytes, name: 'message.eml', mimeType: 'message/rfc822')],
          fileNameOverrides: const ['message.eml'],
        ),
      );
    } on Exception {
      showSnack(messenger, "Couldn't share the message.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return FutureBuilder<_Source>(
      future: _source,
      builder: (context, snapshot) {
        final bytes = snapshot.data?.bytes;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Source'),
            actions: [
              IconButton(
                key: const Key('source-wrap'),
                tooltip: _wrap ? "Don't Wrap Lines" : 'Wrap Lines',
                isSelected: _wrap,
                icon: const Icon(LoupeIcons.wrap),
                onPressed: _toggleWrap,
              ),
              IconButton(
                tooltip: 'Copy All',
                icon: const Icon(LoupeIcons.copy),
                onPressed: bytes == null ? null : () => _copy(bytes),
              ),
              IconButton(
                tooltip: 'Share',
                icon: const Icon(LoupeIcons.share),
                onPressed: bytes == null ? null : () => _share(bytes),
              ),
            ],
          ),
          body: switch (snapshot) {
            AsyncSnapshot(hasError: true, :final error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      error is MailException ? error.message : "The source couldn't be loaded.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colors.secondaryText),
                    ),
                    TextButton(onPressed: () => setState(() => _source = _load()), child: const Text('Try Again')),
                  ],
                ),
              ),
            ),
            AsyncSnapshot(hasData: true, data: final source?) => _body(context, source),
            _ => const Center(child: CircularProgressIndicator.adaptive()),
          },
        );
      },
    );
  }

  /// The width of one character of the monospace font.
  static double _cellWidth(TextScaler textScaler) {
    final painter = TextPainter(
      text: const TextSpan(text: 'MMMMMMMMMM', style: _style),
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
    )..layout();
    final width = painter.width / 10;
    painter.dispose();
    return width;
  }

  Widget _body(BuildContext context, _Source source) {
    final colors = LoupeColors.of(context);
    final rows = source.lines.rows;
    final cellWidth = _cellWidth(MediaQuery.textScalerOf(context));
    final padding = _padding.copyWith(bottom: _padding.bottom + MediaQuery.paddingOf(context).bottom);

    final list = ListView.builder(
      key: const Key('source-list'),
      controller: _vertical,
      padding: padding,
      itemCount: rows.length,
      // Unwrapped, every row is one line: fixed extents keep long sources
      // cheap and the scrollbar exact.
      prototypeItem: _wrap ? null : const Text('M', style: _style, strutStyle: _strut),
      itemBuilder: (context, i) => Text(rows[i], style: _style, strutStyle: _strut, softWrap: _wrap),
    );

    // The same structure in both modes, so the list keeps its position.
    final content = LayoutBuilder(
      builder: (context, constraints) {
        final unwrapped = (source.lines.columns + 1) * cellWidth + padding.horizontal;
        final width = _wrap ? constraints.maxWidth : math.max(constraints.maxWidth, unwrapped);
        return Scrollbar(
          controller: _horizontal,
          thumbVisibility: !_wrap,
          interactive: true,
          notificationPredicate: (n) => n.metrics.axis == Axis.horizontal,
          child: SingleChildScrollView(
            controller: _horizontal,
            scrollDirection: Axis.horizontal,
            physics: _wrap ? const NeverScrollableScrollPhysics() : null,
            child: SizedBox(width: width, height: constraints.maxHeight, child: list),
          ),
        );
      },
    );

    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (source.cut)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Text(
                'Showing the first ${formatBytes(_displayLimit)} of ${formatBytes(source.bytes.length)}. '
                'Copy or share to get all of it.',
                style: TextStyle(color: colors.secondaryText, fontSize: 13),
              ),
            ),
          Expanded(
            child: Scrollbar(
              key: const Key('source-scrollbar'),
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
