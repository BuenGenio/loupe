import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:clock/clock.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';

import 'account_syncer.dart';
import 'config.dart';
import 'util.dart';

/// The real [MailRepository]: the local [MailStore] kept in sync with the
/// servers through [TransportFactory] transports.
///
/// Lifecycle: construct, then [start] (loads accounts, starts syncing and
/// sends overdue outbox messages). Call [pause] when the app goes to the
/// background and [resume] when it returns; [syncOnce] serves background
/// fetch tasks. [dispose] stops everything but leaves the store open.
final class LiveMailRepository implements MailRepository {
  LiveMailRepository(
    this.store,
    this.transports,
    this.credentials, {
    this.config = const SyncConfig(),
    this._clock,
    this.refreshOAuth,
  });

  final MailStore store;
  final TransportFactory transports;
  final CredentialStore credentials;
  final SyncConfig config;

  /// Refreshes OAuth tokens; null until OAuth sign-in exists.
  final OAuthRefresher? refreshOAuth;

  final Clock? _clock;
  late final _host = _Host(this);
  final _syncers = <String, AccountSyncer>{};
  final _statusById = <String, AccountSyncStatus>{};
  final _statuses = ValueStream<List<AccountSyncStatus>>(const []);
  final _errors = StreamController<MailException>.broadcast();
  final _refreshing = <String, Future<OAuthCredentials>>{};

  bool _started = false;
  bool _paused = false;
  bool _disposed = false;

  Timer? _outboxTimer;
  int _outboxGeneration = 0;
  bool _outboxBusy = false;
  bool _outboxAgain = false;

  Timer? _snoozeTimer;
  int _snoozeGeneration = 0;

  DateTime _now() => (_clock ?? clock).now();

  // Lifecycle ---------------------------------------------------------------

  /// Loads the stored accounts and starts syncing them; sends overdue outbox
  /// messages. Idempotent.
  Future<void> start() async {
    if (_started || _disposed) return;
    _started = true;
    await _loadAccounts();
    // A send interrupted by the app being killed is retried.
    for (final e in await store.outboxEntries()) {
      if (e.status == OutboxStatus.sending) {
        await store.updateOutbox(e.id, status: OutboxStatus.queued, attempts: e.attempts, lastError: e.lastError);
      }
    }
    if (!_paused) {
      for (final s in _syncers.values) {
        s.start();
      }
    }
    await _scheduleOutbox();
    await _scheduleSnoozeTimer();
  }

  Future<void> _loadAccounts() async {
    for (final a in await store.getAccounts()) {
      _syncers[a.id] ??= AccountSyncer(_host, a);
    }
    _publishStatuses();
  }

  /// Stops polling and IDLE and closes connections (app in background).
  /// Queued sends still go out when due.
  Future<void> pause() async {
    _paused = true;
    // Background wake-ups (syncOnce) wake snoozed messages meanwhile.
    _snoozeTimer?.cancel();
    _snoozeTimer = null;
    await Future.wait([for (final s in _syncers.values) s.pause()]);
  }

  /// Restarts polling and IDLE and syncs at once.
  Future<void> resume() async {
    if (_disposed) return;
    _paused = false;
    for (final s in _syncers.values) {
      s.start();
    }
    await _scheduleOutbox();
    await _scheduleSnoozeTimer();
  }

  /// One full sync of every account plus due sends and queued operations,
  /// for background fetch (WorkManager, BGAppRefreshTask). Works without
  /// [start]; closes connections afterwards unless the repository is running.
  Future<void> syncOnce() async {
    if (_disposed) return;
    await _loadAccounts();
    await Future.wait([for (final s in _syncers.values) s.syncAll()]);
    await _processOutbox();
    await Future.wait([for (final s in _syncers.values) s.flushOps()]);
    if (!_started || _paused) await Future.wait([for (final s in _syncers.values) s.pause()]);
  }

  /// Stops all syncing. The store stays open (the app owns it).
  Future<void> dispose() async {
    _disposed = true;
    _outboxTimer?.cancel();
    _snoozeTimer?.cancel();
    await Future.wait([for (final s in _syncers.values) s.dispose()]);
    _syncers.clear();
    await _statuses.close();
    await _errors.close();
  }

  /// Failures of background work the user started: operations reverted
  /// after repeated failures, sends that failed (and will be retried).
  Stream<MailException> get errors => _errors.stream;

  void _reportError(MailException e) {
    if (!_errors.isClosed) _errors.add(e);
  }

  void _reportStatus(AccountSyncStatus s) {
    if (_disposed || !_syncers.containsKey(s.accountId)) return;
    _statusById[s.accountId] = s;
    _publishStatuses();
  }

  void _publishStatuses() {
    if (_disposed) return;
    _statuses.value = [for (final s in _syncers.values) _statusById[s.account.id] ?? s.status];
  }

  AccountSyncer _syncerFor(String accountId) =>
      _syncers[accountId] ?? (throw const MailException(MailErrorKind.notFound, 'This account no longer exists'));

  // Credentials -------------------------------------------------------------

  CredentialsCallback _credentialsFor(MailAccount account) => ({bool forceRefresh = false}) async {
    final c = await credentials.read(account.id);
    if (c == null) {
      throw const MailException(MailErrorKind.authentication, 'The password is missing. Sign in again.');
    }
    return _maybeRefresh(account, c, forceRefresh: forceRefresh, persist: true);
  };

