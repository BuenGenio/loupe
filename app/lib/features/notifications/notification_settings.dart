import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart';

/// New-mail notification preferences (Settings › Notifications). Persisted
/// in SharedPreferences under `notifications.*`, where background isolates
/// read them too ([NotificationSettings.read]).
@immutable
class NotificationSettings {
  const NotificationSettings({
    this.mutedAccounts = const {},
    this.vipOnly = false,
    this.hideContent = false,
    this.instant = false,
    this.permissionRequested = false,
  });

  /// Accounts whose new mail doesn't notify. New accounts notify.
  final Set<String> mutedAccounts;

  /// Notify only about mail from VIPs.
  final bool vipOnly;

  /// Show only “New message from Work” (the account): no sender, subject or
  /// preview.
  final bool hideContent;

  /// Instant delivery (an IMAP IDLE foreground service); not available yet.
  final bool instant;

  /// Whether Android was asked for POST_NOTIFICATIONS already.
  final bool permissionRequested;

  bool notifiesFor(String accountId) => !mutedAccounts.contains(accountId);

  NotificationSettings copyWith({
    Set<String>? mutedAccounts,
    bool? vipOnly,
    bool? hideContent,
    bool? instant,
    bool? permissionRequested,
  }) => NotificationSettings(
    mutedAccounts: mutedAccounts ?? this.mutedAccounts,
    vipOnly: vipOnly ?? this.vipOnly,
    hideContent: hideContent ?? this.hideContent,
    instant: instant ?? this.instant,
    permissionRequested: permissionRequested ?? this.permissionRequested,
  );

  NotificationSettings withAccount(String accountId, {required bool notify}) =>
      copyWith(mutedAccounts: notify ? ({...mutedAccounts}..remove(accountId)) : {...mutedAccounts, accountId});

  static const _prefix = 'notifications.';

  /// Reads the settings, e.g. in a background isolate.
  static NotificationSettings read(SharedPreferences p) => NotificationSettings(
    mutedAccounts: {...?p.getStringList('${_prefix}mutedAccounts')},
    vipOnly: p.getBool('${_prefix}vipOnly') ?? false,
    hideContent: p.getBool('${_prefix}hideContent') ?? false,
    instant: p.getBool('${_prefix}instant') ?? false,
    permissionRequested: p.getBool('${_prefix}permissionRequested') ?? false,
  );

  Future<void> write(SharedPreferences p) async {
    await Future.wait([
      p.setStringList('${_prefix}mutedAccounts', mutedAccounts.toList()..sort()),
      p.setBool('${_prefix}vipOnly', vipOnly),
      p.setBool('${_prefix}hideContent', hideContent),
      p.setBool('${_prefix}instant', instant),
      p.setBool('${_prefix}permissionRequested', permissionRequested),
    ]);
  }

  @override
  bool operator ==(Object other) =>
      other is NotificationSettings &&
      setEquals(other.mutedAccounts, mutedAccounts) &&
      other.vipOnly == vipOnly &&
      other.hideContent == hideContent &&
      other.instant == instant &&
      other.permissionRequested == permissionRequested;

  @override
  int get hashCode => Object.hash(Object.hashAllUnordered(mutedAccounts), vipOnly, hideContent, instant);
}

final notificationSettingsProvider = NotifierProvider<NotificationSettingsController, NotificationSettings>(
  NotificationSettingsController.new,
);

class NotificationSettingsController extends Notifier<NotificationSettings> {
  @override
  NotificationSettings build() {
    ref.watch(prefsEpochProvider);
    return NotificationSettings.read(ref.watch(sharedPreferencesProvider));
  }

  Future<void> update(NotificationSettings Function(NotificationSettings current) change) async {
    final next = change(state);
    state = next;
    await next.write(ref.read(sharedPreferencesProvider));
  }
}
