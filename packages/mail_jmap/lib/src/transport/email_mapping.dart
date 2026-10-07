/// JMAP `Email` objects → mail model objects.
library;

import 'package:mail_imap/mime.dart';
import 'package:mail_model/mail_model.dart';

import '../client/request.dart';

/// Properties of each [EmailBodyPart] Loupe asks for. The Content-Type
/// header carries the parameters the part's `type` leaves out (`format`,
/// `delsp`, `smime-type`, `protocol`, `start`).
const bodyProperties = [
  'partId',
  'blobId',
  'size',
  'name',
  'type',
  'charset',
  'disposition',
  'cid',
  'subParts',
  'header:Content-Type',
];

/// The list headers, fetched raw (Stalwart has no `asText` form of
/// List-Id) and decoded here as the IMAP transport does.
const listHeaders = ['List-Id', 'List-Post', 'List-Unsubscribe', 'List-Unsubscribe-Post'];

/// Properties of a list row. [previews] adds the server's preview text.
List<String> summaryProperties({bool previews = true}) => [
  'id',
  'blobId',
  'threadId',
  'mailboxIds',
  'keywords',
  'size',
  'receivedAt',
  'sentAt',
  'messageId',
  'inReplyTo',
  'references',
  'from',
  'to',
  'cc',
  'bcc',
  'replyTo',
  'subject',
  if (previews) 'preview',
  'bodyStructure',
  for (final h in listHeaders) 'header:$h',
];

/// The thread id of JMAP thread [threadId], unique across accounts.
String jmapThreadId(String accountId, String threadId) => '$accountId|jmthread|$threadId';

/// The value of header property `header:<name>[:form]` in [json]; servers
/// may leave out the default `:asRaw` and differ in case.
Object? headerProperty(Json json, String name, {String? form}) {
  final key = form == null ? 'header:$name' : 'header:$name:$form';
  if (json.containsKey(key)) return json[key];
  final lower = key.toLowerCase();
  final bare = 'header:$name'.toLowerCase();
  for (final MapEntry(key: k, :value) in json.entries) {
    final l = k.toLowerCase();
    if (l == lower || (form == null || form == 'asRaw') && l == bare || form == 'asRaw' && l == '$bare:asraw') {
      return value;
    }
  }
  return null;
}

List<EmailAddress> addressesOf(Object? json) => [
  if (json is List)
    for (final a in json)
      if (a is Map && a['email'] is String && (a['email'] as String).isNotEmpty)
        EmailAddress(a['email'] as String, (a['name'] as String?)?.trim().isEmpty ?? true ? null : a['name'] as String),
];

DateTime? dateOf(Object? json) => json is String ? DateTime.tryParse(json) : null;

