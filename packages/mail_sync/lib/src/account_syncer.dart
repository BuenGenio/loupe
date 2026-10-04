import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';

import 'config.dart';
import 'summary_json.dart';
import 'util.dart';

/// What an [AccountSyncer] needs from the repository that owns it.
abstract interface class SyncHost {
  MailStore get store;
  TransportFactory get transports;
  SyncConfig get config;
  DateTime now();
  CredentialsCallback credentialsFor(MailAccount account);
  void reportStatus(AccountSyncStatus status);
  void reportError(MailException error);

  /// The Inbox [inboxId] of [account] was just synced (device rules run).
  Future<void> inboxSynced(MailAccount account, String inboxId);

  /// Called after each full sync of [syncer]'s account (its Snoozed folder
  /// is fresh then): wakes the messages whose snooze is over.
  Future<void> wakeSnoozed(AccountSyncer syncer);
}

/// Types of queued server operations.
abstract final class OpType {
  /// `{ids, add, remove, previous: {id: [keywords]}}`
  static const setKeywords = 'setKeywords';

  /// `{ids, target, previous: {id: mailboxId}}`
  static const move = 'move';

  /// `{ids, previous: [summary json]}`
  static const delete = 'delete';

  /// `{mailboxId, data (base64), keywords, placeholderId?, kind}`
  static const append = 'append';

  /// `{mailboxId, name, subscribed, previous}`
  static const subscribe = 'subscribe';

  /// `{mailboxId, path, name}`: creates a folder (the Snoozed folder).
  static const createMailbox = 'createMailbox';

  /// `{ids, until}`: a snooze kept on this device only, because the server
  /// doesn't store keywords. Never sent; it waits here until the message
  /// wakes, its ids follow moves like any later operation's, and syncs keep
  /// its `$snoozed-…` keyword on the local copy.
  static const localSnooze = 'localSnooze';
}

/// One server search's hits (post-filtered) and the ids that were not
/// stored locally before.
typedef ServerHits = ({List<EmailSummary> hits, Set<String> fromServer});

/// Keeps one account in sync. Owns three transports: the main one (sync,
/// operations, content; calls are serialised), one for searches (dropped to
/// cancel), and one holding IDLE on the Inbox.
final class AccountSyncer {
  AccountSyncer(this._host, MailAccount account, {MailTransport? connected})
    : _account = account,
      main = connected ?? _host.transports.createTransport(account, _host.credentialsFor(account));

  final SyncHost _host;
  MailAccount _account;

  /// The main transport (sync, operations, content).
  final MailTransport main;
  late final MailTransport _search = _host.transports.createTransport(_account, _host.credentialsFor(_account));
  late final MailTransport _idle = _host.transports.createTransport(_account, _host.credentialsFor(_account));
  bool _searchCreated = false;
  bool _idleCreated = false;

  final _mainQueue = SerialQueue();
  final _searchQueue = SerialQueue();
  final _remote = <String, RemoteMailbox>{};

  /// Mailboxes the user opened; kept in sync with the priority ones.
  final _active = <String>{};

  /// Mailboxes to sync after operations changed them.
  final _dirty = <String>{};

  /// What the Inbox and the Snoozed folder said about keywords when last
  /// synced (PERMANENTFLAGS); see [storesKeywords].
  bool? _inboxKeywords;
  bool? _snoozeKeywords;

  bool _running = false;
  bool _disposed = false;
  int _failures = 0;
  DateTime? _lastSuccess;
  late AccountSyncStatus _status = AccountSyncStatus(accountId: _account.id, phase: SyncPhase.idle);

  Timer? _pollTimer;
  Timer? _reconnectTimer;
  Timer? _opsTimer;
  Timer? _idleDebounce;
  StreamSubscription<void>? _idleSub;
  bool _idleStarting = false;

  Future<void>? _fullSync;
  Future<void>? _queuedSync;
  Future<void>? _replay;
  Object? _runningSearch;

  MailAccount get account => _account;
  AccountSyncStatus get status => _status;

  /// Whether the server keeps snooze keywords: what the Snoozed folder, or
  /// else the Inbox, last said. Assumed until a sync says otherwise.
  bool get storesKeywords => _snoozeKeywords ?? _inboxKeywords ?? true;
  MailStore get _store => _host.store;
  SyncConfig get _config => _host.config;

