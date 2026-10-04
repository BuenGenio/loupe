import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/router.dart';
import 'package:loupe/theme/loupe_icons.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';

Future<List<Identity>> _identities(DemoMailRepository repo, String accountId) async =>
    (await repo.watchAccounts().first).firstWhere((a) => a.id == accountId).identities;

Future<void> _type(WidgetTester tester, String key, String text) async {
  await tester.enterText(find.descendant(of: find.byKey(Key(key)), matching: find.byType(TextField)), text);
  await tester.pump();
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('account settings open the identities; the first is the default', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.accountSettings('work'));
    expect(find.text('sam.rivera@northwind.example, atlas-team@northwind.example'), findsOneWidget);
    await _tap(tester, find.byKey(const Key('account-identities')));
    expect(find.text('Identities'), findsWidgets);
    expect(find.text('Sam Rivera'), findsOneWidget);
    expect(find.text('Atlas Team'), findsOneWidget);
    expect(find.text('Default'), findsOneWidget);
  });

  testWidgets('adds an identity with every field, validating addresses and patterns', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.identities('work'));
    await _tap(tester, find.byKey(const Key('identity-add')));
    expect(find.text('New Identity'), findsOneWidget);

    // The name starts as the default identity's.
    await _tap(tester, find.byKey(const Key('identity-done')));
    expect(find.text('No Address'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await _type(tester, 'identity-email', 'sam+atlas@northwind');
    await _tap(tester, find.byKey(const Key('identity-done')));
    expect(find.text('“sam+atlas@northwind” isn’t a valid email address.'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await _type(tester, 'identity-email', 'sam+atlas@northwind.example');
    await _type(tester, 'identity-reply-to', 'nope');
    await _tap(tester, find.byKey(const Key('identity-done')));
    expect(find.text('Reply-To “nope” isn’t a valid email address.'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await _type(tester, 'identity-reply-to', 'atlas-replies@northwind.example');
    await tester.enterText(find.byKey(const Key('identity-signature')), 'Sam\nAtlas');
    await _type(tester, 'identity-bcc', 'archive@rivera.example');

    await _tap(tester, find.byKey(const Key('identity-add-pattern')));
    await tester.enterText(find.byType(EditableText).last, 'not a pattern');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    expect(find.text('Invalid Pattern'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await _tap(tester, find.byKey(const Key('identity-add-pattern')));
    await tester.enterText(find.byType(EditableText).last, '@Atlas.Northwind.example');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    await _tap(tester, find.byKey(const Key('identity-add-pattern')));
    await tester.enterText(find.byType(EditableText).last, 'sam+*@northwind.example');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    expect(find.text('*@atlas.northwind.example'), findsOneWidget);
    await _tap(tester, find.byTooltip('Remove sam+*@northwind.example'));
    expect(find.text('sam+*@northwind.example'), findsNothing);

    await _tap(tester, find.byKey(const Key('identity-done')));
    final added = (await _identities(repo, 'work')).last;
    expect(added.id, startsWith('work/'));
    expect(added.name, 'Sam Rivera');
    expect(added.email, 'sam+atlas@northwind.example');
    expect(added.replyTo, 'atlas-replies@northwind.example');
    expect(added.signature, 'Sam\nAtlas');
    expect(added.autoCc, isNull);
    expect(added.autoBcc, 'archive@rivera.example');
    expect(added.replyPatterns, ['*@atlas.northwind.example']);
    expect(find.text('sam+atlas@northwind.example'), findsOneWidget);
  });

  testWidgets('edits an identity; Back with changes asks first', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.identities('work'));
    await _tap(tester, find.text('Atlas Team'));
    await tester.enterText(find.byKey(const Key('identity-signature')), 'The Atlas team');
    await tester.pump();

    await tester.tap(find.byIcon(LoupeIcons.back));
    await tester.pumpAndSettle();
    expect(find.text('Discard Changes'), findsOneWidget);
    await tester.tap(find.text('Save Identity'));
    await tester.pumpAndSettle();
    final atlas = (await _identities(repo, 'work')).firstWhere((i) => i.id == 'work/atlas');
    expect(atlas.signature, 'The Atlas team');
    expect(atlas.email, 'atlas-team@northwind.example');

    await _tap(tester, find.text('Atlas Team'));
    await tester.enterText(find.byKey(const Key('identity-signature')), 'Thrown away');
    await tester.pump();
    await tester.tap(find.byIcon(LoupeIcons.back));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discard Changes'));
    await tester.pumpAndSettle();
    expect((await _identities(repo, 'work')).firstWhere((i) => i.id == 'work/atlas').signature, 'The Atlas team');
    expect(find.text('Default'), findsOneWidget, reason: 'back on the list');
  });

  testWidgets('deletes an identity, but never the last one', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.identities('work'));
    await _tap(tester, find.text('Atlas Team'));
    await _tap(tester, find.byKey(const Key('identity-delete')));
    expect(find.text('Delete “atlas-team@northwind.example”?'), findsOneWidget);
    await tester.tap(find.text('Delete Identity').last);
    await tester.pumpAndSettle();
    expect((await _identities(repo, 'work')).map((i) => i.id), ['work/default']);
    expect(find.text('Atlas Team'), findsNothing);
    expect(find.text('Default'), findsNothing, reason: 'nothing to tell apart');

    await _tap(tester, find.text('Sam Rivera'));
    expect(find.text('An account needs at least one identity.'), findsOneWidget);
    await _tap(tester, find.byKey(const Key('identity-delete')));
    expect(find.textContaining('Delete “'), findsNothing);
    expect(await _identities(repo, 'work'), hasLength(1));
  });

  testWidgets('dragging reorders, and the new first one is the default', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.identities('work'));
    final handle = find.bySemanticsLabel('Reorder atlas-team@northwind.example');
    final gesture = await tester.startGesture(tester.getCenter(handle));
    await tester.pump(const Duration(milliseconds: 100));
    for (var i = 0; i < 8; i++) {
      await gesture.moveBy(const Offset(0, -12));
      await tester.pump(const Duration(milliseconds: 16));
    }
    await gesture.up();
    await tester.pumpAndSettle();
    final identities = await _identities(repo, 'work');
    expect(identities.map((i) => i.id), ['work/atlas', 'work/default']);
    final account = (await repo.watchAccounts().first).firstWhere((a) => a.id == 'work');
    expect(account.defaultIdentity.email, 'atlas-team@northwind.example');
    expect(tester.getTopLeft(find.text('Atlas Team')).dy, lessThan(tester.getTopLeft(find.text('Sam Rivera')).dy));
  });
}
