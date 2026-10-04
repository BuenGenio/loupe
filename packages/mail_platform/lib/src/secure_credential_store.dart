/// Credentials in the platform keychain.
library;

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mail_model/mail_model.dart';

/// The key-value secret storage [SecureCredentialStore] writes to; the
/// default is the platform keychain, tests use an in-memory one.
abstract interface class SecretStorage {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

/// [SecretStorage] on flutter_secure_storage: the iOS Keychain (readable
/// after first unlock, so background refresh works; never synced to other
/// devices) and Keystore-encrypted storage on Android.
final class KeychainSecretStorage implements SecretStorage {
  KeychainSecretStorage([FlutterSecureStorage? storage])
    : _storage =
          storage ??
          const FlutterSecureStorage(
            iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
            mOptions: MacOsOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
          );

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) => _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}

/// [CredentialStore] keeping JSON-encoded [Credentials] per account id.
final class SecureCredentialStore implements CredentialStore {
  SecureCredentialStore([SecretStorage? storage]) : _storage = storage ?? KeychainSecretStorage();

  final SecretStorage _storage;

  static String keyFor(String accountId) => 'loupe.credentials.$accountId';

  @override
  Future<Credentials?> read(String accountId) async {
    final raw = await _storage.read(keyFor(accountId));
    if (raw == null) return null;
    try {
      return decodeCredentials(raw);
    } on FormatException {
      return null;
    }
  }

  @override
  Future<void> write(String accountId, Credentials credentials) =>
      _storage.write(keyFor(accountId), encodeCredentials(credentials));

  @override
  Future<void> delete(String accountId) => _storage.delete(keyFor(accountId));
}

/// JSON for [Credentials].
String encodeCredentials(Credentials credentials) => jsonEncode(switch (credentials) {
  PasswordCredentials(:final password) => {'type': 'password', 'password': password},
  OAuthCredentials(:final accessToken, :final refreshToken, :final expiresAt) => {
    'type': 'oauth2',
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'expiresAt': expiresAt.toUtc().toIso8601String(),
  },
});

/// Parses [encodeCredentials] output; throws [FormatException] otherwise.
Credentials decodeCredentials(String json) {
  final Object? decoded;
  try {
    decoded = jsonDecode(json);
  } on FormatException {
    throw const FormatException('Stored credentials are not JSON');
  }
  if (decoded is! Map<String, Object?>) throw const FormatException('Stored credentials are not an object');
  switch (decoded['type']) {
    case 'password':
      final password = decoded['password'];
      if (password is String) return PasswordCredentials(password);
    case 'oauth2':
      final access = decoded['accessToken'];
      final refresh = decoded['refreshToken'];
      final expires = DateTime.tryParse(decoded['expiresAt'] as String? ?? '');
      if (access is String && (refresh == null || refresh is String) && expires != null) {
        return OAuthCredentials(accessToken: access, refreshToken: refresh as String?, expiresAt: expires);
      }
  }
  throw const FormatException('Unknown stored credentials');
}
