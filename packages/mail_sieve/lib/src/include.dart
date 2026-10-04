/// Editing somebody else's active script, only to make it run Loupe's too.
library;

import 'script.dart';
import 'sieve_text.dart';

/// The change [planInclude] proposes.
final class IncludeEdit {
  const IncludeEdit({required this.after, required this.addedLines});

  /// The whole script after the change.
  final String after;

  /// The lines added, in order.
  final List<String> addedLines;
}

/// The comment Loupe writes above its include line.
const includeComment = '# Added by Loupe, so the rules made in Loupe run too.';

/// Whether [script] includes the personal script [name]
/// (`include :personal "loupe";`, or without `:personal`, its default).
bool includesScript(String script, {String name = loupeScriptName}) {
  final code = _withoutComments(script);
  final pattern = RegExp(
    r'(^|[\s;{}])include\s+((:personal|:once|:optional)\s+)*' + RegExp.escape(sieveString(name)) + r'\s*;',
    multiLine: true,
  );
  return pattern.hasMatch(code);
}

/// Plans the smallest change that makes [script] (the server's active
/// script) also run Loupe's [name] script: `require "include";` after its
/// leading `require`s (unless it has one) and, at the very end, after the
/// script's own rules, `include :personal "loupe";`. Null when [script]
/// already includes it.
///
/// Everything else stays byte for byte as it was. Loupe's rules then run
/// after the script's own, unless one of those stops.
IncludeEdit? planInclude(String script, {String name = loupeScriptName}) {
  if (includesScript(script, name: name)) return null;
  final requires = _leadingRequires(script);
  final added = <String>[];
  var text = script;
  if (!requires.extensions.contains('include')) {
    const line = 'require "include";';
    added.add(line);
    final before = text.substring(0, requires.insertAt);
    final after = text.substring(requires.insertAt);
    final lead = before.isEmpty || before.endsWith('\n') ? '' : '\n';
    final trail = after.isEmpty || after.startsWith('\n') || after.startsWith('\r\n') ? '' : '\n';
    text = '$before$lead$line$trail$after';
  }
  final includeLine = 'include :personal ${sieveString(name)};';
  added
    ..add(includeComment)
    ..add(includeLine);
  if (text.isNotEmpty && !text.endsWith('\n')) text += '\n';
  text += '\n$includeComment\n$includeLine\n';
  return IncludeEdit(after: text, addedLines: added);
}

/// Where a new `require` line goes (the start of the line after the last
/// leading `require`, else before the first command) and which extensions
/// the leading `require`s list.
({int insertAt, Set<String> extensions}) _leadingRequires(String s) {
  final extensions = <String>{};
  var i = 0;
  int? afterLast;
  while (true) {
    final start = _skipTrivia(s, i);
    if (!_isWord(s, start, 'require')) {
      return (insertAt: afterLast ?? _lineStart(s, start), extensions: extensions);
    }
    var j = start + 'require'.length;
    while (j < s.length && s[j] != ';') {
      if (s[j] == '"') {
        final (value, end) = _readString(s, j);
        extensions.add(value);
        j = end;
      } else {
        j++;
      }
    }
    i = j < s.length ? j + 1 : s.length;
    // After the line's end if only blanks or a comment follow the `;`.
    final nl = s.indexOf('\n', i);
    final rest = s.substring(i, nl < 0 ? s.length : nl).trim();
    afterLast = rest.isEmpty || rest.startsWith('#') ? (nl < 0 ? s.length : nl + 1) : i;
  }
}

/// [i] or the start of its line when only blanks precede it there.
int _lineStart(String s, int i) {
  var k = i;
  while (k > 0 && (s[k - 1] == ' ' || s[k - 1] == '\t')) {
    k--;
  }
  return k == 0 || s[k - 1] == '\n' ? k : i;
}

bool _isWord(String s, int i, String word) {
  if (!s.startsWith(word, i)) return false;
  final end = i + word.length;
  return end >= s.length || !RegExp('[A-Za-z0-9_]').hasMatch(s[end]);
}

/// Skips blanks, `#` comments and `/* */` comments from [i].
int _skipTrivia(String s, int i) {
  while (i < s.length) {
    final c = s[i];
    if (c == ' ' || c == '\t' || c == '\r' || c == '\n') {
      i++;
    } else if (c == '#') {
      final nl = s.indexOf('\n', i);
      i = nl < 0 ? s.length : nl + 1;
    } else if (s.startsWith('/*', i)) {
      final end = s.indexOf('*/', i + 2);
      i = end < 0 ? s.length : end + 2;
    } else {
      break;
    }
  }
  return i;
}

/// Reads the quoted string starting at [i] (`"`); returns its value and the
/// index after the closing quote.
(String, int) _readString(String s, int i) {
  final out = StringBuffer();
  var j = i + 1;
  while (j < s.length && s[j] != '"') {
    if (s[j] == r'\' && j + 1 < s.length) j++;
    out.write(s[j]);
    j++;
  }
  return (out.toString(), j + 1);
}

/// [s] with comments blanked out (strings and `text:` blocks kept intact).
String _withoutComments(String s) {
  final out = StringBuffer();
  var i = 0;
  while (i < s.length) {
    final c = s[i];
    if (c == '"') {
      final (_, end) = _readString(s, i);
      out.write(s.substring(i, end.clamp(0, s.length)));
      i = end;
    } else if (c == '#') {
      final nl = s.indexOf('\n', i);
      i = nl < 0 ? s.length : nl;
    } else if (s.startsWith('/*', i)) {
      final end = s.indexOf('*/', i + 2);
      i = end < 0 ? s.length : end + 2;
      out.write(' ');
    } else if (_isWord(s, i, 'text:')) {
      // A multi-line string runs to a line holding a single dot.
      final end = s.indexOf(RegExp(r'\r?\n\.\r?\n'), i);
      final stop = end < 0 ? s.length : s.indexOf('\n', end + 1) + 1;
      out.write(s.substring(i, stop));
      i = stop;
    } else {
      out.write(c);
      i++;
    }
  }
  return out.toString();
}
