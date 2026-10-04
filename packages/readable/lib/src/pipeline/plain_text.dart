// Plain text: reflow format=flowed (RFC 3676), nest quote levels, dim the
// signature, linkify URLs and addresses. Also used for text-only messages in
// Readable mode.

import '../model/document.dart';
import 'limits.dart';
import 'links.dart';
import 'redirects.dart';

/// One logical line after quote stripping and reflow.
final class _Line {
  _Line(this.depth, this.text);
  final int depth;
  final String text;
  bool signature = false;
}

/// Builds a document from a `text/plain` body.
ReaderDocument parsePlainText(String input, {bool flowed = false, PipelineLimits limits = const PipelineLimits()}) {
  var truncated = false;
  var text = input;
  if (text.length > limits.maxInputChars) {
    text = text.substring(0, limits.maxInputChars);
    truncated = true;
  }
  text = text.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
  final raw = text.split('\n');
  final lines = flowed ? _reflow(raw) : [for (final l in raw) _quoted(l, flowed: false)];
  _markSignatures(lines);

  final links = <LinkRef>[];
  final builder = _TreeBuilder(links, limits);
  for (final line in lines) {
    builder.add(line);
  }
  final blocks = builder.finish();
  return ReaderDocument(
    blocks: blocks,
    links: links,
    stats: ReaderStats(
      sourceTextLength: text.replaceAll(RegExp(r'\s'), '').length,
      keptTextLength: text.replaceAll(RegExp(r'\s'), '').length,
      truncated: truncated || builder.truncated,
    ),
  );
}

/// Splits a quote prefix off: `>>> text`, or `> > text` when not flowed.
_Line _quoted(String line, {required bool flowed}) {
  var depth = 0;
  var i = 0;
  while (i < line.length) {
    if (line[i] == '>') {
      depth++;
      i++;
    } else if (!flowed && line[i] == ' ' && i + 1 < line.length && line[i + 1] == '>' && depth > 0) {
      i++;
    } else {
      break;
    }
  }
  var rest = line.substring(i);
  // One leading space is quote padding / space-stuffing (RFC 3676 4.4).
  if (rest.startsWith(' ') && (depth > 0 || flowed)) rest = rest.substring(1);
  return _Line(depth, expandTabs(rest));
}

/// Joins soft-broken lines (ending in a space) of the same quote depth.
List<_Line> _reflow(List<String> raw) {
  final out = <_Line>[];
  StringBuffer? pending;
  var pendingDepth = 0;
  for (final r in raw) {
    final line = _quoted(r, flowed: true);
    final isSigSep = line.text == '-- ';
    if (pending != null && line.depth != pendingDepth) {
      out.add(_Line(pendingDepth, pending.toString()));
      pending = null;
    }
    final soft = line.text.endsWith(' ') && !isSigSep;
    if (isSigSep && pending != null) {
      // A flowed line before the signature separator ends there.
      out.add(_Line(pendingDepth, pending.toString()));
      pending = null;
    }
    if (pending == null) {
      if (soft) {
        pending = StringBuffer(line.text);
        pendingDepth = line.depth;
      } else {
        out.add(line);
      }
    } else {
      pending.write(line.text);
      if (!soft) {
        out.add(_Line(pendingDepth, pending.toString()));
        pending = null;
      }
    }
  }
  if (pending != null) out.add(_Line(pendingDepth, pending.toString()));
  return out;
}

/// Expands tabs to 8-column stops, per line.
String expandTabs(String s) {
  if (!s.contains('\t')) return s;
  final sb = StringBuffer();
  var col = 0;
  for (final rune in s.runes) {
    if (rune == 0x09) {
      final n = 8 - col % 8;
      sb.write(' ' * n);
      col += n;
    } else {
      sb.writeCharCode(rune);
      col = rune == 0x0A ? 0 : col + 1;
    }
  }
  return sb.toString();
}

