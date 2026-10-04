import 'package:flutter/foundation.dart';

import '../conversation/raw_source_screen.dart' show SourceLines;
import 'attachment_type.dart';
import 'csv.dart';
import 'eml.dart';
import 'ics.dart';
import 'text_decoding.dart';

/// A text-like attachment (text, CSV, calendar, message), decoded and split
/// into rows for the monospace viewer, plus what its kind adds.
final class PreparedText {
  const PreparedText({
    required this.charset,
    required this.lines,
    required this.cut,
    this.table,
    this.events = const [],
    this.message,
  });

  /// "UTF-8", "UTF-16" or "Latin-1".
  final String charset;
  final SourceLines lines;

  /// Only the first [PreparedText.displayLimit] bytes are shown.
  final bool cut;

  /// CSV small enough for the table view.
  final CsvData? table;

  /// Calendar events.
  final List<IcsEvent> events;

  /// The parsed message (null if it couldn't be parsed: the source still shows).
  final EmlMessage? message;

  /// Longer files are cut for display; Copy and the actions use everything.
  static const displayLimit = 8 * 1024 * 1024;
}

/// Decodes and splits [bytes] for [kind]. Runs in a background isolate for
/// large files (see [prepareTextAsync]).
PreparedText prepareText(AttachmentKind kind, Uint8List bytes) {
  final head = headOfText(bytes, PreparedText.displayLimit);
  final decoded = decodeAttachmentText(head);
  final cut = head.length < bytes.length;
  CsvData? table;
  if (kind == AttachmentKind.csv && !cut) {
    final csv = parseCsv(decoded.text, maxRows: CsvData.maxTableRows + 1);
    if (csv.fitsTable) table = csv;
  }
  EmlMessage? message;
  if (kind == AttachmentKind.email) {
    try {
      message = parseEml(bytes);
    } on FormatException {
      message = null;
    }
  }
  return PreparedText(
    charset: decoded.charset,
    lines: SourceLines.parse(decoded.text),
    cut: cut,
    table: table,
    events: kind == AttachmentKind.calendar ? parseIcsEvents(decoded.text) : const [],
    message: message,
  );
}

PreparedText _prepare((AttachmentKind, Uint8List) args) => prepareText(args.$1, args.$2);

/// [prepareText], in a background isolate when the file is over 256 KB.
Future<PreparedText> prepareTextAsync(AttachmentKind kind, Uint8List bytes) async {
  if (bytes.length <= 256 * 1024) return prepareText(kind, bytes);
  return compute(_prepare, (kind, bytes));
}
