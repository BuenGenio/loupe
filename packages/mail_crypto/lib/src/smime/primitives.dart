/// The cryptography under S/MIME, on pointycastle: digests, RSA (PKCS #1
/// v1.5, OAEP, PSS), ECDSA, ECDH with the X9.63 KDF, AES key wrap, and
/// the content ciphers (AES-CBC, AES-GCM, 3DES-CBC, RC2-CBC).
library;

import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/api.dart' hide Signature;
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/desede_engine.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/block/modes/gcm.dart';
import 'package:pointycastle/block/rc2_engine.dart';
import 'package:pointycastle/digests/sha1.dart';
import 'package:pointycastle/digests/sha224.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/digests/sha384.dart';
import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/ecc_fp.dart' as fp;
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';

import 'certificate.dart';
import 'der.dart';
import 'oids.dart';

// pointycastle registers curves by name.
import 'package:pointycastle/ecc/curves/brainpoolp256r1.dart';
import 'package:pointycastle/ecc/curves/brainpoolp384r1.dart';
import 'package:pointycastle/ecc/curves/brainpoolp512r1.dart';
import 'package:pointycastle/ecc/curves/secp256r1.dart';
import 'package:pointycastle/ecc/curves/secp384r1.dart';
import 'package:pointycastle/ecc/curves/secp521r1.dart';

final _random = Random.secure();

Uint8List randomBytes(int n) => Uint8List.fromList([for (var i = 0; i < n; i++) _random.nextInt(256)]);

// Digests ---------------------------------------------------------------------

Digest? digestFor(String oid) => switch (oid) {
  Oid.sha1 => SHA1Digest(),
  Oid.sha224 => SHA224Digest(),
  Oid.sha256 => SHA256Digest(),
  Oid.sha384 => SHA384Digest(),
  Oid.sha512 => SHA512Digest(),
  _ => null,
};

/// RFC 8551 `micalg` names.
String micalgOf(String digestOid) => switch (digestOid) {
  Oid.sha1 => 'sha-1',
  Oid.sha224 => 'sha-224',
  Oid.sha256 => 'sha-256',
  Oid.sha384 => 'sha-384',
  Oid.sha512 => 'sha-512',
  _ => 'unknown',
};

String digestName(String oid) => switch (oid) {
  Oid.sha1 => 'SHA-1',
  Oid.sha224 => 'SHA-224',
  Oid.sha256 => 'SHA-256',
  Oid.sha384 => 'SHA-384',
  Oid.sha512 => 'SHA-512',
  Oid.md5 => 'MD5',
  _ => oid,
};

Uint8List digest(String oid, List<int> data) {
  final d = digestFor(oid);
  if (d == null) throw SmimeException(SmimeErrorKind.unsupported, 'The digest ${digestName(oid)} isn’t supported.');
  return d.process(Uint8List.fromList(data));
}

Uint8List _hash(Digest d, List<int> data) {
  d.reset();
  return d.process(data is Uint8List ? data : Uint8List.fromList(data));
}

// Keys ------------------------------------------------------------------------

/// A private key as PKCS #8 (unencrypted PrivateKeyInfo), backend-neutral.
final class SmimePrivateKey {
  const SmimePrivateKey(this.pkcs8);
  final Uint8List pkcs8;
}

ECDomainParameters _domain(String? curve) => switch (curve) {
  Oid.secp256r1 => ECCurve_secp256r1(),
  Oid.secp384r1 => ECCurve_secp384r1(),
  Oid.secp521r1 => ECCurve_secp521r1(),
  Oid.brainpoolP256r1 => ECCurve_brainpoolp256r1(),
  Oid.brainpoolP384r1 => ECCurve_brainpoolp384r1(),
  Oid.brainpoolP512r1 => ECCurve_brainpoolp512r1(),
  _ => throw SmimeException(SmimeErrorKind.unsupported, 'The elliptic curve ${curveName(curve)} isn’t supported.'),
};

