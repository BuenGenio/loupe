import 'package:expr_search/expr_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/router.dart';

import '../../helpers.dart';

void main() {
  testWidgets('Ask in Plain English proposes an expression you can check, then use', (tester) async {
    await pumpLoupe(tester, prefs: {'settings.aiAssist': true});
    await goTo(tester, Routes.search(''));
    await tester.enterText(find.byType(CupertinoSearchTextField), 'unread from dana with attachments');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Ask in Plain English'), findsOneWidget);

    await tester.tap(find.text('Ask in Plain English'));
    await tester.pumpAndSettle();
    expect(find.text('Proposed search'), findsOneWidget);
    // The sheet shows the canonical form of what the demo proposed.
    final canonical = formatQuery(parseQuery('is:unread from:dana has:attachment').expr);
    expect(textContaining('from:dana'), findsWidgets);
    expect(find.text('Unread'), findsOneWidget); // a chip
    expect(find.text('Translated by the built-in demo, not a model.'), findsOneWidget);

    await tester.tap(find.text('Use This Search'));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    final field = tester.widget<CupertinoSearchTextField>(find.byType(CupertinoSearchTextField));
    expect(field.controller!.text, '$canonical ');
    // Now an expression, not a sentence: the offer is gone.
    expect(find.text('Ask in Plain English'), findsNothing);
    await drainTimers(tester);
  });

  testWidgets('the offer is absent when Private AI is off, or the query is already an expression', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.search(''));
    await tester.enterText(find.byType(CupertinoSearchTextField), 'unread from dana with attachments');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Ask in Plain English'), findsNothing);
    await drainTimers(tester);
  });

  testWidgets('a typed expression is never offered for translation', (tester) async {
    await pumpLoupe(tester, prefs: {'settings.aiAssist': true});
    await goTo(tester, Routes.search(''));
    await tester.enterText(find.byType(CupertinoSearchTextField), 'from:dana is:unread photos');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Ask in Plain English'), findsNothing);
    await drainTimers(tester);
  });

  testWidgets('Settings has the switch under Private AI', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.settings);
    final row = find.byKey(const Key('ai-assist'));
    await tester.scrollUntilVisible(row, 200, scrollable: find.byType(Scrollable).first);
    expect(find.descendant(of: row, matching: find.text('Ask in Plain English')), findsOneWidget);
    expect(find.descendant(of: row, matching: find.byType(CupertinoSwitch)), findsOneWidget);
  });
}
