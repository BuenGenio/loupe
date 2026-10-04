import 'package:mail_model/mail_model.dart';

/// A `WHERE` condition over `emails e`, with its positional arguments.
final class SqlCondition {
  const SqlCondition(this.sql, this.args, {this.needsPostFilter = false});

  final String sql;
  final List<Object?> args;

  /// True if terms were widened (regex, unknown headers): the caller must
  /// post-filter rows with `matchesEmail`.
  final bool needsPostFilter;
}

const _anyColumns = ['subject', 'from_addr', 'to_addr', 'cc_addr', 'bcc_addr', 'preview', 'body'];

List<String> _columnsFor(TextField field) => switch (field) {
  TextField.any => _anyColumns,
  TextField.from => const ['from_addr'],
  TextField.to => const ['to_addr'],
  TextField.cc => const ['cc_addr'],
  TextField.bcc => const ['bcc_addr'],
  TextField.recipients => const ['to_addr', 'cc_addr', 'bcc_addr'],
  TextField.participants => const ['from_addr', 'to_addr', 'cc_addr', 'bcc_addr'],
  TextField.subject => const ['subject'],
  TextField.body => const ['preview', 'body'],
  TextField.attachment => const ['attachments'],
};

final _tokenSplit = RegExp(r'[^\p{L}\p{N}\p{M}]+', unicode: true);

/// Splits user text the way the unicode61 tokenizer does (letters, numbers
/// and marks form tokens; everything else separates them).
List<String> ftsTokens(String text) => text.split(_tokenSplit).where((t) => t.isNotEmpty).toList();

/// An FTS5 query for [text] in [columns]: the tokens as a phrase, each a
/// prefix (`{subject} : "foo"* + "bar"*`). Every token is a quoted string,
/// so FTS5 syntax characters in user text are inert. Null if [text] has no
/// tokens.
String? ftsMatchQuery(String text, List<String> columns) {
  final tokens = ftsTokens(text);
  if (tokens.isEmpty) return null;
  final phrase = tokens.map((t) => '"${t.replaceAll('"', '""')}"*').join(' + ');
  return '{${columns.join(' ')}} : $phrase';
}

/// Header names the store can answer from columns.
TextField? _headerField(String name) => switch (name.toLowerCase()) {
  'from' => TextField.from,
  'to' => TextField.to,
  'cc' => TextField.cc,
  'bcc' => TextField.bcc,
  'subject' => TextField.subject,
  _ => null,
};

/// Translates [expr] into SQL over `emails e` (with `accounts` available).
///
/// Negations are pushed down to the terms; terms SQL can't evaluate become
/// TRUE in either polarity, which yields a superset, and set
/// [SqlCondition.needsPostFilter].
SqlCondition translateSearch(SearchExpr expr) {
  final args = <Object?>[];
  var widened = false;

  String text(TextField field, String value) {
    final q = ftsMatchQuery(value, _columnsFor(field));
    if (q == null) {
      widened = true;
      return '1';
    }
    args.add(q);
    return 'e.seq IN (SELECT rowid FROM email_fts WHERE email_fts MATCH ?)';
  }

  String keywordSql(String k) {
    final kw = Keywords.normalize(k);
    if (kw == Keywords.seen) return 'e.is_seen = 1';
    if (kw == Keywords.flagged) return 'e.is_flagged = 1';
    args.add(kw);
    return 'EXISTS (SELECT 1 FROM email_keywords k WHERE k.email_id = e.id AND k.keyword = ?)';
  }

  int dayStart(DateTime d, [int plusDays = 0]) => DateTime(d.year, d.month, d.day + plusDays).millisecondsSinceEpoch;

  String tr(SearchExpr e, bool neg) {
    String leaf(String sql) => neg ? 'NOT ($sql)' : '($sql)';
    switch (e) {
      case MatchAll():
        return neg ? '0' : '1';
      case SearchNot(:final child):
        return tr(child, !neg);
      case SearchAnd(:final children):
        if (children.isEmpty) return neg ? '0' : '1';
        final parts = [for (final c in children) tr(c, neg)];
        return '(${parts.join(neg ? ' OR ' : ' AND ')})';
      case SearchOr(:final children):
        if (children.isEmpty) return neg ? '1' : '0';
        final parts = [for (final c in children) tr(c, neg)];
        return '(${parts.join(neg ? ' AND ' : ' OR ')})';
      case TextTerm(field: TextField.attachment, :final value):
        final match = text(TextField.attachment, value);
        if (match == '1') return '1';
        // Attachment names are only known once content is cached: an
        // uncached message with attachments may match.
        return neg
            ? 'NOT ($match)'
            : '($match OR (e.has_attachment = 1 AND NOT EXISTS (SELECT 1 FROM contents c WHERE c.email_id = e.id)))';
      case TextTerm(:final field, :final value):
        final sql = text(field, value);
        return sql == '1' ? '1' : leaf(sql);
      case HeaderTerm(:final name, :final value):
        final field = _headerField(name);
        if (field != null) return tr(TextTerm(field, value), neg);
        if (name.toLowerCase() == 'message-id') {
          args.add('%${_escapeLike(value.toLowerCase())}%');
          return leaf(r"lower(coalesce(e.message_id_header, '')) LIKE ? ESCAPE '\'");
        }
        widened = true;
        return '1';
      case RegexTerm():
        widened = true;
        return '1';
      case KeywordTerm(:final keyword):
        return leaf(keywordSql(keyword));
      case DateTerm(:final comparison, :final date):
        switch (comparison) {
          case DateComparison.before:
            args.add(dayStart(date));
            return leaf('e.received_at < ?');
          case DateComparison.onOrAfter:
            args.add(dayStart(date));
            return leaf('e.received_at >= ?');
          case DateComparison.on:
            args
              ..add(dayStart(date))
              ..add(dayStart(date, 1));
            return leaf('e.received_at >= ? AND e.received_at < ?');
        }
      case SizeTerm(:final comparison, :final bytes):
        args.add(bytes);
        return leaf(comparison == SizeComparison.larger ? 'e.size > ?' : 'e.size < ?');
      case HasAttachmentTerm():
        return leaf('e.has_attachment = 1');
      case AccountTerm(:final value):
        args.add(value.toLowerCase());
        return leaf(
          "e.account_id IN (SELECT a.id FROM accounts a WHERE instr(lower(a.display_name || ' ' || a.email), ?) > 0)",
        );
    }
  }

  final sql = tr(expr, false);
  return SqlCondition(sql, args, needsPostFilter: widened);
}

String _escapeLike(String s) => s.replaceAll(r'\', r'\\').replaceAll('%', r'\%').replaceAll('_', r'\_');

/// Escapes `%`, `_` and `\` for `LIKE … ESCAPE '\'`.
String escapeLike(String s) => _escapeLike(s);
