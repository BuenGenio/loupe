// Random expressions and messages for property tests.
import 'dart:math';

import 'package:mail_model/mail_model.dart';

/// Random expressions in the shape the parser produces (compound nodes with
/// two or more children, no MatchAll below the root, lower-case keywords).
final class ExprGen {
  ExprGen(int seed) : r = Random(seed);
  final Random r;

  T pick<T>(List<T> xs) => xs[r.nextInt(xs.length)];

  static const _pieces = [
    'alice', 'Bob', 'a b', 'or', 'AND', 'not', '-x', '/x', 'x:y', '"q"', r'back\slash', '(p)', 'é', 'emoji 😀', //
    '', ' lead', 'trail ', 'tab\tsep', 'f:x', 'is:read', '“smart”', 'a,b', 'x-y', '#2', 'na', 'today', 'line\nbreak',
    'invoice', '2026-03-01', 'Ünïcode', r'\"', 'and', 'NOT',
  ];

  static const _patterns = [
    '^a', r'b$', r'\d+', 'a/b', '[/]', r'x\.y', '(a|b)', r'\\', '.*', 'é+', ' ', 'a b', r'[\]/]', '"q"', r'\(', //
    r'^\[jira\]', r'(?<!x)y', '[a-z]{2,3}', r'\/', 'or',
  ];

  static const _keywords = [
    r'$seen', r'$flagged', r'$answered', r'$draft', r'$forwarded', r'$junk', r'$notjunk', r'$mdnsent', //
    r'$label1', r'$label2', r'$label3', r'$label4', r'$label5', 'work', 'important', 'projectx', 'na', '#2',
    'to do', 'a"b', 'o', 'x:y', 'later',
  ];

  String value() {
    final n = r.nextInt(3);
    return [for (var i = 0; i < n; i++) pick(_pieces)].join();
  }

  String nonEmptyValue() {
    final v = value();
    return v.isEmpty ? 'v' : v;
  }

  /// A valid pattern in normal form (no escaped slash).
  String pattern() {
    final p = pick(_patterns);
    return p == r'\/' ? '/' : p;
  }

  DateTime date() => switch (r.nextInt(5)) {
    0 => DateTime(1990 + r.nextInt(50)),
    1 => DateTime(2000 + r.nextInt(40), 3),
    2 => DateTime(2026, 3, 29),
    _ => DateTime(1990 + r.nextInt(50), 1 + r.nextInt(12), 1 + r.nextInt(28)),
  };

  int bytes() => pick([0, 1, 1023, 1024, 1536, 500 * 1024, 2 << 20, 3 << 30, r.nextInt(1 << 30)]);

  SearchExpr root() => r.nextInt(30) == 0 ? const MatchAll() : expr(4);

  SearchExpr expr(int depth) {
    if (depth <= 0 || r.nextInt(3) == 0) return term();
    List<SearchExpr> kids() => [for (var i = 0; i < 2 + r.nextInt(3); i++) expr(depth - 1)];
    return switch (r.nextInt(3)) {
      0 => SearchAnd(kids()),
      1 => SearchOr(kids()),
      _ => SearchNot(expr(depth - 1)),
    };
  }

  SearchExpr term() {
    final field = pick(TextField.values);
    return switch (r.nextInt(12)) {
      0 || 1 => TextTerm(field, value()),
      2 => RegexTerm(field, pattern(), caseSensitive: r.nextBool()),
      3 => HeaderTerm(pick(['List-Id', 'X-Mailer', 'x-spam-flag', 'Received']), r.nextBool() ? '' : value()),
      4 => KeywordTerm(pick(_keywords)),
      5 => DateTerm(pick(DateComparison.values), date()),
      6 => SizeTerm(pick(SizeComparison.values), bytes()),
      7 => const HasAttachmentTerm(),
      8 => AccountTerm(value()),
      9 => _toOrCc(),
      10 => _only(),
      _ => _simple(),
    };
  }

  SearchExpr _toOrCc() {
    if (r.nextBool()) {
      final v = value();
      return SearchOr([TextTerm(TextField.to, v), TextTerm(TextField.cc, v)]);
    }
    final p = pattern();
    final cs = r.nextBool();
    return SearchOr([RegexTerm(TextField.to, p, caseSensitive: cs), RegexTerm(TextField.cc, p, caseSensitive: cs)]);
  }

