import 'package:flutter/widgets.dart';

import '../../theme/loupe_icons.dart';
import 'attachment_type.dart';

/// Icon for an attachment's type; the file name decides when the MIME type
/// is generic (application/octet-stream).
IconData attachmentIcon(String mimeType, [String? filename]) {
  final mime = effectiveMimeType(mimeType, filename);
  final ext = fileExtension(filename);
  if (mime.startsWith('image/')) return LoupeIcons.image;
  if (mime.startsWith('video/')) return LoupeIcons.video;
  if (mime.startsWith('audio/')) return LoupeIcons.audio;
  if (mime == 'application/pdf' || ext == 'pdf') return LoupeIcons.pdf;
  if (mime == 'text/calendar' || ext == 'ics') return LoupeIcons.calendar;
  if (mime.contains('zip') || mime.contains('compressed') || mime.contains('x-tar') || mime.contains('x-7z')) {
    return LoupeIcons.zip;
  }
  if (mime.contains('spreadsheet') ||
      mime.contains('excel') ||
      mime == 'text/csv' ||
      mime == 'text/tab-separated-values') {
    return LoupeIcons.spreadsheet;
  }
  if (mime.contains('presentation') || mime.contains('powerpoint')) return LoupeIcons.presentation;
  if (mime.contains('word') || mime.contains('opendocument.text') || mime == 'application/rtf') {
    return LoupeIcons.wordDocument;
  }
  if (mime == 'message/rfc822' || ext == 'eml') return LoupeIcons.email;
  if (mime.startsWith('text/') || attachmentKindOf(mimeType, filename) == AttachmentKind.text) {
    return LoupeIcons.textDocument;
  }
  return LoupeIcons.file;
}
