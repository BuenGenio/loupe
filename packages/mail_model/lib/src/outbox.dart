import 'outgoing.dart';

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
  /// [OutboxItem.sendAt], or at once with `sendNow`.
  failed,
}

/// A message waiting to be sent.
final class OutboxItem {
  const OutboxItem({required this.id, required this.message, required this.sendAt, required this.status, this.error});

  /// The outbox id `MailRepository.send` returned.
  final String id;
  final OutgoingMessage message;

  /// When it goes out: the scheduled time, the end of the undo window, or
  /// the next retry of a failed message.
  final DateTime sendAt;
  final OutboxStatus status;

  /// Human-readable reason of the last failure, shown as is.
  final String? error;
}
