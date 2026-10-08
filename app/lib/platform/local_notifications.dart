import 'dart:convert';
import 'dart:ui' show Color;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mail_model/mail_model.dart';

import '../features/notifications/mail_notifier.dart';
import '../features/notifications/notification_content.dart';
import '../l10n/l10n.dart';

/// The small status bar icon (res/drawable*/ic_stat_loupe.png).
const _icon = 'ic_stat_loupe';

/// The navy of the app icon, for the small icon's circle and the buttons.
const _accent = Color(0xFF1F4E8C);

/// iOS notification categories: the buttons a notification gets (iOS
/// registers them once, at start-up, rather than per notification).
const _withArchive = 'loupe.message';
const _withoutArchive = 'loupe.message.noArchive';

/// Archive and Mark as Read run in the background, like on Android; Reply
/// opens the app.
DarwinNotificationAction _darwinAction(MailAction a, AppLocalizations l10n) => DarwinNotificationAction.plain(
  a.id,
  a.label(l10n),
  options: {if (a == MailAction.reply) DarwinNotificationActionOption.foreground},
);

/// The plugin's settings, with the buttons in the device's language (this
/// runs in background isolates too, without a widget tree).
InitializationSettings _settings() {
  final l10n = deviceL10n();
  return InitializationSettings(
    android: const AndroidInitializationSettings(_icon),
    // Asks nothing at start: [LocalMailNotifier.requestPermission] does, at
    // the same moment as on Android.
    iOS: DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      notificationCategories: [
        DarwinNotificationCategory(
          _withArchive,
          actions: [
            for (final a in [MailAction.archive, MailAction.markRead, MailAction.reply]) _darwinAction(a, l10n),
          ],
        ),
        DarwinNotificationCategory(
          _withoutArchive,
          actions: [
            for (final a in [MailAction.markRead, MailAction.reply]) _darwinAction(a, l10n),
          ],
        ),
      ],
    ),
  );
}

