/// A throwaway Stalwart mail server for Loupe's JMAP integration tests.
///
/// Uses only dart:io, so tests import it by path and it runs on its own:
///
/// ```sh
/// dart tool/test-servers/stalwart/stalwart.dart [--binary PATH] [--seed N]
/// ```
///
/// prints the environment for the integration tests and runs until Ctrl-C.
///
/// The setup follows Stalwart 0.16's unattended sequence (administration
/// is JMAP: `x:<Object>/get|set` with `urn:stalwart:jmap`):
/// 1. bootstrap mode (no config.json) and `x:Bootstrap/set`, which writes the
///    configuration and returns the admin login;
/// 2. recovery mode: no outside fetching (ASN and geo data, spam rules, the
///    web admin), and the listeners, on 127.0.0.1 and free ports only, so
///    Stalwart never creates its defaults (25, 443, 993…);
/// 3. normal mode, where the admin creates the two test users.
///
/// Everything lives in a temporary directory that [StalwartServer.stop]
/// deletes. The process runs under a small shell that stops it when this
/// process's end of its stdin closes, so a crashed test leaves no server
/// behind.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

/// The domain and host name the test server is set up with. Its session
/// resource names `https://mail.example.test/…` URLs, which clients must
/// map to [StalwartServer.httpUrl] (see [StalwartServer.rewrite]).
const stalwartDomain = 'example.test';
const stalwartHostname = 'mail.example.test';

/// The default binary location on the development machine.
String get defaultStalwartBinary => '${Platform.environment['HOME']}/development/roost-deps/stalwart';

/// A test user.
final class StalwartUser {
  const StalwartUser(this.email, this.password);
  final String email;
  final String password;
}

final class StalwartServer {
  StalwartServer._(this.dir, this._process, this.ports, this.admin, this.users);

  /// Where data, configuration and logs live.
  final Directory dir;
  final Process _process;

  /// `http`, `imap`, `smtp`, `submission`, `sieve` → port on 127.0.0.1.
  final Map<String, int> ports;
  final StalwartUser admin;

  /// alice@example.test and bob@example.test.
  final List<StalwartUser> users;

  int get httpPort => ports['http']!;
  Uri get httpUrl => Uri.parse('http://127.0.0.1:$httpPort');

  /// [uri] with the server's public origin (`https://mail.example.test`)
  /// replaced by [httpUrl]; other URLs unchanged.
  Uri rewrite(Uri uri) =>
      uri.host == stalwartHostname ? uri.replace(scheme: 'http', host: '127.0.0.1', port: httpPort) : uri;

  /// Environment variables describing this server for the tests.
  Map<String, String> get environment => {
    'LOUPE_TEST_STALWART_URL': httpUrl.toString(),
    'LOUPE_TEST_STALWART_IMAP_PORT': '${ports['imap']}',
    'LOUPE_TEST_STALWART_SMTP_PORT': '${ports['smtp']}',
    'LOUPE_TEST_STALWART_SIEVE_PORT': '${ports['sieve']}',
    'LOUPE_TEST_STALWART_USER': users[0].email,
    'LOUPE_TEST_STALWART_PASSWORD': users[0].password,
    'LOUPE_TEST_STALWART_USER2': users[1].email,
    'LOUPE_TEST_STALWART_PASSWORD2': users[1].password,
    'LOUPE_TEST_STALWART_ADMIN': '${admin.email}:${admin.password}',
  };

