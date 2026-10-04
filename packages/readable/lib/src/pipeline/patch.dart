// Patches in plain text: the diffs and diffstat of `git format-patch` /
// `git send-email` mail, and diff hunks quoted in review replies. Regions of
// lines that form them become DiffBlocks and DiffStatBlocks; everything
// else (the commit message, review comments) stays prose.

import '../model/document.dart';

/// Lines [start, end) of a message, all at quote [depth], recognised as
/// [blocks].
final class PatchRegion {
  const PatchRegion(this.start, this.end, this.depth, this.blocks);
  final int start;
  final int end;
  final int depth;
  final List<Block> blocks;
}

final _hunkHeader = RegExp(r'^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@(.*)$');
final _statLine = RegExp(r'^\s*(\S.*?)\s+\|\s+(?:(\d+)(?: ([+\-]+))?|(Bin(?: \d+ -> \d+ bytes)?))\s*$');
final _statSummary = RegExp(r'^\s*\d+ files? changed(?:, \d+ insertions?\(\+\))?(?:, \d+ deletions?\(-\))?\s*$');
final _statExtra = RegExp(r'^\s*(create mode|delete mode|mode change|rename|copy) ');
final _extendedHeader = RegExp(
  r'^(old mode|new mode|deleted file mode|new file mode|copy from|copy to|rename from|rename to|'
  r'similarity index|dissimilarity index|index) ',
);
final _binaryChunk = RegExp(r'^(literal|delta) \d+$');
final _timestamp = RegExp(
  r'\s+(\d{4}-\d\d-\d\d \d\d:\d\d:\d\d(\.\d+)?( [+-]\d{4})?|\w{3} \w{3} [ \d]\d \d\d:\d\d:\d\d \d{4})$',
);
final _patchHint = RegExp(
  r'^[> ]*(diff --git |@@ -\d+(?:,\d+)? \+\d+(?:,\d+)? @@|\s*\d+ files? changed, )',
  multiLine: true,
);

/// True when [text] holds a diff, a quoted hunk or a diffstat: then a
/// format=flowed body isn't reflowed (that would join diff lines).
bool looksLikePatch(String text) => _patchHint.hasMatch(text);

/// A line of a hunk body: context, added, removed, or `\ No newline…`.
bool _isDiffish(String s) => s.startsWith(' ') || s.startsWith('+') || s.startsWith('-') || s.startsWith(r'\ ');

/// Finds the diffs and diffstats in a message's lines ([texts] without
/// their quote markers, [depths] the quote levels), in order.
///
/// - `diff --git` sections, or `---`/`+++` followed by a hunk, are files
///   of a patch; their hunks run as far as the hunk header counts say.
/// - A `@@ -a,b +c,d @@` line starts a hunk anywhere (pasted or quoted).
/// - In a quote that already showed a diff, a further run of `+`/`-`/space
///   lines is an excerpt of it (review replies trim and interleave).
/// - Diffstat lines end with the `N files changed` summary.
/// - The `---` line before a patch's notes and diffstat becomes a rule.
List<PatchRegion> findPatchRegions(List<String> texts, List<int> depths) {
  final regions = <PatchRegion>[];
  final withDiff = <int>{};
  var i = 0;
  while (i < texts.length) {
    final region = _statAt(texts, depths, i) ?? _diffAt(texts, depths, i, excerpts: withDiff.contains(depths[i]));
    if (region == null) {
      i++;
      continue;
    }
    regions.add(region);
    if (region.blocks.any((b) => b is DiffBlock)) withDiff.add(region.depth);
    i = region.end;
  }
  if (regions.isEmpty) return regions;
  // "---" between the commit message and the notes / diffstat.
  final rules = <PatchRegion>[];
  var next = 0;
  for (var k = 0; k < texts.length; k++) {
    while (next < regions.length && regions[next].end <= k) {
      next++;
    }
    if (next < regions.length && regions[next].start <= k) continue;
    if (texts[k].trimRight() != '---') continue;
    final d = depths[k];
    if (regions.skip(next).any((r) => r.depth == d)) rules.add(PatchRegion(k, k + 1, d, const [RuleBlock()]));
  }
  return [...regions, ...rules]..sort((a, b) => a.start.compareTo(b.start));
}

