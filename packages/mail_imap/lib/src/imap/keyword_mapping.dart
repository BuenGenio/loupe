/// IMAP flags and keywords ↔ Loupe (JMAP-style) keywords.
library;

import 'package:mail_model/mail_model.dart';

/// JMAP-style keyword for `\Deleted`. Not in [Keywords] because the UI never
/// shows deleted-but-not-expunged messages, but the transport maps it.
const deletedKeyword = r'$deleted';

const _systemToKeyword = {
  r'\seen': Keywords.seen,
  r'\flagged': Keywords.flagged,
  r'\answered': Keywords.answered,
  r'\draft': Keywords.draft,
  r'\deleted': deletedKeyword,
};

const _keywordToSystem = {
  Keywords.seen: r'\Seen',
  Keywords.flagged: r'\Flagged',
  Keywords.answered: r'\Answered',
  Keywords.draft: r'\Draft',
  deletedKeyword: r'\Deleted',
};

/// Customary spelling of well-known keywords on the wire.
const _wireSpelling = {
  Keywords.forwarded: r'$Forwarded',
  Keywords.junk: r'$Junk',
  Keywords.notJunk: r'$NotJunk',
  r'$mdnsent': r'$MDNSent',
  r'$phishing': r'$Phishing',
};

/// Converts IMAP FLAGS to lower-cased keywords. `\Recent` and unknown system
/// flags are dropped; legacy `Junk`/`NonJunk` map to `$junk`/`$notjunk`.
Set<String> keywordsFromFlags(Iterable<String> flags) {
  final result = <String>{};
  for (final flag in flags) {
    final lower = flag.toLowerCase();
    if (lower.startsWith(r'\')) {
      final k = _systemToKeyword[lower];
      if (k != null) result.add(k);
      continue;
    }
    if (lower == 'junk') {
      result.add(Keywords.junk);
    } else if (lower == 'nonjunk' || lower == 'notjunk') {
      result.add(Keywords.notJunk);
    } else if (lower.isNotEmpty) {
      result.add(Keywords.normalize(lower));
    }
  }
  return result;
}

final _atomSpecials = RegExp(r'[\x00-\x20\x7f-￿(){%*"\\\]]');

/// The IMAP flag for a keyword, or null if it can't be sent (not a valid atom).
String? flagForKeyword(String keyword) {
  final k = Keywords.normalize(keyword);
  final system = _keywordToSystem[k];
  if (system != null) return system;
  if (k.isEmpty || k.startsWith(r'\') || _atomSpecials.hasMatch(k)) return null;
  return _wireSpelling[k] ?? k;
}

/// IMAP flags for keywords, skipping the ones that can't be sent.
List<String> flagsForKeywords(Iterable<String> keywords) => [for (final k in keywords) ?flagForKeyword(k)];
