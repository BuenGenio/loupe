/// Value types: DATE and DATE-TIME (§3.3.4, §3.3.5), DURATION (§3.3.6) and
/// UTC-OFFSET (§3.3.14).
library;

import 'content_line.dart';

/// How a DATE-TIME is anchored (RFC 5545 §3.3.5).
enum TimeForm {
  /// A DATE: an all-day value, no time.
  date,

  /// Local time without a zone: the same wall-clock time everywhere.
  floating,

  /// UTC (`…Z`).
  utc,

  /// Local time in the zone named by [CalDateTime.tzid].
  zoned,
}

/// A DATE or DATE-TIME as written: its wall-clock fields ([local]), how
/// they are anchored ([form]) and the TZID of a zoned time.
final class CalDateTime implements Comparable<CalDateTime> {
  const CalDateTime._(this.local, this.form, this.tzid);

  /// An all-day DATE.
  factory CalDateTime.date(int year, int month, int day) =>
      CalDateTime._(DateTime.utc(year, month, day), TimeForm.date, null);

  /// Wall-clock time without a zone.
  factory CalDateTime.floating(DateTime wall) => CalDateTime._(_fields(wall), TimeForm.floating, null);

  /// An instant, written in UTC.
  factory CalDateTime.utc(DateTime instant) => CalDateTime._(_fields(instant.toUtc()), TimeForm.utc, null);

  /// Wall-clock time in the zone [tzid].
  factory CalDateTime.zoned(DateTime wall, String tzid) => CalDateTime._(_fields(wall), TimeForm.zoned, tzid);

  /// The same form and zone as [like], at the wall-clock time [wall].
  factory CalDateTime.like(CalDateTime like, DateTime wall) =>
      CalDateTime._(like.isDate ? DateTime.utc(wall.year, wall.month, wall.day) : _fields(wall), like.form, like.tzid);

  static DateTime _fields(DateTime d) => DateTime.utc(d.year, d.month, d.day, d.hour, d.minute, d.second);

  /// The wall-clock fields, carried in a UTC [DateTime] (only its fields
  /// mean anything; for [TimeForm.utc] it is the instant itself).
  final DateTime local;
  final TimeForm form;

  /// The TZID of a [TimeForm.zoned] time.
  final String? tzid;

  bool get isDate => form == TimeForm.date;
  bool get isUtc => form == TimeForm.utc;

  static final _pattern = RegExp(r'^(\d{4})(\d{2})(\d{2})(?:[Tt](\d{2})(\d{2})(\d{2})?([Zz])?)?$');

  /// Parses a DATE or DATE-TIME [value]. [tzid] is the TZID parameter
  /// (ignored for UTC times and dates). Null when it isn't one.
  static CalDateTime? parse(String value, {String? tzid}) {
    final m = _pattern.firstMatch(value.trim());
    if (m == null) return null;
    int n(int g) => int.parse(m[g] ?? '0');
    final (year, month, day) = (n(1), n(2), n(3));
    if (month < 1 || month > 12 || day < 1 || day > _daysIn(year, month)) return null;
    if (m[4] == null) return CalDateTime.date(year, month, day);
    final (hour, minute) = (n(4), n(5));
    final second = n(6).clamp(0, 59);
    if (hour > 23 || minute > 59) {
      // 24:00:00 is sometimes written for midnight at the end of a day.
      if (hour == 24 && minute == 0 && second == 0) {
        final next = DateTime.utc(year, month, day + 1);
        return parse('${_date(next)}T000000${m[7] ?? ''}', tzid: tzid);
      }
      return null;
    }
    final wall = DateTime.utc(year, month, day, hour, minute, second);
    if (m[7] != null) return CalDateTime._(wall, TimeForm.utc, null);
    final zone = tzid?.trim();
    if (zone != null && zone.isNotEmpty) return CalDateTime._(wall, TimeForm.zoned, zone);
    return CalDateTime._(wall, TimeForm.floating, null);
  }

  /// Parses the value of [property], with its TZID.
  static CalDateTime? fromProperty(Property property) =>
      parse(property.value.split(',').first, tzid: property.param('TZID'));

