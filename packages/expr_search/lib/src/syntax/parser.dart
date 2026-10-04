import 'package:mail_model/mail_model.dart';

import '../api.dart';
import 'lexer.dart';
import 'operators.dart';
import 'values.dart';

/// Parses a query. Recursive descent over [lex]'s tokens with precedence
/// not > and > or; problems become [QueryError]s and the offending term is
/// dropped, so a half-typed query still gives a useful expression.
final class QueryParser {
  QueryParser(this.input, {required DateTime now, required this.tags}) : today = dayOf(now.toLocal());

  final String input;
  final DateTime today;
  final List<TagDefinition> tags;

  final _errors = <QueryError>[];
  final _badTokens = <Tok>{};
  late final List<Tok> _all = lex(input);
  late final List<Tok> _toks = [
    for (final t in _all)
      if (t.type != TokType.global) t,
  ];
  var _i = 0;

  ParsedQuery parse() {
    final parts = <SearchExpr?>[];
    while (true) {
      parts.add(_or(null));
      if (_i >= _toks.length) break;
      final stray = _next();
      _badTokens.add(stray);
      _error('Unmatched closing parenthesis', stray.start, stray.end);
    }
    return ParsedQuery(expr: _combine(parts, or: false) ?? const MatchAll(), errors: _errors, tokens: _tokens());
  }

  List<QueryToken> _tokens() => [
    for (final t in _all)
      QueryToken(_badTokens.contains(t) ? QueryTokenKind.error : _kindOf(t.type), t.start, t.end, t.text),
  ];

  static QueryTokenKind _kindOf(TokType t) => switch (t) {
    TokType.op || TokType.global => QueryTokenKind.operatorName,
    TokType.word || TokType.raw => QueryTokenKind.value,
    TokType.quoted => QueryTokenKind.quoted,
    TokType.regex => QueryTokenKind.regex,
    TokType.and || TokType.or || TokType.not || TokType.minus => QueryTokenKind.keyword,
    TokType.lparen || TokType.rparen => QueryTokenKind.paren,
  };

  // ------------------------------------------------------------ grammar

  Tok? get _peek => _i < _toks.length ? _toks[_i] : null;
  bool _at(TokType type) => _peek?.type == type;
  Tok _next() => _toks[_i++];

  /// True where an operand can't start: end, `)` or `or`.
  bool get _atOperandEnd => _peek == null || _at(TokType.rparen) || _at(TokType.or);

  void _error(String message, int start, int end) => _errors.add(QueryError(message, start, end));

  SearchExpr? _or(OpSpec? ctx) {
    final items = <SearchExpr?>[];
    var start = _i;
    items.add(_and(ctx));
    while (_at(TokType.or)) {
      final or = _next();
      if (_i - 1 == start) _error('Nothing before “${or.text}”', or.start, or.end);
      if (_atOperandEnd) {
        _error('Nothing after “${or.text}”', or.start, or.end);
        start = -2; // reported; don't flag the next `or` again
        continue;
      }
      start = _i;
      items.add(_and(ctx));
    }
    return _combine(items, or: true);
  }

  SearchExpr? _and(OpSpec? ctx) {
    final items = <SearchExpr?>[];
    while (!_atOperandEnd) {
      if (_at(TokType.and)) {
        final and = _next();
        if (items.isEmpty) {
          _error('Nothing before “${and.text}”', and.start, and.end);
        } else if (_atOperandEnd || _at(TokType.and)) {
          _error('Nothing after “${and.text}”', and.start, and.end);
        }
        continue;
      }
      items.add(_unary(ctx));
    }
    return _combine(items, or: false);
  }

  SearchExpr? _unary(OpSpec? ctx) {
    if (_at(TokType.not) || _at(TokType.minus)) {
      final neg = _next();
      if (_atOperandEnd || _at(TokType.and)) {
        _error('Nothing to negate after “${neg.text}”', neg.start, neg.end);
        return null;
      }
      final inner = _unary(ctx);
      return inner == null ? null : SearchNot(inner);
    }
    return _primary(ctx);
  }

  SearchExpr? _primary(OpSpec? ctx) {
    final t = _peek!;
    switch (t.type) {
      case TokType.lparen:
        return _group(ctx);
      case TokType.op:
        _next();
        return _operatorValue(t.op!, t);
      case TokType.word || TokType.quoted || TokType.regex || TokType.raw:
        return _atom(ctx);
      default:
        // Only reachable through a token the callers already handle.
        _next();
        return null;
    }
  }

  SearchExpr? _group(OpSpec? ctx) {
    final open = _next();
    final first = _i;
    final e = _or(ctx);
    final empty = _i == first;
    var end = _peek?.start ?? input.length;
    if (_at(TokType.rparen)) {
      end = _next().end;
    } else {
      _badTokens.add(open);
      _error('Missing closing parenthesis', open.start, open.end);
    }
    if (empty) _error('Empty parentheses', open.start, end);
    return e;
  }