  /// Starts a fresh server with [binary]. [log] gets progress lines.
  static Future<StalwartServer> start({String? binary, void Function(String)? log}) async {
    final bin = binary ?? defaultStalwartBinary;
    if (!File(bin).existsSync()) throw StateError('No Stalwart binary at $bin');
    final dir = await Directory.systemTemp.createTemp('loupe-stalwart-');
    await Directory('${dir.path}/logs').create();
    final config = '${dir.path}/config.json';
    final recovery = StalwartUser('loupe-recovery', _secret());
    final ports = {
      for (final name in const ['http', 'imap', 'smtp', 'submission', 'sieve']) name: await _freePort(),
    };
    Process? process;
    try {
      // 1. Bootstrap.
      var adminPort = await _freePort();
      process = await _launch(bin, config, dir, {
        'STALWART_RECOVERY_ADMIN': '${recovery.email}:${recovery.password}',
        'STALWART_RECOVERY_MODE_PORT': '$adminPort',
      });
      var base = Uri.parse('http://127.0.0.1:$adminPort');
      await _waitReady(base, process);
      log?.call('stalwart: bootstrapping in ${dir.path}');
      final boot = await _call(base, recovery, 'd333333', [
        [
          'x:Bootstrap/set',
          {
            'update': {
              'singleton': {
                'serverHostname': stalwartHostname,
                'defaultDomain': stalwartDomain,
                'requestTlsCertificate': false,
                'generateDkimKeys': false,
                'dataStore': {'@type': 'RocksDb', 'path': '${dir.path}/data'},
                'blobStore': {'@type': 'Default'},
                'searchStore': {'@type': 'Default'},
                'inMemoryStore': {'@type': 'Default'},
                'directory': {'@type': 'Internal'},
                'dnsServer': {'@type': 'Manual'},
                'tracer': {'@type': 'Log', 'path': '${dir.path}/logs', 'ansi': false},
              },
            },
          },
          'boot',
        ],
      ]);
      final creds = (_args(boot, 'boot')['updated'] as Map)['singleton'] as Map;
      final admin = StalwartUser(creds['username'] as String, creds['secret'] as String);
      await _stop(process);

      // 2. Recovery mode: offline, and our listeners only.
      adminPort = await _freePort();
      process = await _launch(bin, config, dir, {
        'STALWART_RECOVERY_ADMIN': '${recovery.email}:${recovery.password}',
        'STALWART_RECOVERY_MODE_PORT': '$adminPort',
        'STALWART_RECOVERY_MODE': '1',
      });
      base = Uri.parse('http://127.0.0.1:$adminPort');
      await _waitReady(base, process);
      log?.call('stalwart: configuring listeners');
      final apps = await _call(base, recovery, 'd333333', [
        [
          'x:Asn/set',
          {
            'update': {
              'singleton': {'@type': 'Disabled'},
            },
          },
          'asn',
        ],
        [
          'x:SpamSettings/set',
          {
            'update': {
              'singleton': {'spamFilterRulesUrl': null},
            },
          },
          'spam',
        ],
        [
          'x:Application/get',
          {
            'properties': ['id'],
          },
          'apps',
        ],
        // Plain-text logins on the plain listeners (IMAP cross-checks, SMTP
        // submission); the SMTP listener takes local mail without a login.
        [
          'x:Imap/set',
          {
            'update': {
              'singleton': {'allowPlainTextAuth': true},
            },
          },
          'imap',
        ],
        [
          'x:MtaStageAuth/set',
          {
            'update': {
              'singleton': {
                'require': {
                  'match': {
                    '0': {'if': "listener == 'submission'", 'then': 'true'},
                  },
                  'else': 'false',
                },
                'saslMechanisms': {'match': {}, 'else': '[plain, login]'},
              },
            },
          },
          'smtp',
        ],
      ]);
      final appIds = [for (final a in _args(apps, 'apps')['list'] as List) (a as Map)['id'] as String];
      await _call(base, recovery, 'd333333', [
        [
          'x:Application/set',
          {
            'update': {
              for (final id in appIds) id: {'enabled': false},
            },
          },
          'apps',
        ],
        [
          'x:NetworkListener/set',
          {
            'create': {
              for (final (name, protocol) in const [
                ('http', 'http'),
                ('imap', 'imap'),
                ('smtp', 'smtp'),
                ('submission', 'smtp'),
                ('sieve', 'manageSieve'),
              ])
                name: {
                  'name': name,
                  'protocol': protocol,
                  'bind': {'127.0.0.1:${ports[name]}': true},
                  'tlsImplicit': false,
                },
            },
          },
          'listeners',
        ],
      ]);
      await _stop(process);

      // 3. Normal mode and the users.
      process = await _launch(bin, config, dir, const {});
      final server = StalwartServer._(dir, process, ports, admin, const [
        StalwartUser('alice@$stalwartDomain', ''),
        StalwartUser('bob@$stalwartDomain', ''),
      ]);
      await _waitReady(server.httpUrl, process);
      final settings = await _call(server.httpUrl, admin, null, [
        [
          'x:SystemSettings/get',
          {
            'ids': ['singleton'],
            'properties': ['defaultDomainId'],
          },
          'settings',
        ],
      ]);
      final domainId = ((_args(settings, 'settings')['list'] as List).first as Map)['defaultDomainId'] as String;
      final users = [
        for (final name in const ['alice', 'bob']) StalwartUser('$name@$stalwartDomain', _secret()),
      ];
      final created = await _call(server.httpUrl, admin, null, [
        [
          'x:Account/set',
          {
            'create': {
              for (final u in users)
                u.email.split('@').first: {
                  '@type': 'User',
                  'name': u.email.split('@').first,
                  'domainId': domainId,
                  'credentials': {
                    '0': {'@type': 'Password', 'secret': u.password},
                  },
                },
            },
          },
          'users',
        ],
      ]);
      final notCreated = _args(created, 'users')['notCreated'];
      if (notCreated is Map && notCreated.isNotEmpty) throw StateError('Stalwart refused the users: $notCreated');
      log?.call('stalwart: ready at ${server.httpUrl} (${dir.path})');
      return StalwartServer._(dir, process, ports, admin, users);
    } catch (_) {
      if (process != null) await _stop(process);
      if (Platform.environment['LOUPE_TEST_STALWART_KEEP'] == null) await dir.delete(recursive: true);
      rethrow;
    }
  }

