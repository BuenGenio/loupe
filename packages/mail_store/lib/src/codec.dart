import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

import 'schema.dart';

/// Serialises address lists as `[{"e": email, "n": name}]`.
String encodeAddresses(List<EmailAddress> list) => jsonEncode([
  for (final a in list) {'e': a.email, if (a.name != null && a.name!.isNotEmpty) 'n': a.name},
]);

List<EmailAddress> decodeAddresses(String json) {
  final list = jsonDecode(json) as List<Object?>;
  return [
    for (final item in list)
      if (item case {'e': final String e}) EmailAddress(e, (item as Map)['n'] as String?),
  ];
}

String encodeStrings(Iterable<String> values) => jsonEncode(values.toList());

List<String> decodeStrings(String json) => [for (final v in jsonDecode(json) as List<Object?>) v! as String];

/// Keywords as a sorted JSON array of lower-cased strings.
String encodeKeywords(Iterable<String> keywords) =>
    jsonEncode((keywords.map(Keywords.normalize).toSet().toList())..sort());

int? millis(DateTime? d) => d?.millisecondsSinceEpoch;

DateTime fromMillis(int ms) => DateTime.fromMillisecondsSinceEpoch(ms);

EmailSummary summaryFromRow(EmailRow r) => EmailSummary(
  id: r.id,
  accountId: r.accountId,
  mailboxId: r.mailboxId,
  receivedAt: fromMillis(r.receivedAt),
  threadId: r.threadId,
  messageIdHeader: r.messageIdHeader,
  inReplyTo: r.inReplyTo,
  references: decodeStrings(r.referencesJson),
  from: decodeAddresses(r.fromAddrs),
  to: decodeAddresses(r.toAddrs),
  cc: decodeAddresses(r.ccAddrs),
  bcc: decodeAddresses(r.bccAddrs),
  replyTo: decodeAddresses(r.replyToAddrs),
  subject: r.subject,
  preview: r.preview,
  sentAt: r.sentAt == null ? null : fromMillis(r.sentAt!),
  size: r.size,
  keywords: decodeStrings(r.keywords).toSet(),
  hasAttachment: r.hasAttachment,
);

Mailbox mailboxFromRow(MailboxRow r) => Mailbox(
  id: r.id,
  accountId: r.accountId,
  name: r.name,
  path: r.path,
  role: MailboxRole.values.asNameMap()[r.role] ?? MailboxRole.none,
  parentId: r.parentId,
  unreadCount: r.unreadCount,
  totalCount: r.totalCount,
  isSelectable: r.isSelectable,
  isSubscribed: r.isSubscribed,
  sortOrder: r.sortOrder,
);

/// Strips angle brackets and whitespace from a Message-ID.
String normalizeMessageId(String id) {
  var s = id.trim();
  if (s.startsWith('<')) s = s.substring(1);
  if (s.endsWith('>')) s = s.substring(0, s.length - 1);
  return s.trim();
}

final _replyPrefix = RegExp(
  r'^\s*((re|fwd?|aw|wg|sv|vs|antw|rif|tr|r|ref|odp|enc|res)(\s*\[\d+\]|\s*\(\d+\))?\s*[:：]\s*|\[[^\]]{1,40}\]\s*)',
  caseSensitive: false,
);

/// The subject without reply/forward prefixes and list tags, lower-cased and
/// whitespace-collapsed (JWZ "base subject").
String baseSubject(String subject) {
  var s = subject;
  while (true) {
    final m = _replyPrefix.firstMatch(s);
    if (m == null || m.end == 0) break;
    s = s.substring(m.end);
  }
  return s.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
}

/// True if [subject] starts with a reply or forward prefix.
bool isReplySubject(String subject) => RegExp(
  r'^\s*(\[[^\]]{1,40}\]\s*)*(re|fwd?|aw|wg|sv|vs|antw|rif|tr|r|ref|odp|enc|res)(\s*\[\d+\])?\s*[:：]',
  caseSensitive: false,
).hasMatch(subject);

