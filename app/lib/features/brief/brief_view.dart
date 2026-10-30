import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../ai/ai_providers.dart';
import '../calendar/invitation_card.dart' show invitationZoneProvider;
import '../conversation/security/assessment.dart';
import '../conversation/security/finding_text.dart';
import '../conversation/security/security_badge.dart';
import '../conversation/security/security_provider.dart';
import '../conversation/security/security_sheet.dart';
import '../conversation/sheets.dart';
import 'brief_calendar.dart';
import 'brief_checklist.dart';
import 'brief_evidence_sheet.dart';
import 'brief_input.dart';
import 'brief_tracker.dart';

/// "Brief" above a message body: shows what the message asks of the reader
/// in place of the body. Shown only while Private AI offers Brief for the
/// message; it is a new view, so it is a button people can see, as well as
/// a choice in the "Aa" sheet.
class BriefButton extends StatelessWidget {
  const BriefButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final accent = LoupeColors.of(context).unreadDot;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Semantics(
          button: true,
          hint: context.l10n.briefButtonHint,
          child: Material(
            color: accent.withValues(alpha: 0.12),
            shape: const StadiumBorder(),
            child: InkWell(
              key: const Key('brief-button'),
              customBorder: const StadiumBorder(),
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LoupeIcons.brief, size: 16, color: accent),
                    const SizedBox(width: 6),
                    Text(
                      context.l10n.briefButton,
                      style: TextStyle(color: accent, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// What a message asks of the reader, in place of its body: a short
/// summary, then the items by group (to do, documents to send, dates,
/// conditions, what happens next), each with how and when as the message
/// states them and a tap to the passage it comes from. Items can be ticked,
/// dismissed, copied, tracked or put in the calendar; Copy Checklist copies
/// them all.
///
/// The Brief is made on request, by [service], from the downloaded message.
/// It shows its provider, says when it read only part of the message, says
/// when there is nothing to summarise, and shows a failure as a failure: never
/// an empty or half checklist that looks complete. The security warning of
/// the message, if any, comes first. Show Original is always one tap away.
class BriefView extends ConsumerStatefulWidget {
  const BriefView({
    super.key,
    required this.message,
    required this.content,
    required this.service,
    required this.loadAttachment,
    required this.onShowOriginal,
    this.textScale = 1.0,
  });

  final EmailSummary message;
  final EmailContent content;
  final AiService service;
  final Future<Uint8List> Function(Attachment attachment) loadAttachment;

  /// Back to the message's own wording, in its usual view.
  final VoidCallback onShowOriginal;

  /// The "Aa" text size.
  final double textScale;

  @override
  ConsumerState<BriefView> createState() => _BriefViewState();
}

sealed class _Step {
  const _Step();
}

final class _Working extends _Step {
  const _Working();
}

/// The reader cancelled.
final class _Stopped extends _Step {
  const _Stopped();
}

final class _Finished extends _Step {
  const _Finished(this.source, this.run);
  final BriefSource source;
  final AiRun<Brief> run;
}

enum _ItemAction { done, dismiss, copy, calendar, track, source }

class _BriefViewState extends ConsumerState<BriefView> {
  _Step _step = const _Working();
  CancelToken? _cancel;

  /// Bumped by every start and cancel, so a run that ends late is ignored.
  int _generation = 0;
  bool _showDismissed = false;

  @override
  void initState() {
    super.initState();
    unawaited(_start(building: true));
  }

  @override
  void didUpdateWidget(BriefView old) {
    super.didUpdateWidget(old);
    if (!identical(old.content, widget.content) || old.service != widget.service) unawaited(_start(building: true));
  }

  @override
  void dispose() {
    _cancel?.cancel();
    super.dispose();
  }

  /// Reads the message and runs the task. Until its first wait it runs
  /// before a build ([building]: initState, didUpdateWidget), so a Brief made
  /// earlier shows at once, without a flash of the progress row.
  Future<void> _start({bool building = false}) async {
    _cancel?.cancel();
    final generation = ++_generation;
    final cancel = _cancel = CancelToken();
    var beforeBuild = building;
    void show(_Step step) {
      if (!mounted || generation != _generation) return;
      if (beforeBuild) {
        _step = step;
      } else {
        setState(() => _step = step);
      }
    }

    show(const _Working());
    final prepared = briefSource(widget.message, widget.content);
    final BriefSource source;
    if (prepared is BriefSource) {
      source = prepared;
    } else {
      beforeBuild = false;
      source = await prepared;
      if (!mounted || generation != _generation) return;
    }
    final today = DateTime.now();
    final zone = ref.read(invitationZoneProvider);
    final task = briefTaskFor(source.input, now: today, zone: zone?.ianaName);
    if (widget.service.cached(task) case final hit?) return show(_Finished(source, hit));
    beforeBuild = false;
    final run = await widget.service.run(task, cancel: cancel);
    final cancelled = run is AiFailure<Brief> && run.reason == AiFailureReason.cancelled;
    show(cancelled ? const _Stopped() : _Finished(source, run));
  }

  void _stop() {
    _cancel?.cancel();
    _generation++;
    setState(() => _step = const _Stopped());
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return MediaQuery(
      data: mq.copyWith(textScaler: _TimesTextScaler(mq.textScaler, widget.textScale.clamp(0.8, 1.6))),
      child: Builder(builder: _build),
    );
  }

  Widget _build(BuildContext context) {
    final step = _step;
    return Column(
      key: const Key('brief-view'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _header(context),
        _SecurityNotice(message: widget.message, content: widget.content),
        ...switch (step) {
          _Working() => [_working(context)],
          _Stopped() => [_stopped(context)],
          _Finished(:final source, run: AiSuccess<Brief>(:final value, :final record)) => _brief(
            context,
            source,
            value,
            record,
          ),
          _Finished(run: final AiFailure<Brief> failure) => [_failure(context, failure)],
        },
      ],
    );
  }

  Widget _header(BuildContext context) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(LoupeIcons.brief, size: 18, color: colors.unreadDot),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              l10n.briefTitle,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          // A long label wraps rather than pushing the title off.
          Flexible(
            flex: 2,
            child: CupertinoButton(
              key: const Key('brief-show-original'),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: const Size(44, 36),
              onPressed: widget.onShowOriginal,
              child: Text(l10n.briefShowOriginal, textAlign: TextAlign.end, style: const TextStyle(fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _working(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    return Row(
      key: const Key('brief-working'),
      children: [
        const CupertinoActivityIndicator(),
        const SizedBox(width: 10),
        Expanded(flex: 2, child: Text(context.l10n.briefWorking, style: styles.body.copyWith(fontSize: 16))),
        Flexible(
          child: CupertinoButton(
            key: const Key('brief-cancel'),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: const Size(44, 36),
            onPressed: _stop,
            child: Text(context.l10n.commonCancel, textAlign: TextAlign.end, style: const TextStyle(fontSize: 15)),
          ),
        ),
      ],
    );
  }

  Widget _stopped(BuildContext context) => _Notice(
    key: const Key('brief-stopped'),
    icon: LoupeIcons.info,
    text: context.l10n.briefStopped,
    action: (label: context.l10n.commonTryAgain, onPressed: () => unawaited(_start())),
  );

  /// A failure with its reason and Retry. Nothing else is shown in its place:
  /// no other provider is tried, and no partial list is kept.
  Widget _failure(BuildContext context, AiFailure<Brief> failure) {
    final l10n = context.l10n;
    final text = switch (failure.reason) {
      AiFailureReason.tooLarge => l10n.briefFailedTooLarge,
      AiFailureReason.invalidOutput => l10n.briefFailedInvalid,
      AiFailureReason.providerError || AiFailureReason.cancelled => l10n.briefFailedProvider,
    };
    // The parser's reason can quote what the model made up; the provider's
    // and the size check's say what to do about it.
    final detail = failure.reason == AiFailureReason.invalidOutput ? null : failure.message;
    return _Notice(
      key: const Key('brief-failed'),
      icon: LoupeIcons.error,
      text: text,
      detail: detail,
      action: (label: l10n.commonRetry, onPressed: () => unawaited(_start())),
    );
  }

  List<Widget> _brief(BuildContext context, BriefSource source, Brief brief, AiRunRecord record) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    final footer = [
      Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Text(_madeBy(l10n, record), key: const Key('brief-made-by'), style: styles.footnote),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(l10n.briefCaution, style: styles.footnote),
      ),
    ];
    if (brief.nothingToSummarise) {
      return [
        _Notice(
          key: const Key('brief-nothing'),
          icon: LoupeIcons.check,
          title: l10n.briefNothingTitle,
          text: brief.summary,
        ),
        ...footer,
      ];
    }
    final states = ref.watch(briefChecklistProvider.select((s) => s[widget.message.id])) ?? const {};
    BriefItemState stateOf(BriefItem item) => states[briefItemKey(item)] ?? BriefItemState.open;
    final dismissed = brief.items.where((i) => stateOf(i) == BriefItemState.dismissed).length;
    final sections = <Widget>[];
    for (final group in BriefGroup.values) {
      final items = [
        for (final (index, item) in brief.items.indexed)
          if (briefGroupOf(item) == group && (_showDismissed || stateOf(item) != BriefItemState.dismissed))
            (index, item),
      ];
      if (items.isEmpty) continue;
      sections.add(
        Padding(
          key: ValueKey('brief-section-${group.name}'),
          padding: const EdgeInsets.only(top: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(briefGroupTitle(l10n, group), style: styles.footnote.copyWith(fontWeight: FontWeight.w600)),
              for (final (index, item) in items)
                _ItemTile(
                  key: ValueKey('brief-item-$index'),
                  index: index,
                  item: item,
                  state: stateOf(item),
                  onToggleDone: () => _set(
                    item,
                    stateOf(item) == BriefItemState.done ? BriefItemState.open : BriefItemState.done,
                    from: stateOf(item),
                  ),
                  onShowSource: () => _showSource(source, item),
                  onMore: () => _more(source, item, stateOf(item)),
                ),
            ],
          ),
        ),
      );
    }
    return [
      Text(brief.summary, key: const Key('brief-summary'), style: styles.body.copyWith(fontSize: 16)),
      if (brief.partial || source.cut)
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: _Notice(key: const Key('brief-partial'), icon: LoupeIcons.warning, text: l10n.briefPartial),
        ),
      ...sections,
      if (dismissed > 0)
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: CupertinoButton(
            key: const Key('brief-toggle-dismissed'),
            padding: EdgeInsets.zero,
            minimumSize: const Size(44, 36),
            onPressed: () => setState(() => _showDismissed = !_showDismissed),
            child: Text(
              _showDismissed ? l10n.briefHideDismissed : l10n.briefShowDismissed(dismissed),
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: CupertinoButton(
            key: const Key('brief-copy-checklist'),
            padding: EdgeInsets.zero,
            minimumSize: const Size(44, 36),
            onPressed: () => _copy(
              briefChecklistText(l10n, message: widget.message, brief: brief, states: states),
              l10n.briefChecklistCopied,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(LoupeIcons.copy, size: 18),
                const SizedBox(width: 6),
                Flexible(child: Text(l10n.briefCopyChecklist, style: const TextStyle(fontSize: 15))),
              ],
            ),
          ),
        ),
      ),
      ...footer,
    ];
  }

  /// Which provider made the Brief. The demo says it is one, every time.
  String _madeBy(AppLocalizations l10n, AiRunRecord record) {
    if (record.providerId == 'demo') return l10n.briefMadeByDemo;
    final model = record.model;
    final name = model == null || record.providerId.contains(model)
        ? record.providerId
        : '${record.providerId} · $model';
    return l10n.briefMadeBy(widget.service.provider.location.name, name);
  }

  /// Ticks, unticks, dismisses or restores [item], with Undo back to [from].
  void _set(BriefItem item, BriefItemState to, {required BriefItemState from}) {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final checklist = ref.read(briefChecklistProvider.notifier);
    final id = widget.message.id;
    checklist.set(id, item, to);
    final said = switch (to) {
      BriefItemState.done => l10n.briefMarkedDone,
      BriefItemState.dismissed => l10n.briefDismissed,
      BriefItemState.open => null,
    };
    if (said == null) return;
    showSnack(
      messenger,
      said,
      action: SnackBarAction(label: l10n.commonUndo, onPressed: () => checklist.set(id, item, from)),
    );
  }

  void _copy(String text, String said) {
    unawaited(Clipboard.setData(ClipboardData(text: text)));
    showSnack(ScaffoldMessenger.of(context), said);
  }

  Future<void> _showSource(BriefSource source, BriefItem item) => showBriefEvidenceSheet(
    context,
    input: source.input,
    item: item,
    content: widget.content,
    load: widget.loadAttachment,
    onShowOriginal: widget.onShowOriginal,
  );

  Future<void> _more(BriefSource source, BriefItem item, BriefItemState state) async {
    final l10n = context.l10n;
    final tracker = ref.read(briefItemTrackerProvider);
    final trackable = tracker != null && item.owner == BriefOwner.me && tracker.canTrack(item);
    final action = await showActionSheet<_ItemAction>(
      context,
      title: item.text,
      actions: [
        SheetAction(state == BriefItemState.done ? l10n.briefMarkNotDone : l10n.briefMarkDone, _ItemAction.done),
        SheetAction(state == BriefItemState.dismissed ? l10n.briefRestore : l10n.briefDismiss, _ItemAction.dismiss),
        SheetAction(l10n.briefCopy, _ItemAction.copy),
        if (briefHasEvent(item)) SheetAction(l10n.briefAddToCalendar, _ItemAction.calendar),
        if (trackable) SheetAction(l10n.briefTrack, _ItemAction.track),
        SheetAction(l10n.briefShowInMessage, _ItemAction.source),
      ],
    );
    if (action == null || !mounted) return;
    switch (action) {
      case _ItemAction.done:
        _set(item, state == BriefItemState.done ? BriefItemState.open : BriefItemState.done, from: state);
      case _ItemAction.dismiss:
        _set(item, state == BriefItemState.dismissed ? BriefItemState.open : BriefItemState.dismissed, from: state);
      case _ItemAction.copy:
        _copy(briefItemText(l10n, item), l10n.briefItemCopied);
      case _ItemAction.calendar:
        await addBriefItemToCalendar(context, ref, item: item, message: widget.message);
      case _ItemAction.track:
        await _track(tracker!, item);
      case _ItemAction.source:
        await _showSource(source, item);
    }
  }

  Future<void> _track(BriefItemTracker tracker, BriefItem item) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final run = switch (_step) {
        _Finished(run: AiSuccess(:final record)) => record,
        _ => null,
      };
      await tracker.track(MessageRef.of(widget.message), item, run: run);
      showSnack(messenger, l10n.briefTracking(item.text));
    } on Object {
      showSnack(messenger, l10n.briefTrackFailed);
    }
  }
}

/// One item: a tick, its words, then how, when and who; a tap shows where it
/// comes from, and ⋯ has the rest.
class _ItemTile extends StatelessWidget {
  const _ItemTile({
    super.key,
    required this.index,
    required this.item,
    required this.state,
    required this.onToggleDone,
    required this.onShowSource,
    required this.onMore,
  });

  final int index;
  final BriefItem item;
  final BriefItemState state;
  final VoidCallback onToggleDone;
  final VoidCallback onShowSource;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final done = state == BriefItemState.done;
    final dismissed = state == BriefItemState.dismissed;
    final timing = briefTiming(l10n, item);
    final tags = [
      if (item.channel case final channel? when channel.isNotEmpty)
        _Tag(key: ValueKey('brief-channel-$index'), icon: LoupeIcons.openIn, text: channel, color: colors.unreadDot),
      if (timing != null)
        _Tag(
          key: ValueKey('brief-timing-$index'),
          icon: switch (item.due.kind) {
            DueKind.explicit => item.due.date == null ? LoupeIcons.time : LoupeIcons.calendar,
            DueKind.suggested => LoupeIcons.briefTarget,
            DueKind.conditional => LoupeIcons.briefAfterEvent,
            DueKind.none => LoupeIcons.time,
          },
          text: timing,
          color: item.due.kind == DueKind.none ? colors.secondaryText : colors.label,
        ),
      if (item.owner != BriefOwner.unknown)
        _Tag(
          key: ValueKey('brief-owner-$index'),
          icon: LoupeIcons.person,
          text: l10n.briefOwner(item.owner.name),
          color: colors.secondaryText,
        ),
    ];
    return Opacity(
      opacity: dismissed ? 0.5 : 1,
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              button: true,
              checked: done,
              label: done ? l10n.briefMarkNotDone : l10n.briefMarkDone,
              excludeSemantics: true,
              child: InkResponse(
                key: ValueKey('brief-check-$index'),
                onTap: onToggleDone,
                radius: 20,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 8, 2),
                  child: Icon(
                    done ? LoupeIcons.selected : LoupeIcons.unselected,
                    size: 22,
                    color: done ? colors.unreadDot : colors.secondaryText,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Semantics(
                button: true,
                hint: l10n.briefShowInMessage,
                child: InkWell(
                  key: ValueKey('brief-source-$index'),
                  onTap: onShowSource,
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.text,
                          style: styles.body.copyWith(
                            fontSize: 16,
                            color: done ? colors.secondaryText : null,
                            decoration: done ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        if (tags.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Wrap(spacing: 6, runSpacing: 4, children: tags),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              key: ValueKey('brief-more-$index'),
              tooltip: l10n.commonMore,
              visualDensity: VisualDensity.compact,
              icon: Icon(LoupeIcons.more, size: 20, color: colors.secondaryText),
              onPressed: onMore,
            ),
          ],
        ),
      ),
    );
  }
}

/// A small label under an item: its channel, timing or owner.
class _Tag extends StatelessWidget {
  const _Tag({super.key, required this.icon, required this.text, required this.color});

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Flexible(
          child: Text(text, style: TextStyle(fontSize: 13, color: color)),
        ),
      ],
    ),
  );
}

