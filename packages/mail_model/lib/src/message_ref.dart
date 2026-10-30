import 'email.dart';

/// A message as durable state (actions, matters, review checkpoints) refers
/// to it. Local ids depend on where the message is ([MailIds]: an IMAP id has
/// the mailbox path, UIDVALIDITY and UID), so moving mail changes them. A
/// reference keeps what survives a move, the account and the RFC 5322
/// Message-ID when there is one, beside where the message was last seen.
/// Finding it again: by [messageIdHeader] within [accountId] first, guarded by
/// [subject] and [receivedAt] because a Message-ID is neither always present
/// nor always unique; then by [emailId].
final class MessageRef {
  const MessageRef({
    required this.accountId,
    required this.emailId,
    this.messageIdHeader,
    this.threadId,
    this.subject = '',
    this.receivedAt,
  });

  factory MessageRef.of(EmailSummary email) => MessageRef(
    accountId: email.accountId,
    emailId: email.id,
    messageIdHeader: email.messageIdHeader,
    threadId: email.threadId,
    subject: email.subject,
    receivedAt: email.receivedAt,
  );

  factory MessageRef.fromJson(Map<String, Object?> json) => MessageRef(
    accountId: json['account'] as String,
    emailId: json['email'] as String,
    messageIdHeader: json['messageId'] as String?,
    threadId: json['thread'] as String?,
    subject: (json['subject'] as String?) ?? '',
    receivedAt: switch (json['received']) {
      final String s => DateTime.tryParse(s),
      _ => null,
    },
  );

  final String accountId;

  /// The local id when the reference was made or last reconciled.
  final String emailId;
  final String? messageIdHeader;
  final String? threadId;
  final String subject;
  final DateTime? receivedAt;

  /// Whether [email] is the message this refers to, wherever it is now.
  bool matches(EmailSummary email) {
    if (email.accountId != accountId) return false;
    if (email.id == emailId) return true;
    final id = messageIdHeader;
    if (id == null || email.messageIdHeader != id) return false;
    // A reused Message-ID with another subject or a far-off date is another message.
    if (subject.isNotEmpty && email.subject != subject) return false;
    final at = receivedAt;
    return at == null || email.receivedAt.difference(at).abs() < const Duration(days: 2);
  }

  /// The same message, last seen as [email].
  MessageRef seenAs(EmailSummary email) => MessageRef(
    accountId: accountId,
    emailId: email.id,
    messageIdHeader: messageIdHeader ?? email.messageIdHeader,
    threadId: email.threadId ?? threadId,
    subject: subject,
    receivedAt: receivedAt ?? email.receivedAt,
  );

  Map<String, Object?> toJson() => {
    'account': accountId,
    'email': emailId,
    if (messageIdHeader != null) 'messageId': messageIdHeader,
    if (threadId != null) 'thread': threadId,
    if (subject.isNotEmpty) 'subject': subject,
    if (receivedAt != null) 'received': receivedAt!.toUtc().toIso8601String(),
  };

  @override
  bool operator ==(Object other) =>
      other is MessageRef &&
      other.accountId == accountId &&
      (messageIdHeader != null ? other.messageIdHeader == messageIdHeader : other.emailId == emailId);

  @override
  int get hashCode => Object.hash(accountId, messageIdHeader ?? emailId);
}
