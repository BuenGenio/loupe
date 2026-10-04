import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/cms.dart' show contentInfo;
import 'package:mail_crypto/src/smime/oids.dart';
import 'package:test/test.dart';

import 'smime_support.dart';

/// The CMS blob of an S/MIME message: the p7m body, or the p7s part and
/// the signed content of a multipart/signed.
(Uint8List, Uint8List?) cmsOf(String name) {
  final root = MimeEntity.parse(smimeMail(name));
  if (root.mimeType == 'multipart/signed') {
    return (root.parts[1].decodedBody, canonicalLineEnds(root.parts[0].raw));
  }
  return (root.decodedBody, null);
}

final content = Uint8List.fromList(
  utf8.encode('Content-Type: text/plain; charset=utf-8\r\n\r\nHello from Loupe, Grüße!\r\n'),
);

void main() {
  group('verifying what OpenSSL signed', () {
    test('detached (RSA, SHA-256) and opaque (ECDSA P-256, SHA-384)', () {
      final (p7s, signed) = cmsOf('signed-detached.eml');
      final detached = smime.verify(p7s, content: signed);
      final s = detached.signers.single;
      expect((s.valid, s.certificate?.displayName, s.digestAlgorithm), (true, 'Alice Example', Oid.sha256));
      expect(s.signingTime, isNotNull);
      expect(s.capabilities, contains(Oid.aes256Cbc));
      expect(detached.certificates.map((c) => c.displayName), unorderedEquals(['Alice Example', 'Loupe Test Mail CA']));

      final opaque = smime.verify(cmsOf('signed-opaque.eml').$1);
      expect(opaque.signers.single.valid, isTrue);
      expect(opaque.signers.single.certificate?.displayName, 'Bob Example');
      expect(opaque.signers.single.digestAlgorithm, Oid.sha384);
      expect(utf8.decode(opaque.content!), contains('This message is signed with S/MIME.'));
    });

    test('without signed attributes', () {
      final (p7s, signed) = cmsOf('signed-noattr.eml');
      final s = smime.verify(p7s, content: signed).signers.single;
      expect((s.valid, s.signingTime), (true, null));
    });

    test('a modified message fails; a missing certificate is found among known ones', () {
      final (p7s, signed) = cmsOf('signed-modified.eml');
      final s = smime.verify(p7s, content: signed).signers.single;
      expect(s.valid, isFalse);
      expect(s.problem, contains('changed'));

      final (noCerts, original) = cmsOf('signed-noattr.eml');
      expect(smime.verify(noCerts, content: original, known: [cert('alice.crt')]).signers.single.valid, isTrue);
    });
  });

  group('decrypting what OpenSSL encrypted', () {
    final keys = [alice, bob];
    for (final (file, cipher) in [
      ('enveloped-rsa.eml', 'AES-256-CBC'),
      ('enveloped-oaep.eml', 'AES-256-CBC'),
      ('enveloped-ec.eml', 'AES-128-CBC'),
      ('enveloped-ec-sha1kdf.eml', 'AES-256-CBC'),
      ('enveloped-3des.eml', '3DES'),
      ('enveloped-stream.eml', 'AES-256-CBC'),
      ('authenveloped.eml', 'AES-256-GCM'),
    ]) {
      test('$file: $cipher', () {
        final d = smime.decrypt(cmsOf(file).$1, keys);
        expect(d.cipher, cipher);
        expect(d.authenticated, file.startsWith('auth'));
        expect(utf8.decode(d.content), contains('Gr=C3=BC=C3=9Fe!'));
      });
    }

    test('ECDH for Bob, RSA for Alice: each with only their own key', () {
      final (der, _) = cmsOf('authenveloped.eml');
      expect(smime.decrypt(der, [bob]).content, smime.decrypt(der, [alice]).content);
      expect(smime.recipientsOf(der).map((r) => r.serialNumber), [BigInt.from(100), BigInt.from(101)]);
    });

    test('not for us', () {
      expect(
        () => smime.decrypt(cmsOf('enveloped-other.eml').$1, [alice, bob]),
        throwsA(isA<SmimeException>().having((e) => e.kind, 'kind', SmimeErrorKind.noKey)),
      );
    });

    test('a changed AES-GCM message is refused', () {
      final der = Uint8List.fromList(cmsOf('authenveloped.eml').$1);
      der[der.length - 20] ^= 1; // in the ciphertext, before the tag
      expect(() => smime.decrypt(der, [alice]), throwsA(isA<SmimeException>()));
    });
  });

  group('Loupe’s own CMS', () {
    test('signs as RSA and ECDSA, detached and opaque, and verifies it', () {
      for (final signer in [alice, bob]) {
        final sig = smime.sign(
          content,
          signer,
          chain: aliceBundle.chain,
          now: today,
          encryptionCertificate: signer.certificate,
        );
        expect(sig.micalg, 'sha-256');
        final checked = smime.verify(sig.data, content: content);
        expect(checked.signers.single.valid, isTrue);
        expect(checked.signers.single.signingTime, today);
        // The root is left out; the intermediate goes along.
        expect(checked.certificates, [signer.certificate, testCa]);

        final opaque = smime.sign(content, signer, detached: false);
        expect(smime.verify(opaque.data).content, content);
      }
    });

    test('encrypts to RSA and EC recipients, CBC and GCM', () {
      for (final cipher in SmimeContentCipher.values) {
        final der = smime.encrypt(content, [alice.certificate, bob.certificate], cipher: cipher);
        expect(contentInfo(der).$1, cipher == SmimeContentCipher.aes256Gcm ? Oid.authEnvelopedData : Oid.envelopedData);
        for (final k in [alice, bob]) {
          expect(smime.decrypt(der, [k]).content, content);
        }
      }
    });
  });

  group('OpenSSL reads what Loupe writes', () {
    final openssl = Openssl.create();
    tearDownAll(() => openssl?.dispose());

    test('signatures verify with openssl cms -verify', () {
      for (final signer in [alice, bob]) {
        for (final detached in [true, false]) {
          final sig = smime.sign(content, signer, chain: aliceBundle.chain, detached: detached);
          final r = openssl!.run([
            'cms', '-verify', '-inform', 'DER', '-in', openssl.file('sig.der', sig.data), //
            '-CAfile', 'test/fixtures/smime/root.crt', '-purpose', 'smimesign',
            if (detached) ...['-content', openssl.file('content', content), '-binary'],
          ]);
          expect(r.exitCode, 0, reason: '${signer.certificate.displayName} detached=$detached: ${r.stderr}');
          expect(r.stdout, content);
        }
      }
    }, skip: openssl == null ? 'openssl is not installed' : null);

    test('envelopes decrypt with openssl cms -decrypt, for each recipient', () {
      for (final cipher in SmimeContentCipher.values) {
        final der = smime.encrypt(content, [alice.certificate, bob.certificate], cipher: cipher);
        for (final who in ['alice', 'bob']) {
          final r = openssl!.run([
            'cms', '-decrypt', '-inform', 'DER', '-in', openssl.file('env.der', der), '-binary', //
            '-recip', 'test/fixtures/smime/$who.crt', '-inkey', 'test/fixtures/smime/$who.key',
          ]);
          expect(r.exitCode, 0, reason: '$cipher $who: ${r.stderr}');
          expect(r.stdout, content);
        }
      }
    }, skip: openssl == null ? 'openssl is not installed' : null);
  });
}
