/// Server-sent events (the `text/event-stream` format JMAP push uses,
/// RFC 8620 §7.3).
library;

import 'dart:async';
import 'dart:convert';

/// One event of a stream.
final class ServerEvent {
  const ServerEvent(this.type, this.data, {this.id});

  /// The `event:` field; `message` when absent.
  final String type;

  /// The `data:` lines, joined with newlines.
  final String data;
  final String? id;

  @override
  String toString() => 'ServerEvent($type, $data)';
}

/// Parses a byte stream of server-sent events.
Stream<ServerEvent> parseServerEvents(Stream<List<int>> bytes) async* {
  String? type;
  String? id;
  final data = <String>[];
  await for (final line in const LineSplitter().bind(const Utf8Decoder(allowMalformed: true).bind(bytes))) {
    if (line.isEmpty) {
      if (data.isNotEmpty || type != null) {
        yield ServerEvent(type ?? 'message', data.join('\n'), id: id);
      }
      type = null;
      data.clear();
      continue;
    }
    if (line.startsWith(':')) continue;
    final colon = line.indexOf(':');
    final field = colon < 0 ? line : line.substring(0, colon);
    var value = colon < 0 ? '' : line.substring(colon + 1);
    if (value.startsWith(' ')) value = value.substring(1);
    switch (field) {
      case 'event':
        type = value;
      case 'data':
        data.add(value);
      case 'id':
        id = value;
    }
  }
}

/// The new states in a JMAP `StateChange` push event (RFC 8620 §7.1) for
/// [accountId]: type name (`Email`, `Mailbox`…) → state. Empty for other
/// events or other accounts.
Map<String, String> stateChangesOf(ServerEvent event, String accountId) {
  if (event.type != 'state' && event.type != 'message') return const {};
  try {
    final json = jsonDecode(event.data);
    if (json is! Map || json['@type'] != 'StateChange') return const {};
    final changed = json['changed'];
    if (changed is! Map) return const {};
    final mine = changed[accountId];
    if (mine is! Map) return const {};
    return {
      for (final MapEntry(:key, :value) in mine.entries)
        if (key is String && value is String) key: value,
    };
  } on FormatException {
    return const {};
  }
}
