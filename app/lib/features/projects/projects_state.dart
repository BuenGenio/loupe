import 'dart:async';
import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart' show Color;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers.dart';
import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart' show sharedPreferencesProvider;
import '../../settings/ui_state.dart' show smartMailboxHomeProvider;

/// A project as the app shows it (see docs/projects-format.md): its
/// messages carry [keyword], in any account.
@immutable
final class Project {
  const Project({required this.id, required this.name, required this.color, this.done = false, this.query = ''});

  final String id;
  final String name;
  final Color color;

  /// Finished: listed after the others, and not among the tiles.
  final bool done;

  /// The search whose matches join it as they arrive (none yet: phase 4).
  final String query;

  String get keyword => Projects.keyword(id);

  MailboxRef get ref => KeywordMailboxRef(keyword);

  @override
  bool operator ==(Object other) =>
      other is Project &&
      other.id == id &&
      other.name == name &&
      other.color == color &&
      other.done == done &&
      other.query == query;

  @override
  int get hashCode => Object.hash(id, name, color, done, query);
}

/// The colours offered for projects. Stored as `#rrggbb`, so other apps
/// reading the document see the same; any other colour they write is shown
/// as it is.
abstract final class ProjectColors {
  static const palette = [
    Color(0xFFFF3B30),
    Color(0xFFFF9500),
    Color(0xFFFFCC00),
    Color(0xFF34C759),
    Color(0xFF30B0C7),
    Color(0xFF007AFF),
    Color(0xFFAF52DE),
    Color(0xFFFF2D55),
  ];

  /// A project's colour: the one it has, else one picked by its id.
  static Color of(ProjectEntry e) {
    final hex = e.color;
    if (hex != null) return Color(0xFF000000 | int.parse(hex.substring(1), radix: 16));
    return palette[e.id.codeUnits.fold(0, (h, c) => (h * 31 + c) & 0x7fffffff) % palette.length];
  }

  static String hex(Color c) => '#${(c.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';
}

/// How the projects stand with the home account's server.
@immutable
final class ProjectSyncStatus {
  const ProjectSyncStatus({
    this.pending = false,
    this.running = false,
    this.accountId,
    this.synced = false,
    this.unsupported = false,
    this.newerFormat = false,
    this.error,
  });

  /// Changes made here that no round has taken to the server yet.
  final bool pending;
  final bool running;

  /// The account the last round synced with.
  final String? accountId;
  final bool synced;

  /// The server can't keep them (Gmail).
  final bool unsupported;

  /// A newer Loupe wrote them; left alone.
  final bool newerFormat;
  final String? error;

  ProjectSyncStatus copyWith({bool? pending, bool? running}) => ProjectSyncStatus(
    pending: pending ?? this.pending,
    running: running ?? this.running,
    accountId: accountId,
    synced: synced,
    unsupported: unsupported,
    newerFormat: newerFormat,
    error: error,
  );
}

final projectSyncStatusProvider = NotifierProvider<ProjectSyncStatusNotifier, ProjectSyncStatus>(
  ProjectSyncStatusNotifier.new,
);

class ProjectSyncStatusNotifier extends Notifier<ProjectSyncStatus> {
  @override
  ProjectSyncStatus build() {
    ref.watch(prefsEpochProvider);
    return const ProjectSyncStatus();
  }

  void set(ProjectSyncStatus status) => state = status;
}

/// The projects: active ones by name, then the done ones.
final projectsProvider = NotifierProvider<ProjectsNotifier, List<Project>>(ProjectsNotifier.new);

/// Projects by id.
final projectsByIdProvider = Provider<Map<String, Project>>(
  (ref) => {for (final p in ref.watch(projectsProvider)) p.id: p},
);

/// Project names by keyword (rules that add a project's keyword read as it).
final projectNamesProvider = Provider<Map<String, String>>(
  (ref) => {for (final p in ref.watch(projectsProvider)) p.keyword: p.name},
);

/// Unread messages of each project, by keyword.
final projectUnreadProvider = StreamProvider<Map<String, int>>((ref) {
  final keywords = ref.watch(projectsProvider.select((ps) => {for (final p in ps) p.keyword}.toList()..sort()));
  return ref.watch(repositoryProvider).watchKeywordUnread(keywords.toSet());
});

/// Projects, kept on this device (with deletions, for 30 days) and synced
/// with the home account's server (the one Smart Mailboxes sync via) as
/// docs/projects-format.md describes. A round runs after every change,
/// after every mail sync, and when the accounts or the home account change.
class ProjectsNotifier extends Notifier<List<Project>> {
  /// `{"entries": [ProjectEntry…]}`.
  static const key = 'projects.v1';

  /// Coalesces bursts of triggers (several accounts finishing a sync).
  static const debounce = Duration(seconds: 2);

  List<ProjectEntry> _entries = const [];
  Timer? _timer;
  bool _running = false;
  bool _again = false;

  /// Everything kept here, deletions included.
  List<ProjectEntry> get entries => _entries;