String encodeHeaders(List<(String, String)> headers) => jsonEncode([
  for (final (n, v) in headers) [n, v],
]);

List<(String, String)> decodeHeaders(String json) => [
  for (final h in (jsonDecode(json) as List<Object?>).cast<List<Object?>>()) (h[0]! as String, h[1]! as String),
];

Map<String, Object?> attachmentToJson(Attachment a) => {
  'partId': a.partId,
  'mimeType': a.mimeType,
  'filename': a.filename,
  'size': a.size,
  'contentId': a.contentId,
  'isInline': a.isInline,
};

Attachment attachmentFromJson(Map<String, Object?> j) => Attachment(
  partId: j['partId']! as String,
  mimeType: j['mimeType']! as String,
  filename: j['filename'] as String?,
  size: j['size'] as int? ?? 0,
  contentId: j['contentId'] as String?,
  isInline: j['isInline'] as bool? ?? false,
);

String encodeAttachments(List<Attachment> list) => jsonEncode([for (final a in list) attachmentToJson(a)]);

List<Attachment> decodeAttachments(String json) => [
  for (final a in jsonDecode(json) as List<Object?>) attachmentFromJson((a! as Map).cast()),
];

Map<String, Object?> _addrJson(EmailAddress a) => {'e': a.email, 'n': a.name};

EmailAddress _addrFromJson(Object? j) {
  final m = (j! as Map).cast<String, Object?>();
  return EmailAddress(m['e']! as String, m['n'] as String?);
}

/// Serialises an outgoing message, attachment data included (base64).
String encodeOutgoing(OutgoingMessage m) => jsonEncode({
  'accountId': m.accountId,
  'identityId': m.identityId,
  'to': [for (final a in m.to) _addrJson(a)],
  'cc': [for (final a in m.cc) _addrJson(a)],
  'bcc': [for (final a in m.bcc) _addrJson(a)],
  'subject': m.subject,
  'text': m.text,
  'html': m.html,
  'attachments': [
    for (final a in m.attachments) {'filename': a.filename, 'mimeType': a.mimeType, 'data': base64Encode(a.data)},
  ],
  'inReplyTo': m.inReplyTo,
  'references': m.references,
  'mode': m.mode.name,
  'sourceEmailId': m.sourceEmailId,
  'draftId': m.draftId,
});

OutgoingMessage decodeOutgoing(String json) {
  final j = (jsonDecode(json) as Map).cast<String, Object?>();
  List<EmailAddress> addrs(String k) => [for (final a in j[k]! as List<Object?>) _addrFromJson(a)];
  return OutgoingMessage(
    accountId: j['accountId']! as String,
    identityId: j['identityId']! as String,
    to: addrs('to'),
    cc: addrs('cc'),
    bcc: addrs('bcc'),
    subject: j['subject']! as String,
    text: j['text']! as String,
    html: j['html'] as String?,
    attachments: [
      for (final a in (j['attachments']! as List<Object?>).cast<Map<String, Object?>>())
        OutgoingAttachment(
          filename: a['filename']! as String,
          mimeType: a['mimeType']! as String,
          data: Uint8List.fromList(base64Decode(a['data']! as String)),
        ),
    ],
    inReplyTo: j['inReplyTo'] as String?,
    references: [for (final r in j['references']! as List<Object?>) r! as String],
    mode: ComposeMode.values.byName(j['mode']! as String),
    sourceEmailId: j['sourceEmailId'] as String?,
    draftId: j['draftId'] as String?,
  );
}

/// Plain text for the full-text index: the text body, or the HTML with tags
/// stripped.
String bodyTextFor(EmailContent c, {int maxChars = 64 * 1024}) {
  var t = c.text;
  if (t == null || t.trim().isEmpty) {
    final html = c.html ?? '';
    t = html
        .replaceAll(RegExp(r'<(script|style|head)[^>]*>.*?</\1\s*>', caseSensitive: false, dotAll: true), ' ')
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'");
  }
  t = t.replaceAll(RegExp(r'\s+'), ' ').trim();
  return t.length > maxChars ? t.substring(0, maxChars) : t;
}
