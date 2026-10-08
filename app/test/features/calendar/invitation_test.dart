import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/calendar/device_calendar.dart';
import 'package:loupe/features/calendar/invitation.dart';
import 'package:loupe/features/calendar/invitation_format.dart';
import 'package:loupe/features/calendar/invitation_reply.dart';
import 'package:loupe/features/compose/identity_selection.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:mail_calendar/mail_calendar.dart';
import 'package:mail_model/mail_model.dart';

/// An Outlook invitation to me@example.com, organized by Olivia in Los Angeles.
String outlookInvite({int sequence = 0, int hour = 9, String method = 'REQUEST', String attendee = 'me@example.com'}) =>
    [
      'BEGIN:VCALENDAR',
      'METHOD:$method',
      'PRODID:Microsoft Exchange Server 2010',
      'VERSION:2.0',
      'BEGIN:VTIMEZONE',
      'TZID:Pacific Standard Time',
      'BEGIN:STANDARD',
      'DTSTART:16010101T020000',
      'TZOFFSETFROM:-0700',
      'TZOFFSETTO:-0800',
      'RRULE:FREQ=YEARLY;INTERVAL=1;BYDAY=1SU;BYMONTH=11',
      'END:STANDARD',
      'BEGIN:DAYLIGHT',
      'DTSTART:16010101T020000',
      'TZOFFSETFROM:-0800',
      'TZOFFSETTO:-0700',
      'RRULE:FREQ=YEARLY;INTERVAL=1;BYDAY=2SU;BYMONTH=3',
      'END:DAYLIGHT',
      'END:VTIMEZONE',
      'BEGIN:VEVENT',
      'ORGANIZER;CN=Olivia Grant:mailto:olivia@fabrikam.example',
      'ATTENDEE;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=TRUE;CN=Me Myself:mailto:$attendee',
      'ATTENDEE;ROLE=OPT-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE;CN=Bob Builder:mailto:bob@example.com',
      'UID:outlook-uid-1',
      'SEQUENCE:$sequence',
      'SUMMARY:Pricing review',
      'DTSTART;TZID=Pacific Standard Time:20261013T${hour.toString().padLeft(2, '0')}0000',
      'DTEND;TZID=Pacific Standard Time:20261013T${(hour + 1).toString().padLeft(2, '0')}0000',
      'DTSTAMP:20261005T161812Z',
      'LOCATION:Room 4',
      'X-MICROSOFT-SKYPETEAMSMEETINGURL:https://teams.microsoft.com/l/meetup-join/abc',
      'END:VEVENT',
      'END:VCALENDAR',
      '',
    ].join('\r\n');

const account = MailAccount(
  id: 'acc',
  email: 'me@example.com',
  displayName: 'Work',
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: ServerConfig(protocol: ServerProtocol.imap, host: 'imap.example.com', port: 993),
  outgoing: ServerConfig(protocol: ServerProtocol.smtp, host: 'smtp.example.com', port: 465),
  identities: [
    Identity(id: 'acc/me', email: 'me@example.com', name: 'Me Myself'),
    Identity(id: 'acc/team', email: 'team@example.com', name: 'The Team'),
  ],
);

final message = EmailSummary(
  id: 'm1',
  accountId: 'acc',
  mailboxId: 'acc|INBOX',
  receivedAt: DateTime.utc(2026, 10, 5, 16),
  messageIdHeader: 'invite-1@fabrikam.example',
  references: const ['earlier@fabrikam.example'],
  from: const [EmailAddress('olivia@fabrikam.example', 'Olivia Grant')],
  to: const [EmailAddress('team@example.com')],
  subject: 'Pricing review',
);

const part = Attachment(partId: '3', mimeType: 'text/calendar');

final class MemoryRecords implements CalendarRecords {
  final map = <(String, String), String>{};

  @override
  Future<String?> readCalendarRecord(String uid, {String recurrenceId = ''}) async => map[(uid, recurrenceId)];

