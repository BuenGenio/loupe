/// Writing Sieve (RFC 5228) source text.
library;

/// A Sieve quoted string: `"…"` with `\"` and `\\` escaped. Line breaks are
/// legal in Sieve strings and kept.
String sieveString(String s) => '"${s.replaceAll(r'\', r'\\').replaceAll('"', r'\"')}"';

/// A string list: a single string, or `["a", "b"]`.
String sieveStringList(Iterable<String> items) {
  final list = items.toList();
  return list.length == 1 ? sieveString(list.single) : '[${list.map(sieveString).join(', ')}]';
}

/// `require [...]` for [extensions] in a stable order, or '' for none.
String sieveRequire(Iterable<String> extensions) {
  final sorted = extensions.toSet().toList()..sort();
  return sorted.isEmpty ? '' : 'require ${sieveStringList(sorted)};';
}

/// The IMAP system flag Sieve uses for a JMAP-style keyword (`$seen` →
/// `\Seen`); other keywords stay as they are.
String sieveFlag(String keyword) => switch (keyword.toLowerCase()) {
  r'$seen' => r'\Seen',
  r'$flagged' => r'\Flagged',
  r'$answered' => r'\Answered',
  r'$draft' => r'\Draft',
  r'$deleted' => r'\Deleted',
  r'$junk' => r'$Junk',
  r'$notjunk' => r'$NotJunk',
  _ => keyword,
};
