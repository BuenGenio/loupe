import 'dart:typed_data';

import 'address.dart';

/// A file attached to an outgoing message.
final class OutgoingAttachment {
  const OutgoingAttachment({required this.filename, required this.mimeType, required this.data});
  final String filename;
  final String mimeType;
  final Uint8List data;
}

/// An iCalendar object sent next to the text, as the message's
/// `text/calendar` alternative (iMIP, RFC 6047): a reply to an invitation.
/// The composer writes `multipart/alternative` with the text first and
/// `text/calendar; method=…; charset=UTF-8` last, as Outlook and Gmail
/// expect it.
final class OutgoingCalendar {
  const OutgoingCalendar({required this.method, required this.data});

  /// The iTIP method (`REPLY`), as in the object's METHOD.
  final String method;

  /// The iCalendar text (CRLF line ends).
  final String data;

  Map<String, Object?> toJson() => {'method': method, 'data': data};

  static OutgoingCalendar? fromJson(Object? json) {
    if (json is! Map) return null;
    final method = json['method'];
    final data = json['data'];
    return method is String && data is String ? OutgoingCalendar(method: method, data: data) : null;
  }

  @override
  bool operator ==(Object other) => other is OutgoingCalendar && other.method == method && other.data == data;

  @override
  int get hashCode => Object.hash(method, data);
}

enum ComposeMode { newMessage, reply, replyAll, forward, editDraft }

/// The end-to-end encryption standard a message is protected with.
enum SecurityTechnology {
  /// PGP/MIME (RFC 3156), as Thunderbird, Proton and K-9 Mail write it.
  openPgp,

  /// S/MIME (RFC 8551) with X.509 certificates, as Outlook and Apple Mail write it.
  smime,
}

/// End-to-end protection chosen for an outgoing message, with OpenPGP or
/// S/MIME ([technology]). The composer applies it; without a key or
/// certificate it fails rather than sending in the clear.
final class OutgoingSecurity {
  const OutgoingSecurity({
    this.encrypt = false,
    this.sign = false,
    this.attachPublicKey = false,
    this.draft = false,
    this.technology = SecurityTechnology.openPgp,
    this.hideSubject,
  });

  /// Nothing: a plain message.
  static const none = OutgoingSecurity();

  /// Encrypt to every recipient and to the sender.
  final bool encrypt;

  /// Sign with the sender's key (S/MIME: certificate).
  final bool sign;

  /// Attach the sender's public key (OpenPGP only; S/MIME signatures carry the certificate).
  final bool attachPublicKey;

  /// Saving a draft: encrypted (when [encrypt]) only to the sender, never
  /// signed, and the choices are kept in the draft so they come back.
  final bool draft;

  final SecurityTechnology technology;

  /// Whether encrypted mail shows `...` as its Subject outside, with the real
  /// one protected inside. Null: the technology's default ([hidesSubject]).
  final bool? hideSubject;

  /// OpenPGP hides the Subject by default, as Thunderbird does and reads
  /// back. S/MIME doesn't: Outlook and Thunderbird don't read protected
  /// S/MIME headers, so their users would see `...` as the Subject.
  bool get hidesSubject => hideSubject ?? !isSmime;

  bool get isPlain => !encrypt && !sign && !attachPublicKey;

  bool get isSmime => technology == SecurityTechnology.smime;

  /// The same choices for saving as a draft.
  OutgoingSecurity forDraft() => OutgoingSecurity(
    encrypt: encrypt,
    sign: sign,
    attachPublicKey: attachPublicKey,
    draft: true,
    technology: technology,
    hideSubject: hideSubject,
  );

  Map<String, Object?> toJson() => {
    if (encrypt) 'encrypt': true,
    if (sign) 'sign': true,
    if (attachPublicKey) 'attachPublicKey': true,
    if (draft) 'draft': true,
    if (technology != SecurityTechnology.openPgp) 'technology': technology.name,
    'hideSubject': ?hideSubject,
  };

