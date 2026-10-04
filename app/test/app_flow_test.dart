import 'package:loupe/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/router.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loupe/theme/loupe_icons.dart';

import 'helpers.dart';

void main() {
  testWidgets('first launch shows the welcome screen; demo mail opens Mailboxes', (tester) async {
    await pumpLoupe(tester, mode: AppMode.none);
    expect(find.text('Loupe'), findsOneWidget);
    expect(find.text('Add Account'), findsOneWidget);

    await tester.tap(find.text('Try with demo mail'));
    await tester.pumpAndSettle();

    expect(find.text('Mailboxes'), findsWidgets);
    expect(find.text('All Inboxes'), findsOneWidget);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(AppModeController.key), 'demo');
  });

  testWidgets('Add Account on first launch sets up an account and switches to live mode', (tester) async {
    await pumpLoupe(tester, mode: AppMode.none);
    await tester.tap(find.text('Add Account'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('setup-name')), 'Jane Doe');
    await tester.enterText(find.byKey(const Key('setup-email')), 'jane@example.org');
    await tester.tap(find.byKey(const Key('setup-continue')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('setup-password')), 'secret');
    await tester.ensureVisible(find.byKey(const Key('setup-sign-in')));
    await tester.tap(find.byKey(const Key('setup-sign-in')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('setup-done')));
    await tester.pumpAndSettle();
    final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
    expect(container.read(appModeProvider), AppMode.live);
    expect(find.text('All Inboxes'), findsOneWidget);
  });

  testWidgets('backing out of the first account setup returns to the welcome screen', (tester) async {
    await pumpLoupe(tester, mode: AppMode.none);
    await tester.tap(find.text('Add Account'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('setup-email')), findsOneWidget);
    final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
    container.read(routerProvider).pop();
    await tester.pumpAndSettle();
    expect(container.read(appModeProvider), AppMode.none);
    expect(find.text('Try with demo mail'), findsOneWidget);
  });

  testWidgets('Mailboxes shows unified counts and every account', (tester) async {
    final repo = await pumpLoupe(tester);
    final counts = await repo.watchVirtualCounts().first;
    final inboxRow = find.ancestor(of: find.text('All Inboxes'), matching: find.byType(Row)).first;
    expect(find.descendant(of: inboxRow, matching: find.text('${counts[VirtualMailbox.allInboxes]}')), findsOneWidget);
    expect(find.text('Personal'), findsOneWidget);
    expect(textContaining('Updated'), findsOneWidget);
    await tester.scrollTo(find.text('Fastmail'));
    expect(find.text('Fastmail'), findsOneWidget);
  });

  testWidgets('opening All Inboxes lists the newest mail', (tester) async {
    await pumpLoupe(tester);
    await tester.tap(find.text('All Inboxes'));
    await tester.pumpAndSettle();
    expect(find.text('All Inboxes'), findsWidgets);
    expect(find.text('Quick question about the export API'), findsOneWidget);
    expect(find.byIcon(LoupeIcons.compose), findsOneWidget);
  });

  testWidgets('a nested folder opens with its mail', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.list(RealMailboxRef(MailIds.mailbox('fastmail', 'Lists/Open Garden'))));
    expect(find.text('Open Garden'), findsWidgets);
    expect(find.text('No Mail'), findsNothing);
    expect(textContaining('[open-garden]'), findsWidgets);
  });

  testWidgets('the VIP list shows and removes VIPs', (tester) async {
    final repo = await pumpLoupe(tester);
    await tester.tap(find.bySemanticsLabel('Manage VIPs'));
    await tester.pumpAndSettle();
    expect(find.text('Jordan Lee'), findsOneWidget);
    final row = find.ancestor(of: find.text('Jordan Lee'), matching: find.byType(Row)).first;
    await tester.tap(find.descendant(of: row, matching: find.byIcon(LoupeIcons.remove)));
    await tester.pumpAndSettle();
    expect(find.text('Jordan Lee'), findsNothing);
    expect(await repo.watchVipAddresses().first, isNot(contains('jordan.lee@example.com')));
  });
}
