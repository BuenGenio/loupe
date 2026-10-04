/// A ManageSieve client (RFC 5804).
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

import 'channel.dart';
import 'session.dart';

/// One ManageSieve connection: reads the greeting, upgrades with STARTTLS,
/// logs in with SASL PLAIN, LOGIN, XOAUTH2 or OAUTHBEARER, then runs
/// commands one at a time. Strings go out quoted, or as non-synchronising
/// literals (`{n+}`) when they are long or have line breaks; scripts always
/// go as literals.
final class ManageSieveClient implements SieveSession {
  ManageSieveClient._(this._channel, this.host, this.timeout) : _reader = _ByteReader(_channel.input, timeout);

  /// Reads the greeting and, unless the channel is already encrypted, says
  /// STARTTLS. Without STARTTLS on offer it refuses to go on (credentials
  /// never cross in plain text) unless [requireTls] is false.
  static Future<ManageSieveClient> open(
    SieveChannel channel, {
    required String host,
    bool requireTls = true,
    Duration timeout = const Duration(seconds: 30),
    Duration capabilityWait = const Duration(seconds: 5),
  }) async {
    final client = ManageSieveClient._(channel, host, timeout).._capabilityWait = capabilityWait;
    try {
      client._capabilities = await client._guard(client._readCapabilities);
      if (!channel.isSecure) {
        if (client._capabilities.startTls) {
          await client._guard(client._startTls);
        } else if (requireTls) {
          throw MailException(
            MailErrorKind.unsupported,
            '$host doesn’t offer a secure connection (STARTTLS) for server rules.',
          );
        }
      }
      return client;
    } catch (_) {
      await client._close();
      rethrow;
    }
  }

  final String host;
  final Duration timeout;
  SieveChannel _channel;
  _ByteReader _reader;
  late SieveCapabilities _capabilities;
  Future<void> _last = Future.value();
  bool _closed = false;

  /// How long to wait for the capabilities a server sends unasked after
  /// STARTTLS before asking for them.
  Duration _capabilityWait = const Duration(seconds: 5);

  @override
  SieveCapabilities get capabilities => _capabilities;

  /// Whether the connection is encrypted.
  bool get isSecure => _channel.isSecure;

  // Plumbing -------------------------------------------------------------------------

  /// Runs [op] after the previous command, mapping socket trouble to
  /// [MailException]s.
  Future<T> _run<T>(Future<T> Function() op) {
    final result = _last.then((_) => _guard(op));
    _last = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }

  Future<T> _guard<T>(Future<T> Function() op) async {
    if (_closed) throw MailException(MailErrorKind.connection, 'The connection to $host is closed.');
    try {
      return await op();
    } on TimeoutException catch (e) {
      await _close();
      throw MailException(MailErrorKind.connection, '$host stopped responding.', e);
    } on SocketException catch (e) {
      await _close();
      throw MailException(MailErrorKind.connection, 'Lost the connection to $host.', e);
    } on TlsException catch (e) {
      await _close();
      throw MailException(MailErrorKind.connection, 'Lost the secure connection to $host.', e);
    }
  }

  Future<void> _close() async {
    if (_closed) return;
    _closed = true;
    try {
      await _reader.cancel();
    } catch (_) {
      // Already gone.
    }
    await _channel.close();
  }

