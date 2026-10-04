/// Smart Mailboxes (saved searches) synced through the mail servers.
///
/// The shared format is documented in docs/smart-mailboxes-format.md: one
/// JSON document per account, holding the Smart Mailboxes of that account's
/// folders and, on the home account, those that search every account.
library;

import 'dart:convert';

import 'package:mail_model/mail_model.dart';

import 'util.dart';

/// `format` of the document.
const smartMailboxesFormat = 'loupe.smart-mailboxes';

/// The newest document `version` this code reads and writes.
const smartMailboxesVersion = 1;

/// How long a deletion is remembered, so other devices learn of it.
const tombstoneLifetime = Duration(days: 30);

/// One Smart Mailbox in the shared format (an entry of the document).
final class SmartMailboxEntry {
  const SmartMailboxEntry({
    required this.id,
    required this.modifiedAt,
    this.name = '',
    this.query = '',
    this.scope,
    this.deleted = false,
    this.extra = const {},
  });

  /// Unique and stable (Loupe: base-36 creation time in microseconds; any
  /// string will do).
  final String id;
  final String name;

  /// Loupe / Expression Search query text.
  final String query;

  /// Where it searches: null for every mailbox of every account,
  /// `{"mailbox": "<path>"}` for one folder of the account whose document
  /// holds the entry, `{"virtual": "<kind>"}` for a unified mailbox
  /// (`allInboxes`, `unread`, `flagged`, `vip`, `allDrafts`, `allSent`).
  final Map<String, Object?>? scope;

  /// When it last changed (UTC, millisecond precision): the newest wins.
  final DateTime modifiedAt;

  /// A tombstone: deleted at [modifiedAt].
  final bool deleted;

  /// Fields this version doesn't know (an icon, a colour, add-on data…),
  /// written back unchanged.
  final Map<String, Object?> extra;

  /// The folder path of a `{"mailbox": …}` scope (null unless a string:
  /// another app's document may hold anything).
  String? get mailboxPath => switch (scope?['mailbox']) {
    final String path => path,
    _ => null,
  };

  /// The kind of a `{"virtual": …}` scope.
  String? get virtualKind => switch (scope?['virtual']) {
    final String kind => kind,
    _ => null,
  };

  /// Whether the entry belongs in the document of the account that owns its
  /// folder (rather than the home account's).
  bool get isAccountScoped => mailboxPath != null;

  SmartMailboxEntry copyWith({String? name, String? query, DateTime? modifiedAt}) => SmartMailboxEntry(
    id: id,
    name: name ?? this.name,
    query: query ?? this.query,
    scope: scope,
    modifiedAt: modifiedAt ?? this.modifiedAt,
    deleted: deleted,
    extra: extra,
  );

  /// This entry deleted at [at]. Tombstones keep only the id and the scope
  /// (which says which document they belong to).
  SmartMailboxEntry tombstone(DateTime at) => SmartMailboxEntry(id: id, scope: scope, modifiedAt: at, deleted: true);

  static String _time(DateTime t) => t.toUtc().toIso8601String();

  Map<String, Object?> toJson() => deleted
      ? {'id': id, 'scope': ?scope, 'modifiedAt': _time(modifiedAt), 'deleted': true}
      : {...extra, 'id': id, 'name': name, 'query': query, 'scope': scope, 'modifiedAt': _time(modifiedAt)};

  /// Reads an entry; null when it lacks an id or a valid `modifiedAt`.
  static SmartMailboxEntry? fromJson(Object? json) {
    if (json is! Map) return null;
    final id = json['id'];
    final modified = json['modifiedAt'];
    final at = modified is String ? DateTime.tryParse(modified) : null;
    if (id is! String || id.isEmpty || at == null) return null;
    final scope = json['scope'];
    return SmartMailboxEntry(
      id: id,
      name: json['name'] is String ? json['name']! as String : '',
      query: json['query'] is String ? json['query']! as String : '',
      scope: scope is Map ? Map.unmodifiable(scope.cast<String, Object?>()) : null,
      modifiedAt: at.toUtc(),
      deleted: json['deleted'] == true,
      extra: Map.unmodifiable({
        for (final MapEntry(:key, :value) in json.cast<String, Object?>().entries)
          if (!const {'id', 'name', 'query', 'scope', 'modifiedAt', 'deleted'}.contains(key)) key: value,
      }),
    );
  }

  /// The canonical JSON, for comparisons and tie-breaks.
  String get canonical => jsonEncode(_sorted(toJson()));

  static Object? _sorted(Object? v) => switch (v) {
    final Map<Object?, Object?> m => {for (final k in (m.keys.map((k) => '$k').toList()..sort())) k: _sorted(m[k])},
    final List<Object?> l => [for (final e in l) _sorted(e)],
    _ => v,
  };

  @override
  String toString() => 'SmartMailboxEntry($canonical)';
}

/// A parsed document: entries this version understands, and everything else
/// (entries it can't read) to write back as it was.
final class SmartMailboxDocument {
  const SmartMailboxDocument({
    this.entries = const [],
    this.unreadable = const [],
    this.version = smartMailboxesVersion,
  });

