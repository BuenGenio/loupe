/// Opening mail server connections: implicit TLS, STARTTLS (done here, so the
/// trusted-certificate check also covers it) or plain text.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:mail_model/mail_model.dart';

import 'line_reader.dart';

/// Which protocol speaks on the socket (for the STARTTLS exchange).
enum WireProtocol { imap, smtp }

/// The [MailException.cause] of a [MailErrorKind.certificate] error: the
/// certificate the server presented. Trusting it means storing [sha256] in
/// [ServerConfig.trustedCertificateSha256].
final class UntrustedCertificate {
  const UntrustedCertificate({required this.host, required this.sha256, this.subject, this.issuer, this.validUntil});

  final String host;

  /// Lower-case hex SHA-256 of the DER encoding, no separators.
  final String sha256;
  final String? subject;
  final String? issuer;
  final DateTime? validUntil;

  @override
  String toString() => 'UntrustedCertificate($host, $sha256)';
}

/// The SHA-256 fingerprint (lower-case hex) of a certificate.
String certificateFingerprint(X509Certificate certificate) => sha256.convert(certificate.der).toString();

/// Normalises a user-supplied fingerprint (`AB:CD…` or `abcd…`).
String normalizeFingerprint(String fingerprint) => fingerprint.replaceAll(RegExp('[^0-9a-fA-F]'), '').toLowerCase();

/// Extracts the fingerprint from a certificate error, for "Trust this
/// certificate" in the UI.
String? untrustedFingerprintOf(MailException error) {
  final cause = error.cause;
  if (cause is UntrustedCertificate) return cause.sha256;
  return RegExp(r'\b[0-9a-f]{64}\b').firstMatch(error.message)?[0];
}

/// Opens a connection to a mail server and, for STARTTLS, upgrades it.
///
/// A certificate that fails normal validation is accepted only if its
/// SHA-256 equals [trustedSha256]; otherwise a [MailException] of kind
/// [MailErrorKind.certificate] is thrown with an [UntrustedCertificate]
/// cause. For STARTTLS the returned socket replays a synthetic greeting, so
/// the protocol client can start as if freshly connected; the client must
/// ask for capabilities (IMAP) or say EHLO (SMTP) again.
Future<Socket> openMailSocket({
  required String host,
  required int port,
  required ConnectionSecurity security,
  required WireProtocol protocol,
  String? trustedSha256,
  Duration timeout = const Duration(seconds: 20),
}) async {
  UntrustedCertificate? rejected;
  bool onBadCertificate(X509Certificate cert) {
    final fp = certificateFingerprint(cert);
    if (trustedSha256 != null && normalizeFingerprint(trustedSha256) == fp) return true;
    rejected = UntrustedCertificate(
      host: host,
      sha256: fp,
      subject: cert.subject,
      issuer: cert.issuer,
      validUntil: cert.endValidity,
    );
    return false;
  }

  try {
    switch (security) {
      case ConnectionSecurity.tls:
        return await SecureSocket.connect(
          host,
          port,
          onBadCertificate: onBadCertificate,
          timeout: timeout,
        ).timeout(timeout);
      case ConnectionSecurity.none:
        return await Socket.connect(host, port, timeout: timeout);
      case ConnectionSecurity.startTls:
        final plain = await Socket.connect(host, port, timeout: timeout);
        try {
          return await _startTls(plain, host, protocol, onBadCertificate, timeout);
        } catch (_) {
          plain.destroy();
          rethrow;
        }
    }
  } on HandshakeException catch (e) {
    final cert = rejected;
    if (cert != null) {
      throw MailException(
        MailErrorKind.certificate,
        'The security certificate of $host is not trusted (SHA-256 ${cert.sha256}).',
        cert,
      );
    }
    throw MailException(MailErrorKind.connection, 'Secure connection to $host:$port failed.', e);
  } on TlsException catch (e) {
    throw MailException(MailErrorKind.connection, 'Secure connection to $host:$port failed.', e);
  } on SocketException catch (e) {
    throw MailException(MailErrorKind.connection, _socketMessage(host, port, e), e);
  } on TimeoutException catch (e) {
    throw MailException(MailErrorKind.connection, 'Connecting to $host:$port timed out.', e);
  }
}

/// Upgrades [plain] to TLS for a protocol whose STARTTLS exchange the caller
/// did itself (ManageSieve), with the certificate check of [openMailSocket].
/// As for [SecureSocket.secure], pause the caller's subscription to [plain]
/// first and cancel it afterwards.
Future<SecureSocket> secureMailSocket(
  Socket plain, {
  required String host,
  String? trustedSha256,
  Duration timeout = const Duration(seconds: 20),
}) async {
  UntrustedCertificate? rejected;
  bool onBadCertificate(X509Certificate cert) {
    final fp = certificateFingerprint(cert);
    if (trustedSha256 != null && normalizeFingerprint(trustedSha256) == fp) return true;
    rejected = UntrustedCertificate(
      host: host,
      sha256: fp,
      subject: cert.subject,
      issuer: cert.issuer,
      validUntil: cert.endValidity,
    );
    return false;
  }

  try {
    return await SecureSocket.secure(plain, host: host, onBadCertificate: onBadCertificate).timeout(timeout);
  } on HandshakeException catch (e) {
    final cert = rejected;
    if (cert != null) {
      throw MailException(
        MailErrorKind.certificate,
        'The security certificate of $host is not trusted (SHA-256 ${cert.sha256}).',
        cert,
      );
    }
    throw MailException(MailErrorKind.connection, 'Secure connection to $host failed.', e);
  } on TlsException catch (e) {
    throw MailException(MailErrorKind.connection, 'Secure connection to $host failed.', e);
  } on SocketException catch (e) {
    throw MailException(MailErrorKind.connection, 'Lost the connection to $host.', e);
  } on TimeoutException catch (e) {
    throw MailException(MailErrorKind.connection, 'The secure connection to $host timed out.', e);
  }
}

