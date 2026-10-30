import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_documents/mail_documents.dart';

import '../../l10n/l10n.dart';
import '../../router.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../ai/ai_providers.dart';
import '../conversation/sheets.dart' show subtleFill;
import 'document_index.dart';
import 'document_text.dart';

/// A document's Key Facts: the fields of its type, each with its value as
/// written and the page that says it; a tap shows the page with the quote
/// marked. Unknown and conflicting fields say so. Nothing at all when
/// Private AI or Documents is off, or the document has no text.
///
/// With a provider on this phone the facts are found when the card shows;
/// with a network one only when asked ([AiService] never uploads silently).
class KeyFactsCard extends ConsumerStatefulWidget {
  const KeyFactsCard({super.key, required this.entry});

  final DocumentEntry entry;

  @override
  ConsumerState<KeyFactsCard> createState() => _KeyFactsCardState();
}

class _KeyFactsCardState extends ConsumerState<KeyFactsCard> {
  Future<AiRun<DocumentFacts>>? _run;
  String? _runBy;

  void _start(AiService service) {
    _runBy = service.provider.id;
    _run = ref.read(documentIndexProvider).facts(service, widget.entry);
  }

  @override
  Widget build(BuildContext context) {
    final service = ref.watch(aiServiceForProvider((AiFeature.documents, widget.entry.email.accountId)));
    final doc = widget.entry.document;
    if (service == null || doc == null || !doc.searchable) return const SizedBox.shrink();
    if (_runBy != service.provider.id) {
      _run = null;
      _runBy = null;
      final cached = ref.read(documentIndexProvider).cachedFacts(service, doc);
      if (cached != null) {
        _runBy = service.provider.id;
        _run = Future.value(cached);
      } else if (service.provider.location == ProviderLocation.onThisPhone) {
        _start(service);
      }
    }
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    final colors = LoupeColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Container(
        key: const Key('key-facts'),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(color: colors.cellBackground, borderRadius: BorderRadius.circular(12)),
        child: FutureBuilder<AiRun<DocumentFacts>>(
          future: _run,
          builder: (context, snapshot) {
            final run = snapshot.data;
            final facts = run is AiSuccess<DocumentFacts> ? run.value : null;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(LoupeIcons.ask, size: 20, color: colors.unreadDot),
                    const SizedBox(width: 8),
                    Expanded(child: Text(l10n.documentsKeyFacts, style: styles.sectionHeader)),
                    if (facts != null && facts.type != DocumentType.other)
                      Flexible(
                        child: Text(
                          documentTypeLabel(facts.type, l10n),
                          style: styles.footnote,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                ..._body(context, service, run, snapshot),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _body(
    BuildContext context,
    AiService service,
    AiRun<DocumentFacts>? run,
    AsyncSnapshot<AiRun<DocumentFacts>> snapshot,
  ) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    if (_run == null) {
      return [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => setState(() => _start(service)),
            child: Text(l10n.documentsKeyFactsFind),
          ),
        ),
      ];
    }
    if (snapshot.connectionState != ConnectionState.done) {
      return [
        Row(
          children: [
            const CupertinoActivityIndicator(),
            const SizedBox(width: 10),
            Expanded(child: Text(l10n.documentsKeyFactsWorking, style: styles.body)),
          ],
        ),
      ];
    }
    switch (run) {
      case AiSuccess(:final value, :final record):
        return [
          if (value.type == DocumentType.other)
            Text(l10n.documentsKeyFactsNone, style: styles.body)
          else
            for (final field in value.fields) _FactRow(entry: widget.entry, field: field, fact: value.facts[field]),
          const SizedBox(height: 8),
          if (value.partial) Text(l10n.documentsKeyFactsPartial, style: styles.footnote),
          if (value.type != DocumentType.other) Text(l10n.documentsKeyFactsHint, style: styles.footnote),
          Text(
            record.providerId == 'demo'
                ? l10n.documentsKeyFactsDemoNote
                : l10n.documentsKeyFactsMadeBy(record.model ?? record.providerId),
            style: styles.footnote,
          ),
        ];
      case AiFailure(:final message):
        return [Text(l10n.documentsKeyFactsFailed, style: styles.body), ..._retry(context, service, message)];
      case null:
        return [
          Text(l10n.documentsKeyFactsFailed, style: styles.body),
          ..._retry(context, service, '${snapshot.error ?? ''}'),
        ];
    }
  }

  List<Widget> _retry(BuildContext context, AiService service, String message) => [
    if (message.isNotEmpty)
      Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(message, style: LoupeTextStyles.of(context).footnote),
      ),
    Align(
      alignment: AlignmentDirectional.centerStart,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => setState(() => _start(service)),
        child: Text(context.l10n.commonRetry),
      ),
    ),
  ];
}

/// One field: its name, the value with its qualifier, and its page.
class _FactRow extends StatelessWidget {
  const _FactRow({required this.entry, required this.field, required this.fact});