  // Lifecycle ---------------------------------------------------------------

  /// Starts polling, IDLE and an immediate full sync.
  void start() {
    if (_disposed || _running) return;
    _running = true;
    _pollTimer = Timer.periodic(_config.pollInterval, (_) => unawaited(syncAll()));
    unawaited(syncAll());
  }

  /// Stops timers and IDLE and closes the connections (app in background).
  /// Queued operations stay queued.
  Future<void> pause() async {
    _running = false;
    _pollTimer?.cancel();
    _reconnectTimer?.cancel();
    _opsTimer?.cancel();
    _idleDebounce?.cancel();
    _pollTimer = _reconnectTimer = _opsTimer = _idleDebounce = null;
    await _stopIdle();
    if (_searchCreated) await _quietDisconnect(_search);
    await _mainQueue.run(() => _quietDisconnect(main));
  }

  Future<void> dispose() async {
    _disposed = true;
    await pause();
  }

  void updateAccount(MailAccount account) => _account = account;

  // Status ------------------------------------------------------------------

  void _setStatus(SyncPhase phase, {String? error}) {
    _status = AccountSyncStatus(accountId: _account.id, phase: phase, lastSuccess: _lastSuccess, error: error);
    _host.reportStatus(_status);
  }

  void _handleFailure(Object error) {
    final e = asMailException(error, 'Sync failed');
    if (e.kind == MailErrorKind.connection) {
      _setStatus(SyncPhase.offline, error: e.message);
    } else {
      _setStatus(SyncPhase.error, error: e.message);
    }
    // A rejected password won't fix itself; the poll timer retries it.
    if (e.kind != MailErrorKind.authentication) _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (!_running || _disposed || _reconnectTimer != null) return;
    final delay = backoff(_config.reconnectBase, _config.reconnectMax, _failures++);
    _reconnectTimer = Timer(delay, () {
      _reconnectTimer = null;
      unawaited(syncAll());
    });
  }

  // Connections -------------------------------------------------------------

  static Future<void> _quietDisconnect(MailTransport t) async {
    try {
      if (t.isConnected) await t.disconnect();
    } catch (_) {
      // Already gone.
    }
  }

  Future<T> _withConnection<T>(MailTransport t, Future<T> Function(MailTransport t) op) async {
    // A disposed syncer never connects again; what was queued fails instead.
    if (_disposed) throw const MailException(MailErrorKind.cancelled, 'Sync stopped');
    try {
      if (!t.isConnected) await t.connect();
      return await op(t);
    } on MailException catch (e) {
      if (e.kind == MailErrorKind.connection) await _quietDisconnect(t);
      rethrow;
    }
  }

  /// Runs [op] on the main transport, serialised with everything else.
  Future<T> onMain<T>(Future<T> Function(MailTransport t) op, {bool priority = false}) =>
      _mainQueue.run(() => _withConnection(main, op), priority: priority);

  RemoteMailbox _remoteFor(Mailbox m) =>
      _remote[m.id] ??
      RemoteMailbox(
        path: m.path,
        name: m.name,
        role: m.role,
        parentPath: m.parentId == null ? null : MailIds.parseMailbox(m.parentId!).$2,
        isSelectable: m.isSelectable,
        isSubscribed: m.isSubscribed,
      );

  Future<RemoteMailbox?> remoteForId(String mailboxId) async {
    final cached = _remote[mailboxId];
    if (cached != null) return cached;
    final m = await _store.getMailbox(mailboxId);
    return m == null ? null : _remoteFor(m);
  }

  // Sync --------------------------------------------------------------------

  /// Lists mailboxes, replays queued operations and syncs the priority and
  /// opened mailboxes. Never throws; failures go to the status. Calls while a
  /// sync runs coalesce into one follow-up sync.
  Future<void> syncAll() {
    if (_disposed) return Future.value();
    final running = _fullSync;
    if (running != null) {
      return _queuedSync ??= running.then((_) {
        _queuedSync = null;
        return syncAll();
      });
    }
    final f = _doFullSync();
    _fullSync = f;
    return f.whenComplete(() {
      if (identical(_fullSync, f)) _fullSync = null;
    });
  }

