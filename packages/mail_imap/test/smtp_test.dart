import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mail_imap/mail_imap.dart';
import 'package:mail_imap/src/smtp/smtp_client.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

MailAccount _account(int port) => MailAccount(
  id: 'acc',
  email: 'me@example.com',
  displayName: 'Work',
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: const ServerConfig(protocol: ServerProtocol.imap, host: '127.0.0.1', port: 1),
  outgoing: ServerConfig(
    protocol: ServerProtocol.smtp,
    host: '127.0.0.1',
    port: port,
    security: ConnectionSecurity.none,
  ),
);

const _password = 'hunter2-correct-horse';

Future<Credentials> _passwordCredentials({bool forceRefresh = false}) async => const PasswordCredentials(_password);

/// A loopback SMTP server answering each command as configured.
final class _SmtpServer {
  _SmtpServer._(this._socket) {
    _socket.listen(_session);
  }

  static Future<_SmtpServer> start() async => _SmtpServer._(await ServerSocket.bind(InternetAddress.loopbackIPv4, 0));

  final ServerSocket _socket;
  int get port => _socket.port;

  String greeting = '220 smtp.test ready';
  String Function(String command) auth = (_) => '235 2.7.0 Accepted';
  String mailFrom = '250 2.1.0 Ok';

  /// RCPT TO replies by address; others get 250.
  final rcpt = <String, String>{};
  String data = '354 Go ahead';
  String endOfData = '250 2.0.0 Ok: queued';

  /// Closes the connection instead of answering MAIL FROM.
  bool dropAtMailFrom = false;

  final commands = <String>[];

  /// The accepted recipients of every message taken.
  final delivered = <List<String>>[];

  void _session(Socket client) {
    var inData = false;
    var accepted = <String>[];
    client.write('$greeting\r\n');
    client.cast<List<int>>().transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
      if (inData) {
        if (line == '.') {
          inData = false;
          final reply = endOfData;
          if (reply.startsWith('250')) delivered.add(accepted);
          client.write('$reply\r\n');
        }
        return;
      }
      commands.add(line);
      final verb = line.split(' ').first.toUpperCase();
      switch (verb) {
        case 'EHLO':
          client.write('250-smtp.test\r\n250-AUTH PLAIN\r\n250 8BITMIME\r\n');
        case 'AUTH':
          client.write('${auth(line)}\r\n');
        case 'MAIL':
          if (dropAtMailFrom) {
            client.destroy();
            return;
          }
          accepted = [];
          client.write('$mailFrom\r\n');
        case 'RCPT':
          final address = RegExp('<([^>]*)>').firstMatch(line)!.group(1)!;
          final reply = rcpt[address] ?? '250 2.1.5 Ok';
          if (reply.startsWith('25')) accepted.add(address);
          client.write('$reply\r\n');
        case 'DATA':
          if (data.startsWith('354')) inData = true;
          client.write('$data\r\n');
        case 'QUIT':
          client.write('221 Bye\r\n');
          unawaited(client.close());
        default:
          client.write('250 Ok\r\n');
      }
    }, onError: (Object _) {});
  }

  Future<void> close() => _socket.close();
}

final _message = Uint8List.fromList(utf8.encode('Subject: Hi\r\n\r\nHello\r\n'));

