import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:expr_search/expr_search.dart';
import 'package:flutter/services.dart';
import 'package:mail_model/mail_model.dart';

import 'demo_data.dart';
import 'demo_mime.dart';
import 'demo_openpgp.dart';
import 'demo_rules.dart';

export 'demo_data.dart' show DemoAccounts, DemoPeople;

/// Loads the bytes of a bundled asset.
typedef DemoAssetLoader = Future<Uint8List> Function(String path);

/// Simulated network delays. [DemoLatency.zero] makes everything immediate
/// (tests); timers still run asynchronously, so local results always arrive
/// before server results.
final class DemoLatency {
  const DemoLatency({
    this.network = const Duration(milliseconds: 900),
    this.content = const Duration(milliseconds: 180),
    this.serverSearchMin = const Duration(milliseconds: 800),
    this.serverSearchMax = const Duration(milliseconds: 1500),
  });

  static const zero = DemoLatency(
    network: Duration.zero,
    content: Duration.zero,
    serverSearchMin: Duration.zero,
    serverSearchMax: Duration.zero,
  );

  /// Sync, discovery, account setup, loading older mail.
  final Duration network;

  /// Opening a message for the first time.
  final Duration content;

  /// Each account's server search answers somewhere in this range.
  final Duration serverSearchMin;
  final Duration serverSearchMax;
}

/// A message in the demo outbox.
final class _Queued {
  _Queued(this.id, this.message, this.sendAt, this.status);
  final String id;
  final OutgoingMessage message;
  DateTime sendAt;
  OutboxStatus status;
  String? error;
  Timer? timer;

  OutboxItem get item => OutboxItem(id: id, message: message, sendAt: sendAt, status: status, error: error);
}

/// A complete, in-memory [MailRepository] with a realistic fictional mailbox,
/// so the app can be explored without an account.
///
/// Every `watch*` stream is a broadcast stream that emits the current value
/// to each new listener and again after every change. Actions are optimistic
/// and immediate; network-ish operations wait for [latency].
///
/// Behaviours worth knowing when testing UI against it:
/// - `addAccount` with the password `wrong` fails with an authentication
///   error, and a host containing `unreachable` fails to connect.
/// - `discover` finds nothing for `.invalid` and `.test` domains (manual setup).
/// - Server search finds older mail that isn't synced locally (marked in
///   [SearchResults.fromServerIds]); acting on such a message syncs it.
/// - Sending to an address at a `.invalid` domain fails, so the Outbox
///   shows a failed message with an error and Retry.
class DemoMailRepository implements MailRepository, MailingLists, MailSubscriptions, DecryptedMail {
  DemoMailRepository({
    this.latency = const DemoLatency(),
    DateTime Function()? clock,
    int seed = 7,
    DemoAssetLoader? loadAsset,
  }) : _clock = clock ?? DateTime.now,
       _random = Random(seed),
       _loadAsset = loadAsset ?? _loadFromBundle {
    final data = DemoSeed.build(_clock(), seed: seed);
    _accounts.addAll(data.accounts);
    for (final m in data.mailboxes) {
      _mailboxes[m.id] = m;
    }
    for (final m in data.messages) {
      _messages[m.id] = m;
    }
    for (final MapEntry(:key, :value) in data.older.entries) {
      _older[key] = value;
      for (final m in value) {
        _remote[m.id] = m;
      }
    }
    for (final MapEntry(:key, :value) in data.serverOnly.entries) {
      _serverOnly[key] = value;
      for (final m in value) {
        _remote[m.id] = m;
      }
    }
    _vips.addAll(DemoPeople.vips);
    _startupSync();
  }

  /// Zero latency, for tests.
  factory DemoMailRepository.instant({DateTime Function()? clock, DemoAssetLoader? loadAsset}) =>
      DemoMailRepository(latency: DemoLatency.zero, clock: clock, loadAsset: loadAsset);

  final DemoLatency latency;
  final DateTime Function() _clock;
  final Random _random;
  final DemoAssetLoader _loadAsset;

  final _accounts = <MailAccount>[];
  final _mailboxes = <String, Mailbox>{};
  final _messages = <String, DemoMessage>{};

  /// Not yet synced: older mail per mailbox id (newest first) …
  final _older = <String, List<DemoMessage>>{};

  /// … and mail only the server has, per account.
  final _serverOnly = <String, List<DemoMessage>>{};

  /// Every message in [_older] and [_serverOnly], by id.
  final _remote = <String, DemoMessage>{};
  final _vips = <String>{};

  /// Muted thread ids (local, like the live repository's).
  final _muted = <String>{};

  /// Documents "on the server": account id → document name → content.
  /// Tests write here to play another device.
  final serverDocuments = <String, Map<String, String>>{};

  /// Demo accounts whose server has no METADATA: their documents live in a
  /// Loupe Settings folder, created on the first write. Gmail accounts
  /// can't keep documents at all, like the real one.
  static const _withoutMetadata = {DemoAccounts.work};
  final _sync = <String, AccountSyncStatus>{};
  final _outbox = <String, _Queued>{};
  final _contentCache = <String, EmailContent>{};
  final _changes = StreamController<void>.broadcast();
  final _timers = <Timer>{};

  /// Wakes the next message snoozed in this session on time. Seeded
  /// snoozes wake on refresh (no timer pending in tests).
  Timer? _snoozeTimer;
  int _incomingIndex = 0;
  int _nextId = 100000;
  bool _disposed = false;

  static Future<Uint8List> _loadFromBundle(String path) async => (await rootBundle.load(path)).buffer.asUint8List();

  /// Rules, with simulated ManageSieve servers (see [DemoRules]).
  @override
  late final DemoRules rules = DemoRules(
    this,
    accounts: _accounts,
    mailboxes: [..._mailboxes.values],
    clock: _clock,
    latency: latency.content,
  );

  /// Stops timers and closes streams.
  void dispose() {
    _disposed = true;
    rules.dispose();
    for (final t in _timers) {
      t.cancel();
    }
    for (final q in _outbox.values) {
      q.timer?.cancel();
    }
    _snoozeTimer?.cancel();
    _timers.clear();
    _outbox.clear();
    unawaited(_changes.close());
  }

  // Plumbing -----------------------------------------------------------------------

  void _notify() {
    if (!_disposed) _changes.add(null);
  }

  Stream<T> _watch<T>(T Function() compute) => Stream<T>.multi((c) {
    c.add(compute());
    final sub = _changes.stream.listen((_) => c.add(compute()));
    // onCancel must not return a Future: under fake async `.first` would
    // never complete.
    c.onCancel = () {
      unawaited(sub.cancel());
    };
  }, isBroadcast: true);

  Timer _schedule(Duration delay, void Function() action) {
    late Timer t;
    t = Timer(delay, () {
      _timers.remove(t);
      if (!_disposed) action();
    });
    _timers.add(t);
    return t;
  }

  Future<void> _wait(Duration d) {
    final c = Completer<void>();
    _schedule(d, c.complete);
    return c.future;
  }

  Duration _jitter(Duration base, [double spread = 0.4]) {
    if (base == Duration.zero) return base;
    final factor = 1 - spread / 2 + _random.nextDouble() * spread;
    return Duration(microseconds: (base.inMicroseconds * factor).round());
  }

  MailAccount? _account(String id) => _accounts.where((a) => a.id == id).firstOrNull;

  Mailbox? _roleBox(String accountId, MailboxRole role) =>
      _mailboxes.values.where((m) => m.accountId == accountId && m.role == role).firstOrNull;

  static bool _isBin(Mailbox box) => box.role == MailboxRole.trash || box.role == MailboxRole.junk;

