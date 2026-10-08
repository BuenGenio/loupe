import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/openpgp/pgp_status.dart' show PgpTone;
import 'package:loupe/features/smime/smime_status.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:mail_crypto/mail_crypto.dart';

import 'smime_test_support.dart';

void main() {
  final l10n = lookupAppLocalizations(const Locale('en'));
  final alice = aliceBundle.keys.single.certificate;
  final ca = fixtureCert('intermediate.crt');

  SmimeMessageStatus signed({
    bool valid = true,
    bool modified = false,
    Set<SmimeProblem> problems = const {},
    bool encrypted = false,
    bool withCertificate = true,
  }) => SmimeMessageStatus(
    protection: encrypted ? SmimeProtection.enveloped : SmimeProtection.signedDetached,
    encrypted: encrypted,
    cipher: encrypted ? 'AES-256-CBC' : null,
    signature: SmimeSignatureStatus(
      valid: valid,
      modified: modified,
      certificate: withCertificate ? alice : null,
      trust: withCertificate
          ? SmimeTrustCheck(chain: [alice, ca, testRoot], anchor: testRoot, problems: problems)
          : null,
    ),
  );

  test('a good signature by a trusted certificate: "Signed by Alice Example ✓ (Loupe Test)", in green', () {
    final v = SmimeStatusView.of(l10n, signed(encrypted: true));
    expect(v.encryptionLabel, 'Encrypted (S/MIME)');
    expect(v.signatureText, 'Signed by Alice Example ✓ (Loupe Test)');
    expect(v.signatureTone, PgpTone.good);
  });

  test('each problem in words, without the ✓', () {
    String? label(Set<SmimeProblem> p) => SmimeStatusView.of(l10n, signed(problems: p)).signatureText;
    expect(label({SmimeProblem.untrusted}), 'Signed by Alice Example · not trusted');
    expect(label({SmimeProblem.expired}), 'Signed by Alice Example · certificate expired');
    expect(label({SmimeProblem.wrongAddress}), 'Signed by Alice Example, not the sender');
    expect(label({SmimeProblem.wrongUsage}), 'Signed by Alice Example · certificate not for mail');
    expect(label({SmimeProblem.notYetValid}), 'Signed by Alice Example · certificate not yet valid');
    // The most serious problem wins.
    expect(label({SmimeProblem.expired, SmimeProblem.untrusted}), 'Signed by Alice Example · not trusted');
    final invalid = SmimeStatusView.of(l10n, signed(problems: {SmimeProblem.invalidChain}));
    expect(
      (invalid.signatureText, invalid.signatureTone),
      ('Signed by Alice Example · invalid certificate', PgpTone.bad),
    );
  });

  test('a modified message, a signature that can’t be checked, a missing certificate', () {
    final modified = SmimeStatusView.of(l10n, signed(valid: false, modified: true));
    expect((modified.signatureText, modified.signatureTone), ('Signature invalid: message modified', PgpTone.bad));
    expect(SmimeStatusView.of(l10n, signed(valid: false)).signatureText, 'Signature can’t be checked');
    expect(SmimeStatusView.of(l10n, signed(withCertificate: false)).signatureText, 'Signed · certificate missing');
    final weak = SmimeMessageStatus(signature: SmimeSignatureStatus(valid: false, weak: true, certificate: alice));
    expect(SmimeStatusView.of(l10n, weak).signatureText, 'Signature insecure: outdated algorithm');
    final redated = SmimeMessageStatus(
      signature: SmimeSignatureStatus(
        valid: true,
        dateMismatch: true,
        certificate: alice,
        trust: SmimeTrustCheck(chain: [alice, ca, testRoot], anchor: testRoot),
      ),
    );
    expect(SmimeStatusView.of(l10n, redated).signatureText, 'Signed by Alice Example · at another date');
  });

  test('encryption failures', () {
    String? label(SmimeDecryptFailure f) =>
        SmimeStatusView.of(l10n, SmimeMessageStatus(encrypted: true, failure: f)).encryptionLabel;
    expect(label(SmimeDecryptFailure.noKey), 'Encrypted (S/MIME) · no certificate');
    expect(label(SmimeDecryptFailure.damaged), 'Encrypted (S/MIME) · damaged');
    expect(label(SmimeDecryptFailure.unsupported), 'Encrypted (S/MIME) · unsupported');
    expect(SmimeStatusView.of(l10n, const SmimeMessageStatus(encrypted: true)).signatureLabel, isNull);
  });
}
