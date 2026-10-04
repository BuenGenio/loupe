/// Turning a [SearchExpr] into IMAP SEARCH commands.
library;

import 'dart:convert';

import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';

import 'values.dart';

/// Terms plain IMAP SEARCH can evaluate (structural nodes count as yes).
bool imapCanEvaluate(SearchExpr term) => switch (term) {
  TextTerm(field: TextField.attachment) => false,
  RegexTerm() || HasAttachmentTerm() || AccountTerm() => false,
  _ => true,
};

/// Terms Gmail's X-GM-RAW can evaluate.
bool gmailCanEvaluate(SearchExpr term) => switch (term) {
  RegexTerm() || AccountTerm() => false,
  _ => true,
};

/// The UID SEARCH command text for a compiled query.
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
