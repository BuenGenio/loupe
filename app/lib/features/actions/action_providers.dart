import 'dart:math';

import 'package:clock/clock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../conversation/mail_streams.dart';
import 'brief_actions.dart';

/// The repository's action side, if it has one.
ActionRecords? actionRecordsOf(MailRepository repository) => switch (repository) {
  final ActionRecords records => records,
  _ => null,
};

/// Every action of every account, the most recently changed first; deleted
/// ones left out.
final actionsProvider = StreamProvider<List<ActionRecord>>((ref) {
  final records = actionRecordsOf(ref.watch(repositoryProvider));
  return records?.watchActions() ?? Stream.value(const <ActionRecord>[]);
});

/// The same with deleted ones: what suggestions are checked against, so one
/// the user deleted isn't offered again.
final allActionsProvider = StreamProvider.autoDispose<List<ActionRecord>>((ref) {
  final records = actionRecordsOf(ref.watch(repositoryProvider));
  return records?.watchActions(includeDeleted: true) ?? Stream.value(const <ActionRecord>[]);
});

/// The actions of a conversation: those whose message is one of [messages].
List<ActionRecord> actionsOf(Iterable<ActionRecord> actions, List<EmailSummary> messages) => [
  for (final a in actions)
    if (messages.any(a.source.matches)) a,
];

/// The open actions of each conversation in [folder], by (account id, thread
/// id), the soonest due first: what a row of the folder's list shows.
Map<(String, String), List<ActionRecord>> openActionsByConversation(
  Iterable<ActionRecord> actions,
  VirtualMailbox folder,
) {
  final out = <(String, String), List<ActionRecord>>{};
  for (final a in actions) {
    final thread = a.source.threadId;
    if (a.folder != folder || thread == null) continue;
    (out[(a.accountId, thread)] ??= []).add(a);
  }
  for (final list in out.values) {
    list.sort(compareByDue);
  }
  return out;
}

/// Soonest stated date first, then timings without one, then none; ties by
/// when they were added.
int compareByDue(ActionRecord a, ActionRecord b) {
  int rank(ActionRecord r) => r.due.date != null ? 0 : (r.due.isNone ? 2 : 1);
  final byRank = rank(a).compareTo(rank(b));
  if (byRank != 0) return byRank;
  final ad = a.due.date, bd = b.due.date;
  if (ad != null && bd != null && ad != bd) return ad.compareTo(bd);
  return a.createdAt.compareTo(b.createdAt);
}

/// Makes and saves actions. Every change goes through [save]; screens put
/// Undo on top (`changeAction`, `addActions`).
final class ActionTracker {
  ActionTracker(this._ref, {Random? random}) : _random = random ?? Random();

  final Ref _ref;
  final Random _random;

  ActionRecords? get records => actionRecordsOf(_ref.read(repositoryProvider));

  DateTime now() => clock.now();

  /// A new, unique action id.
  String newId() =>
      'act-${now().microsecondsSinceEpoch.toRadixString(36)}-${_random.nextInt(1 << 32).toRadixString(36)}';

  Future<void> save(List<ActionRecord> records) async {
    final store = this.records;
    if (store == null || records.isEmpty) return;
    await store.saveActions(records);
  }

  Future<void> forget(List<String> ids) async => records?.forgetActions(ids);

  /// A new action the user wrote, about [source].
  ActionRecord manual({
    required MessageRef source,
    required ActionOwner owner,
    required String text,
    required bool fromMe,
    ActionDue due = ActionDue.none,
  }) {
    final at = now();
    final kind = owner == ActionOwner.me ? ActionKind.task : (fromMe ? ActionKind.followUp : ActionKind.promise);
    return ActionRecord(
      id: newId(),
      owner: owner,
      kind: kind,
      source: source,
      originalRequest: text.trim(),
      currentRequest: text.trim(),
      due: due,
      createdAt: at,
      updatedAt: at,
      history: [ActionEvent(at: at, change: ActionChange.created, state: ActionState.needsAction)],
    );
  }

  /// A new action from [suggestion], accepted by the user.
  ActionRecord accepted(MessageRef source, ActionSuggestion suggestion, ActionOrigin origin) =>
      ActionRecord.suggested(id: newId(), source: source, suggestion: suggestion, origin: origin, at: now());

  /// Whether the user sent [message] (from one of their accounts' addresses).
  Future<bool> isFromMe(EmailSummary message) async {
    final accounts = await _ref.read(repositoryProvider).watchAccounts().first;
    final sender = message.sender?.email.toLowerCase();
    return sender != null && ownAddresses(accounts).contains(sender);
  }

  /// Tracks [item], a Brief item of the message [source], as Suggest Actions
  /// does, and returns the action: the one already tracking that passage if
  /// there is one, else a new one. [run] is the Brief's run, so the action
  /// says which provider and model suggested it. Null when [item] isn't
  /// something to track (a date, a condition, what happens next that nobody
  /// promised), the repository keeps no actions, or the user deleted the
  /// action for that passage before.
  Future<ActionRecord?> trackBriefItem(MessageRef source, BriefItem item, {AiRunRecord? run}) async {
    final store = records;
    if (store == null) return null;
    final email = await _ref.read(repositoryProvider).getEmail(source.emailId);
    final fromMe = email != null && await isFromMe(email);
    final suggestion = suggestionFromBriefItem(item, fromMe: fromMe);
    if (suggestion == null) return null;
    final existing = await store.watchActions(includeDeleted: true).first;
    final (status, match) = suggestionStatus(suggestion, source, existing);
    if (status == SuggestionStatus.removed) return null;
    if (match != null) return match;
    final record = accepted(
      email == null ? source : MessageRef.of(email),
      suggestion,
      run == null ? const ActionOrigin.manual() : actionOriginOf(run),
    );
    await store.saveActions([record]);
    return record;
  }
}

final actionTrackerProvider = Provider<ActionTracker>(ActionTracker.new);

/// The Brief's "Track" ([ActionTracker.trackBriefItem]): tracks [item] of the
/// message [source] as an action and returns it, or null when it isn't one.
Future<ActionRecord?> trackBriefItem(WidgetRef ref, MessageRef source, BriefItem item, {AiRunRecord? run}) =>
    ref.read(actionTrackerProvider).trackBriefItem(source, item, run: run);
