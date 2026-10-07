/// Header protection for S/MIME (RFC 9788, "Cryptographic MIME Header
/// Protection", formerly draft-ietf-lamps-header-protection): the message's
/// header fields copied into the cryptographic payload, the Subject of
/// encrypted mail obscured outside, and a "legacy display" of it in the
/// body for clients that don't read protected headers.
///
/// Thunderbird reads and writes protected headers only for OpenPGP
/// (`protected-headers="v1"`, draft-autocrypt-lamps-protected-headers);
/// for S/MIME it shows the outer Subject and the body as they are (RFC 9788
/// support is its bug 1991625), as Outlook does. So the payload is marked
/// both ways (`hp="cipher"` and `protected-headers="v1"`), and the real
/// Subject leads the text of the main body parts (`hp-legacy-display="1"`):
/// in Thunderbird and Outlook the message reads "Subject: …" above the text,
/// where readers that know RFC 9788 (Loupe among them) hide it.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'codecs.dart';
import 'entity.dart';
import 'split.dart';

/// The Subject encrypted mail is sent with outside, as Thunderbird's and
/// Loupe's OpenPGP mail (RFC 9788's baseline policy writes `[...]`).
const hiddenSubject = '...';

/// The legacy display's HTML element (RFC 9788 §5.2.3).
const legacyDisplayClass = 'header-protection-legacy-display';

/// [content] (the cryptographic payload: the MIME entity that is signed,
/// then encrypted) with the message's header fields ([outer], RFC 5322 lines
/// with their folds) in its header section, and `hp` and `protected-headers`
/// on its Content-Type (RFC 9788 §5.2.1). When [encrypted], the header
/// fields as they go outside are recorded as `HP-Outer`: [obscure]d when
/// [hideSubject], and then a legacy display of the Subject leads the main
/// body parts. Without [hideSubject] the Subject stays readable outside (and
/// protected inside), so no legacy display is needed.
Uint8List protectHeaders(Uint8List content, List<String> outer, {required bool encrypted, bool hideSubject = true}) {
  final subject = _subjectOf(outer);
  final hidden = encrypted && hideSubject && subject != null && subject.trim().isNotEmpty;
  var payload = hidden ? _withLegacyDisplay(content, 'Subject: ${subject.trim()}', main: true) : content;
  final entity = SplitMessage.parse(payload);
  final lines = <String>[];
  var marked = false;
  final mark = 'hp="${encrypted ? 'cipher' : 'clear'}"; protected-headers="v1"';
  for (final h in entity.headers) {
    if (!marked && headerName(h) == 'content-type') {
      lines.add('$h;\r\n $mark');
      marked = true;
    } else {
      lines.add(h);
    }
  }
  if (!marked) lines.insert(0, 'Content-Type: text/plain; charset=us-ascii;\r\n $mark');
  lines.addAll(outer);
  if (encrypted) {
    for (final h in hideSubject ? obscure(outer) : outer) {
      lines.add('HP-Outer: $h');
    }
  }
  payload = assembleEntity(lines, entity.body);
  return payload;
}

/// The header fields of encrypted mail as they go outside: the Subject
/// obscured ([hiddenSubject]), everything else as it is (RFC 9788's
/// baseline policy; there is no Comments or Keywords field to remove).
List<String> obscure(List<String> outer) => [
  for (final h in outer) headerName(h) == 'subject' ? 'Subject: $hiddenSubject' : h,
];

String? _subjectOf(List<String> lines) {
  for (final h in lines) {
    if (headerName(h) != 'subject') continue;
    final value = h.substring(h.indexOf(':') + 1).replaceAll(RegExp(r'\r\n[ \t]'), ' ');
    return decodeEncodedWords(value.trim());
  }
  return null;
}

