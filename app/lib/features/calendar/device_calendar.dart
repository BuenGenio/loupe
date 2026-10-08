import 'package:add_2_calendar/add_2_calendar.dart' as a2c;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_calendar/mail_calendar.dart';

import '../../l10n/l10n.dart';
import 'invitation.dart';

/// An event for the phone's calendar app, which shows it for the user to
/// save (nothing is written without them).
@immutable
final class DeviceEvent {
  const DeviceEvent({
    required this.title,
    required this.start,
    required this.end,
    this.allDay = false,
    this.timeZone,
    this.location,
    this.description,
    this.url,
    this.rule,
  });

  final String title;
  final DateTime start;
  final DateTime end;
  final bool allDay;

  /// The IANA zone the event is written in, if any.
  final String? timeZone;
  final String? location;
  final String? description;

  /// The meeting link.
  final Uri? url;

  /// The recurrence (Android takes the RRULE as it is; iOS its frequency,
  /// interval and end).
  final RecurrenceRule? rule;
}

/// The phone's calendar: hands it an event to add. A seam, so tests check
/// what would be added.
abstract interface class DeviceCalendar {
  /// Opens the calendar app's (or the system's) new-event screen with
  /// [event] filled in. False when no calendar app took it, or the user
  /// cancelled (iOS).
  Future<bool> add(DeviceEvent event);
}

/// Android's calendar insert intent (ACTION_INSERT with CalendarContract's
/// extras: no calendar permission) and iOS's EventKit add-event sheet, by
/// add_2_calendar.
final class Add2CalendarDevice implements DeviceCalendar {
  const Add2CalendarDevice();

  @override
  Future<bool> add(DeviceEvent event) {
    final rule = event.rule;
    final frequency = switch (rule?.frequency) {
      Frequency.daily => a2c.Frequency.daily,
      Frequency.weekly => a2c.Frequency.weekly,
      Frequency.monthly => a2c.Frequency.monthly,
      Frequency.yearly => a2c.Frequency.yearly,
      _ => null,
    };
    final until = rule?.until;
    return a2c.Add2Calendar.addEvent2Cal(
      a2c.Event(
        title: event.title,
        description: event.description,
        location: event.location,
        startDate: event.start,
        endDate: event.end,
        timeZone: event.timeZone,
        allDay: event.allDay,
        iosParams: a2c.IOSParams(url: event.url?.toString()),
        recurrence: rule == null || frequency == null
            ? null
            : a2c.Recurrence(
                frequency: frequency,
                interval: rule.interval,
                ocurrences: rule.count,
                endDate: rule.count == null ? until?.local : null,
                rRule: rule.value,
              ),
      ),
    );
  }
}

final deviceCalendarProvider = Provider<DeviceCalendar>((ref) => const Add2CalendarDevice());

/// What "Add to Calendar" hands the phone for [invitation]: its title,
/// first occurrence, zone, place, recurrence and meeting link (in the notes
/// too, as calendar apps show those), with [l10n]'s words.
DeviceEvent? deviceEventFor(Invitation invitation, AppLocalizations l10n) {
  final span = invitation.span;
  if (span == null) return null;
  final event = invitation.event;
  final link = invitation.meetingLink?.uri;
  final notes = event.description?.trim();
  final description = [
    if (notes != null && notes.isNotEmpty) notes,
    if (link != null && !(notes?.contains(link.toString()) ?? false)) l10n.calendarJoinNote('$link'),
  ].join('\n\n');
  return DeviceEvent(
    title: event.summary ?? l10n.calendarUntitledEvent,
    start: span.start,
    end: span.end,
    allDay: span.allDay,
    timeZone: span.zone?.ianaName,
    location: event.location,
    description: description.isEmpty ? null : description,
    url: link,
    rule: event.rule,
  );
}
