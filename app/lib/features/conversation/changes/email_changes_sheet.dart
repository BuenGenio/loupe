import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import '../../../l10n/l10n.dart';
import '../../../shared/format.dart';
import '../../../theme/loupe_icons.dart';
import '../../../theme/theme.dart';
import '../sheets.dart';
import 'email_diff.dart';

/// An explicit comparison of two messages. Read flags are deliberately not
/// used as a review checkpoint: opening a conversation already changes them.
Future<void> showEmailChangesSheet(
  BuildContext context, {
  required List<EmailSummary> messages,
  required String initialEmailId,
  required Future<EmailContent> Function(EmailSummary message) loadContent,
}) => showLoupeSheet<void>(
  context,
  expand: true,
  builder: (_) => EmailChangesSheet(messages: messages, initialEmailId: initialEmailId, loadContent: loadContent),
);

EmailDiff _compare((EmailContent, EmailContent) input) => compareEmailContent(input.$1, input.$2);

/// Only bodies and attachment descriptions cross the comparison isolate.
/// Inline image bytes, raw headers and credentials are not needed here.
EmailContent _input(EmailContent content) => EmailContent(
  emailId: content.emailId,
  text: content.text,
  html: content.html,
  isFlowed: content.isFlowed,
  attachments: content.attachments,
);

class EmailChangesSheet extends StatefulWidget {
  const EmailChangesSheet({super.key, required this.messages, required this.initialEmailId, required this.loadContent})
    : assert(messages.length >= 2);

  final List<EmailSummary> messages;
  final String initialEmailId;
  final Future<EmailContent> Function(EmailSummary message) loadContent;

  @override
  State<EmailChangesSheet> createState() => _EmailChangesSheetState();
}

class _EmailChangesSheetState extends State<EmailChangesSheet> {
  late final List<EmailSummary> _messages;
  late String _fromId;
  late String _toId;
  late Future<EmailDiff> _comparison;

  @override
  void initState() {
    super.initState();
    _messages = List.of(widget.messages)
      ..sort((a, b) {
        final order = a.receivedAt.compareTo(b.receivedAt);
        return order == 0 ? a.id.compareTo(b.id) : order;
      });
    final index = _messages.indexWhere((m) => m.id == widget.initialEmailId);
    final target = index < 0 ? _messages.length - 1 : index;
    if (target == 0) {
      _fromId = _messages.first.id;
      _toId = _messages[1].id;
    } else {
      _toId = _messages[target].id;
      final sender = _messages[target].sender?.email.toLowerCase();
      final sameSender = sender == null
          ? null
          : _messages.take(target).where((m) => m.sender?.email.toLowerCase() == sender).lastOrNull;
      _fromId = (sameSender ?? _messages[target - 1]).id;
    }
    _comparison = _load();
  }

  Future<EmailDiff> _load() async {
    final from = _messages.firstWhere((m) => m.id == _fromId);
    final to = _messages.firstWhere((m) => m.id == _toId);
    final contents = await Future.wait([widget.loadContent(from), widget.loadContent(to)]);
    return compute(_compare, (_input(contents[0]), _input(contents[1])));
  }

  void _select({String? from, String? to}) {
    setState(() {
      _fromId = from ?? _fromId;
      _toId = to ?? _toId;
      _comparison = _load();
    });
  }

