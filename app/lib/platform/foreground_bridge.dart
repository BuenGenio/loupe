import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

/// Hands work from background isolates (a notification action) to the app's
/// main isolate while it runs, so the app's own repository does it: one
/// syncer on the database, and the screens update at once.
///
/// The main isolate [serve]s; a background isolate tries [forward] and does
/// the work itself when nobody answers (the app isn't running).
abstract final class ForegroundBridge {
  static const portName = 'loupe.foreground';

  /// Serves requests until [ForegroundBridgeServer.close]. Each request is
  /// acknowledged as soon as it is accepted, then handled.
  static ForegroundBridgeServer serve(Future<void> Function(Map<String, Object?> request) handle) {
    final port = ReceivePort('loupe.foreground');
    IsolateNameServer.removePortNameMapping(portName);
    IsolateNameServer.registerPortWithName(port.sendPort, portName);
    port.listen((message) {
      if (message case [final SendPort reply, final Map<Object?, Object?> request]) {
        reply.send(true);
        unawaited(handle(request.cast<String, Object?>()).catchError((Object _) {}));
      }
    });
    return ForegroundBridgeServer._(port);
  }

  /// Sends [request] to the main isolate. True if it accepted it within
  /// [timeout]; false if the app isn't running (a stale registration left by
  /// a destroyed engine is removed).
  static Future<bool> forward(Map<String, Object?> request, {Duration timeout = const Duration(seconds: 2)}) async {
    final target = IsolateNameServer.lookupPortByName(portName);
    if (target == null) return false;
    final reply = ReceivePort('loupe.foreground.reply');
    try {
      target.send([reply.sendPort, request]);
      final accepted = await reply.first.timeout(timeout, onTimeout: () => false);
      if (accepted != true) IsolateNameServer.removePortNameMapping(portName);
      return accepted == true;
    } finally {
      reply.close();
    }
  }
}

final class ForegroundBridgeServer {
  ForegroundBridgeServer._(this._port);

  final ReceivePort _port;

  void close() {
    if (IsolateNameServer.lookupPortByName(ForegroundBridge.portName) == _port.sendPort) {
      IsolateNameServer.removePortNameMapping(ForegroundBridge.portName);
    }
    _port.close();
  }
}
