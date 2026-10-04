import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

/// Hands work from background isolates (a notification action) to the
/// isolate that syncs the database while it runs, so its own repository does
/// it: one syncer on the database, and what shows updates at once.
///
/// The app's main isolate serves [portName], the instant delivery service
/// [instantPortName]; a background isolate tries [forward] to each and does
/// the work itself when nobody answers.
abstract final class ForegroundBridge {
  static const portName = 'loupe.foreground';
  static const instantPortName = 'loupe.instant';

  /// Serves requests on [name] until [ForegroundBridgeServer.close]. Each
  /// request is acknowledged as soon as it is accepted, then handled.
  static ForegroundBridgeServer serve(
    Future<void> Function(Map<String, Object?> request) handle, {
    String name = portName,
  }) {
    final port = ReceivePort(name);
    IsolateNameServer.removePortNameMapping(name);
    IsolateNameServer.registerPortWithName(port.sendPort, name);
    port.listen((message) {
      if (message case [final SendPort reply, final Map<Object?, Object?> request]) {
        reply.send(true);
        unawaited(handle(request.cast<String, Object?>()).catchError((Object _) {}));
      }
    });
    return ForegroundBridgeServer._(port, name);
  }

  /// Sends [request] to the isolate serving [name]. True if it accepted it
  /// within [timeout]; false if it isn't running (a stale registration left
  /// by a destroyed engine is removed).
  static Future<bool> forward(
    Map<String, Object?> request, {
    String name = portName,
    Duration timeout = const Duration(seconds: 2),
  }) async {
    final target = IsolateNameServer.lookupPortByName(name);
    if (target == null) return false;
    final reply = ReceivePort('$name.reply');
    try {
      target.send([reply.sendPort, request]);
      final accepted = await reply.first.timeout(timeout, onTimeout: () => false);
      if (accepted != true) IsolateNameServer.removePortNameMapping(name);
      return accepted == true;
    } finally {
      reply.close();
    }
  }
}

final class ForegroundBridgeServer {
  ForegroundBridgeServer._(this._port, this._name);

  final ReceivePort _port;
  final String _name;

  void close() {
    if (IsolateNameServer.lookupPortByName(_name) == _port.sendPort) IsolateNameServer.removePortNameMapping(_name);
    _port.close();
  }
}
