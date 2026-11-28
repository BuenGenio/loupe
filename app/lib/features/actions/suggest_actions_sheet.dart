import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../ai/ai_providers.dart';
import '../compose/compose_text.dart';
import '../conversation/sheets.dart';
import '../openpgp/content_loader.dart';
import 'action_providers.dart';
import 'action_text.dart';
import 'action_widgets.dart';
import 'brief_actions.dart';

/// Suggest Actions: Private AI reads [message] (the Brief task, through
/// [service]) and offers what it asks of the user and what its sender
/// promised, each with the passage it quotes. Nothing is tracked until the
/// user adds it; what is tracked already is marked so, and an action the
/// user deleted isn't offered again. Quoted earlier mail never counts: the
/// task's parser rejects passages found only in `>` lines.
Future<void> suggestActionsFor(BuildContext context, EmailSummary message, AiService service) => showLoupeSheet<void>(
  context,
  expand: true,
  builder: (_) => _SuggestSheet(message: message, service: service),
);

/// What Suggest Actions found in one message.
final class _Found {
  const _Found({required this.suggestions, required this.origin, required this.partial});

  final List<ActionSuggestion> suggestions;
  final ActionOrigin origin;
  final bool partial;
}

class _SuggestSheet extends ConsumerStatefulWidget {
  const _SuggestSheet({required this.message, required this.service});

  final EmailSummary message;
  final AiService service;

  @override
  ConsumerState<_SuggestSheet> createState() => _SuggestSheetState();
}

class _SuggestSheetState extends ConsumerState<_SuggestSheet> {
  final _cancel = CancelToken();
  late Future<_Found> _found = _run();

  /// What this sheet added or updated, by suggestion: the record as it was
  /// before (null for one it added), so Undo can put it back.
  final _done = <int, ({String id, ActionRecord? before})>{};

  @override
  void dispose() {
    _cancel.cancel();
    super.dispose();
  }

  Future<_Found> _run() async {
    final m = widget.message;
    final tracker = ref.read(actionTrackerProvider);
    final fromMe = await tracker.isFromMe(m);
    final content = await ref.read(contentLoaderProvider).loadContent(m.id);
    final input = briefInputOf(
      m,
      ComposeText.plainTextOf(content),
      attachments: [
        for (final a in content.attachments)
          if (!a.isInline && a.filename != null) a.filename!,
      ],
    );
    final now = clock.now();
    final run = await widget.service.run(
      BriefTask(input, now: now, timeZone: now.timeZoneName),
      cancel: _cancel,
    );
    return switch (run) {
      AiSuccess(:final value, :final record) => _Found(
        suggestions: [for (final item in value.items) ?suggestionFromBriefItem(item, fromMe: fromMe)],
        origin: actionOriginOf(record),
        partial: value.partial,
      ),
      AiFailure(:final reason) => throw _Failed(reason),
    };
  }

  Future<void> _add(int i, ActionSuggestion s, ActionOrigin origin) async {
    final tracker = ref.read(actionTrackerProvider);
    final record = tracker.accepted(MessageRef.of(widget.message), s, origin);
    unawaited(HapticFeedback.lightImpact());
    await tracker.save([record]);
    if (mounted) setState(() => _done[i] = (id: record.id, before: null));
  }

  Future<void> _update(int i, ActionSuggestion s, ActionOrigin origin, ActionRecord match) async {
    final tracker = ref.read(actionTrackerProvider);
    unawaited(HapticFeedback.lightImpact());
    await tracker.save([match.revisedBy(s, origin, tracker.now())]);
    if (mounted) setState(() => _done[i] = (id: match.id, before: match));
  }

