/// Which in-app viewer shows an attachment.
enum AttachmentKind {
  /// Decodable images: the gallery.
  image,
  pdf,

  /// Plain text, code and data files: the monospace viewer.
  text,

  /// Comma- or tab-separated values: a table when small, otherwise text.
  csv,

  /// iCalendar: a summary of the event above the text.
  calendar,

  /// An attached message (message/rfc822, .eml): headers and body.
  email,

  /// Everything else: a details card with "Open in…" and Share.
  other,
}

/// The MIME type without parameters, lower-cased: `Text/Plain; charset=x` → `text/plain`.
String baseMimeType(String mimeType) => mimeType.split(';').first.trim().toLowerCase();

/// The file name's extension, lower-cased and without the dot; '' if none.
String fileExtension(String? filename) {
  final name = (filename ?? '').trim();
  final dot = name.lastIndexOf('.');
  if (dot <= 0 || dot == name.length - 1) return '';
  return name.substring(dot + 1).toLowerCase();
}

/// MIME types that say nothing about the content; the extension decides.
const _genericMimeTypes = {
  '',
  'application/octet-stream',
  'binary/octet-stream',
  'application/binary',
  'application/unknown',
  'application/x-unknown',
  'application/download',
  'application/x-download',
  'application/force-download',
  'application/save',
  'application/x-msdownload',
  'content/unknown',
};

/// Image types Flutter decodes on Android (HEIF and AVIF through the
/// platform decoder, on Android 9 and 12 and later).
const _decodableImages = {
  'image/jpeg',
  'image/jpg',
  'image/pjpeg',
  'image/png',
  'image/x-png',
  'image/apng',
  'image/gif',
  'image/webp',
  'image/bmp',
  'image/x-bmp',
  'image/x-ms-bmp',
  'image/vnd.wap.wbmp',
  'image/x-icon',
  'image/vnd.microsoft.icon',
  'image/heic',
  'image/heif',
  'image/heic-sequence',
  'image/heif-sequence',
  'image/avif',
};

const _pdfMimeTypes = {'application/pdf', 'application/x-pdf', 'application/acrobat', 'applications/vnd.pdf'};
const _csvMimeTypes = {
  'text/csv',
  'text/x-csv',
  'application/csv',
  'application/x-csv',
  'text/comma-separated-values',
  'text/tab-separated-values',
};
const _calendarMimeTypes = {'text/calendar', 'text/x-vcalendar', 'application/ics', 'application/x-ics'};
const _emailMimeTypes = {'message/rfc822', 'message/global'};

/// Text types outside `text/*`.
const _textApplicationTypes = {
  'application/json',
  'application/xml',
  'application/x-yaml',
  'application/yaml',
  'application/toml',
  'application/javascript',
  'application/x-javascript',
  'application/ecmascript',
  'application/x-sh',
  'application/x-shellscript',
  'application/sql',
  'application/x-sql',
  'application/x-subrip',
  'application/x-ndjson',
  'application/geo+json',
  'application/ld+json',
};

/// `text/*` types that are better opened elsewhere.
const _notText = {'text/html', 'text/rtf', 'text/richtext', 'text/enriched'};

const _imageExtensions = {
  'jpg',
  'jpeg',
  'jpe',
  'jfif',
  'pjpeg',
  'png',
  'apng',
  'gif',
  'webp',
  'bmp',
  'ico',
  'heic',
  'heif',
  'avif',
};

const _textExtensions = {
  'txt',
  'text',
  'log',
  'md',
  'markdown',
  'json',
  'ndjson',
  'geojson',
  'xml',
  'yaml',
  'yml',
  'toml',
  'ini',
  'cfg',
  'conf',
  'properties',
  'env',
  'vcf',
  'vcard',
  'srt',
  'vtt',
  'diff',
  'patch',
  'sql',
  'sh',
  'bash',
  'zsh',
  'py',
  'rb',
  'js',
  'mjs',
  'ts',
  'dart',
  'java',
  'kt',
  'kts',
  'swift',
  'go',
  'rs',
  'c',
  'h',
  'cc',
  'cpp',
  'hpp',
  'cs',
  'php',
  'pl',
  'lua',
  'r',
  'css',
  'scss',
  'gradle',
  'gpx',
  'kml',
  'asc',
  'pem',
  'readme',
  'nfo',
};

