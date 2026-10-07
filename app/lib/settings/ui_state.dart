import 'dart:async';
import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers.dart';
import '../shared/mailbox_ref_codec.dart';
import 'app_mode.dart';
import 'app_settings.dart';

/// A set of strings persisted in SharedPreferences under [key].
class PrefsStringSet extends Notifier<Set<String>> {
  PrefsStringSet(this.key, {this.defaults = const {}});

  final String key;
  final Set<String> defaults;

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  Set<String> build() {
    ref.watch(prefsEpochProvider);
    final stored = ref.watch(sharedPreferencesProvider).getStringList(key);
    return stored == null ? {...defaults} : stored.toSet();
  }

  Future<void> toggle(String value) => set(state.contains(value) ? ({...state}..remove(value)) : {...state, value});

  Future<void> set(Set<String> values) async {
    state = values;
    await _prefs.setStringList(key, values.toList());
  }
}

/// Mailboxes-screen items hidden in Edit mode: `v.<virtual>`, `m.<mailbox id>`,
/// `tag.<keyword>`, `smart.<id>`, `list.<List-Id>` (pinned lists),
/// `tool.subscriptions` (the Subscriptions row). All Drafts and All Sent start hidden.
final hiddenMailboxItemsProvider = NotifierProvider<PrefsStringSet, Set<String>>(
  () => PrefsStringSet('mailboxes.hidden', defaults: {'v.allDrafts', 'v.allSent'}),
);

/// Account sections collapsed on the Mailboxes screen.
final collapsedAccountsProvider = NotifierProvider<PrefsStringSet, Set<String>>(
  () => PrefsStringSet('mailboxes.collapsedAccounts'),
);

/// Folders whose subfolders are shown.
final expandedFoldersProvider = NotifierProvider<PrefsStringSet, Set<String>>(
  () => PrefsStringSet('mailboxes.expandedFolders'),
);

/// Accounts whose unsubscribed folders show on the Mailboxes screen too
/// (Show All Folders, in the account's settings). Off by default.
final showAllFoldersProvider = NotifierProvider<PrefsStringSet, Set<String>>(
  () => PrefsStringSet('mailboxes.showAllFolders'),
);

/// The criteria behind the Filter button (Unread by default).
final filterCriteriaProvider = NotifierProvider<FilterCriteria, Set<QuickFilter>>(FilterCriteria.new);

class FilterCriteria extends Notifier<Set<QuickFilter>> {
  static const key = 'list.filterCriteria';

  @override
  Set<QuickFilter> build() {
    ref.watch(prefsEpochProvider);
    final names = ref.watch(sharedPreferencesProvider).getStringList(key);
    if (names == null) return const {QuickFilter.unread};
    return {for (final n in names) ...QuickFilter.values.where((f) => f.name == n)};
  }

  Future<void> set(Set<QuickFilter> filters) async {
    state = filters;
    await ref.read(sharedPreferencesProvider).setStringList(key, [for (final f in filters) f.name]);
  }
}

/// Recent search queries, newest first.
final recentSearchesProvider = NotifierProvider<RecentSearches, List<String>>(RecentSearches.new);

class RecentSearches extends Notifier<List<String>> {
  static const key = 'search.recent';
  static const max = 8;

  @override
  List<String> build() {
    ref.watch(prefsEpochProvider);
    return ref.watch(sharedPreferencesProvider).getStringList(key) ?? const [];
  }

  Future<void> add(String query) async {
    final q = query.trim();
    if (q.isEmpty) return;
    state = [q, ...state.where((s) => s != q)].take(max).toList();
    await ref.read(sharedPreferencesProvider).setStringList(key, state);
  }

  Future<void> clear() async {
    state = const [];
    await ref.read(sharedPreferencesProvider).remove(key);
  }
}

// Smart Mailboxes ------------------------------------------------------------------------

/// A saved search shown on the Mailboxes screen.
@immutable
final class SmartMailbox {
  const SmartMailbox({required this.id, required this.name, required this.query, this.scope, this.accountId});

  final String id;
  final String name;
  final String query;

  /// Encoded MailboxRef (see MailboxRefCodec); null means all mailboxes.
  final String? scope;

  /// The account whose server keeps it: the account of its folder. Null for
  /// the others, which the home account keeps ([smartMailboxHomeProvider]).
  final String? accountId;
}