  SearchExpr? _operatorValue(OpSpec op, Tok opTok) {
    final t = _peek;
    final startsValue = switch (t?.type) {
      TokType.word || TokType.quoted || TokType.regex || TokType.raw => true,
      TokType.lparen || TokType.minus || TokType.not => true,
      _ => false,
    };
    if (!startsValue) {
      _badTokens.add(opTok);
      _error('“${opTok.text}” needs a value', opTok.start, opTok.end);
      return null;
    }
    switch (t!.type) {
      case TokType.lparen:
        return _group(op);
      case TokType.minus || TokType.not:
        _next();
        if (_atOperandEnd || _at(TokType.and)) {
          _error('Nothing to negate after “${t.text}”', t.start, t.end);
          return null;
        }
        final inner = _operatorValue(op, opTok);
        return inner == null ? null : SearchNot(inner);
      default:
        return _atom(op);
    }
  }

  /// A word phrase, quoted string, regex or raw value, interpreted by [ctx]
  /// (bare text when null).
  SearchExpr? _atom(OpSpec? ctx) {
    final first = _next();
    final toks = [first];
    if (first.type == TokType.word) {
      while (_at(TokType.word)) {
        toks.add(_next());
      }
    }
    final start = first.start;
    final end = toks.last.end;
    if (first.unterminated) {
      final what = first.type == TokType.regex ? 'closing slash' : 'closing quote';
      _error('Missing $what', start, end);
    }
    final atom = switch (first.type) {
      TokType.word => _Atom(toks.map((t) => t.text).join(' '), start, end),
      TokType.regex => _Atom(
        first.value,
        start,
        end,
        regex: true,
        flags: first.unterminated ? 'i' : first.flags,
        quoted: true,
      ),
      _ => _Atom(first.value, start, end, quoted: first.type == TokType.quoted),
    };
    final before = _errors.length;
    final e = _term(ctx, atom);
    if (e == null && _errors.length > before) _badTokens.addAll(toks);
    return e;
  }

  // ------------------------------------------------------------ terms

  SearchExpr? _fail(String message, _Atom a) {
    _error(message, a.start, a.end);
    return null;
  }

  SearchExpr? _term(OpSpec? op, _Atom a) {
    if (op == null) return a.regex ? _regexTerm(TextField.any, a) : TextTerm(TextField.any, a.text);
    if (a.regex && !_acceptsRegex(op.kind)) return _fail('A pattern can’t be used with “${op.name}:”', a);
    final v = a.text;
    if (!a.regex && v.trim().isEmpty && !_acceptsEmpty(op.kind)) return _fail('Empty value for “${op.name}:”', a);
    switch (op.kind) {
      case OpKind.text:
        return a.regex ? _regexTerm(op.field!, a) : TextTerm(op.field!, v);
      case OpKind.toOrCc:
        return switch (a.regex ? _regexTerm(TextField.to, a) : TextTerm(TextField.to, v)) {
          RegexTerm(:final pattern, :final caseSensitive) && final to => SearchOr([
            to,
            RegexTerm(TextField.cc, pattern, caseSensitive: caseSensitive),
          ]),
          final SearchExpr to => SearchOr([to, TextTerm(TextField.cc, v)]),
          null => null,
        };
      case OpKind.regex:
        return a.regex ? _regexTerm(op.field!, a) : _pattern(op.field!, v, caseSensitive: false, a);
      case OpKind.simple:
        return SearchAnd([
          TextTerm(TextField.subject, v),
          RegexTerm(TextField.subject, RegExp.escape(v), caseSensitive: true),
        ]);
      case OpKind.header || OpKind.headerRegex:
        return _header(op.kind, a);
      case OpKind.attachment:
        if (a.regex) return _regexTerm(TextField.attachment, a);
        return switch (v.trim().toLowerCase()) {
          'yes' || 'y' || '1' => const HasAttachmentTerm(),
          'no' || 'n' || '0' => const SearchNot(HasAttachmentTerm()),
          _ => TextTerm(TextField.attachment, v),
        };
      case OpKind.has:
        return switch (v.trim().toLowerCase()) {
          'attachment' || 'attachments' || 'att' || 'a' => const HasAttachmentTerm(),
          _ => _fail('Unknown “has:” value: ${v.trim()} (try has:attachment)', a),
        };
      case OpKind.status:
        final key = v.trim().toLowerCase();
        if (key == 'deleted') return _fail('“is:deleted” is not supported; deleted mail is in the trash', a);
        return statusValues[key] ?? _fail('Unknown status: ${v.trim()} (try unread, flagged or replied)', a);
      case OpKind.tag:
        return switch (resolveTag(v, tags)) {
          Ok(:final value) => value,
          Err(:final message) => _fail(message, a),
        };
      case OpKind.keyword:
        return KeywordTerm(Keywords.normalize(v));
      case OpKind.account:
        return AccountTerm(v);
      case OpKind.only:
        final people = [
          for (final p in v.split(','))
            if (p.trim().isNotEmpty) p.trim(),
        ];
        if (people.isEmpty) return _fail('“only:” needs one or more people, separated by commas', a);
        return onlyExpr(people);
      case OpKind.before || OpKind.after || OpKind.date:
        return switch (parseDaySpan(v, today)) {
          Ok(value: (:final start, :final end)) => switch (op.kind) {
            OpKind.before => DateTerm(DateComparison.before, start),
            OpKind.after => DateTerm(DateComparison.onOrAfter, end),
            _ when dayOf(start, 1) == end => DateTerm(DateComparison.on, start),
            _ => SearchAnd([DateTerm(DateComparison.onOrAfter, start), DateTerm(DateComparison.before, end)]),
          },
          Err(:final message) => _fail(message, a),
        };
      case OpKind.olderThan || OpKind.newerThan:
        return switch (parseAge(v, today)) {
          Ok(value: (:final cutoff, :final inclusive)) =>
            op.kind == OpKind.olderThan
                ? DateTerm(DateComparison.before, cutoff)
                : DateTerm(DateComparison.onOrAfter, inclusive ? cutoff : dayOf(cutoff, 1)),
          Err(:final message) => _fail(message, a),
        };
      case OpKind.larger || OpKind.smaller:
        return switch (parseSize(v)) {
          Ok(:final value) => SizeTerm(
            op.kind == OpKind.larger ? SizeComparison.larger : SizeComparison.smaller,
            value,
          ),
          Err(:final message) => _fail(message, a),
        };
    }
  }

