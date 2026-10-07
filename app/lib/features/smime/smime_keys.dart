/// The S/MIME store and its private keys, without any UI: background
/// isolates send with them too.
library;

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_platform/mail_platform.dart';

import '../openpgp/openpgp_keys.dart';

/// Keychain entries of the real S/MIME store start with this.
const liveSmimePrefix = 'loupe.smime';

/// The store with the private keys in memory (the composer works
/// synchronously): keys in the keychain, handles of keys that stay on the
/// device (Android KeyChain), and keys unlocked with their passphrase.
///
/// Keys without a passphrase and on the device are pinned. Unlocked ones
/// follow Remember Passphrases, as OpenPGP's ([KeySession]): with
/// [remember] they stay until [lockAll] (or the app quits); without, each
/// lasts [grace] after its last use.
final class StoreSmimeKeys implements SmimeSendKeys {
  StoreSmimeKeys(
    this.store, {
    this.remember = true,
    this.grace = const Duration(minutes: 2),
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final SmimeStore store;
  bool remember;
  final Duration grace;
  final DateTime Function() _clock;
  final _keys = <String, SmimeKeyHandle>{};
  final _unlocked = <String, (SmimePrivateKey, DateTime)>{};

  /// Reads the private key of every own certificate from the store; keys
  /// with a passphrase stay locked.
  Future<void> loadKeys() async {
    for (final o in store.state.own) {
      try {
        final key = await store.privateKey(o.fingerprint);
        if (key != null) _keys[o.fingerprint] = key;
      } on Object {
        // Unreadable: signing with it fails, and says so.
      }
    }
  }

  @override
  SmimeState get smimeState => store.state;

  @override
  SmimeKeyHandle? smimeKey(String fingerprint) {
    final pinned = _keys[fingerprint];
    if (pinned != null) return pinned;
    final entry = _unlocked[fingerprint];
    if (entry == null) return null;
    final now = _clock();
    if (!remember && now.difference(entry.$2) > grace) {
      _unlocked.remove(fingerprint);
      return null;
    }
    _unlocked[fingerprint] = (entry.$1, now);
    return entry.$1;
  }

  /// Whether [fingerprint]'s key can be used now (no passphrase, on the device, or unlocked).
  bool isAvailable(String fingerprint) => smimeKey(fingerprint) != null;

  /// The own certificates whose keys are here: what decrypts.
  List<SmimeKeyPair> get keyPairs => [
    for (final o in store.state.own)
      if (smimeKey(o.fingerprint) case final key?) SmimeKeyPair(o.certificate, key),
  ];

  /// A key without a passphrase, or on the device: kept until it is forgotten.
  void put(String fingerprint, SmimeKeyHandle key) {
    _unlocked.remove(fingerprint);
    _keys[fingerprint] = key;
  }

  /// A key unlocked with its passphrase: kept as Remember Passphrases says.
  void putUnlocked(String fingerprint, SmimePrivateKey key) {
    _keys.remove(fingerprint);
    _unlocked[fingerprint] = (key, _clock());
  }

  void forget(String fingerprint) {
    _keys.remove(fingerprint);
    _unlocked.remove(fingerprint);
  }

  /// Locks every key unlocked with its passphrase (Lock Keys Now).
  void lockAll() => _unlocked.clear();
}

/// What the composer chain reads at send time: OpenPGP's keys and S/MIME's.
final class SecureSendKeys implements PgpSendKeys, SmimeSendKeys {
  SecureSendKeys(this.pgp, this.smime);

  final PgpSendKeys pgp;
  final SmimeSendKeys smime;

  @override
  KeyringState get state => pgp.state;

  @override
  PgpKey? unlockedKey(String fingerprint) => pgp.unlockedKey(fingerprint);

  @override
  SmimeState get smimeState => smime.smimeState;

  @override
  SmimeKeyHandle? smimeKey(String fingerprint) => smime.smimeKey(fingerprint);
}

/// The S/MIME store of a background isolate, from the keychain.
Future<StoreSmimeKeys> backgroundSmimeKeys() async {
  final keys = StoreSmimeKeys(SmimeStore(SecretStorageKeyring(KeychainSecretStorage()), prefix: liveSmimePrefix));
  try {
    await keys.store.load();
    await keys.loadKeys();
  } on Object {
    // A keychain that can't be read: S/MIME mail waits for the app.
  }
  return keys;
}
