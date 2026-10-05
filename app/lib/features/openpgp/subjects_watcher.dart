import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import 'decrypted_mail.dart';
import 'openpgp_providers.dart';

/// While Decrypt Subjects in the Background is on and the app runs,
/// decrypts the protected subjects of encrypted mail as it arrives in the
/// inboxes (the newest [limit] messages), with keys stored without a
/// passphrase, off the UI isolate. Background work does the same before it
/// notifies (`NewMailCheck.subjects`).
class ProtectedSubjectsWatcher extends ConsumerStatefulWidget {
  const ProtectedSubjectsWatcher({super.key, required this.repository, required this.child, this.limit = 100});

  final MailRepository repository;
  final Widget child;
  final int limit;

  @override
  ConsumerState<ProtectedSubjectsWatcher> createState() => _ProtectedSubjectsWatcherState();
}

class _ProtectedSubjectsWatcherState extends ConsumerState<ProtectedSubjectsWatcher> {
  StreamSubscription<List<ThreadSummary>>? _rows;

  /// Tried once per run of the app, decrypted or not.
  final _tried = <String>{};
  final _queue = <EmailSummary>[];
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    ref.listenManual(
      decryptedMailSettingsProvider.select((s) => s.subjectsInBackground),
      (_, on) => _apply(on),
      fireImmediately: true,
    );
  }

  void _apply(bool on) {
    unawaited(_rows?.cancel());
    _rows = null;
    if (!on || widget.repository is! DecryptedMail) return;
    _rows = widget.repository
        .watchList(const VirtualMailboxRef(VirtualMailbox.allInboxes), threaded: false, limit: widget.limit)
        .listen(_look, onError: (Object _) {});
  }

  void _look(List<ThreadSummary> rows) {
    for (final t in rows) {
      final e = t.latest;
      if (e.isEncrypted && !e.hasDecryptedSubject && _tried.add(e.id)) _queue.add(e);
    }
    if (_queue.isNotEmpty) unawaited(_drain());
  }

  Future<void> _drain() async {
    if (_busy) return;
    _busy = true;
    try {
      while (_queue.isNotEmpty && mounted && _rows != null) {
        final batch = [..._queue];
        _queue.clear();
        final decryptor = await _decryptor();
        if (decryptor == null || !mounted) return;
        await decryptor.decrypt(widget.repository, batch);
      }
    } on Object {
      // The keyring isn't there (yet): the next arrival tries again.
    } finally {
      _busy = false;
    }
  }

  /// Keys stored without a passphrase are unlocked from the start (and
  /// pinned); protected ones are never used here, even when unlocked.
  Future<SubjectDecryptor?> _decryptor() async {
    final service = await ref.read(openPgpServiceProvider.future);
    await service.ready;
    final keys = [
      for (final k in service.state.ownKeys)
        if (!k.isProtected) ?service.unlockedKey(k.fingerprint),
    ];
    final run = ref.read(pgpRunnerProvider);
    return keys.isEmpty ? null : SubjectDecryptor(keys: keys, run: (work) => run(work));
  }

  @override
  void dispose() {
    unawaited(_rows?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
