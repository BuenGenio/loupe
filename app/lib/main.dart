import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/repositories.dart';
import 'features/notifications/mail_notifier.dart';
import 'features/notifications/notifications_coordinator.dart';
import 'platform/background.dart';
import 'platform/background_entry.dart';
import 'platform/local_notifications.dart';
import 'platform/work_scheduler.dart';
import 'providers.dart';
import 'settings/app_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final taps = NotificationTaps();
  final android = !kIsWeb && Platform.isAndroid;
  final overrides = [
    sharedPreferencesProvider.overrideWithValue(prefs),
    repositoryProvider.overrideWith(repositoryForMode),
    notificationTapsProvider.overrideWithValue(taps),
  ];
  // Background sync (WorkManager) and new-mail notifications, Android only
  // for now. Neither may keep the app from starting.
  if (android) {
    try {
      final work = WorkmanagerWorkScheduler();
      await work.initialize(backgroundTaskDispatcher);
      final scheduler = WorkmanagerBackgroundScheduler(work);
      overrides.addAll([
        backgroundSchedulerProvider.overrideWithValue(scheduler),
        periodicSyncProvider.overrideWithValue(scheduler),
      ]);
    } on Object catch (e) {
      debugPrint('Background sync unavailable: $e');
    }
    try {
      final (notifier, launch) = await LocalMailNotifier.initialize(
        onTap: taps.add,
        onBackgroundAction: onNotificationAction,
      );
      taps.launch = launch;
      overrides.addAll([
        mailNotifierProvider.overrideWithValue(notifier),
        servesNotificationActionsProvider.overrideWithValue(true),
      ]);
    } on Object catch (e) {
      debugPrint('Notifications unavailable: $e');
    }
  }
  runApp(ProviderScope(overrides: overrides, child: const LoupeApp()));
}