  Future<void> _doFullSync() async {
    final firstSync = _lastSuccess == null;
    _setStatus(SyncPhase.syncing);
    try {
      final remote = await _withPendingSubscriptions(await onMain((t) => t.listMailboxes()));
      await _store.replaceMailboxes(_account.id, remote);
      _remote
        ..clear()
        ..addAll({for (final m in remote) MailIds.mailbox(_account.id, m.path): m});
      await _replayOps();
      _dirty.clear();
      for (final m in await _mailboxesForFullSync()) {
        if (_disposed) return;
        await onMain((t) => _syncMailbox(t, m));
        if (m.role == MailboxRole.inbox) await _inboxSynced(m);
      }
      // Later syncs also fill in a few never-opened mailboxes.
      if (!firstSync) {
        final pending = await _store.unsyncedMailboxIds(_account.id);
        for (final id in pending.take(_config.backgroundMailboxesPerSync)) {
          if (_disposed) return;
          final m = await _store.getMailbox(id);
          if (m != null) await onMain((t) => _syncMailbox(t, m));
        }
      }
      await _host.wakeSnoozed(this);
      _failures = 0;
      _lastSuccess = _host.now();
      _setStatus(SyncPhase.idle);
      _ensureIdle();
    } catch (e) {
      _handleFailure(e);
    }
  }

  /// The server's mailbox list with still-queued subscription changes
  /// applied and folders still to be created added, so a sync doesn't undo
  /// them (or drop what was moved into them) before they reach the server.
  Future<List<RemoteMailbox>> _withPendingSubscriptions(List<RemoteMailbox> listedRemote) async {
    final ops = await _store.pendingOps(accountId: _account.id);
    final pending = <String, bool>{
      for (final op in ops)
        if (op.type == OpType.subscribe) op.payload['mailboxId']! as String: op.payload['subscribed']! as bool,
    };
    final listed = {for (final m in listedRemote) m.path};
    final remote = [
      ...listedRemote,
      for (final op in ops)
        if (op.type == OpType.createMailbox && !listed.contains(op.payload['path']))
          RemoteMailbox(path: op.payload['path']! as String, name: op.payload['name']! as String),
    ];
    if (pending.isEmpty) return remote;
    return [
      for (final m in remote)
        switch (pending[MailIds.mailbox(_account.id, m.path)]) {
          final subscribed? when subscribed != m.isSubscribed => RemoteMailbox(
            path: m.path,
            name: m.name,
            role: m.role,
            parentPath: m.parentPath,
            isSelectable: m.isSelectable,
            isSubscribed: subscribed,
          ),
          _ => m,
        },
    ];
  }

  /// Inbox first, then Sent, Drafts and Archive, then mailboxes opened in
  /// this session and those synced before that are still subscribed (or
  /// hold a role). Unsubscribed folders sync only while the user opens them.
  Future<List<Mailbox>> _mailboxesForFullSync() async {
    final all = [
      for (final m in await _store.getMailboxes(accountId: _account.id))
        if (m.isSelectable) m,
    ];
    Mailbox? byRole(MailboxRole r) => all.where((m) => m.role == r).firstOrNull;
    final ordered = <Mailbox>[];
    void add(Mailbox? m) {
      if (m != null && !ordered.contains(m)) ordered.add(m);
    }

    add(byRole(MailboxRole.inbox));
    add(byRole(MailboxRole.sent));
    add(byRole(MailboxRole.drafts));
    add(byRole(MailboxRole.archive) ?? (_account.provider == ProviderKind.gmail ? byRole(MailboxRole.all) : null));
    // Snoozed messages must wake on time, subscribed or not.
    add(all.where(Snooze.isFolder).firstOrNull);
    for (final m in all) {
      final background = m.isSubscribed || m.role != MailboxRole.none;
      if (_active.contains(m.id) || (background && await _store.getSyncInfo(m.id) != null)) add(m);
    }
    return ordered;
  }

