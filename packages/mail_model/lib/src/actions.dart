// Needs My Action and Waiting on Others (docs/plan/PLAN-combined.md,
// section 2): what the user has to do, and what they wait for from others.

import 'mailbox.dart';
import 'message_ref.dart';

/// Who has to act.
enum ActionOwner {
  /// The user ("Please send the statement"): Needs My Action.
  me,

  /// Someone else ("I will send the revised offer tomorrow"): Waiting on
  /// Others.
  them,
}

/// What an action is about. It picks the icon and the words; the folder
/// follows the owner and the state.
enum ActionKind {
  /// Something to do: a check, a form, a payment, an answer.
  task,

  /// A document to provide.
  document,

  /// What someone said they will do.
  promise,

  /// Something the user asked for or sent and waits to hear back on.
  followUp,
}

/// Where an action is. Not every action uses every state: a promise goes
/// from [needsAction] to [done]; a document can be [sent], then waited on,
/// then [acknowledged]. Only the user moves an action from one state to
/// another: mail never does, so a reply saying "Thanks" settles nothing.
enum ActionState {
  needsAction,
  inProgress,

  /// The owner sent it (a reply with the document). It says nothing about
  /// whether it was received or accepted.
  sent,

  /// Sent, and waiting for the other side to confirm it: Waiting on Others.
  waitingForAcknowledgement,

  /// The other side confirmed they have it.
  acknowledged,
  done,
  dismissed,

  /// A newer request took its place.
  superseded,
}

/// How firm a timing is, as the message states it.
enum ActionDueKind {
  /// A stated date or deadline.
  explicit,

  /// A target ("ideally by Friday").
  suggested,

  /// Measured from an event ("within 24 hours after submission"): never
  /// shown as a date.
  conditional,
  none,
}

/// When an action is due: the wording, and a calendar date only when one
/// was stated or picked (never worked out from "next week").
final class ActionDue {
  const ActionDue({required this.kind, this.text, this.date});

  factory ActionDue.fromJson(Map<String, Object?> json) => ActionDue(
    kind: _byName(ActionDueKind.values, json['kind']) ?? ActionDueKind.none,
    text: json['text'] as String?,
    date: switch (json['date']) {
      final String s => DateTime.tryParse(s),
      _ => null,
    },
  );

  static const none = ActionDue(kind: ActionDueKind.none);

  final ActionDueKind kind;

  /// The timing as written ("by Thursday 5 November"), when there is one.
  final String? text;

  /// The day, without a time (local midnight).
  final DateTime? date;

  bool get isNone => kind == ActionDueKind.none && text == null && date == null;

  Map<String, Object?> toJson() => {
    'kind': kind.name,
    if (text != null) 'text': text,
    if (date != null) 'date': _day(date!),
  };

  @override
  bool operator ==(Object other) =>
      other is ActionDue && other.kind == kind && other.text == text && _sameDay(other.date, date);

  @override
  int get hashCode => Object.hash(kind, text, date == null ? null : _day(date!));
}

/// Where an action came from: the user, or a suggestion they accepted
/// (which provider and model, and the hash of the run's input, so a later
/// run on the same message can be told apart from a new one).
final class ActionOrigin {
  const ActionOrigin.manual() : providerId = null, model = null, runHash = null;

  const ActionOrigin.suggested({required String this.providerId, this.model, required String this.runHash});

  factory ActionOrigin.fromJson(Map<String, Object?>? json) => switch (json) {
    {'provider': final String provider, 'run': final String run} => ActionOrigin.suggested(
      providerId: provider,
      model: json['model'] as String?,
      runHash: run,
    ),
    _ => const ActionOrigin.manual(),
  };

  final String? providerId;
  final String? model;
  final String? runHash;

  bool get isSuggested => providerId != null;

  Map<String, Object?>? toJson() =>
      isSuggested ? {'provider': providerId, if (model != null) 'model': model, 'run': runHash} : null;

  @override
  bool operator ==(Object other) =>
      other is ActionOrigin && other.providerId == providerId && other.model == model && other.runHash == runHash;

  @override
  int get hashCode => Object.hash(providerId, model, runHash);
}

