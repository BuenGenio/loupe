final _comments = RegExp(r'<!--[\s\S]*?-->');
final _hidden = RegExp(r'<(script|style|head|title)\b[^>]*>[\s\S]*?</\1\s*>', caseSensitive: false);
final _blockTags = RegExp(
  r'</?(?:p|div|br|li|ul|ol|tr|td|th|table|h[1-6]|blockquote|pre|hr|section|article|header|footer|dt|dd)\b[^>]*>',
  caseSensitive: false,
);
final _tags = RegExp('<[^>]*>');
final _entity = RegExp('&(#[xX][0-9a-fA-F]{1,6}|#[0-9]{1,7}|[a-zA-Z]{2,8});');

const _named = {
  'amp': '&',
  'lt': '<',
  'gt': '>',
  'quot': '"',
  'apos': "'",
  'nbsp': ' ',
  'ndash': '–',
  'mdash': '—',
  'hellip': '…',
  'lsquo': '‘',
  'rsquo': '’',
  'ldquo': '“',
  'rdquo': '”',
  'laquo': '«',
  'raquo': '»',
  'copy': '©',
  'reg': '®',
  'euro': '€',
  'shy': '',
  'zwnj': '',
  'zwj': '',
};

/// The text of an HTML body for searching: hidden parts dropped, block tags
/// turned into spaces, inline tags removed (so `<b>wo</b>rd` stays one word)
/// and entities decoded. Whitespace is left for the caller to collapse.
String htmlToText(String html) => html
    .replaceAll(_comments, ' ')
    .replaceAll(_hidden, ' ')
    .replaceAll(_blockTags, ' ')
    .replaceAll(_tags, '')
    .replaceAllMapped(_entity, (m) => _decode(m[1]!) ?? m[0]!);

String? _decode(String e) {
  if (e.startsWith('#')) {
    final hex = e.length > 1 && (e[1] == 'x' || e[1] == 'X');
    final code = int.tryParse(e.substring(hex ? 2 : 1), radix: hex ? 16 : 10);
    if (code == null || code == 0 || code > 0x10FFFF || (code >= 0xD800 && code <= 0xDFFF)) return null;
    return String.fromCharCode(code);
  }
  return _named[e.toLowerCase()];
}
