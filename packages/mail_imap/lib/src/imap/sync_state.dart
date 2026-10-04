/// The IMAP transport's per-mailbox sync state (stored opaquely by the store).
library;

import 'package:mail_model/mail_model.dart';

import '../util/uid_set.dart';

/// What the transport knows about a mailbox after a sync.
final class ImapSyncState {
  ImapSyncState({
    required this.uidValidity,
    required this.uidNext,
    required this.oldestUid,
    required this.exists,
    required List<int> uids,
    this.highestModSeq,
  }) : uids = List.unmodifiable(uids.toSet().toList()..sort());

  final int uidValidity;

  /// UIDNEXT at the last sync: everything below has been seen.
  final int uidNext;

  /// HIGHESTMODSEQ at the last sync (CONDSTORE); null without it.
  final int? highestModSeq;

  /// The lowest UID in the synced window; older messages are fetched on demand.
  final int oldestUid;

  /// EXISTS at the last sync (detects expunges cheaply).
  final int exists;

  /// UIDs reported to the store (the window), ascending.
  final List<int> uids;

  static const _version = 1;

  /// Reads a stored state; null if missing or from an incompatible version.
  static ImapSyncState? fromState(MailboxSyncState? state) {
    final d = state?.data;
    if (d == null || d['v'] != _version) return null;
    try {
      return ImapSyncState(
        uidValidity: d['uidValidity']! as int,
        uidNext: d['uidNext']! as int,
        highestModSeq: d['highestModSeq'] as int?,
        oldestUid: d['oldestUid']! as int,
        exists: d['exists']! as int,
        uids: parseSequenceSet(d['uids']! as String),
      );
    } on Object {
      return null;
    }
  }

  MailboxSyncState toState() => MailboxSyncState({
    'v': _version,
    'uidValidity': uidValidity,
    'uidNext': uidNext,
    'highestModSeq': highestModSeq,
    'oldestUid': oldestUid,
    'exists': exists,
    'uids': formatSequenceSet(uids),
  });

  /// Whether messages older than the window exist on the server.
  bool olderExist(int serverExists) => serverExists > uids.length && oldestUid > 1;

  /// Whether, besides [newCount] arrivals, the server count shows removals of
  /// messages that existed at the last sync.
  bool hasRemovals({required int serverExists, required int newCount}) => exists + newCount != serverExists;
}

/// UIDs in [known] that are missing from [current] (expunged).
List<int> vanishedUids(Iterable<int> known, Iterable<int> current) {
  final now = current.toSet();
  return [
    for (final uid in known)
      if (!now.contains(uid)) uid,
  ];
}
