import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/calendar/device_calendar.dart';
import 'package:loupe/features/calendar/invitation_card.dart';
import 'package:mail_calendar/mail_calendar.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';
import 'invitation_test.dart' show london, outlookInvite;

/// The test repository, serving calendar parts and keeping records.
class CalendarRepository extends FakeMailRepository implements CalendarRecords {
  CalendarRepository({super.emails, super.contents});

  final files = <String, Uint8List>{};
  final records = <(String, String), String>{};

  @override
  Future<Uint8List> loadAttachment(String emailId, String partId) async =>
      files['$emailId/$partId'] ?? (throw const MailException(MailErrorKind.notFound, 'gone'));

  @override
  Future<String?> readCalendarRecord(String uid, {String recurrenceId = ''}) async => records[(uid, recurrenceId)];

  @override
  Future<void> writeCalendarRecord(String uid, String? data, {String recurrenceId = ''}) async =>
      data == null ? records.remove((uid, recurrenceId)) : records[(uid, recurrenceId)] = data;

  /// Adds message [id] carrying [ics] as its text/calendar alternative.
  void invite(String id, String ics, {String subject = 'Pricing review', EmailAddress? from, String body = 'Join us'}) {
    emails.add(
      EmailSummary(
        id: id,
        accountId: 'acc',
        mailboxId: 'acc|INBOX',
        threadId: id,
        messageIdHeader: '$id@fabrikam.example',
        receivedAt: DateTime(2026, 10, 4, 11),
        from: [from ?? const EmailAddress('olivia@fabrikam.example', 'Olivia Grant')],
        to: const [me],
        subject: subject,
        preview: body,
      ),
    );
    contents[id] = EmailContent(
      emailId: id,
      text: body,
      attachments: [Attachment(partId: '2', mimeType: 'text/calendar', size: ics.length)],
    );
    files['$id/2'] = Uint8List.fromList(utf8.encode(ics));
  }
}

final class FakeDeviceCalendar implements DeviceCalendar {
  final added = <DeviceEvent>[];

  @override
  Future<bool> add(DeviceEvent event) async {
    added.add(event);
    return true;
  }
}

final card = find.byKey(const Key('invitation-card'));

Finder inCard(Finder f) => find.descendant(of: card, matching: f);

Finder text(String pattern) => inCard(find.textContaining(RegExp(pattern), findRichText: true));

Future<(CalendarRepository, FakeDeviceCalendar)> open(
  WidgetTester tester,
  void Function(CalendarRepository repo) setUp, {
  String id = 'i1',
  int undoSeconds = 10,
}) async {
  tester.view
    ..physicalSize = const Size(390, 1600) * 3
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final repo = CalendarRepository();
  setUp(repo);
  final device = FakeDeviceCalendar();
  final router = await pumpTestApp(
    tester,
    repository: repo,
    prefs: {'settings.undoSendSeconds': undoSeconds},
    overrides: [invitationZoneProvider.overrideWithValue(london), deviceCalendarProvider.overrideWithValue(device)],
  );
  unawaited(router.push('/message/$id'));
  await tester.pumpAndSettle();
  return (repo, device);
}

Future<T> at<T>(Future<T> Function() body) => withClock(Clock.fixed(DateTime.utc(2026, 10, 4, 11)), body);