/// RSA keys smaller than this don't count for signatures (they can be
/// factored, and a signing time can be backdated to when they were valid).
const minRsaBits = 2048;

/// RSA keys larger than this are refused, as OpenSSL does.
const maxRsaBits = 16384;

/// [cert]'s RSA key: an odd modulus of at most [maxRsaBits], an odd public
/// exponent of at least 3 and at most 64 bits (a huge one makes every
/// signature check with the key take seconds).
RSAPublicKey rsaPublicKey(SmimeCertificate cert) {
  final key = Asn1.parse(cert.publicKey);
  final n = key[0].integer;
  final e = key[1].integer;
  if (n.isNegative || n.isEven || n.bitLength > maxRsaBits || e < BigInt.from(3) || e.isEven || e.bitLength > 64) {
    throw const SmimeException(SmimeErrorKind.unsupported, 'This RSA key isn’t supported.');
  }
  return RSAPublicKey(n, e);
}

/// A public key on [curve]: an uncompressed or compressed point that is on
/// the curve. pointycastle doesn't check that, and ECDH with a point off the
/// curve (from a message's originator key) is an invalid-curve attack on
/// the private key. Every supported curve has cofactor 1: on the curve and
/// not infinity is enough.
ECPublicKey ecPublicKey(String? curve, Uint8List point) {
  final domain = _domain(curve);
  const bad = SmimeException(SmimeErrorKind.malformed, 'Bad EC public key.');
  if (point.isEmpty || !const {2, 3, 4}.contains(point[0])) throw bad;
  ECPoint? q;
  try {
    q = domain.curve.decodePoint(point);
  } on ArgumentError {
    throw bad;
  }
  if (q == null || q.isInfinity || !_onCurve(domain.curve as fp.ECCurve, q)) throw bad;
  return ECPublicKey(q, domain);
}

bool _onCurve(fp.ECCurve curve, ECPoint q) {
  final p = curve.q!;
  final x = q.x!.toBigInteger()!;
  final y = q.y!.toBigInteger()!;
  if (x.isNegative || y.isNegative || x >= p || y >= p) return false;
  final a = curve.a!.toBigInteger()!;
  final b = curve.b!.toBigInteger()!;
  return (y * y - (x * x * x + a * x + b)) % p == BigInt.zero;
}

/// A parsed private key: RSA, or EC with its curve.
sealed class PrivateKeyMaterial {
  const PrivateKeyMaterial();

  static PrivateKeyMaterial parse(SmimePrivateKey key) {
    try {
      final info = Asn1.parse(key.pkcs8);
      final algorithm = info[1][0].oid;
      final inner = Asn1.parse(info[2].octets);
      if (algorithm == Oid.rsaEncryption) {
        return RsaKeyMaterial(
          RSAPrivateKey(inner[1].integer, inner[3].integer, inner[4].integer, inner[5].integer),
          inner[1].integer,
          inner[2].integer,
        );
      }
      if (algorithm == Oid.ecPublicKey) {
        final params = info[1].length > 1 ? info[1][1] : null;
        String? curve = params != null && params.tag == Tag.oid ? params.oid : null;
        // ECPrivateKey may carry the curve itself ([0]).
        curve ??= inner.context(0)?[0].oid;
        final domain = _domain(curve);
        return EcKeyMaterial(ECPrivateKey(bigIntFromBytes(inner[1].content), domain), curve!);
      }
      throw const SmimeException(SmimeErrorKind.unsupported, 'Only RSA and EC keys are supported.');
    } on SmimeException {
      rethrow;
    } on Object catch (e) {
      throw SmimeException(SmimeErrorKind.malformed, 'The private key is damaged.', e);
    }
  }

  /// Whether this is the private half of [cert]'s public key.
  bool matches(SmimeCertificate cert);
}

final class RsaKeyMaterial extends PrivateKeyMaterial {
  const RsaKeyMaterial(this.key, this.modulus, this.publicExponent);
  final RSAPrivateKey key;
  final BigInt modulus;
  final BigInt publicExponent;