/// Settings › Smart Mailboxes › Sync via: an account id, [off], or null for
/// the default, the first account.
final smartMailboxSyncViaProvider = NotifierProvider<SmartMailboxSyncVia, String?>(SmartMailboxSyncVia.new);

class SmartMailboxSyncVia extends Notifier<String?> {
  static const key = 'smartMailboxes.syncVia';
  static const off = 'off';

  @override
  String? build() {
    ref.watch(prefsEpochProvider);
    return ref.watch(sharedPreferencesProvider).getString(key);
  }

  Future<void> set(String? value) async {
    state = value;
    final prefs = ref.read(sharedPreferencesProvider);
    await (value == null ? prefs.remove(key) : prefs.setString(key, value));
  }
}

/// The home account, which keeps the Smart Mailboxes that search every
/// account: the one chosen under Sync via, else the first account (the
/// first but Gmail, which can't keep them). Null when syncing is off or
/// there is no account.
final smartMailboxHomeProvider = Provider<String?>((ref) {
  final choice = ref.watch(smartMailboxSyncViaProvider);
  if (choice == SmartMailboxSyncVia.off) return null;
  final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
  if (accounts.isEmpty) return null;
  if (accounts.any((a) => a.id == choice)) return choice;
  return (accounts.where((a) => a.provider != ProviderKind.gmail).firstOrNull ?? accounts.first).id;
});

/// How the Smart Mailboxes stand with the servers.
@immutable
final class SmartMailboxSyncStatus {
  const SmartMailboxSyncStatus({
    this.pending = false,
    this.running = false,
    this.synced = const {},
    this.failed = const {},
    this.unsupported = const {},
    this.newerFormat = const {},
    this.lastRound,
  });

  /// Changes made here that no round has taken to the servers yet.
  final bool pending;
  final bool running;

  /// Accounts in step after the last round, and where they keep the
  /// document (null: nothing to keep yet).
  final Map<String, ServerStorage?> synced;

  /// Accounts the last round couldn't reach, with the reason.
  final Map<String, String> failed;

  /// Accounts whose server can't keep Smart Mailboxes (Gmail).
  final Set<String> unsupported;

  /// Accounts whose Smart Mailboxes a newer Loupe wrote (left alone).
  final Set<String> newerFormat;
  final DateTime? lastRound;

  SmartMailboxSyncStatus copyWith({bool? pending, bool? running}) => SmartMailboxSyncStatus(
    pending: pending ?? this.pending,
    running: running ?? this.running,
    synced: synced,
    failed: failed,
    unsupported: unsupported,
    newerFormat: newerFormat,
    lastRound: lastRound,
  );
}

final smartMailboxSyncStatusProvider = NotifierProvider<SmartMailboxSyncStatusNotifier, SmartMailboxSyncStatus>(
  SmartMailboxSyncStatusNotifier.new,
);

class SmartMailboxSyncStatusNotifier extends Notifier<SmartMailboxSyncStatus> {
  @override
  SmartMailboxSyncStatus build() {
    ref.watch(prefsEpochProvider);
    return const SmartMailboxSyncStatus();
  }

  void set(SmartMailboxSyncStatus status) => state = status;
}

final smartMailboxesProvider = NotifierProvider<SmartMailboxes, List<SmartMailbox>>(SmartMailboxes.new);

/// Smart Mailboxes, kept on this device (with deletions, for 30 days) and
/// synced with the mail servers as docs/smart-mailboxes-format.md
/// describes. A sync round runs after every change, after every mail sync,
/// and when the accounts or the home account change. Rounds are idempotent,
/// so changes made offline simply go out with a later one.
class SmartMailboxes extends Notifier<List<SmartMailbox>> {
  /// Before syncing existed: a list of `{id, name, query, scope}`. Read once,
  /// on the first start of this version (the migration).
  static const legacyKey = 'search.smartMailboxes';

  /// `{"records": [SmartMailboxRecord…]}`.
  static const key = 'search.smartMailboxes.v2';

  /// Coalesces bursts of triggers (several accounts finishing a sync).
  static const debounce = Duration(seconds: 2);

  List<SmartMailboxRecord> _records = const [];
  Timer? _timer;
  bool _running = false;
  bool _again = false;

  /// Everything kept here, deletions included.
  List<SmartMailboxRecord> get records => _records;

