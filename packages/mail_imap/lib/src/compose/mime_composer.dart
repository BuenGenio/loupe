/// RFC 5322 / MIME message composition.
library;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

/// Builds outgoing messages:
/// - `text/plain; charset=utf-8`, quoted-printable;
/// - `multipart/alternative` with an HTML part when [OutgoingMessage.html] is set;
/// - `multipart/mixed` around it when there are attachments (base64);
/// - RFC 2047 encoded headers, RFC 2231 file names;
/// - Date, Message-ID, In-Reply-To, References, MIME-Version, User-Agent.
///
/// Bcc recipients are never written into the message; they only go into the
/// SMTP envelope. The signature is not appended here: the compose screen puts
/// it into the body so the user can edit it.
final class MimeMessageComposer implements MessageComposer {
  MimeMessageComposer({Random? random}) : _random = random ?? Random.secure();

  final Random _random;

  static const userAgent = 'Loupe/0.1';

  @override
  Uint8List compose(OutgoingMessage message, Identity from, {required String messageId, DateTime? date}) {
    final out = StringBuffer();
    void header(String line) => out.write('$line\r\n');

    header('Date: ${formatMailDate(date ?? DateTime.now())}');
    header(addressHeader('From', [EmailAddress(from.email, from.name)]));
    final replyTo = from.replyTo?.trim();
    if (replyTo != null && replyTo.isNotEmpty) header(addressHeader('Reply-To', [EmailAddress(replyTo)]));
    if (message.to.isNotEmpty) header(addressHeader('To', message.to));
    if (message.cc.isNotEmpty) header(addressHeader('Cc', message.cc));
    header(unstructuredHeader('Subject', message.subject));
    header('Message-ID: <${_bare(messageId)}>');
    final inReplyTo = message.inReplyTo;
    if (inReplyTo != null && inReplyTo.trim().isNotEmpty) header('In-Reply-To: <${_bare(inReplyTo)}>');
    final refs = [for (final r in message.references) '<${_bare(r)}>'];
    if (inReplyTo != null && inReplyTo.trim().isNotEmpty && !refs.contains('<${_bare(inReplyTo)}>')) {
      refs.add('<${_bare(inReplyTo)}>');
    }
    if (refs.isNotEmpty) header(foldWords('References:', refs));
    header('MIME-Version: 1.0');
    header('User-Agent: $userAgent');

    final text = _MimePart([
      'Content-Type: text/plain; charset=utf-8',
      'Content-Transfer-Encoding: quoted-printable',
    ], encodeQuotedPrintable(utf8.encode(_crlf(message.text))));
    var body = text;
    final html = message.html;
    if (html != null && html.trim().isNotEmpty) {
      final htmlPart = _MimePart([
        'Content-Type: text/html; charset=utf-8',
        'Content-Transfer-Encoding: quoted-printable',
      ], encodeQuotedPrintable(utf8.encode(_crlf(html))));
      body = _multipart('alternative', [text, htmlPart]);
    }
    if (message.attachments.isNotEmpty) {
      body = _multipart('mixed', [body, for (final a in message.attachments) _attachment(a)]);
    }
    for (final h in body.headers) {
      header(h);
    }
    out
      ..write('\r\n')
      ..write(body.body);
    return Uint8List.fromList(ascii.encode(out.toString()));
  }

  _MimePart _multipart(String subtype, List<_MimePart> parts) {
    final boundary =
        '----=_Loupe_${List.generate(16, (_) => _random.nextInt(256).toRadixString(16).padLeft(2, '0')).join()}';
    final body = StringBuffer();
    for (final p in parts) {
      body.write('--$boundary\r\n');
      for (final h in p.headers) {
        body.write('$h\r\n');
      }
      body
        ..write('\r\n')
        ..write(p.body);
      if (!p.body.endsWith('\r\n')) body.write('\r\n');
    }
    body.write('--$boundary--\r\n');
    return _MimePart(['Content-Type: multipart/$subtype;\r\n boundary="$boundary"'], body.toString());
  }

