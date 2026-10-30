import 'dart:typed_data';

import '../budget.dart';

/// A PDF name, without its slash and with `#xx` escapes decoded.
final class PdfName {
  const PdfName(this.value);
  final String value;

  @override
  bool operator ==(Object other) => other is PdfName && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => '/$value';
}

/// A string's bytes. What they mean depends on where the string is: in a
/// content stream, the font's encoding decides.
final class PdfString {
  const PdfString(this.bytes);
  final Uint8List bytes;
}

/// An indirect reference, `12 0 R`.
final class PdfRef {
  const PdfRef(this.number, this.generation);
  final int number;
  final int generation;
}

/// A bare word: an operator in a content stream, or `obj`, `stream`, `R`.
final class PdfKeyword {
  const PdfKeyword(this.value);
  final String value;
}

/// A stream object: its dictionary and its still-encoded bytes.
final class PdfStream {
  const PdfStream(this.dict, this.data);
  final Map<String, Object?> dict;
  final Uint8List data;
}

/// The end of the input.
final class PdfEnd {
  const PdfEnd();
}

const _maxDepth = 48;

/// Whitespace in PDF syntax.
bool isPdfSpace(int c) => c == 0x20 || c == 0x0A || c == 0x0D || c == 0x09 || c == 0x0C || c == 0x00;

/// Delimiters in PDF syntax: ( ) < > [ ] { } / %.
bool isPdfDelimiter(int c) =>
    c == 0x28 ||
    c == 0x29 ||
    c == 0x3C ||
    c == 0x3E ||
    c == 0x5B ||
    c == 0x5D ||
    c == 0x7B ||
    c == 0x7D ||
    c == 0x2F ||
    c == 0x25;

int _hexValue(int c) {
  if (c >= 0x30 && c <= 0x39) return c - 0x30;
  if (c >= 0x41 && c <= 0x46) return c - 0x37;
  if (c >= 0x61 && c <= 0x66) return c - 0x57;
  return -1;
}

/// Reads PDF objects from bytes, leniently: an unexpected byte is skipped,
/// a string or array left open ends with the input, and nesting is bounded.
/// Values are Dart values: null, bool, int, double, [PdfName], [PdfString],
/// `List<Object?>`, `Map<String, Object?>` (keys without the slash),
/// [PdfRef] and [PdfKeyword]. Streams are read by the file, which knows where
/// they end.
final class PdfLexer {
  PdfLexer(this.data, {this.pos = 0, int? end, this.references = true}) : end = end ?? data.length;

  final Uint8List data;
  int pos;
  final int end;

  /// Whether `1 0 R` is a reference. Content streams have none, and reading
  /// them without the lookahead is faster.
  final bool references;

  bool get atEnd {
    skipSpace();
    return pos >= end;
  }

  void skipSpace() {
    while (pos < end) {
      final c = data[pos];
      if (isPdfSpace(c)) {
        pos++;
      } else if (c == 0x25) {
        // A comment, to the end of the line.
        while (pos < end && data[pos] != 0x0A && data[pos] != 0x0D) {
          pos++;
        }
      } else {
        return;
      }
    }
  }

  /// The next object, a [PdfKeyword] for a bare word, or [PdfEnd].
  Object? next([int depth = 0]) {
    if (depth > _maxDepth) throw const Malformed('nested too deep');
    skipSpace();
    if (pos >= end) return const PdfEnd();
    final c = data[pos];
    switch (c) {
      case 0x2F: // /
        return _name();
      case 0x28: // (
        return _literalString();
      case 0x3C: // <
        if (pos + 1 < end && data[pos + 1] == 0x3C) {
          pos += 2;
          return _dict(depth);
        }
        return _hexString();
      case 0x5B: // [
        pos++;
        return _array(depth);
      case 0x3E || 0x5D || 0x29 || 0x7B || 0x7D: // a stray closer or brace
        pos++;
        if (c == 0x3E && pos < end && data[pos] == 0x3E) pos++;
        return PdfKeyword(String.fromCharCode(c));
    }
    if (c == 0x2B || c == 0x2D || c == 0x2E || (c >= 0x30 && c <= 0x39)) return _numberOrRef();
    final word = _word();
    return switch (word) {
      'true' => true,
      'false' => false,
      'null' => null,
      _ => PdfKeyword(word),
    };
  }

  String _word() {
    final start = pos;
    while (pos < end && !isPdfSpace(data[pos]) && !isPdfDelimiter(data[pos])) {
      pos++;
    }
    if (pos == start) {
      pos++; // Not a word either: skip the byte.
      return String.fromCharCode(data[start]);
    }
    return String.fromCharCodes(data, start, pos);
  }

  PdfName _name() {
    pos++;
    final out = <int>[];
    while (pos < end && !isPdfSpace(data[pos]) && !isPdfDelimiter(data[pos])) {
      final c = data[pos];
      if (c == 0x23 && pos + 2 < end) {
        final hi = _hexValue(data[pos + 1]), lo = _hexValue(data[pos + 2]);
        if (hi >= 0 && lo >= 0) {
          out.add(hi << 4 | lo);
          pos += 3;
          continue;
        }
      }
      out.add(c);
      pos++;
    }
    return PdfName(String.fromCharCodes(out));
  }

  Object _numberOrRef() {
    final first = _number();
    if (!references || first is! int || first < 0) return first;
    final save = pos;
    skipSpace();
    if (pos < end && data[pos] >= 0x30 && data[pos] <= 0x39) {
      final second = _number();
      if (second is int) {
        skipSpace();
        if (pos < end && data[pos] == 0x52 && (pos + 1 >= end || _ends(data[pos + 1]))) {
          pos++;
          return PdfRef(first, second);
        }
      }
    }
    pos = save;
    return first;
  }

