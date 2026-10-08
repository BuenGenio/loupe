// PUBLIC API OF expr_search. The signatures in this file are a contract used
// by the app, mail_imap, mail_store and mail_sync; change them only in
// agreement with those packages. The implementations live in syntax/, eval/
// and compile/.

import 'package:clock/clock.dart';
import 'package:mail_model/mail_model.dart';

import 'compile/gmail.dart';
import 'compile/imap.dart';
import 'compile/jmap.dart';
import 'eval/matcher.dart';
import 'eval/normal_form.dart';
import 'syntax/format.dart';
import 'syntax/parser.dart';
import 'syntax/suggest.dart';

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
  const QuerySuggestion({
    required this.label,
    required this.insertText,
    this.detail,
    this.replaceStart,
    this.replaceEnd,
  });

  /// Shown in the list, e.g. "from: — sender contains".
  final String label;

  /// Replaces the word at the cursor.
  final String insertText;
  final String? detail;

  /// The range of the word at the cursor that [insertText] replaces (set by
  /// [suggest]).
  final int? replaceStart;
  final int? replaceEnd;

  @override
  String toString() => 'QuerySuggestion($insertText)';
}

/// Parses [input]. Never throws; problems are reported in [ParsedQuery.errors]
/// with a best-effort [ParsedQuery.expr]. [now] anchors relative dates
/// ("today", "7d"); it defaults to `clock.now()` (package:clock, so tests can
/// pin it with `withClock`). [tags] resolves `tag:` labels (Thunderbird's defaults
/// unless the account defines its own).
ParsedQuery parseQuery(String input, {DateTime? now, List<TagDefinition> tags = TagDefinition.thunderbirdDefaults}) {
  try {
    return QueryParser(input, now: now ?? clock.now(), tags: tags).parse();
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

/// Completions for the word at [cursor] in [input]: operators with a one-line
/// description, `is:` values, tag names, date and size shortcuts. [now]
/// dates the shortcuts; [tags] lists the tag names.
List<QuerySuggestion> suggest(
  String input,
  int cursor, {
  DateTime? now,
  List<TagDefinition> tags = TagDefinition.thunderbirdDefaults,
}) => suggestAt(input, cursor, now: now ?? clock.now(), tags: tags);

/// Pushes negations down to the terms (negation normal form). Nested AND/OR
/// of the same kind are flattened; `Not` remains only directly above terms.
SearchExpr toNnf(SearchExpr expr) => negationNormalForm(expr);

/// Replaces terms for which [supported] is false by [MatchAll] (in negation
/// normal form, so the result matches a superset) and simplifies.
///
/// [supported] receives the bare term, also for a negated one. AND drops
/// [MatchAll]; OR containing it becomes [MatchAll]; a result of [MatchAll]
/// means the server can't narrow the search at all.
SearchExpr widenForServer(SearchExpr expr, bool Function(SearchExpr term) supported) => widen(expr, supported);

/// Simplifies [expr] without changing what it matches: [MatchAll] and
/// `Not(MatchAll)` (nothing) are folded away, single children unwrapped,
/// nesting flattened and double negations cancelled.
SearchExpr simplifyQuery(SearchExpr expr) => simplify(expr);

/// Resolves [AccountTerm]s for the account labelled [accountLabel] (its name
/// and addresses), so each account's server gets only what concerns it. The
/// result is `Not(MatchAll)` when the query can't match in this account,
/// which callers can check with [matchesNothing] to skip the server.
SearchExpr bindAccountTerms(SearchExpr expr, String accountLabel) => bindAccount(expr, accountLabel);

/// Whether [expr] matches no message at all: it simplifies to nothing (see
/// [simplifyQuery]), or has a [findContradiction].
bool matchesNothing(SearchExpr expr) => simplify(expr) == matchNone || contradiction(expr) != null;

/// A term that [expr] requires both to hold and not to hold, which makes it
/// match nothing, or null if none is found: `KeywordTerm(Keywords.seen)` for
/// `is:read and is:unread`, the `from:` term for
/// `from:alice and not from:alice`. Finds a term next to its own negation,
/// also for operators that expand to several terms (`to:x and not to:x`);
/// other impossible queries (`before:2020 and after:2021`) aren't caught.
SearchExpr? findContradiction(SearchExpr expr) => contradiction(expr);

/// Evaluates [expr] against one message. Body and attachment terms need
/// [content]; without it they match (superset semantics). [accountLabel] is the
/// account's name and address, for [AccountTerm]. [headers] are extra header
/// fields (lower-cased names) for [HeaderTerm].
///
/// Terms that lack data are unknown rather than true, and unknown counts as
/// a match only at the end, so negated terms keep the superset property too.
bool matchesEmail(
  SearchExpr expr,
  EmailSummary email, {
  EmailContent? content,
  String? accountLabel,
  Map<String, String> headers = const {},
}) => EmailMatcher(email, content: content, accountLabel: accountLabel, headers: headers).matches(expr);

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
///
/// Works on the negation normal form and widens what IMAP can't express
/// (patterns, attachment presence and names, accounts) to ALL, setting
/// [ImapSearchQuery.exact] to false; there is no need to call
/// [widenForServer] first. Terms for which [supported] returns false are
/// widened too (e.g. BODY on servers without a full-text index). A query
/// that widens to everything compiles to `ALL`.
ImapSearchQuery compileImap(SearchExpr expr, {bool Function(SearchExpr term)? supported}) =>
    ImapCompiler(supported: supported).compile(expr);

/// Gmail search syntax for `X-GM-RAW`, or null if the query can't be expressed
/// (the caller then widens it first).
///
/// Use `compileGmailRaw(e) ?? compileGmailRaw(widenForServer(e, gmailSupports))!`.
/// Gmail matches whole words rather than substrings and has no body-only
/// operator (body terms become plain text), so post-filter the results with
/// [matchesEmail]. An empty string means "everything".
String? compileGmailRaw(SearchExpr expr) => compileGmail(expr);

/// Whether [compileGmailRaw] can express [term]; for [widenForServer].
bool gmailSupports(SearchExpr term) => gmailCanExpress(term);

/// A JMAP `Email/query` filter (FilterOperator / FilterCondition, RFC 8621).
///
/// Patterns, attachment names and accounts are widened first (see
/// [jmapSupports]); post-filter with [matchesEmail] when the query has any.
/// [MatchAll] compiles to an empty condition.
Map<String, Object?> compileJmapFilter(SearchExpr expr) => compileJmap(expr);

/// Whether [compileJmapFilter] keeps [term] (rather than widening it).
bool jmapSupports(SearchExpr term) => jmapCanExpress(term);
