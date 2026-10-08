import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:expr_search/expr_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart';
import '../../settings/ui_state.dart' show PrefsStringSet;
import '../rules/rule_format.dart';
import 'one_click.dart';

/// The repository's subscription side, if it has one.
MailSubscriptions? subscriptionsOf(MailRepository repository) => switch (repository) {
  final MailSubscriptions s => s,
  _ => null,
};

/// Newsletters and discussion lists, ranked (see `MailSubscriptions`).
/// Counted while something shows them (the Mailboxes screen's row does).
final subscriptionsProvider = StreamProvider.autoDispose<List<Subscription>>((ref) {
  final subs = subscriptionsOf(ref.watch(repositoryProvider));
  return subs?.watchSubscriptions() ?? Stream.value(const <Subscription>[]);
});

/// The discussion lists, most recent activity first.
final discussionsProvider = Provider.autoDispose<List<Subscription>>(
  (ref) => [
    for (final s in ref.watch(subscriptionsProvider).value ?? const <Subscription>[])
      if (s.isDiscussion) s,
  ]..sort(Subscription.compareByActivity),
);

/// The newest messages of one subscription, one copy each (the Inbox copy
/// when there is one).
final subscriptionEmailsProvider = StreamProvider.autoDispose.family<List<EmailSummary>, String>((ref, key) {
  final subs = subscriptionsOf(ref.watch(repositoryProvider));
  return (subs?.watchSubscriptionEmails(key, limit: 60) ?? Stream.value(const <EmailSummary>[])).map(_oneCopyEach);
});

List<EmailSummary> _oneCopyEach(List<EmailSummary> emails) {
  final seen = <String>{};
  return [
    for (final e in emails)
      if (seen.add('${e.accountId}|${e.messageIdHeader ?? e.id}')) e,
  ];
}

/// Whether [s] matches what was typed in the filter field: its name, sender
/// or list address, or List-Id.
bool matchesFilterText(Subscription s, String text) {
  final t = text.trim().toLowerCase();
  if (t.isEmpty) return true;
  return s.name.toLowerCase().contains(t) ||
      s.address.contains(t) ||
      (s.postAddress?.email.toLowerCase().contains(t) ?? false) ||
      s.listIds.any((l) => l.contains(t));
}

/// Discussion lists pinned to the Mailboxes screen, by List-Id. None at
/// first.
final pinnedListsProvider = NotifierProvider<PrefsStringSet, Set<String>>(
  () => PrefsStringSet('subscriptions.pinnedLists'),
);

/// The pinned discussions that are still discussions, in the order of
/// [discussionsProvider].
final pinnedDiscussionsProvider = Provider.autoDispose<List<Subscription>>((ref) {
  final pinned = ref.watch(pinnedListsProvider);
  if (pinned.isEmpty) return const [];
  return [
    for (final s in ref.watch(discussionsProvider))
      if (pinned.contains(s.listId)) s,
  ];
});

/// The Subscriptions screen's last tab (`subscriptions.tab`); null until
/// one was chosen.
final subscriptionsTabProvider = NotifierProvider<SubscriptionsTab, SubscriptionKind?>(SubscriptionsTab.new);

class SubscriptionsTab extends Notifier<SubscriptionKind?> {
  static const key = 'subscriptions.tab';

  @override
  SubscriptionKind? build() {
    ref.watch(prefsEpochProvider);
    return SubscriptionKind.values.asNameMap()[ref.watch(sharedPreferencesProvider).getString(key)];
  }

  Future<void> set(SubscriptionKind kind) async {
    state = kind;
    await ref.read(sharedPreferencesProvider).setString(key, kind.name);
  }
}

/// Which subscriptions the list shows.
enum SubscriptionFilter {
  neverRead,
  rarelyRead,
  all;

  /// Rarely read: under a quarter, never-read ones included.
  bool matches(Subscription s) => switch (this) {
    neverRead => s.neverRead,
    rarelyRead => s.readRate < 0.25,
    all => true,
  };
}

// Unsubscribe records -----------------------------------------------------------------

enum UnsubscribeVia { oneClick, mail, web }

/// When and how the user unsubscribed from a subscription (on this device).
@immutable
final class UnsubscribeRecord {
  const UnsubscribeRecord({required this.at, required this.via});

  /// Mail this long after unsubscribing means the sender ignored it.
  static const grace = Duration(days: 7);

  final DateTime at;
  final UnsubscribeVia via;

  /// Mail arrived more than [grace] after unsubscribing.
  bool stillSending(Subscription s) => s.lastReceived?.isAfter(at.add(grace)) ?? false;

  Map<String, Object?> toJson() => {'at': at.toUtc().toIso8601String(), 'via': via.name};

  static UnsubscribeRecord? fromJson(Object? json) {
    if (json is! Map) return null;
    final at = DateTime.tryParse(json['at'] as String? ?? '');
    final via = UnsubscribeVia.values.asNameMap()[json['via']];
    return at == null || via == null ? null : UnsubscribeRecord(at: at.toLocal(), via: via);
  }

  @override
  bool operator ==(Object other) => other is UnsubscribeRecord && other.at == at && other.via == via;

  @override
  int get hashCode => Object.hash(at, via);
}

/// Unsubscribes done on this device, by subscription key.
final unsubscribeRecordsProvider = NotifierProvider<UnsubscribeRecords, Map<String, UnsubscribeRecord>>(
  UnsubscribeRecords.new,
);

