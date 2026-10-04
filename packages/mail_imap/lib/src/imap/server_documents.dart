/// Documents Loupe keeps on the server when it has no METADATA: one message
/// per copy in the "Loupe Settings" folder (docs/smart-mailboxes-format.md).
library;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

import '../compose/mime_composer.dart' show formatMailDate;
import '../mime/headers.dart';
import '../mime/transfer_encoding.dart';

/// Documents larger than this are refused when reading (a sane bound for
/// settings; METADATA servers usually allow far less).
const maxDocumentSize = 4 * 1024 * 1024;

/// Folder messages looked at per read (the newest ones). Normally the
/// folder holds one message per document.
const maxDocumentMessages = 50;

/// The documents folder among [boxes], if the server has one.
RemoteMailbox? findDocumentsFolder(List<RemoteMailbox> boxes) {
  for (final b in boxes) {
    if (b.isSelectable && ServerDocuments.isFolderName(b.name, b.parentPath)) return b;
  }
  return null;
}

/// The message holding a copy of document [name]: a single text/plain
/// UTF-8 part, base64-encoded (so long JSON lines survive every server),
/// named by the `X-Loupe-Document` header.
Uint8List buildDocumentMessage(
  String name,
  String content, {
  required String address,
  required DateTime date,
  required String messageId,
}) {
  final b64 = base64.encode(utf8.encode(content));
  final body = StringBuffer();
  for (var i = 0; i < b64.length; i += 76) {
    body
      ..write(b64.substring(i, min(i + 76, b64.length)))
      ..write('\r\n');
  }
  final headers = [
    'Date: ${formatMailDate(date)}',
    'From: Loupe <$address>',
    'Subject: Loupe settings: $name (kept in sync by Loupe, please keep)',
    'Message-ID: <$messageId>',
    'MIME-Version: 1.0',
    '${ServerDocuments.header}: $name',
    'Content-Type: text/plain; charset=utf-8',
    'Content-Transfer-Encoding: base64',
  ];
  return Uint8List.fromList(utf8.encode('${headers.join('\r\n')}\r\n\r\n$body'));
}

/// The content of document [name] in a folder message, from its header block
/// and body; null when the message holds another document (or none).
String? readDocumentMessage(String name, List<int> header, List<int> body) {
  final headers = parseHeaderBlock(header);
  if (headerValue(headers, ServerDocuments.header)?.trim() != name) return null;
  final bytes = decodeTransferEncoding(body, headerValue(headers, 'Content-Transfer-Encoding'));
  return utf8.decode(bytes, allowMalformed: true).trim();
}
