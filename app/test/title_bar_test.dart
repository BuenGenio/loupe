import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/router.dart';
import 'package:loupe/shared/bars.dart';
import 'package:mail_model/mail_model.dart';

import 'helpers.dart';

class _CountingRepository extends DemoMailRepository {
  _CountingRepository() : super(latency: DemoLatency.zero, clock: () => testNow);

  int refreshes = 0;

  @override
  Future<void> refresh({MailboxRef? ref}) {
    refreshes++;
    return super.refresh(ref: ref);
  }
}

Future<void> pullToRefresh(WidgetTester tester) async {
  final gesture = await tester.startGesture(const Offset(200, 300));
  for (var i = 0; i < 4; i++) {
    await gesture.moveBy(const Offset(0, 60));
    await tester.pump();
  }
  await gesture.up();
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Mailboxes: title and Edit on the top line, the search field below, content higher', (tester) async {
    await pumpLoupe(tester);
    final title = tester.getRect(find.text('Mailboxes'));
    final edit = tester.getRect(find.text('Edit'));
    final field = tester.getRect(find.byType(CupertinoSearchTextField));
    expect(title.left, 16);
    expect((title.center.dy - edit.center.dy).abs(), lessThan(2));
    expect(field.top, greaterThanOrEqualTo(title.bottom));
    expect(find.byType(CupertinoSearchTextField).hitTestable(), findsOneWidget);
    // The large-title layout put the first row's text at y = 155 on this
    // 390×844 screen.
    expect(tester.getTopLeft(find.text('All Inboxes')).dy, lessThanOrEqualTo(105));
    // Settings moved to the bottom toolbar.
    expect(
      find.descendant(of: find.byType(LoupeBottomBar), matching: find.bySemanticsLabel('Settings')),
      findsOneWidget,
    );
  });

  testWidgets('focusing the Mailboxes search field enters search; Cancel leaves it', (tester) async {
    await pumpLoupe(tester);
    await tester.tap(find.byType(CupertinoSearchTextField));
    await tester.pumpAndSettle();
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Suggestions'), findsOneWidget);
    expect(find.text('Mailboxes'), findsNothing);

    await tester.enterText(find.byType(CupertinoSearchTextField), 'lisbon');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Re: Lisbon in November?'), findsWidgets);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Cancel'), findsNothing);
    expect(find.text('Mailboxes'), findsOneWidget);
    expect(find.text('All Inboxes'), findsOneWidget);
  });

  testWidgets('a pushed list has back and a centred title, on Android too', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.list(RealMailboxRef(MailIds.mailbox('fastmail', 'Lists/Open Garden'))));
    final back = tester.getRect(find.bySemanticsLabel('Back'));
    final title = tester.getRect(find.text('Open Garden'));
    final account = tester.getRect(find.text('Fastmail'));
    final edit = tester.getRect(find.text('Edit'));
    final screen = tester.view.physicalSize / tester.view.devicePixelRatio;
    expect(title.center.dx, moreOrLessEquals(screen.width / 2, epsilon: 1));
    // The account line (colour dot and name) is centred as a whole.
    final accountLine = tester.getRect(find.ancestor(of: find.text('Fastmail'), matching: find.byType(Row)).first);
    expect(accountLine.center.dx, moreOrLessEquals(screen.width / 2, epsilon: 1));
    expect(back.right, lessThanOrEqualTo(title.left));
    expect(title.right, lessThanOrEqualTo(edit.left));
    expect(account.top, greaterThanOrEqualTo(title.bottom - 1));
    expect(account.bottom, lessThanOrEqualTo(52));
    // The search field starts hidden; rows begin right under the bar.
    expect(find.byType(CupertinoSearchTextField).hitTestable(), findsNothing);
    // The system back goes back too.
    await systemBack(tester);
    expect(find.text('All Inboxes'), findsOneWidget);
  }, variant: TargetPlatformVariant.only(TargetPlatform.android));

  testWidgets('on iOS a pushed list has back, a bold title and the account on one compact bar', (tester) async {
    await pumpLoupe(tester);
    expect(find.bySemanticsLabel('Back'), findsNothing, reason: 'the root screen has nothing to go back to');
    await goTo(tester, Routes.list(RealMailboxRef(MailIds.mailbox('fastmail', 'Lists/Open Garden'))));
    final back = tester.getRect(find.bySemanticsLabel('Back'));
    final title = tester.getRect(find.text('Open Garden'));
    final account = tester.getRect(find.text('Fastmail'));
    expect(back.right, lessThanOrEqualTo(title.left));
    expect(account.top, greaterThanOrEqualTo(title.bottom - 1));
    expect(account.bottom, lessThanOrEqualTo(52));
    await tester.tap(find.bySemanticsLabel('Back'));
    await tester.pumpAndSettle();
    expect(find.text('All Inboxes'), findsOneWidget);
  }, variant: TargetPlatformVariant.only(TargetPlatform.iOS));

  testWidgets('settings pages: back and a centred title on every platform', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.settings);
    expect(find.text('Settings'), findsWidgets);
    expect(find.bySemanticsLabel('Back'), findsOneWidget);
    final screen = tester.view.physicalSize / tester.view.devicePixelRatio;
    expect(tester.getRect(find.text('Settings').first).center.dx, moreOrLessEquals(screen.width / 2, epsilon: 1));
  }, variant: const TargetPlatformVariant({TargetPlatform.android, TargetPlatform.iOS}));

  testWidgets('pull to refresh works on Mailboxes and on a list', (tester) async {
    final repo = _CountingRepository();
    await pumpLoupe(tester, repository: repo);
    await pullToRefresh(tester);
    expect(repo.refreshes, 1);

    await goTo(tester, Routes.list(const VirtualMailboxRef(VirtualMailbox.allInboxes)));
    await tester.drag(find.byType(CustomScrollView), const Offset(0, 60));
    await tester.pumpAndSettle();
    await pullToRefresh(tester);
    expect(repo.refreshes, 2);
  });

  testWidgets('long titles are ellipsised on one line', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.search('lisbon'));
    await tester.tap(find.text('Save as Smart Mailbox'));
    await tester.pumpAndSettle();
    final name = 'A very long smart mailbox name that cannot possibly fit ' * 2;
    await tester.enterText(find.byType(CupertinoTextField).last, name);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await drainTimers(tester);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    await tester.scrollTo(find.text(name.trim()));
    await tester.tap(find.text(name.trim()));
    await tester.pumpAndSettle();
    final text = tester.widget<Text>(find.text(name.trim()));
    expect(text.maxLines, 1);
    expect(text.overflow, TextOverflow.ellipsis);
    expect(tester.getSize(find.text(name.trim())).height, lessThan(40));
    expect(tester.takeException(), isNull);
  });
}