  /// Bins and the Snoozed folder stay out of Flagged.
  static bool _isAside(Mailbox box) => _isBin(box) || Snooze.isFolder(box);

  static bool _isRegular(Mailbox box) =>
      !_isAside(box) && box.role != MailboxRole.sent && box.role != MailboxRole.drafts;

  Set<String> _myAddresses(String accountId) {
    final a = _account(accountId);
    if (a == null) return const {};
    return {a.email.toLowerCase(), for (final i in a.identities) i.email.toLowerCase()};
  }

  bool _isVip(EmailSummary s) => s.from.any((f) => _vips.contains(f.email.toLowerCase()));

  bool _isFromMe(EmailSummary s) => s.from.any((f) => _myAddresses(s.accountId).contains(f.email.toLowerCase()));

  static int _newestFirst(DemoMessage a, DemoMessage b) => b.summary.receivedAt.compareTo(a.summary.receivedAt);

  // Startup and sync -------------------------------------------------------------------

  void _startupSync() {
    final earlier = _clock().subtract(const Duration(minutes: 7));
    for (final a in _accounts) {
      _sync[a.id] = AccountSyncStatus(accountId: a.id, phase: SyncPhase.syncing, lastSuccess: earlier);
    }
    _schedule(_jitter(latency.network), () {
      for (final a in _accounts) {
        _sync[a.id] = AccountSyncStatus(accountId: a.id, phase: SyncPhase.idle, lastSuccess: _clock());
      }
      _notify();
    });
  }

  // Accounts -------------------------------------------------------------------------

  @override
  Stream<List<MailAccount>> watchAccounts() => _watch(() => List.unmodifiable(_accounts));

  @override
  Future<AccountDiscovery> discover(String email) async {
    final at = email.lastIndexOf('@');
    if (at <= 0 || at == email.length - 1) {
      throw const MailException(MailErrorKind.unknown, 'Enter a full email address, like name@example.com.');
    }
    await _wait(_jitter(latency.network));
    final domain = email.substring(at + 1).toLowerCase();
    ServerConfig imap(String host) => ServerConfig(protocol: ServerProtocol.imap, host: host, port: 993);
    ServerConfig smtp(String host, {bool startTls = false}) => ServerConfig(
      protocol: ServerProtocol.smtp,
      host: host,
      port: startTls ? 587 : 465,
      security: startTls ? ConnectionSecurity.startTls : ConnectionSecurity.tls,
    );
    if (const {'gmail.com', 'googlemail.com', 'gmail.example'}.contains(domain)) {
      return AccountDiscovery(
        email: email,
        provider: ProviderKind.gmail,
        authKind: AuthKind.oauth2,
        incoming: imap('imap.gmail.com'),
        outgoing: smtp('smtp.gmail.com'),
        source: 'Provider settings',
        notes: 'You’ll sign in with Google in your browser. Loupe never sees your password.',
      );
    }
    if (const {'outlook.com', 'hotmail.com', 'live.com', 'msn.com', 'outlook.example'}.contains(domain) ||
        domain.endsWith('.onmicrosoft.com')) {
      return AccountDiscovery(
        email: email,
        provider: ProviderKind.microsoft,
        authKind: AuthKind.oauth2,
        incoming: imap('outlook.office365.com'),
        outgoing: smtp('smtp.office365.com', startTls: true),
        source: 'Provider settings',
        notes: 'You’ll sign in with Microsoft in your browser. Work accounts may need admin approval.',
      );
    }
    if (const {'icloud.com', 'me.com', 'mac.com'}.contains(domain)) {
      return AccountDiscovery(
        email: email,
        provider: ProviderKind.icloud,
        authKind: AuthKind.password,
        incoming: imap('imap.mail.me.com'),
        outgoing: smtp('smtp.mail.me.com', startTls: true),
        source: 'Provider settings',
        notes:
            'iCloud needs an app-specific password, not your Apple Account password. Create one at '
            'account.apple.com › Sign-In and Security › App-Specific Passwords.',
      );
    }
    if (const {'fastmail.com', 'fastmail.fm', 'rivera.example'}.contains(domain)) {
      return AccountDiscovery(
        email: email,
        provider: ProviderKind.fastmail,
        authKind: AuthKind.password,
        incoming: imap('imap.fastmail.com'),
        outgoing: smtp('smtp.fastmail.com'),
        source: 'ISPDB',
        notes: 'Use an app password from Fastmail › Settings › Privacy & Security.',
      );
    }
    if (const {'yahoo.com', 'ymail.com'}.contains(domain)) {
      return AccountDiscovery(
        email: email,
        provider: ProviderKind.yahoo,
        authKind: AuthKind.password,
        incoming: imap('imap.mail.yahoo.com'),
        outgoing: smtp('smtp.mail.yahoo.com'),
        source: 'ISPDB',
        notes: 'Yahoo needs an app password: Account security › Generate app password.',
      );
    }
    if (domain.endsWith('.invalid') || domain.endsWith('.test')) {
      return AccountDiscovery(email: email, provider: ProviderKind.generic, authKind: AuthKind.password);
    }
    return AccountDiscovery(
      email: email,
      provider: ProviderKind.generic,
      authKind: AuthKind.password,
      incoming: imap('imap.$domain'),
      outgoing: smtp('smtp.$domain', startTls: true),
      source: 'autoconfig.$domain',
    );
  }

  @override
  Future<MailAccount> addAccount(AccountSetup setup) async {
    await _wait(_jitter(latency.network * 1.5));
    final creds = setup.credentials;
    if (creds is PasswordCredentials && creds.password == 'wrong') {
      throw MailException(MailErrorKind.authentication, 'The server rejected the password for ${setup.email}.');
    }
    if (setup.incoming.host.contains('unreachable')) {
      throw MailException(MailErrorKind.connection, 'Couldn’t connect to ${setup.incoming.host}.');
    }
    final id = 'acct${_nextId++}';
    final account = MailAccount(
      id: id,
      email: setup.email,
      displayName: setup.displayName,
      provider: setup.provider,
      authKind: creds is OAuthCredentials ? AuthKind.oauth2 : AuthKind.password,
      incoming: setup.incoming,
      outgoing: setup.outgoing,
      identities: [Identity(id: '$id/default', email: setup.email, name: setup.senderName)],
      colorIndex: (_accounts.map((a) => a.colorIndex).fold(-1, max) + 1) % 6,
    );
    _accounts.add(account);
    final roles = {
      'INBOX': MailboxRole.inbox,
      'Drafts': MailboxRole.drafts,
      'Sent': MailboxRole.sent,
      'Archive': MailboxRole.archive,
      'Junk': MailboxRole.junk,
      'Trash': MailboxRole.trash,
      'Notes': MailboxRole.none,
    };
    for (final MapEntry(key: path, value: role) in roles.entries) {
      final mid = MailIds.mailbox(id, path);
      _mailboxes[mid] = Mailbox(
        id: mid,
        accountId: id,
        name: path == 'INBOX' ? 'Inbox' : path,
        path: path,
        role: role,
        sortOrder: _mailboxes.length,
      );
    }
    final now = _clock();
    _addLocal(
      accountId: id,
      mailboxId: MailIds.mailbox(id, 'INBOX'),
      from: const EmailAddress('hello@loupe.example', 'Loupe'),
      to: [EmailAddress(setup.email, setup.senderName)],
      subject: 'Your ${setup.displayName} mailbox is ready',
      text:
          'This is a demo account, so nothing here touches a real server. Try swiping this message, '
          'flagging it, or searching for it.\n\nHappy reading!',
      at: now,
      seen: false,
    );
    _sync[id] = AccountSyncStatus(accountId: id, phase: SyncPhase.idle, lastSuccess: now);
    _notify();
    return account;
  }

