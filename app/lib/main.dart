import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/repositories.dart';
import 'features/notifications/mail_notifier.dart';
import 'features/notifications/notifications_coordinator.dart';
import 'platform/background.dart';
import 'platform/background_entry.dart';
import 'platform/error_log.dart';
import 'platform/instant_delivery.dart';
import 'platform/local_notifications.dart';
import 'platform/work_scheduler.dart';
import 'providers.dart';
import 'settings/app_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  installErrorHandlers(ErrorLog(getApplicationSupportDirectory()));
  // Dates in every language intl knows, before Flutter's own (a smaller
  // set) can claim the table: see formatLocale in l10n/l10n.dart.
  await initializeDateFormatting();
  final prefs = await SharedPreferences.getInstance();
  final taps = NotificationTaps();
  final android = !kIsWeb && Platform.isAndroid;
  final ios = !kIsWeb && Platform.isIOS;
  final overrides = [
    sharedPreferencesProvider.overrideWithValue(prefs),
    repositoryProvider.overrideWith(repositoryForMode),
    notificationTapsProvider.overrideWithValue(taps),
  ];
  // Background sync (WorkManager on Android, a BGAppRefreshTask on iOS) and
  // new-mail notifications. None of them may keep the app from starting.
  if (android || ios) {
    try {
      await WorkmanagerWorkScheduler().initialize(backgroundTaskDispatcher);
      final scheduler = platformSyncScheduler()!;
      overrides.addAll([
        backgroundSchedulerProvider.overrideWithValue(scheduler),
        periodicSyncProvider.overrideWithValue(scheduler),
      ]);
    } on Object catch (e) {
      debugPrint('Background sync unavailable: $e');
    }
    // Android only: iOS allows no lasting connection, and Settings doesn't
    // offer it there.
    if (android) {
      try {
        overrides.addAll([
          instantServiceProvider.overrideWithValue(ForegroundTaskInstantService()),
          instantDeliveryAvailableProvider.overrideWithValue(true),
        ]);
      } on Object catch (e) {
        debugPrint('Instant Delivery unavailable: $e');
      }
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
