import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_imap/src/imap/protocol.dart';

/// Converts `\n` line ends to CRLF.
String crlf(String s) => s.replaceAll('\r\n', '\n').replaceAll('\n', '\r\n');

/// An IMAP literal with [content] (CRLF line ends expected).
String literal(String content) => '{${utf8.encode(content).length}}\r\n$content';

/// Splits raw server output (CRLF line ends) into responses the way the
/// client does, with the `* ` prefix removed from untagged ones.
List<ImapResponse> serverResponses(String raw) {
  final responses = <ImapResponse>[];
  final reader = ImapResponseReader((ImapResponse r) {
    final text = r.parseText;
    if (text.startsWith('* ')) r.parseText = text.substring(2);
    responses.add(r);
  });
  reader.onData(Uint8List.fromList(utf8.encode(raw)));
  return responses;
}

/// Feeds untagged responses (CRLF line ends) and the tagged result to [parser].
T runParser<T>(ResponseParser<T> parser, String untagged, {String tagged = 'OK done'}) {
  for (final r in serverResponses(untagged)) {
    parser.parseUntagged(r, null);
  }
  final done = serverResponses('$tagged\r\n').single;
  final response = Response<T>()..status = ResponseStatus.ok;
  return parser.parse(done, response) as T;
}
