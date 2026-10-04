import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// A tiny IMAP server on the loopback interface for transport unit tests: it
/// greets, accepts any AUTHENTICATE unless [authReply] refuses it, answers LIST with [listLines] and
/// every other command with `OK` unless [script] or [reply] say otherwise. It
/// records each command (without its tag) in [commands] and the literals
/// clients send (APPEND, SETMETADATA) in [literals].
final class ScriptedImapServer {
  ScriptedImapServer._(this._socket) {
    _socket.listen((client) => _Session(this, client));
  }

  static Future<ScriptedImapServer> start() async =>
      ScriptedImapServer._(await ServerSocket.bind(InternetAddress.loopbackIPv4, 0));

  final ServerSocket _socket;
  final _clients = <Socket>[];

  int get port => _socket.port;

  /// Capabilities announced in the greeting and after login.
  String capabilities = 'IMAP4rev1 SASL-IR AUTH=PLAIN LIST-EXTENDED SPECIAL-USE';

  /// Commands received, without tags, e.g. `SUBSCRIBE "Lists"`. A command
  /// with a literal keeps its `{n}` announcement; the literal itself goes to
  /// [literals].
  final commands = <String>[];

  /// Literals received, in order, decoded as UTF-8.
  final literals = <String>[];

  /// Untagged LIST responses (without `* `).
  List<String> listLines = const [r'LIST (\HasNoChildren \Subscribed) "/" INBOX'];

  /// The tagged reply (after the tag) for a command; null means `OK done`.
  String? Function(String command)? reply;

  /// The tagged reply to an AUTHENTICATE command (with its SASL-IR
  /// argument); null, or no callback, logs in.
  String? Function(String command)? authReply;

  /// AUTHENTICATE commands received, with their arguments.
  final authentications = <String>[];

  /// A full answer to a command: raw untagged responses (each with `* ` and
  /// CRLF; literals as `{n}\r\n<data>`) and the tagged reply after the tag.
  /// Null falls back to the built-in answers and [reply].
  ({String untagged, String tagged})? Function(String command)? script;

  void _handle(Socket client, String line) {
    final space = line.indexOf(' ');
    if (space < 0) return;
    final tag = line.substring(0, space);
    final command = line.substring(space + 1);
    final verb = command.split(' ').first.toUpperCase();
    if (verb != 'AUTHENTICATE') commands.add(command);
    final scripted = verb == 'AUTHENTICATE' ? null : script?.call(command);
    if (scripted != null) {
      client.write('${scripted.untagged}$tag ${scripted.tagged}\r\n');
      return;
    }
    switch (verb) {
      case 'AUTHENTICATE':
        authentications.add(command);
        final refused = authReply?.call(command);
        client.write(refused == null ? '$tag OK [CAPABILITY $capabilities] Logged in\r\n' : '$tag $refused\r\n');
      case 'LIST':
        for (final l in listLines) {
          client.write('* $l\r\n');
        }
        client.write('$tag OK List completed\r\n');
      case 'LOGOUT':
        client.write('* BYE Bye\r\n$tag OK Logout completed\r\n');
        unawaited(client.close());
      default:
        client.write('$tag ${reply?.call(command) ?? 'OK done'}\r\n');
    }
  }

  Future<void> close() async {
    for (final c in _clients) {
      c.destroy();
    }
    await _socket.close();
  }
}

/// One client connection: splits the byte stream into command lines and
/// literals (answering `{n}` with a continuation request, `{n+}` without).
final class _Session {
  _Session(this.server, this.socket) {
    server._clients.add(socket);
    socket.write('* OK [CAPABILITY ${server.capabilities}] Scripted server ready\r\n');
    socket.listen(_onData, onError: (Object _) {});
  }

  final ScriptedImapServer server;
  final Socket socket;
  var _buffer = <int>[];
  int? _literal;
  final _command = StringBuffer();

  void _onData(List<int> data) {
    _buffer.addAll(data);
    while (true) {
      final literal = _literal;
      if (literal != null) {
        if (_buffer.length < literal) return;
        server.literals.add(utf8.decode(_buffer.sublist(0, literal), allowMalformed: true));
        _buffer = _buffer.sublist(literal);
        _literal = null;
        continue;
      }
      var end = -1;
      for (var i = 0; i + 1 < _buffer.length; i++) {
        if (_buffer[i] == 13 && _buffer[i + 1] == 10) {
          end = i;
          break;
        }
      }
      if (end < 0) return;
      final line = utf8.decode(_buffer.sublist(0, end), allowMalformed: true);
      _buffer = _buffer.sublist(end + 2);
      _command.write(line);
      final announced = RegExp(r'\{(\d+)(\+?)\}$').firstMatch(line);
      if (announced != null) {
        _literal = int.parse(announced[1]!);
        if (announced[2]!.isEmpty) socket.write('+ Ready for literal data\r\n');
        continue;
      }
      final command = _command.toString();
      _command.clear();
      server._handle(socket, command);
    }
  }
}
