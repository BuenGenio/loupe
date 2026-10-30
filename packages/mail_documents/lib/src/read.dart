import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

import 'budget.dart';
import 'document.dart';
import 'pdf/encodings.dart';
import 'pdf/pdf_text.dart';

/// Hex SHA-256 of [bytes]: a document's identity, whatever its name.
String contentHash(List<int> bytes) => sha256.convert(bytes).toString();

/// The format of a file the extractor can read, from its MIME type, its
/// name and its first bytes; null for anything else. A PDF sent as
/// `application/octet-stream` counts, a Word document doesn't.
DocumentFormat? documentFormatOf(String mimeType, String? fileName, [List<int>? head]) {
  final mime = mimeType.split(';').first.trim().toLowerCase();
  final name = (fileName ?? '').toLowerCase();
  final ext = name.contains('.') ? name.substring(name.lastIndexOf('.') + 1) : '';
  if (mime == 'application/pdf' || mime == 'application/x-pdf' || ext == 'pdf') return DocumentFormat.pdf;
  if (head != null && head.length >= 5 && String.fromCharCodes(head.take(5)) == '%PDF-') return DocumentFormat.pdf;
  if (mime == 'text/csv' || mime == 'text/comma-separated-values' || ext == 'csv' || ext == 'tsv') {
    return DocumentFormat.csv;
  }
  if (mime == 'text/plain' || ext == 'txt' || ext == 'text' || ext == 'md' || ext == 'log') return DocumentFormat.text;
  return null;
}

/// Reads a downloaded attachment's text, bounded by [limits]: a PDF page by
/// page, a text or CSV file as one page. Never throws: hostile, damaged,
/// encrypted or huge input comes back as a status. Pure work with no I/O,
/// so it can run in another isolate.
ExtractedDocument readDocument(
  Uint8List bytes, {
  required String mimeType,
  String? fileName,
  ExtractionLimits limits = const ExtractionLimits(),
  String? hash,
}) {
  final id = hash ?? contentHash(bytes);
  final format = documentFormatOf(mimeType, fileName, bytes.length >= 5 ? bytes.sublist(0, 5) : null);
  ExtractedDocument result(
    ExtractionStatus status, {
    List<DocumentPage> pages = const [],
    int? pageCount,
    ExtractionLimit? limit,
  }) => ExtractedDocument(
    contentHash: id,
    byteLength: bytes.length,
    format: format,
    status: status,
    pages: pages,
    pageCount: pageCount,
    limit: limit,
  );
  if (format == null) return result(ExtractionStatus.unsupported);
  if (bytes.length > limits.maxBytes) return result(ExtractionStatus.tooLarge);
  final budget = Budget(limits);
  try {
    switch (format) {
      case DocumentFormat.pdf:
        final read = readPdf(bytes, budget);
        return result(read.status, pages: read.pages, pageCount: read.pageCount, limit: read.limit);
      case DocumentFormat.text || DocumentFormat.csv:
        final text = decodeText(bytes).replaceAll('\r\n', '\n').replaceAll('\r', '\n');
        final cut = text.length > limits.maxCharacters;
        final kept = cut ? text.substring(0, limits.maxCharacters) : text;
        final page = DocumentPage(1, kept.replaceAll(RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F]'), ' ').trimRight());
        if (page.text.trim().isEmpty) return result(ExtractionStatus.noText, pages: [page], pageCount: 1);
        return cut
            ? result(ExtractionStatus.partial, pages: [page], pageCount: 1, limit: ExtractionLimit.characters)
            : result(ExtractionStatus.complete, pages: [page], pageCount: 1);
    }
  } on LimitReached catch (e) {
    return result(ExtractionStatus.partial, limit: e.limit);
  } on Object {
    // A bug or input nobody anticipated: say it couldn't be read, never crash.
    return result(ExtractionStatus.damaged);
  }
}

/// Decodes a text file: a byte-order mark wins, then UTF-8 when the bytes
/// are valid UTF-8, else Windows-1252 (what files called Latin-1 nearly
/// always are).
String decodeText(Uint8List bytes) {
  if (bytes.length >= 3 && bytes[0] == 0xEF && bytes[1] == 0xBB && bytes[2] == 0xBF) {
    return utf8.decode(bytes.sublist(3), allowMalformed: true);
  }
  if (bytes.length >= 2 && ((bytes[0] == 0xFF && bytes[1] == 0xFE) || (bytes[0] == 0xFE && bytes[1] == 0xFF))) {
    final big = bytes[0] == 0xFE;
    final units = Uint16List((bytes.length - 2) ~/ 2);
    for (var i = 0; i < units.length; i++) {
      final a = bytes[2 + 2 * i], b = bytes[3 + 2 * i];
      units[i] = big ? (a << 8) | b : (b << 8) | a;
    }
    return String.fromCharCodes(units);
  }
  try {
    return utf8.decode(bytes);
  } on FormatException {
    return String.fromCharCodes(bytes.map(_cp1252));
  }
}

int _cp1252(int b) => b >= 0x80 && b < 0xA0 && cp1252High[b - 0x80] != 0 ? cp1252High[b - 0x80] : b;
