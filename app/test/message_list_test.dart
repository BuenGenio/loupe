import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/router.dart';
import 'package:mail_model/mail_model.dart';

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

    await tester.tap(find.byIcon(CupertinoIcons.line_horizontal_3_decrease_circle));
    await tester.pumpAndSettle();

    expect(find.text('Filtered by:'), findsOneWidget);
    expect(find.text(read), findsNothing);
    await tester.scrollTo(find.text(unread));
    expect(find.text(unread), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.line_horizontal_3_decrease_circle_fill), findsOneWidget);
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
}
