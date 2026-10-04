import 'dart:async';

import 'package:clock/clock.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loupe/app.dart';
import 'package:loupe/data/repositories.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/notifications/app_icon_badge.dart';
import 'package:loupe/providers.dart';
import 'package:loupe/router.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A fixed "now" so the demo mailbox is the same in every run.
final testNow = DateTime(2026, 10, 4, 16);

/// Pumps the whole app on a phone-sized screen against a zero-latency demo
/// repository. Returns the repository.
Future<DemoMailRepository> pumpLoupe(
  WidgetTester tester, {
  AppMode mode = AppMode.demo,
  Map<String, Object> prefs = const {},
  DemoMailRepository? repository,
  Size size = const Size(390, 844),
  AppIconBadge? badge,
  List<Override> overrides = const [],
}) async {
  tester.view
    ..physicalSize = size * 3
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  SharedPreferences.setMockInitialValues({if (mode != AppMode.none) AppModeController.key: mode.name, ...prefs});
  final sharedPreferences = await SharedPreferences.getInstance();
  final repo = repository ?? DemoMailRepository.instant(clock: () => testNow);
  addTearDown(repo.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        demoRepositoryProvider.overrideWithValue(repo),
        // Stands in for the real repository: live mode needs a device.
        liveRepositoryProvider.overrideWith((ref) async => repo),
        repositoryProvider.overrideWith(repositoryForMode),
        if (badge != null) appIconBadgeProvider.overrideWithValue(badge),
        ...overrides,
      ],
      child: const LoupeApp(),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

/// Navigates like a tap on a link would.
Future<void> goTo(WidgetTester tester, String location, {bool settle = true}) async {
  final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
  final GoRouter router = container.read(routerProvider);
  unawaited(router.push<void>(location));
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    // Finish the page transition without letting much fake time pass.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 450));
  }
}

/// Lets SnackBars and other timers run out before the test ends.
Future<void> drainTimers(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

Finder textContaining(String text) => find.textContaining(text, findRichText: true);

extension ScrollUntil on WidgetTester {
  Future<void> scrollTo(Finder finder) => scrollUntilVisible(finder, 200, scrollable: find.byType(Scrollable).first);
}

/// Runs [body] with `clock.now()` at [testNow] (advancing with the test's
/// fake time), the time the demo repository lives in: logic that reads the
/// clock (relative dates, previews of the last days) then agrees with the
/// demo mail whatever the real date is.
Future<T> atTestNow<T>(Future<T> Function() body) {
  final outer = clock;
  final offset = testNow.difference(outer.now());
  return withClock(Clock(() => outer.now().add(offset)), body);
}
