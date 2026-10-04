/// OpenPGP ASCII armor (RFC 9580 §6), tolerant of mail: CRLF, indentation
/// from quoting, text around the block.
library;

import 'dart:convert';
import 'dart:typed_data';

/// One armored block: its label (`PGP MESSAGE`, `PGP PUBLIC KEY BLOCK`, …),
/// header lines and decoded data.
final class ArmorBlock {
  const ArmorBlock(this.label, this.data, {this.headers = const {}});
  final String label;
  final Uint8List data;
  final Map<String, String> headers;
}

final _begin = RegExp(r'^-----BEGIN (PGP [A-Z ,/0-9]+)-----$');

/// Whether [text] contains an armored block with [label] (any block when null).
bool hasArmor(String text, [String? label]) =>
    text.contains(label == null ? '-----BEGIN PGP ' : '-----BEGIN $label-----');

/// Every armored block in [text], in order. Cleartext-signed messages are
/// skipped (see [splitCleartext]). Throws [FormatException] for a block
/// whose base64 or checksum is broken.
List<ArmorBlock> dearmorAll(String text) {
  final lines = const LineSplitter().convert(text).map((l) => l.trim()).toList();
  final blocks = <ArmorBlock>[];
  var i = 0;
  while (i < lines.length) {
    final m = _begin.firstMatch(lines[i]);
    i++;
    if (m == null) continue;
    final label = m.group(1)!;
    if (label == 'PGP SIGNED MESSAGE') continue;
    final headers = <String, String>{};
    // Header lines up to the first blank line (some writers omit it).
    while (i < lines.length && lines[i].isNotEmpty && lines[i].contains(': ') && !lines[i].startsWith('-----')) {
      final at = lines[i].indexOf(': ');
      headers[lines[i].substring(0, at)] = lines[i].substring(at + 2);
      i++;
    }
    final body = StringBuffer();
    String? checksum;
    var ended = false;
    for (; i < lines.length; i++) {
      final line = lines[i];
      if (line == '-----END $label-----') {
        ended = true;
        i++;
        break;
      }
      if (line.isEmpty) continue;
      if (line.startsWith('=') && line.length == 5) {
        checksum = line.substring(1);
      } else {
        body.write(line);
      }
    }
    if (!ended) throw FormatException('The $label block has no end.');
    final Uint8List data;
    try {
      data = base64.decode(body.toString());
    } on FormatException {
      throw FormatException('The $label block is damaged.');
    }
    if (checksum != null && checksum != _crc24(data)) throw FormatException('The $label block is damaged.');
    blocks.add(ArmorBlock(label, data, headers: headers));
  }
  return blocks;
}

/// ASCII armor for [data] with [label], e.g. `PGP MESSAGE`. Lines end in
/// `\n`; MIME code converts them to CRLF.
String encodeArmor(String label, List<int> data) {
  final out = StringBuffer('-----BEGIN $label-----\n\n');
  final b64 = base64.encode(data);
  for (var i = 0; i < b64.length; i += 64) {
    out.writeln(b64.substring(i, i + 64 > b64.length ? b64.length : i + 64));
  }
  out
    ..writeln('=${_crc24(data)}')
    ..writeln('-----END $label-----');
  return out.toString();
}

String _crc24(List<int> data) {
  var crc = 0xb704ce;
  for (final b in data) {
    crc ^= b << 16;
    for (var j = 0; j < 8; j++) {
      crc <<= 1;
      if (crc & 0x1000000 != 0) crc ^= 0x1864cfb;
    }
  }
  crc &= 0xffffff;
  return base64.encode([crc >> 16 & 0xff, crc >> 8 & 0xff, crc & 0xff]);
}

/// A cleartext-signed message split into its text and its signature block.
final class CleartextParts {
  const CleartextParts({required this.text, required this.signature, this.hashes = const [], this.byteString = false});

  /// The signed text, dash-unescaped, lines joined with `\n`.
  final String text;

  /// The `PGP SIGNATURE` block's data.
  final Uint8List signature;

  /// Values of the `Hash:` headers.
  final List<String> hashes;

  /// [text] holds bytes (Latin-1 decoded) rather than characters, so a
  /// message in any charset can be checked: see [splitCleartext].
  final bool byteString;

  /// The bytes the signature covers (RFC 9580 §7.1): trailing whitespace
  /// removed from every line, CRLF line ends, no final line end.
  Uint8List get signedBytes {
    final canonical = text.split('\n').map((l) => l.replaceFirst(RegExp(r'[ \t\r]+$'), '')).join('\r\n');
    return Uint8List.fromList(byteString ? latin1.encode(canonical) : utf8.encode(canonical));
  }
}

/// Splits the first cleartext-signed message in [text]; null if there is
/// none. With [byteString], [text] is raw bytes decoded as Latin-1 (any
/// charset survives the round trip).
CleartextParts? splitCleartext(String text, {bool byteString = false}) {
  final lines = const LineSplitter().convert(text);
  var i = lines.indexWhere((l) => l.trim() == '-----BEGIN PGP SIGNED MESSAGE-----');
  if (i < 0) return null;
  i++;
  final hashes = <String>[];
  while (i < lines.length && lines[i].trim().isNotEmpty) {
    final l = lines[i].trim();
    if (l.startsWith('Hash:')) hashes.addAll(l.substring(5).split(',').map((h) => h.trim()));
    i++;
  }
  i++; // the blank line
  final body = <String>[];
  var sigStart = -1;
  for (; i < lines.length; i++) {
    final l = lines[i];
    if (l.trim() == '-----BEGIN PGP SIGNATURE-----') {
      sigStart = i;
      break;
    }
    body.add(l.startsWith('- ') ? l.substring(2) : l);
  }
  if (sigStart < 0) return null;
  final blocks = dearmorAll(lines.sublist(sigStart).join('\n'));
  final sig = blocks.where((b) => b.label == 'PGP SIGNATURE').firstOrNull;
  if (sig == null) return null;
  return CleartextParts(text: body.join('\n'), signature: sig.data, hashes: hashes, byteString: byteString);
}
