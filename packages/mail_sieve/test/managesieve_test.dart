import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';
import 'package:test/test.dart';

import 'support/scripted_sieve_server.dart';

Future<ManageSieveClient> _login(ScriptedSieveServer server, {Credentials? credentials}) async {
  final client = await ManageSieveClient.open(server.connect(), host: 'mail.example.org');
  await client.login(
    'me@example.org',
    ({bool forceRefresh = false}) async => credentials ?? const PasswordCredentials('secret'),
  );
  return client;
}

void main() {
  test('STARTTLS, then login, then every command, with literals', () async {
    final server = ScriptedSieveServer()
      ..scripts['sogo'] = 'require "fileinto";\r\n# "quoted" and {braces}\r\nkeep;\r\n'
      ..active = 'sogo';
    final client = await _login(server);
    expect(server.startTlsCalls, 1);
    expect(client.isSecure, isTrue);
    expect(client.capabilities.implementation, 'Dovecot Pigeonhole');
    expect(client.capabilities.extensions, containsAll(['fileinto', 'imap4flags', 'body', 'regex', 'include', 'mime']));
    expect(client.capabilities.sasl, {'PLAIN', 'LOGIN', 'XOAUTH2'});

    expect(await client.listScripts(), [const SieveScriptInfo('sogo', active: true)]);
    expect(await client.getScript('sogo'), server.scripts['sogo']);
    const script = 'require "imap4flags";\nif header :contains "subject" "€uro" {\n  addflag "\\\\Seen";\n}\n';
    expect(await client.checkScript(script), isNull);
    expect(await client.haveSpace('loupe', utf8.encode(script).length), isTrue);
    await client.putScript('loupe', script);
    expect(server.scripts['loupe'], script);
    await client.setActive('loupe');
    expect(server.active, 'loupe');
    await client.deleteScript('sogo');
    await client.logout();

    expect(
      [for (final c in server.commands) c.first],
      [
        'STARTTLS',
        'AUTHENTICATE',
        'CAPABILITY',
        'LISTSCRIPTS',
        'GETSCRIPT',
        'CHECKSCRIPT',
        'HAVESPACE',
        'PUTSCRIPT',
        'SETACTIVE',
        'DELETESCRIPT',
        'LOGOUT',
      ],
    );
    // Nothing but STARTTLS before the connection is encrypted.
    expect(server.secure, [false, true, true, true, true, true, true, true, true, true, true]);
    final login = server.commands[1];
    expect(login[1], 'PLAIN');
    expect(utf8.decode(base64.decode(login[2])), '\u0000me@example.org\u0000secret');
    // Scripts go as non-synchronising literals, names as quoted strings.
    final bytes = utf8.encode(script).length;
    expect(server.received.toString(), contains('PUTSCRIPT "loupe" {$bytes+}\r\n$script\r\n'));
    expect(server.received.toString(), contains('HAVESPACE "loupe" $bytes\r\n'));
  });

  test('a name with quotes and backslashes is escaped; long or multi-line strings become literals', () async {
    final server = ScriptedSieveServer();
    final client = await _login(server);
    server.scripts['a "b" \\ c'] = 'keep;';
    expect(await client.getScript('a "b" \\ c'), 'keep;');
    expect(server.received.toString(), contains(r'GETSCRIPT "a \"b\" \\ c"'));
    final long = 'x' * 1100;
    await expectLater(client.getScript(long), throwsA(isA<SieveException>()));
    expect(server.received.toString(), contains('GETSCRIPT {1100+}\r\n$long\r\n'));
    await client.logout();
  });

  test('a server without STARTTLS is refused unless plain text was chosen', () async {
    await expectLater(
      ManageSieveClient.open(ScriptedSieveServer(offerStartTls: false).connect(), host: 'mail.example.org'),
      throwsA(
        isA<MailException>()
            .having((e) => e.kind, 'kind', MailErrorKind.unsupported)
            .having((e) => e.message, 'message', contains('STARTTLS')),
      ),
    );
    final server = ScriptedSieveServer(offerStartTls: false);
    final client = await ManageSieveClient.open(server.connect(), host: 'h', requireTls: false);
    expect(client.isSecure, isFalse);
    expect(server.startTlsCalls, 0);
    await client.logout();
  });

  test('asks for the capabilities when the server doesn’t send them after STARTTLS', () async {
    final server = ScriptedSieveServer(capabilitiesAfterTls: false);
    final client = await ManageSieveClient.open(
      server.connect(),
      host: 'h',
      capabilityWait: const Duration(milliseconds: 20),
    );
    expect(client.capabilities.sasl, contains('PLAIN'));
    expect([for (final c in server.commands) c.first], ['STARTTLS', 'CAPABILITY']);
    await client.logout();
  });

  test('a wrong password is an authentication error with the server’s words', () async {
    final server = ScriptedSieveServer(password: 'other');
    await expectLater(
      _login(server),
      throwsA(
        isA<SieveException>()
            .having((e) => e.kind, 'kind', MailErrorKind.authentication)
            .having((e) => e.message, 'message', 'Authentication failed.'),
      ),
    );
  });

  test('LOGIN when the server has no PLAIN', () async {
    final server = ScriptedSieveServer();
    final client = await ManageSieveClient.open(server.connect(), host: 'h');
    // Pretend the server offered only LOGIN.
    server.replies['CAPABILITY'] = (_) => ['"SASL" "LOGIN"', 'OK'];
    await client.capability();
    server.replies.remove('CAPABILITY');
    await client.login('me@example.org', ({bool forceRefresh = false}) async => const PasswordCredentials('secret'));
    expect(server.commands.where((c) => c.first == 'AUTHENTICATE').single, ['AUTHENTICATE', 'LOGIN']);
    await client.logout();
  });

  test('XOAUTH2: a rejected token is refreshed once, answering the error challenge', () async {
    final server = ScriptedSieveServer()..validTokens.add('fresh');
    final refreshed = <bool>[];
    final client = await ManageSieveClient.open(server.connect(), host: 'h');
    await client.login('me@example.org', ({bool forceRefresh = false}) async {
      refreshed.add(forceRefresh);
      return OAuthCredentials(
        accessToken: forceRefresh ? 'fresh' : 'stale',
        refreshToken: 'r',
        expiresAt: DateTime(2030),
      );
    });
    expect(refreshed, [false, true]);
    final logins = server.commands.where((c) => c.first == 'AUTHENTICATE').toList();
    expect(logins, hasLength(2));
    expect(logins.first[1], 'XOAUTH2');
    expect(utf8.decode(base64.decode(logins.last[2])), 'user=me@example.org\u0001auth=Bearer fresh\u0001\u0001');
    // The empty answer to the error challenge.
    expect(server.received.toString(), contains('\r\n""\r\n'));
    await client.logout();
  });

  test('CHECKSCRIPT errors come back as the server wrote them (a literal)', () async {
    final server = ScriptedSieveServer();
    final client = await _login(server);
    await expectLater(
      client.checkScript('keep;\nERROR;\n'),
      throwsA(
        isA<SieveException>().having(
          (e) => e.message,
          'message',
          "line 2: error: unknown command 'ERROR'.\nerror: validation failed.",
        ),
      ),
    );
    // The connection is still usable.
    expect(await client.listScripts(), isEmpty);
    server.replies['CHECKSCRIPT'] = (_) => ['OK (WARNINGS) "line 3: warning: deprecated."'];
    expect(await client.checkScript('keep;'), 'line 3: warning: deprecated.');
    await client.logout();
  });

  test('HAVESPACE over quota is false; other NOs carry their code', () async {
    final server = ScriptedSieveServer()..quota = 10;
    final client = await _login(server);
    expect(await client.haveSpace('loupe', 11), isFalse);
    await expectLater(
      client.getScript('missing'),
      throwsA(isA<SieveException>().having((e) => e.code, 'code', 'NONEXISTENT')),
    );
    await client.logout();
  });

  test('BYE in the greeting is a connection error', () async {
    await expectLater(
      ManageSieveClient.open(ScriptedSieveServer(greeting: 'BYE "Too many connections."').connect(), host: 'h'),
      throwsA(
        isA<MailException>()
            .having((e) => e.kind, 'kind', MailErrorKind.connection)
            .having((e) => e.message, 'message', 'Too many connections.'),
      ),
    );
  });

  test('a server that stops answering times out as a connection error', () async {
    final server = ScriptedSieveServer();
    final client = await ManageSieveClient.open(server.connect(), host: 'h', timeout: const Duration(milliseconds: 50));
    server.replies['LISTSCRIPTS'] = (_) => const [];
    await expectLater(
      client.listScripts(),
      throwsA(isA<MailException>().having((e) => e.message, 'message', 'h stopped responding.')),
    );
  });

  group('over a socket', () {
    test('SocketSieveChannel speaks to a plain-text server on loopback', () async {
      final socket = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(socket.close);
      socket.listen((c) {
        c.write('"IMPLEMENTATION" "Test"\r\n"SIEVE" "fileinto"\r\nOK "Ready."\r\n');
        c.cast<List<int>>().transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
          if (line == 'LISTSCRIPTS') c.write('"loupe" ACTIVE\r\nOK\r\n');
          if (line == 'LOGOUT') {
            c.write('OK\r\n');
            unawaited(c.close());
          }
        });
      });
      final channel = SocketSieveChannel(await Socket.connect('127.0.0.1', socket.port), host: '127.0.0.1');
      final client = await ManageSieveClient.open(channel, host: '127.0.0.1', requireTls: false);
      expect(client.capabilities.extensions, {'fileinto'});
      expect(await client.listScripts(), [const SieveScriptInfo('loupe', active: true)]);
      await client.logout();
    });

    MailAccount account(int port, {ProviderKind provider = ProviderKind.generic}) => MailAccount(
      id: 'a',
      email: 'me@example.org',
      displayName: 'Mailcow',
      provider: provider,
      authKind: AuthKind.password,
      incoming: ServerConfig(protocol: ServerProtocol.imap, host: '127.0.0.1', port: port),
    );

    test('the connector explains a closed ManageSieve port and providers without it', () async {
      final probe = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      final port = probe.port;
      await probe.close();
      Future<Credentials> creds({bool forceRefresh = false}) async => const PasswordCredentials('x');
      await expectLater(
        ManageSieveConnector(port: port, timeout: const Duration(seconds: 3)).connect(account(993), creds),
        throwsA(
          isA<MailException>()
              .having((e) => e.kind, 'kind', MailErrorKind.connection)
              .having((e) => e.message, 'message', contains('ManageSieve')),
        ),
      );
      await expectLater(
        const ManageSieveConnector().connect(account(993, provider: ProviderKind.gmail), creds),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.unsupported)),
      );
    });
  });
}
