/// Charset decoding for message text.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:enough_convert/enough_convert.dart';

final Map<String, Encoding Function()> _codecs = {
  'utf-8': () => const Utf8Codec(allowMalformed: true),
  'utf8': () => const Utf8Codec(allowMalformed: true),
  'us-ascii': () => const Utf8Codec(allowMalformed: true),
  'ascii': () => const Utf8Codec(allowMalformed: true),
  'iso-8859-1': () => const Windows1252Codec(allowInvalid: true),
  'latin1': () => const Windows1252Codec(allowInvalid: true),
  'iso-8859-2': () => const Latin2Codec(allowInvalid: true),
  'iso-8859-3': () => const Latin3Codec(allowInvalid: true),
  'iso-8859-4': () => const Latin4Codec(allowInvalid: true),
  'iso-8859-5': () => const Latin5Codec(allowInvalid: true),
  'iso-8859-6': () => const Latin6Codec(allowInvalid: true),
  'iso-8859-7': () => const Latin7Codec(allowInvalid: true),
  'iso-8859-8': () => const Latin8Codec(allowInvalid: true),
  'iso-8859-8-i': () => const Latin8Codec(allowInvalid: true),
  'iso-8859-9': () => const Latin9Codec(allowInvalid: true),
  'iso-8859-10': () => const Latin10Codec(allowInvalid: true),
  'iso-8859-11': () => const Latin11Codec(allowInvalid: true),
  'iso-8859-13': () => const Latin13Codec(allowInvalid: true),
  'iso-8859-14': () => const Latin14Codec(allowInvalid: true),
  'iso-8859-15': () => const Latin15Codec(allowInvalid: true),
  'iso-8859-16': () => const Latin16Codec(allowInvalid: true),
  'windows-1250': () => const Windows1250Codec(allowInvalid: true),
  'windows-1251': () => const Windows1251Codec(allowInvalid: true),
  'windows-1252': () => const Windows1252Codec(allowInvalid: true),
  'windows-1253': () => const Windows1253Codec(allowInvalid: true),
  'windows-1254': () => const Windows1254Codec(allowInvalid: true),
  'windows-1255': () => const Windows1255Codec(allowInvalid: true),
  'windows-1256': () => const Windows1256Codec(allowInvalid: true),
  'koi8-r': () => const Koi8rCodec(allowInvalid: true),
  'koi8-u': () => const Koi8uCodec(allowInvalid: true),
  'gbk': () => const GbkCodec(allowInvalid: true),
  'gb2312': () => const GbkCodec(allowInvalid: true),
  'gb18030': () => const GbkCodec(allowInvalid: true),
  'big5': () => const Big5Codec(allowInvalid: true),
  'cp850': () => const CodePage850Codec(allowInvalid: true),
};

String _normalize(String charset) {
  var c = charset.trim().toLowerCase().replaceAll('"', '');
  c = c.replaceFirst(RegExp(r'^(x-|cs)'), '');
  c = switch (c) {
    'iso8859-1' || 'iso_8859-1' || 'latin-1' || 'iso-latin-1' => 'iso-8859-1',
    'cp1250' || 'cp-1250' => 'windows-1250',
    'cp1251' || 'cp-1251' => 'windows-1251',
    'cp1252' || 'cp-1252' => 'windows-1252',
    'cp1253' || 'cp-1253' => 'windows-1253',
    'cp1254' || 'cp-1254' => 'windows-1254',
    'cp1255' || 'cp-1255' => 'windows-1255',
    'cp1256' || 'cp-1256' => 'windows-1256',
    'cp936' || 'windows-936' || 'gb-2312' || 'chinese' => 'gbk',
    'big-5' || 'big5-hkscs' => 'big5',
    'koi8' => 'koi8-r',
    'unicode-1-1-utf-8' || 'utf-8-sig' => 'utf-8',
    _ => c,
  };
  final iso = RegExp(r'^iso[-_ ]?8859[-_ ]?(\d+)$').firstMatch(c);
  if (iso != null) return 'iso-8859-${iso.group(1)}';
  return c;
}

/// Whether [charset] can be decoded (UTF-16 included).
bool isKnownCharset(String charset) {
  final c = _normalize(charset);
  return _codecs.containsKey(c) || c.startsWith('utf-16');
}

/// Decodes [bytes] in [charset]. Unknown or missing charsets: UTF-8 when the
/// bytes are valid UTF-8, otherwise Windows-1252 (the de-facto Latin-1).
String decodeCharset(List<int> bytes, String? charset) {
  final c = charset == null ? '' : _normalize(charset);
  if (c.startsWith('utf-16')) return _decodeUtf16(bytes, littleEndian: c == 'utf-16le');
  final codec = _codecs[c];
  if (codec != null && c != 'us-ascii' && c != 'ascii') return codec().decode(bytes);
  try {
    return const Utf8Decoder().convert(bytes);
  } on FormatException {
    return const Windows1252Codec(allowInvalid: true).decode(bytes);
  }
}

String _decodeUtf16(List<int> bytes, {required bool littleEndian}) {
  var le = littleEndian;
  var start = 0;
  if (bytes.length >= 2) {
    if (bytes[0] == 0xff && bytes[1] == 0xfe) {
      le = true;
      start = 2;
    } else if (bytes[0] == 0xfe && bytes[1] == 0xff) {
      le = false;
      start = 2;
    }
  }
  final units = Uint16List((bytes.length - start) ~/ 2);
  for (var i = 0; i < units.length; i++) {
    final a = bytes[start + 2 * i];
    final b = bytes[start + 2 * i + 1];
    units[i] = le ? (b << 8 | a) : (a << 8 | b);
  }
  return String.fromCharCodes(units);
}