  @override
  bool matches(SmimeCertificate cert) => cert.keyType == SmimeKeyType.rsa && rsaPublicKey(cert).modulus == modulus;
}

final class EcKeyMaterial extends PrivateKeyMaterial {
  const EcKeyMaterial(this.key, this.curve);
  final ECPrivateKey key;
  final String curve;

  ECPoint get publicPoint => (key.parameters!.G * key.d)!;

  @override
  bool matches(SmimeCertificate cert) {
    if (cert.keyType != SmimeKeyType.ec || cert.curve != curve) return false;
    try {
      return ecPublicKey(cert.curve, cert.publicKey).Q == publicPoint;
    } on SmimeException {
      return false;
    }
  }
}

// RSA -------------------------------------------------------------------------

BigInt _modPow(BigInt base, BigInt e, BigInt m) => base.modPow(e, m);

int _byteLength(BigInt n) => (n.bitLength + 7) >> 3;

Uint8List _rsaPrivate(RSAPrivateKey key, Uint8List input) {
  final engine = RSAEngine()..init(false, PrivateKeyParameter<RSAPrivateKey>(key));
  final out = engine.process(input);
  return unsignedBytes(bigIntFromBytes(out), _byteLength(key.modulus!));
}

Uint8List _digestInfo(String digestOid, Uint8List hash) =>
    derSequence([derAlgorithm(digestOid, derNull), derOctets(hash)]);

/// RSASSA-PKCS1-v1_5 verification (RFC 8017 §8.2.2): the recovered block
/// must be exactly the one encoding [hash] would give, DigestInfo with NULL
/// parameters or without them. Nothing in it is parsed: a parser that lets
/// anything through (extra elements, a NULL with content, long-form
/// lengths) leaves room for a forgery under small exponents (Bleichenbacher 2006).
bool rsaPkcs1Verify(RSAPublicKey key, String digestOid, Uint8List hash, Uint8List signature) {
  final n = key.modulus!;
  final k = _byteLength(n);
  if (signature.length > k) return false;
  final s = bigIntFromBytes(signature);
  if (s >= n) return false;
  final em = unsignedBytes(_modPow(s, key.exponent!, n), k);
  var ok = false;
  for (final t in [_digestInfo(digestOid, hash), derSequence([derAlgorithm(digestOid), derOctets(hash)])]) {
    final expected = _pkcs1Block(t, k);
    if (expected != null && _constantEquals(em, expected)) ok = true;
  }
  return ok;
}

/// EMSA-PKCS1-v1_5: `00 01 FF… 00 T` in [k] octets; null when [t] doesn't fit.
Uint8List? _pkcs1Block(Uint8List t, int k) {
  if (t.length + 11 > k) return null;
  final em = Uint8List(k)
    ..[0] = 0
    ..[1] = 1;
  for (var i = 2; i < k - t.length - 1; i++) {
    em[i] = 0xff;
  }
  em[k - t.length - 1] = 0;
  em.setRange(k - t.length, k, t);
  return em;
}

Uint8List rsaPkcs1Sign(RsaKeyMaterial key, String digestOid, Uint8List hash) {
  final em = _pkcs1Block(_digestInfo(digestOid, hash), _byteLength(key.modulus));
  if (em == null) throw const SmimeException(SmimeErrorKind.unsupported, 'The RSA key is too small.');
  return _rsaPrivate(key.key, em);
}

Uint8List _mgf1(Digest d, Uint8List seed, int length) {
  final out = BytesBuilder(copy: false);
  for (var counter = 0; out.length < length; counter++) {
    out.add(_hash(d, [...seed, (counter >> 24) & 0xff, (counter >> 16) & 0xff, (counter >> 8) & 0xff, counter & 0xff]));
  }
  return Uint8List.sublistView(out.takeBytes(), 0, length);
}

