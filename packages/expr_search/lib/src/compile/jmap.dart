import 'package:mail_model/mail_model.dart';

import '../eval/normal_form.dart';
import '../syntax/values.dart' show dayOf;

typedef Json = Map<String, Object?>;

/// Whether RFC 8621 `Email/query` can filter on [term]: everything except
/// patterns, attachment names and accounts.
bool jmapCanExpress(SearchExpr term) => switch (term) {
  RegexTerm() || AccountTerm() || TextTerm(field: TextField.attachment) => false,
  _ => true,
};

/// Compiles to a FilterOperator / FilterCondition tree, after widening what
/// JMAP can't express.
Json compileJmap(SearchExpr expr) => _node(widen(expr, jmapCanExpress));

Json _node(SearchExpr e) => switch (e) {
  SearchAnd(:final children) => _op('AND', children.map(_node)),
  SearchOr(:final children) => _op('OR', children.map(_node)),
  SearchNot(:final child) => _literal(child, true),
  _ => _literal(e, false),
};

Json _op(String operator, Iterable<Json> conditions) => {'operator': operator, 'conditions': conditions.toList()};

Json _literal(SearchExpr t, bool negated) {
  Json maybeNot(Json c) => negated ? _op('NOT', [c]) : c;
  switch (t) {
    case MatchAll():
      return negated ? _op('NOT', [<String, Object?>{}]) : {};
    case TextTerm(:final field, :final value):
      Json anyOf(List<String> props) {
        final conditions = [
          for (final p in props) <String, Object?>{p: value},
        ];
        return _op(negated ? 'NOT' : 'OR', conditions);
      }
      return switch (field) {
        TextField.from ||
        TextField.to ||
        TextField.cc ||
        TextField.bcc ||
        TextField.subject ||
        TextField.body => maybeNot({field.name: value}),
        TextField.recipients => anyOf(const ['to', 'cc', 'bcc']),
        TextField.participants => anyOf(const ['from', 'to', 'cc', 'bcc']),
        // `text` also covers Bcc and attachments: a superset, fine when positive.
        TextField.any => negated ? anyOf(const ['from', 'to', 'cc', 'subject', 'body']) : {'text': value},
        TextField.attachment => const {},
      };
    case KeywordTerm(:final keyword):
      return {negated ? 'notKeyword' : 'hasKeyword': Keywords.normalize(keyword)};
    case HasAttachmentTerm():
      return {'hasAttachment': !negated};
    case HeaderTerm(:final name, :final value):
      return maybeNot({
        'header': value.isEmpty ? [name] : [name, value],
      });
    case DateTerm(:final comparison, :final date):
      final start = utcDate(dayOf(date));
      final next = utcDate(dayOf(date, 1));
      return switch ((comparison, negated)) {
        (DateComparison.before, false) || (DateComparison.onOrAfter, true) => {'before': start},
        (DateComparison.onOrAfter, false) || (DateComparison.before, true) => {'after': start},
        (DateComparison.on, false) => {'after': start, 'before': next},
        (DateComparison.on, true) => _op('OR', [
          {'before': start},
          {'after': next},
        ]),
      };
    case SizeTerm(:final comparison, :final bytes):
      // minSize is inclusive, maxSize exclusive.
      return switch ((comparison, negated)) {
        (SizeComparison.larger, false) => {'minSize': bytes + 1},
        (SizeComparison.larger, true) => {'maxSize': bytes + 1},
        (SizeComparison.smaller, false) => {'maxSize': bytes},
        (SizeComparison.smaller, true) => {'minSize': bytes},
      };
    default:
      // Widened before compiling.
      return const {};
  }
}

/// RFC 8621 UTCDate of a local time: `2026-03-01T05:00:00Z`.
String utcDate(DateTime local) {
  final u = local.toUtc();
  String two(int n) => n.toString().padLeft(2, '0');
  return '${u.year.toString().padLeft(4, '0')}-${two(u.month)}-${two(u.day)}T${two(u.hour)}:${two(u.minute)}:${two(u.second)}Z';
}
