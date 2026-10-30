import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_documents/mail_documents.dart';

import '../../l10n/l10n.dart';
import '../../router.dart';
import '../../shared/bars.dart';
import '../../shared/format.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../attachments/attachment_icon.dart';
import 'document_index.dart';
import 'document_text.dart';
import 'document_versions.dart';

/// Mailboxes › Documents: the attachments on this phone that Loupe can read,
/// and an exact search inside them. Results show the document, the message,
/// the page and the passage with the match marked; a passage opens the
/// attachment, a document its details. The coverage line says what was
/// searched: downloaded documents, never the whole mailbox.
class DocumentsScreen extends ConsumerStatefulWidget {
  const DocumentsScreen({super.key, this.initialQuery = ''});

  final String initialQuery;

  @override
  ConsumerState<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends ConsumerState<DocumentsScreen> {
  late final _text = TextEditingController(text: widget.initialQuery);
  late var _query = widget.initialQuery.trim();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _text.dispose();
    super.dispose();
  }

  void _changed(String text) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (mounted) setState(() => _query = text.trim());
    });
  }

  void _submitted(String text) {
    _debounce?.cancel();
    setState(() => _query = text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final library = ref.watch(documentLibraryProvider);
    return Scaffold(
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          LoupeTitleBar(title: l10n.documentsTitle),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 6),
              child: LoupeSearchField(
                controller: _text,
                placeholder: l10n.documentsSearchPlaceholder,
                autofocus: widget.initialQuery.isEmpty,
                onChanged: _changed,
                onSubmitted: _submitted,
              ),
            ),
          ),
          ...switch (library) {
            AsyncData(:final value) => _query.isEmpty ? _list(value) : _results(value),
            AsyncError(:final error) => [
              SliverFillRemaining(
                hasScrollBody: false,
                child: _Empty(title: l10n.documentsEmpty, detail: '$error'),
              ),
            ],
            _ => [const SliverFillRemaining(hasScrollBody: false, child: Center(child: CupertinoActivityIndicator()))],
          },
          SliverToBoxAdapter(child: _Footnote(text: l10n.documentsScopeNote)),
        ],
      ),
    );
  }

  List<Widget> _list(DocumentLibrary library) {
    final l10n = context.l10n;
    if (library.entries.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: _Empty(title: l10n.documentsEmpty, detail: l10n.documentsEmptyDetail),
        ),
      ];
    }
    final count = library.entries.length, unreadable = library.unreadable;
    return [
      SliverToBoxAdapter(
        child: _Coverage(
          unreadable == 0
              ? l10n.documentsLibraryCount(count)
              : l10n.documentsLibraryCountWithUnreadable(count, unreadable),
        ),
      ),
      SliverList.builder(
        itemCount: library.entries.length,
        itemBuilder: (context, i) {
          final e = library.entries[i];
          final comparison = compareCopies(e, library.copiesOf(e));
          return _DocumentRow(
            key: ValueKey('${e.ref.emailId}#${e.ref.partId}'),
            entry: e,
            note: documentStatusText(e.document, l10n) ?? (comparison == null ? null : copyNote(comparison, l10n)),
            highlightNote: comparison?.relation == CopyRelation.different,
            onTap: () => context.push(Routes.document(e.ref.emailId, e.ref.partId)),
          );
        },
      ),
    ];
  }

  List<Widget> _results(DocumentLibrary library) {
    final l10n = context.l10n;
    final hits = searchLibrary(library, _query);
    final searched = library.searchable, unreadable = library.entries.length - searched;
    return [
      SliverToBoxAdapter(
        child: _Coverage(
          unreadable == 0
              ? l10n.documentsCoverage(searched)
              : l10n.documentsCoverageWithUnreadable(searched, unreadable),
          key: const Key('documents-coverage'),
        ),
      ),
      if (hits.isEmpty)
        SliverToBoxAdapter(
          child: _Empty(title: l10n.documentsNoResults, detail: l10n.documentsNoResultsDetail(_query)),
        )
      else
        SliverList.builder(
          itemCount: hits.length,
          itemBuilder: (context, i) => _ResultGroup(hits: hits[i]),
        ),
    ];
  }
}

