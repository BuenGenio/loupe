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

/// How long a connection waits for another one's write lock before failing
/// with SQLITE_BUSY, in milliseconds.
const _busyTimeoutMs = 10000;

/// Inline parts larger than this are not cached.
const maxInlinePartBytes = 512 * 1024;

/// Total inline bytes cached per message.
const maxInlineBytesPerMessage = 4 * 1024 * 1024;

/// Mailbox roles whose messages are excluded from cross-mailbox views
/// (virtual mailboxes): Gmail's All Mail/Starred/Important duplicate other
/// mailboxes, and Trash/Junk are not wanted there.
const _virtualExcludedRoles = "'trash', 'junk', 'all', 'flagged', 'important'";

/// SQL true for `mailboxes m` that are their account's snooze folder (see
/// `Snooze.isFolderPath`). Snoozed messages stay out of Unread, Flagged and
/// VIP until they wake.
const _snoozeFolderSql = "(m.is_selectable = 1 AND lower(m.path) IN ('snoozed', 'inbox.snoozed', 'inbox/snoozed'))";

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

  /// A store on [executor], for benchmarks and tests that observe the
  /// statements it runs (drift's `interceptWith`). The executor must enable
  /// foreign keys itself.
  factory MailStore.forExecutor(QueryExecutor executor) => MailStore._(StoreDatabase(executor));

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
      // Background work (sync, notification actions) opens its own
      // connection; a writer waits for another one instead of failing. First,
      // so that the statements below wait too (switching to WAL takes a lock).
      db.execute('PRAGMA busy_timeout = $_busyTimeoutMs');
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
  ///
  /// Transactions take the write lock when they begin (`BEGIN IMMEDIATE`,
  /// as drift's sqlite3 executor starts them; the store's tests check it).
  /// The app and background isolates open the file on connections of their
  /// own, and a transaction that reads and then writes would otherwise fail
  /// with SQLITE_BUSY_SNAPSHOT when another connection wrote in between:
  /// the busy timeout can't help a snapshot that is already stale. With the
  /// lock taken up front, the other connection waits instead, so put a read
  /// and the write that depends on it in one transaction. Never wait for the
  /// network inside one: other processes would wait as long.
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

  /// [read]'s result at once and again after every change of [tables], for
  /// what one query can't say. One read at a time; a change during a read
  /// reads again after it. Nothing is emitted once the store is closed.
  Stream<T> _recomputed<T>(
    String name,
    Set<ResultSetImplementation<dynamic, dynamic>> tables,
    Future<T> Function() read,
  ) {
    // A statement of its own: drift shares streams of the same SQL, whatever
    // tables they watch.
    final changes = _select('SELECT 1 AS $name', const [], tables).watch();
    StreamSubscription<List<QueryRow>>? subscription;
    late final StreamController<T> controller;
    var reading = false;
    var again = false;
    Future<void> run() async {
      if (reading) {
        again = true;
        return;
      }
      reading = true;
      try {
        do {
          again = false;
          final value = await read();
          if (controller.isClosed || subscription == null) return;
          controller.add(value);
        } while (again);
      } catch (e, s) {
        if (!controller.isClosed && subscription != null) controller.addError(e, s);
      } finally {
        reading = false;
      }
    }

    controller = StreamController<T>.broadcast(
      onListen: () => subscription = changes.listen(
        (_) => unawaited(run()),
        onError: controller.addError,
        onDone: () => unawaited(controller.close()),
      ),
      onCancel: () async {
        final s = subscription;
        subscription = null;
        await s?.cancel();
      },
    );
    return controller.stream;
  }

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

  /// Sets the subscription flag of [mailboxId] (optimistic: the server
  /// catches up). Returns the previous value, or null if there is no such
  /// mailbox.
  Future<bool?> setMailboxSubscribed(String mailboxId, {required bool subscribed}) => _db.transaction(() async {
    final row = await (_db.select(_db.mailboxes)..where((m) => m.id.equals(mailboxId))).getSingleOrNull();
    if (row == null) return null;
    if (row.isSubscribed != subscribed) {
      await (_db.update(
        _db.mailboxes,
      )..where((m) => m.id.equals(mailboxId))).write(MailboxesCompanion(isSubscribed: Value(subscribed)));
    }
    return row.isSubscribed;
  });

  /// Selectable mailboxes of [accountId] that never synced, in display
  /// order: subscribed ones and those holding a role. Trash and Junk are
  /// left for when they are opened.
  Future<List<String>> unsyncedMailboxIds(String accountId) async {
    final rows = await _select(
      'SELECT m.id FROM mailboxes m LEFT JOIN sync_states s ON s.mailbox_id = m.id '
      "WHERE m.account_id = ? AND m.is_selectable = 1 AND (m.is_subscribed = 1 OR m.role != 'none') "
      "AND m.role NOT IN ('trash', 'junk') AND s.mailbox_id IS NULL ORDER BY m.sort_order",
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
      staleHeaders: row.staleHeaders,
    );
  }

  /// Asks the sync engine to fetch the stored summaries of [mailboxId]
  /// again for their header fields (see [MailboxSyncInfo.staleHeaders]),
  /// from the newest.
  Future<void> markHeadersStale(String mailboxId) => _write(
    'UPDATE sync_states SET stale_headers = 1, headers_done_at = NULL, headers_done_seq = NULL '
    'WHERE mailbox_id = ? AND stale_headers = 0',
    [mailboxId],
    {_db.syncStates},
    kind: UpdateKind.update,
  );

  /// The summaries of [mailboxId] have their header fields again (see
  /// [MailboxSyncInfo.staleHeaders]).
  Future<void> markHeadersFresh(String mailboxId) => _write(
    'UPDATE sync_states SET stale_headers = 0, headers_done_at = NULL, headers_done_seq = NULL '
    'WHERE mailbox_id = ? AND stale_headers = 1',
    [mailboxId],
    {_db.syncStates},
    kind: UpdateKind.update,
  );

  /// The next [limit] messages of [mailboxId] whose header fields are to be
  /// fetched again (see [MailboxSyncInfo.staleHeaders]), newest first, after
  /// the progress [fillHeaders] saved; null when there are no more (or the
  /// mailbox isn't marked). Messages stored meanwhile are newer, and came
  /// with every field.
  Future<StaleHeadersBatch?> nextStaleHeaders(String mailboxId, {int limit = 200}) async {
    final state = await _select(
      'SELECT headers_done_at AS at, headers_done_seq AS seq FROM sync_states WHERE mailbox_id = ? AND stale_headers = 1',
      [mailboxId],
      {_db.syncStates},
    ).getSingleOrNull();
    if (state == null) return null;
    final at = state.read<int?>('at');
    final seq = state.read<int?>('seq');
    // A range of the mailbox's index: each batch starts where the last ended.
    final rows = await _select(
      'SELECT id, received_at, seq FROM emails WHERE mailbox_id = ?1 '
      '${at == null ? '' : 'AND (received_at, seq) < (?3, ?4) '}ORDER BY received_at DESC, seq DESC LIMIT ?2',
      [
        mailboxId,
        limit,
        if (at != null) ...[at, seq],
      ],
      {_db.emails},
    ).get();
    if (rows.isEmpty) return null;
    return StaleHeadersBatch(
      mailboxId: mailboxId,
      emailIds: [for (final r in rows) r.read<String>('id')],
      receivedAt: rows.last.read<int>('received_at'),
      seq: rows.last.read<int>('seq'),
    );
  }

  /// Fills header fields that stored summaries lack from [fetched] copies
  /// of them; nothing else changes (keywords and mailboxes stay as the
  /// store has them). Unknown ids are ignored. Watchers hear of it once.
  ///
  /// With [progress], the batch they were fetched for, saves how far the
  /// refetch got in the same transaction (see [nextStaleHeaders]).
  Future<void> fillHeaders(List<EmailSummary> fetched, {StaleHeadersBatch? progress}) async {
    const sql =
        'UPDATE emails SET list_id = coalesce(list_id, ?1), list_name = coalesce(list_name, ?2), '
        'list_post = coalesce(list_post, ?3), list_unsubscribe = coalesce(list_unsubscribe, ?4), '
        'list_unsubscribe_post = coalesce(list_unsubscribe_post, ?5) '
        'WHERE id = ?6 AND ((list_id IS NULL AND ?1 IS NOT NULL) OR (list_name IS NULL AND ?2 IS NOT NULL) '
        'OR (list_post IS NULL AND ?3 IS NOT NULL) OR (list_unsubscribe IS NULL AND ?4 IS NOT NULL) '
        'OR (list_unsubscribe_post IS NULL AND ?5 IS NOT NULL))';
    var changed = 0;
    await _db.transaction(() async {
      for (final e in fetched) {
        final values = [e.listId, e.listName, e.listPost, e.listUnsubscribe, e.listUnsubscribePost];
        if (values.every((v) => v == null)) continue;
        changed += await _db.customUpdate(
          sql,
          variables: [
            for (final v in [...values, e.id]) _var(v),
          ],
        );
      }
      if (progress != null) {
        await _db.customUpdate(
          'UPDATE sync_states SET headers_done_at = ?, headers_done_seq = ? WHERE mailbox_id = ? AND stale_headers = 1',
          variables: [_var(progress.receivedAt), _var(progress.seq), _var(progress.mailboxId)],
        );
      }
    });
    if (changed > 0) _db.notifyUpdates({TableUpdate.onTable(_db.emails, kind: UpdateKind.update)});
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
          // Header fields the stored copy predates.
          listId: _fill(old.listId, e.listId),
          listName: _fill(old.listName, e.listName),
          listPost: _fill(old.listPost, e.listPost),
          listUnsubscribe: _fill(old.listUnsubscribe, e.listUnsubscribe),
          listUnsubscribePost: _fill(old.listUnsubscribePost, e.listUnsubscribePost),
        );
        final changed =
            old.mailboxId != e.mailboxId ||
            old.keywords != keywords ||
            (companion.threadId.present && old.threadId != given) ||
            companion.preview.present ||
            companion.listId.present ||
            companion.listName.present ||
            companion.listPost.present ||
            companion.listUnsubscribe.present ||
            companion.listUnsubscribePost.present;
        if (changed) await (_db.update(_db.emails)..where((t) => t.id.equals(e.id))).write(companion);
        continue;
      }
      final assigner = byAccount[e.accountId] ??= ThreadAssigner(_db, e.accountId);
      final threadId = await assigner.assign(e);
      // A copy of an encrypted message decrypted before (in another
      // mailbox) shows its subject at once.
      final protectedSubject = e.hasDecryptedSubject ? e.subject : await _knownProtectedSubject(e);
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
              listId: Value(e.listId),
              listName: Value(e.listName),
              listPost: Value(e.listPost),
              listUnsubscribe: Value(e.listUnsubscribe),
              listUnsubscribePost: Value(e.listUnsubscribePost),
              isEncrypted: Value(e.isEncrypted),
              protectedSubject: Value(protectedSubject),
            ),
          );
    }
  }

  /// The protected subject of another copy of [e] (same account, Message-ID,
  /// size and outer subject), if one was decrypted.
  Future<String?> _knownProtectedSubject(EmailSummary e) async {
    final messageId = e.messageIdHeader;
    if (!e.isEncrypted || messageId == null) return null;
    final row = await _select(
      'SELECT protected_subject FROM emails WHERE account_id = ? AND message_id_header = ? AND size = ? '
      'AND subject = ? AND protected_subject IS NOT NULL LIMIT 1',
      [e.accountId, normalizeMessageId(messageId), e.size, e.subject],
      {_db.emails},
    ).getSingleOrNull();
    return row?.read<String>('protected_subject');
  }

  static Value<String?> _fill(String? stored, String? fetched) =>
      stored == null && fetched != null ? Value(fetched) : const Value.absent();

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

  /// SQL restricting `emails e` (joined with `mailboxes m`) to [ref]; [e]
  /// and [m] name other aliases of those tables.
  String _scopeSql(MailboxRef ref, List<Object?> args, {String e = 'e', String m = 'm'}) {
    final snoozeFolder = _snoozeFolderSql.replaceAll('m.', '$m.');
    switch (ref) {
      case RealMailboxRef(:final mailboxId):
        args.add(mailboxId);
        return '$e.mailbox_id = ?';
      case VirtualMailboxRef(:final kind):
        return switch (kind) {
          VirtualMailbox.allInboxes => "$m.role = 'inbox'",
          VirtualMailbox.unread =>
            "$e.is_seen = 0 AND $m.role NOT IN ($_virtualExcludedRoles, 'sent', 'drafts') AND NOT $snoozeFolder",
          VirtualMailbox.flagged =>
            '$e.is_flagged = 1 AND $m.role NOT IN ($_virtualExcludedRoles) AND NOT $snoozeFolder',
          VirtualMailbox.vip =>
            '$e.from_email IN (SELECT email FROM vip_addresses) '
                "AND $m.role NOT IN ($_virtualExcludedRoles, 'sent', 'drafts') AND NOT $snoozeFolder",
          VirtualMailbox.allDrafts => "$m.role = 'drafts'",
          VirtualMailbox.allSent => "$m.role = 'sent'",
        };
    }
  }

  static String _filterSql(QuickFilter f, {String e = 'e'}) => switch (f) {
    QuickFilter.unread => '$e.is_seen = 0',
    QuickFilter.flagged => '$e.is_flagged = 1',
    QuickFilter.toMe =>
      "EXISTS (SELECT 1 FROM json_each($e.to_json) j WHERE lower(json_extract(j.value, '\$.e')) IN (SELECT addr FROM me))",
    QuickFilter.ccMe =>
      "EXISTS (SELECT 1 FROM json_each($e.cc_json) j WHERE lower(json_extract(j.value, '\$.e')) IN (SELECT addr FROM me))",
    QuickFilter.hasAttachment => '$e.has_attachment = 1',
    QuickFilter.unreplied =>
      "NOT EXISTS (SELECT 1 FROM email_keywords k WHERE k.email_id = $e.id AND k.keyword = '\$answered')",
    QuickFilter.fromVip => '$e.from_email IN (SELECT email FROM vip_addresses)',
  };

  /// [_scopeSql] and the [filters], for the aliases [e] and [m].
  String _listWhere(MailboxRef ref, Set<QuickFilter> filters, List<Object?> args, {String e = 'e', String m = 'm'}) =>
      [_scopeSql(ref, args, e: e, m: m), for (final f in filters) _filterSql(f, e: e)].join(' AND ');

  /// Ranks copies of one message across mailboxes (lower is preferred).
  static const _copyRank =
      "CASE m.role WHEN 'inbox' THEN 0 WHEN 'all' THEN 3 WHEN 'flagged' THEN 2 WHEN 'important' THEN 2 ELSE 1 END";

  /// Threads looked at beyond the page, for copies that change a thread's
  /// place (see [watchList]).
  static const _threadSlack = 50;

  /// The message list of [ref], newest first; see `MailRepository.watchList`.
  ///
  /// A threaded list first finds the newest threads with an index walk that
  /// stops after a page ([_threadSlack] more), then ranks and counts only
  /// their messages: the work follows the page, not the mailbox (a 40,000
  /// message inbox took ~300 ms with the window functions over everything).
  Stream<List<ThreadSummary>> watchList(
    MailboxRef ref, {
    Set<QuickFilter> filters = const {},
    bool threaded = true,
    int limit = 200,
  }) {
    final args = <Object?>[];
    // Virtual mailboxes may hold several copies of one message (labels).
    final dedup = ref is VirtualMailboxRef;
    final copyRank = dedup
        ? 'ROW_NUMBER() OVER (PARTITION BY e.account_id, coalesce(e.message_id_header, e.id) ORDER BY $_copyRank, e.seq)'
        : '1';
    final String sql;
    if (threaded) {
      // A thread's newest message in scope: none newer in scope. The index
      // hints keep SQLite (without statistics) from scanning the mailbox
      // per message instead of the thread.
      final headWhere = _listWhere(ref, filters, args);
      final newerWhere = _listWhere(ref, filters, args, e: 'n', m: 'nm');
      args.add(limit + _threadSlack);
      final memberWhere = _listWhere(ref, filters, args);
      sql =
          '''
WITH me(addr) AS ($_meSql),
heads AS (
  SELECT e.account_id, e.thread_id FROM emails e JOIN mailboxes m ON m.id = e.mailbox_id
  WHERE $headWhere AND NOT EXISTS (
    SELECT 1 FROM emails n INDEXED BY emails_thread JOIN mailboxes nm ON nm.id = n.mailbox_id
    WHERE n.account_id = e.account_id AND n.thread_id = e.thread_id
      AND (n.received_at > e.received_at OR (n.received_at = e.received_at AND n.seq > e.seq)) AND $newerWhere)
  ORDER BY e.received_at DESC, e.seq DESC LIMIT ?
),
candidates AS (
  SELECT e.*, $copyRank AS copy_rank
  FROM heads h CROSS JOIN emails e INDEXED BY emails_thread ON e.account_id = h.account_id AND e.thread_id = h.thread_id
  JOIN mailboxes m ON m.id = e.mailbox_id WHERE $memberWhere
),
scoped AS (SELECT * FROM candidates WHERE copy_rank = 1),
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
    } else if (dedup) {
      // The newest messages in scope, then every copy of them in scope to
      // pick the preferred one: again work by the page.
      final recentWhere = _listWhere(ref, filters, args);
      args.add(limit + _threadSlack);
      final copyWhere = _listWhere(ref, filters, args);
      sql =
          '''
WITH me(addr) AS ($_meSql),
recent AS (
  SELECT e.seq, e.account_id, e.message_id_header AS mid FROM emails e JOIN mailboxes m ON m.id = e.mailbox_id
  WHERE $recentWhere ORDER BY e.received_at DESC, e.seq DESC LIMIT ?
),
copies AS (
  SELECT seq FROM recent
  UNION SELECT c.seq FROM recent r CROSS JOIN emails c INDEXED BY emails_message_id
    ON c.account_id = r.account_id AND c.message_id_header = r.mid
),
candidates AS (
  SELECT e.*, $copyRank AS copy_rank FROM copies x CROSS JOIN emails e ON e.seq = x.seq
  JOIN mailboxes m ON m.id = e.mailbox_id WHERE $copyWhere
),
scoped AS (SELECT * FROM candidates WHERE copy_rank = 1)
SELECT * FROM scoped ORDER BY received_at DESC, seq DESC LIMIT ?''';
    } else {
      final where = _listWhere(ref, filters, args);
      sql =
          '''
WITH me(addr) AS ($_meSql)
SELECT e.*, 1 AS copy_rank FROM emails e JOIN mailboxes m ON m.id = e.mailbox_id WHERE $where
ORDER BY e.received_at DESC, e.seq DESC LIMIT ?''';
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
  ///
  /// All Inboxes and Unread agree with the mailboxes' own (server) counts,
  /// although only the newest messages are stored: All Inboxes sums the
  /// inboxes' unread counts; Unread counts the stored unread messages once
  /// each (copies in several mailboxes are one message) and adds, per
  /// mailbox it covers, the unread messages the server has beyond the
  /// stored ones. A mailbox whose server count is unknown stores the local
  /// count (see [applySync]), so it adds nothing.
  Stream<Map<VirtualMailbox, int>> watchVirtualCounts() {
    // Mailboxes first, then their unread or flagged messages through the
    // partial indexes (emails_unread, emails_flagged), which cover the key.
    const distinctKey = "count(DISTINCT e.account_id || '|' || coalesce(e.message_id_header, '#' || e.seq))";
    const byMailbox = 'FROM mailboxes m CROSS JOIN emails e ON e.mailbox_id = m.id';
    const from = 'FROM emails e JOIN mailboxes m ON m.id = e.mailbox_id';
    const unreadRoles = "m.role NOT IN ($_virtualExcludedRoles, 'sent', 'drafts') AND NOT $_snoozeFolderSql";
    const sql =
        '''
SELECT
  (SELECT coalesce(sum(unread_count), 0) FROM mailboxes WHERE role = 'inbox') AS all_inboxes,
  (SELECT $distinctKey $byMailbox WHERE e.is_seen = 0 AND $unreadRoles) +
  (SELECT coalesce(sum(max(0, m.unread_count - coalesce(l.n, 0))), 0) FROM mailboxes m
    LEFT JOIN (SELECT mailbox_id, count(*) AS n FROM emails WHERE is_seen = 0 GROUP BY mailbox_id) l
      ON l.mailbox_id = m.id
    WHERE $unreadRoles) AS unread,
  (SELECT $distinctKey $byMailbox WHERE e.is_flagged = 1 AND m.role NOT IN ($_virtualExcludedRoles)
    AND NOT $_snoozeFolderSql) AS flagged,
  (SELECT $distinctKey $from WHERE e.is_seen = 0 AND e.from_email IN (SELECT email FROM vip_addresses)
    AND $unreadRoles) AS vip,
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

  /// Messages in every account's snooze folder (see `Snooze`), in no
  /// particular order.
  Stream<List<EmailSummary>> watchSnoozed() => _select(
    'SELECT e.* FROM emails e JOIN mailboxes m ON m.id = e.mailbox_id WHERE $_snoozeFolderSql',
    [],
    {_db.emails, _db.mailboxes, _db.emailKeywords},
  ).watch().distinct(_rowsEqual).map((rows) => [for (final r in rows) summaryFromRow(_emailRow(r))]);

  // Mailing lists -----------------------------------------------------------

  /// Messages of `emails e` (joined with `mailboxes m`) on mailing lists,
  /// one copy per message, outside Trash and Junk; [where] narrows them.
  static String _listCandidates(String where) =>
      '''
candidates AS (
  SELECT e.*, ROW_NUMBER() OVER (PARTITION BY e.account_id, coalesce(e.message_id_header, e.id)
    ORDER BY $_copyRank, e.seq) AS copy_rank
  FROM emails e JOIN mailboxes m ON m.id = e.mailbox_id
  WHERE $where AND m.role NOT IN ('trash', 'junk')
)''';

  /// The conversations of list [listId], newest activity first; see
  /// `MailingLists.watchListThreads`.
  Stream<List<ListThread>> watchListThreads(String listId, {bool includeMuted = false, int limit = 200}) {
    final sql =
        '''
WITH ${_listCandidates('e.list_id = ?')},
scoped AS (
  SELECT c.*, (t.thread_id IS NOT NULL) AS muted FROM candidates c
  LEFT JOIN muted_threads t ON t.account_id = c.account_id AND t.thread_id = c.thread_id
  WHERE c.copy_rank = 1${includeMuted ? '' : ' AND t.thread_id IS NULL'}
),
ranked AS (
  SELECT s.*,
    ROW_NUMBER() OVER (t ORDER BY s.received_at DESC, s.seq DESC) AS rn_new,
    ROW_NUMBER() OVER (t ORDER BY s.received_at ASC, s.seq ASC) AS rn_old,
    count(*) OVER t AS thread_count,
    sum(1 - s.is_seen) OVER t AS thread_unread,
    max(s.received_at) OVER t AS last_at,
    json_group_array(json(s.from_json)) OVER (t ORDER BY s.received_at ASC, s.seq ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS thread_from,
    json_group_array(s.subject) FILTER (WHERE instr(s.subject, 'PATCH') > 0) OVER t AS patch_subjects
  FROM scoped s
  WINDOW t AS (PARTITION BY s.account_id, s.thread_id)
),
threads AS (
  SELECT account_id, thread_id FROM ranked WHERE rn_new = 1 ORDER BY last_at DESC, seq DESC LIMIT ?
)
SELECT r.* FROM ranked r JOIN threads th ON th.account_id = r.account_id AND th.thread_id = r.thread_id
WHERE r.rn_new = 1 OR r.rn_old = 1
ORDER BY r.last_at DESC, r.account_id, r.thread_id, r.rn_new''';
    return _select(
      sql,
      [listId.toLowerCase(), limit],
      {_db.emails, _db.mailboxes, _db.mutedThreads},
    ).watch().distinct(_rowsEqual).map(_listThreadsFromRows);
  }

  List<ListThread> _listThreadsFromRows(List<QueryRow> rows) {
    String keyOf(QueryRow r) => '${r.read<String>('account_id')}|${r.read<String>('thread_id')}';
    final out = <ListThread>[];
    for (var i = 0; i < rows.length;) {
      final key = keyOf(rows[i]);
      var j = i + 1;
      while (j < rows.length && keyOf(rows[j]) == key) {
        j++;
      }
      final group = rows.sublist(i, j);
      i = j;
      final newest = group.firstWhere((x) => x.read<int>('rn_new') == 1);
      final oldest = group.firstWhere((x) => x.read<int>('rn_old') == 1);
      final first = summaryFromRow(_emailRow(oldest));
      final participants = <EmailAddress>[];
      final seen = <String>{};
      for (final list in jsonDecode(newest.read<String>('thread_from')) as List<Object?>) {
        for (final a in list! as List<Object?>) {
          final m = (a! as Map).cast<String, Object?>();
          final email = m['e']! as String;
          if (seen.add(email.toLowerCase())) participants.add(EmailAddress(email, m['n'] as String?));
        }
      }
      final subjects = [
        for (final s in jsonDecode(newest.read<String?>('patch_subjects') ?? '[]') as List<Object?>) ?s as String?,
      ];
      out.add(
        ListThread(
          threadId: newest.read<String>('thread_id'),
          first: first,
          latest: summaryFromRow(_emailRow(newest)),
          messageCount: newest.read<int>('thread_count'),
          unreadCount: newest.read<int>('thread_unread'),
          participants: participants,
          patchCount: ListThread.countPatches(subjects, series: PatchTag.parse(first.subject)),
          isMuted: newest.read<int>('muted') != 0,
        ),
      );
    }
    return out;
  }

  /// Ids of the muted conversations of all accounts.
  Stream<Set<String>> watchMutedThreads() => _select('SELECT thread_id FROM muted_threads ORDER BY thread_id', [], {
    _db.mutedThreads,
  }).watch().distinct(_rowsEqual).map((rows) => {for (final r in rows) r.read<String>('thread_id')});

  /// The account and conversation of [emailId] (resolving moved ids), or
  /// null when it isn't stored.
  Future<({String accountId, String threadId})?> threadOf(String emailId) async {
    final id = await resolveId(emailId);
    final row = await (_db.select(_db.emails)..where((e) => e.id.equals(id))).getSingleOrNull();
    return row == null ? null : (accountId: row.accountId, threadId: row.threadId);
  }

  /// Mutes or unmutes conversation [threadId] of [accountId].
  Future<void> setThreadMuted(String accountId, String threadId, {required bool muted, DateTime? now}) async {
    if (muted) {
      await _db
          .into(_db.mutedThreads)
          .insert(
            MutedThreadsCompanion.insert(
              accountId: accountId,
              threadId: threadId,
              mutedAt: (now ?? DateTime.now()).millisecondsSinceEpoch,
            ),
            mode: InsertMode.insertOrIgnore,
          );
    } else {
      await (_db.delete(
        _db.mutedThreads,
      )..where((t) => t.accountId.equals(accountId) & t.threadId.equals(threadId))).go();
    }
  }

  /// Unread messages of conversation [threadId] of [accountId].
  Future<List<String>> unreadInThread(String accountId, String threadId) async {
    final rows = await _select(
      'SELECT id FROM emails WHERE account_id = ? AND thread_id = ? AND is_seen = 0',
      [accountId, threadId],
      {_db.emails},
    ).get();
    return [for (final r in rows) r.read<String>('id')];
  }

  /// The unread ones among [emailIds] whose conversation is muted.
  Future<List<String>> unreadInMutedThreads(Iterable<String> emailIds) async {
    final out = <String>[];
    for (final chunk in _chunks(emailIds.toSet().toList())) {
      final rows = await _select(
        'SELECT e.id FROM emails e JOIN muted_threads t ON t.account_id = e.account_id AND t.thread_id = e.thread_id '
        'WHERE e.is_seen = 0 AND e.id IN (${List.filled(chunk.length, '?').join(', ')})',
        chunk,
        {_db.emails, _db.mutedThreads},
      ).get();
      out.addAll([for (final r in rows) r.read<String>('id')]);
    }
    return out;
  }

  // Subscriptions -----------------------------------------------------------

  /// Messages counted for subscriptions (see `summarizeSubscriptions`):
  /// `emails e` joined with `mailboxes m`, after a `me` CTE.
  static const _subscriptionScopeSql =
      "m.role NOT IN ('junk', 'sent', 'drafts') AND e.from_email <> '' AND e.from_email NOT IN (SELECT addr FROM me)";

  /// "Newest value" of a column within a group: the maximum of the receipt
  /// time (zero-padded) and the value, so `max()` picks the newest row's.
  static String _newest(String value) => "printf('%015d', received_at) || char(31) || $value";

  static String? _newestValue(String? packed) {
    if (packed == null) return null;
    final at = packed.indexOf('\u001f');
    return at < 0 ? null : packed.substring(at + 1);
  }

  /// The copies counted for subscriptions (bulk mail in scope) among
  /// `emails e` as [from] joins it, after a `me` CTE; with [key] as `mkey`,
  /// the key of each copy's message. With [details], what classifying a
  /// list reads too: its List-Post, and whether the copy replies to mail of
  /// its list (`SubscriptionSource.hasReplies`).
  static String _subscriptionCopiesSql(
    String from, {
    String where = 'TRUE',
    String key = 'NULL',
    bool details = false,
  }) =>
      '''
SELECT e.account_id, coalesce(e.message_id_header, e.id) AS mid, e.mailbox_id, m.role, e.received_at, e.is_seen,
  e.from_email, e.list_name, e.list_unsubscribe, e.list_unsubscribe_post,
  trim(coalesce(json_extract(e.from_json, '\$[0].n'), '')) AS from_name, e.sub_key AS gkey, $key AS mkey,
  (e.list_id IS NOT NULL OR e.list_unsubscribe IS NOT NULL) AS has_headers${details ? ', $_replySql AS is_reply, e.list_post' : ''}
FROM $from JOIN mailboxes m ON m.id = e.mailbox_id
WHERE e.sub_key IS NOT NULL AND $_subscriptionScopeSql AND $where''';

  /// SQL true when the copy `e` answers mail of its own list: its
  /// In-Reply-To (else its last References entry) is the Message-ID of a
  /// stored message of the account with the same List-Id.
  static const _replySql = '''
(e.list_id IS NOT NULL AND (e.in_reply_to IS NOT NULL OR e.references_json <> '[]')
  AND EXISTS (SELECT 1 FROM emails p INDEXED BY emails_message_id WHERE p.account_id = e.account_id
    AND p.message_id_header = coalesce(e.in_reply_to, json_extract(e.references_json, '\$[#-1]'))
    AND p.list_id = e.list_id))''';

  /// `subscription_messages` rows of the messages in `copies`: one per
  /// message, under the first of its copies' keys.
  static const _subscriptionMessagesSql =
      "SELECT account_id, mid, min(gkey), max(received_at), max(is_seen), max(role = 'inbox'), min(role = 'trash') "
      'FROM copies GROUP BY account_id, mid';

  /// `subscription_details` rows of the keys in `copies` (made with
  /// `details`, by `mkey`): what all copies of the key's messages say, as
  /// `subscriptionSources` has it.
  static final _subscriptionDetailsSql =
      '''
SELECT mkey, group_concat(DISTINCT mailbox_id), group_concat(DISTINCT account_id), count(DISTINCT from_email),
  count(DISTINCT CASE WHEN received_at >= key_last - ${listPostersWindow.inMilliseconds} THEN from_email END),
  max(is_reply), max(has_headers), max(${_newest('from_email')}),
  max(CASE WHEN trim(coalesce(list_name, '')) <> '' THEN ${_newest('trim(list_name)')} END),
  max(CASE WHEN from_name <> '' THEN ${_newest('from_name')} END),
  max(CASE WHEN list_post IS NOT NULL THEN ${_newest('list_post')} END),
  max(CASE WHEN list_unsubscribe IS NOT NULL THEN ${_newest("list_unsubscribe || char(31) || coalesce(list_unsubscribe_post, '')")} END),
  NULL, NULL, NULL, NULL
FROM (SELECT *, max(received_at) OVER (PARTITION BY mkey) AS key_last FROM copies) GROUP BY mkey''';

  /// Fills in what SQL can't work out for the `subscription_details` rows
  /// of [where]: whether a list is a discussion
  /// (`SubscriptionSource.autoKind`), the key a source goes under as a
  /// newsletter (`SubscriptionSource.newsletterKey`), and its newest List-Id
  /// phrase and From name when they can name it (`humanName`). With them,
  /// the sources of one newsletter are added up before they are read.
  Future<void> _nameSources(String where) async {
    final rows = await _select(
      'SELECT key, senders, posters, replies, sender, list_name, from_name, post FROM subscription_details '
      'WHERE $where',
      const [],
      const {},
    ).get();
    if (rows.isEmpty) return;
    final values = [
      for (final r in rows)
        if ((
              _newestOf(r.read<String?>('list_name')),
              _newestOf(r.read<String?>('from_name')),
              _newestOf(r.read<String?>('post')),
            )
            case (final phrase, final name, final post))
          if (SubscriptionSource(
                key: r.read<String>('key'),
                address: _newestValue(r.read<String?>('sender')) ?? '',
                senderCount: r.read<int>('senders'),
                posters: r.read<int>('posters'),
                hasReplies: (r.read<int?>('replies') ?? 0) != 0,
                fromName: name,
                listPost: post,
              )
              case final source)
            [
              source.key,
              source.autoKind.name,
              source.newsletterKey,
              humanName(phrase?.value) == null ? 0 : 1,
              humanName(name?.value) == null ? 0 : 1,
            ],
    ];
    await _db.customStatement(
      "UPDATE subscription_details SET auto_kind = json_extract(j.value, '\$[1]'), "
      "nkey = json_extract(j.value, '\$[2]'), "
      "human_phrase = CASE WHEN json_extract(j.value, '\$[3]') = 1 THEN list_name END, "
      "human_name = CASE WHEN json_extract(j.value, '\$[4]') = 1 THEN from_name END "
      "FROM json_each(?) j WHERE subscription_details.key = json_extract(j.value, '\$[0]')",
      [jsonEncode(values)],
    );
  }

  /// The copies of the messages that [from] joins as `s` (rows with
  /// `account_id` and `mid`), copies found by Message-ID or else by id, with
  /// [key] as `mkey`. The joined rows come first (CROSS JOIN): they are few.
  static String _copiesOfMessagesSql(String from, {String key = 's.key', bool details = false}) => [
    _subscriptionCopiesSql(
      '$from CROSS JOIN emails e ON e.account_id = s.account_id AND e.message_id_header = s.mid',
      key: key,
      details: details,
    ),
    _subscriptionCopiesSql(
      '$from CROSS JOIN emails e ON e.id = s.mid',
      where: 'e.message_id_header IS NULL',
      key: key,
      details: details,
    ),
  ].join(' UNION ALL ');

  /// Brings the Subscriptions screen's data up to date (see
  /// `_subscriptionSchema`): the messages the triggers marked since the last
  /// time, and the keys they were and are under; or everything after a `*`
  /// or when more than half the messages are marked.
  /// One transaction, so another process's changes wait for it and are
  /// marked for the next time.
  Future<void> _refreshSubscriptions() => _db.transaction(() async {
    Future<void> run(String sql) => _db.customStatement(sql);
    final state = await _select(
      "SELECT EXISTS (SELECT 1 FROM subscription_dirty_keys WHERE key = '*') AS r, "
      '(SELECT count(*) FROM subscription_dirty) AS d, (SELECT count(*) FROM subscription_messages) AS m',
      const [],
      const {},
    ).getSingle();
    // After long enough without a look, redoing everything is quicker.
    if (state.read<int>('r') == 1 || state.read<int>('d') * 2 > state.read<int>('m')) {
      await run('DELETE FROM subscription_messages');
      await run('DELETE FROM subscription_details');
      await run(
        'WITH me(addr) AS ($_meSql), copies AS (${_subscriptionCopiesSql('emails e')}) '
        'INSERT INTO subscription_messages $_subscriptionMessagesSql',
      );
      final all = _subscriptionCopiesSql(
        'emails e JOIN subscription_messages s ON s.account_id = e.account_id '
        'AND s.mid = coalesce(e.message_id_header, e.id)',
        key: 's.key',
        details: true,
      );
      await run(
        'WITH me(addr) AS ($_meSql), copies AS ($all) INSERT INTO subscription_details $_subscriptionDetailsSql',
      );
      await _nameSources('TRUE');
    } else {
      // The keys of the marked messages, before and after they are redone.
      const keysOfDirty =
          'INSERT OR IGNORE INTO subscription_dirty_keys SELECT s.key FROM subscription_dirty d '
          'CROSS JOIN subscription_messages s ON s.account_id = d.account_id AND s.mid = d.mid';
      await run(keysOfDirty);
      // And the lists of marked messages that don't count (the user's own
      // posts): what answers them makes a list a discussion.
      await run(
        'INSERT OR IGNORE INTO subscription_dirty_keys SELECT e.sub_key FROM subscription_dirty d '
        'CROSS JOIN emails e ON e.account_id = d.account_id AND e.message_id_header = d.mid '
        'WHERE e.list_id IS NOT NULL AND e.sub_key IS NOT NULL '
        'UNION SELECT e.sub_key FROM subscription_dirty d CROSS JOIN emails e ON e.id = d.mid '
        'WHERE e.message_id_header IS NULL AND e.list_id IS NOT NULL AND e.sub_key IS NOT NULL',
      );
      await run(
        'DELETE FROM subscription_messages WHERE (account_id, mid) IN (SELECT account_id, mid FROM subscription_dirty)',
      );
      final dirty = _copiesOfMessagesSql('subscription_dirty s', key: 'NULL');
      await run(
        'WITH me(addr) AS ($_meSql), copies AS ($dirty) INSERT INTO subscription_messages $_subscriptionMessagesSql',
      );
      await run(keysOfDirty);
      await run('DELETE FROM subscription_details WHERE key IN (SELECT key FROM subscription_dirty_keys)');
      final keys = _copiesOfMessagesSql(
        'subscription_dirty_keys k CROSS JOIN subscription_messages s ON s.key = k.key',
        details: true,
      );
      await run(
        'WITH me(addr) AS ($_meSql), copies AS ($keys) INSERT INTO subscription_details $_subscriptionDetailsSql',
      );
      await _nameSources('key IN (SELECT key FROM subscription_dirty_keys)');
    }
    await run('DELETE FROM subscription_dirty');
    await run('DELETE FROM subscription_dirty_keys');
  });

  /// The sources of bulk mail (see `SubscriptionSource`), counting recent
  /// mail from [cutoff] (epoch milliseconds), and the kinds the user chose
  /// for lists; after bringing the data up to date if anything changed.
  Future<(List<QueryRow>, List<QueryRow>)> _subscriptionRows(int cutoff) async {
    // Discussions, and lists that stay one newsletter, are sources of their
    // own; the other sources that go under one newsletter (a sender's
    // campaigns, its addresses) are added up here, so about as many rows
    // come back as there are subscriptions, and `groupSubscriptions` has
    // little left to do.
    const sql = '''
WITH stats AS (
  SELECT key AS gkey, count(*) AS total, sum(seen) AS seen, sum(seen = 0 AND trash = 0) AS unread,
    sum(received_at >= ?1) AS recent, sum(CASE WHEN received_at >= ?1 THEN seen ELSE 0 END) AS recent_seen,
    sum(inbox) AS inbox, max(received_at) AS last_at
  FROM subscription_messages GROUP BY key
),
sources AS (
  SELECT s.*, d.*, CASE WHEN d.key LIKE 'list:%' AND coalesce(k.kind, d.auto_kind) = 'discussion' THEN d.key
    ELSE coalesce(d.nkey, d.key) END AS skey
  FROM stats s JOIN subscription_details d ON d.key = s.gkey LEFT JOIN list_kinds k ON k.list_id = substr(d.key, 6)
  WHERE d.has_headers = 1 OR s.total >= 2
)
SELECT gkey, NULL AS keys, total, seen, unread, recent, recent_seen, inbox, last_at, boxes, accounts, senders,
  posters, replies, sender, list_name, from_name, post, unsubscribe
FROM sources WHERE skey = gkey AND gkey LIKE 'list:%'
UNION ALL
SELECT skey, group_concat(gkey, char(30)), sum(total), sum(seen), sum(unread), sum(recent), sum(recent_seen),
  sum(inbox), max(last_at), group_concat(boxes), group_concat(accounts), max(senders), max(posters), max(replies),
  max(sender), max(human_phrase), max(human_name), max(post), max(unsubscribe)
FROM sources WHERE NOT (skey = gkey AND gkey LIKE 'list:%') GROUP BY skey''';
    Future<(List<QueryRow>, List<QueryRow>)> read() async => (
      await _select(sql, [cutoff], const {}).get(),
      await _select('SELECT list_id, kind FROM list_kinds', const [], const {}).get(),
    );
    final dirty = await _select(
      'SELECT EXISTS (SELECT 1 FROM subscription_dirty_keys) OR EXISTS (SELECT 1 FROM subscription_dirty) AS d',
      const [],
      const {},
    ).getSingle();
    if (dirty.read<int>('d') == 0) return read();
    return _db.transaction(() async {
      await _refreshSubscriptions();
      return read();
    });
  }

  /// The subscriptions, counting recent mail from [cutoff].
  Future<List<Subscription>> _subscriptions(int cutoff) async {
    final (rows, kindRows) = await _subscriptionRows(cutoff);
    final kinds = {
      for (final r in kindRows) r.read<String>('list_id'): ?SubscriptionKind.values.asNameMap()[r.read<String>('kind')],
    };
    return groupSubscriptions([for (final r in rows) _sourceFromRow(r)], kinds: kinds);
  }

  /// Bulk mail grouped into newsletters and discussions, ranked by
  /// `Subscription.compareByNeglect`; see `MailSubscriptions`. Counts read
  /// and recent mail relative to [now].
  ///
  /// The sources are kept in tables that triggers mark out of date as mail
  /// changes (see `_subscriptionSchema`): opening the screen redoes only
  /// what changed since it was last open, not every message. Grouping the
  /// few hundred sources (`groupSubscriptions`) is done as they are read.
  Stream<List<Subscription>> watchSubscriptions({DateTime? now}) {
    final cutoff = (now ?? DateTime.now()).subtract(Subscription.window).millisecondsSinceEpoch;
    return _recomputed('subscriptions', {
      _db.emails,
      _db.mailboxes,
      _db.accounts,
      _db.listKinds,
    }, () => _subscriptions(cutoff)).distinct(_listEquals);
  }

  /// A packed "newest value" ([_newest]) with its time.
  static NewestValue? _newestOf(String? packed) {
    if (packed == null) return null;
    final at = packed.indexOf('\u001f');
    final millis = at < 0 ? null : int.tryParse(packed.substring(0, at));
    return millis == null ? null : (at: fromMillis(millis), value: packed.substring(at + 1));
  }

  static SubscriptionSource _sourceFromRow(QueryRow r) {
    List<String> split(String column) =>
        (r.read<String?>(column) ?? '').split(',').where((s) => s.isNotEmpty).toList()..sort();
    return SubscriptionSource(
      key: r.read<String>('gkey'),
      keys: r.read<String?>('keys')?.split('\u001e') ?? const [],
      address: _newestValue(r.read<String?>('sender')) ?? '',
      messageCount: r.read<int>('total'),
      readCount: r.read<int>('seen'),
      unreadCount: r.read<int>('unread'),
      recentCount: r.read<int>('recent'),
      recentReadCount: r.read<int>('recent_seen'),
      inboxCount: r.read<int>('inbox'),
      senderCount: r.read<int>('senders'),
      posters: r.read<int>('posters'),
      hasReplies: (r.read<int?>('replies') ?? 0) != 0,
      lastReceived: fromMillis(r.read<int>('last_at')),
      mailboxIds: split('boxes'),
      accountIds: split('accounts'),
      fromName: _newestOf(r.read<String?>('from_name')),
      listName: _newestOf(r.read<String?>('list_name')),
      listPost: _newestOf(r.read<String?>('post')),
      unsubscribe: _newestOf(r.read<String?>('unsubscribe')),
    );
  }

  /// The messages of subscription [key], newest first; see
  /// `MailSubscriptions.watchSubscriptionEmails`. Which sources it has is
  /// worked out again as mail changes.
  Stream<List<EmailSummary>> watchSubscriptionEmails(
    String key, {
    bool inboxOnly = false,
    int limit = 200,
    DateTime? now,
  }) {
    if (!key.startsWith('list:') && !key.startsWith('from:') && !key.startsWith('sender:')) {
      return Stream.value(const []);
    }
    final cutoff = (now ?? DateTime.now()).subtract(Subscription.window).millisecondsSinceEpoch;
    Future<List<EmailSummary>> read() async {
      final subs = await _subscriptions(cutoff);
      final group = subs.where((s) => s.key == key).firstOrNull;
      // Else the key of a source (a list, a sender): its own mail.
      final sources = group?.sourceKeys ?? [if (!key.startsWith('sender:')) key];
      if (sources.isEmpty) return const <EmailSummary>[];
      final sql =
          '''
WITH me(addr) AS ($_meSql)
SELECT e.* FROM emails e JOIN mailboxes m ON m.id = e.mailbox_id
WHERE e.sub_key IN (${List.filled(sources.length, '?').join(', ')}) AND $_subscriptionScopeSql${inboxOnly ? " AND m.role = 'inbox'" : ''}
ORDER BY e.received_at DESC, e.seq DESC LIMIT ?''';
      final rows = await _select(sql, [...sources, limit], const {}).get();
      return [for (final r in rows) summaryFromRow(_emailRow(r))];
    }

    return _recomputed('subscription_emails', {
      _db.emails,
      _db.mailboxes,
      _db.accounts,
      _db.emailKeywords,
      _db.listKinds,
    }, read).distinct(_summariesEqual);
  }

  /// Treats the lists [listIds] as [kind] ("Treat as Newsletter"), or as
  /// they are classified with null; see `MailSubscriptions.setListKind`.
  Future<void> setListKind(Iterable<String> listIds, SubscriptionKind? kind) => _db.transaction(() async {
    for (final id in {for (final l in listIds) l.trim().toLowerCase()}) {
      if (id.isEmpty) continue;
      if (kind == null) {
        await (_db.delete(_db.listKinds)..where((k) => k.listId.equals(id))).go();
      } else {
        await _db.into(_db.listKinds).insertOnConflictUpdate(ListKindsCompanion.insert(listId: id, kind: kind.name));
      }
    }
  });

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
    // Outside one mailbox, walk the messages newest first and stop at the
    // page: SQLite would otherwise fetch every full-text match and sort
    // them (a one-letter prefix while typing matches most of the mail).
    final newestFirst = scope is MailboxScope && scope.ref is RealMailboxRef ? '' : ' INDEXED BY emails_received';
    final sql =
        'SELECT e.*, $_copyRank AS copy_pref FROM emails e$newestFirst JOIN mailboxes m ON m.id = e.mailbox_id '
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

  // Encrypted mail ----------------------------------------------------------

  /// Remembers [subject] as the protected subject of the encrypted message
  /// [emailId] and of its copies (same account, Message-ID, size and outer
  /// subject: the same message in other mailboxes). The summaries show it
  /// as their subject from then on, and the full-text index has it.
  Future<void> rememberProtectedSubject(String emailId, String subject) async {
    final id = await resolveId(emailId);
    await _write(
      'UPDATE emails SET protected_subject = ?1 WHERE (id = ?2 OR (message_id_header IS NOT NULL AND '
      '(account_id, message_id_header, size, subject) = '
      '(SELECT account_id, message_id_header, size, subject FROM emails WHERE id = ?2))) '
      'AND protected_subject IS NOT ?1',
      [subject, id],
      {_db.emails},
      kind: UpdateKind.update,
    );
  }

  /// The most of a decrypted text the search index keeps, in characters.
  static const maxDecryptedTextChars = 64 * 1024;

  /// Indexes [text], the decrypted text of the encrypted message [emailId]
  /// (the first [maxDecryptedTextChars]), for full-text search: it stands in
  /// for the message's cached body there. Ignored if the message isn't
  /// stored.
  Future<void> putDecryptedText(String emailId, String text) async {
    final id = await resolveId(emailId);
    final body = text.length > maxDecryptedTextChars ? text.substring(0, maxDecryptedTextChars) : text;
    await _db.customStatement(
      'INSERT INTO decrypted_texts (email_id, body) SELECT id, ?2 FROM emails WHERE id = ?1 '
      'ON CONFLICT (email_id) DO UPDATE SET body = excluded.body WHERE body IS NOT excluded.body',
      [id, body],
    );
  }

  /// Takes every decrypted text out of the search index. Returns how many.
  Future<int> deleteDecryptedTexts() => _db.customUpdate('DELETE FROM decrypted_texts');

  // Calendar invitations ----------------------------------------------------

  /// The record of the invitation [uid] (and [recurrenceId]), as the app
  /// wrote it; see `CalendarRecords`.
  Future<String?> calendarRecord(String uid, {String recurrenceId = ''}) async {
    final rows = await _db
        .customSelect(
          'SELECT data FROM calendar_records WHERE uid = ?1 AND recurrence_id = ?2',
          variables: [Variable.withString(uid), Variable.withString(recurrenceId)],
        )
        .get();
    return rows.firstOrNull?.read<String>('data');
  }

  /// Saves [data] as the record of [uid] (and [recurrenceId]); null deletes it.
  Future<void> putCalendarRecord(String uid, String? data, {String recurrenceId = '', DateTime? now}) {
    if (data == null) {
      return _db.customStatement('DELETE FROM calendar_records WHERE uid = ?1 AND recurrence_id = ?2', [
        uid,
        recurrenceId,
      ]);
    }
    return _db.customStatement(
      'INSERT INTO calendar_records (uid, recurrence_id, data, updated_at) VALUES (?1, ?2, ?3, ?4) '
      'ON CONFLICT (uid, recurrence_id) DO UPDATE SET data = excluded.data, updated_at = excluded.updated_at',
      [uid, recurrenceId, data, (now ?? DateTime.now()).millisecondsSinceEpoch],
    );
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
          held: Value(entry.held),
        ),
      );

  OutboxEntry _outboxFromRow(QueryRow q) {
    final r = _db.outboxItems.map(q.data);
    final composedFor = q.readNullable<int>('composed_for');
    return OutboxEntry(
      id: r.id,
      accountId: r.accountId,
      message: decodeOutgoing(r.message),
      sendAfter: fromMillis(r.sendAfter),
      createdAt: fromMillis(r.createdAt),
      status: OutboxStatus.values.byName(r.status),
      attempts: r.attempts,
      lastError: r.lastError,
      held: r.held,
      composedFor: composedFor == null ? null : fromMillis(composedFor),
    );
  }

  /// Outbox entries [where], soonest first, with when their copies were composed for.
  Selectable<QueryRow> _outbox(String where, List<Object?> args) => _select(
    'SELECT o.*, (SELECT min(c.date) FROM outbox_copies c WHERE c.outbox_id = o.id) AS composed_for '
    'FROM outbox_items o WHERE $where ORDER BY o.send_after',
    args,
    {_db.outboxItems, _db.outboxCopies},
  );

  Future<OutboxEntry?> getOutbox(String id) async {
    final row = await _outbox('o.id = ?', [id]).getSingleOrNull();
    return row == null ? null : _outboxFromRow(row);
  }

  Future<List<OutboxEntry>> outboxEntries({String? accountId}) async => [
    for (final r in await (accountId == null ? _outbox('1', []) : _outbox('o.account_id = ?', [accountId])).get())
      _outboxFromRow(r),
  ];

  Stream<List<OutboxEntry>> watchOutbox() =>
      _outbox('1', []).watch().map((rows) => [for (final r in rows) _outboxFromRow(r)]);

  /// Atomically marks a queued (or failed) entry that is due at [now] as
  /// sending. Returns it, or null if it is gone, being sent, held (see
  /// [OutboxEntry.held]), or was moved to later meanwhile.
  ///
  /// While an entry is sending, its `sendAfter` holds the time of the claim,
  /// so a claim left by a process that died can be told from one in
  /// progress (see [releaseStaleOutboxClaims]).
  Future<OutboxEntry?> claimOutbox(String id, {DateTime? now}) => _db.transaction(() async {
    final at = (now ?? DateTime.now()).millisecondsSinceEpoch;
    final n = await _write(
      'UPDATE outbox_items SET status = ?, send_after = ? WHERE id = ? AND status != ? AND held = 0 AND send_after <= ?',
      [OutboxStatus.sending.name, at, id, OutboxStatus.sending.name, at],
      {_db.outboxItems},
      kind: UpdateKind.update,
    );
    return n == 0 ? null : getOutbox(id);
  });

  /// Queues again the entries claimed for sending at or before
  /// [claimedBy]: the process sending them died. Returns how many.
  Future<int> releaseStaleOutboxClaims(DateTime claimedBy) => _write(
    'UPDATE outbox_items SET status = ? WHERE status = ? AND send_after <= ?',
    [OutboxStatus.queued.name, OutboxStatus.sending.name, claimedBy.millisecondsSinceEpoch],
    {_db.outboxItems},
    kind: UpdateKind.update,
  );

  /// Removes an entry unless it is being sent. Returns it if removed.
  Future<OutboxEntry?> takeOutbox(String id) => _db.transaction(() async {
    final entry = await getOutbox(id);
    if (entry == null || entry.status == OutboxStatus.sending) return null;
    await (_db.delete(_db.outboxItems)..where((o) => o.id.equals(id))).go();
    return entry;
  });

  /// Moves an entry that isn't being sent to [sendAfter] with [status],
  /// clearing its last error and releasing it if it was held. Returns false
  /// if it is gone or being sent.
  Future<bool> rescheduleOutbox(String id, {required DateTime sendAfter, required OutboxStatus status}) async {
    final n = await _write(
      'UPDATE outbox_items SET send_after = ?, status = ?, last_error = NULL, held = 0 WHERE id = ? AND status != ?',
      [sendAfter.millisecondsSinceEpoch, status.name, id, OutboxStatus.sending.name],
      {_db.outboxItems},
      kind: UpdateKind.update,
    );
    return n > 0;
  }

  Future<void> deleteOutbox(String id) => (_db.delete(_db.outboxItems)..where((o) => o.id.equals(id))).go();

  /// Replaces what entry [id] was composed as when it was queued; null
  /// forgets it (it is composed when it goes out). Ignored if the entry is
  /// gone.
  Future<void> setOutboxCopies(String id, PreparedMessage? prepared) => _db.transaction(() async {
    await (_db.delete(_db.outboxCopies)..where((c) => c.outboxId.equals(id))).go();
    final exists =
        await (_db.selectOnly(_db.outboxItems)
              ..addColumns([_db.outboxItems.id])
              ..where(_db.outboxItems.id.equals(id)))
            .getSingleOrNull();
    if (prepared == null || exists == null) return;
    for (final (i, copy) in prepared.copies.indexed) {
      await _db
          .into(_db.outboxCopies)
          .insert(
            OutboxCopiesCompanion.insert(
              outboxId: id,
              seq: i,
              recipients: encodeStrings(copy.recipients),
              filed: Value(copy.filed),
              date: prepared.date.millisecondsSinceEpoch,
              data: copy.rfc822,
            ),
          );
    }
  });

  /// What entry [id] was composed as when it was queued, if it was.
  Future<PreparedMessage?> outboxCopies(String id) async {
    final rows =
        await (_db.select(_db.outboxCopies)
              ..where((c) => c.outboxId.equals(id))
              ..orderBy([(c) => OrderingTerm.asc(c.seq)]))
            .get();
    if (rows.isEmpty) return null;
    return PreparedMessage(
      date: fromMillis(rows.first.date),
      copies: [for (final r in rows) PreparedCopy(decodeStrings(r.recipients), r.data, filed: r.filed)],
    );
  }

  /// Sets an entry's [status] and [lastError], and what else is given.
  /// [held] true keeps a failed entry from being claimed until it is
  /// rescheduled (see [OutboxEntry.held]).
  Future<void> updateOutbox(
    String id, {
    required OutboxStatus status,
    int? attempts,
    String? lastError,
    DateTime? sendAfter,
    bool? held,
  }) => (_db.update(_db.outboxItems)..where((o) => o.id.equals(id))).write(
    OutboxItemsCompanion(
      status: Value(status.name),
      attempts: attempts == null ? const Value.absent() : Value(attempts),
      lastError: Value(lastError),
      sendAfter: sendAfter == null ? const Value.absent() : Value(sendAfter.millisecondsSinceEpoch),
      held: held == null ? const Value.absent() : Value(held),
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

  // Rules -------------------------------------------------------------------

  Rule _ruleFromRow(QueryRow r) =>
      Rule.fromJson((jsonDecode(r.read<String>('json')) as Map).cast<String, Object?>())
          .copyWith(order: r.read<int>('sort_order'));

  /// Every rule, in order.
  Stream<List<Rule>> watchRules() => _select('SELECT * FROM rules ORDER BY sort_order, id', [], {
    _db.rules,
  }).watch().distinct(_rowsEqual).map((rows) => [for (final r in rows) _ruleFromRow(r)]);

  Future<List<Rule>> getRules() async => [
    for (final r in await _select('SELECT * FROM rules ORDER BY sort_order, id', [], {_db.rules}).get())
      _ruleFromRow(r),
  ];

  /// Stores [rule]: a new one goes last, an existing one keeps its place
  /// ([Rule.order] is ignored; see [reorderRules]).
  Future<void> saveRule(Rule rule) => _db.transaction(() async {
    final json = jsonEncode(rule.toJson()..remove('order'));
    final updated = await _write('UPDATE rules SET json = ? WHERE id = ?', [json, rule.id], {_db.rules});
    if (updated > 0) return;
    final last = await _select('SELECT coalesce(max(sort_order), -1) AS m FROM rules', [], {_db.rules}).getSingle();
    await _db
        .into(_db.rules)
        .insert(RulesCompanion.insert(id: rule.id, json: json, sortOrder: Value(last.read<int>('m') + 1)));
  });

  Future<void> deleteRule(String id) => (_db.delete(_db.rules)..where((r) => r.id.equals(id))).go();

  /// Puts the rules in the order of [ids]; rules not listed go after them.
  Future<void> reorderRules(List<String> ids) => _db.transaction(() async {
    final rest = [
      for (final r in await getRules())
        if (!ids.contains(r.id)) r.id,
    ];
    for (final (i, id) in [...ids, ...rest].indexed) {
      await _write('UPDATE rules SET sort_order = ? WHERE id = ? AND sort_order != ?', [i, id, i], {_db.rules});
    }
  });

  /// Where device rules stopped in [mailboxId]; null before they first ran.
  Future<RuleWatermark?> ruleWatermark(String mailboxId) async {
    final row = await (_db.select(_db.ruleWatermarks)..where((w) => w.mailboxId.equals(mailboxId))).getSingleOrNull();
    return row == null ? null : RuleWatermark(seq: row.seq, uidValidity: row.uidValidity, uid: row.uid);
  }

  /// Moves the watermark of [mailboxId] from [from] (null: none yet) to
  /// [to], unless another process moved it meanwhile. Returns whether it
  /// moved: whoever moves it handles the mail in between, once.
  Future<bool> advanceRuleWatermark(String mailboxId, {required RuleWatermark? from, required RuleWatermark to}) =>
      _db.transaction(() async {
        if (await ruleWatermark(mailboxId) != from) return false;
        await _db
            .into(_db.ruleWatermarks)
            .insertOnConflictUpdate(
              RuleWatermarksCompanion.insert(
                mailboxId: mailboxId,
                seq: to.seq,
                uidValidity: Value(to.uidValidity),
                uid: Value(to.uid),
              ),
            );
        return true;
      });

  /// Messages stored in [mailboxId] after [seq] (insertion order), oldest
  /// insertion first, with their seq.
  Future<List<(int, EmailSummary)>> emailsStoredAfter(String mailboxId, int seq) async {
    final rows =
        await (_db.select(_db.emails)
              ..where((e) => e.seq.isBiggerThanValue(seq) & e.mailboxId.equals(mailboxId))
              ..orderBy([(e) => OrderingTerm.asc(e.seq)]))
            .get();
    return [for (final r in rows) (r.seq, summaryFromRow(r))];
  }

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

  /// How often [email] wrote to the user (outside Junk and Trash) and the
  /// user to it. The address book remembers mail that was deleted since,
  /// but counts a sender once per sync batch, so the messages in the store
  /// are counted too and the larger number wins.
  Future<SenderHistory> senderHistory(String email) async {
    final e = email.trim().toLowerCase();
    if (e.isEmpty) return SenderHistory.none;
    final book = await _select(
      'SELECT seen_count, sent_count FROM address_book WHERE email = ?',
      [e],
      {_db.addressBook},
    ).getSingleOrNull();
    final stored = await _select(
      'SELECT count(DISTINCT coalesce(e.message_id_header, e.id)) AS n FROM emails e '
      'JOIN mailboxes m ON m.id = e.mailbox_id '
      "WHERE e.from_email = ? AND m.role NOT IN ('junk', 'trash', 'sent', 'drafts')",
      [e],
      {_db.emails, _db.mailboxes},
    ).getSingle();
    final seen = book?.read<int>('seen_count') ?? 0;
    final n = stored.read<int>('n');
    return SenderHistory(received: seen > n ? seen : n, sent: book?.read<int>('sent_count') ?? 0);
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

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

/// Summaries that show the same: equal ids, keywords and mailboxes are not
/// enough (`EmailSummary ==`), a subject decrypted since is a change too.
bool _summariesEqual(List<EmailSummary> a, List<EmailSummary> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i] || a[i].subject != b[i].subject) return false;
  }
  return true;
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