  /// As written in iCalendar: `20261008`, `20261008T090000` or `20261008T090000Z`.
  String get value => switch (form) {
    TimeForm.date => _date(local),
    TimeForm.utc => '${_date(local)}T${_time(local)}Z',
    _ => '${_date(local)}T${_time(local)}',
  };

  /// A property [name] with this value (TZID, or VALUE=DATE).
  Property toProperty(String name, {Map<String, List<String>> params = const {}}) => Property(
    name,
    value,
    params: {
      ...params,
      if (form == TimeForm.zoned) 'TZID': [tzid!],
      if (isDate) 'VALUE': ['DATE'],
    },
  );

  @override
  int compareTo(CalDateTime other) => local.compareTo(other.local);

  @override
  bool operator ==(Object other) =>
      other is CalDateTime && other.local == local && other.form == form && other.tzid == tzid;

  @override
  int get hashCode => Object.hash(local, form, tzid);

  @override
  String toString() => form == TimeForm.zoned ? '$tzid:$value' : value;
}

int _daysIn(int year, int month) => DateTime.utc(year, month + 1, 0).day;

String _two(int n) => n.toString().padLeft(2, '0');
String _date(DateTime d) => '${d.year.toString().padLeft(4, '0')}${_two(d.month)}${_two(d.day)}';
String _time(DateTime d) => '${_two(d.hour)}${_two(d.minute)}${_two(d.second)}';

/// A DURATION: nominal days (and weeks), which follow the wall clock, and
/// an exact time part.
final class CalDuration {
  const CalDuration({this.days = 0, this.seconds = 0, this.negative = false});

  final int days;
  final int seconds;
  final bool negative;

  static final _pattern = RegExp(
    r'^([+-])?P(?:(\d+)W)?(?:(\d+)D)?(?:T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?)?$',
    caseSensitive: false,
  );

  static CalDuration? parse(String value) {
    final v = value.trim();
    final m = _pattern.firstMatch(v);
    if (m == null || v.endsWith('P') || v.endsWith('T') || v.endsWith('t') || v.endsWith('p')) return null;
    int n(int g) => int.parse(m[g] ?? '0');
    return CalDuration(days: n(2) * 7 + n(3), seconds: n(4) * 3600 + n(5) * 60 + n(6), negative: m[1] == '-');
  }

  /// As a [Duration] (a day is 24 hours).
  Duration get duration {
    final d = Duration(days: days, seconds: seconds);
    return negative ? -d : d;
  }

  /// [wall] moved by this duration on the wall clock.
  DateTime addTo(DateTime wall) => wall.add(duration);

  String get value {
    final out = StringBuffer(negative ? '-P' : 'P');
    if (days > 0 && days % 7 == 0 && seconds == 0) return '$out${days ~/ 7}W';
    if (days > 0) out.write('${days}D');
    if (seconds > 0 || days == 0) {
      out.write('T');
      final h = seconds ~/ 3600;
      final m = seconds % 3600 ~/ 60;
      final s = seconds % 60;
      if (h > 0) out.write('${h}H');
      if (m > 0) out.write('${m}M');
      if (s > 0 || (h == 0 && m == 0)) out.write('${s}S');
    }
    return out.toString();
  }

  @override
  bool operator ==(Object other) =>
      other is CalDuration && other.days == days && other.seconds == seconds && other.negative == negative;

  @override
  int get hashCode => Object.hash(days, seconds, negative);

  @override
  String toString() => value;
}

/// A UTC-OFFSET (`+0100`, `-0530`, `+013045`), or null.
Duration? parseUtcOffset(String value) {
  final m = RegExp(r'^([+-])(\d{2}):?(\d{2})(?::?(\d{2}))?$').firstMatch(value.trim());
  if (m == null) return null;
  final hours = int.parse(m[2]!);
  final minutes = int.parse(m[3]!);
  if (hours > 23 || minutes > 59) return null;
  final d = Duration(hours: hours, minutes: minutes, seconds: int.parse(m[4] ?? '0'));
  return m[1] == '-' ? -d : d;
}
