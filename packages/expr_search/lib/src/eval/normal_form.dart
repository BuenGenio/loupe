import 'package:mail_model/mail_model.dart';

/// Matches nothing: the negation of [MatchAll].
const matchNone = SearchNot(MatchAll());

/// Pushes negations down to the terms (De Morgan, double negation) and
/// flattens nested AND/OR of the same kind. Terms and `Not(term)` are the
/// literals of the result.
SearchExpr negationNormalForm(SearchExpr e, [bool negate = false]) => switch (e) {
  SearchNot(:final child) => negationNormalForm(child, !negate),
  SearchAnd(:final children) => _flat(children.map((c) => negationNormalForm(c, negate)), or: negate),
  SearchOr(:final children) => _flat(children.map((c) => negationNormalForm(c, negate)), or: !negate),
  _ => negate ? SearchNot(e) : e,
};

SearchExpr _flat(Iterable<SearchExpr> children, {required bool or}) {
  final out = <SearchExpr>[];
  for (final c in children) {
    switch (c) {
      case SearchOr(:final children) when or:
        out.addAll(children);
      case SearchAnd(:final children) when !or:
        out.addAll(children);
      default:
        out.add(c);
    }
  }
  return or ? SearchOr(out) : SearchAnd(out);
}

/// Removes [MatchAll] and [matchNone] where they decide the result, unwraps
/// single children, flattens nesting and cancels double negation. Keeps the
/// meaning, including the three-valued meaning used by `matchesEmail`.
SearchExpr simplify(SearchExpr e) {
  switch (e) {
    case SearchAnd(:final children):
      final out = <SearchExpr>[];
      for (final c in children.map(simplify)) {
        if (c == matchNone) return matchNone;
        if (c is SearchAnd) {
          out.addAll(c.children);
        } else if (c is! MatchAll) {
          out.add(c);
        }
      }
      return out.isEmpty ? const MatchAll() : (out.length == 1 ? out.single : SearchAnd(out));
    case SearchOr(:final children):
      final out = <SearchExpr>[];
      for (final c in children.map(simplify)) {
        if (c is MatchAll) return const MatchAll();
        if (c is SearchOr) {
          out.addAll(c.children);
        } else if (c != matchNone) {
          out.add(c);
        }
      }
      return out.isEmpty ? matchNone : (out.length == 1 ? out.single : SearchOr(out));
    case SearchNot(:final child):
      return switch (simplify(child)) {
        SearchNot(:final child) => child,
        final c => SearchNot(c),
      };
    default:
      return e;
  }
}

/// In negation normal form, replaces every literal whose term is not
/// [supported] with [MatchAll], then simplifies. Since the normal form is
/// monotone in its literals, the result matches a superset.
SearchExpr widen(SearchExpr expr, bool Function(SearchExpr term) supported) {
  SearchExpr go(SearchExpr e) => switch (e) {
    SearchAnd(:final children) => SearchAnd(children.map(go).toList()),
    SearchOr(:final children) => SearchOr(children.map(go).toList()),
    SearchNot(child: MatchAll()) => e,
    SearchNot(:final child) => supported(child) ? e : const MatchAll(),
    MatchAll() => e,
    _ => supported(e) ? e : const MatchAll(),
  };
  return simplify(go(negationNormalForm(expr)));
}

/// Replaces [AccountTerm]s by what they mean for one account, labelled
/// [accountLabel], and simplifies.
SearchExpr bindAccount(SearchExpr expr, String accountLabel) {
  final label = accountLabel.toLowerCase();
  SearchExpr go(SearchExpr e) => switch (e) {
    SearchAnd(:final children) => SearchAnd(children.map(go).toList()),
    SearchOr(:final children) => SearchOr(children.map(go).toList()),
    SearchNot(:final child) => SearchNot(go(child)),
    AccountTerm(:final value) => label.contains(value.toLowerCase()) ? const MatchAll() : matchNone,
    _ => e,
  };
  return simplify(go(expr));
}
