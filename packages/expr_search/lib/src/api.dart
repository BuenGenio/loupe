// PUBLIC API OF expr_search. The signatures in this file are a contract used
// by the app, mail_imap, mail_store and mail_sync; change them only in
// agreement with those packages. The bodies are temporary stubs.

import 'package:mail_model/mail_model.dart';

import 'syntax/format.dart';
import 'syntax/parser.dart';

/// A parse problem, with the character range it refers to.
final class QueryError {
  const QueryError(this.message, this.start, this.end);
  final String message;
  final int start;
  final int end;
  @override
  String toString() => 'QueryError($start-$end: $message)';
}

enum QueryTokenKind {
  /// `from:`, `f:`, `is:` …
  operatorName,

  /// The value after an operator, or a bare word.
  value,

  /// A quoted value.
  quoted,

  /// A /regex/.
  regex,

  /// `and`, `or`, `not`, `-`.
  keyword,
  paren,
  error,
}

/// A lexical token with its source range, for syntax highlighting and chips.
final class QueryToken {
  const QueryToken(this.kind, this.start, this.end, this.text);
  final QueryTokenKind kind;
  final int start;
  final int end;
  final String text;
}

final class ParsedQuery {
  const ParsedQuery({required this.expr, this.errors = const [], this.tokens = const []});

  /// Best-effort result; [MatchAll] for empty input.
  final SearchExpr expr;
  final List<QueryError> errors;
  final List<QueryToken> tokens;
  bool get isValid => errors.isEmpty;
}

/// A completion offered while typing, e.g. `from:` or `is:unread`.
final class QuerySuggestion {
  const QuerySuggestion({required this.label, required this.insertText, this.detail});

  /// Shown in the list, e.g. "from: — sender contains".
  final String label;

  /// Replaces the word at the cursor.
  final String insertText;
  final String? detail;
}

/// Parses [input]. Never throws; problems are reported in [ParsedQuery.errors]
/// with a best-effort [ParsedQuery.expr]. [now] anchors relative dates
/// ("today", "7d"). [tags] resolves `tag:` labels (Thunderbird's defaults
/// unless the account defines its own).
ParsedQuery parseQuery(String input, {DateTime? now, List<TagDefinition> tags = TagDefinition.thunderbirdDefaults}) {
  try {
    return QueryParser(input, now: now ?? DateTime.now(), tags: tags).parse();
  } on Object {
    // Only absurd nesting (stack overflow) gets here.
    return ParsedQuery(expr: const MatchAll(), errors: [QueryError('Query too complex', 0, input.length)]);
  }
}

/// Canonical text for [expr]; `parseQuery(formatQuery(e)).expr == e`.
///
/// Holds for expressions the parser can produce: compound nodes with at least
/// two children and no [MatchAll] below the root (others are simplified
/// first), lower-case keywords, and regex patterns without `\/`.
String formatQuery(SearchExpr expr, {List<TagDefinition> tags = TagDefinition.thunderbirdDefaults}) =>
    QueryFormatter(tags).format(expr);

/// A short human description of one term, for chips ("From: alice",
/// "Unread", "Not tagged Work", "Before 1 Mar 2026").
String describeTerm(SearchExpr expr, {List<TagDefinition> tags = TagDefinition.thunderbirdDefaults}) =>
    TermDescriber(tags).describe(expr);

/// Completions for the word at [cursor] in [input].
List<QuerySuggestion> suggest(String input, int cursor) => const [];

/// Pushes negations down to the terms (negation normal form).
SearchExpr toNnf(SearchExpr expr) => expr;

/// Replaces terms for which [supported] is false by [MatchAll] (in negation
/// normal form, so the result matches a superset) and simplifies.
SearchExpr widenForServer(SearchExpr expr, bool Function(SearchExpr term) supported) => expr;

/// Evaluates [expr] against one message. Body and attachment terms need
/// [content]; without it they match (superset semantics). [accountLabel] is the
/// account's name and address, for [AccountTerm]. [headers] are extra header
/// fields (lower-cased names) for [HeaderTerm].
bool matchesEmail(
  SearchExpr expr,
  EmailSummary email, {
  EmailContent? content,
  String? accountLabel,
  Map<String, String> headers = const {},
}) {
  bool contains(String hay, String needle) => hay.toLowerCase().contains(needle.toLowerCase());
  return switch (expr) {
    MatchAll() => true,
    SearchAnd(:final children) => children.every(
      (c) => matchesEmail(c, email, content: content, accountLabel: accountLabel, headers: headers),
    ),
    SearchOr(:final children) => children.any(
      (c) => matchesEmail(c, email, content: content, accountLabel: accountLabel, headers: headers),
    ),
    SearchNot(:final child) => !matchesEmail(
      child,
      email,
      content: content,
      accountLabel: accountLabel,
      headers: headers,
    ),
    KeywordTerm(:final keyword) => email.keywords.contains(keyword),
    TextTerm(field: TextField.subject, :final value) => contains(email.subject, value),
    TextTerm(field: TextField.from, :final value) => email.from.any((a) => contains(a.toString(), value)),
    TextTerm(:final value) => contains(
      '${email.subject} ${email.from.join(' ')} ${email.to.join(' ')} ${email.preview}',
      value,
    ),
    _ => true,
  };
}

/// IMAP SEARCH criteria for a query.
final class ImapSearchQuery {
  const ImapSearchQuery({required this.criteria, required this.exact, this.useUtf8 = false});

  /// The criteria after `UID SEARCH`, e.g. `OR FROM "alice" SUBJECT "invoice"`.
  final String criteria;

  /// False if terms were widened; the caller must post-filter with [matchesEmail].
  final bool exact;

  /// True if the criteria contain non-ASCII text and need `CHARSET UTF-8`
  /// (or UTF8=ACCEPT).
  final bool useUtf8;
}

/// Compiles for IMAP SEARCH (RFC 3501 keys; nested OR/NOT/parentheses).
ImapSearchQuery compileImap(SearchExpr expr) => const ImapSearchQuery(criteria: 'ALL', exact: false);

/// Gmail search syntax for `X-GM-RAW`, or null if the query can't be expressed
/// (the caller then widens it first).
String? compileGmailRaw(SearchExpr expr) => null;

/// A JMAP `Email/query` filter (FilterOperator / FilterCondition, RFC 8621).
Map<String, Object?> compileJmapFilter(SearchExpr expr) => const {};