  static bool _acceptsRegex(OpKind k) =>
      k == OpKind.text || k == OpKind.toOrCc || k == OpKind.regex || k == OpKind.attachment;

  static bool _acceptsEmpty(OpKind k) => k == OpKind.text || k == OpKind.toOrCc || k == OpKind.account;

  SearchExpr? _regexTerm(TextField field, _Atom a) {
    var caseSensitive = true;
    for (final f in a.flags.split('')) {
      if (f == 'i') {
        caseSensitive = false;
      } else if (f != 'g') {
        _error('Unsupported pattern flag “$f” (only i is supported)', a.start, a.end);
      }
    }
    return _pattern(field, a.text, caseSensitive: caseSensitive, a);
  }

  SearchExpr? _pattern(TextField field, String pattern, _Atom a, {required bool caseSensitive}) {
    if (pattern.isEmpty) return _fail('Empty pattern', a);
    try {
      RegExp(pattern, caseSensitive: caseSensitive);
    } on FormatException catch (e) {
      return _fail('Invalid pattern: ${e.message}', a);
    }
    return RegexTerm(field, pattern, caseSensitive: caseSensitive);
  }

  /// `name`, `name=text`, or for `headerre:` also `name=/regex/`. Header
  /// patterns are limited to literal text, since [HeaderTerm] is a substring.
  SearchExpr? _header(OpKind kind, _Atom a) {
    final eq = a.text.indexOf('=');
    final name = (eq < 0 ? a.text : a.text.substring(0, eq)).trim();
    if (name.isEmpty || name.contains(RegExp(r'[\s:]'))) return _fail('Missing or invalid header name', a);
    if (eq < 0) return HeaderTerm(name, '');
    final value = a.text.substring(eq + 1);
    if (kind == OpKind.header) return HeaderTerm(name, value);
    var pattern = value.trim();
    if (pattern.startsWith('/')) {
      final r = scanRegex(pattern, 0);
      if (r.end == pattern.length) pattern = r.pattern;
    }
    final literal = literalOfPattern(pattern);
    if (literal != null) return HeaderTerm(name, literal);
    _error('Header patterns must be plain text; matching every message with a $name header', a.start, a.end);
    return HeaderTerm(name, '');
  }

  /// Combines operands, dropping failed (null) ones.
  static SearchExpr? _combine(List<SearchExpr?> items, {required bool or}) {
    final kept = [for (final e in items) ?e];
    if (kept.isEmpty) return null;
    if (kept.length == 1) return kept.single;
    return or ? SearchOr(kept) : SearchAnd(kept);
  }
}

/// "The given people are the only To recipients": each is in To, and no To
/// address lacks all of them.
SearchExpr onlyExpr(List<String> people) => SearchAnd([
  for (final p in people) TextTerm(TextField.to, p),
  SearchNot(RegexTerm(TextField.to, onlyPattern(people))),
]);

/// Matches an address that contains none of [people].
String onlyPattern(List<String> people) => '^(?!.*(?:${people.map(RegExp.escape).join('|')}))';

final class _Atom {
  const _Atom(this.text, this.start, this.end, {this.regex = false, this.flags = '', this.quoted = false});
  final String text;
  final int start;
  final int end;
  final bool regex;
  final String flags;
  final bool quoted;
}