  @override
  Future<void> updateAccount(MailAccount account) async {
    final i = _accounts.indexWhere((a) => a.id == account.id);
    if (i < 0) throw const MailException(MailErrorKind.notFound, 'This account no longer exists.');
    _accounts[i] = account;
    _notify();
  }

  @override
  Future<void> removeAccount(String accountId) async {
    _accounts.removeWhere((a) => a.id == accountId);
    _mailboxes.removeWhere((_, m) => m.accountId == accountId);
    _messages.removeWhere((_, m) => m.summary.accountId == accountId);
    _remote.removeWhere((_, m) => m.summary.accountId == accountId);
    _older.removeWhere((id, _) => MailIds.accountOf(id) == accountId);
    _serverOnly.remove(accountId);
    _sync.remove(accountId);
    serverDocuments.remove(accountId);
    _notify();
  }

  // Mailboxes and lists ------------------------------------------------------------------

  @override
  Stream<List<Mailbox>> watchMailboxes({String? accountId}) => _watch(() {
    final unread = <String, int>{};
    final total = <String, int>{};
    for (final m in _messages.values) {
      final id = m.summary.mailboxId;
      total[id] = (total[id] ?? 0) + 1;
      if (!m.summary.isSeen) unread[id] = (unread[id] ?? 0) + 1;
    }
    return [
      for (final box in _mailboxes.values)
        if (accountId == null || box.accountId == accountId)
          box.copyWith(unreadCount: unread[box.id] ?? 0, totalCount: total[box.id] ?? 0),
    ];
  });

  @override
  Future<void> setMailboxSubscribed(String mailboxId, {required bool subscribed}) async {
    final box = _mailboxes[mailboxId];
    if (box == null) throw const MailException(MailErrorKind.notFound, 'That mailbox no longer exists.');
    _mailboxes[mailboxId] = box.copyWith(isSubscribed: subscribed);
    _notify();
  }

  @override
  Stream<Map<VirtualMailbox, int>> watchVirtualCounts() => _watch(() {
    var inboxes = 0, unread = 0, flagged = 0, vip = 0, drafts = 0;
    for (final m in _messages.values) {
      final box = _mailboxes[m.summary.mailboxId];
      if (box == null) continue;
      final s = m.summary;
      if (box.role == MailboxRole.drafts) drafts++;
      if (s.isFlagged && !_isAside(box)) flagged++;
      if (s.isSeen) continue;
      if (box.role == MailboxRole.inbox) inboxes++;
      if (_isRegular(box)) {
        unread++;
        if (_isVip(s)) vip++;
      }
    }
    // Flagged shows how many messages are flagged, as Apple Mail does; the
    // others count unread messages.
    return {
      VirtualMailbox.allInboxes: inboxes,
      VirtualMailbox.unread: unread,
      VirtualMailbox.flagged: flagged,
      VirtualMailbox.vip: vip,
      VirtualMailbox.allDrafts: drafts,
      VirtualMailbox.allSent: 0,
    };
  });

  bool _inScope(EmailSummary s, MailboxRef ref) {
    final box = _mailboxes[s.mailboxId];
    if (box == null) return false;
    return switch (ref) {
      RealMailboxRef(:final mailboxId) => s.mailboxId == mailboxId,
      VirtualMailboxRef(:final kind) => switch (kind) {
        VirtualMailbox.allInboxes => box.role == MailboxRole.inbox,
        VirtualMailbox.unread => !s.isSeen && _isRegular(box),
        VirtualMailbox.flagged => s.isFlagged && !_isAside(box),
        VirtualMailbox.vip => _isVip(s) && _isRegular(box),
        VirtualMailbox.allDrafts => box.role == MailboxRole.drafts,
        VirtualMailbox.allSent => box.role == MailboxRole.sent,
      },
    };
  }

  bool _passes(EmailSummary s, Set<QuickFilter> filters) {
    for (final f in filters) {
      final ok = switch (f) {
        QuickFilter.unread => !s.isSeen,
        QuickFilter.flagged => s.isFlagged,
        QuickFilter.toMe => s.to.any((a) => _myAddresses(s.accountId).contains(a.email.toLowerCase())),
        QuickFilter.ccMe => s.cc.any((a) => _myAddresses(s.accountId).contains(a.email.toLowerCase())),
        QuickFilter.hasAttachment => s.hasAttachment,
        QuickFilter.unreplied => !s.isAnswered && !_isFromMe(s),
        QuickFilter.fromVip => _isVip(s),
      };
      if (!ok) return false;
    }
    return true;
  }

  /// Messages of [m]'s conversation. Outside Trash and Junk, deleted and junk
  /// copies are left out; inside them, only that mailbox counts.
  List<DemoMessage> _threadOf(DemoMessage m) {
    final threadId = m.summary.threadId;
    if (threadId == null) return [m];
    final box = _mailboxes[m.summary.mailboxId];
    final inBin = box != null && _isBin(box);
    return [
      for (final o in _messages.values)
        if (o.summary.threadId == threadId &&
            (inBin
                ? o.summary.mailboxId == m.summary.mailboxId
                : !(_mailboxes[o.summary.mailboxId]?.let(_isBin) ?? true)))
          o,
    ];
  }

  ThreadSummary _threadRow(DemoMessage latest) {
    final members = _threadOf(latest)..sort(_newestFirst);
    final participants = <EmailAddress>[];
    for (final m in members) {
      for (final f in m.summary.from) {
        if (!participants.any((p) => p.email.toLowerCase() == f.email.toLowerCase())) participants.add(f);
      }
    }
    return ThreadSummary(
      threadId: latest.summary.threadId ?? latest.id,
      latest: latest.summary,
      messageCount: max(1, members.length),
      unreadCount: members.where((m) => !m.summary.isSeen).length,
      participants: participants,
    );
  }

  @override
  Stream<List<ThreadSummary>> watchList(
    MailboxRef ref, {
    Set<QuickFilter> filters = const {},
    bool threaded = true,
    int limit = 200,
  }) => _watch(() {
    final matching = [
      for (final m in _messages.values)
        if (_inScope(m.summary, ref) && _passes(m.summary, filters)) m,
    ]..sort(_newestFirst);
    if (!threaded) {
      return [
        for (final m in matching.take(limit))
          ThreadSummary(
            threadId: m.summary.threadId ?? m.id,
            latest: m.summary,
            messageCount: 1,
            unreadCount: m.summary.isSeen ? 0 : 1,
            participants: m.summary.from,
          ),
      ];
    }
    final seen = <String>{};
    final rows = <ThreadSummary>[];
    for (final m in matching) {
      if (!seen.add(m.summary.threadId ?? m.id)) continue;
      rows.add(_threadRow(m));
      if (rows.length >= limit) break;
    }
    return rows;
  });

  List<String> _mailboxIdsOf(MailboxRef ref) => switch (ref) {
    RealMailboxRef(:final mailboxId) => [mailboxId],
    VirtualMailboxRef(kind: VirtualMailbox.allInboxes) => [
      for (final m in _mailboxes.values)
        if (m.role == MailboxRole.inbox) m.id,
    ],
    VirtualMailboxRef() => const [],
  };

  @override
  Future<bool> loadOlder(MailboxRef ref) async {
    final ids = _mailboxIdsOf(ref).where((id) => _older[id]?.isNotEmpty ?? false).toList();
    if (ids.isEmpty) return false;
    await _wait(_jitter(latency.network));
    for (final id in ids) {
      final pool = _older[id];
      if (pool == null) continue;
      final page = pool.take(10).toList();
      pool.removeRange(0, page.length);
      for (final m in page) {
        _remote.remove(m.id);
        _messages[m.id] = m;
      }
    }
    _notify();
    return ids.any((id) => _older[id]?.isNotEmpty ?? false);
  }

