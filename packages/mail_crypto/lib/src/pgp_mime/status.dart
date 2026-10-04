/// What OpenPGP did to a received message: decrypted it, checked its
/// signature, found protected headers.
library;

import '../pgp/types.dart';

/// Why an encrypted message wasn't decrypted.
enum PgpDecryptFailure {
  /// None of the user's keys is a recipient.
  noSecretKey,

  /// The right key is locked and the passphrase wasn't given.
  locked,

  /// The data is damaged, or not integrity protected (no MDC).
  damaged,

  /// An algorithm the backend doesn't support.
  unsupported,
}

/// How the message is protected, judged from its outer structure.
enum PgpProtection {
  none,

  /// RFC 3156 `multipart/encrypted`.
  pgpMimeEncrypted,

  /// RFC 3156 `multipart/signed`.
  pgpMimeSigned,

  /// An inline `-----BEGIN PGP MESSAGE-----` block.
  inlineEncrypted,

  /// An inline `-----BEGIN PGP SIGNED MESSAGE-----` block.
  inlineSigned,
}

/// The outcome for one message.
final class PgpMessageStatus {
  const PgpMessageStatus({
    this.protection = PgpProtection.none,
    this.encrypted = false,
    this.failure,
    this.failureMessage,
    this.signature,
    this.recipientKeyIds = const [],
    this.protectedHeaders = const [],
    this.gossip = const [],
    this.partial = false,
  });

  static const none = PgpMessageStatus();

  final PgpProtection protection;

  /// The message was encrypted (whether or not it could be decrypted).
  final bool encrypted;

  /// Set when an encrypted message couldn't be decrypted.
  final PgpDecryptFailure? failure;
  final String? failureMessage;

  /// The (first) signature's check; null when the message isn't signed.
  final PgpSignatureCheck? signature;

  /// Key ids the message is encrypted to.
  final List<String> recipientKeyIds;

  /// Header fields from inside the encrypted (or signed) part: the real
  /// Subject when the outer one is `...`, From, To, Cc (RFC 2047 decoded).
  final List<(String, String)> protectedHeaders;

  /// `Autocrypt-Gossip` header values found inside the encrypted part.
  final List<String> gossip;

  /// Inline PGP with other text around the block (a mailing list footer,
  /// a forwarded fragment): only part of what is shown is protected.
  final bool partial;

  bool get decrypted => encrypted && failure == null;
  bool get isSigned => signature != null;
  bool get isInline => protection == PgpProtection.inlineEncrypted || protection == PgpProtection.inlineSigned;

  /// The protected Subject, if any.
  String? get protectedSubject => protectedHeader('subject');

  String? protectedHeader(String name) {
    final n = name.toLowerCase();
    for (final (k, v) in protectedHeaders) {
      if (k.toLowerCase() == n) return v;
    }
    return null;
  }

  PgpMessageStatus copyWith({PgpSignatureCheck? signature}) => PgpMessageStatus(
    protection: protection,
    encrypted: encrypted,
    failure: failure,
    failureMessage: failureMessage,
    signature: signature ?? this.signature,
    recipientKeyIds: recipientKeyIds,
    protectedHeaders: protectedHeaders,
    gossip: gossip,
    partial: partial,
  );

  @override
  String toString() =>
      'PgpMessageStatus(${protection.name}, encrypted: $encrypted, failure: $failure, signature: $signature)';
}
