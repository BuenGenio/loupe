/// Header block parsing.
library;

import 'charsets.dart';
import 'encoded_words.dart';

/// Splits a raw header block into (name, value) pairs in order. Values are
/// unfolded; with [decode], RFC 2047 words are decoded. Stops at the first
/// empty line.
List<(String, String)> parseHeaderBlock(List<int> raw, {bool decode = true}) {
  final text = decodeCharset(raw, 'utf-8');
  final result = <(String, String)>[];
  String? name;
  final value = StringBuffer();
  void flush() {
    final n = name;
    if (n == null) return;
    final v = value.toString().trim();
    result.add((n, decode ? decodeEncodedWords(v) : v));
    name = null;
    value.clear();
  }

  for (final line in text.split(RegExp(r'\r?\n'))) {
    if (line.isEmpty) {
      if (name != null || result.isNotEmpty) break;
      continue;
    }
    if (line.startsWith(' ') || line.startsWith('\t')) {
      if (name != null) value.write(' ${line.trim()}');
      continue;
    }
    flush();
    final colon = line.indexOf(':');
    if (colon <= 0) continue;
    name = line.substring(0, colon).trim();
    value.write(line.substring(colon + 1));
  }
  flush();
  return result;
}

/// The first value of header [name] (case-insensitive), or null.
String? headerValue(List<(String, String)> headers, String name) {
  final lower = name.toLowerCase();
  for (final (n, v) in headers) {
    if (n.toLowerCase() == lower) return v;
  }
  return null;
}

final _msgId = RegExp(r'<([^<>\s]+)>');

/// Message ids in a References / In-Reply-To value, without angle brackets.
/// Falls back to whitespace-separated tokens when there are no brackets.
List<String> parseMessageIds(String? value) {
  if (value == null || value.trim().isEmpty) return const [];
  final ids = [for (final m in _msgId.allMatches(value)) m[1]!];
  if (ids.isNotEmpty) return ids;
  return value.split(RegExp(r'[\s,]+')).where((s) => s.contains('@')).toList();
}

/// A single message id without angle brackets, or null.
String? stripMessageId(String? value) {
  if (value == null) return null;
  final ids = parseMessageIds(value);
  if (ids.isNotEmpty) return ids.first;
  final t = value.trim();
  return t.isEmpty ? null : t;
}