  Future<Credentials> _maybeRefresh(
    MailAccount account,
    Credentials c, {
    required bool forceRefresh,
    required bool persist,
  }) {
    final refresh = refreshOAuth;
    if (c is! OAuthCredentials || refresh == null) return Future.value(c);
    final expiring = !c.expiresAt.isAfter(_now().add(const Duration(minutes: 1)));
    if (!forceRefresh && !expiring) return Future.value(c);
    return _refreshing[account.id] ??= () async {
      try {
        final fresh = await refresh(account, c);
        if (persist) await credentials.write(account.id, fresh);
        return fresh;
      } finally {
        // ignore: unawaited_futures
        _refreshing.remove(account.id);
      }
    }();
  }

  // Accounts ----------------------------------------------------------------

  @override
  Stream<List<MailAccount>> watchAccounts() => store.watchAccounts();

  @override
  Future<AccountDiscovery> discover(String email) => transports.discover(email);

  @override
  Future<MailAccount> addAccount(AccountSetup setup) async {
    final existing = await store.getAccounts();
    final id = newId();
    final account = MailAccount(
      id: id,
      email: setup.email.trim(),
      displayName: setup.displayName,
      provider: setup.provider,
      authKind: setup.credentials is OAuthCredentials ? AuthKind.oauth2 : AuthKind.password,
      incoming: setup.incoming,
      outgoing: setup.outgoing,
      identities: [Identity(id: '$id/default', email: setup.email.trim(), name: setup.senderName)],
      colorIndex: existing.length,
    );
    var current = setup.credentials;
    var persisted = false;
    Future<Credentials> provisional({bool forceRefresh = false}) async {
      if (persisted) return _credentialsFor(account)(forceRefresh: forceRefresh);
      current = await _maybeRefresh(account, current, forceRefresh: forceRefresh, persist: false);
      return current;
    }

    final transport = transports.createTransport(account, provisional);
    final List<RemoteMailbox> remote;
    try {
      await transport.connect();
      remote = await transport.listMailboxes();
    } catch (_) {
      try {
        await transport.disconnect();
      } catch (_) {
        // Never connected.
      }
      rethrow;
    }
    await credentials.write(id, current);
    persisted = true;
    await store.saveAccount(account);
    await store.replaceMailboxes(id, remote);
    final syncer = AccountSyncer(_host, account, connected: transport);
    _syncers[id] = syncer;
    _publishStatuses();
    if (!_paused && !_disposed) syncer.start();
    return account;
  }

  @override
  Future<void> updateAccount(MailAccount account) async {
    final old = await store.getAccount(account.id);
    await store.saveAccount(account);
    final syncer = _syncers[account.id];
    if (syncer == null) return;
    String servers(MailAccount a) => jsonEncode([a.incoming.toJson(), a.outgoing?.toJson()]);
    if (old != null && servers(old) != servers(account)) {
      await syncer.dispose();
      final fresh = AccountSyncer(_host, account);
      _syncers[account.id] = fresh;
      if (_started && !_paused && !_disposed) fresh.start();
    } else {
      syncer.updateAccount(account);
    }
  }

  @override
  Future<void> removeAccount(String accountId) async {
    final syncer = _syncers.remove(accountId);
    _statusById.remove(accountId);
    _publishStatuses();
    await syncer?.dispose();
    await store.deleteAccount(accountId);
    await credentials.delete(accountId);
  }

  // Mailboxes and lists -----------------------------------------------------

  @override
  Stream<List<Mailbox>> watchMailboxes({String? accountId}) => store.watchMailboxes(accountId: accountId);

  @override
  Future<void> setMailboxSubscribed(String mailboxId, {required bool subscribed}) async {
    final mailbox =
        await store.getMailbox(mailboxId) ??
        (throw const MailException(MailErrorKind.notFound, 'That folder no longer exists'));
    await store.transaction(() async {
      final previous = await store.setMailboxSubscribed(mailboxId, subscribed: subscribed);
      if (previous == null || previous == subscribed) return;
      await store.enqueueOp(mailbox.accountId, OpType.subscribe, {
        'mailboxId': mailboxId,
        'name': mailbox.name,
        'subscribed': subscribed,
        'previous': previous,
      }, now: _now());
    });
    _kick(mailbox.accountId);
  }

  @override
  Stream<Map<VirtualMailbox, int>> watchVirtualCounts() => store.watchVirtualCounts();

  @override
  Stream<List<ThreadSummary>> watchList(
    MailboxRef ref, {
    Set<QuickFilter> filters = const {},
    bool threaded = true,
    int limit = 200,
  }) {
    if (ref case RealMailboxRef(:final mailboxId)) {
      _syncers[MailIds.accountOf(mailboxId)]?.openMailbox(mailboxId);
    }
    return store.watchList(ref, filters: filters, threaded: threaded, limit: limit);
  }

  /// The mailbox of each account that a virtual mailbox draws from.
  Future<List<(AccountSyncer, String)>> _roleMailboxes(VirtualMailbox kind) async {
    final role = switch (kind) {
      VirtualMailbox.allDrafts => MailboxRole.drafts,
      VirtualMailbox.allSent => MailboxRole.sent,
      _ => MailboxRole.inbox,
    };
    return [
      for (final s in _syncers.values)
        if (await store.mailboxByRole(s.account.id, role) case final m?) (s, m.id),
    ];
  }

  @override
  Future<bool> loadOlder(MailboxRef ref) async {
    switch (ref) {
      case RealMailboxRef(:final mailboxId):
        final syncer = _syncers[MailIds.accountOf(mailboxId)];
        return syncer == null ? false : syncer.loadOlder(mailboxId);
      case VirtualMailboxRef(:final kind):
        final results = await Future.wait([for (final (s, id) in await _roleMailboxes(kind)) s.loadOlder(id)]);
        return results.any((r) => r);
    }
  }

