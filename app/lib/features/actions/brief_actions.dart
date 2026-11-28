import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

/// "I will send…", "we'll book…": the sender's own promise, not a statement
/// of what happens next ("a case manager will be assigned").
final _promise = RegExp(r"\b(I|we)\s+(will|shall)\b|\b(I|we)['’]ll\b", caseSensitive: false);

/// What [item], a Brief item of a message, offers to track, or null when it
/// isn't an action: a date, a condition, what happens next that nobody
/// promised, an item without an owner.
///
/// A Brief reads a message for its reader. In mail from someone else, the
/// reader's actions and documents need the user's action, and the sender's
/// promises are waited for. In mail the user sent ([fromMe]) it is the other
/// way round: what it asks of the recipient is a follow-up the user waits on,
/// and the user's own promise ("I'll do the ID check tonight") is theirs to do.
ActionSuggestion? suggestionFromBriefItem(BriefItem item, {required bool fromMe}) {
  final (ActionOwner, ActionKind)? who = switch ((item.kind, item.owner)) {
    (BriefItemKind.action || BriefItemKind.document, BriefOwner.me) =>
      fromMe
          ? (ActionOwner.them, ActionKind.followUp)
          : (ActionOwner.me, item.kind == BriefItemKind.document ? ActionKind.document : ActionKind.task),
    (BriefItemKind.next, BriefOwner.them) when _promise.hasMatch(item.evidence.quote) => (
      fromMe ? ActionOwner.me : ActionOwner.them,
      ActionKind.promise,
    ),
    _ => null,
  };
  if (who == null) return null;
  final (owner, kind) = who;
  return ActionSuggestion(
    owner: owner,
    kind: kind,
    text: item.text,
    quote: item.evidence.quote,
    channel: item.channel,
    due: actionDueOf(item.due),
  );
}

/// A Brief's timing as an action's.
ActionDue actionDueOf(BriefDue due) => ActionDue(
  kind: switch (due.kind) {
    DueKind.explicit => ActionDueKind.explicit,
    DueKind.suggested => ActionDueKind.suggested,
    DueKind.conditional => ActionDueKind.conditional,
    DueKind.none => ActionDueKind.none,
  },
  text: due.text,
  date: due.date,
);

/// Where an action from [run] came from: its provider, model and input.
ActionOrigin actionOriginOf(AiRunRecord run) =>
    ActionOrigin.suggested(providerId: run.providerId, model: run.model, runHash: run.inputHash);

/// What the Brief task reads of a message: its subject, sender, date, text
/// and attachment names.
BriefInput briefInputOf(EmailSummary message, String text, {List<String> attachments = const []}) {
  final sender = message.sender;
  return BriefInput(
    subject: message.subject,
    from: sender == null ? '' : (sender.name == null ? sender.email : '${sender.name} <${sender.email}>'),
    date: message.receivedAt,
    text: text,
    attachments: attachments,
  );
}

/// How a suggestion stands against the actions already kept for its message.
enum SuggestionStatus {
  /// Nothing tracks this passage yet.
  fresh,

  /// Tracked, as suggested.
  tracked,

  /// Tracked, and this suggestion would change what the user hasn't
  /// changed themselves: offered as an update to review.
  update,

  /// The user deleted it; not offered again.
  removed,
}

/// [suggestion] of [source] against [existing] (deleted ones included), and
/// the action it matches, by message and passage.
(SuggestionStatus, ActionRecord?) suggestionStatus(
  ActionSuggestion suggestion,
  MessageRef source,
  Iterable<ActionRecord> existing,
) {
  final match = existing.where((a) => a.comesFrom(source, suggestion.quote)).firstOrNull;
  if (match == null) return (SuggestionStatus.fresh, null);
  if (match.deleted) return (SuggestionStatus.removed, match);
  return (match.wouldRevise(suggestion) ? SuggestionStatus.update : SuggestionStatus.tracked, match);
}
