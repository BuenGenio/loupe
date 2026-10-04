/// Comma-, semicolon- or tab-separated values, as rows of cells.
final class CsvData {
  const CsvData(this.rows, this.delimiter);

  final List<List<String>> rows;
  final String delimiter;

  int get columns => rows.fold(0, (m, r) => r.length > m ? r.length : m);

  /// Small enough for the table view; bigger files show as text.
  bool get fitsTable => rows.isNotEmpty && rows.length <= maxTableRows && columns <= maxTableColumns;

  static const maxTableRows = 2000;
  static const maxTableColumns = 40;
}

/// Guesses the delimiter from the first lines: the one of `,` `;` and tab
/// that appears most, outside quotes. Comma when none does.
String detectCsvDelimiter(String text) {
  const candidates = [',', ';', '\t'];
  final counts = {for (final c in candidates) c: 0};
  var quoted = false;
  var lines = 0;
  for (var i = 0; i < text.length && i < 64 * 1024; i++) {
    final ch = text[i];
    if (ch == '"') {
      quoted = !quoted;
    } else if (!quoted && ch == '\n') {
      if (++lines >= 20) break;
    } else if (!quoted && counts.containsKey(ch)) {
      counts[ch] = counts[ch]! + 1;
    }
  }
  var best = ',';
  for (final c in candidates) {
    if (counts[c]! > counts[best]!) best = c;
  }
  return best;
}

/// Parses CSV (RFC 4180): quoted fields may hold delimiters, line breaks
/// and doubled quotes. Lines end in CRLF, LF or CR; a trailing line break
/// adds no empty row. Stops after [maxRows] rows (null: no limit).
CsvData parseCsv(String text, {String? delimiter, int? maxRows}) {
  final sep = delimiter ?? detectCsvDelimiter(text);
  final rows = <List<String>>[];
  var row = <String>[];
  final field = StringBuffer();
  var quoted = false;
  var fieldStarted = false;
  var i = 0;

  void endField() {
    row.add(field.toString());
    field.clear();
    fieldStarted = false;
  }

  void endRow() {
    endField();
    rows.add(row);
    row = <String>[];
  }

  while (i < text.length) {
    if (maxRows != null && rows.length >= maxRows) break;
    final ch = text[i];
    if (quoted) {
      if (ch == '"') {
        if (i + 1 < text.length && text[i + 1] == '"') {
          field.write('"');
          i += 2;
          continue;
        }
        quoted = false;
      } else {
        field.write(ch);
      }
      i++;
      continue;
    }
    if (ch == '"' && !fieldStarted && field.isEmpty) {
      quoted = true;
      fieldStarted = true;
    } else if (ch == sep) {
      endField();
    } else if (ch == '\r' || ch == '\n') {
      endRow();
      if (ch == '\r' && i + 1 < text.length && text[i + 1] == '\n') i++;
    } else {
      field.write(ch);
      fieldStarted = true;
    }
    i++;
  }
  // The last row, unless the text ended with a line break.
  if (field.isNotEmpty || row.isNotEmpty || fieldStarted) endRow();
  return CsvData(rows, sep);
}
