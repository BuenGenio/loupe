/// The swappable S/MIME engine, and the pure Dart one.
library;

import 'dart:typed_data';

import 'certificate.dart';
import 'cms.dart' as cms;
import 'cms.dart' show SmimeContentCipher, SmimeDecrypted, SmimeRecipientId, SmimeSignedData;
import 'pkcs12.dart' as pkcs12;
import 'key_handle.dart';
import 'pkcs12.dart' show SmimeBundle;

/// The user's certificate with its private key: in the app
/// ([SmimePrivateKey]) or on the device ([SmimePlatformKey]).
final class SmimeKeyPair {
  const SmimeKeyPair(this.certificate, this.key);
  final SmimeCertificate certificate;
  final SmimeKeyHandle key;
}

/// A detached or opaque SignedData, and its digest for `micalg`.
final class SmimeSignature {
  const SmimeSignature(this.data, this.micalg);

  /// The DER ContentInfo.
  final Uint8List data;

  /// `sha-256`, …
  final String micalg;
}

/// The S/MIME engine: PKCS #12, CMS and certificate signatures. Everything
/// is synchronous and pure, so a caller can run it in another isolate. A
/// platform engine (iOS Security.framework) could take its place;
/// certificates and keys are plain DER values. Keys the platform keeps
/// ([SmimePlatformKey], Android KeyChain) sign and decrypt through
/// [SmimeKeyRequest]s: [sign] and [decrypt] throw [SmimeKeyRequired] until
/// the key's answers are given.
abstract interface class SmimeBackend {
  /// The keys and certificates of a PKCS #12 file. Throws [SmimeException]
  /// ([SmimeErrorKind.wrongPassword] for a wrong [password]).
  SmimeBundle readPkcs12(Uint8List data, String password);

  /// Whether [issuer]'s key signed [cert].
  bool certificateSignedBy(SmimeCertificate cert, SmimeCertificate issuer);

  /// Checks a SignedData ContentInfo: opaque, or detached with [content].
  /// The signer's certificate comes from the message or [known].
  SmimeSignedData verify(Uint8List signedData, {Uint8List? content, List<SmimeCertificate> known = const []});

  /// Signs [content] (a MIME entity with CRLF line ends) as [signer],
  /// carrying [chain]; detached unless [detached] is false. A
  /// [SmimePlatformKey] without the signature throws [SmimeKeyRequired].
  SmimeSignature sign(
    Uint8List content,
    SmimeKeyPair signer, {
    List<SmimeCertificate> chain = const [],
    bool detached = true,
    DateTime? now,
    SmimeCertificate? encryptionCertificate,
  });

  /// Encrypts [content] to [recipients].
  Uint8List encrypt(
    Uint8List content,
    List<SmimeCertificate> recipients, {
    SmimeContentCipher cipher = SmimeContentCipher.aes256Cbc,
  });

  /// Decrypts an EnvelopedData or AuthEnvelopedData with one of [keys]
  /// (keys in the app first). A [SmimePlatformKey] that must decrypt the
  /// content key throws [SmimeKeyRequired] until it is given the answer.
  SmimeDecrypted decrypt(Uint8List envelope, List<SmimeKeyPair> keys);

  /// Who an EnvelopedData or AuthEnvelopedData is encrypted to.
  List<SmimeRecipientId> recipientsOf(Uint8List envelope);
}

/// S/MIME in pure Dart: CMS, X.509 and PKCS #12 here, the primitives from
/// pointycastle. Certificate signature checks are remembered (per isolate).
final class DartSmimeBackend implements SmimeBackend {
  const DartSmimeBackend();

  static final _checked = <String, bool>{};

  @override
  SmimeBundle readPkcs12(Uint8List data, String password) => pkcs12.readPkcs12(data, password);

  @override
  bool certificateSignedBy(SmimeCertificate cert, SmimeCertificate issuer) {
    final key = '${cert.fingerprint}/${issuer.fingerprint}';
    final known = _checked[key];
    if (known != null) return known;
    if (_checked.length > 512) _checked.clear();
    return _checked[key] = cms.certificateSignedBy(cert, issuer);
  }

  @override
  SmimeSignedData verify(Uint8List signedData, {Uint8List? content, List<SmimeCertificate> known = const []}) =>
      cms.verifySignedData(signedData, detached: content, known: known);

  @override
  SmimeSignature sign(
    Uint8List content,
    SmimeKeyPair signer, {
    List<SmimeCertificate> chain = const [],
    bool detached = true,
    DateTime? now,
    SmimeCertificate? encryptionCertificate,
  }) {
    final (data, micalg) = cms.createSignedData(
      content,
      certificate: signer.certificate,
      key: signer.key,
      chain: chain,
      detached: detached,
      signingTime: now,
      encryptionCertificate: encryptionCertificate,
    );
    return SmimeSignature(data, micalg);
  }

  @override
  Uint8List encrypt(
    Uint8List content,
    List<SmimeCertificate> recipients, {
    SmimeContentCipher cipher = SmimeContentCipher.aes256Cbc,
  }) => cms.createEnveloped(content, recipients, cipher: cipher);

  @override
  SmimeDecrypted decrypt(Uint8List envelope, List<SmimeKeyPair> keys) =>
      cms.decryptEnveloped(envelope, [for (final k in keys) (k.certificate, k.key)]);

  @override
  List<SmimeRecipientId> recipientsOf(Uint8List envelope) => cms.recipientsOf(envelope);
}
