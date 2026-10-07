import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_calendar/mail_calendar.dart';
import 'package:mail_imap/mail_imap.dart' show MimeMessageComposer;
import 'package:mail_model/mail_model.dart';

import 'demo_data.dart';

/// Calendar invitations in the demo, written as the services send them
/// (iMIP: the text, then the iCalendar object as its text/calendar
/// alternative), dated around the demo's "now":
///
/// - Outlook: a Windows time zone (Pacific Standard Time) and Teams;
/// - Google Calendar: every two weeks on Tuesday and Thursday, with Meet and
///   Google's invite.ics attached;
/// - an update that moved a design review by an hour (the device saw the
///   first version: see [DemoCalendarCases.seedCalendarRecords]);
/// - a cancellation;
/// - an attendee's reply (Wren declines Sam's book club, with a comment);
/// - an all-day, two-day summit with a place on the map.
extension DemoCalendarCases on DemoSeed {
  static const _work = DemoPeople.work;
  static const _personal = DemoPeople.personal;
  static const _fastmail = DemoPeople.fastmail;

  /// UID of the design review that the demo moves.
  static const atlasUid = 'atlas-review-2f7c1e@northwind.example';

  DateTime _day(int days, [int hour = 0, int minute = 0]) =>
      DateTime(now.year, now.month, now.day + days, hour, minute);

  /// [hour]:[minute] on [day] (wall clock, whatever daylight saving does).
  static DateTime _at(DateTime day, int hour, [int minute = 0]) => DateTime(day.year, day.month, day.day, hour, minute);

  void calendarCases() {
    _outlook();
    _google();
    _update();
    _cancellation();
    _reply();
    _allDay();
  }

  /// The record of the design review's first version, as if the device had
  /// shown it, so its update says what changed.
  Map<(String, String), String> seedCalendarRecords() {
    final first = Calendar.parse(_atlas(sequence: 0, hour: 14))!;
    final record = InvitationRecord.first(first.primary!, first.method, first.zones);
    return {(atlasUid, ''): jsonEncode(record.toJson())};
  }

  void _outlook() {
    final day = _day(6);
    const olivia = DemoPeople.olivia;
    final ics = _calendar(
      method: 'REQUEST',
      prodId: 'Microsoft Exchange Server 2010',
      timezones: _pacific,
      event: [
        'ORGANIZER;CN=${olivia.name}:mailto:${olivia.email}',
        'ATTENDEE;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=TRUE;CN=Sam Rivera:mailto:${_work.email}',
        'ATTENDEE;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=TRUE;CN=Ben Walsh:mailto:${DemoPeople.ben.email}',
        'ATTENDEE;ROLE=OPT-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE;CN="Becker, Tom":mailto:${DemoPeople.tom.email}',
        'DESCRIPTION;LANGUAGE=en-US:${escapeText(_teamsText)}',
        'UID:040000008200E00074C5B7101A82E008000000005F4A1C2B3D4E5F60100000000000000001000000A1B2C3D4E5F6',
        'SUMMARY;LANGUAGE=en-US:SOW phase 2 – pricing review',
        'DTSTART;TZID=Pacific Standard Time:${_wall(_at(day, 9))}',
        'DTEND;TZID=Pacific Standard Time:${_wall(_at(day, 10))}',
        'CLASS:PUBLIC',
        'PRIORITY:5',
        'DTSTAMP:${_utc(_day(0, 9, 10))}',
        'TRANSP:OPAQUE',
        'STATUS:CONFIRMED',
        'SEQUENCE:0',
        'LOCATION;LANGUAGE=en-US:Microsoft Teams Meeting',
        'X-MICROSOFT-CDO-BUSYSTATUS:TENTATIVE',
        'X-MICROSOFT-CDO-INTENDEDSTATUS:BUSY',
        'X-MICROSOFT-SKYPETEAMSMEETINGURL:$_teamsLink',
        'X-MICROSOFT-DONOTFORWARDMEETING:FALSE',
        'BEGIN:VALARM',
        'DESCRIPTION:REMINDER',
        'TRIGGER;RELATED=START:-PT15M',
        'ACTION:DISPLAY',
        'END:VALARM',
      ],
    );
    _invite(
      account: DemoAccounts.work,
      at: at(0, 9, 12),
      from: olivia,
      to: const [_work, DemoPeople.ben],
      cc: const [DemoPeople.tom],
      subject: 'SOW phase 2 – pricing review',
      text: 'Let’s go through the phase 2 pricing before we sign.\n\n$_teamsText',
      ics: ics,
      unread: true,
    );
  }

