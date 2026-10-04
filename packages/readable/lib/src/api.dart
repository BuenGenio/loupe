// PUBLIC API OF readable. The app depends on these signatures; change them
// only in agreement with the app. The bodies are temporary stubs.

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

enum ReaderMode { readable, original, plain }

enum PlainTextFont { sans, mono }

/// Per-message view settings (the "Aa" sheet).
@immutable
final class ReaderSettings {
  const ReaderSettings({
    this.mode = ReaderMode.readable,
    this.plainFont = PlainTextFont.sans,
    this.textScale = 1.0,
    this.keepOriginalColors = false,
  });

  final ReaderMode mode;
  final PlainTextFont plainFont;

  /// Multiplies the platform text scale; 0.8 – 1.6.
  final double textScale;

  /// Readable mode: don't adjust colours for contrast / dark mode.
  final bool keepOriginalColors;

  ReaderSettings copyWith({ReaderMode? mode, PlainTextFont? plainFont, double? textScale, bool? keepOriginalColors}) =>
      ReaderSettings(
        mode: mode ?? this.mode,
        plainFont: plainFont ?? this.plainFont,
        textScale: textScale ?? this.textScale,
        keepOriginalColors: keepOriginalColors ?? this.keepOriginalColors,
      );

  @override
  bool operator ==(Object other) =>
      other is ReaderSettings &&
      other.mode == mode &&
      other.plainFont == plainFont &&
      other.textScale == textScale &&
      other.keepOriginalColors == keepOriginalColors;

  @override
  int get hashCode => Object.hash(mode, plainFont, textScale, keepOriginalColors);
}

enum RemoteContentPolicy { block, allow }

/// Shows one message body. Does not scroll by itself: it sizes to its content
/// so the host can stack several messages (conversation view) in one scroll
/// view. It shows its own "Load images" banner when remote content is blocked.
class ReadableMessageView extends StatelessWidget {
  const ReadableMessageView({
    super.key,
    required this.content,
    this.settings = const ReaderSettings(),
    this.remoteContent = RemoteContentPolicy.block,
    this.onAllowRemoteContent,
    this.onOpenLink,
    this.loadAttachment,
    this.onSuggestOriginal,
  });

  final EmailContent content;
  final ReaderSettings settings;
  final RemoteContentPolicy remoteContent;

  /// The user tapped "Load images"; [always] means "always for this sender".
  final void Function({required bool always})? onAllowRemoteContent;

  /// A link was tapped (after the mismatch warning, if any). Null: links are inert.
  final void Function(Uri uri)? onOpenLink;

  /// Loads an attachment's bytes (images not delivered inline).
  final Future<Uint8List> Function(Attachment attachment)? loadAttachment;

  /// Readable mode thinks the Original view would do better (the host shows a hint).
  final VoidCallback? onSuggestOriginal;

  @override
  Widget build(BuildContext context) {
    final text = content.text ?? _stripTags(content.html ?? '');
    final mono = settings.mode == ReaderMode.plain && settings.plainFont == PlainTextFont.mono;
    return SelectableText(
      text.trim(),
      style: (mono ? const TextStyle(fontFamily: 'monospace') : DefaultTextStyle.of(context).style).copyWith(
        fontSize: 16 * settings.textScale,
        height: 1.4,
      ),
    );
  }

  static String _stripTags(String html) => html
      .replaceAll(RegExp(r'<(style|script)[^>]*>.*?</\1>', caseSensitive: false, dotAll: true), '')
      .replaceAll(RegExp(r'<br\s*/?>|</p>|</div>|</tr>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'<[^>]+>'), '')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll(RegExp(r'\n\s*\n\s*\n+'), '\n\n');
}

/// One image of the full-screen gallery.
final class GalleryImage {
  const GalleryImage({required this.image, this.caption});
  final ImageProvider image;
  final String? caption;
}

/// Opens the full-screen image gallery (swipe between images, pinch to zoom).
Future<void> showImageGallery(BuildContext context, {required List<GalleryImage> images, int initialIndex = 0}) {
  return Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(backgroundColor: Colors.black, foregroundColor: Colors.white),
        body: PageView(
          controller: PageController(initialPage: initialIndex),
          children: [
            for (final i in images)
              InteractiveViewer(
                child: Center(child: Image(image: i.image)),
              ),
          ],
        ),
      ),
    ),
  );
}