String _socketMessage(String host, int port, SocketException e) {
  final os = e.osError?.message;
  if (e.message.contains('Failed host lookup') || (os ?? '').contains('No address associated')) {
    return 'Server $host not found.';
  }
  return 'Couldn’t connect to $host:$port${os == null || os.isEmpty ? '' : ' ($os)'}.';
}

Future<Socket> _startTls(
  Socket plain,
  String host,
  WireProtocol protocol,
  bool Function(X509Certificate) onBadCertificate,
  Duration timeout,
) async {
  final reader = LineReader(plain, timeout);
  final String greeting;
  switch (protocol) {
    case WireProtocol.imap:
      final first = await reader.next();
      if (first.startsWith('* PREAUTH') || first.startsWith('* BYE')) {
        throw MailException(MailErrorKind.connection, '$host refused the connection before STARTTLS.');
      }
      plain.write('L0 STARTTLS\r\n');
      while (true) {
        final line = await reader.next();
        if (!line.startsWith('L0 ')) continue;
        if (!line.toUpperCase().startsWith('L0 OK')) {
          throw MailException(MailErrorKind.unsupported, '$host doesn’t support STARTTLS. Use SSL/TLS instead.');
        }
        break;
      }
      greeting = '* OK [Loupe] TLS established\r\n';
    case WireProtocol.smtp:
      final hello = await reader.smtpReply();
      if (hello.$1 != 220) throw MailException(MailErrorKind.server, '$host: ${hello.$2.join(' ')}');
      plain.write('EHLO [127.0.0.1]\r\n');
      final ehlo = await reader.smtpReply();
      if (ehlo.$1 != 250 || !ehlo.$2.any((l) => l.toUpperCase().startsWith('STARTTLS'))) {
        throw MailException(MailErrorKind.unsupported, '$host doesn’t support STARTTLS. Use SSL/TLS instead.');
      }
      plain.write('STARTTLS\r\n');
      final ready = await reader.smtpReply();
      if (ready.$1 != 220) {
        throw MailException(MailErrorKind.unsupported, '$host refused STARTTLS: ${ready.$2.join(' ')}');
      }
      greeting = '220 [Loupe] TLS established\r\n';
  }
  reader.pause();
  final secure = await SecureSocket.secure(plain, host: host, onBadCertificate: onBadCertificate).timeout(timeout);
  await reader.cancel();
  return _PrefixedSocket(secure, Uint8List.fromList(ascii.encode(greeting)));
}

/// A socket whose stream starts with [_first], then continues with the
/// wrapped socket's data.
final class _PrefixedSocket extends StreamView<Uint8List> implements Socket {
  _PrefixedSocket(this._inner, Uint8List first) : super(_prefixed(first, _inner));

  final Socket _inner;

  static Stream<Uint8List> _prefixed(Uint8List first, Stream<Uint8List> rest) async* {
    yield first;
    yield* rest;
  }

  @override
  Encoding get encoding => _inner.encoding;
  @override
  set encoding(Encoding value) => _inner.encoding = value;
  @override
  void add(List<int> data) => _inner.add(data);
  @override
  void addError(Object error, [StackTrace? stackTrace]) => _inner.addError(error, stackTrace);
  @override
  Future<void> addStream(Stream<List<int>> stream) => _inner.addStream(stream);
  @override
  Future<void> close() => _inner.close();
  @override
  void destroy() => _inner.destroy();
  @override
  Future<void> get done => _inner.done;
  @override
  Future<void> flush() => _inner.flush();
  @override
  void write(Object? object) => _inner.write(object);
  @override
  void writeAll(Iterable<Object?> objects, [String separator = '']) => _inner.writeAll(objects, separator);
  @override
  void writeCharCode(int charCode) => _inner.writeCharCode(charCode);
  @override
  void writeln([Object? object = '']) => _inner.writeln(object);
  @override
  InternetAddress get address => _inner.address;
  @override
  InternetAddress get remoteAddress => _inner.remoteAddress;
  @override
  int get port => _inner.port;
  @override
  int get remotePort => _inner.remotePort;
  @override
  bool setOption(SocketOption option, bool enabled) => _inner.setOption(option, enabled);
  @override
  Uint8List getRawOption(RawSocketOption option) => _inner.getRawOption(option);
  @override
  void setRawOption(RawSocketOption option) => _inner.setRawOption(option);
}
