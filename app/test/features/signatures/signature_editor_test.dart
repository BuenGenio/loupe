import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' show QuillEditor;
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/router.dart';

import '../../helpers.dart';

Future<void> _tap(WidgetTester tester, Finder finder) async {
  if (finder.evaluate().isEmpty) await tester.scrollTo(finder);
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the identity lists its signatures with their rules; a new one gets signature.cc rules', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.identities('work'));
    await _tap(tester, find.text('Sam Rivera'));
    await tester.scrollTo(find.byKey(const Key('identity-add-signature')));
    expect(find.text('Work'), findsOneWidget);
    expect(find.text('Default'), findsOneWidget);
    expect(find.text('Copied'), findsOneWidget);
    expect(find.text('When someone is copied'), findsOneWidget);

    await _tap(tester, find.byKey(const Key('identity-add-signature')));
    expect(find.text('New Signature'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('signature-name')), 'Client');
    tester.widget<QuillEditor>(find.byType(QuillEditor)).controller.replaceText(0, 0, 'Sam for Client Co', null);
    await tester.pump();
    await _tap(tester, find.byKey(const Key('signature-when-copied')));
    await _tap(tester, find.byKey(const Key('signature-add-copied')));
    await tester.enterText(find.byType(EditableText).last, 'Client.Example');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    expect(find.text('client.example'), findsOneWidget);
    await _tap(tester, find.byKey(const Key('signature-scheduled')));
    expect(find.byKey(const Key('signature-starts')), findsOneWidget);
    await _tap(tester, find.byKey(const Key('signature-rotation')));
    await _tap(tester, find.byKey(const Key('signature-done')));

    expect(find.text('Client'), findsOneWidget);
    expect(textContaining('When copying client.example'), findsOneWidget);
    expect(textContaining('In rotation'), findsOneWidget);
    await _tap(tester, find.byKey(const Key('identity-done')));
    final identity = (await repo.watchAccounts().first)
        .firstWhere((a) => a.id == 'work')
        .identities
        .firstWhere((i) => i.id == 'work/default');
    final added = identity.signatures.last;
    expect(added.name, 'Client');
    expect(added.plainText, 'Sam for Client Co');
    expect(added.rule.copied, ['client.example']);
    expect(added.rule.isScheduled, isTrue);
    expect(added.rule.rotate, isTrue);
  });

  testWidgets('Make Default moves a signature first, without its rules', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.identities('work'));
    await _tap(tester, find.text('Sam Rivera'));
    await _tap(tester, find.text('Copied'));
    await _tap(tester, find.byKey(const Key('signature-make-default')));
    await _tap(tester, find.byKey(const Key('identity-done')));
    final signatures = (await repo.watchAccounts().first).firstWhere((a) => a.id == 'work').identities.first.signatures;
    expect([for (final s in signatures) s.id], ['work/copied', 'work/sig']);
    expect(signatures.first.rule.isAlways, isTrue);
  });
}