  @override
  Future<void> refresh({MailboxRef? ref}) async {
    switch (ref) {
      case null:
        await Future.wait([for (final s in _syncers.values) s.syncAll()]);
      case RealMailboxRef(:final mailboxId):
        await _syncers[MailIds.accountOf(mailboxId)]?.syncMailboxes([mailboxId]);
      case VirtualMailboxRef(kind: VirtualMailbox.allInboxes || VirtualMailbox.allDrafts || VirtualMailbox.allSent):
        await Future.wait([
          for (final (s, id) in await _roleMailboxes(ref.kind)) s.syncMailboxes([id]),
        ]);
      case VirtualMailboxRef():
        await Future.wait([for (final s in _syncers.values) s.syncAll()]);
    }
  }

  @override
  Stream<List<AccountSyncStatus>> watchSyncStatus() => _statuses.stream;

  // Messages ----------------------------------------------------------------

  @override
  Stream<List<EmailSummary>> watchConversation(String emailId) => store.watchConversation(emailId);

  @override
  Future<EmailSummary?> getEmail(String emailId) => store.getEmail(emailId);

  Future<EmailSummary> _requireEmail(String emailId) async =>
      await store.getEmail(emailId) ??
      (throw const MailException(MailErrorKind.notFound, 'This message is no longer available'));

  @override
  Future<EmailContent> loadContent(String emailId) async {
    final email = await _requireEmail(emailId);
    final cached = await store.getContent(email.id);
    if (cached != null) return cached;
    if (isLocalEmailId(email.id)) return EmailContent(emailId: email.id, text: email.preview);
    final content = await _syncerFor(email.accountId).fetchContent(email.id);
    await store.putContent(content, now: _now());
    return content;
  }

  @override
  Future<Uint8List> loadAttachment(String emailId, String partId) async {
    final email = await _requireEmail(emailId);
    return _syncerFor(email.accountId).fetchAttachment(email.id, partId);
  }

  @override
  Future<Uint8List> loadRawSource(String emailId) async {
    final email = await _requireEmail(emailId);
    return _syncerFor(email.accountId).fetchRaw(email.id);
  }

  // Actions -----------------------------------------------------------------

  Future<List<String>> _resolveAll(List<String> ids) async => [for (final id in ids) await store.resolveId(id)];

  void _kick(String accountId) => _syncers[accountId]?.kickOps();

  @override
  Future<void> setKeywords(List<String> emailIds, {Set<String> add = const {}, Set<String> remove = const {}}) async {
    for (final MapEntry(key: accountId, value: ids) in groupByAccount(emailIds).entries) {
      await _setKeywordsWithin(accountId, await _resolveAll(ids), add: add, remove: remove);
    }
  }

  /// Changes keywords of resolved [ids] of one account and queues the change.
  Future<void> _setKeywordsWithin(
    String accountId,
    List<String> ids, {
    Set<String> add = const {},
    Set<String> remove = const {},
  }) async {
    final adds = add.map(Keywords.normalize).toSet();
    final removes = remove.map(Keywords.normalize).toSet();
    await store.transaction(() async {
      final previous = await store.updateKeywords(ids, add: adds, remove: removes);
      final changed = [
        for (final id in previous.keys)
          if (!isLocalEmailId(id)) id,
      ];
      if (changed.isEmpty) return;
      await store.enqueueOp(accountId, OpType.setKeywords, {
        'ids': changed,
        'add': adds.toList(),
        'remove': removes.toList(),
        'previous': {for (final id in changed) id: previous[id]!.toList()},
      }, now: _now());
    });
    _kick(accountId);
  }

  /// Moves resolved [ids] of one account and queues the move. Inside an
  /// outer transaction pass [kick] false and kick after it: a replay started
  /// in the transaction's zone would run inside it.
  Future<void> _moveWithin(String accountId, List<String> ids, String targetMailboxId, {bool kick = true}) async {
    await store.transaction(() async {
      final previous = await store.moveLocally(ids, targetMailboxId);
      final moved = [
        for (final id in previous.keys)
          if (!isLocalEmailId(id)) id,
      ];
      if (moved.isEmpty) return;
      await store.enqueueOp(accountId, OpType.move, {
        'ids': moved,
        'target': targetMailboxId,
        'previous': {for (final id in moved) id: previous[id]},
      }, now: _now());
    });
    if (kick) _kick(accountId);
  }

  Future<void> _deletePermanently(String accountId, List<String> ids) async {
    await store.transaction(() async {
      final gone = [
        for (final e in await store.deleteEmails(ids))
          if (!isLocalEmailId(e.id)) e,
      ];
      if (gone.isEmpty) return;
      await store.enqueueOp(accountId, OpType.delete, {
        'ids': [for (final e in gone) e.id],
        'previous': AccountSyncer.summariesJson(gone),
      }, now: _now());
    });
    _kick(accountId);
  }

  @override
  Future<void> move(List<String> emailIds, String targetMailboxId) async {
    final targetAccount = MailIds.accountOf(targetMailboxId);
    final groups = groupByAccount(emailIds);
    if (groups.keys.any((a) => a != targetAccount)) {
      throw const MailException(MailErrorKind.unsupported, 'Moving messages between accounts isn’t supported yet');
    }
    if (await store.getMailbox(targetMailboxId) == null) {
      throw const MailException(MailErrorKind.notFound, 'That folder no longer exists');
    }
    for (final MapEntry(key: accountId, value: ids) in groups.entries) {
      await _moveWithin(accountId, await _resolveAll(ids), targetMailboxId);
    }
  }

