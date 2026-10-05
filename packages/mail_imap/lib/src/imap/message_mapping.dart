/// Fetched IMAP data → mail model objects.
library;

import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

import '../mime/charsets.dart';
import '../mime/headers.dart';
import '../mime/plain_text.dart';
import '../mime/transfer_encoding.dart';
import 'body_structure.dart';
import 'envelope.dart';
import 'keyword_mapping.dart';
import 'parsers.dart';

/// Header fields fetched with every list row, besides the ENVELOPE:
/// threading, and the mailing-list headers (List-Id grouping, Reply to
/// List, unsubscribing).
const summaryHeaderFields = [
  'REFERENCES',
  'IN-REPLY-TO',
  'LIST-ID',
  'LIST-POST',
  'LIST-UNSUBSCRIBE',
  'LIST-UNSUBSCRIBE-POST',
];

/// FETCH items for a list row. `X-GM-THRID` is added for Gmail.
String summaryFetchItems({required bool gmail}) =>
    '(UID FLAGS INTERNALDATE RFC822.SIZE ENVELOPE BODYSTRUCTURE '
    'BODY.PEEK[HEADER.FIELDS (${summaryHeaderFields.join(' ')})]${gmail ? ' X-GM-THRID' : ''})';

/// How many bytes of a part a preview needs.
int previewBytes(BodyNode part) => part.subtype == 'html' ? 4096 : 2048;

/// The thread id for a Gmail X-GM-THRID.
String gmailThreadId(String accountId, String thrid) => '$accountId|gmthread|$thrid';

/// Builds a list row; null if the server sent no UID.
EmailSummary? summaryFromFetch(
  FetchedMessage m, {
  required String accountId,
  required String path,
  required int uidValidity,
  String preview = '',
}) {
  final uid = m.uid;
  if (uid == null) return null;
  final env = m.envelope ?? const ImapEnvelope();
  final headers = parseHeaderBlock(m.sections['HEADER.FIELDS'] ?? Uint8List(0));
  final structure = m.structure;
  final thrid = m.gmailThreadId;
  final list = parseListId(headerValue(headers, 'List-Id'));
  String? raw(String name) {
    final v = headerValue(headers, name)?.trim();
    return v == null || v.isEmpty ? null : v;
  }

  return EmailSummary(
    id: MailIds.imapEmail(accountId, path, uidValidity, uid),
    accountId: accountId,
    mailboxId: MailIds.mailbox(accountId, path),
    receivedAt: m.internalDate ?? env.date ?? DateTime.fromMillisecondsSinceEpoch(0),
    sentAt: env.date,
    threadId: thrid == null ? null : gmailThreadId(accountId, thrid),
    messageIdHeader: env.messageId,
    inReplyTo: env.inReplyTo ?? stripMessageId(headerValue(headers, 'In-Reply-To')),
    references: parseMessageIds(headerValue(headers, 'References')),
    from: env.from,
    to: env.to,
    cc: env.cc,
    bcc: env.bcc,
    replyTo: env.replyTo,
    subject: env.subject,
    preview: preview,
    size: m.size ?? 0,
    keywords: keywordsFromFlags(m.flags ?? const []),
    hasAttachment: structure != null && hasVisibleAttachment(structure),
    isEncrypted: structure != null && isEncryptedStructure(structure),
    listId: list?.id,
    listName: list?.name,
    listPost: raw('List-Post'),
    listUnsubscribe: raw('List-Unsubscribe'),
    listUnsubscribePost: raw('List-Unsubscribe-Post'),
  );
}

/// Decodes the (possibly truncated) start of [part] into a preview.
String previewFromPart(BodyNode part, List<int> raw) {
  final bytes = decodeTransferEncoding(raw, part.encoding);
  var text = decodeCharset(bytes, part.charset).replaceAll('�', '');
  if (part.subtype == 'html') text = htmlToPreviewText(text);
  return makePreview(text);
}

/// Decodes a complete text part.
String decodeTextPart(BodyNode part, List<int> raw) =>
    decodeCharset(decodeTransferEncoding(raw, part.encoding), part.charset);

/// Which sections [fetchContent] needs: the body parts and small inline
/// images (`cid:`), within [inlineCap] each and [totalInlineCap] together.
({List<BodyNode> body, List<Attachment> inline}) planContentFetch(
  BodyNode root, {
  int inlineCap = 1024 * 1024,
  int totalInlineCap = 8 * 1024 * 1024,
}) {
  final body = selectDisplayParts(root).all.toList();
  final inline = <Attachment>[];
  var total = 0;
  for (final a in listAttachments(root)) {
    if (a.contentId == null || !a.isImage || a.size > inlineCap) continue;
    if (total + a.size > totalInlineCap) break;
    total += a.size;
    inline.add(a);
  }
  return (body: body, inline: inline);
}

/// Assembles [EmailContent] from the structure, the raw header block and
/// the fetched sections (keyed by section).
EmailContent buildContent({
  required String emailId,
  required BodyNode root,
  required List<int> header,
  required Map<String, Uint8List> sections,
}) {
  final display = selectDisplayParts(root);
  String? join(List<BodyNode> parts, String separator) {
    final texts = [
      for (final p in parts)
        if (sections[p.section] case final raw?) decodeTextPart(p, raw),
    ];
    return texts.isEmpty ? null : texts.join(separator);
  }

  final html = join(display.html, '\n');
  var text = join(display.text, '\n\n');
  var flowed = display.text.isNotEmpty && display.text.first.isFlowed;
  if (flowed && text != null && display.text.first.isDelSp) {
    // The model has no DelSp flag: unwrap here and hand over plain text.
    text = unflowText(text, delSp: true);
    flowed = false;
  }
  final attachments = listAttachments(root);
  final inlineData = <String, Uint8List>{};
  for (final a in attachments) {
    final cid = a.contentId;
    final raw = sections[a.partId];
    if (cid == null || raw == null) continue;
    final node = root.find(a.partId);
    inlineData[cid] = decodeTransferEncoding(raw, node?.encoding);
  }
  return EmailContent(
    emailId: emailId,
    html: html,
    text: text,
    isFlowed: flowed,
    attachments: attachments,
    inlineData: inlineData,
    headers: parseHeaderBlock(header),
  );
}

/// Unwraps format=flowed text (RFC 3676) into one line per paragraph.
String unflowText(String text, {required bool delSp}) {
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
