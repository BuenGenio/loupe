import 'package:mail_model/mail_model.dart';

import 'lexer.dart';
import 'operators.dart';
import 'parser.dart' show onlyPattern;
import 'values.dart';

enum _Ctx { top, and, or, not }

/// Writes an expression in the canonical syntax, so that parsing the result
/// gives the same expression back.
///
/// Compound nodes with fewer than two children and [MatchAll] inside a
/// compound are simplified first; `Not(MatchAll)` (matches nothing) has no
/// syntax and comes out as `-()`.
final class QueryFormatter {
  const QueryFormatter(this.tags);
  final List<TagDefinition> tags;

  String format(SearchExpr expr) {
    final e = tidy(expr);
    return e is MatchAll ? '' : _fmt(e, _Ctx.top);
  }

  String _fmt(SearchExpr e, _Ctx ctx) {
    if (toOrCcShape(e) case (final value, final regex)) {
      return 'to:${regex == null ? quoteValue(value) : regexLiteral(regex.pattern, regex.caseSensitive)}';
    }
    if (onlyShape(e) case final people?) return 'only:${quoteValue(people.join(','))}';
    return switch (e) {
      MatchAll() => '()',
      SearchAnd(:final children) => _wrap(ctx == _Ctx.and || ctx == _Ctx.not, _joinAnd(children)),
      SearchOr(:final children) => _wrap(ctx != _Ctx.top, children.map((c) => _fmt(c, _Ctx.or)).join(' or ')),
      SearchNot(:final child) => _not(child),
      TextTerm(field: TextField.any, :final value) => quoteValue(value),
      TextTerm(:final field, :final value) => '${textOperatorFor(field)}:${quoteValue(value)}',
      RegexTerm(:final field, :final pattern, :final caseSensitive) =>
        field == TextField.any
            ? regexLiteral(pattern, caseSensitive)
            : '${textOperatorFor(field)}:${regexLiteral(pattern, caseSensitive)}',
      HeaderTerm(:final name, :final value) => 'header:${quoteValue(value.isEmpty ? name : '$name=$value')}',
      KeywordTerm(:final keyword) => _keyword(keyword),
      DateTerm(:final comparison, :final date) => switch (comparison) {
        DateComparison.before => 'before:${isoDay(date)}',
        DateComparison.onOrAfter => 'after:${isoDay(DateTime(date.year, date.month, date.day - 1))}',
        DateComparison.on => 'date:${isoDay(date)}',
      },
      SizeTerm(:final comparison, :final bytes) => '${comparison.name}:${sizeText(bytes)}',
      HasAttachmentTerm() => 'attachment:yes',
      AccountTerm(:final value) => 'account:${quoteValue(value)}',
    };
  }

  static String _wrap(bool parens, String s) => parens ? '($s)' : s;

  /// Children separated by spaces; `and` where a bare word would otherwise
  /// continue the previous term's phrase.
  String _joinAnd(List<SearchExpr> children) {
    final b = StringBuffer();
    for (var i = 0; i < children.length; i++) {
      final c = children[i];
      if (i > 0) b.write(c is TextTerm && c.field == TextField.any && !needsQuotes(c.value) ? ' and ' : ' ');
      b.write(_fmt(c, _Ctx.and));
    }
    return b.toString();
  }

  String _not(SearchExpr child) {
    if (child case KeywordTerm(:final keyword)) {
      final status = statusNameFor(keyword, negated: true);
      if (status != null) return 'is:$status';
    }
    if (child is HasAttachmentTerm) return 'attachment:no';
    return '-${_fmt(child, _Ctx.not)}';
  }

  String _keyword(String k) {
    final status = statusNameFor(k, negated: false);
    if (status != null) return 'is:$status';
    if (!Keywords.system.contains(k)) {
      final label = tagLabel(k, tags);
      if (label != null && _tagMeans(label, k)) return 'tag:${quoteValue(label)}';
      if (_tagMeans(k, k)) return 'tag:${quoteValue(k)}';
    }
    return 'keyword:${quoteValue(k)}';
  }

