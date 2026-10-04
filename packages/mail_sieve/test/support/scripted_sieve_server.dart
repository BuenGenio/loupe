import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_sieve/mail_sieve.dart';

/// A scripted ManageSieve server (in the manner of Dovecot Pigeonhole) on
/// in-memory channels: greets with its capabilities, does STARTTLS through
/// the channel seam, checks SASL PLAIN, LOGIN and XOAUTH2 logins, and keeps
/// scripts. It records every command in [commands].
final class ScriptedSieveServer {
  ScriptedSieveServer({
    this.offerStartTls = true,
    this.capabilitiesAfterTls = true,
    this.user = 'me@example.org',
    this.password = 'secret',
    this.greeting,
  });

  final bool offerStartTls;

  /// Sends the capabilities unasked after STARTTLS, as RFC 5804 says.
  final bool capabilitiesAfterTls;
  final String user;
  String password;

  /// Replaces the greeting (e.g. `BYE "Too many connections"`).
  final String? greeting;

  /// Access tokens XOAUTH2 accepts.
  final validTokens = <String>{};
  final scripts = <String, String>{};
  String? active;
  int quota = 10000;

  /// Commands as decoded tokens, e.g. `['PUTSCRIPT', 'loupe', '<script>']`.
  final commands = <List<String>>[];

  /// Every byte the client sent, as text.
  final received = StringBuffer();

  /// Whether each command arrived over TLS.
  final secure = <bool>[];

  /// Overrides the reply to a verb: raw lines without CRLF.
  final replies = <String, List<String> Function(List<String> args)>{};

  int startTlsCalls = 0;
  FakeSieveChannel? _channel;
  final _buffer = <int>[];
  _Sasl? _sasl;

  FakeSieveChannel connect() {
    final channel = _channel = FakeSieveChannel._(this, isSecure: false);
    if (greeting != null) {
      _send([greeting!]);
    } else {
      _sendCapabilities(tls: false);
    }
    return channel;
  }

  List<String> _capabilityLines({required bool tls}) => [
    '"IMPLEMENTATION" "Dovecot Pigeonhole"',
    '"SIEVE" "fileinto reject envelope encoded-character vacation subaddress comparator-i;ascii-numeric '
        'relational regex imap4flags copy include variables body enotify environment mailbox date index ihave '
        'duplicate mime foreverypart extracttext"',
    '"NOTIFY" "mailto"',
    if (tls) '"SASL" "PLAIN LOGIN XOAUTH2"' else '"SASL" ""',
    if (offerStartTls && !tls) '"STARTTLS"',
    '"VERSION" "1.0"',
  ];

  void _sendCapabilities({required bool tls}) => _send([..._capabilityLines(tls: tls), 'OK "Dovecot ready."']);

  void _send(List<String> lines) {
    _channel!._toClient.add(Uint8List.fromList(utf8.encode(lines.map((l) => '$l\r\n').join())));
  }

  /// A server literal `{n}` with [text].
  static String literal(String text) => '{${utf8.encode(text).length}}\r\n$text';

  void _upgraded(FakeSieveChannel next) {
    startTlsCalls++;
    _channel = next;
    if (capabilitiesAfterTls) _sendCapabilities(tls: true);
  }

  void _receive(List<int> bytes) {
    received.write(utf8.decode(bytes));
    _buffer.addAll(bytes);
    while (_tryCommand()) {}
  }

  /// Parses one complete command from the buffer (quoted strings, `{n+}`
  /// literals, atoms) and answers it. False if it isn't complete yet.
  bool _tryCommand() {
    final tokens = <String>[];
    var i = 0;
    while (true) {
      if (i >= _buffer.length) return false;
      final c = _buffer[i];
      if (c == 0x20) {
        i++;
      } else if (c == 0x0d) {
        if (i + 1 >= _buffer.length) return false;
        i += 2;
        break;
      } else if (c == 0x22) {
        final out = <int>[];
        var j = i + 1;
        while (j < _buffer.length && _buffer[j] != 0x22) {
          if (_buffer[j] == 0x5c) j++;
          if (j < _buffer.length) out.add(_buffer[j]);
          j++;
        }
        if (j >= _buffer.length) return false;
        tokens.add(utf8.decode(out));
        i = j + 1;
      } else if (c == 0x7b) {
        final close = _buffer.indexOf(0x7d, i);
        if (close < 0) return false;
        final spec = ascii.decode(_buffer.sublist(i + 1, close));
        if (!spec.endsWith('+')) throw StateError('The client sent a synchronising literal: {$spec}');
        final n = int.parse(spec.substring(0, spec.length - 1));
        final start = close + 3;
        if (_buffer.length < start + n) return false;
        tokens.add(utf8.decode(_buffer.sublist(start, start + n)));
        i = start + n;
      } else {
        var j = i;
        while (j < _buffer.length && _buffer[j] != 0x20 && _buffer[j] != 0x0d) {
          j++;
        }
        tokens.add(ascii.decode(_buffer.sublist(i, j)));
        i = j;
      }
    }
    _buffer.removeRange(0, i);
    _handle(tokens);
    return true;
  }

