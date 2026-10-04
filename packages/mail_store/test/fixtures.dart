import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';

const accountId = 'acc1';

MailAccount account({String id = accountId, String email = 'me@example.com', String name = 'Work'}) => MailAccount(
  id: id,
  email: email,
  displayName: name,
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: const ServerConfig(protocol: ServerProtocol.imap, host: 'imap.example.com', port: 993),
  identities: [
    Identity(id: '$id/default', email: email, name: 'Me'),
    Identity(id: '$id/alt', email: 'alias@$id.test'),
  ],
);

String mbox(String path, {String account = accountId}) => MailIds.mailbox(account, path);

String eid(String path, int uid, {String account = accountId, int validity = 1}) =>
    MailIds.imapEmail(account, path, validity, uid);

final base = DateTime(2026, 9, 1, 12);

EmailSummary mail(
  int uid, {
  String path = 'INBOX',
  String account = accountId,
  int validity = 1,
  String subject = 'Hello',
  String from = 'alice@example.com',
  String? fromName = 'Alice',
  List<String> to = const ['me@example.com'],
  List<String> cc = const [],
  String preview = '',
  Set<String> keywords = const {},
  int minutes = 0,
  String? messageId,
  String? inReplyTo,
  List<String> references = const [],
  String? threadId,
  int size = 1000,
  bool hasAttachment = false,
  String? listId,
  String? listName,
  String? listPost,
  String? listUnsubscribe,
  String? listUnsubscribePost,
}) => EmailSummary(
  id: eid(path, uid, account: account, validity: validity),
  accountId: account,
  mailboxId: mbox(path, account: account),
  receivedAt: base.add(Duration(minutes: minutes)),
  sentAt: base.add(Duration(minutes: minutes)),
  messageIdHeader: messageId,
  inReplyTo: inReplyTo,
  references: references,
  threadId: threadId,
  from: [EmailAddress(from, fromName)],
  to: [for (final t in to) EmailAddress(t)],
  cc: [for (final c in cc) EmailAddress(c)],
  subject: subject,
  preview: preview,
  keywords: keywords,
  size: size,
  hasAttachment: hasAttachment,
  listId: listId,
  listName: listName,
  listPost: listPost,
  listUnsubscribe: listUnsubscribe,
  listUnsubscribePost: listUnsubscribePost,
);

const standardMailboxes = [
  RemoteMailbox(path: 'INBOX', name: 'Inbox', role: MailboxRole.inbox),
  RemoteMailbox(path: 'Sent', name: 'Sent', role: MailboxRole.sent),
  RemoteMailbox(path: 'Drafts', name: 'Drafts', role: MailboxRole.drafts),
  RemoteMailbox(path: 'Archive', name: 'Archive', role: MailboxRole.archive),
  RemoteMailbox(path: 'Trash', name: 'Trash', role: MailboxRole.trash),
  RemoteMailbox(path: 'Junk', name: 'Junk', role: MailboxRole.junk),
  RemoteMailbox(path: 'Work', name: 'Work'),
];

/// A memory store with one account and [standardMailboxes].
Future<MailStore> seededStore({List<MailAccount>? accounts}) async {
  final store = MailStore.memory();
  for (final a in accounts ?? [account()]) {
    await store.saveAccount(a);
    await store.replaceMailboxes(a.id, standardMailboxes);
  }
  return store;
}

MailboxSyncResult added(List<EmailSummary> emails, {int? total, int? unread, bool hasOlder = false}) =>
    MailboxSyncResult(
      state: const MailboxSyncState({'v': 1}),
      added: emails,
      totalCount: total,
      unreadCount: unread,
      hasOlder: hasOlder,
    );

Future<void> addMails(MailStore store, List<EmailSummary> emails) async {
  final byBox = <String, List<EmailSummary>>{};
  for (final e in emails) {
    (byBox[e.mailboxId] ??= []).add(e);
  }
  for (final MapEntry(:key, :value) in byBox.entries) {
    await store.applySync(key, added(value));
  }
}
