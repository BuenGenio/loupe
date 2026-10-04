import 'package:mail_model/mail_model.dart';

import '../api.dart' show ImapSearchQuery;
import '../eval/normal_form.dart';
import '../syntax/values.dart' show monthAbbrevs;

/// Compiles to RFC 3501 SEARCH keys from the negation normal form, so terms
/// IMAP can't express become ALL and the result is a superset.
final class ImapCompiler {
  ImapCompiler({this.supported});

  /// Extra terms to leave to the client (null: everything IMAP can do).
  final bool Function(SearchExpr term)? supported;
  var _exact = true;

  ImapSearchQuery compile(SearchExpr expr) {
    final keys = _node(simplify(negationNormalForm(expr)));
    final criteria = keys == null ? 'ALL' : keys.join(' ');
    return ImapSearchQuery(criteria: criteria, exact: _exact, useUtf8: criteria.codeUnits.any((u) => u > 0x7f));
  }

  /// The keys for [e] (all must match), or null for ALL.
  List<String>? _node(SearchExpr e) {
    switch (e) {
      case SearchAnd(:final children):
        final keys = [for (final c in children) ...?_node(c)];
        return keys.isEmpty ? null : keys;
      case SearchOr(:final children):
        final parts = <String>[];
        for (final c in children) {
          final k = _node(c);
          if (k == null) return null;
          parts.add(_one(k));
        }
        if (parts.isEmpty) return const ['NOT ALL'];
        var folded = parts.last;
        for (var i = parts.length - 2; i >= 0; i--) {
          folded = 'OR ${parts[i]} $folded';
        }
        return [folded];
      case SearchNot(:final child):
        return _literal(child, negated: true);
      default:
        return _literal(e, negated: false);
    }
  }

  static String _one(List<String> keys) => keys.length == 1 ? keys.single : '(${keys.join(' ')})';

  List<String>? _widen() {
    _exact = false;
    return null;
  }

  List<String>? _literal(SearchExpr t, {required bool negated}) {
    if (t is MatchAll) return negated ? const ['NOT ALL'] : null;
    if (supported?.call(t) == false) return _widen();
    String n(String key) => negated ? 'NOT $key' : key;
    switch (t) {
      case TextTerm(:final field, :final value):
        final q = imapString(value);
        if (q == null) return _widen();
        if (field == SearchField.any && !negated) {
          // TEXT also searches other headers: a superset, fine when positive.
          _exact = false;
          return ['TEXT $q'];
        }
        final key = switch (field) {
          SearchField.from => 'FROM $q',
          SearchField.to => 'TO $q',
          SearchField.cc => 'CC $q',
          SearchField.bcc => 'BCC $q',
          SearchField.subject => 'SUBJECT $q',
          SearchField.body => 'BODY $q',
          SearchField.recipients => 'OR TO $q OR CC $q BCC $q',
          SearchField.participants => 'OR FROM $q OR TO $q OR CC $q BCC $q',
          SearchField.any => 'OR FROM $q OR TO $q OR CC $q OR SUBJECT $q BODY $q',
          SearchField.attachment => null,
        };
        return key == null ? _widen() : [n(key)];
      case HeaderTerm(:final name, :final value):
        final v = imapString(value);
        if (!_isFieldName(name) || v == null) return _widen();
        return [n('HEADER ${imapString(name)} $v')];
      case KeywordTerm(:final keyword):
        final k = Keywords.normalize(keyword);
        final flag = switch (k) {
          Keywords.seen => 'SEEN',
          Keywords.flagged => 'FLAGGED',
          Keywords.answered => 'ANSWERED',
          Keywords.draft => 'DRAFT',
          _ => null,
        };
        if (flag != null) return [negated ? 'UN$flag' : flag];
        if (!_isAtom(k)) return _widen();
        return ['${negated ? 'UNKEYWORD' : 'KEYWORD'} $k'];
      case DateTerm(:final comparison, :final date):
        final d = imapDate(date);
        return [
          switch ((comparison, negated)) {
            (DateComparison.before, false) || (DateComparison.onOrAfter, true) => 'BEFORE $d',
            (DateComparison.onOrAfter, false) || (DateComparison.before, true) => 'SINCE $d',
            (DateComparison.on, _) => n('ON $d'),
          },
        ];
      case SizeTerm(:final comparison, :final bytes):
        if (bytes < 0 || bytes > 0xFFFFFFFF) return _widen();
        return [n('${comparison == SizeComparison.larger ? 'LARGER' : 'SMALLER'} $bytes')];
      default:
        // Patterns, attachment presence and names, accounts.
        return _widen();
    }
  }
}

/// An IMAP quoted string, or null if the text needs a literal (CR, LF, NUL).
String? imapString(String s) {
  if (s.contains(RegExp('[\r\n\u0000]'))) return null;
  return '"${s.replaceAll(r'\', r'\\').replaceAll('"', r'\"')}"';
}

/// `d-Mon-yyyy`.
String imapDate(DateTime d) => '${d.day}-${monthAbbrevs[d.month - 1]}-${d.year.toString().padLeft(4, '0')}';

/// A keyword usable as an IMAP atom (no atom-specials, no backslash flag).
bool _isAtom(String k) =>
    k.isNotEmpty && k.codeUnits.every((u) => u > 0x20 && u < 0x7f && !'(){%*"\\]'.contains(String.fromCharCode(u)));

/// A header field name: printable ASCII without colon or space.
bool _isFieldName(String n) => n.isNotEmpty && n.codeUnits.every((u) => u > 0x20 && u < 0x7f && u != 0x3a);