/// What an extraction proposed for one passage of a message: the values an
/// action takes from it until the user changes them.
final class ActionSuggestion {
  const ActionSuggestion({
    required this.owner,
    required this.kind,
    required this.text,
    required this.quote,
    this.channel,
    this.due = ActionDue.none,
  });

  factory ActionSuggestion.fromJson(Map<String, Object?> json) => ActionSuggestion(
    owner: _byName(ActionOwner.values, json['owner']) ?? ActionOwner.me,
    kind: _byName(ActionKind.values, json['kind']) ?? ActionKind.task,
    text: (json['text'] as String?) ?? '',
    quote: (json['quote'] as String?) ?? '',
    channel: json['channel'] as String?,
    due: switch (json['due']) {
      final Map<String, Object?> d => ActionDue.fromJson(d),
      _ => ActionDue.none,
    },
  );

  final ActionOwner owner;
  final ActionKind kind;

  /// The request in a few words.
  final String text;

  /// The exact passage of the message it comes from.
  final String quote;

  /// How or where it must be done, as stated ("in the Harbour app").
  final String? channel;
  final ActionDue due;

  Map<String, Object?> toJson() => {
    'owner': owner.name,
    'kind': kind.name,
    'text': text,
    'quote': quote,
    if (channel != null) 'channel': channel,
    if (!due.isNone) 'due': due.toJson(),
  };

  @override
  bool operator ==(Object other) =>
      other is ActionSuggestion &&
      other.owner == owner &&
      other.kind == kind &&
      other.text == text &&
      other.quote == quote &&
      other.channel == channel &&
      other.due == due;

  @override
  int get hashCode => Object.hash(owner, kind, text, quote, channel, due);
}

/// What the user can change on an action. Once changed, a field is theirs: a
/// later suggestion for the same passage leaves it alone.
enum ActionField { owner, text, channel, due, state, reminder }

/// What one step of an action's history did.
enum ActionChange { created, state, edited, due, reminder, revised, deleted, restored }

/// One step of an action's history.
final class ActionEvent {
  const ActionEvent({required this.at, required this.change, this.state, this.detail});

  factory ActionEvent.fromJson(Map<String, Object?> json) => ActionEvent(
    at: DateTime.tryParse((json['at'] as String?) ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    change: _byName(ActionChange.values, json['change']) ?? ActionChange.edited,
    state: _byName(ActionState.values, json['state']),
    detail: json['detail'] as String?,
  );

  final DateTime at;
  final ActionChange change;

  /// The state the action was in after this step, for [ActionChange.created]
  /// and [ActionChange.state].
  final ActionState? state;

  /// The new text after an edit or a revision.
  final String? detail;

  Map<String, Object?> toJson() => {
    'at': at.toUtc().toIso8601String(),
    'change': change.name,
    if (state != null) 'state': state!.name,
    if (detail != null) 'detail': detail,
  };
}

/// One thing the user has to do, or waits for, tied to the message that
/// asked for it or promised it ([source], with the exact passage in
/// [quote]). It has an identity of its own: several actions can come from
/// one message, and one message can have actions in both folders.
///
/// [originalRequest] is the request as first recorded, [currentRequest] as
/// it reads now (the user's edit, or a revision they accepted). [suggestion]
/// keeps what extraction last proposed apart from what the user changed
/// ([overridden]), so running it again, or another model, never erases a
/// correction or reopens something the user settled.
final class ActionRecord {
  const ActionRecord({
    required this.id,
    required this.owner,
    required this.kind,
    required this.source,
    required this.originalRequest,
    required this.currentRequest,
    required this.createdAt,
    required this.updatedAt,
    this.quote = '',
    this.channel,
    this.due = ActionDue.none,
    this.state = ActionState.needsAction,
    this.remindAt,
    this.origin = const ActionOrigin.manual(),
    this.suggestion,
    this.overridden = const {},
    this.history = const [],
    this.deleted = false,
  });