  @override
  Future<void> refresh({MailboxRef? ref}) async {
    final accounts = switch (ref) {
      RealMailboxRef(:final mailboxId) => [MailIds.accountOf(mailboxId)],
      _ => [for (final a in _accounts) a.id],
    };
    for (final id in accounts) {
      _sync[id] = AccountSyncStatus(accountId: id, phase: SyncPhase.syncing, lastSuccess: _sync[id]?.lastSuccess);
    }
    _notify();
    await _wait(_jitter(latency.network));
    _wakeDue();
    final roll = _random.nextDouble();
    final count = roll < 0.35 ? 0 : (roll < 0.8 ? 1 : 2);
    final candidates = DemoSeed.incoming.where((t) => accounts.contains(t.$1)).toList();
    final arrived = <EmailSummary>[];
    for (var i = 0; i < count && candidates.isNotEmpty; i++) {
      final (accountId, from, subject, text) = candidates[(_incomingIndex++) % candidates.length];
      final inbox = _roleBox(accountId, MailboxRole.inbox);
      if (inbox == null) continue;
      final message = _addLocal(
        accountId: accountId,
        mailboxId: inbox.id,
        from: from,
        to: [EmailAddress(_account(accountId)!.email, 'Sam Rivera')],
        subject: subject,
        text: text,
        at: _clock().subtract(Duration(seconds: 30 * i)),
        seen: false,
      );
      arrived.add(message.summary);
    }
    await rules.runOnArrivals(arrived);
    final now = _clock();
    for (final id in accounts) {
      if (_account(id) == null) continue;
      _sync[id] = AccountSyncStatus(accountId: id, phase: SyncPhase.idle, lastSuccess: now);
    }
    _notify();
  }

  @override
  Stream<List<AccountSyncStatus>> watchSyncStatus() => _watch(() => [for (final a in _accounts) ?_sync[a.id]]);

  // Mailing lists --------------------------------------------------------------------

  /// Synced list mail outside Trash and Junk, by List-Id.
  Map<String, List<DemoMessage>> _listMail() {
    final out = <String, List<DemoMessage>>{};
    for (final m in _messages.values) {
      final id = m.summary.listId;
      final box = _mailboxes[m.summary.mailboxId];
      if (id == null || box == null || _isBin(box)) continue;
      (out[id] ??= []).add(m);
    }
    return out;
  }

  bool _isMuted(EmailSummary s) => _muted.contains(s.threadId ?? s.id);

  @override
  Stream<List<MailingList>> watchMailingLists() => _watch(() {
    final lists = <MailingList>[];
    for (final MapEntry(key: id, value: mail) in _listMail().entries) {
      mail.sort(_newestFirst);
      final summaries = [for (final m in mail) m.summary];
      lists.add(
        MailingList(
          id: id,
          name: summaries.map((s) => s.listName).nonNulls.firstOrNull ?? id,
          postAddress: summaries.map((s) => listPostAddress(s.listPost)).nonNulls.firstOrNull,
          messageCount: mail.length,
          unreadCount: summaries.where((s) => !s.isSeen && !_isMuted(s)).length,
          lastActivity: summaries.first.receivedAt,
          accountIds: {for (final s in summaries) s.accountId}.toList()..sort(),
        ),
      );
    }
    return lists..sort((a, b) => b.lastActivity!.compareTo(a.lastActivity!));
  });

  @override
  Stream<List<ListThread>> watchListThreads(String listId, {bool includeMuted = false, int limit = 200}) => _watch(() {
    final byThread = <String, List<EmailSummary>>{};
    for (final m in _listMail()[listId.toLowerCase()] ?? const <DemoMessage>[]) {
      if (!includeMuted && _isMuted(m.summary)) continue;
      (byThread[m.summary.threadId ?? m.id] ??= []).add(m.summary);
    }
    final threads = <ListThread>[];
    for (final MapEntry(key: threadId, value: mail) in byThread.entries) {
      mail.sort((a, b) => a.receivedAt.compareTo(b.receivedAt));
      final participants = <EmailAddress>[];
      for (final s in mail) {
        for (final f in s.from) {
          if (!participants.any((p) => p.email.toLowerCase() == f.email.toLowerCase())) participants.add(f);
        }
      }
      threads.add(
        ListThread(
          threadId: threadId,
          first: mail.first,
          latest: mail.last,
          messageCount: mail.length,
          unreadCount: mail.where((s) => !s.isSeen).length,
          participants: participants,
          patchCount: ListThread.countPatches(mail.map((s) => s.subject), series: PatchTag.parse(mail.first.subject)),
          isMuted: _muted.contains(threadId),
        ),
      );
    }
    threads.sort((a, b) => b.lastActivity.compareTo(a.lastActivity));
    return threads.take(limit).toList();
  });

  @override
  Stream<Set<String>> watchMutedThreads() => _watch(() => Set.unmodifiable(_muted));

  // Subscriptions --------------------------------------------------------------------

  Set<String> get _allMyAddresses => {for (final a in _accounts) ..._myAddresses(a.id)};

  MailboxRole? _roleOf(EmailSummary s) => _mailboxes[s.mailboxId]?.role;

  @override
  Stream<List<Subscription>> watchSubscriptions() => _watch(
    () => summarizeSubscriptions(
      [for (final m in _messages.values) m.summary],
      roleOf: _roleOf,
      now: _clock(),
      me: _allMyAddresses,
    ),
  );

  @override
  Stream<List<EmailSummary>> watchSubscriptionEmails(String key, {bool inboxOnly = false, int limit = 200}) =>
      _watch(() {
        final me = _allMyAddresses;
        final out = [
          for (final m in _messages.values)
            if (subscriptionKeyOf(m.summary) == key &&
                !subscriptionExcludedRoles.contains(_roleOf(m.summary)) &&
                !me.contains(m.summary.sender?.email.toLowerCase()) &&
                (!inboxOnly || _roleOf(m.summary) == MailboxRole.inbox))
              m.summary,
        ]..sort((a, b) => b.receivedAt.compareTo(a.receivedAt));
        return out.take(limit).toList();
      });

  @override
  Future<void> setThreadMuted(String emailId, {required bool muted}) async {
    final m = _local(emailId);
    if (m == null) throw const MailException(MailErrorKind.notFound, 'This message no longer exists.');
    final threadId = m.summary.threadId ?? m.id;
    if (!muted) {
      _muted.remove(threadId);
      _notify();
      return;
    }
    _muted.add(threadId);
    // Muting marks the conversation read, as the live repository does.
    for (final o in _messages.values) {
      if ((o.summary.threadId ?? o.id) == threadId && !o.summary.isSeen) {
        o.summary = o.summary.copyWith(keywords: {...o.summary.keywords, Keywords.seen});
      }
    }
    _notify();
  }

  // Messages ------------------------------------------------------------------------

  @override
  Stream<List<EmailSummary>> watchConversation(String emailId) => _watch(() {
    final m = _messages[emailId];
    if (m == null) {
      final remote = _remote[emailId];
      return remote == null ? const <EmailSummary>[] : [remote.summary];
    }
    final members = _threadOf(m)..sort((a, b) => a.summary.receivedAt.compareTo(b.summary.receivedAt));
    return [for (final x in members) x.summary];
  });

  @override
  Future<EmailSummary?> getEmail(String emailId) async => (_messages[emailId] ?? _remote[emailId])?.summary;

