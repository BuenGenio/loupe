import 'dart:async';
import 'dart:io';
import 'dart:math';

/// Who syncs the mail database: the app in the foreground, or background
/// work (the periodic WorkManager sync, a notification action, Instant
/// Delivery).
enum SyncHolder { foreground, background }

/// Keeps two syncers off the database at once, across isolates and
/// processes, with lease files.
///
/// Whoever syncs keeps its lease file fresh (a timestamp and who wrote it,
/// renewed every [renewEvery]). A lease older than [ttl] counts as released,
/// so a process that died never blocks the others for long. The foreground
/// always wins: background work starts only while the app holds no lease
/// and nobody else holds the background one, checks again while it runs
/// and gives way when the app comes back.
///
/// Each instance is one owner; use one per syncer.
final class SyncLeases {
  SyncLeases(this.directory, {DateTime Function()? clock, this.ttl = const Duration(seconds: 45), String? owner})
    : _clock = clock ?? DateTime.now,
      owner = owner ?? '$pid-${Random().nextInt(1 << 32)}';

  final Directory directory;
  final Duration ttl;
  final DateTime Function() _clock;

  /// Who this instance writes leases as.
  final String owner;

  /// How often a holder renews its lease; well inside [ttl].
  static const renewEvery = Duration(seconds: 10);

  File _file(SyncHolder holder) => File('${directory.path}/sync-${holder.name}.lease');

  /// The fresh lease of [holder]: its owner, or null if none.
  Future<String?> _fresh(SyncHolder holder) async {
    final String text;
    try {
      text = await _file(holder).readAsString();
    } on FileSystemException {
      return null;
    }
    final lines = text.trim().split('\n');
    final ms = int.tryParse(lines.first.trim());
    if (ms == null) return null;
    final age = _clock().difference(DateTime.fromMillisecondsSinceEpoch(ms));
    // A lease from the future means the clock went back; don't trust it long.
    if (age.abs() >= ttl) return null;
    return lines.length > 1 ? lines[1].trim() : '';
  }

  /// Whether anyone holds a fresh [holder] lease.
  Future<bool> isHeld(SyncHolder holder) async => await _fresh(holder) != null;

  /// Whether someone other than this instance holds a fresh [holder] lease.
  Future<bool> isHeldByOther(SyncHolder holder) async {
    final current = await _fresh(holder);
    return current != null && current != owner;
  }

  /// Takes or renews [holder]'s lease.
  Future<void> renew(SyncHolder holder) async {
    await directory.create(recursive: true);
    final file = _file(holder);
    // Write, then rename: a reader never sees half a lease.
    final temp = File('${file.path}.$owner.tmp');
    await temp.writeAsString('${_clock().millisecondsSinceEpoch}\n$owner', flush: true);
    await temp.rename(file.path);
  }

  /// Gives up [holder]'s lease, unless someone else has taken it since.
  Future<void> release(SyncHolder holder) async {
    if (await isHeldByOther(holder)) return;
    try {
      await _file(holder).delete();
    } on FileSystemException {
      // Already gone.
    }
  }

  /// For background work: takes the background lease unless the app holds
  /// the foreground one or other background work the background one. Checks
  /// again after taking it, so two that start at the same moment never both
  /// go ahead.
  Future<bool> tryAcquireBackground() async {
    if (await isHeld(SyncHolder.foreground) || await isHeldByOther(SyncHolder.background)) return false;
    await renew(SyncHolder.background);
    if (await isHeld(SyncHolder.foreground) || await isHeldByOther(SyncHolder.background)) {
      await release(SyncHolder.background);
      return false;
    }
    return true;
  }

  /// For background work that must run (a notification action): waits up to
  /// [maxWait] for other background work, then takes the lease anyway.
  Future<void> acquireBackgroundWaiting({
    Duration maxWait = const Duration(seconds: 45),
    Duration poll = const Duration(milliseconds: 500),
  }) async {
    final deadline = _clock().add(maxWait);
    while (await isHeldByOther(SyncHolder.background) && _clock().isBefore(deadline)) {
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
    while (await isHeldByOther(SyncHolder.background)) {
      if (!_clock().isBefore(deadline) || (cancelled?.call() ?? false)) return false;
      await Future<void>.delayed(poll);
    }
    return true;
  }
}
