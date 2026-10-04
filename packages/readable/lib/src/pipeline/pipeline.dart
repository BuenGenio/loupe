// The reader pipeline: pick parts → parse → clean → linearise → allowlist →
// document model. Pure Dart, so it runs in a background isolate.

import 'dart:isolate';

import 'package:html/parser.dart' as html_parser;

import '../model/document.dart';
import 'converter.dart';
import 'html_to_plain.dart';
import 'limits.dart';
import 'original_html.dart';
import 'plain_text.dart';
import 'sanitizer.dart';

/// Which view the pipeline prepares.
enum PipelineMode { readable, plain, original }

/// Everything the pipeline needs; plain data, so it can cross isolates.
final class PipelineInput {
  const PipelineInput({
    required this.mode,
    this.html,
    this.text,
    this.isFlowed = false,
    this.contentIds = const {},
    this.limits = const PipelineLimits(),
  });

  final PipelineMode mode;
  final String? html;
  final String? text;
  final bool isFlowed;

  /// Content-IDs the host can resolve (inline data and attachments).
  final Set<String> contentIds;
  final PipelineLimits limits;

  bool get hasHtml => html != null && html!.trim().isNotEmpty;
  bool get hasText => text != null && text!.trim().isNotEmpty;

  /// Rough size, to decide whether a background isolate is worth it.
  int get size => (html?.length ?? 0) + (text?.length ?? 0);
}

/// What the views render.
final class PipelineOutput {
  const PipelineOutput({required this.document, this.original});

  /// The Readable or Plain document (Original mode: the plain fallback for
  /// text-only messages).
  final ReaderDocument document;

  /// Original mode with an HTML part.
  final OriginalHtml? original;
}

/// Runs the pipeline in a background isolate.
Future<PipelineOutput> runPipelineInIsolate(PipelineInput input) => Isolate.run(() => runPipeline(input));

/// Runs the pipeline synchronously. Never throws for bad input: it degrades
/// to plain text.
PipelineOutput runPipeline(PipelineInput input) {
  switch (input.mode) {
    case PipelineMode.original:
      if (input.hasHtml) {
        return PipelineOutput(
          document: ReaderDocument.empty,
          original: prepareOriginalHtml(input.html!, limits: input.limits),
        );
      }
      return PipelineOutput(document: _plain(input));
    case PipelineMode.plain:
      if (input.hasText) return PipelineOutput(document: _plain(input));
      if (input.hasHtml) return PipelineOutput(document: toPlainDocument(buildReadable(input)));
      return const PipelineOutput(document: ReaderDocument.empty);
    case PipelineMode.readable:
      if (input.hasHtml) return PipelineOutput(document: buildReadable(input));
      if (input.hasText) return PipelineOutput(document: _plain(input));
      return const PipelineOutput(document: ReaderDocument.empty);
  }
}

ReaderDocument _plain(PipelineInput input) =>
    parsePlainText(input.text ?? '', flowed: input.isFlowed, limits: input.limits);

/// The Readable document of the HTML part.
ReaderDocument buildReadable(PipelineInput input) {
  var html = input.html!;
  var truncated = false;
  if (html.length > input.limits.maxInputChars) {
    html = html.substring(0, input.limits.maxInputChars);
    truncated = true;
  }
  final budget = Budget(input.limits);
  final document = html_parser.parse(html);
  final cleaned = sanitize(document, budget);
  budget.resetNodes();

  final ids = input.contentIds;
  final lower = {for (final id in ids) id.toLowerCase(): id};
  String? resolve(String cid) => ids.contains(cid) ? cid : lower[cid.toLowerCase()];

  final doc = convertBody(cleaned.body, budget: budget, resolveCid: resolve);
  final s = doc.stats;
  return ReaderDocument(
    blocks: doc.blocks,
    images: doc.images,
    links: doc.links,
    stats: ReaderStats(
      sourceTextLength: s.keptTextLength + cleaned.hiddenTextLength,
      keptTextLength: s.keptTextLength,
      hiddenTextLength: cleaned.hiddenTextLength,
      hiddenElements: cleaned.hiddenElements,
      trackers: cleaned.trackers,
      contentImages: s.contentImages,
      remoteImages: s.remoteImages,
      truncated: truncated || cleaned.truncated || s.truncated || budget.exhausted,
    ),
  );
}
