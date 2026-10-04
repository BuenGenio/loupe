import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/router.dart';
import 'package:mail_model/mail_model.dart';
import 'package:loupe/theme/loupe_icons.dart';

import 'helpers.dart';

void main() {
  const allInboxes = VirtualMailboxRef(VirtualMailbox.allInboxes);

  testWidgets('a full swipe left archives the conversation and removes the row', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.list(allInboxes));
    const subject = 'Photos from Sunday’s hike';
    expect(find.text(subject), findsOneWidget);

    await tester.drag(find.text(subject), const Offset(-330, 0));
    await tester.pumpAndSettle();

    expect(find.text(subject), findsNothing);
    expect(textContaining('Archived 1 message'), findsOneWidget);
    final archived = (await repo.watchList(allInboxes, threaded: false, limit: 1000).first).where(
      (t) => t.latest.subject == subject,
    );
    expect(archived, isEmpty);
    await drainTimers(tester);
  });

  testWidgets('a short swipe reveals the actions without running them', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.list(allInboxes));
    const subject = 'Photos from Sunday’s hike';
    await tester.drag(find.text(subject), const Offset(-190, 0));
    await tester.pumpAndSettle();
    expect(find.text('More'), findsOneWidget);
    expect(find.text(subject), findsOneWidget);
  });

  testWidgets('the Filter button shows only unread mail', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.list(allInboxes));
    const read = 'RE: Statement of work – phase 2 (revised pricing)';
    const unread = 'Quick question about the export API';
    await tester.scrollTo(find.text(read));
    expect(find.text(read), findsOneWidget);

    await tester.tap(find.byIcon(LoupeIcons.filter));
    await tester.pumpAndSettle();

    expect(find.text('Filtered by:'), findsOneWidget);
    expect(find.text(read), findsNothing);
    await tester.scrollTo(find.text(unread));
    expect(find.text(unread), findsOneWidget);
    expect(find.byIcon(LoupeIcons.filterFilled), findsOneWidget);
  });

  testWidgets('edit mode selects rows and archives them', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.list(allInboxes));
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    expect(find.text('Select Messages'), findsWidgets);
    await tester.tap(find.text('Photos from Sunday’s hike'));
    await tester.pump();
    expect(find.text('1 Selected'), findsWidgets);
    await tester.tap(find.text('Archive'));
    await tester.pumpAndSettle();
    expect(find.text('Photos from Sunday’s hike'), findsNothing);
    await drainTimers(tester);
  });

  group('Undo', () {
    const subject = 'Photos from Sunday’s hike';

    Future<List<EmailSummary>> inbox(DemoMailRepository repo) async => [
      for (final t in await repo.watchList(allInboxes, threaded: false, limit: 1000).first) t.latest,
    ];

    testWidgets('after a swipe archive puts the conversation back in its inbox', (tester) async {
      final repo = await pumpLoupe(tester);
      await goTo(tester, Routes.list(allInboxes));
      final before = (await inbox(repo)).where((e) => e.subject == subject).map((e) => e.mailboxId).toList();
      await tester.drag(find.text(subject), const Offset(-330, 0));
      await tester.pumpAndSettle();
      expect(find.text(subject), findsNothing);
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      expect(find.text(subject), findsOneWidget);
      expect((await inbox(repo)).where((e) => e.subject == subject).map((e) => e.mailboxId), before);
      await drainTimers(tester);
    });

    testWidgets('after Move to Junk from the More sheet restores the inbox and the keywords', (tester) async {
      final repo = await pumpLoupe(tester);
      await goTo(tester, Routes.list(allInboxes));
      await tester.longPress(find.text(subject));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Move to Junk'));
      await tester.pumpAndSettle();
      expect(find.text(subject), findsNothing);
      expect(textContaining('to Junk'), findsOneWidget);
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      expect(find.text(subject), findsOneWidget);
      final back = (await inbox(repo)).where((e) => e.subject == subject);
      expect(back, isNotEmpty);
      for (final e in back) {
        expect(e.keywords, isNot(contains(Keywords.junk)));
        expect(e.keywords, isNot(contains(Keywords.notJunk)));
      }
      await drainTimers(tester);
    });

    testWidgets('after archiving a selection puts it back', (tester) async {
      await pumpLoupe(tester);
      await goTo(tester, Routes.list(allInboxes));
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(subject));
      await tester.pump();
      await tester.tap(find.text('Archive'));
      await tester.pumpAndSettle();
      expect(find.text(subject), findsNothing);
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      expect(find.text(subject), findsOneWidget);
      await drainTimers(tester);
    });

    testWidgets('in Trash, Delete Permanently asks first and has no Undo', (tester) async {
      final repo = await pumpLoupe(tester);
      late Mailbox trash;
      var rows = <ThreadSummary>[];
      for (final m in await repo.watchMailboxes().first) {
        if (m.role != MailboxRole.trash) continue;
        trash = m;
        rows = await repo.watchList(RealMailboxRef(m.id), threaded: false).first;
        if (rows.isNotEmpty) break;
      }
      expect(rows, isNotEmpty, reason: 'the demo has mail in a Trash');
      final victim = rows.first.latest.subject;
      await goTo(tester, Routes.list(RealMailboxRef(trash.id)));
      await tester.longPress(find.text(victim).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete Permanently'));
      await tester.pumpAndSettle();
      expect(find.text('Delete this message permanently?'), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text(victim), findsWidgets);

      await tester.longPress(find.text(victim).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete Permanently'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete Permanently'));
      await tester.pumpAndSettle();
      expect(find.text('Deleted 1 message'), findsOneWidget);
      expect(find.text('Undo'), findsNothing);
      expect(await repo.getEmail(rows.first.latest.id), isNull);
      await drainTimers(tester);
    });
  });
}
