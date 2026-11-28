import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';

/// Where a Brief item stands on the reader's checklist.
enum BriefItemState { open, done, dismissed }

/// An item's identity within one message's Brief: what it is and where it
/// comes from, so the same item from a later run of the same Brief keeps its
/// tick.
String briefItemKey(BriefItem item) =>
    '${item.kind.name}|${item.evidence.start}|${item.evidence.end}|${item.evidence.quote}|${item.text}';

/// Ticks and dismissals of Brief items, by message id and [briefItemKey].
/// They last for the session: what the reader decided, kept apart from the
/// Brief itself, so clearing Private AI's results doesn't undo a tick. Durable
/// completion and reminders belong to tracked actions ([BriefItemTracker]).
final briefChecklistProvider = NotifierProvider<BriefChecklist, Map<String, Map<String, BriefItemState>>>(
  BriefChecklist.new,
);

class BriefChecklist extends Notifier<Map<String, Map<String, BriefItemState>>> {
  @override
  Map<String, Map<String, BriefItemState>> build() => const {};

  void set(String emailId, BriefItem item, BriefItemState value) {
    final items = {...?state[emailId]};
    final key = briefItemKey(item);
    if (value == BriefItemState.open) {
      items.remove(key);
    } else {
      items[key] = value;
    }
    state = {...state, emailId: items};
  }
}

/// The groups a Brief is shown in, in this order.
enum BriefGroup { toDo, documents, otherDocuments, dates, conditions, next }

BriefGroup briefGroupOf(BriefItem item) => switch (item.kind) {
  BriefItemKind.action => BriefGroup.toDo,
  BriefItemKind.document when item.owner == BriefOwner.me => BriefGroup.documents,
  BriefItemKind.document => BriefGroup.otherDocuments,
  BriefItemKind.date => BriefGroup.dates,
  BriefItemKind.condition => BriefGroup.conditions,
  BriefItemKind.next => BriefGroup.next,
};

String briefGroupTitle(AppLocalizations l10n, BriefGroup group) => switch (group) {
  BriefGroup.toDo => l10n.briefSectionToDo,
  BriefGroup.documents => l10n.briefSectionDocuments,
  BriefGroup.otherDocuments => l10n.briefSectionOtherDocuments,
  BriefGroup.dates => l10n.briefSectionDates,
  BriefGroup.conditions => l10n.briefSectionConditions,
  BriefGroup.next => l10n.briefSectionNext,
};

/// The item's timing in words, labelled for what it is: a deadline, a stated
/// date, a target, or a timing measured from an event (never shown as a
/// date). Null when there is nothing to say; "No deadline stated" only for
/// what the reader must do or send.
String? briefTiming(AppLocalizations l10n, BriefItem item, {DateTime? now}) {
  final due = item.due;
  final date = due.date;
  final written = due.text?.trim() ?? '';
  // As the message words it; the stated date when it gives no words.
  final when = written.isNotEmpty ? written : (date == null ? null : briefDate(date, now: now));
  return switch (due.kind) {
    DueKind.explicit when item.kind == BriefItemKind.date && date != null => l10n.briefDueOn(briefDate(date, now: now)),
    DueKind.explicit => when == null ? null : l10n.briefDueDeadline(when),
    DueKind.suggested => when == null ? null : l10n.briefDueSuggested(when),
    // Never a date: it counts from an event, not from today.
    DueKind.conditional => written.isEmpty ? null : l10n.briefDueConditional(written),
    DueKind.none =>
      item.owner == BriefOwner.me && (item.kind == BriefItemKind.action || item.kind == BriefItemKind.document)
          ? l10n.briefDueNone
          : null,
  };
}

/// A stated date, as the app writes dates: the weekday, day and month, and
/// the year when it isn't this year's.
String briefDate(DateTime date, {DateTime? now}) {
  final year = (now ?? DateTime.now()).year;
  return (date.year == year ? DateFormat.MMMMEEEEd() : DateFormat.yMMMMEEEEd()).format(date);
}

/// One item as plain text: its words, then how and when, as the Brief shows
/// them. Never a quote of the message: a Brief has no secrets in it, and a
/// copy keeps it that way.
String briefItemText(AppLocalizations l10n, BriefItem item, {DateTime? now}) {
  final details = [?item.channel, ?briefTiming(l10n, item, now: now)];
  return details.isEmpty ? item.text : '${item.text}\n   ${details.join(' · ')}';
}

/// Copy Checklist: the subject, the summary, then each group's items that
/// weren't dismissed, ticked (☑) or not (☐).
String briefChecklistText(
  AppLocalizations l10n, {
  required EmailSummary message,
  required Brief brief,
  required Map<String, BriefItemState> states,
  DateTime? now,
}) {
  final out = StringBuffer(message.subject.isEmpty ? l10n.mailNoSubject : message.subject);
  if (brief.summary.isNotEmpty) out.write('\n${brief.summary}');
  for (final group in BriefGroup.values) {
    final items = [
      for (final item in brief.items)
        if (briefGroupOf(item) == group && states[briefItemKey(item)] != BriefItemState.dismissed) item,
    ];
    if (items.isEmpty) continue;
    out.write('\n\n${briefGroupTitle(l10n, group)}');
    for (final item in items) {
      final mark = states[briefItemKey(item)] == BriefItemState.done ? '☑' : '☐';
      out.write('\n$mark ${briefItemText(l10n, item, now: now)}');
    }
  }
  return out.toString();
}
