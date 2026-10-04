/// Response parsers for the IMAP commands the transport sends. They work on
/// enough_mail's generic value tree and never print.
library;

import 'dart:convert';
import 'dart:typed_data';

import '../mime/dates.dart';
import '../util/uid_set.dart';
import 'body_structure.dart';
import 'envelope.dart';
import 'protocol.dart';
import 'values.dart';

/// Upper-cased capability atoms in [text] (after `CAPABILITY ` or inside a
/// `[CAPABILITY …]` response code).
Set<String> parseCapabilityList(String text) {
  final end = text.indexOf(']');
  final body = end >= 0 ? text.substring(0, end) : text;
  return body.split(RegExp(r'\s+')).where((s) => s.isNotEmpty).map((s) => s.toUpperCase()).toSet();
}

Set<String>? _capabilitiesIn(String text) {
  final i = text.indexOf('[CAPABILITY ');
  if (i >= 0) return parseCapabilityList(text.substring(i + '[CAPABILITY '.length));
  if (text.startsWith('CAPABILITY ')) return parseCapabilityList(text.substring('CAPABILITY '.length));
  return null;
}

/// CAPABILITY, LOGIN and AUTHENTICATE: the capabilities the server
/// reported, or an empty set if it didn't.
final class CapabilityParser extends ResponseParser<Set<String>> {
  Set<String>? _caps;

  @override
  Set<String> parse(ImapResponse imapResponse, Response<Object?> response) =>
      _capabilitiesIn(imapResponse.parseText) ?? _caps ?? <String>{};

  @override
  bool parseUntagged(ImapResponse imapResponse, Response<Object?>? response) {
    final caps = _capabilitiesIn(imapResponse.parseText);
    if (caps != null) _caps = caps;
    return true;
  }
}

/// A tagged response's code and text, plus codes from untagged OKs (MOVE
/// reports COPYUID in an untagged OK).
final class GenericResult {
  const GenericResult(this.codes, this.text);

  /// Response codes without brackets, e.g. `APPENDUID 38505 3955`.
  final List<String> codes;
  final String text;

  String? code(String name) {
    for (final c in codes) {
      if (c == name || c.startsWith('$name ')) return c;
    }
    return null;
  }
}

String? _responseCode(String text) {
  final start = text.indexOf('[');
  if (start < 0) return null;
  final end = text.indexOf(']', start);
  return end < 0 ? null : text.substring(start + 1, end);
}

/// Any command whose interesting output is a response code.
final class GenericParser extends ResponseParser<GenericResult> {
  final _codes = <String>[];

  @override
  GenericResult parse(ImapResponse imapResponse, Response<Object?> response) {
    final text = imapResponse.parseText;
    final code = _responseCode(text);
    return GenericResult([?code, ..._codes], text);
  }

  @override
  bool parseUntagged(ImapResponse imapResponse, Response<Object?>? response) {
    final text = imapResponse.parseText;
    if (text.startsWith('OK [')) {
      final code = _responseCode(text);
      if (code != null) _codes.add(code);
    }
    return true;
  }
}

/// (validity, source UIDs, destination UIDs) of a COPYUID code, or
/// (validity, [], new UIDs) of an APPENDUID code.
(int, List<int>, List<int>)? parseUidPlusCode(String? code) {
  if (code == null) return null;
  final parts = code.split(' ');
  try {
    if (parts.first == 'COPYUID' && parts.length >= 4) {
      return (int.parse(parts[1]), parseSequenceSet(parts[2]), parseSequenceSet(parts[3]));
    }
    if (parts.first == 'APPENDUID' && parts.length >= 3) {
      return (int.parse(parts[1]), const <int>[], parseSequenceSet(parts[2]));
    }
  } on FormatException {
    return null;
  }
  return null;
}

/// What SELECT/EXAMINE reported.
final class SelectData {
  int exists = 0;
  int? uidValidity;
  int? uidNext;
  int? highestModSeq;
  bool noModSeq = false;
  bool readOnly = false;
  List<String> permanentFlags = const [];

  /// Whether the server sent PERMANENTFLAGS at all.
  bool permanentFlagsSent = false;

  /// Whether new keywords are stored permanently (`\*` in PERMANENTFLAGS);
  /// null if the server didn't say, which RFC 9051 says means yes.
  bool? get canStoreKeywords => permanentFlagsSent ? permanentFlags.contains(r'\*') : null;
}

final class SelectParser extends ResponseParser<SelectData> {
  final _data = SelectData();

  @override
  SelectData parse(ImapResponse imapResponse, Response<Object?> response) {
    final text = imapResponse.parseText;
    if (text.contains('[READ-ONLY]')) _data.readOnly = true;
    final hms = RegExp(r'\[HIGHESTMODSEQ (\d+)\]').firstMatch(text);
    if (hms != null) _data.highestModSeq = int.parse(hms[1]!);
    return _data;
  }

