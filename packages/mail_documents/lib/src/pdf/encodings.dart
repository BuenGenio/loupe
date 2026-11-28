/// The single-byte encodings of PDF's simple fonts (PDF 32000-1:2008,
/// Annex D), as 256 characters each; an empty entry is an unused code.
library;

/// Windows-1252 for 0x80–0x9F. The rest of WinAnsiEncoding is Latin-1.
const cp1252High = [
  0x20AC, 0, 0x201A, 0x0192, 0x201E, 0x2026, 0x2020, 0x2021, //
  0x02C6, 0x2030, 0x0160, 0x2039, 0x0152, 0, 0x017D, 0,
  0, 0x2018, 0x2019, 0x201C, 0x201D, 0x2022, 0x2013, 0x2014,
  0x02DC, 0x2122, 0x0161, 0x203A, 0x0153, 0, 0x017E, 0x0178,
];

/// WinAnsiEncoding: Windows-1252.
final List<String> winAnsiEncoding = List.unmodifiable([
  for (var c = 0; c < 256; c++)
    if (c < 0x20)
      ''
    else if (c >= 0x80 && c < 0xA0)
      cp1252High[c - 0x80] == 0 ? '' : String.fromCharCode(cp1252High[c - 0x80])
    else if (c == 0x7F)
      ''
    else if (c == 0xAD)
      '-' // The soft hyphen shows as a hyphen in PDFs.
    else
      String.fromCharCode(c),
]);

/// StandardEncoding, Adobe's default for Type 1 fonts (the standard 14
/// fonts such as Helvetica): ASCII except the quotes, and its own upper half.
final List<String> standardEncoding = List.unmodifiable([for (var c = 0; c < 256; c++) _standard(c)]);

String _standard(int c) {
  if (c == 0x27) return '’';
  if (c == 0x60) return '‘';
  if (c >= 0x20 && c < 0x7F) return String.fromCharCode(c);
  return switch (c) {
    0xA1 => '¡',
    0xA2 => '¢',
    0xA3 => '£',
    0xA4 => '⁄',
    0xA5 => '¥',
    0xA6 => 'ƒ',
    0xA7 => '§',
    0xA8 => '¤',
    0xA9 => "'",
    0xAA => '“',
    0xAB => '«',
    0xAC => '‹',
    0xAD => '›',
    0xAE => 'ﬁ',
    0xAF => 'ﬂ',
    0xB1 => '–',
    0xB2 => '†',
    0xB3 => '‡',
    0xB4 => '·',
    0xB6 => '¶',
    0xB7 => '•',
    0xB8 => '‚',
    0xB9 => '„',
    0xBA => '”',
    0xBB => '»',
    0xBC => '…',
    0xBD => '‰',
    0xBF => '¿',
    0xC1 => '`',
    0xC2 => '´',
    0xC3 => 'ˆ',
    0xC4 => '˜',
    0xC5 => '¯',
    0xC6 => '˘',
    0xC7 => '˙',
    0xC8 => '¨',
    0xCA => '˚',
    0xCB => '¸',
    0xCD => '˝',
    0xCE => '˛',
    0xCF => 'ˇ',
    0xD0 => '—',
    0xE1 => 'Æ',
    0xE3 => 'ª',
    0xE8 => 'Ł',
    0xE9 => 'Ø',
    0xEA => 'Œ',
    0xEB => 'º',
    0xF1 => 'æ',
    0xF5 => 'ı',
    0xF8 => 'ł',
    0xF9 => 'ø',
    0xFA => 'œ',
    0xFB => 'ß',
    _ => '',
  };
}

/// MacRomanEncoding's upper half (0x80–0xFF); the lower half is ASCII.
const _macRomanHigh =
    'ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôöõúùûü†°¢£§•¶ß®©™´¨≠ÆØ∞±≤≥¥µ∂∑∏π∫ªºΩæø'
    '¿¡¬√ƒ≈∆«»… ÀÃÕŒœ–—“”‘’÷◊ÿŸ⁄¤‹›ﬁﬂ‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒÚÛÙıˆ˜¯˘˙˚¸˝˛ˇ';

final List<String> macRomanEncoding = List.unmodifiable([
  for (var c = 0; c < 256; c++)
    if (c >= 0x20 && c < 0x7F) String.fromCharCode(c) else if (c >= 0x80) _macRomanHigh[c - 0x80] else '',
]);

