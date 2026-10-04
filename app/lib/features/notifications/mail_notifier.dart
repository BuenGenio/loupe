import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import 'notification_content.dart';

/// Shows new-mail notifications and reports what is showing. The app uses
/// the flutter_local_notifications one on Android (`LocalMailNotifier`);
/// elsewhere and in tests something else stands in.
abstract interface class MailNotifier {
  /// Whether Android lets Loupe post notifications (POST_NOTIFICATIONS).
  Future<bool> permissionGranted();

  /// Asks for POST_NOTIFICATIONS (Android 13+). Returns whether it's granted.
  Future<bool> requestPermission();

  /// Opens Loupe's notification settings in Android Settings.
  Future<void> openSystemSettings();

  /// Creates or renames the channels of [accounts] and the VIP channel, and
  /// deletes those of accounts that are gone.
  Future<void> syncChannels(List<MailAccount> accounts);

  Future<void> show(List<MailNotification> notifications);

  /// The notifications Loupe shows right now.
  Future<List<ShownNotification>> shown();

  Future<void> cancel(int id);

  Future<void> cancelAll();
}

/// Shows nothing (tests, platforms without notifications yet). Claims
/// permission, so nothing asks the user to fix what can't be fixed.
class NoopMailNotifier implements MailNotifier {
  const NoopMailNotifier();

  @override
  Future<bool> permissionGranted() async => true;

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<void> openSystemSettings() async {}

  @override
  Future<void> syncChannels(List<MailAccount> accounts) async {}

  @override
  Future<void> show(List<MailNotification> notifications) async {}

  @override
  Future<List<ShownNotification>> shown() async => const [];

  @override
  Future<void> cancel(int id) async {}

  @override
  Future<void> cancelAll() async {}
}

final mailNotifierProvider = Provider<MailNotifier>((ref) => const NoopMailNotifier());

/// The user tapped a notification, or a button of it that opens the app.
@immutable
final class NotificationTap {
  const NotificationTap(this.target, {this.action});

  final NotificationTarget target;

  /// [MailAction.reply], or null for the notification itself.
  final MailAction? action;
}

/// Taps that open the app: the one that launched it (if any), then the ones
/// while it runs. Overridden in main().
final class NotificationTaps {
  NotificationTaps({this.launch});

  /// The tap that started the app, until [takeLaunch] hands it out.
  NotificationTap? launch;
  final _taps = StreamController<NotificationTap>.broadcast();

  Stream<NotificationTap> get stream => _taps.stream;

  void add(NotificationTap tap) => _taps.add(tap);

  NotificationTap? takeLaunch() {
    final tap = launch;
    launch = null;
    return tap;
  }
}

final notificationTapsProvider = Provider<NotificationTaps>((ref) => NotificationTaps());
