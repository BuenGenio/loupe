/// A parsed MIME entity as reader content ([EmailContent]).
library;

import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

import 'entity.dart';

/// Builds what the reader shows from [root]: the text and HTML bodies,
/// attachments and inline images. Part ids are [partPrefix] plus the IMAP
/// section (`pgp:1.2`), so the caller can serve attachments from [root]
/// again with [partOf].
///
/// Skips legacy-display parts of protected headers (`text/rfc822-headers`)
/// and, unless [keepPgpParts], PGP/MIME plumbing (signatures, the version part).
EmailContent contentFromEntity(
  MimeEntity root, {
  required String emailId,
  String partPrefix = 'pgp:',
  List<(String, String)> headers = const [],
  bool keepPgpParts = false,
}) {
  final texts = <MimeEntity>[];
  final htmls = <MimeEntity>[];
  final attachments = <Attachment>[];
  final inlineData = <String, Uint8List>{};

  void attach(MimeEntity e, String section, {bool inline = false}) {
    final type = e.mimeType;
    if (!keepPgpParts && (type == 'application/pgp-signature' || type == 'application/pgp-encrypted')) return;
    if (type == 'text/rfc822-headers') return;
    final cid = e.contentId;
    final data = e.decodedBody;
    final isInline = inline || (e.disposition.value == 'inline' && cid != null);
    attachments.add(
      Attachment(
        partId: '$partPrefix$section',
        mimeType: type,
        filename: e.filename,
        size: data.length,
        contentId: cid,
        isInline: isInline,
      ),
    );
    if (cid != null && type.startsWith('image/')) inlineData[cid] = data;
  }

  bool isBodyText(MimeEntity e) =>
      (e.mimeType == 'text/plain' || e.mimeType == 'text/html') &&
      e.disposition.value != 'attachment' &&
      e.filename == null;

  void walk(MimeEntity e, String section, {bool inAlternative = false}) {
    if (!e.isMultipart) {
      if (isBodyText(e)) {
        (e.mimeType == 'text/html' ? htmls : texts).add(e);
      } else {
        attach(e, section);
      }
      return;
    }
    String child(int i) => section.isEmpty ? '${i + 1}' : '$section.${i + 1}';
    switch (e.mimeType) {
      case 'multipart/alternative':
        // The richest version of each kind: the last HTML and the last plain text.
        MimeEntity? html;
        MimeEntity? text;
        var htmlIndex = -1;
        for (final (i, p) in e.parts.indexed) {
          if (p.mimeType == 'text/html' || (p.isMultipart && _containsHtml(p))) {
            html = p;
            htmlIndex = i;
          } else if (p.mimeType == 'text/plain') {
            text = p;
          } else if (p.mimeType == 'text/calendar') {
            // An invitation (iMIP): the app shows it as a card.
            attach(p, child(i));
          }
        }
        if (text != null) texts.add(text);
        if (html != null) {
          if (html.isMultipart) {
            walk(html, child(htmlIndex), inAlternative: true);
          } else {
            htmls.add(html);
          }
        }
        if (html == null && text == null && e.parts.isNotEmpty) walk(e.parts.last, child(e.parts.length - 1));
      case 'multipart/related':
        if (e.parts.isEmpty) return;
        final start = e.contentType['start']?.replaceAll(RegExp(r'[<>]'), '');
        var rootIndex = start == null ? 0 : e.parts.indexWhere((p) => p.contentId == start);
        if (rootIndex < 0) rootIndex = 0;
        for (final (i, p) in e.parts.indexed) {
          if (i == rootIndex) {
            walk(p, child(i), inAlternative: inAlternative);
          } else {
            attach(p, child(i), inline: p.contentId != null);
          }
        }
      default:
        // mixed, signed, encrypted, report, …: inline text parts are the body.
        for (final (i, p) in e.parts.indexed) {
          if (i == 0 || isBodyText(p) || p.isMultipart) {
            walk(p, child(i));
          } else {
            attach(p, child(i));
          }
        }
    }
  }

  walk(root, root.isMultipart ? '' : '1');

  String? join(List<MimeEntity> parts, String separator) =>
      parts.isEmpty ? null : parts.map((p) => p.text).join(separator);

  var text = join(texts, '\n\n');
  var flowed = false;
  if (texts.isNotEmpty && texts.first.contentType['format']?.toLowerCase() == 'flowed' && text != null) {
    if (texts.first.contentType['delsp']?.toLowerCase() == 'yes') {
      text = unflow(text, delSp: true);
    } else {
      flowed = true;
    }
  }
  return EmailContent(
    emailId: emailId,
    html: join(htmls, '\n'),
    text: text,
    isFlowed: flowed,
    attachments: attachments,
    inlineData: inlineData,
    headers: headers,
  );
}

bool _containsHtml(MimeEntity e) =>
    e.isMultipart ? e.parts.any(_containsHtml) : e.mimeType == 'text/html' && e.disposition.value != 'attachment';

/// The part behind a [contentFromEntity] part id, or null.
MimeEntity? partOf(MimeEntity root, String partId, {String partPrefix = 'pgp:'}) {
  if (!partId.startsWith(partPrefix)) return null;
  return root.find(partId.substring(partPrefix.length));
}

/// Unwraps format=flowed text (RFC 3676) into one line per paragraph.
String unflow(String text, {required bool delSp}) {
  final out = <String>[];
  String? current;
  var depth = -1;
  String prefix(int d) => d == 0 ? '' : '${'>' * d} ';
  for (final line in text.split(RegExp(r'\r?\n'))) {
    var d = 0;
    while (d < line.length && line[d] == '>') {
      d++;
    }
    var content = line.substring(d);
    if (content.startsWith(' ')) content = content.substring(1);
    final soft = content.endsWith(' ') && content != '-- ';
    if (soft && delSp) content = content.substring(0, content.length - 1);
    if (current != null && d == depth) {
      current += content;
    } else {
      if (current != null) out.add(prefix(depth) + current);
      current = content;
      depth = d;
    }
    if (!soft) {
      out.add(prefix(depth) + current);
      current = null;
      depth = -1;
    }
  }
  if (current != null) out.add(prefix(depth) + current);
  return out.join('\n');
}
