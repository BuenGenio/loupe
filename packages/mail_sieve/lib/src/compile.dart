/// Compiling search expressions to Sieve tests (RFC 5228 and extensions).
library;

import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';

import 'sieve_text.dart';

/// The Sieve extensions Loupe can use. Compiling with `extensions: null`
/// assumes a server that has all of them.
const loupeSieveExtensions = {
  'body',
  'copy',
  'date',
  'fileinto',
  'imap4flags',
  'include',
  'mailbox',
  'mime',
  'regex',
  'relational',
};

/// Why (part of) a query can't run on the server.
final class SieveProblem {
  const SieveProblem(this.message, [this.term]);

  /// Shown after "Can't run on the server: ", e.g. "“Unread”: new mail is
  /// always unread when it arrives".
  final String message;

  /// The term at fault, if one is.
  final SearchExpr? term;

  @override
  bool operator ==(Object other) => other is SieveProblem && other.message == message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'SieveProblem($message)';
}

/// A compiled Sieve test, or the problems that kept the query from
/// compiling. Problems are never silently dropped: a query compiles exactly
/// or not at all.
final class SieveTest {
  const SieveTest(this.test, this.requires, this.problems);

  /// The test, e.g. `address :domain :is "from" "example.com"`; null when
  /// there are [problems]. May span several lines (indented by two spaces).
  final String? test;

  /// The extensions the test needs (`body`, `regex`, …).
  final Set<String> requires;
  final List<SieveProblem> problems;

  bool get ok => problems.isEmpty && test != null;
}

/// Compiles [expr] to a Sieve test.
///
/// - from, to, cc, bcc: `address :all :is` for a full address,
///   `address :domain :is` for `@domain`, `address :all :contains` for
///   other address fragments, `header :contains` for names.
/// - subject and other headers: `header :contains`; a header without a value
///   tests `exists`.
/// - body: `body :text :contains` (the body extension); bare words search
///   the address headers, the subject and the body.
/// - attachments: `header :mime :anychild` (the mime extension).
/// - size: `size :over` / `:under`. Patterns: `:regex` (the regex
///   extension), when they don't use Perl-only syntax.
/// - tags: `hasflag` (imap4flags), which sees what earlier rules set.
/// - absolute dates: `currentdate` (date, relational).
/// - and, or, not: `allof`, `anyof`, `not`.
///
/// Terms that make no sense when mail is delivered (read and replied
/// state, accounts, dates relative to today as told by [isRelativeDate]) or
/// that need an extension missing from [extensions] are reported in
/// [SieveTest.problems]. [extensions] null assumes every extension in
/// [loupeSieveExtensions].
SieveTest compileSieve(
  SearchExpr expr, {
  Set<String>? extensions,
  bool Function(DateTerm term)? isRelativeDate,
  List<TagDefinition> tags = TagDefinition.thunderbirdDefaults,
}) {
  final c = _SieveCompiler(extensions, isRelativeDate, tags);
  final test = c.node(simplifyQuery(expr), 0);
  final problems = c.problems.toSet().toList();
  return SieveTest(problems.isEmpty ? test : null, problems.isEmpty ? c.requires : const {}, problems);
}

/// Keywords that never exist when mail is delivered.
const _stateKeywords = {
  Keywords.seen,
  Keywords.answered,
  Keywords.forwarded,
  Keywords.draft,
  Keywords.junk,
  Keywords.notJunk,
  r'$deleted',
  r'$mdnsent',
};

final class _SieveCompiler {
  _SieveCompiler(this.extensions, this.isRelativeDate, this.tags);

  final Set<String>? extensions;
  final bool Function(DateTerm term)? isRelativeDate;
  final List<TagDefinition> tags;
  final requires = <String>{};
  final problems = <SieveProblem>[];

  /// Requires [ext], or reports [why] for [shown]. Returns whether it is there.
  bool _need(String ext, SearchExpr shown, String why) {
    if (extensions == null || extensions!.contains(ext)) {
      requires.add(ext);
      return true;
    }
    _problem(shown, why);
    return false;
  }

  String? _problem(SearchExpr shown, String why) {
    problems.add(SieveProblem('“${describeTerm(shown, tags: tags)}”: $why', shown));
    return null;
  }

