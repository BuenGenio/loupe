import 'dart:async';
import 'dart:io';

import 'package:mail_imap/mail_imap.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

void main() {
  test('secureMailSocket reports a failed handshake as a connection error', () async {
    // A "server" that answers the TLS hello with plain text, then hangs up.
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((client) {
      client.listen((_) {
        client.write('NO not TLS\r\n');
        unawaited(client.close());
      }, onError: (Object _) {});
    });
    addTearDown(server.close);
    final plain = await openMailSocket(
      host: '127.0.0.1',
      port: server.port,
      security: ConnectionSecurity.none,
      protocol: WireProtocol.imap,
    );
    await expectLater(
      secureMailSocket(plain, host: '127.0.0.1', timeout: const Duration(seconds: 5)),
      throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.connection)),
    );
    plain.destroy();
  });
}
