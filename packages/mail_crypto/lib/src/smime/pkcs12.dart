/// PKCS #12 (`.p12`, `.pfx`, RFC 7292) import: the user's private key and
/// certificate chain, as Windows, macOS, Thunderbird and OpenSSL export them.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/digests/sha1.dart';
import 'package:pointycastle/key_derivators/api.dart';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/key_derivators/pkcs12_parameter_generator.dart';
import 'package:pointycastle/macs/hmac.dart';

import 'certificate.dart';
import 'der.dart';
import 'oids.dart';
import 'primitives.dart';

/// A private key with its certificate, from a PKCS #12 file.
final class SmimeKeyEntry {
  const SmimeKeyEntry({required this.key, required this.certificate, this.friendlyName});
  final SmimePrivateKey key;
  final SmimeCertificate certificate;
  final String? friendlyName;
}

/// What a PKCS #12 file holds: keys with their certificates, and every
/// certificate (the CA chain too).
final class SmimeBundle {
  const SmimeBundle({required this.keys, required this.certificates});
  final List<SmimeKeyEntry> keys;
  final List<SmimeCertificate> certificates;

  /// The certificates that aren't one of [keys]' own (the issuers).
  List<SmimeCertificate> get chain => [
    for (final c in certificates)
      if (!keys.any((k) => k.certificate == c)) c,
  ];
}

/// Reads a PKCS #12 file protected by [password]. Throws [SmimeException]:
/// [SmimeErrorKind.wrongPassword], [SmimeErrorKind.malformed] or
/// [SmimeErrorKind.unsupported].
SmimeBundle readPkcs12(Uint8List data, String password) {
  try {
    return _Pkcs12(password).read(data);
  } on SmimeException {
    rethrow;
  } on Object catch (e) {
    // Hostile input can trip anything in the parsers (a missing element, a
    // bad curve point): it is damaged data, never a crash.
    throw SmimeException(SmimeErrorKind.malformed, 'This file isn’t a PKCS #12 certificate file, or it is damaged.', e);
  }
}

final class _Pkcs12 {
  _Pkcs12(this.password);
  final String password;

  /// PKCS #12 passwords are BMPStrings with a terminating zero (RFC 7292 B.1).
  /// An empty password is tried both as two zero octets and as nothing.
  List<Uint8List> get _bmpPasswords {
    final units = <int>[];
    for (final r in password.runes) {
      if (r > 0xffff) {
        final v = r - 0x10000;
        units
          ..add(0xd800 + (v >> 10))
          ..add(0xdc00 + (v & 0x3ff));
      } else {
        units.add(r);
      }
    }
    final bmp = Uint8List.fromList([
      for (final u in units) ...[u >> 8, u & 0xff],
      0,
      0,
    ]);
    return password.isEmpty ? [bmp, Uint8List(0)] : [bmp];
  }

  late Uint8List _bmp = _bmpPasswords.first;

  SmimeBundle read(Uint8List data) {
    final pfx = Asn1.parse(data)..expect(Tag.sequence, 'PFX');
    final authSafe = pfx[1];
    if (authSafe[0].oid != Oid.data) {
      throw const SmimeException(SmimeErrorKind.unsupported, 'PKCS #12 files signed with a key aren’t supported.');
    }
    final content = authSafe[1][0].octets;
    if (pfx.length > 2) _checkMac(pfx[2], content);
    final keys = <(Uint8List?, String?, SmimePrivateKey)>[];
    final certs = <(Uint8List?, SmimeCertificate)>[];
    for (final info in Asn1.parse(content).children) {
      final type = info[0].oid;
      Uint8List safeContents;
      if (type == Oid.data) {
        safeContents = info[1][0].octets;
      } else if (type == Oid.encryptedData) {
        final eci = info[1][0][1];
        final encrypted = eci.context(0);
        if (encrypted == null) continue;
        safeContents = _decrypt(eci[1], encrypted.constructed ? encrypted.octets : encrypted.content);
      } else {
        continue;
      }
      for (final bag in Asn1.parse(safeContents).children) {
        _bag(bag, keys, certs);
      }
    }
    final entries = <SmimeKeyEntry>[];
    for (final (id, name, key) in keys) {
      final material = PrivateKeyMaterial.parse(key);
      final cert =
          certs.where((c) => id != null && c.$1 != null && constantEquals(c.$1!, id)).map((c) => c.$2).firstOrNull ??
          certs.where((c) => material.matches(c.$2)).map((c) => c.$2).firstOrNull;
      if (cert == null || !material.matches(cert)) continue;
      entries.add(SmimeKeyEntry(key: key, certificate: cert, friendlyName: name));
    }
    return SmimeBundle(keys: entries, certificates: [for (final c in certs) c.$2]);
  }

  void _bag(Asn1 bag, List<(Uint8List?, String?, SmimePrivateKey)> keys, List<(Uint8List?, SmimeCertificate)> certs) {
    final id = bag[0].oid;
    final value = bag[1][0];
    Uint8List? localKeyId;
    String? friendlyName;
    if (bag.length > 2) {
      for (final attr in bag[2].children) {
        final values = attr[1].children;
        if (values.isEmpty) continue;
        if (attr[0].oid == Oid.localKeyId) localKeyId = values.first.octets;
        if (attr[0].oid == Oid.friendlyName) friendlyName = values.first.string;
      }
    }
    switch (id) {
      case Oid.keyBag:
        keys.add((localKeyId, friendlyName, SmimePrivateKey(value.encoded)));
      case Oid.pkcs8ShroudedKeyBag:
        final pkcs8 = _decrypt(value[0], value[1].octets);
        keys.add((localKeyId, friendlyName, SmimePrivateKey(Asn1.parse(pkcs8).encoded)));
      case Oid.certBag:
        if (value[0].oid != Oid.x509Certificate) return;
        try {
          certs.add((localKeyId, SmimeCertificate.fromDer(value[1][0].octets)));
        } on SmimeException {
          // A certificate this parser can't read is left out.
        }
    }
  }

