import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_documents/mail_documents.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../router.dart';
import '../../shared/bars.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../ai/ai_providers.dart';
import '../attachments/attachment_type.dart';
import 'document_index.dart';
import 'document_text.dart';
import 'document_versions.dart';

/// The account of a message id (`MailIds`); null for ids that aren't one,
/// such as an attached message's.
String? _accountOf(String emailId) => emailId.contains('|') ? MailIds.accountOf(emailId) : null;

bool _readable(Attachment a) => documentFormatOf(effectiveMimeType(a.mimeType, a.filename), a.filename) != null;

/// Under an attachment in the reader: how it compares with another copy of
/// the same name in the conversation ("Different contents from the earlier
/// copy (28 Oct)"). Nothing when there is no such copy. A tap opens the
/// document's details.
class AttachmentCopyNote extends ConsumerWidget {
  const AttachmentCopyNote({super.key, required this.emailId, required this.attachment});

  final String emailId;
  final Attachment attachment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (_accountOf(emailId) == null || !isDocumentAttachment(attachment)) return const SizedBox.shrink();
    final comparison = ref.watch(documentCopiesProvider(DocumentRef(emailId, attachment.partId))).value?.comparison;
    if (comparison == null) return const SizedBox.shrink();
    final colors = LoupeColors.of(context);
    return GestureDetector(
      onTap: () => context.push(Routes.document(emailId, attachment.partId)),
      child: Text(
        copyNote(comparison, context.l10n),
        key: const Key('attachment-copy-note'),
        style: LoupeTextStyles.of(context).footnote
            .copyWith(color: comparison.relation == CopyRelation.different ? colors.unreadDot : null),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// A Key Facts button on a readable attachment in the reader, while
/// Private AI and Documents are on: it opens the document's details, where
/// the card is.
class AttachmentKeyFactsButton extends ConsumerWidget {
  const AttachmentKeyFactsButton({super.key, required this.emailId, required this.attachment});

  final String emailId;
  final Attachment attachment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = _accountOf(emailId);
    if (account == null || !_readable(attachment)) return const SizedBox.shrink();
    if (ref.watch(aiServiceForProvider((AiFeature.documents, account))) == null) return const SizedBox.shrink();
    final l10n = context.l10n;
    return Tooltip(
      message: l10n.documentsKeyFacts,
      excludeFromSemantics: true,
      child: Semantics(
        button: true,
        label: l10n.documentsKeyFacts,
        child: CupertinoButton(
          key: ValueKey('key-facts-${attachment.partId}'),
          padding: EdgeInsets.zero,
          minimumSize: const Size(44, 44),
          onPressed: () => context.push(Routes.document(emailId, attachment.partId)),
          child: Icon(LoupeIcons.ask, size: 22, color: LoupeColors.of(context).unreadDot),
        ),
      ),
    );
  }
}

/// The attachment viewer's Document Details button, for files Documents
/// can read: their text by page, other copies and Key Facts.
class DocumentDetailsButton extends StatelessWidget {
  const DocumentDetailsButton({super.key, required this.emailId, required this.attachment});

  final String emailId;
  final Attachment attachment;

  @override
  Widget build(BuildContext context) {
    if (_accountOf(emailId) == null || !_readable(attachment)) return const SizedBox.shrink();
    return BarIconButton(
      key: const Key('document-details'),
      icon: LoupeIcons.documents,
      tooltip: context.l10n.documentsDetails,
      onPressed: () => context.push(Routes.document(emailId, attachment.partId)),
    );
  }
}
