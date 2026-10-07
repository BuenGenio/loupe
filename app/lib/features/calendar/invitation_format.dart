import 'package:intl/intl.dart';
import 'package:mail_calendar/mail_calendar.dart';

/// How invitations write times: the device's locale and clock (12 or 24
/// hours) and its time zone ([deviceZone]; the system's when null).
final class EventTimeFormat {
  EventTimeFormat({this.locale = 'en_US', this.use24h = false, this.deviceZone, required this.now});

  final String locale;
  final bool use24h;
  final Zone? deviceZone;
  final DateTime now;

  /// [t] on the device's clock: instants converted, wall-clock times (all
  /// day, floating) as they are.
  DateTime local(DateTime t) {
    if (!t.isUtc) return t;
    final zone = deviceZone;
    if (zone == null) return t.toLocal();
    final w = zone.toWall(t);
    return DateTime(w.year, w.month, w.day, w.hour, w.minute, w.second);
  }

  Duration _localOffset(DateTime instant) => deviceZone?.offsetAt(instant) ?? instant.toLocal().timeZoneOffset;

  String time(DateTime t) => (use24h ? DateFormat.Hm(locale) : DateFormat.jm(locale)).format(t);

  bool _thisYear(DateTime t) => t.year == local(now.toUtc()).year;

  /// "Tuesday, October 13" (with the year when it isn't this one).
  String day(DateTime t) => (_thisYear(t) ? DateFormat.MMMMEEEEd(locale) : DateFormat.yMMMMEEEEd(locale)).format(t);

  /// "Tue, Oct 13".
  String shortDay(DateTime t) => (_thisYear(t) ? DateFormat.MMMEd(locale) : DateFormat.yMMMEd(locale)).format(t);

  /// "Dec 1, 2026", for the end of a recurrence.
  String date(DateTime t) => DateFormat.yMMMd(locale).format(t);

  static bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

  /// When [span] happens, in two lines: the day(s), and the times, in the
  /// device's zone; when the event is written in another zone with another
  /// offset, its own times first: "09:00–10:00 London · 17:00–18:00 your time".
  ({String day, String? time}) when(TimeSpan span) {
    if (span.allDay) {
      final last = span.lastDay;
      if (!last.isAfter(span.start)) return (day: day(span.start), time: 'All day');
      return (day: '${shortDay(span.start)} – ${shortDay(last)}', time: 'All day');
    }
    final s = local(span.start);
    final e = local(span.end);
    final mine = _range(s, e);
    if (!_sameDay(s, e) && e.isAfter(s.add(const Duration(days: 1)))) {
      // Several days: one line.
      return (day: '${shortDay(s)}, ${time(s)} – ${shortDay(e)}, ${time(e)}', time: _elsewhere(span, null));
    }
    final elsewhere = _elsewhere(span, s);
    return (day: day(s), time: elsewhere == null ? mine : '$elsewhere · $mine your time');
  }

  String _range(DateTime s, DateTime e) => s == e ? time(s) : '${time(s)}–${time(e)}';

  /// The event's own times and zone, when its offset isn't the device's:
  /// "09:00–10:00 London" (with the weekday when the day differs from
  /// [localStart]'s). For an unknown zone, its name.
  String? _elsewhere(TimeSpan span, DateTime? localStart) {
    final zone = span.zone;
    if (zone == null || !span.start.isUtc) return null;
    if (zone.offsetAt(span.start) == _localOffset(span.start) && zone.offsetAt(span.end) == _localOffset(span.end)) {
      return null;
    }
    DateTime wall(DateTime t) {
      final w = zone.toWall(t);
      return DateTime(w.year, w.month, w.day, w.hour, w.minute);
    }

    final s = wall(span.start);
    final e = wall(span.end);
    final weekday = localStart != null && !_sameDay(s, localStart) ? '${DateFormat.E(locale).format(s)} ' : '';
    return '$weekday${_range(s, e)} ${zoneLabel(zone, span.start)}';
  }

  /// The times as the event's zone has them (for the organizer, in a reply).
  String inZone(TimeSpan span) {
    if (span.allDay) return when(span).day;
    final zone = span.zone;
    if (zone == null || !span.start.isUtc) {
      final w = when(span);
      return w.time == null ? w.day : '${w.day}, ${w.time}';
    }
    final f = EventTimeFormat(locale: locale, use24h: use24h, deviceZone: zone, now: now);
    final w = f.when(span);
    final label = zoneLabel(zone, span.start);
    return w.time == null ? '${w.day} ($label)' : '${w.day}, ${w.time} ($label)';
  }
}

/// The text of a reply, for people (and mail apps) that don't read the
/// calendar part: "Sam Rivera has accepted: Planning, Tuesday, October 13,
/// 9:00 AM–10:00 AM (Los Angeles)", and the comment.
String replyText({
  required String name,
  required PartStat answer,
  required String? title,
  required TimeSpan? span,
  required EventTimeFormat format,
  String? comment,
}) {
  final what = [
    if (title != null && title.trim().isNotEmpty) title.trim(),
    if (span != null) format.inZone(span),
  ].join(', ');
  final line = '$name has ${partStatVerb(answer)}${what.isEmpty ? ' the invitation' : ': $what'}';
  final note = comment?.trim() ?? '';
  return note.isEmpty ? '$line\n' : '$line\n\n$note\n';
}