  /// [e] as a test at nesting [depth], or null if part of it can't compile
  /// (the problem is recorded; compiling goes on to find the others).
  String? node(SearchExpr e, int depth) {
    switch (e) {
      case SearchAnd(:final children):
        return _group('allof', children, depth);
      case SearchOr(:final children):
        return _group('anyof', children, depth);
      case SearchNot(child: MatchAll()):
        return 'false';
      case SearchNot(:final child):
        final inner = child is SearchAnd || child is SearchOr || child is SearchNot
            ? node(child, depth)
            : _leaf(child, e);
        return inner == null ? null : 'not $inner';
      default:
        return _leaf(e, e);
    }
  }

  String? _group(String name, List<SearchExpr> children, int depth) {
    final parts = [for (final c in children) node(c, depth + 1)];
    if (parts.contains(null)) return null;
    final oneLine = '$name(${parts.join(', ')})';
    if (oneLine.length + depth * 2 <= 90 && !oneLine.contains('\n')) return oneLine;
    final indent = '  ' * (depth + 1);
    return '$name(\n${parts.map((p) => '$indent$p').join(',\n')}\n${'  ' * depth})';
  }

  String? _leaf(SearchExpr t, SearchExpr shown) {
    switch (t) {
      case MatchAll():
        return 'true';
      case TextTerm(:final field, :final value):
        return _text(field, value, shown);
      case RegexTerm(:final field, :final pattern, :final caseSensitive):
        return _regex(field, pattern, caseSensitive, shown);
      case HeaderTerm(:final name, :final value):
        if (!_isFieldName(name)) return _problem(shown, '“$name” isn’t a header name the server accepts');
        if (_hasLineBreak(value)) return _problem(shown, 'the text has a line break');
        if (value.isEmpty) return 'exists ${sieveString(name)}';
        return 'header :contains ${sieveString(name)} ${sieveString(value)}';
      case KeywordTerm(:final keyword):
        final k = Keywords.normalize(keyword);
        if (_stateKeywords.contains(k)) {
          return _problem(shown, 'new mail has no read, replied or junk state when it arrives');
        }
        if (!_need('imap4flags', shown, 'the server can’t check tags (no imap4flags extension)')) return null;
        return 'hasflag ${sieveString(sieveFlag(k))}';
      case DateTerm(:final comparison, :final date):
        if (isRelativeDate?.call(t) ?? false) {
          return _problem(shown, 'dates relative to today change every day, but a server rule is fixed when saved');
        }
        const why = 'the server can’t compare dates (no date extension)';
        if (!_need('date', shown, why)) return null;
        final day = sieveString(_isoDay(date));
        if (comparison == DateComparison.on) return 'currentdate :is "date" $day';
        if (!_need('relational', shown, 'the server can’t compare dates (no relational extension)')) return null;
        return 'currentdate :value ${comparison == DateComparison.before ? '"lt"' : '"ge"'} "date" $day';
      case SizeTerm(:final comparison, :final bytes):
        return comparison == SizeComparison.larger ? 'size :over $bytes' : 'size :under $bytes';
      case HasAttachmentTerm():
        if (!_need('mime', shown, 'the server can’t look at attachments (no mime extension)')) return null;
        return 'header :mime :anychild :contains "Content-Disposition" "attachment"';
      case AccountTerm():
        return _problem(shown, 'a server only sees its own account’s mail; choose the accounts of the rule instead');
      case SearchAnd() || SearchOr() || SearchNot():
        return node(t, 0);
    }
  }

  static const _bodyWhy = 'the server can’t search message bodies (no body extension)';
  static const _mimeWhy = 'the server can’t look at attachments (no mime extension)';

  String? _text(SearchField field, String value, SearchExpr shown) {
    if (_hasLineBreak(value)) return _problem(shown, 'the text has a line break');
    final v = sieveString(value);
    switch (field) {
      case SearchField.body:
        if (!_need('body', shown, _bodyWhy)) return null;
        return 'body :text :contains $v';
      case SearchField.attachment:
        if (!_need('mime', shown, _mimeWhy)) return null;
        return 'anyof(header :mime :anychild :param "filename" :contains "Content-Disposition" $v, '
            'header :mime :anychild :param "name" :contains "Content-Type" $v, '
            'header :mime :anychild :contenttype :contains "Content-Type" $v)';
      case SearchField.any:
        if (!_need('body', shown, _bodyWhy)) return null;
        return 'anyof(header :contains ["from", "to", "cc", "subject"] $v, body :text :contains $v)';
      case SearchField.subject:
        return 'header :contains "subject" $v';
      case SearchField.from ||
          SearchField.to ||
          SearchField.cc ||
          SearchField.bcc ||
          SearchField.recipients ||
          SearchField.participants:
        return _address(_addressHeaders(field), value);
    }
  }

