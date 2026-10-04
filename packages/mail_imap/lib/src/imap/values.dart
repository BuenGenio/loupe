/// Helpers for enough_mail's generic IMAP value tree.
library;

import 'protocol.dart';

/// Whether [v] is a parenthesised list (not a string, number or literal).
bool isList(ImapValue v) => v.children != null && v.value == null && v.data == null;

/// The string value of an atom, quoted string or literal; null for NIL.
String? stringOf(ImapValue v) {
  if (v.data == null && v.value == null) return null;
  if (v.data == null && v.value == 'NIL') return null;
  return v.valueOrDataText;
}

/// The integer value, or null.
int? intOf(ImapValue v) => int.tryParse(v.value ?? '');

/// Quotes a string for an IMAP command (only for ASCII without CR/LF).
String quoteImap(String s) => '"${s.replaceAll(r'\', r'\\').replaceAll('"', r'\"')}"';

/// Whether [s] can go into a quoted string.
bool isQuotable(String s) => !s.codeUnits.any((c) => c > 0x7e || c == 0x0d || c == 0x0a || c == 0);