  /// Syncs specific mailboxes now (pull to refresh, IDLE, opening a mailbox).
  Future<void> syncMailboxes(Iterable<String> mailboxIds) async {
    if (_disposed) return;
    final ids = mailboxIds.toSet();
    if (ids.isEmpty) return;
    try {
      await _replayOps();
      for (final id in ids) {
        final m = await _store.getMailbox(id);
        if (m == null || !m.isSelectable) continue;
        await onMain((t) => _syncMailbox(t, m));
        if (m.role == MailboxRole.inbox) await _inboxSynced(m);
      }
      _failures = 0;
      _lastSuccess = _host.now();
      if (_fullSync == null) _setStatus(SyncPhase.idle);
    } catch (e) {
      _handleFailure(e);
    }
  }

  /// Marks [mailboxId] as opened, syncing it at once if it never was.
  void openMailbox(String mailboxId) {
    if (_active.add(mailboxId)) {
      unawaited(() async {
        if (await _store.getSyncInfo(mailboxId) == null) await syncMailboxes([mailboxId]);
      }());
    }
  }

  Future<void> _syncMailbox(MailTransport t, Mailbox m) async {
    final info = await _store.getSyncInfo(m.id);
    final fetched = await t.syncMailbox(_remoteFor(m), info?.state, initialWindow: _config.initialWindow);
    _noteKeywordSupport(m, fetched.canStoreKeywords);
    final result = await _overlay(fetched);
    // One transaction: lists never show a muted thread's new mail unread.
    final readMuted = await _store.transaction(() async {
      await _store.applySync(m.id, result, now: _host.now());
      return _readMutedArrivals(result.added);
    });
    if (readMuted) kickOps();
    if (info != null && info.staleHeaders) unawaited(_refetchHeaders(m));
  }

  /// New mail of a muted conversation arrives read (like Thunderbird's
  /// ignored threads), here and on the server, so it never notifies.
  /// Returns whether an operation was queued.
  Future<bool> _readMutedArrivals(List<EmailSummary> added) async {
    if (added.isEmpty) return false;
    final ids = await _store.unreadInMutedThreads([for (final e in added) e.id]);
    if (ids.isEmpty) return false;
    final previous = await _store.updateKeywords(ids, add: {Keywords.seen});
    final changed = [
      for (final id in previous.keys)
        if (!isLocalEmailId(id)) id,
    ];
    if (changed.isEmpty) return false;
    await _store.enqueueOp(_account.id, OpType.setKeywords, {
      'ids': changed,
      'add': [Keywords.seen],
      'remove': <String>[],
      'previous': {for (final id in changed) id: previous[id]!.toList()},
    }, now: _host.now());
    return true;
  }

  /// Mailboxes whose headers are being fetched again.
  final _refetching = <String>{};

  /// Fetches the stored summaries of [m] again for the header fields they
  /// predate (see `MailboxSyncInfo.staleHeaders`), once per mailbox. Each
  /// batch is its own main-queue task, so user actions don't wait for all
  /// of them; a failure leaves the mailbox marked for the next sync.
  Future<void> _refetchHeaders(Mailbox m) async {
    if (!_refetching.add(m.id)) return;
    try {
      final ids = [
        for (final id in await _store.emailIdsIn(m.id))
          if (!isLocalEmailId(id)) id,
      ];
      for (var i = 0; i < ids.length; i += _headerBatch) {
        final chunk = ids.sublist(i, i + _headerBatch > ids.length ? ids.length : i + _headerBatch);
        await onMain((t) async => _store.fillHeaders(await t.fetchSummaries(chunk)));
      }
      await _store.markHeadersFresh(m.id);
    } catch (_) {
      // Offline or the mailbox is gone: the next sync tries again.
    } finally {
      _refetching.remove(m.id);
    }
  }

  /// Summaries per request when refetching headers.
  static const _headerBatch = 200;

  /// Lets device rules handle new Inbox mail (outside the main queue, so
  /// they can load content). Their failures never fail the sync.
  Future<void> _inboxSynced(Mailbox inbox) async {
    try {
      await _host.inboxSynced(_account, inbox.id);
    } catch (e) {
      _host.reportError(asMailException(e, 'Rules couldn’t run on new mail'));
    }
  }

  void _noteKeywordSupport(Mailbox m, bool? stores) {
    if (stores == null) return;
    if (Snooze.isFolder(m)) {
      _snoozeKeywords = stores;
    } else if (m.role == MailboxRole.inbox) {
      _inboxKeywords = stores;
    }
  }