  final DocumentEntry entry;
  final FactField field;
  final DocumentFact? fact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    final colors = LoupeColors.of(context);
    final f = fact;
    final label = factFieldLabel(field, l10n);
    final Widget value;
    if (f == null) {
      value = Text(l10n.documentsKeyFactsNotStated, style: styles.body.copyWith(color: colors.tertiaryText));
    } else if (f.isConflicting) {
      value = Text(l10n.documentsKeyFactsConflicting, style: styles.body.copyWith(color: colors.destructive));
    } else {
      value = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(f.value, style: styles.body.copyWith(fontWeight: FontWeight.w600)),
          if (f.qualifier != null) Text(f.qualifier!, style: styles.footnote),
        ],
      );
    }
    final row = Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(label, style: styles.body.copyWith(color: colors.secondaryText)),
          ),
          const SizedBox(width: 10),
          Expanded(flex: 5, child: value),
          if (f != null) ...[
            const SizedBox(width: 6),
            Text(l10n.documentsPage(f.evidence.page), style: styles.footnote),
            Icon(LoupeIcons.disclosure, size: 16, color: colors.tertiaryText),
          ],
        ],
      ),
    );
    if (f == null) return row;
    return InkWell(
      key: ValueKey('fact-${field.json}'),
      onTap: () => showDocumentPage(
        context,
        entry: entry,
        page: f.evidence.page,
        highlight: (f.evidence.start, f.evidence.end),
        quote: f.evidence.quote,
        also: f.conflict,
      ),
      child: row,
    );
  }
}

/// Shows page [page] of [entry]'s text, with [highlight] marked and [quote]
/// above it; [also] is a second passage (a conflicting value). Open
/// Document opens the attachment itself.
Future<void> showDocumentPage(
  BuildContext context, {
  required DocumentEntry entry,
  required int page,
  (int, int)? highlight,
  String? quote,
  FactEvidence? also,
}) => showModalBottomSheet<void>(
  context: context,
  useSafeArea: true,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (sheet) {
    final l10n = sheet.l10n;
    final styles = LoupeTextStyles.of(sheet);
    final colors = LoupeColors.of(sheet);
    final text = entry.document?.pageText(page) ?? '';
    Widget passage(String q) => Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.unreadDot.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SelectableText('“$q”', style: styles.body.copyWith(fontWeight: FontWeight.w600)),
    );
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (inner, scroll) => ListView(
        controller: scroll,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.documentsPage(page), style: styles.navTitle),
                    Text(entry.name, style: styles.footnote, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                minimumSize: const Size(44, 32),
                onPressed: () => Navigator.of(inner).pop(),
                child: Text(l10n.commonDone),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (quote != null) passage(quote),
          if (also != null) ...[
            Text(l10n.documentsEvidenceAlso(also.page), style: styles.footnote),
            const SizedBox(height: 4),
            passage(also.quote),
          ],
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: subtleFill(inner), borderRadius: BorderRadius.circular(10)),
            child: highlight == null
                ? SelectableText(text, style: styles.body)
                : HighlightedText(text, start: highlight.$1, end: highlight.$2, selectable: true),
          ),
          const SizedBox(height: 12),
          CupertinoButton(
            onPressed: () {
              Navigator.of(inner).pop();
              unawaited(context.push(Routes.attachment(entry.ref.emailId, entry.ref.partId)));
            },
            child: Text(l10n.documentsOpenDocument),
          ),
        ],
      ),
    );
  },
);

/// The first line of a page, for a list of pages.
String firstLine(DocumentPage page) {
  final t = page.text.trimLeft();
  final nl = t.indexOf('\n');
  return nl < 0 ? t : t.substring(0, nl);
}
