import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mail_model/mail_model.dart';

typedef Json = Map<String, Object?>;

/// A recorded Stalwart exchange from `test/fixtures/stalwart/`.
Json fixture(String name) =>
    (jsonDecode(File('test/fixtures/stalwart/$name.json').readAsStringSync()) as Map).cast<String, Object?>();

/// The arguments of the first method response of a recorded exchange.
Json recordedArgs(String name) => (((fixture(name)['methodResponses']! as List).first as List)[1] as Map).cast();

/// One method call the scripted server got (back-references resolved).
typedef ScriptedCall = ({String name, Json args});

/// A JMAP server in memory: the session resource Stalwart serves
/// (recorded), method handlers the tests script, uploads and downloads.
/// Answers like Stalwart: `/.well-known/jmap` redirects to the session.
final class ScriptedJmap {
  ScriptedJmap({this.password = 'secret', this.bearer, Json? session}) : session = session ?? fixture('session');

  /// The password Basic authentication takes (`alice@example.test`).
  final String password;

  /// A token taken as `Bearer`; null takes none.
  String? bearer;
  Json session;

  /// Method name → handlers, used in turn (the last one repeats).
  final _handlers = <String, List<Object? Function(Json args)>>{};

  /// Every method call, in order.
  final calls = <ScriptedCall>[];

  /// Every HTTP request.
  final requests = <http.BaseRequest>[];

  /// Uploaded blobs by id.
  final blobs = <String, Uint8List>{};
  var _uploads = 0;

  /// The session state answered with every API response.
  String? sessionState;

  /// HTTP status answered to API requests instead of a response, when set.
  int? apiStatus;
  late final http.Client client = MockClient(_handle);

  /// Answers [method] with [respond]'s result: the response arguments, or
  /// a `(type, description)` record for a method error.
  void on(String method, Object? Function(Json args) respond) => _handlers.putIfAbsent(method, () => []).add(respond);

  /// Answers [method] with a method error of [type].
  void fail(String method, String type) => on(method, (_) => (type, 'scripted'));

  /// The calls of [method].
  List<Json> callsOf(String method) => [
    for (final c in calls)
      if (c.name == method) c.args,
  ];

  Future<http.Response> _handle(http.Request request) async {
    requests.add(request);
    final auth = request.headers['Authorization'] ?? '';
    final basic = 'Basic ${base64.encode(utf8.encode('alice@example.test:$password'))}';
    if (auth != basic && (bearer == null || auth != 'Bearer $bearer')) {
      return http.Response(
        '{"type":"about:blank","status":401,"title":"Unauthorized","detail":"You have to authenticate first."}',
        401,
        headers: {'content-type': 'application/problem+json'},
      );
    }
    final path = request.url.path;
    if (path == '/.well-known/jmap') {
      return http.Response('', 307, headers: {'location': 'https://mail.example.test/jmap/session'});
    }
    if (path == '/jmap/session') {
      return http.Response(jsonEncode(session), 200, headers: {'content-type': 'application/json'});
    }
    if (path.startsWith('/jmap/upload/')) {
      final id = 'blob${++_uploads}';
      blobs[id] = request.bodyBytes;
      return http.Response(
        jsonEncode({
          'accountId': 'c',
          'blobId': id,
          'type': request.headers['Content-Type'],
          'size': request.bodyBytes.length,
        }),
        201,
        headers: {'content-type': 'application/json'},
      );
    }
    if (path.startsWith('/jmap/download/')) {
      final id = request.url.pathSegments[3];
      final blob = blobs[id];
      if (blob == null) return http.Response('', 404);
      return http.Response.bytes(blob, 200);
    }
    if (path == '/jmap/' && request.method == 'POST') {
      final status = apiStatus;
      if (status != null) {
        return http.Response('{"type":"urn:ietf:params:jmap:error:limit","status":$status}', status);
      }
      return http.Response(
        jsonEncode(_api((jsonDecode(request.body) as Map).cast())),
        200,
        headers: {'content-type': 'application/json'},
      );
    }
    return http.Response('', 404);
  }