  static List<String> _addressHeaders(SearchField field) => switch (field) {
    SearchField.from => const ['from'],
    SearchField.to => const ['to'],
    SearchField.cc => const ['cc'],
    SearchField.bcc => const ['bcc'],
    SearchField.recipients => const ['to', 'cc', 'bcc'],
    _ => const ['from', 'to', 'cc', 'bcc'],
  };

  static final _domain = RegExp(r'^@([a-z0-9-]+\.)+[a-z0-9-]+$', caseSensitive: false);
  static final _fullAddress = RegExp(r'^[^\s@<>"(),;:]+@([a-z0-9-]+\.)+[a-z0-9-]+$', caseSensitive: false);

  /// An address test where the value clearly is (part of) an address, else
  /// a header test, which also sees display names.
  static String _address(List<String> headers, String value) {
    final h = sieveStringList(headers);
    final v = value.trim();
    if (_domain.hasMatch(v)) return 'address :domain :is $h ${sieveString(v.substring(1))}';
    if (_fullAddress.hasMatch(v)) return 'address :all :is $h ${sieveString(v)}';
    if (!v.contains(RegExp(r'\s')) && (v.contains('@') || v.contains('.'))) {
      return 'address :all :contains $h ${sieveString(v)}';
    }
    return 'header :contains $h ${sieveString(value)}';
  }

  String? _regex(SearchField field, String pattern, bool caseSensitive, SearchExpr shown) {
    if (!_need('regex', shown, 'the server has no regular expressions (no regex extension)')) return null;
    final issue = posixIssue(pattern);
    if (issue != null) return _problem(shown, 'the pattern uses $issue, which the server’s patterns don’t have');
    if (_hasLineBreak(pattern)) return _problem(shown, 'the pattern has a line break');
    final cmp = caseSensitive ? ':comparator "i;octet" ' : '';
    final p = sieveString(pattern);
    switch (field) {
      case SearchField.body:
        if (!_need('body', shown, _bodyWhy)) return null;
        return 'body :text :regex $cmp$p';
      case SearchField.attachment:
        if (!_need('mime', shown, _mimeWhy)) return null;
        return 'anyof(header :mime :anychild :param "filename" :regex $cmp"Content-Disposition" $p, '
            'header :mime :anychild :contenttype :regex $cmp"Content-Type" $p)';
      case SearchField.any:
        if (!_need('body', shown, _bodyWhy)) return null;
        return 'anyof(header :regex $cmp["from", "to", "cc", "subject"] $p, body :text :regex $cmp$p)';
      case SearchField.subject:
        return 'header :regex $cmp"subject" $p';
      case SearchField.from ||
          SearchField.to ||
          SearchField.cc ||
          SearchField.bcc ||
          SearchField.recipients ||
          SearchField.participants:
        return 'header :regex $cmp${sieveStringList(_addressHeaders(field))} $p';
    }
  }

  static bool _hasLineBreak(String s) => s.contains('\n') || s.contains('\r');

  /// A header field name: printable ASCII without colon or space.
  static bool _isFieldName(String n) => n.isNotEmpty && n.codeUnits.every((u) => u > 0x20 && u < 0x7f && u != 0x3a);

  static String _isoDay(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

/// What in [pattern] (a Dart/Perl-style regular expression) POSIX extended
/// regular expressions, which Sieve's regex extension uses, don't have; null
/// if nothing.
String? posixIssue(String pattern) {
  for (var i = 0; i < pattern.length; i++) {
    final c = pattern[i];
    final next = i + 1 < pattern.length ? pattern[i + 1] : '';
    if (c == r'\') {
      if ('dDwWsSbB'.contains(next) && next.isNotEmpty) return 'shorthands like \\$next';
      if (RegExp('[1-9]').hasMatch(next)) return 'back-references';
      if ('ntrfvuxcpPkA'.contains(next) && next.isNotEmpty) return 'escapes like \\$next';
      i++;
      continue;
    }
    if (c == '(' && next == '?') return 'look-arounds or (?:…) groups';
    if ('*+?}'.contains(c) && next == '?') return 'lazy quantifiers';
  }
  return null;
}