  /// Stops the server and deletes its directory (kept when
  /// `LOUPE_TEST_STALWART_KEEP` is set, for reading the logs).
  Future<void> stop() async {
    await _stop(_process);
    if (Platform.environment['LOUPE_TEST_STALWART_KEEP'] == null && dir.existsSync()) {
      await dir.delete(recursive: true);
    }
  }

  /// The tail of the server's log files, for failing tests.
  String logTail([int bytes = 8192]) {
    final buffer = StringBuffer();
    for (final f in [File('${dir.path}/stalwart.out'), ...Directory('${dir.path}/logs').listSync().whereType<File>()]) {
      if (!f.existsSync()) continue;
      final text = f.readAsStringSync();
      buffer.writeln('== ${f.path}\n${text.length > bytes ? text.substring(text.length - bytes) : text}');
    }
    return buffer.toString();
  }

  /// JMAP method calls as [user] against their mail account; returns the
  /// method responses.
  Future<List<Object?>> jmap(StalwartUser user, List<List<Object?>> calls) =>
      _call(httpUrl, user, null, calls, using: const ['urn:ietf:params:jmap:core', 'urn:ietf:params:jmap:mail']);

  /// [user]'s JMAP mail account id.
  Future<String> accountId(StalwartUser user) async {
    final session = await _getJson(httpUrl.replace(path: '/jmap/session'), user);
    return ((session['primaryAccounts'] as Map)['urn:ietf:params:jmap:mail']) as String;
  }

  /// Puts [messages] (RFC 822) in [user]'s mailbox with [role] (`inbox`
  /// by default) through JMAP `Email/import`, with [keywords]. Returns the
  /// new emails' ids.
  Future<List<String>> importMessages(
    StalwartUser user,
    List<List<int>> messages, {
    String role = 'inbox',
    Set<String> keywords = const {},
    List<DateTime>? receivedAt,
  }) async {
    final account = await accountId(user);
    final boxes = _args(
      await jmap(user, [
        [
          'Mailbox/get',
          {
            'accountId': account,
            'properties': ['role'],
          },
          'b',
        ],
      ]),
      'b',
    );
    final box = [for (final m in boxes['list'] as List) m as Map].firstWhere((m) => m['role'] == role)['id'] as String;
    final ids = <String>[];
    for (final (i, m) in messages.indexed) {
      final upload = await _send(
        'POST',
        httpUrl.replace(path: '/jmap/upload/$account/'),
        user,
        body: m,
        type: 'message/rfc822',
      );
      final blob = (jsonDecode(upload) as Map)['blobId'] as String;
      final r = await jmap(user, [
        [
          'Email/import',
          {
            'accountId': account,
            'emails': {
              'm': {
                'blobId': blob,
                'mailboxIds': {box: true},
                'keywords': {for (final k in keywords) k: true},
                if (receivedAt != null) 'receivedAt': '${receivedAt[i].toUtc().toIso8601String().split('.').first}Z',
              },
            },
          },
          'i',
        ],
      ]);
      final created = _args(r, 'i')['created'] as Map?;
      if (created == null || created['m'] == null) throw StateError('Import failed: $r');
      ids.add((created['m'] as Map)['id'] as String);
    }
    return ids;
  }

