import 'dart:convert';
import 'dart:io';

import 'package:mail_calendar/mail_calendar.dart';
import 'package:test/test.dart';

/// RFC 5546 §4.2.1: A sends a meeting request to B, C and D.
const _rfcRequest = '''BEGIN:VCALENDAR
PRODID:-//Example/ExampleCalendarClient//EN
METHOD:REQUEST
VERSION:2.0
BEGIN:VEVENT
ORGANIZER:mailto:a@example.com
ATTENDEE;ROLE=CHAIR;PARTSTAT=ACCEPTED:mailto:a@example.com
ATTENDEE;RSVP=TRUE;TYPE=INDIVIDUAL:mailto:b@example.com
ATTENDEE;RSVP=TRUE;TYPE=INDIVIDUAL:mailto:c@example.com
ATTENDEE;RSVP=TRUE;TYPE=INDIVIDUAL:mailto:d@example.com
DTSTAMP:19970611T190000Z
DTSTART:19970701T200000Z
DTEND:19970701T210000Z
SUMMARY:Conference Call
UID:calsrv.example.com-873970198738777@example.com
SEQUENCE:0
STATUS:CONFIRMED
END:VEVENT
END:VCALENDAR''';

/// RFC 5546 §4.2.2: B accepts.
const _rfcReply = '''BEGIN:VCALENDAR
PRODID:-//Example/ExampleCalendarClient//EN
METHOD:REPLY
VERSION:2.0
BEGIN:VEVENT
ATTENDEE;PARTSTAT=ACCEPTED:mailto:b@example.com
ORGANIZER:mailto:a@example.com
UID:calsrv.example.com-873970198738777@example.com
SEQUENCE:0
REQUEST-STATUS:2.0;Success
DTSTAMP:19970612T190000Z
END:VEVENT
END:VCALENDAR''';

Map<String, List<String>> _lines(Component c) => {
  for (final name in c.properties.map((p) => p.name).toSet()) name: [for (final p in c.all(name)) p.toLine()],
};

