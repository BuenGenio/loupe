import 'dart:convert';
import 'dart:typed_data';

/// A text attachment decoded for display, and the charset it was read as.
final class DecodedText {
  const DecodedText(this.text, this.charset);

  final String text;

  /// "UTF-8", "UTF-16" or "Latin-1".
  final String charset;
}

/// Windows-1252 characters for bytes 0x80–0x9F, which Latin-1 leaves as C1
/// controls. Files called "Latin-1" are nearly always Windows-1252 in
/// practice (curly quotes, the euro sign); the rest of the range is the same.
const _cp1252 = [
  0x20AC, 0x81, 0x201A, 0x0192, 0x201E, 0x2026, 0x2020, 0x2021, //
  0x02C6, 0x2030, 0x0160, 0x2039, 0x0152, 0x8D, 0x017D, 0x8F,
  0x90, 0x2018, 0x2019, 0x201C, 0x201D, 0x2022, 0x2013, 0x2014,
  0x02DC, 0x2122, 0x0161, 0x203A, 0x0153, 0x9D, 0x017E, 0x0178,
];

String _decodeLatin1(List<int> bytes) {
  final codes = Uint16List(bytes.length);
  for (var i = 0; i < bytes.length; i++) {
    final b = bytes[i];
    codes[i] = b >= 0x80 && b < 0xA0 ? _cp1252[b - 0x80] : b;
  }
  return String.fromCharCodes(codes);
}

String _decodeUtf16(List<int> bytes, {required bool bigEndian}) {
  final units = Uint16List(bytes.length ~/ 2);
  for (var i = 0; i < units.length; i++) {
    final a = bytes[2 * i], b = bytes[2 * i + 1];
    units[i] = bigEndian ? (a << 8) | b : (b << 8) | a;
  }
  return String.fromCharCodes(units);
}

/// Decodes a text attachment: a byte-order mark wins, then UTF-8 if the
/// bytes are valid UTF-8, otherwise Latin-1 (read as Windows-1252, its
/// common superset).
DecodedText decodeAttachmentText(List<int> bytes) {
  if (bytes.length >= 3 && bytes[0] == 0xEF && bytes[1] == 0xBB && bytes[2] == 0xBF) {
    return DecodedText(utf8.decode(bytes.sublist(3), allowMalformed: true), 'UTF-8');
  }
  if (bytes.length >= 2 && bytes[0] == 0xFF && bytes[1] == 0xFE) {
    return DecodedText(_decodeUtf16(bytes.sublist(2), bigEndian: false), 'UTF-16');
  }
  if (bytes.length >= 2 && bytes[0] == 0xFE && bytes[1] == 0xFF) {
    return DecodedText(_decodeUtf16(bytes.sublist(2), bigEndian: true), 'UTF-16');
  }
  try {
    return DecodedText(utf8.decode(bytes), 'UTF-8');
  } on FormatException {
    return DecodedText(_decodeLatin1(bytes), 'Latin-1');
  }
}

/// The first [limit] bytes of [bytes], cut back to a UTF-8 character
/// boundary so valid UTF-8 stays valid. All of it when it is shorter.
Uint8List headOfText(Uint8List bytes, int limit) {
  if (bytes.length <= limit) return bytes;
  var end = limit;
  while (end > 0 && (bytes[end] & 0xC0) == 0x80) {
    end--;
  }
  return Uint8List.sublistView(bytes, 0, end);
}
