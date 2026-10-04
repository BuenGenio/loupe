import 'dart:async';
import 'dart:isolate';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_platform/mail_platform.dart';

import '../../demo/demo_openpgp.dart';
import '../../router.dart';
import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart';
import 'openpgp_keys.dart';
import 'openpgp_service.dart';
import 'passphrase_dialog.dart';

export 'openpgp_keys.dart';

/// Runs OpenPGP work (key derivation, decryption) off the UI isolate.
typedef PgpRunner = Future<T> Function<T>(T Function() work);

Future<T> _isolate<T>(T Function() work) => Isolate.run(work);

/// Tests override this to run the work inline.
final pgpRunnerProvider = Provider<PgpRunner>((ref) => _isolate);

/// The OpenPGP engine (dart_pg, pure Dart).
final pgpBackendProvider = Provider<PgpBackend>((ref) => const DartPgBackend());

/// Where the real keyring lives; tests override it with memory.
final keyringStorageProvider = Provider<KeyringStorage>((ref) => SecretStorageKeyring(KeychainSecretStorage()));

Future<Keyring> _open(Ref ref, Keyring keyring) async {
  ref.onDispose(keyring.dispose);
  try {
    await keyring.load();
  } on Object {
    // A keychain that can't be read starts empty; nothing is overwritten
    // until the user adds a key.
  }
  return keyring;
}

/// The keyring of real accounts: keys and settings in the keychain.
final liveKeyringProvider = FutureProvider<Keyring>(
  (ref) => _open(ref, Keyring(ref.watch(keyringStorageProvider), prefix: liveKeyringPrefix)),
);

/// The demo keyring: Sam's key and the keys of a few colleagues, in memory.
/// Starts over when the app is reset.
final demoKeyringProvider = FutureProvider<Keyring>((ref) async {
  ref.watch(prefsEpochProvider);
  final keyring = await _open(ref, Keyring(MemoryKeyringStorage(), prefix: 'demo.openpgp'));
  await seedDemoKeyring(keyring, ref.read(pgpBackendProvider));
  return keyring;
});

/// The keyring of the current mode.
final keyringProvider = FutureProvider<Keyring>(
  (ref) => switch (ref.watch(appModeProvider)) {
    AppMode.demo => ref.watch(demoKeyringProvider.future),
    AppMode.live || AppMode.none => ref.watch(liveKeyringProvider.future),
  },
);

/// The keyring's state, kept current.
final keyringStateProvider = StreamProvider<KeyringState>((ref) async* {
  final keyring = await ref.watch(keyringProvider.future);
  yield keyring.state;
  yield* keyring.changes;
});

/// "Remember Passphrases": unlocked keys stay unlocked until Loupe quits
/// (on by default), or only a couple of minutes after each use.
/// Persisted as `openpgp.rememberPassphrases`.
final rememberPassphrasesProvider = NotifierProvider<RememberPassphrases, bool>(RememberPassphrases.new);

class RememberPassphrases extends Notifier<bool> {
  static const key = 'openpgp.rememberPassphrases';

  @override
  bool build() {
    ref.watch(prefsEpochProvider);
    return ref.watch(sharedPreferencesProvider).getBool(key) ?? true;
  }

  Future<void> set(bool value) async {
    state = value;
    await ref.read(sharedPreferencesProvider).setBool(key, value);
  }
}

/// Keys unlocked in this session. Locked again when the mode changes.
final keySessionProvider = Provider<KeySession>((ref) {
  ref.watch(appModeProvider);
  final session = KeySession(remember: ref.read(rememberPassphrasesProvider));
  ref.listen(rememberPassphrasesProvider, (_, remember) => session.remember = remember);
  return session;
});

/// Asks for the passphrase of [key]; null when the user cancels. [error]
/// explains why it is asked again.
typedef PassphrasePrompt = Future<String?> Function(PgpKey key, {String? error});

/// Shows the passphrase dialog over whatever screen is open.
final passphrasePromptProvider = Provider<PassphrasePrompt>((ref) {
  return (PgpKey key, {String? error}) async {
    final context = ref.read(routerProvider).routerDelegate.navigatorKey.currentContext;
    if (context == null || !context.mounted) return null;
    return showPassphraseDialog(context, key: key, error: error);
  };
});

/// Everything OpenPGP the screens need.
final openPgpServiceProvider = FutureProvider<OpenPgpService>((ref) async {
  final keyring = await ref.watch(keyringProvider.future);
  return OpenPgpService(
    keyring: keyring,
    session: ref.watch(keySessionProvider),
    backend: ref.watch(pgpBackendProvider),
    run: ref.watch(pgpRunnerProvider),
    prompt: (key, {error}) => ref.read(passphrasePromptProvider)(key, error: error),
  );
});

/// Builds [builder] once the OpenPGP service is ready; [fallback] until then.
class WithOpenPgp extends ConsumerWidget {
  const WithOpenPgp({super.key, required this.builder, this.fallback = const SizedBox.shrink()});

  final Widget Function(BuildContext context, OpenPgpService service, KeyringState state) builder;
  final Widget fallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(openPgpServiceProvider).value;
    final state = ref.watch(keyringStateProvider).value;
    if (service == null || state == null) return fallback;
    return builder(context, service, state);
  }
}
