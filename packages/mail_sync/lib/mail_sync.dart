/// Sync engine and the live MailRepository: keeps the local store in sync
/// with the servers, replays offline operations and sends the outbox.
///
/// ```dart
/// final store = await MailStore.open('$supportDir/loupe.db', encryptionKey: keyFromKeystore);
/// final repo = LiveMailRepository(store, transportFactory, credentialStore);
/// await repo.start();
/// // App hidden: repo.pause(); shown again: repo.resume().
/// // Background fetch: repo.syncOnce().
/// // Shutdown: await repo.dispose(); await store.close();
/// ```
library;

export 'src/config.dart';
export 'src/live_repository.dart';
