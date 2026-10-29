import 'dart:typed_data';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;
import 'package:mail_model/mail_model.dart';

/// A comparison of message text and attachment metadata, with no I/O or model.
///
/// Body text is compared in full, including quotations and signatures. HTML is
/// used only when a nonblank plain-text part is unavailable. Formatting changes
/// are outside this comparison; HTML link destinations and image alt text are
/// retained so a changed destination is not hidden behind an unchanged label.
EmailDiff compareEmailContent(
  EmailContent before,
  EmailContent after, {
  EmailDiffLimits limits = const EmailDiffLimits(),
}) {
  final oldBody = _bodyText(before, limits);
  final newBody = _bodyText(after, limits);
  final oldLines = oldBody.text.isEmpty ? <String>[] : oldBody.text.split('\n');
  final newLines = newBody.text.isEmpty ? <String>[] : newBody.text.split('\n');
  final lineDiff = _diff(oldLines, newLines, limits.maxLineDiffCells);
  final lines = <EmailDiffLine>[];
  var beforeLine = 1;
  var afterLine = 1;
  for (final change in lineDiff.changes) {
    lines.add(
      EmailDiffLine(
        kind: change.kind,
        text: change.text,
        beforeLineNumber: change.kind == EmailDiffKind.added ? null : beforeLine++,
        afterLineNumber: change.kind == EmailDiffKind.removed ? null : afterLine++,
        spans: List.unmodifiable([EmailDiffSpan(change.kind, change.text)]),
      ),
    );
  }

  var usedFallback = lineDiff.usedFallback;
  var refinements = 0;
  for (var index = 0; index < lines.length;) {
    if (lines[index].kind != EmailDiffKind.removed) {
      index++;
      continue;
    }
    final removedStart = index;
    while (index < lines.length && lines[index].kind == EmailDiffKind.removed) {
      index++;
    }
    final addedStart = index;
    while (index < lines.length && lines[index].kind == EmailDiffKind.added) {
      index++;
    }
    final pairs = (addedStart - removedStart).clamp(0, index - addedStart);
    for (var pair = 0; pair < pairs; pair++) {
      final removed = lines[removedStart + pair];
      final added = lines[addedStart + pair];
      if (refinements++ >= limits.maxRefinements) {
        usedFallback = true;
        break;
      }
      final oldWords = _words(removed.text, limits.maxWordsPerLine);
      final newWords = _words(added.text, limits.maxWordsPerLine);
      if (oldWords == null || newWords == null) {
        usedFallback = true;
        continue;
      }
      final wordDiff = _diff(oldWords, newWords, limits.maxWordDiffCells);
      usedFallback |= wordDiff.usedFallback;
      lines[removedStart + pair] = removed._withSpans(
        _spans(wordDiff.changes.where((c) => c.kind != EmailDiffKind.added)),
      );
      lines[addedStart + pair] = added._withSpans(
        _spans(wordDiff.changes.where((c) => c.kind != EmailDiffKind.removed)),
      );
    }
  }

  return EmailDiff(
    body: EmailBodyDiff(
      beforeText: oldBody.text,
      afterText: newBody.text,
      lines: List.unmodifiable(lines),
      beforeTruncated: oldBody.truncated,
      afterTruncated: newBody.truncated,
      beforeUsedHtml: oldBody.usedHtml,
      afterUsedHtml: newBody.usedHtml,
      usedFallback: usedFallback,
    ),
    attachments: _attachments(before.visibleAttachments, after.visibleAttachments),
  );
}

enum EmailDiffKind { equal, added, removed }