  DemoMessage _require(String emailId) {
    final m = _messages[emailId] ?? _remote[emailId];
    if (m == null) throw const MailException(MailErrorKind.notFound, 'This message no longer exists.');
    return m;
  }

  @override
  Future<EmailContent> loadContent(String emailId) async {
    final cached = _contentCache[emailId];
    if (cached != null) return cached;
    final m = _require(emailId);
    await _wait(_jitter(latency.content));
    if (m.raw != null) {
      const transport = {'return-path', 'received', 'authentication-results', 'dkim-signature'};
      return _contentCache[emailId] = demoRawContent(m, [
        for (final h in _headers(m, encoded: false))
          if (transport.contains(h.$1.toLowerCase())) h,
      ]);
    }
    final inline = <String, Uint8List>{};
    for (final a in m.attachments) {
      final cid = a.attachment.contentId;
      if (cid != null && a.attachment.isInline) inline[cid] = await _bytesOf(a);
    }
    final content = EmailContent(
      emailId: emailId,
      html: m.html,
      text: m.text ?? (m.html == null ? '' : htmlToPreviewText(m.html!)),
      isFlowed: m.isFlowed,
      attachments: [for (final a in m.attachments) a.attachment],
      inlineData: inline,
      headers: _headers(m, encoded: false),
    );
    _contentCache[emailId] = content;
    return content;
  }

  Future<Uint8List> _bytesOf(DemoAttachment a) async {
    if (a.generate != null) return a.generate!();
    if (a.asset != null) return _loadAsset(a.asset!);
    return Uint8List(0);
  }

  @override
  Future<Uint8List> loadAttachment(String emailId, String partId) async {
    final m = _require(emailId);
    if (m.raw != null) {
      await _wait(_jitter(latency.content));
      return demoRawPart(m, partId) ??
          (throw const MailException(MailErrorKind.notFound, 'This attachment no longer exists.'));
    }
    final a = m.attachments.where((a) => a.attachment.partId == partId).firstOrNull;
    if (a == null) throw const MailException(MailErrorKind.notFound, 'This attachment no longer exists.');
    await _wait(_jitter(latency.content));
    return _bytesOf(a);
  }

  String _mxHost(String accountId) => switch (_account(accountId)?.provider) {
    ProviderKind.gmail => 'mx.google.example',
    ProviderKind.microsoft => 'mx.protection.outlook.example',
    ProviderKind.fastmail => 'mx.messagingengine.example',
    _ => 'mx.mail.example',
  };

  List<(String, String)> _headers(DemoMessage m, {required bool encoded}) {
    final s = m.summary;
    String enc(String v) => encoded ? encodeHeaderValue(v) : v;
    String addresses(List<EmailAddress> list) => encoded ? formatAddressHeader(list) : list.join(', ');
    final from = s.from.isEmpty ? 'example.com' : s.from.first.domain;
    final mx = _mxHost(s.accountId);
    final hash = s.id.hashCode.abs();
    final received = s.receivedAt;
    return [
      ('Return-Path', '<${s.from.isEmpty ? '' : s.from.first.email}>'),
      (
        'Received',
        'from mail.$from (mail.$from [192.0.2.${20 + hash % 200}]) by $mx with ESMTPS id '
            '${hash.toRadixString(16)}; ${rfc5322Date(received)}',
      ),
      (
        'Authentication-Results',
        m.authenticationFails
            ? '$mx; dkim=none (message not signed); spf=softfail (domain of $from does not designate '
                  '198.51.100.77 as permitted sender) smtp.mailfrom=$from; dmarc=fail (p=NONE) header.from=$from'
            : '$mx; dkim=pass header.d=$from header.s=mail; spf=pass smtp.mailfrom=$from; '
                  'dmarc=pass (p=REJECT) header.from=$from',
      ),
      if (!m.authenticationFails)
        (
          'DKIM-Signature',
          'v=1; a=rsa-sha256; c=relaxed/relaxed; d=$from; s=mail; t=${received.millisecondsSinceEpoch ~/ 1000}; '
              'h=from:to:subject:date:message-id; bh=${base64.encode(utf8.encode('$hash body')).substring(0, 16)}=; '
              'b=${base64.encode(utf8.encode('$hash signature of the demo message'))}',
        ),
      if (s.messageIdHeader != null) ('Message-ID', '<${s.messageIdHeader}>'),
      if (s.inReplyTo != null) ('In-Reply-To', '<${s.inReplyTo}>'),
      if (s.references.isNotEmpty) ('References', s.references.map((r) => '<$r>').join(' ')),
      ('Date', rfc5322Date(s.sentAt ?? received)),
      ('From', addresses(s.from)),
      if (s.to.isNotEmpty) ('To', addresses(s.to)),
      if (s.cc.isNotEmpty) ('Cc', addresses(s.cc)),
      if (s.replyTo.isNotEmpty) ('Reply-To', addresses(s.replyTo)),
      ('Subject', enc(s.subject)),
      ...m.extraHeaders,
      ('MIME-Version', '1.0'),
    ];
  }

  @override
  Future<void> rememberProtectedSubject(String emailId, String subject) async {
    final m = _messages[emailId];
    if (m == null || (m.summary.hasDecryptedSubject && m.summary.subject == subject)) return;
    m.summary = m.summary.copyWith(subject: subject, hasDecryptedSubject: true);
    _notify();
  }

  /// Decrypted text that search finds, by email id (Index Decrypted
  /// Messages for Search).
  final _decryptedTexts = <String, String>{};

  @override
  Future<void> indexDecryptedText(String emailId, String text) async {
    if (!_messages.containsKey(emailId) || _decryptedTexts[emailId] == text) return;
    _decryptedTexts[emailId] = text;
    _notify();
  }

  @override
  Future<void> forgetDecryptedText() async {
    if (_decryptedTexts.isEmpty) return;
    _decryptedTexts.clear();
    _notify();
  }

  @override
  Future<Uint8List> loadRawSource(String emailId) async {
    final m = _require(emailId);
    await _wait(_jitter(latency.content));
    if (m.raw case final raw?) return raw();
    final n = m.id.hashCode.abs();
    final text = m.text ?? (m.html == null ? '' : htmlToPreviewText(m.html!));
    var top = _MimePart(
      'Content-Type: text/plain; charset=utf-8${m.isFlowed ? '; format=flowed' : ''}\r\n'
      'Content-Transfer-Encoding: 8bit',
      text,
    );
    if (m.html != null) {
      top = _MimePart.multipart('alternative', 'alt_$n', [
        top,
        _MimePart('Content-Type: text/html; charset=utf-8\r\nContent-Transfer-Encoding: 8bit', m.html!),
      ]);
    }
    final inline = <_MimePart>[];
    final files = <_MimePart>[];
    for (final a in m.attachments) {
      final meta = a.attachment;
      final name = meta.filename ?? 'part${meta.partId}';
      final bytes = await _bytesOf(a);
      final part = _MimePart(
        'Content-Type: ${meta.mimeType}; name="$name"\r\nContent-Transfer-Encoding: base64\r\n'
        '${meta.contentId != null ? 'Content-ID: <${meta.contentId}>\r\n' : ''}'
        'Content-Disposition: ${meta.isInline ? 'inline' : 'attachment'}; filename="$name"',
        wrappedBase64(bytes),
      );
      (meta.isInline && meta.contentId != null ? inline : files).add(part);
    }
    if (inline.isNotEmpty) top = _MimePart.multipart('related', 'rel_$n', [top, ...inline]);
    if (files.isNotEmpty) top = _MimePart.multipart('mixed', 'mix_$n', [top, ...files]);
    final out = StringBuffer();
    for (final (name, value) in _headers(m, encoded: true)) {
      out.write('$name: $value\r\n');
    }
    out
      ..write(top.headers)
      ..write('\r\n\r\n')
      ..write(top.body);
    return Uint8List.fromList(utf8.encode(out.toString()));
  }

