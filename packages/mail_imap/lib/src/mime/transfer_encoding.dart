/// Content-Transfer-Encoding decoders. Lenient: they accept truncated input
/// (partial IMAP fetches) and skip garbage instead of throwing.
library;

import 'dart:convert';
import 'dart:typed_data';

/// Decodes [data] according to [encoding] (`base64`, `quoted-printable`,
/// `7bit`, `8bit`, `binary`; null or unknown means as-is).
Uint8List decodeTransferEncoding(List<int> data, String? encoding) {
  switch (encoding?.trim().toLowerCase()) {
    case 'base64':
      return decodeBase64Lenient(data);
    case 'quoted-printable':
      return decodeQuotedPrintable(data);
    default:
      return data is Uint8List ? data : Uint8List.fromList(data);
  }
}

bool _isB64(int c) =>
    (c >= 0x41 && c <= 0x5a) || (c >= 0x61 && c <= 0x7a) || (c >= 0x30 && c <= 0x39) || c == 0x2b || c == 0x2f;

/// Base64 decoding that ignores line breaks and junk and drops an incomplete
/// trailing group.
Uint8List decodeBase64Lenient(List<int> data) {
  final clean = StringBuffer();
  var count = 0;
  for (final c in data) {
    if (c == 0x3d) break;
    if (_isB64(c)) {
      clean.writeCharCode(c);
      count++;
    }
  }
  final text = clean.toString();
  final whole = count - count % 4;
  Uint8List head;
  try {
    head = base64.decode(text.substring(0, whole));
  } on FormatException {
    return Uint8List(0);
  }
  final rest = text.substring(whole);
  if (rest.length < 2) return head;
  // Decode an incomplete last group by hand (a truncated partial fetch).
  final v = [for (final c in rest.codeUnits) _b64Value(c)];
  final tail = <int>[(v[0] << 2 | v[1] >> 4) & 0xff];
  if (v.length == 3) tail.add(((v[1] & 0xf) << 4 | v[2] >> 2) & 0xff);
  return Uint8List.fromList([...head, ...tail]);
}

int _b64Value(int c) {
  if (c >= 0x41 && c <= 0x5a) return c - 0x41;
  if (c >= 0x61 && c <= 0x7a) return c - 0x61 + 26;
  if (c >= 0x30 && c <= 0x39) return c - 0x30 + 52;
  return c == 0x2b ? 62 : 63;
}

int _hex(int c) {
  if (c >= 0x30 && c <= 0x39) return c - 0x30;
  if (c >= 0x41 && c <= 0x46) return c - 0x37;
  if (c >= 0x61 && c <= 0x66) return c - 0x57;
  return -1;
}

/// Quoted-printable decoding (RFC 2045). Soft line breaks are removed;
/// invalid escapes are kept literally; a truncated escape at the end is dropped.
Uint8List decodeQuotedPrintable(List<int> data) {
  final buffer = Uint8List(data.length);
  var n = 0;
  var i = 0;
  while (i < data.length) {
    final c = data[i];
    if (c != 0x3d) {
      buffer[n++] = c;
      i++;
      continue;
    }
    // '='
    if (i + 1 >= data.length) break;
    final c1 = data[i + 1];
    if (c1 == 0x0d || c1 == 0x0a) {
      i += (c1 == 0x0d && i + 2 < data.length && data[i + 2] == 0x0a) ? 3 : 2;
      continue;
    }
    if (c1 == 0x20 || c1 == 0x09) {
      // "=  \r\n": soft break with trailing whitespace.
      var j = i + 1;
      while (j < data.length && (data[j] == 0x20 || data[j] == 0x09)) {
        j++;
      }
      if (j >= data.length) break;
      if (data[j] == 0x0d || data[j] == 0x0a) {
        i = j + ((data[j] == 0x0d && j + 1 < data.length && data[j + 1] == 0x0a) ? 2 : 1);
        continue;
      }
    }
    if (i + 2 >= data.length) break;
    final h = _hex(c1);
    final l = _hex(data[i + 2]);
    if (h < 0 || l < 0) {
      buffer[n++] = c;
      i++;
      continue;
    }
    buffer[n++] = h << 4 | l;
    i += 3;
  }
  return buffer.sublist(0, n);
}

/// Quoted-printable decoding of an RFC 2047 "Q" word: `_` means space.
Uint8List decodeQEncoding(String text) =>
    decodeQuotedPrintable(latin1.encode(text.replaceAll('_', ' ').replaceAll(RegExp(r'[^\x00-\xff]'), '?')));
