import 'operators.dart';

enum TokType {
  /// A bare word; consecutive words form a phrase.
  word,
  quoted,
  regex,

  /// The value of a rest-of-input operator.
  raw,

  /// `from:` and friends (including the colon).
  op,

  /// `g:` at the very start (desktop global search; ignored).
  global,
  lparen,
  rparen,
  and,
  or,
  not,
  minus,
}

/// A token with its source range and decoded value.
final class Tok {
  const Tok(
    this.type,
    this.start,
    this.end,
    this.text, {
    this.value = '',
    this.flags = '',
    this.op,
    this.unterminated = false,
  });

  final TokType type;
  final int start;
  final int end;

  /// The source text.
  final String text;

  /// Decoded content: quoted text without quotes and escapes, regex pattern.
  final String value;

  /// Regex flags.
  final String flags;
  final OpSpec? op;

  /// A quoted string or regex without its closing delimiter.
  final bool unterminated;

  @override
  String toString() => '${type.name}($start-$end "$text")';
}

final _ws = RegExp(r'\s');
final _opPrefix = RegExp(r'([a-z_]+):');
final _flagChar = RegExp('[a-zA-Z]');

/// Whether [c] (one UTF-16 unit) is whitespace for the language.
bool isWs(String c) => _ws.hasMatch(c);

/// Opening quote characters and the characters that close them; smart quotes
/// come from mobile keyboards.
const quoteClosers = <String, String>{'"': '"', '“': '”"', '„': '“”"', '”': '”"'};

/// Characters a backslash escapes inside quotes.
const _escapable = r'\"“”„';

const _keywords = {'and': TokType.and, 'AND': TokType.and, 'or': TokType.or, 'OR': TokType.or};
const _notWords = {'not', 'NOT'};

/// Whether [word] is a bare boolean keyword.
bool isKeywordWord(String word) => _keywords.containsKey(word) || _notWords.contains(word);

/// Splits [s] into tokens. Context-sensitive in two ways: a value glued to an
/// operator (`f:or`) is never a keyword or operator, and rest-of-input
/// operators take everything up to the end (or the enclosing `)`).
List<Tok> lex(String s) {
  final out = <Tok>[];
  var i = _skipWs(s, 0);
  if (s.startsWith('g:', i)) {
    out.add(Tok(TokType.global, i, i + 2, 'g:'));
    i += 2;
  }
  var depth = 0;
  var valuePos = false;
  while (true) {
    final ws = _skipWs(s, i);
    final glued = ws == i;
    i = ws;
    if (i >= s.length) break;
    final c = s[i];
    final gluedValue = valuePos && glued;
    final wasValuePos = valuePos;
    valuePos = false;
    if (c == '(') {
      out.add(Tok(TokType.lparen, i, i + 1, c));
      depth++;
      i++;
    } else if (c == ')') {
      out.add(Tok(TokType.rparen, i, i + 1, c));
      if (depth > 0) depth--;
      i++;
    } else if (quoteClosers.containsKey(c)) {
      i = _quoted(s, i, out);
    } else if (c == '/') {
      i = _regex(s, i, out);
    } else if (c == '-') {
      out.add(Tok(TokType.minus, i, i + 1, c));
      valuePos = wasValuePos;
      i++;
    } else {
      var j = i;
      while (j < s.length && !isWs(s[j]) && s[j] != '(' && s[j] != ')') {
        j++;
      }
      final word = s.substring(i, j);
      if (!gluedValue) {
        final kw = _keywords[word] ?? (_notWords.contains(word) ? TokType.not : null);
        if (kw != null) {
          out.add(Tok(kw, i, j, word));
          i = j;
          continue;
        }
        final m = _opPrefix.matchAsPrefix(word);
        final spec = m == null ? null : operatorsByName[m[1]];
        if (m != null && spec != null) {
          final opEnd = i + m[0]!.length;
          out.add(Tok(TokType.op, i, opEnd, m[0]!, op: spec));
          i = opEnd;
          if (spec.restOfInput) {
            i = _rest(s, i, spec, depth, out);
          } else {
            valuePos = true;
          }
          continue;
        }
      }
      out.add(Tok(TokType.word, i, j, word, value: word));
      i = j;
    }
  }
  return out;
}

int _skipWs(String s, int i) {
  while (i < s.length && isWs(s[i])) {
    i++;
  }
  return i;
}

int _quoted(String s, int i, List<Tok> out) {
  final closers = quoteClosers[s[i]]!;
  final buf = StringBuffer();
  var j = i + 1;
  while (j < s.length) {
    final c = s[j];
    if (c == r'\' && j + 1 < s.length) {
      final n = s[j + 1];
      if (!_escapable.contains(n)) buf.write(c);
      buf.write(n);
      j += 2;
      continue;
    }
    if (closers.contains(c)) {
      out.add(Tok(TokType.quoted, i, j + 1, s.substring(i, j + 1), value: buf.toString()));
      return j + 1;
    }
    buf.write(c);
    j++;
  }
  out.add(Tok(TokType.quoted, i, s.length, s.substring(i), value: buf.toString(), unterminated: true));
  return s.length;
}

/// Reads `/pattern/flags` starting at [i]. `\/` stands for a slash; a slash
/// inside a character class does not end the pattern.
int _regex(String s, int i, List<Tok> out) {
  final r = scanRegex(s, i);
  out.add(
    Tok(TokType.regex, i, r.end, s.substring(i, r.end), value: r.pattern, flags: r.flags, unterminated: r.unterminated),
  );
  return r.end;
}

/// Scans a `/pattern/flags` literal at [i] (which must be a slash).
({String pattern, String flags, int end, bool unterminated}) scanRegex(String s, int i) {
  final buf = StringBuffer();
  var j = i + 1;
  var inClass = false;
  while (j < s.length) {
    final c = s[j];
    if (c == r'\' && j + 1 < s.length) {
      final n = s[j + 1];
      if (n != '/') buf.write(c);
      buf.write(n);
      j += 2;
      continue;
    }
    if (inClass) {
      if (c == ']') inClass = false;
    } else if (c == '[') {
      inClass = true;
    } else if (c == '/') {
      var k = j + 1;
      while (k < s.length && _flagChar.hasMatch(s[k])) {
        k++;
      }
      return (pattern: buf.toString(), flags: s.substring(j + 1, k), end: k, unterminated: false);
    }
    buf.write(c);
    j++;
  }
  return (pattern: buf.toString(), flags: '', end: s.length, unterminated: true);
}

/// The value of a rest-of-input operator: a quoted string or regex if it
/// starts with one (except for `simple:`), otherwise the raw text up to the
/// end of the input or to the `)` closing the enclosing group.
int _rest(String s, int i, OpSpec spec, int depth, List<Tok> out) {
  final start = _skipWs(s, i);
  if (start >= s.length) return start;
  if (spec.kind != OpKind.simple) {
    if (s[start] == '/') return _regex(s, start, out);
    if (quoteClosers.containsKey(s[start])) return _quoted(s, start, out);
  }
  var end = s.length;
  if (depth > 0) {
    var balance = 0;
    for (var k = start; k < s.length; k++) {
      if (s[k] == '(') {
        balance++;
      } else if (s[k] == ')') {
        if (balance == 0) {
          end = k;
          break;
        }
        balance--;
      }
    }
  }
  final text = s.substring(start, end).trimRight();
  if (text.isEmpty) return end;
  out.add(Tok(TokType.raw, start, start + text.length, text, value: text));
  return end;
}
