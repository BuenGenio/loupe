import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// A tiny IMAP server on the loopback interface for transport unit tests: it
/// greets, accepts any AUTHENTICATE PLAIN, answers LIST with [listLines] and
/// every other command with `OK` unless [reply] says otherwise. It records
/// each command (without its tag) in [commands].
final class ScriptedImapServer {
  ScriptedImapServer._(this._socket) {
    _socket.listen(_serve);
  }

  static Future<ScriptedImapServer> start() async =>
      ScriptedImapServer._(await ServerSocket.bind(InternetAddress.loopbackIPv4, 0));

  final ServerSocket _socket;
  final _clients = <Socket>[];

  int get port => _socket.port;

  /// Commands received, without tags, e.g. `SUBSCRIBE "Lists"`.
  final commands = <String>[];

  /// Untagged LIST responses (without `* `).
  List<String> listLines = const [r'LIST (\HasNoChildren \Subscribed) "/" INBOX'];

  /// The tagged reply (after the tag) for a command; null means `OK done`.
  String? Function(String command)? reply;

  static const _capabilities = 'IMAP4rev1 SASL-IR AUTH=PLAIN LIST-EXTENDED SPECIAL-USE';

  void _serve(Socket client) {
    _clients.add(client);
    client.write('* OK [CAPABILITY $_capabilities] Scripted server ready\r\n');
    client.cast<List<int>>().transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
      final space = line.indexOf(' ');
      if (space < 0) return;
      final tag = line.substring(0, space);
      final command = line.substring(space + 1);
      final verb = command.split(' ').first.toUpperCase();
      if (verb != 'AUTHENTICATE') commands.add(command);
      switch (verb) {
        case 'AUTHENTICATE':
          client.write('$tag OK [CAPABILITY $_capabilities] Logged in\r\n');
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
    }, onError: (Object _) {});
  }

  Future<void> close() async {
    for (final c in _clients) {
      c.destroy();
    }
    await _socket.close();
  }
}
