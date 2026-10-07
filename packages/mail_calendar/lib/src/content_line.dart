/// Content lines (RFC 5545 §3.1): unfolding and folding, parameters,
/// quoted values and TEXT escapes.
library;

import 'dart:convert';

/// One property of a component: `NAME;PARAM=a,b;OTHER="x:y":value`.
///
/// [name] and parameter names are upper-cased; [value] is kept as written
/// (still escaped for TEXT values, see [text]).
final class Property {
  Property(String name, this.value, {Map<String, List<String>>? params})
    : name = name.toUpperCase(),
      params = {for (final e in (params ?? const {}).entries) e.key.toUpperCase(): List.unmodifiable(e.value)};

  final String name;
  final String value;

  /// Parameters by upper-cased name; values without their quotes.
  final Map<String, List<String>> params;

  /// The first value of parameter [name], or null.
  String? param(String name) {
    final values = params[name.toUpperCase()];
    return values == null || values.isEmpty ? null : values.first;
  }

  /// [value] as TEXT (RFC 5545 §3.3.11): `\n`, `\,`, `\;` and `\\` undone.
  String get text => unescapeText(value);

  /// The same property with [value] or parameters replaced.
  Property copyWith({String? value, Map<String, List<String>>? params}) =>
      Property(name, value ?? this.value, params: params ?? this.params);

  /// The content line, unfolded: `NAME;PARAM=value:value`.
  String toLine() {
    final out = StringBuffer(name);
    for (final MapEntry(:key, value: values) in params.entries) {
      out
        ..write(';')
        ..write(key)
        ..write('=')
        ..write(values.map(_paramValue).join(','));
    }
    out
      ..write(':')
      ..write(_clean(value));
    return out.toString();
  }

  @override
  String toString() => toLine();
}

/// Joins folded lines: a line break followed by a space or a tab continues
/// the line (RFC 5545 §3.1). Bare LF and CR count as line breaks, as many
/// writers send them. A byte-order mark at the start is dropped.
List<String> unfoldLines(String text) {
  var s = text;
  if (s.startsWith('﻿')) s = s.substring(1);
  final lines = <String>[];
  StringBuffer? current;
  for (final raw in s.split(RegExp(r'\r\n|\n|\r'))) {
    if (raw.isNotEmpty && (raw.codeUnitAt(0) == 0x20 || raw.codeUnitAt(0) == 0x09) && current != null) {
      current.write(raw.substring(1));
      continue;
    }
    if (current != null) lines.add(current.toString());
    current = StringBuffer(raw);
  }
  if (current != null) lines.add(current.toString());
  return [
    for (final l in lines)
      if (l.trim().isNotEmpty) l,
  ];
}

/// Parses one unfolded content line; null when it isn't one (no name, or
/// no colon outside quotes).
Property? parseContentLine(String line) {
  final n = line.length;
  var i = 0;
  while (i < n && _isNameChar(line.codeUnitAt(i))) {
    i++;
  }
  if (i == 0 || i >= n) return null;
  final name = line.substring(0, i);
  final params = <String, List<String>>{};
  while (i < n && line[i] == ';') {
    i++;
    final start = i;
    while (i < n && _isNameChar(line.codeUnitAt(i))) {
      i++;
    }
    final paramName = line.substring(start, i).toUpperCase();
    if (i >= n) return null;
    if (line[i] != '=') {
      // A parameter without a value (seen in the wild): skip to the next ; or :.
      while (i < n && line[i] != ';' && line[i] != ':') {
        i++;
      }
      continue;
    }
    i++;
    final values = <String>[];
    while (true) {
      if (i < n && line[i] == '"') {
        final close = line.indexOf('"', i + 1);
        if (close < 0) return null;
        values.add(_decodeParam(line.substring(i + 1, close)));
        i = close + 1;
        // Junk after the closing quote, up to the next delimiter.
        while (i < n && line[i] != ',' && line[i] != ';' && line[i] != ':') {
          i++;
        }
      } else {
        final start = i;
        while (i < n && line[i] != ',' && line[i] != ';' && line[i] != ':') {
          i++;
        }
        values.add(_decodeParam(line.substring(start, i)));
      }
      if (i < n && line[i] == ',') {
        i++;
        continue;
      }
      break;
    }
    if (paramName.isNotEmpty) (params[paramName] ??= []).addAll(values);
  }
  if (i >= n || line[i] != ':') return null;
  return Property(name, line.substring(i + 1), params: params);
}

bool _isNameChar(int c) =>
    (c >= 0x41 && c <= 0x5A) || (c >= 0x61 && c <= 0x7A) || (c >= 0x30 && c <= 0x39) || c == 0x2D || c == 0x5F;

/// RFC 6868 parameter value encoding: `^n` newline, `^^` caret, `^'` quote.
String _decodeParam(String v) {
  if (!v.contains('^')) return v;
  return v.replaceAllMapped(RegExp(r"\^([n^'])"), (m) {
    return switch (m[1]) {
      'n' => '\n',
      "'" => '"',
      _ => '^',
    };
  });
}

String _paramValue(String v) {
  final encoded = v.replaceAll('^', '^^').replaceAll('"', "^'").replaceAll(RegExp(r'\r\n|\n|\r'), '^n');
  final safe = _clean(encoded);
  return RegExp(r'[:;,]').hasMatch(safe) || safe.isEmpty ? '"$safe"' : safe;
}

/// Control characters other than tab aren't allowed in values.
String _clean(String v) => v.replaceAll(RegExp(r'[\x00-\x08\x0A-\x1F\x7F]'), ' ');

/// Undoes TEXT escapes: `\n` and `\N` are line breaks, `\,`, `\;` and `\\`
/// themselves. A backslash before anything else stays (lenient).
String unescapeText(String value) {
  if (!value.contains(r'\')) return value;
  final out = StringBuffer();
  for (var i = 0; i < value.length; i++) {
    final c = value[i];
    if (c == r'\' && i + 1 < value.length) {
      final next = value[i + 1];
      switch (next) {
        case 'n' || 'N':
          out.write('\n');
          i++;
          continue;
        case ',' || ';' || r'\':
          out.write(next);
          i++;
          continue;
      }
    }
    out.write(c);
  }
  return out.toString();
}

/// Escapes TEXT: backslash, semicolon, comma and line breaks.
String escapeText(String value) => value
    .replaceAll(r'\', r'\\')
    .replaceAll(';', r'\;')
    .replaceAll(',', r'\,')
    .replaceAll(RegExp(r'\r\n|\n|\r'), r'\n');

/// Folds [line] into lines of at most 75 octets (RFC 5545 §3.1), each
/// continuation starting with a space, never splitting a UTF-8 sequence
/// (or a surrogate pair). Returns them joined with CRLF, without a final one.
String foldLine(String line) {
  const limit = 75;
  if (line.length <= limit ~/ 4 || utf8.encode(line).length <= limit) return line;
  final out = StringBuffer();
  var octets = 0;
  final runes = line.runes.toList();
  for (final r in runes) {
    final size = r < 0x80
        ? 1
        : r < 0x800
        ? 2
        : r < 0x10000
        ? 3
        : 4;
    if (octets + size > limit) {
      out.write('\r\n ');
      octets = 1;
    }
    out.writeCharCode(r);
    octets += size;
  }
  return out.toString();
}
