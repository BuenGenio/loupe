import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_imap/mail_imap.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart';
import 'package:mail_store/mail_store.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:path_provider/path_provider.dart';

/// Keychain entry holding the database encryption key.
const _databaseKeyName = 'loupe.database.key';

/// Builds the real repository: the encrypted store, the IMAP transports and
/// the keychain, then starts syncing. Disposed with the provider.
Future<MailRepository> createLiveRepository(Ref ref) async {
  // Never delete the database on failure: a MailStoreException surfaces in
  // the live gate, and the user decides.
  final store = await openLiveStore();
  final repository = buildLiveRepository(store);
  ref.onDispose(() async {
    await repository.dispose();
    await store.close();
  });
  await repository.start();
  return repository;
}

/// Opens the encrypted mail database with the key from the keychain. The app
/// and the background isolates (sync, notification actions) all open it
/// through here.
///
/// Without [createKey], a missing key throws a [MailStoreException] instead
/// of starting a new, empty database (background work never creates one).
Future<MailStore> openLiveStore({bool createKey = true}) async {
  final key = await _databaseKey(KeychainSecretStorage(), create: createKey);
  final directory = await getApplicationSupportDirectory();
  return MailStore.open('${directory.path}/loupe.db', encryptionKey: key);
}

/// The live repository over [store], not yet started.
LiveMailRepository buildLiveRepository(MailStore store, {SyncConfig config = const SyncConfig()}) {
  final credentials = CredentialsService(store: SecureCredentialStore(KeychainSecretStorage()));
  return LiveMailRepository(
    store,
    ImapTransportFactory(),
    credentials.store,
    config: config,
    refreshOAuth: (account, current) => credentials.oauth.refresh(account.provider, current),
  );
}

/// Reads the database key, creating a random 256-bit one on first use.
Future<String> _databaseKey(SecretStorage secrets, {required bool create}) async {
  final existing = await secrets.read(_databaseKeyName);
  if (existing != null) return existing;
  if (!create) throw const MailStoreException('The database key is missing');
  final random = Random.secure();
  final key = base64.encode([for (var i = 0; i < 32; i++) random.nextInt(256)]);
  await secrets.write(_databaseKeyName, key);
  return key;
}