  final List<SmartMailboxEntry> entries;
  final List<Object?> unreadable;

  /// The document's `version`; newer than [smartMailboxesVersion] means a
  /// newer app wrote it and this one must not overwrite it.
  final int version;

  bool get isNewer => version > smartMailboxesVersion;

  /// Parses [text]. Throws [FormatException] when it isn't a Smart Mailboxes
  /// document.
  static SmartMailboxDocument parse(String text) {
    final json = jsonDecode(text);
    if (json is! Map || json['format'] != smartMailboxesFormat) {
      throw const FormatException('Not a Smart Mailboxes document');
    }
    final version = json['version'];
    final list = json['entries'];
    final entries = <SmartMailboxEntry>[];
    final unreadable = <Object?>[];
    for (final e in list is List ? list : const []) {
      final entry = SmartMailboxEntry.fromJson(e);
      if (entry == null) {
        unreadable.add(e);
      } else {
        entries.add(entry);
      }
    }
    return SmartMailboxDocument(
      entries: entries,
      unreadable: unreadable,
      version: version is int ? version : smartMailboxesVersion,
    );
  }

  String encode() => jsonEncode({
    'format': smartMailboxesFormat,
    'version': smartMailboxesVersion,
    'entries': [for (final e in entries) e.toJson(), ...unreadable],
  });

  /// Same entries, in any order.
  bool sameContent(SmartMailboxDocument other) => _fingerprint() == other._fingerprint();

  String _fingerprint() => ([
    for (final e in entries) e.canonical,
    for (final u in unreadable) jsonEncode(SmartMailboxEntry._sorted(u)),
  ]..sort()).join('\n');
}

/// Whether [a] wins over [b] (same id): the later `modifiedAt`; on a tie a
/// tombstone, then the larger canonical JSON, so every device agrees.
bool _wins(SmartMailboxEntry a, SmartMailboxEntry b) {
  final c = a.modifiedAt.compareTo(b.modifiedAt);
  if (c != 0) return c > 0;
  if (a.deleted != b.deleted) return a.deleted;
  return a.canonical.compareTo(b.canonical) > 0;
}

/// The `modifiedAt` for a change made [now] to an entry last changed at
/// [previous]: never earlier, so an edit always wins over the version it
/// replaces, even when another device's clock ran ahead.
DateTime nextModifiedAt(DateTime? previous, DateTime now) {
  final t = DateTime.fromMillisecondsSinceEpoch(now.millisecondsSinceEpoch, isUtc: true);
  if (previous == null || t.isAfter(previous)) return t;
  return previous.toUtc().add(const Duration(milliseconds: 1));
}

/// Merges entry lists by id: last writer wins per entry, and tombstones
/// older than [tombstoneLifetime] are dropped. Order: first appearance
/// across [lists] (so the local order stays and new entries follow it).
List<SmartMailboxEntry> mergeSmartMailboxes(Iterable<Iterable<SmartMailboxEntry>> lists, {required DateTime now}) {
  final byId = <String, SmartMailboxEntry>{};
  for (final list in lists) {
    for (final e in list) {
      final current = byId[e.id];
      if (current == null || _wins(e, current)) byId[e.id] = e;
    }
  }
  final horizon = now.toUtc().subtract(tombstoneLifetime);
  return [
    for (final e in byId.values)
      if (!e.deleted || e.modifiedAt.isAfter(horizon)) e,
  ];
}

/// A Smart Mailbox as this device keeps it: the shared entry plus the
/// account whose document holds it. [accountId] is null for those that
/// search every account (or a unified mailbox); they live in the home
/// account's document.
final class SmartMailboxRecord {
  const SmartMailboxRecord(this.entry, {this.accountId});

  final SmartMailboxEntry entry;
  final String? accountId;

  String get id => entry.id;

  Map<String, Object?> toJson() => {'entry': entry.toJson(), 'accountId': ?accountId};

  static SmartMailboxRecord? fromJson(Object? json) {
    if (json is! Map) return null;
    final entry = SmartMailboxEntry.fromJson(json['entry']);
    final accountId = json['accountId'];
    return entry == null ? null : SmartMailboxRecord(entry, accountId: accountId is String ? accountId : null);
  }
}

/// What one sync round did.
final class SmartMailboxSyncReport {
  const SmartMailboxSyncReport({
    required this.records,
    this.synced = const {},
    this.failed = const {},
    this.newerFormat = const {},
  });

  /// The merged state for this device (with tombstones).
  final List<SmartMailboxRecord> records;

  /// Accounts whose document is now in step with this device, and where it
  /// is stored (null: nothing to store yet).
  final Map<String, ServerStorage?> synced;

  /// Accounts that couldn't be synced (offline, server errors). Their
  /// changes stay on this device and go out with the next round.
  final Map<String, MailException> failed;

  /// Accounts whose document a newer app version wrote; left alone.
  final Set<String> newerFormat;
}

