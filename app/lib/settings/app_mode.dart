import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories.dart';
import 'app_settings.dart';

/// What the app shows: nothing yet (first launch), demo mail or real accounts.
enum AppMode { none, demo, live }

final appModeProvider = NotifierProvider<AppModeController, AppMode>(AppModeController.new);

/// Bumped when SharedPreferences are wiped, so every provider that caches
/// preferences re-reads them.
final prefsEpochProvider = NotifierProvider<PrefsEpoch, int>(PrefsEpoch.new);

class PrefsEpoch extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state++;
}

/// The persisted [AppMode] (`app.mode`).
class AppModeController extends Notifier<AppMode> {
  static const key = 'app.mode';

  @override
  AppMode build() {
    ref.watch(prefsEpochProvider);
    final name = ref.watch(sharedPreferencesProvider).getString(key);
    return AppMode.values.where((m) => m.name == name).firstOrNull ?? AppMode.none;
  }

  Future<void> set(AppMode mode) async {
    state = mode;
    await ref.read(sharedPreferencesProvider).setString(key, mode.name);
  }

  /// Back to first launch: forgets every preference and the demo mailbox.
  Future<void> reset() async {
    await ref.read(sharedPreferencesProvider).clear();
    ref.invalidate(demoRepositoryProvider);
    ref.read(prefsEpochProvider.notifier).bump();
  }
}
