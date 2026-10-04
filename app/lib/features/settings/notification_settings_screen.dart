import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../platform/instant_delivery.dart';
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

/// Settings › Notifications: new-mail alerts per account, VIP only, hidden
/// content, a test notification, and the app icon badge. Android adds
/// Instant Delivery; iOS, which can't hold a connection open, points to
/// Background App Refresh instead.
class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends ConsumerState<NotificationSettingsScreen> {
  late final AppLifecycleListener _lifecycle;

  static const _badgeNote = 'The badge updates whenever Loupe checks for mail, also in the background.';

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

  Future<void> _sendTest() async {
    final messenger = ScaffoldMessenger.of(context);
    void say(String text) => messenger.showSnackBar(SnackBar(content: Text(text)));
    final ios = defaultTargetPlatform == TargetPlatform.iOS;
    if (!await _ensurePermission()) {
      say(
        ios ? 'Notifications are off for Loupe in Settings.' : 'Notifications are off for Loupe in Android Settings.',
      );
      return;
    }
    final repository = ref.read(repositoryProvider);
    final settings = ref.read(notificationSettingsProvider);
    final notification = await testNotification(repository, hideContent: settings.hideContent);
    await ref.read(mailNotifierProvider).show([notification]);
  }

  @override
  Widget build(BuildContext context) {
    // The system, not the look: Instant Delivery is Android's, Background
    // App Refresh iOS's.
    final ios = defaultTargetPlatform == TargetPlatform.iOS;
    final colors = LoupeColors.of(context);
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

    return GroupedPage(
      title: 'Notifications',
      children: [
        if (granted == false && anyOn)
          InsetGroup(
            separatorIndent: 58,
            footer: '${ios ? 'iOS' : 'Android'} doesn’t let Loupe show notifications. Allow them in Settings.',
            children: [
              GroupedRow(
                leading: Icon(LoupeIcons.warning, color: colors.flag),
                title: ios ? 'Open Settings' : 'Open Android Settings',
                onTap: () => unawaited(ref.read(mailNotifierProvider).openSystemSettings()),
              ),
            ],
          ),
        InsetGroup(
          header: 'New Mail',
          separatorIndent: 16,
          footer: mode == AppMode.demo
              ? 'Demo mail doesn’t arrive in the background. Send a test notification to see how new mail looks.'
              : ios
              ? 'Loupe checks for new mail in the background when iOS lets it, which can be hours apart for apps '
                    'you don’t open often. You’re told about new messages in your inboxes, and from VIPs in any folder.'
              : 'Loupe checks for new mail about every 15 minutes, when Android allows. You’re told about new '
                    'messages in your inboxes, and from VIPs in any folder.',
          children: [
            for (final a in accounts)
              SwitchRow(
                key: ValueKey(a.id),
                title: accountName(a),
                subtitle: a.email == accountName(a) ? null : a.email,
                value: settings.notifiesFor(a.id),
                onChanged: (v) => unawaited(_setAccount(a, v)),
              ),
            if (accounts.isEmpty) const GroupedRow(title: 'No Accounts', enabled: false, chevron: false),
          ],
        ),
        InsetGroup(
          separatorIndent: 16,
          footer: settings.hideContent
              ? 'Notifications only say “New message from” and the account, not who wrote or what about.'
              : 'Hide Content keeps the sender, subject and preview off the lock screen and out of notifications.',
          children: [
            SwitchRow(
              title: 'VIP Only',
              subtitle: 'Only messages from your VIPs',
              value: settings.vipOnly,
              onChanged: (v) => unawaited(_controller.update((s) => s.copyWith(vipOnly: v))),
            ),
            SwitchRow(
              title: 'Hide Content',
              value: settings.hideContent,
              onChanged: (v) => unawaited(_controller.update((s) => s.copyWith(hideContent: v))),
            ),
          ],
        ),
        if (ios)
          InsetGroup(
            separatorIndent: 16,
            footer:
                'New mail only arrives in the background while Background App Refresh is on for Loupe in Settings. '
                'iOS can’t keep a connection to your inboxes open, so there’s no Instant Delivery.',
            children: [
              GroupedRow(title: 'Background App Refresh', onTap: () => unawaited(ref.read(openAppSettingsProvider)())),
            ],
          )
        else
          InsetGroup(
            separatorIndent: 16,
            footer: batteryRestricted
                ? 'Android may stop Instant Delivery to save battery. Let Loupe use the battery without '
                      'restrictions to keep it running.'
                : 'Instant Delivery (experimental) keeps a connection to your inboxes open, so new mail arrives '
                      'within seconds. It shows a quiet “Watching for new mail” notification and uses more battery.',
            children: [
              if (instantAvailable)
                SwitchRow(
                  title: 'Instant Delivery',
                  subtitle: 'Experimental',
                  value: settings.instant,
                  onChanged: (v) => unawaited(_setInstant(v)),
                )
              else
                const GroupedRow(title: 'Instant Delivery', detail: 'Coming Soon', enabled: false, chevron: false),
              if (batteryRestricted)
                GroupedRow(
                  title: 'Allow Unrestricted Battery Use',
                  onTap: () => unawaited(ref.read(instantServiceProvider).openBatterySettings()),
                ),
            ],
          ),
        InsetGroup(
          separatorIndent: 16,
          children: [
            GroupedRow(
              title: 'Send Test Notification',
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              chevron: false,
              onTap: () => unawaited(_sendTest()),
            ),
          ],
        ),
        InsetGroup(
          separatorIndent: 16,
          footer: badgeSupported == false
              ? 'This phone’s home screen doesn’t show numbers on app icons. $_badgeNote'
              : _badgeNote,
          children: [
            GroupedRow(
              title: 'App Icon Badge',
              detail: badgeCountLabel(badge),
              onTap: () => ChoicePage.push<BadgeCount>(
                context,
                title: 'App Icon Badge',
                selected: badge,
                footer: _badgeNote,
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
Future<MailNotification> testNotification(MailRepository repository, {required bool hideContent}) async {
  const inboxes = VirtualMailboxRef(VirtualMailbox.allInboxes);
  final accounts = await repository.watchAccounts().first;
  final unread = await repository.watchList(inboxes, filters: {QuickFilter.unread}, threaded: false, limit: 1).first;
  final latest = unread.isNotEmpty ? unread : await repository.watchList(inboxes, threaded: false, limit: 1).first;
  final email = latest.firstOrNull?.latest;
  final account = accounts.where((a) => a.id == email?.accountId).firstOrNull;
  if (email == null || account == null) {
    return const MailNotification(
      id: 1,
      channel: MailChannel.vip,
      groupKey: 'loupe.test',
      title: 'Loupe',
      body: 'Notifications for new mail look like this.',
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