  /// Gmail archives by removing the Inbox label, i.e. moving to All Mail.
  Future<Mailbox?> _archiveMailbox(MailAccount account) async {
    if (account.provider == ProviderKind.gmail) {
      final all = await store.mailboxByRole(account.id, MailboxRole.all);
      if (all != null) return all;
      for (final path in const ['[Gmail]/All Mail', '[Google Mail]/All Mail']) {
        final m = await store.getMailbox(MailIds.mailbox(account.id, path));
        if (m != null) return m;
      }
    }
    return store.mailboxByRole(account.id, MailboxRole.archive);
  }

  @override
  Future<void> archive(List<String> emailIds) async {
    for (final MapEntry(key: accountId, value: ids) in groupByAccount(emailIds).entries) {
      final account = await store.getAccount(accountId);
      if (account == null) continue;
      final target = await _archiveMailbox(account);
      if (target == null) {
        throw MailException(MailErrorKind.notFound, '${account.displayName} has no Archive folder.');
      }
      await _moveWithin(accountId, await _resolveAll(ids), target.id);
    }
  }

  @override
  Future<void> trash(List<String> emailIds) async {
    for (final MapEntry(key: accountId, value: ids) in groupByAccount(emailIds).entries) {
      final trashBox = await store.mailboxByRole(accountId, MailboxRole.trash);
      final emails = await store.getEmails(await _resolveAll(ids));
      final inTrash = [
        for (final e in emails)
          if (e.mailboxId == trashBox?.id) e.id,
      ];
      final others = [
        for (final e in emails)
          if (e.mailboxId != trashBox?.id) e.id,
      ];
      if (others.isNotEmpty && trashBox == null) {
        throw const MailException(MailErrorKind.notFound, 'This account has no Trash folder.');
      }
      if (inTrash.isNotEmpty) await _deletePermanently(accountId, inTrash);
      if (others.isNotEmpty) await _moveWithin(accountId, others, trashBox!.id);
    }
  }

  @override
  Future<void> markJunk(List<String> emailIds, {required bool junk}) async {
    await setKeywords(
      emailIds,
      add: {junk ? Keywords.junk : Keywords.notJunk},
      remove: {junk ? Keywords.notJunk : Keywords.junk},
    );
    for (final MapEntry(key: accountId, value: ids) in groupByAccount(emailIds).entries) {
      final junkBox = await store.mailboxByRole(accountId, MailboxRole.junk);
      final emails = await store.getEmails(await _resolveAll(ids));
      if (junk) {
        if (junkBox == null) continue;
        await _moveWithin(accountId, [
          for (final e in emails)
            if (e.mailboxId != junkBox.id) e.id,
        ], junkBox.id);
      } else {
        final inbox = await store.mailboxByRole(accountId, MailboxRole.inbox);
        if (junkBox == null || inbox == null) continue;
        await _moveWithin(accountId, [
          for (final e in emails)
            if (e.mailboxId == junkBox.id) e.id,
        ], inbox.id);
      }
    }
  }

  // Snooze ------------------------------------------------------------------

  /// The account's snooze folder (`Snoozed` before `INBOX.Snoozed`), if any.
  Future<Mailbox?> _snoozeFolder(String accountId) async {
    final folders = (await store.getMailboxes(accountId: accountId)).where(Snooze.isFolder).toList()
      ..sort((a, b) => a.path.length.compareTo(b.path.length));
    return folders.firstOrNull;
  }

  /// The account's snooze folder; one is added locally, its creation queued
  /// for the server, when there is none yet.
  Future<Mailbox> _ensureSnoozeFolder(AccountSyncer syncer) async {
    final accountId = syncer.account.id;
    final existing = await _snoozeFolder(accountId);
    if (existing != null) return existing;
    const path = Snooze.folderName;
    final id = MailIds.mailbox(accountId, path);
    await store.transaction(() async {
      await syncer.addLocalMailbox(const RemoteMailbox(path: path, name: path));
      await store.enqueueOp(accountId, OpType.createMailbox, {
        'mailboxId': id,
        'path': path,
        'name': path,
      }, now: _now());
    });
    return await store.getMailbox(id) ??
        (throw const MailException(MailErrorKind.unknown, 'Couldn’t add the Snoozed folder'));
  }

  @override
  Future<SnoozeStorage> snooze(List<String> emailIds, DateTime until) async {
    final keyword = Snooze.keyword(until);
    var storage = SnoozeStorage.server;
    for (final MapEntry(key: accountId, value: ids) in groupByAccount(emailIds).entries) {
      final syncer = _syncerFor(accountId);
      final emails = await store.getEmails(await _resolveAll(ids));
      if (emails.isEmpty) continue;
      final folder = await _ensureSnoozeFolder(syncer);
      final resolved = [for (final e in emails) e.id];
      final stale = {for (final e in emails) ...Snooze.keywordsIn(e.keywords)}..remove(keyword);
      final away = [
        for (final e in emails)
          if (e.mailboxId != folder.id) e.id,
      ];
      if (syncer.storesKeywords) {
        // The time goes first, so the message never waits without one.
        await _setKeywordsWithin(accountId, resolved, add: {keyword}, remove: stale);
        await _forgetLocalSnoozes(accountId, resolved);
        if (away.isNotEmpty) await _moveWithin(accountId, away, folder.id);
        continue;
      }
      // The server can't keep the time: move it, and keep the time here.
      storage = SnoozeStorage.device;
      await store.transaction(() async {
        await store.updateKeywords(resolved, add: {keyword}, remove: stale);
        if (away.isNotEmpty) await _moveWithin(accountId, away, folder.id, kick: false);
        await _forgetLocalSnoozes(accountId, resolved);
        // After the move, so its ids follow the server's new ones.
        await store.enqueueOp(accountId, OpType.localSnooze, {
          'ids': [
            for (final id in resolved)
              if (!isLocalEmailId(id)) id,
          ],
          'until': until.toUtc().toIso8601String(),
        }, now: _now());
      });
      _kick(accountId);
    }
    await _scheduleSnoozeTimer();
    return storage;
  }

