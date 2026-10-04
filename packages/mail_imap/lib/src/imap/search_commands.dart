/// Turning a [SearchExpr] into IMAP SEARCH commands.
library;

import 'dart:convert';

import 'package:expr_search/expr_search.dart';

import 'values.dart';

/// The UID SEARCH command text for a compiled query. `CHARSET UTF-8` is
/// added for non-ASCII criteria (Loupe never enables UTF8=ACCEPT).
String uidSearchCommand(ImapSearchQuery query) =>
    'UID SEARCH ${query.useUtf8 || _hasNonAscii(query.criteria) ? 'CHARSET UTF-8 ' : ''}${query.criteria}';

/// The UID SEARCH command for a Gmail X-GM-RAW query.
String gmailRawSearchCommand(String raw) =>
    'UID SEARCH ${_hasNonAscii(raw) ? 'CHARSET UTF-8 ' : ''}X-GM-RAW ${_quoteAny(raw)}';

bool _hasNonAscii(String s) => s.codeUnits.any((c) => c > 0x7e);

String _quoteAny(String s) => quoteImap(s.replaceAll(RegExp(r'[\r\n]+'), ' '));

/// Splits [command] into continuation parts: every quoted string that
/// can't be sent quoted (non-ASCII) becomes a literal `{n}`, and the text
/// after it starts the next part.
List<String> literalize(String command) {
  final parts = <String>[];
  final current = StringBuffer();
  var i = 0;
  while (i < command.length) {
    final ch = command[i];
    if (ch != '"') {
      current.write(ch);
      i++;
      continue;
    }
    var j = i + 1;
    final content = StringBuffer();
    while (j < command.length && command[j] != '"') {
      if (command[j] == r'\' && j + 1 < command.length) j++;
      content.write(command[j]);
      j++;
    }
    final s = content.toString();
    if (isQuotable(s)) {
      current.write(command.substring(i, j < command.length ? j + 1 : j));
    } else {
      current.write('{${utf8.encode(s).length}}');
      parts.add(current.toString());
      current
        ..clear()
        ..write(s);
    }
    i = j + 1;
  }
  parts.add(current.toString());
  return parts;
}
