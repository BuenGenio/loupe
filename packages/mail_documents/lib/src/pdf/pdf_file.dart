import 'dart:typed_data';

import '../budget.dart';
import 'filters.dart';
import 'fonts.dart';
import 'syntax.dart';

const _obj = [0x6F, 0x62, 0x6A]; // obj
const _stream = [0x73, 0x74, 0x72, 0x65, 0x61, 0x6D]; // stream
const _endstream = [0x65, 0x6E, 0x64, 0x73, 0x74, 0x72, 0x65, 0x61, 0x6D]; // endstream
const _trailer = [0x74, 0x72, 0x61, 0x69, 0x6C, 0x65, 0x72]; // trailer

/// A PDF's objects, found by scanning the file rather than trusting its
/// cross-reference table, which is often wrong in mail attachments (edited,
/// cut short, appended to). A later definition of an object replaces an
/// earlier one, as incremental updates intend. Objects inside object streams
/// (PDF 1.5) fill in numbers no plain object defines.
final class PdfFile {
  PdfFile._(this.data, this.budget);

  /// Scans [data]. Throws [Malformed] when it isn't a PDF at all, and
  /// [LimitReached] when the budget runs out while scanning.
  factory PdfFile.parse(Uint8List data, Budget budget, {required int maxObjects}) {
    final file = PdfFile._(data, budget);
    if (indexOfBytes(data, const [0x25, 0x50, 0x44, 0x46, 0x2D], 0, data.length < 1024 ? data.length : 1024) < 0) {
      throw const Malformed('no %PDF- header');
    }
    file._scan(maxObjects);
    file._readTrailer();
    file._expandObjectStreams(maxObjects);
    return file;
  }

  final Uint8List data;
  final Budget budget;
  final _objects = <int, Object?>{};
  final Map<String, Object?> trailer = {};

  /// Fonts read so far, by object number (or name for direct ones): pages
  /// share them, and a ToUnicode map is parsed once.
  final fonts = <Object, PdfFont>{};

  bool get encrypted => trailer['Encrypt'] != null;

  /// Follows references, at most a few deep (a reference to a reference is
  /// legal, a loop is not).
  Object? resolve(Object? value) {
    var v = value;
    for (var i = 0; i < 8 && v is PdfRef; i++) {
      v = _objects[v.number];
    }
    return v is PdfRef ? null : v;
  }

  Map<String, Object?>? dict(Object? value) => switch (resolve(value)) {
    final Map<String, Object?> d => d,
    final PdfStream s => s.dict,
    _ => null,
  };

  /// The document catalog: the trailer's `/Root`, or the last object typed
  /// `/Catalog` when the trailer is missing.
  Map<String, Object?>? get catalog {
    final root = dict(trailer['Root']);
    if (root != null) return root;
    Map<String, Object?>? found;
    for (final o in _objects.values) {
      if (o is Map<String, Object?> && o['Type'] == const PdfName('Catalog')) found = o;
    }
    return found;
  }

  /// Every object that is a page, in object-number order: the fallback when
  /// the page tree is broken.
  List<Map<String, Object?>> get loosePages {
    final numbers = _objects.keys.toList()..sort();
    return [
      for (final n in numbers)
        if (_objects[n] case final Map<String, Object?> d when d['Type'] == const PdfName('Page')) d,
    ];
  }

  Uint8List decode(PdfStream stream) => decodeStream(stream, resolve, budget);

  void _scan(int maxObjects) {
    var i = 0;
    while (true) {
      final at = indexOfBytes(data, _obj, i);
      if (at < 0) return;
      i = at + 3;
      if (i < data.length && !isPdfSpace(data[i]) && !isPdfDelimiter(data[i])) continue;
      final number = _objectNumberBefore(at);
      if (number == null) continue;
      if (_objects.length >= maxObjects) throw const Malformed('too many objects');
      budget.checkTime();
      final lexer = PdfLexer(data, pos: i);
      Object? value;
      try {
        value = lexer.next();
      } on Malformed {
        continue;
      }
      if (value is PdfEnd || value is PdfKeyword) continue;
      if (value is Map<String, Object?>) {
        final save = lexer.pos;
        lexer.skipSpace();
        if (_startsWith(lexer.pos, _stream)) {
          final stream = _streamAt(value, lexer.pos + _stream.length);
          if (stream != null) {
            _objects[number] = stream.$1;
            i = stream.$2;
            continue;
          }
        }
        lexer.pos = save;
      }
      _objects[number] = value;
      i = lexer.pos;
    }
  }