  @override
  Future<void> unsnooze(List<String> emailIds) async {
    for (final MapEntry(key: accountId, value: ids) in groupByAccount(emailIds).entries) {
      final emails = await store.getEmails(await _resolveAll(ids));
      if (emails.isNotEmpty) await _wake(_syncerFor(accountId), emails);
    }
    await _scheduleSnoozeTimer();
  }

  /// Brings snoozed [emails] of one account back to its Inbox: snooze
  /// keywords removed, unread and `$new`, in that order on the server.
  Future<void> _wake(AccountSyncer syncer, List<EmailSummary> emails) async {
    final accountId = syncer.account.id;
    final inbox =
        await store.mailboxByRole(accountId, MailboxRole.inbox) ??
        (throw const MailException(MailErrorKind.notFound, 'This account has no Inbox.'));
    final ids = [for (final e in emails) e.id];
    final stale = {for (final e in emails) ...Snooze.keywordsIn(e.keywords)};
    if (syncer.storesKeywords) {
      await _setKeywordsWithin(accountId, ids, add: {Keywords.newAgain}, remove: {Keywords.seen, ...stale});
    } else {
      // Only \Seen reaches a server without keywords; the rest is local.
      await store.updateKeywords(ids, add: {Keywords.newAgain}, remove: stale);
      await _setKeywordsWithin(accountId, ids, remove: {Keywords.seen});
    }
    await _forgetLocalSnoozes(accountId, ids);
    final away = [
      for (final e in emails)
        if (e.mailboxId != inbox.id) e.id,
    ];
    if (away.isNotEmpty) await _moveWithin(accountId, away, inbox.id);
  }

  /// Drops [ids] from the account's device-only snoozes.
  Future<void> _forgetLocalSnoozes(String accountId, List<String> ids) async {
    final gone = ids.toSet();
    for (final op in await store.pendingOps(accountId: accountId)) {
      if (op.type != OpType.localSnooze) continue;
      final kept = [
        for (final id in (op.payload['ids'] as List<Object?>? ?? const [])) ?(gone.contains(id) ? null : id),
      ];
      if (kept.isEmpty) {
        await store.deleteOp(op.id);
      } else if (kept.length != (op.payload['ids']! as List).length) {
        await store.updateOp(op.id, payload: {...op.payload, 'ids': kept}, attempts: op.attempts);
      }
    }
  }

  /// Wakes the account's messages whose time has come; after every full
  /// sync, so the Snoozed folder is up to date and a time another device
  /// changed counts.
  Future<void> _wakeDue(AccountSyncer syncer) async {
    final accountId = syncer.account.id;
    final folder = await _snoozeFolder(accountId);
    if (folder == null) return;
    final waiting = await store.emailIdsIn(folder.id);
    await _pruneLocalSnoozes(accountId, waiting.toSet());
    final now = _now();
    final due = [
      for (final e in await store.getEmails(waiting))
        if (e.snoozedUntil case final t? when !t.isAfter(now)) e,
    ];
    if (due.isNotEmpty) await _wake(syncer, due);
  }

  /// Drops device-only snoozes of messages that left the Snoozed folder
  /// (moved or deleted by hand, or woken by another device).
  Future<void> _pruneLocalSnoozes(String accountId, Set<String> waiting) async {
    final gone = <String>[];
    for (final op in await store.pendingOps(accountId: accountId)) {
      if (op.type != OpType.localSnooze) continue;
      for (final id in (op.payload['ids'] as List<Object?>? ?? const []).cast<String>()) {
        if (!waiting.contains(await store.resolveId(id))) gone.add(id);
      }
    }
    if (gone.isNotEmpty) await _forgetLocalSnoozes(accountId, gone);
  }

  @override
  Stream<List<EmailSummary>> watchSnoozed() => store.watchSnoozed().map((list) => [...list]..sort(Snooze.compare));

  /// While the app runs, wakes the next snoozed message on time instead of
  /// at the next poll.
  Future<void> _scheduleSnoozeTimer() async {
    if (_disposed) return;
    final generation = ++_snoozeGeneration;
    DateTime? next;
    for (final e in await store.watchSnoozed().first) {
      final t = e.snoozedUntil;
      if (t != null && (next == null || t.isBefore(next))) next = t;
    }
    if (generation != _snoozeGeneration || _disposed) return;
    _snoozeTimer?.cancel();
    _snoozeTimer = null;
    if (next == null || !_started || _paused) return;
    var delay = next.difference(_now());
    // Overdue but still waiting (its wake failed): try again in a while.
    if (delay <= Duration.zero) delay = const Duration(minutes: 1);
    _snoozeTimer = Timer(delay, () {
      _snoozeTimer = null;
      unawaited(_onSnoozeTimer());
    });
  }

