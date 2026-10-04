import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mail_imap/mail_imap.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/scripted_imap_server.dart';

MailAccount _account({int imapPort = 1, int smtpPort = 1}) => MailAccount(
  id: 'acc',
  email: 'me@gmail.com',
  displayName: 'Gmail',
  provider: ProviderKind.gmail,
  authKind: AuthKind.oauth2,
  incoming: ServerConfig(
    protocol: ServerProtocol.imap,
    host: '127.0.0.1',
    port: imapPort,
    security: ConnectionSecurity.none,
  ),
  outgoing: ServerConfig(
    protocol: ServerProtocol.smtp,
    host: '127.0.0.1',
    port: smtpPort,
    security: ConnectionSecurity.none,
  ),
);

/// The bearer token in an XOAUTH2 initial response.
String _bearer(String base64Response) =>
    RegExp(r'auth=Bearer ([^\u0001]*)').firstMatch(utf8.decode(base64.decode(base64Response)))!.group(1)!;

/// Credentials as the app's callback gives them: a stale token, a fresh one
/// on a forced refresh. Records every call's forceRefresh.
final class _Tokens {
  final calls = <bool>[];

  Future<Credentials> call({bool forceRefresh = false}) async {
    calls.add(forceRefresh);
    return OAuthCredentials(
      accessToken: forceRefresh ? 'fresh' : 'stale',
      refreshToken: 'r',
      expiresAt: DateTime.now().add(const Duration(hours: 1)),
    );
  }
}

/// A loopback SMTP server offering AUTH XOAUTH2 that takes [accepted]
/// tokens, answering others like Gmail (a 334 JSON challenge, then 535).
final class _SmtpServer {
  _SmtpServer._(this._socket) {
    _socket.listen(_session);
  }

  static Future<_SmtpServer> start() async => _SmtpServer._(await ServerSocket.bind(InternetAddress.loopbackIPv4, 0));

  final ServerSocket _socket;
  final tokens = <String>[];
  Set<String> accepted = const {};
  int messages = 0;

  int get port => _socket.port;

  void _session(Socket client) {
    var data = false;
    var challenged = false;
    client.write('220 smtp.test ready\r\n');
    client.cast<List<int>>().transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
      if (data) {
        if (line == '.') {
          data = false;
          messages++;
          client.write('250 2.0.0 OK\r\n');
        }
        return;
      }
      if (challenged) {
        challenged = false;
        client.write('535 5.7.8 Username and Password not accepted\r\n');
        return;
      }
      final verb = line.split(' ').first.toUpperCase();
      switch (verb) {
        case 'EHLO':
          client.write('250-smtp.test\r\n250-AUTH XOAUTH2 PLAIN\r\n250 8BITMIME\r\n');
        case 'AUTH':
          final token = _bearer(line.split(' ')[2]);
          tokens.add(token);
          if (accepted.contains(token)) {
            client.write('235 2.7.0 Accepted\r\n');
          } else {
            challenged = true;
            client.write('334 ${base64.encode(utf8.encode('{"status":"400","schemes":"Bearer"}'))}\r\n');
          }
        case 'DATA':
          data = true;
          client.write('354 Go ahead\r\n');
        case 'QUIT':
          client.write('221 Bye\r\n');
          unawaited(client.close());
        default:
          client.write('250 OK\r\n');
      }
    }, onError: (Object _) {});
  }

  Future<void> close() => _socket.close();
}

void main() {
  group('IMAP XOAUTH2', () {
    late ScriptedImapServer server;

    setUp(() async {
      server = await ScriptedImapServer.start();
      server.capabilities = 'IMAP4rev1 SASL-IR AUTH=XOAUTH2 AUTH=OAUTHBEARER';
    });

    tearDown(() => server.close());

    List<String> sentTokens() => [for (final a in server.authentications) _bearer(a.split(' ').last)];

    test('AUTHENTICATIONFAILED gets exactly one forced refresh', () async {
      server.authReply = (command) => _bearer(command.split(' ').last) == 'fresh'
          ? null
          : 'NO [AUTHENTICATIONFAILED] Invalid credentials (Failure)';
      final tokens = _Tokens();
      final transport = ImapTransport(_account(imapPort: server.port), tokens.call);
      await transport.connect();
      expect(tokens.calls, [false, true]);
      expect(sentTokens(), ['stale', 'fresh']);
      expect(server.authentications.first, startsWith('AUTHENTICATE XOAUTH2 '));
      await transport.disconnect();
    });

    test('a token still refused after the refresh fails without another try', () async {
      server.authReply = (_) => 'NO [AUTHENTICATIONFAILED] Invalid credentials (Failure)';
      final tokens = _Tokens();
      final transport = ImapTransport(_account(imapPort: server.port), tokens.call);
      await expectLater(
        transport.connect(),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.authentication)),
      );
      expect(tokens.calls, [false, true]);
      expect(server.authentications, hasLength(2));
    });

    test('a refresh that needs a new sign-in surfaces as such', () async {
      server.authReply = (_) => 'NO [AUTHENTICATIONFAILED] Invalid credentials (Failure)';
      final calls = <bool>[];
      final transport = ImapTransport(_account(imapPort: server.port), ({forceRefresh = false}) async {
        calls.add(forceRefresh);
        if (forceRefresh) throw const SignInRequiredException();
        return OAuthCredentials(accessToken: 'revoked', refreshToken: 'r', expiresAt: DateTime.now());
      });
      await expectLater(transport.connect(), throwsA(isA<SignInRequiredException>()));
      expect(calls, [false, true]);
    });

    test('passwords are never refreshed', () async {
      server
        ..capabilities = 'IMAP4rev1 SASL-IR AUTH=PLAIN'
        ..authReply = (_) => 'NO [AUTHENTICATIONFAILED] Invalid credentials';
      final calls = <bool>[];
      final transport = ImapTransport(_account(imapPort: server.port), ({forceRefresh = false}) async {
        calls.add(forceRefresh);
        return const PasswordCredentials('pw');
      });
      await expectLater(transport.connect(), throwsA(isA<MailException>()));
      expect(calls, [false]);
    });
  });

  group('SMTP XOAUTH2', () {
    late _SmtpServer server;
    final message = Uint8List.fromList(utf8.encode('Subject: Hi\r\n\r\nHello\r\n'));

    setUp(() async => server = await _SmtpServer.start());
    tearDown(() => server.close());

    test('a rejected token gets exactly one forced refresh', () async {
      server.accepted = {'fresh'};
      final tokens = _Tokens();
      final sender = ImapSmtpSender(_account(smtpPort: server.port), tokens.call);
      await sender.send(message, envelopeFrom: 'me@gmail.com', recipients: ['you@example.com']);
      expect(tokens.calls, [false, true]);
      expect(server.tokens, ['stale', 'fresh']);
      expect(server.messages, 1);
    });

    test('a token still refused after the refresh fails without another try', () async {
      final tokens = _Tokens();
      final sender = ImapSmtpSender(_account(smtpPort: server.port), tokens.call);
      await expectLater(
        sender.send(message, envelopeFrom: 'me@gmail.com', recipients: ['you@example.com']),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.authentication)),
      );
      expect(tokens.calls, [false, true]);
      expect(server.tokens, hasLength(2));
      expect(server.messages, 0);
    });
  });
}