/// Caps bound parsing, displayed output, and both dynamic-programming tables.
///
/// Character caps count Unicode scalar values, never half of a surrogate pair.
/// A cap on body content sets [EmailBodyDiff.isTruncated]. An alignment cap keeps
/// all included text but uses a coarser comparison and sets
/// [EmailBodyDiff.usedFallback]. No content is silently discarded.
final class EmailDiffLimits {
  const EmailDiffLimits({
    this.maxSourceCharacters = 120000,
    this.maxTextCharacters = 40000,
    this.maxLines = 600,
    this.maxLineDiffCells = 240000,
    this.maxWordsPerLine = 400,
    this.maxWordDiffCells = 10000,
    this.maxRefinements = 64,
  }) : assert(maxSourceCharacters > 0),
       assert(maxTextCharacters > 0),
       assert(maxLines > 0),
       assert(maxLineDiffCells > 0),
       assert(maxWordsPerLine > 0),
       assert(maxWordDiffCells > 0),
       assert(maxRefinements >= 0);

  final int maxSourceCharacters;
  final int maxTextCharacters;
  final int maxLines;
  final int maxLineDiffCells;
  final int maxWordsPerLine;
  final int maxWordDiffCells;
  final int maxRefinements;
}

final class EmailDiff {
  const EmailDiff({required this.body, required this.attachments});

  final EmailBodyDiff body;
  final EmailAttachmentDiff attachments;

  /// Changes in the included text or attachment metadata. False does not prove
  /// attachment bytes match, or that omitted text matches when truncated.
  bool get hasChanges => body.hasChanges || attachments.hasMetadataChanges;
}

final class EmailBodyDiff {
  const EmailBodyDiff({
    required this.beforeText,
    required this.afterText,
    required this.lines,
    required this.beforeTruncated,
    required this.afterTruncated,
    required this.beforeUsedHtml,
    required this.afterUsedHtml,
    required this.usedFallback,
  });

  final String beforeText;
  final String afterText;
  final List<EmailDiffLine> lines;
  final bool beforeTruncated;
  final bool afterTruncated;
  final bool beforeUsedHtml;
  final bool afterUsedHtml;

  /// The alignment budget was exceeded; all included text is still present.
  final bool usedFallback;

  bool get isTruncated => beforeTruncated || afterTruncated;
  bool get hasChanges => lines.any((line) => line.kind != EmailDiffKind.equal);
  int get addedLineCount => lines.where((line) => line.kind == EmailDiffKind.added).length;
  int get removedLineCount => lines.where((line) => line.kind == EmailDiffKind.removed).length;
}

final class EmailDiffLine {
  const EmailDiffLine({
    required this.kind,
    required this.text,
    required this.beforeLineNumber,
    required this.afterLineNumber,
    required this.spans,
  });

  final EmailDiffKind kind;
  final String text;
  final int? beforeLineNumber;
  final int? afterLineNumber;

  /// Word-level changes within a replacement. Joining these restores [text].
  /// Removed lines contain only equal/removed spans; added lines equal/added.
  final List<EmailDiffSpan> spans;

  EmailDiffLine _withSpans(List<EmailDiffSpan> value) => EmailDiffLine(
    kind: kind,
    text: text,
    beforeLineNumber: beforeLineNumber,
    afterLineNumber: afterLineNumber,
    spans: value,
  );
}

final class EmailDiffSpan {
  const EmailDiffSpan(this.kind, this.text);

  final EmailDiffKind kind;
  final String text;
}

final class EmailAttachmentDiff {
  const EmailAttachmentDiff({required this.added, required this.removed, required this.matchingMetadata});

  final List<Attachment> added;
  final List<Attachment> removed;

  /// These pairs share a filename, MIME type and declared size. Their file
  /// contents may differ. Message-scoped part IDs are not content identifiers.
  final List<EmailAttachmentMetadataMatch> matchingMetadata;

  bool get bytesCompared => false;
  bool get hasMetadataChanges => added.isNotEmpty || removed.isNotEmpty;
}

final class EmailAttachmentMetadataMatch {
  const EmailAttachmentMetadataMatch({required this.before, required this.after});

  final Attachment before;
  final Attachment after;
}