/// A document in the list: its icon, name, message and a note on what Loupe
/// could read or how it compares with an earlier copy.
class _DocumentRow extends StatelessWidget {
  const _DocumentRow({super.key, required this.entry, required this.onTap, this.note, this.highlightNote = false});

  final DocumentEntry entry;
  final String? note;
  final bool highlightNote;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: colors.separator, width: 0.5)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 16, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DocumentIcon(entry: entry),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.name,
                        style: styles.body.copyWith(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      _MessageLine(entry: entry),
                      if (note != null)
                        Text(
                          note!,
                          style: styles.footnote.copyWith(color: highlightNote ? colors.unreadDot : null),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// "Rhea Patel · Your mortgage application… · 28 Oct".
class _MessageLine extends StatelessWidget {
  const _MessageLine({required this.entry});

  final DocumentEntry entry;

  @override
  Widget build(BuildContext context) {
    final email = entry.email;
    final sender = email.from.firstOrNull;
    return Text(
      [
        if (sender != null) sender.displayName,
        if (email.subject.isNotEmpty) email.subject,
        formatListDate(email.receivedAt, l10n: context.l10n),
      ].join(' · '),
      style: LoupeTextStyles.of(context).footnote,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _DocumentIcon extends StatelessWidget {
  const _DocumentIcon({required this.entry});

  final DocumentEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        attachmentIcon(entry.attachment.mimeType, entry.attachment.filename),
        size: 20,
        color: theme.colorScheme.primary,
      ),
    );
  }
}

/// One document's matches: the document (to its details), then the first
/// passages (each to the attachment) and how many more there are.
class _ResultGroup extends StatelessWidget {
  const _ResultGroup({required this.hits});

  static const shown = 3;

  final DocumentHits hits;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final e = hits.entry;
    final pdf = e.document?.format == DocumentFormat.pdf;
    final more = hits.matches.length - shown;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DocumentRow(
          entry: e,
          note: documentStatusText(e.document, l10n),
          onTap: () => context.push(Routes.document(e.ref.emailId, e.ref.partId)),
        ),
        for (final m in hits.matches.take(shown))
          InkWell(
            onTap: () => context.push(Routes.attachment(e.ref.emailId, e.ref.partId)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(64, 8, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pdf ? l10n.documentsMatchedOnPage(m.page) : l10n.documentsMatchedOnLine(m.line),
                    style: styles.footnote.copyWith(color: colors.unreadDot),
                  ),
                  const SizedBox(height: 2),
                  HighlightedText(
                    m.passage,
                    start: m.passageStart,
                    end: m.passageEnd,
                    style: styles.body.copyWith(fontSize: 15),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
        if (more > 0)
          Padding(
            padding: const EdgeInsets.fromLTRB(64, 0, 16, 8),
            child: Text(l10n.documentsMoreMatches(more), style: styles.footnote),
          ),
        Divider(height: 0.5, thickness: 0.5, indent: 16, color: colors.separator),
      ],
    );
  }
}

class _Coverage extends StatelessWidget {
  const _Coverage(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
    child: Text(text, style: LoupeTextStyles.of(context).footnote),
  );
}

class _Footnote extends StatelessWidget {
  const _Footnote({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 24 + MediaQuery.paddingOf(context).bottom),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LoupeIcons.thisDevice, size: 16, color: colors.secondaryText),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: LoupeTextStyles.of(context).footnote)),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
      child: Column(
        children: [
          Icon(LoupeIcons.documents, size: 52, color: colors.tertiaryText),
          const SizedBox(height: 14),
          Text(
            title,
            style: styles.sectionHeader.copyWith(color: colors.secondaryText),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(detail, style: styles.footnote, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
