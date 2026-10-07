/// Certificates made in Dart for tests of chain validation: EC P-256 keys
/// from a seed, and certificates with whatever fields a test needs, really
/// signed by the issuer's key.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/der.dart';
import 'package:mail_crypto/src/smime/oids.dart';
import 'package:mail_crypto/src/smime/primitives.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256r1.dart';

final class TestKey {
  factory TestKey(String seed) {
    final domain = ECCurve_secp256r1();
    final d = bigIntFromBytes(SHA256Digest().process(utf8.encode(seed))) % domain.n;
    return TestKey._(EcKeyMaterial(ECPrivateKey(d, domain), Oid.secp256r1));
  }
  TestKey._(this.material);

  final EcKeyMaterial material;

  Uint8List get point => material.publicPoint.getEncoded(false);

  Uint8List get spki => derSequence([derAlgorithm(Oid.ecPublicKey, derOid(Oid.secp256r1)), derBitString(point)]);

  /// SHA-256 of the point, as a subject key identifier.
  Uint8List get keyId => Uint8List.sublistView(SHA256Digest().process(point), 0, 20);

  /// An ECDSA-with-SHA-256 signature over [data].
  Uint8List sign(List<int> data) => ecdsaSign(material, Oid.sha256, digest(Oid.sha256, data));
}

/// An RSA SubjectPublicKeyInfo with modulus [n] and exponent [e].
Uint8List rsaSpki(BigInt n, BigInt e) => derSequence([
  derAlgorithm(Oid.rsaEncryption, derNull),
  derBitString(derSequence([derInteger(n), derInteger(e)])),
]);

Uint8List name(String cn, {String? org}) => derSequence([
  if (org != null)
    derSet([
      derSequence([derOid(Oid.organization), derUtf8(org)]),
    ]),
  derSet([
    derSequence([derOid(Oid.commonName), derUtf8(cn)]),
  ]),
]);

Uint8List extension(String oid, List<int> value, {bool critical = false}) =>
    derSequence([derOid(oid), if (critical) derBoolean(true), derOctets(value)]);

Uint8List basicConstraints({bool ca = true, int? pathLen}) => extension(
  Oid.basicConstraints,
  derSequence([if (ca) derBoolean(true), if (pathLen != null) derInt(pathLen)]),
  critical: true,
);

/// keyUsage with the named bits set ([KeyUsage] values).
Uint8List keyUsage(int bits) {
  var last = 0;
  for (var i = 0; i < 16; i++) {
    if (bits & (1 << i) != 0) last = i;
  }
  final bytes = Uint8List(last ~/ 8 + 1);
  for (var i = 0; i <= last; i++) {
    if (bits & (1 << i) != 0) bytes[i ~/ 8] |= 0x80 >> (i % 8);
  }
  final unused = 7 - last % 8;
  return extension(Oid.keyUsage, der(Tag.bitString, [unused, ...bytes]), critical: true);
}

Uint8List extendedKeyUsage(List<String> oids) =>
    extension(Oid.extKeyUsage, derSequence([for (final o in oids) derOid(o)]));

Uint8List subjectAltEmails(List<String> emails) => extension(
  Oid.subjectAltName,
  derSequence([for (final e in emails) derContext(1, ascii.encode(e), constructed: false)]),
);

Uint8List subjectKeyId(TestKey key) => extension(Oid.subjectKeyIdentifier, derOctets(key.keyId));

Uint8List authorityKeyId(TestKey key) =>
    extension(Oid.authorityKeyIdentifier, derSequence([derContext(0, key.keyId, constructed: false)]));

/// A certificate of [key] named [subject], issued by [issuer] (its name)
/// and signed with [issuerKey].
SmimeCertificate makeCertificate({
  required TestKey key,
  required Uint8List subject,
  required Uint8List issuer,
  required TestKey issuerKey,
  int serial = 1,
  int version = 3,
  DateTime? notBefore,
  DateTime? notAfter,
  List<Uint8List> extensions = const [],
  String? outerAlgorithm,
  Uint8List? spki,
}) {
  final alg = derAlgorithm(Oid.ecdsaWithSha256);
  final tbs = derSequence([
    if (version > 1) derContext(0, derInt(version - 1)),
    derInt(serial),
    alg,
    issuer,
    derSequence([derTime(notBefore ?? DateTime.utc(2025)), derTime(notAfter ?? DateTime.utc(2040))]),
    subject,
    spki ?? key.spki,
    if (version >= 3 && extensions.isNotEmpty) derContext(3, derSequence(extensions)),
  ]);
  final cert = derSequence([
    tbs,
    outerAlgorithm == null ? alg : derAlgorithm(outerAlgorithm),
    derBitString(issuerKey.sign(tbs)),
  ]);
  return SmimeCertificate.fromDer(cert);
}

/// A CA: self-signed when [issuerKey] is null.
SmimeCertificate makeCa(
  String cn,
  TestKey key, {
  TestKey? issuerKey,
  Uint8List? issuer,
  int serial = 1,
  int version = 3,
  List<Uint8List>? extensions,
}) => makeCertificate(
  key: key,
  subject: name(cn),
  issuer: issuer ?? name(cn),
  issuerKey: issuerKey ?? key,
  serial: serial,
  version: version,
  extensions: extensions ?? [basicConstraints(), keyUsage(KeyUsage.keyCertSign | KeyUsage.crlSign), subjectKeyId(key)],
);

/// A mail user's certificate for [email], issued by [issuerCn] with [issuerKey].
SmimeCertificate makeUser(
  String email,
  TestKey key, {
  required String issuerCn,
  required TestKey issuerKey,
  int serial = 100,
  int version = 3,
  List<Uint8List>? extensions,
}) => makeCertificate(
  key: key,
  subject: name(email),
  issuer: name(issuerCn),
  issuerKey: issuerKey,
  serial: serial,
  version: version,
  extensions:
      extensions ??
      [
        basicConstraints(ca: false),
        keyUsage(KeyUsage.digitalSignature | KeyUsage.keyAgreement),
        extendedKeyUsage([Oid.emailProtection]),
        subjectAltEmails([email]),
      ],
);
