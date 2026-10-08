import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/app_lock/app_lock.dart';
import 'package:loupe/features/app_lock/app_lock_settings.dart';
import 'package:loupe/features/app_lock/device_authenticator.dart';
import 'package:loupe/platform/recents_privacy.dart';
import 'package:loupe/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart';

/// Answers for the system prompt.
class FakeAuthenticator implements DeviceAuthenticator {
  FakeAuthenticator({this.available = true, List<AuthResult> results = const []}) : results = [...results];

  /// Whether the phone has a screen lock (or a fingerprint or face).
  bool available;

  /// The answers to the next prompts, in order; success once they run out.
  final List<AuthResult> results;

  /// The titles of the prompts shown.
  final prompts = <String>[];

  /// When set, the next prompt stays open until this completes.
  Completer<AuthResult>? hold;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<AuthResult> authenticate({required String title, required String reason}) async {
    prompts.add(title);
    final held = hold;
    hold = null;
    if (held != null) return held.future;
    return results.isEmpty ? AuthResult.success : results.removeAt(0);
  }
}

class FakeRecents implements RecentsPrivacy {
  /// Every call: true hides Loupe's content in Recent Apps.
  final calls = <bool>[];

  @override
  Future<void> hideContent(bool hide) async => calls.add(hide);
}

const _lockOn = {AppLockSettingsController.enabledKey: true};

Future<({FakeAuthenticator auth, FakeRecents recents})> _pump(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
  FakeAuthenticator? auth,
  Future<void> Function()? openScreenLockSettings,
}) async {
  final authenticator = auth ?? FakeAuthenticator();
  final recents = FakeRecents();
  await pumpLoupe(
    tester,
    prefs: prefs,
    overrides: [
      deviceAuthenticatorProvider.overrideWithValue(authenticator),
      recentsPrivacyProvider.overrideWithValue(recents),
      if (openScreenLockSettings != null) openScreenLockSettingsProvider.overrideWithValue(openScreenLockSettings),
    ],
  );
  return (auth: authenticator, recents: recents);
}

/// Loupe in the foreground, as Android reports it once the activity runs.
Future<void> _resumed(WidgetTester tester) async {
  tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
  await tester.pumpAndSettle();
}

/// Home, or another app: Loupe goes out of sight. No frames are drawn then,
/// so this forces one, as the engine may when the surface comes back, to see
/// what it would show.
Future<void> _leave(WidgetTester tester) async {
  for (final state in [AppLifecycleState.inactive, AppLifecycleState.hidden, AppLifecycleState.paused]) {
    tester.binding.handleAppLifecycleStateChanged(state);
  }
  tester.binding.scheduleForcedFrame();
  await tester.pump();
}

/// Back to Loupe after [away].
Future<void> _comeBack(WidgetTester tester, {Duration away = Duration.zero}) async {
  await tester.pump(away);
  for (final state in [AppLifecycleState.hidden, AppLifecycleState.inactive, AppLifecycleState.resumed]) {
    tester.binding.handleAppLifecycleStateChanged(state);
  }
  await tester.pumpAndSettle();
}

final _unlock = find.widgetWithText(FilledButton, 'Unlock');
final _mail = find.text('All Inboxes');

void _expectLocked() {
  expect(_unlock, findsOneWidget);
  expect(_mail, findsNothing, reason: 'nothing of the mail shows under the lock');
}

void _expectOpen() {
  expect(_unlock, findsNothing);
  expect(find.byType(LockScreen), findsNothing);
  expect(_mail, findsOneWidget);
}

final _appLockSwitchFinder = find.descendant(
  of: find.byKey(const Key('app-lock')),
  matching: find.byType(CupertinoSwitch),
);

CupertinoSwitch _appLockSwitch(WidgetTester tester) => tester.widget<CupertinoSwitch>(_appLockSwitchFinder);