  @override
  bool parseUntagged(ImapResponse imapResponse, Response<Object?>? response) {
    final text = imapResponse.parseText;
    final exists = RegExp(r'^(\d+) EXISTS').firstMatch(text);
    if (exists != null) {
      _data.exists = int.parse(exists[1]!);
      return true;
    }
    final code = text.startsWith('OK [') ? _responseCode(text) : null;
    if (code != null) {
      final parts = code.split(' ');
      switch (parts.first) {
        case 'UIDVALIDITY':
          _data.uidValidity = int.tryParse(parts.length > 1 ? parts[1] : '');
        case 'UIDNEXT':
          _data.uidNext = int.tryParse(parts.length > 1 ? parts[1] : '');
        case 'HIGHESTMODSEQ':
          _data.highestModSeq = int.tryParse(parts.length > 1 ? parts[1] : '');
        case 'NOMODSEQ':
          _data.noModSeq = true;
        case 'PERMANENTFLAGS':
          _data.permanentFlagsSent = true;
          _data.permanentFlags = code
              .substring('PERMANENTFLAGS'.length)
              .replaceAll(RegExp(r'[()]'), ' ')
              .split(' ')
              .where((s) => s.isNotEmpty)
              .toList();
      }
    }
    return true;
  }
}

/// STATUS items (upper-cased names → values).
final class StatusParser extends ResponseParser<Map<String, int>> {
  final _items = <String, int>{};

  @override
  Map<String, int> parse(ImapResponse imapResponse, Response<Object?> response) => _items;

  @override
  bool parseUntagged(ImapResponse imapResponse, Response<Object?>? response) {
    if (!imapResponse.parseText.startsWith('STATUS ')) return true;
    final values = imapResponse.iterate().values;
    for (final v in values) {
      if (isList(v)) {
        final items = v.children!;
        for (var i = 0; i + 1 < items.length; i += 2) {
          final name = items[i].value?.toUpperCase();
          final n = intOf(items[i + 1]);
          if (name != null && n != null) _items[name] = n;
        }
      }
    }
    return true;
  }
}

/// One LIST or LSUB line.
final class ListEntry {
  const ListEntry(this.flags, this.delimiter, this.rawName);

  /// Lower-cased attributes, e.g. `\noselect`, `\sent`.
  final Set<String> flags;
  final String? delimiter;

  /// Mailbox name as sent (modified UTF-7 unless UTF8=ACCEPT is enabled).
  final String rawName;
}

final class ListParser extends ResponseParser<List<ListEntry>> {
  final _entries = <ListEntry>[];

  @override
  List<ListEntry> parse(ImapResponse imapResponse, Response<Object?> response) => _entries;

  @override
  bool parseUntagged(ImapResponse imapResponse, Response<Object?>? response) {
    final text = imapResponse.parseText;
    if (!text.startsWith('LIST ') && !text.startsWith('LSUB ') && !text.startsWith('XLIST ')) return true;
    final values = imapResponse.iterate().values;
    final idx = values.indexWhere((v) => v.value == 'LIST' || v.value == 'LSUB' || v.value == 'XLIST');
    if (idx < 0 || idx + 3 >= values.length) return true;
    final flags = {
      for (final f in values[idx + 1].children ?? const <ImapValue>[])
        if (stringOf(f) case final s?) s.toLowerCase(),
    };
    final delimiter = stringOf(values[idx + 2]);
    final name = stringOf(values[idx + 3]);
    if (name != null) _entries.add(ListEntry(flags, delimiter, name));
    return true;
  }
}

/// SEARCH or ESEARCH results.
final class SearchData {
  SearchData();
  final ids = <int>[];
  int? count;
  int? min;
  int? max;
}

final class SearchParser extends ResponseParser<SearchData> {
  final _data = SearchData();

  @override
  SearchData parse(ImapResponse imapResponse, Response<Object?> response) => _data;

  @override
  bool parseUntagged(ImapResponse imapResponse, Response<Object?>? response) {
    final text = imapResponse.parseText;
    if (text == 'SEARCH' || text.startsWith('SEARCH ')) {
      final body = text.length > 7 ? text.substring(7).replaceAll(RegExp(r'\(MODSEQ \d+\)'), '') : '';
      _data.ids.addAll(body.split(' ').map(int.tryParse).nonNulls);
      return true;
    }
    if (text.startsWith('ESEARCH')) {
      final body = text.replaceFirst(RegExp(r'^ESEARCH\s*(\(TAG "[^"]*"\))?\s*(UID\s*)?'), '');
      final tokens = body.split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();
      for (var i = 0; i + 1 < tokens.length; i += 2) {
        final value = tokens[i + 1];
        switch (tokens[i].toUpperCase()) {
          case 'ALL':
            try {
              _data.ids.addAll(parseSequenceSet(value));
            } on FormatException {
              // Ignore a malformed set.
            }
          case 'COUNT':
            _data.count = int.tryParse(value);
          case 'MIN':
            _data.min = int.tryParse(value);
          case 'MAX':
            _data.max = int.tryParse(value);
        }
      }
      return true;
    }
    return true;
  }
}

