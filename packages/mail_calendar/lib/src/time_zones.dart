/// Time zones: TZIDs to IANA zones (also Outlook's Windows names), the
/// VTIMEZONE rules embedded in a calendar as the fallback, and wall-clock
/// times to instants.
library;

import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'component.dart';
import 'rrule.dart';
import 'values.dart';
import 'windows_zones.dart';

/// Loads the IANA database (once per isolate, about 20 ms).
void ensureTimeZoneDatabase() {
  if (!tz.timeZoneDatabase.isInitialized) tzdata.initializeTimeZones();
}

/// A time zone: its offset from UTC at any instant.
abstract base class Zone {
  const Zone();

  /// The IANA name, or the TZID as written.
  String get id;

  /// The IANA name, when this is a zone of the database.
  String? get ianaName => null;

  /// The offset from UTC at [instant].
  Duration offsetAt(DateTime instant);

  /// The wall-clock time here at [instant] (fields in a UTC [DateTime]).
  DateTime toWall(DateTime instant) {
    final u = instant.toUtc();
    return u.add(offsetAt(u));
  }

  /// The instant of the wall-clock time [wall] here (its fields; RFC 5545
  /// §3.3.5): a time that occurs twice (clocks going back) is the first
  /// one; a time skipped (clocks going forward) is read with the offset from
  /// before the gap.
  DateTime toUtc(DateTime wall) {
    final w = DateTime.utc(wall.year, wall.month, wall.day, wall.hour, wall.minute, wall.second);
    final before = offsetAt(w.subtract(const Duration(days: 1)));
    final after = offsetAt(w.add(const Duration(days: 1)));
    final valid = [
      for (final o in {before, after})
        if (offsetAt(w.subtract(o)) == o) o,
    ];
    if (valid.isEmpty) return w.subtract(before);
    final offset = valid.reduce((a, b) => a > b ? a : b);
    return w.subtract(offset);
  }

  @override
  String toString() => id;
}

/// A zone of the IANA database.
final class IanaZone extends Zone {
  IanaZone(this.location);

  /// The zone called [name] in the IANA database, or null.
  static IanaZone? named(String name) {
    ensureTimeZoneDatabase();
    final location = tz.timeZoneDatabase.locations[name];
    return location == null ? null : IanaZone(location);
  }

  final tz.Location location;

  @override
  String get id => location.name;

  @override
  String get ianaName => location.name;

  @override
  Duration offsetAt(DateTime instant) => location.timeZone(instant.millisecondsSinceEpoch).offset;
}

/// A fixed offset from UTC.
final class FixedZone extends Zone {
  const FixedZone(this.id, this.offset);

  static const utc = FixedZone('UTC', Duration.zero);

  @override
  final String id;
  final Duration offset;

  @override
  Duration offsetAt(DateTime instant) => offset;
}

/// The rules of a VTIMEZONE: its STANDARD and DAYLIGHT observances, each
/// starting at DTSTART (written in the offset before it, TZOFFSETFROM) and
/// recurring by its RRULE and RDATEs, switching to TZOFFSETTO.
final class EmbeddedZone extends Zone {
  EmbeddedZone._(this.id, this._observances);

  /// The rules of [vtimezone]; null without a TZID or any usable observance.
  static EmbeddedZone? fromComponent(Component vtimezone) {
    final id = vtimezone.property('TZID')?.value.trim();
    if (id == null || id.isEmpty) return null;
    final observances = <_Observance>[];
    for (final c in vtimezone.components) {
      if (c.name != 'STANDARD' && c.name != 'DAYLIGHT') continue;
      final start = c.property('DTSTART');
      final from = parseUtcOffset(c.property('TZOFFSETFROM')?.value ?? '');
      final to = parseUtcOffset(c.property('TZOFFSETTO')?.value ?? '');
      final dt = start == null ? null : CalDateTime.parse(start.value);
      if (dt == null || to == null) continue;
      final rule = c.property('RRULE');
      observances.add(
        _Observance(
          start: dt.local,
          from: from ?? to,
          to: to,
          rule: rule == null ? null : RecurrenceRule.parse(rule.value),
          dates: [
            for (final r in c.all('RDATE'))
              for (final v in r.value.split(','))
                if (CalDateTime.parse(v) case final d?) d.local,
          ],
        ),
      );
    }
    return observances.isEmpty ? null : EmbeddedZone._(id, observances);
  }

