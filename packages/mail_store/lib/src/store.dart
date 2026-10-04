import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:sqlite3/sqlite3.dart' show Database;

import 'codec.dart';
import 'records.dart';
import 'schema.dart';
import 'search_sql.dart';
import 'threading.dart';

/// Inline parts larger than this are not cached.
const maxInlinePartBytes = 512 * 1024;

/// Total inline bytes cached per message.
const maxInlineBytesPerMessage = 4 * 1024 * 1024;

/// Mailbox roles whose messages are excluded from cross-mailbox views
/// (virtual mailboxes): Gmail's All Mail/Starred/Important duplicate other
/// mailboxes, and Trash/Junk are not wanted there.
const _virtualExcludedRoles = "'trash', 'junk', 'all', 'flagged', 'important'";

/// SQL listing the user's own addresses (account and identity addresses).
const _meSql =
    "SELECT lower(a.email) AS addr FROM accounts a UNION SELECT lower(json_extract(i.value, '\$.email')) "
    "FROM accounts a, json_each(a.json, '\$.identities') i";

/// The local mail database: accounts, mailboxes, message summaries, cached
/// content, the outbox and the offline operation queue, with reactive
/// queries for the UI.
///
/// Open with [MailStore.open] (encrypted file) or [MailStore.memory] (tests).
final class MailStore {
  MailStore._(this._db);

  /// An unencrypted in-memory store, for tests. Runs on the calling isolate.
  factory MailStore.memory() => MailStore._(StoreDatabase(NativeDatabase.memory(setup: _configure)));

  final StoreDatabase _db;

