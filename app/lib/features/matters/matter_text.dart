import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';

/// Why a conversation is suggested, as the suggestion says it. A shared
/// sender or domain says that alone it isn't evidence.
String matterReasonText(MatterReason reason, AppLocalizations l10n) => switch (reason.kind) {
  MatterReasonKind.mentions => l10n.mattersReasonMentions(reason.value),
  MatterReasonKind.sameSender => l10n.mattersReasonSameSender(reason.value),
  MatterReasonKind.sameDomain => l10n.mattersReasonSameDomain(reason.value),
};

/// One entry of a matter's activity.
String matterEventText(MatterEvent event, AppLocalizations l10n) {
  final subject = event.text.trim().isEmpty ? l10n.mailNoSubject : event.text;
  return switch (event.kind) {
    MatterEventKind.created => l10n.mattersEventCreated,
    MatterEventKind.renamed => l10n.mattersEventRenamed(event.text),
    MatterEventKind.added when event.source == MatterSource.suggested => l10n.mattersEventAddedSuggested(subject),
    MatterEventKind.added => l10n.mattersEventAdded(subject),
    MatterEventKind.removed => l10n.mattersEventRemoved(subject),
    MatterEventKind.merged => l10n.mattersEventMerged(event.count, event.text),
    MatterEventKind.splitOff => l10n.mattersMovedTo(event.count, event.text),
    MatterEventKind.splitFrom => l10n.mattersEventSplitFrom(event.count, event.text),
  };
}
