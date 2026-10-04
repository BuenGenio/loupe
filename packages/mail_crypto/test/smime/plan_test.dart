import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/oids.dart';
import 'package:mail_model/mail_model.dart' show SecurityTechnology;
import 'package:test/test.dart';

import 'smime_support.dart';

SmimeContactCertificate contact(SmimeCertificate c, {List<String> capabilities = const []}) =>
    SmimeContactCertificate(certificate: c, chain: [testCa], added: today, capabilities: capabilities);

SmimeState state({List<SmimeContactCertificate> contacts = const [], bool trustTestRoot = true}) => SmimeState(
  own: [
    SmimeOwnCertificate(certificate: alice.certificate, chain: [testCa], added: today),
  ],
  contacts: contacts,
  authorities: [if (trustTestRoot) testRoot],
);

SmimePlan plan(SmimeState s, List<String> to) =>
    planSmime(s, from: 'alice@example.org', recipients: to, now: today, signedBy: smime.certificateSignedBy);

void main() {
  group('which certificate a recipient gets', () {
    SmimeCertificate? forBob(SmimeState s, {DateTime? at}) =>
        s.encryptionCertificateFor('Bob@Example.net', now: at ?? today, signedBy: smime.certificateSignedBy);

    test('a trusted, valid certificate for encryption', () {
      expect(forBob(state(contacts: [contact(bob.certificate)])), bob.certificate);
    });

    test('none: untrusted, expired, signing only, or unknown', () {
      expect(forBob(state(contacts: [contact(bob.certificate)], trustTestRoot: false)), isNull);
      expect(forBob(state(contacts: [contact(bob.certificate)]), at: DateTime.utc(2037)), isNull);
      final dave = state(contacts: [contact(cert('dave.crt'))]);
      expect(
        dave.encryptionCertificateFor('dave@example.org', now: today, signedBy: smime.certificateSignedBy),
        isNull,
      );
      expect(forBob(state()), isNull);
    });

    test('the user’s own address gets their own certificate', () {
      expect(
        state().encryptionCertificateFor('alice@example.org', now: today, signedBy: smime.certificateSignedBy),
        alice.certificate,
      );
    });
  });

  group('the plan', () {
    test('possible when every recipient has a certificate; the sender’s is included', () {
      final p = plan(state(contacts: [contact(bob.certificate)]), ['bob@example.net']);
      expect((p.possible, p.canSign), (true, true));
      expect(p.missing, isEmpty);
      expect(p.recipientCertificates, [bob.certificate, alice.certificate]);
      expect(p.cipher, SmimeContentCipher.aes256Cbc);
    });

    test('missing certificates are named', () {
      final p = plan(state(contacts: [contact(bob.certificate)]), ['bob@example.net', 'carol@example.org']);
      expect(p.possible, isFalse);
      expect(p.missing, ['carol@example.org']);
    });

    test('AES-GCM only when every recipient announced it', () {
      final gcm = contact(bob.certificate, capabilities: [Oid.aes256Gcm, Oid.aes256Cbc]);
      expect(plan(state(contacts: [gcm]), ['bob@example.net']).cipher, SmimeContentCipher.aes256Gcm);
      expect(
        plan(state(contacts: [gcm]), ['bob@example.net', 'alice@example.org']).cipher,
        SmimeContentCipher.aes256Gcm,
      );
    });

    test('no own certificate: nothing is possible', () {
      final p = planSmime(
        const SmimeState(),
        from: 'alice@example.org',
        recipients: ['bob@example.net'],
        now: today,
        signedBy: smime.certificateSignedBy,
      );
      expect((p.canSign, p.possible), (false, false));
    });
  });

  group('choosing OpenPGP or S/MIME', () {
    test('only one available: that one', () {
      expect(chooseTechnology(pgp: true, smime: false, preferSmime: true), SecurityTechnology.openPgp);
      expect(chooseTechnology(pgp: false, smime: true, preferSmime: false), SecurityTechnology.smime);
    });

    test('both: the preference, unless only the other can encrypt to everyone', () {
      expect(chooseTechnology(pgp: true, smime: true, preferSmime: false), SecurityTechnology.openPgp);
      expect(chooseTechnology(pgp: true, smime: true, preferSmime: true), SecurityTechnology.smime);
      expect(
        chooseTechnology(pgp: true, smime: true, preferSmime: false, smimeCanEncrypt: true),
        SecurityTechnology.smime,
      );
      expect(
        chooseTechnology(pgp: true, smime: true, preferSmime: true, pgpCanEncrypt: true),
        SecurityTechnology.openPgp,
      );
      expect(
        chooseTechnology(pgp: true, smime: true, preferSmime: true, pgpCanEncrypt: true, smimeCanEncrypt: true),
        SecurityTechnology.smime,
      );
    });

    test('neither: the preference (nothing is offered anyway)', () {
      expect(chooseTechnology(pgp: false, smime: false, preferSmime: true), SecurityTechnology.smime);
    });
  });
}
