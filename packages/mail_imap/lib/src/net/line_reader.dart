/// Reading CRLF-terminated lines from a socket.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// Buffers a socket's data and hands out lines (without CRLF).
final class LineReader {
  LineReader(Socket socket, this.timeout) {
    _sub = socket.listen(
      (data) {
        _buffer.add(data);
        _drain();
      },
      onError: _fail,
      onDone: () => _fail(const SocketException('Connection closed')),
    );
  }

  /// How long [next] waits for a line.
  final Duration timeout;
  late final StreamSubscription<Uint8List> _sub;
  var _buffer = BytesBuilder();
  final _lines = <String>[];
  Completer<String>? _waiting;
  Object? _error;

  void _drain() {
    var bytes = _buffer.takeBytes();
    var start = 0;
    for (var i = 0; i < bytes.length; i++) {
      if (bytes[i] != 0x0a) continue;
      var end = i;
      if (end > start && bytes[end - 1] == 0x0d) end--;
      _lines.add(utf8.decode(Uint8List.sublistView(bytes, start, end), allowMalformed: true));
      start = i + 1;
    }
    _buffer = BytesBuilder()..add(Uint8List.sublistView(bytes, start));
    bytes = Uint8List(0);
    final w = _waiting;
    if (w != null && _lines.isNotEmpty) {
      _waiting = null;
      w.complete(_lines.removeAt(0));
    }
  }

  void _fail(Object e) {
    _error ??= e;
    final w = _waiting;
    _waiting = null;
    w?.completeError(e);
  }

  /// The next line; throws [TimeoutException] or the socket's error.
  Future<String> next() {
    if (_lines.isNotEmpty) return Future.value(_lines.removeAt(0));
    final error = _error;
    if (error != null) return Future.error(error);
    final c = _waiting = Completer<String>();
    return c.future.timeout(timeout);
  }

  /// A complete (possibly multi-line) SMTP reply: code and text lines.
  Future<(int, List<String>)> smtpReply() async {
    final lines = <String>[];
    while (true) {
      final line = await next();
      final code = int.tryParse(line.length >= 3 ? line.substring(0, 3) : '') ?? 0;
      lines.add(line.length > 4 ? line.substring(4) : '');
      if (line.length < 4 || line[3] != '-') return (code, lines);
    }
  }

  void pause() => _sub.pause();
  Future<void> cancel() => _sub.cancel();
}
