import 'dart:convert';
import 'dart:ui' show Color;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mail_model/mail_model.dart';

import '../features/notifications/mail_notifier.dart';
import '../features/notifications/notification_content.dart';

/// The small status bar icon (res/drawable*/ic_stat_loupe.png).
const _icon = 'ic_stat_loupe';

/// The navy of the app icon, for the small icon's circle and the buttons.
const _accent = Color(0xFF1F4E8C);

/// [MailNotifier] on Android, through flutter_local_notifications.
final class LocalMailNotifier implements MailNotifier {
  LocalMailNotifier._(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  AndroidFlutterLocalNotificationsPlugin? get _android =>
      _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

  /// Sets the plugin up in the app's main isolate: taps and Reply go to
  /// [onTap]; Archive and Mark as Read run [onBackgroundAction] in a
  /// background isolate. Returns the tap that launched the app, if any.
  static Future<(LocalMailNotifier, NotificationTap?)> initialize({
    required void Function(NotificationTap tap) onTap,
    required DidReceiveBackgroundNotificationResponseCallback onBackgroundAction,
  }) async {
    final plugin = FlutterLocalNotificationsPlugin();
    await plugin.initialize(
      settings: const InitializationSettings(android: AndroidInitializationSettings(_icon)),
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
    await plugin.initialize(
      settings: const InitializationSettings(android: AndroidInitializationSettings(_icon)),
      onDidReceiveBackgroundNotificationResponse: onBackgroundAction,
    );
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
  Future<bool> permissionGranted() async => await _android?.areNotificationsEnabled() ?? false;

  @override
  Future<bool> requestPermission() async => await _android?.requestNotificationsPermission() ?? false;

  @override
  Future<void> openSystemSettings() async => _android?.openAppNotificationSettings();

  @override
  Future<void> syncChannels(List<MailAccount> accounts) async {
    final android = _android;
    if (android == null) return;
    final wanted = [MailChannel.vip, for (final a in accounts) MailChannel.account(a)];
    for (final c in wanted) {
      await android.createNotificationChannel(
        AndroidNotificationChannel(c.id, c.name, description: c.description, importance: Importance.high),
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
    for (final n in notifications) {
      await _plugin.show(
        id: n.id,
        title: n.title,
        body: n.body,
        notificationDetails: NotificationDetails(android: _details(n)),
        payload: n.target?.encode(),
      );
    }
  }

  static AndroidNotificationDetails _details(MailNotification n) => AndroidNotificationDetails(
    n.channel.id,
    n.channel.name,
    channelDescription: n.channel.description,
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
    styleInformation: n.isSummary
        ? InboxStyleInformation(n.lines, contentTitle: n.title, summaryText: n.subText)
        : n.expandedBody == null
        ? null
        : BigTextStyleInformation(_bold(n.expandedBody!), htmlFormatBigText: true, contentTitle: n.title),
    actions: [
      for (final a in n.actions)
        AndroidNotificationAction(
          a.id,
          a.label,
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

  @override
  Future<List<ShownNotification>> shown() async => [
    for (final n in await _plugin.getActiveNotifications())
      if (n.id case final int id)
        ShownNotification(id: id, title: n.title, body: n.body, target: NotificationTarget.decode(n.payload)),
  ];

  @override
  Future<void> cancel(int id) => _plugin.cancel(id: id);

  @override
  Future<void> cancelAll() => _plugin.cancelAll();
}
