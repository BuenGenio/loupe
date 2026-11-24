import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

/// Changing an account's servers, password and IDLE after setup.
void main() {
  const moved = ServerConfig(
    protocol: ServerProtocol.imap,
    host: 'mail.example.com',
    port: 143,
    security: ConnectionSecurity.startTls,
    username: 'me',
  );
  const smtp = ServerConfig(protocol: ServerProtocol.smtp, host: 'mail.example.com', port: 587);

  String? password(Harness h, MailAccount a) => (h.credentials.values[a.id] as PasswordCredentials?)?.password;
  int connected(FakeServer server) => server.transports.where((t) => t.isConnected).length;

  test('changeServers connects with the new settings first and keeps the old ones when that fails', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer();
      final a = await h.add(server);
      server.password = 'new';

      await expectLater(
        h.repo.changeServers(a.id, incoming: moved, outgoing: smtp, credentials: const PasswordCredentials('typo')),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.authentication)),
      );
      expect((await h.repo.watchAccounts().first).single.incoming.host, 'imap.example.com');
      expect(password(h, a), 'secret');

      final changed = await h.repo.changeServers(
        a.id,
        incoming: moved,
        outgoing: smtp,
        credentials: const PasswordCredentials('new'),
      );
      expect(changed.incoming.host, 'mail.example.com');
      expect(changed.outgoing!.port, 587);
      expect([for (final i in changed.identities) i.id], [for (final i in a.identities) i.id]);
      final stored = (await h.repo.watchAccounts().first).single;
      expect(stored.incoming.security, ConnectionSecurity.startTls);
      expect(stored.incoming.username, 'me');
      expect(password(h, a), 'new');
      // The account syncs over new connections, with the new settings.
      expect(h.factory.created.last.account.incoming.host, 'mail.example.com');
      server.deliver('INBOX', subject: 'After the move');
      await settle();
      expect(await h.subjects(a, 'INBOX'), ['After the move']);
      await h.dispose();
    });
  });

  test('without new credentials the stored ones are checked and kept', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer();
      final a = await h.add(server);
      await h.repo.changeServers(a.id, incoming: moved, outgoing: smtp);
      expect(password(h, a), 'secret');
      expect((await h.repo.watchAccounts().first).single.incoming.host, 'mail.example.com');

      // IMAP to JMAP is refused before anything connects.
      await expectLater(
        h.repo.changeServers(
          a.id,
          incoming: const ServerConfig(protocol: ServerProtocol.jmap, host: 'mail.example.com', port: 443),
        ),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.unsupported)),
      );
      await h.dispose();
    });
  });

  test('a new password brings an account the server refused back at once', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer();
      final a = await h.add(server);
      server.password = 'changed';
      await server.dropConnections();
      await h.repo.refresh();
      expect((await h.status(a)).error, 'Password rejected');

      server.deliver('INBOX', subject: 'Waiting');
      await h.repo.changeServers(
        a.id,
        incoming: a.incoming,
        outgoing: a.outgoing,
        credentials: const PasswordCredentials('changed'),
      );
      await settle();
      expect((await h.status(a)).phase, SyncPhase.idle);
      expect(await h.subjects(a, 'INBOX'), ['Waiting']);
      await h.dispose();
    });
  });

  test('IDLE can be switched off and on for an account', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer();
      final a = await h.add(server);
      expect(connected(server), 2, reason: 'main and IDLE connections');

      await h.repo.updateAccount(a.copyWith(useIdle: false));
      await settle();
      expect(connected(server), 1);
      server.deliver('INBOX', subject: 'Polled');
      await settle();
      expect(await h.subjects(a, 'INBOX'), isEmpty);
      await settle(fastConfig.pollInterval);
      expect(await h.subjects(a, 'INBOX'), ['Polled']);
      expect(connected(server), 1, reason: 'syncing does not start IDLE again');

      await h.repo.updateAccount(a.copyWith(useIdle: true));
      await settle();
      expect(connected(server), 2);
      server.deliver('INBOX', subject: 'Pushed');
      await settle();
      expect(await h.subjects(a, 'INBOX'), ['Pushed', 'Polled']);
      await h.dispose();
    });
  });

  test('resume takes up accounts changed meanwhile by another isolate', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer();
      final a = await h.add(server);
      await h.repo.start();
      await h.repo.pause();

      // The app changed the account while Instant Delivery's service was paused.
      await h.store.saveAccount(a.copyWith(incoming: moved, useIdle: false));
      await h.repo.resume();
      await settle();
      expect(h.factory.created.last.account.incoming.host, 'mail.example.com');
      expect(connected(server), 1, reason: 'IDLE is off now');

      await h.repo.pause();
      await h.store.deleteAccount(a.id);
      await h.repo.resume();
      await settle();
      expect(await h.repo.watchSyncStatus().first, isEmpty);
      expect(connected(server), 0);
      await h.dispose();
    });
  });
}