void main() {
  group('REPLY', () {
    test('as RFC 5546 §4.2.2 has it', () {
      final request = Calendar.parse(_rfcRequest)!;
      final ics = buildReply(
        calendar: request,
        event: request.primary!,
        email: 'b@example.com',
        partStat: PartStat.accepted,
        now: DateTime.utc(1997, 6, 12, 19),
      );
      final reply = Calendar.parse(ics)!;
      final expected = Calendar.parse(_rfcReply)!;
      expect(reply.method, ItipMethod.reply);
      expect(reply.root.property('VERSION')!.value, '2.0');
      final got = reply.primary!;
      final want = expected.primary!;
      // Every property of the RFC's reply but REQUEST-STATUS (optional), with the same value.
      for (final name in ['ORGANIZER', 'UID', 'SEQUENCE', 'DTSTAMP']) {
        expect(got.component.property(name)!.value, want.component.property(name)!.value, reason: name);
      }
      final attendee = got.attendees.single;
      expect(attendee.email, 'b@example.com');
      expect(attendee.partStat, PartStat.accepted);
      expect(attendee.rsvp, isFalse);
      expect(attendee.property!.params.containsKey('RSVP'), isFalse);
      // The times and title come along, as Outlook and Google send them.
      expect(got.start, CalDateTime.parse('19970701T200000Z'));
      expect(got.summary, 'Conference Call');
      expect(got.comments, isEmpty);
      // Nothing else: no other attendees, no status, no RSVP.
      expect(_lines(got.component).keys.toSet(), {
        'ATTENDEE',
        'ORGANIZER',
        'UID',
        'SEQUENCE',
        'DTSTAMP',
        'DTSTART',
        'DTEND',
        'SUMMARY',
      });
      expect(ics, contains('\r\nMETHOD:REPLY\r\n'));
      expect(ics.endsWith('END:VCALENDAR\r\n'), isTrue);
    });

    test('declining with a comment', () {
      final request = Calendar.parse(_rfcRequest)!;
      final reply = Calendar.parse(
        buildReply(
          calendar: request,
          event: request.primary!,
          email: 'C@Example.com',
          name: 'Carol',
          partStat: PartStat.declined,
          comment: "Sorry, I'm travelling; Thursday, maybe?",
          now: DateTime.utc(1997, 6, 12, 19),
        ),
      )!;
      final e = reply.primary!;
      expect(e.attendees.single.partStat, PartStat.declined);
      expect(e.attendees.single.name, 'Carol');
      expect(e.comments, ["Sorry, I'm travelling; Thursday, maybe?"]);
      expect(e.component.property('COMMENT')!.value, r"Sorry\, I'm travelling\; Thursday\, maybe?");
    });

    test('an attendee the invitation did not name (forwarded to them)', () {
      final request = Calendar.parse(_rfcRequest)!;
      final e = Calendar.parse(
        buildReply(
          calendar: request,
          event: request.primary!,
          email: 'e@example.com',
          name: 'Erin',
          partStat: PartStat.tentative,
          now: DateTime.utc(2026),
        ),
      )!.primary!;
      expect(e.attendees.single.property!.toLine(), 'ATTENDEE;CN=Erin;PARTSTAT=TENTATIVE:mailto:e@example.com');
    });

    test('keeps SEQUENCE and RECURRENCE-ID, and the VTIMEZONE the times use', () {
      final text = File('test/corpus/outlook_teams.ics')
          .readAsStringSync()
          .replaceFirst('SEQUENCE:0', 'SEQUENCE:3\nRECURRENCE-ID;TZID=Pacific Standard Time:20261013T090000');
      final request = Calendar.parse(text)!;
      final ics = buildReply(
        calendar: request,
        event: request.primary!,
        email: 'sam.rivera@northwind.example',
        partStat: PartStat.accepted,
        now: DateTime.utc(2026, 10, 6, 8, 30),
      );
      final reply = Calendar.parse(ics)!;
      final e = reply.primary!;
      expect(e.sequence, 3);
      expect(e.recurrenceId, CalDateTime.zoned(DateTime.utc(2026, 10, 13, 9), 'Pacific Standard Time'));
      expect(e.uid, request.primary!.uid);
      expect(e.component.property('DTSTAMP')!.value, '20261006T083000Z');
      expect(reply.root.children('VTIMEZONE').single.property('TZID')!.value, 'Pacific Standard Time');
      expect(
        e.attendees.single.property!.toLine(),
        'ATTENDEE;ROLE=REQ-PARTICIPANT;CN=Sam Rivera;PARTSTAT=ACCEPTED:mailto:sam.rivera@northwind.example',
      );
      // Nothing private comes along: not the description, the other attendees, alarms or Microsoft's extras.
      expect(ics, isNot(contains('DESCRIPTION')));
      expect(ics, isNot(contains('tom.becker')));
      expect(ics, isNot(contains('VALARM')));
      expect(ics, isNot(contains('X-MICROSOFT')));
      expect(ics.split('\r\n').every((l) => utf8.encode(l).length <= 75), isTrue);
    });

    test('only answers', () {
      final request = Calendar.parse(_rfcRequest)!;
      expect(
        () => buildReply(
          calendar: request,
          event: request.primary!,
          email: 'b@example.com',
          partStat: PartStat.needsAction,
          now: DateTime.utc(2026),
        ),
        throwsArgumentError,
      );
    });

    test('subjects and verbs', () {
      expect(replySubject(PartStat.accepted, 'Conference Call'), 'Accepted: Conference Call');
      expect(replySubject(PartStat.tentative, 'Conference Call'), 'Tentative: Conference Call');
      expect(replySubject(PartStat.declined, null), 'Declined');
      expect(partStatVerb(PartStat.tentative), 'tentatively accepted');
    });
  });

  group('records', () {
    CalendarEvent event(String props, {String method = 'REQUEST'}) =>
        Calendar.parse('BEGIN:VCALENDAR\nMETHOD:$method\nBEGIN:VEVENT\nUID:u1\n$props\nEND:VEVENT\nEND:VCALENDAR')!
            .primary!;
    final zones = ZoneResolver();
    final v0 = event('SEQUENCE:0\nDTSTART:20261008T090000Z\nDTEND:20261008T100000Z\nLOCATION:Room 1\nSUMMARY:Sync');
    final v1 = event('SEQUENCE:1\nDTSTART:20261008T100000Z\nDTEND:20261008T110000Z\nLOCATION:Room 1\nSUMMARY:Sync');
    final cancel = event('SEQUENCE:2\nDTSTART:20261008T100000Z\nSUMMARY:Sync', method: 'CANCEL');

    test('an update says what changed; the original is then outdated', () {
      final first = InvitationRecord.first(v0, ItipMethod.request, zones);
      expect(first.sequence, 0);
      expect(first.previous, isNull);
      final updated = first.seen(v1, ItipMethod.request, zones);
      expect(updated.sequence, 1);
      final changes = EventChanges.between(updated.previous!, updated.latest);
      expect(changes.time!.$1.start, DateTime.utc(2026, 10, 8, 9));
      expect(changes.time!.$2.start, DateTime.utc(2026, 10, 8, 10));
      expect(changes.location, isNull);
      expect(changes.title, isFalse);
      // Seeing the original again changes nothing.
      expect(identical(updated.seen(v0, ItipMethod.request, zones), updated), isTrue);
      expect(identical(updated.seen(v1, ItipMethod.request, zones), updated), isTrue);
    });

    test('a cancellation is remembered, and survives a round trip', () {
      final r = InvitationRecord.first(
        v0,
        ItipMethod.request,
        zones,
      ).responded(PartStat.accepted, 0, DateTime.utc(2026, 10, 5, 12)).seen(cancel, ItipMethod.cancel, zones);
      expect(r.cancelled, isTrue);
      expect(r.sequence, 2);
      expect(r.latest.location, 'Room 1');
      expect(r.response, PartStat.accepted);
      final back = InvitationRecord.fromJson('u1', '', jsonDecode(jsonEncode(r.toJson())) as Map<String, Object?>)!;
      expect(back.cancelled, isTrue);
      expect(back.response, PartStat.accepted);
      expect(back.responseSequence, 0);
      expect(back.respondedAt, DateTime.utc(2026, 10, 5, 12));
      expect(back.latest.start, r.latest.start);
      expect(InvitationRecord.fromJson('u1', '', const {}), isNull);
    });

    test('location and title changes', () {
      final a = EventSnapshot.of(v0, zones);
      final b = EventSnapshot.of(
        event('SEQUENCE:1\nDTSTART:20261008T090000Z\nDTEND:20261008T100000Z\nLOCATION:Room 2\nSUMMARY:Sync!'),
        zones,
      );
      final changes = EventChanges.between(a, b);
      expect(changes.time, isNull);
      expect(changes.location, ('Room 1', 'Room 2'));
      expect(changes.title, isTrue);
      expect(EventChanges.between(a, a).isEmpty, isTrue);
    });
  });
}
