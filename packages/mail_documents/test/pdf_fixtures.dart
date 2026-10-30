import 'dart:convert';
import 'dart:io' show ZLibEncoder;
import 'dart:typed_data';

/// Builds small PDFs for tests: numbered objects, a page tree, one content
/// stream per page (optionally Flate-compressed), a font per document, and
/// a classic cross-reference table and trailer.
final class PdfBuilder {
  final _objects = <String?>[];
  final _binary = <int, List<int>>{};

  /// Reserves the next object number.
  int reserve() {
    _objects.add(null);
    return _objects.length;
  }

  int add(String body) {
    _objects.add(body);
    return _objects.length;
  }

  void set(int number, String body) => _objects[number - 1] = body;

  /// A stream object; [compress] Flate-encodes it.
  int stream(String dict, List<int> data, {bool compress = false}) {
    final bytes = compress ? ZLibEncoder().convert(data) : data;
    final filter = compress ? ' /Filter /FlateDecode' : '';
    final n = add('<< $dict /Length ${bytes.length}$filter >>\nstream\n');
    _binary[n] = bytes;
    return n;
  }

  Uint8List build({String trailerExtra = '', int? root}) {
    final out = BytesBuilder();
    void write(String s) => out.add(latin1.encode(s));
    write('%PDF-1.7\n%\xE2\xE3\xCF\xD3\n');
    final offsets = <int>[];
    for (final (i, body) in _objects.indexed) {
      offsets.add(out.length);
      write('${i + 1} 0 obj\n${body ?? 'null'}');
      final binary = _binary[i + 1];
      if (binary != null) {
        out.add(binary);
        write('\nendstream');
      }
      write('\nendobj\n');
    }
    final xref = out.length;
    write('xref\n0 ${_objects.length + 1}\n0000000000 65535 f \n');
    for (final o in offsets) {
      write('${o.toString().padLeft(10, '0')} 00000 n \n');
    }
    write('trailer\n<< /Size ${_objects.length + 1} /Root ${root ?? 1} 0 R$trailerExtra >>\nstartxref\n$xref\n%%EOF\n');
    return out.takeBytes();
  }
}

/// A document whose pages have [contents] (content stream text, one per
/// page), with Helvetica as /F1 in WinAnsiEncoding unless [font] is given.
Uint8List pdfWithPages(
  List<String> contents, {
  bool compress = false,
  String? font,
  String trailerExtra = '',
  Map<String, String> extraResources = const {},
}) {
  final b = PdfBuilder();
  final catalog = b.reserve();
  final pages = b.reserve();
  final f = b.add(font ?? '<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica /Encoding /WinAnsiEncoding >>');
  final kids = <int>[];
  for (final c in contents) {
    final content = b.stream('', latin1.encode(c), compress: compress);
    final extra = extraResources.entries.map((e) => '/${e.key} ${e.value}').join(' ');
    kids.add(
      b.add(
        '<< /Type /Page /Parent $pages 0 R /Contents $content 0 R /Resources << /Font << /F1 $f 0 R >> $extra >> >>',
      ),
    );
  }
  b
    ..set(catalog, '<< /Type /Catalog /Pages $pages 0 R >>')
    ..set(pages, '<< /Type /Pages /Kids [${kids.map((k) => '$k 0 R').join(' ')}] /Count ${kids.length} >>');
  return b.build(trailerExtra: trailerExtra);
}

/// One line of text, as the demo's PDFs write it.
String line(String text, {int y = 700}) => 'BT /F1 12 Tf 72 $y Td ($text) Tj ET\n';