void main() {
  group('reply classification', () {
    // RFC 5321 4.2.1: 5yz is a permanent negative completion, 4yz transient.
    const table = <(int, String, bool, MailErrorKind)>[
      (421, '4.3.2 Service not available, closing channel', false, MailErrorKind.server),
      (450, '4.2.1 Mailbox unavailable (greylisted)', false, MailErrorKind.server),
      (451, '4.3.0 Local error in processing', false, MailErrorKind.server),
      (452, '4.5.3 Too many recipients', false, MailErrorKind.server),
      (454, '4.7.0 Temporary authentication failure', false, MailErrorKind.authentication),
      (500, '5.5.1 Command unrecognized', true, MailErrorKind.server),
      (501, '5.5.4 Syntax error in parameters', true, MailErrorKind.server),
      (503, '5.5.1 Bad sequence of commands', true, MailErrorKind.server),
      (530, '5.7.0 Authentication required', true, MailErrorKind.authentication),
      (534, '5.7.9 Application-specific password required', true, MailErrorKind.authentication),
      (535, '5.7.8 Username and Password not accepted', true, MailErrorKind.authentication),
      (538, '5.7.11 Encryption required', true, MailErrorKind.authentication),
      (550, '5.1.1 Mailbox unavailable', true, MailErrorKind.server),
      (551, '5.1.6 User not local', true, MailErrorKind.server),
      (552, '5.3.4 Message size exceeds fixed limit', true, MailErrorKind.server),
      (553, '5.7.1 Sender address rejected: not owned by user', true, MailErrorKind.server),
      (554, '5.7.1 Message rejected as spam', true, MailErrorKind.server),
      (556, '5.1.10 Domain does not accept mail', true, MailErrorKind.server),
      // An unreadable reply says nothing about the message.
      (0, 'garbage', false, MailErrorKind.server),
    ];
    for (final (code, text, permanent, kind) in table) {
      test('$code $text: ${permanent ? 'permanent' : 'temporary'}', () {
        expect(isPermanentSmtpReply(code), permanent);
        final e = smtpFailure(code, text);
        expect(e, permanent ? isA<PermanentMailException>() : isNot(isA<PermanentMailException>()));
        expect(e.kind, kind);
        expect(e.message, text);
      });
    }
  });

  group('sending', () {
    late _SmtpServer server;
    late ImapSmtpSender sender;

    setUp(() async {
      server = await _SmtpServer.start();
      sender = ImapSmtpSender(_account(server.port), _passwordCredentials);
    });
    tearDown(() => server.close());

    Future<SendReceipt> send([List<String> to = const ['a@example.org', 'b@example.org']]) =>
        sender.send(_message, envelopeFrom: 'me@example.com', recipients: to);

    Matcher fails({required bool permanent, MailErrorKind? kind, String? saying}) => throwsA(
      allOf([
        isA<MailException>(),
        permanent ? isA<PermanentMailException>() : isNot(isA<PermanentMailException>()),
        if (kind != null) isA<MailException>().having((e) => e.kind, 'kind', kind),
        if (saying != null) isA<MailException>().having((e) => e.message, 'message', contains(saying)),
      ]),
    );

    // Where the server says no, and what that means for the Outbox.
    final stages = <(String, void Function(_SmtpServer), bool, MailErrorKind, String)>[
      ('greeting 554', (s) => s.greeting = '554 5.7.1 No SMTP service here', true, MailErrorKind.server, 'No SMTP'),
      ('greeting 421', (s) => s.greeting = '421 4.3.2 Too busy', false, MailErrorKind.server, 'Too busy'),
      (
        'AUTH 535',
        (s) => s.auth = (_) => '535 5.7.8 Authentication credentials invalid',
        true,
        MailErrorKind.authentication,
        'credentials invalid',
      ),
      (
        'AUTH 454',
        (s) => s.auth = (_) => '454 4.7.0 Temporary authentication failure',
        false,
        MailErrorKind.authentication,
        'Temporary',
      ),
      (
        'MAIL FROM 553',
        (s) => s.mailFrom = '553 5.7.1 Sender address rejected: not owned by user',
        true,
        MailErrorKind.server,
        'Sender me@example.com rejected',
      ),
      ('MAIL FROM 451', (s) => s.mailFrom = '451 4.3.0 Try again later', false, MailErrorKind.server, 'later'),
      (
        'every RCPT 550',
        (s) => s.rcpt.addAll({
          'a@example.org': '550 5.1.1 <a@example.org>: Recipient address rejected: User unknown',
          'b@example.org': '550 5.1.1 <b@example.org>: Recipient address rejected: User unknown',
        }),
        true,
        MailErrorKind.server,
        'Recipient b@example.org rejected',
      ),
      (
        'every RCPT refused, one only for now',
        (s) => s.rcpt.addAll({
          'a@example.org': '550 5.1.1 User unknown',
          'b@example.org': '450 4.2.1 Greylisted, try again',
        }),
        false,
        MailErrorKind.server,
        'Greylisted',
      ),
      (
        'RCPT 421',
        (s) => s.rcpt['a@example.org'] = '421 4.4.2 Closing connection',
        false,
        MailErrorKind.server,
        'Closing',
      ),
      ('DATA 554', (s) => s.data = '554 5.5.1 No valid recipients', true, MailErrorKind.server, 'No valid'),
      (
        'end of data 554',
        (s) => s.endOfData = '554 5.7.1 Message rejected as spam',
        true,
        MailErrorKind.server,
        'Message rejected by 127.0.0.1: 5.7.1 Message rejected as spam',
      ),
      (
        'end of data 451',
        (s) => s.endOfData = '451 4.7.1 Please try again later',
        false,
        MailErrorKind.server,
        'try again',
      ),
      ('connection lost', (s) => s.dropAtMailFrom = true, false, MailErrorKind.connection, 'Lost the connection'),
    ];
    for (final (stage, setUpServer, permanent, kind, saying) in stages) {
      test('$stage: ${permanent ? 'permanent' : 'temporary'}', () async {
        setUpServer(server);
        await expectLater(send(), fails(permanent: permanent, kind: kind, saying: saying));
        expect(server.delivered, isEmpty);
      });
    }

    test('a 421 to a recipient stops at once', () async {
      server.rcpt['a@example.org'] = '421 4.4.2 Closing connection';
      await expectLater(send(), fails(permanent: false));
      expect(server.commands.where((c) => c.startsWith('RCPT')), hasLength(1));
      expect(server.commands.where((c) => c == 'DATA'), isEmpty);
    });

    test('refused recipients are reported; the others get the message', () async {
      server.rcpt
        ..['b@example.org'] = '550 5.1.1 <b@example.org>: Recipient address rejected: User unknown'
        ..['c@example.org'] = '452 4.5.3 Too many recipients';
      final receipt = await send(['a@example.org', 'b@example.org', 'c@example.org']);
      expect(server.delivered, [
        ['a@example.org'],
      ]);
      expect(receipt.refused.keys, ['b@example.org', 'c@example.org']);
      expect(receipt.refused['b@example.org'], isA<PermanentMailException>());
      expect(receipt.refused['b@example.org']!.message, contains('User unknown'));
      expect(receipt.refused['c@example.org'], isNot(isA<PermanentMailException>()));
    });

    test('a message every recipient takes has an empty receipt', () async {
      expect((await send()).refused, isEmpty);
      expect(server.delivered, [
        ['a@example.org', 'b@example.org'],
      ]);
    });

    test('a message over the SIZE limit is refused for good without sending it', () async {
      final big = await _SmtpServer.start();
      addTearDown(big.close);
      final session = await SmtpConnection.open(_account(big.port).outgoing!);
      session.extensions.add('SIZE 10');
      await expectLater(
        session.sendMail('me@example.com', ['a@example.org'], _message),
        fails(permanent: true, saying: 'too large'),
      );
      await session.quit();
      expect(big.commands.where((c) => c.startsWith('MAIL')), isEmpty);
    });

    test('no recipients, no SMTP server: refused for good', () async {
      await expectLater(send(const [' ']), fails(permanent: true));
      final noSmtp = ImapSmtpSender(
        MailAccount(
          id: 'x',
          email: 'me@example.com',
          displayName: 'x',
          provider: ProviderKind.generic,
          authKind: AuthKind.password,
          incoming: const ServerConfig(protocol: ServerProtocol.imap, host: 'h', port: 1),
        ),
        _passwordCredentials,
      );
      await expectLater(
        noSmtp.send(_message, envelopeFrom: 'me@example.com', recipients: ['a@example.org']),
        fails(permanent: true, kind: MailErrorKind.unsupported),
      );
    });

    test('a server quoting the login keeps the credentials out of the error', () async {
      // Some servers quote the command they refuse, AUTH payload included.
      server.auth = (command) => '501 5.5.2 Cannot decode: $command password=$_password';
      Object? error;
      try {
        await send();
      } on Object catch (e) {
        error = e;
      }
      final message = (error! as PermanentMailException).message;
      final payload = base64.encode(utf8.encode('\u0000me@example.com\u0000$_password'));
      expect(message, contains('Cannot decode'));
      expect(message, isNot(contains(_password)));
      expect(message, isNot(contains(payload)));
    });
  });

  group('sanitizeSmtpText', () {
    test('one line, no control characters, capped', () {
      expect(sanitizeSmtpText('5.1.1 User\r\nunknown\t\u0007here'), '5.1.1 User unknown here');
      final long = sanitizeSmtpText('x ' * 400);
      expect(long.length, 300);
      expect(long, endsWith('…'));
    });

    test('hides secrets and opaque tokens, keeps help links and queue ids', () {
      const gmail =
          '5.1.1 The email account that you tried to reach does not exist. '
          'https://support.google.com/mail/?p=NoSuchUser 6a1803df08f44-6d17f8ab5adsi1234567 - gsmtp';
      expect(sanitizeSmtpText(gmail), gmail);
      const microsoft =
          '5.7.139 Authentication unsuccessful, SmtpClientAuthentication is disabled for the Tenant. '
          'Visit https://aka.ms/smtp_auth_disabled for more information.';
      expect(sanitizeSmtpText(microsoft), microsoft);
      expect(
        sanitizeSmtpText('bad token ya29.a0AfH6SMBx3kQ7Lm2Rz9VtPq8WcYdEhJ4uNo5Ki1Fg', secrets: const []),
        'bad token [hidden]',
      );
      expect(sanitizeSmtpText('rejected for s3cret-pass', secrets: const ['s3cret-pass']), 'rejected for [hidden]');
    });
  });
}
