/// IMAP mailbox name encoding (modified UTF-7, RFC 3501 section 5.1.3).
library;

import 'dart:convert';

const _b64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,';

/// Encodes a mailbox name for the wire.
String encodeModifiedUtf7(String text) {
  final out = StringBuffer();
  final pending = <int>[];
  void flush() {
    if (pending.isEmpty) return;
    final bytes = <int>[];
    for (final unit in pending) {
      bytes
        ..add(unit >> 8)
        ..add(unit & 0xff);
    }
    out
      ..write('&')
      ..write(base64.encode(bytes).replaceAll('/', ',').replaceAll('=', ''))
      ..write('-');
    pending.clear();
  }

  for (final unit in text.codeUnits) {
    if (unit >= 0x20 && unit <= 0x7e) {
      flush();
      out.write(unit == 0x26 ? '&-' : String.fromCharCode(unit));
    } else {
      pending.add(unit);
    }
  }
  flush();
  return out.toString();
}

/// Decodes a mailbox name from the wire. Invalid sequences are kept as is.
String decodeModifiedUtf7(String text) {
  if (!text.contains('&')) return text;
  final out = StringBuffer();
  var i = 0;
  while (i < text.length) {
    final c = text[i];
    if (c != '&') {
      out.write(c);
      i++;
      continue;
    }
    final end = text.indexOf('-', i + 1);
    if (end < 0) {
      out.write(text.substring(i));
      break;
    }
    if (end == i + 1) {
      out.write('&');
      i = end + 1;
      continue;
    }
    final chunk = text.substring(i + 1, end);
    final decoded = _decodeChunk(chunk);
    out.write(decoded ?? text.substring(i, end + 1));
    i = end + 1;
  }
  return out.toString();
}

String? _decodeChunk(String chunk) {
  if (chunk.split('').any((ch) => !_b64.contains(ch))) return null;
  var b64 = chunk.replaceAll(',', '/');
  while (b64.length % 4 != 0) {
    b64 += '=';
  }
  try {
    final bytes = base64.decode(b64);
    final units = <int>[];
    for (var j = 0; j + 1 < bytes.length; j += 2) {
      units.add(bytes[j] << 8 | bytes[j + 1]);
    }
    return String.fromCharCodes(units);
  } on FormatException {
    return null;
  }
}
