import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/features/openpgp/key_import.dart';
import 'package:loupe/features/smime/smime_import.dart';
import 'package:loupe/features/smime/smime_providers.dart';
import 'package:loupe/router.dart';
import 'package:mail_crypto/mail_crypto.dart';

import '../../helpers.dart';
import '../openpgp/openpgp_test_support.dart';
import 'smime_test_support.dart';

Future<SmimeState> smimeOf(WidgetTester tester) async {
  final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
  return (await container.read(smimeKeysProvider.future)).store.state;
}

Future<StoreSmimeKeys> keysOf(WidgetTester tester) =>
    ProviderScope.containerOf(tester.element(find.byType(LoupeApp))).read(smimeKeysProvider.future);

void main() {
  final aliceCert = aliceBundle.keys.single.certificate;
  final bobCert = bobBundle.keys.single.certificate;

  Future<void> password(WidgetTester tester, String value) async {
    await tester.enterText(find.byKey(const ValueKey('smime-password-field')), value);
    await tester.tap(find.byKey(const ValueKey('smime-password-import')));
    await tester.pumpAndSettle();
  }

  testWidgets('imports a .p12: asks its password, then whether to trust the company CA', (tester) async {
    await pumpLoupe(
      tester,
      overrides: [inlinePgp, pickKeyFileProvider.overrideWithValue(() async => smimeFixture('alice.p12'))],
    );
    await goTo(tester, Routes.encryption);
    await tester.scrollTo(find.byKey(const ValueKey('smime-import-own')));
    await tester.ensureVisible(find.byKey(const ValueKey('smime-import-own')));
    await tester.pumpAndSettle();
    expect(textContaining('Import your certificate with its private key'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('smime-import-own')));
    await tester.pumpAndSettle();

    expect(find.byType(SmimePasswordDialog), findsOneWidget);
    await password(tester, 'nope');
    expect(find.text('That password is wrong. Try again.'), findsOneWidget);
    await password(tester, 'alice-pass');

    expect(find.text('Trust “Loupe Test Root CA” for Mail?'), findsOneWidget);
    await tester.tap(find.text('Trust'));
    await tester.pumpAndSettle();
    expect(textContaining('Imported your certificate Alice Example (alice@example.org).'), findsOneWidget);

    final state = await smimeOf(tester);
    expect(state.own.single.certificate, aliceCert);
    expect(state.authorities, [testRoot]);
    expect((await keysOf(tester)).smimeKey(aliceCert.fingerprint), isNotNull);
    expect(find.byKey(ValueKey('smime-own-${aliceCert.fingerprint}')), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('a .p12 carrying another root besides the one that issued it: only that one is offered', (tester) async {
    await pumpLoupe(
      tester,
      overrides: [inlinePgp, pickKeyFileProvider.overrideWithValue(() async => smimeFixture('alice-extra-ca.p12'))],
    );
    await goTo(tester, Routes.encryption);
    await tester.scrollTo(find.byKey(const ValueKey('smime-import-own')));
    await tester.ensureVisible(find.byKey(const ValueKey('smime-import-own')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('smime-import-own')));
    await tester.pumpAndSettle();
    await password(tester, 'alice-pass');

    // Declined: Alice's certificate stays untrusted, and the Evil Root CA
    // (which didn't issue it) isn't offered next.
    expect(find.text('Trust “Loupe Test Root CA” for Mail?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Trust “Evil Root CA” for Mail?'), findsNothing);
    expect(textContaining('Imported your certificate Alice Example (alice@example.org).'), findsOneWidget);
    expect((await smimeOf(tester)).authorities, isEmpty);
    await drainTimers(tester);
  });

  testWidgets('a correspondent’s certificate from the clipboard; trusting its CA from the details', (tester) async {
    final pem = '${bobCert.pem}${fixtureCert('intermediate.crt').pem}';
    await pumpLoupe(
      tester,
      overrides: [inlinePgp, pasteKeyProvider.overrideWithValue(() async => Uint8List.fromList(utf8.encode(pem)))],
    );
    await goTo(tester, Routes.encryption);
    await tester.scrollTo(find.byKey(const ValueKey('smime-import-contact')));
    await tester.ensureVisible(find.byKey(const ValueKey('smime-import-contact')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('smime-import-contact')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('From Clipboard'));
    await tester.pumpAndSettle();
    expect(textContaining('Imported Bob Example’s certificate.'), findsOneWidget);
    expect(textContaining('bob@example.net · Not trusted · Loupe Test'), findsOneWidget);

    await goTo(tester, Routes.smimeCertificate(bobCert.fingerprint));
    expect(find.text('Not trusted · Loupe Test'), findsOneWidget);
    expect(find.text('Signing, Encryption'), findsOneWidget);
    await tester.scrollTo(find.byKey(const ValueKey('smime-trust-top')));
    await tester.ensureVisible(find.byKey(const ValueKey('smime-trust-top')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('smime-trust-top')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Trust'));
    await tester.pumpAndSettle();
    expect(find.text('Trusted · Loupe Test'), findsOneWidget);
    expect((await smimeOf(tester)).authorities.single.displayName, 'Loupe Test Mail CA');
    await drainTimers(tester);
  });

  testWidgets('certificate details: share, delete one’s own', (tester) async {
    final shared = <String>[];
    await pumpLoupe(
      tester,
      overrides: [
        inlinePgp,
        certificateExportProvider.overrideWithValue((name, pem) async => shared.add('$name ${pem.split('\n').first}')),
      ],
    );
    final keys = await keysOf(tester);
    final alice = aliceBundle.keys.single;
    await keys.store.addOwn(SmimeKeyPair(alice.certificate, alice.key), chain: aliceBundle.chain);
    keys.put(alice.certificate.fingerprint, alice.key);
    await goTo(tester, Routes.smimeCertificate(aliceCert.fingerprint));
    expect(find.text('alice@example.org'), findsWidgets);

    await tester.scrollTo(find.byKey(const ValueKey('smime-share')));
    await tester.ensureVisible(find.byKey(const ValueKey('smime-share')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('smime-share')));
    await tester.pumpAndSettle();
    expect(shared, ['Alice_Example.pem -----BEGIN CERTIFICATE-----']);

    await tester.scrollTo(find.byKey(const ValueKey('smime-delete')));
    await tester.ensureVisible(find.byKey(const ValueKey('smime-delete')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('smime-delete')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete Certificate').last);
    await tester.pumpAndSettle();
    expect((await smimeOf(tester)).own, isEmpty);
    expect(keys.smimeKey(aliceCert.fingerprint), isNull);
  });

  testWidgets('address settings: the certificate, and Prefer S/MIME when there is an OpenPGP key too', (tester) async {
    await pumpLoupe(tester, overrides: [inlinePgp]);
    final keys = await keysOf(tester);
    final alice = aliceBundle.keys.single;
    await keys.store.addOwn(SmimeKeyPair(alice.certificate, alice.key), chain: aliceBundle.chain);
    await goTo(tester, Routes.encryptionAddress('alice@example.org'));
    expect(find.byKey(ValueKey('smime-use-${aliceCert.fingerprint}')), findsOneWidget);
    expect(find.text('Prefer S/MIME'), findsNothing, reason: 'no OpenPGP key for this address');
    expect(find.text('Sign Unencrypted Mail'), findsOneWidget, reason: 'the sending settings apply to S/MIME too');
    expect(find.text('Send My Key with Mail'), findsNothing, reason: 'Autocrypt is OpenPGP only');

    // Sam has an OpenPGP key in the demo: with no certificate there, S/MIME offers an import.
    await goTo(tester, Routes.encryptionAddress('sam.rivera@northwind.example'));
    await tester.scrollTo(find.byKey(const ValueKey('smime-address-import')));
    await tester.ensureVisible(find.byKey(const ValueKey('smime-address-import')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('smime-address-import')), findsOneWidget);
  });
}