Future<void> _openSecuritySettings(WidgetTester tester) async {
  await goTo(tester, Routes.settings);
  await tester.scrollTo(find.byKey(const Key('app-lock')));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('off by default: no lock on a cold start, nothing asked', (tester) async {
    final (:auth, :recents) = await _pump(tester);
    await _resumed(tester);
    _expectOpen();
    await _leave(tester);
    await _comeBack(tester, away: const Duration(hours: 2));
    _expectOpen();
    expect(auth.prompts, isEmpty);
    expect(recents.calls, isEmpty, reason: 'Recent Apps keeps its screenshot');
  });

  testWidgets('on: a cold start shows the lock first and asks once by itself', (tester) async {
    final (:auth, :recents) = await _pump(
      tester,
      prefs: _lockOn,
      auth: FakeAuthenticator(results: [AuthResult.cancelled, AuthResult.cancelled]),
    );
    _expectLocked();
    expect(find.text('Loupe'), findsOneWidget);
    expect(_mail.hitTestable(), findsNothing);
    expect(find.text('All Inboxes', skipOffstage: false), findsOneWidget, reason: 'the app runs under the lock');
    expect(recents.calls, [true], reason: 'Recent Apps shows no mail');
    expect(auth.prompts, isEmpty, reason: 'the prompt waits for the foreground');

    await _resumed(tester);
    expect(auth.prompts, ['Unlock Loupe']);
    _expectLocked();

    // Cancelled: the prompt closing doesn't bring it back.
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(auth.prompts, hasLength(1));
    _expectLocked();

    // Left at the lock screen and back: it asks by itself again, once.
    await _leave(tester);
    await _comeBack(tester, away: const Duration(minutes: 1));
    expect(auth.prompts, hasLength(2));
    _expectLocked();

    await tester.tap(_unlock);
    await tester.pumpAndSettle();
    expect(auth.prompts, hasLength(3));
    _expectOpen();
  });

  testWidgets('a PIN screen that hides Loupe neither locks again nor asks again', (tester) async {
    // Android 10 and earlier show the PIN, pattern or password in a screen of
    // their own, so Loupe goes out of sight during the prompt.
    final pin = Completer<AuthResult>();
    final (:auth, recents: _) = await _pump(tester, prefs: _lockOn, auth: FakeAuthenticator()..hold = pin);
    await _resumed(tester);
    expect(auth.prompts, hasLength(1));
    await _leave(tester);
    pin.complete(AuthResult.cancelled);
    await _comeBack(tester);
    expect(auth.prompts, hasLength(1), reason: 'closing the PIN screen doesn’t open the prompt again');
    _expectLocked();

    // The right PIN, with Loupe back in sight before the answer arrives.
    final rightPin = Completer<AuthResult>();
    auth.hold = rightPin;
    await tester.tap(_unlock);
    await tester.pump();
    await _leave(tester);
    await _comeBack(tester);
    rightPin.complete(AuthResult.success);
    await tester.pumpAndSettle();
    _expectOpen();
    expect(auth.prompts, hasLength(2));
  });

  testWidgets('a failed prompt keeps the lock and says why', (tester) async {
    final (:auth, recents: _) = await _pump(
      tester,
      prefs: _lockOn,
      auth: FakeAuthenticator(results: [AuthResult.failed, AuthResult.lockedOut, AuthResult.cancelled]),
    );
    await tester.tap(_unlock);
    await tester.pumpAndSettle();
    _expectLocked();
    expect(find.text('Loupe couldn’t confirm it’s you.'), findsOneWidget);

    await tester.tap(_unlock);
    await tester.pumpAndSettle();
    _expectLocked();
    expect(find.text('Too many attempts. Try again later.'), findsOneWidget);

    await tester.tap(_unlock);
    await tester.pumpAndSettle();
    _expectLocked();
    expect(find.text('Too many attempts. Try again later.'), findsNothing, reason: 'a new try clears it');

    await tester.tap(_unlock);
    await tester.pumpAndSettle();
    expect(auth.prompts, hasLength(4));
    _expectOpen();
  });

  testWidgets('Immediately: locks as Loupe leaves the screen, where the user was', (tester) async {
    final (:auth, recents: _) = await _pump(
      tester,
      prefs: _lockOn,
      auth: FakeAuthenticator(results: [AuthResult.success, AuthResult.cancelled]),
    );
    await _resumed(tester);
    _expectOpen();
    await goTo(tester, Routes.settings);
    expect(find.text('Swipe Actions'), findsOneWidget);

    // The notification shade, a system dialog: still in sight.
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(_unlock, findsNothing);

    await _leave(tester);
    expect(_unlock, findsOneWidget, reason: 'locked before it comes back');
    expect(find.text('Swipe Actions'), findsNothing);
    expect(auth.prompts, hasLength(1), reason: 'no prompt in the background');

    await _comeBack(tester);
    expect(auth.prompts, hasLength(2));
    expect(_unlock, findsOneWidget);

    await tester.tap(_unlock);
    await tester.pumpAndSettle();
    expect(find.text('Swipe Actions'), findsOneWidget, reason: 'back where the user was');
  });

  testWidgets('Lock After: locks again only after being away that long', (tester) async {
    final (:auth, recents: _) = await _pump(
      tester,
      prefs: {..._lockOn, AppLockSettingsController.lockAfterKey: LockAfter.fiveMinutes.name},
      auth: FakeAuthenticator(results: [AuthResult.success, AuthResult.cancelled]),
    );
    await _resumed(tester);
    _expectOpen();

    await _leave(tester);
    expect(find.byType(LockScreen), findsOneWidget, reason: 'covered while out of sight');
    expect(_unlock, findsNothing);
    await _comeBack(tester, away: const Duration(minutes: 4));
    _expectOpen();
    expect(auth.prompts, hasLength(1));

    await _leave(tester);
    await _comeBack(tester, away: const Duration(minutes: 5));
    _expectLocked();
    expect(auth.prompts, ['Unlock Loupe', 'Unlock Loupe']);
  });

  testWidgets('Back on the lock screen leaves Loupe, not the screen under it', (tester) async {
    final (:auth, recents: _) = await _pump(
      tester,
      prefs: _lockOn,
      auth: FakeAuthenticator(results: [AuthResult.success, AuthResult.cancelled]),
    );
    final calls = <String>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      calls.add(call.method);
      return null;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));
    await _resumed(tester);
    await goTo(tester, Routes.settings);
    await _leave(tester);
    await _comeBack(tester);
    _expectLocked();

    await systemBack(tester);
    expect(calls, contains('SystemNavigator.pop'));
    await tester.tap(_unlock);
    await tester.pumpAndSettle();
    expect(find.text('Swipe Actions'), findsOneWidget, reason: 'Settings is still open');
    expect(auth.prompts, hasLength(3));
  });

  testWidgets('a phone whose screen lock was removed opens, and App Lock turns off', (tester) async {
    final (:auth, :recents) = await _pump(
      tester,
      prefs: _lockOn,
      auth: FakeAuthenticator(available: false, results: [AuthResult.unavailable]),
    );
    await tester.tap(_unlock);
    await tester.pumpAndSettle();
    _expectOpen();
    expect(textContaining('App Lock is off'), findsOneWidget);
    expect((await SharedPreferences.getInstance()).getBool(AppLockSettingsController.enabledKey), isFalse);
    expect(recents.calls, [true, false]);
    await drainTimers(tester);
  });

  testWidgets('Settings: turning App Lock on asks first; Lock After; turning it off', (tester) async {
    final (:auth, :recents) = await _pump(
      tester,
      auth: FakeAuthenticator(results: [AuthResult.cancelled, AuthResult.failed, AuthResult.success]),
    );
    await _openSecuritySettings(tester);
    expect(find.text('SECURITY'), findsOneWidget);
    expect(_appLockSwitch(tester).value, isFalse);
    expect(find.text('Lock After'), findsNothing);

    // Cancelled: still off.
    await tester.tap(find.text('App Lock'));
    await tester.pumpAndSettle();
    expect(auth.prompts, ['Turn On App Lock']);
    expect(_appLockSwitch(tester).value, isFalse);

    // Not recognised: still off, and says so.
    await tester.tap(_appLockSwitchFinder);
    await tester.pumpAndSettle();
    expect(_appLockSwitch(tester).value, isFalse);
    expect(find.text('App Lock is still off. Loupe couldn’t confirm it’s you.'), findsOneWidget);
    await drainTimers(tester);

    await tester.tap(find.text('App Lock'));
    await tester.pumpAndSettle();
    expect(auth.prompts, hasLength(3));
    expect(_appLockSwitch(tester).value, isTrue);
    expect(_unlock, findsNothing, reason: 'turning it on doesn’t lock');
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool(AppLockSettingsController.enabledKey), isTrue);
    expect(recents.calls, [true]);

    await tester.scrollTo(find.text('Lock After'));
    expect(find.text('Immediately'), findsOneWidget);
    await tester.tap(find.text('Lock After'));
    await tester.pumpAndSettle();
    for (final label in ['Immediately', '1 Minute', '5 Minutes', '15 Minutes', '1 Hour']) {
      expect(find.text(label), findsOneWidget);
    }
    await tester.tap(find.text('15 Minutes'));
    await tester.pumpAndSettle();
    expect(prefs.getString(AppLockSettingsController.lockAfterKey), 'fifteenMinutes');
    await systemBack(tester);
    expect(find.text('15 Minutes'), findsOneWidget);

    // Off needs no prompt.
    await tester.tap(find.text('App Lock'));
    await tester.pumpAndSettle();
    expect(_appLockSwitch(tester).value, isFalse);
    expect(find.text('Lock After'), findsNothing);
    expect(prefs.getBool(AppLockSettingsController.enabledKey), isFalse);
    expect(recents.calls, [true, false]);
    expect(auth.prompts, hasLength(3));
  });

  testWidgets('Settings: without a screen lock, App Lock explains and stays off', (tester) async {
    var opened = 0;
    final (:auth, :recents) = await _pump(
      tester,
      auth: FakeAuthenticator(available: false),
      openScreenLockSettings: () async => opened++,
    );
    await _openSecuritySettings(tester);
    await tester.tap(find.text('App Lock'));
    await tester.pumpAndSettle();
    expect(find.text('Set Up a Screen Lock'), findsOneWidget);
    expect(textContaining('Set up a PIN, pattern or password in Android’s settings'), findsOneWidget);
    expect(auth.prompts, isEmpty);
    expect(_appLockSwitch(tester).value, isFalse);

    await tester.tap(find.text('Open Settings'));
    await tester.pumpAndSettle();
    expect(opened, 1);
    expect(find.text('Set Up a Screen Lock'), findsNothing);
    expect(_appLockSwitch(tester).value, isFalse);
    expect((await SharedPreferences.getInstance()).getBool(AppLockSettingsController.enabledKey), isNull);
    expect(recents.calls, isEmpty);
  });
}
