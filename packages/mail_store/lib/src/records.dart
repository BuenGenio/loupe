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
  const MailboxSyncInfo({required this.state, required this.hasOlder, required this.syncedAt});
  final MailboxSyncState state;
  final bool hasOlder;
  final DateTime syncedAt;
}
