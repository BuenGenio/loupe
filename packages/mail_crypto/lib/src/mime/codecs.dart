/// MIME decoding: transfer encodings, charsets, RFC 2047 encoded words and
/// RFC 2231 parameters.
library;

import 'dart:convert';
import 'dart:typed_data';

/// Decodes a body in [encoding] (`base64`, `quoted-printable`, or anything
/// else as is).
Uint8List decodeTransfer(Uint8List body, String? encoding) => switch (encoding?.trim().toLowerCase()) {
  'base64' => decodeBase64Lenient(body),
  'quoted-printable' => decodeQuotedPrintable(body),
  _ => body,
};

/// Base64 that skips line breaks and anything outside the alphabet.
Uint8List decodeBase64Lenient(List<int> data) {
  final clean = StringBuffer();
  for (final b in data) {
    if ((b >= 0x41 && b <= 0x5a) || (b >= 0x61 && b <= 0x7a) || (b >= 0x30 && b <= 0x39) || b == 0x2b || b == 0x2f) {
      clean.writeCharCode(b);
    }
  }
  var s = clean.toString();
  if (s.length % 4 == 1) s = s.substring(0, s.length - 1);
  final pad = (4 - s.length % 4) % 4;
  try {
    return base64.decode(s + '=' * pad);
  } on FormatException {
    return Uint8List(0);
  }
}

/// Quoted-printable (RFC 2045), tolerant of LF line ends and bad escapes.
Uint8List decodeQuotedPrintable(List<int> data) {
  final out = BytesBuilder(copy: false);
  int hex(int c) => switch (c) {
    >= 0x30 && <= 0x39 => c - 0x30,
    >= 0x41 && <= 0x46 => c - 0x37,
    >= 0x61 && <= 0x66 => c - 0x57,
    _ => -1,
  };
  for (var i = 0; i < data.length; i++) {
    final c = data[i];
    if (c != 0x3d) {
      out.addByte(c);
      continue;
    }
    // Soft line break: "=" then optional whitespace and a line end.
    var j = i + 1;
    while (j < data.length && (data[j] == 0x20 || data[j] == 0x09)) {
      j++;
    }
    if (j < data.length && (data[j] == 0x0d || data[j] == 0x0a)) {
      if (data[j] == 0x0d && j + 1 < data.length && data[j + 1] == 0x0a) j++;
      i = j;
      continue;
    }
    if (j >= data.length) {
      i = j;
      continue;
    }
    if (i + 2 < data.length) {
      final h = hex(data[i + 1]);
      final l = hex(data[i + 2]);
      if (h >= 0 && l >= 0) {
        out.addByte(h * 16 + l);
        i += 2;
        continue;
      }
    }
    out.addByte(c);
  }
  return out.takeBytes();
}

const _cp1252 = <int, int>{
  0x80: 0x20ac, 0x82: 0x201a, 0x83: 0x0192, 0x84: 0x201e, 0x85: 0x2026, 0x86: 0x2020, 0x87: 0x2021, //
  0x88: 0x02c6, 0x89: 0x2030, 0x8a: 0x0160, 0x8b: 0x2039, 0x8c: 0x0152, 0x8e: 0x017d, 0x91: 0x2018,
  0x92: 0x2019, 0x93: 0x201c, 0x94: 0x201d, 0x95: 0x2022, 0x96: 0x2013, 0x97: 0x2014, 0x98: 0x02dc,
  0x99: 0x2122, 0x9a: 0x0161, 0x9b: 0x203a, 0x9c: 0x0153, 0x9e: 0x017e, 0x9f: 0x0178,
};

/// Text in [charset]: UTF-8, ASCII, Latin-1, Windows-1252 and Latin-9;
/// anything else is read as UTF-8, then Latin-1 if that fails.
String decodeCharset(List<int> bytes, String? charset) {
  final cs = (charset ?? 'utf-8').trim().toLowerCase().replaceAll('_', '-');
  switch (cs) {
    case 'iso-8859-1' || 'latin1' || 'latin-1' || 'l1' || 'iso8859-1':
      return latin1.decode(bytes);
    case 'windows-1252' || 'cp1252' || 'us-ascii' || 'ascii':
      return String.fromCharCodes([for (final b in bytes) _cp1252[b] ?? b]);
    case 'iso-8859-15' || 'latin9' || 'latin-9':
      const changed = {0xa4: 0x20ac, 0xa6: 0x0160, 0xa8: 0x0161, 0xb4: 0x017d, 0xb8: 0x017e, 0xbc: 0x0152};
      return String.fromCharCodes([for (final b in bytes) changed[b] ?? b]);
    default:
      try {
        return utf8.decode(bytes);
      } on FormatException {
        return cs == 'utf-8' || cs == 'utf8' ? utf8.decode(bytes, allowMalformed: true) : latin1.decode(bytes);
      }
  }
}

final _encodedWord = RegExp(r'=\?([^?\s]+)\?([bBqQ])\?([^?\s]*)\?=');