  static bool _ends(int c) => isPdfSpace(c) || isPdfDelimiter(c);

  num _number() {
    final start = pos;
    var negative = false;
    var sawDigit = false;
    var sawDot = false;
    var whole = 0;
    var fraction = 0.0;
    var scale = 0.1;
    // Signs, repeated or not: lenient readers accept "--5" as -5.
    while (pos < end && (data[pos] == 0x2B || data[pos] == 0x2D)) {
      if (data[pos] == 0x2D) negative = !negative;
      pos++;
    }
    while (pos < end) {
      final c = data[pos];
      if (c >= 0x30 && c <= 0x39) {
        sawDigit = true;
        if (sawDot) {
          fraction += (c - 0x30) * scale;
          scale /= 10;
        } else if (whole < 0x7FFFFFFFFFFF) {
          whole = whole * 10 + (c - 0x30);
        }
      } else if (c == 0x2E && !sawDot) {
        sawDot = true;
      } else {
        break;
      }
      pos++;
    }
    if (pos == start) pos++;
    if (!sawDigit) return 0;
    if (!sawDot) return negative ? -whole : whole;
    final value = whole + fraction;
    return negative ? -value : value;
  }

  PdfString _literalString() {
    pos++;
    final out = BytesBuilder(copy: false);
    final buffer = <int>[];
    var depth = 1;
    while (pos < end) {
      final c = data[pos++];
      if (c == 0x5C) {
        if (pos >= end) break;
        final e = data[pos++];
        switch (e) {
          case 0x6E:
            buffer.add(0x0A);
          case 0x72:
            buffer.add(0x0D);
          case 0x74:
            buffer.add(0x09);
          case 0x62:
            buffer.add(0x08);
          case 0x66:
            buffer.add(0x0C);
          case 0x0D:
            // A line continuation: \ at the end of a line adds nothing.
            if (pos < end && data[pos] == 0x0A) pos++;
          case 0x0A:
            break;
          case >= 0x30 && <= 0x37:
            var v = e - 0x30;
            for (var k = 0; k < 2 && pos < end && data[pos] >= 0x30 && data[pos] <= 0x37; k++) {
              v = v * 8 + data[pos++] - 0x30;
            }
            buffer.add(v & 0xFF);
          default:
            buffer.add(e); // \( \) \\ and unknown escapes: the character itself
        }
      } else if (c == 0x28) {
        depth++;
        buffer.add(c);
      } else if (c == 0x29) {
        if (--depth == 0) break;
        buffer.add(c);
      } else if (c == 0x0D) {
        // An end of line in a string is a line feed, whichever it was.
        if (pos < end && data[pos] == 0x0A) pos++;
        buffer.add(0x0A);
      } else {
        buffer.add(c);
      }
      if (buffer.length >= 4096) {
        out.add(Uint8List.fromList(buffer));
        buffer.clear();
      }
    }
    out.add(Uint8List.fromList(buffer));
    return PdfString(out.takeBytes());
  }

  PdfString _hexString() {
    pos++;
    final out = <int>[];
    var high = -1;
    while (pos < end) {
      final c = data[pos++];
      if (c == 0x3E) break;
      final v = _hexValue(c);
      if (v < 0) continue; // whitespace and junk
      if (high < 0) {
        high = v;
      } else {
        out.add(high << 4 | v);
        high = -1;
      }
    }
    if (high >= 0) out.add(high << 4); // An odd digit count: the last is padded with 0.
    return PdfString(Uint8List.fromList(out));
  }

  List<Object?> _array(int depth) {
    final items = <Object?>[];
    while (true) {
      skipSpace();
      if (pos >= end) return items;
      if (data[pos] == 0x5D) {
        pos++;
        return items;
      }
      final item = next(depth + 1);
      if (item is PdfEnd) return items;
      items.add(item);
    }
  }

  Map<String, Object?> _dict(int depth) {
    final dict = <String, Object?>{};
    while (true) {
      skipSpace();
      if (pos >= end) return dict;
      if (data[pos] == 0x3E) {
        pos++;
        if (pos < end && data[pos] == 0x3E) pos++;
        return dict;
      }
      final key = next(depth + 1);
      if (key is PdfEnd) return dict;
      if (key is! PdfName) {
        // A dictionary interrupted by a keyword (`obj`, `stream`): it ends here.
        if (key is PdfKeyword && key.value.length > 1) return dict;
        continue;
      }
      skipSpace();
      if (pos < end && data[pos] == 0x3E) {
        dict[key.value] = null;
        continue;
      }
      final value = next(depth + 1);
      if (value is PdfEnd) return dict;
      dict[key.value] = value;
    }
  }
}

/// Finds [needle] in [data] from [from] to [to]; -1 when it isn't there.
int indexOfBytes(Uint8List data, List<int> needle, int from, [int? to]) {
  final last = (to ?? data.length) - needle.length;
  final first = needle[0];
  outer:
  for (var i = from < 0 ? 0 : from; i <= last; i++) {
    if (data[i] != first) continue;
    for (var k = 1; k < needle.length; k++) {
      if (data[i + k] != needle[k]) continue outer;
    }
    return i;
  }
  return -1;
}

/// Finds the last [needle] in [data] before [before]; -1 when there is none.
int lastIndexOfBytes(Uint8List data, List<int> needle, [int? before]) {
  final first = needle[0];
  outer:
  for (var i = (before ?? data.length) - needle.length; i >= 0; i--) {
    if (data[i] != first) continue;
    for (var k = 1; k < needle.length; k++) {
      if (data[i + k] != needle[k]) continue outer;
    }
    return i;
  }
  return -1;
}
