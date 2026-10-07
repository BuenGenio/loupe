import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/cms.dart'
    show contentInfo, maxMessageCertificates, maxRecipients, maxSigners, verifySignature;
import 'package:mail_crypto/src/smime/der.dart';
import 'package:mail_crypto/src/smime/primitives.dart'
    show PrivateKeyMaterial, RsaKeyMaterial, aesUnwrap, digest, rsaPkcs1Sign;
import 'package:pointycastle/api.dart' show ParametersWithSalt, PrivateKeyParameter;
import 'package:pointycastle/asymmetric/api.dart' show RSAPrivateKey;
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/digests/sha1.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/signers/pss_signer.dart';
import 'package:mail_crypto/src/smime/oids.dart';
import 'package:test/test.dart';

import 'cert_builder.dart';
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
      expect((s.valid, s.modified), (false, true));
      expect(s.problem, contains('changed'));

      final (noCerts, original) = cmsOf('signed-noattr.eml');
      expect(smime.verify(noCerts, content: original, known: [cert('alice.crt')]).signers.single.valid, isTrue);
    });
  });

  test('at most a few dozen certificates of a message are read', () {
    final (p7s, signed) = cmsOf('signed-detached.eml');
    final (_, sd) = contentInfo(p7s);
    final certs = sd.context(0)!.children;
    final stuffed = derSequence([
      derOid(Oid.signedData),
      derContext(0, derSequence([
        for (final c in sd.children)
          if (c.isContext(0)) derContext(0, [for (var i = 0; i < 500; i++) ...certs[i % certs.length].encoded]) else c.encoded,
      ])),
    ]);
    final checked = smime.verify(stuffed, content: signed);
    expect(checked.certificates.length, maxMessageCertificates);
    expect(checked.signers.single.valid, isTrue);
  });

  /// The p7s of signed-detached.eml with its certificates and SignerInfos replaced.
  Uint8List rebuilt({List<Uint8List>? certificates, int signerCopies = 1}) {
    final (p7s, _) = cmsOf('signed-detached.eml');
    final (_, sd) = contentInfo(p7s);
    return derSequence([
      derOid(Oid.signedData),
      derContext(0, derSequence([
        for (final c in sd.children)
          if (c.isContext(0) && certificates != null)
            derContext(0, [for (final x in certificates) ...x])
          else if (c.isSet)
            der(Tag.set, [for (var i = 0; i < signerCopies; i++) ...c[0].encoded])
          else
            c.encoded,
      ])),
    ]);
  }

  test('a thousand SignerInfos: a few are checked, and the content is hashed once', () {
    final stuffed = rebuilt(signerCopies: 1000);
    final big = Uint8List(4 << 20);
    final watch = Stopwatch()..start();
    final checked = smime.verify(stuffed, content: big);
    expect(checked.signers, hasLength(maxSigners));
    expect(checked.signers.every((s) => s.modified), isTrue);
    expect(watch.elapsed, lessThan(const Duration(seconds: 3)));
  });

  group('RSA keys', () {
    final caKey = TestKey('rsa-test-ca');
    final r = Random(1024);
    BigInt modulus(int bits) => bigIntFromBytes([0xc0, for (var i = 1; i < bits ~/ 8; i++) r.nextInt(256)]) | BigInt.one;
    SmimeCertificate withKey(BigInt n, BigInt e, {Uint8List? issuer, int serial = 1}) => makeCertificate(
      key: caKey,
      subject: name('RSA key'),
      issuer: issuer ?? name('RSA test CA'),
      issuerKey: caKey,
      serial: serial,
      spki: rsaSpki(n, e),
    );

    test('a huge public exponent, an even one, or a modulus past 16384 bits isn’t used', () {
      final f4 = BigInt.from(65537);
      for (final cert in [
        withKey(modulus(2048), modulus(2048)),
        withKey(modulus(2048), BigInt.from(65536)),
        withKey(modulus(2048), BigInt.one),
      ]) {
        final watch = Stopwatch()..start();
        expect(
          () => verifySignature(cert, Oid.sha256WithRsa, null, Oid.sha256, content, Uint8List(256)),
          throwsA(isA<SmimeException>()),
        );
        expect(watch.elapsed, lessThan(const Duration(milliseconds: 200)));
      }
      expect(verifySignature(withKey(modulus(2048), f4), Oid.sha256WithRsa, null, Oid.sha256, content, Uint8List(256)), isFalse);
      // Past 16384 bits, the certificate itself doesn't parse.
      expect(() => withKey(modulus(16392), f4), throwsA(isA<SmimeException>()));
    });

    test('a signer’s RSA key under 2048 bits is weak; such a CA signs nothing', () {
      // Alice's issuer and serial number, with a 1024-bit key: the SignerInfo finds it.
      final weak = withKey(modulus(1024), BigInt.from(65537), issuer: alice.certificate.issuer.der, serial: 100);
      final s = smime.verify(rebuilt(certificates: [weak.der]), content: cmsOf('signed-detached.eml').$2).signers.single;
      expect((s.valid, s.weak, s.certificate), (false, true, weak));
      expect(smime.certificateSignedBy(alice.certificate, withKey(modulus(1024), BigInt.from(65537))), isFalse);
    });
  });

  group('signatures made here, of any shape', () {
    final material = PrivateKeyMaterial.parse(aliceKey) as RsaKeyMaterial;
    Uint8List attr(String oid, List<int> value) => derSequence([derOid(oid), derSet([value])]);
    final standardAttrs = [attr(Oid.contentType, derOid(Oid.data)), attr(Oid.messageDigest, derOctets(digest(Oid.sha256, content)))];

    /// A detached SignedData over `content` by Alice with [attrs], signed by [sign] as [sigAlg].
    Uint8List signedData(List<Uint8List> attrs, Uint8List sigAlg, Uint8List Function(Uint8List signedAttrs) sign) {
      final signedAttrs = der(Tag.set, [for (final a in attrs) ...a]);
      final signerInfo = derSequence([
        derInt(1),
        derSequence([alice.certificate.issuer.der, derInteger(alice.certificate.serialNumber)]),
        derAlgorithm(Oid.sha256),
        retag(signedAttrs, 0xa0),
        sigAlg,
        derOctets(sign(signedAttrs)),
      ]);
      return derSequence([
        derOid(Oid.signedData),
        derContext(0, derSequence([
          derInt(1),
          derSet([derAlgorithm(Oid.sha256)]),
          derSequence([derOid(Oid.data)]),
          derContext(0, alice.certificate.der),
          derSet([signerInfo]),
        ])),
      ]);
    }

    Uint8List pkcs1(Uint8List data) => rsaPkcs1Sign(material, Oid.sha256, digest(Oid.sha256, data));
    Uint8List pss(Uint8List data, {required bool sha1}) {
      final signer = sha1
          ? PSSSigner(RSAEngine(), SHA1Digest(), SHA1Digest())
          : PSSSigner(RSAEngine(), SHA256Digest(), SHA256Digest());
      signer.init(true, ParametersWithSalt(PrivateKeyParameter<RSAPrivateKey>(material.key), Uint8List(sha1 ? 20 : 32)));
      return signer.generateSignature(data).bytes;
    }

    test('PKCS #1 v1.5 and RSASSA-PSS with SHA-256 verify', () {
      final rsa = smime.verify(signedData(standardAttrs, derAlgorithm(Oid.rsaEncryption, derNull), pkcs1), content: content);
      expect(rsa.signers.single.valid, isTrue);
      final pssParams = derSequence([
        derContext(0, derAlgorithm(Oid.sha256)),
        derContext(1, derAlgorithm(Oid.mgf1, derAlgorithm(Oid.sha256))),
        derContext(2, derInt(32)),
      ]);
      final checked = smime.verify(
        signedData(standardAttrs, derAlgorithm(Oid.rsassaPss, pssParams), (d) => pss(d, sha1: false)),
        content: content,
      );
      expect(checked.signers.single.valid, isTrue);
    });

    test('RSASSA-PSS with SHA-1 (its default parameters) is weak, like sha1WithRSA', () {
      final s = smime
          .verify(signedData(standardAttrs, derAlgorithm(Oid.rsassaPss), (d) => pss(d, sha1: true)), content: content)
          .signers
          .single;
      expect((s.valid, s.weak), (false, true));
    });

    test('an attribute twice, or a message digest with two values, is damage', () {
      final digestAttr = standardAttrs[1];
      final twoValues = derSequence([
        derOid(Oid.messageDigest),
        derSet([derOctets(digest(Oid.sha256, content)), derOctets(Uint8List(32))]),
      ]);
      for (final attrs in [
        [...standardAttrs, digestAttr],
        [standardAttrs[0], twoValues],
      ]) {
        final s = smime.verify(signedData(attrs, derAlgorithm(Oid.rsaEncryption, derNull), pkcs1), content: content);
        expect(s.signers.single.valid, isFalse);
        expect(s.signers.single.problem, contains('attributes'));
      }
    });
  });

  test('a certificate whose outer signature algorithm isn’t the inner one is signed by nobody', () {
    final caKey = TestKey('mismatch-ca');
    final ca = makeCa('Mismatch CA', caKey);
    SmimeCertificate user({String? outer}) => makeCertificate(
      key: TestKey('mismatch-user'),
      subject: name('alice@example.org'),
      issuer: name('Mismatch CA'),
      issuerKey: caKey,
      outerAlgorithm: outer,
    );
    expect(smime.certificateSignedBy(user(), ca), isTrue);
    // The same signature, labelled with the bare key algorithm outside.
    final relabelled = user(outer: Oid.ecPublicKey);
    expect(relabelled.signatureAlgorithmsMatch, isFalse);
    expect(smime.certificateSignedBy(relabelled, ca), isFalse);
  });

  test('a certificate with an extension twice is damaged', () {
    final key = TestKey('twice');
    expect(
      () => makeCertificate(
        key: key,
        subject: name('Twice'),
        issuer: name('Twice'),
        issuerKey: key,
        extensions: [basicConstraints(ca: false), basicConstraints()],
      ),
      throwsA(isA<SmimeException>()),
    );
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

    test('an envelope naming thousands of recipients, or a wrapped key of megabytes, is damage', () {
      final (p7m, _) = cmsOf('enveloped-rsa.eml');
      final (_, env) = contentInfo(p7m);
      final stuffed = derSequence([
        derOid(Oid.envelopedData),
        derContext(0, derSequence([
          for (final c in env.children)
            if (c.isSet) der(Tag.set, [for (var i = 0; i <= maxRecipients; i++) ...c[0].encoded]) else c.encoded,
        ])),
      ]);
      for (final run in [() => smime.decrypt(stuffed, [alice]), () => smime.recipientsOf(stuffed)]) {
        expect(run, throwsA(isA<SmimeException>().having((e) => e.kind, 'kind', SmimeErrorKind.malformed)));
      }
      final watch = Stopwatch()..start();
      expect(() => aesUnwrap(Uint8List(32), Uint8List(1 << 20)), throwsA(isA<SmimeException>()));
      expect(watch.elapsed, lessThan(const Duration(milliseconds: 100)));
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
