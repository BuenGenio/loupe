import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

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

final class _KeyAttachmentRepository extends FakeMailRepository {
  _KeyAttachmentRepository(this.key, {super.emails, super.contents});
  final Uint8List key;

  @override
  Future<Uint8List> loadAttachment(String emailId, String partId) async => key;
}

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

    testWidgets('once opened, its protected subject shows in the list and search', (tester) async {
      final repo = await pumpLoupe(tester, overrides: [inlinePgp]);
      final id = await demoId(repo, (e) => e.sender?.email == 'dana.okafor@northwind.example' && e.subject == '...');
      expect((await repo.getEmail(id))!.isEncrypted, isTrue);
      final inbox = Routes.list(RealMailboxRef((await repo.getEmail(id))!.mailboxId));
      await goTo(tester, inbox);
      await tester.scrollTo(find.text('...'));
      expect(find.text('...'), findsOneWidget);
      await goTo(tester, Routes.message(id));
      expect(find.text('Offsite venue (confidential)'), findsOneWidget);

      final remembered = (await repo.getEmail(id))!;
      expect((remembered.subject, remembered.hasDecryptedSubject), ('Offsite venue (confidential)', true));
      await goTo(tester, inbox);
      await tester.scrollTo(find.text('Offsite venue (confidential)'));
      expect(find.text('Offsite venue (confidential)'), findsOneWidget);
      expect(find.text('...'), findsNothing);
      await goTo(tester, Routes.search('offsite'));
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

  group('signed mail with content added around it: only what the signature covers shows as signed', () {
    final mine = testKey('Me Myself <me@example.com>');
    final aliceKey = testKey('Alice Example <alice@example.com>');
    const evilHtml = 'Content-Type: text/html; charset=utf-8\r\n\r\n<p>Please pay the new account: EVIL</p>\r\n';
    const evilPdf =
        'Content-Type: application/pdf; name="invoice.pdf"\r\n'
        'Content-Disposition: attachment; filename="invoice.pdf"\r\n\r\n%PDF-1.4\r\n';
    // How a server would show such a message: every part, as if it were one.
    const serverView = EmailContent(
      emailId: 'm1',
      text: 'See you at noon.\nPlease pay the new account: EVIL',
      html: '<p>Please pay the new account: EVIL</p>',
      attachments: [
        Attachment(partId: '2', mimeType: 'application/pgp-signature', filename: 'OpenPGP_signature.asc', size: 300),
        Attachment(partId: '3', mimeType: 'application/pdf', filename: 'invoice.pdf', size: 300),
      ],
    );

    String signedByAlice({bool encrypt = false}) => pgpMessage(
      from: alice,
      fromKey: aliceKey,
      to: me,
      toKey: mine,
      subject: 'Lunch',
      text: 'See you at noon.',
      security: OutgoingSecurity(sign: true, encrypt: encrypt),
    );

    /// [raw] with [part] put before its closing delimiter.
    String withPart(String raw, String part) {
      final boundary = MimeEntity.parse(Uint8List.fromList(latin1.encode(raw))).contentType['boundary']!;
      final end = raw.lastIndexOf('--$boundary--');
      return '${raw.substring(0, end)}--$boundary\r\n$part\r\n${raw.substring(end)}';
    }

    Future<void> openWith(WidgetTester tester, String raw, {EmailContent? server}) async {
      final storage = await keychainWith(own: [mine], others: [(aliceKey, KeyAcceptance.verified)]);
      final root = MimeEntity.parse(Uint8List.fromList(latin1.encode(raw)));
      final view = server ?? serverView;
      final repo = FakeMailRepository(
        emails: [testEmail('m1', subject: 'Lunch')],
        contents: {
          'm1': EmailContent(
            emailId: 'm1',
            headers: root.headers,
            text: view.text,
            html: view.html,
            attachments: view.attachments,
          ),
        },
      )..rawSources['m1'] = raw;
      final router = await pumpTestApp(tester, repository: repo, overrides: [inlinePgp, keychain(storage)]);
      unawaited(router.push('/message/m1'));
      await tester.pumpAndSettle();
    }

    testWidgets('PGP/MIME: an HTML part and an attachment added after the signature', (tester) async {
      await openWith(tester, withPart(withPart(signedByAlice(), evilHtml), evilPdf));
      expect(textContaining('Signature invalid'), findsOneWidget);
      expect(textContaining('✓'), findsNothing);
      expect(textContaining('EVIL'), findsNothing);
      expect(textContaining('invoice.pdf'), findsNothing);
      expect(textContaining('See you at noon.'), findsWidgets);
    });

    testWidgets('PGP/MIME: a good signature, though the server splits the message otherwise', (tester) async {
      await openWith(tester, signedByAlice());
      expect(textContaining('Signed by Alice Example ✓'), findsOneWidget);
      expect(textContaining('EVIL'), findsNothing);
      expect(textContaining('invoice.pdf'), findsNothing);
      expect(textContaining('See you at noon.'), findsWidgets);
    });

    testWidgets('encrypted: a part added inside, next to the signed one, encrypted anew', (tester) async {
      // Alice's signed message, a part added, encrypted to me by anyone.
      final signed = withPart(signedByAlice(), evilHtml);
      final inner = signed.substring(signed.indexOf('Content-Type: multipart/signed'));
      final armored = pgp.encrypt(Uint8List.fromList(latin1.encode(inner)), recipients: [pgp.publicKey(mine)]);
      final raw =
          'From: alice@example.com\r\nTo: me@example.com\r\nSubject: ...\r\nMIME-Version: 1.0\r\n'
          'Content-Type: multipart/encrypted; protocol="application/pgp-encrypted"; boundary="b1"\r\n\r\n'
          '--b1\r\nContent-Type: application/pgp-encrypted\r\n\r\nVersion: 1\r\n\r\n'
          '--b1\r\nContent-Type: application/octet-stream\r\n\r\n$armored\r\n--b1--\r\n';
      await openWith(tester, raw, server: const EmailContent(emailId: 'm1'));
      expect(textContaining('Encrypted'), findsWidgets);
      expect(textContaining('Signature invalid'), findsOneWidget);
      expect(textContaining('EVIL'), findsNothing);
      expect(textContaining('See you at noon.'), findsWidgets);
    });

    testWidgets('inline: text after the signed block shows below the “Unsigned content” line', (tester) async {
      final signature = pgp.signDetached(utf8.encode('See you at noon.'), aliceKey);
      final body =
          '-----BEGIN PGP SIGNED MESSAGE-----\r\nHash: ${signature.hashAlgorithm.toUpperCase()}\r\n\r\n'
          'See you at noon.\r\n${signature.armored.replaceAll('\r\n', '\n').replaceAll('\n', '\r\n')}\r\n'
          'PS: please pay the new account: EVIL\r\n';
      final raw =
          'From: alice@example.com\r\nTo: me@example.com\r\nSubject: Lunch\r\nMIME-Version: 1.0\r\n'
          'Content-Type: text/plain; charset=utf-8\r\n\r\n$body';
      await openWith(
        tester,
        raw,
        server: EmailContent(emailId: 'm1', text: body.replaceAll('\r\n', '\n')),
      );
      expect(textContaining('Signed in part by Alice Example'), findsOneWidget);
      expect(textContaining('✓'), findsNothing);
      expect(textContaining('Unsigned content'), findsWidgets);
      final shown = tester.widgetList<Text>(find.textContaining('EVIL', findRichText: true));
      expect(shown, isNotEmpty);
      expect(textContaining('BEGIN PGP'), findsNothing);
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

    late FakeMailRepository repo;

    Future<GoRouter> open(WidgetTester tester) async {
      final storage = await keychainWith(own: [mine], others: [(aliceKey, KeyAcceptance.unverified)]);
      repo = FakeMailRepository(
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
      // Kept for the list, search and notifications.
      expect(repo.protectedSubjects, {'p1': 'The real subject'});
    });

    testWidgets('cancelled: the message says it is locked and Unlock asks again', (tester) async {
      await open(tester);
      await tester.tap(find.widgetWithText(CupertinoDialogAction, 'Cancel'));
      await tester.pumpAndSettle();
      expect(textContaining('Unlock your OpenPGP key to read it'), findsWidgets);
      expect(textContaining('Encrypted · locked'), findsOneWidget);
      expect(repo.protectedSubjects, isEmpty);

      await tester.tap(find.byKey(const ValueKey('pgp-unlock-p1')));
      await tester.pumpAndSettle();
      expect(find.byType(PassphraseDialog), findsOneWidget);
      await enter(tester, 'correct horse');
      // Unlocking finishes after the dialog closes; then the message loads again.
      await tester.pumpAndSettle();
      expect(textContaining('Only for you.'), findsWidgets);
    });
  });

  testWidgets('an attached public key can be imported from the message', (tester) async {
    final bob = testKey('Bob Builder <bob@example.org>');
    final storage = await keychainWith();
    final repo = _KeyAttachmentRepository(
      Uint8List.fromList(utf8.encode(pgp.armor(pgp.publicKey(bob)))),
      emails: [testEmail('k1', subject: 'My key')],
      contents: {
        'k1': const EmailContent(
          emailId: 'k1',
          text: 'Here is my key.',
          attachments: [
            Attachment(partId: '2', mimeType: 'application/pgp-keys', filename: 'OpenPGP_0xFBFCC82A015E7330.asc'),
          ],
        ),
      },
    );
    final router = await pumpTestApp(tester, repository: repo, overrides: [inlinePgp, keychain(storage)]);
    unawaited(router.push('/message/k1'));
    await tester.pumpAndSettle();

    expect(find.text('An OpenPGP key is attached.'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('import-attached-key')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Import and Accept'));
    await tester.pumpAndSettle();
    final keyring = Keyring(storage, prefix: 'loupe.openpgp');
    final entry = (await keyring.load()).publicEntry(bob.fingerprint)!;
    expect((entry.acceptance, entry.source), (KeyAcceptance.unverified, KeySource.attachment));
    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('a secret key in a message is imported as one’s own only after a warning', (tester) async {
    final stranger = testKey('Me Myself <me@example.com>');
    final storage = await keychainWith();
    final repo = _KeyAttachmentRepository(
      Uint8List.fromList(utf8.encode(pgp.armor(stranger))),
      emails: [testEmail('k2', subject: 'Your new key')],
      contents: {
        'k2': const EmailContent(
          emailId: 'k2',
          text: 'Use this key.',
          attachments: [Attachment(partId: '2', mimeType: 'application/pgp-keys', filename: 'key.asc')],
        ),
      },
    );
    final router = await pumpTestApp(tester, repository: repo, overrides: [inlinePgp, keychain(storage)]);
    unawaited(router.push('/message/k2'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('import-attached-key')));
    await tester.pumpAndSettle();
    expect(find.text('Import a Secret Key?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    final keyring = Keyring(storage, prefix: 'loupe.openpgp');
    expect((await keyring.load()).ownKeys, isEmpty);
  });
}