void main() {
  testWidgets('an invitation: what, when in both zones, where, the meeting, who, and the answers', (tester) async {
    await at(() async {
      await open(tester, (r) => r.invite('i1', outlookInvite()));
      expect(card, findsOneWidget);
      expect(inCard(find.text('Pricing review')), findsOneWidget);
      expect(text('Tuesday, October 13'), findsOneWidget);
      expect(text(r'^9:00.AM–10:00.AM Los Angeles$'), findsOneWidget);
      expect(text(r'^5:00.PM–6:00.PM your time$'), findsOneWidget);
      expect(inCard(find.text('Room 4')), findsOneWidget);
      expect(find.byKey(const Key('invitation-map')), findsOneWidget);
      expect(inCard(find.text('Teams meeting')), findsOneWidget);
      expect(inCard(find.text('teams.microsoft.com')), findsOneWidget);
      expect(find.byKey(const Key('invitation-organizer')), findsOneWidget);
      expect(text(r'^Olivia Grant · organizer$'), findsOneWidget);
      expect(text('2 guests · 1 accepted'), findsOneWidget);
      expect(find.text('Bob Builder · optional'), findsNothing);
      await tester.tap(find.byKey(const Key('invitation-attendees')));
      await tester.pumpAndSettle();
      expect(find.text('Bob Builder · optional'), findsOneWidget);
      expect(find.text('Me Myself (you)'), findsOneWidget);
      expect(find.byKey(const Key('invitation-accept')), findsOneWidget);
      expect(text('Your reply goes to Olivia Grant from me@example.com.'), findsOneWidget);
      expect(find.byKey(const Key('invitation-response')), findsNothing);
      // The calendar part isn't listed as an attachment.
      expect(find.textContaining('attachment'), findsNothing);
    });
  });

  testWidgets('Accept sends an iMIP REPLY through the Outbox; Undo takes it back', (tester) async {
    await at(() async {
      final (repo, _) = await open(tester, (r) => r.invite('i1', outlookInvite()));
      await tester.tap(find.byKey(const Key('invitation-accept')));
      await tester.pumpAndSettle();

      final sent = repo.sent.single;
      expect(sent.to.single.email, 'olivia@fabrikam.example');
      expect(sent.identityId, 'acc/me');
      expect(sent.subject, 'Accepted: Pricing review');
      expect(sent.text, startsWith('Me Myself has accepted: Pricing review'));
      expect(sent.inReplyTo, 'i1@fabrikam.example');
      expect(sent.calendar!.method, 'REPLY');
      final reply = Calendar.parse(sent.calendar!.data)!.primary!;
      expect(reply.attendees.single.email, 'me@example.com');
      expect(reply.attendees.single.partStat, PartStat.accepted);
      expect(repo.log, contains('send Accepted: Pricing review undo=10'));

      // Remembered, and shown.
      expect(repo.records[('outlook-uid-1', '')], contains('"response":"ACCEPTED"'));
      expect(find.byKey(const Key('invitation-response')), findsOneWidget);
      expect(inCard(find.text('Accepted')), findsOneWidget);
      expect(find.textContaining('sending reply to Olivia Grant'), findsOneWidget);

      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      expect(repo.cancelled, ['outbox-1']);
      expect(repo.records[('outlook-uid-1', '')], isNot(contains('response')));
      expect(find.byKey(const Key('invitation-response')), findsNothing);
      expect(find.text('Reply not sent.'), findsOneWidget);
    });
  });

  testWidgets('Decline with a comment', (tester) async {
    await at(() async {
      final (repo, _) = await open(tester, (r) => r.invite('i1', outlookInvite()));
      await tester.tap(find.byKey(const Key('invitation-add-comment')));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('invitation-comment')), 'Travelling that week, sorry');
      await tester.tap(find.byKey(const Key('invitation-decline')));
      await tester.pumpAndSettle();
      final sent = repo.sent.single;
      expect(sent.subject, 'Declined: Pricing review');
      expect(sent.text, endsWith('\n\nTravelling that week, sorry\n'));
      final reply = Calendar.parse(sent.calendar!.data)!.primary!;
      expect(reply.attendees.single.partStat, PartStat.declined);
      expect(reply.comments, ['Travelling that week, sorry']);
      expect(inCard(find.text('Declined')), findsOneWidget);
      await tester.pump(const Duration(seconds: 11));
    });
  });

  testWidgets('an update says what changed; the original is out of date', (tester) async {
    await at(() async {
      final (repo, _) = await open(tester, (r) {
        r.invite('i1', outlookInvite());
        r.invite('i2', outlookInvite(sequence: 1, hour: 10), subject: 'Updated: Pricing review');
        // The device saw the first version.
        final first = Calendar.parse(outlookInvite())!;
        r.records[('outlook-uid-1', '')] = jsonEncode(
          InvitationRecord.first(first.primary!, first.method, first.zones).toJson(),
        );
      }, id: 'i2');
      expect(find.byKey(const Key('invitation-updated')), findsOneWidget);
      // The times the device saw before, in local time.
      expect(text(r'^Time changed from 5:00.PM–6:00.PM to 6:00.PM–7:00.PM$'), findsOneWidget);
      expect(find.byKey(const Key('invitation-accept')), findsOneWidget);
      expect(repo.records[('outlook-uid-1', '')], contains('"previous"'));
    });
  });

  testWidgets('the original after its update: out of date, no answers', (tester) async {
    await at(() async {
      await open(tester, (r) {
        r.invite('i1', outlookInvite());
        final newer = Calendar.parse(outlookInvite(sequence: 1, hour: 10))!;
        r.records[('outlook-uid-1', '')] = jsonEncode(
          InvitationRecord.first(newer.primary!, newer.method, newer.zones).toJson(),
        );
      });
      expect(find.byKey(const Key('invitation-outdated')), findsOneWidget);
      expect(find.byKey(const Key('invitation-accept')), findsNothing);
    });
  });

  testWidgets('a cancellation', (tester) async {
    await at(() async {
      await open(tester, (r) => r.invite('i1', outlookInvite(sequence: 1, method: 'CANCEL')));
      expect(find.byKey(const Key('invitation-cancelled')), findsOneWidget);
      expect(text('The organizer cancelled this event.'), findsOneWidget);
      expect(find.byKey(const Key('invitation-accept')), findsNothing);
      expect(find.byKey(const Key('invitation-add-to-calendar')), findsNothing);
    });
  });

  testWidgets("an attendee's reply: who answered what, and their comment", (tester) async {
    await at(() async {
      final ics = outlookInvite(method: 'REPLY')
          .replaceFirst('olivia@fabrikam.example', 'me@example.com')
          .replaceFirst(RegExp('ATTENDEE;ROLE=REQ[^\r]*\r\n'), '')
          .replaceFirst('PARTSTAT=ACCEPTED', 'PARTSTAT=DECLINED')
          .replaceFirst('SUMMARY:', 'COMMENT:Away that week\\, sorry\r\nSUMMARY:');
      await open(
        tester,
        (r) => r.invite('i1', ics, from: const EmailAddress('bob@example.com', 'Bob Builder'), subject: 'Declined'),
      );
      expect(find.text('Bob Builder declined:'), findsOneWidget);
      expect(find.text('“Away that week, sorry”'), findsOneWidget);
      expect(find.byKey(const Key('invitation-accept')), findsNothing);
      expect(find.byKey(const Key('invitation-attendees')), findsNothing);
    });
  });

  testWidgets('all day, recurring, with the next occurrence; Add to Calendar hands it to the phone', (tester) async {
    await at(() async {
      final ics = outlookInvite()
          .replaceFirst(RegExp('DTSTART;TZID=[^\r]*'), 'DTSTART;VALUE=DATE:20260929')
          .replaceFirst(RegExp('DTEND;TZID=[^\r]*'), 'DTEND;VALUE=DATE:20260930\r\nRRULE:FREQ=WEEKLY;COUNT=6');
      final (_, device) = await open(tester, (r) => r.invite('i1', ics));
      expect(text('Tuesday, September 29'), findsOneWidget);
      expect(text('All day'), findsOneWidget);
      expect(find.byKey(const Key('invitation-recurrence')), findsOneWidget);
      expect(text('Every week on Tuesday, 6 times'), findsOneWidget);
      expect(text('Next: Tuesday, October 6'), findsOneWidget);
      await tester.tap(find.byKey(const Key('invitation-add-to-calendar')));
      await tester.pumpAndSettle();
      final added = device.added.single;
      expect((added.title, added.allDay, added.start), ('Pricing review', true, DateTime(2026, 9, 29)));
      expect(added.rule!.value, 'FREQ=WEEKLY;COUNT=6');
    });
  });

  testWidgets('a published event (Zoom): no answers, the meeting and the calendar', (tester) async {
    await at(() async {
      final ics = outlookInvite(method: 'PUBLISH')
          .replaceFirst('LOCATION:Room 4', 'LOCATION:https://us02web.zoom.us/j/81234567890')
          .replaceFirst(RegExp('X-MICROSOFT-SKYPETEAMSMEETINGURL[^\r]*\r\n'), '');
      await open(tester, (r) => r.invite('i1', ics));
      expect(card, findsOneWidget);
      expect(find.byKey(const Key('invitation-accept')), findsNothing);
      expect(find.byKey(const Key('invitation-add-comment')), findsNothing);
      expect(find.byKey(const Key('invitation-add-to-calendar')), findsOneWidget);
      expect(inCard(find.text('Zoom meeting')), findsOneWidget);
      expect(find.byKey(const Key('invitation-location')), findsNothing, reason: 'the link is the meeting row');
    });
  });

  testWidgets('a proposal for another time', (tester) async {
    await at(() async {
      await open(
        tester,
        (r) => r.invite(
          'i1',
          outlookInvite(method: 'COUNTER', hour: 11).replaceFirst(RegExp('ATTENDEE;ROLE=OPT[^\r]*\r\n'), ''),
        ),
      );
      expect(find.byKey(const Key('invitation-counter')), findsOneWidget);
      expect(text('Me Myself proposes a new time'), findsOneWidget);
      expect(find.byKey(const Key('invitation-accept')), findsNothing);
    });
  });

  testWidgets('Join shows where the link goes first', (tester) async {
    await at(() async {
      await open(tester, (r) => r.invite('i1', outlookInvite()));
      await tester.tap(find.byKey(const Key('invitation-join')));
      await tester.pumpAndSettle();
      expect(find.text('Join Teams Meeting?'), findsOneWidget);
      expect(find.text('Opens teams.microsoft.com in your browser.'), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
    });
  });

  testWidgets('a message without a calendar part, or with a broken one, shows no card', (tester) async {
    await at(() async {
      await open(tester, (r) {
        r.invite('i1', 'not a calendar');
        r.invite('i2', outlookInvite());
        r.files.remove('i2/2');
      });
      expect(card, findsNothing);
      expect(find.text('Join us'), findsWidgets);
    });
  });
}
