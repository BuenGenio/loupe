import 'package:clock/clock.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

void main() {
  group('accounts', () {
    test('addAccount connects, persists, and syncs priority mailboxes first', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer()
          ..deliver('INBOX', subject: 'Welcome')
          ..deliver('Sent', subject: 'Sent one', from: 'me@example.com')
          ..deliver('Work', subject: 'Later');
        final account = await h.add(server);

        expect(account.identities.single.name, 'Me');
        expect(account.identities.single.email, 'me@example.com');
        expect((await h.repo.watchAccounts().first).single.id, account.id);
        expect(h.credentials.values[account.id], isA<PasswordCredentials>());
        final boxes = await h.repo.watchMailboxes(accountId: account.id).first;
        expect(boxes.first.role, MailboxRole.inbox);
        expect(await h.subjects(account, 'INBOX'), ['Welcome']);
        expect(await h.subjects(account, 'Sent'), ['Sent one']);
        // Other mailboxes sync lazily, when opened.
        expect(await h.subjects(account, 'Work'), isEmpty);
        final syncs = server.log.where((l) => l.startsWith('sync:')).toList();
        expect(syncs.take(4), ['sync:INBOX', 'sync:Sent', 'sync:Drafts', 'sync:Archive']);
        expect(syncs, isNot(contains('sync:Work')));

        // Later periodic syncs fill in never-opened mailboxes.
        await settle(fastConfig.pollInterval);
        expect(await h.subjects(account, 'Work'), ['Later']);
        expect(server.log, isNot(contains('sync:Trash')));

        server.deliver('Work', subject: 'Newer');
        final work = h.repo.watchList(RealMailboxRef(h.mailbox(account, 'Work')));
        await settle();
        await h.repo.refresh(ref: RealMailboxRef(h.mailbox(account, 'Work')));
        expect([for (final t in await work.first) t.latest.subject], ['Newer', 'Later']);

        final status = await h.status(account);
        expect(status.phase, SyncPhase.idle);
        expect(status.lastSuccess, isNotNull);
        await h.dispose();
      });
    });

    test('addAccount rethrows the transport error and stores nothing', () {
      fakeTime((async) async {
        final h = Harness();
        h.factory.serve('me@example.com', FakeServer(password: 'right'));
        await expectLater(
          h.repo.addAccount(h.setup('me@example.com', password: 'wrong')),
          throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.authentication)),
        );
        expect(await h.repo.watchAccounts().first, isEmpty);
        expect(h.credentials.values, isEmpty);
        expect(h.factory.created.single.isConnected, isFalse);
        await h.dispose();
      });
    });

    test('discover, updateAccount and removeAccount', () {
      fakeTime((async) async {
        final h = Harness();
        expect((await h.repo.discover('x@mail.test')).incoming!.host, 'imap.mail.test');
        final server = FakeServer()..deliver('INBOX', subject: 'Hi');
        final a = await h.add(server);
        await h.repo.updateAccount(a.copyWith(displayName: 'Renamed'));
        expect((await h.repo.watchAccounts().first).single.displayName, 'Renamed');
        await h.repo.removeAccount(a.id);
        expect(await h.repo.watchAccounts().first, isEmpty);
        expect(await h.repo.watchMailboxes().first, isEmpty);
        expect(h.credentials.values, isEmpty);
        expect(await h.repo.watchSyncStatus().first, isEmpty);
        await h.dispose();
      });
    });

    test('start() resumes stored accounts with stored credentials', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer()..deliver('INBOX', subject: 'One');
        final a = await h.add(server);
        await h.repo.dispose();
        server.deliver('INBOX', subject: 'Two');
        final repo2 = LiveMailRepository(h.store, h.factory, h.credentials, config: fastConfig);
        await repo2.start();
        await settle();
        expect(await h.subjects(a, 'INBOX'), ['Two', 'One']);
        await repo2.dispose();
        await h.store.close();
      });
    });
  });

  test('OAuth tokens are refreshed through the injected refresher and persisted', () {
    fakeTime((async) async {
      var refreshes = 0;
      final h = Harness(
        refreshOAuth: (account, current) async => OAuthCredentials(
          accessToken: 'fresh${++refreshes}',
          refreshToken: current.refreshToken,
          expiresAt: clock.now().add(const Duration(hours: 1)),
        ),
      );
      final server = FakeServer()..deliver('INBOX', subject: 'Hi');
      h.factory.serve('me@gmail.com', server);
      final expired = OAuthCredentials(accessToken: 'old', refreshToken: 'r', expiresAt: DateTime(2026, 9, 1, 11));
      final a = await h.repo.addAccount(h.setup('me@gmail.com', provider: ProviderKind.gmail, credentials: expired));
      await settle();
      expect(a.authKind, AuthKind.oauth2);
      expect(refreshes, 1);
      expect((h.credentials.values[a.id]! as OAuthCredentials).accessToken, 'fresh1');

      await settle(const Duration(hours: 2));
      await server.dropConnections();
      await h.repo.refresh();
      expect(refreshes, 2);
      expect((h.credentials.values[a.id]! as OAuthCredentials).accessToken, 'fresh2');
      await h.dispose();
    });
  });

  group('sync', () {
    test('incremental sync: new messages, flag changes, expunges', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer()
          ..deliver('INBOX', subject: 'A')
          ..deliver('INBOX', subject: 'B');
        final a = await h.add(server);
        server
          ..deliver('INBOX', subject: 'C')
          ..setFlags('INBOX', 1, {Keywords.seen, Keywords.flagged})
          ..expunge('INBOX', 2);
        await h.repo.refresh();
        expect(await h.subjects(a, 'INBOX'), ['C', 'A']);
        expect((await h.email(a, 'INBOX', 'A')).keywords, {Keywords.seen, Keywords.flagged});
        final inbox = (await h.repo.watchMailboxes(accountId: a.id).first).first;
        expect((inbox.totalCount, inbox.unreadCount), (2, 1));
        await h.dispose();
      });
    });

    test('UIDVALIDITY change resets the mailbox', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer()
          ..deliver('INBOX', subject: 'A')
          ..deliver('INBOX', subject: 'B');
        final a = await h.add(server);
        final before = (await h.email(a, 'INBOX', 'A')).id;
        server.resetUidValidity('INBOX');
        await h.repo.refresh(ref: RealMailboxRef(h.mailbox(a, 'INBOX')));
        expect(await h.subjects(a, 'INBOX'), ['B', 'A']);
        final after = (await h.email(a, 'INBOX', 'A')).id;
        expect(after, isNot(before));
        expect(MailIds.parseImapEmail(after)!.uidValidity, 2);
        await h.dispose();
      });
    });

    test('IDLE triggers an Inbox sync; polling covers the rest', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        expect(h.factory.created, hasLength(2), reason: 'main and IDLE connections');
        server.deliver('INBOX', subject: 'Pushed');
        await settle();
        expect(await h.subjects(a, 'INBOX'), ['Pushed']);

        server.deliver('Sent', subject: 'Polled');
        await settle();
        expect(await h.subjects(a, 'Sent'), isEmpty);
        await settle(fastConfig.pollInterval);
        expect(await h.subjects(a, 'Sent'), ['Polled']);
        await h.dispose();
      });
    });

    test('reconnects with backoff and reports offline status', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        server.offline = true;
        await server.dropConnections();
        await h.repo.refresh();
        final status = await h.status(a);
        expect(status.phase, SyncPhase.offline);
        expect(status.error, 'Server unreachable');

        server
          ..offline = false
          ..deliver('INBOX', subject: 'Back');
        await settle(const Duration(seconds: 30));
        expect((await h.status(a)).phase, SyncPhase.idle);
        expect(await h.subjects(a, 'INBOX'), ['Back']);
        await h.dispose();
      });
    });

    test('authentication failures are reported without fast retries', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        server.password = 'changed';
        await server.dropConnections();
        await h.repo.refresh();
        expect((await h.status(a)).error, 'Password rejected');
        final connects = server.connects;
        await settle(const Duration(minutes: 1));
        expect(server.connects, connects);
        await h.dispose();
      });
    });

    test('pause stops polling and IDLE; resume syncs at once', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        await h.repo.pause();
        expect(server.transports.where((t) => t.isConnected), isEmpty);
        server.deliver('INBOX', subject: 'While paused');
        await settle(const Duration(minutes: 20));
        expect(await h.subjects(a, 'INBOX'), isEmpty);
        await h.repo.resume();
        await settle();
        expect(await h.subjects(a, 'INBOX'), ['While paused']);
        await h.repo.pause();
        server.deliver('INBOX', subject: 'Background');
        await h.repo.syncOnce();
        expect(await h.subjects(a, 'INBOX'), ['Background', 'While paused']);
        expect(server.transports.where((t) => t.isConnected), isEmpty);
        await h.dispose();
      });
    });

    test('loadOlder pages back until the start of the mailbox', () {
      fakeTime((async) async {
        final h = Harness(
          config: const SyncConfig(initialWindow: 5, olderPageSize: 4, pollInterval: Duration(minutes: 5)),
        );
        final server = FakeServer();
        for (var i = 1; i <= 12; i++) {
          server.deliver('INBOX', subject: 'M$i');
        }
        final a = await h.add(server);
        final ref = RealMailboxRef(h.mailbox(a, 'INBOX'));
        expect(await h.subjects(a, 'INBOX'), hasLength(5));
        expect(await h.repo.loadOlder(ref), isTrue);
        expect(await h.subjects(a, 'INBOX'), hasLength(9));
        expect(await h.repo.loadOlder(ref), isFalse);
        expect((await h.subjects(a, 'INBOX')).last, 'M1');
        expect(await h.repo.loadOlder(ref), isFalse);
        expect(await h.repo.loadOlder(const VirtualMailboxRef(VirtualMailbox.allInboxes)), isFalse);
        await h.dispose();
      });
    });

    test('loadContent caches; attachments and raw source come from the server', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer()..deliver('INBOX', subject: 'Body', text: 'The body text');
        final a = await h.add(server);
        final e = await h.email(a, 'INBOX', 'Body');
        expect((await h.repo.loadContent(e.id)).text, 'The body text');
        expect((await h.repo.loadContent(e.id)).text, 'The body text');
        expect(server.log.where((l) => l == 'content'), hasLength(1));
        expect(String.fromCharCodes(await h.repo.loadAttachment(e.id, '2')), 'part 2');
        expect(String.fromCharCodes(await h.repo.loadRawSource(e.id)), startsWith('Subject: Body'));
        await expectLater(h.repo.loadContent('nope|x|1|1'), throwsA(isA<MailException>()));
        await h.dispose();
      });
    });

    test('address book learns from synced and sent mail', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer()..deliver('INBOX', subject: 'Hi', from: 'zoe@example.org', fromName: 'Zoe Q');
        await h.add(server);
        expect((await h.repo.suggestAddresses('zo')).single.name, 'Zoe Q');
        expect((await h.repo.suggestAddresses('q')).single.email, 'zoe@example.org');
        await h.dispose();
      });
    });
  });
}