  Widget _picker({required bool from}) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        key: ValueKey(from ? 'changes-from' : 'changes-to'),
        initialValue: from ? _fromId : _toId,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: from ? l10n.conversationChangesFrom : l10n.conversationChangesTo,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        items: [
          for (final message in _messages)
            if (message.id != (from ? _toId : _fromId))
              DropdownMenuItem(
                value: message.id,
                child: Text(
                  '${message.sender?.displayName ?? l10n.conversationNoSender} · '
                  '${formatFullDate(message.sentAt ?? message.receivedAt, l10n: l10n)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        ],
        onChanged: (id) {
          if (id != null) _select(from: from ? id : null, to: from ? null : id);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
          child: Row(
            children: [
              Expanded(child: Text(l10n.conversationChangesTitle, style: LoupeTextStyles.of(context).navTitle)),
              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonDone)),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<EmailDiff>(
            future: _comparison,
            builder: (context, snapshot) {
              final rows = <Widget>[_picker(from: true), _picker(from: false)];
              if (snapshot.connectionState != ConnectionState.done) {
                rows.add(
                  const Center(
                    child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()),
                  ),
                );
              } else if (snapshot.hasError) {
                rows.addAll([
                  Text(l10n.conversationChangesLoadError),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton(onPressed: () => _select(), child: Text(l10n.commonRetry)),
                  ),
                ]);
              } else if (snapshot.data case final diff?) {
                rows.addAll(_result(diff));
              }
              return SelectionArea(
                child: ListView.builder(
                  controller: PrimaryScrollController.maybeOf(context),
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                  itemCount: rows.length,
                  itemBuilder: (_, i) => rows[i],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _result(EmailDiff diff) {
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    final body = diff.body;
    return [
      if (!body.isTruncated)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(l10n.conversationChangesFullTextNote, style: TextStyle(color: colors.secondaryText)),
        ),
      if (body.isTruncated || body.usedFallback)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(l10n.conversationChangesLimited, style: TextStyle(color: colors.secondaryText)),
        ),
      Text(l10n.conversationChangesText, style: LoupeTextStyles.of(context).sectionHeader),
      const SizedBox(height: 8),
      if (!body.hasChanges && !body.isTruncated)
        Text(l10n.conversationChangesNoText)
      else if (body.hasChanges) ...[
        Wrap(
          spacing: 16,
          children: [
            Text(l10n.conversationChangesRemoved, style: TextStyle(color: colors.destructive)),
            Text(l10n.conversationChangesAdded, style: TextStyle(color: colors.success)),
          ],
        ),
        const SizedBox(height: 8),
        for (final line in body.lines) _DiffRow(line: line),
      ],
      if (diff.attachments.added.isNotEmpty ||
          diff.attachments.removed.isNotEmpty ||
          diff.attachments.matchingMetadata.isNotEmpty) ...[
        const SizedBox(height: 24),
        Text(l10n.conversationChangesAttachments, style: LoupeTextStyles.of(context).sectionHeader),
        const SizedBox(height: 8),
        Text(l10n.conversationChangesAttachmentNote, style: TextStyle(color: colors.secondaryText)),
        for (final attachment in diff.attachments.removed)
          _attachment(attachment, l10n.conversationChangesRemoved, colors.destructive),
        for (final attachment in diff.attachments.added)
          _attachment(attachment, l10n.conversationChangesAdded, colors.success),
        for (final match in diff.attachments.matchingMetadata)
          _attachment(match.after, l10n.conversationChangesSameMetadata, colors.secondaryText),
      ],
    ];
  }

  Widget _attachment(Attachment attachment, String label, Color color) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LoupeIcons.attachment, size: 18, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${attachment.filename ?? l10n.conversationAttachmentUntitled}\n'
              '$label · ${attachment.mimeType} · ${formatBytes(attachment.size, l10n: l10n)}',
            ),
          ),
        ],
      ),
    );
  }
}

class _DiffRow extends StatelessWidget {
  const _DiffRow({required this.line});
  final EmailDiffLine line;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final (prefix, label, color) = switch (line.kind) {
      EmailDiffKind.added => ('+', l10n.conversationChangesAdded, colors.success),
      EmailDiffKind.removed => ('−', l10n.conversationChangesRemoved, colors.destructive),
      EmailDiffKind.equal => (' ', '', colors.label),
    };
    return Semantics(
      label: label,
      child: ColoredBox(
        color: line.kind == EmailDiffKind.equal ? colors.cellBackground : color.withValues(alpha: 0.10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExcludeSemantics(
                child: SizedBox(
                  width: 20,
                  child: Text(prefix, style: TextStyle(color: color)),
                ),
              ),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      for (final span in line.spans)
                        TextSpan(
                          text: span.text,
                          style: TextStyle(
                            backgroundColor: span.kind == EmailDiffKind.equal ? null : color.withValues(alpha: 0.20),
                            decoration: span.kind == EmailDiffKind.removed ? TextDecoration.lineThrough : null,
                          ),
                        ),
                    ],
                  ),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
