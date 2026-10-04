import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/router.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers.dart';

void main() {
  testWidgets('settings persist across launches', (tester) async {
    await pumpLoupe(tester);
    await tester.tap(find.bySemanticsLabel('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Accounts'.toUpperCase()), findsOneWidget);

    await tester.tap(find.text('Organize by Conversation'));
    await tester.tap(find.text('Compact'));
    await tester.pumpAndSettle();

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('settings.threaded'), isFalse);
    expect(prefs.getString('settings.density'), 'compact');

    // Launch again with what was saved.
    await pumpLoupe(tester, prefs: {for (final k in prefs.getKeys()) k: prefs.get(k)!});
    await goTo(tester, Routes.settings);
    final toggle = tester.widget<CupertinoSwitch>(
      find.descendant(
        of: find.ancestor(of: find.text('Organize by Conversation'), matching: find.byType(Row)).first,
        matching: find.byType(CupertinoSwitch),
      ),
    );
    expect(toggle.value, isFalse);
  });

  testWidgets('Reset App returns to the welcome screen', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.advancedSettings);
    await tester.tap(find.text('Reset App'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reset App').last);
    await tester.pumpAndSettle();
    expect(find.text('Try with demo mail'), findsOneWidget);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(AppModeController.key), isNull);
  });

  testWidgets('account detail edits the name and the colour', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.accountSettings('work'));
    expect(find.text('Identities'.toUpperCase()), findsOneWidget);
    await tester.enterText(find.widgetWithText(Row, 'Description').last, 'Northwind');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.tap(find.bySemanticsLabel('Colour 4'));
    await tester.pumpAndSettle();
    final account = (await repo.watchAccounts().first).firstWhere((a) => a.id == 'work');
    expect(account.colorIndex, 3);
  });
}
