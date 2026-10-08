import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';

import '../../demo/demo_smime.dart';
import '../../router.dart';
import '../../settings/app_mode.dart';
import '../openpgp/openpgp_providers.dart';
import 'device_certificates.dart';
import 'smime_keys.dart';
import 'smime_passphrase.dart';
import 'smime_service.dart';

export 'smime_keys.dart';

/// The S/MIME engine (pure Dart, on pointycastle).
final smimeBackendProvider = Provider<SmimeBackend>((ref) => const DartSmimeBackend());

Future<StoreSmimeKeys> _open(Ref ref, SmimeStore store) async {
  ref.onDispose(store.dispose);
  // Keys unlocked with a passphrase follow Remember Passphrases, as OpenPGP's.
  final keys = StoreSmimeKeys(store, remember: ref.read(rememberPassphrasesProvider));
  ref.listen(rememberPassphrasesProvider, (_, remember) => keys.remember = remember);
  try {
    await store.load();
    await keys.loadKeys();
  } on Object {
    // A keychain that can't be read starts empty; nothing is overwritten
    // until the user adds a certificate.
  }
  return keys;
}

/// The S/MIME store of real accounts, in the keychain (next to the OpenPGP keyring).
final liveSmimeKeysProvider = FutureProvider<StoreSmimeKeys>(
  (ref) => _open(ref, SmimeStore(ref.watch(keyringStorageProvider), prefix: liveSmimePrefix)),
);

/// Whether the demo's S/MIME store starts with Sam's certificate and the
/// demo CA (tests of importing turn it off).
final demoSmimeSeedProvider = Provider<bool>((ref) => true);

/// The demo's S/MIME store, in memory, starting over with the app: Sam's
/// certificate and the Northwind demo CA (demo_smime.dart).
final demoSmimeKeysProvider = FutureProvider<StoreSmimeKeys>((ref) async {
  ref.watch(prefsEpochProvider);
  final store = SmimeStore(MemoryKeyringStorage(), prefix: 'demo.smime');
  if (ref.watch(demoSmimeSeedProvider)) {
    await store.load();
    await seedDemoSmime(store);
  }
  return _open(ref, store);
});

/// The S/MIME store of the current mode.
final smimeKeysProvider = FutureProvider<StoreSmimeKeys>(
  (ref) => switch (ref.watch(appModeProvider)) {
    AppMode.demo => ref.watch(demoSmimeKeysProvider.future),
    AppMode.live || AppMode.none => ref.watch(liveSmimeKeysProvider.future),
  },
);

/// The store's state, kept current.
final smimeStateProvider = StreamProvider<SmimeState>((ref) async* {
  final keys = await ref.watch(smimeKeysProvider.future);
  yield keys.store.state;
  yield* keys.store.changes;
});

/// Shows the S/MIME passphrase dialog over whatever screen is open.
final smimePassphrasePromptProvider = Provider<SmimePassphrasePrompt>((ref) {
  return (SmimeCertificate certificate, {PassphraseError? error}) async {
    final context = ref.read(routerProvider).routerDelegate.navigatorKey.currentContext;
    if (context == null || !context.mounted) return null;
    return showSmimeUnlockDialog(context, certificate: certificate, error: error);
  };
});

/// Everything S/MIME the screens need. Work runs off the UI isolate like OpenPGP's.
final smimeServiceProvider = FutureProvider<SmimeService>(
  (ref) async => SmimeService(
    keys: await ref.watch(smimeKeysProvider.future),
    backend: ref.watch(smimeBackendProvider),
    run: ref.watch(pgpRunnerProvider),
    device: ref.watch(deviceCertificatesProvider),
    prompt: (certificate, {error}) => ref.read(smimePassphrasePromptProvider)(certificate, error: error),
  ),
);

/// Builds [builder] once the S/MIME service is ready; [fallback] until then.
class WithSmime extends ConsumerWidget {
  const WithSmime({super.key, required this.builder, this.fallback = const SizedBox.shrink()});

  final Widget Function(BuildContext context, SmimeService service, SmimeState state) builder;
  final Widget fallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(smimeServiceProvider).value;
    final state = ref.watch(smimeStateProvider).value;
    if (service == null || state == null) return fallback;
    return builder(context, service, state);
  }
}
