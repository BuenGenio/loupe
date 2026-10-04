import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Wakes the app in the background to sync and to send what is due.
///
/// The no-op default keeps everything working in the foreground; the
/// Android implementation (WorkManager) overrides [backgroundSchedulerProvider].
abstract interface class BackgroundScheduler {
  /// Makes sure a background sync runs at, or soon after, [time]
  /// (e.g. a scheduled send or a snooze ending). Later calls may add more times.
  Future<void> scheduleWakeUp(DateTime time);
}

class NoopBackgroundScheduler implements BackgroundScheduler {
  const NoopBackgroundScheduler();

  @override
  Future<void> scheduleWakeUp(DateTime time) async {}
}

final backgroundSchedulerProvider = Provider<BackgroundScheduler>((ref) => const NoopBackgroundScheduler());
