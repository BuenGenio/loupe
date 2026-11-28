import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../theme/loupe_icons.dart';
import '../compose/send_later.dart';

/// What an action's state is called, as a status and as a menu item.
String actionStateLabel(AppLocalizations l10n, ActionState state) => switch (state) {
  ActionState.needsAction => l10n.actionsStateNeedsAction,
  ActionState.inProgress => l10n.actionsStateInProgress,
  ActionState.sent => l10n.actionsStateSent,
  ActionState.waitingForAcknowledgement => l10n.actionsStateWaiting,
  ActionState.acknowledged => l10n.actionsStateAcknowledged,
  ActionState.done => l10n.actionsStateDone,
  ActionState.dismissed => l10n.actionsStateDismissed,
  ActionState.superseded => l10n.actionsStateSuperseded,
};

IconData actionStateIcon(ActionState state) => switch (state) {
  ActionState.needsAction => LoupeIcons.actionOpen,
  ActionState.inProgress => LoupeIcons.actionInProgress,
  ActionState.sent => LoupeIcons.actionSent,
  ActionState.waitingForAcknowledgement => LoupeIcons.actionWaiting,
  ActionState.acknowledged => LoupeIcons.actionAcknowledged,
  ActionState.done => LoupeIcons.actionDone,
  ActionState.dismissed => LoupeIcons.actionDismissed,
  ActionState.superseded => LoupeIcons.actionSuperseded,
};

/// The states an action of [owner] can be put in. Someone else's promise is
/// kept or not; something of the user's can also be sent, and then waited
/// on until it is acknowledged. Either can be superseded by a newer request.
/// A sent reply never moves an action by itself: these are the user's to
/// pick.
List<ActionState> actionStatesFor(ActionOwner owner) => owner == ActionOwner.me
    ? const [
        ActionState.needsAction,
        ActionState.inProgress,
        ActionState.sent,
        ActionState.waitingForAcknowledgement,
        ActionState.acknowledged,
        ActionState.done,
        ActionState.dismissed,
        ActionState.superseded,
      ]
    : const [
        ActionState.needsAction,
        ActionState.inProgress,
        ActionState.done,
        ActionState.dismissed,
        ActionState.superseded,
      ];

/// The snack bar after the user moved an action to [state].
String actionMarkedLabel(AppLocalizations l10n, ActionState state) => l10n.actionsMarked(state.name);

/// When an action is due, for its row: the stated day, else the timing as
/// the message words it; null when it has none.
String? actionDueLabel(AppLocalizations l10n, ActionDue due) {
  final date = due.date;
  if (date != null) {
    final day = DateFormat.MMMEd().format(date);
    return due.kind == ActionDueKind.suggested ? l10n.actionsTargetOn(day) : l10n.actionsDueOn(day);
  }
  final text = due.text?.trim();
  return text == null || text.isEmpty ? null : l10n.actionsDueAsWritten(text);
}

/// Whether [action] is open and its stated day has passed.
bool actionOverdue(ActionRecord action, DateTime now) {
  final date = action.due.date;
  if (!action.isOpen || date == null) return false;
  return DateTime(date.year, date.month, date.day).isBefore(DateTime(now.year, now.month, now.day));
}

/// "Tomorrow 08:00", for a reminder.
String actionReminderLabel(BuildContext context, DateTime at, {required DateTime now}) =>
    formatSendTimeFor(context, at.toLocal(), now: now, compact: true);

/// Where an action came from, for its details.
String actionOriginLabel(AppLocalizations l10n, ActionOrigin origin) {
  final provider = origin.providerId;
  if (provider == null) return l10n.actionsOriginManual;
  if (provider == 'demo') return l10n.actionsOriginDemo;
  final model = origin.model;
  return model == null || model == provider
      ? l10n.actionsOriginSuggested(provider)
      : l10n.actionsOriginSuggestedModel(provider, model);
}

/// Who made a set of suggestions, and where it runs.
String suggestionsByLabel(AppLocalizations l10n, AiProvider provider) =>
    provider.id == 'demo' ? l10n.actionsSuggestByDemo : l10n.actionsSuggestBy(provider.id, provider.location.name);

/// One step of an action's history.
String actionHistoryLabel(AppLocalizations l10n, ActionEvent event) => switch (event.change) {
  ActionChange.created => l10n.actionsHistoryAdded,
  ActionChange.state => actionStateLabel(l10n, event.state ?? ActionState.needsAction),
  ActionChange.edited => l10n.actionsHistoryEdited,
  ActionChange.due => l10n.actionsHistoryDue,
  ActionChange.reminder => l10n.actionsHistoryReminder,
  ActionChange.revised => l10n.actionsHistoryRevised,
  ActionChange.deleted => l10n.actionsHistoryDeleted,
  ActionChange.restored => l10n.actionsHistoryRestored,
};

/// "I need to" or "They will", for an action's details.
String actionOwnerLabel(AppLocalizations l10n, ActionOwner owner) =>
    owner == ActionOwner.me ? l10n.actionsOwnerMe : l10n.actionsOwnerThem;
