import 'package:intl/intl.dart';

/// The parts of an iCalendar event worth a summary.
final class IcsEvent {
  const IcsEvent({
    this.summary,
    this.start,
    this.end,
    this.allDay = false,
    this.utc = false,
    this.timeZone,
    this.location,
    this.organizer,
    this.cancelled = false,
  });

  final String? summary;

  /// Wall-clock time as written, or a UTC time when [utc] (shown in local
  /// time). Dates only when [allDay].
  final DateTime? start;

  /// Exclusive end (the day after the last one, for all-day events).
  final DateTime? end;
  final bool allDay;
  final bool utc;

  /// The TZID the times are written in (not converted: no time zone
  /// database here).
  final String? timeZone;
  final String? location;

  /// The organizer's name, or their address.
  final String? organizer;
  final bool cancelled;
}

/// Joins folded lines (a line break followed by a space or tab continues
/// the line).
String _unfold(String text) => text.replaceAll(RegExp(r'\r?\n[ \t]'), '');

/// Undoes TEXT escapes: `\n`, `\,`, `\;` and `\\`.
String _unescape(String value) => value.replaceAllMapped(RegExp(r'\\([nN,;\\])'), (m) {
  final c = m[1]!;
  return c == 'n' || c == 'N' ? '\n' : c;
});

typedef _Property = ({String name, Map<String, String> params, String value});

/// `NAME;PARAM=a;PARAM2="b:c":value`. The value starts after the first
/// colon outside quotes.
_Property? _parseLine(String line) {
  var quoted = false;
  var colon = -1;
  for (var i = 0; i < line.length; i++) {
    final ch = line[i];
    if (ch == '"') quoted = !quoted;
    if (ch == ':' && !quoted) {
      colon = i;
      break;
    }
  }
  if (colon <= 0) return null;
  final head = line.substring(0, colon);
  final parts = <String>[];
  quoted = false;
  var start = 0;
  for (var i = 0; i < head.length; i++) {
    if (head[i] == '"') quoted = !quoted;
    if (head[i] == ';' && !quoted) {
      parts.add(head.substring(start, i));
      start = i + 1;
    }
  }
  parts.add(head.substring(start));
  final params = <String, String>{};
  for (final p in parts.skip(1)) {
    final eq = p.indexOf('=');
    if (eq <= 0) continue;
    var v = p.substring(eq + 1);
    if (v.length >= 2 && v.startsWith('"') && v.endsWith('"')) v = v.substring(1, v.length - 1);
    params[p.substring(0, eq).toUpperCase()] = v;
  }
  return (name: parts.first.toUpperCase(), params: params, value: line.substring(colon + 1));
}

final _dateTime = RegExp(r'^(\d{4})(\d{2})(\d{2})(?:T(\d{2})(\d{2})(\d{2})?(Z)?)?$');

/// An iCalendar DATE or DATE-TIME: (time, utc, dateOnly), or null.
(DateTime, bool, bool)? _parseDate(String value) {
  final m = _dateTime.firstMatch(value.trim());
  if (m == null) return null;
  int n(int g) => int.parse(m[g] ?? '0');
  if (m[4] == null) return (DateTime(n(1), n(2), n(3)), false, true);
  final utc = m[7] != null;
  final t = utc ? DateTime.utc(n(1), n(2), n(3), n(4), n(5), n(6)) : DateTime(n(1), n(2), n(3), n(4), n(5), n(6));
  return (t, utc, false);
}

final _duration = RegExp(r'^([+-])?P(?:(\d+)W)?(?:(\d+)D)?(?:T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?)?$');

Duration? _parseDuration(String value) {
  final m = _duration.firstMatch(value.trim());
  if (m == null) return null;
  int n(int g) => int.parse(m[g] ?? '0');
  final d = Duration(days: n(2) * 7 + n(3), hours: n(4), minutes: n(5), seconds: n(6));
  return m[1] == '-' ? -d : d;
}

String? _organizer(_Property p) {
  final name = p.params['CN']?.trim();
  if (name != null && name.isNotEmpty) return name;
  final v = p.value.trim();
  return v.toLowerCase().startsWith('mailto:') ? v.substring(7) : (v.isEmpty ? null : v);
}

