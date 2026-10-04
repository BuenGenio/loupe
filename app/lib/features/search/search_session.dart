import 'dart:async';

import 'package:expr_search/expr_search.dart';
// mail_model's TextField (search fields) is meant here, not the widget.
import 'package:flutter/material.dart' hide TextField;
import 'package:mail_model/mail_model.dart';

import '../../shared/tags.dart';

/// Query text for a structured term: the canonical syntax when [formatQuery]
/// round-trips it, otherwise [fallback] (common search-language spellings).
String queryTextFor(SearchExpr term, String fallback) {
  final text = formatQuery(term);
  return parseQuery(text).expr == term ? text : fallback;
}

/// Suggestion tokens offered when the search field is empty.
abstract final class SearchTokens {
  static String get unread => queryTextFor(const SearchNot(KeywordTerm(Keywords.seen)), 'is:unread');
  static String get flagged => queryTextFor(const KeywordTerm(Keywords.flagged), 'is:flagged');
  static String get attachments => queryTextFor(const HasAttachmentTerm(), 'has:attachment');
  static String get unreplied => queryTextFor(const SearchNot(KeywordTerm(Keywords.answered)), 'is:unreplied');

  static String tag(String keyword) {
    final label = tagLabel(keyword);
    return queryTextFor(KeywordTerm(keyword), label.contains(' ') ? 'tag:"$label"' : 'tag:${label.toLowerCase()}');
  }

  static String from(EmailAddress address) =>
      queryTextFor(TextTerm(TextField.from, address.email), 'from:${address.email}');
}

/// The top-level AND terms of a query, shown as chips.
List<SearchExpr> queryTerms(SearchExpr expr) => switch (expr) {
  MatchAll() => const [],
  SearchAnd(:final children) => children,
  _ => [expr],
};

/// Rebuilds query text from chips.
String queryFromTerms(List<SearchExpr> terms) => switch (terms.length) {
  0 => '',
  1 => formatQuery(terms.single),
  _ => formatQuery(SearchAnd(terms)),
};

/// Highlights the search language as the user types: operators, quoted
/// values, keywords and errors, from [ParsedQuery.tokens].
class QueryTextController extends TextEditingController {
  QueryTextController({super.text});

  Color operatorColor = Colors.blue;
  Color keywordColor = Colors.purple;
  Color quotedColor = Colors.teal;
  Color errorColor = Colors.red;

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    final parsed = parseQuery(text);
    if (parsed.tokens.isEmpty || (withComposing && value.isComposingRangeValid)) {
      return super.buildTextSpan(context: context, style: style, withComposing: withComposing);
    }
    final spans = <TextSpan>[];
    var pos = 0;
    for (final t in parsed.tokens) {
      if (t.start < pos || t.end > text.length || t.start > t.end) continue;
      if (t.start > pos) spans.add(TextSpan(text: text.substring(pos, t.start)));
      final tokenStyle = switch (t.kind) {
        QueryTokenKind.operatorName => TextStyle(color: operatorColor, fontWeight: FontWeight.w500),
        QueryTokenKind.keyword => TextStyle(color: keywordColor, fontWeight: FontWeight.w500),
        QueryTokenKind.quoted || QueryTokenKind.regex => TextStyle(color: quotedColor),
        QueryTokenKind.error => TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: errorColor,
          decorationStyle: TextDecorationStyle.wavy,
        ),
        _ => null,
      };
      spans.add(TextSpan(text: text.substring(t.start, t.end), style: tokenStyle));
      pos = t.end;
    }
    if (pos < text.length) spans.add(TextSpan(text: text.substring(pos)));
    return TextSpan(style: style, children: spans);
  }
}

/// One search in progress: the query text, its scope and the streamed
/// results. Typing runs a local-only search after ~150 ms and the full
/// search (local, then each account's server) after ~350 ms.
class SearchSession extends ChangeNotifier {
  SearchSession({
    required this.repository,
    this.scope = const AllMailboxesScope(),
    String initialQuery = '',
    this.localDelay = const Duration(milliseconds: 150),
    this.fullDelay = const Duration(milliseconds: 350),
  }) : controller = QueryTextController(text: initialQuery) {
    if (initialQuery.trim().isNotEmpty) _run(includeServer: true);
  }

  final MailRepository repository;
  final QueryTextController controller;
  final Duration localDelay;
  final Duration fullDelay;
  SearchScope scope;

  SearchResults? results;

  /// The text the current [results] belong to.
  String resultsQuery = '';
  Timer? _localTimer;
  Timer? _fullTimer;
  StreamSubscription<SearchResults>? _subscription;
  bool _disposed = false;

  String get query => controller.text;
  bool get hasQuery => query.trim().isNotEmpty;
  ParsedQuery get parsed => parseQuery(query);

  /// Call from the field's onChanged.
  void onChanged(String _) {
    _cancelTimers();
    if (!hasQuery) {
      _stop();
      results = null;
      resultsQuery = '';
      notifyListeners();
      return;
    }
    _localTimer = Timer(localDelay, () => _run(includeServer: false));
    _fullTimer = Timer(fullDelay, () => _run(includeServer: true));
    notifyListeners();
  }

  /// Return pressed: search everywhere now.
  void submit() {
    _cancelTimers();
    if (hasQuery) _run(includeServer: true);
  }

  /// Replaces the query (suggestions, chips) and searches at once.
  void setQuery(String text) {
    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
    _cancelTimers();
    if (text.trim().isEmpty) {
      onChanged(text);
    } else {
      _run(includeServer: true);
      notifyListeners();
    }
  }

  /// Appends a token ("is:unread") to what is already typed.
  void addToken(String token) {
    final current = query.trimRight();
    setQuery(current.isEmpty ? '$token ' : '$current $token ');
  }

  void setScope(SearchScope next) {
    scope = next;
    if (hasQuery) _run(includeServer: true);
    notifyListeners();
  }

  void clear() {
    _cancelTimers();
    _stop();
    controller.clear();
    results = null;
    resultsQuery = '';
    notifyListeners();
  }

  /// Runs the current query again (pull to refresh in a smart mailbox).
  Future<void> rerun() async {
    if (!hasQuery) return;
    _run(includeServer: true);
  }

  void _run({required bool includeServer}) {
    final text = query;
    final request = SearchRequest(expr: parseQuery(text).expr, text: text, scope: scope, includeServer: includeServer);
    _stop();
    _subscription = repository.search(request).listen((r) {
      if (_disposed) return;
      results = r;
      resultsQuery = text;
      notifyListeners();
    });
  }

  void _cancelTimers() {
    _localTimer?.cancel();
    _fullTimer?.cancel();
  }

  void _stop() {
    unawaited(_subscription?.cancel());
    _subscription = null;
  }

  @override
  void dispose() {
    _disposed = true;
    _cancelTimers();
    _stop();
    controller.dispose();
    super.dispose();
  }
}