  /// A string argument: quoted when short and single-line, else a literal.
  static List<int> _string(String s, {bool literal = false}) {
    final bytes = utf8.encode(s);
    if (!literal && bytes.length <= 1024 && !s.contains(RegExp('[\r\n\u0000]'))) {
      return utf8.encode('"${s.replaceAll(r'\', r'\\').replaceAll('"', r'\"')}"');
    }
    return [...ascii.encode('{${bytes.length}+}\r\n'), ...bytes];
  }

  Future<void> _write(String verb, {List<String> strings = const [], String? literal, String? number}) async {
    final out = BytesBuilder(copy: false)..add(ascii.encode(verb));
    for (final s in strings) {
      out
        ..addByte(0x20)
        ..add(_string(s));
    }
    if (literal != null) {
      out
        ..addByte(0x20)
        ..add(_string(literal, literal: true));
    }
    if (number != null) out.add(ascii.encode(' $number'));
    out.add(const [0x0d, 0x0a]);
    _channel.write(out.takeBytes());
    await _channel.flush();
  }

  /// One response line as tokens, with literals read in.
  Future<List<_Token>> _readTokens() async {
    final tokens = <_Token>[];
    var line = await _reader.readLine();
    var i = 0;
    while (true) {
      while (i < line.length && line[i] == ' ') {
        i++;
      }
      if (i >= line.length) return tokens;
      final c = line[i];
      if (c == '"') {
        final out = StringBuffer();
        var j = i + 1;
        while (j < line.length && line[j] != '"') {
          if (line[j] == r'\' && j + 1 < line.length) j++;
          out.write(line[j]);
          j++;
        }
        tokens.add(_Token.string(out.toString()));
        i = j + 1;
      } else if (c == '{') {
        final close = line.indexOf('}', i);
        final n = int.tryParse(line.substring(i + 1, close < 0 ? line.length : close).replaceAll('+', ''));
        if (close < 0 || n == null) throw MailException(MailErrorKind.server, '$host sent a malformed literal.');
        final bytes = await _reader.readBytes(n);
        tokens.add(_Token.string(utf8.decode(bytes, allowMalformed: true)));
        // The response line goes on after the literal.
        line = await _reader.readLine();
        i = 0;
      } else if (c == '(' || c == ')') {
        tokens.add(_Token(c == '(' ? _Kind.open : _Kind.close, c));
        i++;
      } else {
        var j = i;
        while (j < line.length && !' ()'.contains(line[j])) {
          j++;
        }
        tokens.add(_Token(_Kind.atom, line.substring(i, j)));
        i = j;
      }
    }
  }

  /// The final response a line holds (`OK`, `NO`, `BYE`), or null for data.
  static _Reply? _asReply(List<_Token> tokens) {
    if (tokens.isEmpty || tokens.first.kind != _Kind.atom) return null;
    final status = tokens.first.text.toUpperCase();
    if (status != 'OK' && status != 'NO' && status != 'BYE') return null;
    String? code;
    var i = 1;
    if (i < tokens.length && tokens[i].kind == _Kind.open) {
      final parts = <String>[];
      for (i++; i < tokens.length && tokens[i].kind != _Kind.close; i++) {
        parts.add(tokens[i].text);
      }
      code = parts.isEmpty ? null : parts.first.toUpperCase();
      i++;
    }
    final text = i < tokens.length ? tokens.sublist(i).map((t) => t.text).join(' ').trim() : null;
    return _Reply(status, code, text == null || text.isEmpty ? null : text);
  }

  /// Data lines up to the final response.
  Future<(List<List<_Token>>, _Reply)> _readReply() async {
    final data = <List<_Token>>[];
    while (true) {
      final tokens = await _readTokens();
      final reply = _asReply(tokens);
      if (reply != null) return (data, reply);
      data.add(tokens);
    }
  }

  void _check(_Reply reply, String what) {
    switch (reply.status) {
      case 'OK':
        return;
      case 'BYE':
        unawaited(_close());
        throw MailException(MailErrorKind.connection, reply.text ?? '$host closed the connection.');
      default:
        throw SieveException(reply.text ?? 'The server refused to $what.', code: reply.code);
    }
  }

  Future<SieveCapabilities> _readCapabilities() async {
    final (data, reply) = await _readReply();
    _check(reply, 'say what it can do');
    return SieveCapabilities.parse({
      for (final line in data)
        if (line.isNotEmpty) line.first.text.toUpperCase(): line.length > 1 ? line[1].text : null,
    });
  }

  Future<void> _startTls() async {
    await _write('STARTTLS');
    final (_, reply) = await _readReply();
    _check(reply, 'start a secure connection');
    _reader.pause();
    final secure = await _channel.startTls();
    await _reader.cancel();
    _channel = secure;
    _reader = _ByteReader(secure.input, timeout);
    // The server says what it can do again (RFC 5804, 2.2); older servers
    // wait to be asked.
    if (!await _reader.dataWithin(_capabilityWait)) await _write('CAPABILITY');
    _capabilities = await _readCapabilities();
  }

  // Login -----------------------------------------------------------------------------

  /// Logs in as [username]. With OAuth, a rejected token is refreshed once.
  /// Asks for the capabilities again afterwards.
  Future<void> login(String username, CredentialsCallback credentials) => _run(() async {
    var c = await credentials();
    try {
      await _authenticate(username, c);
    } on SieveException catch (e) {
      if (e.kind != MailErrorKind.authentication || c is! OAuthCredentials) rethrow;
      c = await credentials(forceRefresh: true);
      await _authenticate(username, c);
    }
    await _write('CAPABILITY');
    _capabilities = await _readCapabilities();
  });

  Future<void> _authenticate(String username, Credentials credentials) async {
    final sasl = _capabilities.sasl;
    String b64(String s) => base64.encode(utf8.encode(s));
    switch (credentials) {
      case PasswordCredentials(:final password):
        if (sasl.contains('PLAIN') || !sasl.contains('LOGIN')) {
          await _sasl('PLAIN', initial: b64('\u0000$username\u0000$password'), answers: const []);
        } else {
          await _sasl('LOGIN', answers: [b64(username), b64(password)]);
        }
      case OAuthCredentials(:final accessToken):
        if (sasl.contains('XOAUTH2') || !sasl.contains('OAUTHBEARER')) {
          await _sasl(
            'XOAUTH2',
            initial: b64('user=$username\u0001auth=Bearer $accessToken\u0001\u0001'),
            answers: const [''],
          );
        } else {
          await _sasl(
            'OAUTHBEARER',
            initial: b64('n,a=$username,\u0001auth=Bearer $accessToken\u0001\u0001'),
            answers: [b64('\u0001')],
          );
        }
    }
  }

  /// AUTHENTICATE [mechanism], answering challenges with [answers] in turn
  /// (and `"*"`, which cancels, when they run out).
  Future<void> _sasl(String mechanism, {String? initial, required List<String> answers}) async {
    await _write('AUTHENTICATE', strings: [mechanism, ?initial]);
    var next = 0;
    while (true) {
      final tokens = await _readTokens();
      final reply = _asReply(tokens);
      if (reply != null) {
        if (reply.status == 'OK') return;
        if (reply.status == 'BYE') _check(reply, 'log in');
        throw SieveException(
          reply.text ?? 'The server rejected the user name or password.',
          code: reply.code,
          kind: MailErrorKind.authentication,
        );
      }
      final answer = next < answers.length ? answers[next++] : null;
      _channel.write([...(answer == null ? ascii.encode('"*"') : _string(answer)), 0x0d, 0x0a]);
      await _channel.flush();
    }
  }

  // Commands --------------------------------------------------------------------------

  /// Asks for the capabilities again.
  Future<SieveCapabilities> capability() => _run(() async {
    await _write('CAPABILITY');
    return _capabilities = await _readCapabilities();
  });

  @override
  Future<List<SieveScriptInfo>> listScripts() => _run(() async {
    await _write('LISTSCRIPTS');
    final (data, reply) = await _readReply();
    _check(reply, 'list the scripts');
    return [
      for (final line in data)
        if (line.isNotEmpty && line.first.kind == _Kind.string)
          SieveScriptInfo(
            line.first.text,
            active: line.length > 1 && line[1].kind == _Kind.atom && line[1].text.toUpperCase() == 'ACTIVE',
          ),
    ];
  });

  @override
  Future<String> getScript(String name) => _run(() async {
    await _write('GETSCRIPT', strings: [name]);
    final (data, reply) = await _readReply();
    _check(reply, 'send the script “$name”');
    return data.isEmpty || data.first.isEmpty ? '' : data.first.first.text;
  });

  @override
  Future<String?> checkScript(String script) => _run(() async {
    await _write('CHECKSCRIPT', literal: script);
    final (_, reply) = await _readReply();
    _check(reply, 'accept the script');
    return reply.code == 'WARNINGS' ? reply.text : null;
  });

  @override
  Future<void> putScript(String name, String script) => _run(() async {
    await _write('PUTSCRIPT', strings: [name], literal: script);
    final (_, reply) = await _readReply();
    _check(reply, 'store the script “$name”');
  });

  @override
  Future<void> setActive(String name) => _run(() async {
    await _write('SETACTIVE', strings: [name]);
    final (_, reply) = await _readReply();
    _check(reply, 'activate the script “$name”');
  });

  @override
  Future<bool> haveSpace(String name, int size) => _run(() async {
    await _write('HAVESPACE', strings: [name], number: '$size');
    final (_, reply) = await _readReply();
    if (reply.status == 'NO' && (reply.code ?? '').startsWith('QUOTA')) return false;
    _check(reply, 'check its space');
    return true;
  });

  @override
  Future<void> deleteScript(String name) => _run(() async {
    await _write('DELETESCRIPT', strings: [name]);
    final (_, reply) = await _readReply();
    _check(reply, 'delete the script “$name”');
  });

  @override
  Future<void> logout() async {
    if (_closed) return;
    try {
      await _run(() async {
        await _write('LOGOUT');
        await _readReply().timeout(const Duration(seconds: 5));
      });
    } on Object {
      // Closing anyway.
    }
    await _close();
  }
}

enum _Kind { atom, string, open, close }

final class _Token {
  const _Token(this.kind, this.text);
  const _Token.string(this.text) : kind = _Kind.string;
  final _Kind kind;
  final String text;
}

final class _Reply {
  const _Reply(this.status, this.code, this.text);
  final String status;
  final String? code;
  final String? text;
}

/// Buffers a channel's bytes and hands out lines and literal bytes.
final class _ByteReader {
  _ByteReader(Stream<Uint8List> input, this.timeout) {
    _sub = input.listen(
      (data) {
        _buffer.addAll(data);
        _wake();
      },
      onError: (Object e) {
        _error ??= e;
        _wake();
      },
      onDone: () {
        _done = true;
        _wake();
      },
    );
  }

  final Duration timeout;
  late final StreamSubscription<Uint8List> _sub;
  final _buffer = <int>[];
  Completer<void>? _waiting;
  Object? _error;
  bool _done = false;

  void _wake() {
    final w = _waiting;
    _waiting = null;
    w?.complete();
  }

  Future<void> _more() {
    final error = _error;
    if (error != null) return Future.error(error);
    if (_done) return Future.error(const SocketException('Connection closed'));
    final c = _waiting = Completer<void>();
    return c.future.timeout(timeout);
  }

  Future<String> readLine() async {
    while (true) {
      final nl = _buffer.indexOf(0x0a);
      if (nl >= 0) {
        var end = nl;
        if (end > 0 && _buffer[end - 1] == 0x0d) end--;
        final line = utf8.decode(_buffer.sublist(0, end), allowMalformed: true);
        _buffer.removeRange(0, nl + 1);
        return line;
      }
      await _more();
    }
  }

  Future<Uint8List> readBytes(int n) async {
    while (_buffer.length < n) {
      await _more();
    }
    final out = Uint8List.fromList(_buffer.sublist(0, n));
    _buffer.removeRange(0, n);
    return out;
  }

  /// Whether data arrives within [wait] (without reading it).
  Future<bool> dataWithin(Duration wait) async {
    if (_buffer.isNotEmpty || _error != null || _done) return true;
    final c = _waiting = Completer<void>();
    try {
      await c.future.timeout(wait);
      return true;
    } on TimeoutException {
      if (identical(_waiting, c)) _waiting = null;
      return false;
    }
  }

  void pause() => _sub.pause();
  Future<void> cancel() => _sub.cancel();
}
