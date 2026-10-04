import 'dart:typed_data';

import 'package:enough_mail/enough_mail.dart';
import 'package:mail_model/mail_model.dart';

/// An attached message (.eml), parsed for display.
final class EmlMessage {
  const EmlMessage({
    this.subject,
    this.from,
    this.to,
    this.cc,
    this.date,
    this.html,
    this.text,
    this.inlineImages = const {},
    this.attachmentNames = const [],
  });

  final String? subject;
  final String? from;
  final String? to;
  final String? cc;
  final DateTime? date;
  final String? html;
  final String? text;

  /// Images referenced from the HTML (`cid:`), by Content-ID.
  final Map<String, Uint8List> inlineImages;

  /// Files attached to the attached message (listed, not opened).
  final List<String> attachmentNames;

  bool get hasBody => (html?.trim().isNotEmpty ?? false) || (text?.trim().isNotEmpty ?? false);

  /// The message as reader content, under a made-up [emailId].
  EmailContent toContent(String emailId) => EmailContent(
    emailId: emailId,
    html: html,
    text: text,
    inlineData: inlineImages,
    headers: [
      if (from != null) ('From', from!),
      if (to != null) ('To', to!),
      if (subject != null) ('Subject', subject!),
    ],
  );
}

String? _addresses(List<MailAddress>? list) {
  if (list == null || list.isEmpty) return null;
  return list
      .map((a) => a.hasPersonalName ? '${a.personalName!.trim()} <${a.email}>' : a.email)
      .where((s) => s.trim().isNotEmpty)
      .join(', ');
}

/// Parses an RFC 822 message: decoded headers, the text and HTML bodies,
/// inline images and the names of its attachments. Throws [FormatException]
/// when the bytes are not a message.
EmlMessage parseEml(Uint8List bytes) {
  final MimeMessage m;
  try {
    m = MimeMessage.parseFromData(bytes);
  } on Object catch (e) {
    throw FormatException('Not a message: $e');
  }
  if ((m.headers ?? const []).isEmpty) throw const FormatException('Not a message: no headers');

  final inline = <String, Uint8List>{};
  final names = <String>[];
  try {
    for (final info in m.findContentInfo(disposition: ContentDisposition.inline)) {
      final cid = info.cid?.replaceAll(RegExp(r'^<|>$'), '');
      if (cid == null || !info.isImage) continue;
      final data = m.getPart(info.fetchId)?.decodeContentBinary();
      if (data != null) inline[cid] = data;
    }
    for (final info in m.findContentInfo()) {
      final name = info.fileName;
      if (name != null && name.isNotEmpty) names.add(name);
    }
  } on Object {
    // A broken part costs its images and names, not the message.
  }

  String? safe(String? Function() read) {
    try {
      return read();
    } on Object {
      return null;
    }
  }

  return EmlMessage(
    subject: safe(m.decodeSubject),
    from: safe(() => _addresses(m.from)),
    to: safe(() => _addresses(m.to)),
    cc: safe(() => _addresses(m.cc)),
    date: (() {
      try {
        return m.decodeDate();
      } on Object {
        return null;
      }
    })(),
    html: safe(m.decodeTextHtmlPart),
    text: safe(m.decodeTextPlainPart),
    inlineImages: inline,
    attachmentNames: names,
  );
}
