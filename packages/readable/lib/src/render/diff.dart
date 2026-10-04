// Patches: a diff file with its hunks (line numbers, green and red lines,
// each hunk scrolling sideways) and the collapsible diffstat.

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../model/document.dart';
import 'icons.dart';
import 'scope.dart';

/// The colours of diffs, for the light or dark theme: tints that keep the
/// theme's text colour readable.
@immutable
final class DiffPalette {
  const DiffPalette({
    required this.addedLine,
    required this.addedGutter,
    required this.addedMark,
    required this.removedLine,
    required this.removedGutter,
    required this.removedMark,
    required this.hunkHeader,
    required this.hunkHeaderText,
    required this.fileHeader,
    required this.border,
    required this.lineNumber,
  });

  factory DiffPalette.of(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final dark = theme.brightness == Brightness.dark;
    return DiffPalette(
      addedLine: dark ? const Color(0x262EA043) : const Color(0xFFE6FFEC),
      addedGutter: dark ? const Color(0x4D3FB950) : const Color(0xFFCCFFD8),
      addedMark: dark ? const Color(0xFF3FB950) : const Color(0xFF1A7F37),
      removedLine: dark ? const Color(0x1AF85149) : const Color(0xFFFFEBE9),
      removedGutter: dark ? const Color(0x4DF85149) : const Color(0xFFFFD7D5),
      removedMark: dark ? const Color(0xFFF85149) : const Color(0xFFCF222E),
      hunkHeader: dark ? const Color(0x1F388BFD) : const Color(0xFFDDF4FF),
      hunkHeaderText: scheme.onSurfaceVariant,
      fileHeader: scheme.surfaceContainerHighest,
      border: scheme.outlineVariant,
      lineNumber: scheme.onSurfaceVariant,
    );
  }

  final Color addedLine;
  final Color addedGutter;
  final Color addedMark;
  final Color removedLine;
  final Color removedGutter;
  final Color removedMark;
  final Color hunkHeader;
  final Color hunkHeaderText;
  final Color fileHeader;
  final Color border;
  final Color lineNumber;

  Color? line(DiffLineKind kind) => switch (kind) {
    DiffLineKind.added => addedLine,
    DiffLineKind.removed => removedLine,
    _ => null,
  };

  Color? gutter(DiffLineKind kind) => switch (kind) {
    DiffLineKind.added => addedGutter,
    DiffLineKind.removed => removedGutter,
    _ => null,
  };
}

/// One file of a patch, or a quoted excerpt of one.
class DiffView extends StatelessWidget {
  const DiffView(this.block, {super.key});

  final DiffBlock block;

  @override
  Widget build(BuildContext context) {
    final styles = ReaderScope.of(context).styles;
    final palette = DiffPalette.of(context);
    final file = block.file;
    final code = styles.mono.copyWith(fontSize: 13, height: 1.45);
    final showHeader = file.path.isNotEmpty || file.headers.isNotEmpty;
    final empty = file.hunks.every((h) => h.lines.isEmpty);
    return Semantics(
      container: true,
      label: file.path.isEmpty ? 'Diff' : 'Diff of ${file.path}',
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: palette.border),
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showHeader) _FileHeader(file: file, palette: palette, style: code),
            for (final (i, hunk) in file.hunks.indexed) ...[
              if (i > 0 || showHeader) Divider(height: 1, thickness: 1, color: palette.border),
              if (hunk.header.isNotEmpty) _HunkHeader(hunk.header, palette: palette, style: code),
              if (hunk.lines.isNotEmpty) HunkBody(hunk, palette: palette, style: code),
            ],
            if (empty && showHeader) ...[
              Divider(height: 1, thickness: 1, color: palette.border),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  file.binary ? 'Binary file, not shown' : (file.isRename ? 'Renamed without changes' : 'No changes'),
                  style: code.copyWith(color: palette.lineNumber, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FileHeader extends StatelessWidget {
  const _FileHeader({required this.file, required this.palette, required this.style});

  final DiffFile file;
  final DiffPalette palette;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final muted = style.copyWith(color: palette.lineNumber, fontSize: 12);
    final added = file.added;
    final removed = file.removed;
    final status = [
      if (file.isNew) 'new file',
      if (file.isDeleted) 'deleted',
      if (file.isRename) 'renamed from ${file.oldPath}',
      if (file.binary) 'binary',
    ];
    return Container(
      color: palette.fileHeader,
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(ReadableIcons.file, size: 16, color: palette.lineNumber),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  file.path.isEmpty ? 'diff' : file.path,
                  style: style.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (added > 0) Text(' +$added', style: style.copyWith(color: palette.addedMark, fontSize: 12)),
              if (removed > 0) Text(' −$removed', style: style.copyWith(color: palette.removedMark, fontSize: 12)),
            ],
          ),
          if (status.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 22, top: 2),
              child: Text(status.join(' · '), style: muted),
            ),
        ],
      ),
    );
  }
}

