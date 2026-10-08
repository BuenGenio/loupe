import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/openpgp/key_import.dart';
import 'package:loupe/features/openpgp/openpgp_providers.dart';
import 'package:loupe/features/openpgp/pgp_status.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:loupe/theme/loupe_icons.dart';
import 'package:loupe/theme/theme.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import 'openpgp_test_support.dart';

void main() {
  final dana = pgp.publicKey(testKey('Dana Okafor <dana@example.com>'));
  final mine = testKey('Me <me@example.com>');

  KeyringState keyring(KeyAcceptance? acceptance) => KeyringState(
    ownKeys: [pgp.publicKey(mine)],
    publicKeys: [if (acceptance != null) PublicKeyEntry(key: dana, acceptance: acceptance, added: DateTime(2026))],
  );

  PgpMessageStatus signed(PgpSignatureStatus status, {String? by, bool encrypted = false}) => PgpMessageStatus(
    protection: encrypted ? PgpProtection.pgpMimeEncrypted : PgpProtection.pgpMimeSigned,
    encrypted: encrypted,
    signature: PgpSignatureCheck(status: status, issuerKeyId: dana.keyId, signerFingerprint: by),
  );

  group('PgpStatusView', () {
    test('a good signature by a verified key: "Signed by Dana Okafor ✓" in green', () {
      final v = PgpStatusView.of(
        signed(PgpSignatureStatus.good, by: dana.fingerprint, encrypted: true),
        keyring(KeyAcceptance.verified),
        sender: 'dana@example.com',
      );
      expect(
        (v.encryptionLabel, v.signatureLabel, v.check, v.signatureTone),
        ('Encrypted', 'Signed by Dana Okafor', true, PgpTone.good),
      );
    });

    test('accepted without checking: ✓, but not green', () {
      final v = PgpStatusView.of(
        signed(PgpSignatureStatus.good, by: dana.fingerprint),
        keyring(KeyAcceptance.unverified),
        sender: 'dana@example.com',
      );
      expect((v.signatureLabel, v.check, v.signatureTone), ('Signed by Dana Okafor', true, PgpTone.neutral));
      expect(v.encryptionLabel, isNull);
    });

    test('not accepted yet, rejected, another address', () {
      final undecided = PgpStatusView.of(
        signed(PgpSignatureStatus.good, by: dana.fingerprint),
        keyring(KeyAcceptance.undecided),
        sender: 'dana@example.com',
      );
      expect((undecided.signatureLabel, undecided.check), ('Signed by Dana Okafor · key not accepted', false));
      final rejected = PgpStatusView.of(
        signed(PgpSignatureStatus.good, by: dana.fingerprint),
        keyring(KeyAcceptance.rejected),
        sender: 'dana@example.com',
      );
      expect((rejected.signatureLabel, rejected.signatureTone), ('Signed with a rejected key', PgpTone.bad));
      final other = PgpStatusView.of(
        signed(PgpSignatureStatus.good, by: dana.fingerprint),
        keyring(KeyAcceptance.verified),
        sender: 'ceo@example.com',
      );
      expect(
        (other.signatureLabel, other.mismatch, other.check),
        ('Signed by Dana Okafor, not the sender', true, false),
      );
    });

    test('inline PGP with text around it is signed and encrypted only in part', () {
      final status = PgpMessageStatus(
        protection: PgpProtection.inlineEncrypted,
        encrypted: true,
        partial: true,
        signature: PgpSignatureCheck(
          status: PgpSignatureStatus.good,
          issuerKeyId: dana.keyId,
          signerFingerprint: dana.fingerprint,
        ),
      );
      final v = PgpStatusView.of(status, keyring(KeyAcceptance.verified), sender: 'dana@example.com');
      expect(
        (v.encryptionLabel, v.signatureLabel, v.check),
        ('Encrypted in part', 'Signed in part by Dana Okafor', false),
      );
    });

    test('"Signature invalid" and "Unknown key"', () {
      final bad = PgpStatusView.of(
        signed(PgpSignatureStatus.bad, by: dana.fingerprint),
        keyring(KeyAcceptance.verified),
      );
      expect((bad.signatureLabel, bad.signatureTone), ('Signature invalid', PgpTone.bad));
      final unknown = PgpStatusView.of(signed(PgpSignatureStatus.unknownKey), keyring(null));
      expect((unknown.signatureLabel, unknown.signatureTone), ('Unknown key', PgpTone.caution));
    });

    test('encrypted but not decrypted says why', () {
      const status = PgpMessageStatus(
        protection: PgpProtection.pgpMimeEncrypted,
        encrypted: true,
        failure: PgpDecryptFailure.noSecretKey,
      );
      expect(PgpStatusView.of(status, keyring(null)).encryptionLabel, 'Encrypted · no key');
    });
  });

  testWidgets('the sheet explains an invalid signature and shows the fingerprint', (tester) async {
    final view = PgpStatusView.of(
      signed(PgpSignatureStatus.bad, by: dana.fingerprint, encrypted: true),
      keyring(KeyAcceptance.verified),
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [keyringStateProvider.overrideWith((ref) => Stream.value(keyring(KeyAcceptance.verified)))],
        child: MaterialApp(
          localizationsDelegates: loupeLocalizationsDelegates,
          theme: LoupeTheme.light(),
          home: Scaffold(body: PgpStatusSheet(view: view)),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Signature invalid'), findsOneWidget);
    expect(find.textContaining('the message may have been changed'), findsOneWidget);
    expect(find.text(dana.formattedFingerprint), findsOneWidget);
    expect(find.byIcon(LoupeIcons.signatureInvalid), findsOneWidget);
    expect(find.text('Accepted and verified'), findsOneWidget);
  });

  test('attached keys: pgp-keys parts and key files, not signatures or encrypted parts', () {
    Attachment a(String type, String name) => Attachment(partId: '2', mimeType: type, filename: name, size: 3000);
    expect(PgpKeyAttachments.isKey(a('application/pgp-keys', 'OpenPGP_0x1234.asc')), isTrue);
    expect(PgpKeyAttachments.isKey(a('application/octet-stream', 'Sam Rivera (0x1234) – Secret.asc')), isTrue);
    expect(PgpKeyAttachments.isKey(a('text/plain', 'bob.key')), isTrue);
    expect(PgpKeyAttachments.isKey(a('application/pgp-signature', 'OpenPGP_signature.asc')), isFalse);
    expect(PgpKeyAttachments.isKey(a('application/octet-stream', 'signature.asc')), isFalse);
    expect(PgpKeyAttachments.isKey(a('application/octet-stream', 'encrypted.asc')), isFalse);
    expect(PgpKeyAttachments.isKey(a('application/pdf', 'report.pdf')), isFalse);
  });
}
