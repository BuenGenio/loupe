import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_imap/mail_imap.dart';
import 'package:mail_model/mail_model.dart' hide TextField;
import 'package:mail_platform/mail_platform.dart';
import 'package:mail_store/mail_store.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:path_provider/path_provider.dart';

/// Keychain entry holding the database encryption key.
const _databaseKeyName = 'loupe.database.key';

/// Builds the real repository: the encrypted store, the IMAP transports and
/// the keychain, then starts syncing. Disposed with the provider.
Future<MailRepository> createLiveRepository(Ref ref) async {
  final secrets = KeychainSecretStorage();
  final key = await _databaseKey(secrets);
  final directory = await getApplicationSupportDirectory();
  // Never delete the database on failure: a MailStoreException surfaces in
  // the live gate, and the user decides.
  final store = await MailStore.open('${directory.path}/loupe.db', encryptionKey: key);
  final credentials = CredentialsService(store: SecureCredentialStore(secrets));
  final repository = LiveMailRepository(
    store,
    ImapTransportFactory(),
    credentials.store,
    refreshOAuth: (account, current) => credentials.oauth.refresh(account.provider, current),
  );
  ref.onDispose(() async {
    await repository.dispose();
    await store.close();
  });
  await repository.start();
  return repository;
}

/// Reads the database key, creating a random 256-bit one on first use.
Future<String> _databaseKey(SecretStorage secrets) async {
  final existing = await secrets.read(_databaseKeyName);
  if (existing != null) return existing;
  final random = Random.secure();
  final key = base64.encode([for (var i = 0; i < 32; i++) random.nextInt(256)]);
  await secrets.write(_databaseKeyName, key);
  return key;
}
