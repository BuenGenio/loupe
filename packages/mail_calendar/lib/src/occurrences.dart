/// When an event happens: its time span, its zone and its next occurrences.
library;

import 'event.dart';
import 'rrule.dart';
import 'time_zones.dart';
import 'values.dart';

/// One occurrence of an event.
///
/// Times with a zone (or UTC) are instants ([DateTime.isUtc]); all-day and
/// floating times are wall-clock times in the device's local time (not
/// UTC), the same everywhere.
final class TimeSpan {
  const TimeSpan({required this.start, required this.end, this.allDay = false, this.zone, this.unknownZone = false});

  final DateTime start;

  /// Exclusive: an all-day event of one day ends the next day.
  final DateTime end;
  final bool allDay;

  /// The zone the event is written in, when it has one (not UTC).
  final Zone? zone;

  /// The TZID couldn't be found: the times are shown as written.
  final bool unknownZone;

  /// Neither an instant nor a date: the same wall-clock time anywhere.
  bool get floating => !allDay && !start.isUtc;

  /// The last day of an all-day event.
  DateTime get lastDay => allDay ? DateTime(end.year, end.month, end.day - 1) : end;

  @override
  bool operator ==(Object other) =>
      other is TimeSpan && other.start == start && other.end == end && other.allDay == allDay;

  @override
  int get hashCode => Object.hash(start, end, allDay);

  @override
  String toString() => '$start – $end${allDay ? ' (all day)' : ''}';
}

DateTime _localWall(DateTime w) => DateTime(w.year, w.month, w.day, w.hour, w.minute, w.second);

/// [wall] (fields of a time written like [like]) as a [TimeSpan] time.
DateTime _resolve(CalDateTime like, DateTime wall, ZoneResolver zones) {
  final t = CalDateTime.like(like, wall);
  return zones.instant(t) ?? _localWall(wall);
}

/// The span of [event]'s first occurrence (its DTSTART), or null without a
/// start.
TimeSpan? eventSpan(CalendarEvent event, ZoneResolver zones) {
  final s = event.start;
  if (s == null) return null;
  return _span(event, s.local, zones);
}

TimeSpan _span(CalendarEvent event, DateTime wall, ZoneResolver zones) {
  final s = event.start!;
  final e = event.end ?? s;
  final length = e.local.difference(s.local);
  final zone = s.form == TimeForm.zoned ? zones.zone(s.tzid!) : null;
  final DateTime start;
  final DateTime end;
  if (s.isDate) {
    start = DateTime(wall.year, wall.month, wall.day);
    final last = wall.add(length);
    end = DateTime(last.year, last.month, last.day);
  } else if (e.form == s.form && e.tzid == s.tzid) {
    start = _resolve(s, wall, zones);
    end = _resolve(s, wall.add(length), zones);
  } else {
    // DTEND in another zone (Outlook does this): the same length as the first time.
    start = _resolve(s, wall, zones);
    final firstStart = zones.instant(s);
    final firstEnd = zones.instant(e);
    end = firstStart != null && firstEnd != null
        ? start.add(firstEnd.difference(firstStart))
        : _resolve(s, wall.add(length), zones);
  }
  return TimeSpan(
    start: start,
    end: end.isBefore(start) ? start : end,
    allDay: s.isDate,
    zone: zone,
    unknownZone: zones.isUnknown(s),
  );
}

/// The occurrences of [event] that haven't ended at [from] (all of them
/// without it), at most [limit]: its RRULE and RDATEs, without its
/// EXDATEs. A single event has one.
List<TimeSpan> eventOccurrences(CalendarEvent event, ZoneResolver zones, {DateTime? from, int limit = 10}) {
  final s = event.start;
  if (s == null || limit <= 0) return const [];
  final rule = event.rule;
  bool ended(TimeSpan o) => from != null && !o.end.isAfter(from);

  // Wall-clock times of the rule, in DTSTART's zone.
  DateTime wallOf(CalDateTime t) {
    if (s.isDate) return DateTime.utc(t.local.year, t.local.month, t.local.day, s.local.hour);
    if (t.form == s.form && t.tzid == s.tzid) return t.local;
    final instant = zones.instant(t);
    if (instant == null) return t.local;
    return zones.wallLike(s, instant);
  }

  final excluded = {for (final x in event.exceptionDates) _key(wallOf(x), s.isDate)};
  final extra = [for (final r in event.recurrenceDates) wallOf(r)]..sort();
  DateTime? until;
  final u = rule?.until;
  if (u != null) {
    if (u.isDate && !s.isDate) {
      until = DateTime.utc(u.local.year, u.local.month, u.local.day, 23, 59, 59);
    } else if (u.isUtc && s.form == TimeForm.zoned) {
      until = zones.wallLike(s, u.local);
    } else {
      until = u.local;
    }
  }
  final out = <TimeSpan>[];
  final seen = <String>{};
  final ruled = rule == null ? <DateTime>[s.local] : expandRule(rule, s.local, until: until);
  final it = ruled.iterator;
  var hasRuled = it.moveNext();
  var extraIndex = 0;
  var guard = 0;
  while (out.length < limit && guard++ < 100000) {
    DateTime? next;
    if (hasRuled && (extraIndex >= extra.length || !extra[extraIndex].isAfter(it.current))) {
      next = it.current;
      hasRuled = it.moveNext();
    } else if (extraIndex < extra.length) {
      next = extra[extraIndex++];
    } else {
      break;
    }
    final key = _key(next, s.isDate);
    if (excluded.contains(key) || !seen.add(key)) continue;
    final o = _span(event, next, zones);
    if (ended(o)) continue;
    out.add(o);
  }
  return out;
}

String _key(DateTime wall, bool date) => date ? '${wall.year}-${wall.month}-${wall.day}' : wall.toIso8601String();