  void _google() {
    // The next Tuesday, at least two days out.
    var start = _day(2);
    while (start.weekday != DateTime.tuesday) {
      start = DateTime(start.year, start.month, start.day + 1);
    }
    final last = DateTime(start.year, start.month, start.day + 58);
    const jordan = DemoPeople.jordan;
    final ics = _calendar(
      method: 'REQUEST',
      prodId: '-//Google Inc//Google Calendar 70.9054//EN',
      timezones: _newYork,
      event: [
        'DTSTART;TZID=America/New_York:${_wall(_at(start, 10))}',
        'DTEND;TZID=America/New_York:${_wall(_at(start, 10, 30))}',
        'RRULE:FREQ=WEEKLY;WKST=SU;UNTIL=${_date(DateTime(last.year, last.month, last.day + 1))}T045959Z;INTERVAL=2;BYDAY=TU,TH',
        'DTSTAMP:${_utc(_day(-1, 13))}',
        'ORGANIZER;CN=${jordan.name}:mailto:${jordan.email}',
        'UID:5u1qk1b0v0s7bq3tq1g9o8r2ks@google.com',
        'ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE;CN=${jordan.name};X-NUM-GUESTS=0:mailto:${jordan.email}',
        'ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=TRUE;CN=${_personal.email};X-NUM-GUESTS=0:mailto:${_personal.email}',
        'X-GOOGLE-CONFERENCE:https://meet.google.com/abc-defg-hij',
        'CREATED:${_utc(_day(-1, 12, 58))}',
        'DESCRIPTION:${escapeText(_meetText)}',
        'LAST-MODIFIED:${_utc(_day(-1, 13))}',
        'LOCATION:',
        'SEQUENCE:0',
        'STATUS:CONFIRMED',
        'SUMMARY:Jordan / Sam 1:1',
        'TRANSP:OPAQUE',
        'BEGIN:VALARM',
        'ACTION:EMAIL',
        'DESCRIPTION:This is an event reminder',
        'SUMMARY:Alarm notification',
        'ATTENDEE:mailto:${_personal.email}',
        'TRIGGER:-P0DT0H30M0S',
        'END:VALARM',
      ],
    );
    _invite(
      account: DemoAccounts.personal,
      at: at(1, 13, 5),
      from: jordan,
      to: const [_personal],
      subject: 'Invitation: Jordan / Sam 1:1 @ Every 2 weeks on Tuesday and Thursday (Sam Rivera)',
      text: 'Jordan Lee has invited you to a fortnightly 1:1.\n\n$_meetText',
      ics: ics,
      attachInvite: true,
    );
  }

