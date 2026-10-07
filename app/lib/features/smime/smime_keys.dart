/// The S/MIME store and its private keys, without any UI: background
/// isolates send with them too.
library;

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_platform/mail_platform.dart';

import '../openpgp/openpgp_keys.dart';

/// Keychain entries of the real S/MIME store start with this.
const liveSmimePrefix = 'loupe.smime';

/// The store with the private keys in memory (the composer works
/// synchronously): keys in the keychain, and handles of keys that stay on
/// the device (Android KeyChain).
final class StoreSmimeKeys implements SmimeSendKeys {
  StoreSmimeKeys(this.store);

  final SmimeStore store;
  final _keys = <String, SmimeKeyHandle>{};

  /// Reads the private key of every own certificate from the store.
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
  SmimeKeyHandle? smimeKey(String fingerprint) => _keys[fingerprint];

  /// The own certificates whose keys are here: what decrypts.
  List<SmimeKeyPair> get keyPairs => [
    for (final o in store.state.own)
      if (_keys[o.fingerprint] case final key?) SmimeKeyPair(o.certificate, key),
  ];

  void put(String fingerprint, SmimeKeyHandle key) => _keys[fingerprint] = key;

  void forget(String fingerprint) => _keys.remove(fingerprint);
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
