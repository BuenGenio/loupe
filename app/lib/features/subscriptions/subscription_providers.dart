import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:expr_search/expr_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers.dart';
import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart';
import '../rules/rule_format.dart';
import 'one_click.dart';

/// The repository's subscription side, if it has one.
MailSubscriptions? subscriptionsOf(MailRepository repository) => switch (repository) {
  final MailSubscriptions s => s,
  _ => null,
};

/// Bulk mail by sender, ranked (see `MailSubscriptions`). Counted only
/// while a Subscriptions screen is open.
final subscriptionsProvider = StreamProvider.autoDispose<List<Subscription>>((ref) {
  final subs = subscriptionsOf(ref.watch(repositoryProvider));
  return subs?.watchSubscriptions() ?? Stream.value(const <Subscription>[]);
});

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

/// Which subscriptions the list shows.
enum SubscriptionFilter {
  neverRead('Never Read'),
  rarelyRead('Rarely Read'),
  all('All');

  const SubscriptionFilter(this.label);
  final String label;

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

  Future<void> _save(Map<String, UnsubscribeRecord> records) async {
    state = records;
    await ref
        .read(sharedPreferencesProvider)
        .setString(key, jsonEncode({for (final MapEntry(:key, :value) in records.entries) key: value.toJson()}));
  }
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

/// The rule condition for a subscription's mail: its sender, or for a list
/// with several senders its List-Id.
String subscriptionCondition(Subscription s) => formatQuery(
  s.isList && s.senderCount > 1 ? HeaderTerm('List-Id', s.listId!) : TextTerm(SearchField.from, s.address),
);

/// A "Block Sender" rule for [s] exists: its condition, moving to Junk.
bool isBlocked(Subscription s, List<Rule> rules) {
  final condition = subscriptionCondition(s);
  return rules.any((r) => r.enabled && r.condition == condition && r.actions.any((a) => a is MarkJunkAction));
}

/// The rule that sends [s]'s future mail to Junk.
Rule blockRule(Subscription s) => Rule(
  id: newRuleId(),
  name: 'Block ${s.name}',
  condition: subscriptionCondition(s),
  actions: const [MarkJunkAction()],
  stopProcessing: true,
);
