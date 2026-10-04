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
  /// `stale_headers` on sync states.
  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      for (final sql in _ftsAndTriggers) {
        await customStatement(sql);
      }
    },
    onUpgrade: (m, from, to) async {
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
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
