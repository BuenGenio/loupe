import 'package:mail_model/mail_model.dart';

import '../eval/normal_form.dart';
import '../syntax/values.dart' show dayOf;

/// Gmail query parts; rendered with the parentheses Gmail's precedence
/// needs (OR binds tighter than the implicit AND).
sealed class _G {
  const _G();
}

final class _Atom extends _G {
  const _Atom(this.text);
  final String text;
}

final class _All extends _G {
  const _All(this.items);
  final List<_G> items;
}

final class _Any extends _G {
  const _Any(this.items);
  final List<_G> items;
}

/// Compiles to Gmail search syntax (for `X-GM-RAW`) from the negation normal
/// form. Null if a term has no Gmail operator; '' for [MatchAll].
String? compileGmail(SearchExpr expr) {
  final e = simplify(negationNormalForm(expr));
  if (e is MatchAll) return '';
  final g = _node(e);
  return g == null ? null : _render(g, null);
}

/// Whether Gmail can express [term], negated or not.
bool gmailCanExpress(SearchExpr term) => _literal(term, false) != null && _literal(term, true) != null;

_G? _node(SearchExpr e) => switch (e) {
  SearchAnd(:final children) => _list(children, _All.new),
  SearchOr(:final children) => _list(children, _Any.new),
  SearchNot(:final child) => _literal(child, true),
  _ => _literal(e, false),
};

_G? _list(List<SearchExpr> children, _G Function(List<_G>) make) {
  final items = <_G>[];
  for (final c in children) {
    final g = _node(c);
    if (g == null) return null;
    items.add(g);
  }
  return make(items);
}

_G? _literal(SearchExpr t, bool negated) {
  _Atom a(String s) => _Atom(negated ? '-$s' : s);
  switch (t) {
    case TextTerm(:final field, :final value):
      final v = gmailValue(value);
      if (v == null) return null;
      _G spread(List<String> ops) =>
          negated ? _All([for (final o in ops) _Atom('-$o:$v')]) : _Any([for (final o in ops) _Atom('$o:$v')]);
      return switch (field) {
        // Gmail has no body-only operator; plain text searches everywhere.
        TextField.any || TextField.body => a(v),
        TextField.from => a('from:$v'),
        TextField.to => a('to:$v'),
        TextField.cc => a('cc:$v'),
        TextField.bcc => a('bcc:$v'),
        TextField.subject => a('subject:$v'),
        TextField.attachment => a('filename:$v'),
        TextField.recipients => spread(const ['to', 'cc', 'bcc']),
        TextField.participants => spread(const ['from', 'to', 'cc', 'bcc']),
      };
    case HasAttachmentTerm():
      return a('has:attachment');
    case KeywordTerm(:final keyword):
      return switch (Keywords.normalize(keyword)) {
        Keywords.seen => _Atom(negated ? 'is:unread' : 'is:read'),
        Keywords.flagged => a('is:starred'),
        _ => null,
      };
    case DateTerm(:final comparison, :final date):
      final d = gmailDate(date);
      final next = gmailDate(dayOf(date, 1));
      return switch ((comparison, negated)) {
        (DateComparison.before, false) || (DateComparison.onOrAfter, true) => _Atom('before:$d'),
        (DateComparison.onOrAfter, false) || (DateComparison.before, true) => _Atom('after:$d'),
        (DateComparison.on, false) => _All([_Atom('after:$d'), _Atom('before:$next')]),
        (DateComparison.on, true) => _Any([_Atom('before:$d'), _Atom('after:$next')]),
      };
    case SizeTerm(:final comparison, :final bytes):
      return a('${comparison == SizeComparison.larger ? 'larger' : 'smaller'}:$bytes');
    case HeaderTerm(:final name, :final value) when name.toLowerCase() == 'list-id' && value.isNotEmpty:
      final v = gmailValue(value);
      return v == null ? null : a('list:$v');
    default:
      // Patterns, accounts, other headers and keywords, Not(MatchAll).
      return null;
  }
}

enum _Parent { and, or }

String _render(_G g, _Parent? parent) => switch (g) {
  _Atom(:final text) => text,
  _All(:final items) => _wrap(parent == _Parent.or, items.map((i) => _render(i, _Parent.and)).join(' ')),
  _Any(:final items) => _wrap(parent == _Parent.and, items.map((i) => _render(i, _Parent.or)).join(' OR ')),
};

String _wrap(bool parens, String s) => parens ? '($s)' : s;

final _plain = RegExp(r"^[\p{L}\p{N}@._+'&*#-]+$", unicode: true);

/// A Gmail value: bare when it is one plain word, else in double quotes.
/// Null when Gmail can't express it (empty, contains a double quote or a
/// control character).
String? gmailValue(String v) {
  if (v.trim().isEmpty || v.contains('"') || v.contains(RegExp('[\u0000-\u001f]'))) return null;
  if (_plain.hasMatch(v) && !v.startsWith('-') && !const {'OR', 'AND', 'AROUND'}.contains(v)) return v;
  return '"$v"';
}

/// `yyyy/mm/dd`.
String gmailDate(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';
