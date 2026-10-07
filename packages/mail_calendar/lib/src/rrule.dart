/// RRULE (RFC 5545 §3.3.10): reading, writing and expanding.
library;

import 'values.dart';

enum Frequency { secondly, minutely, hourly, daily, weekly, monthly, yearly }

/// A BYDAY entry: a weekday ([DateTime.monday] … [DateTime.sunday]) with an
/// optional ordinal (`2TU` the second Tuesday, `-1FR` the last Friday).
final class WeekdayNum {
  const WeekdayNum(this.weekday, [this.ordinal]);

  final int weekday;
  final int? ordinal;

  static const codes = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];

  static WeekdayNum? parse(String s) {
    final m = RegExp(r'^([+-]?\d{1,2})?([A-Za-z]{2})$').firstMatch(s.trim());
    if (m == null) return null;
    final day = codes.indexOf(m[2]!.toUpperCase());
    if (day < 0) return null;
    final n = m[1] == null ? null : int.parse(m[1]!.replaceFirst('+', ''));
    if (n != null && (n == 0 || n.abs() > 53)) return null;
    return WeekdayNum(day + 1, n);
  }

  String get value => '${ordinal ?? ''}${codes[weekday - 1]}';

  @override
  bool operator ==(Object other) => other is WeekdayNum && other.weekday == weekday && other.ordinal == ordinal;

  @override
  int get hashCode => Object.hash(weekday, ordinal);

  @override
  String toString() => value;
}

/// A recurrence rule.
final class RecurrenceRule {
  const RecurrenceRule({
    required this.frequency,
    this.interval = 1,
    this.count,
    this.until,
    this.bySecond = const [],
    this.byMinute = const [],
    this.byHour = const [],
    this.byDay = const [],
    this.byMonthDay = const [],
    this.byYearDay = const [],
    this.byWeekNo = const [],
    this.byMonth = const [],
    this.bySetPos = const [],
    this.weekStart = DateTime.monday,
  });

  final Frequency frequency;
  final int interval;
  final int? count;

  /// UNTIL as written: a DATE, or a DATE-TIME (UTC, or floating with a
  /// floating DTSTART).
  final CalDateTime? until;
  final List<int> bySecond;
  final List<int> byMinute;
  final List<int> byHour;
  final List<WeekdayNum> byDay;
  final List<int> byMonthDay;
  final List<int> byYearDay;
  final List<int> byWeekNo;
  final List<int> byMonth;
  final List<int> bySetPos;
  final int weekStart;

  /// Parses an RRULE value; null without a valid FREQ. Parts that aren't
  /// understood, or are out of range, are left out.
  static RecurrenceRule? parse(String value) {
    final parts = <String, String>{};
    for (final part in value.trim().split(';')) {
      final eq = part.indexOf('=');
      if (eq <= 0) continue;
      parts[part.substring(0, eq).trim().toUpperCase()] = part.substring(eq + 1).trim();
    }
    final freq = Frequency.values.where((f) => f.name.toUpperCase() == parts['FREQ']?.toUpperCase()).firstOrNull;
    if (freq == null) return null;
    List<int> ints(String key, int min, int max, {bool negative = false}) => [
      for (final s in (parts[key] ?? '').split(','))
        if (int.tryParse(s.trim().replaceFirst('+', '')) case final n?)
          if ((n >= min && n <= max) || (negative && n <= -min && n >= -max && n != 0)) n,
    ];
    final interval = int.tryParse(parts['INTERVAL'] ?? '') ?? 1;
    final count = int.tryParse(parts['COUNT'] ?? '');
    final until = parts['UNTIL'] == null ? null : CalDateTime.parse(parts['UNTIL']!);
    final wkst = WeekdayNum.parse(parts['WKST'] ?? '')?.weekday ?? DateTime.monday;
    return RecurrenceRule(
      frequency: freq,
      interval: interval < 1 ? 1 : interval,
      count: count != null && count > 0 ? count : null,
      until: count == null ? until : null,
      bySecond: ints('BYSECOND', 0, 60),
      byMinute: ints('BYMINUTE', 0, 59),
      byHour: ints('BYHOUR', 0, 23),
      byDay: [
        for (final s in (parts['BYDAY'] ?? '').split(','))
          if (WeekdayNum.parse(s) case final d?) d,
      ],
      byMonthDay: ints('BYMONTHDAY', 1, 31, negative: true),
      byYearDay: ints('BYYEARDAY', 1, 366, negative: true),
      byWeekNo: ints('BYWEEKNO', 1, 53, negative: true),
      byMonth: ints('BYMONTH', 1, 12),
      bySetPos: ints('BYSETPOS', 1, 366, negative: true),
      weekStart: wkst,
    );
  }

