/// Turning message bodies into short plain-text previews.
library;

final _dropBlocks = RegExp(
  r'<(style|script|head|title|template)\b[^>]*>.*?(</\1\s*>|$)',
  caseSensitive: false,
  dotAll: true,
);
final _comments = RegExp(r'<!--.*?(-->|$)', dotAll: true);
final _breaks = RegExp(
  r'<(br|/p|/div|/tr|/li|/h[1-6]|p|div|tr|li|h[1-6]|blockquote|/blockquote)\b[^>]*>',
  caseSensitive: false,
);
final _tags = RegExp(r'<[^>]*(>|$)');
final _entity = RegExp(r'&(#[0-9]+|#[xX][0-9a-fA-F]+|[a-zA-Z]+);?');
final _whitespace = RegExp(r'\s+');

const _named = {
  'nbsp': ' ',
  'amp': '&',
  'lt': '<',
  'gt': '>',
  'quot': '"',
  'apos': "'",
  'zwnj': '',
  'zwj': '',
  'shy': '',
  'ndash': '–',
  'mdash': '—',
  'hellip': '…',
  'lsquo': '‘',
  'rsquo': '’',
  'ldquo': '“',
  'rdquo': '”',
  'bull': '•',
  'middot': '·',
  'copy': '©',
  'reg': '®',
  'trade': '™',
  'euro': '€',
  'pound': '£',
  'yen': '¥',
  'laquo': '«',
  'raquo': '»',
  'auml': 'ä',
  'ouml': 'ö',
  'uuml': 'ü',
  'Auml': 'Ä',
  'Ouml': 'Ö',
  'Uuml': 'Ü',
  'szlig': 'ß',
  'eacute': 'é',
  'egrave': 'è',
  'agrave': 'à',
  'ccedil': 'ç',
};

/// Decodes HTML character references.
String decodeHtmlEntities(String text) => text.replaceAllMapped(_entity, (m) {
  final e = m[1]!;
  if (e.startsWith('#')) {
    final code = e.length > 1 && (e[1] == 'x' || e[1] == 'X')
        ? int.tryParse(e.substring(2), radix: 16)
        : int.tryParse(e.substring(1));
    if (code == null || code <= 0 || code > 0x10ffff) return m[0]!;
    return String.fromCharCode(code);
  }
  return _named[e] ?? _named[e.toLowerCase()] ?? m[0]!;
});

/// Rough HTML to text for previews: drops head/style/script, tags and
/// comments; decodes entities. Not meant for display of the full message.
String htmlToPreviewText(String html) {
  var s = html.replaceAll(_comments, ' ');
  s = s.replaceAll(_dropBlocks, ' ');
  s = s.replaceAll(_breaks, '\n');
  s = s.replaceAll(_tags, ' ');
  return decodeHtmlEntities(s);
}

/// A one-paragraph preview: quoted lines (`>`), signature and long
/// separators dropped, whitespace collapsed, cut at a word near [maxLength].
String makePreview(String text, {int maxLength = 200}) {
  final lines = <String>[];
  for (final raw in text.split(RegExp(r'\r?\n'))) {
    final line = raw.trimRight();
    if (line == '-- ' || line == '--') break;
    final t = line.trimLeft();
    if (t.startsWith('>')) continue;
    if (RegExp(r'^[-_=*~#]{4,}$').hasMatch(t)) continue;
    lines.add(t);
  }
  var s = lines.join(' ').replaceAll(' ', ' ').replaceAll(_whitespace, ' ').trim();
  if (s.length <= maxLength) return s;
  final cut = s.lastIndexOf(' ', maxLength);
  var end = cut > maxLength * 0.6 ? cut : maxLength;
  // Not between the halves of a surrogate pair (an emoji).
  final unit = s.codeUnitAt(end - 1);
  if (unit >= 0xD800 && unit <= 0xDBFF) end--;
  s = s.substring(0, end);
  return '${s.trimRight()}…';
}