  /// A new action from [suggestion], which the user accepted.
  factory ActionRecord.suggested({
    required String id,
    required MessageRef source,
    required ActionSuggestion suggestion,
    required ActionOrigin origin,
    required DateTime at,
    ActionState state = ActionState.needsAction,
  }) => ActionRecord(
    id: id,
    owner: suggestion.owner,
    kind: suggestion.kind,
    source: source,
    quote: suggestion.quote,
    originalRequest: suggestion.text,
    currentRequest: suggestion.text,
    channel: suggestion.channel,
    due: suggestion.due,
    state: state,
    origin: origin,
    suggestion: suggestion,
    createdAt: at,
    updatedAt: at,
    history: [ActionEvent(at: at, change: ActionChange.created, state: state)],
  );

  factory ActionRecord.fromJson(Map<String, Object?> json) {
    final created = DateTime.tryParse((json['created'] as String?) ?? '') ?? DateTime.utc(1970);
    return ActionRecord(
      id: json['id']! as String,
      owner: _byName(ActionOwner.values, json['owner']) ?? ActionOwner.me,
      kind: _byName(ActionKind.values, json['kind']) ?? ActionKind.task,
      source: MessageRef.fromJson((json['source']! as Map).cast<String, Object?>()),
      quote: (json['quote'] as String?) ?? '',
      originalRequest: (json['original'] as String?) ?? '',
      currentRequest: (json['current'] as String?) ?? '',
      channel: json['channel'] as String?,
      due: switch (json['due']) {
        final Map<String, Object?> d => ActionDue.fromJson(d),
        _ => ActionDue.none,
      },
      state: _byName(ActionState.values, json['state']) ?? ActionState.needsAction,
      remindAt: switch (json['remind']) {
        final String s => DateTime.tryParse(s),
        _ => null,
      },
      origin: ActionOrigin.fromJson((json['origin'] as Map?)?.cast<String, Object?>()),
      suggestion: switch (json['suggestion']) {
        final Map<String, Object?> s => ActionSuggestion.fromJson(s),
        _ => null,
      },
      overridden: {for (final f in (json['overridden'] as List?) ?? const []) ?_byName(ActionField.values, f)},
      history: [
        for (final e in (json['history'] as List?) ?? const [])
          if (e is Map) ActionEvent.fromJson(e.cast<String, Object?>()),
      ],
      createdAt: created,
      updatedAt: DateTime.tryParse((json['updated'] as String?) ?? '') ?? created,
      deleted: json['deleted'] == true,
    );
  }

  final String id;
  final ActionOwner owner;
  final ActionKind kind;

  /// The message that asked for it or promised it.
  final MessageRef source;

  /// The exact passage of [source] it comes from; empty when the user added
  /// it without one.
  final String quote;
  final String originalRequest;
  final String currentRequest;

  /// How or where it must be done, as stated ("in the Harbour app").
  final String? channel;
  final ActionDue due;
  final ActionState state;

  /// When to remind the user of this action, and only this one: a message
  /// snooze is something else.
  final DateTime? remindAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ActionOrigin origin;

  /// What extraction last proposed for [quote]; null for one the user added.
  final ActionSuggestion? suggestion;

  /// The fields the user changed since.
  final Set<ActionField> overridden;

  /// What happened to it, oldest first.
  final List<ActionEvent> history;

  /// Deleted by the user: kept, so the same suggestion isn't offered again,
  /// but shown nowhere.
  final bool deleted;

  String get accountId => source.accountId;

  /// The folder it shows in, or null once it is settled.
  VirtualMailbox? get folder => deleted ? null : folderOf(owner, state);

  bool get isOpen => folder != null;

  /// Needs My Action holds the user's open actions; Waiting on Others holds
  /// other people's, and what the user sent and waits to see acknowledged.
  static VirtualMailbox? folderOf(ActionOwner owner, ActionState state) => switch (state) {
    ActionState.needsAction ||
    ActionState.inProgress => owner == ActionOwner.me ? VirtualMailbox.needsMyAction : VirtualMailbox.waitingOnOthers,
    ActionState.waitingForAcknowledgement => VirtualMailbox.waitingOnOthers,
    ActionState.sent ||
    ActionState.acknowledged ||
    ActionState.done ||
    ActionState.dismissed ||
    ActionState.superseded => null,
  };