  /// Delivers [rfc822] from [from] to [to] through the SMTP listener (no
  /// authentication: local recipients only).
  Future<void> deliverSmtp(String from, List<String> to, List<int> rfc822) async {
    final socket = await Socket.connect('127.0.0.1', ports['smtp']!);
    final lines = socket.cast<List<int>>().transform(utf8.decoder).transform(const LineSplitter());
    final replies = StreamIterator(lines);
    Future<String> reply() async {
      while (await replies.moveNext()) {
        final line = replies.current;
        if (line.length >= 4 && line[3] == '-') continue;
        return line;
      }
      throw StateError('SMTP connection closed');
    }

    Future<void> expect(String code) async {
      final line = await reply();
      if (!line.startsWith(code)) throw StateError('SMTP: expected $code, got $line');
    }

    try {
      await expect('220');
      socket.write('EHLO loupe.test\r\n');
      await expect('250');
      socket.write('MAIL FROM:<$from>\r\n');
      await expect('250');
      for (final r in to) {
        socket.write('RCPT TO:<$r>\r\n');
        await expect('250');
      }
      socket.write('DATA\r\n');
      await expect('354');
      final text = latin1.decode(rfc822).replaceAll(RegExp(r'\r?\n'), '\r\n');
      socket.write(text.split('\r\n').map((l) => l.startsWith('.') ? '.$l' : l).join('\r\n'));
      socket.write('${text.endsWith('\r\n') ? '' : '\r\n'}.\r\n');
      await expect('250');
      socket.write('QUIT\r\n');
    } finally {
      await replies.cancel();
      socket.destroy();
    }
  }

  // Process --------------------------------------------------------------------

  /// Runs Stalwart under a shell that stops it (SIGTERM, then waits) when
  /// stdin closes: on [_stop], or when this process dies.
  static Future<Process> _launch(String bin, String config, Directory dir, Map<String, String> env) async {
    final environment = {
      for (final MapEntry(:key, :value) in Platform.environment.entries)
        if (!key.startsWith('STALWART_')) key: value,
      ...env,
    };
    final process = await Process.start(
      '/bin/sh',
      [
        '-c',
        r'"$0" --config "$1" >>"$2" 2>&1 </dev/null & pid=$!; echo $pid; cat >/dev/null; kill $pid 2>/dev/null; wait $pid',
        bin,
        config,
        '${dir.path}/stalwart.out',
      ],
      environment: environment,
      includeParentEnvironment: false,
    );
    unawaited(process.stdout.drain<void>());
    unawaited(process.stderr.drain<void>());
    return process;
  }

  static Future<void> _stop(Process process) async {
    await process.stdin.close().catchError((Object _) {});
    final code = await process.exitCode.timeout(const Duration(seconds: 20), onTimeout: () => -1);
    if (code == -1) process.kill(ProcessSignal.sigkill);
  }

  static Future<void> _waitReady(Uri base, Process process) async {
    final client = HttpClient()..connectionTimeout = const Duration(seconds: 2);
    var exited = false;
    unawaited(process.exitCode.then((_) => exited = true));
    try {
      for (var i = 0; i < 300; i++) {
        if (exited) throw StateError('Stalwart exited during startup');
        try {
          final request = await client.getUrl(base.replace(path: '/jmap/session'));
          final response = await request.close();
          await response.drain<void>();
          return;
        } on IOException {
          await Future<void>.delayed(const Duration(milliseconds: 100));
        }
      }
      throw StateError('Stalwart did not start at $base');
    } finally {
      client.close(force: true);
    }
  }

