import 'package:mail_model/mail_model.dart';

/// Thrown when the database can't be opened (wrong key, corrupt file, or a
/// SQLite build without encryption).
final class MailStoreException implements Exception {
  const MailStoreException(this.message, [this.cause]);
  final String message;
  final Object? cause;
  @override
  String toString() => 'MailStoreException: $message';
}

/// A message waiting in the outbox. Its status is mail_model's
/// [OutboxStatus], stored by name.
final class OutboxEntry {
  const OutboxEntry({
    required this.id,
    required this.accountId,
    required this.message,
    required this.sendAfter,
    required this.createdAt,
    this.status = OutboxStatus.queued,
    this.attempts = 0,
    this.lastError,
    this.held = false,
  });

  final String id;
  final String accountId;
  final OutgoingMessage message;

  /// Not sent before this time (undo window, scheduled time, retry backoff).
  final DateTime sendAfter;
  final DateTime createdAt;
  final OutboxStatus status;
  final int attempts;

  /// Human-readable reason of the last failure.
  final String? lastError;

  /// A [OutboxStatus.failed] entry the server refused for good (a
  /// `PermanentMailException`): it is never claimed for sending again until
  /// rescheduled (`MailStore.rescheduleOutbox`, the user's Retry).
  final bool held;
}

/// One queued server operation.
final class PendingOp {
  const PendingOp({
    required this.id,
    required this.accountId,
    required this.type,
    required this.payload,
    required this.nextAttemptAt,
    required this.createdAt,
    this.attempts = 0,
    this.lastError,
  });

  final int id;
  final String accountId;
  final String type;
  final Map<String, Object?> payload;
  final int attempts;
  final DateTime nextAttemptAt;
  final DateTime createdAt;
  final String? lastError;
}

/// Persisted sync position of a mailbox.
final class MailboxSyncInfo {
  const MailboxSyncInfo({
    required this.state,
    required this.hasOlder,
    required this.syncedAt,
    this.staleHeaders = false,
  });
  final MailboxSyncState state;
  final bool hasOlder;
  final DateTime syncedAt;

  /// The stored summaries predate header fields added to the store since
  /// (the List-* headers): fetch them again batch by batch
  /// (`MailStore.nextStaleHeaders`, `MailStore.fillHeaders`), then call
  /// `MailStore.markHeadersFresh`.
  final bool staleHeaders;
}

/// The next messages of a mailbox whose header fields are to be fetched
/// again (`MailStore.nextStaleHeaders`), newest first. Passing it to
/// `MailStore.fillHeaders` saves the progress: the next batch starts after
/// it, even after a restart.
final class StaleHeadersBatch {
  const StaleHeadersBatch({
    required this.mailboxId,
    required this.emailIds,
    required this.receivedAt,
    required this.seq,
  });

  final String mailboxId;

  /// Every stored message of the batch, local placeholders included.
  final List<String> emailIds;

  /// The oldest message of the batch: its `received_at` (epoch ms) and the
  /// store's `seq`, which orders messages that arrived at the same moment.
  final int receivedAt;
  final int seq;
}

/// How far device rules have run in a mailbox: messages stored after [seq]
/// (the store's insertion order) are candidates, and of those with IMAP ids
/// only the ones with a UID above [uid] under the same [uidValidity] are
/// new mail (not older mail loaded later, search hits or moves).
final class RuleWatermark {
  const RuleWatermark({required this.seq, this.uidValidity, this.uid});
  final int seq;
  final int? uidValidity;
  final int? uid;

  @override
  bool operator ==(Object other) =>
      other is RuleWatermark && other.seq == seq && other.uidValidity == uidValidity && other.uid == uid;

  @override
  int get hashCode => Object.hash(seq, uidValidity, uid);

  @override
  String toString() => 'RuleWatermark($seq, $uidValidity:$uid)';
}
