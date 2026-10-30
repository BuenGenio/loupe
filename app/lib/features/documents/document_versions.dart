import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../attachments/attachment_cache.dart';
import 'document_index.dart';

/// What two copies of a document have in common, as far as their bytes
/// tell: the same name proves nothing.
enum CopyRelation {
  /// Byte for byte the same.
  same,
  different,

  /// One of them isn't downloaded, so they weren't compared.
  notCompared,
}

/// A document compared with another copy of the same name.
final class CopyComparison {
  const CopyComparison({required this.other, required this.otherIsEarlier, required this.relation});

  final DocumentEntry other;
  final bool otherIsEarlier;
  final CopyRelation relation;
}

/// [entry] compared with the nearest earlier of its [copies], else the
/// nearest later one; null without copies. Only content hashes are
/// compared: equal names and sizes never make two copies the same.
CopyComparison? compareCopies(DocumentEntry entry, List<DocumentEntry> copies) {
  if (copies.isEmpty) return null;
  final when = entry.email.receivedAt;
  final earlier = copies.where((c) => c.email.receivedAt.isBefore(when)).toList()
    ..sort((a, b) => b.email.receivedAt.compareTo(a.email.receivedAt));
  final later = copies.where((c) => !c.email.receivedAt.isBefore(when)).toList()
    ..sort((a, b) => a.email.receivedAt.compareTo(b.email.receivedAt));
  final other = earlier.firstOrNull ?? later.first;
  final mine = entry.document?.contentHash, theirs = other.document?.contentHash;
  return CopyComparison(
    other: other,
    otherIsEarlier: earlier.isNotEmpty,
    relation: mine == null || theirs == null
        ? CopyRelation.notCompared
        : mine == theirs
        ? CopyRelation.same
        : CopyRelation.different,
  );
}

/// A Key Fact that two copies state differently.
final class FactChange {
  const FactChange(this.field, this.before, this.after);

  final FactField field;
  final String before;
  final String after;
}

/// The fields both copies state, with different values, in card order.
/// Fields only one of them states are not changes anyone can vouch for.
List<FactChange> factChanges(DocumentFacts older, DocumentFacts newer) {
  if (older.type != newer.type) return const [];
  return [
    for (final field in newer.fields)
      if ((older.known(field), newer.known(field)) case (final a?, final b?) when a.value != b.value)
        FactChange(field, a.value, b.value),
  ];
}

/// A document and the other attachments of the same name in its
/// conversation (same account), one copy per message.
final class DocumentCopies {
  const DocumentCopies(this.entry, this.copies);

  final DocumentEntry entry;
  final List<DocumentEntry> copies;

  CopyComparison? get comparison => compareCopies(entry, copies);
}

/// [docRef] and its same-named copies in the conversation, or null when it
/// has none. Copies are read when their bytes are on the phone; otherwise
/// they are listed as not compared. Encrypted messages are left out.
final documentCopiesProvider = FutureProvider.autoDispose.family<DocumentCopies?, DocumentRef>((ref, docRef) async {
  final repository = ref.watch(repositoryProvider);
  final cache = ref.watch(attachmentCacheProvider);
  final index = ref.watch(documentIndexProvider);
  final everything = ref.watch(documentsAllAvailableProvider);
  final email = await repository.getEmail(docRef.emailId);
  if (email == null || email.isEncrypted) return null;
  final conversation = await repository.watchConversation(docRef.emailId).first;
  final seen = {email.messageIdHeader ?? email.id};
  final others = [
    for (final m in conversation)
      if (m.id != email.id &&
          m.accountId == email.accountId &&
          m.hasAttachment &&
          !m.isEncrypted &&
          seen.add(m.messageIdHeader ?? m.id))
        m,
  ];
  if (others.isEmpty) return null;
  // The repository's content: comparing must not verify signatures or learn
  // keys as a side effect (encrypted mail is left out above).
  final attachment = (await repository.loadContent(email.id)).attachments
      .where((a) => a.partId == docRef.partId)
      .firstOrNull;
  if (attachment == null || !isDocumentAttachment(attachment)) return null;
  Future<DocumentEntry> entryOf(EmailSummary m, Attachment a) async {
    final r = DocumentRef(m.id, a.partId);
    final cached = index.cached(r);
    if (cached != null || (!everything && !cache.contains(m.id, a.partId))) {
      return DocumentEntry(ref: r, attachment: a, email: m, document: cached);
    }
    try {
      final bytes = await cache.bytes(m.id, a);
      return DocumentEntry(ref: r, attachment: a, email: m, document: await index.read(r, a, bytes));
    } on Object {
      return DocumentEntry(ref: r, attachment: a, email: m);
    }
  }

  final self = await entryOf(email, attachment);
  final copies = <DocumentEntry>[];
  for (final m in others) {
    try {
      for (final a in (await repository.loadContent(m.id)).visibleAttachments) {
        if (!isDocumentAttachment(a)) continue;
        final candidate = DocumentEntry(ref: DocumentRef(m.id, a.partId), attachment: a, email: m);
        if (candidate.copyKey == self.copyKey) copies.add(await entryOf(m, a));
      }
    } on Object {
      // A message that can't be loaded has no copy to compare.
    }
  }
  return copies.isEmpty ? null : DocumentCopies(self, copies);
});