  void _checkMac(Asn1 macData, Uint8List content) {
    final digestInfo = macData[0];
    final algorithm = digestInfo[0][0].oid;
    final expected = digestInfo[1].octets;
    if (algorithm == Oid.pbmac1) {
      // RFC 9579: PBKDF2 over the UTF-8 password, then HMAC.
      final params = digestInfo[0][1];
      final kdf = params[0];
      final hmacOid = params[1][0].oid;
      final key = _pbkdf2(kdf[1], utf8.encode(password));
      final mac = _hmacFor(hmacOid)..init(KeyParameter(key));
      if (!constantEquals(mac.process(content), expected)) throw _wrongPassword;
      return;
    }
    final digest = digestFor(algorithm);
    if (digest == null) {
      throw SmimeException(SmimeErrorKind.unsupported, 'The integrity check ${digestName(algorithm)} isn’t supported.');
    }
    final salt = macData[1].octets;
    final iterations = macData.length > 2 ? macData[2].intValue : 1;
    for (final bmp in _bmpPasswords) {
      final gen = PKCS12ParametersGenerator(digestFor(algorithm)!)..init(bmp, salt, iterations);
      final key = gen.generateDerivedMacParameters(digest.digestSize);
      final mac = HMac(digestFor(algorithm)!, digest.byteLength)..init(key);
      if (constantEquals(mac.process(content), expected)) {
        _bmp = bmp;
        return;
      }
    }
    throw _wrongPassword;
  }

  static const _wrongPassword = SmimeException(SmimeErrorKind.wrongPassword, 'That password is wrong.');

  HMac _hmacFor(String oid) {
    final (digest, blockLength) = switch (oid) {
      Oid.hmacSha1 => (Oid.sha1, 64),
      Oid.hmacSha224 => (Oid.sha224, 64),
      Oid.hmacSha256 => (Oid.sha256, 64),
      Oid.hmacSha384 => (Oid.sha384, 128),
      Oid.hmacSha512 => (Oid.sha512, 128),
      _ => throw SmimeException(SmimeErrorKind.unsupported, 'The algorithm $oid isn’t supported.'),
    };
    return HMac(digestFor(digest)!, blockLength);
  }

  /// PBKDF2-params: salt, iterations, key length, PRF (HMAC-SHA1 by default).
  Uint8List _pbkdf2(Asn1 params, List<int> secret, {int? keyLength}) {
    final salt = params[0].octets;
    final iterations = params[1].intValue;
    var length = keyLength;
    var prf = Oid.hmacSha1;
    for (final p in params.children.skip(2)) {
      if (p.tag == Tag.integer) length = p.intValue;
      if (p.isSequence) prf = p[0].oid;
    }
    if (length == null) throw const SmimeException(SmimeErrorKind.malformed, 'The key length is missing.');
    final kdf = PBKDF2KeyDerivator(_hmacFor(prf))..init(Pbkdf2Parameters(salt, iterations, length));
    return kdf.process(Uint8List.fromList(secret));
  }

  Uint8List _decrypt(Asn1 algorithm, Uint8List data) {
    final oid = algorithm[0].oid;
    if (oid == Oid.pbes2) {
      final params = algorithm[1];
      final kdf = params[0];
      final scheme = params[1];
      if (kdf[0].oid != Oid.pbkdf2) throw const SmimeException(SmimeErrorKind.unsupported, 'Unknown key derivation.');
      final cipher = scheme[0].oid;
      final keyLength = switch (cipher) {
        Oid.aes128Cbc => 16,
        Oid.aes192Cbc => 24,
        Oid.aes256Cbc => 32,
        Oid.desEde3Cbc => 24,
        _ => throw SmimeException(SmimeErrorKind.unsupported, 'The cipher $cipher isn’t supported.'),
      };
      // PBES2 in PKCS #12 takes the password as UTF-8 (as OpenSSL and Windows write it).
      final key = _pbkdf2(kdf[1], utf8.encode(password), keyLength: keyLength);
      final iv = scheme[1].octets;
      try {
        return cipher == Oid.desEde3Cbc ? desEde3CbcDecrypt(key, iv, data) : aesCbc(false, key, iv, data);
      } on SmimeException {
        throw _wrongPassword;
      }
    }
    final (keyLength, rc2Bits) = switch (oid) {
      Oid.pbeSha13Des => (24, null),
      Oid.pbeSha12Des => (16, null),
      Oid.pbeSha1Rc2128 => (16, 128),
      Oid.pbeSha1Rc240 => (5, 40),
      _ => throw SmimeException(SmimeErrorKind.unsupported, 'The encryption $oid isn’t supported.'),
    };
    final params = algorithm[1];
    final salt = params[0].octets;
    final iterations = params[1].intValue;
    final gen = PKCS12ParametersGenerator(SHA1Digest())..init(_bmp, salt, iterations);
    final derived = gen.generateDerivedParametersWithIV(keyLength, 8);
    var key = (derived.parameters! as KeyParameter).key;
    final iv = derived.iv;
    try {
      if (rc2Bits != null) return rc2CbcDecrypt(key, rc2Bits, iv, data);
      if (key.length == 16) key = Uint8List.fromList([...key, ...key.sublist(0, 8)]);
      return desEde3CbcDecrypt(key, iv, data);
    } on SmimeException {
      throw _wrongPassword;
    }
  }
}
