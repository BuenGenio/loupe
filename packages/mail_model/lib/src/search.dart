import 'email.dart';
import 'mailbox.dart';

/// Search syntax tree shared by the query parser (expr_search), the local
/// store (SQL/FTS5), the IMAP/JMAP transports and the local matcher.
///
/// Text comparisons are case-insensitive substring matches unless stated
/// otherwise. Dates compare by local calendar day.
sealed class SearchExpr {
  const SearchExpr();
}

/// Matches every message. Used as the neutral element and when a server
/// can't evaluate a term (replacing it by [MatchAll] yields a superset).
final class MatchAll extends SearchExpr {
  const MatchAll();
  @override
  bool operator ==(Object other) => other is MatchAll;
  @override
  int get hashCode => 0;
  @override
  String toString() => 'MatchAll';
}

final class SearchAnd extends SearchExpr {
  const SearchAnd(this.children);
  final List<SearchExpr> children;
  @override
  bool operator ==(Object other) => other is SearchAnd && _listEquals(other.children, children);
  @override
  int get hashCode => Object.hashAll(['and', ...children]);
  @override
  String toString() => 'And(${children.join(', ')})';
}

final class SearchOr extends SearchExpr {
  const SearchOr(this.children);
  final List<SearchExpr> children;
  @override
  bool operator ==(Object other) => other is SearchOr && _listEquals(other.children, children);
  @override
  int get hashCode => Object.hashAll(['or', ...children]);
  @override
  String toString() => 'Or(${children.join(', ')})';
}

final class SearchNot extends SearchExpr {
  const SearchNot(this.child);
  final SearchExpr child;
  @override
  bool operator ==(Object other) => other is SearchNot && other.child == child;
  @override
  int get hashCode => Object.hash('not', child);
  @override
  String toString() => 'Not($child)';
}

/// Where a text term looks.
enum SearchField {
  /// Headers (from, to, cc, subject) and body.
  any,
  from,
  to,
  cc,
  bcc,

  /// to, cc or bcc.
  recipients,

  /// from, to, cc or bcc.
  participants,
  subject,
  body,

  /// Attachment file names and MIME types.
  attachment,
}

/// Substring match on a field.
final class TextTerm extends SearchExpr {
  const TextTerm(this.field, this.value);
  final SearchField field;
  final String value;
  @override
  bool operator ==(Object other) => other is TextTerm && other.field == field && other.value == value;
  @override
  int get hashCode => Object.hash(field, value);
  @override
  String toString() => 'Text(${field.name}: "$value")';
}

/// Regular expression on a field. Servers can't evaluate it; always applied
/// locally (the server gets a superset).
final class RegexTerm extends SearchExpr {
  const RegexTerm(this.field, this.pattern, {this.caseSensitive = false});
  final SearchField field;
  final String pattern;
  final bool caseSensitive;
  @override
  bool operator ==(Object other) =>
      other is RegexTerm && other.field == field && other.pattern == pattern && other.caseSensitive == caseSensitive;
  @override
  int get hashCode => Object.hash(field, pattern, caseSensitive);
  @override
  String toString() => 'Regex(${field.name}: /$pattern/${caseSensitive ? '' : 'i'})';
}

/// Substring match on an arbitrary header ("List-Id", "X-Mailer").
final class HeaderTerm extends SearchExpr {
  const HeaderTerm(this.name, this.value);
  final String name;
  final String value;
  @override
  bool operator ==(Object other) =>
      other is HeaderTerm && other.name.toLowerCase() == name.toLowerCase() && other.value == value;
  @override
  int get hashCode => Object.hash(name.toLowerCase(), value);
  @override
  String toString() => 'Header($name: "$value")';
}

/// The message has this keyword (flags such as `$seen`, or a tag). Negate
/// with [SearchNot] for "unread", "unreplied" and so on.
final class KeywordTerm extends SearchExpr {
  const KeywordTerm(this.keyword);
  final String keyword;
  @override
  bool operator ==(Object other) => other is KeywordTerm && other.keyword == keyword;
  @override
  int get hashCode => keyword.hashCode;
  @override
  String toString() => 'Keyword($keyword)';
}

enum DateComparison { before, onOrAfter, on }

/// Compares the received date by local calendar day.
final class DateTerm extends SearchExpr {
  const DateTerm(this.comparison, this.date);
  final DateComparison comparison;

  /// Only year, month and day are significant.
  final DateTime date;
  @override
  bool operator ==(Object other) =>
      other is DateTerm &&
      other.comparison == comparison &&
      other.date.year == date.year &&
      other.date.month == date.month &&
      other.date.day == date.day;
  @override
  int get hashCode => Object.hash(comparison, date.year, date.month, date.day);
  @override
  String toString() => 'Date(${comparison.name} ${date.year}-${date.month}-${date.day})';
}

enum SizeComparison { larger, smaller }

final class SizeTerm extends SearchExpr {
  const SizeTerm(this.comparison, this.bytes);
  final SizeComparison comparison;
  final int bytes;
  @override
  bool operator ==(Object other) => other is SizeTerm && other.comparison == comparison && other.bytes == bytes;
  @override
  int get hashCode => Object.hash(comparison, bytes);
  @override
  String toString() => 'Size(${comparison.name} $bytes)';
}

final class HasAttachmentTerm extends SearchExpr {
  const HasAttachmentTerm();
  @override
  bool operator ==(Object other) => other is HasAttachmentTerm;
  @override
  int get hashCode => 1;
  @override
  String toString() => 'HasAttachment';
}

/// Matches messages of an account whose name or address contains [value].
final class AccountTerm extends SearchExpr {
  const AccountTerm(this.value);
  final String value;
  @override
  bool operator ==(Object other) => other is AccountTerm && other.value == value;
  @override
  int get hashCode => value.hashCode;
  @override
  String toString() => 'Account("$value")';
}

bool _listEquals(List<SearchExpr> a, List<SearchExpr> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

/// Where to search.
sealed class SearchScope {
  const SearchScope();
}

final class AllMailboxesScope extends SearchScope {
  const AllMailboxesScope();
}

final class MailboxScope extends SearchScope {
  const MailboxScope(this.ref);
  final MailboxRef ref;
}

final class SearchRequest {
  const SearchRequest({
    required this.expr,
    required this.scope,
    this.text = '',
    this.includeServer = true,
    this.limit = 200,
  });

  /// The parsed query.
  final SearchExpr expr;

  /// What the user typed (for history and highlighting).
  final String text;
  final SearchScope scope;

  /// False for the instant, local-only pass while typing.
  final bool includeServer;
  final int limit;
}

/// One emission of a search stream. Local results arrive first; server
/// results are merged in as accounts answer.
final class SearchResults {
  const SearchResults({
    required this.items,
    this.pendingAccountIds = const {},
    this.failedAccountIds = const {},
    this.fromServerIds = const {},
  });

  /// Newest first, de-duplicated.
  final List<EmailSummary> items;

  /// Accounts whose server search is still running.
  final Set<String> pendingAccountIds;

  /// Accounts whose server search failed (results are local only).
  final Set<String> failedAccountIds;

  /// Ids of items found only on the server (not yet stored locally).
  final Set<String> fromServerIds;

  bool get isComplete => pendingAccountIds.isEmpty;
}
