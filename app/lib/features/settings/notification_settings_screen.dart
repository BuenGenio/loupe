import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../platform/instant_delivery.dart';
import '../../platform/push.dart';
import '../../providers.dart';
import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart';
import '../../shared/grouped_list.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../account_import/qr_scanner.dart' show openAppSettingsProvider;
import '../notifications/app_icon_badge.dart';
import '../notifications/mail_notifier.dart';
import '../notifications/new_mail.dart';
import '../notifications/new_mail_check.dart';
import '../notifications/notification_content.dart';
import '../notifications/notification_settings.dart';
import 'settings_widgets.dart';

/// Whether the system lets Loupe notify; refreshed when the page shows again
/// (the user may have come back from the system settings).
final notificationPermissionProvider = FutureProvider.autoDispose<bool>(
  (ref) => ref.watch(mailNotifierProvider).permissionGranted(),
);

/// Whether Android's battery optimisation may stop Instant Delivery.
final instantBatteryRestrictedProvider = FutureProvider.autoDispose<bool>(
  (ref) => ref.watch(instantServiceProvider).isBatteryRestricted(),
);

/// The address pushes reach this phone at, while Push is on in live mode;
/// an error when the phone can't receive them (no Google Play services).
/// Not retried: Play services don't appear by trying again, and the page
/// asks afresh each time it opens.
final pushTokenProvider = FutureProvider.autoDispose<String?>((ref) {
  final on = ref.watch(notificationSettingsProvider.select((s) => s.push));
  final live = ref.watch(appModeProvider) == AppMode.live;
  return on && live ? ref.watch(pushServiceProvider).token() : Future.value();
}, retry: (_, _) => null);