/// Everything after a `-- ` line (at that quote depth) is the signature.
void _markSignatures(List<_Line> lines) {
  int? sigDepth;
  for (final line in lines) {
    if (sigDepth != null && line.depth < sigDepth) sigDepth = null;
    if (sigDepth == null && (line.text == '-- ' || line.text == '--')) sigDepth = line.depth;
    if (sigDepth != null && line.depth == sigDepth) line.signature = true;
  }
}

/// Turns lines into paragraphs nested in quote blocks.
final class _TreeBuilder {
  _TreeBuilder(this.links, this.limits);

  final List<LinkRef> links;
  final PipelineLimits limits;
  bool truncated = false;
  int _blocks = 0;

  /// Open containers, one per quote depth (index 0 is the top level).
  final _stack = <List<Block>>[[]];
  final _para = <String>[];
  var _paraSig = false;

  void add(_Line line) {
    if (line.depth != _stack.length - 1) {
      _flush();
      while (_stack.length - 1 > line.depth) {
        _close();
      }
      while (_stack.length - 1 < line.depth) {
        _stack.add([]);
      }
    }
    final blank = line.text.trim().isEmpty;
    if (blank) {
      _flush();
      return;
    }
    if (line.signature != _paraSig && _para.isNotEmpty) _flush();
    _paraSig = line.signature;
    _para.add(line.text.trimRight());
  }

  List<Block> finish() {
    _flush();
    while (_stack.length > 1) {
      _close();
    }
    return _stack.first;
  }

  void _close() {
    final children = _stack.removeLast();
    if (children.isNotEmpty) _stack.last.add(QuoteBlock(children));
  }

  void _flush() {
    if (_para.isEmpty) return;
    if (_blocks++ >= limits.maxBlocks) {
      truncated = true;
      _para.clear();
      return;
    }
    final lines = List.of(_para);
    _para.clear();
    final text = lines.join('\n');
    if (lines.length == 1 && _separator.hasMatch(text)) {
      // "--------" between sections: a rule, not a line that wraps.
      _stack.last.add(const RuleBlock());
    } else if (!_paraSig && looksTabular(lines)) {
      // ASCII tables and diagrams keep their columns: monospace, no wrapping.
      _stack.last.add(PreBlock(linkify(text, links, const RunStyle(mono: true))));
    } else {
      _stack.last.add(ParagraphBlock(linkify(text, links), muted: _paraSig));
    }
  }
}

final _separator = RegExp(r'^\s*([-=_*~#+]\s*){10,}$');
final _boxDrawing = RegExp('[\u2500-\u257f]');
final _ruleLine = RegExp(r'^\s*[-=+|_:.\u2500-\u257f ]{5,}\s*$');

/// True for an ASCII table or box drawing: most lines are column rules
/// (`+----+----+`) or have two or more `|` separators.
bool looksTabular(List<String> lines) {
  if (lines.length < 3) return false;
  var tabular = 0;
  for (final line in lines) {
    if (_ruleLine.hasMatch(line) || '|'.allMatches(line).length >= 2 || _boxDrawing.hasMatch(line)) tabular++;
  }
  return tabular * 2 >= lines.length;
}

/// Splits [text] into runs, turning URLs and addresses into links (added to
/// [links]).
List<Inline> linkify(String text, List<LinkRef> links, [RunStyle style = RunStyle.plain]) {
  final found = findLinks(text);
  if (found.isEmpty) return [TextRun(text, style)];
  final out = <Inline>[];
  var pos = 0;
  for (final m in found) {
    if (m.start > pos) out.add(TextRun(text.substring(pos, m.start), style));
    final label = text.substring(m.start, m.end);
    // The text is the URL itself: nothing to mismatch.
    links.add(LinkRef(m.url, text: label, redirect: unwrapRedirect(m.url)));
    out.add(TextRun(label, style.copyWith(link: () => links.length - 1, underline: true)));
    pos = m.end;
  }
  if (pos < text.length) out.add(TextRun(text.substring(pos), style));
  return out;
}