  SearchExpr _only() {
    final people = [
      for (var i = 0; i < 1 + r.nextInt(3); i++) pick(['tom', 'Jerry Smith', 'a"b', 'x.y', 'é']),
    ];
    return SearchAnd([
      for (final p in people) TextTerm(TextField.to, p),
      SearchNot(RegexTerm(TextField.to, '^(?!.*(?:${people.map(RegExp.escape).join('|')}))')),
    ]);
  }

  SearchExpr _simple() {
    final v = nonEmptyValue().trim();
    final s = v.isEmpty ? 'x' : v;
    return SearchAnd([
      TextTerm(TextField.subject, s),
      RegexTerm(TextField.subject, RegExp.escape(s), caseSensitive: true),
    ]);
  }
}

/// Literals built from the words [EmailGen] uses, so they hit and miss
/// generated messages often, in every field.
List<SearchExpr> vocabularyLiterals() {
  const words = ['alice', 'bob', 'invoice', 'tom', 'example.org', 'x.y', 'team-x', 'jerry smith', 'é', 'pdf'];
  return [
    for (final f in TextField.values)
      for (final w in words) TextTerm(f, w),
    for (final h in ['List-Id', 'X-Mailer', 'X-Absent'])
      for (final w in ['', ...words]) HeaderTerm(h, w),
    for (final k in [r'$seen', r'$flagged', r'$answered', r'$draft', r'$label2', 'work', r'$forwarded']) KeywordTerm(k),
    for (final c in DateComparison.values)
      for (final y in [2000, 2020, 2039]) DateTerm(c, DateTime(y, 6, 15)),
    for (final c in SizeComparison.values)
      for (final b in [100, 1024, 1536, 600 * 1024]) SizeTerm(c, b),
    const HasAttachmentTerm(),
    const AccountTerm('work'),
    const RegexTerm(TextField.subject, '^a'),
  ];
}

/// Random messages with optional content, for matcher properties.
final class EmailGen {
  EmailGen(int seed) : r = Random(seed);
  final Random r;

  T pick<T>(List<T> xs) => xs[r.nextInt(xs.length)];

  static const _words = ['alice', 'Bob', 'invoice', 'a b', 'x.y', 'tom', 'é', 'team-x', 'or', '2026', 'Jerry Smith'];

  String text() => [for (var i = 0; i < r.nextInt(4); i++) pick(_words)].join(' ');

  List<EmailAddress> addresses() => [
    for (var i = 0; i < r.nextInt(3); i++)
      EmailAddress(
        '${pick(['tom', 'alice', 'team-x', 'x.y', 'bob'])}@${pick(['example.com', 'example.org'])}',
        pick([null, '', 'Jerry Smith', 'Tom', 'é']),
      ),
  ];

  /// A random message. With [complete], everything a query can ask about is
  /// known: content with headers, a size and an account label.
  ({EmailSummary email, EmailContent? content, String? account, Map<String, String> headers}) next({
    bool complete = false,
  }) {
    final email = EmailSummary(
      id: 'm${r.nextInt(1000)}',
      accountId: 'a1',
      mailboxId: 'inbox',
      receivedAt: DateTime(2000 + r.nextInt(40), 1 + r.nextInt(12), 1 + r.nextInt(28), r.nextInt(24)),
      from: addresses(),
      to: addresses(),
      cc: addresses(),
      bcc: addresses(),
      subject: text(),
      preview: text(),
      size: pick([if (!complete) 0, 100, 1024, 1536, 600 * 1024, 3 << 20]),
      keywords: {
        for (final k in [r'$seen', r'$flagged', r'$answered', r'$label2', 'work', r'$forwarded'])
          if (r.nextBool()) k,
      },
      hasAttachment: r.nextBool(),
    );
    final content = complete || r.nextBool()
        ? EmailContent(
            emailId: email.id,
            text: r.nextBool() ? text() : null,
            html: r.nextBool() ? '<p>${text()}</p>' : null,
            attachments: [
              if (email.hasAttachment)
                Attachment(partId: '2', mimeType: pick(['application/pdf', 'image/png']), filename: '${text()}.pdf'),
            ],
            headers: complete || r.nextBool() ? [('List-Id', text()), ('X-Mailer', text())] : const [],
          )
        : null;
    return (
      email: email,
      content: content,
      account: complete || r.nextBool() ? pick(['Work <tom@example.com>', 'Home']) : null,
      headers: !complete && r.nextBool() ? {'received': text()} : const {},
    );
  }
}