  /// The design review: first for 14:00, then moved to 15:00.
  String _atlas({required int sequence, required int hour}) {
    final day = _day(2);
    const dana = DemoPeople.dana;
    return _calendar(
      method: 'REQUEST',
      prodId: '-//Mozilla.org/NONSGML Mozilla Calendar V1.1//EN',
      timezones: _london,
      event: [
        'UID:$atlasUid',
        'SEQUENCE:$sequence',
        'DTSTAMP:${_utc(_day(-1, sequence == 0 ? 9 : 14))}',
        'SUMMARY:Atlas design review',
        'ORGANIZER;CN=${dana.name}:mailto:${dana.email}',
        'ATTENDEE;RSVP=TRUE;CN=${dana.name};PARTSTAT=ACCEPTED;ROLE=CHAIR:mailto:${dana.email}',
        'ATTENDEE;RSVP=TRUE;CN=Sam Rivera;PARTSTAT=NEEDS-ACTION;ROLE=REQ-PARTICIPANT:mailto:${_work.email}',
        'ATTENDEE;RSVP=TRUE;CN=${DemoPeople.aisha.name};PARTSTAT=ACCEPTED;ROLE=REQ-PARTICIPANT:mailto:${DemoPeople.aisha.email}',
        'ATTENDEE;RSVP=TRUE;CN=${DemoPeople.leo.name};PARTSTAT=TENTATIVE;ROLE=OPT-PARTICIPANT:mailto:${DemoPeople.leo.email}',
        'ATTENDEE;CUTYPE=ROOM;RSVP=FALSE;CN=Lighthouse;PARTSTAT=ACCEPTED;ROLE=NON-PARTICIPANT:mailto:lighthouse@rooms.northwind.example',
        'DTSTART;TZID=Europe/London:${_wall(_at(day, hour))}',
        'DTEND;TZID=Europe/London:${_wall(_at(day, hour + 1))}',
        'LOCATION:Lighthouse (3rd floor)\\, Northwind HQ',
        'DESCRIPTION:Onboarding v2: the account picker and the error copy.',
      ],
    );
  }

  void _update() {
    const dana = DemoPeople.dana;
    _invite(
      account: DemoAccounts.work,
      at: at(1, 9, 12),
      from: dana,
      to: const [_work, DemoPeople.aisha, DemoPeople.leo],
      subject: 'Invitation: Atlas design review',
      text: 'Dana Okafor has invited you to Atlas design review.\n\nOnboarding v2: the account picker and the error copy.',
      ics: _atlas(sequence: 0, hour: 14),
    );
    _invite(
      account: DemoAccounts.work,
      at: at(1, 14, 40),
      from: dana,
      to: const [_work, DemoPeople.aisha, DemoPeople.leo],
      subject: 'Updated invitation: Atlas design review',
      text: 'Dana Okafor has updated Atlas design review: it starts an hour later.',
      ics: _atlas(sequence: 1, hour: 15),
      unread: true,
    );
  }

  void _cancellation() {
    final day = _day(3);
    const hana = DemoPeople.hana;
    final ics = _calendar(
      method: 'CANCEL',
      prodId: 'Microsoft Exchange Server 2010',
      timezones: _london,
      event: [
        'ORGANIZER;CN=${hana.name}:mailto:${hana.email}',
        'ATTENDEE;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=FALSE;CN=Sam Rivera:mailto:${_work.email}',
        'ATTENDEE;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=FALSE;CN=${DemoPeople.ben.name}:mailto:${DemoPeople.ben.email}',
        'UID:040000008200E00074C5B7101A82E00800000000BEAC0A1B2C3D4E5F6000000000000000010000009F8E7D6C5B4A',
        'SUMMARY;LANGUAGE=en-US:Beacon retro follow-up',
        'DTSTART;TZID=Europe/London:${_wall(_at(day, 11))}',
        'DTEND;TZID=Europe/London:${_wall(_at(day, 11, 45))}',
        'DTSTAMP:${_utc(_day(-2, 16, 30))}',
        'STATUS:CANCELLED',
        'SEQUENCE:1',
        'LOCATION;LANGUAGE=en-US:Harbour room',
        'PRIORITY:1',
      ],
    );
    _invite(
      account: DemoAccounts.work,
      at: at(2, 16, 31),
      from: hana,
      to: const [_work, DemoPeople.ben],
      subject: 'Canceled: Beacon retro follow-up',
      text: 'We covered everything on Friday, so I’m cancelling the follow-up. Thanks all!\n\nHana',
      ics: ics,
    );
  }