/// RSASSA-PSS verification (RFC 8017 §9.1.2).
bool rsaPssVerify(RSAPublicKey key, Digest hashAlg, Digest mgfAlg, int saltLength, Uint8List mHash, Uint8List sig) {
  final n = key.modulus!;
  final modBits = n.bitLength;
  final emBits = modBits - 1;
  final emLen = (emBits + 7) >> 3;
  final s = bigIntFromBytes(sig);
  if (s >= n) return false;
  final em = unsignedBytes(_modPow(s, key.exponent!, n), emLen);
  final hLen = hashAlg.digestSize;
  if (em.length != emLen || emLen < hLen + saltLength + 2 || em.last != 0xbc) return false;
  final maskedDb = Uint8List.sublistView(em, 0, emLen - hLen - 1);
  final h = Uint8List.sublistView(em, emLen - hLen - 1, emLen - 1);
  final topMask = 0xff >> (8 * emLen - emBits);
  if (maskedDb[0] & ~topMask & 0xff != 0) return false;
  final db = _mgf1(mgfAlg, h, maskedDb.length);
  for (var i = 0; i < db.length; i++) {
    db[i] ^= maskedDb[i];
  }
  db[0] &= topMask;
  final psLen = emLen - hLen - saltLength - 2;
  for (var i = 0; i < psLen; i++) {
    if (db[i] != 0) return false;
  }
  if (db[psLen] != 1) return false;
  final salt = Uint8List.sublistView(db, db.length - saltLength);
  final mPrime = Uint8List(8 + hLen + saltLength)
    ..setRange(8, 8 + hLen, mHash)
    ..setRange(8 + hLen, 8 + hLen + saltLength, salt);
  return _constantEquals(_hash(hashAlg, mPrime), h);
}

/// RSAES-PKCS1-v1_5 encryption of a content-encryption key.
Uint8List rsaPkcs1Encrypt(RSAPublicKey key, Uint8List message) {
  final n = key.modulus!;
  final k = _byteLength(n);
  if (message.length > k - 11) throw const SmimeException(SmimeErrorKind.unsupported, 'The RSA key is too small.');
  final em = Uint8List(k)
    ..[0] = 0
    ..[1] = 2;
  final psLen = k - message.length - 3;
  for (var i = 0; i < psLen; i++) {
    var b = 0;
    while (b == 0) {
      b = _random.nextInt(256);
    }
    em[2 + i] = b;
  }
  em[2 + psLen] = 0;
  em.setRange(3 + psLen, k, message);
  return unsignedBytes(_modPow(bigIntFromBytes(em), key.exponent!, n), k);
}

/// RSAES-PKCS1-v1_5 decryption of a key of [expectedLength] bytes. A bad
/// padding gives random bytes instead of an error (RFC 3218 §2.3.2), so
/// the content decryption fails like any wrong key.
Uint8List rsaPkcs1DecryptKey(RsaKeyMaterial key, Uint8List encrypted, int? expectedLength) {
  final k = _byteLength(key.modulus);
  final fallback = randomBytes(expectedLength ?? 32);
  if (encrypted.length > k) return fallback;
  final em = _rsaPrivate(key.key, encrypted);
  var good = em[0] == 0 && em[1] == 2;
  var sep = -1;
  for (var i = 2; i < em.length; i++) {
    if (em[i] == 0 && sep < 0) sep = i;
  }
  good = good && sep >= 10;
  final message = sep < 0 ? Uint8List(0) : Uint8List.sublistView(em, sep + 1);
  if (expectedLength != null && message.length != expectedLength) good = false;
  if (!good || message.isEmpty) return fallback;
  return Uint8List.fromList(message);
}

