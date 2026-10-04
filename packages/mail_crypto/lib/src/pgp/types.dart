/// Backend-neutral OpenPGP values: keys, signature checks, decryption results.
library;

import 'dart:typed_data';

enum PgpErrorKind {
  /// The passphrase didn't unlock the secret key.
  wrongPassphrase,

  /// None of the user's secret keys can decrypt the message.
  noSecretKey,

  /// The secret key that can is still protected by its passphrase.
  locked,

  /// The input isn't OpenPGP data, or it is damaged.
  malformed,

  /// An algorithm or packet version this backend can't handle.
  unsupported,

  /// A recipient's key can't encrypt (expired, revoked, no encryption subkey).
  keyUnusable,

  /// Anything else.
  failed,
}

/// An OpenPGP failure; [message] is fit for the UI.
final class PgpException implements Exception {
  const PgpException(this.kind, this.message, [this.cause]);
  final PgpErrorKind kind;
  final String message;
  final Object? cause;

  @override
  String toString() => 'PgpException(${kind.name}): $message';
}

/// An OpenPGP key (a certificate), with or without its secret part.
///
/// Immutable and backend-neutral: [data] holds the transferable key in
/// binary form, and the backend parses it again when it needs it, so keys
/// can cross isolates as plain values.
final class PgpKey {
  const PgpKey({
    required this.data,
    required this.version,
    required this.fingerprint,
    required this.keyIds,
    required this.userIds,
    required this.created,
    required this.algorithm,
    this.expires,
    this.revoked = false,
    this.hasSecret = false,
    this.isProtected = false,
    this.canEncrypt = false,
    this.canSign = false,
  });

  /// The transferable key, binary packets.
  final Uint8List data;

  /// Key version (4 for Thunderbird and gpg keys, 6 for RFC 9580 keys).
  final int version;

  /// Upper-case hex: 40 digits (v4) or 64 (v6).
  final String fingerprint;

  /// Upper-case hex ids of the primary key and every subkey.
  final Set<String> keyIds;

  /// User ids, primary first, e.g. `Alice Example <alice@example.org>`.
  final List<String> userIds;
  final DateTime created;

  /// Null when the key never expires.
  final DateTime? expires;
  final bool revoked;

  /// "Ed25519", "RSA 3072", …
  final String algorithm;

  /// The secret key material is included.
  final bool hasSecret;

  /// The secret key material is protected with a passphrase.
  final bool isProtected;

  /// A valid encryption (sub)key exists.
  final bool canEncrypt;
  final bool canSign;

  /// The primary key id (the fingerprint's last 16 digits for v4 keys).
  String get keyId => version == 6 ? fingerprint.substring(0, 16) : fingerprint.substring(fingerprint.length - 16);

  /// Lower-cased addresses of every user id.
  Set<String> get emails => {for (final u in userIds) ?emailOfUserId(u)};

  /// The first user id's name, or its address.
  String get displayName {
    final first = userIds.firstOrNull;
    if (first == null) return keyId;
    return nameOfUserId(first) ?? emailOfUserId(first) ?? first;
  }

  bool isExpiredAt(DateTime now) => expires != null && !now.isBefore(expires!);

  /// Not revoked and not expired at [now].
  bool isValidAt(DateTime now) => !revoked && !isExpiredAt(now);

  /// Whether [email] is one of the key's addresses (case-insensitive).
  bool hasEmail(String email) => emails.contains(email.trim().toLowerCase());

  /// The fingerprint in groups of four: `30191E20 CFF1…` style, readable aloud.
  String get formattedFingerprint => formatFingerprint(fingerprint);

  @override
  bool operator ==(Object other) =>
      other is PgpKey &&
      other.fingerprint == fingerprint &&
      other.hasSecret == hasSecret &&
      _bytesEqual(other.data, data);

  @override
  int get hashCode => Object.hash(fingerprint, hasSecret, data.length);

  @override
  String toString() => 'PgpKey($fingerprint, ${userIds.firstOrNull})';
}