  @override
  final String id;
  final List<_Observance> _observances;
  final _byYear = <int, List<(DateTime, Duration, Duration)>>{};

  /// Transitions (instant, offset before, offset after) from the year
  /// before [year] to the one after it, sorted.
  List<(DateTime, Duration, Duration)> _around(int year) => _byYear.putIfAbsent(year, () {
    final from = DateTime.utc(year - 1);
    final to = DateTime.utc(year + 2);
    final out = <(DateTime, Duration, Duration)>[];
    for (final o in _observances) {
      void add(DateTime wall) {
        final instant = wall.subtract(o.from);
        if (!instant.isBefore(from.subtract(const Duration(days: 2))) && instant.isBefore(to)) {
          out.add((instant, o.from, o.to));
        }
      }

      add(o.start);
      o.dates.forEach(add);
      final rule = o.rule;
      if (rule == null) continue;
      final until = rule.until;
      final untilWall = until == null ? null : (until.isUtc ? until.local.add(o.from) : until.local);
      // Outlook starts its rules in 1601: begin near the year asked for,
      // which a rule with BYMONTH and BYDAY doesn't depend on.
      var start = o.start;
      var includeStart = true;
      if (rule.count == null && rule.frequency == Frequency.yearly && start.year < year - 2) {
        start = DateTime.utc(year - 2, start.month, start.day, start.hour, start.minute, start.second);
        includeStart = false;
      }
      for (final wall in expandRule(rule, start, until: untilWall, includeStart: includeStart)) {
        if (wall.isAfter(to.add(const Duration(days: 2)))) break;
        add(wall);
      }
    }
    out.sort((a, b) => a.$1.compareTo(b.$1));
    return out;
  });

  @override
  Duration offsetAt(DateTime instant) {
    final u = instant.toUtc();
    final transitions = _around(u.year);
    (DateTime, Duration, Duration)? last;
    for (final t in transitions) {
      if (t.$1.isAfter(u)) break;
      last = t;
    }
    if (last != null) return last.$3;
    if (transitions.isNotEmpty) return transitions.first.$2;
    // Nothing near: the observance in force since the latest start.
    final started = [..._observances.where((o) => !o.start.isAfter(u))]..sort((a, b) => a.start.compareTo(b.start));
    return (started.lastOrNull ?? _observances.first).to;
  }
}

final class _Observance {
  _Observance({required this.start, required this.from, required this.to, this.rule, this.dates = const []});

  final DateTime start;
  final Duration from;
  final Duration to;
  final RecurrenceRule? rule;
  final List<DateTime> dates;
}

/// The IANA name a [tzid] stands for, or null: an IANA name (also with a
/// path in front, as old Lightning versions wrote them:
/// `/mozilla.org/20050126_1/America/New_York`), a Windows zone name
/// ("Pacific Standard Time") or display name ("(UTC-08:00) Pacific Time (US &
/// Canada)"), or UTC/GMT.
String? ianaZoneName(String tzid) {
  ensureTimeZoneDatabase();
  final locations = tz.timeZoneDatabase.locations;
  var id = tzid.trim();
  if (id.length >= 2 && id.startsWith('"') && id.endsWith('"')) id = id.substring(1, id.length - 1).trim();
  if (id.isEmpty) return null;
  if (locations.containsKey(id)) return id;
  final upper = id.toUpperCase();
  if (upper == 'Z' || upper == 'UTC' || upper == 'GMT' || upper == 'ETC/UTC' || upper == 'ETC/GMT') return 'Etc/UTC';
  if (id.contains('/')) {
    final parts = id.split('/').where((p) => p.isNotEmpty).toList();
    for (var i = 0; i < parts.length; i++) {
      final candidate = parts.sublist(i).join('/');
      if (locations.containsKey(candidate)) return candidate;
    }
  }
  final windows = _windowsNames[id.toLowerCase()] ?? _windowsDisplay[_normalizeDisplay(id)];
  if (windows != null && locations.containsKey(windows)) return windows;
  return null;
}