  @override
  List<Project> build() {
    ref.watch(prefsEpochProvider);
    _entries = _load(ref.watch(sharedPreferencesProvider));
    ref.onDispose(() => _timer?.cancel());
    String accountIds(AsyncValue<List<MailAccount>> accounts) =>
        [for (final a in accounts.value ?? const <MailAccount>[]) a.id].join(',');
    String syncs(AsyncValue<List<AccountSyncStatus>> statuses) => [
      for (final s in statuses.value ?? const <AccountSyncStatus>[])
        '${s.accountId}@${s.lastSuccess?.millisecondsSinceEpoch}',
    ].join(',');
    ref.listen(accountsProvider.select(accountIds), (_, _) => _schedule());
    ref.listen(smartMailboxHomeProvider, (_, _) => _schedule());
    ref.listen(syncStatusProvider.select(syncs), (_, _) => _schedule());
    return _visible(_entries);
  }

  Future<Project> add(String name, {Color? color}) async {
    final now = clock.now();
    final id = now.microsecondsSinceEpoch.toRadixString(36);
    final entry = ProjectEntry(
      id: id,
      name: name.trim(),
      color: color == null ? null : ProjectColors.hex(color),
      modifiedAt: nextModifiedAt(null, now),
    );
    await _change([..._entries, entry]);
    return _view(entry);
  }

  Future<void> edit(String id, {String? name, Color? color, bool? done}) => _edit(
    id,
    (e, at) => e.copyWith(
      name: name?.trim(),
      color: color == null ? null : () => ProjectColors.hex(color),
      done: done,
      modifiedAt: at,
    ),
  );

  Future<void> remove(String id) => _edit(id, (e, at) => e.tombstone(at));

  Future<void> _edit(String id, ProjectEntry Function(ProjectEntry e, DateTime at) change) {
    final now = clock.now();
    return _change([
      for (final e in _entries) e.id == id && !e.deleted ? change(e, nextModifiedAt(e.modifiedAt, now)) : e,
    ]);
  }

  Future<void> _change(List<ProjectEntry> entries) async {
    await _store(ref, entries);
    ref.read(projectSyncStatusProvider.notifier).set(ref.read(projectSyncStatusProvider).copyWith(pending: true));
    _schedule(const Duration(seconds: 1));
  }

  void _schedule([Duration delay = debounce]) {
    _timer?.cancel();
    _timer = Timer(delay, () => unawaited(sync()));
  }

  /// Syncs with the home account's server now. Never throws: what can't be
  /// synced waits for the next round.
  Future<void> sync() async {
    _timer?.cancel();
    if (_running) {
      _again = true;
      return;
    }
    final r = ref;
    final status = r.read(projectSyncStatusProvider.notifier);
    _running = true;
    try {
      do {
        _again = false;
        final home = r.read(smartMailboxHomeProvider);
        if (home == null) {
          // Sync turned off, or no account: they stay here.
          status.set(const ProjectSyncStatus());
          return;
        }
        status.set(r.read(projectSyncStatusProvider).copyWith(running: true));
        final before = _entries;
        final report = await syncProjects(r.read(repositoryProvider), before, homeAccountId: home, now: clock.now());
        if (!r.mounted) return;
        // Changed here while the round ran: keep those changes, send them next.
        final meanwhile = !identical(before, _entries);
        await _store(r, meanwhile ? mergeEntries([_entries, report.entries], now: clock.now()) : report.entries);
        if (!r.mounted) return;
        _again = _again || meanwhile;
        final failed = report.failed;
        status.set(
          ProjectSyncStatus(
            pending: meanwhile || !report.synced,
            running: _again,
            accountId: home,
            synced: report.synced,
            unsupported: failed?.kind == MailErrorKind.unsupported,
            newerFormat: report.newerFormat,
            error: failed == null || failed.kind == MailErrorKind.unsupported ? null : failed.message,
          ),
        );
      } while (_again);
    } on Object catch (e, s) {
      debugPrint('Project sync failed: $e\n$s');
      if (r.mounted) status.set(r.read(projectSyncStatusProvider).copyWith(running: false));
    } finally {
      _running = false;
    }
  }

  Future<void> _store(Ref r, List<ProjectEntry> entries) async {
    final horizon = clock.now().toUtc().subtract(tombstoneLifetime);
    entries = [
      for (final e in entries)
        if (!e.deleted || e.modifiedAt.isAfter(horizon)) e,
    ];
    _entries = entries;
    state = _visible(entries);
    await r
        .read(sharedPreferencesProvider)
        .setString(
          key,
          jsonEncode({
            'entries': [for (final e in entries) e.toJson()],
          }),
        );
  }

  static List<Project> _visible(List<ProjectEntry> entries) {
    final live = [
      for (final e in entries)
        if (!e.deleted) _view(e),
    ];
    int byName(Project a, Project b) => a.name.toLowerCase().compareTo(b.name.toLowerCase());
    return [...live.where((p) => !p.done).toList()..sort(byName), ...live.where((p) => p.done).toList()..sort(byName)];
  }

  static Project _view(ProjectEntry e) =>
      Project(id: e.id, name: e.name, color: ProjectColors.of(e), done: e.done, query: e.query);

  static List<ProjectEntry> _load(SharedPreferences prefs) {
    final raw = prefs.getString(key);
    if (raw == null) return const [];
    try {
      return [for (final e in (jsonDecode(raw) as Map)['entries'] as List) ?ProjectEntry.fromJson(e)];
    } on Object {
      return const [];
    }
  }
}
