/// Where an S/MIME private key lives: in the app (PKCS #8 bytes), or in the
/// platform's keystore (Android KeyChain), where it never leaves and the
/// platform does what the key must do.
library;

import 'dart:typed_data';

import 'package:pointycastle/digests/sha256.dart';

import 'certificate.dart';
import 'der.dart' show hex;

/// A private key, wherever it is. The backend signs and decrypts with
/// either kind ([SmimePrivateKey], [SmimePlatformKey]).
sealed class SmimeKeyHandle {
  const SmimeKeyHandle();
}

/// A private key in the app: PKCS #8 (unencrypted PrivateKeyInfo), backend-neutral.
final class SmimePrivateKey extends SmimeKeyHandle {
  const SmimePrivateKey(this.pkcs8);
  final Uint8List pkcs8;
}

/// What a platform key is asked to do.
enum SmimeKeyOperation {
  /// Sign [SmimeKeyRequest.input] (the DER signed attributes) with
  /// [SmimeKeyRequest.digest]: RSASSA-PKCS1-v1_5 for RSA, ECDSA (DER) for EC.
  sign,

  /// RSAES-PKCS1-v1_5 decryption of a content-encryption key.
  decryptPkcs1,

  /// RSAES-OAEP decryption of a content-encryption key, with
  /// [SmimeKeyRequest.digest] and MGF1 with [SmimeKeyRequest.mgfDigest].
  decryptOaep,

  /// ECDH with the peer's public key ([SmimeKeyRequest.input], a DER
  /// SubjectPublicKeyInfo): the shared secret Z (the x coordinate).
  agree,
}

/// One operation a [SmimePlatformKey] must do before the work can go on.
/// Plain data: it crosses isolates and goes over a platform channel.
final class SmimeKeyRequest {
  const SmimeKeyRequest({
    required this.alias,
    required this.operation,
    required this.input,
    required this.keyType,
    this.digest,
    this.mgfDigest,
  });

  /// The key's name in the platform keystore.
  final String alias;
  final SmimeKeyOperation operation;

  /// The data to sign, the encrypted key, or the peer's public key.
  final Uint8List input;

  /// The key's type, from its certificate.
  final SmimeKeyType keyType;

  /// `SHA-256`, `SHA-384`, `SHA-512` (or `SHA-1` for OAEP): the platform's names.
  final String? digest;

  /// OAEP's MGF1 digest, as [digest].
  final String? mgfDigest;

  /// The same request always has the same id: where its answer is kept
  /// ([SmimePlatformKey.answers]).
  String get id => [alias, operation.name, digest ?? '', mgfDigest ?? '', hex(SHA256Digest().process(input))].join('|');

  @override
  String toString() => 'SmimeKeyRequest(${operation.name}, $alias, ${input.length} bytes)';
}

/// A private key that the platform keeps (Android KeyChain, installed by
/// device management or the user), known by its [alias]. The backend
/// can't use it directly: what it needs is asked for with a
/// [SmimeKeyRequired] (a [SmimeKeyRequest]), the platform answers
/// ([SmimePlatformKeys]), and the work is done again with the answer in
/// [answers]. Everything else (CMS, digests, key derivation, content
/// decryption) stays in Dart.
final class SmimePlatformKey extends SmimeKeyHandle {
  const SmimePlatformKey(this.alias, {this.answers = const {}});

  final String alias;

  /// Answers known so far, by [SmimeKeyRequest.id].
  final Map<String, Uint8List> answers;

  SmimePlatformKey withAnswers(Map<String, Uint8List> more) =>
      more.isEmpty ? this : SmimePlatformKey(alias, answers: {...answers, ...more});

  /// The answer to [request], or a [SmimeKeyRequired] for it.
  Uint8List answer(SmimeKeyRequest request) => answers[request.id] ?? (throw SmimeKeyRequired(request));
}

/// A [SmimePlatformKey] must do [request] first; nothing was done. The
/// caller asks the platform ([SmimePlatformKeys.perform]) and runs the work
/// again with the answer.
final class SmimeKeyRequired extends SmimeException {
  SmimeKeyRequired(this.request)
    : super(SmimeErrorKind.locked, 'The certificate on this device is needed for this message.');

  final SmimeKeyRequest request;
}

/// The platform side of [SmimePlatformKey]s: Android's KeyChain through a
/// platform channel in the app.
abstract interface class SmimePlatformKeys {
  /// Does [request] with the key in the platform keystore. Throws
  /// [SmimeException]: [SmimeErrorKind.locked] when the key isn't there or
  /// Loupe may not use it anymore, [SmimeErrorKind.malformed] for a
  /// decryption the key refused (bad padding), [SmimeErrorKind.unsupported]
  /// for an operation the platform can't do with it.
  Future<Uint8List> perform(SmimeKeyRequest request);
}