/// One message from a FETCH response.
final class FetchedMessage {
  FetchedMessage(this.seq);

  final int seq;
  int? uid;
  List<String>? flags;
  int? modSeq;
  DateTime? internalDate;
  int? size;
  ImapEnvelope? envelope;
  BodyNode? structure;

  /// Gmail X-GM-THRID.
  String? gmailThreadId;

  /// Raw section contents by upper-cased section spec: `` for `BODY[]`,
  /// `HEADER`, `HEADER.FIELDS`, `1.2`, `TEXT`.
  final sections = <String, Uint8List>{};
}

final class FetchResult {
  const FetchResult(this.messages, this.vanished);
  final List<FetchedMessage> messages;

  /// UIDs from `VANISHED (EARLIER)` (QRESYNC).
  final List<int> vanished;
}

final _fetchLine = RegExp(r'^(\d+) FETCH');
final _origin = RegExp(r'^<?\d+>$');

/// FETCH and UID FETCH. Messages are merged by sequence number, so a server
/// that splits one message over several responses is fine.
final class FetchParser extends ResponseParser<FetchResult> {
  final _bySeq = <int, FetchedMessage>{};
  final _vanished = <int>[];

  @override
  FetchResult parse(ImapResponse imapResponse, Response<Object?> response) =>
      FetchResult(_bySeq.values.toList(), _vanished);

  @override
  bool parseUntagged(ImapResponse imapResponse, Response<Object?>? response) {
    final text = imapResponse.parseText;
    if (text.startsWith('VANISHED (EARLIER) ')) {
      try {
        _vanished.addAll(parseSequenceSet(text.substring('VANISHED (EARLIER) '.length)));
      } on FormatException {
        // Ignore a malformed set.
      }
      return true;
    }
    final m = _fetchLine.firstMatch(text);
    if (m == null) return true;
    final seq = int.parse(m[1]!);
    final message = _bySeq.putIfAbsent(seq, () => FetchedMessage(seq));
    final values = imapResponse.iterate().values;
    final fetch = values.where((v) => v.value == 'FETCH').firstOrNull;
    final items = fetch?.children;
    if (items != null) parseFetchItems(items, message);
    return true;
  }
}

/// Fills [message] from the items of one FETCH response.
void parseFetchItems(List<ImapValue> items, FetchedMessage message) {
  var i = 0;
  ImapValue? next() => i + 1 < items.length ? items[i + 1] : null;
  while (i < items.length) {
    final name = items[i].value?.toUpperCase();
    if (name == null) {
      i++;
      continue;
    }
    switch (name) {
      case 'UID':
        message.uid = intOf(next() ?? ImapValue(null));
        i += 2;
      case 'FLAGS':
        message.flags = [for (final f in items[i].children ?? const <ImapValue>[]) ?stringOf(f)];
        i++;
      case 'MODSEQ':
        final list = next()?.children;
        message.modSeq = list == null || list.isEmpty ? null : intOf(list.first);
        i += 2;
      case 'INTERNALDATE':
        message.internalDate = parseMailDate(stringOf(next() ?? ImapValue(null)));
        i += 2;
      case 'RFC822.SIZE':
        message.size = intOf(next() ?? ImapValue(null));
        i += 2;
      case 'ENVELOPE':
        message.envelope = parseEnvelope(items[i].children ?? const []);
        i++;
      case 'BODYSTRUCTURE' || 'BODY':
        final children = items[i].children;
        if (children != null && children.isNotEmpty) message.structure = parseBodyStructure(children);
        i++;
      case 'X-GM-THRID':
        message.gmailThreadId = stringOf(next() ?? ImapValue(null));
        i += 2;
      case 'X-GM-MSGID' || 'X-GM-LABELS':
        i += 2;
      default:
        final section = _sectionKey(name);
        if (section == null) {
          i++;
          continue;
        }
        var j = i + 1;
        if (j < items.length && _origin.hasMatch(items[j].value ?? '')) j++;
        if (j < items.length) message.sections[section] = _bytesOf(items[j]);
        i = j + 1;
    }
  }
}

String? _sectionKey(String name) {
  if (name == 'RFC822') return '';
  if (name == 'RFC822.HEADER') return 'HEADER';
  if (name == 'RFC822.TEXT') return 'TEXT';
  final open = name.indexOf('[');
  if (open < 0 || !name.endsWith(']')) return null;
  final prefix = name.substring(0, open);
  if (prefix != 'BODY' && prefix != 'BINARY' && prefix != 'BODY.PEEK' && prefix != 'BINARY.PEEK') return null;
  final spec = name.substring(open + 1, name.length - 1);
  if (spec.startsWith('HEADER.FIELDS')) return 'HEADER.FIELDS';
  return spec;
}

Uint8List _bytesOf(ImapValue v) {
  final data = v.data;
  if (data != null) return data;
  final value = v.value;
  if (value == null || value == 'NIL') return Uint8List(0);
  return utf8.encode(value);
}
