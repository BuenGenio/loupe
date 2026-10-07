/// Recurrence rules in words: "Every 2 weeks on Tuesday and Thursday until
/// 1 Dec 2026".
library;

import 'rrule.dart';
import 'time_zones.dart';
import 'values.dart';

const _weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
const _months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

/// "1 Dec 2026".
String formatShortDate(DateTime d) => '${d.day} ${_months[d.month - 1].substring(0, 3)} ${d.year}';

/// [rule] of an event starting at [start] in words, in English. Dates
/// (UNTIL) go through [formatDate]; a UTC UNTIL is read in [start]'s zone
/// through [zones].
String describeRule(
  RecurrenceRule rule, {
  required CalDateTime start,
  ZoneResolver? zones,
  String Function(DateTime date) formatDate = formatShortDate,
}) {
  final s = start.local;
  final n = rule.interval;
  String every(String one, String many) => n == 1 ? 'Every $one' : 'Every $n $many';
  final plainDays = [
    for (final d in rule.byDay)
      if (d.ordinal == null) d.weekday,
  ];
  final ordinalDays = [
    for (final d in rule.byDay)
      if (d.ordinal != null) d,
  ];
  String? phrase;
  switch (rule.frequency) {
    case Frequency.daily:
      if (rule.byDay.isEmpty) {
        phrase = every('day', 'days');
      } else if (n == 1 && _isWeekdays(plainDays) && ordinalDays.isEmpty) {
        phrase = 'Every weekday';
      } else if (ordinalDays.isEmpty) {
        phrase = n == 1 ? 'Every ${_dayList(plainDays)}' : '${every('day', 'days')} on ${_dayList(plainDays)}';
      }
    case Frequency.weekly:
      final days = rule.byDay.isEmpty ? [s.weekday] : [for (final d in rule.byDay) d.weekday];
      final unique = days.toSet().toList()..sort();
      if (n == 1 && unique.length == 7) {
        phrase = 'Every day';
      } else if (n == 1 && _isWeekdays(unique)) {
        phrase = 'Every weekday';
      } else {
        phrase = '${every('week', 'weeks')} on ${_dayList(unique)}';
      }
    case Frequency.monthly:
      final on = _monthlyDay(rule, s);
      if (on != null) phrase = '${every('month', 'months')} $on';
    case Frequency.yearly:
      final months = rule.byMonth.isEmpty ? [s.month] : (rule.byMonth.toSet().toList()..sort());
      final monthNames = _join([for (final m in months) _months[m - 1]]);
      if (ordinalDays.isNotEmpty && rule.byMonthDay.isEmpty && rule.bySetPos.isEmpty) {
        phrase =
            '${every('year', 'years')} on the ${_join([for (final d in ordinalDays) _ordinalDay(d)])} of $monthNames';
      } else if (rule.byDay.isEmpty && rule.byYearDay.isEmpty && rule.byWeekNo.isEmpty) {
        final days = rule.byMonthDay.isEmpty ? [s.day] : rule.byMonthDay;
        if (days.length == 1 && days.first > 0 && months.length == 1) {
          phrase = '${every('year', 'years')} on ${days.first} $monthNames';
        } else {
          phrase = '${every('year', 'years')} on the ${_join([for (final d in days) _dayOfMonth(d)])} of $monthNames';
        }
      }
    case Frequency.hourly:
      phrase = every('hour', 'hours');
    case Frequency.minutely:
      phrase = every('minute', 'minutes');
    case Frequency.secondly:
      phrase = every('second', 'seconds');
  }
  phrase ??=
      '${switch (rule.frequency) {
        Frequency.daily => every('day', 'days'),
        Frequency.weekly => every('week', 'weeks'),
        Frequency.monthly => every('month', 'months'),
        _ => every('year', 'years'),
      }} (custom)';
  final count = rule.count;
  final until = rule.until;
  if (count != null) {
    phrase += count == 1 ? ', once' : ', $count times';
  } else if (until != null) {
    var day = until.local;
    if (until.isUtc && start.form == TimeForm.zoned && zones != null) day = zones.wallLike(start, until.local);
    phrase += ' until ${formatDate(DateTime(day.year, day.month, day.day))}';
  }
  return phrase;
}

bool _isWeekdays(List<int> days) {
  final set = days.toSet();
  return set.length == 5 && set.containsAll(const [1, 2, 3, 4, 5]);
}

String _dayList(List<int> days) => _join([for (final d in days) _weekdays[d - 1]]);

String _join(List<String> parts) {
  if (parts.length <= 1) return parts.join();
  return '${parts.sublist(0, parts.length - 1).join(', ')} and ${parts.last}';
}

const _ordinalWords = ['first', 'second', 'third', 'fourth', 'fifth'];

/// "second", "last", "second to last", "10th".
String _ordinal(int n) {
  if (n == -1) return 'last';
  if (n < 0) return '${_ordinal(-n)} to last';
  if (n <= _ordinalWords.length) return _ordinalWords[n - 1];
  return _numbered(n);
}

String _numbered(int n) {
  final teen = n % 100 >= 11 && n % 100 <= 13;
  final suffix = teen
      ? 'th'
      : switch (n % 10) {
          1 => 'st',
          2 => 'nd',
          3 => 'rd',
          _ => 'th',
        };
  return '$n$suffix';
}

/// "15th", "last day", "second to last day".
String _dayOfMonth(int n) => n > 0 ? _numbered(n) : (n == -1 ? 'last day' : '${_ordinal(n)} day');

String _ordinalDay(WeekdayNum d) => '${_ordinal(d.ordinal!)} ${_weekdays[d.weekday - 1]}';

String? _monthlyDay(RecurrenceRule rule, DateTime s) {
  if (rule.byYearDay.isNotEmpty || rule.byWeekNo.isNotEmpty) return null;
  final ordinals = [
    for (final d in rule.byDay)
      if (d.ordinal != null) d,
  ];
  final plain = [
    for (final d in rule.byDay)
      if (d.ordinal == null) d.weekday,
  ];
  if (rule.byMonthDay.isNotEmpty && rule.byDay.isEmpty) {
    return 'on the ${_join([for (final d in rule.byMonthDay) _dayOfMonth(d)])}';
  }
  if (ordinals.isNotEmpty && plain.isEmpty && rule.byMonthDay.isEmpty && rule.bySetPos.isEmpty) {
    return 'on the ${_join([for (final d in ordinals) _ordinalDay(d)])}';
  }
  if (plain.isNotEmpty && ordinals.isEmpty && rule.byMonthDay.isEmpty) {
    final what = _isWeekdays(plain)
        ? 'weekday'
        : plain.toSet().length == 7
        ? 'day'
        : _join([for (final d in plain) _weekdays[d - 1]]);
    if (rule.bySetPos.isEmpty) return 'on every $what';
    if (rule.bySetPos.length == 1) return 'on the ${_ordinal(rule.bySetPos.single)} $what';
    return null;
  }
  if (rule.byDay.isEmpty && rule.byMonthDay.isEmpty) return 'on the ${_numbered(s.day)}';
  return null;
}