AttachmentKind? _kindOfExtension(String ext) => switch (ext) {
  'pdf' => AttachmentKind.pdf,
  'csv' || 'tsv' => AttachmentKind.csv,
  'ics' || 'ical' || 'icalendar' || 'ifb' || 'vcs' => AttachmentKind.calendar,
  'eml' => AttachmentKind.email,
  _ when _imageExtensions.contains(ext) => AttachmentKind.image,
  _ when _textExtensions.contains(ext) => AttachmentKind.text,
  _ => null,
};

AttachmentKind? _kindOfMime(String mime, String ext) {
  if (_decodableImages.contains(mime)) return AttachmentKind.image;
  if (_pdfMimeTypes.contains(mime)) return AttachmentKind.pdf;
  if (_csvMimeTypes.contains(mime)) return AttachmentKind.csv;
  if (_calendarMimeTypes.contains(mime)) return AttachmentKind.calendar;
  if (_emailMimeTypes.contains(mime)) return AttachmentKind.email;
  // Outlook and Excel send CSV files as Excel documents.
  if (mime == 'application/vnd.ms-excel' && (ext == 'csv' || ext == 'tsv')) return AttachmentKind.csv;
  if (mime == 'text/plain') {
    // Many mailers send every text file as text/plain: the extension knows better.
    final byExt = _kindOfExtension(ext);
    if (byExt == AttachmentKind.csv || byExt == AttachmentKind.calendar) return byExt;
    return AttachmentKind.text;
  }
  if (mime.startsWith('text/') && !_notText.contains(mime)) return AttachmentKind.text;
  if (_textApplicationTypes.contains(mime) ||
      (mime.startsWith('application/') && (mime.endsWith('+json') || mime.endsWith('+xml')))) {
    return AttachmentKind.text;
  }
  return null;
}

/// The viewer for an attachment: by MIME type, with the file name's
/// extension as the fallback when the MIME type is generic
/// (application/octet-stream) or not one a viewer knows.
AttachmentKind attachmentKindOf(String mimeType, [String? filename]) {
  final mime = baseMimeType(mimeType);
  final ext = fileExtension(filename);
  if (!_genericMimeTypes.contains(mime)) {
    final byMime = _kindOfMime(mime, ext);
    if (byMime != null) return byMime;
    // A specific type the app can't show (image/tiff, video/mp4, a Word
    // document): don't second-guess it from the name.
    if (mime.startsWith('image/') ||
        mime.startsWith('video/') ||
        mime.startsWith('audio/') ||
        _notText.contains(mime) ||
        mime.contains('officedocument') ||
        mime.contains('opendocument') ||
        mime.contains('zip') ||
        mime.contains('compressed')) {
      return AttachmentKind.other;
    }
  }
  return _kindOfExtension(ext) ?? AttachmentKind.other;
}