class _HunkHeader extends StatelessWidget {
  const _HunkHeader(this.header, {required this.palette, required this.style});

  final String header;
  final DiffPalette palette;
  final TextStyle style;

  @override
  Widget build(BuildContext context) => Container(
    color: palette.hunkHeader,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    child: Text(
      header,
      style: style.copyWith(color: palette.hunkHeaderText, fontSize: 12),
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

/// The lines of a hunk: a line-number gutter that stays put and the code,
/// which scrolls sideways instead of wrapping. Very long hunks show their
/// start and a button for the rest.
class HunkBody extends StatefulWidget {
  const HunkBody(this.hunk, {super.key, required this.palette, required this.style});

  final DiffHunk hunk;
  final DiffPalette palette;
  final TextStyle style;

  /// Lines shown before "Show all".
  static const initialLines = 400;

  @override
  State<HunkBody> createState() => _HunkBodyState();
}

class _HunkBodyState extends State<HunkBody> {
  bool _all = false;

  @override
  Widget build(BuildContext context) {
    final all = widget.hunk.lines;
    final lines = _all || all.length <= HunkBody.initialLines + 50 ? all : all.sublist(0, HunkBody.initialLines);
    final palette = widget.palette;
    final style = widget.style;
    final strut = StrutStyle.fromTextStyle(style, forceStrutHeight: true);
    final numbered = lines.any((l) => l.oldLine != null || l.newLine != null);
    final kinds = [for (final l in lines) l.kind];
    Widget body = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (numbered) _gutter(lines, kinds, strut),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CustomPaint(
                painter: _LinePainter(kinds, palette.line),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text.rich(
                      TextSpan(children: _code(lines)),
                      style: style,
                      strutStyle: strut,
                      softWrap: false,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    if (lines.length < all.length) {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          body,
          TextButton(onPressed: () => setState(() => _all = true), child: Text('Show all ${all.length} lines')),
        ],
      );
    }
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: body);
  }

  /// Old and new line numbers, right-aligned, not selectable.
  Widget _gutter(List<DiffLine> lines, List<DiffLineKind> kinds, StrutStyle strut) {
    final digits = math.max(
      2,
      lines.fold(0, (w, l) => math.max(w, math.max('${l.oldLine ?? ''}'.length, '${l.newLine ?? ''}'.length))),
    );
    final text = [
      for (final l in lines) '${'${l.oldLine ?? ''}'.padLeft(digits)} ${'${l.newLine ?? ''}'.padLeft(digits)}',
    ].join('\n');
    return SelectionContainer.disabled(
      child: ExcludeSemantics(
        child: CustomPaint(
          painter: _LinePainter(kinds, widget.palette.gutter),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              text,
              style: widget.style.copyWith(color: widget.palette.lineNumber),
              strutStyle: strut,
              softWrap: false,
            ),
          ),
        ),
      ),
    );
  }

