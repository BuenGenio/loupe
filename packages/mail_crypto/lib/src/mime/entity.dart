/// A small MIME parser that keeps every part's exact bytes, as RFC 3156
/// signature checks need them.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'codecs.dart';

/// One MIME entity: its header fields, its raw bytes and, for multiparts,
/// its children.
final class MimeEntity {
  MimeEntity._(this.raw, this.headers, this.body, this.parts);

  /// Deeper nesting than this is treated as a leaf (hostile input).
  static const maxDepth = 24;

  /// At most this many parts in one message.
  static const maxParts = 1000;

  /// Parses [bytes] (a whole message or a body part). Never throws: broken
  /// input gives a leaf entity.
  factory MimeEntity.parse(Uint8List bytes) => _parse(bytes, 0, _Budget());

  /// The entity exactly as given: header block, blank line and body.
  final Uint8List raw;

  /// Header fields in order, unfolded; values are not decoded (see [header]).
  final List<(String, String)> headers;

  /// The body, still transfer-encoded.
  final Uint8List body;

  /// Children of a multipart; empty otherwise.
  final List<MimeEntity> parts;

  /// The first value of header [name] (case-insensitive), RFC 2047 decoded.
  String? header(String name) {
    final raw = rawHeader(name);
    return raw == null ? null : decodeEncodedWords(raw);
  }

  /// The first value of header [name], undecoded.
  String? rawHeader(String name) {
    final n = name.toLowerCase();
    for (final (k, v) in headers) {
      if (k.toLowerCase() == n) return v.trim();
    }
    return null;
  }

  /// Every value of header [name], undecoded.
  List<String> rawHeaders(String name) {
    final n = name.toLowerCase();
    return [
      for (final (k, v) in headers)
        if (k.toLowerCase() == n) v.trim(),
    ];
  }

  /// Content-Type; `text/plain` when missing (RFC 2045).
  late final HeaderValue contentType = () {
    final ct = HeaderValue.parse(rawHeader('content-type'));
    return ct.value.contains('/') ? ct : HeaderValue('text/plain', ct.params);
  }();

  late final HeaderValue disposition = HeaderValue.parse(rawHeader('content-disposition'));

  String get mimeType => contentType.value;
  bool get isMultipart => mimeType.startsWith('multipart/');
  String? get charset => contentType['charset'];
  String? get transferEncoding => rawHeader('content-transfer-encoding')?.toLowerCase();

  /// The file name: Content-Disposition `filename`, else Content-Type `name`.
  String? get filename {
    final n = disposition['filename'] ?? contentType['name'];
    return n == null || n.trim().isEmpty ? null : decodeEncodedWords(n.trim());
  }

  /// Content-ID without angle brackets.
  String? get contentId {
    final id = rawHeader('content-id');
    if (id == null) return null;
    final s = id.replaceAll(RegExp(r'^\s*<|>\s*$'), '').trim();
    return s.isEmpty ? null : s;
  }

  /// The body with its transfer encoding undone.
  Uint8List get decodedBody => decodeTransfer(body, transferEncoding);

  /// The body as text in its charset.
  String get text => decodeCharset(decodedBody, charset);

  /// The child at a section path like `2.1` (IMAP numbering: a leaf root
  /// is section `1`).
  MimeEntity? find(String section) {
    var node = this;
    final steps = section.split('.');
    for (final (i, s) in steps.indexed) {
      final n = int.tryParse(s);
      if (n == null || n < 1) return null;
      if (!node.isMultipart) return i == 0 && n == 1 && steps.length == 1 ? node : null;
      if (n > node.parts.length) return null;
      node = node.parts[n - 1];
    }
    return node;
  }
}

final class _Budget {
  int parts = 0;
}

