// Reference evaluators for compiled queries: an idealised RFC 3501 server
// and an RFC 8621 server, using the same field model as matchesEmail.
import 'package:expr_search/src/eval/html_text.dart';
import 'package:mail_model/mail_model.dart';

typedef Message = ({EmailSummary email, EmailContent content});

String _norm(String s) => s.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
bool _has(String hay, String needle) => _norm(hay).contains(_norm(needle));

List<String> _addresses(List<EmailAddress> list) => [
  for (final a in list) (a.name?.trim() ?? '').isEmpty ? a.email : '${a.name!.trim()} <${a.email}>',
];

String _body(EmailContent c) {
  final text = c.text;
  if (text != null && text.trim().isNotEmpty) return text;
  return c.html == null ? '' : htmlToText(c.html!);
}

List<String> _header(Message m, String name) => [
  for (final (n, v) in m.content.headers)
    if (n.toLowerCase() == name.toLowerCase()) v,
];

DateTime _day(DateTime t) {
  final l = t.toLocal();
  return DateTime(l.year, l.month, l.day);
}

bool _hasAttachment(Message m) => m.email.hasAttachment || m.content.visibleAttachments.isNotEmpty;

// ------------------------------------------------------------------ IMAP

const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

/// Evaluates IMAP SEARCH criteria. Throws on malformed criteria, which is
/// itself a test failure.
bool imapMatches(String criteria, Message m) {
  final toks = _imapTokens(criteria);
  var i = 0;
  String next() => i < toks.length ? toks[i++] : throw FormatException('Unexpected end: $criteria');
  String string() {
    final t = next();
    if (!t.startsWith('"')) throw FormatException('Expected a string at $t: $criteria');
    return t.substring(1);
  }

  DateTime date() {
    final parts = next().split('-');
    return DateTime(int.parse(parts[2]), _months.indexOf(parts[1]) + 1, int.parse(parts[0]));
  }

  late bool Function() key;
  bool addr(List<EmailAddress> list, String s) => _addresses(list).any((a) => _has(a, s));
  key = () {
    final t = next();
    final e = m.email;
    switch (t) {
      case '(':
        var all = true;
        while (toks[i] != ')') {
          all = key() && all;
        }
        i++;
        return all;
      case 'ALL':
        return true;
      case 'NOT':
        return !key();
      case 'OR':
        final a = key();
        final b = key();
        return a || b;
      case 'FROM':
        return addr(e.from, string());
      case 'TO':
        return addr(e.to, string());
      case 'CC':
        return addr(e.cc, string());
      case 'BCC':
        return addr(e.bcc, string());
      case 'SUBJECT':
        return _has(e.subject, string());
      case 'BODY':
        return _has(_body(m.content), string());
      case 'TEXT':
        final s = string();
        return [
          ..._addresses([...e.from, ...e.to, ...e.cc, ...e.bcc]),
          e.subject,
          _body(m.content),
          for (final (_, v) in m.content.headers) v,
        ].any((h) => _has(h, s));
      case 'HEADER':
        final name = string();
        final s = string();
        return _header(m, name).any((v) => _has(v, s));
      case 'KEYWORD':
        return e.keywords.contains(next());
      case 'UNKEYWORD':
        return !e.keywords.contains(next());
      case 'SEEN' || 'UNSEEN':
        return e.isSeen == (t == 'SEEN');
      case 'FLAGGED' || 'UNFLAGGED':
        return e.isFlagged == (t == 'FLAGGED');
      case 'ANSWERED' || 'UNANSWERED':
        return e.isAnswered == (t == 'ANSWERED');
      case 'DRAFT' || 'UNDRAFT':
        return e.isDraft == (t == 'DRAFT');
      case 'BEFORE':
        return _day(e.receivedAt).isBefore(date());
      case 'SINCE':
        return !_day(e.receivedAt).isBefore(date());
      case 'ON':
        return _day(e.receivedAt) == date();
      case 'LARGER':
        return e.size > int.parse(next());
      case 'SMALLER':
        return e.size < int.parse(next());
      default:
        throw FormatException('Unknown key $t: $criteria');
    }
  };
  var all = true;
  while (i < toks.length) {
    all = key() && all;
  }
  return all;
}

/// Atoms, parentheses, and quoted strings (as `"` + unescaped content).
List<String> _imapTokens(String s) {
  final out = <String>[];
  var i = 0;
  while (i < s.length) {
    final c = s[i];
    if (c == ' ') {
      i++;
    } else if (c == '(' || c == ')') {
      out.add(c);
      i++;
    } else if (c == '"') {
      final b = StringBuffer('"');
      i++;
      while (s[i] != '"') {
        if (s[i] == r'\') {
          final n = s[i + 1];
          if (n != r'\' && n != '"') throw FormatException('Bad escape in $s');
          i++;
        }
        b.write(s[i++]);
      }
      i++;
      out.add(b.toString());
    } else {
      final start = i;
      while (i < s.length && !' ()"'.contains(s[i])) {
        i++;
      }
      out.add(s.substring(start, i));
    }
  }
  return out;
}

// ------------------------------------------------------------------ JMAP

/// Evaluates an RFC 8621 FilterOperator / FilterCondition.
bool jmapMatches(Map<String, Object?> f, Message m) {
  final op = f['operator'];
  if (op != null) {
    final conditions = (f['conditions']! as List).cast<Map<String, Object?>>();
    final results = conditions.map((c) => jmapMatches(c, m));
    return switch (op) {
      'AND' => results.every((r) => r),
      'OR' => results.any((r) => r),
      'NOT' => !results.any((r) => r),
      _ => throw FormatException('Unknown operator $op'),
    };
  }
  final e = m.email;
  bool addr(List<EmailAddress> list, Object? s) => _addresses(list).any((a) => _has(a, s! as String));
  for (final MapEntry(:key, :value) in f.entries) {
    final ok = switch (key) {
      'from' => addr(e.from, value),
      'to' => addr(e.to, value),
      'cc' => addr(e.cc, value),
      'bcc' => addr(e.bcc, value),
      'subject' => _has(e.subject, value! as String),
      'body' => _has(_body(m.content), value! as String),
      'text' => [
        ..._addresses([...e.from, ...e.to, ...e.cc, ...e.bcc]),
        e.subject,
        _body(m.content),
        for (final a in m.content.attachments) a.filename ?? '',
      ].any((h) => _has(h, value! as String)),
      'hasKeyword' => e.keywords.contains(value),
      'notKeyword' => !e.keywords.contains(value),
      'hasAttachment' => _hasAttachment(m) == value,
      'header' => switch ((value! as List).cast<String>()) {
        [final name] => _header(m, name).isNotEmpty,
        [final name, final s] => _header(m, name).any((v) => _has(v, s)),
        _ => throw const FormatException('Bad header condition'),
      },
      'before' => e.receivedAt.isBefore(DateTime.parse(value! as String)),
      'after' => !e.receivedAt.isBefore(DateTime.parse(value! as String)),
      'minSize' => e.size >= (value! as int),
      'maxSize' => e.size < (value! as int),
      _ => throw FormatException('Unknown condition $key'),
    };
    if (!ok) return false;
  }
  return true;
}