  /// The rule as an RRULE value.
  String get value {
    final parts = ['FREQ=${frequency.name.toUpperCase()}'];
    if (until != null) parts.add('UNTIL=${until!.value}');
    if (count != null) parts.add('COUNT=$count');
    if (interval != 1) parts.add('INTERVAL=$interval');
    void list(String key, List<Object> values) {
      if (values.isNotEmpty) parts.add('$key=${values.join(',')}');
    }

    list('BYSECOND', bySecond);
    list('BYMINUTE', byMinute);
    list('BYHOUR', byHour);
    list('BYDAY', byDay);
    list('BYMONTHDAY', byMonthDay);
    list('BYYEARDAY', byYearDay);
    list('BYWEEKNO', byWeekNo);
    list('BYMONTH', byMonth);
    list('BYSETPOS', bySetPos);
    if (weekStart != DateTime.monday) parts.add('WKST=${WeekdayNum.codes[weekStart - 1]}');
    return parts.join(';');
  }

  /// The same rule ending at [until] (and without COUNT).
  RecurrenceRule withUntil(CalDateTime until) => RecurrenceRule(
    frequency: frequency,
    interval: interval,
    until: until,
    bySecond: bySecond,
    byMinute: byMinute,
    byHour: byHour,
    byDay: byDay,
    byMonthDay: byMonthDay,
    byYearDay: byYearDay,
    byWeekNo: byWeekNo,
    byMonth: byMonth,
    bySetPos: bySetPos,
    weekStart: weekStart,
  );

  @override
  String toString() => value;
}

/// The occurrence start times of [rule] from [start], in order, as wall
/// clock times like [start] (fields in a UTC [DateTime]). [start] is the
/// first (and counts toward COUNT), as calendars treat it, unless
/// [includeStart] is false: then only times the rule matches count. [until]
/// is the rule's UNTIL as a wall-clock time of [start]'s zone (the caller
/// converts a UTC UNTIL); occurrences after it aren't produced.
///
/// The work is bounded ([budget] candidate days or times): a rule that
/// never matches, or goes on forever, simply stops.
Iterable<DateTime> expandRule(
  RecurrenceRule rule,
  DateTime start, {
  DateTime? until,
  bool includeStart = true,
  int budget = 400000,
}) sync* {
  final s = DateTime.utc(start.year, start.month, start.day, start.hour, start.minute, start.second);
  if (until != null && s.isAfter(until)) return;
  var emitted = 0;
  if (includeStart) {
    yield s;
    emitted = 1;
    if (rule.count != null && emitted >= rule.count!) return;
  }
  final expander = _Expander(rule, s);
  var spent = 0;
  for (var i = 0; spent < budget; i++) {
    final (set, cost, beyond) = expander.period(i);
    spent += cost + 1;
    if (beyond) return;
    for (final t in set) {
      if (includeStart ? !t.isAfter(s) : t.isBefore(s)) continue;
      if (until != null && t.isAfter(until)) return;
      yield t;
      emitted++;
      if (rule.count != null && emitted >= rule.count!) return;
    }
  }
}

final class _Expander {
  _Expander(this.rule, this.start)
    : byMonth = rule.byMonth,
      byWeekNo = rule.frequency == Frequency.yearly ? rule.byWeekNo : const [],
      byYearDay = rule.byYearDay,
      byMonthDay = _defaultMonthDay(rule, start),
      byDay = _defaultDay(rule, start),
      byMonthFilter = _defaultMonth(rule, start);

  final RecurrenceRule rule;
  final DateTime start;
  final List<int> byMonth;
  final List<int> byWeekNo;
  final List<int> byYearDay;
  final List<int> byMonthDay;
  final List<WeekdayNum> byDay;
  final List<int> byMonthFilter;

  static bool _hasDayRule(RecurrenceRule r) =>
      r.byDay.isNotEmpty || r.byMonthDay.isNotEmpty || r.byYearDay.isNotEmpty || r.byWeekNo.isNotEmpty;