/// Decodes RFC 2047 encoded words; whitespace between two encoded words is dropped.
String decodeEncodedWords(String value) {
  if (!value.contains('=?')) return value;
  final out = StringBuffer();
  var last = 0;
  var previousWasWord = false;
  for (final m in _encodedWord.allMatches(value)) {
    final between = value.substring(last, m.start);
    if (!(previousWasWord && between.trim().isEmpty)) out.write(between);
    var charset = m.group(1)!;
    final star = charset.indexOf('*');
    if (star >= 0) charset = charset.substring(0, star);
    final text = m.group(3)!;
    final List<int> bytes;
    if (m.group(2)!.toLowerCase() == 'b') {
      bytes = decodeBase64Lenient(ascii.encode(text));
    } else {
      bytes = decodeQuotedPrintable(ascii.encode(text.replaceAll('_', ' ')));
    }
    out.write(decodeCharset(bytes, charset));
    last = m.end;
    previousWasWord = true;
  }
  out.write(value.substring(last));
  return out.toString();
}

/// A parsed `type/subtype; name=value` header (Content-Type, Content-Disposition).
final class HeaderValue {
  const HeaderValue(this.value, this.params);

  /// Lower-cased main value, e.g. `multipart/signed` or `attachment`.
  final String value;

  /// Parameters by lower-cased name, RFC 2231 continuations joined and decoded.
  final Map<String, String> params;

  String? operator [](String name) => params[name.toLowerCase()];

  static final _paramName = RegExp(r'^(.+?)(?:\*(\d+))?(\*)?$', dotAll: true);

  static HeaderValue parse(String? raw) {
    if (raw == null) return const HeaderValue('', {});
    final parts = _splitParams(raw);
    final value = parts.isEmpty ? '' : parts.first.trim().toLowerCase();
    final plain = <String, String>{};
    final extended = <String, Map<int, (String, bool)>>{};
    for (final p in parts.skip(1)) {
      final eq = p.indexOf('=');
      if (eq <= 0) continue;
      var name = p.substring(0, eq).trim().toLowerCase();
      var v = p.substring(eq + 1).trim();
      if (v.length >= 2 && v.startsWith('"') && v.endsWith('"')) {
        v = v.substring(1, v.length - 1).replaceAllMapped(RegExp(r'\\(.)'), (m) => m.group(1)!);
      }
      // dotAll: a name with a CR in it (a header line split oddly) must match too.
      final m = _paramName.firstMatch(name)!;
      if (m.group(2) == null && m.group(3) == null) {
        plain[name] = v;
        continue;
      }
      name = m.group(1)!;
      final index = int.tryParse(m.group(2) ?? '0') ?? 0;
      (extended[name] ??= {})[index] = (v, m.group(3) != null);
    }
    for (final MapEntry(key: name, value: pieces) in extended.entries) {
      final ordered = pieces.keys.toList()..sort();
      String? charset;
      final bytes = <int>[];
      for (final (i, k) in ordered.indexed) {
        var (v, encoded) = pieces[k]!;
        if (encoded && i == 0) {
          final q = v.indexOf("'");
          final q2 = q < 0 ? -1 : v.indexOf("'", q + 1);
          if (q2 > 0) {
            charset = v.substring(0, q);
            v = v.substring(q2 + 1);
          }
        }
        if (encoded) {
          bytes.addAll(_percentDecode(v));
        } else {
          bytes.addAll(utf8.encode(v));
        }
      }
      plain[name] = decodeCharset(bytes, charset ?? 'utf-8');
    }
    return HeaderValue(value, plain);
  }
}

List<int> _percentDecode(String s) {
  final out = <int>[];
  for (var i = 0; i < s.length; i++) {
    if (s[i] == '%' && i + 2 < s.length) {
      final v = int.tryParse(s.substring(i + 1, i + 3), radix: 16);
      if (v != null) {
        out.add(v);
        i += 2;
        continue;
      }
    }
    out.addAll(utf8.encode(s[i]));
  }
  return out;
}

/// Splits at `;` outside quotes.
List<String> _splitParams(String raw) {
  final out = <String>[];
  final cur = StringBuffer();
  var quoted = false;
  for (var i = 0; i < raw.length; i++) {
    final c = raw[i];
    if (c == '\\' && quoted && i + 1 < raw.length) {
      cur
        ..write(c)
        ..write(raw[++i]);
      continue;
    }
    if (c == '"') quoted = !quoted;
    if (c == ';' && !quoted) {
      out.add(cur.toString());
      cur.clear();
    } else {
      cur.write(c);
    }
  }
  if (cur.toString().trim().isNotEmpty) out.add(cur.toString());
  return out;
}

/// LF line ends become CRLF (RFC 3156 canonical form); CRLF stays.
Uint8List canonicalLineEnds(Uint8List data) {
  var lone = 0;
  for (var i = 0; i < data.length; i++) {
    if (data[i] == 0x0a && (i == 0 || data[i - 1] != 0x0d)) lone++;
  }
  if (lone == 0) return data;
  final out = Uint8List(data.length + lone);
  var j = 0;
  for (var i = 0; i < data.length; i++) {
    if (data[i] == 0x0a && (i == 0 || data[i - 1] != 0x0d)) out[j++] = 0x0d;
    out[j++] = data[i];
  }
  return out;
}