  // Actions -------------------------------------------------------------------------------

  /// The local message [id], syncing it first if only the server had it.
  DemoMessage? _local(String id) {
    final local = _messages[id];
    if (local != null) return local;
    final remote = _remote.remove(id);
    if (remote == null) return null;
    for (final pool in [..._older.values, ..._serverOnly.values]) {
      pool.remove(remote);
    }
    _messages[id] = remote;
    return remote;
  }

  @override
  Future<void> setKeywords(List<String> emailIds, {Set<String> add = const {}, Set<String> remove = const {}}) async {
    final adds = add.map(Keywords.normalize).toSet();
    final removes = remove.map(Keywords.normalize).toSet();
    for (final id in emailIds) {
      final m = _local(id);
      if (m == null) continue;
      m.summary = m.summary.copyWith(keywords: {...m.summary.keywords.difference(removes), ...adds});
    }
    _notify();
  }

  void _moveTo(DemoMessage m, Mailbox target) {
    if (target.accountId != m.summary.accountId) return;
    m.summary = m.summary.copyWith(mailboxId: target.id);
  }

  @override
  Future<void> move(List<String> emailIds, String targetMailboxId) async {
    final target = _mailboxes[targetMailboxId];
    if (target == null) throw const MailException(MailErrorKind.notFound, 'That mailbox no longer exists.');
    for (final id in emailIds) {
      final m = _local(id);
      if (m != null) _moveTo(m, target);
    }
    _notify();
  }

  @override
  Future<void> archive(List<String> emailIds) async {
    for (final id in emailIds) {
      final m = _local(id);
      if (m == null) continue;
      final target =
          _roleBox(m.summary.accountId, MailboxRole.archive) ?? _roleBox(m.summary.accountId, MailboxRole.all);
      if (target != null) _moveTo(m, target);
    }
    _notify();
  }

  @override
  Future<void> trash(List<String> emailIds) async {
    for (final id in emailIds) {
      final m = _local(id);
      if (m == null) continue;
      final box = _mailboxes[m.summary.mailboxId];
      if (box?.role == MailboxRole.trash) {
        _messages.remove(id);
        _contentCache.remove(id);
        continue;
      }
      final target = _roleBox(m.summary.accountId, MailboxRole.trash);
      if (target != null) _moveTo(m, target);
    }
    _notify();
  }

  @override
  Future<void> markJunk(List<String> emailIds, {required bool junk}) async {
    for (final id in emailIds) {
      final m = _local(id);
      if (m == null) continue;
      final target = _roleBox(m.summary.accountId, junk ? MailboxRole.junk : MailboxRole.inbox);
      if (target != null) _moveTo(m, target);
      final keywords = {...m.summary.keywords}
        ..remove(junk ? Keywords.notJunk : Keywords.junk)
        ..add(junk ? Keywords.junk : Keywords.notJunk);
      m.summary = m.summary.copyWith(keywords: keywords);
    }
    _notify();
  }

  // Snooze --------------------------------------------------------------------------------

  /// The account's Snoozed folder, added when it has none yet.
  Mailbox _snoozeBox(String accountId) {
    final existing = _mailboxes.values.where((m) => m.accountId == accountId && Snooze.isFolder(m)).firstOrNull;
    if (existing != null) return existing;
    final id = MailIds.mailbox(accountId, Snooze.folderName);
    return _mailboxes[id] = Mailbox(
      id: id,
      accountId: accountId,
      name: Snooze.folderName,
      path: Snooze.folderName,
      sortOrder: _mailboxes.length,
    );
  }

  @override
  Future<SnoozeStorage> snooze(List<String> emailIds, DateTime until) async {
    final keyword = Snooze.keyword(until);
    for (final id in emailIds) {
      final m = _local(id);
      if (m == null) continue;
      final k = m.summary.keywords;
      m.summary = m.summary.copyWith(
        mailboxId: _snoozeBox(m.summary.accountId).id,
        keywords: {...k.difference(Snooze.keywordsIn(k)), keyword},
      );
    }
    _armSnoozeTimer();
    _notify();
    return SnoozeStorage.server;
  }

  @override
  Future<void> unsnooze(List<String> emailIds) async {
    for (final id in emailIds) {
      final m = _local(id);
      if (m != null) _wake(m);
    }
    _armSnoozeTimer();
    _notify();
  }

  /// Back to the Inbox, unread, `$new`, without its snooze keywords.
  void _wake(DemoMessage m) {
    final k = m.summary.keywords;
    m.summary = m.summary.copyWith(
      mailboxId: _roleBox(m.summary.accountId, MailboxRole.inbox)?.id,
      keywords: {
        ...k.difference({...Snooze.keywordsIn(k), Keywords.seen}),
        Keywords.newAgain,
      },
    );
  }

  bool _isSnoozed(DemoMessage m) => _mailboxes[m.summary.mailboxId]?.let(Snooze.isFolder) ?? false;

  /// Wakes the messages whose time has come.
  void _wakeDue() {
    final now = _clock();
    for (final m in _messages.values) {
      final t = m.summary.snoozedUntil;
      if (t != null && !t.isAfter(now) && _isSnoozed(m)) _wake(m);
    }
  }

  void _armSnoozeTimer() {
    _snoozeTimer?.cancel();
    _snoozeTimer = null;
    if (_disposed) return;
    DateTime? next;
    for (final m in _messages.values) {
      final t = m.summary.snoozedUntil;
      if (t != null && _isSnoozed(m) && (next == null || t.isBefore(next))) next = t;
    }
    if (next == null) return;
    final delay = next.difference(_clock());
    _snoozeTimer = Timer(delay.isNegative ? Duration.zero : delay, () {
      _snoozeTimer = null;
      if (_disposed) return;
      _wakeDue();
      _notify();
    });
  }

  @override
  Stream<List<EmailSummary>> watchSnoozed() => _watch(
    () => [
      for (final m in _messages.values)
        if (_isSnoozed(m)) m.summary,
    ]..sort(Snooze.compare),
  );

  // Search ------------------------------------------------------------------------------

  Set<String> _accountsOf(SearchScope scope) => switch (scope) {
    MailboxScope(ref: RealMailboxRef(:final mailboxId)) => {MailIds.accountOf(mailboxId)},
    _ => {for (final a in _accounts) a.id},
  };

  bool _inSearchScope(EmailSummary s, SearchScope scope) => switch (scope) {
    AllMailboxesScope() => _mailboxes[s.mailboxId]?.let((b) => !_isBin(b)) ?? false,
    MailboxScope(:final ref) => _inScope(s, ref),
  };

  bool _matches(DemoMessage m, SearchExpr expr) {
    final account = _account(m.summary.accountId);
    return matchesEmail(
      expr,
      m.summary,
      content: switch (_decryptedTexts[m.id]) {
        final decrypted? => EmailContent(emailId: m.id, text: decrypted),
        null => EmailContent(
          emailId: m.id,
          html: m.html,
          text: m.text,
          attachments: [for (final a in m.attachments) a.attachment],
        ),
      },
      accountLabel: account == null ? null : '${account.displayName} ${account.email}',
      headers: {for (final (name, value) in m.extraHeaders) name.toLowerCase(): value},
    );
  }