/// Glyph names of WinAnsiEncoding's codes from 0x20 (Adobe Glyph List).
const _winAnsiNames = [
  'space', 'exclam', 'quotedbl', 'numbersign', 'dollar', 'percent', 'ampersand', 'quotesingle', //
  'parenleft', 'parenright', 'asterisk', 'plus', 'comma', 'hyphen', 'period', 'slash',
  'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven',
  'eight', 'nine', 'colon', 'semicolon', 'less', 'equal', 'greater', 'question',
  'at', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
  'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
  'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
  'X', 'Y', 'Z', 'bracketleft', 'backslash', 'bracketright', 'asciicircum', 'underscore',
  'grave', 'a', 'b', 'c', 'd', 'e', 'f', 'g',
  'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
  'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
  'x', 'y', 'z', 'braceleft', 'bar', 'braceright', 'asciitilde', '',
  'Euro', '', 'quotesinglbase', 'florin', 'quotedblbase', 'ellipsis', 'dagger', 'daggerdbl',
  'circumflex', 'perthousand', 'Scaron', 'guilsinglleft', 'OE', '', 'Zcaron', '',
  '', 'quoteleft', 'quoteright', 'quotedblleft', 'quotedblright', 'bullet', 'endash', 'emdash',
  'tilde', 'trademark', 'scaron', 'guilsinglright', 'oe', '', 'zcaron', 'Ydieresis',
  'nbspace', 'exclamdown', 'cent', 'sterling', 'currency', 'yen', 'brokenbar', 'section',
  'dieresis', 'copyright', 'ordfeminine', 'guillemotleft', 'logicalnot', 'sfthyphen', 'registered', 'macron',
  'degree', 'plusminus', 'twosuperior', 'threesuperior', 'acute', 'mu', 'paragraph', 'periodcentered',
  'cedilla', 'onesuperior', 'ordmasculine', 'guillemotright', 'onequarter', 'onehalf', 'threequarters', 'questiondown',
  'Agrave', 'Aacute', 'Acircumflex', 'Atilde', 'Adieresis', 'Aring', 'AE', 'Ccedilla',
  'Egrave', 'Eacute', 'Ecircumflex', 'Edieresis', 'Igrave', 'Iacute', 'Icircumflex', 'Idieresis',
  'Eth', 'Ntilde', 'Ograve', 'Oacute', 'Ocircumflex', 'Otilde', 'Odieresis', 'multiply',
  'Oslash', 'Ugrave', 'Uacute', 'Ucircumflex', 'Udieresis', 'Yacute', 'Thorn', 'germandbls',
  'agrave', 'aacute', 'acircumflex', 'atilde', 'adieresis', 'aring', 'ae', 'ccedilla',
  'egrave', 'eacute', 'ecircumflex', 'edieresis', 'igrave', 'iacute', 'icircumflex', 'idieresis',
  'eth', 'ntilde', 'ograve', 'oacute', 'ocircumflex', 'otilde', 'odieresis', 'divide',
  'oslash', 'ugrave', 'uacute', 'ucircumflex', 'udieresis', 'yacute', 'thorn', 'ydieresis',
];

final Map<String, String> _glyphs = {
  for (final (i, name) in _winAnsiNames.indexed)
    if (name.isNotEmpty) name: name == 'nbspace' ? ' ' : (name == 'sfthyphen' ? '-' : winAnsiEncoding[0x20 + i]),
  'space': ' ',
  'quoteright': '’',
  'quoteleft': '‘',
  'fi': 'ﬁ',
  'fl': 'ﬂ',
  'ff': 'ﬀ',
  'ffi': 'ﬃ',
  'ffl': 'ﬄ',
  'fraction': '⁄',
  'minus': '−',
  'dotlessi': 'ı',
  'Lslash': 'Ł',
  'lslash': 'ł',
  'breve': '˘',
  'dotaccent': '˙',
  'ring': '˚',
  'hungarumlaut': '˝',
  'ogonek': '˛',
  'caron': 'ˇ',
  'hyphenminus': '-',
  'afii61664': '‌',
};

/// The character of glyph [name]: Adobe's names for Latin text, `uniXXXX`
/// and `uXXXX[XX]`. Empty for names it doesn't know.
String glyphToUnicode(String name) {
  final known = _glyphs[name];
  if (known != null) return known;
  final base = name.contains('.') ? name.substring(0, name.indexOf('.')) : name;
  if (base != name && _glyphs[base] != null) return _glyphs[base]!;
  final uni = RegExp(r'^uni([0-9A-Fa-f]{4})+$').firstMatch(base);
  if (uni != null) {
    final hex = base.substring(3);
    return String.fromCharCodes([
      for (var i = 0; i + 4 <= hex.length; i += 4) int.parse(hex.substring(i, i + 4), radix: 16),
    ]);
  }
  final u = RegExp(r'^u([0-9A-Fa-f]{4,6})$').firstMatch(base);
  if (u != null) {
    final code = int.parse(u.group(1)!, radix: 16);
    if (code <= 0x10FFFF && (code < 0xD800 || code > 0xDFFF)) return String.fromCharCode(code);
  }
  return '';
}