MimeEntity _parse(Uint8List bytes, int depth, _Budget budget) {
  budget.parts++;
  final split = _headerEnd(bytes);
  final headers = _parseHeaders(Uint8List.sublistView(bytes, 0, split.headerEnd));
  final body = Uint8List.sublistView(bytes, split.bodyStart);
  final entity = MimeEntity._(bytes, headers, body, const []);
  if (!entity.isMultipart || depth >= MimeEntity.maxDepth || budget.parts > MimeEntity.maxParts) return entity;
  final boundary = entity.contentType['boundary'];
  if (boundary == null || boundary.isEmpty) return entity;
  final children = [for (final p in splitMultipart(body, boundary)) _parse(p, depth + 1, budget)];
  return MimeEntity._(bytes, headers, body, children);
}

/// Where the header block ends and the body starts. Without a blank line
/// the whole entity is headers; an entity starting with a line end has none.
({int headerEnd, int bodyStart}) _headerEnd(Uint8List b) {
  if (b.isNotEmpty && b[0] == 0x0a) return (headerEnd: 0, bodyStart: 1);
  if (b.length > 1 && b[0] == 0x0d && b[1] == 0x0a) return (headerEnd: 0, bodyStart: 2);
  for (var i = 0; i < b.length; i++) {
    if (b[i] != 0x0a) continue;
    // LF LF, or LF CR LF.
    if (i + 1 < b.length && b[i + 1] == 0x0a) return (headerEnd: i + 1, bodyStart: i + 2);
    if (i + 2 < b.length && b[i + 1] == 0x0d && b[i + 2] == 0x0a) return (headerEnd: i + 1, bodyStart: i + 3);
  }
  return (headerEnd: b.length, bodyStart: b.length);
}

List<(String, String)> _parseHeaders(Uint8List block) {
  String text;
  try {
    text = utf8.decode(block);
  } on FormatException {
    text = latin1.decode(block);
  }
  final out = <(String, String)>[];
  for (final line in text.split('\n')) {
    final l = line.endsWith('\r') ? line.substring(0, line.length - 1) : line;
    if (l.isEmpty) continue;
    if ((l.startsWith(' ') || l.startsWith('\t')) && out.isNotEmpty) {
      final (k, v) = out.removeLast();
      out.add((k, '$v ${l.trim()}'));
      continue;
    }
    final colon = l.indexOf(':');
    if (colon <= 0) continue;
    out.add((l.substring(0, colon).trim(), l.substring(colon + 1).trim()));
  }
  return out;
}

/// The parts of a multipart body, each exactly as between its delimiter
/// lines (the line end before a delimiter belongs to the delimiter).
List<Uint8List> splitMultipart(Uint8List body, String boundary) {
  final delimiter = ascii.encode('--$boundary');
  final parts = <Uint8List>[];
  int? start;
  var lineStart = 0;
  while (lineStart <= body.length) {
    var lineEnd = lineStart;
    while (lineEnd < body.length && body[lineEnd] != 0x0a) {
      lineEnd++;
    }
    if (_startsWith(body, lineStart, delimiter)) {
      var rest = lineStart + delimiter.length;
      final closing = rest + 1 < body.length && body[rest] == 0x2d && body[rest + 1] == 0x2d;
      if (closing) rest += 2;
      var onlySpace = true;
      for (var i = rest; i < lineEnd; i++) {
        if (body[i] != 0x20 && body[i] != 0x09 && body[i] != 0x0d) onlySpace = false;
      }
      if (onlySpace) {
        if (start != null) {
          // Drop the line end before the delimiter: CRLF or LF.
          var end = lineStart;
          if (end > start && body[end - 1] == 0x0a) end--;
          if (end > start && body[end - 1] == 0x0d) end--;
          parts.add(Uint8List.sublistView(body, start, end < start ? start : end));
        }
        if (closing) return parts;
        start = lineEnd + 1 > body.length ? body.length : lineEnd + 1;
      }
    }
    if (lineEnd >= body.length) break;
    lineStart = lineEnd + 1;
  }
  // No closing delimiter: keep what the last part has.
  if (start != null && start < body.length) parts.add(Uint8List.sublistView(body, start));
  return parts;
}

bool _startsWith(Uint8List b, int at, List<int> prefix) {
  if (at + prefix.length > b.length) return false;
  for (var i = 0; i < prefix.length; i++) {
    if (b[at + i] != prefix[i]) return false;
  }
  return true;
}
