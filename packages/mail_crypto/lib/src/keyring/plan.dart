/// Which keys a message would be encrypted to, and whether to encrypt it
/// by default (Thunderbird's automatic encryption plus Autocrypt Level 1).
library;

import '../autocrypt.dart';
import '../pgp/types.dart';
import 'keyring.dart';

/// The key a recipient gets: an accepted key, or one from Autocrypt.
final class RecipientKey {
  const RecipientKey(this.key, {required this.acceptance, this.viaAutocrypt = false});
  final PgpKey key;
  final KeyAcceptance acceptance;

  /// Found through the recipient's (or gossiped) Autocrypt header, not accepted by the user.
  final bool viaAutocrypt;
}

extension KeyringLookups on KeyringState {
  /// The key to encrypt to [email]: the best accepted key, else the
  /// Autocrypt key unless it was rejected; own keys for own addresses.
  RecipientKey? encryptionKeyFor(String email, {DateTime? now}) {
    final at = now ?? DateTime.now();
    final address = email.trim().toLowerCase();
    final own = ownKeys.where((k) => k.hasEmail(address) && k.isValidAt(at) && k.canEncrypt).firstOrNull;
    if (own != null) return RecipientKey(own, acceptance: KeyAcceptance.verified);
    final accepted = acceptedKeysFor(address, now: at).firstOrNull;
    if (accepted != null) return RecipientKey(accepted.key, acceptance: accepted.acceptance);
    final peer = peers[address];
    final fingerprint = peer?.bestFingerprint;
    if (fingerprint == null) return null;
    final entry = publicEntry(fingerprint);
    if (entry == null || entry.acceptance == KeyAcceptance.rejected) return null;
    if (!entry.key.isValidAt(at) || !entry.key.canEncrypt) return null;
    return RecipientKey(entry.key, acceptance: entry.acceptance, viaAutocrypt: true);
  }
}

/// The encryption outlook of a message being written.
final class EncryptionPlan {
  const EncryptionPlan({
    required this.keys,
    required this.ownKey,
    required this.recommendation,
    required this.suggested,
  });

  /// Each recipient (lower-cased) with its key, or null when it has none.
  final Map<String, RecipientKey?> keys;

  /// The sender's own key (also encrypted to, so the Sent copy stays readable).
  final PgpKey? ownKey;

  /// Autocrypt's view of the whole message.
  final AutocryptRecommendation recommendation;

  /// Encrypt by default: required for the identity, or every recipient
  /// has an accepted key (automatic encryption), or Autocrypt says so.
  final bool suggested;

  /// Recipients without a key.
  List<String> get missing => [
    for (final MapEntry(:key, :value) in keys.entries)
      if (value == null) key,
  ];

  /// Encryption is possible: an own key, at least one recipient, and a key for each.
  bool get possible => ownKey != null && keys.isNotEmpty && missing.isEmpty;

  /// Every key that would be encrypted to, own key included.
  List<PgpKey> get recipientKeys => [
    for (final k in keys.values)
      if (k != null) k.key,
    ?ownKey,
  ];
}

/// Plans a message from [from] to [recipients].
EncryptionPlan planEncryption(
  KeyringState state, {
  required String from,
  required Iterable<String> recipients,
  bool replyToEncrypted = false,
  DateTime? now,
}) {
  final at = now ?? DateTime.now();
  final settings = state.identity(from);
  final own = state.ownKeyFor(from, now: at);
  final keys = <String, RecipientKey?>{
    for (final r in recipients)
      if (r.trim().isNotEmpty) r.trim().toLowerCase(): state.encryptionKeyFor(r, now: at),
  };
  final recommendation = combineRecommendations([
    for (final MapEntry(:key, :value) in keys.entries)
      if (value != null && !value.viaAutocrypt)
        // An accepted key is as good as a mutual Autocrypt peer.
        (settings.preferEncrypt || replyToEncrypted)
            ? AutocryptRecommendation.encrypt
            : AutocryptRecommendation.available
      else
        recommendFor(state.peers[key], ownMutual: settings.preferEncrypt, replyToEncrypted: replyToEncrypted),
  ]);
  final allAccepted = keys.isNotEmpty && keys.values.every((k) => k != null && !k.viaAutocrypt);
  final suggested =
      own != null &&
      (settings.encryptByDefault ||
          (keys.isNotEmpty &&
              keys.values.every((k) => k != null) &&
              ((settings.autoEncrypt && allAccepted) ||
                  recommendation == AutocryptRecommendation.encrypt ||
                  replyToEncrypted)));
  return EncryptionPlan(keys: keys, ownKey: own, recommendation: recommendation, suggested: suggested);
}
