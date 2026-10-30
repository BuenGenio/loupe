import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../../l10n/l10n.dart';
import '../../../theme/loupe_icons.dart';
import '../../../theme/theme.dart';
import '../../ai/ai_providers.dart';
import '../sheets.dart';
import 'change_passages_sheet.dart';
import 'email_diff.dart';

/// What Changed's task for a literal comparison: the compared text of both
/// messages, with sender and date, and the diff's removed and added lines as
/// the evidence. Attachments stay out: they are compared by metadata only.
ChangeExplanationTask explainChangesTask(EmailDiff diff, {required EmailSummary from, required EmailSummary to}) =>
    ChangeExplanationTask(
      before: ChangeSource(from: _sender(from), date: from.sentAt ?? from.receivedAt, text: diff.body.beforeText),
      after: ChangeSource(from: _sender(to), date: to.sentAt ?? to.receivedAt, text: diff.body.afterText),
      removedLines: [
        for (final line in diff.body.lines)
          if (line.kind == EmailDiffKind.removed) line.text,
      ],
      addedLines: [
        for (final line in diff.body.lines)
          if (line.kind == EmailDiffKind.added) line.text,
      ],
    );

String _sender(EmailSummary message) => switch (message.sender) {
  EmailAddress(:final email, name: final name?) when name.trim().isNotEmpty => '$name <$email>',
  EmailAddress(:final email) => email,
  null => '',
};

/// The kinds in the order they are listed: a conflict first, so it isn't
/// missed, and what is no longer mentioned last.
const _order = [ChangeKind.contradiction, ChangeKind.changed, ChangeKind.added, ChangeKind.removed];

/// What Changed, above the exact line diff: Private AI explains the changed
/// facts, each opening both passages in their messages. It runs only when
/// asked, and once per pair and provider (AiService keeps the result). A
/// failure says why and offers Retry; nothing else is asked instead.
class WhatChangedSection extends StatefulWidget {
  const WhatChangedSection({
    super.key,
    required this.service,
    required this.diff,
    required this.from,
    required this.to,
  });

  final AiService service;
  final EmailDiff diff;
  final EmailSummary from;
  final EmailSummary to;

  @override
  State<WhatChangedSection> createState() => _WhatChangedSectionState();
}