class UnsubscribeRecords extends Notifier<Map<String, UnsubscribeRecord>> {
  static const key = 'subscriptions.unsubscribed';

  @override
  Map<String, UnsubscribeRecord> build() {
    ref.watch(prefsEpochProvider);
    final raw = ref.watch(sharedPreferencesProvider).getString(key);
    if (raw == null) return const {};
    try {
      final json = jsonDecode(raw);
      if (json is! Map) return const {};
      return {
        for (final MapEntry(:key, :value) in json.entries)
          if (key is String) key: ?UnsubscribeRecord.fromJson(value),
      };
    } on FormatException {
      return const {};
    }
  }

  Future<void> record(String subscriptionKey, UnsubscribeVia via, {DateTime? at}) =>
      _save({...state, subscriptionKey: UnsubscribeRecord(at: at ?? clock.now(), via: via)});

  Future<void> forget(String subscriptionKey) => _save({...state}..remove(subscriptionKey));

  /// Moves records kept under keys that [subs] now group under another one
  /// (a list's own key before its sender's newsletter took it in, a
  /// sender's address with a +tag) to that key, the newest when there are
  /// several.
  Future<void> adopt(Iterable<Subscription> subs) async {
    final next = {...state};
    var changed = false;
    for (final s in subs) {
      for (final old in s.sourceKeys) {
        if (old == s.key) continue;
        final record = next.remove(old);
        if (record == null) continue;
        changed = true;
        final kept = next[s.key];
        if (kept == null || record.at.isAfter(kept.at)) next[s.key] = record;
      }
    }
    if (changed) await _save(next);
  }

  Future<void> _save(Map<String, UnsubscribeRecord> records) async {
    state = records;
    await ref
        .read(sharedPreferencesProvider)
        .setString(key, jsonEncode({for (final MapEntry(:key, :value) in records.entries) key: value.toJson()}));
  }
}

/// The record of [s] in [records]: under its key, else under one of its
/// sources' (kept before they were grouped so; [UnsubscribeRecords.adopt]
/// moves them).
UnsubscribeRecord? unsubscribeRecordOf(Map<String, UnsubscribeRecord> records, Subscription s) {
  var found = records[s.key];
  for (final k in s.sourceKeys) {
    final r = records[k];
    if (r != null && (found == null || r.at.isAfter(found.at))) found = r;
  }
  return found;
}

/// The user has seen what one-click unsubscribing sends (asked once).
final oneClickExplainedProvider = NotifierProvider<OneClickExplained, bool>(OneClickExplained.new);

class OneClickExplained extends Notifier<bool> {
  static const key = 'subscriptions.oneClickExplained';

  @override
  bool build() {
    ref.watch(prefsEpochProvider);
    return ref.watch(sharedPreferencesProvider).getBool(key) ?? false;
  }

  Future<void> set() async {
    state = true;
    await ref.read(sharedPreferencesProvider).setBool(key, true);
  }
}

// Network and browser -------------------------------------------------------------------

/// Sends one-click unsubscribes: over the network for real accounts, a
/// pretend success in the demo.
final oneClickUnsubscriberProvider = Provider<OneClickUnsubscriber>(
  (ref) => switch (ref.watch(appModeProvider)) {
    AppMode.live => const OneClickUnsubscriber(IoOneClickTransport()),
    AppMode.demo || AppMode.none => const OneClickUnsubscriber(DemoOneClickTransport()),
  },
);

/// Opens a web page in the in-app browser; false if it couldn't.
final webPageOpenerProvider = Provider<Future<bool> Function(Uri uri)>(
  (ref) =>
      (uri) => launchUrl(uri, mode: LaunchMode.inAppBrowserView),
);

// Rules ------------------------------------------------------------------------------------

/// The rule condition for a subscription's mail: the List-Id of a list
/// with several senders (a discussion), the name and domain of a sender
/// whose address changes, else the sender's address.
String subscriptionCondition(Subscription s) {
  if (s.isList && s.senderCount > 1) return formatQuery(HeaderTerm('List-Id', s.listId!));
  final domain = s.brandDomain;
  if (domain != null) {
    final name = s.key.substring(s.key.indexOf('/') + 1);
    return formatQuery(
      name.isEmpty
          ? TextTerm(SearchField.from, domain)
          : SearchAnd([TextTerm(SearchField.from, name), TextTerm(SearchField.from, domain)]),
    );
  }
  return formatQuery(TextTerm(SearchField.from, s.address));
}

/// A "Block Sender" rule for [s] exists: its condition, the sender's, or
/// one of its List-Ids' (rules made before its mail was grouped so),
/// moving to Junk.
bool isBlocked(Subscription s, List<Rule> rules) {
  final conditions = {
    subscriptionCondition(s),
    formatQuery(TextTerm(SearchField.from, s.address)),
    for (final l in s.listIds) formatQuery(HeaderTerm('List-Id', l)),
  };
  return rules.any((r) => r.enabled && conditions.contains(r.condition) && r.actions.any((a) => a is MarkJunkAction));
}

/// The rule that sends [s]'s future mail to Junk.
Rule blockRule(AppLocalizations l10n, Subscription s) => Rule(
  id: newRuleId(),
  name: l10n.subscriptionsBlockRuleName(s.name),
  condition: subscriptionCondition(s),
  actions: const [MarkJunkAction()],
  stopProcessing: true,
);
