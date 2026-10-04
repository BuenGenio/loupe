import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import 'background.dart';

/// The Dart task name every Loupe background job runs (a sync).
const backgroundSyncTask = 'loupe.sync';

/// iOS: the BGAppRefreshTask that runs the background sync. The same string
/// is in Info.plist (`BGTaskSchedulerPermittedIdentifiers`) and in
/// AppDelegate.swift; iOS hands it to the job as its task name.
const iosRefreshTask = 'io.github.buengenio.loupe.sync';

/// Whether [task], as the job dispatcher gets it, is the background sync.
bool isBackgroundSyncTask(String task) => task == backgroundSyncTask || task == iosRefreshTask;

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

/// Both sides of the platform's scheduler.
abstract interface class SyncScheduler implements BackgroundScheduler, PeriodicSync {}

/// The scheduler of the platform this runs on, both through the workmanager
/// plugin: WorkManager jobs on Android, a BGAppRefreshTask on iOS. Null
/// where Loupe has no background work.
SyncScheduler? platformSyncScheduler() {
  if (kIsWeb) return null;
  return switch (defaultTargetPlatform) {
    TargetPlatform.android => WorkmanagerBackgroundScheduler(WorkmanagerWorkScheduler()),
    TargetPlatform.iOS => AppRefreshScheduler(AppRefreshWorkScheduler()),
    _ => null,
  };
}

/// The Android [BackgroundScheduler]: WorkManager jobs that need a network.
///
/// - The periodic sync runs every 15 minutes while the app is in live mode.
/// - [scheduleWakeUp] adds a one-off job at that time (e.g. a scheduled
///   send); wake-ups for the same minute share one job.
final class WorkmanagerBackgroundScheduler implements SyncScheduler {
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

/// The iOS [BackgroundScheduler]: one BGAppRefreshTask ([iosRefreshTask]).
/// iOS runs it when it sees fit, never sooner than [period] after the last
/// run, and gives it about 30 seconds. There is no lasting connection (IDLE)
/// on iOS.
///
/// iOS has no wake-ups at a set time (a one-off job would only run while
/// the app does), so [scheduleWakeUp] does nothing: a send or a snooze that
/// falls due waits for the next refresh, or for the app to open.
final class AppRefreshScheduler implements SyncScheduler {
  AppRefreshScheduler(this._work);

  final WorkScheduler _work;

  /// Also the earliest start AppDelegate.swift asks for after each run.
  static const period = Duration(minutes: 15);

  @override
  Future<void> setEnabled(bool enabled) =>
      enabled ? _work.schedulePeriodic(iosRefreshTask, frequency: period) : _work.cancelAll();

  @override
  Future<void> scheduleWakeUp(DateTime time) async {}
}

/// [WorkScheduler] over the workmanager plugin on iOS (BGTaskScheduler).
/// Only periodic refreshes, named by an identifier Info.plist permits.
final class AppRefreshWorkScheduler implements WorkScheduler {
  AppRefreshWorkScheduler([Workmanager? workmanager]) : _workmanager = workmanager ?? Workmanager();

  final Workmanager _workmanager;

  /// iOS knows the job only by its identifier, so [uniqueName] is its task
  /// name too. The first run is no sooner than [frequency] from now; later
  /// ones are scheduled natively (AppDelegate.swift). Registering again
  /// replaces the pending request.
  @override
  Future<void> schedulePeriodic(String uniqueName, {required Duration frequency}) =>
      _workmanager.registerPeriodicTask(uniqueName, uniqueName, frequency: frequency, initialDelay: frequency);

  /// Not on iOS: workmanager would run it in the app's process, and only
  /// while the app runs.
  @override
  Future<void> scheduleOnce(String uniqueName, {required Duration delay}) async {}

  /// Tags are Android only; Loupe has no other jobs on iOS.
  @override
  Future<void> cancelAll() => _workmanager.cancelAll();
}

/// [WorkScheduler] over the workmanager plugin (Android WorkManager).
final class WorkmanagerWorkScheduler implements WorkScheduler {
  WorkmanagerWorkScheduler([Workmanager? workmanager]) : _workmanager = workmanager ?? Workmanager();

  final Workmanager _workmanager;

  static const _tag = 'loupe';

  /// Registers [dispatcher], the top-level function background jobs start
  /// in (on Android and iOS). Call once at startup.
  Future<void> initialize(Function dispatcher) => _workmanager.initialize(dispatcher);

  Constraints get _constraints => Constraints(networkType: NetworkType.connected);

  @override
  Future<void> schedulePeriodic(String uniqueName, {required Duration frequency}) => _workmanager.registerPeriodicTask(
    uniqueName,
    backgroundSyncTask,
    frequency: frequency,
    constraints: _constraints,
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    tag: _tag,
  );

  @override
  Future<void> scheduleOnce(String uniqueName, {required Duration delay}) => _workmanager.registerOneOffTask(
    uniqueName,
    backgroundSyncTask,
    initialDelay: delay,
    constraints: _constraints,
    existingWorkPolicy: ExistingWorkPolicy.keep,
    tag: _tag,
  );

  @override
  Future<void> cancelAll() => _workmanager.cancelByTag(_tag);
}