  @override
  Future<void> writeCalendarRecord(String uid, String? data, {String recurrenceId = ''}) async =>
      data == null ? map.remove((uid, recurrenceId)) : map[(uid, recurrenceId)] = data;
}

Future<Invitation> read(String ics, {CalendarRecords? records, Attachment p = part, EmailSummary? source}) async =>
    (await readInvitation(
      bytes: Uint8List.fromList(utf8.encode(ics)),
      part: p,
      message: source ?? message,
      own: OwnAddresses([account]),
      records: records,
    ))!;

final london = IanaZone.named('Europe/London')!;

final en = lookupAppLocalizations(const Locale('en'));

EventTimeFormat format() => EventTimeFormat(l10n: en, deviceZone: london, now: DateTime.utc(2026, 10, 4));

String plain(String s) => s.replaceAll(RegExp('[  ]'), ' ');

void main() {
  group('the part to show', () {
    test('the text/calendar alternative first, then an .ics file; not too big ones', () {
      const alternative = Attachment(partId: '1.3', mimeType: 'text/calendar', size: 3000);
      const file = Attachment(partId: '2', mimeType: 'application/ics', filename: 'invite.ics', size: 3000);
      const pdf = Attachment(partId: '3', mimeType: 'application/pdf', filename: 'a.pdf');
      EmailContent content(List<Attachment> a) => EmailContent(emailId: 'x', attachments: a);
      expect(invitationPart(content([file, alternative, pdf])), alternative);
      expect(invitationPart(content([pdf, file])), file);
      expect(invitationPart(content([pdf])), isNull);
      expect(
        invitationPart(content([const Attachment(partId: '4', mimeType: 'text/calendar', size: 5 << 20)])),
        isNull,
      );
      expect(isCalendarAlternative(alternative), isTrue);
      expect(isCalendarAlternative(file), isFalse);
    });
  });

  group('reading', () {
    test('me among the attendees, the organizer, the place and the meeting', () async {
      final inv = await read(outlookInvite());
      expect(inv.method, ItipMethod.request);
      expect(inv.me!.email, 'me@example.com');
      expect(inv.isOrganizer, isFalse);
      expect(inv.canRespond, isTrue);
      expect(inv.canAddToCalendar, isTrue);
      expect(inv.response, isNull);
      expect(inv.place!.query, 'Room 4');
      expect(inv.meetingLink!.provider, 'Teams');
      expect(inv.span!.start, DateTime.utc(2026, 10, 13, 16));
    });

    test('an update says what changed; the original is then out of date; a cancellation wins', () async {
      final records = MemoryRecords();
      final first = await read(outlookInvite(), records: records);
      expect(first.changes, isNull);
      expect(records.map.keys, [('outlook-uid-1', '')]);

      final update = await read(outlookInvite(sequence: 1, hour: 10), records: records);
      final time = update.changes!.time!;
      expect(time.$1.start, DateTime.utc(2026, 10, 13, 16));
      expect(time.$2.start, DateTime.utc(2026, 10, 13, 17));
      expect(update.outdated, isFalse);

      final again = await read(outlookInvite(), records: records);
      expect(again.outdated, isTrue);
      expect(again.canRespond, isFalse);
      // The update still says what changed when shown again.
      expect((await read(outlookInvite(sequence: 1, hour: 10), records: records)).changes, isNotNull);

      final cancel = await read(outlookInvite(sequence: 2, hour: 10, method: 'CANCEL'), records: records);
      expect(cancel.cancelled, isTrue);
      expect(cancel.canRespond, isFalse);
      expect(cancel.canAddToCalendar, isFalse);
      expect((await read(outlookInvite(sequence: 1, hour: 10), records: records)).cancelled, isTrue);
    });

    test('replies and proposals leave the records alone', () async {
      final records = MemoryRecords();
      final reply = await read(outlookInvite(method: 'REPLY'), records: records);
      expect(reply.record, isNull);
      expect(records.map, isEmpty);
      expect(reply.canRespond, isFalse);
    });

    test('an .ics file from someone else than the organizer only goes to the calendar', () async {
      const file = Attachment(partId: '2', mimeType: 'text/calendar', filename: 'invite.ics');
      final forwarded = EmailSummary(
        id: 'm2',
        accountId: 'acc',
        mailboxId: 'acc|INBOX',
        receivedAt: DateTime.utc(2026, 10, 5),
        from: const [EmailAddress('bob@example.com')],
      );
      final inv = await read(outlookInvite(), p: file, source: forwarded);
      expect(inv.canRespond, isFalse);
      expect(inv.canAddToCalendar, isTrue);
      expect((await read(outlookInvite(), p: file)).canRespond, isTrue, reason: 'from the organizer');
    });

    test('my own invitation', () async {
      final inv = await read(outlookInvite().replaceFirst('olivia@fabrikam.example', 'me@example.com'));
      expect(inv.isOrganizer, isTrue);
      expect(inv.canRespond, isFalse);
    });
  });

  group('times', () {
    test("local time with the organizer's when the offsets differ", () async {
      final inv = await read(outlookInvite());
      final w = format().when(inv.span!);
      expect(w.day, 'Tuesday, October 13');
      expect(plain(w.time!), '9:00 AM–10:00 AM Los Angeles · 5:00 PM–6:00 PM your time');
      final f24 = EventTimeFormat(l10n: en, deviceZone: london, use24h: true, now: DateTime.utc(2026, 10, 4));
      expect(f24.when(inv.span!).time, '09:00–10:00 Los Angeles · 17:00–18:00 your time');
      final there = EventTimeFormat(
        l10n: en,
        deviceZone: IanaZone.named('America/Los_Angeles'),
        use24h: true,
        now: DateTime.utc(2026, 10, 4),
      );
      expect(there.when(inv.span!).time, '09:00–10:00');
    });

    test('across midnight and on another day there', () async {
      final late = await read(outlookInvite(hour: 22).replaceAll('T230000', 'T230000'));
      final tokyo = EventTimeFormat(
        l10n: en,
        deviceZone: IanaZone.named('Asia/Tokyo'),
        use24h: true,
        now: DateTime.utc(2026),
      );
      final w = tokyo.when(late.span!);
      // 22:00 in Los Angeles is 14:00 the next day in Tokyo.
      expect(w.day, 'Wednesday, October 14');
      expect(w.time, 'Tue 22:00–23:00 Los Angeles · 14:00–15:00 your time');
    });
  });

  group('the reply', () {
    test('to the organizer, from the identity the invitation names, with the iMIP REPLY', () async {
      final inv = await read(outlookInvite(attendee: 'TEAM@example.com'));
      final reply = buildInvitationReply(
        invitation: inv,
        source: message,
        accounts: const [account],
        answer: PartStat.accepted,
        format: EventTimeFormat(l10n: en, use24h: true, now: DateTime.utc(2026, 10, 4)),
        comment: 'See you there',
        now: DateTime.utc(2026, 10, 6, 8, 30),
      );
      final m = reply.message;
      expect(reply.identity.id, 'acc/team');
      expect(m.identityId, 'acc/team');
      expect(m.to, const [EmailAddress('olivia@fabrikam.example', 'Olivia Grant')]);
      expect(m.cc, isEmpty);
      expect(m.subject, 'Accepted: Pricing review');
      expect(
        m.text,
        'The Team has accepted: Pricing review, Tuesday, October 13, 09:00–10:00 (Los Angeles)\n\nSee you there\n',
      );
      expect(m.inReplyTo, 'invite-1@fabrikam.example');
      expect(m.references, ['earlier@fabrikam.example', 'invite-1@fabrikam.example']);
      expect(m.sourceEmailId, 'm1');
      expect(m.mode, ComposeMode.reply);
      expect(m.security.isPlain, isTrue);
      expect(m.calendar!.method, 'REPLY');
      final ics = Calendar.parse(m.calendar!.data)!;
      expect(ics.method, ItipMethod.reply);
      final e = ics.primary!;
      expect(e.uid, 'outlook-uid-1');
      expect(e.attendees.single.email, 'TEAM@example.com');
      expect(e.attendees.single.partStat, PartStat.accepted);
      expect(e.comments, ['See you there']);
      expect(e.component.property('DTSTAMP')!.value, '20261006T083000Z');
    });

    test('not to be had without an organizer or an account', () async {
      final noOrganizer = await read(outlookInvite().replaceFirst(RegExp('ORGANIZER[^\r]*\r\n'), ''));
      expect(
        () => buildInvitationReply(
          invitation: noOrganizer,
          source: message,
          accounts: const [account],
          answer: PartStat.declined,
          format: format(),
        ),
        throwsA(isA<InvitationReplyException>()),
      );
      final inv = await read(outlookInvite());
      expect(
        () => buildInvitationReply(
          invitation: inv,
          source: message,
          accounts: const [],
          answer: PartStat.declined,
          format: format(),
        ),
        throwsA(isA<InvitationReplyException>()),
      );
    });

    test('an unsaved alias the invitation was sent to answers as itself', () async {
      final inv = await read(outlookInvite(attendee: 'store-17@example.com'));
      expect(inv.me, isNull, reason: 'not one of the identities');
      final aliased = EmailSummary(
        id: 'm3',
        accountId: 'acc',
        mailboxId: 'acc|INBOX',
        receivedAt: DateTime.utc(2026, 10, 5),
        from: const [EmailAddress('olivia@fabrikam.example')],
        to: const [EmailAddress('store-17@example.com')],
      );
      final from = replyIdentity(accounts: const [account], message: aliased);
      expect(from!.identity.email, 'store-17@example.com');
      final reply = buildInvitationReply(
        invitation: inv,
        source: aliased,
        accounts: const [account],
        answer: PartStat.tentative,
        format: format(),
      );
      expect(reply.message.identityId, account.aliasIdentity('store-17@example.com').id);
      expect(Calendar.parse(reply.message.calendar!.data)!.primary!.attendees.single.email, 'store-17@example.com');
    });
  });

  group('add to calendar', () {
    test('title, times, zone, place, link and recurrence', () async {
      final ics = outlookInvite().replaceFirst('SEQUENCE:0', 'SEQUENCE:0\r\nRRULE:FREQ=WEEKLY;COUNT=4;BYDAY=TU');
      final event = deviceEventFor(await read(ics), en)!;
      expect(event.title, 'Pricing review');
      expect(event.start, DateTime.utc(2026, 10, 13, 16));
      expect(event.end, DateTime.utc(2026, 10, 13, 17));
      expect(event.allDay, isFalse);
      expect(event.timeZone, 'America/Los_Angeles');
      expect(event.location, 'Room 4');
      expect(event.url.toString(), 'https://teams.microsoft.com/l/meetup-join/abc');
      expect(event.description, 'Join: https://teams.microsoft.com/l/meetup-join/abc');
      expect(event.rule!.value, 'FREQ=WEEKLY;COUNT=4;BYDAY=TU');
    });

    test('all-day events', () async {
      final ics = outlookInvite()
          .replaceFirst(RegExp('DTSTART;TZID=[^\r]*'), 'DTSTART;VALUE=DATE:20261012')
          .replaceFirst(RegExp('DTEND;TZID=[^\r]*'), 'DTEND;VALUE=DATE:20261014');
      final event = deviceEventFor(await read(ics), en)!;
      expect(event.allDay, isTrue);
      expect(event.start, DateTime(2026, 10, 12));
      expect(event.end, DateTime(2026, 10, 14));
      expect(event.timeZone, isNull);
      expect(format().when((await read(ics)).span!), (day: 'Mon, Oct 12 – Tue, Oct 13', time: 'All day'));
    });
  });
}
