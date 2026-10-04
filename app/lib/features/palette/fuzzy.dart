import 'dart:math' as math;

/// How well [query] matches [text], higher is better; null when the query's
/// letters don't all appear in [text] in order.
///
/// Case, accents and the query's spaces don't matter ("mark read" finds
/// "Mark All as Read"). A match scores per letter, more at the start of a
/// word (initials: "mar" finds "Mark All as Read") and for runs of letters;
/// gaps and a late start cost a little. Text that starts with the query, or
/// has it as a word, scores extra. The best way through [text] counts.
int? fuzzyScore(String query, String text) {
  final q = foldForSearch(query).replaceAll(' ', '');
  if (q.isEmpty) return 0;
  final t = foldForSearch(text);
  final n = t.length;
  final m = q.length;
  if (m > n) return null;

  const neg = -1 << 30;
  const base = 2;
  const run = 6;
  const gap = 2;
  // prev[j]: best score with the previous query letter at t[j];
  // prevMax[j]: the best of prev[0..j].
  var prev = List<int>.filled(n, neg);
  var prevMax = List<int>.filled(n, neg);
  for (var i = 0; i < m; i++) {
    final cur = List<int>.filled(n, neg);
    final c = q.codeUnitAt(i);
    for (var j = i; j < n; j++) {
      if (t.codeUnitAt(j) != c) continue;
      final here = base + _wordStartBonus(t, j);
      if (i == 0) {
        cur[j] = here - math.min(j, 6);
        continue;
      }
      var best = neg;
      if (j > 0 && prev[j - 1] > neg) best = prev[j - 1] + run;
      if (j > 1 && prevMax[j - 2] > neg) best = math.max(best, prevMax[j - 2] - gap);
      if (best > neg) cur[j] = best + here;
    }
    final curMax = List<int>.filled(n, neg);
    var running = neg;
    for (var j = 0; j < n; j++) {
      running = math.max(running, cur[j]);
      curMax[j] = running;
    }
    prev = cur;
    prevMax = curMax;
  }
  final best = prevMax[n - 1];
  if (best <= neg) return null;
  final plain = foldForSearch(query).trim();
  final bonus = t.startsWith(plain)
      ? 30
      : (' $t').contains(' $plain')
      ? 15
      : 0;
  // Shorter texts win ties: "Inbox" before "Inbox Zero Tips".
  return best + bonus - (n - m) ~/ 8;
}

/// Lower case without accents, for matching.
String foldForSearch(String s) {
  final lower = s.toLowerCase();
  final out = StringBuffer();
  for (final r in lower.runes) {
    final ch = String.fromCharCode(r);
    out.write(_accents[ch] ?? ch);
  }
  return out.toString();
}

int _wordStartBonus(String t, int j) {
  if (j == 0) return 10;
  final before = t.codeUnitAt(j - 1);
  // After a space or punctuation (/, -, _, ., :, ›, @).
  final isLetterOrDigit =
      (before >= 0x61 && before <= 0x7a) || (before >= 0x30 && before <= 0x39) || before > 0x7f && before != 0x203a;
  return isLetterOrDigit ? 0 : 8;
}

const _accents = {
  'à': 'a', 'á': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'å': 'a', 'æ': 'ae', //
  'ç': 'c', 'è': 'e', 'é': 'e', 'ê': 'e', 'ë': 'e', //
  'ì': 'i', 'í': 'i', 'î': 'i', 'ï': 'i', 'ñ': 'n', //
  'ò': 'o', 'ó': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o', 'ø': 'o', 'œ': 'oe', //
  'ù': 'u', 'ú': 'u', 'û': 'u', 'ü': 'u', 'ý': 'y', 'ÿ': 'y', 'ß': 'ss', //
  '’': "'",
};