/// The events of an iCalendar file, in order. Properties of nested
/// components (alarms) don't leak into their event. Times are not converted
/// between time zones: a TZID time is kept as written, with [IcsEvent.timeZone].
List<IcsEvent> parseIcsEvents(String text) {
  final events = <IcsEvent>[];
  final stack = <String>[];
  var cancelledCalendar = false;
  Map<String, _Property>? current;

  for (final raw in _unfold(text).split(RegExp(r'\r?\n|\r'))) {
    final p = _parseLine(raw.trimRight());
    if (p == null) continue;
    if (p.name == 'BEGIN') {
      final component = p.value.trim().toUpperCase();
      stack.add(component);
      if (component == 'VEVENT') current = {};
      continue;
    }
    if (p.name == 'END') {
      if (stack.isNotEmpty) stack.removeLast();
      if (p.value.trim().toUpperCase() == 'VEVENT' && current != null) {
        events.add(_event(current, cancelledCalendar: cancelledCalendar));
        current = null;
      }
      continue;
    }
    if (stack.isNotEmpty && stack.last == 'VCALENDAR' && p.name == 'METHOD') {
      cancelledCalendar = p.value.trim().toUpperCase() == 'CANCEL';
    }
    if (current != null && stack.isNotEmpty && stack.last == 'VEVENT') current.putIfAbsent(p.name, () => p);
  }
  return events;
}

IcsEvent _event(Map<String, _Property> props, {required bool cancelledCalendar}) {
  String? text(String name) {
    final v = props[name]?.value;
    if (v == null) return null;
    final s = _unescape(v).trim();
    return s.isEmpty ? null : s;
  }

  final startProp = props['DTSTART'];
  final start = startProp == null ? null : _parseDate(startProp.value);
  final allDay = start != null && (start.$3 || startProp!.params['VALUE']?.toUpperCase() == 'DATE');
  DateTime? end;
  final endProp = props['DTEND'] ?? props['DUE'];
  if (endProp != null) {
    end = _parseDate(endProp.value)?.$1;
  } else if (start != null) {
    final d = props['DURATION'] == null ? null : _parseDuration(props['DURATION']!.value);
    if (d != null) {
      end = start.$1.add(d);
    } else if (allDay) {
      end = start.$1.add(const Duration(days: 1));
    }
  }
  final status = props['STATUS']?.value.trim().toUpperCase();
  return IcsEvent(
    summary: text('SUMMARY'),
    start: start?.$1,
    end: end,
    allDay: allDay,
    utc: start?.$2 ?? false,
    timeZone: startProp?.params['TZID'],
    location: text('LOCATION'),
    organizer: props['ORGANIZER'] == null ? null : _organizer(props['ORGANIZER']!),
    cancelled: cancelledCalendar || status == 'CANCELLED',
  );
}

/// When an event happens, in the user's locale: "Tue, Oct 6, 2026, 2:00 PM –
/// 3:00 PM", "Tue, Oct 6, 2026 (all day)". UTC times show in local time; a
/// TZID time shows as written, followed by the zone.
String describeIcsTime(IcsEvent e) {
  final start = e.start;
  if (start == null) return '';
  final day = DateFormat.yMMMEd();
  final time = DateFormat.jm();
  if (e.allDay) {
    // DTEND is exclusive: a one-day event ends the next day.
    final last = e.end?.subtract(const Duration(days: 1));
    if (last == null || !last.isAfter(start)) return '${day.format(start)} (all day)';
    return '${day.format(start)} – ${day.format(last)}';
  }
  final s = e.utc ? start.toLocal() : start;
  final end = e.end == null ? null : (e.utc ? e.end!.toLocal() : e.end!);
  final zone = !e.utc && e.timeZone != null ? ' (${e.timeZone})' : '';
  if (end == null) return '${day.format(s)}, ${time.format(s)}$zone';
  final sameDay = s.year == end.year && s.month == end.month && s.day == end.day;
  if (sameDay) return '${day.format(s)}, ${time.format(s)} – ${time.format(end)}$zone';
  return '${day.format(s)}, ${time.format(s)} – ${day.format(end)}, ${time.format(end)}$zone';
}
