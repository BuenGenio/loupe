import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';

import 'attachment_cache.dart';
import 'attachment_type.dart';

/// An image attachment, downloaded when first displayed.
@immutable
class AttachmentImage extends ImageProvider<AttachmentImage> {
  const AttachmentImage({required this.emailId, required this.partId, required this.load});

  final String emailId;
  final String partId;
  final Future<Uint8List> Function() load;

  @override
  Future<AttachmentImage> obtainKey(ImageConfiguration configuration) => SynchronousFuture(this);

  @override
  ImageStreamCompleter loadImage(AttachmentImage key, ImageDecoderCallback decode) =>
      MultiFrameImageStreamCompleter(codec: _decode(decode), scale: 1, debugLabel: '$emailId#$partId');

  Future<ui.Codec> _decode(ImageDecoderCallback decode) async {
    final bytes = await load();
    return decode(await ui.ImmutableBuffer.fromUint8List(bytes));
  }

  @override
  bool operator ==(Object other) => other is AttachmentImage && other.emailId == emailId && other.partId == partId;

  @override
  int get hashCode => Object.hash(emailId, partId);
}

/// The images of a message the gallery shows: every visible attachment
/// Flutter can decode (by MIME type, or by name when the type is generic).
List<Attachment> galleryImagesOf(EmailContent content) => [
  for (final a in content.visibleAttachments)
    if (attachmentKindOf(a.mimeType, a.filename) == AttachmentKind.image) a,
];

/// Opens the full-screen gallery over all images of [content], at [current].
/// Images come from the message's inline data when it has them, otherwise
/// through [cache] (downloaded once per session); [download] replaces the
/// repository as the source.
Future<void> openAttachmentGallery(
  BuildContext context, {
  required EmailContent content,
  required Attachment current,
  required AttachmentCache cache,
  Future<Uint8List> Function(Attachment attachment)? download,
}) {
  var images = galleryImagesOf(content);
  if (!images.any((a) => a.partId == current.partId)) images = [current];
  ImageProvider imageOf(Attachment a) {
    final inline = a.contentId == null ? null : content.inlineData[a.contentId];
    if (inline != null) return MemoryImage(inline);
    return AttachmentImage(
      emailId: content.emailId,
      partId: a.partId,
      load: () => cache.bytes(content.emailId, a, download: download == null ? null : () => download(a)),
    );
  }

  return showImageGallery(
    context,
    images: [for (final a in images) GalleryImage(image: imageOf(a), caption: a.filename)],
    initialIndex: images.indexWhere((a) => a.partId == current.partId),
  );
}