PatchRegion? _statAt(List<String> t, List<int> depth, int start) {
  final d = depth[start];
  bool at(int k) => k < t.length && depth[k] == d;
  if (!_statLine.hasMatch(t[start])) return null;
  final files = <DiffStatEntry>[];
  var k = start;
  while (at(k)) {
    final m = _statLine.firstMatch(t[k]);
    if (m == null) break;
    files.add(DiffStatEntry(m[1]!, changes: int.tryParse(m[2] ?? '') ?? 0, graph: m[3] ?? '', binary: m[4]));
    k++;
  }
  if (!at(k) || !_statSummary.hasMatch(t[k])) return null;
  final summary = t[k].trim();
  k++;
  final extra = <String>[];
  while (at(k) && _statExtra.hasMatch(t[k])) {
    extra.add(t[k].trim());
    k++;
  }
  return PatchRegion(start, k, d, [DiffStatBlock(files: files, summary: summary, extra: extra)]);
}

/// Diff files and hunks from [start] on, at its quote depth. With
/// [excerpts], quoted diff-like runs without headers count too.
PatchRegion? _diffAt(List<String> t, List<int> depth, int start, {required bool excerpts}) {
  final d = depth[start];
  bool at(int k) => k < t.length && depth[k] == d;
  final blocks = <Block>[];
  var i = start;
  while (at(i)) {
    final file = _fileAt(t, at, i);
    if (file != null) {
      blocks.add(DiffBlock(file.$1, fragment: d > 0));
      i = file.$2;
      continue;
    }
    if (_hunkHeader.hasMatch(t[i])) {
      final (hunks, end) = _hunks(t, at, i);
      blocks.add(DiffBlock(DiffFile(hunks: hunks), fragment: true));
      i = end;
      continue;
    }
    if (d > 0 && (excerpts || blocks.isNotEmpty)) {
      final excerpt = _excerpt(t, at, i);
      if (excerpt != null) {
        blocks.add(
          DiffBlock(
            DiffFile(
              hunks: [DiffHunk(header: '', lines: excerpt.$1)],
            ),
            fragment: true,
          ),
        );
        i = excerpt.$2;
        continue;
      }
    }
    break;
  }
  return blocks.isEmpty ? null : PatchRegion(start, i, d, blocks);
}

/// A file section at [i]: `diff --git` with its extended headers, or a bare
/// `---`/`+++` pair followed by a hunk. Returns the file and where it ends.
(DiffFile, int)? _fileAt(List<String> t, bool Function(int) at, int i) {
  String? oldPath;
  String? newPath;
  final headers = <String>[];
  var binary = false;
  var k = i;
  final line = t[i];
  if (line.startsWith('diff --git ')) {
    (oldPath, newPath) = _gitPaths(line.substring('diff --git '.length));
    headers.add(line);
    k++;
    while (at(k) && _extendedHeader.hasMatch(t[k])) {
      final h = t[k];
      headers.add(h);
      if (h.startsWith('rename from ') || h.startsWith('copy from ')) {
        oldPath = _unquote(h.substring(h.indexOf(' from ') + 6));
      }
      if (h.startsWith('rename to ') || h.startsWith('copy to ')) {
        newPath = _unquote(h.substring(h.indexOf(' to ') + 4));
      }
      if (h.startsWith('new file mode')) oldPath = null;
      if (h.startsWith('deleted file mode')) newPath = null;
      k++;
    }
  } else if (!(line.startsWith('--- ') &&
      at(k + 1) &&
      t[k + 1].startsWith('+++ ') &&
      at(k + 2) &&
      _hunkHeader.hasMatch(t[k + 2]))) {
    return null;
  }
  if (at(k + 1) && t[k].startsWith('--- ') && t[k + 1].startsWith('+++ ')) {
    oldPath = _path(t[k].substring(4));
    newPath = _path(t[k + 1].substring(4));
    k += 2;
  }
  if (at(k) && t[k].startsWith('Binary files ') && t[k].endsWith(' differ')) {
    headers.add(t[k]);
    binary = true;
    k++;
  } else if (at(k) && t[k].trimRight() == 'GIT binary patch') {
    binary = true;
    k++;
    // `literal N` / `delta N` sections of base85 lines, each closed by a
    // blank line: summarised, not shown.
    while (at(k) && _binaryChunk.hasMatch(t[k].trim())) {
      // The first section is the change; the second one reverses it.
      if (!headers.any((h) => h.startsWith('GIT binary patch'))) headers.add('GIT binary patch (${t[k].trim()} bytes)');
      k++;
      while (at(k) && t[k].trim().isNotEmpty) {
        k++;
      }
      if (at(k)) k++;
    }
  }
  final (hunks, end) = _hunks(t, at, k);
  return (DiffFile(oldPath: oldPath, newPath: newPath, headers: headers, hunks: hunks, binary: binary), end);
}

