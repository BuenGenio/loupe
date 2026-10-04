import 'package:mail_model/mail_model.dart';

/// JSON form of [EmailSummary], for operation payloads (reverting deletes).
Map<String, Object?> summaryToJson(EmailSummary e) => {
  'id': e.id,
  'accountId': e.accountId,
  'mailboxId': e.mailboxId,
  'receivedAt': e.receivedAt.millisecondsSinceEpoch,
  'threadId': e.threadId,
  'messageId': e.messageIdHeader,
  'inReplyTo': e.inReplyTo,
  'references': e.references,
  'from': _addrs(e.from),
  'to': _addrs(e.to),
  'cc': _addrs(e.cc),
  'bcc': _addrs(e.bcc),
  'replyTo': _addrs(e.replyTo),
  'subject': e.subject,
  'preview': e.preview,
  'sentAt': e.sentAt?.millisecondsSinceEpoch,
  'size': e.size,
  'keywords': e.keywords.toList(),
  'hasAttachment': e.hasAttachment,
  if (e.listId != null) 'listId': e.listId,
  if (e.listName != null) 'listName': e.listName,
  if (e.listPost != null) 'listPost': e.listPost,
  if (e.listUnsubscribe != null) 'listUnsubscribe': e.listUnsubscribe,
  if (e.listUnsubscribePost != null) 'listUnsubscribePost': e.listUnsubscribePost,
};

EmailSummary summaryFromJson(Map<String, Object?> j) => EmailSummary(
  id: j['id']! as String,
  accountId: j['accountId']! as String,
  mailboxId: j['mailboxId']! as String,
  receivedAt: DateTime.fromMillisecondsSinceEpoch(j['receivedAt']! as int),
  threadId: j['threadId'] as String?,
  messageIdHeader: j['messageId'] as String?,
  inReplyTo: j['inReplyTo'] as String?,
  references: _strings(j['references']),
  from: _parseAddrs(j['from']),
  to: _parseAddrs(j['to']),
  cc: _parseAddrs(j['cc']),
  bcc: _parseAddrs(j['bcc']),
  replyTo: _parseAddrs(j['replyTo']),
  subject: j['subject'] as String? ?? '',
  preview: j['preview'] as String? ?? '',
  sentAt: j['sentAt'] == null ? null : DateTime.fromMillisecondsSinceEpoch(j['sentAt']! as int),
  size: j['size'] as int? ?? 0,
  keywords: _strings(j['keywords']).toSet(),
  hasAttachment: j['hasAttachment'] as bool? ?? false,
  listId: j['listId'] as String?,
  listName: j['listName'] as String?,
  listPost: j['listPost'] as String?,
  listUnsubscribe: j['listUnsubscribe'] as String?,
  listUnsubscribePost: j['listUnsubscribePost'] as String?,
);

List<Map<String, Object?>> _addrs(List<EmailAddress> list) => [
  for (final a in list) {'e': a.email, 'n': a.name},
];

List<EmailAddress> _parseAddrs(Object? json) => [
  for (final a in (json as List<Object?>? ?? const []).cast<Map<String, Object?>>())
    EmailAddress(a['e']! as String, a['n'] as String?),
];

List<String> _strings(Object? json) => [for (final s in json as List<Object?>? ?? const []) s! as String];
