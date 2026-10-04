import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../demo/demo_repository.dart';
import '../settings/app_mode.dart';
import 'live.dart';

/// The demo mailbox. Lives until the app is reset, so switching screens or
/// modes keeps what the user did to it.
final demoRepositoryProvider = Provider<DemoMailRepository>((ref) {
  final repository = DemoMailRepository();
  ref.onDispose(repository.dispose);
  return repository;
});

/// The real repository, built once live mode is chosen.
final liveRepositoryProvider = FutureProvider<MailRepository>(createLiveRepository);

/// The repository for the current [AppMode]; main() overrides
/// `repositoryProvider` with this. Live mode is only reached once
/// [liveRepositoryProvider] has loaded (the app shows a gate until then).
MailRepository repositoryForMode(Ref ref) => switch (ref.watch(appModeProvider)) {
  AppMode.live => ref.watch(liveRepositoryProvider).requireValue,
  AppMode.demo || AppMode.none => ref.watch(demoRepositoryProvider),
};

/// Where account setup adds accounts: the demo mailbox in demo mode,
/// otherwise the real repository (also on first launch, before live mode is
/// switched on by the first successful setup).
final setupRepositoryProvider = FutureProvider<MailRepository>(
  (ref) async => switch (ref.watch(appModeProvider)) {
    AppMode.demo => ref.watch(demoRepositoryProvider),
    AppMode.none || AppMode.live => await ref.watch(liveRepositoryProvider.future),
  },
);
