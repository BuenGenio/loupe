import 'dart:async';
import 'dart:io';

/// Who syncs the mail database: the app in the foreground, or background
/// work (the periodic WorkManager sync, a notification action).
enum SyncHolder { foreground, background }

/// Keeps two syncers off the database at once, across isolates and
/// processes, with lease files.
///
/// Whoever syncs keeps its lease file fresh (a timestamp, renewed every
/// [renewEvery]). A lease older than [ttl] counts as released, so a process
/// that died never blocks the other side for long. The foreground always
/// wins: background work starts only while the app holds no lease, checks
/// it again while it runs and gives way when the app comes back.
final class SyncLeases {
  SyncLeases(this.directory, {DateTime Function()? clock, this.ttl = const Duration(seconds: 45)})
    : _clock = clock ?? DateTime.now;

  final Directory directory;
  final Duration ttl;
  final DateTime Function() _clock;

  /// How often a holder renews its lease; well inside [ttl].
  static const renewEvery = Duration(seconds: 10);

  File _file(SyncHolder holder) => File('${directory.path}/sync-${holder.name}.lease');

  /// Whether [holder] holds a fresh lease.
  Future<bool> isHeld(SyncHolder holder) async {
    final String text;
    try {
      text = await _file(holder).readAsString();
    } on FileSystemException {
      return false;
    }
    final at = int.tryParse(text.trim());
    if (at == null) return false;
    final age = _clock().difference(DateTime.fromMillisecondsSinceEpoch(at));
    // A lease from the future means the clock went back; don't trust it long.
    return age.abs() < ttl;
  }

  /// Takes or renews [holder]'s lease.
  Future<void> renew(SyncHolder holder) async {
    await directory.create(recursive: true);
    final file = _file(holder);
    // Write, then rename: a reader never sees half a timestamp.
    final temp = File('${file.path}.${pid}_${identityHashCode(this)}.tmp');
    await temp.writeAsString('${_clock().millisecondsSinceEpoch}', flush: true);
    await temp.rename(file.path);
  }

  /// Gives up [holder]'s lease.
  Future<void> release(SyncHolder holder) async {
    try {
      await _file(holder).delete();
    } on FileSystemException {
      // Already gone.
    }
  }

  /// For background work: takes the background lease unless the app holds
  /// the foreground one. Checks again after taking it, so the app and a
  /// background task that start at the same moment never both go ahead.
  Future<bool> tryAcquireBackground() async {
    if (await isHeld(SyncHolder.foreground)) return false;
    await renew(SyncHolder.background);
    if (await isHeld(SyncHolder.foreground)) {
      await release(SyncHolder.background);
      return false;
    }
    return true;
  }

  /// For background work that must run (a notification action): waits up to
  /// [maxWait] for another background holder, then takes the lease anyway.
  Future<void> acquireBackgroundWaiting({
    Duration maxWait = const Duration(seconds: 45),
    Duration poll = const Duration(milliseconds: 500),
  }) async {
    final deadline = _clock().add(maxWait);
    while (await isHeld(SyncHolder.background) && _clock().isBefore(deadline)) {
      await Future<void>.delayed(poll);
    }
    await renew(SyncHolder.background);
  }

  /// For the app coming to the foreground: takes the foreground lease (the
  /// app always wins), then waits up to [maxWait] for running background
  /// work to notice and stop. Returns false if it was still running.
  Future<bool> acquireForeground({
    Duration maxWait = const Duration(seconds: 20),
    Duration poll = const Duration(milliseconds: 300),
    bool Function()? cancelled,
  }) async {
    await renew(SyncHolder.foreground);
    final deadline = _clock().add(maxWait);
    while (await isHeld(SyncHolder.background)) {
      if (!_clock().isBefore(deadline) || (cancelled?.call() ?? false)) return false;
      await Future<void>.delayed(poll);
    }
    return true;
  }
}
