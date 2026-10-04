import 'dart:typed_data';

import 'address.dart';

/// A file attached to an outgoing message.
final class OutgoingAttachment {
  const OutgoingAttachment({required this.filename, required this.mimeType, required this.data});
  final String filename;
  final String mimeType;
  final Uint8List data;
}

enum ComposeMode { newMessage, reply, replyAll, forward, editDraft }

/// A message being composed or queued for sending.
final class OutgoingMessage {
  const OutgoingMessage({
    required this.accountId,
    required this.identityId,
    this.to = const [],
    this.cc = const [],
    this.bcc = const [],
    this.subject = '',
    this.text = '',
    this.html,
    this.attachments = const [],
    this.inReplyTo,
    this.references = const [],
    this.mode = ComposeMode.newMessage,
    this.sourceEmailId,
    this.draftId,
  });

  final String accountId;
  final String identityId;
  final List<EmailAddress> to;
  final List<EmailAddress> cc;
  final List<EmailAddress> bcc;
  final String subject;

  /// Plain-text body (always present; generated from [html] if needed).
  final String text;

  /// Optional simple rich-text body.
  final String? html;
  final List<OutgoingAttachment> attachments;

  /// Message-ID being replied to, without angle brackets.
  final String? inReplyTo;
  final List<String> references;
  final ComposeMode mode;

  /// Local id of the message replied to or forwarded (to set $answered / $forwarded).
  final String? sourceEmailId;

  /// Local id of the draft this replaces, if any.
  final String? draftId;

  OutgoingMessage copyWith({
    String? identityId,
    List<EmailAddress>? to,
    List<EmailAddress>? cc,
    List<EmailAddress>? bcc,
    String? subject,
    String? text,
    List<OutgoingAttachment>? attachments,
    String? draftId,
  }) => OutgoingMessage(
    accountId: accountId,
    identityId: identityId ?? this.identityId,
    to: to ?? this.to,
    cc: cc ?? this.cc,
    bcc: bcc ?? this.bcc,
    subject: subject ?? this.subject,
    text: text ?? this.text,
    html: html,
    attachments: attachments ?? this.attachments,
    inReplyTo: inReplyTo,
    references: references,
    mode: mode,
    sourceEmailId: sourceEmailId,
    draftId: draftId ?? this.draftId,
  );

  /// The same message without [draftId] (once its draft is gone).
  OutgoingMessage withoutDraft() => OutgoingMessage(
    accountId: accountId,
    identityId: identityId,
    to: to,
    cc: cc,
    bcc: bcc,
    subject: subject,
    text: text,
    html: html,
    attachments: attachments,
    inReplyTo: inReplyTo,
    references: references,
    mode: mode,
    sourceEmailId: sourceEmailId,
  );
}
