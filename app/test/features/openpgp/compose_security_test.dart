import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loupe/features/compose/compose_args.dart';
import 'package:loupe/features/compose/compose_screen.dart';
import 'package:loupe/features/openpgp/compose_security.dart';
import 'package:loupe/features/openpgp/openpgp_providers.dart';
import 'package:loupe/features/openpgp/passphrase_dialog.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';
import 'openpgp_test_support.dart';

final toField = find.byKey(const ValueKey('recipients-To:'));
final sendButton = find.byKey(const Key('compose-send'));
final encryptToggle = find.byKey(const Key('compose-encrypt'));
final signToggle = find.byKey(const Key('compose-sign'));

bool isOn(WidgetTester tester, Finder toggle) =>
    tester.widget<Semantics>(find.descendant(of: toggle, matching: find.byType(Semantics)).first).properties.toggled ??
    false;

void main() {
  final mine = testKey('Me Myself <me@example.com>');
  final locked = testKey('Me Myself <me@example.com>', passphrase: 'pass');
  final aliceKey = testKey('Alice Example <alice@example.com>');

  Future<FakeMailRepository> open(
    WidgetTester tester, {
    PgpKey? own,
    ComposeArgs args = const ComposeArgs(to: [alice]),
  }) async {
    final storage = await keychainWith(own: [own ?? mine], others: [(aliceKey, KeyAcceptance.unverified)]);
    final repo = FakeMailRepository();
    late GoRouter router;
    router = await pumpTestApp(
      tester,
      repository: repo,
      composeBuilder: (args) => ComposeScreen(args: args),
      overrides: [
        inlinePgp,
        keychain(storage),
        passphrasePromptProvider.overrideWithValue(
          (key, {error}) =>
              showPassphraseDialog(router.routerDelegate.navigatorKey.currentContext!, key: key, error: error),
        ),
      ],
    );
    unawaited(router.push('/compose', extra: args));
    await tester.pumpAndSettle();
    return repo;
  }

  testWidgets('encryption turns on by itself when every recipient has an accepted key', (tester) async {
    await open(tester);
    expect(encryptToggle, findsOneWidget);
    expect(isOn(tester, encryptToggle), isTrue);
    expect(isOn(tester, signToggle), isTrue, reason: 'encrypted mail is signed');

    await tester.enterText(toField, 'carol@example.com,');
    await tester.pumpAndSettle();
    expect(isOn(tester, encryptToggle), isFalse, reason: 'Carol has no key');
  });

  testWidgets('a new message without recipients shows the toggles, off', (tester) async {
    await open(tester, args: const ComposeArgs());
    expect(encryptToggle, findsOneWidget);
    expect(isOn(tester, encryptToggle), isFalse);
    await tester.enterText(toField, 'alice@example.com,');
    await tester.pumpAndSettle();
    expect(isOn(tester, encryptToggle), isTrue);
  });

  testWidgets('a toggled Encrypt stays; sending asks about recipients without a key', (tester) async {
    final repo = await open(tester, args: const ComposeArgs(to: [alice, EmailAddress('carol@example.com')]));
    expect(isOn(tester, encryptToggle), isFalse);
    await tester.tap(encryptToggle);
    await tester.pumpAndSettle();
    expect(isOn(tester, encryptToggle), isTrue);
    expect(find.text('No key for carol@example.com'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('compose-subject')), 'Plans');
    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    expect(find.text('Can’t Encrypt'), findsOneWidget);
    await tester.tap(find.text('Send Unencrypted'));
    await tester.pumpAndSettle();
    expect(repo.sent.single.security, const OutgoingSecurity(sign: true));
    await tester.pump(const Duration(seconds: 11));
  });

  testWidgets('sending encrypted unlocks the key with its passphrase', (tester) async {
    final repo = await open(tester, own: locked);
    await tester.enterText(find.byKey(const Key('compose-subject')), 'Secret');
    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    expect(find.byType(PassphraseDialog), findsOneWidget);
    await tester.enterText(find.byKey(const ValueKey('passphrase-field')), 'pass');
    await tester.tap(find.byKey(const ValueKey('passphrase-unlock')));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(repo.sent.single.security, const OutgoingSecurity(encrypt: true, sign: true));
    await tester.pump(const Duration(seconds: 11));
  });

  testWidgets('cancelling the passphrase keeps the message in compose', (tester) async {
    final repo = await open(tester, own: locked);
    await tester.enterText(find.byKey(const Key('compose-subject')), 'Secret');
    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel').last);
    await tester.pumpAndSettle();
    expect(repo.sent, isEmpty);
    expect(find.byType(ComposeScreen), findsOneWidget);
  });

  testWidgets('drafts are saved encrypted to the sender, with the choices', (tester) async {
    final repo = await open(tester);
    await tester.enterText(find.byKey(const Key('compose-subject')), 'Draft');
    await tester.pump(ComposeScreen.autosaveDelay + const Duration(milliseconds: 100));
    await tester.pumpAndSettle();
    final draft = repo.drafts.last;
    expect(draft.security, const OutgoingSecurity(encrypt: true, sign: true, draft: true));
  });

  testWidgets('without a key for the sender there are no toggles', (tester) async {
    final storage = await keychainWith(others: [(aliceKey, KeyAcceptance.verified)]);
    final router = await pumpTestApp(
      tester,
      repository: FakeMailRepository(),
      composeBuilder: (args) => ComposeScreen(args: args),
      overrides: [inlinePgp, keychain(storage)],
    );
    unawaited(router.push('/compose', extra: const ComposeArgs(to: [alice])));
    await tester.pumpAndSettle();
    expect(encryptToggle, findsNothing);
  });

  group('ComposeSecurityController', () {
    late Keyring keyring;

    setUp(() async {
      keyring = Keyring(MemoryKeyringStorage());
      await keyring.load();
      await keyring.addOwnKey(secret: mine, public: pgp.publicKey(mine));
    });

    test('a reply to an encrypted message suggests encryption when the keys are there', () async {
      await keyring.addPublicKeys([pgp.publicKey(aliceKey)], source: KeySource.autocrypt);
      await keyring.putPeers([
        updatePeer(null, 'alice@example.com', DateTime.now(), fingerprint: aliceKey.fingerprint),
      ]);
      final c = ComposeSecurityController()
        ..update(state: keyring.state, from: 'me@example.com', recipients: ['alice@example.com']);
      expect((c.available, c.encrypt), (true, false), reason: 'an Autocrypt key without mutual preference');
      c.update(state: keyring.state, from: 'me@example.com', recipients: ['alice@example.com'], replyToEncrypted: true);
      expect(c.encrypt, isTrue);
    });

    test('Sign Unencrypted Mail and Attach My Public Key follow the address settings; restore wins', () async {
      await keyring.setIdentity('me@example.com', const IdentityPgp(signByDefault: true, attachPublicKey: true));
      final c = ComposeSecurityController()
        ..update(state: keyring.state, from: 'me@example.com', recipients: ['dave@example.org']);
      expect(c.value, const OutgoingSecurity(sign: true, attachPublicKey: true));
      c.toggleSign();
      expect(c.value.sign, isFalse);
      c
        ..restore(const OutgoingSecurity(encrypt: true, sign: true))
        ..update(state: keyring.state, from: 'me@example.com', recipients: ['dave@example.org']);
      expect(c.value.encrypt, isTrue, reason: 'restored choices are kept');
    });
  });
}
