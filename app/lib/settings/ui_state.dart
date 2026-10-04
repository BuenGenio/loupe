import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
/// `tag.<keyword>`, `smart.<id>`. All Drafts and All Sent start hidden.
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

/// A saved search shown on the Mailboxes screen.
@immutable
final class SmartMailbox {
  const SmartMailbox({required this.id, required this.name, required this.query, this.scope});

  final String id;
  final String name;
  final String query;

  /// Encoded MailboxRef (see MailboxRefCodec); null means all mailboxes.
  final String? scope;

  Map<String, Object?> toJson() => {'id': id, 'name': name, 'query': query, 'scope': scope};

  factory SmartMailbox.fromJson(Map<String, Object?> json) => SmartMailbox(
    id: json['id']! as String,
    name: json['name']! as String,
    query: json['query']! as String,
    scope: json['scope'] as String?,
  );

  SmartMailbox copyWith({String? name}) => SmartMailbox(id: id, name: name ?? this.name, query: query, scope: scope);
}

final smartMailboxesProvider = NotifierProvider<SmartMailboxes, List<SmartMailbox>>(SmartMailboxes.new);

class SmartMailboxes extends Notifier<List<SmartMailbox>> {
  static const key = 'search.smartMailboxes';

  @override
  List<SmartMailbox> build() {
    ref.watch(prefsEpochProvider);
    final raw = ref.watch(sharedPreferencesProvider).getString(key);
    if (raw == null) return const [];
    try {
      return [for (final e in jsonDecode(raw) as List) SmartMailbox.fromJson((e as Map).cast())];
    } on FormatException {
      return const [];
    }
  }

  Future<SmartMailbox> add(String name, String query, {String? scope}) async {
    final box = SmartMailbox(
      id: DateTime.now().microsecondsSinceEpoch.toRadixString(36),
      name: name,
      query: query,
      scope: scope,
    );
    await _save([...state, box]);
    return box;
  }

  Future<void> rename(String id, String name) =>
      _save([for (final s in state) s.id == id ? s.copyWith(name: name) : s]);

  Future<void> remove(String id) => _save(state.where((s) => s.id != id).toList());

  Future<void> _save(List<SmartMailbox> list) async {
    state = list;
    await ref.read(sharedPreferencesProvider).setString(key, jsonEncode([for (final s in list) s.toJson()]));
  }
}
