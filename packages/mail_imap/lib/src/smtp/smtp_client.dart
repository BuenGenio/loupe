/// A small SMTP submission client (RFC 5321, 4954, 6409).
///
/// enough_mail's SmtpClient escapes only lines that are exactly ".", encodes
/// AUTH PLAIN as UTF-16 code units and sends message data as text, so the
/// sender uses this client instead; it shares the TLS/STARTTLS socket code
/// with the IMAP transport.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

import '../net/line_reader.dart';
import '../net/secure_socket.dart';

/// One SMTP session.
final class SmtpConnection {
  SmtpConnection._(this._socket, this._reader, this.host);

  final Socket _socket;
  final LineReader _reader;
  final String host;

  /// EHLO keywords, upper-cased (`SIZE 35882577`, `AUTH PLAIN LOGIN`, …).
  final extensions = <String>[];

  /// Opens a session and says EHLO.
  static Future<SmtpConnection> open(ServerConfig server, {Duration timeout = const Duration(seconds: 30)}) async {
    final socket = await openMailSocket(
      host: server.host,
      port: server.port,
      security: server.security,
      protocol: WireProtocol.smtp,
      trustedSha256: server.trustedCertificateSha256,
      timeout: timeout,
    );
    final conn = SmtpConnection._(socket, LineReader(socket, const Duration(seconds: 60)), server.host);
    try {
      final (code, text) = await conn._reply();
      if (code != 220) throw MailException(MailErrorKind.server, '${server.host}: ${text.join(' ')}');
      await conn._ehlo();
      return conn;
    } catch (_) {
      await conn.close();
      rethrow;
    }
  }

  Future<(int, List<String>)> _reply() async {
    try {
      return await _reader.smtpReply();
    } on TimeoutException {
      await close();
      throw MailException(MailErrorKind.connection, '$host stopped responding.');
    } on SocketException catch (e) {
      throw MailException(MailErrorKind.connection, 'Lost the connection to $host.', e);
    }
  }

  /// Sends one command line and reads the reply.
  Future<(int, List<String>)> command(String line) async {
    try {
      _socket.write('$line\r\n');
      await _socket.flush();
    } on Object catch (e) {
      throw MailException(MailErrorKind.connection, 'Lost the connection to $host.', e);
    }
    return _reply();
  }

  Future<void> _ehlo() async {
    var (code, lines) = await command('EHLO [127.0.0.1]');
    if (code != 250) {
      (code, lines) = await command('HELO [127.0.0.1]');
      if (code != 250) throw MailException(MailErrorKind.server, '$host: ${lines.join(' ')}');
    }
    extensions
      ..clear()
      ..addAll(lines.skip(1).map((l) => l.toUpperCase().trim()));
  }

  bool supports(String keyword) => extensions.any((e) => e == keyword || e.startsWith('$keyword '));

  /// AUTH mechanisms the server offers.
  Set<String> get authMechanisms => {
    for (final e in extensions)
      if (e.startsWith('AUTH ') || e.startsWith('AUTH=')) ...e.substring(5).split(' ').where((m) => m.isNotEmpty),
  };

  /// Maximum message size, if the server announced one.
  int? get maxSize {
    for (final e in extensions) {
      if (e.startsWith('SIZE ')) return int.tryParse(e.substring(5).trim());
    }
    return null;
  }

  /// Authenticates. Servers that offer no AUTH at all are used as is.
  Future<void> authenticate(String username, Credentials credentials) async {
    final mechanisms = authMechanisms;
    if (mechanisms.isEmpty) return;
    (int, List<String>) reply;
    switch (credentials) {
      case PasswordCredentials(:final password):
        if (mechanisms.contains('PLAIN') || !mechanisms.contains('LOGIN')) {
          reply = await command('AUTH PLAIN ${base64.encode(utf8.encode('\u0000$username\u0000$password'))}');
        } else {
          reply = await command('AUTH LOGIN');
          if (reply.$1 == 334) reply = await command(base64.encode(utf8.encode(username)));
          if (reply.$1 == 334) reply = await command(base64.encode(utf8.encode(password)));
        }
      case OAuthCredentials(:final accessToken):
        final String initial;
        if (mechanisms.contains('XOAUTH2') || !mechanisms.contains('OAUTHBEARER')) {
          initial = 'XOAUTH2 ${base64.encode(utf8.encode('user=$username\u0001auth=Bearer $accessToken\u0001\u0001'))}';
        } else {
          initial =
              'OAUTHBEARER ${base64.encode(utf8.encode('n,a=$username,\u0001auth=Bearer $accessToken\u0001\u0001'))}';
        }
        reply = await command('AUTH $initial');
        // An error challenge carries JSON details; answer it to get the final reply.
        if (reply.$1 == 334) reply = await command('');
    }
    if (reply.$1 != 235) {
      throw MailException(MailErrorKind.authentication, _authMessage(reply));
    }
  }

