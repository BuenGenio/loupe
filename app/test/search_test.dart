import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/router.dart';

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
}
