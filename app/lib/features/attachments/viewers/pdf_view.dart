import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';

import '../../../theme/theme.dart';

/// Builds the PDF viewer: pages scrolling vertically, pinch to zoom. Calls
/// [onPageCount] once the document is open and [onPageChanged] (1-based)
/// as pages scroll by, and shows [error] if the document can't be opened.
typedef PdfViewBuilder = Widget Function({
  required String? path,
  required Uint8List bytes,
  required ValueChanged<int> onPageCount,
  required ValueChanged<int> onPageChanged,
  required Widget error,
});

/// The PDF renderer seam: pdfx (the platform's renderer) in the app; widget
/// tests, which have no platform renderer, replace it.
final pdfViewBuilderProvider = Provider<PdfViewBuilder>(
  (ref) =>
      ({required path, required bytes, required onPageCount, required onPageChanged, required error}) =>
          PdfxView(path: path, bytes: bytes, onPageCount: onPageCount, onPageChanged: onPageChanged, error: error),
);

/// A PDF through pdfx's [PdfViewPinch], which renders with Android's
/// PdfRenderer (CGPDF on iOS) and re-renders sharply as it zooms.
class PdfxView extends StatefulWidget {
  const PdfxView({
    super.key,
    required this.path,
    required this.bytes,
    required this.onPageCount,
    required this.onPageChanged,
    required this.error,
  });

  /// The cached file; opened from [bytes] when null.
  final String? path;
  final Uint8List bytes;
  final ValueChanged<int> onPageCount;
  final ValueChanged<int> onPageChanged;
  final Widget error;

  @override
  State<PdfxView> createState() => _PdfxViewState();
}

class _PdfxViewState extends State<PdfxView> {
  late final Future<PdfDocument> _document = widget.path != null
      ? PdfDocument.openFile(widget.path!)
      : PdfDocument.openData(widget.bytes);
  late final _controller = PdfControllerPinch(document: _document);

  @override
  void dispose() {
    _controller.dispose();
    unawaited(_document.then((d) => d.close(), onError: (_) {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return PdfViewPinch(
      controller: _controller,
      padding: 8,
      maxScale: 8,
      backgroundDecoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: colors.separator, blurRadius: 3, offset: const Offset(0, 1))],
      ),
      onDocumentLoaded: (document) => widget.onPageCount(document.pagesCount),
      onPageChanged: widget.onPageChanged,
      builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
        options: const DefaultBuilderOptions(),
        documentLoaderBuilder: (_) => const Center(child: CircularProgressIndicator.adaptive()),
        pageLoaderBuilder: (_) => const Center(child: CircularProgressIndicator.adaptive()),
        errorBuilder: (_, _) => widget.error,
      ),
    );
  }
}