  bool _tagMeans(String text, String keyword) => switch (resolveTag(text, tags)) {
    Ok(:final value) => value == KeywordTerm(keyword),
    Err() => false,
  };
}

/// Drops [MatchAll] inside compounds and unwraps single children.
SearchExpr tidy(SearchExpr e) {
  switch (e) {
    case SearchAnd(:final children):
      final kept = [
        for (final c in children.map(tidy))
          if (c is! MatchAll) c,
      ];
      return kept.isEmpty ? const MatchAll() : (kept.length == 1 ? kept.single : SearchAnd(kept));
    case SearchOr(:final children):
      final all = children.map(tidy).toList();
      if (all.any((c) => c is MatchAll)) return const MatchAll();
      return all.isEmpty ? const SearchNot(MatchAll()) : (all.length == 1 ? all.single : SearchOr(all));
    case SearchNot(:final child):
      return SearchNot(tidy(child));
    default:
      return e;
  }
}

/// `to:v` parses to To-or-Cc; returns the value (and pattern) for that shape.
(String, RegexTerm?)? toOrCcShape(SearchExpr e) => switch (e) {
  SearchOr(children: [TextTerm(field: TextField.to, value: final a), TextTerm(field: TextField.cc, value: final b)])
      when a == b =>
    (a, null),
  SearchOr(
    children: [
      RegexTerm(field: TextField.to) && final to,
      RegexTerm(field: TextField.cc, :final pattern, :final caseSensitive),
    ],
  )
      when to.pattern == pattern && to.caseSensitive == caseSensitive =>
    (pattern, to),
  _ => null,
};

/// The people of an `only:` expression, if [e] has exactly that shape.
List<String>? onlyShape(SearchExpr e) {
  if (e is! SearchAnd || e.children.length < 2) return null;
  final people = <String>[];
  for (final c in e.children.take(e.children.length - 1)) {
    if (c case TextTerm(field: TextField.to, :final value) when value.isNotEmpty && value == value.trim()) {
      if (value.contains(',')) return null;
      people.add(value);
    } else {
      return null;
    }
  }
  return e.children.last == SearchNot(RegexTerm(TextField.to, onlyPattern(people))) ? people : null;
}

/// The value `simple:` produced: subject text plus its case-sensitive form.
String? simpleShape(SearchExpr e) => switch (e) {
  SearchAnd(
    children: [
      TextTerm(field: TextField.subject, :final value),
      RegexTerm(field: TextField.subject, :final pattern, caseSensitive: true),
    ],
  )
      when pattern == RegExp.escape(value) =>
    value,
  _ => null,
};

final _needsQuotes = RegExp(r'[\s()"“”„\\:]');

/// Whether a value must be quoted to read back as one literal value.
bool needsQuotes(String v) =>
    v.isEmpty || _needsQuotes.hasMatch(v) || v.startsWith('-') || v.startsWith('/') || isKeywordWord(v);

String quoteValue(String v) => needsQuotes(v) ? '"${v.replaceAll(r'\', r'\\').replaceAll('"', r'\"')}"' : v;

/// `/pattern/` or `/pattern/i`, escaping slashes.
String regexLiteral(String pattern, bool caseSensitive) {
  final b = StringBuffer('/');
  for (var i = 0; i < pattern.length; i++) {
    final c = pattern[i];
    if (c == r'\' && i + 1 < pattern.length) {
      b
        ..write(c)
        ..write(pattern[++i]);
    } else {
      b.write(c == '/' ? r'\/' : c);
    }
  }
  b
    ..write('/')
    ..write(caseSensitive ? '' : 'i');
  return b.toString();
}

// ------------------------------------------------------------ describe

/// Short labels for chips.
final class TermDescriber {
  const TermDescriber(this.tags);
  final List<TagDefinition> tags;

