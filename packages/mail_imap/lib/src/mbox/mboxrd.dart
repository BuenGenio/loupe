/// Writing messages in the mbox format, as its mboxrd variant.
///
/// An mbox file is the messages one after another, each starting with a
/// separator line (`From sender date`). In mboxrd, a line of a message that
/// starts with `From `, after any number of `>`, gets one more `>`, so a
/// reader can tell it from a separator and take the `>` off again: the
/// messages come back exactly. Thunderbird, mutt, Apple Mail and Python's
/// `mailbox` read it. Lines end in LF, as in every Unix mbox; each message
/// ends with an empty line (RFC 4155).
library;

import 'dart:convert';
import 'dart:typed_data';

import '../mime/headers.dart';

const _lf = 0x0a;
const _cr = 0x0d;
const _gt = 0x3e;
const _from = [0x46, 0x72, 0x6f, 0x6d, 0x20]; // "From "

/// [raw] (an RFC 5322 message, as the server has it) as one mboxrd entry:
/// its separator line, the message with LF line ends and `From ` lines
/// quoted, and the empty line that ends it.
///
/// [date] goes in the separator line (the date it arrived, by convention);
/// [sender] too, else [envelopeSender] finds one in the message.
Uint8List mboxrdEntry(List<int> raw, {required DateTime date, String? sender}) {
  final bytes = raw is Uint8List ? raw : Uint8List.fromList(raw);
  final out = BytesBuilder(copy: false)..add(utf8.encode(mboxFromLine(sender ?? envelopeSender(bytes), date)));
  final end = bytes.length;
  var start = 0;
  while (start < end) {
    final newline = bytes.indexOf(_lf, start);
    final next = newline < 0 ? end : newline + 1;
    var lineEnd = newline < 0 ? end : newline;
    // CRLF (and a CR closing the message) becomes LF.
    if (lineEnd > start && bytes[lineEnd - 1] == _cr) lineEnd--;
    if (_needsQuoting(bytes, start, lineEnd)) out.addByte(_gt);
    if (lineEnd > start) out.add(Uint8List.sublistView(bytes, start, lineEnd));
    out.addByte(_lf);
    start = next;
  }
  // The message ends with its own line end (added above when it had none),
  // then the empty line that ends the entry.
  out.addByte(_lf);
  return out.takeBytes();
}

/// An mboxrd file of [messages] in order: empty for none.
Uint8List mboxrdFile(Iterable<({List<int> raw, DateTime date, String? sender})> messages) {
  final out = BytesBuilder(copy: false);
  for (final m in messages) {
    out.add(mboxrdEntry(m.raw, date: m.date, sender: m.sender));
  }
  return out.takeBytes();
}

/// Whether the line from [start] to [end] matches `^>*From `.
bool _needsQuoting(Uint8List bytes, int start, int end) {
  var i = start;
  while (i < end && bytes[i] == _gt) {
    i++;
  }
  if (end - i < _from.length) return false;
  for (var k = 0; k < _from.length; k++) {
    if (bytes[i + k] != _from[k]) return false;
  }
  return true;
}

/// The separator line before a message, with its LF:
/// `From alice@example.org Thu Oct  8 14:03:05 2026`.
String mboxFromLine(String sender, DateTime date) {
  final s = sender.replaceAll(RegExp(r'\s+'), '');
  return 'From ${s.isEmpty ? _unknownSender : s} ${mboxDate(date)}\n';
}

const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

/// [date] in UTC in C's asctime format, as separator lines have it:
/// `Thu Oct  8 14:03:05 2026` (the day padded with a space).
String mboxDate(DateTime date) {
  final d = date.toUtc();
  String two(int n) => n.toString().padLeft(2, '0');
  return '${_weekdays[d.weekday - 1]} ${_months[d.month - 1]} ${d.day.toString().padLeft(2)} '
      '${two(d.hour)}:${two(d.minute)}:${two(d.second)} ${d.year}';
}

/// What separator lines say when a message names no sender.
const _unknownSender = 'MAILER-DAEMON';

final _angleAddress = RegExp(r'<([^<>\s]*)>');
final _bareAddress = RegExp(r'[^\s<>"(),;:]+@[^\s<>"(),;:]+');

/// The sender for the separator line of [raw]: the envelope sender its
/// server recorded (Return-Path), else the address in From (or Sender),
/// else `MAILER-DAEMON` (also for bounces, whose Return-Path is `<>`).
String envelopeSender(List<int> raw) {
  final headers = parseHeaderBlock(_headerBlock(raw), decode: false);
  final returnPath = headerValue(headers, 'Return-Path');
  if (returnPath != null) {
    final address = _address(returnPath);
    if (address != null) return address.isEmpty ? _unknownSender : address;
  }
  for (final name in const ['From', 'Sender']) {
    final value = headerValue(headers, name);
    final address = value == null ? null : _address(value);
    if (address != null && address.isNotEmpty) return address;
  }
  return _unknownSender;
}

/// The address in a header value: the last one in angle brackets (the
/// display name may hold some), else the first bare one; null for none.
String? _address(String value) {
  final bracketed = _angleAddress.allMatches(value).lastOrNull;
  if (bracketed != null) return bracketed[1]!;
  return _bareAddress.firstMatch(value)?[0];
}

/// The header block of [raw], up to its first empty line, so a large message
/// isn't decoded just for its headers.
List<int> _headerBlock(List<int> raw) {
  for (var i = 0; i < raw.length; i++) {
    if (raw[i] != _lf) continue;
    final next = i + 1;
    if (next < raw.length && raw[next] == _lf) return raw.sublist(0, next);
    if (next + 1 < raw.length && raw[next] == _cr && raw[next + 1] == _lf) return raw.sublist(0, next);
  }
  return raw;
}
