import 'dart:async';
import 'dart:isolate';

import 'package:expr_search/expr_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_documents/mail_documents.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../settings/app_mode.dart';
import '../ai/ai_providers.dart';
import '../attachments/attachment_cache.dart';
import '../attachments/attachment_type.dart';
import '../openpgp/content_loader.dart';

/// One attachment of one message. Value-equal, so it can key a provider
/// family.
@immutable
final class DocumentRef {
  const DocumentRef(this.emailId, this.partId);

  final String emailId;
  final String partId;

  @override
  bool operator ==(Object other) => other is DocumentRef && other.emailId == emailId && other.partId == partId;

  @override
  int get hashCode => Object.hash(emailId, partId);
}

/// A document as Documents knows it: the attachment, the message it came
/// with, and what Loupe read of it, or null when its bytes aren't on the
/// phone. Nothing about its contents is assumed from its name or size.
final class DocumentEntry {
  const DocumentEntry({required this.ref, required this.attachment, required this.email, this.document});

  final DocumentRef ref;
  final Attachment attachment;
  final EmailSummary email;
  final ExtractedDocument? document;

  String get name => attachment.filename?.trim() ?? '';

  bool get downloaded => document != null;

  /// Has text to search (all or some of its pages).
  bool get searchable => document?.searchable ?? false;

  /// Downloaded, but nothing in it could be read.
  bool get unreadable => document != null && !document!.searchable;

  /// The name copies are matched by: case and spacing aside.
  String get copyKey => name.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
}