  /// Adds [mailbox] to the local list before the server has it (a folder
  /// whose creation is queued).
  Future<void> addLocalMailbox(RemoteMailbox mailbox) async {
    final current = [for (final m in await _store.getMailboxes(accountId: _account.id)) _remoteFor(m)];
    if (current.any((m) => m.path == mailbox.path)) return;
    await _store.replaceMailboxes(_account.id, [...current, mailbox]);
  }

  /// Fetches the next page of older messages; returns whether more exist.
  Future<bool> loadOlder(String mailboxId) async {
    _active.add(mailboxId);
    final m = await _store.getMailbox(mailboxId);
    if (m == null || !m.isSelectable) return false;
    return onMain((t) async {
      final info = await _store.getSyncInfo(mailboxId);
      if (info == null) {
        await _syncMailbox(t, m);
        return (await _store.getSyncInfo(mailboxId))?.hasOlder ?? false;
      }
      if (!info.hasOlder) return false;
      final result = await t.fetchOlder(_remoteFor(m), info.state, count: _config.olderPageSize);
      await _store.applySync(mailboxId, await _overlay(result), now: _host.now());
      return result.hasOlder;
    }, priority: true);
  }

  /// Keeps optimistic state of still-queued operations over server data:
  /// messages moved or deleted locally stay hidden, keyword changes stay.
  Future<MailboxSyncResult> _overlay(MailboxSyncResult r) async {
    final ops = await _store.pendingOps(accountId: _account.id);
    if (ops.isEmpty) return r;
    final hidden = <String>{};
    final adds = <String, Set<String>>{};
    final removes = <String, Set<String>>{};
    for (final op in ops) {
      final ids = _ids(op);
      switch (op.type) {
        case OpType.move || OpType.delete:
          hidden.addAll(ids);
        case OpType.setKeywords:
          final add = _strings(op.payload['add']);
          final remove = _strings(op.payload['remove']);
          for (final id in ids) {
            adds[id] = {...(adds[id] ?? {}).difference(remove), ...add};
            removes[id] = {...(removes[id] ?? {}).difference(add), ...remove};
          }
        case OpType.localSnooze:
          final keyword = Snooze.keyword(DateTime.parse(op.payload['until']! as String));
          for (final id in ids) {
            adds[id] = {...?adds[id], keyword};
            removes[id] ??= {};
          }
      }
    }
    Set<String> apply(String id, Set<String> server) =>
        adds.containsKey(id) ? {...server.difference(removes[id]!), ...adds[id]!} : server;
    return MailboxSyncResult(
      state: r.state,
      added: [
        for (final e in r.added)
          if (!hidden.contains(e.id)) adds.containsKey(e.id) ? e.copyWith(keywords: apply(e.id, e.keywords)) : e,
      ],
      keywordUpdates: {for (final MapEntry(:key, :value) in r.keywordUpdates.entries) key: apply(key, value)},
      vanishedIds: r.vanishedIds,
      resetAll: r.resetAll,
      totalCount: r.totalCount,
      unreadCount: r.unreadCount,
      hasOlder: r.hasOlder,
    );
  }

  // IDLE --------------------------------------------------------------------

  void _ensureIdle() {
    if (!_running || !_config.useIdle || _idleSub != null || _idleStarting) return;
    if (!main.capabilities.supportsIdle) return;
    _idleStarting = true;
    unawaited(() async {
      try {
        final inbox = await _store.mailboxByRole(_account.id, MailboxRole.inbox);
        if (inbox == null || !_running) return;
        _idleCreated = true;
        if (!_idle.isConnected) await _idle.connect();
        if (!_running) {
          await _quietDisconnect(_idle);
          return;
        }
        _idleSub = _idle
            .watch(_remoteFor(inbox))
            .listen(
              (_) => _onIdleEvent(inbox.id),
              onError: (Object _) => _idleLost(),
              onDone: _idleLost,
              cancelOnError: true,
            );
      } catch (_) {
        _idleLost();
      } finally {
        _idleStarting = false;
      }
    }());
  }

  void _onIdleEvent(String inboxId) {
    _idleDebounce?.cancel();
    _idleDebounce = Timer(_config.idleDebounce, () {
      _idleDebounce = null;
      unawaited(syncMailboxes([inboxId]));
    });
  }

