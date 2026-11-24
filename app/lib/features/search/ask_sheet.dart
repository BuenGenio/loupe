import 'package:expr_search/expr_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail_ai/mail_ai.dart';

import '../../l10n/l10n.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import 'search_session.dart';

/// Whether a query reads like a sentence rather than the search language:
/// three words or more, and no operator or keyword in it. Only then is Ask in
/// Plain English offered; a typed expression is never rewritten.
bool looksLikeASentence(String query, ParsedQuery parsed) {
  final words = query.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
  if (words < 3) return false;
  return !parsed.tokens.any((t) => t.kind == QueryTokenKind.operatorName || t.kind == QueryTokenKind.keyword);
}

/// Shows what the provider made of [sentence]: the interpretation, the
/// expression and its chips, with one button to put it in the search field,
/// where it is editable like any typed query. Returns the expression the
/// user chose to use, or null. Questions and failures are shown as such;
/// nothing runs until the user says so.
Future<String?> showAskSheet(
  BuildContext context, {
  required String sentence,
  required String providerId,
  required Future<AiRun<SearchTranslation>> Function() run,
}) => showModalBottomSheet<String>(
  context: context,
  useSafeArea: true,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (_) => _AskSheet(sentence: sentence, providerId: providerId, run: run),
);

class _AskSheet extends StatefulWidget {
  const _AskSheet({required this.sentence, required this.providerId, required this.run});

  final String sentence;
  final String providerId;
  final Future<AiRun<SearchTranslation>> Function() run;

  @override
  State<_AskSheet> createState() => _AskSheetState();
}

class _AskSheetState extends State<_AskSheet> {
  late Future<AiRun<SearchTranslation>> _run = widget.run();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    final colors = LoupeColors.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LoupeIcons.ask, size: 20, color: colors.unreadDot),
                const SizedBox(width: 8),
                Expanded(child: Text(l10n.searchAskPlainEnglish, style: styles.navTitle)),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(44, 32),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.commonDone),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 16),
              child: Text('“${widget.sentence}”', style: styles.footnote),
            ),
            FutureBuilder<AiRun<SearchTranslation>>(
              future: _run,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Row(
                    children: [
                      const CupertinoActivityIndicator(),
                      const SizedBox(width: 10),
                      Expanded(child: Text(l10n.searchAskWorking, style: styles.body)),
                    ],
                  );
                }
                return switch (snapshot.data) {
                  AiSuccess(:final value) when value.needsAnswer => _questions(value),
                  AiSuccess(:final value) => _proposal(value),
                  AiFailure(:final message) => _failure(message),
                  null => _failure(snapshot.error?.toString() ?? ''),
                };
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _proposal(SearchTranslation value) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    final colors = LoupeColors.of(context);
    final expression = value.expression!;
    final terms = queryTerms(value.expr!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.searchAskProposed, style: styles.sectionHeader),
        if (value.interpretation.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(value.interpretation, style: styles.body),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(color: colors.cellBackground, borderRadius: BorderRadius.circular(10)),
            child: SelectableText(expression, style: styles.body.copyWith(fontFamily: 'monospace')),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final term in terms)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colors.unreadDot.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  describeTerm(term),
                  style: TextStyle(color: colors.unreadDot, fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton.filled(
            onPressed: () => Navigator.of(context).pop(expression),
            child: Text(l10n.searchAskUse),
          ),
        ),
        _footnote(),
      ],
    );
  }

  Widget _questions(SearchTranslation value) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.searchAskNeedsAnswer, style: styles.sectionHeader),
        for (final q in value.questions)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text('• $q', style: styles.body),
          ),
        _footnote(),
      ],
    );
  }

  Widget _failure(String message) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.searchAskFailed, style: styles.body),
        if (message.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(message, style: styles.footnote),
          ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => setState(() => _run = widget.run()),
            child: Text(l10n.commonRetry),
          ),
        ),
      ],
    );
  }

  /// Which provider answered. The demo says it is one, every time.
  Widget _footnote() {
    final styles = LoupeTextStyles.of(context);
    final text = widget.providerId == 'demo' ? context.l10n.searchAskDemoNote : widget.providerId;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(text, style: styles.footnote),
    );
  }
}
