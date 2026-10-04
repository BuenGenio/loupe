import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import 'background.dart';

/// The Dart task name every Loupe background job runs (a sync).
const backgroundSyncTask = 'loupe.sync';

/// The OS job scheduler, reduced to what Loupe needs: jobs that need a
/// network and run the background sync. Tests use a fake.
abstract interface class WorkScheduler {
  /// Runs every [frequency] (at least 15 minutes on Android); registering
  /// again keeps the existing schedule.
  Future<void> schedulePeriodic(String uniqueName, {required Duration frequency});

  /// Runs once after [delay]; registering a pending name again keeps it.
  Future<void> scheduleOnce(String uniqueName, {required Duration delay});

  /// Cancels every Loupe job.
  Future<void> cancelAll();
}

/// Turns the 15-minute background sync on and off (live mode only).
abstract interface class PeriodicSync {
  Future<void> setEnabled(bool enabled);
}

final class NoopPeriodicSync implements PeriodicSync {
  const NoopPeriodicSync();

  @override
  Future<void> setEnabled(bool enabled) async {}
}

final periodicSyncProvider = Provider<PeriodicSync>((ref) => const NoopPeriodicSync());

/// The Android [BackgroundScheduler]: WorkManager jobs that need a network.
///
/// - The periodic sync runs every 15 minutes while the app is in live mode.
/// - [scheduleWakeUp] adds a one-off job at that time (e.g. a scheduled
///   send); wake-ups for the same minute share one job.
final class WorkmanagerBackgroundScheduler implements BackgroundScheduler, PeriodicSync {
  WorkmanagerBackgroundScheduler(this._work, {DateTime Function()? clock}) : _clock = clock ?? DateTime.now;

  final WorkScheduler _work;
  final DateTime Function() _clock;

  static const periodicName = 'loupe.sync.periodic';
  static const period = Duration(minutes: 15);

  @override
  Future<void> setEnabled(bool enabled) =>
      enabled ? _work.schedulePeriodic(periodicName, frequency: period) : _work.cancelAll();

  @override
  Future<void> scheduleWakeUp(DateTime time) {
    final minute = time.millisecondsSinceEpoch ~/ Duration.millisecondsPerMinute;
    final delay = time.difference(_clock());
    return _work.scheduleOnce('loupe.sync.at.$minute', delay: delay.isNegative ? Duration.zero : delay);
  }
}

/// [WorkScheduler] over the workmanager plugin (Android WorkManager).
final class WorkmanagerWorkScheduler implements WorkScheduler {
  WorkmanagerWorkScheduler([Workmanager? workmanager]) : _workmanager = workmanager ?? Workmanager();

  final Workmanager _workmanager;

  static const _tag = 'loupe';

  /// Registers [dispatcher], the top-level function background jobs start
  /// in. Call once at startup.
  Future<void> initialize(Function dispatcher) => _workmanager.initialize(dispatcher);

  Constraints get _constraints => Constraints(networkType: NetworkType.connected);

  @override
  Future<void> schedulePeriodic(String uniqueName, {required Duration frequency}) => _workmanager.registerPeriodicTask(
    uniqueName,
    backgroundSyncTask,
    frequency: frequency,
    constraints: _constraints,
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    backoffPolicy: BackoffPolicy.exponential,
    tag: _tag,
  );

  @override
  Future<void> scheduleOnce(String uniqueName, {required Duration delay}) => _workmanager.registerOneOffTask(
    uniqueName,
    backgroundSyncTask,
    initialDelay: delay,
    constraints: _constraints,
    existingWorkPolicy: ExistingWorkPolicy.keep,
    backoffPolicy: BackoffPolicy.exponential,
    tag: _tag,
  );

  @override
  Future<void> cancelAll() => _workmanager.cancelByTag(_tag);
}