  /// [quote] as suggestions are compared: case, whitespace and the kind of
  /// quotation marks and dashes don't count.
  static String normaliseQuote(String quote) => quote
      .toLowerCase()
      .replaceAll(RegExp('[‘’‚′]'), "'")
      .replaceAll(RegExp('[“”„″]'), '"')
      .replaceAll(RegExp('[‐‑‒–—]'), '-')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  /// Whether this action comes from the passage [quote] of the message
  /// [source] refers to.
  bool comesFrom(MessageRef source, String quote) =>
      this.source == source && quote.trim().isNotEmpty && normaliseQuote(this.quote) == normaliseQuote(quote);

  /// Moved to [state] by the user.
  ActionRecord withState(ActionState state, DateTime at) => this.state == state
      ? this
      : _changed(
          at,
          ActionEvent(at: at, change: ActionChange.state, state: state),
          state: state,
          field: ActionField.state,
        );

  /// Reworded by the user.
  ActionRecord withText(String text, DateTime at) {
    final t = text.trim();
    if (t.isEmpty || t == currentRequest) return this;
    return _changed(
      at,
      ActionEvent(at: at, change: ActionChange.edited, detail: t),
      currentRequest: t,
      field: ActionField.text,
    );
  }

  /// A new timing from the user.
  ActionRecord withDue(ActionDue due, DateTime at) => due == this.due
      ? this
      : _changed(
          at,
          ActionEvent(at: at, change: ActionChange.due),
          due: due,
          field: ActionField.due,
        );

  /// A reminder at [remindAt], or none.
  ActionRecord withReminder(DateTime? remindAt, DateTime at) {
    if (remindAt == this.remindAt) return this;
    return ActionRecord(
      id: id,
      owner: owner,
      kind: kind,
      source: source,
      quote: quote,
      originalRequest: originalRequest,
      currentRequest: currentRequest,
      channel: channel,
      due: due,
      state: state,
      remindAt: remindAt,
      origin: origin,
      suggestion: suggestion,
      overridden: {...overridden, ActionField.reminder},
      history: [
        ...history,
        ActionEvent(at: at, change: ActionChange.reminder),
      ],
      createdAt: createdAt,
      updatedAt: at,
      deleted: deleted,
    );
  }

  /// Deleted ([deleted] true) or brought back.
  ActionRecord withDeleted(bool deleted, DateTime at) => deleted == this.deleted
      ? this
      : _changed(
          at,
          ActionEvent(at: at, change: deleted ? ActionChange.deleted : ActionChange.restored),
          deleted: deleted,
        );

  /// Whether [next], a newer suggestion for the same passage, would change
  /// anything the user hasn't changed themselves.
  bool wouldRevise(ActionSuggestion next) => revisedBy(next, origin, updatedAt) != this;

  /// Takes [next], a newer suggestion for the same passage (another model,
  /// another run), for the fields the user hasn't changed. The state is never
  /// touched: re-extraction can't reopen what the user settled. Returns this
  /// action when nothing changes.
  ActionRecord revisedBy(ActionSuggestion next, ActionOrigin origin, DateTime at) {
    final mine = overridden;
    final text = mine.contains(ActionField.text) ? currentRequest : next.text;
    final owner = mine.contains(ActionField.owner) ? this.owner : next.owner;
    final channel = mine.contains(ActionField.channel) ? this.channel : next.channel;
    final due = mine.contains(ActionField.due) ? this.due : next.due;
    if (text == currentRequest && owner == this.owner && channel == this.channel && due == this.due) return this;
    return ActionRecord(
      id: id,
      owner: owner,
      kind: next.kind,
      source: source,
      quote: quote,
      originalRequest: originalRequest,
      currentRequest: text,
      channel: channel,
      due: due,
      state: state,
      remindAt: remindAt,
      origin: origin,
      suggestion: next,
      overridden: overridden,
      history: [
        ...history,
        ActionEvent(at: at, change: ActionChange.revised, detail: text),
      ],
      createdAt: createdAt,
      updatedAt: at,
      deleted: deleted,
    );
  }