EmailAttachmentDiff _attachments(Iterable<Attachment> before, Iterable<Attachment> after) {
  final available = <(String?, String, int), List<Attachment>>{};
  for (final attachment in after) {
    final key = (attachment.filename, attachment.mimeType.toLowerCase(), attachment.size);
    (available[key] ??= []).add(attachment);
  }
  final removed = <Attachment>[];
  final matches = <EmailAttachmentMetadataMatch>[];
  for (final attachment in before) {
    final key = (attachment.filename, attachment.mimeType.toLowerCase(), attachment.size);
    final candidates = available[key];
    if (candidates == null || candidates.isEmpty) {
      removed.add(attachment);
    } else {
      matches.add(EmailAttachmentMetadataMatch(before: attachment, after: candidates.removeLast()));
    }
  }
  return EmailAttachmentDiff(
    added: List.unmodifiable(available.values.expand((attachments) => attachments)),
    removed: List.unmodifiable(removed),
    matchingMetadata: List.unmodifiable(matches),
  );
}

({String text, bool truncated, bool usedHtml}) _bodyText(EmailContent content, EmailDiffLimits limits) {
  // Test only the bounded prefix when choosing a part, too: even a giant blank
  // plain-text body must not cause an unbounded scan before HTML parsing.
  final plain = _cap(content.text ?? '', limits.maxSourceCharacters);
  final usedHtml = !plain.truncated && plain.text.trim().isEmpty && content.html != null;
  final source = usedHtml ? _cap(content.html!, limits.maxSourceCharacters) : plain;
  final text = usedHtml ? _htmlText(source.text) : source.text;
  final normalized = text.replaceAll('\r\n', '\n').replaceAll('\r', '\n').replaceAll('\u00a0', ' ');
  final bounded = _cap(normalized, limits.maxTextCharacters);
  final lines = bounded.text.split('\n');
  final tooManyLines = lines.length > limits.maxLines;
  return (
    text: tooManyLines ? lines.take(limits.maxLines).join('\n') : bounded.text,
    truncated: source.truncated || bounded.truncated || tooManyLines,
    usedHtml: usedHtml,
  );
}

({String text, bool truncated}) _cap(String value, int limit) {
  // Avoid allocating a rune list for the common case. UTF-16 length is an upper
  // bound on scalar count, so this shortcut is safe for every Unicode string.
  if (value.length <= limit) return (text: value, truncated: false);
  final prefix = value.runes.take(limit + 1).toList();
  return (text: String.fromCharCodes(prefix.take(limit)), truncated: prefix.length > limit);
}

const _blockTags = {
  'address',
  'article',
  'aside',
  'blockquote',
  'dd',
  'div',
  'dl',
  'dt',
  'figcaption',
  'figure',
  'footer',
  'h1',
  'h2',
  'h3',
  'h4',
  'h5',
  'h6',
  'header',
  'hr',
  'li',
  'main',
  'nav',
  'ol',
  'p',
  'pre',
  'section',
  'table',
  'tr',
  'ul',
};
const _excludedTags = {'head', 'script', 'style', 'template', 'noscript'};

String _htmlText(String source) {
  final body = html_parser.parse(source).body;
  if (body == null) return '';
  final output = StringBuffer();
  final stack = <({dom.Node node, bool closing})>[(node: body, closing: false)];
  // Iterative traversal also handles deeply nested (but bounded) HTML without a
  // recursive walk overflowing the call stack. The parser never loads URLs.
  while (stack.isNotEmpty) {
    final entry = stack.removeLast();
    final node = entry.node;
    if (node is dom.Text) {
      output.write(node.data);
      continue;
    }
    if (node is! dom.Element || _excludedTags.contains(node.localName)) continue;
    final tag = node.localName;
    if (entry.closing) {
      if (tag == 'a') {
        final href = node.attributes['href']?.trim();
        if (href != null && href.isNotEmpty && node.text.trim() != href) output.write(' <$href>');
      }
      if (tag == 'td' || tag == 'th') output.write('\t');
      if (_blockTags.contains(tag)) output.write('\n');
      continue;
    }
    if (_blockTags.contains(tag) || tag == 'br') output.write('\n');
    if (tag == 'img') {
      final alt = node.attributes['alt'];
      if (alt != null && alt.isNotEmpty) output.write('[$alt]');
    }
    stack.add((node: node, closing: true));
    for (final child in node.nodes.reversed) {
      stack.add((node: child, closing: false));
    }
  }
  // Generated block boundaries should not turn pretty-printing indentation into
  // changes. Preserve paragraph breaks, preformatted spacing and all words.
  return output.toString().replaceAll(RegExp(r'\n[ \t]+\n'), '\n\n').trim();
}

