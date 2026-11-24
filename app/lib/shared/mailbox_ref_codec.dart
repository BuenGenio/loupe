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
    RealMailboxRef(:final mailboxId) => 'b.${_b64(mailboxId)}',
    KeywordMailboxRef(:final keyword) => 'k.${_b64(keyword)}',
  };

  static String _b64(String value) => base64Url.encode(utf8.encode(value)).replaceAll('=', '');

  static String _unb64(String value) => utf8.decode(base64Url.decode(base64Url.normalize(value)));

  static MailboxRef decode(String value) {
    if (value.startsWith('v.')) return VirtualMailboxRef(VirtualMailbox.values.byName(value.substring(2)));
    if (value.startsWith('b.')) return RealMailboxRef(_unb64(value.substring(2)));
    if (value.startsWith('k.')) return KeywordMailboxRef(_unb64(value.substring(2)));
    // The original form, still found in saved smart mailboxes.
    if (value.startsWith('m.')) return RealMailboxRef(Uri.decodeComponent(value.substring(2)));
    throw FormatException('Not a mailbox reference', value);
  }
}