  String _authMessage((int, List<String>) reply) {
    final text = reply.$2.join(' ').replaceFirst(RegExp(r'^\d\.\d\.\d+\s*'), '').trim();
    return text.isEmpty ? 'The server rejected the user name or password.' : text;
  }

  /// Sends [data] (RFC 822 bytes) to [recipients]. Dot-stuffs every line
  /// that starts with a dot and normalises bare LF to CRLF.
  Future<void> sendMail(String from, List<String> recipients, Uint8List data) async {
    final eightBit = data.any((b) => b > 0x7f);
    final utf8Addresses = [from, ...recipients].any((a) => a.codeUnits.any((c) => c > 0x7f));
    final size = maxSize;
    if (size != null && size > 0 && data.length > size) {
      throw MailException(
        MailErrorKind.server,
        'The message is too large for $host (${(data.length / 1e6).toStringAsFixed(1)} MB, limit '
        '${(size / 1e6).toStringAsFixed(1)} MB).',
      );
    }
    final params = StringBuffer();
    if (supports('SIZE')) params.write(' SIZE=${data.length}');
    if (eightBit && supports('8BITMIME')) params.write(' BODY=8BITMIME');
    if (utf8Addresses && supports('SMTPUTF8')) params.write(' SMTPUTF8');
    _expect(await command('MAIL FROM:<$from>$params'), 250, 'Sender $from');
    for (final r in recipients) {
      _expect(await command('RCPT TO:<$r>'), 250, 'Recipient $r', alsoOk: 251);
    }
    _expect(await command('DATA'), 354, 'Message');
    try {
      _socket.add(dotStuff(data));
      _socket.write('.\r\n');
      await _socket.flush();
    } on Object catch (e) {
      throw MailException(MailErrorKind.connection, 'Lost the connection to $host.', e);
    }
    _expect(await _reply(), 250, 'Message');
  }

  void _expect((int, List<String>) reply, int code, String what, {int? alsoOk}) {
    if (reply.$1 == code || reply.$1 == alsoOk) return;
    final text = reply.$2.join(' ').trim();
    final kind = reply.$1 == 530 || reply.$1 == 535 ? MailErrorKind.authentication : MailErrorKind.server;
    throw MailException(kind, '$what rejected by $host: $text');
  }

  /// Says QUIT (best effort) and closes the socket.
  Future<void> quit() async {
    try {
      await command('QUIT').timeout(const Duration(seconds: 5));
    } on Object {
      // Closing anyway.
    }
    await close();
  }

  Future<void> close() async {
    try {
      await _reader.cancel();
    } on Object {
      // Already closed.
    }
    _socket.destroy();
  }
}

/// Escapes leading dots (RFC 5321 4.5.2), turns bare LF into CRLF and makes
/// sure the data ends with CRLF.
Uint8List dotStuff(Uint8List data) {
  final out = BytesBuilder(copy: false);
  var start = 0;
  var lineStart = true;
  for (var i = 0; i < data.length; i++) {
    final b = data[i];
    if (lineStart && b == 0x2e) {
      out
        ..add(Uint8List.sublistView(data, start, i))
        ..addByte(0x2e);
      start = i;
    }
    lineStart = b == 0x0a;
    if (lineStart && (i == 0 || data[i - 1] != 0x0d)) {
      out
        ..add(Uint8List.sublistView(data, start, i))
        ..addByte(0x0d);
      start = i;
    }
  }
  out.add(Uint8List.sublistView(data, start));
  final n = data.length;
  if (n > 0 && data[n - 1] != 0x0a) {
    if (data[n - 1] != 0x0d) out.addByte(0x0d);
    out.addByte(0x0a);
  }
  return out.takeBytes();
}
