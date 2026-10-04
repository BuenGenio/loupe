import 'dart:typed_data';

import 'address.dart';
import 'keywords.dart';

/// What the message list needs for one row. Cheap to load in bulk.
final class EmailSummary {
  const EmailSummary({
    required this.id,
    required this.accountId,
    required this.mailboxId,
    required this.receivedAt,
    this.threadId,
    this.messageIdHeader,
    this.inReplyTo,
    this.references = const [],
    this.from = const [],
    this.to = const [],
    this.cc = const [],
    this.bcc = const [],
    this.replyTo = const [],
    this.subject = '',
    this.preview = '',
    this.sentAt,
    this.size = 0,
    this.keywords = const {},
    this.hasAttachment = false,
  });

  /// Stable local id, unique across accounts.
  final String id;
  final String accountId;

  /// The mailbox this copy lives in.
  final String mailboxId;

  /// Conversation id (Gmail X-GM-THRID, JMAP threadId, or computed from
  /// References / In-Reply-To). Null until threading has run.
  final String? threadId;

  /// The Message-ID header, without angle brackets.
  final String? messageIdHeader;
  final String? inReplyTo;
  final List<String> references;

  final List<EmailAddress> from;
  final List<EmailAddress> to;
  final List<EmailAddress> cc;
  final List<EmailAddress> bcc;
  final List<EmailAddress> replyTo;
  final String subject;

  /// Up to ~256 characters of body text, whitespace collapsed.
  final String preview;
  final DateTime receivedAt;

  /// The Date header.
  final DateTime? sentAt;

  /// RFC 822 size in bytes.
  final int size;

  /// Lower-cased keywords, see [Keywords].
  final Set<String> keywords;
  final bool hasAttachment;

  bool get isSeen => keywords.contains(Keywords.seen);
  bool get isFlagged => keywords.contains(Keywords.flagged);
  bool get isAnswered => keywords.contains(Keywords.answered);
  bool get isDraft => keywords.contains(Keywords.draft);

  /// User-visible tags (keywords that are not system state).
  Iterable<String> get tags => keywords.where((k) => !Keywords.system.contains(k));

  EmailAddress? get sender => from.isNotEmpty ? from.first : null;

  EmailSummary copyWith({Set<String>? keywords, String? mailboxId, String? threadId, String? preview}) => EmailSummary(
    id: id,
    accountId: accountId,
    mailboxId: mailboxId ?? this.mailboxId,
    receivedAt: receivedAt,
    threadId: threadId ?? this.threadId,
    messageIdHeader: messageIdHeader,
    inReplyTo: inReplyTo,
    references: references,
    from: from,
    to: to,
    cc: cc,
    bcc: bcc,
    replyTo: replyTo,
    subject: subject,
    preview: preview ?? this.preview,
    sentAt: sentAt,
    size: size,
    keywords: keywords ?? this.keywords,
    hasAttachment: hasAttachment,
  );

  @override
  bool operator ==(Object other) =>
      other is EmailSummary && other.id == id && _setEquals(other.keywords, keywords) && other.mailboxId == mailboxId;

  @override
  int get hashCode => Object.hash(id, mailboxId, keywords.length);
}

bool _setEquals(Set<String> a, Set<String> b) => a.length == b.length && a.containsAll(b);

/// One row of a conversation-grouped list.
final class ThreadSummary {
  const ThreadSummary({
    required this.threadId,
    required this.latest,
    required this.messageCount,
    required this.unreadCount,
    this.participants = const [],
  });

  final String threadId;

  /// The newest message in the list's scope; the row shows its subject and preview.
  final EmailSummary latest;
  final int messageCount;
  final int unreadCount;

  /// Distinct senders, newest first.
  final List<EmailAddress> participants;
}

/// An attachment or inline part.
final class Attachment {
  const Attachment({
    required this.partId,
    required this.mimeType,
    this.filename,
    this.size = 0,
    this.contentId,
    this.isInline = false,
  });

  /// IMAP body part number ("2.1") or JMAP blobId.
  final String partId;
  final String mimeType;
  final String? filename;

  /// Decoded size in bytes (estimate if the server only gave the encoded size).
  final int size;

  /// Content-ID without angle brackets, for `cid:` references in HTML.
  final String? contentId;

  /// Content-Disposition: inline (typically images referenced from HTML).
  final bool isInline;

  bool get isImage => mimeType.toLowerCase().startsWith('image/');
}

/// The full content of a message, as needed by the reader.
final class EmailContent {
  const EmailContent({
    required this.emailId,
    this.html,
    this.text,
    this.attachments = const [],
    this.inlineData = const {},
    this.headers = const [],
    this.isFlowed = false,
  });

  final String emailId;

  /// The text/html body, decoded to a Dart string. Null if there is none.
  final String? html;

  /// The text/plain body. Null if there is none.
  final String? text;

  /// True if [text] is format=flowed (RFC 3676) and may be reflowed.
  final bool isFlowed;

  /// All attachments and inline parts.
  final List<Attachment> attachments;

  /// Already-downloaded bytes of inline parts, keyed by Content-ID (no angle
  /// brackets). The reader resolves `cid:` images from here.
  final Map<String, Uint8List> inlineData;

  /// All header fields in order, as (name, value) pairs, for "Show all headers".
  final List<(String, String)> headers;

  /// Attachments the user would see in the attachment list.
  Iterable<Attachment> get visibleAttachments => attachments.where((a) => !a.isInline || a.contentId == null);
}
