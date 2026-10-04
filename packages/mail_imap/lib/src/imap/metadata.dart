/// IMAP METADATA (RFC 5464): GETMETADATA and SETMETADATA commands and
/// their responses.
///
/// enough_mail's own METADATA parser can't read NIL, escaped quoted strings
/// or zero-length literals, so responses are tokenised here from the raw
/// response lines (text and literal data).
library;

import 'dart:convert';
import 'dart:typed_data';

import 'protocol.dart';
import 'values.dart';

/// The largest value GETMETADATA asks for (its MAXSIZE option), so a server
/// can't flood the phone. Larger entries are reported as LONGENTRIES.
const metadataMaxSize = 1024 * 1024;

/// Values up to this size that need no escaping go as quoted strings; all
/// others as literals.
const _maxQuotedValue = 1024;

final _atom = RegExp(r'^[!#$&\x27+,\-./0-9:;<=>?@A-Z\[^_`a-z|}~]+$');

/// An entry name (`/private/vendor/loupe/x`) or other astring argument: an
/// atom when it is one, otherwise a quoted string.
String astringArg(String value) =>
    value.isNotEmpty && _atom.hasMatch(value) && value.toUpperCase() != 'NIL' ? value : quoteImap(value);

/// GETMETADATA for [entries] of [mailboxArg] (already encoded and quoted;
/// `""` for server annotations), with the MAXSIZE option.
String getMetadataCommand(String mailboxArg, List<String> entries, {int? maxSize = metadataMaxSize}) {
  final options = maxSize == null ? '' : ' (MAXSIZE $maxSize)';
  final names = entries.map(astringArg).toList();
  final list = names.length == 1 ? names.single : '(${names.join(' ')})';
  return 'GETMETADATA$options $mailboxArg $list';
}

/// A command with at most one literal: [head] (ending in `{n}` when there is
/// a literal), the [literal] bytes once the server asks for them, then
/// [tail] to finish the line.
final class LiteralCommand {
  const LiteralCommand(this.head, [this.literal, this.tail = '']);

  final String head;
  final Uint8List? literal;
  final String tail;

  /// The command as it goes over the wire (after the tag), CRLF-joined.
  String get wire => literal == null ? head : '$head\r\n${utf8.decode(literal!, allowMalformed: true)}$tail';
}