  void _reply() {
    final day = _day(12);
    const wren = DemoPeople.wren;
    final ics = _calendar(
      method: 'REPLY',
      prodId: '-//Apple Inc.//iPhone 18.0//EN',
      timezones: _london,
      event: [
        'ATTENDEE;CN="${wren.name}";PARTSTAT=DECLINED:mailto:${wren.email}',
        'DTEND;TZID=Europe/London:${_wall(_at(day, 21))}',
        'DTSTAMP:${_utc(_day(-1, 12, 10))}',
        'DTSTART;TZID=Europe/London:${_wall(_at(day, 19))}',
        'ORGANIZER;CN="Sam Rivera":mailto:${_fastmail.email}',
        'SEQUENCE:0',
        'SUMMARY:Book club – November meeting',
        'UID:B00C1B2A-77E3-4C1D-9A0B-5E6F7A8B9C0D',
        'COMMENT:Away that weekend\\, sorry! Count me in for December.',
      ],
    );
    _invite(
      account: DemoAccounts.fastmail,
      at: at(1, 12, 15),
      from: wren,
      to: const [_fastmail],
      subject: 'Invitation Declined: Book club – November meeting',
      text: 'Wren Abbott has declined your invitation.\n\nAway that weekend, sorry! Count me in for December.',
      ics: ics,
    );
  }

  void _allDay() {
    final first = _day(20);
    const ines = DemoPeople.ines;
    final ics = _calendar(
      method: 'REQUEST',
      prodId: '-//Mozilla.org/NONSGML Mozilla Calendar V1.1//EN',
      timezones: const [],
      event: [
        'UID:kestrel-summit-2026@kestrel.example',
        'SEQUENCE:0',
        'DTSTAMP:${_utc(_day(-2, 18))}',
        'SUMMARY:Kestrel contributor summit',
        'ORGANIZER;CN=${ines.name}:mailto:${ines.email}',
        'ATTENDEE;RSVP=TRUE;CN=${ines.name};PARTSTAT=ACCEPTED;ROLE=CHAIR:mailto:${ines.email}',
        'ATTENDEE;RSVP=TRUE;CN=Sam Rivera;PARTSTAT=NEEDS-ACTION;ROLE=REQ-PARTICIPANT:mailto:${_fastmail.email}',
        'ATTENDEE;RSVP=TRUE;CN=${DemoPeople.oskar.name};PARTSTAT=ACCEPTED;ROLE=REQ-PARTICIPANT:mailto:${DemoPeople.oskar.email}',
        'ATTENDEE;RSVP=TRUE;CN=${DemoPeople.malik.name};PARTSTAT=TENTATIVE;ROLE=REQ-PARTICIPANT:mailto:${DemoPeople.malik.email}',
        'DTSTART;VALUE=DATE:${_date(first)}',
        'DTEND;VALUE=DATE:${_date(DateTime(first.year, first.month, first.day + 2))}',
        'LOCATION:Fábrica Braço de Prata\\, Lisbon',
        'GEO:38.7465;-9.1037',
        'DESCRIPTION:Two days of planning\\, hacking and pastéis de nata. Travel help: ask Oskar.',
        'TRANSP:TRANSPARENT',
      ],
    );
    _invite(
      account: DemoAccounts.fastmail,
      at: at(2, 18, 5),
      from: ines,
      to: const [_fastmail, DemoPeople.oskar, DemoPeople.malik],
      subject: 'Invitation: Kestrel contributor summit',
      text: 'Two days of planning, hacking and pastéis de nata in Lisbon. Hope you can make it!\n\nInês',
      ics: ics,
    );
  }