/// Settings › Notifications: new-mail alerts per account, VIP only, hidden
/// content, a test notification, and the app icon badge. Android adds
/// Instant Delivery and Push; iOS, which can't hold a connection open, points to
/// Background App Refresh instead.
class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends ConsumerState<NotificationSettingsScreen> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onResume: () {
        ref.invalidate(notificationPermissionProvider);
        ref.invalidate(instantBatteryRestrictedProvider);
      },
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  NotificationSettingsController get _controller => ref.read(notificationSettingsProvider.notifier);

  /// Asks the system when notifications are switched on and aren't allowed.
  Future<bool> _ensurePermission() async {
    final notifier = ref.read(mailNotifierProvider);
    if (await notifier.permissionGranted()) return true;
    await _controller.update((s) => s.copyWith(permissionRequested: true));
    final granted = await notifier.requestPermission();
    ref.invalidate(notificationPermissionProvider);
    return granted;
  }

  Future<void> _setAccount(MailAccount account, bool notify) async {
    await _controller.update((s) => s.withAccount(account.id, notify: notify));
    if (notify) await _ensurePermission();
  }

  Future<void> _setInstant(bool on) async {
    await _controller.update((s) => s.copyWith(instant: on));
    // Its "Watching for new mail" notification needs the permission too.
    if (on) await _ensurePermission();
  }

  Future<void> _copyPushToken(String token) async {
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: token));
    messenger.showSnackBar(const SnackBar(content: Text('Push token copied')));
  }

  Future<void> _sendTest() async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    void say(String text) => messenger.showSnackBar(SnackBar(content: Text(text)));
    final ios = defaultTargetPlatform == TargetPlatform.iOS;
    if (!await _ensurePermission()) {
      say(ios ? l10n.settingsNotificationsOffIos : l10n.settingsNotificationsOffAndroid);
      return;
    }
    final repository = ref.read(repositoryProvider);
    final settings = ref.read(notificationSettingsProvider);
    final notification = await testNotification(repository, l10n, hideContent: settings.hideContent);
    await ref.read(mailNotifierProvider).show([notification]);
  }

  @override
  Widget build(BuildContext context) {
    // The system, not the look: Instant Delivery is Android's, Background
    // App Refresh iOS's.
    final ios = defaultTargetPlatform == TargetPlatform.iOS;
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final mode = ref.watch(appModeProvider);
    final settings = ref.watch(notificationSettingsProvider);
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
    final granted = ref.watch(notificationPermissionProvider).value;
    final anyOn = accounts.any((a) => settings.notifiesFor(a.id));
    final badge = ref.watch(appSettingsProvider.select((s) => s.appIconBadge));
    final badgeSupported = ref.watch(appIconBadgeSupportedProvider).value;
    final instantAvailable = ref.watch(instantDeliveryAvailableProvider);
    final batteryRestricted = instantAvailable && settings.instant
        ? ref.watch(instantBatteryRestrictedProvider).value ?? false
        : false;
    final pushAvailable = ref.watch(pushAvailableProvider);
    final pushToken = pushAvailable ? ref.watch(pushTokenProvider) : null;

    return GroupedPage(
      title: l10n.settingsNotifications,
      children: [
        if (granted == false && anyOn)
          InsetGroup(
            separatorIndent: 58,
            // l10n-ignore: the systems' names
            footer: l10n.settingsNotificationsBlockedFooter(ios ? 'iOS' : 'Android'),
            children: [
              GroupedRow(
                leading: Icon(LoupeIcons.warning, color: colors.flag),
                title: ios ? l10n.settingsOpenSystemSettings : l10n.settingsOpenAndroidSettings,
                onTap: () => unawaited(ref.read(mailNotifierProvider).openSystemSettings()),
              ),
            ],
          ),
        InsetGroup(
          header: l10n.settingsNewMailHeader,
          separatorIndent: 16,
          footer: mode == AppMode.demo
              ? l10n.settingsNewMailFooterDemo
              : ios
              ? l10n.settingsNewMailFooterIos
              : l10n.settingsNewMailFooterAndroid,
          children: [
            for (final a in accounts)
              SwitchRow(
                key: ValueKey(a.id),
                title: accountName(a),
                subtitle: a.email == accountName(a) ? null : a.email,
                value: settings.notifiesFor(a.id),
                onChanged: (v) => unawaited(_setAccount(a, v)),
              ),
            if (accounts.isEmpty) GroupedRow(title: l10n.settingsNoAccounts, enabled: false, chevron: false),
          ],
        ),
        InsetGroup(
          separatorIndent: 16,
          footer: settings.hideContent ? l10n.settingsHideContentFooterOn : l10n.settingsHideContentFooterOff,
          children: [
            SwitchRow(
              title: l10n.settingsVipOnly,
              subtitle: l10n.settingsVipOnlyDetail,
              value: settings.vipOnly,
              onChanged: (v) => unawaited(_controller.update((s) => s.copyWith(vipOnly: v))),
            ),
            SwitchRow(
              title: l10n.settingsHideContent,
              value: settings.hideContent,
              onChanged: (v) => unawaited(_controller.update((s) => s.copyWith(hideContent: v))),
            ),
          ],
        ),
        if (ios)
          InsetGroup(
            separatorIndent: 16,
            footer: l10n.settingsBackgroundRefreshFooter,
            children: [
              GroupedRow(
                title: l10n.settingsBackgroundAppRefresh,
                onTap: () => unawaited(ref.read(openAppSettingsProvider)()),
              ),
            ],
          )
        else
          InsetGroup(
            separatorIndent: 16,
            footer: batteryRestricted ? l10n.settingsBatteryRestrictedFooter : l10n.settingsInstantDeliveryFooter,
            children: [
              if (instantAvailable)
                SwitchRow(
                  title: l10n.settingsInstantDelivery,
                  subtitle: l10n.settingsExperimental,
                  value: settings.instant,
                  onChanged: (v) => unawaited(_setInstant(v)),
                )
              else
                GroupedRow(
                  title: l10n.settingsInstantDelivery,
                  detail: l10n.settingsComingSoon,
                  enabled: false,
                  chevron: false,
                ),
              if (batteryRestricted)
                GroupedRow(
                  title: l10n.settingsAllowUnrestrictedBattery,
                  onTap: () => unawaited(ref.read(instantServiceProvider).openBatterySettings()),
                ),
            ],
          ),
        if (!ios && pushAvailable)
          InsetGroup(
            separatorIndent: 16,
            footer: settings.push && (pushToken?.hasError ?? false)
                ? 'This phone can’t receive pushes: they need Google Play services and a network connection. '
                      'Loupe still checks for mail about every 15 minutes.'
                : 'Push lets new mail wake Loupe at once, where your mail service supports it. Pushes go through '
                      'Google’s push service and carry no mail, only “check now”.',
            children: [
              SwitchRow(
                title: 'Push',
                value: settings.push,
                onChanged: (v) => unawaited(_controller.update((s) => s.copyWith(push: v))),
              ),
              if (pushToken?.value case final token?)
                GroupedRow(title: 'Copy Push Token', chevron: false, onTap: () => unawaited(_copyPushToken(token))),
            ],
          ),
        InsetGroup(
          separatorIndent: 16,
          children: [
            GroupedRow(
              title: l10n.settingsSendTestNotification,
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              chevron: false,
              onTap: () => unawaited(_sendTest()),
            ),
          ],
        ),
        InsetGroup(
          separatorIndent: 16,
          footer: badgeSupported == false ? l10n.settingsBadgeUnsupportedFooter : l10n.settingsBadgeNote,
          children: [
            GroupedRow(
              title: l10n.settingsAppIconBadge,
              detail: badgeCountLabel(badge),
              onTap: () => ChoicePage.push<BadgeCount>(
                context,
                title: l10n.settingsAppIconBadge,
                selected: badge,
                footer: l10n.settingsBadgeNote,
                choices: [for (final c in BadgeCount.values) (value: c, label: badgeCountLabel(c), detail: null)],
                onSelected: (v) => ref.read(appSettingsProvider.notifier).update((s) => s.copyWith(appIconBadge: v)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// A notification like the ones new mail brings, for the newest unread
/// message in the inboxes (works with demo mail too); tapping it opens that
/// message, and its buttons work.
Future<MailNotification> testNotification(
  MailRepository repository,
  AppLocalizations l10n, {
  required bool hideContent,
}) async {
  const inboxes = VirtualMailboxRef(VirtualMailbox.allInboxes);
  final accounts = await repository.watchAccounts().first;
  final unread = await repository.watchList(inboxes, filters: {QuickFilter.unread}, threaded: false, limit: 1).first;
  final latest = unread.isNotEmpty ? unread : await repository.watchList(inboxes, threaded: false, limit: 1).first;
  final email = latest.firstOrNull?.latest;
  final account = accounts.where((a) => a.id == email?.accountId).firstOrNull;
  if (email == null || account == null) {
    return MailNotification(
      id: 1,
      channel: MailChannel.vip,
      groupKey: 'loupe.test',
      title: 'Loupe', // l10n-ignore: the name
      body: l10n.settingsTestNotificationBody,
    );
  }
  final vips = await repository.watchVipAddresses().first;
  final mailboxes = await repository.watchMailboxes().first;
  return messageNotification(
    NewMail(email, fromVip: email.from.any((a) => vips.contains(a.email.toLowerCase()))),
    account,
    hideContent: hideContent,
    canArchive: archivableAccounts(accounts, mailboxes).contains(account.id),
    showAccount: accounts.length > 1,
  );
}