const _mimeByExtension = {
  'pdf': 'application/pdf',
  'jpg': 'image/jpeg',
  'jpeg': 'image/jpeg',
  'png': 'image/png',
  'gif': 'image/gif',
  'webp': 'image/webp',
  'heic': 'image/heic',
  'heif': 'image/heif',
  'avif': 'image/avif',
  'bmp': 'image/bmp',
  'svg': 'image/svg+xml',
  'tif': 'image/tiff',
  'tiff': 'image/tiff',
  'txt': 'text/plain',
  'log': 'text/plain',
  'md': 'text/markdown',
  'csv': 'text/csv',
  'tsv': 'text/tab-separated-values',
  'json': 'application/json',
  'xml': 'application/xml',
  'html': 'text/html',
  'htm': 'text/html',
  'ics': 'text/calendar',
  'vcf': 'text/vcard',
  'eml': 'message/rfc822',
  'zip': 'application/zip',
  'gz': 'application/gzip',
  'tar': 'application/x-tar',
  '7z': 'application/x-7z-compressed',
  'rar': 'application/vnd.rar',
  'doc': 'application/msword',
  'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  'xls': 'application/vnd.ms-excel',
  'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
  'ppt': 'application/vnd.ms-powerpoint',
  'pptx': 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
  'odt': 'application/vnd.oasis.opendocument.text',
  'ods': 'application/vnd.oasis.opendocument.spreadsheet',
  'odp': 'application/vnd.oasis.opendocument.presentation',
  'rtf': 'application/rtf',
  'mp3': 'audio/mpeg',
  'm4a': 'audio/mp4',
  'wav': 'audio/wav',
  'ogg': 'audio/ogg',
  'mp4': 'video/mp4',
  'mov': 'video/quicktime',
  'apk': 'application/vnd.android.package-archive',
};

/// The MIME type to hand to other apps: the attachment's own, or one from
/// the extension when the attachment's says nothing (other apps pick
/// themselves by MIME type).
String effectiveMimeType(String mimeType, [String? filename]) {
  final mime = baseMimeType(mimeType);
  if (!_genericMimeTypes.contains(mime)) return mime;
  return _mimeByExtension[fileExtension(filename)] ?? 'application/octet-stream';
}

/// A short, human description of the file type: "PDF Document",
/// "ZIP Archive", "DOCX File".
String describeFileType(String mimeType, [String? filename]) {
  final mime = effectiveMimeType(mimeType, filename);
  final ext = fileExtension(filename);
  final kind = attachmentKindOf(mimeType, filename);
  switch (kind) {
    case AttachmentKind.image:
      final sub = mime.startsWith('image/') ? mime.substring(6).replaceFirst('x-', '') : ext;
      final name = switch (sub) {
        'jpeg' || 'jpg' || 'pjpeg' => 'JPEG',
        'vnd.microsoft.icon' || 'icon' => 'ICO',
        'ms-bmp' => 'BMP',
        _ => sub.toUpperCase(),
      };
      return name.isEmpty ? 'Image' : '$name Image';
    case AttachmentKind.pdf:
      return 'PDF Document';
    case AttachmentKind.csv:
      return ext == 'tsv' || mime == 'text/tab-separated-values' ? 'Tab-Separated Values' : 'CSV Spreadsheet';
    case AttachmentKind.calendar:
      return 'Calendar Event';
    case AttachmentKind.email:
      return 'Email Message';
    case AttachmentKind.text:
      if (ext == 'vcf' || ext == 'vcard' || mime.contains('vcard')) return 'Contact Card';
      if (ext == 'json' || mime.endsWith('json')) return 'JSON';
      if (ext == 'xml' || mime.endsWith('xml')) return 'XML';
      if (ext == 'md' || ext == 'markdown' || mime == 'text/markdown') return 'Markdown';
      if (ext == 'log') return 'Log File';
      return 'Text';
    case AttachmentKind.other:
      break;
  }
  if (mime.contains('zip') || ext == 'zip') return 'ZIP Archive';
  if (mime.contains('x-7z') || mime.contains('x-tar') || mime.contains('gzip') || mime.contains('rar')) {
    return 'Archive';
  }
  if (mime.contains('wordprocessingml') || mime == 'application/msword') return 'Word Document';
  if (mime.contains('spreadsheetml') || mime == 'application/vnd.ms-excel') return 'Excel Spreadsheet';
  if (mime.contains('presentationml') || mime.contains('powerpoint')) return 'PowerPoint Presentation';
  if (mime.contains('opendocument')) return 'OpenDocument';
  if (mime == 'text/html') return 'Web Page';
  if (mime.startsWith('image/')) return 'Image';
  if (mime.startsWith('video/')) return 'Video';
  if (mime.startsWith('audio/')) return 'Audio';
  if (ext.isNotEmpty && ext.length <= 6) return '${ext.toUpperCase()} File';
  return 'File';
}
