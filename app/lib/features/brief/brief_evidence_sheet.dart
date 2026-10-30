import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/attachments.dart';
import '../conversation/sheets.dart';
import 'brief_input.dart';

/// Where a Brief item comes from: the message's own text with the passage
/// highlighted and scrolled to, or the attachment whose name it is. Show
/// Original closes the sheet and shows the message itself.
Future<void> showBriefEvidenceSheet(
  BuildContext context, {
  required BriefInput input,
  required BriefItem item,
  required EmailContent content,
  required Future<Uint8List> Function(Attachment attachment) load,
  required VoidCallback onShowOriginal,
}) => showLoupeSheet<void>(
  context,
  builder: (context) => BriefEvidenceSheet(
    input: input,
    item: item,
    content: content,
    load: load,
    onShowOriginal: () {
      Navigator.of(context).pop();
      onShowOriginal();
    },
  ),
);

class BriefEvidenceSheet extends StatefulWidget {
  const BriefEvidenceSheet({
    super.key,
    required this.input,
    required this.item,
    required this.content,
    required this.load,
    required this.onShowOriginal,
  });

  final BriefInput input;
  final BriefItem item;
  final EmailContent content;
  final Future<Uint8List> Function(Attachment attachment) load;
  final VoidCallback onShowOriginal;

  @override
  State<BriefEvidenceSheet> createState() => _BriefEvidenceSheetState();
}

class _BriefEvidenceSheetState extends State<BriefEvidenceSheet> {
  final _scroll = ScrollController();
  final _textKey = GlobalKey();

  BriefEvidence get _evidence => widget.item.evidence;

  bool get _inText =>
      !_evidence.isAttachmentName && _evidence.start >= 0 && _evidence.end <= widget.input.normalisedText.length;

  @override
  void initState() {
    super.initState();
    if (_inText) WidgetsBinding.instance.addPostFrameCallback((_) => _reveal());
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  /// The laid-out text (under the selection area's mouse region).
  RenderParagraph? _paragraph() {
    RenderParagraph? found;
    void visit(RenderObject o) {
      if (found != null) return;
      if (o is RenderParagraph) {
        found = o;
      } else {
        o.visitChildren(visit);
      }
    }

    if (_textKey.currentContext?.findRenderObject() case final root?) visit(root);
    return found;
  }

  /// Scrolls the passage to a third of the way down the sheet's text.
  void _reveal() {
    final paragraph = _paragraph();
    if (!mounted || paragraph == null || !_scroll.hasClients) return;
    final caret = paragraph.getOffsetForCaret(TextPosition(offset: _evidence.start), Rect.zero);
    final viewport = RenderAbstractViewport.maybeOf(paragraph);
    if (viewport == null) return;
    final top = viewport.getOffsetToReveal(paragraph, 0).offset + caret.dy;
    final p = _scroll.position;
    _scroll.jumpTo((top - p.viewportDimension / 3).clamp(p.minScrollExtent, p.maxScrollExtent));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    final height = MediaQuery.sizeOf(context).height;
    return SafeArea(
      top: false,
      child: SizedBox(
        height: height * (_inText ? 0.75 : 0.45),
        child: Column(
          key: const Key('brief-evidence'),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 8, 4),
              child: Row(
                children: [
                  Expanded(child: Text(l10n.briefSourceTitle, style: styles.navTitle)),
                  TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonDone)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(widget.item.text, style: styles.footnote),
            ),
            Expanded(child: _inText ? _text(context) : _attachment(context)),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: CupertinoButton(
                key: const Key('brief-evidence-show-original'),
                onPressed: widget.onShowOriginal,
                child: Text(l10n.briefShowOriginal),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(BuildContext context) {
    final text = widget.input.normalisedText;
    final styles = LoupeTextStyles.of(context);
    final highlight = CupertinoColors.systemYellow.resolveFrom(context).withValues(alpha: 0.35);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: groupFill(context), borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        controller: _scroll,
        padding: const EdgeInsets.all(14),
        child: SelectionArea(
          child: Text.rich(
            key: _textKey,
            TextSpan(
              children: [
                TextSpan(text: text.substring(0, _evidence.start)),
                TextSpan(
                  text: text.substring(_evidence.start, _evidence.end),
                  style: TextStyle(backgroundColor: highlight, fontWeight: FontWeight.w600),
                ),
                TextSpan(text: text.substring(_evidence.end)),
              ],
            ),
            style: styles.body.copyWith(fontSize: 15, height: 1.4),
          ),
        ),
      ),
    );
  }

  /// The attachment whose name the item quotes. The Brief never read it.
  Widget _attachment(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    final colors = LoupeColors.of(context);
    final name = _evidence.quote;
    final match = briefAttachments(widget.content)
        .where((a) => BriefInput.normaliseWhitespace(a.filename!) == name)
        .firstOrNull;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Icon(LoupeIcons.attachment, size: 18, color: colors.secondaryText),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(context.l10n.briefSourceAttachment, style: styles.body.copyWith(fontSize: 15))),
          ],
        ),
        if (match != null)
          AttachmentList(
            content: EmailContent(
              emailId: widget.content.emailId,
              attachments: [match],
              inlineData: widget.content.inlineData,
            ),
            load: widget.load,
          ),
      ],
    );
  }
}