  List<InlineSpan> _code(List<DiffLine> lines) {
    final palette = widget.palette;
    final spans = <InlineSpan>[];
    for (final (i, l) in lines.indexed) {
      final nl = i == lines.length - 1 ? '' : '\n';
      switch (l.kind) {
        case DiffLineKind.added || DiffLineKind.removed:
          final mark = l.kind == DiffLineKind.added ? palette.addedMark : palette.removedMark;
          spans
            ..add(
              TextSpan(
                text: ' ${l.marker}',
                style: TextStyle(color: mark, fontWeight: FontWeight.w700),
              ),
            )
            ..add(TextSpan(text: '${l.text}$nl'));
        case DiffLineKind.context:
          spans.add(TextSpan(text: '  ${l.text}$nl'));
        case DiffLineKind.note:
          spans.add(
            TextSpan(
              text: '  ${l.text}$nl',
              style: TextStyle(color: palette.lineNumber, fontStyle: FontStyle.italic),
            ),
          );
      }
    }
    return spans;
  }
}

/// Paints one band per line behind a text of equally tall lines.
class _LinePainter extends CustomPainter {
  _LinePainter(this.kinds, this.colorOf);

  final List<DiffLineKind> kinds;
  final Color? Function(DiffLineKind kind) colorOf;

  @override
  void paint(Canvas canvas, Size size) {
    if (kinds.isEmpty) return;
    final lineHeight = size.height / kinds.length;
    final paint = Paint();
    for (final (i, kind) in kinds.indexed) {
      final color = colorOf(kind);
      if (color == null) continue;
      paint.color = color;
      canvas.drawRect(Rect.fromLTWH(0, i * lineHeight, size.width, lineHeight), paint);
    }
  }

  @override
  bool shouldRepaint(_LinePainter old) => old.kinds != kinds || old.colorOf != colorOf;
}

/// The diffstat, collapsed to its summary line; tap to see the files.
class DiffStatView extends StatefulWidget {
  const DiffStatView(this.block, {super.key, this.initiallyExpanded = false});

  final DiffStatBlock block;
  final bool initiallyExpanded;

  @override
  State<DiffStatView> createState() => _DiffStatViewState();
}

class _DiffStatViewState extends State<DiffStatView> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final styles = ReaderScope.of(context).styles;
    final palette = DiffPalette.of(context);
    final b = widget.block;
    final code = styles.mono.copyWith(fontSize: 13, height: 1.45);
    final small = styles.body.copyWith(fontSize: 14);
    final files = b.filesChanged == 0 ? b.files.length : b.filesChanged;
    return Container(
      decoration: BoxDecoration(color: palette.fileHeader, borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Semantics(
            button: true,
            expanded: _expanded,
            child: InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  children: [
                    AnimatedRotation(
                      turns: _expanded ? 0.25 : 0,
                      duration: const Duration(milliseconds: 150),
                      child: Icon(ReadableIcons.disclosure, size: 16, color: palette.lineNumber),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: files == 1 ? '1 file changed' : '$files files changed'),
                            if (b.insertions > 0)
                              TextSpan(
                                text: '  +${b.insertions}',
                                style: TextStyle(color: palette.addedMark, fontWeight: FontWeight.w600),
                              ),
                            if (b.deletions > 0)
                              TextSpan(
                                text: '  −${b.deletions}',
                                style: TextStyle(color: palette.removedMark, fontWeight: FontWeight.w600),
                              ),
                          ],
                        ),
                        style: small,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final f in b.files)
                    Row(
                      children: [
                        Expanded(
                          child: Text(f.path, style: code, maxLines: 1, overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(width: 8),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: f.binary ?? '${f.changes} '),
                              for (final run in RegExp(r'\++|-+').allMatches(f.graph))
                                TextSpan(
                                  text: run[0],
                                  style: TextStyle(
                                    color: run[0]!.startsWith('+') ? palette.addedMark : palette.removedMark,
                                  ),
                                ),
                            ],
                          ),
                          style: code,
                        ),
                      ],
                    ),
                  for (final e in b.extra) Text(e, style: code.copyWith(color: palette.lineNumber)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
