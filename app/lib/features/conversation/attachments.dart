import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';
import 'package:share_plus/share_plus.dart';

import '../../shared/format.dart';
import '../../theme/theme.dart';
import 'sheets.dart';
import '../../theme/loupe_icons.dart';

/// Icon for an attachment's MIME type.
IconData attachmentIcon(String mimeType, [String? filename]) {
  final mime = mimeType.toLowerCase();
  final ext = (filename ?? '').split('.').last.toLowerCase();
  if (mime.startsWith('image/')) return LoupeIcons.image;
  if (mime.startsWith('video/')) return LoupeIcons.video;
  if (mime.startsWith('audio/')) return LoupeIcons.audio;
  if (mime == 'application/pdf' || ext == 'pdf') return LoupeIcons.pdf;
  if (mime == 'text/calendar' || ext == 'ics') return LoupeIcons.calendar;
  if (mime.contains('zip') || mime.contains('compressed') || mime.contains('x-tar') || mime.contains('x-7z')) {
    return LoupeIcons.zip;
  }
  if (mime.contains('spreadsheet') || mime.contains('excel') || mime == 'text/csv') return LoupeIcons.spreadsheet;
  if (mime.contains('presentation') || mime.contains('powerpoint')) return LoupeIcons.presentation;
  if (mime.contains('word') || mime.contains('opendocument.text') || mime == 'application/rtf') {
    return LoupeIcons.wordDocument;
  }
  if (mime == 'message/rfc822') return LoupeIcons.email;
  if (mime.startsWith('text/')) return LoupeIcons.textDocument;
  return LoupeIcons.file;
}

/// The attachment list under a message body.
class AttachmentList extends StatelessWidget {
  const AttachmentList({super.key, required this.content, required this.load});

  final EmailContent content;

  /// Downloads an attachment's bytes.
  final Future<Uint8List> Function(Attachment attachment) load;

  @override
  Widget build(BuildContext context) {
    final items = content.visibleAttachments.toList();
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          for (final a in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AttachmentTile(attachment: a, load: () => load(a), onOpen: () => _open(context, a, items)),
            ),
        ],
      ),
    );
  }

  Future<void> _open(BuildContext context, Attachment a, List<Attachment> items) async {
    if (a.isImage) {
      final images = items.where((i) => i.isImage).toList();
      await showImageGallery(
        context,
        images: [for (final i in images) GalleryImage(image: _imageOf(i), caption: i.filename)],
        initialIndex: images.indexOf(a),
      );
    }
  }

  ImageProvider _imageOf(Attachment a) {
    final inline = a.contentId == null ? null : content.inlineData[a.contentId];
    if (inline != null) return MemoryImage(inline);
    return AttachmentImage(emailId: content.emailId, partId: a.partId, load: () => load(a));
  }
}

/// One attachment: icon, name and size. Images open the gallery; other files
/// download and open the share sheet (which offers "Open with").
class AttachmentTile extends StatefulWidget {
  const AttachmentTile({super.key, required this.attachment, required this.load, required this.onOpen});

  final Attachment attachment;
  final Future<Uint8List> Function() load;

  /// Opens an image attachment in the gallery.
  final Future<void> Function() onOpen;

  @override
  State<AttachmentTile> createState() => _AttachmentTileState();
}

class _AttachmentTileState extends State<AttachmentTile> {
  bool _busy = false;

  Attachment get _a => widget.attachment;

  Future<void> _share() async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      final bytes = await widget.load();
      final name = _a.filename ?? 'attachment';
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile.fromData(bytes, name: name, mimeType: _a.mimeType)],
          fileNameOverrides: [name],
        ),
      );
    } on MailException catch (e) {
      showSnack(messenger, e.message);
    } catch (e) {
      showSnack(messenger, "Couldn't open the attachment.");
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    final name = _a.filename?.isNotEmpty == true ? _a.filename! : 'Untitled';
    return Material(
      color: subtleFill(context),
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _busy ? null : (_a.isImage ? widget.onOpen : _share),
        onLongPress: _busy ? null : _share,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(attachmentIcon(_a.mimeType, _a.filename), color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodyMedium),
                    if (_a.size > 0)
                      Text(
                        formatBytes(_a.size),
                        style: theme.textTheme.bodySmall?.copyWith(color: colors.secondaryText),
                      ),
                  ],
                ),
              ),
              if (_busy)
                const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
              else
                Icon(LoupeIcons.share, size: 20, color: colors.secondaryText),
            ],
          ),
        ),
      ),
    );
  }
}

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
