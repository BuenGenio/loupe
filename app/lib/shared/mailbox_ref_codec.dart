import 'dart:convert';

import 'package:mail_model/mail_model.dart';

/// Encodes a [MailboxRef] as a single URL path segment and back.
///
/// Mailbox ids contain percent-encoded paths (`work|Projects%2FAtlas`), and
/// routers decode parameters once more, so real mailboxes are base64url
/// encoded: nothing in that alphabet changes under percent-decoding.
abstract final class MailboxRefCodec {
  static String encode(MailboxRef ref) => switch (ref) {
    VirtualMailboxRef(:final kind) => 'v.${kind.name}',
    RealMailboxRef(:final mailboxId) => 'b.${base64Url.encode(utf8.encode(mailboxId)).replaceAll('=', '')}',
  };

  static MailboxRef decode(String value) {
    if (value.startsWith('v.')) return VirtualMailboxRef(VirtualMailbox.values.byName(value.substring(2)));
    if (value.startsWith('b.')) {
      return RealMailboxRef(utf8.decode(base64Url.decode(base64Url.normalize(value.substring(2)))));
    }
    // The original form, still found in saved smart mailboxes.
    if (value.startsWith('m.')) return RealMailboxRef(Uri.decodeComponent(value.substring(2)));
    throw FormatException('Not a mailbox reference', value);
  }
}