/// A tinted box with an icon and a line or two, and an optional button.
class _Notice extends StatelessWidget {
  const _Notice({super.key, required this.icon, required this.text, this.title, this.detail, this.action});

  final IconData icon;
  final String? title;
  final String text;
  final String? detail;
  final ({String label, VoidCallback onPressed})? action;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Container(
      decoration: BoxDecoration(color: subtleFill(context), borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(icon, size: 18, color: colors.secondaryText),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) Text(title!, style: styles.body.copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
                if (text.isNotEmpty) Text(text, style: styles.body.copyWith(fontSize: 15)),
                if (detail case final d? when d.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(d, style: styles.footnote),
                  ),
                if (action case final a?)
                  CupertinoButton(
                    key: const Key('brief-retry'),
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(44, 36),
                    onPressed: a.onPressed,
                    child: Text(a.label, style: const TextStyle(fontSize: 15)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The message's security warning above its Brief: a Brief lists what the
/// message asks, a scam's requests included, so the reason to doubt them
/// comes first. The same check as the reader's badge and phishing banner.
class _SecurityNotice extends ConsumerWidget {
  const _SecurityNotice({required this.message, required this.content});

  final EmailSummary message;
  final EmailContent content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(securityReportProvider(SecurityKey(message, content))).value;
    if (report == null || report.verdict == Verdict.noIssues) return const SizedBox.shrink();
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    final style = verdictStyle(context, report);
    final top = report.concerns.firstOrNull ?? report.findings.firstOrNull;
    final title = report.verdict == Verdict.likelyPhishing
        ? l10n.conversationSecurityPhishingTitle
        : l10n.conversationSecurityCarefulTitle;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        key: const Key('brief-security'),
        decoration: BoxDecoration(
          color: style.color.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: style.color.withValues(alpha: 0.25), width: 0.5),
        ),
        padding: const EdgeInsets.fromLTRB(12, 10, 8, 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Icon(style.icon, size: 18, color: style.color),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: styles.body.copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text(
                    top == null ? l10n.briefSecurityText : l10n.briefSecurityReason(findingText(l10n, top).title),
                    style: styles.body.copyWith(fontSize: 15, color: LoupeColors.of(context).secondaryText),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () => showSecuritySheet(context, report),
                      child: Text(l10n.conversationPhishingWhy),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The platform's text scale (which may be nonlinear) times the "Aa" size.
final class _TimesTextScaler extends TextScaler {
  const _TimesTextScaler(this.base, this.factor);

  final TextScaler base;
  final double factor;

  @override
  double scale(double fontSize) => base.scale(fontSize) * factor;

  @override
  double get textScaleFactor => scale(14) / 14;

  @override
  bool operator ==(Object other) => other is _TimesTextScaler && other.base == base && other.factor == factor;

  @override
  int get hashCode => Object.hash(base, factor);
}