final _windowsNames = {for (final e in windowsZoneNames.entries) e.key.toLowerCase(): e.value};
final _windowsDisplay = {for (final e in windowsZoneDisplayNames.entries) _normalizeDisplay(e.key): e.value};

String _normalizeDisplay(String s) =>
    s.toLowerCase().replaceAll('gmt', 'utc').replaceAll(RegExp(r'[^a-z0-9+\-():,&]+'), ' ').trim();

/// Finds the zones of a calendar's TZIDs: the IANA database first (TZIDs
/// are usually IANA or Windows names), then the VTIMEZONEs the calendar
/// carries ([embedded], by TZID).
final class ZoneResolver {
  ZoneResolver([Map<String, Component> embedded = const {}]) : _embedded = embedded;

  final Map<String, Component> _embedded;
  final _cache = <String, Zone?>{};

  /// The zone of [tzid], or null when it is neither known nor embedded.
  Zone? zone(String tzid) => _cache.putIfAbsent(tzid, () {
    final iana = ianaZoneName(tzid);
    if (iana != null) return iana == 'Etc/UTC' ? FixedZone.utc : IanaZone.named(iana);
    final embedded = _embedded[tzid] ?? _embedded[tzid.trim()];
    return embedded == null ? null : EmbeddedZone.fromComponent(embedded);
  });

  /// Whether [t] is anchored to a zone this resolver can't place.
  bool isUnknown(CalDateTime t) => t.form == TimeForm.zoned && zone(t.tzid!) == null;

  /// The instant [t] stands for: UTC as it is, a zoned time in its zone.
  /// Null for dates and floating times (and zones that can't be found),
  /// which happen at the same wall-clock time anywhere.
  DateTime? instant(CalDateTime t) => switch (t.form) {
    TimeForm.utc => t.local,
    TimeForm.zoned => zone(t.tzid!)?.toUtc(t.local),
    _ => null,
  };

  /// [instant] as a wall-clock time in the zone of [like] (UTC for UTC
  /// times and unknown zones).
  DateTime wallLike(CalDateTime like, DateTime instant) {
    if (like.form != TimeForm.zoned) return instant.toUtc();
    final z = zone(like.tzid!);
    return z == null ? instant.toUtc() : z.toWall(instant);
  }
}

/// A short name for a zone, for "09:00 London": the city of an IANA name
/// ("Los Angeles"), else the offset at [at] ("UTC+5:30").
String zoneLabel(Zone zone, DateTime at) {
  final iana = zone.ianaName;
  if (iana != null && !iana.startsWith('Etc/') && iana.contains('/')) {
    return iana.split('/').last.replaceAll('_', ' ');
  }
  if (zone is FixedZone && zone.offset == Duration.zero) return 'UTC';
  return offsetLabel(zone.offsetAt(at));
}

/// "UTC", "UTC+1", "UTC−5", "UTC+5:30".
String offsetLabel(Duration offset) {
  if (offset == Duration.zero) return 'UTC';
  final minutes = offset.inMinutes.abs();
  final h = minutes ~/ 60;
  final m = minutes % 60;
  return 'UTC${offset.isNegative ? '−' : '+'}$h${m == 0 ? '' : ':${m.toString().padLeft(2, '0')}'}';
}