  Future<void> _onSnoozeTimer() async {
    for (final syncer in [..._syncers.values]) {
      final folder = await _snoozeFolder(syncer.account.id);
      if (folder == null) continue;
      // Another device may have woken it or changed the time; never throws.
      await syncer.syncMailboxes([folder.id]);
      try {
        await _wakeDue(syncer);
      } on MailException catch (e) {
        _reportError(e);
      }
    }
    await _scheduleSnoozeTimer();
  }

  Future<void> _afterFullSync(AccountSyncer syncer) async {
    try {
      await _wakeDue(syncer);
    } on MailException catch (e) {
      // No Inbox to wake into: not a sync failure.
      _reportError(e);
    }
    unawaited(_scheduleSnoozeTimer());
  }

  // Search ------------------------------------------------------------------

  @override
  Stream<SearchResults> search(SearchRequest request) {
    final token = Object();
    var cancelled = false;
    final running = <AccountSyncer>{};
    late final StreamController<SearchResults> controller;
    controller = StreamController<SearchResults>(
      onListen: () => unawaited(_runSearch(request, token, controller, () => cancelled, running)),
      onCancel: () {
        cancelled = true;
        for (final s in running) {
          s.cancelSearch(token);
        }
      },
    );
    return controller.stream;
  }

  Future<void> _runSearch(
    SearchRequest request,
    Object token,
    StreamController<SearchResults> controller,
    bool Function() isCancelled,
    Set<AccountSyncer> running,
  ) async {
    try {
      final local = await store.search(request.expr, scope: request.scope, limit: request.limit);
      if (isCancelled()) return;
      final targets = request.includeServer ? await _searchTargets(request) : const <_SearchTarget>[];
      String key(EmailSummary e) => '${e.accountId}|${e.messageIdHeader ?? e.id}';
      final merged = <String, EmailSummary>{for (final e in local.reversed) key(e): e};
      final fromServer = <String>{};
      final pending = {for (final t in targets) t.syncer.account.id};
      final failed = <String>{};
      void emit() {
        if (isCancelled() || controller.isClosed) return;
        final items = merged.values.toList()..sort((a, b) => b.receivedAt.compareTo(a.receivedAt));
        final shown = items.take(request.limit).toList();
        controller.add(
          SearchResults(
            items: shown,
            pendingAccountIds: {...pending},
            failedAccountIds: {...failed},
            fromServerIds: {
              for (final e in shown)
                if (fromServer.contains(e.id)) e.id,
            },
          ),
        );
      }

      emit();
      await Future.wait([
        for (final t in targets)
          () async {
            final accountId = t.syncer.account.id;
            running.add(t.syncer);
            try {
              final result = await t.syncer.serverSearch(
                t.expr,
                token: token,
                isCancelled: isCancelled,
                mailbox: t.mailbox,
                limit: request.limit,
              );
              for (final e in result.hits) {
                if (t.filter != null && !t.filter!(e)) continue;
                final k = key(e);
                if (merged.containsKey(k)) continue;
                merged[k] = e;
                if (result.fromServer.contains(e.id)) fromServer.add(e.id);
              }
            } catch (_) {
              failed.add(accountId);
            } finally {
              running.remove(t.syncer);
              pending.remove(accountId);
            }
            emit();
          }(),
      ]);
    } catch (e) {
      if (!isCancelled() && !controller.isClosed) controller.addError(asMailException(e, 'Search failed'));
    } finally {
      if (!isCancelled() && !controller.isClosed) await controller.close();
    }
  }

  Future<List<_SearchTarget>> _searchTargets(SearchRequest request) async {
    switch (request.scope) {
      case AllMailboxesScope():
        return [for (final s in _syncers.values) _SearchTarget(s, request.expr)];
      case MailboxScope(ref: RealMailboxRef(:final mailboxId)):
        final s = _syncers[MailIds.accountOf(mailboxId)];
        final remote = await s?.remoteForId(mailboxId);
        return s == null || remote == null ? const [] : [_SearchTarget(s, request.expr, mailbox: remote)];
      case MailboxScope(ref: VirtualMailboxRef(:final kind)):
        switch (kind) {
          case VirtualMailbox.allInboxes || VirtualMailbox.allDrafts || VirtualMailbox.allSent:
            return [
              for (final (s, id) in await _roleMailboxes(kind))
                if (await s.remoteForId(id) case final remote?) _SearchTarget(s, request.expr, mailbox: remote),
            ];
          case VirtualMailbox.unread:
            final expr = SearchAnd([request.expr, const SearchNot(KeywordTerm(Keywords.seen))]);
            return [for (final s in _syncers.values) _SearchTarget(s, expr)];
          case VirtualMailbox.flagged:
            final expr = SearchAnd([request.expr, const KeywordTerm(Keywords.flagged)]);
            return [for (final s in _syncers.values) _SearchTarget(s, expr)];
          case VirtualMailbox.vip:
            final vips = await store.watchVipAddresses().first;
            bool isVip(EmailSummary e) => e.from.any((a) => vips.contains(a.email.toLowerCase()));
            return [for (final s in _syncers.values) _SearchTarget(s, request.expr, filter: isVip)];
        }
    }
  }

  // Sending -----------------------------------------------------------------

  @override
  Future<String> send(
    OutgoingMessage message, {
    Duration undoDelay = const Duration(seconds: 10),
    DateTime? sendAt,
  }) async {
    if (await store.getAccount(message.accountId) == null) {
      throw const MailException(MailErrorKind.notFound, 'This account no longer exists');
    }
    final id = newId();
    final now = _now();
    var queued = message;
    final draft = message.draftId;
    if (sendAt != null && draft != null) {
      // A scheduled message lives in the outbox, not in Drafts.
      queued = message.withoutDraft();
      try {
        await deleteDraft(draft);
      } on MailException {
        // Gone already.
      }
    }
    await store.putOutbox(
      OutboxEntry(
        id: id,
        accountId: message.accountId,
        message: queued,
        sendAfter: sendAt ?? now.add(undoDelay),
        createdAt: now,
        status: sendAt == null ? OutboxStatus.queued : OutboxStatus.scheduled,
      ),
    );
    await _scheduleOutbox();
    return id;
  }