/// Whether Documents lists [attachment]: what the extractor reads (PDF,
/// text, CSV) and office documents it can't read yet, which are listed as
/// such. Images, archives, calendar files and messages are not documents.
bool isDocumentAttachment(Attachment attachment) {
  if (attachment.isInline && attachment.contentId != null) return false;
  final mime = effectiveMimeType(attachment.mimeType, attachment.filename);
  if (documentFormatOf(mime, attachment.filename) != null) return true;
  const office = {'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'odt', 'ods', 'odp', 'rtf', 'pages', 'numbers', 'key'};
  return office.contains(fileExtension(attachment.filename)) ||
      mime.contains('wordprocessingml') ||
      mime.contains('spreadsheetml') ||
      mime.contains('presentationml') ||
      mime.contains('opendocument') ||
      mime == 'application/msword' ||
      mime == 'application/rtf';
}

/// Runs an extraction off the UI isolate.
typedef DocumentRunner = Future<ExtractedDocument> Function(ExtractedDocument Function() work);

Future<ExtractedDocument> _isolate(ExtractedDocument Function() work) => Isolate.run(work);

/// What Loupe read of each document, by content: the same bytes are read
/// once whatever their name or message, and a cached result is reused only
/// by the extractor version that made it. Key Facts are kept the same way,
/// by content, extractor, task version and provider. Device-local and in
/// memory: derived mail data, gone when the app closes or the repository
/// changes.
final class DocumentIndex {
  DocumentIndex({DocumentRunner? run}) : _run = run ?? _isolate;

  final DocumentRunner _run;
  final _byContent = <String, ExtractedDocument>{};
  final _contentOf = <DocumentRef, String>{};
  final _facts = <String, AiSuccess<DocumentFacts>>{};

  static String _key(String hash) => '$hash/$extractorVersion';

  /// What was read of [ref] this session, if anything.
  ExtractedDocument? cached(DocumentRef ref) => switch (_contentOf[ref]) {
    final hash? => _byContent[_key(hash)],
    null => null,
  };

  /// Reads [bytes], the attachment's, or returns what an earlier read of the
  /// same bytes found. Small files are read at once with tight limits (a
  /// few milliseconds); larger ones, and small ones that reach those
  /// limits, in another isolate with the full ones.
  Future<ExtractedDocument> read(DocumentRef ref, Attachment attachment, Uint8List bytes) async {
    final mime = effectiveMimeType(attachment.mimeType, attachment.filename);
    final name = attachment.filename;
    if (bytes.length <= ExtractionLimits.quick.maxBytes) {
      final hash = contentHash(bytes);
      if (_byContent[_key(hash)] case final hit?) return _remember(ref, hit);
      final quick = readDocument(bytes, mimeType: mime, fileName: name, limits: ExtractionLimits.quick, hash: hash);
      if (quick.limit == null) return _remember(ref, quick);
    }
    final doc = await _run(() => readDocument(bytes, mimeType: mime, fileName: name));
    return _remember(ref, _byContent[_key(doc.contentHash)] ?? doc);
  }

  ExtractedDocument _remember(DocumentRef ref, ExtractedDocument doc) {
    _contentOf[ref] = doc.contentHash;
    return _byContent[_key(doc.contentHash)] = doc;
  }

  static String _factsKey(AiService service, ExtractedDocument doc) =>
      '${service.provider.id}\n${doc.contentHash}\n${doc.version}\n${DocumentFactsTask.currentVersion}';

  /// Key Facts of [doc] found earlier by [service]'s provider, for these
  /// bytes under any name.
  AiSuccess<DocumentFacts>? cachedFacts(AiService service, ExtractedDocument doc) => _facts[_factsKey(service, doc)];

  /// Asks [service] for [entry]'s Key Facts, through [AiService.run] and the
  /// task's parser. Successes are kept by content.
  Future<AiRun<DocumentFacts>> facts(AiService service, DocumentEntry entry) async {
    final doc = entry.document;
    if (doc == null) throw StateError('Key Facts need the document read first.');
    if (cachedFacts(service, doc) case final hit?) return hit;
    final run = await service.run(factsTask(entry.name, doc));
    if (run is AiSuccess<DocumentFacts>) _facts[_factsKey(service, doc)] = run;
    return run;
  }

  /// The task for [doc]'s pages, page numbers kept (an unreadable page is
  /// empty, not skipped).
  static DocumentFactsTask factsTask(String fileName, ExtractedDocument doc) =>
      DocumentFactsTask(DocumentFactsInput(fileName: fileName, pages: [for (final p in doc.pages) p.text]));
}

/// The index of the active repository: a new repository (demo ↔ live)
/// starts empty.
final documentIndexProvider = Provider<DocumentIndex>((ref) {
  ref.watch(repositoryProvider);
  return DocumentIndex();
});

/// Whether every attachment's bytes are on the phone: in the demo they are
/// made there. With real accounts, only what was downloaded this session.
final documentsAllAvailableProvider = Provider<bool>((ref) => ref.watch(appModeProvider) == AppMode.demo);

/// The documents Loupe can search on this phone, newest message first:
/// every document attachment of the demo mailbox, or the ones downloaded
/// this session. Read once each (see [DocumentIndex]); listed again
/// whenever something shows them.
final documentLibraryProvider = FutureProvider.autoDispose<DocumentLibrary>((ref) async {
  final repository = ref.watch(repositoryProvider);
  final cache = ref.watch(attachmentCacheProvider);
  final index = ref.watch(documentIndexProvider);
  final candidates = <(EmailSummary, Attachment)>[];
  if (ref.watch(documentsAllAvailableProvider)) {
    final results = await repository
        .search(
          SearchRequest(
            expr: parseQuery('has:attachment').expr,
            scope: const AllMailboxesScope(),
            includeServer: false,
            limit: 500,
          ),
        )
        .first;
    final seen = <String>{};
    await Future.wait([
      for (final email in results.items)
        // Encrypted mail is read only through its own decryption, when opened.
        if (!email.isEncrypted && seen.add('${email.accountId}|${email.messageIdHeader ?? email.id}'))
          () async {
            try {
              // The repository's content, not ContentLoader's: listing must not
              // verify signatures or learn keys as a side effect.
              final content = await repository.loadContent(email.id);
              for (final a in content.visibleAttachments) {
                if (isDocumentAttachment(a)) candidates.add((email, a));
              }
            } on Object {
              // A message that can't be loaded has no documents to list.
            }
          }(),
    ]);
  } else {
    for (final (emailId, attachment) in cache.downloaded) {
      if (!isDocumentAttachment(attachment)) continue;
      final email = await repository.getEmail(emailId);
      if (email != null) candidates.add((email, attachment));
    }
  }
  final entries = await Future.wait([
    for (final (email, attachment) in candidates) _entry(email, attachment, cache, index, download: true),
  ]);
  entries.sort((a, b) {
    final byDate = b.email.receivedAt.compareTo(a.email.receivedAt);
    return byDate != 0 ? byDate : a.ref.partId.compareTo(b.ref.partId);
  });
  return DocumentLibrary(entries);
});

/// [attachment] of [email] as an entry: read when its bytes are cached, or
/// when [download] allows getting them.
Future<DocumentEntry> _entry(
  EmailSummary email,
  Attachment attachment,
  AttachmentCache cache,
  DocumentIndex index, {
  required bool download,
}) async {
  final ref = DocumentRef(email.id, attachment.partId);
  if (index.cached(ref) case final doc?) {
    return DocumentEntry(ref: ref, attachment: attachment, email: email, document: doc);
  }
  if (!download && !cache.contains(email.id, attachment.partId)) {
    return DocumentEntry(ref: ref, attachment: attachment, email: email);
  }
  try {
    final bytes = await cache.bytes(email.id, attachment);
    return DocumentEntry(
      ref: ref,
      attachment: attachment,
      email: email,
      document: await index.read(ref, attachment, bytes),
    );
  } on Object {
    return DocumentEntry(ref: ref, attachment: attachment, email: email);
  }
}

/// The documents on the phone, and what can be said about them as a whole.
final class DocumentLibrary {
  const DocumentLibrary(this.entries);

  final List<DocumentEntry> entries;

  int get searchable => entries.where((e) => e.searchable).length;

  /// Downloaded, but nothing could be read (password protected, scanned,
  /// unsupported, damaged).
  int get unreadable => entries.where((e) => e.unreadable).length;

  /// Other attachments with [entry]'s name in its conversation, oldest
  /// first.
  List<DocumentEntry> copiesOf(DocumentEntry entry) => [
    for (final e in entries.reversed)
      if (e.ref != entry.ref &&
          e.copyKey == entry.copyKey &&
          e.email.accountId == entry.email.accountId &&
          (e.email.threadId ?? e.email.id) == (entry.email.threadId ?? entry.email.id))
        e,
  ];
}

/// One document's matches.
final class DocumentHits {
  const DocumentHits(this.entry, this.matches);

  final DocumentEntry entry;
  final List<DocumentMatch> matches;
}

/// [query] in every searchable document of [library], exactly (see
/// [findInDocument]), in the library's order.
List<DocumentHits> searchLibrary(DocumentLibrary library, String query) => [
  for (final e in library.entries)
    if (e.searchable)
      if (findInDocument(e.document!, query) case final matches when matches.isNotEmpty) DocumentHits(e, matches),
];

/// One document by its message and part: downloaded now when it isn't (the
/// user asked for it), except a large file, which the viewer asks about
/// first.
final documentEntryProvider = FutureProvider.autoDispose.family<DocumentEntry, DocumentRef>((ref, docRef) async {
  final repository = ref.watch(repositoryProvider);
  final cache = ref.watch(attachmentCacheProvider);
  final index = ref.watch(documentIndexProvider);
  final content = await ref.watch(contentLoaderProvider).loadContent(docRef.emailId);
  final attachment = content.attachments.where((a) => a.partId == docRef.partId).firstOrNull;
  final email = await repository.getEmail(docRef.emailId);
  if (attachment == null || email == null) throw const DocumentGone();
  return _entry(email, attachment, cache, index, download: attachment.size < largeDocumentSize);
});

/// The message no longer has the attachment.
final class DocumentGone implements Exception {
  const DocumentGone();
}

/// Above this size, a document is only read once it was downloaded (the
/// viewer asks before downloading it on mobile data).
const largeDocumentSize = 25 * 1024 * 1024;
