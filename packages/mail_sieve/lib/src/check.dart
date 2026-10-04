/// A small Sieve checker: what a server's CHECKSCRIPT would catch first.
/// The simulated server (demo mode, tests) uses it.
library;

/// The extension each identifier or tag needs.
const _needs = {
  'fileinto': 'fileinto',
  'addflag': 'imap4flags',
  'setflag': 'imap4flags',
  'removeflag': 'imap4flags',
  'hasflag': 'imap4flags',
  ':flags': 'imap4flags',
  'body': 'body',
  'currentdate': 'date',
  'date': 'date',
  'include': 'include',
  'return': 'include',
  'global': 'include',
  ':regex': 'regex',
  ':mime': 'mime',
  ':anychild': 'mime',
  ':copy': 'copy',
  ':create': 'mailbox',
  'mailboxexists': 'mailbox',
  ':value': 'relational',
  ':count': 'relational',
  'vacation': 'vacation',
  'reject': 'reject',
  'set': 'variables',
};

/// Errors in [script] for a server with [extensions], as "line N: …"
/// messages in the style of Dovecot Pigeonhole. Empty if it looks fine.
List<String> checkSieveScript(String script, Set<String> extensions) {
  final errors = <String>[];
  final required = <String>{};
  final stack = <(String, int)>[];
  var line = 1;
  var i = 0;
  var expectRequireArgs = false;
  final s = script;
  bool wordChar(String c) => RegExp('[A-Za-z0-9_]').hasMatch(c);
  void use(String token) {
    final ext = _needs[token.toLowerCase()];
    if (ext != null && !required.contains(ext)) {
      errors.add(
        'line $line: unknown ${token.startsWith(':') ? 'tagged argument' : 'command'} '
        "'$token' (maybe you need to require the capability '$ext')",
      );
    }
  }

  while (i < s.length) {
    final c = s[i];
    if (c == '\n') {
      line++;
      i++;
    } else if (c == ' ' || c == '\t' || c == '\r') {
      i++;
    } else if (c == '#') {
      final nl = s.indexOf('\n', i);
      i = nl < 0 ? s.length : nl;
    } else if (s.startsWith('/*', i)) {
      final end = s.indexOf('*/', i + 2);
      if (end < 0) {
        errors.add('line $line: unterminated comment');
        break;
      }
      line += '\n'.allMatches(s.substring(i, end)).length;
      i = end + 2;
    } else if (c == '"') {
      final start = line;
      final value = StringBuffer();
      var j = i + 1;
      while (j < s.length && s[j] != '"') {
        if (s[j] == r'\' && j + 1 < s.length) j++;
        if (s[j] == '\n') line++;
        value.write(s[j]);
        j++;
      }
      if (j >= s.length) {
        errors.add('line $start: unterminated string');
        break;
      }
      if (expectRequireArgs) {
        final ext = value.toString();
        if (extensions.contains(ext)) {
          required.add(ext);
        } else {
          errors.add("line $start: require command: unknown Sieve capability '$ext'");
        }
      }
      i = j + 1;
    } else if (s.startsWith('text:', i)) {
      final end = s.indexOf(RegExp(r'\n\.\r?\n'), i);
      if (end < 0) {
        errors.add('line $line: unterminated multi-line string');
        break;
      }
      line += '\n'.allMatches(s.substring(i, end + 2)).length;
      i = s.indexOf('\n', end + 1) + 1;
    } else if ('([{'.contains(c)) {
      stack.add((c, line));
      i++;
    } else if (')]}'.contains(c)) {
      final open = switch (c) {
        ')' => '(',
        ']' => '[',
        _ => '{',
      };
      if (stack.isEmpty || stack.last.$1 != open) {
        errors.add("line $line: unexpected '$c'");
      } else {
        stack.removeLast();
      }
      i++;
    } else if (c == ';') {
      expectRequireArgs = false;
      i++;
    } else if (c == ':' || wordChar(c)) {
      var j = i + 1;
      while (j < s.length && wordChar(s[j])) {
        j++;
      }
      final token = s.substring(i, j);
      if (token == 'require') {
        expectRequireArgs = true;
      } else {
        use(token);
      }
      i = j;
    } else if (c == ',') {
      i++;
    } else {
      errors.add("line $line: unexpected character '$c'");
      i++;
    }
  }
  for (final (open, at) in stack) {
    errors.add("line $at: '$open' is never closed");
  }
  return errors;
}
