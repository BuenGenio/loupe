import 'outgoing.dart';
import 'repository.dart';

/// Where a message waiting in the outbox stands.
enum OutboxStatus {
  /// Goes out at [OutboxItem.sendAt]: the end of the undo-send window, or
  /// right away after "Send Now".
  queued,

  /// Waits for a time the user picked ("Send Later").
  scheduled,

  /// Being handed to the server now; it can no longer be cancelled.
  sending,

  /// The last attempt failed ([OutboxItem.error]). It is retried at
  /// [OutboxItem.sendAt], or at once with `sendNow` (Retry). A message the
  /// server refused for good ([PermanentMailException]) is retried only by
  /// `sendNow`.
  failed,
}

/// A message waiting to be sent.
final class OutboxItem {
  const OutboxItem({
    required this.id,
    required this.message,
    required this.sendAt,
    required this.status,
    this.error,
    this.composedFor,
  });

  /// The outbox id `MailRepository.send` returned.
  final String id;
  final OutgoingMessage message;

  /// When it goes out: the scheduled time, the end of the undo window, or
  /// the next retry of a failed message.
  final DateTime sendAt;
  final OutboxStatus status;

  /// Human-readable reason of the last failure, shown as is.
  final String? error;

  /// Signed or encrypted mail is composed when it is queued, while the user
  /// is there to unlock the key, so it can go out from background work:
  /// the Date it was composed for. Null when it is composed as it goes out.
  /// Sending it earlier (Send Now) or at another time composes it again.
  final DateTime? composedFor;
}
