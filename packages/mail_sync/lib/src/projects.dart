/// Projects synced through the mail server (docs/projects-format.md): one
/// JSON document in the home account, merged per entry like Smart
/// Mailboxes. Which messages are in a project is not in the document: they
/// carry the project's keyword (`Projects.keyword`).
library;

import 'dart:convert';

import 'package:mail_model/mail_model.dart';

import 'synced_entries.dart';
import 'util.dart';

/// `format` of the document.
const projectsFormat = 'loupe.projects';

/// The newest document `version` this code reads and writes.
const projectsVersion = 1;

/// One project in the shared format (an entry of the document).
final class ProjectEntry implements SyncedEntry {
  const ProjectEntry({
    required this.id,
    required this.modifiedAt,
    this.name = '',
    this.color,
    this.done = false,
    this.query = '',
    this.deleted = false,
    this.extra = const {},
  });

  /// Unique and stable, and a valid project id (`Projects.isValidId`):
  /// Loupe uses the creation time in microseconds, in base 36.
  @override
  final String id;
  final String name;

  /// `#rrggbb`, or null for the default.
  final String? color;

  /// Finished: kept, but out of the way (not among the tiles).
  final bool done;

  /// A search in the Loupe search language whose matches join the project
  /// as they arrive; empty for none.
  final String query;

  @override
  final DateTime modifiedAt;
  @override
  final bool deleted;

  /// Fields this version doesn't know, written back unchanged.
  final Map<String, Object?> extra;

  /// The keyword its messages carry.
  String get keyword => Projects.keyword(id);

  ProjectEntry copyWith({String? name, String? Function()? color, bool? done, String? query, DateTime? modifiedAt}) =>
      ProjectEntry(
        id: id,
        name: name ?? this.name,
        color: color == null ? this.color : color(),
        done: done ?? this.done,
        query: query ?? this.query,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        extra: extra,
      );

  /// This project deleted at [at]: a tombstone holds only the id.
  ProjectEntry tombstone(DateTime at) => ProjectEntry(id: id, modifiedAt: at, deleted: true);

  static String _time(DateTime t) => t.toUtc().toIso8601String();

  Map<String, Object?> toJson() => deleted
      ? {'id': id, 'modifiedAt': _time(modifiedAt), 'deleted': true}
      : {
          ...extra,
          'id': id,
          'name': name,
          'color': ?color,
          if (done) 'done': true,
          if (query.isNotEmpty) 'query': query,
          'modifiedAt': _time(modifiedAt),
        };

  static const _known = {'id', 'name', 'color', 'done', 'query', 'modifiedAt', 'deleted'};
  static final _color = RegExp(r'^#[0-9a-fA-F]{6}$');

  /// Reads an entry; null without a valid id or `modifiedAt`.
  static ProjectEntry? fromJson(Object? json) {
    if (json is! Map) return null;
    final id = json['id'];
    final modified = json['modifiedAt'];
    final at = modified is String ? DateTime.tryParse(modified) : null;
    if (id is! String || !Projects.isValidId(id) || at == null) return null;
    final color = json['color'];
    return ProjectEntry(
      id: id,
      name: json['name'] is String ? json['name']! as String : '',
      color: color is String && _color.hasMatch(color) ? color.toLowerCase() : null,
      done: json['done'] == true,
      query: json['query'] is String ? json['query']! as String : '',
      modifiedAt: at.toUtc(),
      deleted: json['deleted'] == true,
      extra: Map.unmodifiable({
        for (final MapEntry(:key, :value) in json.cast<String, Object?>().entries)
          if (!_known.contains(key)) key: value,
      }),
    );
  }

  @override
  String get canonical => jsonEncode(sortedJson(toJson()));

  @override
  String toString() => 'ProjectEntry($canonical)';
}

/// A parsed document: the entries this version understands, and the rest
/// to write back as it was.
final class ProjectDocument {
  const ProjectDocument({this.entries = const [], this.unreadable = const [], this.version = projectsVersion});

  final List<ProjectEntry> entries;
  final List<Object?> unreadable;
  final int version;

  /// Written by a newer app: never overwritten.
  bool get isNewer => version > projectsVersion;

  /// Throws [FormatException] when [text] isn't a projects document.
  static ProjectDocument parse(String text) {
    final json = jsonDecode(text);
    if (json is! Map || json['format'] != projectsFormat) throw const FormatException('Not a projects document');
    final version = json['version'];
    final list = json['entries'];
    final entries = <ProjectEntry>[];
    final unreadable = <Object?>[];
    for (final e in list is List ? list : const []) {
      final entry = ProjectEntry.fromJson(e);
      entry == null ? unreadable.add(e) : entries.add(entry);
    }
    return ProjectDocument(
      entries: entries,
      unreadable: unreadable,
      version: version is int ? version : projectsVersion,
    );
  }

  String encode() => jsonEncode({
    'format': projectsFormat,
    'version': projectsVersion,
    'entries': [for (final e in entries) e.toJson(), ...unreadable],
  });

  /// Same entries, in any order.
  bool sameContent(ProjectDocument other) => _fingerprint() == other._fingerprint();

  String _fingerprint() => ([
    for (final e in entries) e.canonical,
    for (final u in unreadable) jsonEncode(sortedJson(u)),
  ]..sort()).join('\n');
}

/// What a sync round did.
final class ProjectSyncReport {
  const ProjectSyncReport({required this.entries, this.storage, this.failed, this.newerFormat = false});

  /// The merged projects for this device (with tombstones).
  final List<ProjectEntry> entries;

  /// Where the home account keeps the document now (null: nothing to keep
  /// yet, or not synced).
  final ServerStorage? storage;

  /// Why the round didn't reach the server; the changes wait for the next.
  final MailException? failed;

  /// A newer app wrote the document: left alone.
  final bool newerFormat;

  bool get synced => failed == null && !newerFormat;
}

/// One sync round of [local] with the document on [homeAccountId]'s server:
/// read, merge, and write back when it changed. Idempotent: run one after
/// every change and every mail sync; what didn't reach the server goes with
/// the next.
Future<ProjectSyncReport> syncProjects(
  MailRepository repository,
  List<ProjectEntry> local, {
  required String homeAccountId,
  required DateTime now,
}) async {
  try {
    final copies = await repository.readServerDocuments(homeAccountId, ServerDocuments.projects);
    final docs = <ProjectDocument>[];
    for (final copy in copies) {
      try {
        docs.add(ProjectDocument.parse(copy.content));
      } on FormatException {
        // Unreadable; a valid copy replaces it.
      }
    }
    if (docs.any((d) => d.isNewer)) return ProjectSyncReport(entries: local, newerFormat: true);
    final merged = mergeEntries([local, for (final d in docs) d.entries], now: now);
    final next = ProjectDocument(entries: merged, unreadable: uniqueJson([for (final d in docs) ...d.unreadable]));
    final ServerStorage? storage;
    if (copies.length == 1 && docs.length == 1 && docs.single.sameContent(next)) {
      storage = copies.single.storage;
    } else if (copies.isEmpty && next.entries.isEmpty && next.unreadable.isEmpty) {
      storage = null;
    } else {
      storage = await repository.writeServerDocument(
        homeAccountId,
        ServerDocuments.projects,
        next.encode(),
        replaces: copies,
      );
    }
    return ProjectSyncReport(entries: merged, storage: storage);
  } on MailException catch (e) {
    return ProjectSyncReport(entries: local, failed: e);
  } on Object catch (e) {
    return ProjectSyncReport(entries: local, failed: asMailException(e, 'Projects couldn’t be synced'));
  }
}
