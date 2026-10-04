// PUBLIC API OF readable. The app depends on these signatures; change them
// only in agreement with the app.

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import 'render/gallery.dart';
import 'render/reader_view.dart';

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
///
/// Readable mode rebuilds the HTML into native widgets (no WebView, nothing
/// executes); Plain shows the text part (or text generated from the HTML);
/// Original shows the sender's HTML in a locked-down WebView. Large messages
/// are processed in a background isolate; results are cached per message.
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
    this.senderDomain,
    this.backgroundColor,
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

  /// Shown in the remote-images banner ("Images from example.com are
  /// blocked"). Defaults to the domain of the From header in
  /// [EmailContent.headers].
  final String? senderDomain;

  /// The colour behind the message, for the contrast checks. Defaults to the
  /// theme's surface colour.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => ReaderView(
    content: content,
    settings: settings,
    remoteContent: remoteContent,
    onAllowRemoteContent: onAllowRemoteContent,
    onOpenLink: onOpenLink,
    loadAttachment: loadAttachment,
    onSuggestOriginal: onSuggestOriginal,
    senderDomain: senderDomain,
    backgroundColor: backgroundColor,
  );
}

/// One image of the full-screen gallery.
final class GalleryImage {
  const GalleryImage({required this.image, this.caption});
  final ImageProvider image;
  final String? caption;
}

/// Opens the full-screen image gallery (swipe between images, pinch or
/// double-tap to zoom, close button, counter).
Future<void> showImageGallery(BuildContext context, {required List<GalleryImage> images, int initialIndex = 0}) =>
    pushGallery(context, [for (final i in images) (image: i.image, caption: i.caption)], initialIndex);
