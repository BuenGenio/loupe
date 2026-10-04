import 'package:mail_model/mail_model.dart';

import 'html_text.dart';

final _spaces = RegExp(r'\s+');

/// Lower-case with whitespace runs collapsed, for substring matching.
String _norm(String s) => s.toLowerCase().replaceAll(_spaces, ' ');

/// Evaluates expressions against one message with three-valued logic: a term
/// that needs data we don't have (the body without [content], an unknown
/// header, the account without a label, a zero size) is unknown (`null`),
/// and an unknown result counts as a match. Unknown propagates through
/// NOT, so `-b:x` without the body also matches: the result is a superset.
final class EmailMatcher {
  EmailMatcher(this.email, {this.content, this.accountLabel, this.headers = const {}});

  final EmailSummary email;
  final EmailContent? content;
  final String? accountLabel;
  final Map<String, String> headers;

  bool matches(SearchExpr e) => eval(e) ?? true;

  bool? eval(SearchExpr e) => switch (e) {
    MatchAll() => true,
    SearchAnd(:final children) => _all(children),
    SearchOr(:final children) => _any(children),
    SearchNot(:final child) => switch (eval(child)) {
      null => null,
      final v => !v,
    },
    TextTerm(:final field, :final value) => _text(field, value),
    RegexTerm(:final field, :final pattern, :final caseSensitive) => _regex(field, pattern, caseSensitive),
    HeaderTerm(:final name, :final value) => _header(name, value),
    KeywordTerm(:final keyword) => _keyword(Keywords.normalize(keyword)),
    DateTerm(:final comparison, :final date) => _date(comparison, date),
    SizeTerm(:final comparison, :final bytes) =>
      email.size <= 0 ? null : (comparison == SizeComparison.larger ? email.size > bytes : email.size < bytes),
    HasAttachmentTerm() => email.hasAttachment || (content?.visibleAttachments.isNotEmpty ?? false),
    AccountTerm(:final value) => accountLabel == null ? null : _norm(accountLabel!).contains(_norm(value)),
  };

  bool? _all(List<SearchExpr> xs) {
    var unknown = false;
    for (final x in xs) {
      switch (eval(x)) {
        case false:
          return false;
        case null:
          unknown = true;
        case true:
      }
    }
    return unknown ? null : true;
  }

  bool? _any(List<SearchExpr> xs) {
    var unknown = false;
    for (final x in xs) {
      switch (eval(x)) {
        case true:
          return true;
        case null:
          unknown = true;
        case false:
      }
    }
    return unknown ? null : false;
  }

  bool _keyword(String k) => email.keywords.contains(k) || email.keywords.any((x) => Keywords.normalize(x) == k);

  // ---------------------------------------------------------- text fields

  bool? _text(SearchField field, String value) {
    final needle = _norm(value);
    return _field(field, (hay) => _norm(hay).contains(needle));
  }

  bool? _regex(SearchField field, String pattern, bool caseSensitive) {
    final re = _compile(pattern, caseSensitive);
    if (re == null) return false;
    return _field(field, re.hasMatch);
  }

  /// Applies [test] to the texts of [field]. Each address is one text,
  /// `Name <address>` (or just the address without a name), so a pattern
  /// sees the whole address; `only:` relies on that.
  bool? _field(SearchField field, bool Function(String) test) {
    bool addresses(Iterable<EmailAddress> list) => list.any((a) {
      final name = a.name?.trim() ?? '';
      return test(name.isEmpty ? a.email : '$name <${a.email}>');
    });
    return switch (field) {
      SearchField.from => addresses(email.from),
      SearchField.to => addresses(email.to),
      SearchField.cc => addresses(email.cc),
      SearchField.bcc => addresses(email.bcc),
      SearchField.recipients => addresses([...email.to, ...email.cc, ...email.bcc]),
      SearchField.participants => addresses([...email.from, ...email.to, ...email.cc, ...email.bcc]),
      SearchField.subject => test(email.subject),
      SearchField.body => _body(test),
      SearchField.attachment => _attachments(test),
      SearchField.any =>
        addresses([...email.from, ...email.to, ...email.cc]) || test(email.subject) ? true : _body(test),
    };
  }

  late final String? _bodyText = switch (content) {
    null => null,
    EmailContent(:final text?) when text.trim().isNotEmpty => text.replaceAll(_spaces, ' '),
    EmailContent(:final html?) => htmlToText(html).replaceAll(_spaces, ' '),
    _ => '',
  };

  /// Without content, a hit in the preview is a hit; otherwise unknown.
  bool? _body(bool Function(String) test) {
    final body = _bodyText;
    if (body != null) return test(body);
    return test(email.preview) ? true : null;
  }

  bool? _attachments(bool Function(String) test) {
    final c = content;
    if (c == null) return email.hasAttachment ? null : false;
    return c.attachments.any((a) => test(a.filename ?? '') || test(a.mimeType));
  }

  // ---------------------------------------------------------- headers

  bool? _header(String name, String value) {
    final lower = name.toLowerCase();
    final values = <String>[];
    var known = false;
    for (final MapEntry(:key, value: v) in headers.entries) {
      if (key.toLowerCase() == lower) {
        values.add(v);
        known = true;
      }
    }
    final c = content;
    if (c != null && c.headers.isNotEmpty) {
      known = true;
      for (final (n, v) in c.headers) {
        if (n.toLowerCase() == lower) values.add(v);
      }
    }
    final derived = _derivedHeader(lower);
    if (derived != null) {
      known = true;
      values.addAll(derived);
    }
    if (!known) return null;
    final needle = _norm(value);
    return values.any((v) => _norm(v).contains(needle));
  }

  /// Header values the summary already knows; null when it doesn't know.
  List<String>? _derivedHeader(String name) {
    List<String> list(List<EmailAddress> a) => a.isEmpty ? const [] : [a.join(', ')];
    return switch (name) {
      'subject' => [email.subject],
      'from' => list(email.from),
      'to' => list(email.to),
      'cc' => list(email.cc),
      'bcc' => list(email.bcc),
      'reply-to' => list(email.replyTo),
      'message-id' => email.messageIdHeader == null ? null : ['<${email.messageIdHeader}>'],
      'in-reply-to' => email.inReplyTo == null ? null : ['<${email.inReplyTo}>'],
      _ => null,
    };
  }

  bool _date(DateComparison comparison, DateTime date) {
    final r = email.receivedAt.toLocal();
    final day = DateTime(r.year, r.month, r.day);
    final d = DateTime(date.year, date.month, date.day);
    return switch (comparison) {
      DateComparison.before => day.isBefore(d),
      DateComparison.onOrAfter => !day.isBefore(d),
      DateComparison.on => day == d,
    };
  }
}

final _regexCache = <(String, bool), RegExp?>{};

/// Compiles (and caches) a pattern; null if it is invalid.
RegExp? _compile(String pattern, bool caseSensitive) {
  final key = (pattern, caseSensitive);
  if (_regexCache.containsKey(key)) return _regexCache[key];
  if (_regexCache.length > 256) _regexCache.clear();
  RegExp? re;
  try {
    re = RegExp(pattern, caseSensitive: caseSensitive);
  } on FormatException {
    re = null;
  }
  return _regexCache[key] = re;
}
