import 'dart:typed_data';

import '../budget.dart';
import '../document.dart';
import 'filters.dart';
import 'fonts.dart';
import 'pdf_file.dart';
import 'syntax.dart';

/// The pages of a PDF in reading order, from the page tree (with inherited
/// resources), or every page object when the tree is broken.
List<Map<String, Object?>> pdfPages(PdfFile file) {
  final pages = <Map<String, Object?>>[];
  final seen = <Map<String, Object?>>{};
  void walk(Map<String, Object?> node, Object? resources, int depth) {
    if (depth > 32 || !seen.add(node) || pages.length > 100000) return;
    final own = node['Resources'] ?? resources;
    final kids = file.resolve(node['Kids']);
    if (kids is List<Object?> && node['Type'] != const PdfName('Page')) {
      for (final kid in kids) {
        final d = file.dict(kid);
        if (d != null) walk(d, own, depth + 1);
      }
    } else if (node['Type'] == const PdfName('Page') || node.containsKey('Contents')) {
      pages.add({...node, 'Resources': own});
    }
  }

  final root = file.dict(file.catalog?['Pages']);
  if (root != null) walk(root, null, 0);
  return pages.isNotEmpty ? pages : file.loosePages;
}

/// Reads one page's text. Throws [UnsupportedFilter] when its content can't
/// be decoded, [LimitReached] when the budget runs out.
String pdfPageText(PdfFile file, Map<String, Object?> page) {
  final contents = file.resolve(page['Contents']);
  final streams = switch (contents) {
    final PdfStream s => [s],
    final List<Object?> l => [
      for (final c in l)
        if (file.resolve(c) case final PdfStream s) s,
    ],
    _ => const <PdfStream>[],
  };
  final parts = [for (final s in streams) file.decode(s)];
  // Operators may be split across a page's streams: they are one stream.
  final joined = BytesBuilder(copy: false);
  for (final p in parts) {
    joined
      ..add(p)
      ..addByte(0x0A);
  }
  final out = _TextOut();
  _Interpreter(file, out).run(joined.takeBytes(), file.dict(page['Resources']), 0);
  return out.text();
}

/// Collects shown text, breaking lines where the text moves to another line
/// and putting a space where it jumps along the same one.
final class _TextOut {
  final _buffer = StringBuffer();
  double? _lastY;
  var _moved = false;
  var _lastChar = 0x0A;

  void move() => _moved = true;

  void newLine() {
    if (_buffer.isNotEmpty && _lastChar != 0x0A) _write('\n');
    _moved = false;
  }

  void space() {
    if (_buffer.isNotEmpty && _lastChar != 0x20 && _lastChar != 0x0A) _write(' ');
  }

  void show(String text, double y, double size) {
    if (text.isEmpty) return;
    final last = _lastY;
    if (last != null && (y - last).abs() > (size.abs() * 0.5).clamp(1.0, 1000.0)) {
      newLine();
    } else if (_moved) {
      space();
    }
    _moved = false;
    _lastY = y;
    _write(text);
  }

  void _write(String s) {
    _buffer.write(s);
    _lastChar = s.codeUnitAt(s.length - 1);
  }

  /// The text with control characters dropped, spaces collapsed and each
  /// line trimmed.
  String text() {
    final cleaned = _buffer.toString().replaceAll(RegExp(r'[\x00-\x09\x0B-\x1F\x7F]'), ' ');
    return cleaned
        .split('\n')
        .map((l) => l.replaceAll(RegExp(r' {2,}'), ' ').trim())
        .where((l) => l.isNotEmpty)
        .join('\n');
  }
}

final class _Interpreter {
  _Interpreter(this.file, this.out);

  final PdfFile file;
  final _TextOut out;
  Budget get budget => file.budget;

