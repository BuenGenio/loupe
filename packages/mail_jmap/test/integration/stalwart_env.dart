import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:mail_model/mail_model.dart';

import '../../../../tool/test-servers/stalwart/stalwart.dart';

export '../../../../tool/test-servers/stalwart/stalwart.dart';

/// The Stalwart binary for the integration tests: `LOUPE_TEST_STALWART`,
/// else the development machine's (see tool/test-servers/README.md). Null
/// (the tests skip) when there is none, or when the variable is `0` or `off`.
String? stalwartBinary() {
  final env = Platform.environment['LOUPE_TEST_STALWART'];
  if (env == '0' || env == 'off') return null;
  final path = env == null || env.isEmpty ? defaultStalwartBinary : env;
  return File(path).existsSync() ? path : null;
}

/// Why the integration tests are skipped, or null when they run.
String? get stalwartSkip =>
    stalwartBinary() == null ? 'No Stalwart binary (set LOUPE_TEST_STALWART to its path)' : null;

/// An HTTP client that sends what the test server's session calls
/// `https://mail.example.test/…` to its local listener.
final class StalwartHttpClient extends http.BaseClient {
  StalwartHttpClient(this.server);

  final StalwartServer server;
  final _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final url = server.rewrite(request.url);
    if (url == request.url) return _inner.send(request);
    final copy = request is http.AbortableRequest
        ? http.AbortableRequest(request.method, url, abortTrigger: request.abortTrigger)
        : http.Request(request.method, url);
    copy
      ..headers.addAll(request.headers)
      ..followRedirects = request.followRedirects
      ..bodyBytes = request is http.Request ? request.bodyBytes : const [];
    return _inner.send(copy);
  }

  @override
  void close() => _inner.close();
}

/// A JMAP account of [user] on [server] (plain HTTP on 127.0.0.1).
MailAccount stalwartAccount(StalwartServer server, StalwartUser user, {String id = 'acc'}) => MailAccount(
  id: id,
  email: user.email,
  displayName: 'Stalwart ${user.email.split('@').first}',
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: ServerConfig(
    protocol: ServerProtocol.jmap,
    host: '127.0.0.1',
    port: server.httpPort,
    security: ConnectionSecurity.none,
  ),
  identities: [Identity(id: '$id/default', email: user.email, name: user.email.split('@').first)],
);

/// The same mailbox over IMAP (cross-checks).
MailAccount stalwartImapAccount(StalwartServer server, StalwartUser user, {String id = 'imap'}) => MailAccount(
  id: id,
  email: user.email,
  displayName: 'Stalwart IMAP',
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: ServerConfig(
    protocol: ServerProtocol.imap,
    host: '127.0.0.1',
    port: server.ports['imap']!,
    security: ConnectionSecurity.none,
  ),
  outgoing: ServerConfig(
    protocol: ServerProtocol.smtp,
    host: '127.0.0.1',
    port: server.ports['submission']!,
    security: ConnectionSecurity.none,
  ),
);

CredentialsCallback credentialsOf(StalwartUser user) =>
    ({bool forceRefresh = false}) async => PasswordCredentials(user.password);

var _counter = 0;

/// A small RFC 822 message.
Uint8List testMessage({
  required String subject,
  String from = 'Seeder <seed@example.org>',
  String to = 'alice@example.test',
  String body = 'Hello there',
  DateTime? date,
  String? messageId,
  Map<String, String> headers = const {},
}) {
  final id = messageId ?? '${DateTime.now().microsecondsSinceEpoch}.${++_counter}@example.org';
  final extra = [for (final MapEntry(:key, :value) in headers.entries) '$key: $value\r\n'].join();
  return Uint8List.fromList(
    utf8.encode(
      'From: $from\r\n'
      'To: $to\r\n'
      'Subject: $subject\r\n'
      'Date: ${HttpDate.format(date ?? DateTime.now())}\r\n'
      'Message-ID: <$id>\r\n'
      '$extra'
      'MIME-Version: 1.0\r\n'
      'Content-Type: text/plain; charset=utf-8\r\n'
      'Content-Transfer-Encoding: 8bit\r\n'
      '\r\n'
      '$body\r\n',
    ),
  );
}
