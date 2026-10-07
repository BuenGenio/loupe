import 'dart:convert';
import 'dart:io';

import 'package:mail_calendar/mail_calendar.dart';
import 'package:test/test.dart';

Calendar corpus(String name, {bool crlf = true}) {
  var text = File('test/corpus/$name').readAsStringSync();
  if (crlf) text = text.replaceAll('\r\n', '\n').replaceAll('\n', '\r\n');
  return Calendar.parse(text)!;
}

void main() {
  group('content lines', () {
    test('unfolds CRLF, LF and CR breaks, spaces and tabs', () {
      expect(unfoldLines('A:1\r\n 2\r\n\t3\r\nB:x\ny\n  z\rC:c'), ['A:123', 'B:x', 'y z', 'C:c']);
      expect(unfoldLines('﻿BEGIN:VCALENDAR\r\n'), ['BEGIN:VCALENDAR']);
    });

    test('a fold in the middle of a UTF-8 character or a quoted parameter', () {
      // Writers fold by octets, so a line can break inside "ä" … once decoded,
      // the halves are already joined by the decoder; here it breaks between
      // characters of a quoted CN.
      final c = Calendar.parse(
        'BEGIN:VEVENT\r\nSUMMARY:Gr\r\n üße aus Köln\r\nATTENDEE;CN="Doe,\r\n  Jane":mailto:jane@example.com\r\nEND:VEVENT',
      )!;
      expect(c.events.single.summary, 'Grüße aus Köln');
      expect(c.events.single.attendees.single.name, 'Doe, Jane');
    });

    test('parameters: quoted values with colons, lists, RFC 6868 escapes', () {
      final p = parseContentLine(
        'ATTENDEE;CN="Lee: Jordan";DELEGATED-TO="mailto:a@x.example","mailto:b@x.example";'
        "X-NOTE=say ^'hi^'^nbye:mailto:jordan@example.com",
      )!;
      expect(p.name, 'ATTENDEE');
      expect(p.param('cn'), 'Lee: Jordan');
      expect(p.params['DELEGATED-TO'], ['mailto:a@x.example', 'mailto:b@x.example']);
      expect(p.param('X-NOTE'), 'say "hi"\nbye');
      expect(p.value, 'mailto:jordan@example.com');
      expect(parseContentLine('no colon here'), isNull);
      expect(parseContentLine(':value'), isNull);
      expect(parseContentLine('X;Y="unterminated:value'), isNull);
    });

    test('TEXT escapes both ways', () {
      expect(unescapeText(r'a\, b\; c\\d\ne\Nf \x'), 'a, b; c\\d\ne\nf \\x');
      const text = 'Room 3; floor 2, east\\wing\nBring a laptop';
      expect(unescapeText(escapeText(text)), text);
      expect(escapeText('a,b'), r'a\,b');
    });

    test('writing folds at 75 octets without splitting characters', () {
      final long = Property('DESCRIPTION', escapeText('Ünïcödé ' * 30));
      final folded = foldLine(long.toLine());
      for (final line in folded.split('\r\n')) {
        expect(utf8.encode(line).length, lessThanOrEqualTo(75));
      }
      expect(unfoldLines(folded).single, long.toLine());
      expect(foldLine('SUMMARY:short'), 'SUMMARY:short');
      // Emoji are four octets; surrogate pairs stay together.
      final emoji = foldLine('SUMMARY:${'🎉' * 40}');
      expect(emoji.split('\r\n').every((l) => utf8.encode(l).length <= 75), isTrue);
      expect(unfoldLines(emoji).single, 'SUMMARY:${'🎉' * 40}');
    });

    test('parameter values are quoted when needed', () {
      final p = Property(
        'ATTENDEE',
        'mailto:a@example.com',
        params: {
          'CN': ['Lee, Jordan'],
          'ROLE': ['CHAIR'],
        },
      );
      expect(p.toLine(), 'ATTENDEE;CN="Lee, Jordan";ROLE=CHAIR:mailto:a@example.com');
      final q = Property(
        'X',
        'v',
        params: {
          'P': ['say "hi"'],
        },
      );
      expect(q.toLine(), "X;P=say ^'hi^':v");
      expect(parseContentLine(q.toLine())!.param('P'), 'say "hi"');
    });
  });

  group('corpus', () {
    test('Outlook / Exchange: Windows zone, Teams, quoted names, alarms ignored', () {
      final c = corpus('outlook_teams.ics');
      expect(c.method, ItipMethod.request);
      expect(c.productId, 'Microsoft Exchange Server 2010');
      final e = c.primary!;
      expect(
        e.uid,
        '040000008200E00074C5B7101A82E00800000000A0B1C2D3E4F5A60100000000000000001000000012345678901234567890ABCDEF',
      );
      expect(e.summary, 'SOW phase 2 – pricing review');
      expect(e.sequence, 0);
      expect(e.status, EventStatus.confirmed);
      expect(e.start, CalDateTime.zoned(DateTime.utc(2026, 10, 13, 9), 'Pacific Standard Time'));
      expect(e.organizer!.email, 'olivia.grant@fabrikam.example');
      expect(e.organizer!.name, 'Olivia Grant');
      expect(e.attendees.map((a) => a.displayName), ['Sam Rivera', 'Becker, Tom']);
      expect(e.attendees[1].role, AttendeeRole.optional);
      expect(e.attendees.every((a) => a.rsvp && a.partStat == PartStat.needsAction), isTrue);
      expect(e.description, contains('Click here to join the meeting'));
      expect(e.description, isNot(contains('<html>')));
      // One Teams link, though it is in three places (the HTML is ignored).
      expect(e.meetingLinks, hasLength(1));
      expect(e.meetingLinks.single.provider, 'Teams');
      expect(e.meetingLinks.single.uri.host, 'teams.microsoft.com');
      expect(e.location, 'Microsoft Teams Meeting');
      // 09:00 Pacific Daylight Time.
      expect(eventSpan(e, c.zones)!.start, DateTime.utc(2026, 10, 13, 16));
      expect(eventSpan(e, c.zones)!.zone!.ianaName, 'America/Los_Angeles');
    });

    test('Google Calendar: recurrence, EXDATE, Meet, alarm attendees stay in the alarm', () {
      final c = corpus('google_meet_recurring.ics');
      final e = c.primary!;
      expect(e.summary, 'Jordan / Sam 1:1');
      expect(e.attendees.map((a) => a.email), ['jordan.lee@example.com', 'sam.rivera@gmail.example']);
      expect(e.attendeeFor(['SAM.RIVERA@gmail.example'])!.partStat, PartStat.needsAction);
      expect(e.location, isNull);
      expect(e.meetingLinks.first, MeetingLink(Uri.parse('https://meet.google.com/abc-defg-hij')));
      expect(e.meetingLinks.first.provider, 'Google Meet');
      expect(e.meetingLinks.map((l) => l.uri.host), isNot(contains('support.google.com')));
      expect(e.rule!.frequency, Frequency.weekly);
      expect(e.rule!.interval, 2);
      expect(e.isRecurring, isTrue);
      expect(
        describeRule(e.rule!, start: e.start!, zones: c.zones),
        'Every 2 weeks on Tuesday and Thursday until 1 Dec 2026',
      );
      final next = eventOccurrences(e, c.zones, limit: 20);
      expect(next.map((o) => o.start.toIso8601String()), [
        '2026-10-06T14:00:00.000Z',
        '2026-10-08T14:00:00.000Z',
        // 20 October is excluded.
        '2026-10-22T14:00:00.000Z',
        '2026-11-03T15:00:00.000Z', // EST from 1 November
        '2026-11-05T15:00:00.000Z',
        '2026-11-17T15:00:00.000Z',
        '2026-11-19T15:00:00.000Z',
        '2026-12-01T15:00:00.000Z',
      ]);
      expect(next.first.end.difference(next.first.start), const Duration(minutes: 30));
    });

    test('Apple: unfolded long lines, structured location with geo:', () {
      final c = corpus('apple_icloud.ics');
      final e = c.primary!;
      expect(e.location, 'Le Petit Zinc\n11 Rue Saint-Benoît, 75006 Paris, France');
      final where = e.structuredLocation!;
      expect(where.uri.toString(), 'geo:48.854,2.333');
      expect(where.title, 'Le Petit Zinc');
      expect(where.address, '11 Rue Saint-Benoît, 75006 Paris, France');
      expect(e.url, isNull);
      expect(e.organizer!.displayName, 'Elena Rossi');
      expect(eventSpan(e, c.zones)!.start, DateTime.utc(2026, 10, 16, 17, 30));
      expect(e.meetingLinks, isEmpty);
    });

    test('Zoom: PUBLISH without an organizer, a link as the location', () {
      final c = corpus('zoom_publish.ics');
      expect(c.method, ItipMethod.publish);
      final e = c.primary!;
      expect(e.organizer, isNull);
      expect(e.meetingLinks.first.provider, 'Zoom');
      expect(e.meetingLinks.first.uri.toString(), 'https://us02web.zoom.us/j/81234567890?pwd=AbCdEfGh123');
      expect(e.meetingLinks, hasLength(1));
      expect(eventSpan(e, c.zones)!.start, DateTime.utc(2026, 10, 9, 9));
    });

    test('Thunderbird / Lightning: rooms, roles, sequence', () {
      final c = corpus('lightning.ics', crlf: false);
      final e = c.primary!;
      expect(e.sequence, 2);
      expect(e.location, 'Gemeindehaus, Lindenstraße 5, Berlin');
      expect(e.organizer!.email, 'felix@brandt.example');
      final room = e.attendees.last;
      expect(room.isResource, isTrue);
      expect(room.role, AttendeeRole.nonParticipant);
      expect(e.attendees[1].partStat, PartStat.tentative);
      expect(eventSpan(e, c.zones)!.start, DateTime.utc(2026, 10, 20, 17));
    });

    test('old Lightning TZIDs with a path in front', () {
      final c = Calendar.parse(
        'BEGIN:VCALENDAR\nBEGIN:VEVENT\nUID:x\n'
        'DTSTART;TZID=/mozilla.org/20070129_1/Europe/Berlin:20260115T100000\nEND:VEVENT\nEND:VCALENDAR',
      )!;
      expect(eventSpan(c.primary!, c.zones)!.start, DateTime.utc(2026, 1, 15, 9));
    });
  });

  group('times', () {
    test('UTC, floating, zoned and all-day values', () {
      expect(CalDateTime.parse('20261008T090000Z')!.form, TimeForm.utc);
      expect(CalDateTime.parse('20261008T090000')!.form, TimeForm.floating);
      expect(CalDateTime.parse('20261008T090000', tzid: 'Europe/London')!.form, TimeForm.zoned);
      expect(CalDateTime.parse('20261008T090000Z', tzid: 'Europe/London')!.form, TimeForm.utc);
      expect(CalDateTime.parse('20261008')!.isDate, isTrue);
      expect(CalDateTime.parse('20261008T2400')!.local, DateTime.utc(2026, 10, 9));
      expect(CalDateTime.parse('20260230'), isNull);
      expect(CalDateTime.parse('2026-10-08'), isNull);
      expect(CalDateTime.parse('20261008T250000'), isNull);
      for (final v in ['20261008', '20261008T090000', '20261008T090000Z']) {
        expect(CalDateTime.parse(v)!.value, v);
      }
    });

    test('DURATION', () {
      expect(CalDuration.parse('PT1H30M')!.duration, const Duration(minutes: 90));
      expect(CalDuration.parse('P1W')!.duration, const Duration(days: 7));
      expect(CalDuration.parse('-PT15M')!.duration, const Duration(minutes: -15));
      expect(CalDuration.parse('P1DT12H')!.duration, const Duration(hours: 36));
      expect(CalDuration.parse('P'), isNull);
      expect(CalDuration.parse('PT'), isNull);
      expect(CalDuration.parse('1H'), isNull);
      expect(CalDuration.parse('PT1H30M')!.value, 'PT1H30M');
      expect(const CalDuration(days: 14).value, 'P2W');
    });

    test('end from DTEND, DURATION or the kind of start', () {
      CalendarEvent e(String props) => Calendar.parse('BEGIN:VEVENT\n$props\nEND:VEVENT')!.events.single;
      final zones = ZoneResolver();
      expect(eventSpan(e('DTSTART:20261008T090000Z\nDURATION:PT45M'), zones)!.end, DateTime.utc(2026, 10, 8, 9, 45));
      final allDay = eventSpan(e('DTSTART;VALUE=DATE:20261008'), zones)!;
      expect(allDay.allDay, isTrue);
      expect(allDay.start, DateTime(2026, 10, 8));
      expect(allDay.end, DateTime(2026, 10, 9));
      expect(allDay.lastDay, DateTime(2026, 10, 8));
      final days = eventSpan(e('DTSTART;VALUE=DATE:20261012\nDTEND;VALUE=DATE:20261015'), zones)!;
      expect(days.lastDay, DateTime(2026, 10, 14));
      final floating = eventSpan(e('DTSTART:20261008T090000\nDTEND:20261008T100000'), zones)!;
      expect(floating.floating, isTrue);
      expect(floating.start, DateTime(2026, 10, 8, 9));
      // An end before the start is ignored.
      expect(
        eventSpan(e('DTSTART:20261008T090000Z\nDTEND:20261008T080000Z'), zones)!.end,
        DateTime.utc(2026, 10, 8, 9),
      );
      // Unknown zone: shown as written, flagged.
      final unknown = eventSpan(e('DTSTART;TZID=Mars/Olympus:20261008T090000'), zones)!;
      expect(unknown.unknownZone, isTrue);
      expect(unknown.start, DateTime(2026, 10, 8, 9));
    });
  });

  group('bad input', () {
    test('nothing, garbage and binary', () {
      expect(Calendar.parse(''), isNull);
      expect(Calendar.parse('not a calendar'), isNull);
      expect(Calendar.parse(String.fromCharCodes(List.generate(4000, (i) => (i * 7919) % 256))), isNull);
      expect(Calendar.parse('BEGIN:VCALENDAR\nEND:VCALENDAR')!.events, isEmpty);
    });

    test('missing ENDs, stray ENDs and properties outside components', () {
      final c = Calendar.parse(
        'METHOD:REQUEST\nEND:VEVENT\nBEGIN:VCALENDAR\nMETHOD:CANCEL\nBEGIN:VEVENT\nUID:a\nSUMMARY:One\n'
        'BEGIN:VALARM\nTRIGGER:-PT5M\nEND:VEVENT\nBEGIN:VEVENT\nUID:b\nSUMMARY:Two',
      )!;
      expect(c.method, ItipMethod.cancel);
      expect(c.events.map((e) => e.summary), ['One', 'Two']);
      expect(c.eventCount, 2);
    });

    test('a bare VEVENT and a cancelled status', () {
      final c = Calendar.parse('BEGIN:VEVENT\nSTATUS:CANCELLED\nEND:VEVENT')!;
      expect(c.events.single.status, EventStatus.cancelled);
      expect(c.method, ItipMethod.none);
    });

    test('deep nesting and floods stop early', () {
      final deep = '${'BEGIN:X\n' * 10000}SUMMARY:deep\n';
      expect(parseComponents(deep), hasLength(1));
      final flood = StringBuffer('BEGIN:VCALENDAR\n');
      for (var i = 0; i < 20000; i++) {
        flood.write('BEGIN:VEVENT\nUID:$i\nEND:VEVENT\n');
      }
      final c = Calendar.parse(flood.toString())!;
      expect(c.events.length, lessThanOrEqualTo(ParseLimits.components));
    });

    test('values that are not what they claim', () {
      final c = Calendar.parse(
        'BEGIN:VEVENT\nUID:x\nSEQUENCE:many\nDTSTART:tomorrow\nRRULE:FREQ=SOMETIMES\nGEO:999;1\n'
        'ATTENDEE;PARTSTAT=MAYBE:urn:uuid:123\nORGANIZER:mailto:\nURL:javascript:alert(1)\nEND:VEVENT',
      )!;
      final e = c.events.single;
      expect(e.sequence, 0);
      expect(e.start, isNull);
      expect(eventSpan(e, c.zones), isNull);
      expect(e.rule, isNull);
      expect(e.geo, isNull);
      expect(e.attendees.single.email, '');
      expect(e.attendees.single.partStat, PartStat.other);
      expect(e.meetingLinks, isEmpty);
    });
  });

  test('writing a component back', () {
    final c = corpus('lightning.ics');
    final again = Calendar.parse(c.root.toIcs())!;
    expect(again.primary!.summary, c.primary!.summary);
    expect(again.primary!.location, c.primary!.location);
    expect(again.primary!.attendees.map((a) => a.email), c.primary!.attendees.map((a) => a.email));
    expect(c.root.toIcs(), startsWith('BEGIN:VCALENDAR\r\nPRODID:'));
    expect(c.root.toIcs().split('\r\n').every((l) => utf8.encode(l).length <= 75), isTrue);
  });
}
