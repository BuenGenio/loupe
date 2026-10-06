import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/router.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers.dart';

String _id(String path) => MailIds.mailbox('fastmail', path);

/// The Fastmail section of the Mailboxes screen, with Lists and Old Mail
/// expanded (the demo's unsubscribed folders are Lists/Retired and Old Mail;
/// Old Mail/Taxes is subscribed).
Map<String, Object> _prefs({bool showAll = false}) => {
  'mailboxes.expandedFolders': [_id('Lists'), _id('Old Mail')],
  if (showAll) 'mailboxes.showAllFolders': ['fastmail'],
};

/// Scrolls [finder] to the middle of its list, clear of the bars.
Future<void> _reveal(WidgetTester tester, Finder finder) async {
  await tester.scrollTo(finder);
  await Scrollable.ensureVisible(tester.element(finder), alignment: 0.5);
  await tester.pumpAndSettle();
}

CupertinoSwitch _switchIn(WidgetTester tester, String title) => tester.widget<CupertinoSwitch>(
  find.descendant(
    of: find.ancestor(of: find.text(title), matching: find.byType(Row)).first,
    matching: find.byType(CupertinoSwitch),
  ),
);

void main() {
  testWidgets('Mailboxes shows subscribed folders; their unsubscribed parents are containers', (tester) async {
    await pumpLoupe(tester, prefs: _prefs());
    await _reveal(tester, find.text('Taxes'));
    expect(find.text('Open Garden'), findsOneWidget);
    expect(find.text('Retired'), findsNothing);
    expect(find.text('Old Mail'), findsOneWidget);

    // A container opens and closes instead of opening a list.
    await tester.tap(find.text('Old Mail'));
    await tester.pumpAndSettle();
    expect(find.text('Taxes'), findsNothing);
    expect(find.text('Mailboxes'), findsOneWidget);
  });

  testWidgets('Show All Folders lists unsubscribed folders too', (tester) async {
    await pumpLoupe(tester, prefs: _prefs(showAll: true));
    await _reveal(tester, find.text('Taxes'));
    expect(find.text('Retired'), findsOneWidget);
    await tester.tap(find.text('Old Mail'));
    await tester.pumpAndSettle();
    expect(find.text('Old Mail'), findsWidgets, reason: 'the folder’s list is open');
    expect(find.text('Mailboxes'), findsNothing);
  });

  testWidgets('account settings: Show All Folders is a per-account switch, off by default', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.accountSettings('fastmail'));
    await _reveal(tester, find.text('Show All Folders'));
    expect(_switchIn(tester, 'Show All Folders').value, isFalse);
    await tester.tap(find.text('Show All Folders'));
    await tester.pumpAndSettle();
    expect(_switchIn(tester, 'Show All Folders').value, isTrue);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getStringList('mailboxes.showAllFolders'), ['fastmail']);
  });

  testWidgets('Manage Folders lists every folder and subscribes to one', (tester) async {
    final repo = await pumpLoupe(tester, prefs: _prefs());
    await goTo(tester, Routes.accountSettings('fastmail'));
    await _reveal(tester, find.text('Manage Folders'));
    await tester.tap(find.text('Manage Folders'));
    await tester.pumpAndSettle();

    expect(find.text('Manage Folders'), findsOneWidget);
    // Role mailboxes always show; they have no switch.
    final inboxRow = find.ancestor(of: find.text('Inbox'), matching: find.byType(Row)).first;
    expect(find.descendant(of: inboxRow, matching: find.text('Always Shown')), findsOneWidget);
    expect(find.descendant(of: inboxRow, matching: find.byType(CupertinoSwitch)), findsNothing);

    await _reveal(tester, find.text('Retired'));
    expect(_switchIn(tester, 'Retired').value, isFalse);
    expect(_switchIn(tester, 'Open Garden').value, isTrue);
    await tester.tap(find.bySemanticsLabel('Subscribe to Retired'));
    await tester.pumpAndSettle();
    expect(_switchIn(tester, 'Retired').value, isTrue);
    final boxes = await repo.watchMailboxes(accountId: 'fastmail').first;
    expect(boxes.firstWhere((m) => m.path == 'Lists/Retired').isSubscribed, isTrue);

    // Back on the Mailboxes screen, the folder is there.
    for (var i = 0; i < 2; i++) {
      await systemBack(tester);
    }
    await _reveal(tester, find.text('Retired'));
    expect(find.text('Retired'), findsOneWidget);
  });
}
