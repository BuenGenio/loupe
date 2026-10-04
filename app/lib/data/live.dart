import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_imap/mail_imap.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart';
import 'package:mail_store/mail_store.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:path_provider/path_provider.dart';

import '../features/openpgp/openpgp_providers.dart';
import '../features/smime/smime_providers.dart';

/// Keychain entry holding the database encryption key.
const _databaseKeyName = 'loupe.database.key';

/// Builds the real repository: the encrypted store, the IMAP transports and
/// the keychain. Disposed with the provider.
///
/// It starts paused: accounts are loaded (so messages open and actions
/// work), but syncing waits until the app is in the foreground and no
/// background sync holds the database (`ForegroundSync` resumes it).
Future<MailRepository> createLiveRepository(Ref ref) async {
  // Never delete the database on failure: a MailStoreException or
  // DatabaseKeyUnavailable surfaces in the live gate, and the user decides.
  final store = await openLiveStore();
  // Closed with the provider even if a step below fails (Try Again on the
  // recovery screen would open a second connection otherwise).
  LiveMailRepository? repository;
  ref.onDispose(() async {
    await repository?.dispose();
    await store.close();
  });
  // Before the first send: the composer signs, encrypts and adds Autocrypt
  // headers synchronously from the keyring, the unlocked keys and the
  // S/MIME certificates.
  final keyring = await ref.watch(liveKeyringProvider.future);
  await (await ref.read(openPgpServiceProvider.future)).ready;
  final smime = await ref.watch(liveSmimeKeysProvider.future);
  repository = buildLiveRepository(
    store,
    keys: SecureSendKeys(SessionSendKeys(keyring, () => ref.read(keySessionProvider)), smime),
  );
  await repository.pause();
  await repository.start();
  return repository;
}

/// Opens the encrypted mail database with the key from the keychain. The app
/// and the background isolates (sync, notification actions) all open it
/// through here.
///
/// A new key is only made when there is no database yet ([createKey] and no
/// file): a key the keychain can't give back for an existing database throws
/// [DatabaseKeyUnavailable], never a fresh key (which would lock that
/// database for good). Background work passes `createKey: false`.
Future<MailStore> openLiveStore({bool createKey = true}) async =>
    openStoreIn(await getApplicationSupportDirectory(), KeychainSecretStorage(), createKey: createKey);

/// [openLiveStore] on [directory] with the key in [secrets].
Future<MailStore> openStoreIn(Directory directory, SecretStorage secrets, {bool createKey = true}) async {
  final path = databasePath(directory);
  final key = await databaseKey(secrets, create: createKey && !File(path).existsSync());
  return MailStore.open(path, encryptionKey: key);
}

/// Where the mail database lives in the app support [directory].
String databasePath(Directory directory) => '${directory.path}/loupe.db';

/// The keychain doesn't give the database key: it failed to read it
/// ([cause]; often temporary, e.g. the Keystore after a reboot or an update),
/// or it has none although the database exists ([missing]; e.g. after a
/// backup was restored without the Keystore).
final class DatabaseKeyUnavailable implements Exception {
  const DatabaseKeyUnavailable({this.missing = false, this.cause});

  final bool missing;
  final Object? cause;

  @override
  String toString() => missing
      ? 'DatabaseKeyUnavailable: the keychain has no key for the database'
      : 'DatabaseKeyUnavailable: the keychain could not be read (${cause.runtimeType})';
}

/// Reads the database key from [secrets]; with [create], makes a random
/// 256-bit one if there is none. Never replaces a key: a failed read throws
/// [DatabaseKeyUnavailable].
Future<String> databaseKey(SecretStorage secrets, {required bool create}) async {
  final String? existing;
  try {
    existing = await secrets.read(_databaseKeyName);
  } on Object catch (e) {
    throw DatabaseKeyUnavailable(cause: e);
  }
  if (existing != null && existing.isNotEmpty) return existing;
  if (!create) throw const DatabaseKeyUnavailable(missing: true);
  final random = Random.secure();
  final key = base64.encode([for (var i = 0; i < 32; i++) random.nextInt(256)]);
  await secrets.write(_databaseKeyName, key);
  return key;
}

/// Deletes the mail database and its key, after the user agreed (the
/// recovery screen): accounts and cached mail on this device, and messages
/// still in the Outbox. Mail on the servers is untouched. The next
/// [openLiveStore] starts an empty database with a new key.
Future<void> deleteLocalMailData({Directory? directory, SecretStorage? secrets}) async {
  final dir = directory ?? await getApplicationSupportDirectory();
  final path = databasePath(dir);
  for (final suffix in ['', '-wal', '-shm', '-journal']) {
    final file = File('$path$suffix');
    if (file.existsSync()) await file.delete();
  }
  if (secrets != null) {
    await secrets.delete(_databaseKeyName);
    return;
  }
  try {
    await KeychainSecretStorage().delete(_databaseKeyName);
  } on Object {
    // The Keystore can't be used at all (its key is gone): start it over.
    await KeychainSecretStorage.discardingUnreadable().delete(_databaseKeyName);
  }
}

/// The live repository over [store], not yet started. Its composer writes
/// OpenPGP mail (and Autocrypt headers) and S/MIME mail with [keys]; a
/// message that asks for encryption it can't do stays in the Outbox, never
/// goes out in the clear.
///
/// The background isolates (WorkManager, Instant Delivery, iOS background
/// refresh) build theirs here too: OAuth tokens are refreshed with a plain
/// HTTPS POST (mail_platform's TokenEndpointClient), which needs no plugin,
/// activity or browser. Only signing in uses flutter_appauth.
LiveMailRepository buildLiveRepository(
  MailStore store, {
  required SecureSendKeys keys,
  SyncConfig config = const SyncConfig(),
}) {
  final credentials = CredentialsService(store: SecureCredentialStore(KeychainSecretStorage()));
  return LiveMailRepository(
    store,
    ImapTransportFactory(
      composer: SmimeMessageComposer(
        PgpMessageComposer(MimeMessageComposer(), keys, backend: const DartPgBackend()),
        keys,
        backend: const DartSmimeBackend(),
      ),
    ),
    credentials.store,
    config: config,
    refreshOAuth: (account, current) => credentials.oauth.refresh(account.provider, current),
  );
}

/// Keys for a background isolate (sync, notification actions): the
/// keyring from the keychain and the keys stored without a passphrase, and
/// the S/MIME certificates. Mail that needs a passphrase waits in the
/// Outbox for the app.
Future<SecureSendKeys> backgroundSendKeys() async {
  final keyring = Keyring(SecretStorageKeyring(KeychainSecretStorage()), prefix: liveKeyringPrefix);
  final session = KeySession();
  try {
    await keyring.load();
    for (final k in keyring.state.ownKeys) {
      if (k.isProtected) continue;
      final secret = await keyring.secretKey(k.fingerprint, const DartPgBackend());
      if (secret != null && !secret.isProtected) session.put(secret, pin: true);
    }
  } on Object {
    // A keychain that can't be read: encrypted mail waits for the app.
  }
  return SecureSendKeys(SessionSendKeys(keyring, () => session), await backgroundSmimeKeys());
}
