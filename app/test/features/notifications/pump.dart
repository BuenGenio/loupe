import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/data/repositories.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/notifications/mail_notifier.dart';
import 'package:loupe/features/notifications/notifications_coordinator.dart';
import 'package:loupe/platform/instant_delivery.dart';
import 'package:loupe/platform/push.dart';
import 'package:loupe/platform/work_scheduler.dart';
import 'package:loupe/providers.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart' show testNow;
import 'fakes.dart';

class FakeInstantService implements InstantService {
  FakeInstantService({this.batteryRestricted = false});

  bool running = false;
  bool batteryRestricted;
  int starts = 0;
  int stops = 0;
  int nudges = 0;
  int batterySettingsOpened = 0;

  @override
  Future<bool> isRunning() async => running;

  @override
  Future<bool> start() async {
    starts++;
    return running = true;
  }

  @override
  Future<void> stop() async {
    stops++;
    running = false;
  }

  @override
  void nudge() => nudges++;

  @override
  Future<bool> isBatteryRestricted() async => batteryRestricted;

  @override
  Future<void> openBatterySettings() async => batterySettingsOpened++;
}

class FakePushService implements PushService {
  FakePushService({this.unavailable = false});

  /// Like a phone without Google Play services: no token.
  final bool unavailable;
  final calls = <bool>[];
  final _pushes = StreamController<void>.broadcast();

  bool? get enabled => calls.lastOrNull;

  /// A push arriving with the app in the foreground.
  void push() => _pushes.add(null);

  @override
  Future<void> setEnabled(bool enabled) async => calls.add(enabled);

  @override
  Future<String?> token() async => unavailable ? throw Exception('SERVICE_NOT_AVAILABLE') : 'fcm-token';

  @override
  Stream<void> get foregroundPushes => _pushes.stream;
}

class RecordingPeriodicSync implements PeriodicSync {
  final calls = <bool>[];

  bool? get enabled => calls.lastOrNull;

  @override
  Future<void> setEnabled(bool enabled) async => calls.add(enabled);
}

/// Like `pumpLoupe`, with the notification seams replaced: [notifier],
/// [periodic], [taps], [instant] (which also makes Instant Delivery
/// available) and [push] (likewise Push), plus any other [overrides]. Live mode runs on the demo
/// repository too.
Future<DemoMailRepository> pumpWithNotifications(
  WidgetTester tester, {
  AppMode mode = AppMode.demo,
  Map<String, Object> prefs = const {},
  required FakeNotifier notifier,
  RecordingPeriodicSync? periodic,
  NotificationTaps? taps,
  DemoMailRepository? repository,
  bool servesActions = false,
  InstantService? instant,
  PushService? push,
  List<Override> overrides = const [],
}) async {
  tester.view
    ..physicalSize = const Size(390, 844) * 3
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  SharedPreferences.setMockInitialValues({if (mode != AppMode.none) AppModeController.key: mode.name, ...prefs});
  final sharedPreferences = await SharedPreferences.getInstance();
  final repo = repository ?? DemoMailRepository.instant(clock: () => testNow);
  addTearDown(repo.dispose);
  await tester.pumpWidget(
    ProviderScope(
      // A new scope each time, like a fresh launch.
      key: UniqueKey(),
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        demoRepositoryProvider.overrideWithValue(repo),
        liveRepositoryProvider.overrideWith((ref) async => repo),
        repositoryProvider.overrideWith(repositoryForMode),
        mailNotifierProvider.overrideWithValue(notifier),
        if (periodic != null) periodicSyncProvider.overrideWithValue(periodic),
        if (taps != null) notificationTapsProvider.overrideWithValue(taps),
        servesNotificationActionsProvider.overrideWithValue(servesActions),
        instantServiceProvider.overrideWithValue(instant ?? const NoopInstantService()),
        instantDeliveryAvailableProvider.overrideWithValue(instant != null),
        pushServiceProvider.overrideWithValue(push ?? const NoopPushService()),
        pushAvailableProvider.overrideWithValue(push != null),
        ...overrides,
      ],
      child: const LoupeApp(),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}