/// Hunks from [k] on, each as long as its header's line counts allow (and
/// as the lines look like a diff: quoted excerpts are often trimmed).
(List<DiffHunk>, int) _hunks(List<String> t, bool Function(int) at, int k) {
  final hunks = <DiffHunk>[];
  while (at(k)) {
    final m = _hunkHeader.firstMatch(t[k]);
    if (m == null) break;
    final header = t[k];
    var oldNo = int.parse(m[1]!);
    var newNo = int.parse(m[3]!);
    var oldLeft = m[2] == null ? 1 : int.parse(m[2]!);
    var newLeft = m[4] == null ? 1 : int.parse(m[4]!);
    final lines = <DiffLine>[];
    k++;
    while (at(k)) {
      final s = t[k];
      if (s.startsWith(r'\ ')) {
        lines.add(DiffLine(DiffLineKind.note, s));
        k++;
        continue;
      }
      if (oldLeft <= 0 && newLeft <= 0) break;
      if (s.startsWith('+') && newLeft > 0) {
        lines.add(DiffLine(DiffLineKind.added, s.substring(1), newLine: newNo++));
        newLeft--;
      } else if (s.startsWith('-') && oldLeft > 0) {
        lines.add(DiffLine(DiffLineKind.removed, s.substring(1), oldLine: oldNo++));
        oldLeft--;
      } else if ((s.startsWith(' ') || (s.isEmpty && at(k + 1) && (t[k + 1].isEmpty || _isDiffish(t[k + 1])))) &&
          oldLeft > 0 &&
          newLeft > 0) {
        // Mailers strip the space of an empty context line.
        lines.add(DiffLine(DiffLineKind.context, s.isEmpty ? '' : s.substring(1), oldLine: oldNo++, newLine: newNo++));
        oldLeft--;
        newLeft--;
      } else {
        break;
      }
      k++;
    }
    hunks.add(DiffHunk(header: header, lines: lines));
  }
  return (hunks, k);
}

/// A quoted run of diff lines without a hunk header; needs an added or
/// removed line. Stops at a quoted signature delimiter.
(List<DiffLine>, int)? _excerpt(List<String> t, bool Function(int) at, int k) {
  final lines = <DiffLine>[];
  var changes = false;
  while (at(k)) {
    final s = t[k];
    if (s == '-- ' || s == '--') break;
    if (s.isEmpty) {
      if (lines.isEmpty || !at(k + 1) || !_isDiffish(t[k + 1])) break;
      lines.add(const DiffLine(DiffLineKind.context, ''));
    } else if (s.startsWith('+')) {
      lines.add(DiffLine(DiffLineKind.added, s.substring(1)));
      changes = true;
    } else if (s.startsWith('-')) {
      lines.add(DiffLine(DiffLineKind.removed, s.substring(1)));
      changes = true;
    } else if (s.startsWith(r'\ ')) {
      lines.add(DiffLine(DiffLineKind.note, s));
    } else if (s.startsWith(' ')) {
      lines.add(DiffLine(DiffLineKind.context, s.substring(1)));
    } else {
      break;
    }
    k++;
  }
  return changes ? (lines, k) : null;
}

/// `a/x b/y` of a `diff --git` line (paths may be quoted or hold spaces).
(String?, String?) _gitPaths(String s) {
  final quoted = RegExp(r'^"((?:[^"\\]|\\.)*)" "((?:[^"\\]|\\.)*)"$').firstMatch(s.trim());
  if (quoted != null) return (_strip(_unescape(quoted[1]!)), _strip(_unescape(quoted[2]!)));
  // Same path on both sides (the usual case): split in the middle.
  final candidates = [for (final m in RegExp(' b/').allMatches(s)) m.start];
  for (final at in candidates) {
    final a = s.substring(0, at);
    final b = s.substring(at + 1);
    if (a.startsWith('a/') && a.substring(2) == b.substring(2)) return (a.substring(2), b.substring(2));
  }
  if (candidates.isNotEmpty) {
    final at = candidates.first;
    return (_strip(s.substring(0, at)), _strip(s.substring(at + 1)));
  }
  return (null, null);
}

/// The path of a `---` / `+++` line: no `a/`/`b/` prefix or timestamp;
/// null for /dev/null.
String? _path(String s) {
  // `diff -u` adds a timestamp after a tab (expanded to spaces by now).
  var p = s.split('\t').first.replaceFirst(_timestamp, '').trim();
  p = _unquote(p);
  if (p == '/dev/null') return null;
  return _strip(p);
}

String _strip(String p) => p.startsWith('a/') || p.startsWith('b/') ? p.substring(2) : p;

String _unquote(String p) {
  final s = p.trim();
  return s.length >= 2 && s.startsWith('"') && s.endsWith('"') ? _unescape(s.substring(1, s.length - 1)) : s;
}

String _unescape(String s) => s.replaceAllMapped(
  RegExp(r'\\(.)'),
  (m) => switch (m[1]) {
    'n' => '\n',
    't' => '\t',
    final c => c!,
  },
);
