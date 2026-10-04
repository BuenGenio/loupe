import 'package:mail_imap/mail_imap.dart';
import 'package:mail_imap/src/imap/mailbox_list.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/scripted_imap_server.dart';

MailAccount _account(int port) => MailAccount(
  id: 'acc',
  email: 'me@example.test',
  displayName: 'Test',
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: ServerConfig(
    protocol: ServerProtocol.imap,
    host: '127.0.0.1',
    port: port,
    security: ConnectionSecurity.none,
  ),
);

Matcher _failsWith(MailErrorKind kind) => throwsA(isA<MailException>().having((e) => e.kind, 'kind', kind));

void main() {
  test('subscription commands', () {
    expect(subscriptionCommand('"Lists/Dart"', subscribe: true), 'SUBSCRIBE "Lists/Dart"');
    expect(subscriptionCommand('INBOX', subscribe: false), 'UNSUBSCRIBE INBOX');
  });

  group('setSubscribed', () {
    late ScriptedImapServer server;
    late ImapTransport transport;

    setUp(() async {
      server = await ScriptedImapServer.start();
      transport = ImapTransport(
        _account(server.port),
        ({forceRefresh = false}) async => const PasswordCredentials('pw'),
      );
      await transport.connect();
    });

    tearDown(() async {
      await transport.disconnect();
      await server.close();
    });

    test('sends SUBSCRIBE and UNSUBSCRIBE with encoded, quoted names', () async {
      await transport.setSubscribed(const RemoteMailbox(path: 'Lists/Entwürfe', name: 'Entwürfe'), true);
      await transport.setSubscribed(const RemoteMailbox(path: 'Say "hi"', name: 'Say "hi"'), false);
      await transport.setSubscribed(const RemoteMailbox(path: 'INBOX', name: 'Inbox'), true);
      expect(server.commands, ['SUBSCRIBE "Lists/Entw&APw-rfe"', r'UNSUBSCRIBE "Say \"hi\""', 'SUBSCRIBE INBOX']);
    });

    test('a folder gone from the server', () async {
      server.reply = (command) => "NO [NONEXISTENT] Mailbox doesn't exist";
      const gone = RemoteMailbox(path: 'Old', name: 'Old');
      await expectLater(transport.setSubscribed(gone, true), _failsWith(MailErrorKind.notFound));
      // Nothing left to unsubscribe from: done.
      await transport.setSubscribed(gone, false);
    });

    test('other refusals are server errors', () async {
      server.reply = (command) => 'NO Permission denied';
      await expectLater(
        transport.setSubscribed(const RemoteMailbox(path: 'Shared', name: 'Shared'), true),
        _failsWith(MailErrorKind.server),
      );
    });
  });
}
