import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/platform/work_scheduler.dart';

/// Records what would be handed to WorkManager.
class FakeWork implements WorkScheduler {
  final periodic = <String, Duration>{};
  final once = <String, Duration>{};
  int cancels = 0;

  @override
  Future<void> schedulePeriodic(String uniqueName, {required Duration frequency}) async =>
      periodic.putIfAbsent(uniqueName, () => frequency);

  @override
  Future<void> scheduleOnce(String uniqueName, {required Duration delay}) async =>
      once.putIfAbsent(uniqueName, () => delay);

  @override
  Future<void> cancelAll() async {
    cancels++;
    periodic.clear();
    once.clear();
  }
}

void main() {
  final now = DateTime(2026, 10, 4, 9, 0, 30);
  late FakeWork work;
  late WorkmanagerBackgroundScheduler scheduler;

  setUp(() {
    work = FakeWork();
    scheduler = WorkmanagerBackgroundScheduler(work, clock: () => now);
  });

  test('the periodic sync runs every 15 minutes while enabled', () async {
    await scheduler.setEnabled(true);
    await scheduler.setEnabled(true);
    expect(work.periodic, {WorkmanagerBackgroundScheduler.periodicName: const Duration(minutes: 15)});
    await scheduler.setEnabled(false);
    expect(work.periodic, isEmpty);
    expect(work.cancels, 1);
  });

  test('a wake-up is a one-off job at that time', () async {
    await scheduler.scheduleWakeUp(DateTime(2026, 10, 4, 10));
    expect(work.once.values.single, const Duration(minutes: 59, seconds: 30));
  });

  test('wake-ups add up; the same minute shares one job', () async {
    await scheduler.scheduleWakeUp(DateTime(2026, 10, 4, 10));
    await scheduler.scheduleWakeUp(DateTime(2026, 10, 4, 10, 0, 40));
    await scheduler.scheduleWakeUp(DateTime(2026, 10, 4, 11));
    expect(work.once, hasLength(2));
  });

  test('a wake-up in the past runs as soon as possible', () async {
    await scheduler.scheduleWakeUp(DateTime(2026, 10, 4, 8));
    expect(work.once.values.single, Duration.zero);
  });

  test('every job is the background sync', () {
    expect(backgroundSyncTask, 'loupe.sync');
  });
}
