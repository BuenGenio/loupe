/// Push in Loupe's NonFree release type (docs/releasing.md): a content-free
/// "check now" through Firebase Cloud Messaging (docs/push.md).
///
/// A push carries no mail, only the wake-up; Loupe then syncs straight from
/// the mail server, as the 15-minute background sync does. The push relay
/// (#18) is what will send them. Free builds use `packages/push` instead,
/// which has the same API and no push.
library;

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// A push service: a content-free "check now" that wakes Loupe.
///
/// Keep in step with `packages/push/lib/loupe_push.dart`, which the app is
/// written against.
abstract interface class PushService {
  /// Push on: Firebase gets a token, and keeps it fresh. Off: the token is
  /// deleted, so nothing can reach this phone any more.
  Future<void> setEnabled(bool enabled);

  /// The address pushes are sent to. Throws when the phone can't receive
  /// pushes (no Google Play services, or no network to get one).
  Future<String?> token();

  /// Pushes that arrive while the app is in the foreground. In the
  /// background, `onBackgroundPush` (see [startPush]) gets them.
  Stream<void> get foregroundPushes;
}

/// Starts Firebase and takes pushes from now on; call once in the main
/// isolate. Null on iOS, until it has an APNs key.
///
/// Firebase's settings come from this package's Android module
/// (android/src/main/res/values/firebase.xml). [onBackgroundPush] runs for a
/// push that arrives while the app is in the background or not running, in
/// an isolate Firebase starts for it, so it must be a top-level or static
/// function marked `@pragma('vm:entry-point')`. It is handed to Firebase
/// as it is (Firebase finds it again by its callback handle), never wrapped.
Future<PushService?> startPush({required Future<void> Function(Object message) onBackgroundPush}) async {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return null;
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(onBackgroundPush);
  return _FirebasePushService(FirebaseMessaging.instance);
}

final class _FirebasePushService implements PushService {
  _FirebasePushService(this._messaging);

  final FirebaseMessaging _messaging;

  /// Getting a token can hang without a network; Settings shows the push
  /// as unavailable instead of waiting.
  static const _timeout = Duration(seconds: 30);

  /// Firebase's auto-init flag doubles as "there may be a token": it starts
  /// off (android/src/main/AndroidManifest.xml), so a phone that never had
  /// push on, like one trying the demo, doesn't contact Google at all.
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