  _MimePart _attachment(OutgoingAttachment a) {
    final type = RegExp(r'^[\w.+-]+/[\w.+-]+$').hasMatch(a.mimeType.trim())
        ? a.mimeType.trim().toLowerCase()
        : 'application/octet-stream';
    final name = a.filename.replaceAll(RegExp(r'[\r\n"\\/]'), '_');
    final ascii = name.codeUnits.every((c) => c >= 0x20 && c < 0x7f);
    final quotedName = ascii ? '"$name"' : '"${encodeWords(name).join(' ')}"';
    final disposition = ascii ? ['filename="$name"'] : rfc2231Parameter('filename', name);
    return _MimePart([
      'Content-Type: $type;\r\n name=$quotedName',
      'Content-Disposition: attachment;\r\n ${disposition.join(';\r\n ')}',
      'Content-Transfer-Encoding: base64',
    ], _base64Lines(a.data));
  }
}

final class _MimePart {
  const _MimePart(this.headers, this.body);

  /// Header lines (may contain folds).
  final List<String> headers;
  final String body;
}

String _bare(String id) {
  var s = id.trim();
  if (s.startsWith('<')) s = s.substring(1);
  if (s.endsWith('>')) s = s.substring(0, s.length - 1);
  return s;
}

String _crlf(String s) => s.replaceAll('\r\n', '\n').replaceAll('\r', '\n').replaceAll('\n', '\r\n');

String _base64Lines(Uint8List data) {
  final b64 = base64.encode(data);
  final out = StringBuffer();
  for (var i = 0; i < b64.length; i += 76) {
    out
      ..write(b64.substring(i, min(i + 76, b64.length)))
      ..write('\r\n');
  }
  return out.toString();
}

const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

/// RFC 5322 date in the date's own time zone: `Mon, 06 Oct 2025 10:00:00 +0200`.
String formatMailDate(DateTime date) {
  final d = date.isUtc ? date : date.toLocal();
  final offset = d.isUtc ? Duration.zero : d.timeZoneOffset;
  String two(int n) => n.toString().padLeft(2, '0');
  final sign = offset.isNegative ? '-' : '+';
  final abs = offset.abs();
  return '${_weekdays[d.weekday - 1]}, ${two(d.day)} ${_monthNames[d.month - 1]} ${d.year} '
      '${two(d.hour)}:${two(d.minute)}:${two(d.second)} $sign${two(abs.inHours)}${two(abs.inMinutes % 60)}';
}

bool _isAscii(String s) => s.codeUnits.every((c) => c < 0x7f && (c >= 0x20 || c == 0x09));

/// RFC 2047 "B" encoded words for [text], each at most 75 characters,
/// never splitting a character.
List<String> encodeWords(String text) {
  const maxBytes = 45; // 60 base64 characters + 12 of framing ≤ 75
  final words = <String>[];
  final chunk = <int>[];
  for (final rune in text.runes) {
    final bytes = utf8.encode(String.fromCharCode(rune));
    if (chunk.length + bytes.length > maxBytes) {
      words.add('=?UTF-8?B?${base64.encode(chunk)}?=');
      chunk.clear();
    }
    chunk.addAll(bytes);
  }
  if (chunk.isNotEmpty || words.isEmpty) words.add('=?UTF-8?B?${base64.encode(chunk)}?=');
  return words;
}

/// Folds `Name: word word …` at word boundaries to lines of at most 78.
String foldWords(String start, List<String> words) {
  final out = StringBuffer(start);
  var lineLength = start.length;
  for (final (i, w) in words.indexed) {
    if (i > 0 && lineLength + 1 + w.length > 78) {
      out.write('\r\n $w');
      lineLength = 1 + w.length;
    } else {
      out.write(' $w');
      lineLength += 1 + w.length;
    }
  }
  return out.toString();
}

/// An unstructured header (Subject): plain and folded when ASCII, encoded
/// words otherwise.
String unstructuredHeader(String name, String value) {
  final clean = value.replaceAll(RegExp(r'[\r\n]+'), ' ');
  if (_isAscii(clean) && !clean.contains('=?')) {
    final words = clean.split(' ');
    return words.length <= 1 ? '$name: $clean' : foldWords('$name:', words);
  }
  return foldWords('$name:', encodeWords(clean));
}