  void _idleLost() {
    _idleSub = null;
    if (_idleCreated) unawaited(_quietDisconnect(_idle));
    _scheduleReconnect();
  }

  Future<void> _stopIdle() async {
    final sub = _idleSub;
    _idleSub = null;
    // Not awaited: cancel() may return a root-zone future (stalls fake_async).
    unawaited(sub?.cancel());
    if (_idleCreated) await _quietDisconnect(_idle);
  }

  // Offline operations ------------------------------------------------------

  /// Replays queued operations soon (after an optimistic action).
  void kickOps() {
    if (_disposed) return;
    unawaited(() async {
      try {
        await _replayOps();
        final dirty = {..._dirty};
        _dirty.clear();
        final synced = <String>[
          for (final id in dirty)
            if (await _store.getSyncInfo(id) != null) id,
        ];
        if (synced.isNotEmpty) await syncMailboxes(synced);
      } catch (e) {
        _handleFailure(e);
      }
    }());
  }

  /// Replays due operations now (e.g. the Sent copy after a background
  /// send). Never throws; failures go to the status.
  Future<void> flushOps() async {
    try {
      await _replayOps();
    } catch (e) {
      _handleFailure(e);
    }
  }

  /// Replays due operations in order. Stops at the first one waiting for a
  /// retry; rethrows connection and authentication errors (offline).
  Future<void> _replayOps() => _replay ??= _doReplay().whenComplete(() => _replay = null);

  /// Queued operations for the server, oldest first.
  Future<List<PendingOp>> _serverOps() async => [
    for (final op in await _store.pendingOps(accountId: _account.id))
      if (op.type != OpType.localSnooze) op,
  ];

  Future<void> _doReplay() async {
    while (true) {
      final ops = await _serverOps();
      if (ops.isEmpty) return;
      final op = ops.first;
      final now = _host.now();
      if (op.nextAttemptAt.isAfter(now)) {
        _scheduleOps(op.nextAttemptAt.difference(now));
        return;
      }
      try {
        await onMain((t) => _execute(t, op), priority: true);
        await _store.deleteOp(op.id);
      } catch (error) {
        final e = asMailException(error, 'Unexpected error');
        // Offline, signed out or stopped: the operation waits, it didn't fail.
        if (e.kind == MailErrorKind.connection ||
            e.kind == MailErrorKind.authentication ||
            e.kind == MailErrorKind.cancelled) {
          rethrow;
        }
        if (!await _opFailed(op, e)) return;
      }
    }
  }

  void _scheduleOps(Duration delay) {
    if (!_running) return;
    _opsTimer?.cancel();
    _opsTimer = Timer(delay, () {
      _opsTimer = null;
      kickOps();
    });
  }

  /// Handles a failed operation. Returns true if replay can go on (the
  /// operation was dropped), false if it waits for a retry.
  Future<bool> _opFailed(PendingOp op, MailException e) async {
    if (e.kind == MailErrorKind.notFound) {
      // The server no longer has it: server wins.
      await _store.deleteOp(op.id);
      _dirty.addAll(_affectedMailboxes(op));
      return true;
    }
    final attempts = op.attempts + 1;
    final isDraft = op.type == OpType.append && op.payload['placeholderId'] != null;
    final permanent = !isDraft && (attempts >= _config.maxOpAttempts || e.kind == MailErrorKind.unsupported);
    if (permanent) {
      await _revert(op);
      await _store.deleteOp(op.id);
      _host.reportError(MailException(e.kind, '${_describe(op)}: ${e.message}', e));
      return true;
    }
    await _store.updateOp(
      op.id,
      attempts: attempts,
      nextAttemptAt: _host.now().add(backoff(_config.opRetryBase, _config.opRetryMax, attempts - 1)),
      lastError: e.message,
    );
    final next = await _serverOps();
    _scheduleOps(next.first.nextAttemptAt.difference(_host.now()));
    return false;
  }

