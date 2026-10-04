import 'dart:convert';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:test/test.dart';

import 'support.dart';

void main() {
  const reader = PgpMimeReader(pgp);
  final verifiers = [alicePublic, bobPublic, carolPublic];

  group('Thunderbird PGP/MIME', () {
    test('signed by Bob, encrypted to Alice: decrypts, verifies, protected subject', () {
      final raw = tbMail('signed-by-0xfbfcc82a015e7330-encrypted-to-0xf231550c4f47e38e.eml');
      expect(reader.recipientsOf(raw), contains(aliceSecret.keyIds.firstWhere((id) => id != aliceSecret.keyId)));
      final r = reader.read(raw, keys: [aliceSecret], verifiers: verifiers);
      expect(r.status.protection, PgpProtection.pgpMimeEncrypted);
      expect(r.status.decrypted, isTrue);
      expect(r.status.signature!.status, PgpSignatureStatus.good);
      expect(r.status.signature!.signerFingerprint, bobPublic.fingerprint);
      expect(r.status.protectedSubject, 'Signed Encrypted');
      final content = contentFromEntity(r.entity!, emailId: 'm');
      expect(content.text, contains('Sundays are nothing without callaloo.'));
      expect(content.attachments, isEmpty);
    });

    test('encrypted, not signed', () {
      final r = reader.read(
        tbMail('unsigned-encrypted-to-0xf231550c4f47e38e-from-0xfbfcc82a015e7330.eml'),
        keys: [aliceSecret],
        verifiers: verifiers,
      );
      expect(r.status.decrypted, isTrue);
      expect(r.status.signature, isNull);
      expect(contentFromEntity(r.entity!, emailId: 'm').text, isNotEmpty);
    });

    test('non-ASCII text, from Alice to Bob (RSA)', () {
      final r = reader.read(
        tbMail('encrypted-and-signed-alice-to-bob-nonascii.eml'),
        keys: [bobSecret],
        verifiers: verifiers,
      );
      expect(r.status.decrypted, isTrue, reason: r.status.failureMessage);
      expect(r.status.signature!.status, PgpSignatureStatus.good);
      expect(contentFromEntity(r.entity!, emailId: 'm').text, isNot(contains('�')));
    });

    test('a hidden recipient (wildcard key id) decrypts', () {
      final r = reader.read(tbMail('encrypted-to-alice-as-hidden-recipient.eml'), keys: [aliceSecret]);
      expect(r.status.decrypted, isTrue, reason: r.status.failureMessage);
    });

    test('signed by a key we don’t have: unknown key', () {
      final r = reader.read(
        tbMail('signed-by-0x3099ff1238852b9f-encrypted-to-0xf231550c4f47e38e.eml'),
        keys: [aliceSecret],
        verifiers: [alicePublic, bobPublic],
      );
      expect(r.status.decrypted, isTrue);
      expect(r.status.signature!.status, PgpSignatureStatus.unknownKey);
      expect(r.status.signature!.issuerKeyId, carolPublic.keyId);
    });

    test('signed, not encrypted: good, and damaged: bad', () {
      final good = reader.read(
        tbMail('signed-by-0xfbfcc82a015e7330-to-0xf231550c4f47e38e-unencrypted.eml'),
        verifiers: verifiers,
      );
      expect(good.status.protection, PgpProtection.pgpMimeSigned);
      expect(good.status.encrypted, isFalse);
      expect(good.status.signature!.status, PgpSignatureStatus.good);
      expect(contentFromEntity(good.entity!, emailId: 'm').text, contains('callaloo'));
      final bad = reader.read(tbMail('bob-to-alice-signed-damaged-signature.eml'), verifiers: verifiers);
      expect(bad.status.signature!.status, PgpSignatureStatus.bad);
    });

    test('without Alice’s key: no secret key; locked key: locked', () {
      final raw = tbMail('signed-by-0xfbfcc82a015e7330-encrypted-to-0xf231550c4f47e38e.eml');
      final carol = tbKey('carol@example.com-0x3099ff1238852b9f-secret.asc');
      expect(reader.read(raw, keys: [carol]).status.failure, PgpDecryptFailure.noSecretKey);
      final locked = tbKey('alice@openpgp.example-0xf231550c4f47e38e-secret-with-pp.asc');
      expect(reader.read(raw, keys: [locked]).status.failure, PgpDecryptFailure.locked);
      expect(reader.read(raw, keys: [pgp.unlock(locked, 'alice-passphrase')]).status.decrypted, isTrue);
    });

    test('tampered or unprotected (no MDC) ciphertext is refused', () {
      final bob = [bobSecret];
      expect(reader.read(tbMail('rc-openpgp-mdc.eml'), keys: bob).status.decrypted, isTrue);
      expect(reader.read(tbMail('rc-openpgp-mdc-tampered.eml'), keys: bob).status.failure, PgpDecryptFailure.damaged);
      expect(reader.read(tbMail('rc-openpgp-nomdc.eml'), keys: bob).status.failure, PgpDecryptFailure.damaged);
    });

    test('Autocrypt gossip inside the encrypted part is found', () {
      final r = reader.read(tbMail('signed-encrypted-autocrypt-gossip.eml'), keys: [aliceSecret], verifiers: verifiers);
      expect(r.status.decrypted, isTrue, reason: r.status.failureMessage);
      expect(r.status.gossip, isNotEmpty);
      expect(r.status.gossip.join(), contains('carol@example.com'));
    });
  });

  group('inline PGP', () {
    test('cleartext-signed in UTF-8 and in windows-1252', () {
      final utf = reader.read(tbMail('inline-signed-utf8.eml'), verifiers: verifiers);
      expect(utf.status.protection, PgpProtection.inlineSigned);
      expect(utf.status.signature, isNotNull);
      expect(utf.text, isNot(contains('BEGIN PGP')));
      final latin = reader.read(tbMail('inline-signed-latin1.eml'), verifiers: verifiers);
      expect(latin.status.protection, PgpProtection.inlineSigned);
      expect(latin.text, contains('àèìòù'));
    });

    test('an inline encrypted block between plain text', () {
      final r = reader.read(
        tbMail('partial-encrypt-for-alice-plaintext.eml'),
        keys: [aliceSecret],
        verifiers: verifiers,
      );
      expect(r.status.protection, PgpProtection.inlineEncrypted);
      expect(r.status.decrypted, isTrue, reason: r.status.failureMessage);
      expect(r.text, isNot(contains('BEGIN PGP MESSAGE')));
    });

    test('gpg inline messages: encrypted+signed and clear-signed', () {
      final alice = pgp.unlock(key('gpg/alice.sec.asc'), 'alice-pass');
      final bob = key('gpg/bob.pub.asc');
      String message(String body) => 'From: bob@example.org\r\nContent-Type: text/plain; charset=utf-8\r\n\r\n$body';
      final enc = reader.read(
        bytes(message(utf8.decode(fixture('gpg/bob_to_alice.asc')))),
        keys: [alice],
        verifiers: [bob],
      );
      expect(enc.status.decrypted, isTrue);
      expect(enc.status.signature!.status, PgpSignatureStatus.good);
      expect(enc.text, contains('Grüße'));
      final clear = reader.read(bytes(message(utf8.decode(fixture('gpg/clear.asc')))), verifiers: [bob]);
      expect(clear.status.signature!.status, PgpSignatureStatus.good);
    });
  });

  group('detectProtection', () {
    test('from the top-level Content-Type, or the text', () {
      expect(
        detectProtection([('Content-Type', 'multipart/encrypted; protocol="application/pgp-encrypted"; boundary=x')]),
        PgpProtection.pgpMimeEncrypted,
      );
      expect(
        detectProtection([
          ('content-type', 'multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"'),
        ]),
        PgpProtection.pgpMimeSigned,
      );
      expect(detectProtection([], text: 'Hi\n-----BEGIN PGP MESSAGE-----\n'), PgpProtection.inlineEncrypted);
      expect(detectProtection([], text: '> -----BEGIN PGP MESSAGE-----'), PgpProtection.none);
      expect(
        detectProtection([('Content-Type', 'multipart/signed; protocol="application/pkcs7-signature"')]),
        PgpProtection.none,
      );
    });
  });
}
