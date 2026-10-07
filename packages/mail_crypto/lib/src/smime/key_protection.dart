/// Optional passphrase protection of S/MIME private keys at rest, on top
/// of the keychain: the PKCS #8 key encrypted with AES-256-GCM under a key
/// derived from the passphrase with Argon2id.
///
/// Argon2id (RFC 9106) from pointycastle (maintained, pure Dart, already
/// S/MIME's primitives), with RFC 9106's choice for memory-constrained
/// devices: 64 MiB, 3 passes, 4 lanes (about a second on the development
/// machine, as OpenPGP keys from Thunderbird take to unlock; a few on a
/// phone). PBKDF2-SHA256 would need hundreds of thousands of iterations,
/// which take pointycastle six seconds here, and resists GPUs less.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/key_derivators/api.dart' show Argon2Parameters;
import 'package:pointycastle/key_derivators/argon2.dart';

import 'certificate.dart';
import 'primitives.dart';

/// The Argon2id cost of a protected key.
final class SmimeKdfParameters {
  const SmimeKdfParameters({this.memoryPowerOf2 = 16, this.iterations = 3, this.lanes = 4});

  /// RFC 9106's choice for devices with little memory: 64 MiB, t = 3, p = 4.
  static const standard = SmimeKdfParameters();

  /// Memory in KiB, as a power of 2 (16: 64 MiB).
  final int memoryPowerOf2;
  final int iterations;
  final int lanes;

  /// Within what Loupe makes and can afford: a stored entry asking for
  /// gigabytes or hours is damaged.
  bool get reasonable =>
      memoryPowerOf2 >= 10 && memoryPowerOf2 <= 18 && iterations >= 1 && iterations <= 10 && lanes >= 1 && lanes <= 16;
}

/// A private key encrypted with a passphrase: what the keychain entry
/// holds instead of the bare PKCS #8 key.
final class SmimeProtectedKey {
  const SmimeProtectedKey({required this.kdf, required this.salt, required this.nonce, required this.ciphertext});

  final SmimeKdfParameters kdf;
  final Uint8List salt;
  final Uint8List nonce;

  /// The PKCS #8 key encrypted with AES-256-GCM, the 16-octet tag at its end.
  final Uint8List ciphertext;

  static const _version = 1;

  /// Whether a stored entry is a protected key (JSON) rather than a bare one (base64).
  static bool isProtected(String stored) => stored.trimLeft().startsWith('{');

  String encode() => jsonEncode({
    'v': _version,
    'kdf': 'argon2id',
    'm': kdf.memoryPowerOf2,
    't': kdf.iterations,
    'p': kdf.lanes,
    'salt': base64.encode(salt),
    'nonce': base64.encode(nonce),
    'ct': base64.encode(ciphertext),
  });

  /// Throws [SmimeException] ([SmimeErrorKind.malformed]) for an entry it can't read.
  static SmimeProtectedKey decode(String stored) {
    try {
      final j = (jsonDecode(stored) as Map).cast<String, Object?>();
      final kdf = SmimeKdfParameters(memoryPowerOf2: j['m']! as int, iterations: j['t']! as int, lanes: j['p']! as int);
      final key = SmimeProtectedKey(
        kdf: kdf,
        salt: base64.decode(j['salt']! as String),
        nonce: base64.decode(j['nonce']! as String),
        ciphertext: base64.decode(j['ct']! as String),
      );
      if (j['v'] != _version ||
          j['kdf'] != 'argon2id' ||
          !kdf.reasonable ||
          key.salt.length < 16 ||
          key.nonce.length != 12 ||
          key.ciphertext.length < 17) {
        throw const FormatException('Unknown protection');
      }
      return key;
    } on Object catch (e) {
      throw SmimeException(SmimeErrorKind.malformed, 'The stored private key is damaged.', e);
    }
  }
}

Uint8List _kek(String passphrase, Uint8List salt, SmimeKdfParameters kdf) {
  final generator = Argon2BytesGenerator()
    ..init(
      Argon2Parameters(
        Argon2Parameters.ARGON2_id,
        salt,
        desiredKeyLength: 32,
        iterations: kdf.iterations,
        lanes: kdf.lanes,
        memoryPowerOf2: kdf.memoryPowerOf2,
      ),
    );
  return generator.process(Uint8List.fromList(utf8.encode(passphrase)));
}

/// What the encryption is bound to: the format and the certificate, so a
/// protected key can't be passed off as another certificate's.
Uint8List _associated(String fingerprint) => Uint8List.fromList(utf8.encode('loupe-smime-key-v1:$fingerprint'));

/// [key] encrypted with [passphrase] (Argon2id, AES-256-GCM), bound to the
/// certificate [fingerprint]. Takes about a second: run it off the UI isolate.
SmimeProtectedKey protectKey(
  SmimePrivateKey key,
  String passphrase, {
  required String fingerprint,
  SmimeKdfParameters kdf = SmimeKdfParameters.standard,
}) {
  if (passphrase.isEmpty) throw ArgumentError.value(passphrase, 'passphrase', 'Empty');
  final salt = randomBytes(16);
  final nonce = randomBytes(12);
  final ciphertext = aesGcm(true, _kek(passphrase, salt, kdf), nonce, 16, key.pkcs8, _associated(fingerprint));
  return SmimeProtectedKey(kdf: kdf, salt: salt, nonce: nonce, ciphertext: ciphertext);
}

/// The key in [protected], with [passphrase]. Throws [SmimeException]:
/// [SmimeErrorKind.wrongPassword] when the passphrase (or the certificate
/// [fingerprint]) isn't the one it was protected with. Takes about a second.
SmimePrivateKey unprotectKey(SmimeProtectedKey protected, String passphrase, {required String fingerprint}) {
  if (!protected.kdf.reasonable) throw const SmimeException(SmimeErrorKind.malformed, 'The stored key is damaged.');
  try {
    final kek = _kek(passphrase, protected.salt, protected.kdf);
    return SmimePrivateKey(aesGcm(false, kek, protected.nonce, 16, protected.ciphertext, _associated(fingerprint)));
  } on SmimeException {
    throw const SmimeException(SmimeErrorKind.wrongPassword, 'That passphrase is wrong.');
  }
}
