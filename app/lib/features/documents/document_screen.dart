import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_documents/mail_documents.dart';

import '../../l10n/l10n.dart';
import '../../router.dart';
import '../../shared/bars.dart';
import '../../shared/format.dart';
import '../../shared/grouped_list.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../ai/ai_providers.dart';
import '../attachments/attachment_type.dart';
import 'document_index.dart';
import 'document_text.dart';
import 'document_versions.dart';
import 'key_facts_card.dart';

/// One document: the message it came with, what Loupe could read of it,
/// other copies of the same name and how they differ, its Key Facts, and
/// its text page by page. Opening it downloads it, as opening the
/// attachment would.
class DocumentScreen extends ConsumerWidget {
  const DocumentScreen({super.key, required this.emailId, required this.partId});

  final String emailId;
  final String partId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(documentEntryProvider(DocumentRef(emailId, partId)));
    final entry = async.value;
    final doc = entry?.document;
    final subtitle = entry == null
        ? null
        : [
            describeFileType(entry.attachment.mimeType, entry.attachment.filename, l10n: l10n),
            if (doc?.pageCount case final pages? when doc!.format == DocumentFormat.pdf)
              l10n.attachmentsPageCount(pages),
            formatBytes(doc?.byteLength ?? entry.attachment.size, l10n: l10n),
          ].join(' · ');
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          LoupeTitleBar(
            title: entry?.name.isNotEmpty == true ? entry!.name : l10n.attachmentsUntitled,
            subtitle: subtitle == null ? null : Text(subtitle),
          ),
          switch (async) {
            AsyncData(:final value) => SliverList.list(children: _sections(context, ref, value)),
            AsyncError(:final error) => SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    error is DocumentGone ? l10n.attachmentsGone : l10n.attachmentsDownloadFailed,
                    textAlign: TextAlign.center,
                    style: LoupeTextStyles.of(context).footnote,
                  ),
                ),
              ),
            ),
            _ => const SliverFillRemaining(hasScrollBody: false, child: Center(child: CupertinoActivityIndicator())),
          },
        ],
      ),
    );
  }

  List<Widget> _sections(BuildContext context, WidgetRef ref, DocumentEntry entry) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    final colors = LoupeColors.of(context);
    final doc = entry.document;
    final status = documentStatusText(doc, l10n);
    final email = entry.email;
    return [
      const SizedBox(height: 8),
      InsetGroup(
        children: [
          _Row(
            icon: LoupeIcons.email,
            title: email.sender?.displayName ?? email.from.firstOrNull?.displayName ?? '',
            detail: '${email.subject} · ${formatListDate(email.receivedAt, l10n: l10n)}',
            onTap: () => context.push(Routes.message(email.id)),
            semanticsLabel: l10n.documentsOpenMessage,
          ),
          _Row(
            icon: LoupeIcons.openIn,
            title: l10n.documentsOpenDocument,
            onTap: () => context.push(Routes.attachment(entry.ref.emailId, entry.ref.partId)),
          ),
        ],
      ),
      if (status != null)
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Row(
            key: const Key('document-status'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(LoupeIcons.info, size: 18, color: colors.secondaryText),
              const SizedBox(width: 8),
              Expanded(
                child: Text(status, style: styles.body.copyWith(color: colors.secondaryText)),
              ),
            ],
          ),
        ),
      _Copies(entry: entry),
      KeyFactsCard(entry: entry),
      if (doc != null && doc.searchable)
        InsetGroup(
          header: l10n.documentsPagesHeader,
          separatorIndent: 16,
          children: [
            for (final page in doc.pages)
              if (page.readable)
                _Row(
                  title: doc.format == DocumentFormat.pdf ? l10n.documentsPage(page.number) : entry.name,
                  detail: firstLine(page),
                  onTap: () => showDocumentPage(context, entry: entry, page: page.number),
                ),
          ],
        ),
      if (doc != null)
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 24 + MediaQuery.paddingOf(context).bottom),
          child: Text(
            l10n.documentsFingerprint(
              '${doc.contentHash.substring(0, 4)} ${doc.contentHash.substring(4, 8)} ${doc.contentHash.substring(8, 12)}',
            ),
            style: styles.footnote,
          ),
        ),
    ];
  }
}

