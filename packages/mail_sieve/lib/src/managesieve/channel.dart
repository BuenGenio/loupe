/// The byte stream a ManageSieve client talks over, with the STARTTLS seam.
library;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:mail_imap/mail_imap.dart' show secureMailSocket;

/// A connection's bytes. [input] is listened to once; after STARTTLS the
/// client pauses that subscription, calls [startTls], cancels it and goes on
/// with the returned channel.
abstract interface class SieveChannel {
  Stream<Uint8List> get input;
  void write(List<int> bytes);
  Future<void> flush();

  /// True once the connection is encrypted.
  bool get isSecure;

  /// Upgrades to TLS (after the server said OK to STARTTLS) and returns
  /// the encrypted channel.
  Future<SieveChannel> startTls();

  Future<void> close();
}

/// A [SieveChannel] over a socket; [startTls] checks the certificate like
/// the IMAP connection does (a self-signed certificate the user trusted
/// for the account's IMAP server is trusted here too).
final class SocketSieveChannel implements SieveChannel {
  SocketSieveChannel(this._socket, {required this.host, this.trustedSha256, this.isSecure = false, this.timeout});

  final Socket _socket;
  final String host;
  final String? trustedSha256;
  final Duration? timeout;

  @override
  final bool isSecure;

  @override
  Stream<Uint8List> get input => _socket;

  @override
  void write(List<int> bytes) => _socket.add(bytes);

  @override
  Future<void> flush() => _socket.flush();

  @override
  Future<SieveChannel> startTls() async {
    final secure = await secureMailSocket(
      _socket,
      host: host,
      trustedSha256: trustedSha256,
      timeout: timeout ?? const Duration(seconds: 20),
    );
    return SocketSieveChannel(secure, host: host, trustedSha256: trustedSha256, isSecure: true, timeout: timeout);
  }

  @override
  Future<void> close() async {
    _socket.destroy();
  }
}