  /// The same action, its message last seen at [source].
  ActionRecord seenAt(MessageRef source) => ActionRecord(
    id: id,
    owner: owner,
    kind: kind,
    source: source,
    quote: quote,
    originalRequest: originalRequest,
    currentRequest: currentRequest,
    channel: channel,
    due: due,
    state: state,
    remindAt: remindAt,
    origin: origin,
    suggestion: suggestion,
    overridden: overridden,
    history: history,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deleted: deleted,
  );

  ActionRecord _changed(
    DateTime at,
    ActionEvent event, {
    ActionState? state,
    String? currentRequest,
    ActionDue? due,
    bool? deleted,
    ActionField? field,
  }) => ActionRecord(
    id: id,
    owner: owner,
    kind: kind,
    source: source,
    quote: quote,
    originalRequest: originalRequest,
    currentRequest: currentRequest ?? this.currentRequest,
    channel: channel,
    due: due ?? this.due,
    state: state ?? this.state,
    remindAt: remindAt,
    origin: origin,
    suggestion: suggestion,
    overridden: {...overridden, ?field},
    history: [...history, event],
    createdAt: createdAt,
    updatedAt: at,
    deleted: deleted ?? this.deleted,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'owner': owner.name,
    'kind': kind.name,
    'source': source.toJson(),
    if (quote.isNotEmpty) 'quote': quote,
    'original': originalRequest,
    'current': currentRequest,
    if (channel != null) 'channel': channel,
    if (!due.isNone) 'due': due.toJson(),
    'state': state.name,
    if (remindAt != null) 'remind': remindAt!.toUtc().toIso8601String(),
    'origin': ?origin.toJson(),
    if (suggestion != null) 'suggestion': suggestion!.toJson(),
    if (overridden.isNotEmpty)
      'overridden': [
        for (final f in ActionField.values)
          if (overridden.contains(f)) f.name,
      ],
    if (history.isNotEmpty) 'history': [for (final e in history) e.toJson()],
    'created': createdAt.toUtc().toIso8601String(),
    'updated': updatedAt.toUtc().toIso8601String(),
    if (deleted) 'deleted': true,
  };

  @override
  bool operator ==(Object other) =>
      other is ActionRecord &&
      other.id == id &&
      other.owner == owner &&
      other.kind == kind &&
      other.source == source &&
      other.quote == quote &&
      other.originalRequest == originalRequest &&
      other.currentRequest == currentRequest &&
      other.channel == channel &&
      other.due == due &&
      other.state == state &&
      other.remindAt == remindAt &&
      other.origin == origin &&
      other.suggestion == suggestion &&
      other.overridden.length == overridden.length &&
      other.overridden.containsAll(overridden) &&
      other.history.length == history.length &&
      other.updatedAt == updatedAt &&
      other.deleted == deleted;

  @override
  int get hashCode => Object.hash(id, state, currentRequest, updatedAt, deleted);

  @override
  String toString() => 'ActionRecord($id, ${owner.name}, ${state.name}: $currentRequest)';
}

/// The actions the user tracks: Needs My Action and Waiting on Others. Kept
/// on this device (in the encrypted store), by account: removing an account
/// removes its actions. Implemented by repositories that can (`repository is
/// ActionRecords`); their `watchList` and `watchVirtualCounts` compute the two
/// virtual mailboxes from these records, never by running a model.
abstract interface class ActionRecords {
  /// Every action of every account, the most recently changed first, each
  /// source as last seen (where its message is now, when it is on this
  /// device). Deleted ones only with [includeDeleted]. Emits the current
  /// value at once and again whenever it changes.
  Stream<List<ActionRecord>> watchActions({bool includeDeleted = false});

  /// Saves [records], new or changed, replacing those with the same ids.
  Future<void> saveActions(List<ActionRecord> records);

  /// Forgets [ids] without a trace (undoing an addition), unlike deleting,
  /// which keeps the record with [ActionRecord.deleted] set.
  Future<void> forgetActions(List<String> ids);
}

T? _byName<T extends Enum>(List<T> values, Object? name) =>
    name is String ? values.where((v) => v.name == name).firstOrNull : null;

String _day(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

bool _sameDay(DateTime? a, DateTime? b) => a == null || b == null ? a == b : _day(a) == _day(b);