  @override
  Stream<List<OutboxItem>> watchOutbox() => store.watchOutbox().map(
    (entries) => [
      for (final e in entries)
        OutboxItem(id: e.id, message: e.message, sendAt: e.sendAfter, status: e.status, error: e.lastError),
    ],
  );

  @override
  Future<OutgoingMessage?> cancelSend(String outboxId) async {
    final entry = await store.takeOutbox(outboxId);
    if (entry != null) await _scheduleOutbox();
    return entry?.message;
  }

  @override
  Future<void> sendNow(String outboxId) async {
    final moved = await store.rescheduleOutbox(outboxId, sendAfter: _now(), status: OutboxStatus.queued);
    if (!moved && await store.getOutbox(outboxId) == null) {
      throw const MailException(MailErrorKind.notFound, 'This message was already sent.');
    }
    await _scheduleOutbox();
  }

  @override
  Future<void> rescheduleSend(String outboxId, DateTime sendAt) async {
    if (!await store.rescheduleOutbox(outboxId, sendAfter: sendAt, status: OutboxStatus.scheduled)) {
      throw await store.getOutbox(outboxId) == null
          ? const MailException(MailErrorKind.notFound, 'This message was already sent.')
          : const MailException(MailErrorKind.unsupported, 'This message is being sent right now.');
    }
    await _scheduleOutbox();
  }

  Future<void> _scheduleOutbox() async {
    if (_disposed) return;
    final generation = ++_outboxGeneration;
    final due = [
      for (final e in await store.outboxEntries())
        if (e.status != OutboxStatus.sending) e.sendAfter,
    ];
    if (generation != _outboxGeneration || _disposed) return;
    _outboxTimer?.cancel();
    _outboxTimer = null;
    if (due.isEmpty) return;
    final next = due.reduce((a, b) => a.isBefore(b) ? a : b);
    final delay = next.difference(_now());
    _outboxTimer = Timer(delay.isNegative ? Duration.zero : delay, () {
      _outboxTimer = null;
      unawaited(_processOutbox());
    });
  }

  Future<void> _processOutbox() async {
    if (_disposed) return;
    if (_outboxBusy) {
      _outboxAgain = true;
      return;
    }
    _outboxBusy = true;
    try {
      do {
        _outboxAgain = false;
        final now = _now();
        for (final e in await store.outboxEntries()) {
          if (e.status == OutboxStatus.sending || e.sendAfter.isAfter(now)) continue;
          final claimed = await store.claimOutbox(e.id);
          if (claimed != null) await _sendOne(claimed);
        }
      } while (_outboxAgain && !_disposed);
    } finally {
      _outboxBusy = false;
    }
    await _scheduleOutbox();
  }

  Future<void> _sendOne(OutboxEntry entry) async {
    final m = entry.message;
    try {
      final account =
          await store.getAccount(entry.accountId) ??
          (throw const MailException(MailErrorKind.notFound, 'This account no longer exists'));
      final identity = account.identities.where((i) => i.id == m.identityId).firstOrNull ?? account.defaultIdentity;
      final bytes = transports.composer.compose(m, identity, messageId: newMessageId(identity.email), date: _now());
      final recipients = {
        for (final a in [...m.to, ...m.cc, ...m.bcc]) a.email,
      }.toList();
      final sender = transports.createSender(account, _credentialsFor(account));
      try {
        await sender.send(bytes, envelopeFrom: identity.email, recipients: recipients);
      } finally {
        try {
          await sender.close();
        } catch (_) {
          // The message went out; a failed QUIT doesn't matter.
        }
      }
      await _afterSend(account, entry, bytes);
    } catch (error) {
      final e = asMailException(error, 'Sending failed');
      final attempts = entry.attempts + 1;
      await store.updateOutbox(
        entry.id,
        status: OutboxStatus.failed,
        attempts: attempts,
        lastError: e.message,
        sendAfter: _now().add(backoff(config.sendRetryBase, config.sendRetryMax, attempts - 1)),
      );
      _reportError(MailException(e.kind, 'Couldn’t send a message: ${e.message}. It stays in the Outbox.', e));
    }
  }

  Future<void> _afterSend(MailAccount account, OutboxEntry entry, Uint8List bytes) async {
    final m = entry.message;
    final now = _now();
    final sent = await store.mailboxByRole(account.id, MailboxRole.sent);
    await store.transaction(() async {
      await store.deleteOutbox(entry.id);
      // Gmail files sent mail itself.
      if (account.provider != ProviderKind.gmail && sent != null) {
        await store.enqueueOp(account.id, OpType.append, {
          'mailboxId': sent.id,
          'data': base64Encode(bytes),
          'keywords': [Keywords.seen],
          'kind': 'sent',
        }, now: now);
      }
    });
    await store.recordAddresses([...m.to, ...m.cc, ...m.bcc], sent: true, now: now);
    final source = m.sourceEmailId;
    final flag = switch (m.mode) {
      ComposeMode.reply || ComposeMode.replyAll => Keywords.answered,
      ComposeMode.forward => Keywords.forwarded,
      _ => null,
    };
    if (source != null && flag != null) await setKeywords([source], add: {flag});
    final draft = m.draftId;
    if (draft != null) {
      try {
        await deleteDraft(draft);
      } catch (_) {
        // The draft may be gone already.
      }
    }
    final syncer = _syncers[account.id];
    syncer?.kickOps();
    if (account.provider == ProviderKind.gmail && sent != null) unawaited(syncer?.syncMailboxes([sent.id]));
  }