  /// Opens (or creates) the encrypted database at [path].
  ///
  /// [encryptionKey] is a passphrase for SQLite3MultipleCiphers (ChaCha20);
  /// use a long random string kept in the platform keystore. Throws
  /// [MailStoreException] if the key is wrong, the file isn't a database, or
  /// the bundled SQLite can't encrypt. With [inBackground] (the default) the
  /// database runs on its own isolate.
  static Future<MailStore> open(String path, {required String encryptionKey, bool inBackground = true}) async {
    if (encryptionKey.isEmpty) throw const MailStoreException('The encryption key must not be empty');
    final key = encryptionKey;
    void setup(Database db) {
      if (db.select('PRAGMA cipher').isEmpty) {
        throw StateError('SQLite3MultipleCiphers is not bundled; refusing to open an unencrypted store');
      }
      db.execute("PRAGMA key = '${key.replaceAll("'", "''")}'");
      // Fails with SQLITE_NOTADB if the key is wrong.
      db.select('SELECT count(*) FROM sqlite_master');
      db.execute('PRAGMA journal_mode = WAL');
      _configure(db);
    }

    final file = File(path);
    final executor = inBackground
        ? NativeDatabase.createInBackground(file, setup: setup)
        : NativeDatabase(file, setup: setup);
    final store = MailStore._(StoreDatabase(executor));
    try {
      await store._db.customSelect('SELECT 1').get();
    } catch (e) {
      await store._db.close().catchError((_) {});
      throw MailStoreException('Could not open the mail database (wrong key or damaged file)', e);
    }
    return store;
  }

  static void _configure(Database db) {
    db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> close() => _db.close();

  /// Runs [action] in a transaction; nested calls join the outer one.
  Future<T> transaction<T>(Future<T> Function() action) => _db.transaction(action);

  // Helpers -----------------------------------------------------------------

  /// Runs a write and notifies watchers of [tables] only if rows changed.
  Future<int> _write(String sql, List<Object?> args, Set<TableInfo<Table, Object?>> tables, {UpdateKind? kind}) async {
    final n = await _db.customUpdate(sql, variables: [for (final a in args) _var(a)]);
    if (n > 0) _db.notifyUpdates({for (final t in tables) TableUpdate.onTable(t, kind: kind)});
    return n;
  }

  static Variable _var(Object? v) => switch (v) {
    null => const Variable(null),
    final String s => Variable.withString(s),
    final int i => Variable.withInt(i),
    final bool b => Variable.withBool(b),
    final double d => Variable.withReal(d),
    final Uint8List b => Variable.withBlob(b),
    _ => throw ArgumentError.value(v, 'v', 'Unsupported SQL argument'),
  };

  Selectable<QueryRow> _select(
    String sql,
    List<Object?> args,
    Set<ResultSetImplementation<Object?, Object?>> readsFrom,
  ) => _db.customSelect(sql, variables: [for (final a in args) _var(a)], readsFrom: readsFrom);

  static Iterable<List<T>> _chunks<T>(List<T> list, [int size = 400]) sync* {
    for (var i = 0; i < list.length; i += size) {
      yield list.sublist(i, i + size > list.length ? list.length : i + size);
    }
  }

  EmailRow _emailRow(QueryRow r) => _db.emails.map(r.data);

  // Accounts ----------------------------------------------------------------

  // Watched queries use customSelect: drift's typed `select().watch()` maps
  // rows through a pause/resume transformer that stalls under fake_async.

  Stream<List<MailAccount>> watchAccounts() => _select('SELECT * FROM accounts ORDER BY sort_order, email', [], {
    _db.accounts,
  }).watch().distinct(_rowsEqual).map((rows) => [for (final r in rows) _accountFromRow(_db.accounts.map(r.data))]);

  Future<List<MailAccount>> getAccounts() async {
    final rows = await (_db.select(_db.accounts)..orderBy([(a) => OrderingTerm.asc(a.sortOrder)])).get();
    return [for (final r in rows) _accountFromRow(r)];
  }

  Future<MailAccount?> getAccount(String id) async {
    final row = await (_db.select(_db.accounts)..where((a) => a.id.equals(id))).getSingleOrNull();
    return row == null ? null : _accountFromRow(row);
  }

  static MailAccount _accountFromRow(AccountRow r) =>
      MailAccount.fromJson((jsonDecode(r.json) as Map).cast<String, Object?>());

  /// Inserts or updates [account]. New accounts sort after existing ones.
  Future<void> saveAccount(MailAccount account) => _db.transaction(() async {
    final existing = await (_db.select(_db.accounts)..where((a) => a.id.equals(account.id))).getSingleOrNull();
    final json = jsonEncode(account.toJson());
    if (existing == null) {
      final max = await _select('SELECT coalesce(max(sort_order), -1) AS m FROM accounts', [], {
        _db.accounts,
      }).getSingle();
      await _db
          .into(_db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: account.id,
              email: account.email,
              displayName: account.displayName,
              json: json,
              sortOrder: Value(max.read<int>('m') + 1),
            ),
          );
    } else if (existing.json != json) {
      await (_db.update(_db.accounts)..where((a) => a.id.equals(account.id))).write(
        AccountsCompanion(email: Value(account.email), displayName: Value(account.displayName), json: Value(json)),
      );
    }
  });

  /// Deletes an account and everything stored for it.
  Future<void> deleteAccount(String accountId) => _db.transaction(() async {
    await (_db.delete(_db.accounts)..where((a) => a.id.equals(accountId))).go();
    // Cascades don't notify drift; tell the watchers.
    _db.notifyUpdates({
      for (final t in <TableInfo<Table, Object?>>[
        _db.mailboxes,
        _db.emails,
        _db.emailKeywords,
        _db.contents,
        _db.syncStates,
        _db.outboxItems,
        _db.pendingOps,
        _db.threadRefs,
      ])
        TableUpdate.onTable(t, kind: UpdateKind.delete),
    });
  });

  // Mailboxes ---------------------------------------------------------------

  Stream<List<Mailbox>> watchMailboxes({String? accountId}) => _select(
    'SELECT m.* FROM mailboxes m JOIN accounts a ON a.id = m.account_id '
    '${accountId == null ? '' : 'WHERE m.account_id = ? '}ORDER BY a.sort_order, m.sort_order',
    [?accountId],
    {_db.mailboxes, _db.accounts},
  ).watch().distinct(_rowsEqual).map((rows) => [for (final r in rows) mailboxFromRow(_db.mailboxes.map(r.data))]);

  Future<List<Mailbox>> getMailboxes({String? accountId}) async {
    final q = _db.select(_db.mailboxes);
    if (accountId != null) q.where((m) => m.accountId.equals(accountId));
    q.orderBy([(m) => OrderingTerm.asc(m.sortOrder)]);
    return [for (final r in await q.get()) mailboxFromRow(r)];
  }

  Future<Mailbox?> getMailbox(String mailboxId) async {
    final row = await (_db.select(_db.mailboxes)..where((m) => m.id.equals(mailboxId))).getSingleOrNull();
    return row == null ? null : mailboxFromRow(row);
  }

  /// The first mailbox of [accountId] with [role], if any.
  Future<Mailbox?> mailboxByRole(String accountId, MailboxRole role) async {
    final rows =
        await (_db.select(_db.mailboxes)
              ..where((m) => m.accountId.equals(accountId) & m.role.equals(role.name))
              ..orderBy([(m) => OrderingTerm.asc(m.sortOrder)])
              ..limit(1))
            .get();
    return rows.isEmpty ? null : mailboxFromRow(rows.first);
  }

  static const _roleOrder = [
    MailboxRole.inbox,
    MailboxRole.flagged,
    MailboxRole.important,
    MailboxRole.drafts,
    MailboxRole.outbox,
    MailboxRole.sent,
    MailboxRole.archive,
    MailboxRole.all,
    MailboxRole.junk,
    MailboxRole.trash,
  ];

  /// Replaces the mailbox list of [accountId] with what the server lists.
  /// Mailboxes no longer listed are removed with their messages; counts of
  /// existing ones are kept.
  Future<void> replaceMailboxes(String accountId, List<RemoteMailbox> remote) => _db.transaction(() async {
    int rank(RemoteMailbox m) {
      final i = _roleOrder.indexOf(m.role);
      return i < 0 ? _roleOrder.length : i;
    }

    final sorted = [...remote]
      ..sort((a, b) {
        final r = rank(a).compareTo(rank(b));
        return r != 0 ? r : a.path.toLowerCase().compareTo(b.path.toLowerCase());
      });
    final existing = {
      for (final r in await (_db.select(_db.mailboxes)..where((m) => m.accountId.equals(accountId))).get()) r.id: r,
    };
    final keep = <String>{};
    for (final (i, m) in sorted.indexed) {
      final id = MailIds.mailbox(accountId, m.path);
      keep.add(id);
      final parentId = m.parentPath == null ? null : MailIds.mailbox(accountId, m.parentPath!);
      final old = existing[id];
      if (old == null) {
        await _db
            .into(_db.mailboxes)
            .insert(
              MailboxesCompanion.insert(
                id: id,
                accountId: accountId,
                name: m.name,
                path: m.path,
                role: m.role.name,
                parentId: Value(parentId),
                isSelectable: Value(m.isSelectable),
                isSubscribed: Value(m.isSubscribed),
                sortOrder: Value(i),
              ),
            );
      } else if (old.name != m.name ||
          old.role != m.role.name ||
          old.parentId != parentId ||
          old.isSelectable != m.isSelectable ||
          old.isSubscribed != m.isSubscribed ||
          old.sortOrder != i) {
        await (_db.update(_db.mailboxes)..where((t) => t.id.equals(id))).write(
          MailboxesCompanion(
            name: Value(m.name),
            role: Value(m.role.name),
            parentId: Value(parentId),
            isSelectable: Value(m.isSelectable),
            isSubscribed: Value(m.isSubscribed),
            sortOrder: Value(i),
          ),
        );
      }
    }
    final gone = existing.keys.where((id) => !keep.contains(id)).toList();
    if (gone.isNotEmpty) {
      await (_db.delete(_db.mailboxes)..where((m) => m.id.isIn(gone))).go();
      _db.notifyUpdates({TableUpdate.onTable(_db.emails, kind: UpdateKind.delete)});
    }
  });

  /// Selectable, subscribed mailboxes of [accountId] that never synced, in
  /// display order; Trash and Junk are left for when they are opened.
  Future<List<String>> unsyncedMailboxIds(String accountId) async {
    final rows = await _select(
      'SELECT m.id FROM mailboxes m LEFT JOIN sync_states s ON s.mailbox_id = m.id '
      "WHERE m.account_id = ? AND m.is_selectable = 1 AND m.is_subscribed = 1 AND m.role NOT IN ('trash', 'junk') "
      'AND s.mailbox_id IS NULL ORDER BY m.sort_order',
      [accountId],
      {_db.mailboxes, _db.syncStates},
    ).get();
    return [for (final r in rows) r.read<String>('id')];
  }

  // Sync state --------------------------------------------------------------

  Future<MailboxSyncInfo?> getSyncInfo(String mailboxId) async {
    final row = await (_db.select(_db.syncStates)..where((s) => s.mailboxId.equals(mailboxId))).getSingleOrNull();
    if (row == null) return null;
    return MailboxSyncInfo(
      state: MailboxSyncState((jsonDecode(row.state) as Map).cast<String, Object?>()),
      hasOlder: row.hasOlder,
      syncedAt: fromMillis(row.syncedAt),
    );
  }

  /// Applies a transport sync result to [mailboxId] atomically: drops
  /// everything first when [MailboxSyncResult.resetAll], removes vanished
  /// messages, upserts added ones (threading them), applies keyword changes,
  /// stores counts and the new state, and feeds the address book.
  Future<void> applySync(String mailboxId, MailboxSyncResult result, {DateTime? now}) => _db.transaction(() async {
    final mailbox = await (_db.select(_db.mailboxes)..where((m) => m.id.equals(mailboxId))).getSingleOrNull();
    if (mailbox == null) return;
    if (result.resetAll) {
      await (_db.delete(_db.emails)..where((e) => e.mailboxId.equals(mailboxId))).go();
    }
    if (result.vanishedIds.isNotEmpty) await _deleteEmailRows(result.vanishedIds);
    if (result.added.isNotEmpty) {
      await _upsertEmails(result.added);
      await _recordFromMessages(result.added, MailboxRole.values.asNameMap()[mailbox.role] ?? MailboxRole.none, now);
    }
    if (result.keywordUpdates.isNotEmpty) await _setKeywordSets(result.keywordUpdates);

    var total = result.totalCount;
    var unread = result.unreadCount;
    if (total == null || unread == null) {
      final c = await _select(
        'SELECT count(*) AS t, coalesce(sum(1 - is_seen), 0) AS u FROM emails WHERE mailbox_id = ?',
        [mailboxId],
        {_db.emails},
      ).getSingle();
      total ??= c.read<int>('t');
      unread ??= c.read<int>('u');
    }
    await _write(
      'UPDATE mailboxes SET total_count = ?, unread_count = ? WHERE id = ? AND (total_count != ? OR unread_count != ?)',
      [total, unread, mailboxId, total, unread],
      {_db.mailboxes},
      kind: UpdateKind.update,
    );
    await _db
        .into(_db.syncStates)
        .insertOnConflictUpdate(
          SyncStatesCompanion.insert(
            mailboxId: mailboxId,
            state: jsonEncode(result.state.data),
            hasOlder: Value(result.hasOlder),
            syncedAt: (now ?? DateTime.now()).millisecondsSinceEpoch,
          ),
        );
  });

  // Emails ------------------------------------------------------------------

  /// Resolves an id that may have changed through a server move.
  Future<String> resolveId(String emailId) async {
    final row = await (_db.select(_db.idAliases)..where((a) => a.oldId.equals(emailId))).getSingleOrNull();
    return row?.newId ?? emailId;
  }

  Future<EmailSummary?> getEmail(String emailId) async {
    final id = await resolveId(emailId);
    final row = await (_db.select(_db.emails)..where((e) => e.id.equals(id))).getSingleOrNull();
    return row == null ? null : summaryFromRow(row);
  }

  /// Summaries of the stored ones among [ids], in no particular order.
  Future<List<EmailSummary>> getEmails(Iterable<String> ids) async {
    final out = <EmailSummary>[];
    for (final chunk in _chunks(ids.toSet().toList())) {
      final rows = await (_db.select(_db.emails)..where((e) => e.id.isIn(chunk))).get();
      out.addAll(rows.map(summaryFromRow));
    }
    return out;
  }

  /// Ids of messages in [mailboxId], newest first.
  Future<List<String>> emailIdsIn(String mailboxId) async {
    final rows =
        await (_db.selectOnly(_db.emails)
              ..addColumns([_db.emails.id])
              ..where(_db.emails.mailboxId.equals(mailboxId))
              ..orderBy([OrderingTerm.desc(_db.emails.receivedAt)]))
            .get();
    return [for (final r in rows) r.read(_db.emails.id)!];
  }

  /// Finds a message of [accountId] in [mailboxId] by its Message-ID header.
  Future<EmailSummary?> findByMessageId(String accountId, String messageId, {String? mailboxId}) async {
    final q = _db.select(_db.emails)
      ..where(
        (e) =>
            e.accountId.equals(accountId) &
            e.messageIdHeader.equals(normalizeMessageId(messageId)) &
            (mailboxId == null ? const Constant(true) : e.mailboxId.equals(mailboxId)),
      )
      ..limit(1);
    final row = await q.getSingleOrNull();
    return row == null ? null : summaryFromRow(row);
  }

  /// Stores summaries outside a sync (e.g. server search hits). Messages of
  /// unknown mailboxes are skipped. Returns the ids stored.
  Future<List<String>> insertEmails(List<EmailSummary> emails) => _db.transaction(() async {
    final known = {for (final m in await _db.select(_db.mailboxes).get()) m.id};
    final ok = [
      for (final e in emails)
        if (known.contains(e.mailboxId)) e,
    ];
    await _upsertEmails(ok);
    return [for (final e in ok) e.id];
  });

  Future<void> _upsertEmails(List<EmailSummary> emails) async {
    final existing = <String, EmailRow>{};
    for (final chunk in _chunks([for (final e in emails) e.id])) {
      for (final r in await (_db.select(_db.emails)..where((e) => e.id.isIn(chunk))).get()) {
        existing[r.id] = r;
      }
    }
    final byAccount = <String, ThreadAssigner>{};
    final fresh = [
      for (final e in emails)
        if (!existing.containsKey(e.id)) e,
    ];
    for (final accountId in {for (final e in fresh) e.accountId}) {
      await (byAccount[accountId] = ThreadAssigner(
        _db,
        accountId,
      )).preload(fresh.where((e) => e.accountId == accountId));
    }
    // Oldest first, so parents tend to be threaded before replies.
    final sorted = [...emails]..sort((a, b) => a.receivedAt.compareTo(b.receivedAt));
    for (final e in sorted) {
      final old = existing[e.id];
      final keywords = encodeKeywords(e.keywords);
      if (old != null) {
        final given = e.threadId;
        final companion = EmailsCompanion(
          mailboxId: Value(e.mailboxId),
          keywords: Value(keywords),
          isSeen: Value(e.keywords.contains(Keywords.seen)),
          isFlagged: Value(e.keywords.contains(Keywords.flagged)),
          threadId: given != null && given.isNotEmpty ? Value(given) : const Value.absent(),
          preview: e.preview.isNotEmpty && e.preview != old.preview ? Value(e.preview) : const Value.absent(),
        );
        final changed =
            old.mailboxId != e.mailboxId ||
            old.keywords != keywords ||
            (companion.threadId.present && old.threadId != given) ||
            companion.preview.present;
        if (changed) await (_db.update(_db.emails)..where((t) => t.id.equals(e.id))).write(companion);
        continue;
      }
      final assigner = byAccount[e.accountId] ??= ThreadAssigner(_db, e.accountId);
      final threadId = await assigner.assign(e);
      await _db
          .into(_db.emails)
          .insert(
            EmailsCompanion.insert(
              id: e.id,
              accountId: e.accountId,
              mailboxId: e.mailboxId,
              threadId: threadId,
              messageIdHeader: Value(e.messageIdHeader == null ? null : normalizeMessageId(e.messageIdHeader!)),
              inReplyTo: Value(e.inReplyTo == null ? null : normalizeMessageId(e.inReplyTo!)),
              referencesJson: Value(encodeStrings(e.references.map(normalizeMessageId))),
              fromAddrs: Value(encodeAddresses(e.from)),
              toAddrs: Value(encodeAddresses(e.to)),
              ccAddrs: Value(encodeAddresses(e.cc)),
              bccAddrs: Value(encodeAddresses(e.bcc)),
              replyToAddrs: Value(encodeAddresses(e.replyTo)),
              fromEmail: Value(e.from.isEmpty ? '' : e.from.first.email.toLowerCase()),
              subject: Value(e.subject),
              baseSubject: Value(baseSubject(e.subject)),
              preview: Value(e.preview),
              receivedAt: e.receivedAt.millisecondsSinceEpoch,
              sentAt: Value(millis(e.sentAt)),
              size: Value(e.size),
              keywords: Value(keywords),
              isSeen: Value(e.keywords.contains(Keywords.seen)),
              isFlagged: Value(e.keywords.contains(Keywords.flagged)),
              hasAttachment: Value(e.hasAttachment),
            ),
          );
    }
  }

  Future<void> _deleteEmailRows(List<String> ids) async {
    for (final chunk in _chunks(ids)) {
      await (_db.delete(_db.emails)..where((e) => e.id.isIn(chunk))).go();
    }
  }

  /// Sets complete keyword sets; only rows that change are written.
  Future<void> _setKeywordSets(Map<String, Set<String>> sets) async {
    for (final MapEntry(key: id, value: kw) in sets.entries) {
      final normalized = kw.map(Keywords.normalize).toSet();
      await _write(
        'UPDATE emails SET keywords = ?, is_seen = ?, is_flagged = ? WHERE id = ? AND keywords != ?',
        [
          encodeKeywords(normalized),
          normalized.contains(Keywords.seen),
          normalized.contains(Keywords.flagged),
          id,
          encodeKeywords(normalized),
        ],
        {_db.emails, _db.emailKeywords},
        kind: UpdateKind.update,
      );
    }
  }

  /// Adjusts stored mailbox counts by deltas (optimistic updates).
  Future<void> _adjustCounts(Map<String, (int total, int unread)> deltas) async {
    for (final MapEntry(key: id, value: (total, unread)) in deltas.entries) {
      if (total == 0 && unread == 0) continue;
      await _write(
        'UPDATE mailboxes SET total_count = max(0, total_count + ?), unread_count = max(0, unread_count + ?) '
        'WHERE id = ?',
        [total, unread, id],
        {_db.mailboxes},
        kind: UpdateKind.update,
      );
    }
  }

  static void _addDelta(Map<String, (int, int)> d, String mailboxId, int total, int unread) {
    final (t, u) = d[mailboxId] ?? (0, 0);
    d[mailboxId] = (t + total, u + unread);
  }

  /// Optimistically adds and removes keywords. Returns the previous keyword
  /// sets of the messages that changed (for reverting).
  Future<Map<String, Set<String>>> updateKeywords(
    List<String> emailIds, {
    Set<String> add = const {},
    Set<String> remove = const {},
  }) => _db.transaction(() async {
    final adds = add.map(Keywords.normalize).toSet();
    final removes = remove.map(Keywords.normalize).toSet();
    final previous = <String, Set<String>>{};
    final next = <String, Set<String>>{};
    final deltas = <String, (int, int)>{};
    for (final chunk in _chunks(emailIds.toSet().toList())) {
      for (final r in await (_db.select(_db.emails)..where((e) => e.id.isIn(chunk))).get()) {
        final before = decodeStrings(r.keywords).toSet();
        final after = {...before.difference(removes), ...adds};
        if (after.length == before.length && after.containsAll(before)) continue;
        previous[r.id] = before;
        next[r.id] = after;
        final wasSeen = before.contains(Keywords.seen);
        final isSeen = after.contains(Keywords.seen);
        if (wasSeen != isSeen) _addDelta(deltas, r.mailboxId, 0, isSeen ? -1 : 1);
      }
    }
    await _setKeywordSets(next);
    await _adjustCounts(deltas);
    return previous;
  });

  /// Restores keyword sets returned by [updateKeywords].
  Future<void> restoreKeywords(Map<String, Set<String>> previous) => _db.transaction(() async {
    final deltas = <String, (int, int)>{};
    for (final chunk in _chunks(previous.keys.toList())) {
      for (final r in await (_db.select(_db.emails)..where((e) => e.id.isIn(chunk))).get()) {
        final wasSeen = r.isSeen;
        final isSeen = previous[r.id]!.contains(Keywords.seen);
        if (wasSeen != isSeen) _addDelta(deltas, r.mailboxId, 0, isSeen ? -1 : 1);
      }
    }
    await _setKeywordSets(previous);
    await _adjustCounts(deltas);
  });

  /// Optimistically moves messages to [targetMailboxId] (ids stay until the
  /// server reports new ones). Returns id → previous mailbox id of the
  /// messages that moved.
  Future<Map<String, String>> moveLocally(List<String> emailIds, String targetMailboxId) => _db.transaction(() async {
    final previous = <String, String>{};
    final deltas = <String, (int, int)>{};
    for (final chunk in _chunks(emailIds.toSet().toList())) {
      for (final r in await (_db.select(_db.emails)..where((e) => e.id.isIn(chunk))).get()) {
        if (r.mailboxId == targetMailboxId) continue;
        previous[r.id] = r.mailboxId;
        final unread = r.isSeen ? 0 : 1;
        _addDelta(deltas, r.mailboxId, -1, -unread);
        _addDelta(deltas, targetMailboxId, 1, unread);
      }
    }
    for (final chunk in _chunks(previous.keys.toList())) {
      await (_db.update(
        _db.emails,
      )..where((e) => e.id.isIn(chunk))).write(EmailsCompanion(mailboxId: Value(targetMailboxId)));
    }
    await _adjustCounts(deltas);
    return previous;
  });

  /// Moves messages back to the mailboxes returned by [moveLocally].
  Future<void> restoreMailboxes(Map<String, String> previous) => _db.transaction(() async {
    final byTarget = <String, List<String>>{};
    for (final MapEntry(key: id, value: mailbox) in previous.entries) {
      (byTarget[mailbox] ??= []).add(id);
    }
    for (final MapEntry(key: mailbox, value: ids) in byTarget.entries) {
      await moveLocally(ids, mailbox);
    }
  });

  /// Deletes messages locally (optimistic delete, or after the server removed
  /// them). Returns the deleted summaries.
  Future<List<EmailSummary>> deleteEmails(List<String> emailIds) => _db.transaction(() async {
    final gone = await getEmails(emailIds);
    final deltas = <String, (int, int)>{};
    for (final e in gone) {
      _addDelta(deltas, e.mailboxId, -1, e.isSeen ? 0 : -1);
    }
    await _deleteEmailRows([for (final e in gone) e.id]);
    await _adjustCounts(deltas);
    return gone;
  });

  /// Re-inserts summaries removed by [deleteEmails] (reverting).
  Future<void> restoreEmails(List<EmailSummary> emails) => _db.transaction(() async {
    final deltas = <String, (int, int)>{};
    for (final e in emails) {
      _addDelta(deltas, e.mailboxId, 1, e.isSeen ? 0 : 1);
    }
    await insertEmails(emails);
    await _adjustCounts(deltas);
  });

  /// Renames messages after a server move reported their new ids. If the new
  /// id is already stored (synced meanwhile), the old row is dropped. Old ids
  /// keep resolving through [resolveId].
  Future<void> renameEmails(Map<String, String> oldToNew) => _db.transaction(() async {
    for (final MapEntry(key: oldId, value: newId) in oldToNew.entries) {
      if (oldId == newId) continue;
      final exists = await (_db.select(_db.emails)..where((e) => e.id.equals(newId))).getSingleOrNull();
      if (exists != null) {
        await (_db.delete(_db.emails)..where((e) => e.id.equals(oldId))).go();
      } else {
        final mailboxId = MailIds.mailboxOfImapEmail(newId);
        await (_db.update(_db.emails)..where((e) => e.id.equals(oldId))).write(
          EmailsCompanion(id: Value(newId), mailboxId: mailboxId == null ? const Value.absent() : Value(mailboxId)),
        );
      }
      await _db.customUpdate(
        'UPDATE id_aliases SET new_id = ? WHERE new_id = ?',
        variables: [Variable.withString(newId), Variable.withString(oldId)],
      );
      await _db.into(_db.idAliases).insertOnConflictUpdate(IdAliasesCompanion.insert(oldId: oldId, newId: newId));
    }
    _db.notifyUpdates({
      TableUpdate.onTable(_db.contents, kind: UpdateKind.update),
      TableUpdate.onTable(_db.emailKeywords, kind: UpdateKind.update),
    });
  });

  // Lists -------------------------------------------------------------------

  /// SQL restricting `emails e` (joined with `mailboxes m`) to [ref].
  String _scopeSql(MailboxRef ref, List<Object?> args) {
    switch (ref) {
      case RealMailboxRef(:final mailboxId):
        args.add(mailboxId);
        return 'e.mailbox_id = ?';
      case VirtualMailboxRef(:final kind):
        return switch (kind) {
          VirtualMailbox.allInboxes => "m.role = 'inbox'",
          VirtualMailbox.unread => "e.is_seen = 0 AND m.role NOT IN ($_virtualExcludedRoles, 'sent', 'drafts')",
          VirtualMailbox.flagged => 'e.is_flagged = 1 AND m.role NOT IN ($_virtualExcludedRoles)',
          VirtualMailbox.vip =>
            'e.from_email IN (SELECT email FROM vip_addresses) '
                "AND m.role NOT IN ($_virtualExcludedRoles, 'sent', 'drafts')",
          VirtualMailbox.allDrafts => "m.role = 'drafts'",
          VirtualMailbox.allSent => "m.role = 'sent'",
        };
    }
  }

  static String _filterSql(QuickFilter f) => switch (f) {
    QuickFilter.unread => 'e.is_seen = 0',
    QuickFilter.flagged => 'e.is_flagged = 1',
    QuickFilter.toMe => "EXISTS (SELECT 1 FROM json_each(e.to_json) j WHERE lower(json_extract(j.value, '\$.e')) IN (SELECT addr FROM me))",
    QuickFilter.ccMe => "EXISTS (SELECT 1 FROM json_each(e.cc_json) j WHERE lower(json_extract(j.value, '\$.e')) IN (SELECT addr FROM me))",
    QuickFilter.hasAttachment => 'e.has_attachment = 1',
    QuickFilter.unreplied =>
      "NOT EXISTS (SELECT 1 FROM email_keywords k WHERE k.email_id = e.id AND k.keyword = '\$answered')",
    QuickFilter.fromVip => 'e.from_email IN (SELECT email FROM vip_addresses)',
  };

  /// Ranks copies of one message across mailboxes (lower is preferred).
  static const _copyRank =
      "CASE m.role WHEN 'inbox' THEN 0 WHEN 'all' THEN 3 WHEN 'flagged' THEN 2 WHEN 'important' THEN 2 ELSE 1 END";

  /// The message list of [ref], newest first; see `MailRepository.watchList`.
  Stream<List<ThreadSummary>> watchList(
    MailboxRef ref, {
    Set<QuickFilter> filters = const {},
    bool threaded = true,
    int limit = 200,
  }) {
    final args = <Object?>[];
    final where = [_scopeSql(ref, args), for (final f in filters) _filterSql(f)].join(' AND ');
    // Virtual mailboxes may hold several copies of one message (labels).
    final dedup = ref is VirtualMailboxRef;
    final scoped =
        '''
WITH me(addr) AS ($_meSql),
candidates AS (
  SELECT e.*, ${dedup ? 'ROW_NUMBER() OVER (PARTITION BY e.account_id, coalesce(e.message_id_header, e.id) ORDER BY $_copyRank, e.seq)' : '1'} AS copy_rank
  FROM emails e JOIN mailboxes m ON m.id = e.mailbox_id WHERE $where
),
scoped AS (SELECT * FROM candidates WHERE copy_rank = 1)''';
    final String sql;
    if (threaded) {
      sql =
          '''
$scoped,
ranked AS (
  SELECT s.*,
    ROW_NUMBER() OVER w AS rn,
    count(*) OVER t AS thread_count,
    sum(1 - s.is_seen) OVER t AS thread_unread,
    json_group_array(json(s.from_json)) OVER (t ORDER BY s.received_at DESC, s.seq DESC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS thread_from
  FROM scoped s
  WINDOW t AS (PARTITION BY s.account_id, s.thread_id),
    w AS (PARTITION BY s.account_id, s.thread_id ORDER BY s.received_at DESC, s.seq DESC)
)
SELECT * FROM ranked WHERE rn = 1 ORDER BY received_at DESC, seq DESC LIMIT ?''';
    } else {
      sql = '$scoped SELECT * FROM scoped ORDER BY received_at DESC, seq DESC LIMIT ?';
    }
    args.add(limit);
    return _select(sql, args, {
      _db.emails,
      _db.mailboxes,
      _db.accounts,
      _db.vipAddresses,
      _db.emailKeywords,
    }).watch().distinct(_rowsEqual).map((rows) => [for (final r in rows) _threadFromRow(r, threaded)]);
  }

  ThreadSummary _threadFromRow(QueryRow r, bool threaded) {
    final e = summaryFromRow(_emailRow(r));
    if (!threaded) {
      return ThreadSummary(
        threadId: e.threadId ?? e.id,
        latest: e,
        messageCount: 1,
        unreadCount: e.isSeen ? 0 : 1,
        participants: e.from,
      );
    }
    final participants = <EmailAddress>[];
    final seen = <String>{};
    for (final list in jsonDecode(r.read<String>('thread_from')) as List<Object?>) {
      for (final a in list! as List<Object?>) {
        final m = (a! as Map).cast<String, Object?>();
        final email = m['e']! as String;
        if (seen.add(email.toLowerCase())) participants.add(EmailAddress(email, m['n'] as String?));
      }
    }
    return ThreadSummary(
      threadId: e.threadId ?? e.id,
      latest: e,
      messageCount: r.read<int>('thread_count'),
      unreadCount: r.read<int>('thread_unread'),
      participants: participants,
    );
  }

  /// All messages of the conversation [emailId] belongs to, oldest first.
  /// Copies of one message in several mailboxes appear once; Trash and Junk
  /// copies only when [emailId] itself is there.
  Stream<List<EmailSummary>> watchConversation(String emailId) {
    const sql =
        '''
WITH target AS (
  SELECT e.id, e.account_id, e.thread_id, m.role FROM emails e JOIN mailboxes m ON m.id = e.mailbox_id
  WHERE e.id = coalesce((SELECT new_id FROM id_aliases WHERE old_id = ?1), ?1)
),
members AS (
  SELECT e.*, ROW_NUMBER() OVER (PARTITION BY coalesce(e.message_id_header, e.id)
    ORDER BY (e.id = t.id) DESC, $_copyRank, e.seq) AS copy_rank
  FROM emails e JOIN mailboxes m ON m.id = e.mailbox_id JOIN target t
    ON e.account_id = t.account_id AND e.thread_id = t.thread_id
  WHERE m.role NOT IN ('trash', 'junk') OR t.role IN ('trash', 'junk') OR e.id = t.id
)
SELECT * FROM members WHERE copy_rank = 1 ORDER BY received_at ASC, seq ASC''';
    return _select(
      sql,
      [emailId],
      {_db.emails, _db.mailboxes, _db.idAliases},
    ).watch().distinct(_rowsEqual).map((rows) => [for (final r in rows) summaryFromRow(_emailRow(r))]);
  }

  /// Badge counts of the virtual mailboxes: unread messages for All Inboxes,
  /// Unread and VIP; the number of flagged messages for Flagged and of drafts
  /// for Drafts (as Apple Mail shows them); zero for Sent.
  Stream<Map<VirtualMailbox, int>> watchVirtualCounts() {
    const distinctKey = "count(DISTINCT e.account_id || '|' || coalesce(e.message_id_header, e.id))";
    const from = 'FROM emails e JOIN mailboxes m ON m.id = e.mailbox_id';
    const sql =
        '''
SELECT
  (SELECT coalesce(sum(unread_count), 0) FROM mailboxes WHERE role = 'inbox') AS all_inboxes,
  (SELECT $distinctKey $from WHERE e.is_seen = 0 AND m.role NOT IN ($_virtualExcludedRoles, 'sent', 'drafts')) AS unread,
  (SELECT $distinctKey $from WHERE e.is_flagged = 1 AND m.role NOT IN ($_virtualExcludedRoles)) AS flagged,
  (SELECT $distinctKey $from WHERE e.is_seen = 0 AND e.from_email IN (SELECT email FROM vip_addresses)
    AND m.role NOT IN ($_virtualExcludedRoles, 'sent', 'drafts')) AS vip,
  (SELECT coalesce(sum(total_count), 0) FROM mailboxes WHERE role = 'drafts') AS drafts''';
    return _select(sql, [], {_db.emails, _db.mailboxes, _db.vipAddresses}).watch().distinct(_rowsEqual).map((rows) {
      final r = rows.single;
      return {
        VirtualMailbox.allInboxes: r.read<int>('all_inboxes'),
        VirtualMailbox.unread: r.read<int>('unread'),
        VirtualMailbox.flagged: r.read<int>('flagged'),
        VirtualMailbox.vip: r.read<int>('vip'),
        VirtualMailbox.allDrafts: r.read<int>('drafts'),
        VirtualMailbox.allSent: 0,
      };
    });
  }

  // Search ------------------------------------------------------------------

  /// Searches stored messages, newest first, one row per message (copies in
  /// several mailboxes are merged). Terms SQL can't evaluate are widened and
  /// the candidates post-filtered with `matchesEmail`, using cached content
  /// when there is some.
  Future<List<EmailSummary>> search(
    SearchExpr expr, {
    SearchScope scope = const AllMailboxesScope(),
    int limit = 200,
  }) async {
    final cond = translateSearch(expr);
    final args = <Object?>[];
    final scopeSql = switch (scope) {
      AllMailboxesScope() => '1',
      MailboxScope(:final ref) => _scopeSql(ref, args),
    };
    args.addAll(cond.args);
    final labels = cond.needsPostFilter
        ? {for (final a in await getAccounts()) a.id: '${a.displayName} ${a.email}'}
        : const <String, String>{};
    final sql =
        'SELECT e.*, $_copyRank AS copy_pref FROM emails e JOIN mailboxes m ON m.id = e.mailbox_id '
        'WHERE $scopeSql AND ${cond.sql} ORDER BY e.received_at DESC, e.seq DESC LIMIT ? OFFSET ?';
    final byKey = <String, (EmailSummary, int)>{};
    final order = <String>[];
    final pageSize = cond.needsPostFilter ? limit * 2 : limit + 50;
    var offset = 0;
    const maxScanned = 5000;
    while (order.length < limit && offset < maxScanned) {
      final rows = await _select(sql, [...args, pageSize, offset], {_db.emails}).get();
      offset += rows.length;
      for (final r in rows) {
        final e = summaryFromRow(_emailRow(r));
        if (cond.needsPostFilter && !await _postFilter(expr, e, labels[e.accountId])) continue;
        final key = '${e.accountId}|${e.messageIdHeader ?? e.id}';
        final pref = r.read<int>('copy_pref');
        final prev = byKey[key];
        if (prev == null) {
          order.add(key);
          byKey[key] = (e, pref);
        } else if (pref < prev.$2) {
          byKey[key] = (e, pref);
        }
      }
      if (rows.length < pageSize) break;
    }
    return [for (final k in order.take(limit)) byKey[k]!.$1];
  }

  Future<bool> _postFilter(SearchExpr expr, EmailSummary e, String? label) async {
    final content = await getContent(e.id);
    final headers = <String, String>{
      if (content != null)
        for (final (n, v) in content.headers) n.toLowerCase(): v,
    };
    return matchesEmail(expr, e, content: content, accountLabel: label, headers: headers);
  }

  // Content -----------------------------------------------------------------

  Future<EmailContent?> getContent(String emailId) async {
    final id = await resolveId(emailId);
    final row = await (_db.select(_db.contents)..where((c) => c.emailId.equals(id))).getSingleOrNull();
    if (row == null) return null;
    final inline = await (_db.select(_db.inlineParts)..where((p) => p.emailId.equals(id))).get();
    return EmailContent(
      emailId: emailId,
      html: row.html,
      text: row.plainText,
      isFlowed: row.isFlowed,
      headers: decodeHeaders(row.headersJson),
      attachments: decodeAttachments(row.attachmentsJson),
      inlineData: {for (final p in inline) p.contentId: p.data},
    );
  }

  /// Caches [content] (and its inline parts within the size caps) and
  /// indexes its text. Ignored if the message isn't stored.
  Future<void> putContent(EmailContent content, {DateTime? now}) => _db.transaction(() async {
    final id = await resolveId(content.emailId);
    final exists = await (_db.select(_db.emails)..where((e) => e.id.equals(id))).getSingleOrNull();
    if (exists == null) return;
    await _db
        .into(_db.contents)
        .insertOnConflictUpdate(
          ContentsCompanion.insert(
            emailId: id,
            html: Value(content.html),
            plainText: Value(content.text),
            isFlowed: Value(content.isFlowed),
            headersJson: Value(encodeHeaders(content.headers)),
            attachmentsJson: Value(encodeAttachments(content.attachments)),
            bodyText: Value(bodyTextFor(content)),
            fetchedAt: (now ?? DateTime.now()).millisecondsSinceEpoch,
          ),
        );
    await (_db.delete(_db.inlineParts)..where((p) => p.emailId.equals(id))).go();
    var budget = maxInlineBytesPerMessage;
    for (final MapEntry(key: cid, value: data) in content.inlineData.entries) {
      if (data.length > maxInlinePartBytes || data.length > budget) continue;
      budget -= data.length;
      await _db.into(_db.inlineParts).insert(InlinePartsCompanion.insert(emailId: id, contentId: cid, data: data));
    }
  });

  /// Drops cached content older than [before] (cache eviction).
  Future<int> evictContent(DateTime before) =>
      (_db.delete(_db.contents)..where((c) => c.fetchedAt.isSmallerThanValue(before.millisecondsSinceEpoch))).go();

  // Outbox ------------------------------------------------------------------

  Future<void> putOutbox(OutboxEntry entry) => _db
      .into(_db.outboxItems)
      .insertOnConflictUpdate(
        OutboxItemsCompanion.insert(
          id: entry.id,
          accountId: entry.accountId,
          message: encodeOutgoing(entry.message),
          sendAfter: entry.sendAfter.millisecondsSinceEpoch,
          status: entry.status.name,
          attempts: Value(entry.attempts),
          lastError: Value(entry.lastError),
          createdAt: entry.createdAt.millisecondsSinceEpoch,
        ),
      );

  static OutboxEntry _outboxFromRow(OutboxRow r) => OutboxEntry(
    id: r.id,
    accountId: r.accountId,
    message: decodeOutgoing(r.message),
    sendAfter: fromMillis(r.sendAfter),
    createdAt: fromMillis(r.createdAt),
    status: OutboxStatus.values.byName(r.status),
    attempts: r.attempts,
    lastError: r.lastError,
  );

  Future<OutboxEntry?> getOutbox(String id) async {
    final row = await (_db.select(_db.outboxItems)..where((o) => o.id.equals(id))).getSingleOrNull();
    return row == null ? null : _outboxFromRow(row);
  }

  Future<List<OutboxEntry>> outboxEntries({String? accountId}) async {
    final q = _db.select(_db.outboxItems)..orderBy([(o) => OrderingTerm.asc(o.sendAfter)]);
    if (accountId != null) q.where((o) => o.accountId.equals(accountId));
    return [for (final r in await q.get()) _outboxFromRow(r)];
  }

  Stream<List<OutboxEntry>> watchOutbox() => _select('SELECT * FROM outbox_items ORDER BY send_after', [], {
    _db.outboxItems,
  }).watch().map((rows) => [for (final r in rows) _outboxFromRow(_db.outboxItems.map(r.data))]);

  /// Atomically marks a queued (or failed) entry as sending. Returns it, or
  /// null if it is gone or already being sent.
  Future<OutboxEntry?> claimOutbox(String id) => _db.transaction(() async {
    final n = await _write(
      'UPDATE outbox_items SET status = ? WHERE id = ? AND status != ?',
      [OutboxStatus.sending.name, id, OutboxStatus.sending.name],
      {_db.outboxItems},
      kind: UpdateKind.update,
    );
    return n == 0 ? null : getOutbox(id);
  });

  /// Removes an entry unless it is being sent. Returns it if removed.
  Future<OutboxEntry?> takeOutbox(String id) => _db.transaction(() async {
    final entry = await getOutbox(id);
    if (entry == null || entry.status == OutboxStatus.sending) return null;
    await (_db.delete(_db.outboxItems)..where((o) => o.id.equals(id))).go();
    return entry;
  });

  Future<void> deleteOutbox(String id) => (_db.delete(_db.outboxItems)..where((o) => o.id.equals(id))).go();

  Future<void> updateOutbox(
    String id, {
    required OutboxStatus status,
    int? attempts,
    String? lastError,
    DateTime? sendAfter,
  }) => (_db.update(_db.outboxItems)..where((o) => o.id.equals(id))).write(
    OutboxItemsCompanion(
      status: Value(status.name),
      attempts: attempts == null ? const Value.absent() : Value(attempts),
      lastError: Value(lastError),
      sendAfter: sendAfter == null ? const Value.absent() : Value(sendAfter.millisecondsSinceEpoch),
    ),
  );

  // Pending operations -------------------------------------------------------

  Future<int> enqueueOp(String accountId, String type, Map<String, Object?> payload, {DateTime? now}) {
    final t = (now ?? DateTime.now()).millisecondsSinceEpoch;
    return _db
        .into(_db.pendingOps)
        .insert(
          PendingOpsCompanion.insert(
            accountId: accountId,
            type: type,
            payload: jsonEncode(payload),
            nextAttemptAt: t,
            createdAt: t,
          ),
        );
  }

  static PendingOp _opFromRow(PendingOpRow r) => PendingOp(
    id: r.id,
    accountId: r.accountId,
    type: r.type,
    payload: (jsonDecode(r.payload) as Map).cast<String, Object?>(),
    attempts: r.attempts,
    nextAttemptAt: fromMillis(r.nextAttemptAt),
    createdAt: fromMillis(r.createdAt),
    lastError: r.lastError,
  );

  /// Queued operations, oldest first.
  Future<List<PendingOp>> pendingOps({String? accountId}) async {
    final q = _db.select(_db.pendingOps)..orderBy([(o) => OrderingTerm.asc(o.id)]);
    if (accountId != null) q.where((o) => o.accountId.equals(accountId));
    return [for (final r in await q.get()) _opFromRow(r)];
  }

  Future<void> deleteOp(int id) => (_db.delete(_db.pendingOps)..where((o) => o.id.equals(id))).go();

  Future<void> updateOp(
    int id, {
    int? attempts,
    DateTime? nextAttemptAt,
    String? lastError,
    Map<String, Object?>? payload,
  }) => (_db.update(_db.pendingOps)..where((o) => o.id.equals(id))).write(
    PendingOpsCompanion(
      attempts: attempts == null ? const Value.absent() : Value(attempts),
      nextAttemptAt: nextAttemptAt == null ? const Value.absent() : Value(nextAttemptAt.millisecondsSinceEpoch),
      lastError: Value(lastError),
      payload: payload == null ? const Value.absent() : Value(jsonEncode(payload)),
    ),
  );

  // VIPs --------------------------------------------------------------------

  Stream<Set<String>> watchVipAddresses() => _select('SELECT email FROM vip_addresses', [], {
    _db.vipAddresses,
  }).watch().distinct(_rowsEqual).map((rows) => {for (final r in rows) r.read<String>('email')});

  Future<void> setVip(String email, {required bool vip}) async {
    final e = email.trim().toLowerCase();
    if (vip) {
      await _db.into(_db.vipAddresses).insert(VipAddressesCompanion.insert(email: e), mode: InsertMode.insertOrIgnore);
    } else {
      await (_db.delete(_db.vipAddresses)..where((v) => v.email.equals(e))).go();
    }
  }

  // Address book ------------------------------------------------------------

  /// Records addresses for autocomplete; [sent] marks recipients the user
  /// wrote to (ranked higher).
  Future<void> recordAddresses(Iterable<EmailAddress> addresses, {bool sent = false, DateTime? now}) async {
    final at = (now ?? DateTime.now()).millisecondsSinceEpoch;
    final unique = <String, EmailAddress>{};
    for (final a in addresses) {
      final e = a.email.trim().toLowerCase();
      if (e.isEmpty || !e.contains('@')) continue;
      unique[e] = a;
    }
    if (unique.isEmpty) return;
    await _db.batch((b) {
      for (final MapEntry(key: email, value: a) in unique.entries) {
        final name = a.name?.trim();
        b.customStatement(
          'INSERT INTO address_book(email, name, seen_count, sent_count, last_used_at) VALUES (?, ?, ?, ?, ?) '
          'ON CONFLICT(email) DO UPDATE SET name = coalesce(excluded.name, address_book.name), '
          'seen_count = address_book.seen_count + excluded.seen_count, '
          'sent_count = address_book.sent_count + excluded.sent_count, '
          'last_used_at = max(address_book.last_used_at, excluded.last_used_at)',
          [email, name == null || name.isEmpty ? null : name, sent ? 0 : 1, sent ? 1 : 0, at],
        );
      }
    });
  }

  Future<void> _recordFromMessages(List<EmailSummary> emails, MailboxRole role, DateTime? now) async {
    if (role == MailboxRole.junk || role == MailboxRole.trash) return;
    if (role == MailboxRole.sent) {
      await recordAddresses(
        [
          for (final e in emails) ...[...e.to, ...e.cc, ...e.bcc],
        ],
        sent: true,
        now: now,
      );
    } else if (role != MailboxRole.drafts) {
      await recordAddresses([for (final e in emails) ...e.from], now: now);
    }
  }

  /// Addresses whose email or name (or a word of the name) starts with
  /// [prefix], most used first.
  Future<List<EmailAddress>> suggestAddresses(String prefix, {int limit = 8}) async {
    final p = prefix.trim().toLowerCase();
    if (p.isEmpty) return const [];
    final like = '${escapeLike(p)}%';
    final rows = await _select(
      r"SELECT email, name FROM address_book WHERE email LIKE ? ESCAPE '\' OR lower(name) LIKE ? ESCAPE '\' "
      r"OR lower(name) LIKE ? ESCAPE '\' "
      'ORDER BY (sent_count * 4 + seen_count) DESC, last_used_at DESC LIMIT ?',
      [like, like, '% $like', limit],
      {_db.addressBook},
    ).get();
    return [for (final r in rows) EmailAddress(r.read<String>('email'), r.readNullable<String>('name'))];
  }
}

bool _rowsEqual(List<QueryRow> a, List<QueryRow> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    final x = a[i].data;
    final y = b[i].data;
    if (x.length != y.length) return false;
    for (final MapEntry(:key, :value) in x.entries) {
      if (y[key] != value) return false;
    }
  }
  return true;
}
