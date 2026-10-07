/// The platform's side of [SmimePlatformKey]s, in Dart.
library;

import 'dart:typed_data';

import 'certificate.dart';
import 'der.dart';
import 'key_handle.dart';
import 'oids.dart';
import 'primitives.dart';

/// What a platform keystore (Android's KeyChain) does with a key, done in
/// Dart with keys held here under their aliases: Java's
/// `SHA256withRSA`/`SHA256withECDSA` signatures, `RSA/ECB/PKCS1Padding`
/// and OAEP decryption, and ECDH. The reference for the platform side, and
/// its stand-in in tests.
final class SoftwareSmimeKeystore implements SmimePlatformKeys {
  SoftwareSmimeKeystore(this.keys);

  /// Keys by alias.
  final Map<String, SmimePrivateKey> keys;

  /// What was asked, in order.
  final requests = <SmimeKeyRequest>[];

  @override
  Future<Uint8List> perform(SmimeKeyRequest request) async {
    requests.add(request);
    final key = keys[request.alias];
    if (key == null) throw const SmimeException(SmimeErrorKind.locked, 'There is no such key on this device.');
    final material = PrivateKeyMaterial.parse(key);
    final digestOid = _oid(request.digest ?? 'SHA-256');
    switch (request.operation) {
      case SmimeKeyOperation.sign:
        final hash = digest(digestOid, request.input);
        return switch (material) {
          RsaKeyMaterial() => rsaPkcs1Sign(material, digestOid, hash),
          EcKeyMaterial() => ecdsaSign(material, digestOid, hash),
        };
      case SmimeKeyOperation.decryptPkcs1:
        if (material is! RsaKeyMaterial) throw _unsupported;
        // A bad padding gives random bytes, as for keys in the app (Java's Cipher throws instead).
        return rsaPkcs1DecryptKey(material, request.input, null);
      case SmimeKeyOperation.decryptOaep:
        if (material is! RsaKeyMaterial) throw _unsupported;
        final mgf = digestFor(_oid(request.mgfDigest ?? request.digest ?? 'SHA-1'))!;
        return rsaOaepDecrypt(material, digestFor(digestOid)!, mgf, Uint8List(0), request.input);
      case SmimeKeyOperation.agree:
        if (material is! EcKeyMaterial) throw _unsupported;
        final spki = Asn1.parse(request.input);
        return ecdhSecret(material.key, ecPublicKey(spki[0][1].oid, spki[1].bits));
    }
  }

  static const _unsupported = SmimeException(SmimeErrorKind.unsupported, 'This key can’t do that.');

  static String _oid(String javaName) => switch (javaName) {
    'SHA-1' => Oid.sha1,
    'SHA-224' => Oid.sha224,
    'SHA-384' => Oid.sha384,
    'SHA-512' => Oid.sha512,
    _ => Oid.sha256,
  };
}
