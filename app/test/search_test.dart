import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/router.dart';
import 'package:mail_model/mail_model.dart';

import 'helpers.dart';

void main() {
  testWidgets('search shows local results first, then server-only hits', (tester) async {
    final repo = DemoMailRepository(
      latency: const DemoLatency(
        network: Duration.zero,
        content: Duration.zero,
        serverSearchMin: Duration(seconds: 1),
        serverSearchMax: Duration(seconds: 1),
      ),
      clock: () => testNow,
    );
    await pumpLoupe(tester, repository: repo);
    await goTo(tester, Routes.search('photos'), settle: false);

    // Local results are in; every account is still asking its server.
    expect(find.text('Photos from Sunday’s hike'), findsOneWidget);
    expect(textContaining('on the server…'), findsWidgets);
    expect(find.byIcon(CupertinoIcons.cloud), findsNothing);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(textContaining('on the server…'), findsNothing);
    expect(find.byIcon(CupertinoIcons.cloud), findsWidgets);
    await tester.scrollTo(find.text('Photos from the lake'));
    expect(find.text('Photos from the lake'), findsOneWidget);
  });

  testWidgets('typing searches after a short pause; saving makes a smart mailbox', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.search(''));
    expect(find.text('Recent Searches'), findsNothing);
    expect(find.text('Unread Messages'), findsOneWidget);

    await tester.enterText(find.byType(CupertinoSearchTextField), 'lisbon');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(textContaining('Result'), findsWidgets);
    expect(find.text('Re: Lisbon in November?'), findsWidgets);

    await tester.tap(find.text('Save as Smart Mailbox'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(textContaining('Saved “lisbon”'), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('the list search field appears on pull-down, searches this mailbox, and Back closes it', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.list(const VirtualMailboxRef(VirtualMailbox.allInboxes)));
    expect(find.byType(CupertinoSearchTextField).hitTestable(), findsNothing);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, 60));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CupertinoSearchTextField));
    await tester.pumpAndSettle();
    expect(find.text('All Mailboxes'), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.square_pencil), findsNothing);

    await tester.enterText(find.byType(CupertinoSearchTextField), 'roadmap');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('RE: Atlas Q4 roadmap review'), findsWidgets);

    final popped = await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(popped, isTrue);
    expect(find.text('All Mailboxes'), findsNothing);
    expect(find.byIcon(CupertinoIcons.square_pencil), findsOneWidget);
  });

  testWidgets('typing an operator offers completions from the search language', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.search(''));
    await tester.enterText(find.byType(CupertinoSearchTextField), 'is:unr');
    await tester.pump();
    await tester.tap(find.text('is:unreplied'));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    final field = tester.widget<CupertinoSearchTextField>(find.byType(CupertinoSearchTextField));
    expect(field.controller!.text, 'is:unreplied ');
    expect(find.text('Unreplied'), findsOneWidget);
  });
}