/// RSAES-OAEP decryption (RFC 8017 §7.1.2) with [hashAlg] and MGF1([mgfAlg]).
Uint8List rsaOaepDecrypt(RsaKeyMaterial key, Digest hashAlg, Digest mgfAlg, Uint8List label, Uint8List encrypted) {
  final k = _byteLength(key.modulus);
  final hLen = hashAlg.digestSize;
  Never fail() => throw const SmimeException(SmimeErrorKind.noKey, 'This message can’t be decrypted with your key.');
  if (encrypted.length > k || k < 2 * hLen + 2) fail();
  final em = _rsaPrivate(key.key, encrypted);
  final maskedSeed = Uint8List.sublistView(em, 1, 1 + hLen);
  final maskedDb = Uint8List.sublistView(em, 1 + hLen);
  final seed = _mgf1(mgfAlg, maskedDb, hLen);
  for (var i = 0; i < hLen; i++) {
    seed[i] ^= maskedSeed[i];
  }
  final db = _mgf1(mgfAlg, seed, maskedDb.length);
  for (var i = 0; i < db.length; i++) {
    db[i] ^= maskedDb[i];
  }
  final lHash = _hash(hashAlg, label);
  var good = em[0] == 0 && _constantEquals(Uint8List.sublistView(db, 0, hLen), lHash);
  var i = hLen;
  while (i < db.length && db[i] == 0) {
    i++;
  }
  good = good && i < db.length && db[i] == 1;
  if (!good) fail();
  return Uint8List.fromList(Uint8List.sublistView(db, i + 1));
}

/// Digest and MGF1 digest of RSASSA-PSS-params or RSAES-OAEP-params
/// (`[0]` hash, `[1]` MGF, then `[2]` salt length or label source).
(Digest, Digest, Asn1?) rsaParams(Asn1? params) {
  var hashOid = Oid.sha1;
  var mgfOid = Oid.sha1;
  Asn1? third;
  if (params != null && params.isSequence) {
    final h = params.context(0);
    if (h != null) hashOid = h[0][0].oid;
    final m = params.context(1);
    if (m != null) {
      if (m[0][0].oid != Oid.mgf1) throw const SmimeException(SmimeErrorKind.unsupported, 'Unknown mask function.');
      mgfOid = m[0][1][0].oid;
    }
    third = params.context(2);
  }
  final hash = digestFor(hashOid);
  final mgf = digestFor(mgfOid);
  if (hash == null || mgf == null) {
    throw SmimeException(SmimeErrorKind.unsupported, 'The digest ${digestName(hashOid)} isn’t supported.');
  }
  return (hash, mgf, third);
}

// ECDSA -----------------------------------------------------------------------

bool ecdsaVerify(ECPublicKey key, Uint8List hash, Uint8List signature) {
  try {
    final sig = Asn1.parse(signature);
    final r = sig[0].integer;
    final s = sig[1].integer;
    final n = key.parameters!.n;
    if (r <= BigInt.zero || s <= BigInt.zero || r >= n || s >= n) return false;
    final signer = ECDSASigner()..init(false, PublicKeyParameter<ECPublicKey>(key));
    return signer.verifySignature(hash, ECSignature(r, s));
  } on Asn1Exception {
    return false;
  } on ArgumentError {
    return false;
  }
}

/// The digest that goes with a curve: SHA-256 for P-256, SHA-384 for P-384, SHA-512 above.
String digestForCurve(String? curve) => switch (curve) {
  Oid.secp384r1 || Oid.brainpoolP384r1 => Oid.sha384,
  Oid.secp521r1 || Oid.brainpoolP512r1 => Oid.sha512,
  _ => Oid.sha256,
};

/// ECDSA with a deterministic nonce (RFC 6979); [hash] was made with [digestOid].
Uint8List ecdsaSign(EcKeyMaterial key, String digestOid, Uint8List hash) {
  final mac = switch (digestOid) {
    Oid.sha384 => HMac(SHA384Digest(), 128),
    Oid.sha512 => HMac(SHA512Digest(), 128),
    _ => HMac(SHA256Digest(), 64),
  };
  final signer = ECDSASigner(null, mac)..init(true, PrivateKeyParameter<ECPrivateKey>(key.key));
  final sig = signer.generateSignature(hash) as ECSignature;
  final n = key.key.parameters!.n;
  // Low-s, as most verifiers prefer.
  final s = sig.s > (n >> 1) ? n - sig.s : sig.s;
  return derSequence([derInteger(sig.r), derInteger(s)]);
}