/// [MailNotifier] on Android and iOS, through flutter_local_notifications.
final class LocalMailNotifier implements MailNotifier {
  LocalMailNotifier._(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  AndroidFlutterLocalNotificationsPlugin? get _android =>
      _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

  IOSFlutterLocalNotificationsPlugin? get _ios =>
      _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();

  /// Sets the plugin up in the app's main isolate: taps and Reply go to
  /// [onTap]; Archive and Mark as Read run [onBackgroundAction] in a
  /// background isolate. Returns the tap that launched the app, if any.
  static Future<(LocalMailNotifier, NotificationTap?)> initialize({
    required void Function(NotificationTap tap) onTap,
    required DidReceiveBackgroundNotificationResponseCallback onBackgroundAction,
  }) async {
    final plugin = FlutterLocalNotificationsPlugin();
    await plugin.initialize(
      settings: _settings(),
      onDidReceiveNotificationResponse: (response) {
        final tap = tapOf(response);
        if (tap != null) onTap(tap);
      },
      onDidReceiveBackgroundNotificationResponse: onBackgroundAction,
    );
    final launch = await plugin.getNotificationAppLaunchDetails();
    final response = launch?.didNotificationLaunchApp ?? false ? launch?.notificationResponse : null;
    return (LocalMailNotifier._(plugin), response == null ? null : tapOf(response));
  }

  /// Sets the plugin up in a background isolate (sync, actions): it only
  /// shows and cancels notifications there.
  static Future<LocalMailNotifier> initializeInBackground({
    required DidReceiveBackgroundNotificationResponseCallback onBackgroundAction,
  }) async {
    final plugin = FlutterLocalNotificationsPlugin();
    await plugin.initialize(settings: _settings(), onDidReceiveBackgroundNotificationResponse: onBackgroundAction);
    return LocalMailNotifier._(plugin);
  }

  /// What a tap that opens the app asks for; null for anything else.
  static NotificationTap? tapOf(NotificationResponse response) {
    final target = NotificationTarget.decode(response.payload);
    if (target == null) return null;
    return switch (response.notificationResponseType) {
      NotificationResponseType.selectedNotification => NotificationTap(target),
      NotificationResponseType.selectedNotificationAction when response.actionId == MailAction.reply.id =>
        NotificationTap(target, action: MailAction.reply),
      _ => null,
    };
  }

  @override
  Future<bool> permissionGranted() async =>
      await _android?.areNotificationsEnabled() ?? (await _ios?.checkPermissions())?.isEnabled ?? false;

  /// On iOS also asks for the badge, which app_badge_plus needs.
  @override
  Future<bool> requestPermission() async =>
      await _android?.requestNotificationsPermission() ??
      await _ios?.requestPermissions(alert: true, badge: true, sound: true) ??
      false;

  @override
  Future<void> openSystemSettings() async =>
      await _android?.openAppNotificationSettings() ?? await _ios?.openAppNotificationSettings();

  @override
  Future<void> syncChannels(List<MailAccount> accounts) async {
    final android = _android;
    if (android == null) return;
    final l10n = deviceL10n();
    final wanted = [MailChannel.vip, for (final a in accounts) MailChannel.account(a)];
    for (final c in wanted) {
      await android.createNotificationChannel(
        AndroidNotificationChannel(c.id, c.name(l10n), description: c.description(l10n), importance: Importance.high),
      );
    }
    final ids = {for (final c in wanted) c.id};
    for (final c in await android.getNotificationChannels() ?? const <AndroidNotificationChannel>[]) {
      if (c.id.startsWith(MailChannel.accountPrefix) && !ids.contains(c.id)) {
        await android.deleteNotificationChannel(channelId: c.id);
      }
    }
  }

  @override
  Future<void> show(List<MailNotification> notifications) async {
    final ios = _ios != null;
    final l10n = deviceL10n();
    for (final n in notifications) {
      // iOS groups an account's notifications itself (by thread) and sums
      // them up: no summary notification there.
      if (ios && n.isSummary) continue;
      await _plugin.show(
        id: n.id,
        title: n.title,
        // iOS has no expanded style; the body shows several lines anyway.
        body: ios ? n.expandedBody ?? n.body : n.body,
        notificationDetails: NotificationDetails(android: _details(n, l10n), iOS: _darwinDetails(n)),
        payload: n.target?.encode(),
      );
    }
  }

  static DarwinNotificationDetails _darwinDetails(MailNotification n) => DarwinNotificationDetails(
    threadIdentifier: n.groupKey,
    subtitle: n.subText,
    categoryIdentifier: n.actions.isEmpty
        ? null
        : n.actions.contains(MailAction.archive)
        ? _withArchive
        : _withoutArchive,
  );

  static AndroidNotificationDetails _details(MailNotification n, AppLocalizations l10n) => AndroidNotificationDetails(
    n.channel.id,
    n.channel.name(l10n),
    channelDescription: n.channel.description(l10n),
    importance: Importance.high,
    priority: Priority.high,
    category: AndroidNotificationCategory.email,
    color: _accent,
    groupKey: n.groupKey,
    setAsGroupSummary: n.isSummary,
    // Each message alerts once; the summary never does.
    groupAlertBehavior: GroupAlertBehavior.children,
    onlyAlertOnce: true,
    when: n.when?.millisecondsSinceEpoch,
    showWhen: n.when != null,
    subText: n.subText,
    visibility: NotificationVisibility.private,
    tag: n.tag,
    styleInformation: n.isSummary
        ? InboxStyleInformation(n.lines, contentTitle: n.title, summaryText: n.subText)
        : n.expandedBody == null
        ? null
        : BigTextStyleInformation(_bold(n.expandedBody!), htmlFormatBigText: true, contentTitle: n.title),
    actions: [
      for (final a in n.actions)
        AndroidNotificationAction(
          a.id,
          a.label(l10n),
          titleColor: _accent,
          // Reply opens the app; the others run in the background.
          showsUserInterface: a == MailAction.reply,
          semanticAction: switch (a) {
            MailAction.archive => SemanticAction.archive,
            MailAction.markRead => SemanticAction.markAsRead,
            MailAction.reply => SemanticAction.reply,
          },
        ),
    ],
  );

  /// The first line (the subject) in bold, the rest (the preview) plain.
  static String _bold(String text) {
    final escape = const HtmlEscape(HtmlEscapeMode.element).convert;
    final newline = text.indexOf('\n');
    if (newline < 0) return escape(text);
    return '<b>${escape(text.substring(0, newline))}</b><br>${escape(text.substring(newline + 1))}';
  }

  /// iOS reports no tag, but the payload, which is the same target.
  @override
  Future<List<ShownNotification>> shown() async => [
    for (final n in await _plugin.getActiveNotifications())
      if (n.id case final int id) ShownNotification(id: id, tag: n.tag ?? n.payload, title: n.title, body: n.body),
  ];

  @override
  Future<void> cancel(int id, {String? tag}) => _plugin.cancel(id: id, tag: tag);

  @override
  Future<void> cancelAll() => _plugin.cancelAll();
}