  Future<void> _undo(int i) async {
    final done = _done[i];
    if (done == null) return;
    final tracker = ref.read(actionTrackerProvider);
    final before = done.before;
    before == null ? await tracker.forget([done.id]) : await tracker.save([before]);
    if (mounted) setState(() => _done.remove(i));
  }

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    return FutureBuilder<_Found>(
      future: _found,
      builder: (context, snapshot) {
        final header = _header(context);
        if (snapshot.connectionState != ConnectionState.done) {
          return ListView(
            controller: PrimaryScrollController.maybeOf(context),
            children: [
              header,
              const Padding(padding: EdgeInsets.all(32), child: CupertinoActivityIndicator()),
            ],
          );
        }
        final error = snapshot.error;
        if (error != null || !snapshot.hasData) {
          return ListView(
            controller: PrimaryScrollController.maybeOf(context),
            children: [
              header,
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 8),
                child: Text(
                  _failure(l10n, error),
                  key: const Key('suggest-failed'),
                  style: styles.body,
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: CupertinoButton(
                  onPressed: () => setState(() => _found = _run()),
                  child: Text(l10n.commonTryAgain),
                ),
              ),
            ],
          );
        }
        return _list(context, snapshot.data!);
      },
    );
  }

  /// The title, who made the suggestions, and [trailing] (Add All).
  Widget _header(BuildContext context, {Widget? trailing}) {
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LoupeIcons.suggestActions, size: 20, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(child: Text(l10n.actionsSuggestTitle, style: styles.navTitle)),
              ?trailing,
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: Text(suggestionsByLabel(l10n, widget.service.provider), style: styles.footnote),
          ),
        ],
      ),
    );
  }

  String _failure(AppLocalizations l10n, Object? error) => switch (error) {
    _Failed(reason: AiFailureReason.tooLarge) => l10n.actionsSuggestTooLarge,
    _Failed(reason: AiFailureReason.invalidOutput) => l10n.actionsSuggestInvalid,
    _Failed(reason: AiFailureReason.cancelled) => l10n.actionsSuggestCancelled,
    MailException(:final message) => message,
    _ => l10n.actionsSuggestFailed,
  };

  Widget _list(BuildContext context, _Found found) {
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final existing = ref.watch(allActionsProvider).value ?? const <ActionRecord>[];
    final source = MessageRef.of(widget.message);
    final tracker = ref.read(actionTrackerProvider);
    final rows = <Widget>[];
    final fresh = <(int, ActionSuggestion)>[];
    for (final (i, s) in found.suggestions.indexed) {
      final (status, match) = suggestionStatus(s, source, existing);
      if (status == SuggestionStatus.removed && !_done.containsKey(i)) continue;
      if (status == SuggestionStatus.fresh) fresh.add((i, s));
      rows.add(
        _SuggestionRow(
          key: ValueKey('suggestion-$i'),
          preview: ActionRecord.suggested(
            id: 'preview-$i',
            source: source,
            suggestion: s,
            origin: found.origin,
            at: tracker.now(),
          ),
          status: status,
          justDone: _done.containsKey(i),
          onAdd: () => _add(i, s, found.origin),
          onUpdate: match == null ? null : () => _update(i, s, found.origin, match),
          onUndo: () => _undo(i),
        ),
      );
    }
    Future<void> addAll() async {
      final added = [for (final (_, s) in fresh) tracker.accepted(source, s, found.origin)];
      unawaited(HapticFeedback.lightImpact());
      await tracker.save(added);
      if (!mounted) return;
      setState(() {
        for (final (j, (i, _)) in fresh.indexed) {
          _done[i] = (id: added[j].id, before: null);
        }
      });
    }

    return ListView(
      controller: PrimaryScrollController.maybeOf(context),
      padding: EdgeInsets.only(bottom: 16 + MediaQuery.paddingOf(context).bottom),
      children: [
        _header(
          context,
          trailing: fresh.length < 2
              ? null
              : CupertinoButton(
                  key: const Key('suggest-add-all'),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(44, 36),
                  onPressed: addAll,
                  child: Text(
                    l10n.actionsSuggestAddAll(fresh.length),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
        ),
        if (found.partial)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text(l10n.actionsSuggestPartial, style: styles.footnote),
          ),
        if (rows.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: Text(
              l10n.actionsSuggestNone,
              key: const Key('suggest-none'),
              style: styles.body,
              textAlign: TextAlign.center,
            ),
          )
        else
          SheetGroup(children: rows),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 4, 32, 0),
          child: Text(l10n.actionsSuggestFootnote, style: styles.footnote, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}

/// A Brief run that failed, for the sheet to say why.
final class _Failed implements Exception {
  const _Failed(this.reason);
  final AiFailureReason reason;
}

/// One suggestion: who acts, the words, the quoted passage, its timing, and
/// Add (or Update, or Tracked, and Undo once it was added here).
class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({
    super.key,
    required this.preview,
    required this.status,
    required this.justDone,
    required this.onAdd,
    required this.onUpdate,
    required this.onUndo,
  });

  /// The suggestion as an action, not saved.
  final ActionRecord preview;
  final SuggestionStatus status;

  /// Added or updated from this sheet: Undo is offered.
  final bool justDone;
  final VoidCallback onAdd;
  final VoidCallback? onUpdate;
  final VoidCallback onUndo;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final Widget trailing;
    if (justDone) {
      trailing = CupertinoButton(
        key: const Key('suggestion-undo'),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minimumSize: const Size(44, 36),
        onPressed: onUndo,
        child: Text(l10n.commonUndo),
      );
    } else {
      trailing = switch (status) {
        SuggestionStatus.fresh => CupertinoButton(
          key: const Key('suggestion-add'),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          minimumSize: const Size(44, 36),
          onPressed: onAdd,
          child: Text(l10n.commonAdd, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        SuggestionStatus.update => CupertinoButton(
          key: const Key('suggestion-update'),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          minimumSize: const Size(44, 36),
          onPressed: onUpdate,
          child: Text(l10n.actionsSuggestUpdate),
        ),
        SuggestionStatus.tracked || SuggestionStatus.removed => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(l10n.actionsSuggestTracked, style: styles.footnote),
        ),
      };
    }
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 4, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              preview.owner == ActionOwner.me ? LoupeIcons.needsMyAction : LoupeIcons.waitingOnOthers,
              size: 20,
              color: colors.unreadDot,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(actionOwnerLabel(l10n, preview.owner), style: styles.caption),
                Text(preview.currentRequest, style: styles.body.copyWith(color: colors.label)),
                const SizedBox(height: 3),
                Text(
                  l10n.actionsQuote(preview.quote),
                  style: styles.footnote.copyWith(fontStyle: FontStyle.italic),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                ActionFacts(action: preview),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