bool _bytesEqual(Uint8List a, Uint8List b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

/// `ABCD EF01 …` (four-digit groups, two spaces in the middle for v4).
String formatFingerprint(String fingerprint) {
  final hex = fingerprint.replaceAll(RegExp(r'\s'), '').toUpperCase();
  final groups = [for (var i = 0; i < hex.length; i += 4) hex.substring(i, i + 4 > hex.length ? hex.length : i + 4)];
  if (groups.length == 10) return '${groups.take(5).join(' ')}  ${groups.skip(5).join(' ')}';
  return groups.join(' ');
}

final _angleAddress = RegExp(r'<([^<>\s]+@[^<>\s]+)>');
final _bareAddress = RegExp(r'^[^\s<>@]+@[^\s<>@]+$');

/// The address of a user id (`Name <a@b>` or a bare `a@b`), lower-cased.
String? emailOfUserId(String userId) {
  final m = _angleAddress.firstMatch(userId);
  if (m != null) return m.group(1)!.toLowerCase();
  final t = userId.trim();
  return _bareAddress.hasMatch(t) ? t.toLowerCase() : null;
}

/// The name part of `Name (comment) <a@b>`, without the comment.
String? nameOfUserId(String userId) {
  final i = userId.indexOf('<');
  var name = (i < 0 ? (_bareAddress.hasMatch(userId.trim()) ? '' : userId) : userId.substring(0, i)).trim();
  name = name.replaceAll(RegExp(r'\s*\([^)]*\)\s*$'), '').trim();
  if (name.length >= 2 && name.startsWith('"') && name.endsWith('"')) name = name.substring(1, name.length - 1);
  return name.isEmpty ? null : name;
}

enum PgpSignatureStatus {
  /// The signature is valid for the data and was made by a known key.
  good,

  /// A known key, but the signature doesn't match the data (or the key
  /// was revoked or had expired when it signed).
  bad,

  /// No key with the signature's issuer id is known.
  unknownKey,
}

/// One signature's verification.
final class PgpSignatureCheck {
  const PgpSignatureCheck({
    required this.status,
    required this.issuerKeyId,
    this.signerFingerprint,
    this.created,
    this.detail,
  });

  final PgpSignatureStatus status;

  /// The issuer key id from the signature (upper-case hex), possibly a subkey's.
  final String issuerKeyId;

  /// The primary fingerprint of the key that checked it; null for [PgpSignatureStatus.unknownKey].
  final String? signerFingerprint;
  final DateTime? created;

  /// Why it is bad, in words.
  final String? detail;

  @override
  String toString() => 'PgpSignatureCheck(${status.name}, $issuerKeyId, $signerFingerprint)';
}

/// What decrypting a message gave.
final class PgpDecryption {
  const PgpDecryption({
    required this.data,
    this.signatures = const [],
    this.recipientKeyIds = const [],
    this.filename = '',
  });

  /// The literal data.
  final Uint8List data;

  /// Checks of the signatures inside the encrypted message (sign+encrypt).
  final List<PgpSignatureCheck> signatures;

  /// Key ids the message was encrypted to (upper-case hex).
  final List<String> recipientKeyIds;
  final String filename;
}

/// A cleartext-signed message (`-----BEGIN PGP SIGNED MESSAGE-----`).
final class PgpCleartext {
  const PgpCleartext({required this.text, required this.signatures});
  final String text;
  final List<PgpSignatureCheck> signatures;
}

/// The swappable OpenPGP engine. Everything is synchronous and pure, so a
/// caller can run it in another isolate (`Isolate.run`).
abstract interface class PgpBackend {
  /// Every key in [input]: armored blocks (one or several) or binary
  /// packets. Throws [PgpException] ([PgpErrorKind.malformed]) when there is none.
  List<PgpKey> readKeys(Uint8List input);

  /// A new Thunderbird-compatible key: Ed25519 (EdDSA) primary key for
  /// certifying and signing, Curve25519 (ECDH) subkey for encryption, v4,
  /// valid for [validity] (forever when null). With an empty [passphrase]
  /// the secret key is stored unprotected.
  PgpKey generate({required String userId, String passphrase = '', Duration? validity, DateTime? now});

  /// [key] with its secret material decrypted and stored unprotected
  /// (in memory only). Throws [PgpErrorKind.wrongPassphrase].
  PgpKey unlock(PgpKey key, String passphrase);

  /// [key] without secret material.
  PgpKey publicKey(PgpKey key);

  /// The smallest usable public key for [email]: the primary key, the user
  /// id with that address and its self-signature, and the encryption
  /// subkeys. For Autocrypt's `keydata`.
  PgpKey minimalKey(PgpKey key, String email);

  /// ASCII armor of [key]: a public or a private key block.
  String armor(PgpKey key);

  /// Ids of the keys a message is encrypted to (armored or binary).
  List<String> recipientKeyIds(Uint8List message);

  /// Decrypts [message] (armored or binary) with one of [keys] (unlocked),
  /// checking any signature inside against [verifiers].
  PgpDecryption decrypt(Uint8List message, {required List<PgpKey> keys, List<PgpKey> verifiers = const []});

  /// Encrypts [data] to [recipients] (public keys), signed by [signer]
  /// (unlocked) when given. Returns an ASCII-armored message.
  String encrypt(Uint8List data, {required List<PgpKey> recipients, PgpKey? signer, DateTime? now});

  /// A detached, ASCII-armored binary signature of [data].
  String signDetached(Uint8List data, PgpKey signer, {DateTime? now});

  /// Checks the detached [signature] (armored or binary) of [data].
  List<PgpSignatureCheck> verifyDetached(Uint8List data, Uint8List signature, List<PgpKey> verifiers);

  /// Reads a cleartext-signed message and checks its signatures.
  PgpCleartext verifyCleartext(String armored, List<PgpKey> verifiers);
}
