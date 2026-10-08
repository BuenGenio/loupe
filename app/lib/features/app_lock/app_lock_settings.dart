import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart';

/// How long Loupe can be out of sight before App Lock asks again.
enum LockAfter {
  immediately(Duration.zero),
  oneMinute(Duration(minutes: 1)),
  fiveMinutes(Duration(minutes: 5)),
  fifteenMinutes(Duration(minutes: 15)),
  oneHour(Duration(hours: 1));

  const LockAfter(this.duration);

  final Duration duration;

  /// As Settings shows it, in [l10n] (a widget's `context.l10n`).
  String labelIn(AppLocalizations l10n) => switch (this) {
    immediately => l10n.appLockAfterImmediately,
    oneHour => l10n.appLockAfterHours(duration.inHours),
    oneMinute || fiveMinutes || fifteenMinutes => l10n.appLockAfterMinutes(duration.inMinutes),
  };

  /// [labelIn] the device's language, for code without a `BuildContext`.
  String get label => labelIn(deviceL10n());
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
