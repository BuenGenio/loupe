import 'dart:async';
import 'dart:ui';

import 'package:clock/clock.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'work_scheduler.dart';

/// Push (Android): a content-free "check now" through Firebase Cloud
/// Messaging (docs/push.md). A push carries no mail, only the wake-up; Loupe
/// then syncs straight from the mail server, as the 15-minute background
/// sync does. The push relay (#18) is what will send them.
abstract interface class PushService {
  /// Push on: Firebase gets a token, and keeps it fresh. Off: the token is
  /// deleted, so nothing can reach this phone any more.
  Future<void> setEnabled(bool enabled);

  /// The address pushes are sent to. Throws when the phone can't receive
  /// pushes (no Google Play services, or no network to get one).
  Future<String?> token();

  /// Pushes that arrive while the app is in the foreground. (In the
  /// background, [onBackgroundPush] gets them.)
  Stream<void> get foregroundPushes;
}

/// No push (tests, iOS until it has an APNs key, platforms without Firebase).
final class NoopPushService implements PushService {
  const NoopPushService();

  @override
  Future<void> setEnabled(bool enabled) async {}

  @override
  Future<String?> token() async => null;

  @override
  Stream<void> get foregroundPushes => const Stream.empty();
}

final pushServiceProvider = Provider<PushService>((ref) => const NoopPushService());

/// Whether this build receives pushes: Android, once Firebase started.
/// Settings shows Push only then.
final pushAvailableProvider = Provider<bool>((ref) => false);

/// [PushService] through Firebase Cloud Messaging.
final class FirebasePushService implements PushService {
  FirebasePushService._(this._messaging);

  /// Starts Firebase (its settings come from android/app/google-services.json)
  /// and takes pushes from now on; call once in the main isolate.
  static Future<FirebasePushService> initialize() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(onBackgroundPush);
    return FirebasePushService._(FirebaseMessaging.instance);
  }

  final FirebaseMessaging _messaging;

  /// Getting a token can hang without a network; Settings shows the push
  /// as unavailable instead of waiting.
  static const _timeout = Duration(seconds: 30);

  /// Firebase's auto-init flag doubles as "there may be a token": it starts
  /// off (AndroidManifest.xml), so a phone that never had push on, like one
  /// trying the demo, doesn't contact Google at all.
  @override
  Future<void> setEnabled(bool enabled) async {
    final had = _messaging.isAutoInitEnabled;
    await _messaging.setAutoInitEnabled(enabled);
    if (enabled) {
      await _messaging.getToken().timeout(_timeout);
    } else if (had) {
      await _messaging.deleteToken().timeout(_timeout);
    }
  }

  @override
  Future<String?> token() => _messaging.getToken().timeout(_timeout);

  @override
  Stream<void> get foregroundPushes => FirebaseMessaging.onMessage;
}

/// A push while the app is in the background or not running, in the
/// isolate Firebase starts for it: a background sync right away. The
/// WorkManager job, not this handler, does it: Android gives the handler
/// only seconds, and the job knows how to share the database with the app
/// and Instant Delivery.
@pragma('vm:entry-point')
Future<void> onBackgroundPush(RemoteMessage message) async {
  DartPluginRegistrant.ensureInitialized();
  try {
    await platformSyncScheduler()?.scheduleWakeUp(clock.now());
  } on Object catch (e) {
    // The next periodic sync finds the mail anyway.
    debugPrint('Push: no wake-up: $e');
  }
}
