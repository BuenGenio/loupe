import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/openpgp/openpgp_providers.dart';
import 'package:loupe/features/openpgp/passphrase_dialog.dart';
import 'package:loupe/router.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';
import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';
import 'openpgp_test_support.dart';

Future<String> demoId(DemoMailRepository repo, bool Function(EmailSummary) test) async {
  final rows = await repo
      .watchList(const VirtualMailboxRef(VirtualMailbox.allInboxes), threaded: false, limit: 1000)
      .first;
  return rows.map((t) => t.latest).firstWhere(test).id;
}

void main() {
  group('demo mode', () {
    testWidgets('Dana’s encrypted message: protected subject, signature, decrypted attachment', (tester) async {
      final repo = await pumpLoupe(tester, overrides: [inlinePgp]);
      final id = await demoId(repo, (e) => e.sender?.email == 'dana.okafor@northwind.example' && e.subject == '...');
      await goTo(tester, Routes.message(id));

      expect(find.text('Offsite venue (confidential)'), findsOneWidget);
      expect(textContaining('Lighthouse Lodge'), findsWidgets);
      expect(textContaining('Encrypted'), findsWidgets);
      expect(textContaining('Signed by Dana Okafor ✓'), findsOneWidget);
      expect(textContaining('offsite-budget.csv'), findsOneWidget);

      await tester.tap(find.byKey(ValueKey('pgp-status-$id')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('pgp-sheet')), findsOneWidget);
      expect(find.text('Accepted and verified'), findsOneWidget);
      expect(find.text('Offsite venue (confidential)'), findsWidgets);
    });

    testWidgets('Leo’s signed message brings his key by Autocrypt; accepting it adds the ✓', (tester) async {
      final repo = await pumpLoupe(tester, overrides: [inlinePgp]);
      final id = await demoId(repo, (e) => e.subject == 'Sync phase 2 estimate');
      await goTo(tester, Routes.message(id));

      expect(textContaining('Signed by Leo Martins · key not accepted'), findsOneWidget);
      expect(textContaining('Phase 2 needs about three weeks'), findsWidgets);
      expect(textContaining('BEGIN PGP'), findsNothing);

      await tester.tap(find.byKey(ValueKey('pgp-status-$id')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('pgp-change-acceptance')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Yes, I verified the fingerprint'));
      await tester.pumpAndSettle();
      expect(find.text('Accepted and verified'), findsOneWidget);
      Navigator.of(tester.element(find.byKey(const ValueKey('pgp-sheet')))).pop();
      await tester.pumpAndSettle();
      expect(textContaining('Signed by Leo Martins ✓'), findsOneWidget);
    });
  });

  group('a passphrase-protected key', () {
    final mine = testKey('Me Myself <me@example.com>', passphrase: 'correct horse');
    final aliceKey = testKey('Alice Example <alice@example.com>');
    final raw = pgpMessage(
      from: alice,
      fromKey: aliceKey,
      to: me,
      toKey: mine,
      subject: 'The real subject',
      text: 'Only for you.',
    );

    Future<GoRouter> open(WidgetTester tester) async {
      final storage = await keychainWith(own: [mine], others: [(aliceKey, KeyAcceptance.unverified)]);
      final repo = FakeMailRepository(
        emails: [testEmail('p1', subject: '...')],
        contents: {'p1': outerContent('p1', raw)},
      )..rawSources['p1'] = raw;
      late GoRouter router;
      router = await pumpTestApp(
        tester,
        repository: repo,
        overrides: [
          inlinePgp,
          keychain(storage),
          passphrasePromptProvider.overrideWithValue(
            (key, {error}) =>
                showPassphraseDialog(router.routerDelegate.navigatorKey.currentContext!, key: key, error: error),
          ),
        ],
      );
      unawaited(router.push('/message/p1'));
      await tester.pumpAndSettle();
      return router;
    }

    Future<void> enter(WidgetTester tester, String passphrase) async {
      await tester.enterText(find.byKey(const ValueKey('passphrase-field')), passphrase);
      await tester.tap(find.byKey(const ValueKey('passphrase-unlock')));
      await tester.pumpAndSettle();
    }

    testWidgets('is asked for, a wrong passphrase is refused, the right one decrypts', (tester) async {
      await open(tester);
      expect(find.byType(PassphraseDialog), findsOneWidget);
      await enter(tester, 'wrong');
      expect(find.text('That passphrase is wrong. Try again.'), findsOneWidget);
      await enter(tester, 'correct horse');
      expect(find.byType(PassphraseDialog), findsNothing);
      expect(find.text('The real subject'), findsOneWidget);
      expect(textContaining('Only for you.'), findsWidgets);
      expect(textContaining('Signed by Alice Example ✓'), findsOneWidget);
    });

    testWidgets('cancelled: the message says it is locked and Unlock asks again', (tester) async {
      await open(tester);
      await tester.tap(find.widgetWithText(CupertinoDialogAction, 'Cancel'));
      await tester.pumpAndSettle();
      expect(textContaining('Unlock your OpenPGP key to read it'), findsWidgets);
      expect(textContaining('Encrypted · locked'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('pgp-unlock-p1')));
      await tester.pumpAndSettle();
      expect(find.byType(PassphraseDialog), findsOneWidget);
      await enter(tester, 'correct horse');
      // Unlocking finishes after the dialog closes; then the message loads again.
      await tester.pumpAndSettle();
      expect(textContaining('Only for you.'), findsWidgets);
    });
  });
}