  void _invite({
    required String account,
    required DateTime at,
    required EmailAddress from,
    required List<EmailAddress> to,
    List<EmailAddress> cc = const [],
    required String subject,
    required String text,
    required String ics,
    bool attachInvite = false,
    bool unread = false,
  }) {
    final method = Calendar.parse(ics)!.method.value;
    add(
      account: account,
      box: 'INBOX',
      at: at,
      from: from,
      to: to,
      cc: cc,
      subject: subject,
      text: text,
      unread: unread,
      raw: (summary) => MimeMessageComposer().compose(
        OutgoingMessage(
          accountId: 'demo',
          identityId: 'demo',
          to: to,
          cc: cc,
          subject: subject,
          text: text,
          calendar: OutgoingCalendar(method: method, data: ics),
          attachments: [
            if (attachInvite)
              OutgoingAttachment(
                filename: 'invite.ics',
                mimeType: 'application/ics',
                data: Uint8List.fromList(utf8.encode(ics)),
              ),
          ],
        ),
        Identity(id: 'demo', email: from.email, name: from.name),
        messageId: summary.messageIdHeader ?? '${summary.id}@demo.example',
        date: summary.sentAt ?? summary.receivedAt,
      ),
    );
  }

  static String _calendar({
    required String method,
    required String prodId,
    required List<String> timezones,
    required List<String> event,
  }) {
    final lines = [
      'BEGIN:VCALENDAR',
      'METHOD:$method',
      'PRODID:$prodId',
      'VERSION:2.0',
      ...timezones,
      'BEGIN:VEVENT',
      ...event,
      'END:VEVENT',
      'END:VCALENDAR',
    ];
    return '${lines.map(foldLine).join('\r\n')}\r\n';
  }

  static String _two(int n) => n.toString().padLeft(2, '0');
  static String _date(DateTime d) => '${d.year}${_two(d.month)}${_two(d.day)}';
  static String _wall(DateTime d) => '${_date(d)}T${_two(d.hour)}${_two(d.minute)}00';
  static String _utc(DateTime d) {
    final u = d.toUtc();
    return '${_date(u)}T${_two(u.hour)}${_two(u.minute)}${_two(u.second)}Z';
  }
}

const _teamsLink =
    'https://teams.microsoft.com/l/meetup-join/19%3ameeting_ZDk4YTNk@thread.v2/0?context=%7b%22Tid%22%3a%22f0%22%7d';

const _teamsText =
    '________________________________________________________________________________\n'
    'Microsoft Teams meeting\n'
    'Join on your computer, mobile app or room device\n'
    'Click here to join the meeting<$_teamsLink>\n'
    'Meeting ID: 284 117 405 921\n'
    'Passcode: Hy7mQ2\n'
    '________________________________________________________________________________';

const _meetText =
    'Fortnightly catch-up.\n\n'
    'Join with Google Meet: https://meet.google.com/abc-defg-hij\n'
    'Or dial: (US) +1 555-0100 PIN: 123456789#\n\n'
    'Invitation from Google Calendar';

const _pacific = [
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
];

const _newYork = [
  'BEGIN:VTIMEZONE',
  'TZID:America/New_York',
  'X-LIC-LOCATION:America/New_York',
  'BEGIN:DAYLIGHT',
  'TZOFFSETFROM:-0500',
  'TZOFFSETTO:-0400',
  'TZNAME:EDT',
  'DTSTART:19700308T020000',
  'RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=2SU',
  'END:DAYLIGHT',
  'BEGIN:STANDARD',
  'TZOFFSETFROM:-0400',
  'TZOFFSETTO:-0500',
  'TZNAME:EST',
  'DTSTART:19701101T020000',
  'RRULE:FREQ=YEARLY;BYMONTH=11;BYDAY=1SU',
  'END:STANDARD',
  'END:VTIMEZONE',
];

const _london = [
  'BEGIN:VTIMEZONE',
  'TZID:Europe/London',
  'X-LIC-LOCATION:Europe/London',
  'BEGIN:DAYLIGHT',
  'TZOFFSETFROM:+0000',
  'TZOFFSETTO:+0100',
  'TZNAME:BST',
  'DTSTART:19700329T010000',
  'RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU',
  'END:DAYLIGHT',
  'BEGIN:STANDARD',
  'TZOFFSETFROM:+0100',
  'TZOFFSETTO:+0000',
  'TZNAME:GMT',
  'DTSTART:19701025T020000',
  'RRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU',
  'END:STANDARD',
  'END:VTIMEZONE',
];