/// The list row of [email] in the mailbox at [path].
EmailSummary summaryOf(Json email, {required String accountId, required String path}) {
  final id = email['id']! as String;
  final structure = email['bodyStructure'];
  final root = structure is Map ? JmapStructure.of(structure.cast()).root : null;
  final listId = parseListId(_text(headerProperty(email, 'List-Id')));
  final received = dateOf(email['receivedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
  final thread = email['threadId'] as String?;
  return EmailSummary(
    id: MailIds.jmapEmailIn(accountId, path, id),
    accountId: accountId,
    mailboxId: MailIds.mailbox(accountId, path),
    receivedAt: received,
    sentAt: dateOf(email['sentAt']),
    threadId: thread == null ? null : jmapThreadId(accountId, thread),
    messageIdHeader: stringList(email['messageId']).firstOrNull,
    inReplyTo: stringList(email['inReplyTo']).firstOrNull,
    references: stringList(email['references']),
    from: addressesOf(email['from']),
    to: addressesOf(email['to']),
    cc: addressesOf(email['cc']),
    bcc: addressesOf(email['bcc']),
    replyTo: addressesOf(email['replyTo']),
    subject: email['subject'] as String? ?? '',
    preview: makePreview(email['preview'] as String? ?? ''),
    size: (email['size'] as num?)?.toInt() ?? 0,
    keywords: keywordsOf(email['keywords']),
    hasAttachment: root != null ? hasVisibleAttachment(root) : email['hasAttachment'] == true,
    isEncrypted: root != null && isEncryptedStructure(root),
    listId: listId?.id,
    listName: listId?.name,
    listPost: _text(headerProperty(email, 'List-Post')),
    listUnsubscribe: _text(headerProperty(email, 'List-Unsubscribe')),
    listUnsubscribePost: _text(headerProperty(email, 'List-Unsubscribe-Post')),
  );
}

/// A raw header value unfolded, trimmed and with encoded words decoded;
/// null when absent or empty.
String? _text(Object? value) {
  if (value is! String) return null;
  final t = decodeHeaderValue(value);
  return t.isEmpty ? null : t;
}

/// A raw header value as the reader shows it: unfolded, trimmed, encoded
/// words decoded.
String decodeHeaderValue(String raw) => decodeEncodedWords(raw.replaceAll(RegExp(r'\r?\n[ \t]+'), ' ').trim());

/// Lower-cased keywords of a JMAP keyword set.
Set<String> keywordsOf(Object? json) => {for (final k in idSet(json)) Keywords.normalize(k)};

/// A JMAP keyword set for [keywords].
Json keywordSet(Iterable<String> keywords) => {for (final k in keywords) Keywords.normalize(k): true};

/// An email's `bodyStructure` as the [BodyNode] tree the IMAP transport
/// uses, so both choose body parts and attachments the same way, and the
/// JMAP part of each leaf by its section.
final class JmapStructure {
  JmapStructure._(this.root, this.parts);

  factory JmapStructure.of(Json bodyStructure) {
    final parts = <String, Json>{};
    final root = _node(bodyStructure, '', parts, root: true);
    return JmapStructure._(root, parts);
  }

  final BodyNode root;

  /// Leaf section → its [EmailBodyPart] (`partId`, `blobId`…).
  final Map<String, Json> parts;

  String? blobIdOf(String section) => parts[section]?['blobId'] as String?;
  String? partIdOf(String section) => parts[section]?['partId'] as String?;

  /// A leaf's section is its JMAP `partId`, except a message that is a
  /// single part: `1`, as in IMAP. Blobs come decoded, so there is no
  /// transfer encoding.
  static BodyNode _node(Json part, String section, Map<String, Json> parts, {bool root = false}) {
    final (type, subtype, params) = parseContentType(
      headerProperty(part, 'Content-Type') as String?,
      fallback: part['type'] as String?,
    );
    final charset = part['charset'];
    final name = part['name'];
    final children = <BodyNode>[];
    final sub = part['subParts'];
    final multipart = type == 'multipart';
    if (multipart && sub is List) {
      for (final (i, c) in sub.indexed) {
        if (c is Map) children.add(_node(c.cast(), section.isEmpty ? 'm${i + 1}' : '$section.${i + 1}', parts));
      }
    }
    final own = multipart ? section : (root ? '1' : (part['partId'] as String? ?? section));
    if (!multipart) parts[own] = part;
    return BodyNode(
      type: type,
      subtype: subtype,
      section: own,
      params: {...params, if (charset is String && charset.isNotEmpty) 'charset': charset},
      id: part['cid'] as String?,
      size: (part['size'] as num?)?.toInt() ?? 0,
      disposition: (part['disposition'] as String?)?.toLowerCase(),
      dispositionParams: {if (name is String && name.trim().isNotEmpty) 'filename': name},
      children: children,
    );
  }
}

/// Splits a Content-Type value into type, subtype and parameters (keys
/// lower-cased, RFC 2231 and encoded words decoded). [fallback] is the
/// media type when there is no header (`text/plain` when neither).
(String, String, Map<String, String>) parseContentType(String? header, {String? fallback}) {
  final segments = <String>[];
  final current = StringBuffer();
  var quoted = false;
  final value = header ?? '';
  for (var i = 0; i < value.length; i++) {
    final c = value[i];
    if (c == r'\' && quoted && i + 1 < value.length) {
      current.write(value[++i]);
      continue;
    }
    if (c == '"') {
      quoted = !quoted;
      continue;
    }
    if (c == ';' && !quoted) {
      segments.add(current.toString());
      current.clear();
      continue;
    }
    current.write(c);
  }
  segments.add(current.toString());
  var media = segments.first.replaceAll(RegExp(r'\s+'), '').toLowerCase();
  if (!media.contains('/')) media = (fallback ?? 'text/plain').toLowerCase();
  final raw = <String, String>{};
  for (final s in segments.skip(1)) {
    final eq = s.indexOf('=');
    if (eq <= 0) continue;
    raw[s.substring(0, eq).trim()] = s.substring(eq + 1).trim();
  }
  final slash = media.indexOf('/');
  return (media.substring(0, slash), media.substring(slash + 1), normalizeParameters(raw));
}

/// The header fields of an email (`headers`, raw values) as the reader
/// shows them: unfolded, trimmed, encoded words decoded.
List<(String, String)> headersOf(Object? json) => [
  if (json is List)
    for (final h in json)
      if (h is Map && h['name'] is String) (h['name'] as String, decodeHeaderValue(h['value'] as String? ?? '')),
];
