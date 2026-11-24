import 'dart:async';
import 'dart:ui';

import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loupe_push/loupe_push.dart';

import 'work_scheduler.dart';

export 'package:loupe_push/loupe_push.dart' show PushService, startPush;

// Push (Android): a content-free "check now" that wakes Loupe (docs/push.md).
// A push carries no mail, only the wake-up; Loupe then syncs straight from
// the mail server, as the 15-minute background sync does. Only NonFree builds
// have it (Firebase Cloud Messaging, nonfree/push); in Free builds,
// package:loupe_push has no push at all (docs/releasing.md).

/// No push (Free builds, tests, iOS until it has an APNs key).
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

/// Whether this build receives pushes: a NonFree build on Android, once
/// Firebase started. Settings shows Push only then.
final pushAvailableProvider = Provider<bool>((ref) => false);

/// A push while the app is in the background or not running, in the
/// isolate the push service starts for it: a background sync right away. The
/// WorkManager job, not this handler, does it: Android gives the handler
/// only seconds, and the job knows how to share the database with the app
/// and Instant Delivery. [message] is the push service's own (Firebase's
/// RemoteMessage); its contents are never read.
@pragma('vm:entry-point')
Future<void> onBackgroundPush(Object message) async {
  DartPluginRegistrant.ensureInitialized();
  try {
    await platformSyncScheduler()?.scheduleWakeUp(clock.now());
  } on Object catch (e) {
    // The next periodic sync finds the mail anyway.
    debugPrint('Push: no wake-up: $e');
  }
}