  // The text matrix and line matrix ([a b c d e f]), the leading, the font.
  var _tm = const [1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
  var _tlm = const [1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
  var _leading = 0.0;
  var _fontSize = 12.0;
  PdfFont _font = PdfFont.fallback();

  double get _y => _tm[5];
  double get _size => _fontSize * (_tm[3] == 0 ? 1 : _tm[3]);

  static double _n(Object? v) => v is num ? v.toDouble() : 0;

  void _translate(double tx, double ty) {
    final m = _tlm;
    _tlm = [m[0], m[1], m[2], m[3], tx * m[0] + ty * m[2] + m[4], tx * m[1] + ty * m[3] + m[5]];
    _tm = _tlm;
    out.move();
  }

  void _nextLine() {
    _translate(0, -_leading);
    out.newLine();
  }

  void _show(Object? s) {
    if (s is! PdfString) return;
    final text = _font.decode(s.bytes);
    budget.characters(text.length);
    out.show(text, _y, _size);
  }

  void run(Uint8List content, Map<String, Object?>? resources, int depth) {
    final lexer = PdfLexer(content, references: false);
    final operands = <Object?>[];
    while (true) {
      final token = lexer.next();
      if (token is PdfEnd) return;
      if (token is! PdfKeyword) {
        // Operators take a few operands; a run of hundreds is junk.
        if (operands.length < 64) operands.add(token);
        continue;
      }
      budget.operator();
      final op = token.value;
      switch (op) {
        case 'BT':
          _tm = _tlm = const [1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
          out.move();
        case 'Tf' when operands.length >= 2:
          _font = _fontNamed(operands[operands.length - 2], resources);
          _fontSize = _n(operands.last);
        case 'Td' when operands.length >= 2:
          _translate(_n(operands[operands.length - 2]), _n(operands.last));
        case 'TD' when operands.length >= 2:
          _leading = -_n(operands.last);
          _translate(_n(operands[operands.length - 2]), _n(operands.last));
        case 'TL' when operands.isNotEmpty:
          _leading = _n(operands.last);
        case 'Tm' when operands.length >= 6:
          final m = [for (final v in operands.sublist(operands.length - 6)) _n(v)];
          final sameLine = (m[5] - _y).abs() < 0.01;
          _tm = _tlm = m;
          if (sameLine) out.move();
        case 'T*':
          _nextLine();
        case 'Tj' when operands.isNotEmpty:
          _show(operands.last);
        case "'" when operands.isNotEmpty:
          _nextLine();
          _show(operands.last);
        case '"' when operands.isNotEmpty:
          _nextLine();
          _show(operands.last);
        case 'TJ' when operands.isNotEmpty && operands.last is List<Object?>:
          for (final item in operands.last! as List<Object?>) {
            if (item is PdfString) {
              _show(item);
            } else if (item is num && item < -180) {
              // A gap of about a fifth of an em or more is a word space.
              out.space();
            }
          }
        case 'Do' when operands.isNotEmpty && depth < 4:
          _form(operands.last, resources, depth);
        case 'ID':
          _skipInlineImage(lexer);
      }
      operands.clear();
    }
  }

  PdfFont _fontNamed(Object? name, Map<String, Object?>? resources) {
    if (name is! PdfName) return PdfFont.fallback();
    final fonts = file.dict(resources?['Font']);
    final ref = fonts?[name.value];
    final key = ref is PdfRef ? ref.number : (ref ?? name.value);
    final cached = file.fonts[key];
    if (cached != null) return cached;
    final dict = file.dict(ref);
    final font = dict == null ? PdfFont.fallback() : PdfFont.read(dict, file.resolve, budget);
    return file.fonts[key] = font;
  }

  /// A form XObject is content of its own, with its own resources.
  void _form(Object? name, Map<String, Object?>? resources, int depth) {
    if (name is! PdfName) return;
    final xobjects = file.dict(resources?['XObject']);
    final stream = file.resolve(xobjects?[name.value]);
    if (stream is! PdfStream || stream.dict['Subtype'] != const PdfName('Form')) return;
    final Uint8List body;
    try {
      body = file.decode(stream);
    } on UnsupportedFilter {
      return;
    }
    final (tm, tlm, font, size) = (_tm, _tlm, _font, _fontSize);
    run(body, file.dict(stream.dict['Resources']) ?? resources, depth + 1);
    _tm = tm;
    _tlm = tlm;
    _font = font;
    _fontSize = size;
  }

  /// Inline image data is binary: skip to `EI` after whitespace.
  static void _skipInlineImage(PdfLexer lexer) {
    final data = lexer.data;
    var p = lexer.pos + 1;
    while (p + 1 < lexer.end) {
      if (data[p] == 0x45 &&
          data[p + 1] == 0x49 &&
          isPdfSpace(data[p - 1]) &&
          (p + 2 >= lexer.end || _gap(data[p + 2]))) {
        lexer.pos = p + 2;
        return;
      }
      p++;
    }
    lexer.pos = lexer.end;
  }

  static bool _gap(int c) => isPdfSpace(c) || isPdfDelimiter(c);
}

/// Reads a PDF's pages within [budget]: the status, the pages read, and the
/// page count. Encrypted files stop at once.
({ExtractionStatus status, List<DocumentPage> pages, int? pageCount, ExtractionLimit? limit}) readPdf(
  Uint8List bytes,
  Budget budget,
) {
  final PdfFile file;
  try {
    file = PdfFile.parse(bytes, budget, maxObjects: budget.limits.maxObjects);
  } on Malformed {
    return (status: ExtractionStatus.damaged, pages: const [], pageCount: null, limit: null);
  } on LimitReached catch (e) {
    return (status: ExtractionStatus.partial, pages: const [], pageCount: null, limit: e.limit);
  }
  if (file.encrypted) return (status: ExtractionStatus.encrypted, pages: const [], pageCount: null, limit: null);
  final List<Map<String, Object?>> tree;
  try {
    tree = pdfPages(file);
  } on Malformed {
    return (status: ExtractionStatus.damaged, pages: const [], pageCount: null, limit: null);
  }
  if (tree.isEmpty) return (status: ExtractionStatus.damaged, pages: const [], pageCount: 0, limit: null);
  final pages = <DocumentPage>[];
  ExtractionLimit? limit;
  for (final (i, page) in tree.indexed) {
    if (i >= budget.limits.maxPages) {
      limit = ExtractionLimit.pages;
      break;
    }
    try {
      budget.checkTime();
      pages.add(DocumentPage(i + 1, pdfPageText(file, page)));
    } on LimitReached catch (e) {
      limit = e.limit;
      break;
    } on UnsupportedFilter {
      pages.add(DocumentPage(i + 1, '', readable: false));
    } on Malformed {
      pages.add(DocumentPage(i + 1, '', readable: false));
    }
  }
  final unreadable = pages.any((p) => !p.readable);
  final hasText = pages.any((p) => p.text.isNotEmpty);
  final status = limit != null || (unreadable && hasText)
      ? ExtractionStatus.partial
      : unreadable
      ? ExtractionStatus.damaged
      : hasText
      ? ExtractionStatus.complete
      : ExtractionStatus.noText;
  return (status: status, pages: pages, pageCount: tree.length, limit: limit);
}