  /// RFC 5545: parts the rule leaves out come from DTSTART.
  static List<int> _defaultMonthDay(RecurrenceRule r, DateTime s) {
    if (_hasDayRule(r)) return r.byMonthDay;
    return switch (r.frequency) {
      Frequency.yearly || Frequency.monthly => [s.day],
      _ => r.byMonthDay,
    };
  }

  static List<WeekdayNum> _defaultDay(RecurrenceRule r, DateTime s) {
    if (r.frequency == Frequency.weekly && !_hasDayRule(r)) return [WeekdayNum(s.weekday)];
    if (r.frequency == Frequency.yearly &&
        r.byWeekNo.isNotEmpty &&
        r.byDay.isEmpty &&
        r.byMonthDay.isEmpty &&
        r.byYearDay.isEmpty) {
      return [WeekdayNum(s.weekday)];
    }
    return r.byDay;
  }

  static List<int> _defaultMonth(RecurrenceRule r, DateTime s) {
    if (r.frequency == Frequency.yearly && r.byMonth.isEmpty && !_hasDayRule(r)) return [s.month];
    return r.byMonth;
  }

  /// The occurrences of period [i] (sorted), the work it took, and whether
  /// the period lies beyond any representable date.
  (List<DateTime>, int, bool) period(int i) {
    final step = i * rule.interval;
    final List<DateTime> days;
    switch (rule.frequency) {
      case Frequency.yearly:
        final year = start.year + step;
        if (year > 9999) return (const [], 0, true);
        days = byWeekNo.isEmpty
            ? [for (var d = DateTime.utc(year); d.year == year; d = d.add(const Duration(days: 1))) d]
            : [
                for (var d = DateTime.utc(year - 1, 12, 22); d.isBefore(DateTime.utc(year + 1, 1, 11)); d = _next(d))
                  if (_weekNumber(d, rule.weekStart).$1 == year) d,
              ];
      case Frequency.monthly:
        final index = start.year * 12 + start.month - 1 + step;
        final year = index ~/ 12;
        if (year > 9999) return (const [], 0, true);
        final month = index % 12 + 1;
        days = [for (var d = DateTime.utc(year, month); d.month == month; d = _next(d)) d];
      case Frequency.weekly:
        final offset = (start.weekday - rule.weekStart + 7) % 7;
        final first = DateTime.utc(start.year, start.month, start.day - offset + 7 * step);
        if (first.year > 9999) return (const [], 0, true);
        days = [for (var k = 0; k < 7; k++) DateTime.utc(first.year, first.month, first.day + k)];
      case Frequency.daily:
        final d = DateTime.utc(start.year, start.month, start.day + step);
        if (d.year > 9999) return (const [], 0, true);
        days = [d];
      case Frequency.hourly || Frequency.minutely || Frequency.secondly:
        final unit = switch (rule.frequency) {
          Frequency.hourly => const Duration(hours: 1),
          Frequency.minutely => const Duration(minutes: 1),
          _ => const Duration(seconds: 1),
        };
        final t = start.add(unit * step);
        if (t.year > 9999) return (const [], 0, true);
        return (_subDaily(t), 1, false);
    }
    final matching = [
      for (final d in days)
        if (_matchesDay(d)) d,
    ];
    final times = <DateTime>[];
    for (final d in matching) {
      for (final h in rule.byHour.isEmpty ? [start.hour] : _sorted(rule.byHour)) {
        for (final m in rule.byMinute.isEmpty ? [start.minute] : _sorted(rule.byMinute)) {
          for (final sec in rule.bySecond.isEmpty ? [start.second] : _sorted(rule.bySecond)) {
            times.add(DateTime.utc(d.year, d.month, d.day, h, m, sec.clamp(0, 59)));
          }
        }
      }
    }
    return (_setPos(times), days.length, false);
  }

  List<DateTime> _subDaily(DateTime t) {
    if (!_matchesDay(DateTime.utc(t.year, t.month, t.day))) return const [];
    if (rule.byHour.isNotEmpty && !rule.byHour.contains(t.hour)) return const [];
    final List<DateTime> times;
    switch (rule.frequency) {
      case Frequency.hourly:
        times = [
          for (final m in rule.byMinute.isEmpty ? [t.minute] : _sorted(rule.byMinute))
            for (final s in rule.bySecond.isEmpty ? [t.second] : _sorted(rule.bySecond))
              DateTime.utc(t.year, t.month, t.day, t.hour, m, s.clamp(0, 59)),
        ];
      case Frequency.minutely:
        if (rule.byMinute.isNotEmpty && !rule.byMinute.contains(t.minute)) return const [];
        times = [
          for (final s in rule.bySecond.isEmpty ? [t.second] : _sorted(rule.bySecond))
            DateTime.utc(t.year, t.month, t.day, t.hour, t.minute, s.clamp(0, 59)),
        ];
      default:
        if (rule.byMinute.isNotEmpty && !rule.byMinute.contains(t.minute)) return const [];
        if (rule.bySecond.isNotEmpty && !rule.bySecond.contains(t.second)) return const [];
        times = [t];
    }
    return _setPos(times);
  }