// ECDH (RFC 5753) -------------------------------------------------------------

int _fieldBytes(ECDomainParameters d) => (d.curve.fieldSize + 7) >> 3;

/// The shared secret Z: the x coordinate, left-padded to the field size.
Uint8List ecdhSecret(ECPrivateKey key, ECPublicKey peer) {
  final agreement = ECDHBasicAgreement()..init(key);
  return unsignedBytes(agreement.calculateAgreement(peer), _fieldBytes(key.parameters!));
}

/// A fresh key pair on [curve]: the private key and the uncompressed public point.
(ECPrivateKey, Uint8List) ecdhEphemeral(String? curve) {
  final domain = _domain(curve);
  final n = domain.n;
  BigInt d;
  do {
    d = bigIntFromBytes(randomBytes(((n.bitLength + 7) >> 3) + 8)) % n;
  } while (d == BigInt.zero);
  final q = (domain.G * d)!;
  return (ECPrivateKey(d, domain), q.getEncoded(false));
}

/// ANSI X9.63 KDF: Hash(Z ‖ counter ‖ sharedInfo) blocks.
Uint8List x963Kdf(Digest d, Uint8List z, Uint8List sharedInfo, int length) {
  final out = BytesBuilder(copy: false);
  for (var counter = 1; out.length < length; counter++) {
    out.add(
      _hash(d, [
        ...z,
        (counter >> 24) & 0xff,
        (counter >> 16) & 0xff,
        (counter >> 8) & 0xff,
        counter & 0xff,
        ...sharedInfo,
      ]),
    );
  }
  return Uint8List.fromList(Uint8List.sublistView(out.takeBytes(), 0, length));
}

// AES key wrap (RFC 3394) -----------------------------------------------------

final _wrapIv = Uint8List.fromList(List.filled(8, 0xa6));

Uint8List aesWrap(Uint8List kek, Uint8List key) {
  if (key.length % 8 != 0 || key.length < 16) throw ArgumentError('Key length');
  final aes = AESEngine()..init(true, KeyParameter(kek));
  final n = key.length ~/ 8;
  final a = Uint8List.fromList(_wrapIv);
  final r = [for (var i = 0; i < n; i++) Uint8List.fromList(key.sublist(i * 8, i * 8 + 8))];
  final block = Uint8List(16);
  final out = Uint8List(16);
  for (var j = 0; j < 6; j++) {
    for (var i = 0; i < n; i++) {
      block
        ..setRange(0, 8, a)
        ..setRange(8, 16, r[i]);
      aes.processBlock(block, 0, out, 0);
      final t = n * j + i + 1;
      a.setRange(0, 8, out);
      for (var b = 0; b < 4; b++) {
        a[7 - b] ^= (t >> (8 * b)) & 0xff;
      }
      r[i].setRange(0, 8, out, 8);
    }
  }
  return Uint8List.fromList([...a, for (final x in r) ...x]);
}

Uint8List aesUnwrap(Uint8List kek, Uint8List wrapped) {
  if (wrapped.length % 8 != 0 || wrapped.length < 24) {
    throw const SmimeException(SmimeErrorKind.malformed, 'The wrapped key is damaged.');
  }
  final aes = AESEngine()..init(false, KeyParameter(kek));
  final n = wrapped.length ~/ 8 - 1;
  final a = Uint8List.fromList(wrapped.sublist(0, 8));
  final r = [for (var i = 0; i < n; i++) Uint8List.fromList(wrapped.sublist(8 + i * 8, 16 + i * 8))];
  final block = Uint8List(16);
  final out = Uint8List(16);
  for (var j = 5; j >= 0; j--) {
    for (var i = n - 1; i >= 0; i--) {
      final t = n * j + i + 1;
      for (var b = 0; b < 4; b++) {
        a[7 - b] ^= (t >> (8 * b)) & 0xff;
      }
      block
        ..setRange(0, 8, a)
        ..setRange(8, 16, r[i]);
      aes.processBlock(block, 0, out, 0);
      a.setRange(0, 8, out);
      r[i].setRange(0, 8, out, 8);
    }
  }
  if (!_constantEquals(a, _wrapIv)) {
    throw const SmimeException(SmimeErrorKind.noKey, 'This message can’t be decrypted with your key.');
  }
  return Uint8List.fromList([for (final x in r) ...x]);
}

