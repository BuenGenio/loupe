import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/conversation/changes/comparison_content.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

const _plain = EmailContent(emailId: 'plain', text: 'Please send the bank statement.');
const _inline = EmailContent(
  emailId: 'inline',
  text: '-----BEGIN PGP MESSAGE-----\nEncrypted body\n-----END PGP MESSAGE-----',
);
const _pgpEnvelope = EmailContent(
  emailId: 'pgp-envelope',
  headers: [('Content-Type', 'multipart/encrypted; protocol="application/pgp-encrypted"; boundary="message"')],
);
const _smimeEnvelope = EmailContent(
  emailId: 'smime-envelope',
  headers: [('Content-Type', 'application/pkcs7-mime; smime-type=enveloped-data; name=smime.p7m')],
);

void main() {
  group('comparison content without crypto outcomes', () {
    test('allows plain mail and detached signed content', () {
      expect(comparisonContentAvailable(_plain, summaryEncrypted: false), isTrue);
      for (final protocol in ['application/pgp-signature', 'application/pkcs7-signature']) {
        final signed = EmailContent(
          emailId: 'signed',
          text: 'Signed message text',
          headers: [('Content-Type', 'multipart/signed; protocol="$protocol"; boundary="signature"')],
        );
        expect(comparisonContentAvailable(signed, summaryEncrypted: false), isTrue);
      }
      const inlineSigned = EmailContent(
        emailId: 'signed',
        text: '-----BEGIN PGP SIGNED MESSAGE-----\nHash: SHA256\n\nSigned content',
      );
      expect(comparisonContentAvailable(inlineSigned, summaryEncrypted: false), isTrue);
    });

    test('rejects raw inline ciphertext even when its summary missed encryption', () {
      expect(comparisonContentAvailable(_inline, summaryEncrypted: false), isFalse);
    });

    test('rejects raw PGP/MIME when loading returned no decrypt outcome', () {
      expect(comparisonContentAvailable(_pgpEnvelope, summaryEncrypted: false), isFalse);
    });

    test('rejects both S/MIME encrypted envelope forms and legacy p7m detection', () {
      expect(comparisonContentAvailable(_smimeEnvelope, summaryEncrypted: false), isFalse);
      const authenticated = EmailContent(
        emailId: 'authenticated',
        headers: [('Content-Type', 'application/pkcs7-mime; smime-type=authEnveloped-data')],
      );
      expect(comparisonContentAvailable(authenticated, summaryEncrypted: false), isFalse);
      const legacy = EmailContent(
        emailId: 'legacy',
        headers: [('Content-Type', 'application/x-pkcs7-mime; name=smime.p7m')],
      );
      expect(comparisonContentAvailable(legacy, summaryEncrypted: false), isFalse);
    });

    test('uses summary encryption as a fallback when envelope metadata is absent', () {
      expect(comparisonContentAvailable(_plain, summaryEncrypted: true), isFalse);
    });

    test('does not mistake quoted ciphertext markers for an encrypted body', () {
      const quoted = EmailContent(
        emailId: 'quoted',
        text: 'This is the marker in your instructions:\n> -----BEGIN PGP MESSAGE-----',
      );
      expect(comparisonContentAvailable(quoted, summaryEncrypted: false), isTrue);
    });
  });

  group('authoritative crypto outcomes', () {
    test('rejects failed decryption even if the loader supplied readable error text', () {
      const explanation = EmailContent(emailId: 'failed', text: 'Unlock your key to read this message.');
      expect(
        comparisonContentAvailable(
          explanation,
          summaryEncrypted: false,
          pgpStatus: const PgpMessageStatus(
            protection: PgpProtection.inlineEncrypted,
            encrypted: true,
            failure: PgpDecryptFailure.locked,
          ),
        ),
        isFalse,
      );
      expect(
        comparisonContentAvailable(
          explanation,
          summaryEncrypted: false,
          smimeStatus: const SmimeMessageStatus(
            protection: SmimeProtection.enveloped,
            encrypted: true,
            failure: SmimeDecryptFailure.noKey,
          ),
        ),
        isFalse,
      );
    });

    test('accepts decrypted OpenPGP with the retained outer encrypted headers', () {
      final decrypted = EmailContent(emailId: 'decrypted', text: _plain.text, headers: _pgpEnvelope.headers);
      expect(
        comparisonContentAvailable(
          decrypted,
          summaryEncrypted: true,
          pgpStatus: const PgpMessageStatus(protection: PgpProtection.pgpMimeEncrypted, encrypted: true),
        ),
        isTrue,
      );
    });

    test('accepts decrypted S/MIME with the retained outer envelope', () {
      final decrypted = EmailContent(emailId: 'decrypted', text: _plain.text, headers: _smimeEnvelope.headers);
      expect(
        comparisonContentAvailable(
          decrypted,
          summaryEncrypted: true,
          smimeStatus: const SmimeMessageStatus(protection: SmimeProtection.enveloped, encrypted: true),
        ),
        isTrue,
      );
    });

    test('accepts decoded opaque signed S/MIME despite provisional encrypted summary', () {
      const signed = EmailContent(
        emailId: 'opaque-signed',
        text: 'The decoded signed message',
        headers: [('Content-Type', 'application/pkcs7-mime; name=smime.p7m')],
      );
      expect(
        comparisonContentAvailable(
          signed,
          summaryEncrypted: true,
          smimeStatus: const SmimeMessageStatus(protection: SmimeProtection.signedOpaque),
        ),
        isTrue,
      );
    });

    test('signature verification affects authenticity, not readable text availability', () {
      expect(
        comparisonContentAvailable(
          _plain,
          summaryEncrypted: true,
          pgpStatus: const PgpMessageStatus(protection: PgpProtection.pgpMimeSigned),
        ),
        isTrue,
      );
      expect(
        comparisonContentAvailable(
          _plain,
          summaryEncrypted: false,
          smimeStatus: const SmimeMessageStatus(
            protection: SmimeProtection.signedDetached,
            signature: SmimeSignatureStatus(valid: false, problem: 'Signature does not match'),
          ),
        ),
        isTrue,
      );
    });

    test('one successful outcome cannot conceal failure in another encrypted layer', () {
      const decryptedPgp = PgpMessageStatus(protection: PgpProtection.pgpMimeEncrypted, encrypted: true);
      const failedSmime = SmimeMessageStatus(
        protection: SmimeProtection.enveloped,
        encrypted: true,
        failure: SmimeDecryptFailure.damaged,
      );
      expect(
        comparisonContentAvailable(_plain, summaryEncrypted: true, pgpStatus: decryptedPgp, smimeStatus: failedSmime),
        isFalse,
      );
      expect(
        comparisonContentAvailable(
          _plain,
          summaryEncrypted: true,
          pgpStatus: const PgpMessageStatus(encrypted: true, failure: PgpDecryptFailure.damaged),
          smimeStatus: const SmimeMessageStatus(encrypted: true),
        ),
        isFalse,
      );
    });
  });
}
