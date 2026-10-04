import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:mail_model/mail_model.dart' hide TextField;
import 'package:shared_preferences/shared_preferences.dart';

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

  testWidgets('Add Account on first launch offers demo mail instead', (tester) async {
    await pumpLoupe(tester, mode: AppMode.none);
    await tester.tap(find.text('Add Account'));
    await tester.pumpAndSettle();
    expect(find.text('Real accounts are on their way'), findsOneWidget);
    await tester.tap(find.text('Try Demo Mail'));
    await tester.pumpAndSettle();
    expect(find.text('All Inboxes'), findsOneWidget);
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
    expect(find.byIcon(CupertinoIcons.square_pencil), findsOneWidget);
  });
}
