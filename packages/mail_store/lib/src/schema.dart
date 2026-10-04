import 'package:drift/drift.dart';

part 'schema.g.dart';

/// Configured accounts; [json] is a serialised `MailAccount`.
@DataClassName('AccountRow')
class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get displayName => text()();
  TextColumn get json => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MailboxRow')
class Mailboxes extends Table {
  TextColumn get id => text()();
  TextColumn get accountId => text().references(Accounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get path => text()();

  /// `MailboxRole.name`.
  TextColumn get role => text()();
  TextColumn get parentId => text().nullable()();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  IntColumn get totalCount => integer().withDefault(const Constant(0))();
  BoolColumn get isSelectable => boolean().withDefault(const Constant(true))();
  BoolColumn get isSubscribed => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Opaque transport sync state per mailbox, kept apart from [Mailboxes] so a
/// sync that changes nothing doesn't wake mailbox watchers.
@DataClassName('SyncStateRow')
class SyncStates extends Table {
  TextColumn get mailboxId => text().references(Mailboxes, #id, onDelete: KeyAction.cascade)();
  TextColumn get state => text()();
  BoolColumn get hasOlder => boolean().withDefault(const Constant(false))();
  IntColumn get syncedAt => integer()();

  /// The stored summaries lack header fields added since they were fetched
  /// (schema version 3: the List-* headers); the sync engine fetches them
  /// again once and clears this.
  BoolColumn get staleHeaders => boolean().withDefault(const Constant(false))();

  /// How far that refetch got, newest first: the `received_at` and `seq` of
  /// the oldest message done, so a refetch cut short (the app killed, the
  /// connection lost) goes on from there. Null before its first batch.
  /// Schema version 5.
  IntColumn get headersDoneAt => integer().nullable()();
  IntColumn get headersDoneSeq => integer().nullable()();

  @override
  Set<Column> get primaryKey => {mailboxId};
}

/// Message summaries. [seq] is the stable integer key of the FTS index;
/// [id] is the deterministic `MailIds` id. Address lists are JSON arrays of
/// `{"e": email, "n": name}`; dates are epoch milliseconds.
@DataClassName('EmailRow')
@TableIndex(name: 'emails_mailbox_received', columns: {#mailboxId, #receivedAt})
@TableIndex(name: 'emails_received', columns: {#receivedAt})
@TableIndex(name: 'emails_thread', columns: {#accountId, #threadId})
@TableIndex(name: 'emails_message_id', columns: {#accountId, #messageIdHeader})
@TableIndex(name: 'emails_base_subject', columns: {#accountId, #baseSubject, #receivedAt})
@TableIndex(name: 'emails_from', columns: {#fromEmail})
@TableIndex(name: 'emails_list', columns: {#listId, #receivedAt})
class Emails extends Table {
  IntColumn get seq => integer().autoIncrement()();
  TextColumn get id => text().unique()();
  TextColumn get accountId => text()();
  TextColumn get mailboxId => text().references(Mailboxes, #id, onDelete: KeyAction.cascade)();
  TextColumn get threadId => text()();
  TextColumn get messageIdHeader => text().nullable()();
  TextColumn get inReplyTo => text().nullable()();
  TextColumn get referencesJson => text().withDefault(const Constant('[]'))();
  TextColumn get fromAddrs => text().named('from_json').withDefault(const Constant('[]'))();
  TextColumn get toAddrs => text().named('to_json').withDefault(const Constant('[]'))();
  TextColumn get ccAddrs => text().named('cc_json').withDefault(const Constant('[]'))();
  TextColumn get bccAddrs => text().named('bcc_json').withDefault(const Constant('[]'))();
  TextColumn get replyToAddrs => text().named('reply_to_json').withDefault(const Constant('[]'))();

  /// Lower-cased address of the first sender, for VIP and address filters.
  TextColumn get fromEmail => text().withDefault(const Constant(''))();
  TextColumn get subject => text().withDefault(const Constant(''))();

  /// Subject without reply/forward prefixes, lower-cased (threading fallback).
  TextColumn get baseSubject => text().withDefault(const Constant(''))();
  TextColumn get preview => text().withDefault(const Constant(''))();
  IntColumn get receivedAt => integer()();
  IntColumn get sentAt => integer().nullable()();
  IntColumn get size => integer().withDefault(const Constant(0))();

  /// JSON array of lower-cased keywords; mirrored into [EmailKeywords] by triggers.
  TextColumn get keywords => text().withDefault(const Constant('[]'))();
  BoolColumn get isSeen => boolean().withDefault(const Constant(false))();
  BoolColumn get isFlagged => boolean().withDefault(const Constant(false))();
  BoolColumn get hasAttachment => boolean().withDefault(const Constant(false))();

  /// The List-Id identifier (lower-cased, no brackets) and phrase; the
  /// other List-* headers as sent. Schema version 3.
  TextColumn get listId => text().nullable()();
  TextColumn get listName => text().nullable()();
  TextColumn get listPost => text().nullable()();
  TextColumn get listUnsubscribe => text().nullable()();
  TextColumn get listUnsubscribePost => text().nullable()();
}

/// One row per (email, keyword), maintained by triggers on [Emails].
@DataClassName('EmailKeywordRow')
@TableIndex(name: 'email_keywords_keyword', columns: {#keyword})
class EmailKeywords extends Table {
  TextColumn get emailId => text().references(Emails, #id, onDelete: KeyAction.cascade, onUpdate: KeyAction.cascade)();
  TextColumn get keyword => text()();

  @override
  Set<Column> get primaryKey => {emailId, keyword};
}

/// Cached message content.
@DataClassName('ContentRow')
class Contents extends Table {
  TextColumn get emailId => text().references(Emails, #id, onDelete: KeyAction.cascade, onUpdate: KeyAction.cascade)();
  TextColumn get html => text().nullable()();
  TextColumn get plainText => text().nullable()();
  BoolColumn get isFlowed => boolean().withDefault(const Constant(false))();
  TextColumn get headersJson => text().withDefault(const Constant('[]'))();
  TextColumn get attachmentsJson => text().withDefault(const Constant('[]'))();

  /// Plain body text for the full-text index (capped).
  TextColumn get bodyText => text().withDefault(const Constant(''))();
  IntColumn get fetchedAt => integer()();

  @override
  Set<Column> get primaryKey => {emailId};
}

/// Downloaded inline parts (`cid:` images), within a size cap.
@DataClassName('InlinePartRow')
class InlineParts extends Table {
  TextColumn get emailId => text().references(Emails, #id, onDelete: KeyAction.cascade, onUpdate: KeyAction.cascade)();
  TextColumn get contentId => text()();
  BlobColumn get data => blob()();

  @override
  Set<Column> get primaryKey => {emailId, contentId};
}

/// Messages queued for sending; [message] is a serialised `OutgoingMessage`
/// including attachment data.
@DataClassName('OutboxRow')
class OutboxItems extends Table {
  TextColumn get id => text()();
  TextColumn get accountId => text().references(Accounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get message => text()();
  IntColumn get sendAfter => integer()();

  /// `OutboxStatus.name`.
  TextColumn get status => text()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  IntColumn get createdAt => integer()();

  /// A failed message the server refused for good: never claimed again
  /// until it is rescheduled (Retry). Schema version 5.
  BoolColumn get held => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// The offline operation queue, replayed in [id] order per account.
@DataClassName('PendingOpRow')
class PendingOps extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get accountId => text().references(Accounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text()();
  TextColumn get payload => text()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  IntColumn get nextAttemptAt => integer()();
  IntColumn get createdAt => integer()();
  TextColumn get lastError => text().nullable()();
}

@DataClassName('VipRow')
class VipAddresses extends Table {
  /// Lower-cased address.
  TextColumn get email => text()();

  @override
  Set<Column> get primaryKey => {email};
}

/// Seen addresses for recipient autocomplete.
@DataClassName('AddressRow')
class AddressBook extends Table {
  /// Lower-cased address.
  TextColumn get email => text()();
  TextColumn get name => text().nullable()();
  IntColumn get seenCount => integer().withDefault(const Constant(0))();
  IntColumn get sentCount => integer().withDefault(const Constant(0))();
  IntColumn get lastUsedAt => integer()();

  @override
  Set<Column> get primaryKey => {email};
}

/// Message-ID → thread id per account (computed threading).
@DataClassName('ThreadRefRow')
class ThreadRefs extends Table {
  TextColumn get accountId => text().references(Accounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get messageId => text()();
  TextColumn get threadId => text()();

  @override
  Set<Column> get primaryKey => {accountId, messageId};
}

/// Old email id → new id after a server move, so ids held by the UI still
/// resolve.
@DataClassName('IdAliasRow')
class IdAliases extends Table {
  TextColumn get oldId => text()();
  TextColumn get newId => text()();

  @override
  Set<Column> get primaryKey => {oldId};
}

/// Mail rules; [json] is a serialised `Rule` whose order is [sortOrder].
@DataClassName('RuleRow')
class Rules extends Table {
  TextColumn get id => text()();
  TextColumn get json => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// How far device rules have run in a mailbox (the Inbox): messages stored
/// after [seq] whose IMAP UID is above [uid] (same [uidValidity]) are new.
@DataClassName('RuleWatermarkRow')
class RuleWatermarks extends Table {
  TextColumn get mailboxId => text().references(Mailboxes, #id, onDelete: KeyAction.cascade)();
  IntColumn get seq => integer()();
  IntColumn get uidValidity => integer().nullable()();
  IntColumn get uid => integer().nullable()();

  @override
  Set<Column> get primaryKey => {mailboxId};
}

/// Conversations the user muted (local only). New messages of a muted
/// thread arrive read and stay out of the mailing-list view. Schema
/// version 3.
@DataClassName('MutedThreadRow')
class MutedThreads extends Table {
  TextColumn get accountId => text().references(Accounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get threadId => text()();
  IntColumn get mutedAt => integer()();

  @override
  Set<Column> get primaryKey => {accountId, threadId};
}

/// SQL rendering an address JSON column as searchable text ("name email …").
String _addrText(String column) =>
    "(SELECT group_concat(coalesce(json_extract(value, '\$.n'), '') || ' ' || json_extract(value, '\$.e'), ' ') "
    'FROM json_each($column))';

/// SQL rendering attachment JSON as searchable text (file names and types).
String _attachmentText(String column) =>
    "(SELECT group_concat(coalesce(json_extract(value, '\$.filename'), '') || ' ' || "
    "json_extract(value, '\$.mimeType'), ' ') FROM json_each($column))";

/// Re-indexes the email row aliased `e` (which must exist in the FROM clause).
String _ftsInsertFrom(String where) =>
    '''
INSERT INTO email_fts(rowid, subject, from_addr, to_addr, cc_addr, bcc_addr, preview, body, attachments)
SELECT e.seq, e.subject, ${_addrText('e.from_json')}, ${_addrText('e.to_json')}, ${_addrText('e.cc_json')},
  ${_addrText('e.bcc_json')}, e.preview, coalesce(c.body_text, ''), coalesce(${_attachmentText('c.attachments_json')}, '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id WHERE $where;''';

/// The FTS5 index and the triggers keeping it and `email_keywords` consistent.
const ftsColumns = ['subject', 'from_addr', 'to_addr', 'cc_addr', 'bcc_addr', 'preview', 'body', 'attachments'];

final List<String> _ftsAndTriggers = [
  '''
CREATE VIRTUAL TABLE email_fts USING fts5(${ftsColumns.join(', ')}, content='', contentless_delete=1,
  tokenize='unicode61 remove_diacritics 2', prefix='2 3');''',
  '''
CREATE TRIGGER emails_after_insert AFTER INSERT ON emails BEGIN
  ${_ftsInsertFrom('e.seq = new.seq')}
  INSERT OR IGNORE INTO email_keywords(email_id, keyword) SELECT new.id, value FROM json_each(new.keywords);
END;''',
  '''
CREATE TRIGGER emails_after_update_text AFTER UPDATE OF subject, from_json, to_json, cc_json, bcc_json, preview
ON emails BEGIN
  DELETE FROM email_fts WHERE rowid = old.seq;
  ${_ftsInsertFrom('e.seq = new.seq')}
END;''',
  '''
CREATE TRIGGER emails_after_update_keywords AFTER UPDATE OF keywords ON emails BEGIN
  DELETE FROM email_keywords WHERE email_id = new.id;
  INSERT OR IGNORE INTO email_keywords(email_id, keyword) SELECT new.id, value FROM json_each(new.keywords);
END;''',
  '''
CREATE TRIGGER emails_after_delete AFTER DELETE ON emails BEGIN
  DELETE FROM email_fts WHERE rowid = old.seq;
END;''',
  '''
CREATE TRIGGER contents_after_insert AFTER INSERT ON contents BEGIN
  DELETE FROM email_fts WHERE rowid = (SELECT seq FROM emails WHERE id = new.email_id);
  ${_ftsInsertFrom('e.id = new.email_id')}
END;''',
  '''
CREATE TRIGGER contents_after_update AFTER UPDATE OF body_text, attachments_json ON contents BEGIN
  DELETE FROM email_fts WHERE rowid = (SELECT seq FROM emails WHERE id = new.email_id);
  ${_ftsInsertFrom('e.id = new.email_id')}
END;''',
  '''
CREATE TRIGGER contents_after_delete AFTER DELETE ON contents BEGIN
  DELETE FROM email_fts WHERE rowid = (SELECT seq FROM emails WHERE id = old.email_id);
  ${_ftsInsertFrom('e.id = old.email_id')}
END;''',
];

/// Partial indexes of the unread and the flagged messages, covering what
/// the virtual mailboxes' counts read: those scan only these messages, and
/// none of their wide rows (35,000 unread in a 40,000 message inbox took
/// ~45 ms to count over the table).
const _countIndexes = [
  'CREATE INDEX IF NOT EXISTS emails_unread ON emails (mailbox_id, account_id, message_id_header) WHERE is_seen = 0',
  'CREATE INDEX IF NOT EXISTS emails_flagged ON emails (mailbox_id, account_id, message_id_header) '
      'WHERE is_flagged = 1',
];

/// Message-ID domains of bulk-mail services as schema version 5 has them in
/// `emails.sub_key`: mail_model's `bulkMessageIdDomains` when it was made.
/// A test checks they still agree; changing the list needs a schema version
/// that recreates the column (with its index and triggers).
const subscriptionDomainsInSchema = [
  'mcsv.net',
  'mcdlv.net',
  'rsgsv.net',
  'mandrillapp.com',
  'sendgrid.net',
  'amazonses.com',
  'sparkpostmail.com',
  'mailgun.org',
  'mailgun.net',
  'createsend.com',
  'exacttarget.com',
];

/// SQL of the subscription key (`Subscription.key`, see `subscriptionKeyOf`)
/// of an emails row; null when it isn't bulk mail or has no sender. A List-Id
/// groups by list; else List-Unsubscribe or a bulk-mail service's Message-ID
/// groups by sender. LIKE is case-insensitive for ASCII, as domains are.
final String _subscriptionKeySql = () {
  final bulk = [
    "(list_id IS NOT NULL AND list_id <> '')",
    'list_unsubscribe IS NOT NULL',
    for (final d in subscriptionDomainsInSchema) ...["message_id_header LIKE '%@$d'", "message_id_header LIKE '%.$d'"],
  ].join(' OR ');
  return "CASE WHEN from_email <> '' AND ($bulk) THEN "
      "CASE WHEN list_id IS NOT NULL AND list_id <> '' THEN 'list:' || list_id ELSE 'from:' || from_email END END";
}();

/// Marks every subscription out of date: the next read rebuilds them all.
const subscriptionsRebuildSql = "INSERT OR IGNORE INTO subscription_dirty_keys (key) VALUES ('*')";

/// The Subscriptions screen's data, kept up to date incrementally (schema
/// version 5); `MailStore.watchSubscriptions` reads it.
///
/// - `emails.sub_key`: each message's subscription key (generated), indexed
///   where there is one.
/// - `subscription_messages`: one row per bulk message, its copies merged
///   (the first of their keys, newest arrival, read, in an Inbox), for the
///   counts.
/// - `subscription_details`: per key, what the copies of its messages say
///   (mailboxes, accounts, senders, the newest name and List-Unsubscribe).
/// - `subscription_dirty`: messages whose rows are out of date, marked by
///   triggers on every change (by any process). `subscription_dirty_keys`
///   holds `*` when everything is (the user's own addresses, which don't
///   count, changed), and the keys a refresh redoes while it runs.
///
/// The store brings the rows up to date before it reads them, with work in
/// proportion to what changed.
final List<String> _subscriptionSchema = [
  'ALTER TABLE emails ADD COLUMN sub_key TEXT GENERATED ALWAYS AS ($_subscriptionKeySql) VIRTUAL',
  'CREATE INDEX emails_subscription ON emails (sub_key) WHERE sub_key IS NOT NULL',
  'CREATE TABLE subscription_messages (account_id TEXT NOT NULL, mid TEXT NOT NULL, key TEXT NOT NULL, '
      'received_at INTEGER NOT NULL, seen INTEGER NOT NULL, inbox INTEGER NOT NULL, '
      'PRIMARY KEY (account_id, mid)) WITHOUT ROWID',
  'CREATE INDEX subscription_messages_key ON subscription_messages (key, received_at, seen, inbox)',
  'CREATE TABLE subscription_details (key TEXT NOT NULL PRIMARY KEY, boxes TEXT, accounts TEXT, '
      'senders INTEGER NOT NULL, has_headers INTEGER NOT NULL, sender TEXT, list_name TEXT, from_name TEXT, '
      'unsubscribe TEXT) WITHOUT ROWID',
  'CREATE TABLE subscription_dirty (account_id TEXT NOT NULL, mid TEXT NOT NULL, PRIMARY KEY (account_id, mid)) '
      'WITHOUT ROWID',
  'CREATE TABLE subscription_dirty_keys (key TEXT NOT NULL PRIMARY KEY) WITHOUT ROWID',
  for (final (name, event, row) in const [
    ('emails_subscription_insert', 'INSERT', 'new'),
    ('emails_subscription_delete', 'DELETE', 'old'),
  ])
    'CREATE TRIGGER $name AFTER $event ON emails WHEN $row.sub_key IS NOT NULL BEGIN '
        'INSERT OR IGNORE INTO subscription_dirty VALUES ($row.account_id, coalesce($row.message_id_header, $row.id)); '
        'END;',
  // Every column the key, the scope and the counts read.
  '''
CREATE TRIGGER emails_subscription_update AFTER UPDATE OF id, account_id, mailbox_id, message_id_header, from_json,
  from_email, received_at, is_seen, list_id, list_name, list_unsubscribe, list_unsubscribe_post ON emails
WHEN old.sub_key IS NOT NULL OR new.sub_key IS NOT NULL BEGIN
  INSERT OR IGNORE INTO subscription_dirty
    SELECT old.account_id, coalesce(old.message_id_header, old.id) WHERE old.sub_key IS NOT NULL;
  INSERT OR IGNORE INTO subscription_dirty
    SELECT new.account_id, coalesce(new.message_id_header, new.id) WHERE new.sub_key IS NOT NULL;
END;''',
  // Junk, Sent and Drafts don't count, and Inbox copies are counted.
  '''
CREATE TRIGGER mailboxes_subscription_role AFTER UPDATE OF role ON mailboxes WHEN old.role IS NOT new.role BEGIN
  INSERT OR IGNORE INTO subscription_dirty SELECT account_id, coalesce(message_id_header, id) FROM emails
    WHERE mailbox_id = new.id AND sub_key IS NOT NULL;
END;''',
  // The user's own addresses don't count.
  'CREATE TRIGGER accounts_subscription_insert AFTER INSERT ON accounts BEGIN $subscriptionsRebuildSql; END;',
  'CREATE TRIGGER accounts_subscription_delete AFTER DELETE ON accounts BEGIN $subscriptionsRebuildSql; END;',
  '''
CREATE TRIGGER accounts_subscription_update AFTER UPDATE OF email, json ON accounts
WHEN lower(old.email) IS NOT lower(new.email)
  OR (SELECT group_concat(lower(json_extract(value, '\$.email'))) FROM json_each(old.json, '\$.identities'))
  IS NOT (SELECT group_concat(lower(json_extract(value, '\$.email'))) FROM json_each(new.json, '\$.identities'))
BEGIN $subscriptionsRebuildSql; END;''',
  subscriptionsRebuildSql,
];

@DriftDatabase(
  tables: [
    Accounts,
    Mailboxes,
    SyncStates,
    Emails,
    EmailKeywords,
    Contents,
    InlineParts,
    OutboxItems,
    PendingOps,
    VipAddresses,
    AddressBook,
    ThreadRefs,
    IdAliases,
    Rules,
    RuleWatermarks,
    MutedThreads,
  ],
)
class StoreDatabase extends _$StoreDatabase {
  StoreDatabase(super.e);

  /// 1: the first release. 2: rules and their watermarks. 3: mailing-list
  /// headers on emails (with the `emails_list` index), muted threads, and
  /// `stale_headers` on sync states. 4: the partial indexes of unread and
  /// flagged messages ([_countIndexes]). 5: `held` on outbox items, the
  /// Subscriptions screen's data ([_subscriptionSchema]), and the progress of
  /// the header refetch on sync states.
  @override
  int get schemaVersion => 5;

  /// Creates or upgrades the file in one write transaction, from the
  /// version it has then. The app and a background isolate can open it at
  /// the same moment after an update, both reading the old version before
  /// either migrated: the second waits for the first's transaction (busy
  /// timeout), then finds the new version and does nothing, instead of
  /// failing on a table or column that already exists. The version is set
  /// in the same transaction.
  Future<void> _migrate(Migrator m) => transaction(() async {
    final current = (await customSelect('PRAGMA user_version').getSingle()).read<int>('user_version');
    if (current >= schemaVersion) return;
    if (current == 0) {
      await _create(m);
    } else {
      await _upgrade(m, current);
    }
    await customStatement('PRAGMA user_version = $schemaVersion');
  });

  Future<void> _create(Migrator m) async {
    await m.createAll();
    for (final sql in [..._ftsAndTriggers, ..._countIndexes, ..._subscriptionSchema]) {
      await customStatement(sql);
    }
  }

  Future<void> _upgrade(Migrator m, int from) async {
    if (from < 2) {
      await m.createTable(rules);
      await m.createTable(ruleWatermarks);
    }
    if (from < 3) {
      for (final column in [
        emails.listId,
        emails.listName,
        emails.listPost,
        emails.listUnsubscribe,
        emails.listUnsubscribePost,
      ]) {
        await m.addColumn(emails, column);
      }
      await m.createIndex(emailsList);
      await m.createTable(mutedThreads);
      // Summaries stored so far were fetched without the List-* headers.
      await m.addColumn(syncStates, syncStates.staleHeaders);
      await customStatement('UPDATE sync_states SET stale_headers = 1');
    }
    if (from < 4) {
      for (final sql in _countIndexes) {
        await customStatement(sql);
      }
    }
    if (from < 5) {
      await m.addColumn(outboxItems, outboxItems.held);
      await m.addColumn(syncStates, syncStates.headersDoneAt);
      await m.addColumn(syncStates, syncStates.headersDoneSeq);
      for (final sql in _subscriptionSchema) {
        await customStatement(sql);
      }
    }
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: _migrate,
    onUpgrade: (m, from, to) => _migrate(m),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