// Kept alive: the comparison list builds rows lazily, and scrolling to the
// line diff must not lose a running or finished explanation.
class _WhatChangedSectionState extends State<WhatChangedSection> with AutomaticKeepAliveClientMixin {
  late final ChangeExplanationTask _task = explainChangesTask(widget.diff, from: widget.from, to: widget.to);
  late AiRun<ChangeExplanation>? _run = widget.service.cached(_task);
  CancelToken? _cancel;

  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(WhatChangedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.service, widget.service)) {
      _cancel?.cancel();
      _cancel = null;
      _run = widget.service.cached(_task);
    }
  }

  @override
  void dispose() {
    _cancel?.cancel();
    super.dispose();
  }

  Future<void> _explain() async {
    final cancel = CancelToken();
    setState(() {
      _cancel = cancel;
      _run = null;
    });
    final run = await widget.service.run(_task, cancel: cancel);
    if (!mounted || !identical(cancel, _cancel)) return;
    setState(() {
      _cancel = null;
      _run = run is AiFailure<ChangeExplanation> && run.reason == AiFailureReason.cancelled ? null : run;
    });
  }

  void _stop() {
    _cancel?.cancel();
    setState(() => _cancel = null);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colors = LoupeColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LoupeIcons.ask, size: 18, color: colors.unreadDot),
              const SizedBox(width: 6),
              Expanded(child: Text(context.l10n.changesExplainTitle, style: LoupeTextStyles.of(context).sectionHeader)),
            ],
          ),
          const SizedBox(height: 8),
          ...switch ((_cancel, _run)) {
            (_?, _) => [_working()],
            (null, AiSuccess(:final value, :final record)) => _explanation(value, record),
            (null, AiFailure(:final reason, :final message)) => _failure(reason, message),
            (null, null) => _offer(),
          },
        ],
      ),
    );
  }

  List<Widget> _offer() {
    final l10n = context.l10n;
    return [
      Text(l10n.changesExplainIntro, style: TextStyle(color: LoupeColors.of(context).secondaryText)),
      const SizedBox(height: 10),
      CupertinoButton.tinted(
        key: const ValueKey('explain-changes'),
        sizeStyle: CupertinoButtonSize.medium,
        onPressed: _explain,
        child: Text(l10n.changesExplainAction),
      ),
    ];
  }

  Widget _working() => Row(
    children: [
      const CupertinoActivityIndicator(),
      const SizedBox(width: 10),
      Expanded(child: Text(context.l10n.changesExplainWorking, style: LoupeTextStyles.of(context).body)),
      CupertinoButton(
        padding: EdgeInsets.zero,
        minimumSize: const Size(44, 32),
        onPressed: _stop,
        child: Text(context.l10n.commonCancel),
      ),
    ],
  );

  List<Widget> _failure(AiFailureReason reason, String message) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    return [
      Text(l10n.changesExplainFailed, style: styles.body),
      Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(switch (reason) {
          AiFailureReason.tooLarge => l10n.changesExplainTooLarge,
          AiFailureReason.providerError || AiFailureReason.cancelled => l10n.changesExplainProviderError,
          AiFailureReason.invalidOutput => l10n.changesExplainInvalid,
        }, style: styles.footnote),
      ),
      // The provider's or the parser's own words, like a server's error.
      if (message.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(message, style: styles.footnote),
        ),
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: CupertinoButton(padding: EdgeInsets.zero, onPressed: _explain, child: Text(l10n.commonRetry)),
      ),
    ];
  }

  List<Widget> _explanation(ChangeExplanation explanation, AiRunRecord record) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    final colors = LoupeColors.of(context);
    final changes = [for (final kind in _order) ...explanation.changes.where((c) => c.kind == kind)];
    final rows = <Widget>[];
    for (final (i, change) in changes.indexed) {
      if (i > 0) rows.add(Divider(height: 1, indent: 12, color: colors.separator));
      rows.add(
        _ChangeRow(
          key: ValueKey('change-$i'),
          change: change,
          onTap: () => showChangePassagesSheet(context, change: change, task: _task, from: widget.from, to: widget.to),
        ),
      );
    }
    final notes = [
      if (explanation.partial) l10n.changesExplainPartial,
      if (_task.before.hasQuotedLines || _task.after.hasQuotedLines) l10n.changesExplainQuotedNote,
      if (_task.before.mayQuoteUnmarked || _task.after.mayQuoteUnmarked) l10n.changesExplainUnmarkedQuoteNote,
      if (changes.isNotEmpty) l10n.changesExplainCheckNote,
      l10n.changesExplainAttachmentNote,
      if (record.providerId == 'demo')
        l10n.changesExplainDemoNote
      else
        l10n.changesExplainMadeBy(record.model == null ? record.providerId : '${record.providerId} · ${record.model}'),
    ];
    return [
      Text(explanation.summary, style: styles.body),
      if (explanation.noChangeInMeaning)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(l10n.changesExplainNoChange, style: TextStyle(color: colors.secondaryText)),
        ),
      if (rows.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Material(
            color: groupFill(context),
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: Column(mainAxisSize: MainAxisSize.min, children: rows),
          ),
        ),
      for (final note in notes)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(note, style: styles.footnote),
        ),
    ];
  }
}

/// The colour that marks a kind, as in the line diff: new in green, a
/// conflict in orange, what is no longer mentioned in grey.
Color changeKindColor(BuildContext context, ChangeKind kind) {
  final colors = LoupeColors.of(context);
  return switch (kind) {
    ChangeKind.changed => colors.unreadDot,
    ChangeKind.added => colors.success,
    ChangeKind.removed => colors.secondaryText,
    ChangeKind.contradiction => colors.flag,
  };
}

/// A change's values as one line: "before → after", the new or the earlier
/// wording alone, or the two conflicting ones.
String changeValues(BuildContext context, ExplainedChange change) {
  final l10n = context.l10n;
  return switch (change.kind) {
    ChangeKind.changed => l10n.changesExplainValues(change.before!, change.after!),
    ChangeKind.added => change.after!,
    ChangeKind.removed => change.before!,
    ChangeKind.contradiction => l10n.changesExplainConflictValues(change.before!, change.after!),
  };
}

class _ChangeRow extends StatelessWidget {
  const _ChangeRow({super.key, required this.change, required this.onTap});

  final ExplainedChange change;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.changesExplainKind(change.kind.name),
                    style: styles.caption.copyWith(
                      color: changeKindColor(context, change.kind),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(change.label, style: styles.body.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(changeValues(context, change), style: styles.body, maxLines: 4, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Icon(LoupeIcons.disclosure, size: 18, color: LoupeColors.of(context).tertiaryText),
          ],
        ),
      ),
    );
  }
}
