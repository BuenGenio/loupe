import 'dart:convert';
import 'dart:io';

import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:sqlite3/sqlite3.dart';

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
  bool isEncrypted = false,
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
  isEncrypted: isEncrypted,
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

/// The schema version a store has after opening (`StoreDatabase.schemaVersion`).
const latestSchemaVersion = 6;

/// Creates a database of schema [version] at [path], as that release created
/// it (`test/schemas/v<version>.sql`, encrypted with the key `k`), with an
/// account, an Inbox, a synced message and its content (and a rule from
/// version 2 on).
void createOldDatabase(String path, int version) {
  final db = sqlite3.open(path)..execute("PRAGMA key = 'k'");
  final ddl = File('test/schemas/v$version.sql').readAsStringSync().split(RegExp(r'^--$', multiLine: true));
  for (final statement in ddl) {
    final sql = statement.split('\n').where((l) => !l.startsWith('-- ')).join('\n').trim();
    if (sql.isNotEmpty) db.execute(sql);
  }
  db
    ..execute('INSERT INTO accounts (id, email, display_name, json) VALUES (?, ?, ?, ?)', [
      accountId,
      'me@example.com',
      'Work',
      jsonEncode(account().toJson()),
    ])
    ..execute("INSERT INTO mailboxes (id, account_id, name, path, role) VALUES (?, ?, 'Inbox', 'INBOX', 'inbox')", [
      mbox('INBOX'),
      accountId,
    ])
    ..execute("INSERT INTO sync_states (mailbox_id, state, synced_at) VALUES (?, '{\"v\":1}', 1)", [mbox('INBOX')])
    ..execute(
      'INSERT INTO emails (id, account_id, mailbox_id, thread_id, subject, received_at, keywords) '
      "VALUES (?, ?, ?, 'acc1|t:x', 'Before the upgrade', 1000, ?)",
      [eid('INBOX', 1), accountId, mbox('INBOX'), '["\$seen"]'],
    )
    ..execute(
      "INSERT INTO contents (email_id, plain_text, body_text, fetched_at) VALUES (?, 'kumquat', 'kumquat', 1)",
      [eid('INBOX', 1)],
    );
  if (version >= 2) db.execute("INSERT INTO rules (id, json, sort_order) VALUES ('r1', '{}', 0)");
  db
    ..execute('PRAGMA user_version = $version')
    ..close();
}
