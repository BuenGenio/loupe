import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loupe/features/compose/send_later.dart';

// Times are wall-clock times in the device's zone. Run this file with, e.g.,
// TZ=Europe/Berlin or TZ=America/New_York to exercise daylight-saving days.
void main() {
  testWidgets('asking for a wake-up after the screen is gone does nothing, quietly', (tester) async {
    late WidgetRef captured;
    await tester.pumpWidget(
      ProviderScope(
        child: Consumer(
          builder: (context, ref, _) {
            captured = ref;
            return const SizedBox();
          },
        ),
      ),
    );
    await tester.pumpWidget(const SizedBox());
    // A scheduled send queued after an await, from a compose screen that closed.
    expect(() => wakeUpAt(captured, DateTime(2026, 10, 5, 8)), returnsNormally);
  });

  setUpAll(() async => initializeDateFormatting());

  Map<SendLaterPreset, DateTime> presets(DateTime now) => {for (final (p, at) in sendLaterPresets(now)) p: at};

  group('presets', () {
    test('before 17:00 on a Wednesday: later today, tomorrow and Monday', () {
      final p = presets(DateTime(2026, 10, 7, 16, 59));
      expect(p.keys, [SendLaterPreset.laterToday, SendLaterPreset.tomorrowMorning, SendLaterPreset.mondayMorning]);
      expect(p[SendLaterPreset.laterToday], DateTime(2026, 10, 7, 18));
      expect(p[SendLaterPreset.tomorrowMorning], DateTime(2026, 10, 8, 8));
      expect(p[SendLaterPreset.mondayMorning], DateTime(2026, 10, 12, 8));
    });

    test('"Later Today" is gone from 17:00', () {
      expect(presets(DateTime(2026, 10, 7, 17)).keys, isNot(contains(SendLaterPreset.laterToday)));
      expect(presets(DateTime(2026, 10, 7, 23, 30)).keys, isNot(contains(SendLaterPreset.laterToday)));
      expect(presets(DateTime(2026, 10, 7, 0, 5))[SendLaterPreset.laterToday], DateTime(2026, 10, 7, 18));
    });

    test('on Sunday, Monday morning is tomorrow morning and shown once', () {
      final p = presets(DateTime(2026, 10, 11, 10));
      expect(p.keys, [SendLaterPreset.laterToday, SendLaterPreset.tomorrowMorning]);
      expect(p[SendLaterPreset.tomorrowMorning], DateTime(2026, 10, 12, 8));
    });

    test('on Monday, Monday morning is next week', () {
      expect(presets(DateTime(2026, 10, 12, 7))[SendLaterPreset.mondayMorning], DateTime(2026, 10, 19, 8));
    });

    test('rolls over months and years', () {
      final p = presets(DateTime(2026, 12, 31, 20));
      expect(p[SendLaterPreset.tomorrowMorning], DateTime(2027, 1, 1, 8));
      expect(p[SendLaterPreset.mondayMorning], DateTime(2027, 1, 4, 8));
    });

    test('a UTC "now" is read in the local time zone', () {
      final utc = DateTime.utc(2026, 10, 7, 12);
      final local = utc.toLocal();
      final p = presets(utc);
      final tomorrow = p[SendLaterPreset.tomorrowMorning]!;
      expect(tomorrow.isUtc, isFalse);
      expect(tomorrow, DateTime(local.year, local.month, local.day + 1, 8));
      expect(p.containsKey(SendLaterPreset.laterToday), local.hour < 17);
    });

    test('stays at 08:00 across daylight-saving changes', () {
      // Europe springs forward on 29 March 2026, the US on 8 March; both fall back in autumn.
      for (final now in [
        DateTime(2026, 3, 28, 20),
        DateTime(2026, 3, 7, 20),
        DateTime(2026, 10, 24, 20),
        DateTime(2026, 10, 31, 20),
      ]) {
        final p = presets(now);
        for (final at in p.values) {
          expect(at.hour, 8, reason: '$now → $at');
          expect(at.minute, 0);
        }
        expect(p[SendLaterPreset.tomorrowMorning], DateTime(now.year, now.month, now.day + 1, 8));
      }
    });
  });

  group('formatSendTime', () {
    final now = DateTime(2026, 10, 7, 9, 30);

    test('today, tomorrow, weekdays and dates, 24-hour', () {
      String f(DateTime at, {bool compact = false}) => formatSendTime(at, now: now, use24h: true, compact: compact);
      expect(f(DateTime(2026, 10, 7, 18)), 'Today at 18:00');
      expect(f(DateTime(2026, 10, 8, 8)), 'Tomorrow at 08:00');
      expect(f(DateTime(2026, 10, 12, 8)), 'Monday at 08:00');
      expect(f(DateTime(2026, 10, 20, 8, 5)), 'Tue, Oct 20 at 08:05');
      expect(f(DateTime(2027, 1, 4, 8)), 'Mon, Jan 4, 2027 at 08:00');
      expect(f(DateTime(2026, 10, 8, 8), compact: true), 'Tomorrow 08:00');
      expect(f(DateTime(2026, 10, 12, 8), compact: true), 'Mon 08:00');
      expect(f(DateTime(2026, 10, 20, 8), compact: true), 'Oct 20 08:00');
      expect(f(DateTime(2027, 1, 4, 8), compact: true), 'Jan 4, 2027');
    });

    test("12-hour clock and other locales' formats", () {
      String plain(String s) => s.replaceAll(' ', ' ');
      expect(plain(formatSendTime(DateTime(2026, 10, 7, 18), now: now)), 'Today at 6:00 PM');
      expect(formatSendTime(DateTime(2026, 10, 7, 18), now: now, locale: 'de'), 'Today at 18:00');
      expect(formatSendTime(DateTime(2026, 10, 20, 8), now: now, locale: 'de', compact: true), '20. Okt. 08:00');
      expect(formatSendTime(DateTime(2026, 10, 12, 8), now: now, locale: 'fr', use24h: true), 'lundi at 08:00');
    });

    test('a day is a calendar day, even when daylight saving makes it 23 hours long', () {
      expect(
        formatSendTime(DateTime(2026, 3, 29, 8), now: DateTime(2026, 3, 28, 20), use24h: true),
        'Tomorrow at 08:00',
      );
      expect(
        formatSendTime(DateTime(2026, 10, 25, 23), now: DateTime(2026, 10, 25, 0, 30), use24h: true),
        'Today at 23:00',
      );
    });
  });

  test('roundUpToMinutes', () {
    expect(roundUpToMinutes(DateTime(2026, 10, 7, 9, 30), 5), DateTime(2026, 10, 7, 9, 30));
    expect(roundUpToMinutes(DateTime(2026, 10, 7, 9, 30, 1), 5), DateTime(2026, 10, 7, 9, 35));
    expect(roundUpToMinutes(DateTime(2026, 10, 7, 9, 31), 5), DateTime(2026, 10, 7, 9, 35));
    expect(roundUpToMinutes(DateTime(2026, 10, 7, 23, 58), 5), DateTime(2026, 10, 8, 0, 0));
  });
}