  static String _describe(PendingOp op) {
    if (op.type == OpType.createMailbox) return 'Couldn’t create the folder “${op.payload['name']}”';
    if (op.type == OpType.subscribe) {
      final name = op.payload['name'] as String? ?? 'a folder';
      return op.payload['subscribed'] == true ? 'Couldn’t subscribe to “$name”' : 'Couldn’t unsubscribe from “$name”';
    }
    final n = _ids(op).length;
    final what = n == 1 ? 'a message' : '$n messages';
    return switch (op.type) {
      OpType.setKeywords => 'Couldn’t update $what',
      OpType.move => 'Couldn’t move $what',
      OpType.delete => 'Couldn’t delete $what',
      _ => op.payload['kind'] == 'sent' ? 'Couldn’t save a copy in Sent' : 'Couldn’t save the draft',
    };
  }

  static List<String> _ids(PendingOp op) => _strings(op.payload['ids']).toList();

  static Set<String> _strings(Object? json) => {for (final s in json as List<Object?>? ?? const []) s! as String};

  /// Mailboxes to sync after [op] failed or was reverted (none for
  /// subscription changes: the next mailbox list settles those).
  Set<String> _affectedMailboxes(PendingOp op) => op.type == OpType.subscribe
      ? const {}
      : {
          for (final id in _ids(op)) ?MailIds.mailboxOfImapEmail(id),
          if (op.payload['target'] case final String t) t,
          if (op.payload['mailboxId'] case final String m) m,
        };

  Future<void> _execute(MailTransport t, PendingOp op) async {
    final ids = [
      for (final id in _ids(op))
        if (!isLocalEmailId(id)) id,
    ];
    switch (op.type) {
      case OpType.setKeywords:
        if (ids.isEmpty) return;
        await t.setKeywords(ids, add: _strings(op.payload['add']), remove: _strings(op.payload['remove']));
      case OpType.move:
        final target = op.payload['target']! as String;
        if (ids.isEmpty) return;
        final remote = await remoteForId(target);
        // Permanent: the messages are still where they were, so revert.
        if (remote == null) throw const MailException(MailErrorKind.unsupported, 'The folder no longer exists');
        final mapping = await t.move(ids, remote);
        await _store.renameEmails(mapping);
        final unmapped = [
          for (final id in ids)
            if (!mapping.containsKey(id)) id,
        ];
        // Without new ids, the copies reappear when the target syncs.
        if (unmapped.isNotEmpty) await _store.deleteEmails(unmapped);
        await _remapLaterOps(op.id, {...mapping, for (final id in unmapped) id: null});
        _dirty.add(target);
      case OpType.delete:
        if (ids.isNotEmpty) await t.deletePermanently(ids);
      case OpType.append:
        final mailboxId = op.payload['mailboxId']! as String;
        final remote = await remoteForId(mailboxId);
        if (remote == null) throw const MailException(MailErrorKind.notFound, 'The folder no longer exists');
        final data = base64Decode(op.payload['data']! as String);
        final newId = await t.append(remote, data, keywords: _strings(op.payload['keywords']));
        final placeholder = op.payload['placeholderId'] as String?;
        if (placeholder != null) {
          if (newId != null) {
            await _store.renameEmails({placeholder: newId});
          } else {
            await _store.deleteEmails([placeholder]);
          }
          await _remapLaterOps(op.id, {placeholder: newId});
        }
        _dirty.add(mailboxId);
      case OpType.subscribe:
        final mailboxId = op.payload['mailboxId']! as String;
        final remote = await remoteForId(mailboxId);
        if (remote == null) throw const MailException(MailErrorKind.notFound, 'The folder no longer exists');
        await t.setSubscribed(remote, op.payload['subscribed']! as bool);
      case OpType.createMailbox:
        await t.createMailbox(op.payload['path']! as String);
    }
  }

  /// Rewrites ids in operations queued after [opId] (null drops the id).
  Future<void> _remapLaterOps(int opId, Map<String, String?> mapping) async {
    if (mapping.isEmpty) return;
    for (final op in await _store.pendingOps(accountId: _account.id)) {
      if (op.id <= opId) continue;
      final ids = _ids(op);
      if (!ids.any(mapping.containsKey)) continue;
      String? map(String id) => mapping.containsKey(id) ? mapping[id] : id;
      final payload = {
        ...op.payload,
        'ids': [for (final id in ids) ?map(id)],
      };
      final previous = op.payload['previous'];
      if (previous is Map) {
        payload['previous'] = {
          for (final MapEntry(:key, :value) in previous.entries)
            if (map(key as String) case final String k) k: value,
        };
      } else if (previous is List) {
        payload['previous'] = [
          for (final j in previous.cast<Map<String, Object?>>())
            if (map(j['id']! as String) case final String k) {...j, 'id': k},
        ];
      }
      await _store.updateOp(op.id, payload: payload, attempts: op.attempts, lastError: op.lastError);
    }
  }