  factory OutgoingSecurity.fromJson(Map<String, Object?>? json) => json == null
      ? none
      : OutgoingSecurity(
          encrypt: json['encrypt'] == true,
          sign: json['sign'] == true,
          attachPublicKey: json['attachPublicKey'] == true,
          draft: json['draft'] == true,
          technology: SecurityTechnology.values.asNameMap()[json['technology']] ?? SecurityTechnology.openPgp,
          hideSubject: json['hideSubject'] as bool?,
        );

  @override
  bool operator ==(Object other) =>
      other is OutgoingSecurity &&
      other.encrypt == encrypt &&
      other.sign == sign &&
      other.attachPublicKey == attachPublicKey &&
      other.draft == draft &&
      other.technology == technology &&
      other.hideSubject == hideSubject;

  @override
  int get hashCode => Object.hash(encrypt, sign, attachPublicKey, draft, technology, hideSubject);
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
    this.bccCopy = false,
    this.calendar,
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

  /// The copy of an encrypted message made for its one Bcc recipient
  /// ([bcc]; see [deliveries]): encrypted to them and the sender only,
  /// while its headers show To and Cc like everyone else's copy.
  final bool bccCopy;

  /// An iCalendar object sent as the text's alternative (a reply to an
  /// invitation); null for ordinary mail.
  final OutgoingCalendar? calendar;

  /// Whom the message is encrypted to besides the sender: the Bcc
  /// recipient of a [bccCopy], else everyone in To, Cc and Bcc.
  List<EmailAddress> get encryptionRecipients => bccCopy ? bcc : [...to, ...cc, ...bcc];

  /// How the message goes out: the messages to compose and whom each one
  /// goes to.
  ///
  /// Usually one, to every recipient and filed in Sent. Encrypted with Bcc
  /// recipients, as KMail does (an encrypted message names the keys it is
  /// encrypted to, so one copy for everyone would show every recipient who
  /// was in Bcc): one encrypted to To and Cc and the sender, sent to To and
  /// Cc and filed in Sent; and for each Bcc recipient a [bccCopy] encrypted
  /// to them and the sender, sent to them alone. A Bcc recipient who is in
  /// To or Cc too, or is the [sender], gets the first one: it names their
  /// key already. Without To and Cc, the first is only filed. Like plain
  /// mail, no copy has a Bcc header.
  List<OutgoingDelivery> deliveries({required String sender}) {
    List<String> envelope(Iterable<EmailAddress> list) => {for (final a in list) a.email}.toList();
    if (!security.encrypt || security.draft || bcc.isEmpty) {
      return [
        OutgoingDelivery(this, envelope([...to, ...cc, ...bcc]), filed: true),
      ];
    }
    String key(EmailAddress a) => a.email.trim().toLowerCase();
    final visible = {
      for (final a in [...to, ...cc]) key(a),
    };
    final self = sender.trim().toLowerCase();
    final hidden = <String, EmailAddress>{};
    final toSelf = <EmailAddress>[];
    for (final a in bcc) {
      final k = key(a);
      // Already in the envelope of the first copy.
      if (k.isEmpty || visible.contains(k)) continue;
      if (k == self) {
        if (toSelf.isEmpty) toSelf.add(a);
      } else {
        hidden.putIfAbsent(k, () => a);
      }
    }
    return [
      OutgoingDelivery(copyWith(bcc: const []), envelope([...to, ...cc, ...toSelf]), filed: true),
      for (final a in hidden.values) OutgoingDelivery(copyWith(bcc: [a], bccCopy: true), [a.email]),
    ];
  }

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
    bool? bccCopy,
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
    bccCopy: bccCopy ?? this.bccCopy,
    calendar: calendar,
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
    bccCopy: bccCopy,
    calendar: calendar,
  );
}

/// One message to hand to the server ([OutgoingMessage.deliveries]).
final class OutgoingDelivery {
  const OutgoingDelivery(this.message, this.recipients, {this.filed = false});

  /// What to compose.
  final OutgoingMessage message;

  /// The addresses it goes to (the SMTP envelope); empty for the Sent copy
  /// of an encrypted message that has only Bcc recipients.
  final List<String> recipients;

  /// This one is filed in Sent: one per message.
  final bool filed;
}
