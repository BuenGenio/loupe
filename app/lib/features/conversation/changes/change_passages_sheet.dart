import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../../l10n/l10n.dart';
import '../../../shared/format.dart';
import '../../../theme/theme.dart';
import '../sheets.dart';
import 'what_changed.dart';

/// Both passages of one explained change, highlighted in the whole text of
/// their messages: the From Message above, the To Message below, each
/// scrolled to its passage. The texts are the compared ones with whitespace
/// collapsed, as the passages were located in them; quoted lines are dimmed,
/// so where a message's own words end stays visible.
Future<void> showChangePassagesSheet(
  BuildContext context, {
  required ExplainedChange change,
  required ChangeExplanationTask task,
  required EmailSummary from,
  required EmailSummary to,
}) => showLoupeSheet<void>(
  context,
  builder: (_) => FractionallySizedBox(
    heightFactor: 0.92,
    child: ChangePassagesSheet(change: change, task: task, from: from, to: to),
  ),
);

class ChangePassagesSheet extends StatelessWidget {
  const ChangePassagesSheet({
    super.key,
    required this.change,
    required this.task,
    required this.from,
    required this.to,
  });

  final ExplainedChange change;
  final ChangeExplanationTask task;
  final EmailSummary from;
  final EmailSummary to;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    List<ChangePassage> on(ChangeSide side) => [
      for (final p in change.passages)
        if (p.side == side) p,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 8, 4),
          child: Row(
            children: [
              Expanded(
                child: Text(change.label, style: styles.navTitle, maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonDone)),
            ],
          ),
        ),
        // Bounded, so a long value at a large text size leaves room for both messages.
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.2),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.changesExplainKind(change.kind.name),
                  style: styles.caption.copyWith(
                    color: changeKindColor(context, change.kind),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(changeValues(context, change), style: styles.body),
                if (change.kind == ChangeKind.contradiction)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(l10n.changesExplainConflictNote, style: styles.footnote),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: _MessagePane(
            key: const ValueKey('passages-from'),
            title: l10n.conversationChangesFrom,
            message: from,
            text: task.before.normalisedText,
            passages: on(ChangeSide.before),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _MessagePane(
            key: const ValueKey('passages-to'),
            title: l10n.conversationChangesTo,
            message: to,
            text: task.after.normalisedText,
            passages: on(ChangeSide.after),
          ),
        ),
        SizedBox(height: MediaQuery.paddingOf(context).bottom + 12),
      ],
    );
  }
}

/// One message's whole text with [passages] highlighted, scrolled so the
/// first of them shows near the top, even inside a long paragraph.
class _MessagePane extends StatefulWidget {
  const _MessagePane({
    super.key,
    required this.title,
    required this.message,
    required this.text,
    required this.passages,
  });

  final String title;
  final EmailSummary message;
  final String text;
  final List<ChangePassage> passages;

  @override
  State<_MessagePane> createState() => _MessagePaneState();
}

class _MessagePaneState extends State<_MessagePane> {
  final _scroll = ScrollController();
  final _first = GlobalKey();

  /// Where the first passage starts in its line.
  var _firstStart = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _reveal());
  }

  void _reveal() {
    final paragraph = _paragraphIn(_first.currentContext?.findRenderObject());
    if (!mounted || !_scroll.hasClients || paragraph == null) return;
    final caret = paragraph.getOffsetForCaret(TextPosition(offset: _firstStart), Rect.zero).dy;
    final line = RenderAbstractViewport.of(paragraph).getOffsetToReveal(paragraph, 0).offset;
    final position = _scroll.position;
    _scroll.jumpTo(
      (line + caret - position.viewportDimension * 0.2).clamp(position.minScrollExtent, position.maxScrollExtent),
    );
  }

  /// The text of a line; in a SelectionArea, Text wraps it in a mouse region.
  static RenderParagraph? _paragraphIn(RenderObject? object) {
    if (object == null || object is RenderParagraph) return object as RenderParagraph?;
    RenderParagraph? found;
    object.visitChildren((child) => found ??= _paragraphIn(child));
    return found;
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    final colors = LoupeColors.of(context);
    final sender = widget.message.sender?.displayName ?? l10n.conversationNoSender;
    final date = formatFullDate(widget.message.sentAt ?? widget.message.receivedAt, l10n: l10n);
    final highlight = colors.unreadDot.withValues(alpha: 0.22);

    final lines = <Widget>[];
    var offset = 0;
    var marked = false;
    for (final line in widget.text.split('\n')) {
      final start = offset;
      final end = offset + line.length;
      offset = end + 1;
      if (line.isEmpty) {
        lines.add(const SizedBox(height: 10));
        continue;
      }
      final ranges = [
        for (final p in widget.passages)
          if (p.start < end && p.end > start) (p.start.clamp(start, end) - start, p.end.clamp(start, end) - start),
      ]..sort((a, b) => a.$1.compareTo(b.$1));
      final spans = <TextSpan>[];
      var at = 0;
      for (final (from, to) in ranges) {
        if (to <= at) continue;
        if (from > at) spans.add(TextSpan(text: line.substring(at, from)));
        spans.add(
          TextSpan(
            text: line.substring(from < at ? at : from, to),
            style: TextStyle(backgroundColor: highlight, fontWeight: FontWeight.w600),
          ),
        );
        at = to;
      }
      if (at < line.length) spans.add(TextSpan(text: line.substring(at)));
      final quoted = line.startsWith('>');
      if (ranges.isNotEmpty && !marked) _firstStart = ranges.first.$1;
      lines.add(
        Text.rich(
          TextSpan(children: spans),
          key: ranges.isNotEmpty && !marked ? _first : null,
          style: styles.body.copyWith(height: 1.4, color: quoted ? colors.secondaryText : null),
        ),
      );
      marked |= ranges.isNotEmpty;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
          child: Text(
            '${widget.title} · $sender · $date',
            style: styles.footnote,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (widget.passages.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
            child: Text(
              l10n.changesExplainNoPassage,
              style: styles.footnote,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: groupFill(context), borderRadius: BorderRadius.circular(12)),
            clipBehavior: Clip.antiAlias,
            child: Scrollbar(
              controller: _scroll,
              child: SingleChildScrollView(
                controller: _scroll,
                primary: false,
                padding: const EdgeInsets.all(12),
                child: SelectionArea(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: lines),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
