import 'dart:typed_data';

import '../budget.dart';
import 'encodings.dart';
import 'filters.dart';
import 'syntax.dart';

/// Turns a font's string bytes into text: through its ToUnicode map when it
/// has one, else through its single-byte encoding (with `/Differences`).
/// A composite font without a ToUnicode map gives nothing: its codes are
/// glyph ids, and guessing letters from them would make text up.
final class PdfFont {
  PdfFont._({required this.codeBytes, this.toUnicode, this.simple});

  /// What an unknown or missing font reads as: StandardEncoding.
  factory PdfFont.fallback() => PdfFont._(codeBytes: 1, simple: standardEncoding);

  /// Reads [dict], a font dictionary.
  factory PdfFont.read(Map<String, Object?> dict, Object? Function(Object?) resolve, Budget budget) {
    final subtype = switch (resolve(dict['Subtype'])) {
      final PdfName n => n.value,
      _ => '',
    };
    Map<int, String>? toUnicode;
    var codeBytes = subtype == 'Type0' ? 2 : 1;
    final cmap = resolve(dict['ToUnicode']);
    if (cmap is PdfStream) {
      try {
        final parsed = _parseCMap(decodeStream(cmap, resolve, budget), budget);
        if (parsed.map.isNotEmpty) {
          toUnicode = parsed.map;
          if (parsed.codeBytes != null) codeBytes = parsed.codeBytes!;
        }
      } on UnsupportedFilter {
        // No map: fall back to the encoding.
      } on Malformed {
        // Same.
      }
    }
    if (subtype == 'Type0') return PdfFont._(codeBytes: codeBytes, toUnicode: toUnicode);
    return PdfFont._(codeBytes: 1, toUnicode: toUnicode, simple: _simpleEncoding(dict, subtype, resolve));
  }

  final int codeBytes;
  final Map<int, String>? toUnicode;
  final List<String>? simple;

  String decode(Uint8List bytes) {
    final out = StringBuffer();
    final map = toUnicode;
    final step = codeBytes;
    for (var i = 0; i + step <= bytes.length; i += step) {
      final code = step == 1 ? bytes[i] : (bytes[i] << 8) | bytes[i + 1];
      final mapped = map?[code];
      if (mapped != null) {
        out.write(mapped);
      } else if (simple != null && code < 256) {
        out.write(simple![code]);
      }
    }
    return out.toString();
  }
}

List<String> _simpleEncoding(Map<String, Object?> dict, String subtype, Object? Function(Object?) resolve) {
  List<String> base(Object? name) => switch (name) {
    PdfName(value: 'WinAnsiEncoding') => winAnsiEncoding,
    PdfName(value: 'MacRomanEncoding') => macRomanEncoding,
    PdfName(value: 'StandardEncoding') => standardEncoding,
    // Without an encoding, a TrueType font's own table is nearly always
    // WinAnsi in practice; Type 1 fonts default to StandardEncoding.
    _ => subtype == 'TrueType' ? winAnsiEncoding : standardEncoding,
  };
  final encoding = resolve(dict['Encoding']);
  if (encoding is! Map<String, Object?>) return base(encoding);
  final table = [...base(resolve(encoding['BaseEncoding']))];
  final differences = resolve(encoding['Differences']);
  if (differences is List<Object?>) {
    var code = 0;
    for (final d in differences.take(1024)) {
      final v = resolve(d);
      if (v is int) {
        code = v;
      } else if (v is PdfName) {
        if (code >= 0 && code < 256) table[code] = glyphToUnicode(v.value);
        code++;
      }
    }
  }
  return table;
}

/// A ToUnicode CMap's mappings (`bfchar`, `bfrange`) and the code length its
/// first `codespacerange` declares.
({Map<int, String> map, int? codeBytes}) _parseCMap(Uint8List data, Budget budget) {
  const maxMappings = 70000;
  final map = <int, String>{};
  int? codeBytes;
  final lexer = PdfLexer(data, references: false);
  final operands = <Object?>[];
  String utf16(PdfString s) {
    final b = s.bytes;
    final units = <int>[for (var i = 0; i + 1 < b.length; i += 2) (b[i] << 8) | b[i + 1]];
    if (b.length == 1) units.add(b[0]);
    return String.fromCharCodes(units);
  }

  int code(PdfString s) {
    var v = 0;
    for (final b in s.bytes.take(4)) {
      v = v << 8 | b;
    }
    return v;
  }

  var mode = '';
  while (true) {
    final token = lexer.next();
    if (token is PdfEnd) break;
    budget.operator();
    if (token is! PdfKeyword) {
      if (mode.isNotEmpty) operands.add(token);
      continue;
    }
    switch (token.value) {
      case 'begincodespacerange' || 'beginbfchar' || 'beginbfrange':
        mode = token.value;
        operands.clear();
      case 'endcodespacerange':
        if (codeBytes == null && operands.isNotEmpty && operands.first is PdfString) {
          final n = (operands.first! as PdfString).bytes.length;
          if (n == 1 || n == 2) codeBytes = n;
        }
        mode = '';
      case 'endbfchar':
        for (var i = 0; i + 1 < operands.length; i += 2) {
          final src = operands[i], dst = operands[i + 1];
          if (src is PdfString && dst is PdfString) map[code(src)] = utf16(dst);
          if (map.length > maxMappings) break;
        }
        mode = '';
      case 'endbfrange':
        for (var i = 0; i + 2 < operands.length; i += 3) {
          final lo = operands[i], hi = operands[i + 1], dst = operands[i + 2];
          if (lo is! PdfString || hi is! PdfString) continue;
          final from = code(lo), to = code(hi);
          if (to < from || to - from > 0xFFFF || map.length + (to - from) > maxMappings) continue;
          if (dst is PdfString) {
            final start = utf16(dst);
            if (start.isEmpty) continue;
            final last = start.codeUnitAt(start.length - 1);
            final prefix = start.substring(0, start.length - 1);
            for (var c = from; c <= to; c++) {
              map[c] = '$prefix${String.fromCharCode((last + c - from) & 0xFFFF)}';
            }
          } else if (dst is List<Object?>) {
            for (var c = from; c <= to && c - from < dst.length; c++) {
              final d = dst[c - from];
              if (d is PdfString) map[c] = utf16(d);
            }
          }
        }
        mode = '';
      default:
        if (mode.isEmpty) operands.clear();
    }
  }
  return (map: map, codeBytes: codeBytes);
}
