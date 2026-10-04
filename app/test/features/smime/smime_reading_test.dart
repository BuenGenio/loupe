import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';
import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';
import '../openpgp/openpgp_test_support.dart';
import 'smime_test_support.dart';

void main() {
  /// Opens [file] as message m1 from [from] to Bob, with [storage] as the keychain.
  Future<FakeMailRepository> open(
    WidgetTester tester,
    String file, {
    required MemoryKeyringStorage storage,
    EmailAddress from = aliceAddress,
  }) async {
    final raw = smimeMessage(file);
    final repo = FakeMailRepository(
      emails: [
        testEmail('m1', from: from, to: const [bobAddress], subject: 'S/MIME'),
      ],
      contents: {'m1': serverContent('m1', raw)},
    )..rawSources['m1'] = raw;
    final router = await pumpTestApp(tester, repository: repo, overrides: [inlinePgp, keychain(storage)]);
    unawaited(router.push('/message/m1'));
    await tester.pumpAndSettle();
    return repo;
  }

  testWidgets('signed and encrypted (as Thunderbird sends it): decrypted, verified, the certificate collected', (
    tester,
  ) async {
    final storage = await smimeKeychain(own: [bobBundle], trusted: [testRoot]);
    await open(tester, 'signed-enveloped.eml', storage: storage);

    expect(textContaining('This message is signed with S/MIME. Grüße!'), findsWidgets);
    expect(textContaining('Encrypted (S/MIME)'), findsOneWidget);
    expect(textContaining('Signed by Alice Example ✓ (Loupe Test)'), findsOneWidget);
    expect(textContaining('smime.p7m'), findsNothing);

    final state = await smimeStateIn(storage);
    expect(state.contacts.single.certificate.displayName, 'Alice Example');
    expect(state.contacts.single.source, SmimeCertificateSource.collected);
  });

  testWidgets('opaque-signed inside encrypted (as Outlook sends it), and opaque-signed alone', (tester) async {
    final storage = await smimeKeychain(own: [bobBundle], trusted: [testRoot]);
    await open(tester, 'opaque-enveloped.eml', storage: storage);
    expect(textContaining('Grüße!'), findsWidgets);
    expect(textContaining('Signed by Alice Example ✓'), findsOneWidget);
  });

  testWidgets('signed by Bob (opaque, EC): the content comes out of the signature', (tester) async {
    final storage = await smimeKeychain(trusted: [testRoot]);
    await open(tester, 'signed-opaque.eml', storage: storage, from: bobAddress);
    expect(textContaining('Grüße!'), findsWidgets);
    expect(textContaining('Signed by Bob Example ✓ (Loupe Test)'), findsOneWidget);
    expect(textContaining('Encrypted'), findsNothing);
  });

  testWidgets('an untrusted CA: trusting it from the details adds the ✓', (tester) async {
    final storage = await smimeKeychain();
    await open(tester, 'signed-detached.eml', storage: storage);
    expect(textContaining('Signed by Alice Example · not trusted'), findsOneWidget);
    expect(textContaining('smime.p7s'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('smime-status-m1')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('smime-sheet')), findsOneWidget);
    expect(find.text('The certificate comes from an authority Loupe doesn’t trust.'), findsWidgets);
    await tester.ensureVisible(find.byKey(const ValueKey('smime-trust-issuer')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('smime-trust-issuer')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Trust'));
    await tester.pumpAndSettle();
    expect(textContaining('Signed by Alice Example ✓ (Loupe Test)'), findsOneWidget);
    expect((await smimeStateIn(storage)).authorities.single.displayName, 'Loupe Test Mail CA');
  });

  testWidgets('a modified message', (tester) async {
    final storage = await smimeKeychain(trusted: [testRoot]);
    await open(tester, 'signed-modified.eml', storage: storage);
    expect(textContaining('Signature invalid: message modified'), findsOneWidget);
  });

  testWidgets('an expired certificate', (tester) async {
    final storage = await smimeKeychain(trusted: [testRoot]);
    await open(tester, 'signed-expired.eml', storage: storage, from: const EmailAddress('carol@example.org'));
    expect(textContaining('Signed by Carol Expired · certificate expired'), findsOneWidget);
    expect((await smimeStateIn(storage)).contacts, isEmpty, reason: 'an expired certificate isn’t collected');
  });

  testWidgets('signed by someone else than the sender', (tester) async {
    final storage = await smimeKeychain(trusted: [testRoot]);
    await open(tester, 'signed-detached.eml', storage: storage, from: const EmailAddress('ceo@example.org'));
    expect(textContaining('Signed by Alice Example, not the sender'), findsOneWidget);
  });

  testWidgets('encrypted to a certificate that isn’t here', (tester) async {
    final storage = await smimeKeychain(own: [aliceBundle], trusted: [testRoot]);
    await open(tester, 'enveloped-other.eml', storage: storage);
    expect(textContaining('Encrypted (S/MIME) · no certificate'), findsOneWidget);
    expect(textContaining('not to any certificate on this device'), findsWidgets);
  });

  testWidgets('AES-GCM (AuthEnvelopedData) decrypts; the sheet names the cipher', (tester) async {
    final storage = await smimeKeychain(own: [aliceBundle], trusted: [testRoot]);
    await open(tester, 'authenveloped.eml', storage: storage);
    expect(textContaining('Grüße!'), findsWidgets);
    await tester.tap(find.byKey(const ValueKey('smime-status-m1')));
    await tester.pumpAndSettle();
    expect(textContaining('AES-256-GCM · authenticated'), findsOneWidget);
  });
}