  // Drafts ------------------------------------------------------------------

  @override
  Future<String> saveDraft(OutgoingMessage message) async {
    final account =
        await store.getAccount(message.accountId) ??
        (throw const MailException(MailErrorKind.notFound, 'This account no longer exists'));
    final drafts =
        await store.mailboxByRole(account.id, MailboxRole.drafts) ??
        (throw const MailException(MailErrorKind.notFound, 'This account has no Drafts folder.'));
    final identity = account.identities.where((i) => i.id == message.identityId).firstOrNull ?? account.defaultIdentity;
    final messageId = newMessageId(identity.email);
    final now = _now();
    final bytes = transports.composer.compose(message, identity, messageId: messageId, date: now);
    final syncer = _syncerFor(account.id);
    const keywords = {Keywords.draft, Keywords.seen};
    String id;
    try {
      final remote =
          await syncer.remoteForId(drafts.id) ??
          (throw const MailException(MailErrorKind.notFound, 'This account has no Drafts folder.'));
      final appended = await syncer.onMain((t) => t.append(remote, bytes, keywords: keywords), priority: true);
      await syncer.syncMailboxes([drafts.id]);
      id =
          appended ??
          (await store.findByMessageId(account.id, messageId, mailboxId: drafts.id))?.id ??
          await _draftPlaceholder(account, drafts, identity, message, messageId, bytes, queue: false);
    } on MailException catch (e) {
      if (e.kind != MailErrorKind.connection) rethrow;
      // Offline: keep the draft here and upload it when back online.
      id = await _draftPlaceholder(account, drafts, identity, message, messageId, bytes, queue: true);
    }
    final previous = message.draftId;
    if (previous != null && await store.resolveId(previous) != id) await deleteDraft(previous);
    return id;
  }

  Future<String> _draftPlaceholder(
    MailAccount account,
    Mailbox drafts,
    Identity identity,
    OutgoingMessage message,
    String messageId,
    Uint8List bytes, {
    required bool queue,
  }) async {
    final id = localEmailId(account.id);
    final now = _now();
    final text = message.text.replaceAll(RegExp(r'\s+'), ' ').trim();
    await store.transaction(() async {
      await store.insertEmails([
        EmailSummary(
          id: id,
          accountId: account.id,
          mailboxId: drafts.id,
          receivedAt: now,
          sentAt: now,
          messageIdHeader: messageId,
          inReplyTo: message.inReplyTo,
          references: message.references,
          from: [EmailAddress(identity.email, identity.name)],
          to: message.to,
          cc: message.cc,
          bcc: message.bcc,
          subject: message.subject,
          preview: text.length > 256 ? text.substring(0, 256) : text,
          size: bytes.length,
          keywords: const {Keywords.draft, Keywords.seen},
          hasAttachment: message.attachments.isNotEmpty,
        ),
      ]);
      await store.putContent(
        EmailContent(emailId: id, text: message.text, html: message.html),
        now: now,
      );
      if (queue) {
        await store.enqueueOp(account.id, OpType.append, {
          'mailboxId': drafts.id,
          'data': base64Encode(bytes),
          'keywords': [Keywords.draft, Keywords.seen],
          'placeholderId': id,
          'kind': 'draft',
        }, now: now);
      }
    });
    if (queue) _kick(account.id);
    return id;
  }

  @override
  Future<void> deleteDraft(String draftEmailId) async {
    final id = await store.resolveId(draftEmailId);
    final accountId = MailIds.accountOf(id);
    if (isLocalEmailId(id)) {
      await store.transaction(() async {
        await store.deleteEmails([id]);
        for (final op in await store.pendingOps(accountId: accountId)) {
          if (op.type == OpType.append && op.payload['placeholderId'] == id) await store.deleteOp(op.id);
        }
      });
      return;
    }
    await _deletePermanently(accountId, [id]);
  }

  // People ------------------------------------------------------------------

  @override
  Future<List<EmailAddress>> suggestAddresses(String prefix, {int limit = 8}) =>
      store.suggestAddresses(prefix, limit: limit);

  @override
  Stream<Set<String>> watchVipAddresses() => store.watchVipAddresses();

  @override
  Future<void> setVip(String email, {required bool vip}) => store.setVip(email, vip: vip);
}

final class _SearchTarget {
  const _SearchTarget(this.syncer, this.expr, {this.mailbox, this.filter});
  final AccountSyncer syncer;
  final SearchExpr expr;
  final RemoteMailbox? mailbox;
  final bool Function(EmailSummary)? filter;
}

final class _Host implements SyncHost {
  _Host(this._repo);
  final LiveMailRepository _repo;

  @override
  MailStore get store => _repo.store;
  @override
  TransportFactory get transports => _repo.transports;
  @override
  SyncConfig get config => _repo.config;
  @override
  DateTime now() => _repo._now();
  @override
  CredentialsCallback credentialsFor(MailAccount account) => _repo._credentialsFor(account);
  @override
  void reportStatus(AccountSyncStatus status) => _repo._reportStatus(status);
  @override
  void reportError(MailException error) => _repo._reportError(error);
  @override
  Future<void> wakeSnoozed(AccountSyncer syncer) => _repo._afterFullSync(syncer);
}
