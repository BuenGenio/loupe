import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/snooze/snooze_sheet.dart';

// Times are wall-clock times in the device's zone. Run this file with, e.g.,
// TZ=Europe/Berlin or TZ=America/New_York to exercise daylight-saving days.
void main() {
  Map<SnoozePreset, DateTime> presets(DateTime now) => {for (final (p, at) in snoozePresets(now)) p: at};

  test('a Wednesday morning offers everything', () {
    final p = presets(DateTime(2026, 10, 7, 9, 10));
    expect(p.keys, SnoozePreset.values);
    expect(p[SnoozePreset.laterToday], DateTime(2026, 10, 7, 12, 30), reason: '+3 h, rounded up to the half hour');
    expect(p[SnoozePreset.thisEvening], DateTime(2026, 10, 7, 18));
    expect(p[SnoozePreset.tomorrow], DateTime(2026, 10, 8, 8));
    expect(p[SnoozePreset.thisWeekend], DateTime(2026, 10, 10, 9));
    expect(p[SnoozePreset.nextWeek], DateTime(2026, 10, 12, 8));
  });

  test('Later Today rounds up to the next half hour, and keeps an exact one', () {
    expect(presets(DateTime(2026, 10, 7, 9))[SnoozePreset.laterToday], DateTime(2026, 10, 7, 12));
    expect(presets(DateTime(2026, 10, 7, 9, 0, 1))[SnoozePreset.laterToday], DateTime(2026, 10, 7, 12, 30));
    expect(presets(DateTime(2026, 10, 7, 9, 31))[SnoozePreset.laterToday], DateTime(2026, 10, 7, 13));
  });

  test('Later Today gives way to This Evening, then returns after it', () {
    // 15:00 + 3 h is 18:00: This Evening says it already.
    expect(presets(DateTime(2026, 10, 7, 15)).keys, isNot(contains(SnoozePreset.laterToday)));
    expect(presets(DateTime(2026, 10, 7, 16, 30)).keys, isNot(contains(SnoozePreset.laterToday)));
    expect(presets(DateTime(2026, 10, 7, 14, 29))[SnoozePreset.laterToday], DateTime(2026, 10, 7, 17, 30));
    // From 17:00, This Evening is gone and Later Today is the evening option.
    final late = presets(DateTime(2026, 10, 7, 17));
    expect(late.keys, isNot(contains(SnoozePreset.thisEvening)));
    expect(late[SnoozePreset.laterToday], DateTime(2026, 10, 7, 20));
    expect(presets(DateTime(2026, 10, 7, 20, 30))[SnoozePreset.laterToday], DateTime(2026, 10, 7, 23, 30));
  });

  test('Later Today is left out when it would be tomorrow', () {
    final p = presets(DateTime(2026, 10, 7, 21, 1));
    expect(p.keys, [SnoozePreset.tomorrow, SnoozePreset.thisWeekend, SnoozePreset.nextWeek]);
  });

  test('just after midnight, Later Today is still today', () {
    expect(presets(DateTime(2026, 10, 7, 0, 20))[SnoozePreset.laterToday], DateTime(2026, 10, 7, 3, 30));
    expect(presets(DateTime(2026, 10, 7, 0, 20))[SnoozePreset.tomorrow], DateTime(2026, 10, 8, 8));
  });

  test('This Weekend is offered Monday to Friday', () {
    expect(presets(DateTime(2026, 10, 5, 9))[SnoozePreset.thisWeekend], DateTime(2026, 10, 10, 9));
    expect(presets(DateTime(2026, 10, 9, 9))[SnoozePreset.thisWeekend], DateTime(2026, 10, 10, 9));
    expect(presets(DateTime(2026, 10, 10, 9)).keys, isNot(contains(SnoozePreset.thisWeekend)));
    expect(presets(DateTime(2026, 10, 11, 9)).keys, isNot(contains(SnoozePreset.thisWeekend)));
  });

  test('Next Week is next Monday; on Sunday it would be Tomorrow, so it is left out', () {
    expect(presets(DateTime(2026, 10, 5, 7))[SnoozePreset.nextWeek], DateTime(2026, 10, 12, 8));
    expect(presets(DateTime(2026, 10, 10, 9))[SnoozePreset.nextWeek], DateTime(2026, 10, 12, 8));
    final sunday = presets(DateTime(2026, 10, 11, 10));
    expect(sunday.keys, isNot(contains(SnoozePreset.nextWeek)));
    expect(sunday[SnoozePreset.tomorrow], DateTime(2026, 10, 12, 8));
  });

  test('rolls over months and years', () {
    final p = presets(DateTime(2026, 12, 31, 22));
    expect(p[SnoozePreset.tomorrow], DateTime(2027, 1, 1, 8));
    expect(p[SnoozePreset.thisWeekend], DateTime(2027, 1, 2, 9));
    expect(p[SnoozePreset.nextWeek], DateTime(2027, 1, 4, 8));
  });

  test('every preset is in the future', () {
    for (var h = 0; h < 24 * 7; h++) {
      final now = DateTime(2026, 10, 5).add(Duration(hours: h, minutes: 17));
      for (final (p, at) in snoozePresets(now)) {
        expect(at.isAfter(now), isTrue, reason: '$p at $now');
      }
    }
  });

  test('a UTC "now" is read in the local time zone', () {
    final utc = DateTime.utc(2026, 10, 7, 12);
    final local = utc.toLocal();
    final tomorrow = presets(utc)[SnoozePreset.tomorrow]!;
    expect(tomorrow.isUtc, isFalse);
    expect(tomorrow, DateTime(local.year, local.month, local.day + 1, 8));
  });

  test('mornings stay at 08:00 across daylight-saving changes', () {
    // Europe springs forward on 29 March 2026, the US on 8 March; both fall back in autumn.
    for (final now in [
      DateTime(2026, 3, 28, 20),
      DateTime(2026, 3, 7, 20),
      DateTime(2026, 10, 24, 20),
      DateTime(2026, 10, 31, 20),
    ]) {
      final p = presets(now);
      expect(p[SnoozePreset.tomorrow], DateTime(now.year, now.month, now.day + 1, 8), reason: '$now');
      for (final at in [p[SnoozePreset.tomorrow], p[SnoozePreset.nextWeek]]) {
        if (at == null) continue;
        expect((at.hour, at.minute), (8, 0), reason: '$now → $at');
      }
    }
  });
}
