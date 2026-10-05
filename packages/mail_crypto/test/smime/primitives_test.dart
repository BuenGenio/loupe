import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/der.dart';
import 'package:mail_crypto/src/smime/oids.dart';
import 'package:mail_crypto/src/smime/primitives.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/api.dart' show PrivateKeyParameter;
import 'package:test/test.dart';

import 'smime_support.dart';

/// The integer cube root of [v], rounded down.
BigInt cubeRoot(BigInt v) {
  var x = BigInt.one << ((v.bitLength + 2) ~/ 3);
  while (true) {
    final y = (BigInt.two * x + v ~/ (x * x)) ~/ BigInt.from(3);
    if (y >= x) break;
    x = y;
  }
  while (x * x * x > v) {
    x -= BigInt.one;
  }
  return x;
}

void main() {
  group('RSASSA-PKCS1-v1_5 verification takes only the exact encoding', () {
    final hash = digest(Oid.sha256, utf8.encode('Pay the new account'));
    final material = PrivateKeyMaterial.parse(alice.key) as RsaKeyMaterial;
    final public = RSAPublicKey(material.modulus, material.publicExponent);
    const k = 256;

    /// Alice's raw RSA on [t] with PKCS #1 type 1 padding: what a lax
    /// verifier would accept, signed for real.
    Uint8List signRaw(List<int> t) {
      final em = Uint8List(k)
        ..[1] = 1
        ..fillRange(2, k - t.length - 1, 0xff)
        ..setRange(k - t.length, k, t);
      final engine = RSAEngine()..init(false, PrivateKeyParameter<RSAPrivateKey>(material.key));
      return unsignedBytes(bigIntFromBytes(engine.process(em)), k);
    }

    final alg = derAlgorithm(Oid.sha256, derNull);
    final octets = derOctets(hash);

    test('the DigestInfo with NULL parameters, and without', () {
      expect(rsaPkcs1Verify(public, Oid.sha256, hash, rsaPkcs1Sign(material, Oid.sha256, hash)), isTrue);
      expect(rsaPkcs1Verify(public, Oid.sha256, hash, signRaw(derSequence([alg, octets]))), isTrue);
      expect(rsaPkcs1Verify(public, Oid.sha256, hash, signRaw(derSequence([derAlgorithm(Oid.sha256), octets]))), isTrue);
      expect(rsaPkcs1Verify(public, Oid.sha384, hash, signRaw(derSequence([alg, octets]))), isFalse);
    });

    test('not an element after the digest, a NULL with content, a long-form length', () {
      final garbage = derOctets(List.filled(40, 0x41));
      for (final (what, t) in [
        ('trailing element', derSequence([alg, octets, garbage])),
        ('element after NULL', derSequence([derSequence([derOid(Oid.sha256), derNull, garbage]), octets])),
        ('NULL with content', derSequence([derSequence([derOid(Oid.sha256), const [0x05, 0x02, 0x41, 0x41]]), octets])),
        ('long-form length', [0x30, 0x81, 0x31, ...alg, ...octets]),
        ('non-minimal OID', derSequence([derSequence([const [0x06, 0x0a, 0x80, 0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01], derNull]), octets])),
      ]) {
        expect(rsaPkcs1Verify(public, Oid.sha256, hash, signRaw(t)), isFalse, reason: what);
      }
    });

    test('Bleichenbacher’s forgery (e = 3): no private key, garbage after the digest', () {
      // Any 2048-bit modulus with exponent 3: the forger needs only the public key.
      final r = Random(2006);
      final n = bigIntFromBytes([0xc0 | r.nextInt(64), for (var i = 1; i < k - 1; i++) r.nextInt(256), 1 | r.nextInt(256)]);
      final key = RSAPublicKey(n, BigInt.from(3));
      // 00 01 FF×8 00, then a DigestInfo whose SEQUENCE also holds a 190-octet OCTET STRING.
      final prefix = [
        0, 1, ...List.filled(8, 0xff), 0, //
        0x30, 0x81, 0xf2, ...alg, ...octets, 0x04, 0x81, 0xbe,
      ];
      final garbage = k - prefix.length;
      final target = bigIntFromBytes([...prefix, ...List.filled(garbage, 0xff)]);
      final forged = unsignedBytes(cubeRoot(target), k);
      // The cube really starts with the prefix: only the garbage differs.
      final cube = unsignedBytes(bigIntFromBytes(forged).pow(3), k);
      expect(cube.sublist(0, prefix.length), prefix);
      expect(rsaPkcs1Verify(key, Oid.sha256, hash, forged), isFalse);
    });
  });

  group('EC public keys must be points on the curve', () {
    final point = bob.certificate.publicKey;

    test('Bob’s key is; the same with y changed, an x past the field or a hybrid encoding isn’t', () {
      expect(ecPublicKey(Oid.secp256r1, point).Q, isNotNull);
      final offCurve = Uint8List.fromList(point)..[64] ^= 1;
      final hybrid = Uint8List.fromList(point)..[0] = 6 | (point[64] & 1);
      final tooBig = Uint8List.fromList(point)..fillRange(1, 33, 0xff);
      for (final p in [offCurve, hybrid, tooBig, Uint8List(0), Uint8List.fromList([0])]) {
        expect(
          () => ecPublicKey(Oid.secp256r1, p),
          throwsA(isA<SmimeException>().having((e) => e.kind, 'kind', SmimeErrorKind.malformed)),
        );
      }
    });

    test('an ECDH message whose ephemeral key is off the curve is refused before any key agreement', () {
      final der = Uint8List.fromList(MimeEntity.parse(smimeMail('enveloped-ec.eml')).decodedBody);
      expect(smime.decrypt(der, [bob]).content, isNotEmpty);
      // The originator's point: the one 65-octet uncompressed point in the message.
      final at = () {
        for (var i = 0; i + 66 < der.length; i++) {
          if (der[i] == 0x03 && der[i + 1] == 0x42 && der[i + 2] == 0 && der[i + 3] == 4) return i + 3;
        }
        throw StateError('no point');
      }();
      der[at + 64] ^= 1;
      expect(
        () => smime.decrypt(der, [bob]),
        throwsA(isA<SmimeException>().having((e) => e.kind, 'kind', SmimeErrorKind.malformed)),
      );
    });
  });
}
