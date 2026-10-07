/// What S/MIME did to a received message: decrypted it, checked its
/// signature and the signer's certificate.
library;

import 'certificate.dart';
import 'cms.dart';
import 'key_handle.dart';
import 'trust.dart';

/// How a message is protected, judged from its outer structure.
enum SmimeProtection {
  none,

  /// `application/pkcs7-mime; smime-type=enveloped-data`.
  enveloped,

  /// `application/pkcs7-mime; smime-type=authEnveloped-data` (AES-GCM).
  authEnveloped,

  /// `application/pkcs7-mime; smime-type=signed-data` (opaque signing, as Outlook can send).
  signedOpaque,

  /// `multipart/signed; protocol="application/pkcs7-signature"`.
  signedDetached,
}

/// Why an encrypted message wasn't decrypted.
enum SmimeDecryptFailure {
  /// None of the user's certificates is a recipient.
  noKey,

  /// The data is damaged or was changed (AES-GCM).
  damaged,

  /// An algorithm Loupe doesn't support.
  unsupported,

  /// The key is locked (its passphrase wasn't given), or it is on the
  /// device (Android KeyChain) and couldn't be used.
  locked,
}

/// The signature of a message, and its signer's certificate.
final class SmimeSignatureStatus {
  const SmimeSignatureStatus({
    required this.valid,
    this.certificate,
    this.signingTime,
    this.trust,
    this.problem,
    this.capabilities = const [],
    this.certificates = const [],
    this.modified = false,
    this.weak = false,
    this.dateMismatch = false,
  });

  /// The signature matches the content: it wasn't modified.
  final bool valid;

  /// The signature doesn't match: the message was changed after signing.
  final bool modified;

  /// Made with SHA-1 or MD5: not accepted.
  final bool weak;

  /// The signing time is more than an hour away from the message's Date
  /// (which the signature doesn't cover): an old signed message sent again,
  /// or a changed date. Thunderbird's rule.
  final bool dateMismatch;

  /// The signer's certificate; null when the message doesn't carry it.
  final SmimeCertificate? certificate;
  final DateTime? signingTime;

  /// The signer's certificate checked: chain, validity, usage, the sender's address.
  final SmimeTrustCheck? trust;

  /// Why the signature isn't valid, in words.
  final String? problem;

  /// SMIMECapabilities the signer announced (what their app can decrypt).
  final List<String> capabilities;

  /// Every certificate the message carried (the signer's chain).
  final List<SmimeCertificate> certificates;

  /// Valid, by a trusted certificate of the sender, at the message's date: "Signed by … ✓".
  bool get good => valid && !dateMismatch && (trust?.trusted ?? false);

  /// This signature, made bad: the message holds content it doesn't cover
  /// ([problem] says what), so it can't vouch for what is shown.
  SmimeSignatureStatus notCovering(String problem) => SmimeSignatureStatus(
    valid: false,
    certificate: certificate,
    signingTime: signingTime,
    trust: trust,
    problem: problem,
    capabilities: capabilities,
    certificates: certificates,
    modified: true,
    weak: weak,
    dateMismatch: dateMismatch,
  );

  SmimeSignatureStatus withDateMismatch() => SmimeSignatureStatus(
    valid: valid,
    certificate: certificate,
    signingTime: signingTime,
    trust: trust,
    problem: problem,
    capabilities: capabilities,
    certificates: certificates,
    modified: modified,
    weak: weak,
    dateMismatch: true,
  );
}

/// The outcome for one message.
final class SmimeMessageStatus {
  const SmimeMessageStatus({
    this.protection = SmimeProtection.none,
    this.encrypted = false,
    this.failure,
    this.failureMessage,
    this.cipher,
    this.authenticated = false,
    this.recipients = const [],
    this.signature,
    this.keyRequest,
    this.protectedHeaders = const [],
  });

  static const none = SmimeMessageStatus();

  /// The outermost protection.
  final SmimeProtection protection;

  /// The message was encrypted (whether or not it could be decrypted).
  final bool encrypted;
  final SmimeDecryptFailure? failure;
  final String? failureMessage;

  /// "AES-256-CBC", "AES-256-GCM", "3DES"…
  final String? cipher;

  /// AuthEnvelopedData: the encrypted content can't have been changed.
  final bool authenticated;

  /// Who the message is encrypted to.
  final List<SmimeRecipientId> recipients;

  /// The (first) signature; null when the message isn't signed.
  final SmimeSignatureStatus? signature;

  /// With [SmimeDecryptFailure.locked] for a key on the device: what it must
  /// do to decrypt the message ([SmimePlatformKeys.perform]); read the
  /// message again with the answer.
  final SmimeKeyRequest? keyRequest;

  /// Header fields from inside the signed or encrypted content (RFC 9788,
  /// or `protected-headers="v1"`): the real Subject when the outer one is
  /// `...`, From, To, Cc (RFC 2047 decoded).
  final List<(String, String)> protectedHeaders;

  /// The protected Subject, if any.
  String? get protectedSubject => protectedHeader('subject');

  String? protectedHeader(String name) {
    final n = name.toLowerCase();
    for (final (k, v) in protectedHeaders) {
      if (k.toLowerCase() == n) return v;
    }
    return null;
  }

  bool get decrypted => encrypted && failure == null;
  bool get isSigned => signature != null;

  @override
  String toString() =>
      'SmimeMessageStatus(${protection.name}, encrypted: $encrypted, failure: $failure, '
      'signature: ${signature?.valid}, trust: ${signature?.trust?.problems})';
}
