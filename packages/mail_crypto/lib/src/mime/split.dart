/// An outgoing message split into header lines and body, for the
/// composers that wrap another one (PGP/MIME, S/MIME).
library;

import 'dart:convert';
import 'dart:typed_data';

/// The lower-cased name of a header line (`Subject: …` → `subject`).
String headerName(String headerLine) {
  final colon = headerLine.indexOf(':');
  return colon < 0 ? '' : headerLine.substring(0, colon).trim().toLowerCase();
}

/// Header lines (CRLF added), a blank line and [body].
Uint8List assembleEntity(List<String> headers, List<int> body) {
  final out = BytesBuilder(copy: false);
  for (final h in headers) {
    out.add(utf8.encode('$h\r\n'));
  }
  out
    ..add(const [13, 10])
    ..add(body);
  return out.takeBytes();
}

/// An RFC 822 message as header lines (folds kept) and body.
final class SplitMessage {
  SplitMessage(this.headers, this.body);

  final List<String> headers;
  final Uint8List body;

  static SplitMessage parse(Uint8List bytes) {
    var end = -1;
    for (var i = 0; i + 3 < bytes.length; i++) {
      if (bytes[i] == 13 && bytes[i + 1] == 10 && bytes[i + 2] == 13 && bytes[i + 3] == 10) {
        end = i;
        break;
      }
    }
    final head = end < 0
        ? utf8.decode(bytes, allowMalformed: true)
        : utf8.decode(bytes.sublist(0, end), allowMalformed: true);
    final body = end < 0 ? Uint8List(0) : Uint8List.sublistView(bytes, end + 4);
    final headers = <String>[];
    for (final line in head.split('\r\n')) {
      if (line.isEmpty) continue;
      if ((line.startsWith(' ') || line.startsWith('\t')) && headers.isNotEmpty) {
        headers.add('${headers.removeLast()}\r\n$line');
      } else {
        headers.add(line);
      }
    }
    return SplitMessage(headers, body);
  }

  bool _isContent(String h) => headerName(h).startsWith('content-');

  /// The headers that stay outside: everything but Content-* and MIME-Version.
  List<String> get outer => [
    for (final h in headers)
      if (!_isContent(h) && headerName(h) != 'mime-version') h,
  ];

  /// The body as a MIME entity of its own (its Content-* headers and body).
  Uint8List get content => assembleEntity([
    for (final h in headers)
      if (_isContent(h)) h,
  ], body);

  /// The message with [extra] header lines before its Content-Type.
  Uint8List withHeaders(List<String> extra) {
    if (extra.isEmpty) return assembleEntity(headers, body);
    final at = headers.indexWhere((h) => headerName(h) == 'mime-version');
    final lines = [...headers]..insertAll(at < 0 ? headers.length : at + 1, extra);
    return assembleEntity(lines, body);
  }

  /// The message with [content] (an entity) as its body.
  Uint8List withContent(Uint8List content, List<String> extra) {
    final entity = SplitMessage.parse(content);
    return assembleEntity([...outer, 'MIME-Version: 1.0', ...extra, ...entity.headers], entity.body);
  }
}