List<String>? _words(String line, int limit) {
  final tokens = <String>[];
  // Whitespace stays in the token stream, so word highlighting is lossless.
  // Nonwhitespace runs keep surrogate pairs, combining marks, and emoji intact.
  for (final match in RegExp(r'\s+|\S+', unicode: true).allMatches(line)) {
    if (tokens.length >= limit) return null;
    tokens.add(match.group(0)!);
  }
  return tokens;
}

List<EmailDiffSpan> _spans(Iterable<_Change> changes) {
  final spans = <EmailDiffSpan>[];
  var text = StringBuffer();
  EmailDiffKind? kind;
  for (final change in changes) {
    if (kind != null && kind != change.kind) {
      spans.add(EmailDiffSpan(kind, text.toString()));
      text = StringBuffer();
    }
    kind = change.kind;
    text.write(change.text);
  }
  if (kind != null) spans.add(EmailDiffSpan(kind, text.toString()));
  return List.unmodifiable(spans);
}

typedef _Change = ({EmailDiffKind kind, String text});

/// LCS of the differing middle only. Unchanged prefix/suffix avoid allocating a
/// quadratic table for long messages with a small, local edit.
({List<_Change> changes, bool usedFallback}) _diff(List<String> before, List<String> after, int cellBudget) {
  var prefix = 0;
  while (prefix < before.length && prefix < after.length && before[prefix] == after[prefix]) {
    prefix++;
  }
  var oldEnd = before.length;
  var newEnd = after.length;
  while (oldEnd > prefix && newEnd > prefix && before[oldEnd - 1] == after[newEnd - 1]) {
    oldEnd--;
    newEnd--;
  }
  final changes = <_Change>[for (var i = 0; i < prefix; i++) (kind: EmailDiffKind.equal, text: before[i])];
  final oldCount = oldEnd - prefix;
  final newCount = newEnd - prefix;
  final usedFallback = oldCount > 0 && newCount > 0 && (oldCount + 1) * (newCount + 1) > cellBudget;
  if (oldCount == 0 || newCount == 0 || usedFallback) {
    for (var i = prefix; i < oldEnd; i++) {
      changes.add((kind: EmailDiffKind.removed, text: before[i]));
    }
    for (var i = prefix; i < newEnd; i++) {
      changes.add((kind: EmailDiffKind.added, text: after[i]));
    }
  } else {
    final width = newCount + 1;
    final table = Uint32List((oldCount + 1) * width);
    for (var i = oldCount - 1; i >= 0; i--) {
      for (var j = newCount - 1; j >= 0; j--) {
        final lower = table[(i + 1) * width + j];
        final right = table[i * width + j + 1];
        table[i * width + j] = before[prefix + i] == after[prefix + j]
            ? table[(i + 1) * width + j + 1] + 1
            : (lower > right ? lower : right);
      }
    }
    var i = 0;
    var j = 0;
    while (i < oldCount || j < newCount) {
      if (i < oldCount && j < newCount && before[prefix + i] == after[prefix + j]) {
        changes.add((kind: EmailDiffKind.equal, text: before[prefix + i++]));
        j++;
      } else if (i < oldCount && (j == newCount || table[(i + 1) * width + j] >= table[i * width + j + 1])) {
        changes.add((kind: EmailDiffKind.removed, text: before[prefix + i++]));
      } else {
        changes.add((kind: EmailDiffKind.added, text: after[prefix + j++]));
      }
    }
  }
  for (var i = oldEnd; i < before.length; i++) {
    changes.add((kind: EmailDiffKind.equal, text: before[i]));
  }
  return (changes: changes, usedFallback: usedFallback);
}