// Content ciphers -------------------------------------------------------------

Uint8List _cbc(BlockCipher engine, bool encrypt, Uint8List key, Uint8List iv, Uint8List data, {int? rc2Bits}) {
  final cbc = CBCBlockCipher(engine)
    ..init(encrypt, ParametersWithIV(rc2Bits == null ? KeyParameter(key) : RC2Parameters(key, bits: rc2Bits), iv));
  final bs = cbc.blockSize;
  if (encrypt) {
    final pad = bs - data.length % bs;
    final input = Uint8List(data.length + pad)
      ..setRange(0, data.length, data)
      ..fillRange(data.length, data.length + pad, pad);
    final out = Uint8List(input.length);
    for (var i = 0; i < input.length; i += bs) {
      cbc.processBlock(input, i, out, i);
    }
    return out;
  }
  if (data.isEmpty || data.length % bs != 0) {
    throw const SmimeException(SmimeErrorKind.malformed, 'The encrypted content is damaged.');
  }
  final out = Uint8List(data.length);
  for (var i = 0; i < data.length; i += bs) {
    cbc.processBlock(data, i, out, i);
  }
  final pad = out.last;
  var good = pad >= 1 && pad <= bs;
  for (var i = 0; good && i < pad; i++) {
    if (out[out.length - 1 - i] != pad) good = false;
  }
  if (!good) throw const SmimeException(SmimeErrorKind.malformed, 'The encrypted content is damaged.');
  return Uint8List.sublistView(out, 0, out.length - pad);
}

Uint8List aesCbc(bool encrypt, Uint8List key, Uint8List iv, Uint8List data) =>
    _cbc(AESEngine(), encrypt, key, iv, data);

Uint8List desEde3CbcDecrypt(Uint8List key, Uint8List iv, Uint8List data) => _cbc(DESedeEngine(), false, key, iv, data);

Uint8List desEde3CbcEncrypt(Uint8List key, Uint8List iv, Uint8List data) => _cbc(DESedeEngine(), true, key, iv, data);

Uint8List rc2CbcDecrypt(Uint8List key, int effectiveBits, Uint8List iv, Uint8List data) =>
    _cbc(RC2Engine(), false, key, iv, data, rc2Bits: effectiveBits);

/// AES-GCM; [data] ends with the tag when decrypting, and the tag is appended when encrypting.
Uint8List aesGcm(bool encrypt, Uint8List key, Uint8List nonce, int tagLength, Uint8List data, [Uint8List? aad]) {
  final gcm = GCMBlockCipher(AESEngine())
    ..init(encrypt, AEADParameters(KeyParameter(key), tagLength * 8, nonce, aad ?? Uint8List(0)));
  try {
    return gcm.process(data);
  } on InvalidCipherTextException {
    throw const SmimeException(SmimeErrorKind.malformed, 'The encrypted content was changed on the way.');
  } on ArgumentError {
    throw const SmimeException(SmimeErrorKind.malformed, 'The encrypted content was changed on the way.');
  }
}

bool _constantEquals(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  var d = 0;
  for (var i = 0; i < a.length; i++) {
    d |= a[i] ^ b[i];
  }
  return d == 0;
}

bool constantEquals(List<int> a, List<int> b) => _constantEquals(a, b);