const _specials = '()<>[]:;@\\,."';

/// A display name as a phrase: atoms as is, quoted when it has specials,
/// encoded words when it isn't ASCII.
String encodePhrase(String name) {
  final n = name.replaceAll(RegExp(r'[\r\n]+'), ' ').trim();
  if (!_isAscii(n) || n.contains('=?')) return encodeWords(n).join(' ');
  if (n.split('').any(_specials.contains)) return '"${n.replaceAll(r'\', r'\\').replaceAll('"', r'\"')}"';
  return n;
}

/// An address list header, folded between addresses.
String addressHeader(String name, List<EmailAddress> addresses) {
  final items = <String>[];
  for (var i = 0; i < addresses.length; i++) {
    final a = addresses[i];
    final display = a.name?.trim();
    final mailbox = display == null || display.isEmpty
        ? a.email.trim()
        : '${encodePhrase(display)} <${a.email.trim()}>';
    items.add(i < addresses.length - 1 ? '$mailbox,' : mailbox);
  }
  return foldWords('$name:', items);
}

final _attrChar = RegExp(r'[A-Za-z0-9!#$&+.^_`|~-]');

/// An RFC 2231 extended parameter, split into continuations when long.
List<String> rfc2231Parameter(String name, String value) {
  final encoded = StringBuffer();
  for (final b in utf8.encode(value)) {
    final c = String.fromCharCode(b);
    if (_attrChar.hasMatch(c)) {
      encoded.write(c);
    } else {
      encoded.write('%${b.toRadixString(16).toUpperCase().padLeft(2, '0')}');
    }
  }
  final all = "UTF-8''$encoded";
  if (all.length <= 60) return ['$name*=$all'];
  final parts = <String>[];
  var i = 0;
  var n = 0;
  while (i < all.length) {
    var end = min(i + 60, all.length);
    // Don't split a %XX escape.
    final pct = all.lastIndexOf('%', end - 1);
    if (pct >= i && pct > end - 3 && end < all.length) end = pct;
    parts.add('$name*$n*=${all.substring(i, end)}');
    i = end;
    n++;
  }
  return parts;
}

/// Quoted-printable encoding (RFC 2045) of CRLF text; lines stay within 76
/// characters, and a leading "." or "From " is escaped for transport safety.
String encodeQuotedPrintable(List<int> bytes) {
  final out = StringBuffer();
  var line = StringBuffer();
  void softBreak() {
    out
      ..write(line)
      ..write('=\r\n');
    line = StringBuffer();
  }

  void emit(String token) {
    if (line.length + token.length > 75) softBreak();
    line.write(token);
  }

  String hex(int b) => '=${b.toRadixString(16).toUpperCase().padLeft(2, '0')}';

  for (var i = 0; i < bytes.length; i++) {
    final b = bytes[i];
    if (b == 0x0d && i + 1 < bytes.length && bytes[i + 1] == 0x0a) {
      out
        ..write(line)
        ..write('\r\n');
      line = StringBuffer();
      i++;
      continue;
    }
    final atEnd = i + 1 >= bytes.length || bytes[i + 1] == 0x0d;
    final atStart = line.isEmpty;
    if (b == 0x20 || b == 0x09) {
      emit(atEnd ? hex(b) : String.fromCharCode(b));
    } else if (atStart && b == 0x2e) {
      emit(hex(b));
    } else if (atStart && b == 0x46 && _startsWith(bytes, i, 'From ')) {
      emit(hex(b));
    } else if (b >= 33 && b <= 126 && b != 0x3d) {
      emit(String.fromCharCode(b));
    } else {
      emit(hex(b));
    }
  }
  out.write(line);
  return out.toString();
}

bool _startsWith(List<int> bytes, int i, String s) {
  if (i + s.length > bytes.length) return false;
  for (var j = 0; j < s.length; j++) {
    if (bytes[i + j] != s.codeUnitAt(j)) return false;
  }
  return true;
}
