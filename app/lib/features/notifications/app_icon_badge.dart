import 'dart:async';
import 'dart:io' show Platform;

import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart';

/// The number on the app's launcher icon. Tests replace it to see the count
/// the app would show.
abstract interface class AppIconBadge {
  /// Whether this device's home screen shows numbers on app icons.
  Future<bool> isSupported();

  /// Shows [count] on the icon; 0 removes the badge.
  Future<void> show(int count);
}

/// The badge through app_badge_plus: iOS, Samsung One UI and the Android
/// launchers it knows. Elsewhere (Pixel, desktop, tests) it does nothing.
final class PlatformAppIconBadge implements AppIconBadge {
  const PlatformAppIconBadge();

  static bool get _platformHasBadges => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Future<bool> isSupported() async {
    if (!_platformHasBadges) return false;
    try {
      return await AppBadgePlus.isSupported();
    } on Exception {
      return false;
    }
  }

  @override
  Future<void> show(int count) async {
    if (!_platformHasBadges) return;
    try {
      await AppBadgePlus.updateBadge(count);
    } on Exception {
      // A launcher that refuses badges just shows none.
    }
  }
}

final appIconBadgeProvider = Provider<AppIconBadge>((ref) => const PlatformAppIconBadge());

/// Asked once per launch (on Android the answer depends on the launcher).
final appIconBadgeSupportedProvider = FutureProvider<bool>((ref) => ref.watch(appIconBadgeProvider).isSupported());

String badgeCountLabel(BadgeCount count) => switch (count) {
  BadgeCount.off => 'Off',
  BadgeCount.inboxes => 'Unread in Inboxes',
  BadgeCount.vip => 'Unread in VIP',
};

/// The number the badge should show: 0 when it's off or no account is set
/// up, null while the counts load.
final appIconBadgeCountProvider = Provider<int?>((ref) {
  if (ref.watch(appModeProvider) == AppMode.none) return 0;
  final kind = ref.watch(appSettingsProvider.select((s) => s.appIconBadge));
  if (kind == BadgeCount.off) return 0;
  final counts = ref.watch(virtualCountsProvider).value;
  if (counts == null) return null;
  // Server unread counts for the inboxes; VIP counts what is stored here.
  return counts[kind == BadgeCount.vip ? VirtualMailbox.vip : VirtualMailbox.allInboxes] ?? 0;
});

/// Keeps the app icon badge in step with the chosen count while the app
/// runs. Counts change when Loupe syncs; until background sync arrives, the
/// badge shows what the last sync in the foreground found.
class AppIconBadgeUpdater extends ConsumerStatefulWidget {
  const AppIconBadgeUpdater({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppIconBadgeUpdater> createState() => _AppIconBadgeUpdaterState();
}

class _AppIconBadgeUpdaterState extends ConsumerState<AppIconBadgeUpdater> {
  int? _shown;

  @override
  void initState() {
    super.initState();
    ref.listenManual<int?>(appIconBadgeCountProvider, (_, count) => unawaited(_show(count)), fireImmediately: true);
  }

  Future<void> _show(int? count) async {
    if (count == null || count == _shown) return;
    final supported = await ref.read(appIconBadgeSupportedProvider.future);
    if (!supported || !mounted) return;
    _shown = count;
    await ref.read(appIconBadgeProvider).show(count);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
