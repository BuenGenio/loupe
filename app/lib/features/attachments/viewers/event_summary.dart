import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:mail_calendar/mail_calendar.dart';

import '../../../theme/loupe_icons.dart';
import '../../../theme/theme.dart';
import '../../calendar/invitation_format.dart';
import '../../compose/send_later.dart' show deviceDateLocale;
import '../../conversation/sheets.dart' show subtleFill;

/// A calendar file's first event in plain words: title, when (in local
/// time, and in the event's zone when it differs), how often, where and who
/// organizes it. Shown above the file's text.
class EventSummaryCard extends StatelessWidget {
  const EventSummaryCard({super.key, required this.calendar, this.deviceZone});

  final Calendar calendar;

  /// The device's zone; null is the system's.
  final Zone? deviceZone;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final theme = Theme.of(context);
    final e = calendar.primary!;
    final format = EventTimeFormat(
      locale: deviceDateLocale(),
      use24h: MediaQuery.alwaysUse24HourFormatOf(context),
      deviceZone: deviceZone,
      now: clock.now(),
    );
    final span = eventSpan(e, calendar.zones);
    final when = span == null ? null : format.when(span);
    final rule = e.rule;
    final recurrence = rule == null || e.start == null
        ? null
        : describeRule(rule, start: e.start!, zones: calendar.zones, formatDate: format.date);
    final cancelled = calendar.method == ItipMethod.cancel || e.status == EventStatus.cancelled;
    final more = calendar.eventCount - 1;

    Widget line(IconData icon, String text) => Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: colors.secondaryText),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: styles.body.copyWith(fontSize: 15))),
        ],
      ),
    );

    return Container(
      key: const Key('event-summary'),
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(color: subtleFill(context), borderRadius: BorderRadius.circular(12)),
      child: SelectionArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LoupeIcons.calendar, color: theme.colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    e.summary ?? 'Event',
                    style: styles.body.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            if (cancelled)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text('Cancelled', style: styles.footnote.copyWith(color: colors.destructive)),
              ),
            if (when != null) line(LoupeIcons.time, when.time == null ? when.day : '${when.day}\n${when.time}'),
            if (recurrence != null) line(LoupeIcons.recurring, recurrence),
            if (e.location != null) line(LoupeIcons.location, e.location!),
            if (e.organizer case final organizer?) line(LoupeIcons.person, 'Organizer: ${organizer.displayName}'),
            if (more > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  more == 1 ? 'And 1 more event' : 'And $more more events',
                  style: styles.footnote.copyWith(color: colors.secondaryText),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