  static Future<int> _freePort() async {
    final socket = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    final port = socket.port;
    await socket.close();
    return port;
  }

  static String _secret() {
    final r = Random.secure();
    const chars = 'abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    return List.generate(24, (_) => chars[r.nextInt(chars.length)]).join();
  }

  // JMAP plumbing ------------------------------------------------------------------

  static Future<List<Object?>> _call(
    Uri base,
    StalwartUser user,
    String? accountId,
    List<List<Object?>> calls, {
    List<String> using = const ['urn:ietf:params:jmap:core', 'urn:stalwart:jmap'],
  }) async {
    final body = {
      'using': using,
      'methodCalls': [
        for (final c in calls)
          [
            c[0],
            {'accountId': ?accountId, ...c[1]! as Map},
            c[2],
          ],
      ],
    };
    final text = await _send('POST', base.replace(path: '/jmap/'), user, body: utf8.encode(jsonEncode(body)));
    final responses = (jsonDecode(text) as Map)['methodResponses'] as List;
    for (final r in responses) {
      if ((r as List).first == 'error') throw StateError('Stalwart: ${jsonEncode(r)}');
    }
    return responses;
  }

  static Map<String, Object?> _args(List<Object?> responses, String id) {
    for (final r in responses) {
      if ((r! as List)[2] == id) return ((r as List)[1] as Map).cast();
    }
    throw StateError('No response $id');
  }

  static Future<Map<String, Object?>> _getJson(Uri uri, StalwartUser user) async =>
      (jsonDecode(await _send('GET', uri, user)) as Map).cast();

  static Future<String> _send(
    String method,
    Uri uri,
    StalwartUser user, {
    List<int>? body,
    String type = 'application/json',
  }) async {
    final client = HttpClient();
    try {
      final request = await client.openUrl(method, uri);
      request.headers.set('Authorization', 'Basic ${base64.encode(utf8.encode('${user.email}:${user.password}'))}');
      if (body != null) {
        request.headers.contentType = ContentType.parse(type);
        request.add(body);
      }
      final response = await request.close();
      final text = await response.transform(utf8.decoder).join();
      if (response.statusCode >= 300) throw StateError('Stalwart: HTTP ${response.statusCode} for $uri: $text');
      return text;
    } finally {
      client.close();
    }
  }
}

Future<void> main(List<String> args) async {
  String? binary;
  var seed = 0;
  for (var i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--binary':
        binary = args[++i];
      case '--seed':
        seed = int.parse(args[++i]);
      default:
        stderr.writeln('Usage: dart tool/test-servers/stalwart/stalwart.dart [--binary PATH] [--seed N]');
        exit(64);
    }
  }
  final server = await StalwartServer.start(binary: binary, log: stderr.writeln);
  if (seed > 0) {
    await server.importMessages(server.users[0], [
      for (var n = 1; n <= seed; n++)
        utf8.encode(
          'From: Seeder <seed@example.org>\r\nTo: ${server.users[0].email}\r\nSubject: Sample message $n\r\n'
          'Message-ID: <seed-$n@example.org>\r\nDate: ${HttpDate.format(DateTime.now().subtract(Duration(hours: n)))}\r\n'
          'MIME-Version: 1.0\r\nContent-Type: text/plain; charset=utf-8\r\n\r\nSample body $n.\r\n',
        ),
    ]);
  }
  for (final MapEntry(:key, :value) in server.environment.entries) {
    stdout.writeln("export $key='$value'");
  }
  stderr.writeln('Running; Ctrl-C stops it and deletes ${server.dir.path}.');
  final done = Completer<void>();
  ProcessSignal.sigint.watch().listen((_) => done.isCompleted ? null : done.complete());
  ProcessSignal.sigterm.watch().listen((_) => done.isCompleted ? null : done.complete());
  await done.future;
  await server.stop();
  exit(0);
}