  /// The object number in `12 0 obj`, reading back from `obj` at [at].
  int? _objectNumberBefore(int at) {
    var p = at - 1;
    int? readBack() {
      while (p >= 0 && isPdfSpace(data[p])) {
        p--;
      }
      final end = p;
      while (p >= 0 && data[p] >= 0x30 && data[p] <= 0x39) {
        p--;
      }
      if (p == end || end - p > 10) return null;
      return int.parse(String.fromCharCodes(data, p + 1, end + 1));
    }

    final generation = readBack();
    if (generation == null) return null;
    final number = readBack();
    if (number == null) return null;
    if (p >= 0 && !isPdfSpace(data[p]) && !isPdfDelimiter(data[p])) return null;
    return number;
  }

  bool _startsWith(int at, List<int> word) {
    if (at + word.length > data.length) return false;
    for (var k = 0; k < word.length; k++) {
      if (data[at + k] != word[k]) return false;
    }
    return true;
  }

  /// The stream whose data starts after the `stream` keyword at [start], and
  /// where scanning resumes. `/Length` is used when it is direct and lands on
  /// `endstream`; otherwise the data runs to the next `endstream`.
  (PdfStream, int)? _streamAt(Map<String, Object?> dict, int start) {
    var s = start;
    if (s < data.length && data[s] == 0x0D) s++;
    if (s < data.length && data[s] == 0x0A) s++;
    final length = dict['Length'];
    if (length is int && length >= 0 && s + length <= data.length) {
      var e = s + length;
      while (e < data.length && isPdfSpace(data[e])) {
        e++;
      }
      if (_startsWith(e, _endstream)) {
        return (PdfStream(dict, Uint8List.sublistView(data, s, s + length)), e + _endstream.length);
      }
    }
    final end = indexOfBytes(data, _endstream, s);
    final stop = end < 0 ? data.length : end;
    var e = stop;
    if (e > s && data[e - 1] == 0x0A) e--;
    if (e > s && data[e - 1] == 0x0D) e--;
    return (PdfStream(dict, Uint8List.sublistView(data, s, e)), end < 0 ? data.length : end + _endstream.length);
  }

  /// The trailer: classic `trailer` dictionaries and cross-reference
  /// streams' dictionaries, earliest first so the latest wins.
  void _readTrailer() {
    final numbers = _objects.keys.toList()..sort();
    for (final n in numbers) {
      if (_objects[n] case PdfStream(:final dict) when dict['Type'] == const PdfName('XRef')) {
        trailer.addAll(dict);
      }
    }
    final dicts = <Map<String, Object?>>[];
    var at = data.length;
    while (dicts.length < 32) {
      at = lastIndexOfBytes(data, _trailer, at);
      if (at < 0) break;
      try {
        final d = PdfLexer(data, pos: at + _trailer.length).next();
        if (d is Map<String, Object?>) dicts.add(d);
      } on Malformed {
        // Skip it.
      }
    }
    for (final d in dicts.reversed) {
      trailer.addAll(d);
    }
  }

  void _expandObjectStreams(int maxObjects) {
    final streams = [
      for (final o in _objects.values)
        if (o is PdfStream && o.dict['Type'] == const PdfName('ObjStm')) o,
    ];
    for (final s in streams) {
      final n = resolve(s.dict['N']), first = resolve(s.dict['First']);
      if (n is! int || first is! int || n < 0 || first < 0) continue;
      final Uint8List body;
      try {
        body = decode(s);
      } on UnsupportedFilter {
        continue;
      }
      final header = PdfLexer(body, end: first < body.length ? first : body.length, references: false);
      final entries = <(int, int)>[];
      for (var k = 0; k < n && k < 100000; k++) {
        final number = header.next(), offset = header.next();
        if (number is! int || offset is! int) break;
        entries.add((number, offset));
      }
      for (final (number, offset) in entries) {
        if (_objects.containsKey(number)) continue;
        if (_objects.length >= maxObjects) throw const Malformed('too many objects');
        final at = first + offset;
        if (at < 0 || at >= body.length) continue;
        try {
          final value = PdfLexer(body, pos: at).next();
          if (value is! PdfEnd && value is! PdfKeyword) _objects[number] = value;
        } on Malformed {
          continue;
        }
      }
    }
  }
}
