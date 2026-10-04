import 'dart:async';

import 'sync_leases.dart';

/// Lets the live repository sync only while the app is in the foreground,
/// and never while background work syncs the same database.
///
/// [enterForeground] takes the foreground lease, waits briefly for a
/// running background sync to give way, then resumes syncing and keeps the
/// lease fresh. [enterBackground] pauses syncing, runs [onBackground] (the
/// new-mail check marks what the user saw as seen) and releases the lease,
/// so the periodic background sync may run.
///
/// Transitions run one after the other; one that a later call overtook is
/// skipped.
final class ForegroundSync {
  ForegroundSync({
    required this.leases,
    required this.pause,
    required this.resume,
    this.onBackground,
    this.onClaimed,
    this.maxWait = const Duration(seconds: 20),
  });

  final Future<SyncLeases> leases;
  final Future<void> Function() pause;
  final Future<void> Function() resume;
  final Future<void> Function()? onBackground;

  /// Right after the app claimed the database, before it waits for
  /// background work to give way (to hurry that along).
  final void Function()? onClaimed;

  /// How long the app waits for a background sync before syncing anyway.
  final Duration maxWait;

  Timer? _renew;
  int _generation = 0;
  bool _inForeground = false;
  Future<void> _queue = Future.value();

  bool get inForeground => _inForeground;

  Future<void> enterForeground() {
    final generation = ++_generation;
    _inForeground = true;
    return _serial(() async {
      if (generation != _generation) return;
      final leases = await this.leases;
      _renew?.cancel();
      _renew = Timer.periodic(SyncLeases.renewEvery, (_) => unawaited(_renewQuietly(leases)));
      await leases.renew(SyncHolder.foreground);
      onClaimed?.call();
      await leases.acquireForeground(maxWait: maxWait, cancelled: () => generation != _generation);
      if (generation != _generation) return;
      await resume();
    });
  }

  Future<void> enterBackground() {
    final generation = ++_generation;
    _inForeground = false;
    _renew?.cancel();
    _renew = null;
    return _serial(() async {
      if (generation != _generation) return;
      await pause();
      try {
        await onBackground?.call();
      } finally {
        // Back in the foreground meanwhile: keep the lease.
        if (generation == _generation) await (await leases).release(SyncHolder.foreground);
      }
    });
  }

  /// Stops renewing and releases the lease without touching the repository
  /// (the app left live mode).
  Future<void> dispose() async {
    _generation++;
    _inForeground = false;
    _renew?.cancel();
    _renew = null;
    await (await leases).release(SyncHolder.foreground);
  }

  Future<void> _serial(Future<void> Function() step) {
    final next = _queue.then((_) => step());
    _queue = next.catchError((Object _) {});
    return next;
  }

  static Future<void> _renewQuietly(SyncLeases leases) async {
    try {
      await leases.renew(SyncHolder.foreground);
    } on Exception {
      // Next time.
    }
  }
}