  @override
  List<SmartMailbox> build() {
    ref.watch(prefsEpochProvider);
    _records = _load(ref.watch(sharedPreferencesProvider));
    ref.onDispose(() => _timer?.cancel());
    String accountIds(AsyncValue<List<MailAccount>> accounts) =>
        [for (final a in accounts.value ?? const <MailAccount>[]) a.id].join(',');
    // Every finished mail sync (pull to refresh, polling, IDLE) brings the
    // Smart Mailboxes up to date too.
    String syncs(AsyncValue<List<AccountSyncStatus>> statuses) => [
      for (final s in statuses.value ?? const <AccountSyncStatus>[])
        '${s.accountId}@${s.lastSuccess?.millisecondsSinceEpoch}',
    ].join(',');
    ref.listen(accountsProvider.select(accountIds), (_, _) => _schedule());
    ref.listen(smartMailboxHomeProvider, (_, _) => _schedule());
    ref.listen(syncStatusProvider.select(syncs), (_, _) => _schedule());
    return _visible(_records);
  }

  Future<SmartMailbox> add(String name, String query, {String? scope}) async {
    final now = clock.now();
    final (portable, accountId) = _portableScope(scope);
    final record = SmartMailboxRecord(
      SmartMailboxEntry(
        id: now.microsecondsSinceEpoch.toRadixString(36),
        name: name,
        query: query,
        scope: portable,
        modifiedAt: nextModifiedAt(null, now),
      ),
      accountId: accountId,
    );
    await _change([..._records, record]);
    return _view(record);
  }

  Future<void> rename(String id, String name) => _edit(id, (e, at) => e.copyWith(name: name, modifiedAt: at));

  Future<void> remove(String id) => _edit(id, (e, at) => e.tombstone(at));

  Future<void> _edit(String id, SmartMailboxEntry Function(SmartMailboxEntry e, DateTime at) change) {
    final now = clock.now();
    return _change([
      for (final r in _records)
        r.id == id && !r.entry.deleted
            ? SmartMailboxRecord(change(r.entry, nextModifiedAt(r.entry.modifiedAt, now)), accountId: r.accountId)
            : r,
    ]);
  }

  Future<void> _change(List<SmartMailboxRecord> records) async {
    await _store(ref, records);
    ref
        .read(smartMailboxSyncStatusProvider.notifier)
        .set(ref.read(smartMailboxSyncStatusProvider).copyWith(pending: true));
    _schedule(const Duration(seconds: 1));
  }

  void _schedule([Duration delay = debounce]) {
    _timer?.cancel();
    _timer = Timer(delay, () => unawaited(sync()));
  }

  /// Syncs with the servers now. Never throws: what can't be synced waits
  /// for the next round.
  Future<void> sync() async {
    _timer?.cancel();
    if (_running) {
      _again = true;
      return;
    }
    final r = ref;
    final status = r.read(smartMailboxSyncStatusProvider.notifier);
    _running = true;
    try {
      do {
        _again = false;
        final home = r.read(smartMailboxHomeProvider);
        final accounts = r.read(accountsProvider).value ?? const <MailAccount>[];
        if (home == null || accounts.isEmpty) {
          // Sync turned off, or the last account removed, during a round.
          status.set(r.read(smartMailboxSyncStatusProvider).copyWith(running: false));
          return;
        }
        status.set(r.read(smartMailboxSyncStatusProvider).copyWith(running: true));
        final before = _records;
        final report = await syncSmartMailboxes(
          r.read(repositoryProvider),
          before,
          accountIds: [for (final a in accounts) a.id],
          homeAccountId: home,
          now: clock.now(),
        );
        if (!r.mounted) return;
        // Changed here while the round ran: keep those changes, send them next.
        final meanwhile = !identical(before, _records);
        await _store(r, meanwhile ? _combine(report.records, _records) : report.records);
        if (!r.mounted) return;
        _again = _again || meanwhile;
        status.set(
          SmartMailboxSyncStatus(
            pending: meanwhile,
            running: _again,
            synced: report.synced,
            failed: {
              for (final MapEntry(:key, :value) in report.failed.entries)
                if (value.kind != MailErrorKind.unsupported) key: value.message,
            },
            unsupported: {
              for (final MapEntry(:key, :value) in report.failed.entries)
                if (value.kind == MailErrorKind.unsupported) key,
            },
            newerFormat: report.newerFormat,
            lastRound: clock.now(),
          ),
        );
      } while (_again);
    } on Object catch (e, s) {
      // A bug rather than the network (the round handles those): keep what
      // is here and try again with the next trigger.
      debugPrint('Smart Mailbox sync failed: $e\n$s');
      if (r.mounted) status.set(r.read(smartMailboxSyncStatusProvider).copyWith(running: false));
    } finally {
      _running = false;
    }
  }

