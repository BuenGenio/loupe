import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_data.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/calendar/invitation.dart';
import 'package:loupe/features/calendar/invitation_card.dart';
import 'package:loupe/features/compose/identity_selection.dart';
import 'package:mail_calendar/mail_calendar.dart';
import 'package:mail_model/mail_model.dart';

import '../helpers.dart';

Future<EmailSummary> _find(DemoMailRepository repo, String subject) async {
  // The demo is the same for the same "now": its seed has the ids.
  final seeded = DemoSeed.build(testNow).messages.firstWhere((m) => m.summary.subject == subject);
  return (await repo.getEmail(seeded.id))!;
}

Future<Invitation?> _read(DemoMailRepository repo, String subject) async {
  final message = await _find(repo, subject);
  final content = await repo.loadContent(message.id);
  final part = invitationPart(content);
  if (part == null) return null;
  return readInvitation(
    bytes: await repo.loadAttachment(message.id, part.partId),
    part: part,
    message: message,
    own: OwnAddresses(await repo.watchAccounts().first),
    records: repo,
  );
}

void main() {
  test('the demo invitations: Outlook, Google, an update, a cancellation, a reply, an all-day event', () async {
    final repo = DemoMailRepository.instant(clock: () => testNow);
    addTearDown(repo.dispose);

    final outlook = (await _read(repo, 'SOW phase 2 – pricing review'))!;
    expect(outlook.method, ItipMethod.request);
    expect(outlook.span!.zone!.ianaName, 'America/Los_Angeles');
    expect(outlook.event.start!.tzid, 'Pacific Standard Time');
    expect(outlook.meetingLink!.provider, 'Teams');
    expect(outlook.me!.email, 'sam.rivera@northwind.example');
    expect(outlook.canRespond, isTrue);
    expect(outlook.place, isNull, reason: '"Microsoft Teams Meeting" is no place');

    final google = (await _read(
      repo,
      'Invitation: Jordan / Sam 1:1 @ Every 2 weeks on Tuesday and Thursday (Sam Rivera)',
    ))!;
    expect(google.part.filename, isNull, reason: 'the alternative, not invite.ics');
    expect(google.event.isRecurring, isTrue);
    expect(google.recurrence(), startsWith('Every 2 weeks on Tuesday and Thursday until '));
    expect(google.meetingLink!.provider, 'Google Meet');
    expect(google.me!.email, 'sam.rivera@gmail.example');

    final updated = (await _read(repo, 'Updated invitation: Atlas design review'))!;
    expect(updated.changes!.time, isNotNull);
    expect(updated.changes!.time!.$2.start.difference(updated.changes!.time!.$1.start), const Duration(hours: 1));
    final original = (await _read(repo, 'Invitation: Atlas design review'))!;
    expect(original.outdated, isTrue);

    final cancelled = (await _read(repo, 'Canceled: Beacon retro follow-up'))!;
    expect(cancelled.cancelled, isTrue);
    expect(cancelled.canRespond, isFalse);

    final reply = (await _read(repo, 'Invitation Declined: Book club – November meeting'))!;
    expect(reply.method, ItipMethod.reply);
    expect(reply.isOrganizer, isTrue);
    expect(reply.event.attendees.single.partStat, PartStat.declined);
    expect(reply.event.comments.single, startsWith('Away that weekend'));

    final allDay = (await _read(repo, 'Invitation: Kestrel contributor summit'))!;
    expect(allDay.span!.allDay, isTrue);
    expect(allDay.span!.lastDay.difference(allDay.span!.start), const Duration(days: 1));
    expect(allDay.place!.geo, (38.7465, -9.1037));
  });

  testWidgets('in the app: the Outlook invitation, accepted, goes out with its calendar part', (tester) async {
    await atTestNow(() async {
      final repo = await pumpLoupe(
        tester,
        size: const Size(390, 1400),
        overrides: [invitationZoneProvider.overrideWithValue(IanaZone.named('Europe/London'))],
      );
      final message = await _find(repo, 'SOW phase 2 – pricing review');
      await goTo(tester, '/message/${message.id}');
      // The calendar part loads after the body (the demo's timers).
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('invitation-card')), findsOneWidget);
      expect(find.textContaining(RegExp(r'Los Angeles$')), findsOneWidget);
      expect(find.textContaining(RegExp(r'your time$')), findsOneWidget);
      await tester.tap(find.byKey(const Key('invitation-accept')));
      await tester.pumpAndSettle();
      final queued = (await repo.watchOutbox().first).single.message;
      expect(queued.calendar!.method, 'REPLY');
      expect(queued.to.single.email, 'olivia.grant@fabrikam.example');
      expect(queued.identityId, 'work/default');
      await tester.pump(const Duration(seconds: 12));
      await tester.pumpAndSettle();
      expect(await repo.watchOutbox().first, isEmpty);
    });
  });
}
