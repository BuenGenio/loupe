import 'package:mail_calendar/mail_calendar.dart';
import 'package:test/test.dart';

/// The dates [rule] gives from [start] (wall clock, 09:00 unless given), as `yyyy-mm-dd`.
List<String> dates(String rule, DateTime start, {int take = 100, String? until, List<String> exdates = const []}) {
  final r = RecurrenceRule.parse(rule)!;
  final u = until == null ? null : CalDateTime.parse(until)!.local;
  return [
    for (final t in expandRule(r, start, until: u).take(take))
      if (!exdates.contains(_d(t))) _d(t),
  ];
}

String _d(DateTime t) => '${t.year}-${t.month.toString().padLeft(2, '0')}-${t.day.toString().padLeft(2, '0')}';

/// [rule] of an event starting on [start] at 09:00 in New York, in words.
String words(String rule, {DateTime? start}) {
  final s = CalDateTime.zoned(start ?? DateTime.utc(2026, 10, 6, 9), 'America/New_York');
  return describeRule(RecurrenceRule.parse(rule)!, start: s, zones: ZoneResolver());
}

void main() {
  group('RFC 5545 §3.8.5.3 examples', () {
    final sep2 = DateTime.utc(1997, 9, 2, 9);

    test('daily for 10 occurrences', () {
      expect(dates('FREQ=DAILY;COUNT=10', sep2), [
        for (var d = 2; d <= 11; d++) '1997-09-${d.toString().padLeft(2, '0')}',
      ]);
    });

    test('daily until 24 December 1997', () {
      // UNTIL=19971224T000000Z is 23 December 19:00 in New York.
      final all = dates('FREQ=DAILY;UNTIL=19971224T000000Z', sep2, take: 500, until: '19971223T190000');
      expect(all, hasLength(113));
      expect(all.last, '1997-12-23');
    });

    test('every other day, forever', () {
      expect(dates('FREQ=DAILY;INTERVAL=2', sep2, take: 4), ['1997-09-02', '1997-09-04', '1997-09-06', '1997-09-08']);
    });

    test('every other week on Monday, Wednesday and Friday until 24 December', () {
      expect(
        dates(
          'FREQ=WEEKLY;INTERVAL=2;UNTIL=19971224T000000Z;WKST=SU;BYDAY=MO,WE,FR',
          DateTime.utc(1997, 9, 1, 9),
          until: '19971223T190000',
        ),
        [
          '1997-09-01', '1997-09-03', '1997-09-05', '1997-09-15', '1997-09-17', '1997-09-19', '1997-09-29', //
          '1997-10-01', '1997-10-03', '1997-10-13', '1997-10-15', '1997-10-17', '1997-10-27', '1997-10-29',
          '1997-10-31', '1997-11-10', '1997-11-12', '1997-11-14', '1997-11-24', '1997-11-26', '1997-11-28',
          '1997-12-08', '1997-12-10', '1997-12-12', '1997-12-22',
        ],
      );
    });

    test('WKST makes a difference', () {
      final start = DateTime.utc(1997, 8, 5, 9);
      expect(dates('FREQ=WEEKLY;INTERVAL=2;COUNT=4;BYDAY=TU,SU;WKST=MO', start), [
        '1997-08-05', '1997-08-10', '1997-08-19', '1997-08-24', //
      ]);
      expect(dates('FREQ=WEEKLY;INTERVAL=2;COUNT=4;BYDAY=TU,SU;WKST=SU', start), [
        '1997-08-05', '1997-08-17', '1997-08-19', '1997-08-31', //
      ]);
    });

    test('monthly on the first Friday for 10 occurrences', () {
      expect(dates('FREQ=MONTHLY;COUNT=10;BYDAY=1FR', DateTime.utc(1997, 9, 5, 9)), [
        '1997-09-05', '1997-10-03', '1997-11-07', '1997-12-05', '1998-01-02', //
        '1998-02-06', '1998-03-06', '1998-04-03', '1998-05-01', '1998-06-05',
      ]);
    });

    test('monthly on the second-to-last Monday for 6 months', () {
      expect(dates('FREQ=MONTHLY;COUNT=6;BYDAY=-2MO', DateTime.utc(1997, 9, 22, 9)), [
        '1997-09-22', '1997-10-20', '1997-11-17', '1997-12-22', '1998-01-19', '1998-02-16', //
      ]);
    });

    test('the third of Tuesday, Wednesday or Thursday, for 3 months (BYSETPOS)', () {
      expect(dates('FREQ=MONTHLY;COUNT=3;BYDAY=TU,WE,TH;BYSETPOS=3', DateTime.utc(1997, 9, 4, 9)), [
        '1997-09-04', '1997-10-07', '1997-11-06', //
      ]);
    });

    test('the second-to-last weekday of the month', () {
      expect(dates('FREQ=MONTHLY;BYDAY=MO,TU,WE,TH,FR;BYSETPOS=-2', DateTime.utc(1997, 9, 29, 9), take: 7), [
        '1997-09-29', '1997-10-30', '1997-11-27', '1997-12-30', '1998-01-29', '1998-02-26', '1998-03-30', //
      ]);
    });

    test('every Friday the 13th (with DTSTART excluded)', () {
      expect(dates('FREQ=MONTHLY;BYDAY=FR;BYMONTHDAY=13', sep2, take: 6, exdates: ['1997-09-02']), [
        '1998-02-13',
        '1998-03-13',
        '1998-11-13',
        '1999-08-13',
        '2000-10-13',
      ]);
    });

    test('invalid dates are skipped (the 30th of February)', () {
      expect(dates('FREQ=MONTHLY;BYMONTHDAY=15,30;COUNT=5', DateTime.utc(2007, 1, 15, 9)), [
        '2007-01-15', '2007-01-30', '2007-02-15', '2007-03-15', '2007-03-30', //
      ]);
    });

    test('yearly in June and July for 10 occurrences', () {
      expect(dates('FREQ=YEARLY;COUNT=10;BYMONTH=6,7', DateTime.utc(1997, 6, 10, 9)), [
        for (var y = 1997; y <= 2001; y++) ...['$y-06-10', '$y-07-10'],
      ]);
    });

    test('every 20th Monday of the year', () {
      expect(dates('FREQ=YEARLY;BYDAY=20MO', DateTime.utc(1997, 5, 19, 9), take: 3), [
        '1997-05-19', '1998-05-18', '1999-05-17', //
      ]);
    });

    test('Monday of week number 20', () {
      expect(dates('FREQ=YEARLY;BYWEEKNO=20;BYDAY=MO', DateTime.utc(1997, 5, 12, 9), take: 3), [
        '1997-05-12', '1998-05-11', '1999-05-17', //
      ]);
    });

    test('every Thursday in March', () {
      expect(dates('FREQ=YEARLY;BYMONTH=3;BYDAY=TH', DateTime.utc(1997, 3, 13, 9), take: 11), [
        '1997-03-13', '1997-03-20', '1997-03-27', '1998-03-05', '1998-03-12', '1998-03-19', '1998-03-26', //
        '1999-03-04', '1999-03-11', '1999-03-18', '1999-03-25',
      ]);
    });

    test('US presidential election day', () {
      expect(
        dates(
          'FREQ=YEARLY;INTERVAL=4;BYMONTH=11;BYDAY=TU;BYMONTHDAY=2,3,4,5,6,7,8',
          DateTime.utc(1996, 11, 5, 9),
          take: 3,
        ),
        ['1996-11-05', '2000-11-07', '2004-11-02'],
      );
    });

    test('every 3rd year on the 1st, 100th and 200th day', () {
      expect(dates('FREQ=YEARLY;INTERVAL=3;COUNT=10;BYYEARDAY=1,100,200', DateTime.utc(1997, 1, 1, 9)), [
        '1997-01-01', '1997-04-10', '1997-07-19', '2000-01-01', '2000-04-09', //
        '2000-07-18', '2003-01-01', '2003-04-10', '2003-07-19', '2006-01-01',
      ]);
    });

    test('every 3 hours from 09:00 until 17:00', () {
      final r = RecurrenceRule.parse('FREQ=HOURLY;INTERVAL=3;UNTIL=19970902T170000Z')!;
      expect(expandRule(r, sep2, until: DateTime.utc(1997, 9, 2, 17)).map((t) => t.hour), [9, 12, 15]);
    });
  });

  group('rules', () {
    test('read leniently and written canonically', () {
      final r = RecurrenceRule.parse('freq=weekly; interval=2; byday=tu,th; until=20261202T045959Z; wkst=su; X-FOO=1')!;
      expect(r.value, 'FREQ=WEEKLY;UNTIL=20261202T045959Z;INTERVAL=2;BYDAY=TU,TH;WKST=SU');
      expect(
        RecurrenceRule.parse('FREQ=MONTHLY;BYDAY=+2TU,-1FR;BYMONTHDAY=0,32,-3')!.value,
        'FREQ=MONTHLY;BYDAY=2TU,-1FR;BYMONTHDAY=-3',
      );
      expect(RecurrenceRule.parse('INTERVAL=2'), isNull);
      expect(RecurrenceRule.parse('FREQ=DAILY;INTERVAL=0')!.interval, 1);
      // COUNT and UNTIL together: COUNT wins.
      expect(RecurrenceRule.parse('FREQ=DAILY;COUNT=3;UNTIL=20260101')!.until, isNull);
    });

    test('a rule that never matches stops', () {
      final r = RecurrenceRule.parse('FREQ=YEARLY;BYMONTH=2;BYMONTHDAY=30')!;
      final sw = Stopwatch()..start();
      expect(expandRule(r, DateTime.utc(2026, 1, 1)).toList(), [DateTime.utc(2026, 1, 1)]);
      expect(sw.elapsed, lessThan(const Duration(seconds: 5)));
    });
  });

  group('in words', () {
    test('daily and weekly', () {
      expect(words('FREQ=DAILY'), 'Every day');
      expect(words('FREQ=DAILY;INTERVAL=3'), 'Every 3 days');
      expect(words('FREQ=DAILY;BYDAY=MO,TU,WE,TH,FR'), 'Every weekday');
      expect(words('FREQ=WEEKLY'), 'Every week on Tuesday');
      expect(words('FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR'), 'Every weekday');
      expect(words('FREQ=WEEKLY;BYDAY=MO,WE,FR'), 'Every week on Monday, Wednesday and Friday');
      expect(
        words('FREQ=WEEKLY;INTERVAL=2;BYDAY=TU,TH;UNTIL=20261202T045959Z'),
        'Every 2 weeks on Tuesday and Thursday until 1 Dec 2026',
      );
      expect(words('FREQ=WEEKLY;BYDAY=SU,MO,TU,WE,TH,FR,SA'), 'Every day');
    });

    test('monthly', () {
      expect(words('FREQ=MONTHLY'), 'Every month on the 6th');
      expect(words('FREQ=MONTHLY;BYMONTHDAY=1,15'), 'Every month on the 1st and 15th');
      expect(words('FREQ=MONTHLY;BYMONTHDAY=-1'), 'Every month on the last day');
      expect(words('FREQ=MONTHLY;BYDAY=2TU'), 'Every month on the second Tuesday');
      expect(words('FREQ=MONTHLY;INTERVAL=3;BYDAY=-1FR'), 'Every 3 months on the last Friday');
      expect(words('FREQ=MONTHLY;BYDAY=MO,TU,WE,TH,FR;BYSETPOS=-1'), 'Every month on the last weekday');
      expect(words('FREQ=MONTHLY;BYDAY=TU;BYSETPOS=1'), 'Every month on the first Tuesday');
      expect(words('FREQ=MONTHLY;BYDAY=-2MO'), 'Every month on the second to last Monday');
      expect(words('FREQ=MONTHLY;BYMONTHDAY=22'), 'Every month on the 22nd');
    });

    test('yearly', () {
      expect(words('FREQ=YEARLY'), 'Every year on 6 October');
      expect(words('FREQ=YEARLY;BYMONTH=11;BYDAY=4TH'), 'Every year on the fourth Thursday of November');
      expect(words('FREQ=YEARLY;INTERVAL=2;BYMONTH=1,7;BYMONTHDAY=1'), 'Every 2 years on the 1st of January and July');
    });

    test('ends and anything else', () {
      expect(words('FREQ=DAILY;COUNT=10'), 'Every day, 10 times');
      expect(words('FREQ=DAILY;COUNT=1'), 'Every day, once');
      expect(words('FREQ=WEEKLY;UNTIL=20261201'), 'Every week on Tuesday until 1 Dec 2026');
      expect(words('FREQ=HOURLY;INTERVAL=2'), 'Every 2 hours');
      expect(words('FREQ=YEARLY;BYWEEKNO=20'), 'Every year (custom)');
      expect(
        describeRule(
          RecurrenceRule.parse('FREQ=DAILY;UNTIL=20261201T000000Z')!,
          start: CalDateTime.zoned(DateTime.utc(2026, 10, 6, 9), 'America/New_York'),
          zones: ZoneResolver(),
          formatDate: (d) => '${d.month}/${d.day}',
        ),
        'Every day until 11/30',
      );
    });
  });
}