  List<EmailSummary> _searchLocal(SearchRequest request) {
    final hits = [
      for (final m in _messages.values)
        if (_inSearchScope(m.summary, request.scope) && _matches(m, request.expr)) m,
    ]..sort(_newestFirst);
    return [for (final m in hits.take(request.limit)) m.summary];
  }

  /// What the account's server would find beyond the local copy: older mail
  /// not synced yet and mail that was never downloaded.
  List<DemoMessage> _searchServer(String accountId, SearchRequest request) {
    final candidates = [
      ..._serverOnly[accountId] ?? const <DemoMessage>[],
      for (final MapEntry(:key, :value) in _older.entries)
        if (MailIds.accountOf(key) == accountId) ...value,
    ];
    return [
      for (final m in candidates)
        if (_inSearchScope(m.summary, request.scope) && _matches(m, request.expr)) m,
    ].take(10).toList();
  }

  @override
  Stream<SearchResults> search(SearchRequest request) => Stream<SearchResults>.multi((c) {
    final searchesServer = request.includeServer && request.expr is! MatchAll;
    final pending = searchesServer ? _accountsOf(request.scope) : <String>{};
    final serverHits = <String, EmailSummary>{};

    void emit() {
      final local = _searchLocal(request);
      final localIds = {for (final s in local) s.id};
      final remote = [
        for (final MapEntry(:key, :value) in serverHits.entries)
          if (!localIds.contains(key)) _messages[key]?.summary ?? value,
      ];
      final items = [...local, ...remote]..sort((a, b) => b.receivedAt.compareTo(a.receivedAt));
      c.add(
        SearchResults(
          items: items.take(request.limit).toList(),
          pendingAccountIds: {...pending},
          fromServerIds: {
            for (final s in remote)
              if (!_messages.containsKey(s.id)) s.id,
          },
        ),
      );
    }

    emit();
    final timers = <Timer>[];
    for (final accountId in pending.toList()) {
      final spread = latency.serverSearchMax - latency.serverSearchMin;
      final delay = latency.serverSearchMin + spread * _random.nextDouble();
      timers.add(
        _schedule(delay, () {
          for (final m in _searchServer(accountId, request)) {
            serverHits[m.id] = m.summary;
          }
          pending.remove(accountId);
          emit();
        }),
      );
    }
    final sub = _changes.stream.listen((_) => emit());
    c.onCancel = () {
      for (final t in timers) {
        t.cancel();
        _timers.remove(t);
      }
      unawaited(sub.cancel());
    };
  }, isBroadcast: true);

  // Compose ------------------------------------------------------------------------------

  Identity _identity(OutgoingMessage message) {
    final account = _account(message.accountId);
    if (account == null) throw const MailException(MailErrorKind.notFound, 'This account no longer exists.');
    return account.identityById(message.identityId);
  }

  DemoMessage _addLocal({
    required String accountId,
    required String mailboxId,
    required EmailAddress from,
    required String subject,
    required String text,
    required DateTime at,
    List<EmailAddress> to = const [],
    List<EmailAddress> cc = const [],
    List<EmailAddress> bcc = const [],
    String? html,
    bool seen = true,
    Set<String> keywords = const {},
    String? id,
    String? threadId,
    String? inReplyTo,
    List<String> references = const [],
    List<OutgoingAttachment> attachments = const [],
  }) {
    final n = _nextId++;
    final emailId = id ?? MailIds.jmapEmail(accountId, 'N$n');
    final files = [
      for (final (i, a) in attachments.indexed)
        DemoAttachment(
          Attachment(partId: '${i + 2}', mimeType: a.mimeType, filename: a.filename, size: a.data.length),
          generate: () => a.data,
        ),
    ];
    final message = DemoMessage(
      summary: EmailSummary(
        id: emailId,
        accountId: accountId,
        mailboxId: mailboxId,
        receivedAt: at,
        sentAt: at,
        threadId: threadId ?? 'T$n',
        messageIdHeader: 'loupe.$n.${at.millisecondsSinceEpoch.toRadixString(36)}@${from.domain}',
        inReplyTo: inReplyTo,
        references: references,
        from: [from],
        to: to,
        cc: cc,
        bcc: bcc,
        subject: subject,
        preview: makePreview(text),
        size: text.length + (html?.length ?? 0) + 1500 + attachments.fold(0, (s, a) => s + a.data.length),
        keywords: {if (seen) Keywords.seen, ...keywords},
        hasAttachment: files.isNotEmpty,
      ),
      text: text,
      html: html,
      attachments: files,
    );
    _messages[emailId] = message;
    _contentCache.remove(emailId);
    return message;
  }

  /// Files [message] into [mailboxId], threaded with the message it answers.
  DemoMessage _file(OutgoingMessage message, String mailboxId, {String? id, Set<String> keywords = const {}}) {
    final identity = _identity(message);
    final source = message.sourceEmailId == null ? null : _messages[message.sourceEmailId];
    return _addLocal(
      accountId: message.accountId,
      mailboxId: mailboxId,
      from: EmailAddress(identity.email, identity.name),
      to: message.to,
      cc: message.cc,
      bcc: message.bcc,
      subject: message.subject,
      text: message.text,
      html: message.html,
      at: _clock(),
      keywords: keywords,
      id: id,
      threadId: source?.summary.threadId,
      inReplyTo: message.inReplyTo ?? source?.summary.messageIdHeader,
      references: message.references.isNotEmpty
          ? message.references
          : [...?source?.summary.references, ?source?.summary.messageIdHeader],
      attachments: message.attachments,
    );
  }

  @override
  Future<String> send(
    OutgoingMessage message, {
    Duration undoDelay = const Duration(seconds: 10),
    DateTime? sendAt,
  }) async {
    _identity(message);
    final outboxId = 'outbox-${_nextId++}';
    var queued = message;
    if (sendAt != null && message.draftId != null) {
      // A scheduled message lives in the Outbox, not in Drafts.
      _messages.remove(message.draftId);
      _contentCache.remove(message.draftId);
      queued = message.withoutDraft();
    }
    final entry = _Queued(
      outboxId,
      queued,
      sendAt ?? _clock().add(undoDelay),
      sendAt == null ? OutboxStatus.queued : OutboxStatus.scheduled,
    );
    _outbox[outboxId] = entry;
    _arm(entry);
    _notify();
    return outboxId;
  }

  /// Starts the timer that sends [entry] at its time.
  void _arm(_Queued entry) {
    entry.timer?.cancel();
    final delay = entry.sendAt.difference(_clock());
    entry.timer = Timer(delay.isNegative ? Duration.zero : delay, () => _startSending(entry.id));
  }

  void _startSending(String outboxId) {
    final entry = _outbox[outboxId];
    if (entry == null || _disposed) return;
    entry
      ..timer = null
      ..status = OutboxStatus.sending;
    _notify();
    _schedule(_jitter(latency.network ~/ 2), () => _deliver(outboxId));
  }

  static bool _rejected(EmailAddress a) => a.domain.toLowerCase().endsWith('.invalid');

  void _deliver(String outboxId) {
    final queued = _outbox[outboxId];
    if (queued == null || _disposed) return;
    final message = queued.message;
    final rejected = [...message.to, ...message.cc, ...message.bcc].where(_rejected).firstOrNull;
    if (rejected != null) {
      queued
        ..status = OutboxStatus.failed
        ..error = '550 Recipient address rejected: ${rejected.email}: Domain not found'
        ..sendAt = _clock();
      _notify();
      return;
    }
    _outbox.remove(outboxId);
    final sent = _roleBox(message.accountId, MailboxRole.sent);
    if (sent != null) _file(message, sent.id);
    final source = message.sourceEmailId == null ? null : _messages[message.sourceEmailId];
    if (source != null) {
      final flag = message.mode == ComposeMode.forward ? Keywords.forwarded : Keywords.answered;
      source.summary = source.summary.copyWith(keywords: {...source.summary.keywords, flag});
    }
    if (message.draftId != null) {
      _messages.remove(message.draftId);
      _contentCache.remove(message.draftId);
    }
    _notify();
  }