  Future<void> _store(Ref r, List<SmartMailboxRecord> records) async {
    // Deletions are remembered as long as other devices may need them.
    final horizon = clock.now().toUtc().subtract(tombstoneLifetime);
    records = [
      for (final x in records)
        if (!x.entry.deleted || x.entry.modifiedAt.isAfter(horizon)) x,
    ];
    _records = records;
    state = _visible(records);
    await r
        .read(sharedPreferencesProvider)
        .setString(
          key,
          jsonEncode({
            'records': [for (final x in records) x.toJson()],
          }),
        );
  }

  /// The round's result with changes made here during the round on top
  /// (whichever is newer per entry).
  static List<SmartMailboxRecord> _combine(List<SmartMailboxRecord> synced, List<SmartMailboxRecord> current) {
    final fromRound = {for (final r in synced) r.id: r};
    final seen = <String>{};
    final out = <SmartMailboxRecord>[];
    for (final c in current) {
      seen.add(c.id);
      final s = fromRound[c.id];
      final winner = s == null
          ? null
          : mergeSmartMailboxes([
              [c.entry],
              [s.entry],
            ], now: clock.now()).firstOrNull;
      out.add(winner != null && identical(winner, s?.entry) ? s! : c);
    }
    return [
      ...out,
      for (final s in synced)
        if (!seen.contains(s.id)) s,
    ];
  }

  static List<SmartMailbox> _visible(List<SmartMailboxRecord> records) => [
    for (final r in records)
      if (!r.entry.deleted) _view(r),
  ];

  static SmartMailbox _view(SmartMailboxRecord r) {
    final e = r.entry;
    final path = e.mailboxPath;
    final kind = e.virtualKind;
    final virtual = VirtualMailbox.values.where((v) => v.name == kind).firstOrNull;
    final MailboxRef? scope = path != null && r.accountId != null
        ? RealMailboxRef(MailIds.mailbox(r.accountId!, path))
        : virtual != null
        ? VirtualMailboxRef(virtual)
        : null;
    return SmartMailbox(
      id: e.id,
      name: e.name,
      query: e.query,
      scope: scope == null ? null : MailboxRefCodec.encode(scope),
      accountId: r.accountId,
    );
  }

  /// The shared format's scope and the account keeping it, for an encoded
  /// MailboxRef: a folder is kept by its account, as a path that means the
  /// same on every device.
  static (Map<String, Object?>?, String?) _portableScope(String? scope) {
    if (scope == null) return (null, null);
    try {
      switch (MailboxRefCodec.decode(scope)) {
        case RealMailboxRef(:final mailboxId):
          final (accountId, path) = MailIds.parseMailbox(mailboxId);
          return ({'mailbox': path}, accountId);
        case VirtualMailboxRef(:final kind):
          return ({'virtual': kind.name}, null);
      }
    } on Object {
      return (null, null);
    }
  }

  static List<SmartMailboxRecord> _load(SharedPreferences prefs) {
    final raw = prefs.getString(key);
    try {
      if (raw != null) {
        return [for (final r in (jsonDecode(raw) as Map)['records'] as List) ?SmartMailboxRecord.fromJson(r)];
      }
      final legacy = prefs.getString(legacyKey);
      if (legacy == null) return const [];
      return [for (final e in jsonDecode(legacy) as List) ?_migrate(e)];
    } on Object {
      return const [];
    }
  }

  /// A Smart Mailbox saved before syncing existed. Its id is its creation
  /// time (base-36 microseconds), which serves as its modification time.
  static SmartMailboxRecord? _migrate(Object? json) {
    if (json is! Map) return null;
    final (id, name, query, scope) = (json['id'], json['name'], json['query'], json['scope']);
    if (id is! String || name is! String || query is! String) return null;
    final micros = int.tryParse(id, radix: 36);
    final created = micros == null ? null : DateTime.fromMicrosecondsSinceEpoch(micros, isUtc: true);
    final at = created != null && created.year >= 2020 && created.year < 2100 ? created : DateTime.utc(2026);
    final (portable, accountId) = _portableScope(scope is String ? scope : null);
    return SmartMailboxRecord(
      SmartMailboxEntry(id: id, name: name, query: query, scope: portable, modifiedAt: nextModifiedAt(null, at)),
      accountId: accountId,
    );
  }
}
