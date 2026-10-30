import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../theme/theme.dart';
import '../calendar/device_calendar.dart';
import '../calendar/invitation_card.dart' show invitationZoneProvider;
import '../conversation/sheets.dart';

/// Whether [item] can become a calendar event: only when the message states
/// a calendar date for it. A task without one is never made an appointment.
bool briefHasEvent(BriefItem item) => item.due.date != null;

/// A time of day the passage states ("at 10:00", "10.30am", "2 pm"), or null.
/// Only the quote counts: a time the model worked out is no time.
({int hour, int minute})? briefStatedTime(String quote) {
  final twelve = RegExp(
    r'\b(1[0-2]|0?[1-9])(?:[:.]([0-5]\d))?\s?(am|pm|a\.m\.|p\.m\.)(?![a-z])',
    caseSensitive: false,
  ).firstMatch(quote);
  if (twelve != null) {
    final pm = twelve.group(3)!.toLowerCase().startsWith('p');
    final hour = int.parse(twelve.group(1)!) % 12 + (pm ? 12 : 0);
    return (hour: hour, minute: int.parse(twelve.group(2) ?? '0'));
  }
  final clock = RegExp(r'(?<![\d.,:£$€])\b([01]?\d|2[0-3]):([0-5]\d)\b').firstMatch(quote);
  if (clock == null) return null;
  return (hour: int.parse(clock.group(1)!), minute: int.parse(clock.group(2)!));
}

/// The event [item] proposes, for the phone's calendar app: its words, the
/// stated date, all day unless the passage states a time (then an hour from
/// it, in [timeZone]), and the passage and the message it comes from as
/// notes. Null when the item states no date.
DeviceEvent? briefEventFor(
  BriefItem item, {
  required EmailSummary message,
  required AppLocalizations l10n,
  String? timeZone,
}) {
  final date = item.due.date;
  if (date == null) return null;
  final time = item.evidence.isAttachmentName ? null : briefStatedTime(item.evidence.quote);
  final day = DateTime(date.year, date.month, date.day);
  final start = time == null ? day : DateTime(date.year, date.month, date.day, time.hour, time.minute);
  final from = l10n.briefEventFrom(
    message.subject.isEmpty ? l10n.mailNoSubject : message.subject,
    message.sender?.displayName ?? l10n.conversationNoSender,
  );
  return DeviceEvent(
    title: item.text,
    start: start,
    end: time == null ? DateTime(date.year, date.month, date.day + 1) : start.add(const Duration(hours: 1)),
    allDay: time == null,
    timeZone: time == null ? null : timeZone,
    description: item.evidence.isAttachmentName ? from : '${item.evidence.quote}\n\n$from',
  );
}

/// Add to Calendar… of a Brief item: shows the event first (title, date,
/// all day or the time, the time zone, the notes), and only Add to Calendar
/// hands it to the phone's calendar app, which asks before it saves.
Future<void> addBriefItemToCalendar(
  BuildContext context,
  WidgetRef ref, {
  required BriefItem item,
  required EmailSummary message,
}) async {
  final l10n = context.l10n;
  final messenger = ScaffoldMessenger.of(context);
  final zone = ref.read(invitationZoneProvider);
  final zoneName = zone?.ianaName ?? DateTime.now().timeZoneName;
  final event = briefEventFor(item, message: message, l10n: l10n, timeZone: zone?.ianaName);
  if (event == null) return;
  final add = await showLoupeSheet<bool>(
    context,
    builder: (context) => BriefEventPreview(event: event, zoneName: zoneName),
  );
  if (add != true) return;
  try {
    final opened = await ref.read(deviceCalendarProvider).add(event);
    if (!opened && defaultTargetPlatform == TargetPlatform.android) showSnack(messenger, l10n.calendarNoCalendarApp);
  } on Object {
    showSnack(messenger, l10n.calendarCantOpenCalendar);
  }
}

/// The event as it will go to the calendar app.
class BriefEventPreview extends StatelessWidget {
  const BriefEventPreview({super.key, required this.event, required this.zoneName});

  final DeviceEvent event;

  /// The zone the time is in: this phone's.
  final String zoneName;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    final time = event.allDay
        ? l10n.briefEventAllDay
        : l10n.briefEventTimeRange(DateFormat.jm().format(event.start), DateFormat.jm().format(event.end));
    Widget row(String label, String value, {Key? key}) => ListTile(
      key: key,
      dense: true,
      title: Text(label, style: styles.footnote),
      subtitle: Text(value, style: styles.body),
    );
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Column(
          key: const Key('brief-event-preview'),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
              child: Row(
                children: [
                  Expanded(child: Text(l10n.briefEventTitle, style: styles.navTitle)),
                  TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.commonCancel)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Text(event.title, style: styles.body.copyWith(fontWeight: FontWeight.w600)),
            ),
            SheetGroup(
              children: [
                row(
                  l10n.briefEventDate,
                  DateFormat.yMMMMEEEEd().format(event.start),
                  key: const Key('brief-event-date'),
                ),
                row(l10n.briefEventTime, time, key: const Key('brief-event-time')),
                row(l10n.briefEventZone, zoneName, key: const Key('brief-event-zone')),
                if (event.description case final notes?) row(l10n.briefEventNotes, notes),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: CupertinoButton.filled(
                key: const Key('brief-event-add'),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(l10n.calendarAddToCalendar),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Text(l10n.briefEventFootnote, style: styles.footnote, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
