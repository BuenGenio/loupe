/// The per-entry merge shared by the documents Loupe keeps on the mail
/// servers (Smart Mailboxes, projects): docs/smart-mailboxes-format.md,
/// "Merging".
library;

import 'dart:convert';

/// How long a deletion is remembered, so other devices learn of it.
const tombstoneLifetime = Duration(days: 30);

/// An entry of a synced document.
abstract interface class SyncedEntry {
  String get id;

  /// When it last changed (UTC): the newest wins.
  DateTime get modifiedAt;

  /// A tombstone: deleted at [modifiedAt].
  bool get deleted;

  /// The canonical JSON (sorted keys), for comparisons and tie-breaks.
  String get canonical;
}

/// Whether [a] wins over [b] (same id): the later `modifiedAt`; on a tie a
/// tombstone, then the larger canonical JSON, so every device agrees.
bool entryWins(SyncedEntry a, SyncedEntry b) {
  final c = a.modifiedAt.compareTo(b.modifiedAt);
  if (c != 0) return c > 0;
  if (a.deleted != b.deleted) return a.deleted;
  return a.canonical.compareTo(b.canonical) > 0;
}

/// Merges entry lists by id: last writer wins per entry, and tombstones
/// older than [tombstoneLifetime] are dropped. Order: first appearance
/// across [lists] (so the local order stays and new entries follow it).
List<T> mergeEntries<T extends SyncedEntry>(Iterable<Iterable<T>> lists, {required DateTime now}) {
  final byId = <String, T>{};
  for (final list in lists) {
    for (final e in list) {
      final current = byId[e.id];
      if (current == null || entryWins(e, current)) byId[e.id] = e;
    }
  }
  final horizon = now.toUtc().subtract(tombstoneLifetime);
  return [
    for (final e in byId.values)
      if (!e.deleted || e.modifiedAt.isAfter(horizon)) e,
  ];
}

/// The `modifiedAt` for a change made [now] to an entry last changed at
/// [previous]: never earlier, so an edit always wins over the version it
/// replaces, even when another device's clock ran ahead.
DateTime nextModifiedAt(DateTime? previous, DateTime now) {
  final t = DateTime.fromMillisecondsSinceEpoch(now.millisecondsSinceEpoch, isUtc: true);
  if (previous == null || t.isAfter(previous)) return t;
  return previous.toUtc().add(const Duration(milliseconds: 1));
}

/// [v] with every map's keys sorted, for canonical JSON.
Object? sortedJson(Object? v) => switch (v) {
  final Map<Object?, Object?> m => {for (final k in (m.keys.map((k) => '$k').toList()..sort())) k: sortedJson(m[k])},
  final List<Object?> l => [for (final e in l) sortedJson(e)],
  _ => v,
};

/// [raw] without duplicates (by canonical JSON), in order.
List<Object?> uniqueJson(List<Object?> raw) {
  final seen = <String>{};
  return [
    for (final r in raw)
      if (seen.add(jsonEncode(sortedJson(r)))) r,
  ];
}