  Json _api(Json body) {
    final responses = <List<Object?>>[];
    for (final c in body['methodCalls']! as List) {
      final call = c as List;
      final name = call[0] as String;
      final id = call[2] as String;
      final args = <String, Object?>{};
      var broken = false;
      for (final MapEntry(:key, :value) in (call[1] as Map).cast<String, Object?>().entries) {
        if (key.startsWith('#')) {
          final ref = (value! as Map).cast<String, Object?>();
          final source = responses.where((r) => r[2] == ref['resultOf'] && r[0] == ref['name']).firstOrNull;
          if (source == null) {
            broken = true;
            break;
          }
          args[key.substring(1)] = pointer(source[1], ref['path']! as String);
        } else {
          args[key] = value;
        }
      }
      if (broken) {
        responses.add([
          'error',
          {'type': 'invalidResultReference'},
          id,
        ]);
        continue;
      }
      calls.add((name: name, args: args));
      final handlers = _handlers[name];
      if (handlers == null || handlers.isEmpty) {
        responses.add([
          'error',
          {'type': 'unknownMethod', 'description': name},
          id,
        ]);
        continue;
      }
      final handler = handlers.length > 1 ? handlers.removeAt(0) : handlers.first;
      final result = handler(args);
      if (result case (final String type, final String description)) {
        responses.add([
          'error',
          {'type': type, 'description': description},
          id,
        ]);
      } else if (result case final List<Object?> several) {
        // Several responses to one call: [name, args] pairs.
        for (final r in several) {
          final pair = r! as List;
          responses.add([pair[0], pair[1], id]);
        }
      } else {
        responses.add([name, result, id]);
      }
    }
    return {'methodResponses': responses, 'sessionState': sessionState ?? session['state']};
  }
}

/// A JSON pointer with `*` over lists (RFC 8620 §3.7).
Object? pointer(Object? json, String path) {
  var current = <Object?>[json];
  var flatten = false;
  for (final raw in path.split('/').skip(1)) {
    final segment = raw.replaceAll('~1', '/').replaceAll('~0', '~');
    final next = <Object?>[];
    for (final value in current) {
      if (segment == '*' && value is List) {
        next.addAll(value);
        flatten = true;
      } else if (value is Map) {
        next.add(value[segment]);
      } else if (value is List) {
        next.add(value[int.parse(segment)]);
      }
    }
    current = next;
  }
  if (!flatten) return current.single;
  return [
    for (final v in current) ...(v is List ? v : [v]),
  ];
}

/// A JMAP account on the scripted server.
MailAccount scriptedAccount({String id = 'acc', String email = 'alice@example.test'}) => MailAccount(
  id: id,
  email: email,
  displayName: 'Test',
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: const ServerConfig(protocol: ServerProtocol.jmap, host: 'mail.example.test', port: 443),
  identities: [Identity(id: '$id/default', email: email)],
);

CredentialsCallback passwordCallback([String password = 'secret']) =>
    ({bool forceRefresh = false}) async => PasswordCredentials(password);

/// Mailboxes as Stalwart lists them, with [extra] ones.
Json mailboxList(List<Json> extra) {
  final recorded = recordedArgs('mailbox_get');
  return {
    ...recorded,
    'list': [...recorded['list']! as List, ...extra],
  };
}

Json mailbox(String id, String name, {String? parentId, String? role, bool subscribed = true}) => {
  'id': id,
  'name': name,
  'parentId': parentId,
  'role': role,
  'sortOrder': 0,
  'isSubscribed': subscribed,
  'totalEmails': 0,
  'unreadEmails': 0,
  'myRights': {'mayReadItems': true},
};

/// An email as Stalwart returns it for a list row.
Json emailJson(
  String id, {
  Map<String, bool> mailboxIds = const {'a': true},
  Map<String, bool> keywords = const {},
  String subject = 'Hello',
  String receivedAt = '2026-10-05T08:00:00Z',
  String threadId = 't1',
}) => {
  'id': id,
  'blobId': 'blob-$id',
  'threadId': threadId,
  'mailboxIds': mailboxIds,
  'keywords': keywords,
  'size': 1000,
  'receivedAt': receivedAt,
  'sentAt': '2026-10-05T10:00:00+02:00',
  'messageId': ['$id@example.org'],
  'inReplyTo': null,
  'references': null,
  'from': [
    {'name': 'Carol', 'email': 'carol@example.org'},
  ],
  'to': [
    {'name': null, 'email': 'alice@example.test'},
  ],
  'cc': null,
  'bcc': null,
  'replyTo': null,
  'subject': subject,
  'preview': 'Preview of $subject',
  'bodyStructure': {
    'partId': '1',
    'blobId': 'part-$id',
    'size': 20,
    'name': null,
    'type': 'text/plain',
    'charset': 'utf-8',
    'disposition': null,
    'cid': null,
    'header:Content-Type': ' text/plain; charset=utf-8',
  },
  'header:List-Id': null,
  'header:List-Post': null,
  'header:List-Unsubscribe': null,
  'header:List-Unsubscribe-Post': null,
};

/// Email/get answering from [emails] by id (only the asked properties
/// don't matter: the transport reads what it needs).
Object? Function(Json args) emailGet(Map<String, Json> emails, {String state = 's1'}) => (args) {
  final ids = (args['ids'] as List?)?.cast<String>() ?? emails.keys.toList();
  return {
    'accountId': 'c',
    'state': state,
    'list': [for (final id in ids) ?emails[id]],
    'notFound': [
      for (final id in ids)
        if (!emails.containsKey(id)) id,
    ],
  };
};
