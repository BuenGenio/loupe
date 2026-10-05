import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/features/openpgp/decrypted_mail.dart';
import 'package:loupe/features/openpgp/key_import.dart';
import 'package:loupe/features/openpgp/openpgp_providers.dart';
import 'package:loupe/features/openpgp/passphrase_dialog.dart';
import 'package:loupe/router.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:mail_crypto/mail_crypto.dart';

import '../../helpers.dart';
import 'openpgp_test_support.dart';

Future<KeyringState> keyringOf(WidgetTester tester) async {
  final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
  return (await container.read(keyringProvider.future)).state;
}

void main() {
  testWidgets('demo: Sam’s key, Dana’s verified key and the addresses are listed', (tester) async {
    await pumpLoupe(tester, overrides: [inlinePgp]);
    await goTo(tester, Routes.settings);
    await tester.scrollTo(find.byKey(const Key('encryption-settings')));
    await tester.tap(find.byKey(const Key('encryption-settings')));
    await tester.pumpAndSettle();

    expect(find.text('End-to-End Encryption'), findsWidgets);
    expect(find.text('Sam Rivera'), findsOneWidget);
    expect(textContaining('Ed25519'), findsOneWidget);
    expect(find.text('Dana Okafor'), findsOneWidget);
    expect(textContaining('Accepted and verified'), findsOneWidget);
    expect(find.text('sam.rivera@northwind.example'), findsOneWidget);
  });

  testWidgets('On This Device: Decrypt Subjects in the Background is off until turned on', (tester) async {
    await pumpLoupe(tester, overrides: [inlinePgp]);
    await goTo(tester, Routes.encryption);
    final row = find.byKey(const ValueKey('subjects-in-background'));
    await tester.scrollTo(row);
    final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
    expect(container.read(decryptedMailSettingsProvider).subjectsInBackground, isFalse);
    await tester.tap(row);
    await tester.pumpAndSettle();
    expect(container.read(decryptedMailSettingsProvider).subjectsInBackground, isTrue);
    expect(container.read(sharedPreferencesProvider).getBool('e2ee.subjectsInBackground'), isTrue);
    expect(textContaining('keeps the subject of each message you open'), findsOneWidget);
  });

  testWidgets('generates a key for an address', (tester) async {
    await pumpLoupe(tester, overrides: [inlinePgp]);
    await goTo(tester, Routes.encryptionAddress('sam@rivera.example'));
    expect(textContaining('Add a key in End-to-End Encryption'), findsOneWidget);
    await tester.tap(find.text('Generate a Key…'));
    await tester.pumpAndSettle();
    expect(find.text('sam@rivera.example'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('generate-key')));
    await tester.pumpAndSettle();

    final state = await keyringOf(tester);
    final key = state.ownKeyFor('sam@rivera.example')!;
    expect(key.userIds.single, 'Sam Rivera <sam@rivera.example>');
    expect(key.expires, isNotNull);
    expect(key.isProtected, isFalse);
    expect(state.identity('sam@rivera.example').keyFingerprint, key.fingerprint);
    await drainTimers(tester);
  });

  testWidgets('imports a public key from the clipboard and accepts it', (tester) async {
    final bob = testKey('Bob Builder <bob@example.org>');
    await pumpLoupe(
      tester,
      overrides: [
        inlinePgp,
        pasteKeyProvider.overrideWithValue(() async => Uint8List.fromList(utf8.encode(pgp.armor(pgp.publicKey(bob))))),
      ],
    );
    await goTo(tester, Routes.encryption);
    await tester.scrollTo(find.byKey(const ValueKey('import-public-key')));
    await tester.tap(find.byKey(const ValueKey('import-public-key')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('From Clipboard'));
    await tester.pumpAndSettle();
    expect(textContaining('Import Bob Builder’s key?'), findsOneWidget);
    await tester.tap(find.text('Import and Accept'));
    await tester.pumpAndSettle();

    expect(textContaining('Imported Bob Builder’s key.'), findsOneWidget);
    expect((await keyringOf(tester)).publicEntry(bob.fingerprint)!.acceptance, KeyAcceptance.unverified);
    await drainTimers(tester);
  });

  testWidgets('imports a Thunderbird secret key backup, asking for its passphrase', (tester) async {
    final mine = testKey('Sam Rivera <sam@rivera.example>', passphrase: 'from thunderbird');
    await pumpLoupe(
      tester,
      overrides: [
        inlinePgp,
        pickKeyFileProvider.overrideWithValue(() async => Uint8List.fromList(utf8.encode(pgp.armor(mine)))),
      ],
    );
    await goTo(tester, Routes.encryption);
    await tester.tap(find.byKey(const ValueKey('add-own-key')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Import from File'));
    await tester.pumpAndSettle();

    expect(find.byType(PassphraseDialog), findsOneWidget);
    await tester.enterText(find.byKey(const ValueKey('passphrase-field')), 'from thunderbird');
    await tester.tap(find.byKey(const ValueKey('passphrase-unlock')));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    final state = await keyringOf(tester);
    expect(state.ownKey(mine.fingerprint)!.isProtected, isTrue);
    expect(state.ownKeyFor('sam@rivera.example')!.fingerprint, mine.fingerprint);
    expect(textContaining('Imported your key Sam Rivera.'), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('key details: change acceptance, share the public key, remove it', (tester) async {
    final shared = <String>[];
    await pumpLoupe(
      tester,
      overrides: [
        inlinePgp,
        keyExportProvider.overrideWithValue((name, armored) async => shared.add('$name ${armored.split('\n').first}')),
      ],
    );
    final dana = (await keyringOf(tester)).publicKeys.single.key;
    await goTo(tester, Routes.encryptionKey(dana.fingerprint));
    expect(find.text(dana.formattedFingerprint), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('key-acceptance')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Yes, without checking'));
    await tester.pumpAndSettle();
    expect((await keyringOf(tester)).publicEntry(dana.fingerprint)!.acceptance, KeyAcceptance.unverified);
    expect(find.text('Accepted'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('share-public-key')));
    await tester.pumpAndSettle();
    expect(shared, ['OpenPGP_0x${dana.keyId}.asc -----BEGIN PGP PUBLIC KEY BLOCK-----']);

    await tester.scrollTo(find.byKey(const ValueKey('delete-key')));
    await tester.tap(find.byKey(const ValueKey('delete-key')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remove Key').last);
    await tester.pumpAndSettle();
    expect((await keyringOf(tester)).publicEntry(dana.fingerprint), isNull);
  });

  testWidgets('address settings are kept per address', (tester) async {
    await pumpLoupe(tester, overrides: [inlinePgp]);
    await goTo(tester, Routes.encryptionAddress('sam.rivera@northwind.example'));
    await tester.tap(find.text('Always Encrypt'));
    await tester.pumpAndSettle();
    await tester.scrollTo(find.text('Prefer Encryption'));
    await tester.tap(find.text('Prefer Encryption'));
    await tester.pumpAndSettle();
    final settings = (await keyringOf(tester)).identity('sam.rivera@northwind.example');
    expect(settings.encryptByDefault, isTrue);
    expect(settings.preferEncrypt, isFalse, reason: 'the demo starts with it on');
  });
}