/// Other copies of the same name in the conversation: whether their bytes
/// are the same, and which Key Facts changed when both have them.
class _Copies extends ConsumerWidget {
  const _Copies({required this.entry});

  final DocumentEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copies = ref.watch(documentCopiesProvider(entry.ref)).value;
    final comparison = copies?.comparison;
    if (copies == null || comparison == null) return const SizedBox.shrink();
    final l10n = context.l10n;
    final service = ref.watch(aiServiceForProvider((AiFeature.documents, entry.email.accountId)));
    final other = comparison.other;
    return InsetGroup(
      header: l10n.documentsVersionsHeader,
      separatorIndent: 16,
      children: [
        _Row(
          key: const Key('document-copy'),
          title: copyNote(comparison, l10n),
          detail: other.email.subject,
          onTap: () => context.push(Routes.document(other.ref.emailId, other.ref.partId)),
        ),
        if (comparison.relation == CopyRelation.different && service != null)
          _FactChanges(service: service, entry: copies.entry, comparison: comparison),
      ],
    );
  }
}

/// The Key Facts that differ between two copies, older value first. Facts
/// are found for both when the provider is on this phone; otherwise only
/// facts already found are compared.
class _FactChanges extends ConsumerStatefulWidget {
  const _FactChanges({required this.service, required this.entry, required this.comparison});

  final AiService service;
  final DocumentEntry entry;
  final CopyComparison comparison;

  @override
  ConsumerState<_FactChanges> createState() => _FactChangesState();
}

class _FactChangesState extends ConsumerState<_FactChanges> {
  late final Future<List<FactChange>?> _changes = _load();

  Future<List<FactChange>?> _load() async {
    final index = ref.read(documentIndexProvider);
    final mine = widget.entry, other = widget.comparison.other;
    if (!mine.searchable || !other.searchable) return null;
    Future<DocumentFacts?> factsOf(DocumentEntry e) async {
      final cached = index.cachedFacts(widget.service, e.document!);
      if (cached != null) return cached.value;
      if (widget.service.provider.location != ProviderLocation.onThisPhone) return null;
      final run = await index.facts(widget.service, e);
      return run is AiSuccess<DocumentFacts> ? run.value : null;
    }

    final (a, b) = (await factsOf(mine), await factsOf(other));
    if (a == null || b == null) return null;
    return widget.comparison.otherIsEarlier ? factChanges(b, a) : factChanges(a, b);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    return FutureBuilder<List<FactChange>?>(
      future: _changes,
      builder: (context, snapshot) {
        final changes = snapshot.data;
        if (changes == null) return const SizedBox.shrink();
        return Padding(
          key: const Key('document-changes'),
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (changes.isEmpty) Text(l10n.documentsNoFactChanges, style: styles.footnote),
              for (final c in changes)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 4, child: Text(factFieldLabel(c.field, l10n), style: styles.footnote)),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 6,
                        child: Text(
                          l10n.documentsChange(c.before, c.after),
                          style: styles.body.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({super.key, required this.title, this.icon, this.detail, this.onTap, this.semanticsLabel});

  final IconData? icon;
  final String title;
  final String? detail;
  final VoidCallback? onTap;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Semantics(
      button: onTap != null,
      hint: semanticsLabel,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          child: Row(
            children: [
              if (icon != null) ...[Icon(icon, size: 22, color: colors.unreadDot), const SizedBox(width: 14)],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: styles.body),
                    if (detail != null && detail!.isNotEmpty)
                      Text(detail!, style: styles.footnote, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              if (onTap != null) Icon(LoupeIcons.disclosure, size: 18, color: colors.tertiaryText),
            ],
          ),
        ),
      ),
    );
  }
}
