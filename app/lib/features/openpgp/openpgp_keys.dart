/// The keyring's storage and send-time keys, without any UI: background
/// isolates use them too.
library;

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_platform/mail_platform.dart';

/// Keychain entries of the real keyring start with this.
const liveKeyringPrefix = 'loupe.openpgp';

/// [KeyringStorage] in the platform keychain (mail_platform's [SecretStorage]).
final class SecretStorageKeyring implements KeyringStorage {
  SecretStorageKeyring(this._secrets);
  final SecretStorage _secrets;

  @override
  Future<String?> read(String key) => _secrets.read(key);

  @override
  Future<void> write(String key, String value) => _secrets.write(key, value);

  @override
  Future<void> delete(String key) => _secrets.delete(key);
}

/// What the composer reads at send time: [keyring]'s state and the
/// session's unlocked keys (the session of the moment: it changes with the mode).
final class SessionSendKeys implements PgpSendKeys {
  SessionSendKeys(this.keyring, this.session);

  final Keyring keyring;
  final KeySession Function() session;

  @override
  KeyringState get state => keyring.state;

  @override
  PgpKey? unlockedKey(String fingerprint) => session()[fingerprint];
}
