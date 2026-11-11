/// Push in Loupe's Free release type (docs/releasing.md): there is none.
///
/// Free builds hold no code that talks to Google: new mail comes with the
/// 15-minute background sync and, when the user turns it on, Instant
/// Delivery. The NonFree release type replaces this package with
/// `nonfree/push`, which has the same API and pushes through Firebase Cloud
/// Messaging (docs/push.md).
library;

/// A push service: a content-free "check now" that wakes Loupe.
///
/// Keep in step with `nonfree/push/lib/loupe_push.dart`; the NonFree build
/// compiles the app against that copy.
abstract interface class PushService {
  /// Push on: get an address (a token) and keep it fresh. Off: delete it, so
  /// nothing can reach this phone any more.
  Future<void> setEnabled(bool enabled);

  /// The address pushes are sent to. Throws when the phone can't receive
  /// pushes.
  Future<String?> token();

  /// Pushes that arrive while the app is in the foreground. In the
  /// background, `onBackgroundPush` (see [startPush]) gets them.
  Stream<void> get foregroundPushes;
}

/// Starts this build's push service, or returns null when the build has
/// none. Free builds never have one.
///
/// [onBackgroundPush] runs for a push that arrives while the app is in the
/// background or not running, in an isolate of its own, so it must be a
/// top-level or static function marked `@pragma('vm:entry-point')`.
Future<PushService?> startPush({required Future<void> Function(Object message) onBackgroundPush}) async => null;