  String describe(SearchExpr e) {
    if (toOrCcShape(e) case (final value, final regex)) {
      return regex == null ? 'To/Cc: $value' : 'To/Cc matches ${regexLiteral(regex.pattern, regex.caseSensitive)}';
    }
    if (onlyShape(e) case final people?) return 'Only to: ${people.join(', ')}';
    if (simpleShape(e) case final value?) return 'Subject (exact): $value';
    return switch (e) {
      MatchAll() => 'All messages',
      SearchAnd(:final children) => children.map(_part).join(', '),
      SearchOr(:final children) => _describeOr(children),
      SearchNot(:final child) => _not(child),
      TextTerm(field: TextField.any, :final value) => value,
      TextTerm(:final field, :final value) => '${fieldLabel(field)}: $value',
      RegexTerm(field: TextField.any, :final pattern, :final caseSensitive) =>
        'Matches ${regexLiteral(pattern, caseSensitive)}',
      RegexTerm(:final field, :final pattern, :final caseSensitive) =>
        '${fieldLabel(field)} matches ${regexLiteral(pattern, caseSensitive)}',
      HeaderTerm(:final name, value: '') => 'Has header $name',
      HeaderTerm(:final name, :final value) => '$name: $value',
      KeywordTerm(:final keyword) => _keyword(keyword),
      DateTerm(:final comparison, :final date) => switch (comparison) {
        DateComparison.before => 'Before ${_day(date)}',
        DateComparison.onOrAfter => 'Since ${_day(date)}',
        DateComparison.on => 'On ${_day(date)}',
      },
      SizeTerm(comparison: SizeComparison.larger, :final bytes) => 'Larger than ${humanSize(bytes)}',
      SizeTerm(comparison: SizeComparison.smaller, :final bytes) => 'Smaller than ${humanSize(bytes)}',
      HasAttachmentTerm() => 'Has attachment',
      AccountTerm(:final value) => 'Account: $value',
    };
  }

  String _part(SearchExpr e) => e is SearchAnd || e is SearchOr ? '(${describe(e)})' : describe(e);

  String _describeOr(List<SearchExpr> children) {
    final fields = {for (final c in children) c is TextTerm ? c.field : null};
    if (fields.length == 1 && fields.single != null && fields.single != TextField.any) {
      return '${fieldLabel(fields.single!)}: ${children.map((c) => (c as TextTerm).value).join(' or ')}';
    }
    return children.map(_part).join(' or ');
  }

  String _not(SearchExpr child) {
    switch (child) {
      case KeywordTerm(keyword: Keywords.seen):
        return 'Unread';
      case KeywordTerm(keyword: Keywords.flagged):
        return 'Unflagged';
      case KeywordTerm(keyword: Keywords.answered):
        return 'Unreplied';
      case HasAttachmentTerm():
        return 'No attachment';
      case HeaderTerm(:final name, value: ''):
        return 'No header $name';
      case RegexTerm(field: TextField.any, :final pattern, :final caseSensitive):
        return 'Doesn’t match ${regexLiteral(pattern, caseSensitive)}';
      case TextTerm(field: TextField.any) || HeaderTerm():
        return 'Not ${describe(child)}';
      case SearchAnd() || SearchOr() when toOrCcShape(child) == null && onlyShape(child) == null:
        return 'Not (${describe(child)})';
      default:
        final d = describe(child);
        return 'Not ${d[0].toLowerCase()}${d.substring(1)}';
    }
  }

  String _keyword(String k) {
    final status = statusNameFor(k, negated: false);
    if (status != null) return '${status[0].toUpperCase()}${status.substring(1)}';
    final label = tagLabel(k, tags);
    if (label != null) return 'Tagged $label';
    return Keywords.system.contains(k) ? 'Keyword $k' : 'Tagged $k';
  }

  static String _day(DateTime d) => '${d.day} ${monthAbbrevs[d.month - 1]} ${d.year}';
}

String fieldLabel(TextField f) => switch (f) {
  TextField.any => 'Text',
  TextField.from => 'From',
  TextField.to => 'To',
  TextField.cc => 'Cc',
  TextField.bcc => 'Bcc',
  TextField.recipients => 'Recipients',
  TextField.participants => 'Address',
  TextField.subject => 'Subject',
  TextField.body => 'Body',
  TextField.attachment => 'Attachment',
};