  List<DateTime> _setPos(List<DateTime> times) {
    times.sort();
    if (rule.bySetPos.isEmpty || times.isEmpty) return times;
    final picked = <DateTime>{
      for (final p in rule.bySetPos)
        if (p > 0 && p <= times.length) times[p - 1] else if (p < 0 && -p <= times.length) times[times.length + p],
    }.toList()..sort();
    return picked;
  }

  bool _matchesDay(DateTime d) {
    if (byMonthFilter.isNotEmpty && !byMonthFilter.contains(d.month)) return false;
    if (byWeekNo.isNotEmpty) {
      final (_, week, weeks) = _weekNumber(d, rule.weekStart);
      if (!byWeekNo.any((w) => w == week || w == week - weeks - 1)) return false;
    }
    if (byYearDay.isNotEmpty) {
      final doy = _dayOfYear(d);
      final total = _daysInYear(d.year);
      if (!byYearDay.any((n) => n == doy || n == doy - total - 1)) return false;
    }
    if (byMonthDay.isNotEmpty) {
      final last = _daysInMonth(d.year, d.month);
      if (!byMonthDay.any((n) => n == d.day || n == d.day - last - 1)) return false;
    }
    if (byDay.isNotEmpty && !byDay.any((w) => _matchesWeekday(w, d))) return false;
    return true;
  }

  bool _matchesWeekday(WeekdayNum w, DateTime d) {
    if (w.weekday != d.weekday) return false;
    final n = w.ordinal;
    if (n == null) return true;
    final f = rule.frequency;
    // In a month: MONTHLY, or YEARLY with BYMONTH; in the year: YEARLY otherwise.
    if (f == Frequency.monthly || (f == Frequency.yearly && byMonth.isNotEmpty)) {
      final last = _daysInMonth(d.year, d.month);
      return n > 0 ? (d.day - 1) ~/ 7 + 1 == n : (last - d.day) ~/ 7 + 1 == -n;
    }
    if (f == Frequency.yearly && byWeekNo.isEmpty) {
      final doy = _dayOfYear(d);
      final total = _daysInYear(d.year);
      return n > 0 ? (doy - 1) ~/ 7 + 1 == n : (total - doy) ~/ 7 + 1 == -n;
    }
    // Ordinals mean nothing for other frequencies: any such weekday.
    return true;
  }
}

DateTime _next(DateTime d) => DateTime.utc(d.year, d.month, d.day + 1);

List<int> _sorted(List<int> values) => values.toSet().toList()..sort();

int _daysInMonth(int year, int month) => DateTime.utc(year, month + 1, 0).day;
int _daysInYear(int year) => DateTime.utc(year + 1).difference(DateTime.utc(year)).inDays;
int _dayOfYear(DateTime d) => DateTime.utc(d.year, d.month, d.day).difference(DateTime.utc(d.year)).inDays + 1;

/// The first day of week 1 of [year]: the first week (starting on
/// [weekStart]) with at least four days in the year.
DateTime _week1(int year, int weekStart) {
  final jan1 = DateTime.utc(year);
  final offset = (jan1.weekday - weekStart + 7) % 7;
  final first = DateTime.utc(year, 1, 1 - offset);
  return 7 - offset >= 4 ? first : DateTime.utc(first.year, first.month, first.day + 7);
}

/// (week-numbering year, week number, weeks in that year) of [d].
(int, int, int) _weekNumber(DateTime d, int weekStart) {
  var year = d.year;
  var w1 = _week1(year, weekStart);
  if (d.isBefore(w1)) {
    year--;
    w1 = _week1(year, weekStart);
  } else {
    final next = _week1(year + 1, weekStart);
    if (!d.isBefore(next)) {
      year++;
      w1 = next;
    }
  }
  final weeks = _week1(year + 1, weekStart).difference(w1).inDays ~/ 7;
  return (year, d.difference(w1).inDays ~/ 7 + 1, weeks);
}
