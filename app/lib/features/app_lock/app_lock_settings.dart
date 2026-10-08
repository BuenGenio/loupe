import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart';

/// How long Loupe can be out of sight before App Lock asks again.
enum LockAfter {
  immediately(Duration.zero, 'Immediately'),
  oneMinute(Duration(minutes: 1), '1 Minute'),
  fiveMinutes(Duration(minutes: 5), '5 Minutes'),
  fifteenMinutes(Duration(minutes: 15), '15 Minutes'),
  oneHour(Duration(hours: 1), '1 Hour');

  const LockAfter(this.duration, this.label);

  final Duration duration;

  /// As Settings shows it.
  final String label;
}

/// Settings › Security: App Lock (off by default) and Lock After.
/// Persisted as `settings.appLock` and `settings.lockAfter`.
@immutable
class AppLockSettings {
  const AppLockSettings({this.enabled = false, this.lockAfter = LockAfter.immediately});

  final bool enabled;
  final LockAfter lockAfter;

  AppLockSettings copyWith({bool? enabled, LockAfter? lockAfter}) =>
      AppLockSettings(enabled: enabled ?? this.enabled, lockAfter: lockAfter ?? this.lockAfter);
}

final appLockSettingsProvider = NotifierProvider<AppLockSettingsController, AppLockSettings>(
  AppLockSettingsController.new,
);

class AppLockSettingsController extends Notifier<AppLockSettings> {
  static const enabledKey = 'settings.appLock';
  static const lockAfterKey = 'settings.lockAfter';

  @override
  AppLockSettings build() {
    ref.watch(prefsEpochProvider);
    final p = ref.watch(sharedPreferencesProvider);
    final after = p.getString(lockAfterKey);
    return AppLockSettings(
      enabled: p.getBool(enabledKey) ?? false,
      lockAfter: LockAfter.values.where((v) => v.name == after).firstOrNull ?? LockAfter.immediately,
    );
  }

  /// Turning it on is [AppLockController.enable]'s job: it asks the user
  /// first.
  Future<void> setEnabled(bool enabled) async {
    state = state.copyWith(enabled: enabled);
    await ref.read(sharedPreferencesProvider).setBool(enabledKey, enabled);
  }

  Future<void> setLockAfter(LockAfter after) async {
    state = state.copyWith(lockAfter: after);
    await ref.read(sharedPreferencesProvider).setString(lockAfterKey, after.name);
  }
}