/// [entity] with [display] leading its main body parts (RFC 9788 §5.2.4:
/// text/plain and text/html that aren't attachments, through any child of
/// multipart/alternative and the first child of other multiparts).
Uint8List _withLegacyDisplay(Uint8List entity, String display, {required bool main}) {
  final split = SplitMessage.parse(entity);
  String? header(String name) {
    for (final h in split.headers) {
      if (headerName(h) == name) return h.substring(h.indexOf(':') + 1).replaceAll(RegExp(r'\r\n[ \t]'), ' ').trim();
    }
    return null;
  }

  final type = HeaderValue.parse(header('content-type') ?? 'text/plain');
  final mime = type.value;
  if (mime.startsWith('multipart/')) {
    final boundary = type['boundary'];
    if (boundary == null || boundary.isEmpty) return entity;
    final parts = splitMultipart(split.body, boundary);
    final out = BytesBuilder(copy: false);
    for (final (i, p) in parts.indexed) {
      final childMain = main && (mime == 'multipart/alternative' || i == 0);
      out
        ..add(ascii.encode('--$boundary\r\n'))
        ..add(childMain ? _withLegacyDisplay(p, display, main: true) : p)
        ..add(ascii.encode('\r\n'));
    }
    out.add(ascii.encode('--$boundary--\r\n'));
    return assembleEntity(split.headers, out.takeBytes());
  }
  final attachment = HeaderValue.parse(header('content-disposition')).value == 'attachment';
  if (!main || attachment || (mime != 'text/plain' && mime != 'text/html')) return entity;
  final text = decodeCharset(decodeTransfer(split.body, header('content-transfer-encoding')), type['charset']);
  final String shown;
  if (mime == 'text/plain') {
    shown = '$display\r\n\r\n$text';
  } else {
    final div =
        '<div class="$legacyDisplayClass"><pre>${const HtmlEscape(HtmlEscapeMode.element).convert(display)}</pre></div>';
    final body = RegExp(r'<body[^>]*>', caseSensitive: false).firstMatch(text);
    shown = body == null ? '$div\r\n$text' : '${text.substring(0, body.end)}\r\n$div${text.substring(body.end)}';
  }
  final params = [
    'charset=utf-8',
    if (type['format'] case final f?) 'format=$f',
    if (type['delsp'] case final d?) 'delsp=$d',
    'hp-legacy-display="1"',
  ];
  final b64 = base64.encode(utf8.encode(shown));
  return assembleEntity(
    [
      for (final h in split.headers)
        if (headerName(h) != 'content-type' && headerName(h) != 'content-transfer-encoding') h,
      'Content-Type: $mime; ${params.join('; ')}',
      'Content-Transfer-Encoding: base64',
    ],
    ascii.encode(
      [for (var i = 0; i < b64.length; i += 76) b64.substring(i, i + 76 > b64.length ? b64.length : i + 76)]
          .join('\r\n'),
    ),
  );
}

/// The protected header fields of a cryptographic payload: those of [e]
/// when it is marked (`hp`, or `protected-headers` as OpenPGP mail has it),
/// or carries a Subject (older clients), without `HP-Outer` and the MIME
/// structure fields; RFC 2047 decoded.
List<(String, String)> protectedHeadersOf(MimeEntity e) {
  final marked = e.contentType['hp'] != null || e.contentType['protected-headers'] != null;
  if (!marked && e.rawHeader('subject') == null) return const [];
  const names = {'subject', 'from', 'to', 'cc', 'reply-to', 'date', 'message-id', 'references', 'in-reply-to'};
  return [
    for (final (k, v) in e.headers)
      if (names.contains(k.toLowerCase())) (k, decodeEncodedWords(v)),
  ];
}

/// [text] of a part marked `hp-legacy-display="1"` without its legacy
/// display (RFC 9788 §4.5.3): for text/plain the lines up to and including
/// the first blank one, for HTML the `header-protection-legacy-display`
/// element. Unchanged when there is none.
String withoutLegacyDisplay(String text, {required bool html}) {
  if (!html) {
    for (var start = 0; start <= text.length;) {
      final end = text.indexOf('\n', start);
      final line = text.substring(start, end < 0 ? text.length : end);
      if (line.trim().isEmpty) return end < 0 ? '' : text.substring(end + 1);
      if (end < 0) break;
      start = end + 1;
    }
    return text;
  }
  final open = RegExp(
    '<div[^>]*class\\s*=\\s*["\']?[^"\'>]*\\b$legacyDisplayClass\\b[^>]*>',
    caseSensitive: false,
  ).firstMatch(text);
  if (open == null) return text;
  // The matching </div>, counting nested divs.
  final tags = RegExp(r'<(/?)div\b[^>]*>', caseSensitive: false);
  var depth = 1;
  for (final t in tags.allMatches(text, open.end)) {
    depth += t.group(1)!.isEmpty ? 1 : -1;
    if (depth == 0) return text.substring(0, open.start) + text.substring(t.end);
  }
  return text;
}
