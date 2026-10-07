import 'package:mail_calendar/mail_calendar.dart';
import 'package:test/test.dart';

const _customZone = '''BEGIN:VCALENDAR
BEGIN:VTIMEZONE
TZID:Customized Time Zone
BEGIN:STANDARD
DTSTART:16010101T030000
TZOFFSETFROM:+0200
TZOFFSETTO:+0100
RRULE:FREQ=YEARLY;INTERVAL=1;BYDAY=-1SU;BYMONTH=10
END:STANDARD
BEGIN:DAYLIGHT
DTSTART:16010101T020000
TZOFFSETFROM:+0100
TZOFFSETTO:+0200
RRULE:FREQ=YEARLY;INTERVAL=1;BYDAY=-1SU;BYMONTH=3
END:DAYLIGHT
END:VTIMEZONE
BEGIN:VEVENT
UID:custom
DTSTART;TZID=Customized Time Zone:20260715T140000
DTEND;TZID=Customized Time Zone:20260715T150000
END:VEVENT
END:VCALENDAR''';

void main() {
  group('TZID to IANA', () {
    test('IANA names, also with a path in front', () {
      expect(ianaZoneName('Europe/London'), 'Europe/London');
      expect(ianaZoneName(' "America/New_York" '), 'America/New_York');
      expect(ianaZoneName('/mozilla.org/20070129_1/Europe/Berlin'), 'Europe/Berlin');
      expect(ianaZoneName('/citadel.org/20190914_1/America/Los_Angeles'), 'America/Los_Angeles');
      // Old names (backward links) are in the database too.
      expect(ianaZoneName('Asia/Calcutta'), 'Asia/Calcutta');
      expect(ianaZoneName('US/Eastern'), 'US/Eastern');
      expect(ianaZoneName('UTC'), 'UTC');
      expect(ianaZoneName('Z'), 'Etc/UTC');
    });

    test("Outlook's Windows names and display names", () {
      expect(ianaZoneName('Pacific Standard Time'), 'America/Los_Angeles');
      expect(ianaZoneName('W. Europe Standard Time'), 'Europe/Berlin');
      expect(ianaZoneName('GMT Standard Time'), 'Europe/London');
      expect(ianaZoneName('Tokyo Standard Time'), 'Asia/Tokyo');
      expect(ianaZoneName('India Standard Time'), 'Asia/Calcutta');
      expect(ianaZoneName('E. Australia Standard Time'), 'Australia/Brisbane');
      expect(ianaZoneName('pacific standard time'), 'America/Los_Angeles');
      expect(ianaZoneName('(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna'), 'Europe/Berlin');
      expect(ianaZoneName('(UTC-08:00) Pacific Time (US & Canada)'), 'America/Los_Angeles');
      expect(ianaZoneName('(GMT-08:00) Pacific Time (US & Canada)'), 'America/Los_Angeles');
    });

    test('unknown names', () {
      expect(ianaZoneName('Customized Time Zone'), isNull);
      expect(ianaZoneName(''), isNull);
      expect(ianaZoneName('Mars/Olympus_Mons'), isNull);
    });
  });

  group('wall clock to instants', () {
    final london = IanaZone.named('Europe/London')!;
    final newYork = IanaZone.named('America/New_York')!;

    test('summer and winter time', () {
      expect(london.toUtc(DateTime.utc(2026, 7, 1, 9)), DateTime.utc(2026, 7, 1, 8));
      expect(london.toUtc(DateTime.utc(2026, 12, 1, 9)), DateTime.utc(2026, 12, 1, 9));
      expect(newYork.toWall(DateTime.utc(2026, 7, 1, 13)), DateTime.utc(2026, 7, 1, 9));
    });

    test('a time skipped when clocks go forward is read with the offset before the gap', () {
      // 29 March 2026, London: 01:00 GMT becomes 02:00 BST.
      expect(london.toUtc(DateTime.utc(2026, 3, 29, 1, 30)), DateTime.utc(2026, 3, 29, 1, 30));
      expect(london.toWall(DateTime.utc(2026, 3, 29, 1, 30)), DateTime.utc(2026, 3, 29, 2, 30));
      // 8 March 2026, New York: 02:00 EST becomes 03:00 EDT.
      expect(newYork.toUtc(DateTime.utc(2026, 3, 8, 2, 30)), DateTime.utc(2026, 3, 8, 7, 30));
    });

    test('a time that happens twice when clocks go back is the first one', () {
      // 25 October 2026, London: 02:00 BST becomes 01:00 GMT.
      expect(london.toUtc(DateTime.utc(2026, 10, 25, 1, 30)), DateTime.utc(2026, 10, 25, 0, 30));
      // 1 November 2026, New York.
      expect(newYork.toUtc(DateTime.utc(2026, 11, 1, 1, 30)), DateTime.utc(2026, 11, 1, 5, 30));
    });

    test('a weekly meeting keeps its wall-clock time across the change', () {
      final c = Calendar.parse(
        'BEGIN:VEVENT\nUID:w\nDTSTART;TZID=Europe/London:20261020T090000\nDTEND;TZID=Europe/London:20261020T100000\n'
        'RRULE:FREQ=WEEKLY;COUNT=2\nEND:VEVENT',
      )!;
      final o = eventOccurrences(c.primary!, c.zones);
      expect(o.map((x) => x.start), [DateTime.utc(2026, 10, 20, 8), DateTime.utc(2026, 10, 27, 9)]);
      expect(o.every((x) => x.end.difference(x.start) == const Duration(hours: 1)), isTrue);
    });
  });

  group('VTIMEZONE rules', () {
    test("Outlook's custom zone with rules from 1601", () {
      final c = Calendar.parse(_customZone)!;
      final zone = c.zones.zone('Customized Time Zone')!;
      expect(zone, isA<EmbeddedZone>());
      expect(zone.offsetAt(DateTime.utc(2026, 7, 15)), const Duration(hours: 2));
      expect(zone.offsetAt(DateTime.utc(2026, 1, 15)), const Duration(hours: 1));
      // Transitions: 29 March 2026 01:00Z and 25 October 2026 01:00Z, as in Berlin.
      expect(zone.offsetAt(DateTime.utc(2026, 3, 29, 0, 59)), const Duration(hours: 1));
      expect(zone.offsetAt(DateTime.utc(2026, 3, 29, 1)), const Duration(hours: 2));
      expect(zone.offsetAt(DateTime.utc(2026, 10, 25, 0, 59)), const Duration(hours: 2));
      expect(zone.offsetAt(DateTime.utc(2026, 10, 25, 1)), const Duration(hours: 1));
      expect(eventSpan(c.primary!, c.zones)!.start, DateTime.utc(2026, 7, 15, 12));
    });

    test('agrees with the IANA database for the zones calendars embed', () {
      final berlin = IanaZone.named('Europe/Berlin')!;
      final c = Calendar.parse(_customZone)!;
      final zone = c.zones.zone('Customized Time Zone')!;
      for (var day = 0; day < 3 * 365; day += 3) {
        final t = DateTime.utc(2025).add(Duration(days: day, hours: day % 24));
        expect(zone.offsetAt(t), berlin.offsetAt(t), reason: '$t');
      }
    });

    test('RDATE observances and a zone without rules', () {
      final c = Calendar.parse('''BEGIN:VCALENDAR
BEGIN:VTIMEZONE
TZID:Island Time
BEGIN:STANDARD
DTSTART:20200101T000000
TZOFFSETFROM:+0300
TZOFFSETTO:+0300
END:STANDARD
BEGIN:DAYLIGHT
DTSTART:20260601T000000
RDATE:20260601T000000
TZOFFSETFROM:+0300
TZOFFSETTO:+0400
END:DAYLIGHT
BEGIN:STANDARD
DTSTART:20260901T000000
TZOFFSETFROM:+0400
TZOFFSETTO:+0300
END:STANDARD
END:VTIMEZONE
END:VCALENDAR''')!;
      final zone = c.zones.zone('Island Time')!;
      expect(zone.offsetAt(DateTime.utc(2026, 5, 1)), const Duration(hours: 3));
      expect(zone.offsetAt(DateTime.utc(2026, 7, 1)), const Duration(hours: 4));
      expect(zone.offsetAt(DateTime.utc(2026, 10, 1)), const Duration(hours: 3));
      expect(zone.offsetAt(DateTime.utc(2010, 1, 1)), const Duration(hours: 3));
    });

    test('a known name wins over the embedded rules; an unknown one without rules is null', () {
      final c = Calendar.parse(
        'BEGIN:VCALENDAR\nBEGIN:VTIMEZONE\nTZID:Europe/Berlin\nBEGIN:STANDARD\nDTSTART:19700101T000000\n'
        'TZOFFSETFROM:+0500\nTZOFFSETTO:+0500\nEND:STANDARD\nEND:VTIMEZONE\nEND:VCALENDAR',
      )!;
      expect(c.zones.zone('Europe/Berlin')!.ianaName, 'Europe/Berlin');
      expect(c.zones.zone('Nowhere'), isNull);
    });
  });

  test('labels', () {
    expect(zoneLabel(IanaZone.named('America/Los_Angeles')!, DateTime.utc(2026)), 'Los Angeles');
    expect(zoneLabel(IanaZone.named('America/Argentina/Buenos_Aires')!, DateTime.utc(2026)), 'Buenos Aires');
    expect(zoneLabel(IanaZone.named('Etc/GMT+5')!, DateTime.utc(2026)), 'UTC−5');
    expect(zoneLabel(FixedZone.utc, DateTime.utc(2026)), 'UTC');
    expect(offsetLabel(const Duration(hours: 5, minutes: 30)), 'UTC+5:30');
    final custom = Calendar.parse(_customZone)!.zones.zone('Customized Time Zone')!;
    expect(zoneLabel(custom, DateTime.utc(2026, 7)), 'UTC+2');
  });
}