/// SETMETADATA of one [entry] on [mailboxArg]; a null [value] removes it.
/// Short values that need no escaping are quoted, everything else (JSON
/// with quotes, non-ASCII, long values) goes as a literal.
LiteralCommand setMetadataCommand(String mailboxArg, String entry, String? value) {
  final prefix = 'SETMETADATA $mailboxArg (${astringArg(entry)}';
  if (value == null) return LiteralCommand('$prefix NIL)');
  final bytes = utf8.encode(value);
  final simple = bytes.length <= _maxQuotedValue && isQuotable(value) && !value.contains('"') && !value.contains(r'\');
  if (simple) return LiteralCommand('$prefix ${quoteImap(value)})');
  return LiteralCommand('$prefix {${bytes.length}}', bytes, ')');
}

/// What GETMETADATA returned.
final class MetadataResult {
  const MetadataResult(this.values, {this.longEntries});

  /// Entry name (lower-cased; entry names are case-insensitive) → value.
  /// Entries the server reported as NIL map to null; entries it left out
  /// are missing.
  final Map<String, String?> values;

  /// From `[METADATA LONGENTRIES n]`: the size of the largest entry left
  /// out because it exceeded MAXSIZE.
  final int? longEntries;

  String? operator [](String entry) => values[entry.toLowerCase()];
}

/// The `[METADATA …]` response code of a refused SETMETADATA or GETMETADATA.
enum MetadataRefusal {
  /// `MAXSIZE n`: the value is larger than the server allows.
  maxSize,

  /// `TOOMANY`: the server holds no more entries.
  tooMany,

  /// `NOPRIVATE`: the server has no private annotations.
  noPrivate,

  /// Any other refusal (e.g. Dovecot with `imap_metadata` but no
  /// `mail_attribute_dict`).
  other,
}

/// Reads the refusal from a NO/BAD response text; with [MetadataRefusal.maxSize]
/// also the limit.
(MetadataRefusal, int?) metadataRefusal(String text) {
  final m = RegExp(r'\[METADATA\s+(MAXSIZE|TOOMANY|NOPRIVATE)\s*(\d*)\]', caseSensitive: false).firstMatch(text);
  if (m == null) return (MetadataRefusal.other, null);
  return switch (m[1]!.toUpperCase()) {
    'MAXSIZE' => (MetadataRefusal.maxSize, int.tryParse(m[2]!)),
    'TOOMANY' => (MetadataRefusal.tooMany, null),
    _ => (MetadataRefusal.noPrivate, null),
  };
}

/// Parses `* METADATA <mailbox> (<entry> <value> …)` responses. Unsolicited
/// change notifications (`* METADATA <mailbox> <entry> …`, without values)
/// are ignored.
final class MetadataParser extends ResponseParser<MetadataResult> {
  final _values = <String, String?>{};

  @override
  MetadataResult parse(ImapResponse imapResponse, Response<Object?> response) {
    final m = RegExp(r'\[METADATA\s+LONGENTRIES\s+(\d+)\]', caseSensitive: false).firstMatch(imapResponse.parseText);
    return MetadataResult(Map.unmodifiable(_values), longEntries: m == null ? null : int.parse(m[1]!));
  }

  @override
  bool parseUntagged(ImapResponse imapResponse, Response<Object?>? response) {
    if (!imapResponse.parseText.toUpperCase().startsWith('METADATA ')) return true;
    final tokens = tokenizeResponse(imapResponse);
    // METADATA, mailbox, then a parenthesised list of entry/value pairs.
    if (tokens.length < 4 || tokens[2] != ImapToken.open) return true;
    var i = 3;
    while (i + 1 < tokens.length && tokens[i] != ImapToken.close) {
      final name = tokens[i];
      final value = tokens[i + 1];
      if (name is! ImapString || name.text == null || value is! ImapString) break;
      _values[name.text!.toLowerCase()] = value.text;
      i += 2;
    }
    return true;
  }
}

/// A token of an IMAP response: [ImapToken.open], [ImapToken.close] or an
/// [ImapString].
sealed class ImapToken {
  const ImapToken();

  static const open = _Paren('(');
  static const close = _Paren(')');
}

final class _Paren extends ImapToken {
  const _Paren(this.char);
  final String char;

  @override
  String toString() => char;
}

/// An atom, quoted string, literal or NIL ([text] null).
final class ImapString extends ImapToken {
  const ImapString(this.text, {this.isAtom = false});

  final String? text;

  /// Sent as an atom (not quoted, not a literal).
  final bool isAtom;

  @override
  String toString() => text == null ? 'NIL' : (isAtom ? text! : '"$text"');
}

/// Splits a response into tokens, reading quoted strings with their escapes
/// and literals (including empty ones) from the raw lines.
List<ImapToken> tokenizeResponse(ImapResponse response) {
  final out = <ImapToken>[];
  final lines = response.lines;
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    final raw = line.rawData;
    if (raw != null) {
      out.add(ImapString(utf8.decode(raw, allowMalformed: true)));
      continue;
    }
    var text = line.line ?? '';
    if (i == 0 && text.startsWith('* ')) text = text.substring(2);
    _tokenizeText(text, out);
    if (line.isWithLiteral) {
      // An empty literal has no data line; any other is the next line.
      if (line.literal == 0) {
        out.add(const ImapString(''));
      } else if (i + 1 < lines.length && lines[i + 1].rawData != null) {
        out.add(ImapString(utf8.decode(lines[i + 1].rawData!, allowMalformed: true)));
        i++;
      }
    }
  }
  return out;
}

void _tokenizeText(String text, List<ImapToken> out) {
  var i = 0;
  while (i < text.length) {
    final c = text[i];
    if (c == ' ') {
      i++;
    } else if (c == '(') {
      out.add(ImapToken.open);
      i++;
    } else if (c == ')') {
      out.add(ImapToken.close);
      i++;
    } else if (c == '"') {
      final value = StringBuffer();
      i++;
      while (i < text.length && text[i] != '"') {
        if (text[i] == r'\' && i + 1 < text.length) i++;
        value.write(text[i]);
        i++;
      }
      i++; // closing quote
      out.add(ImapString(value.toString()));
    } else {
      final start = i;
      while (i < text.length && text[i] != ' ' && text[i] != '(' && text[i] != ')') {
        i++;
      }
      final atom = text.substring(start, i);
      out.add(atom.toUpperCase() == 'NIL' ? const ImapString(null) : ImapString(atom, isAtom: true));
    }
  }
}
