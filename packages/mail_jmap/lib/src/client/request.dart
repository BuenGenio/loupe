/// JMAP requests: batches of method calls with result references
/// (RFC 8620 §3.3, §3.7).
library;

import 'errors.dart';
import 'session.dart';

typedef Json = Map<String, Object?>;

/// One method call in a [JmapRequest].
final class JmapCall {
  JmapCall._(this.name, this.args, this.id);

  final String name;
  final Json args;

  /// The call id, unique in its request.
  final String id;

  /// A result reference to [path] (a JSON pointer, e.g. `/ids` or
  /// `/list/*/id`) in this call's response. Pass it as `#<argument>`.
  Json ref(String path) => {'resultOf': id, 'name': name, 'path': path};
}

/// A batch of method calls sent in one HTTP request.
final class JmapRequest {
  JmapRequest([Iterable<String> using = const [JmapCapabilities.mail]]) : using = {JmapCapabilities.core, ...using};

  final Set<String> using;
  final calls = <JmapCall>[];

  /// Adds a call; later calls can refer to its results with [JmapCall.ref].
  JmapCall add(String name, Json args) {
    final call = JmapCall._(name, args, 'c${calls.length}');
    calls.add(call);
    return call;
  }

  Json toJson() => {
    'using': using.toList(),
    'methodCalls': [
      for (final c in calls) [c.name, c.args, c.id],
    ],
  };
}

/// The method responses to a [JmapRequest].
final class JmapResponse {
  JmapResponse(this.responses, {this.sessionState});

  /// Parses a response body; throws [FormatException] if it isn't one.
  factory JmapResponse.fromJson(Json json) {
    final list = json['methodResponses'];
    if (list is! List) throw const FormatException('No methodResponses');
    return JmapResponse([
      for (final r in list)
        if (r is List && r.length == 3 && r[0] is String && r[1] is Map && r[2] is String)
          (name: r[0] as String, args: (r[1] as Map).cast<String, Object?>(), id: r[2] as String),
    ], sessionState: json['sessionState']?.toString());
  }

  final List<({String name, Json args, String id})> responses;

  /// The session state the server is at; when it differs from the session's,
  /// the session must be fetched again.
  final String? sessionState;

  /// The arguments of [call]'s response. Throws a [JmapException] when the
  /// server answered with a method error, or sent no response at all.
  Json of(JmapCall call) {
    for (final r in responses) {
      if (r.id != call.id) continue;
      if (r.name == 'error') throw methodError(call.name, r.args);
      if (r.name == call.name) return r.args;
    }
    throw JmapException('serverFail', methodErrorKind('serverFail'), 'No response to ${call.name}');
  }

  /// The method error [call] got, or null.
  JmapException? errorOf(JmapCall call) {
    for (final r in responses) {
      if (r.id == call.id && r.name == 'error') return methodError(call.name, r.args);
    }
    return null;
  }

  /// A further response to [call] named [name]: the implicit `Email/set` of
  /// an `EmailSubmission/set` with `onSuccessUpdateEmail`, for example.
  Json? implicit(JmapCall call, String name) {
    for (final r in responses) {
      if (r.id == call.id && r.name == name) return r.args;
    }
    return null;
  }
}

/// Splits [items] into chunks of at most [size].
Iterable<List<T>> chunksOf<T>(List<T> items, int size) sync* {
  for (var i = 0; i < items.length; i += size) {
    yield items.sublist(i, i + size > items.length ? items.length : i + size);
  }
}

/// A JMAP id set (`{"id": true, …}`) as a set of ids.
Set<String> idSet(Object? json) => {
  if (json is Map)
    for (final MapEntry(:key, :value) in json.entries)
      if (key is String && value == true) key,
};

/// A list of strings, ignoring anything else.
List<String> stringList(Object? json) => [
  if (json is List)
    for (final s in json)
      if (s is String) s,
];

/// Escapes a JSON pointer segment (RFC 6901): keywords may contain `/`.
String pointerSegment(String s) => s.replaceAll('~', '~0').replaceAll('/', '~1');