  @override
  Stream<List<OutboxItem>> watchOutbox() =>
      _watch(() => [for (final q in _outbox.values) q.item]..sort((a, b) => a.sendAt.compareTo(b.sendAt)));

  @override
  Future<OutgoingMessage?> cancelSend(String outboxId) async {
    final queued = _outbox[outboxId];
    if (queued == null || queued.status == OutboxStatus.sending) return null;
    _outbox.remove(outboxId);
    queued.timer?.cancel();
    _notify();
    return queued.message;
  }

  _Queued _waiting(String outboxId) =>
      _outbox[outboxId] ?? (throw const MailException(MailErrorKind.notFound, 'This message was already sent.'));

  @override
  Future<void> sendNow(String outboxId) async {
    final entry = _waiting(outboxId);
    if (entry.status == OutboxStatus.sending) return;
    entry
      ..status = OutboxStatus.queued
      ..sendAt = _clock()
      ..error = null;
    _arm(entry);
    _notify();
  }

  @override
  Future<void> rescheduleSend(String outboxId, DateTime sendAt) async {
    final entry = _waiting(outboxId);
    if (entry.status == OutboxStatus.sending) {
      throw const MailException(MailErrorKind.unsupported, 'This message is being sent right now.');
    }
    entry
      ..status = OutboxStatus.scheduled
      ..sendAt = sendAt
      ..error = null;
    _arm(entry);
    _notify();
  }

  @override
  Future<String> saveDraft(OutgoingMessage message) async {
    final drafts = _roleBox(message.accountId, MailboxRole.drafts);
    if (drafts == null) throw const MailException(MailErrorKind.unsupported, 'This account has no Drafts mailbox.');
    final existing = message.draftId == null ? null : _messages[message.draftId];
    final draft = _file(message, drafts.id, id: existing?.id, keywords: const {Keywords.draft});
    _notify();
    return draft.id;
  }

  @override
  Future<void> deleteDraft(String draftEmailId) async {
    _messages.remove(draftEmailId);
    _contentCache.remove(draftEmailId);
    _notify();
  }

  @override
  Future<List<EmailAddress>> suggestAddresses(String prefix, {int limit = 8}) async {
    final mine = {for (final a in _accounts) ..._myAddresses(a.id)};
    // People you write to rank far above senders you only receive from, so
    // newsletters and notifications don't crowd out friends.
    final scores = <String, int>{};
    final sentTo = <String>{};
    final names = <String, EmailAddress>{};
    void count(EmailAddress a, int score, {bool sent = false}) {
      final key = a.email.toLowerCase();
      if (mine.contains(key)) return;
      scores[key] = (scores[key] ?? 0) + score;
      if (sent) sentTo.add(key);
      if (a.name != null && a.name!.isNotEmpty) names[key] = a;
      names.putIfAbsent(key, () => a);
    }

    for (final m in _messages.values) {
      final s = m.summary;
      final fromMe = _isFromMe(s);
      for (final a in [...s.to, ...s.cc]) {
        count(a, fromMe ? 5 : 1, sent: fromMe);
      }
      for (final a in s.from) {
        count(a, 1);
      }
    }
    final p = prefix.trim().toLowerCase();
    bool matches(EmailAddress a) =>
        a.email.toLowerCase().startsWith(p) ||
        (a.name ?? '').toLowerCase().startsWith(p) ||
        (a.name ?? '').toLowerCase().split(RegExp(r'\s+')).any((w) => w.startsWith(p));
    final hits = [
      for (final MapEntry(:key, value: a) in names.entries)
        if (p.isEmpty ? sentTo.contains(key) : matches(a)) a,
    ]..sort((a, b) => scores[b.email.toLowerCase()]!.compareTo(scores[a.email.toLowerCase()]!));
    return hits.take(limit).toList();
  }

  // Documents on the server ---------------------------------------------------------

  void _requireAccount(String accountId) {
    final account = _account(accountId);
    if (account == null) throw const MailException(MailErrorKind.notFound, 'This account no longer exists.');
    if (account.provider == ProviderKind.gmail) {
      throw const MailException(MailErrorKind.unsupported, 'Gmail can’t keep Loupe settings on the server.');
    }
  }

  @override
  Future<List<ServerDocument>> readServerDocuments(String accountId, String name) async {
    _requireAccount(accountId);
    await _wait(_jitter(latency.content));
    final content = serverDocuments[accountId]?[name];
    return [
      if (content != null)
        _withoutMetadata.contains(accountId)
            ? ServerDocument(content: content, storage: ServerStorage.folder, ref: '$accountId/$name')
            : ServerDocument(content: content, storage: ServerStorage.metadata),
    ];
  }

  @override
  Future<ServerStorage> writeServerDocument(
    String accountId,
    String name,
    String content, {
    List<ServerDocument> replaces = const [],
  }) async {
    _requireAccount(accountId);
    await _wait(_jitter(latency.content));
    (serverDocuments[accountId] ??= {})[name] = content;
    if (!_withoutMetadata.contains(accountId)) return ServerStorage.metadata;
    final folder = MailIds.mailbox(accountId, ServerDocuments.folderName);
    if (!_mailboxes.containsKey(folder)) {
      _mailboxes[folder] = Mailbox(
        id: folder,
        accountId: accountId,
        name: ServerDocuments.folderName,
        path: ServerDocuments.folderName,
        isSubscribed: false,
        sortOrder: _mailboxes.length,
      );
      _notify();
    }
    return ServerStorage.folder;
  }

  // People -----------------------------------------------------------------------------

  @override
  Stream<Set<String>> watchVipAddresses() => _watch(() => Set.unmodifiable(_vips));

  @override
  Future<void> setVip(String email, {required bool vip}) async {
    final key = email.toLowerCase();
    vip ? _vips.add(key) : _vips.remove(key);
    _notify();
  }

  /// Like the store's address book: senders outside Junk, Trash and Drafts,
  /// and recipients of the user's own messages.
  @override
  Future<SenderHistory> senderHistory(String email) async {
    final e = email.trim().toLowerCase();
    var received = 0;
    var sent = 0;
    for (final m in _messages.values) {
      final s = m.summary;
      final box = _mailboxes[s.mailboxId];
      if (box == null || _isBin(box) || box.role == MailboxRole.drafts) continue;
      if (_isFromMe(s)) {
        if ([...s.to, ...s.cc, ...s.bcc].any((a) => a.email.toLowerCase() == e)) sent++;
      } else if (s.from.any((a) => a.email.toLowerCase() == e)) {
        received++;
      }
    }
    return SenderHistory(received: received, sent: sent);
  }
}

/// One MIME part: its header lines (without the final blank line) and body.
final class _MimePart {
  const _MimePart(this.headers, this.body);

  factory _MimePart.multipart(String subtype, String boundary, List<_MimePart> parts) {
    final body = StringBuffer();
    for (final p in parts) {
      body
        ..write('--$boundary\r\n')
        ..write(p.headers)
        ..write('\r\n\r\n')
        ..write(p.body)
        ..write('\r\n');
    }
    body.write('--$boundary--\r\n');
    return _MimePart('Content-Type: multipart/$subtype; boundary="$boundary"', body.toString());
  }

  final String headers;
  final String body;
}

extension<T> on T {
  R let<R>(R Function(T) f) => f(this);
}