  Future<void> _revert(PendingOp op) async {
    final previous = op.payload['previous'];
    switch (op.type) {
      case OpType.setKeywords when previous is Map:
        await _store.restoreKeywords({
          for (final MapEntry(:key, :value) in previous.entries) key as String: _strings(value),
        });
      case OpType.move when previous is Map:
        await _store.restoreMailboxes(previous.cast<String, String>());
      case OpType.delete when previous is List:
        await _store.restoreEmails([for (final j in previous.cast<Map<String, Object?>>()) summaryFromJson(j)]);
      case OpType.subscribe when previous is bool:
        await _store.setMailboxSubscribed(op.payload['mailboxId']! as String, subscribed: previous);
    }
    _dirty.addAll(_affectedMailboxes(op));
  }

  // Content -----------------------------------------------------------------

  Future<EmailContent> fetchContent(String emailId) => onMain((t) => t.fetchContent(emailId), priority: true);

  Future<Uint8List> fetchAttachment(String emailId, String partId) =>
      onMain((t) => t.fetchAttachment(emailId, partId), priority: true);

  Future<Uint8List> fetchRaw(String emailId) => onMain((t) => t.fetchRaw(emailId), priority: true);

  // Search ------------------------------------------------------------------

  /// Runs a server search on the search transport, stores summaries of hits
  /// not known locally and post-filters everything with `matchesEmail` (the
  /// server may return a superset). [token] identifies the search for
  /// [cancelSearch].
  Future<ServerHits> serverSearch(
    SearchExpr expr, {
    required Object token,
    required bool Function() isCancelled,
    RemoteMailbox? mailbox,
    int limit = 200,
  }) => _searchQueue.run(() async {
    const cancelled = MailException(MailErrorKind.cancelled, 'Search cancelled');
    if (isCancelled() || _disposed) throw cancelled;
    final label = '${_account.displayName} ${_account.email}';
    // Account terms resolve per account; a query that can't match here never
    // reaches this server.
    final bound = bindAccountTerms(expr, label);
    if (matchesNothing(bound)) return (hits: const <EmailSummary>[], fromServer: const <String>{});
    _runningSearch = token;
    _searchCreated = true;
    try {
      final ids = await _withConnection(
        _search,
        (t) => t.search(bound, mailbox: mailbox, limit: limit),
      ).timeout(_config.searchTimeout);
      if (isCancelled()) throw cancelled;
      final known = await _store.getEmails(ids);
      final knownIds = {for (final e in known) e.id};
      final unknown = [
        for (final id in ids)
          if (!knownIds.contains(id)) id,
      ];
      var fetched = const <EmailSummary>[];
      if (unknown.isNotEmpty) {
        fetched = await _withConnection(_search, (t) => t.fetchSummaries(unknown)).timeout(_config.searchTimeout);
        if (isCancelled()) throw cancelled;
        // Stored so the results can be opened like any other message.
        await _store.insertEmails(fetched);
      }
      return (
        hits: [
          for (final e in [...known, ...fetched])
            if (matchesEmail(expr, e, accountLabel: label)) e,
        ],
        fromServer: {for (final e in fetched) e.id},
      );
    } on TimeoutException {
      await _quietDisconnect(_search);
      throw const MailException(MailErrorKind.connection, 'The search took too long');
    } finally {
      if (identical(_runningSearch, token)) _runningSearch = null;
    }
  });

  /// Cancels the search [token]: drops the search connection if that search
  /// is running (IMAP can't cancel a command).
  void cancelSearch(Object token) {
    if (identical(_runningSearch, token)) {
      _runningSearch = null;
      unawaited(_quietDisconnect(_search));
    }
  }

  /// Ids of [summaries] as JSON for a delete operation's revert data.
  static List<Map<String, Object?>> summariesJson(List<EmailSummary> summaries) => [
    for (final s in summaries) summaryToJson(s),
  ];
}