/// One sync round of Smart Mailboxes against the servers of [accountIds]:
/// reads every account's document, merges it with [local] and writes it
/// back where it changed. Unified Smart Mailboxes go to [homeAccountId];
/// those of one folder go to that folder's account.
///
/// Rounds are idempotent: run one after every change, on every refresh and
/// after being offline; whatever didn't reach a server goes with the next.
Future<SmartMailboxSyncReport> syncSmartMailboxes(
  MailRepository repository,
  List<SmartMailboxRecord> local, {
  required List<String> accountIds,
  required String homeAccountId,
  required DateTime now,
}) async {
  var records = [...local];
  final synced = <String, ServerStorage?>{};
  final failed = <String, MailException>{};
  final newer = <String>{};
  for (final accountId in accountIds) {
    final isHome = accountId == homeAccountId;
    bool ours(SmartMailboxRecord r) => r.accountId == accountId || (isHome && r.accountId == null);
    try {
      final copies = await repository.readServerDocuments(accountId, ServerDocuments.smartMailboxes);
      final docs = <SmartMailboxDocument>[];
      for (final copy in copies) {
        try {
          docs.add(SmartMailboxDocument.parse(copy.content));
        } on FormatException {
          // Unreadable; a valid copy replaces it.
        }
      }
      if (docs.any((d) => d.isNewer)) {
        newer.add(accountId);
        continue;
      }
      final mineIds = {
        for (final r in records)
          if (ours(r)) r.id,
      };
      final elsewhere = {
        for (final r in records)
          if (!ours(r)) r.id,
      };
      final remote = <SmartMailboxEntry>[];
      final foreign = <SmartMailboxEntry>[];
      final unreadable = <Object?>[];
      for (final d in docs) {
        unreadable.addAll(d.unreadable);
        for (final e in d.entries) {
          final belongs =
              !elsewhere.contains(e.id) &&
              (e.isAccountScoped || isHome || (e.deleted && e.scope == null && mineIds.contains(e.id)));
          // Unified ones on another account (a former home) and ids this
          // device files elsewhere stay as they are.
          (belongs ? remote : foreign).add(e);
        }
      }
      final mine = [
        for (final r in records)
          if (ours(r)) r.entry,
      ];
      final merged = mergeSmartMailboxes([mine, remote], now: now);
      records = _apply(records, merged, accountId, ours);
      final next = SmartMailboxDocument(
        entries: [
          ...merged,
          ...mergeSmartMailboxes([foreign], now: now),
        ],
        unreadable: _unique(unreadable),
      );
      if (copies.length == 1 && docs.length == 1 && docs.single.sameContent(next)) {
        synced[accountId] = copies.single.storage;
      } else if (copies.isEmpty && next.entries.isEmpty && next.unreadable.isEmpty) {
        synced[accountId] = null;
      } else {
        synced[accountId] = await repository.writeServerDocument(
          accountId,
          ServerDocuments.smartMailboxes,
          next.encode(),
          replaces: copies,
        );
      }
    } on MailException catch (e) {
      failed[accountId] = e;
    } on Object catch (e) {
      // Whatever goes wrong with one account's document leaves the others.
      failed[accountId] = asMailException(e, 'Smart Mailboxes couldn’t be synced');
    }
  }
  return SmartMailboxSyncReport(records: records, synced: synced, failed: failed, newerFormat: newer);
}

/// [records] with the ones [ours] replaced by [merged] in place (dropped
/// when merged away) and new ones appended.
List<SmartMailboxRecord> _apply(
  List<SmartMailboxRecord> records,
  List<SmartMailboxEntry> merged,
  String accountId,
  bool Function(SmartMailboxRecord) ours,
) {
  final byId = {for (final e in merged) e.id: e};
  SmartMailboxRecord record(SmartMailboxEntry e, SmartMailboxRecord? old) {
    // A tombstone from another app may lack the scope: keep where it was filed.
    final oldScope = old?.entry.scope;
    final entry = e.deleted && e.scope == null && oldScope != null ? e.withScope(oldScope) : e;
    return SmartMailboxRecord(entry, accountId: entry.isAccountScoped ? accountId : old?.accountId);
  }

  final seen = <String>{};
  final out = <SmartMailboxRecord>[];
  for (final r in records) {
    if (!ours(r)) {
      out.add(r);
    } else if (byId[r.id] case final e?) {
      seen.add(r.id);
      out.add(record(e, r));
    }
  }
  for (final e in merged) {
    if (seen.add(e.id)) out.add(record(e, null));
  }
  return out;
}

List<Object?> _unique(List<Object?> raw) {
  final seen = <String>{};
  return [
    for (final r in raw)
      if (seen.add(jsonEncode(SmartMailboxEntry._sorted(r)))) r,
  ];
}

extension on SmartMailboxEntry {
  SmartMailboxEntry withScope(Map<String, Object?> scope) => SmartMailboxEntry(
    id: id,
    name: name,
    query: query,
    scope: scope,
    modifiedAt: modifiedAt,
    deleted: deleted,
    extra: extra,
  );
}