  void _handle(List<String> tokens) {
    final sasl = _sasl;
    if (sasl != null) {
      _sasl = null;
      sasl.answer(tokens.isEmpty ? '' : tokens.first);
      return;
    }
    commands.add(tokens);
    secure.add(_channel!.isSecure);
    final verb = tokens.first.toUpperCase();
    final args = tokens.sublist(1);
    final custom = replies[verb];
    if (custom != null) {
      _send(custom(args));
      return;
    }
    switch (verb) {
      case 'CAPABILITY':
        _send([..._capabilityLines(tls: _channel!.isSecure), 'OK "Capability completed."']);
      case 'STARTTLS':
        _send(['OK "Begin TLS negotiation now."']);
      case 'AUTHENTICATE':
        _authenticate(args[0].toUpperCase(), args.length > 1 ? args[1] : null);
      case 'LISTSCRIPTS':
        _send([
          for (final name in scripts.keys) name == active ? '"$name" ACTIVE' : '"$name"',
          'OK "Listscripts completed."',
        ]);
      case 'GETSCRIPT':
        final script = scripts[args[0]];
        _send(
          script == null
              ? ['NO (NONEXISTENT) "Script does not exist."']
              : [literal(script), 'OK "Getscript completed."'],
        );
      case 'CHECKSCRIPT':
        _send([_check(args[0]) ?? 'OK "Script is valid."']);
      case 'PUTSCRIPT':
        final error = _check(args[1]);
        if (error == null) scripts[args[0]] = args[1];
        _send([error ?? 'OK "Putscript completed."']);
      case 'SETACTIVE':
        active = args[0].isEmpty ? null : args[0];
        _send(['OK "Setactive completed."']);
      case 'HAVESPACE':
        _send([
          int.parse(args[1]) > quota ? 'NO (QUOTA/MAXSIZE) "Script is too large."' : 'OK "Putscript would succeed."',
        ]);
      case 'DELETESCRIPT':
        scripts.remove(args[0]);
        _send(['OK "Deletescript completed."']);
      case 'LOGOUT':
        _send(['OK "Logout completed."']);
        unawaited(_channel!._toClient.close());
      default:
        _send(['NO "Unknown command."']);
    }
  }

  /// A Pigeonhole-style multi-line error for scripts containing ERROR.
  String? _check(String script) {
    final line = script.split('\n').indexWhere((l) => l.contains('ERROR'));
    if (line < 0) return null;
    return 'NO ${literal('line ${line + 1}: error: unknown command \'ERROR\'.\nerror: validation failed.')}';
  }

  void _authenticate(String mechanism, String? initial) {
    void done(bool ok) => _send([ok ? 'OK "Logged in."' : 'NO "Authentication failed."']);
    String decode(String s) => utf8.decode(base64.decode(s));
    switch (mechanism) {
      case 'PLAIN':
        final parts = decode(initial!).split('\u0000');
        done(parts.length == 3 && parts[1] == user && parts[2] == password);
      case 'LOGIN':
        _send(['"${base64.encode(utf8.encode('Username:'))}"']);
        _sasl = _Sasl((u) {
          _send(['"${base64.encode(utf8.encode('Password:'))}"']);
          _sasl = _Sasl((p) => done(decode(u) == user && decode(p) == password));
        });
      case 'XOAUTH2':
        final fields = decode(initial!).split('\u0001');
        final token = fields
            .firstWhere((f) => f.startsWith('auth=Bearer '), orElse: () => '')
            .replaceFirst('auth=Bearer ', '');
        if (fields.first == 'user=$user' && validTokens.contains(token)) {
          done(true);
        } else {
          _send([literal(base64.encode(utf8.encode('{"status":"401"}')))]);
          _sasl = _Sasl((answer) => done(false));
        }
      default:
        _send(['NO "Unsupported mechanism."']);
    }
  }
}

final class _Sasl {
  _Sasl(this.answer);
  final void Function(String answer) answer;
}

/// One side of an in-memory connection; [startTls] hands the server a new,
/// "encrypted" channel (the seam the real client uses for TLS).
final class FakeSieveChannel implements SieveChannel {
  FakeSieveChannel._(this._server, {required this.isSecure});

  final ScriptedSieveServer _server;
  final _toClient = StreamController<Uint8List>();

  @override
  final bool isSecure;

  @override
  Stream<Uint8List> get input => _toClient.stream;

  @override
  void write(List<int> bytes) => scheduleMicrotask(() => _server._receive(bytes));

  @override
  Future<void> flush() async {}

  @override
  Future<SieveChannel> startTls() async {
    final next = FakeSieveChannel._(_server, isSecure: true);
    unawaited(_toClient.close());
    _server._upgraded(next);
    return next;
  }

  @override
  Future<void> close() async {
    if (!_toClient.isClosed) unawaited(_toClient.close());
  }
}
