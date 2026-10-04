/// IMAP ENVELOPE parsing.
library;

import 'package:mail_model/mail_model.dart';

import '../mime/dates.dart';
import '../mime/encoded_words.dart';
import '../mime/headers.dart';
import 'protocol.dart';
import 'values.dart';

/// The fields of an IMAP ENVELOPE, decoded.
final class ImapEnvelope {
  const ImapEnvelope({
    this.date,
    this.subject = '',
    this.from = const [],
    this.sender = const [],
    this.replyTo = const [],
    this.to = const [],
    this.cc = const [],
    this.bcc = const [],
    this.inReplyTo,
    this.messageId,
  });

  final DateTime? date;
  final String subject;
  final List<EmailAddress> from;
  final List<EmailAddress> sender;
  final List<EmailAddress> replyTo;
  final List<EmailAddress> to;
  final List<EmailAddress> cc;
  final List<EmailAddress> bcc;

  /// Without angle brackets.
  final String? inReplyTo;

  /// Without angle brackets.
  final String? messageId;
}

/// Parses the ten ENVELOPE fields (the children of the `ENVELOPE` value).
ImapEnvelope parseEnvelope(List<ImapValue> f) {
  String? s(int i) => i < f.length ? stringOf(f[i]) : null;
  List<EmailAddress> a(int i) => i < f.length ? parseAddressList(f[i]) : const [];
  return ImapEnvelope(
    date: parseMailDate(s(0)),
    subject: _cleanSubject(decodeEncodedWords(s(1) ?? '')),
    from: a(2),
    sender: a(3),
    replyTo: a(4),
    to: a(5),
    cc: a(6),
    bcc: a(7),
    inReplyTo: stripMessageId(s(8)),
    messageId: stripMessageId(s(9)),
  );
}

String _cleanSubject(String s) => s.replaceAll(RegExp(r'[\r\n\t]+'), ' ').trim();

/// Parses an address list; group markers are skipped.
List<EmailAddress> parseAddressList(ImapValue v) {
  final list = v.children;
  if (!isList(v) || list == null) return const [];
  final result = <EmailAddress>[];
  for (final item in list) {
    final parts = item.children;
    if (!isList(item) || parts == null || parts.length < 4) continue;
    final mailbox = stringOf(parts[2]);
    final host = stringOf(parts[3]);
    if (host == null || mailbox == null) continue;
    final rawName = stringOf(parts[0]);
    final name = rawName == null ? null : decodeEncodedWords(rawName).trim();
    result.add(EmailAddress('$mailbox@$host', name == null || name.isEmpty ? null : name));
  }
  return result;
}
