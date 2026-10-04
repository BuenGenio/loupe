import 'package:mail_model/mail_model.dart';

/// Encodes a [MailboxRef] as a single URL path segment and back.
abstract final class MailboxRefCodec {
  static String encode(MailboxRef ref) => switch (ref) {
    VirtualMailboxRef(:final kind) => 'v.${kind.name}',
    RealMailboxRef(:final mailboxId) => 'm.${Uri.encodeComponent(mailboxId)}',
  };

  static MailboxRef decode(String value) {
    if (value.startsWith('v.')) return VirtualMailboxRef(VirtualMailbox.values.byName(value.substring(2)));
    if (value.startsWith('m.')) return RealMailboxRef(Uri.decodeComponent(value.substring(2)));
    throw FormatException('Not a mailbox reference', value);
  }
}
