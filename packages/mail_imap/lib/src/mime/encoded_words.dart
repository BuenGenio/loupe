/// RFC 2047 encoded words and RFC 2231 parameter values.
library;

import 'dart:convert';

import 'charsets.dart';
import 'transfer_encoding.dart';

final _encodedWord = RegExp(r'=\?([^?\s]+)\?([bBqQ])\?([^?\s]*)\?=');
final _gapBetweenWords = RegExp(r'(\?=)[ \t\r\n]+(=\?)');

/// Decodes RFC 2047 encoded words in a header value. Whitespace between two
/// adjacent encoded words is dropped, as the RFC requires.
String decodeEncodedWords(String value) {
  if (!value.contains('=?')) return value;
  final joined = value.replaceAllMapped(_gapBetweenWords, (m) => '${m[1]}${m[2]}');
  // Decode runs of words with the same charset together, so multi-byte
  // characters split across words survive.
  final out = StringBuffer();
  var last = 0;
  final matches = _encodedWord.allMatches(joined).toList();
  var i = 0;
  while (i < matches.length) {
    final m = matches[i];
    out.write(joined.substring(last, m.start));
    final charset = m[1]!.split('*').first;
    final bytes = <int>[..._wordBytes(m)];
    var end = m.end;
    var j = i + 1;
    while (j < matches.length &&
        matches[j].start == end &&
        matches[j][1]!.split('*').first.toLowerCase() == charset.toLowerCase()) {
      bytes.addAll(_wordBytes(matches[j]));
      end = matches[j].end;
      j++;
    }
    out.write(decodeCharset(bytes, charset));
    last = end;
    i = j;
  }
  out.write(joined.substring(last));
  return out.toString();
}

List<int> _wordBytes(RegExpMatch m) {
  final text = m[3]!;
  return m[2]!.toLowerCase() == 'b' ? decodeBase64Lenient(latin1.encode(text)) : decodeQEncoding(text);
}

/// Decodes an RFC 2231 extended value (`utf-8'en'%E2%82%AC`).
String decodeRfc2231Value(String value) {
  final first = value.indexOf("'");
  final second = first < 0 ? -1 : value.indexOf("'", first + 1);
  if (second < 0) return _percentDecode(value, null);
  final charset = value.substring(0, first);
  return _percentDecode(value.substring(second + 1), charset.isEmpty ? null : charset);
}

String _percentDecode(String text, String? charset) {
  final bytes = <int>[];
  for (var i = 0; i < text.length; i++) {
    final c = text.codeUnitAt(i);
    if (c == 0x25 && i + 2 < text.length) {
      final v = int.tryParse(text.substring(i + 1, i + 3), radix: 16);
      if (v != null) {
        bytes.add(v);
        i += 2;
        continue;
      }
    }
    if (c < 0x80) {
      bytes.add(c);
    } else {
      bytes.addAll(utf8.encode(String.fromCharCode(c)));
    }
  }
  return decodeCharset(bytes, charset ?? 'utf-8');
}

/// Collects MIME parameters, merging RFC 2231 continuations (`name*0*`,
/// `name*1`) and decoding extended values. Keys are lower-cased.
Map<String, String> normalizeParameters(Map<String, String> raw) {
  final result = <String, String>{};
  final continued = <String, Map<int, (String, bool)>>{};
  raw.forEach((key, value) {
    final k = key.toLowerCase();
    final m = RegExp(r'^([^*]+)\*(\d+)(\*?)$').firstMatch(k);
    if (m != null) {
      continued.putIfAbsent(m[1]!, () => {})[int.parse(m[2]!)] = (value, m[3] == '*');
    } else if (k.endsWith('*')) {
      result[k.substring(0, k.length - 1)] = decodeRfc2231Value(value);
    } else {
      result.putIfAbsent(k, () => decodeEncodedWords(value));
    }
  });
  continued.forEach((name, parts) {
    final keys = parts.keys.toList()..sort();
    String? charset;
    final bytes = <int>[];
    for (final index in keys) {
      var (value, extended) = parts[index]!;
      if (extended) {
        if (index == 0) {
          final first = value.indexOf("'");
          final second = first < 0 ? -1 : value.indexOf("'", first + 1);
          if (second >= 0) {
            charset = value.substring(0, first);
            value = value.substring(second + 1);
          }
        }
        bytes.addAll(latin1.encode(_percentToLatin1(value)));
      } else {
        bytes.addAll(utf8.encode(value));
      }
    }
    result[name] = decodeCharset(bytes, charset == null || charset.isEmpty ? 'utf-8' : charset);
  });
  return result;
}

String _percentToLatin1(String text) {
  final out = StringBuffer();
  for (var i = 0; i < text.length; i++) {
    final c = text[i];
    if (c == '%' && i + 2 < text.length) {
      final v = int.tryParse(text.substring(i + 1, i + 3), radix: 16);
      if (v != null) {
        out.writeCharCode(v);
        i += 2;
        continue;
      }
    }
    out.writeCharCode(c.codeUnitAt(0) & 0xff);
  }
  return out.toString();
}
