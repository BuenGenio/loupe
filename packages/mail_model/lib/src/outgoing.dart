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

/// End-to-end protection chosen for an outgoing message (OpenPGP today).
/// The composer applies it; without a key it fails rather than sending in
/// the clear.
final class OutgoingSecurity {
  const OutgoingSecurity({this.encrypt = false, this.sign = false, this.attachPublicKey = false, this.draft = false});

  /// Nothing: a plain message.
  static const none = OutgoingSecurity();

  /// Encrypt to every recipient and to the sender.
  final bool encrypt;

  /// Sign with the sender's key.
  final bool sign;

  /// Attach the sender's public key.
  final bool attachPublicKey;

  /// Saving a draft: encrypted (when [encrypt]) only to the sender, never
  /// signed, and the choices are kept in the draft so they come back.
  final bool draft;

  bool get isPlain => !encrypt && !sign && !attachPublicKey;

  /// The same choices for saving as a draft.
  OutgoingSecurity forDraft() =>
      OutgoingSecurity(encrypt: encrypt, sign: sign, attachPublicKey: attachPublicKey, draft: true);

  Map<String, Object?> toJson() => {
    if (encrypt) 'encrypt': true,
    if (sign) 'sign': true,
    if (attachPublicKey) 'attachPublicKey': true,
    if (draft) 'draft': true,
  };

  factory OutgoingSecurity.fromJson(Map<String, Object?>? json) => json == null
      ? none
      : OutgoingSecurity(
          encrypt: json['encrypt'] == true,
          sign: json['sign'] == true,
          attachPublicKey: json['attachPublicKey'] == true,
          draft: json['draft'] == true,
        );

  @override
  bool operator ==(Object other) =>
      other is OutgoingSecurity &&
      other.encrypt == encrypt &&
      other.sign == sign &&
      other.attachPublicKey == attachPublicKey &&
      other.draft == draft;

  @override
  int get hashCode => Object.hash(encrypt, sign, attachPublicKey, draft);
}

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
    this.security = OutgoingSecurity.none,
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

  /// Encrypt, sign, attach the public key.
  final OutgoingSecurity security;

  OutgoingMessage copyWith({
    String? identityId,
    List<EmailAddress>? to,
    List<EmailAddress>? cc,
    List<EmailAddress>? bcc,
    String? subject,
    String? text,
    List<OutgoingAttachment>? attachments,
    String? draftId,
    OutgoingSecurity? security,
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
    security: security ?? this.security,
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
    security: security,
  );
}
