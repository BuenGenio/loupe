/// The whole stack on a JMAP account: the live repository (sync engine,
/// offline queue, outbox, snooze, documents, server rules) with the
/// composite factory, against a local Stalwart.
@Tags(['integration'])
library;

import 'dart:async';

import 'package:mail_imap/mail_imap.dart';
import 'package:mail_jmap/mail_jmap.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';
import 'package:mail_store/mail_store.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:test/test.dart';

import 'stalwart_env.dart';

final class _Credentials implements CredentialStore {
  final values = <String, Credentials>{};

  @override
  Future<Credentials?> read(String accountId) async => values[accountId];

  @override
  Future<void> write(String accountId, Credentials credentials) async => values[accountId] = credentials;

  @override
  Future<void> delete(String accountId) async => values.remove(accountId);
}

/// Polls [probe] until it returns a value (or [timeout]).
Future<T> eventually<T>(Future<T?> Function() probe, {Duration timeout = const Duration(seconds: 30)}) async {
  final end = DateTime.now().add(timeout);
  while (true) {
    final v = await probe();
    if (v != null) return v;
    if (DateTime.now().isAfter(end)) throw TimeoutException('Condition not met', timeout);
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }
}

void main() {
  late StalwartServer server;
  late StalwartHttpClient http;
  late StalwartUser alice;
  late StalwartUser bob;
  late MailStore store;
  late LiveMailRepository repo;
  late MailAccount account;
  final errors = <MailException>[];

  setUpAll(() async {
    final binary = stalwartBinary();
    if (binary == null) return;
    server = await StalwartServer.start(binary: binary);
    http = StalwartHttpClient(server);
    alice = server.users[0];
    bob = server.users[1];
    await server.importMessages(
      alice,
      [for (var i = 1; i <= 3; i++) testMessage(subject: 'Welcome $i')],
      receivedAt: [for (var i = 1; i <= 3; i++) DateTime.now().subtract(Duration(hours: 4 - i))],
    );
    store = MailStore.memory();
    repo = LiveMailRepository(
      store,
      CompositeTransportFactory.of(ImapTransportFactory(composer: MimeMessageComposer()), httpClient: http),
      _Credentials(),
      // Sieve over JMAP; ManageSieve stays the fallback.
      sieve: JmapSieveConnector(
        fallback: ManageSieveConnector(port: server.ports['sieve']!),
        httpClient: http,
      ),
    );
    repo.errors.listen(errors.add);
    await repo.start();
    account = await repo.addAccount(
      AccountSetup(
        email: alice.email,
        displayName: 'Stalwart',
        provider: ProviderKind.generic,
        incoming: ServerConfig(
          protocol: ServerProtocol.jmap,
          host: '127.0.0.1',
          port: server.httpPort,
          security: ConnectionSecurity.none,
        ),
        credentials: PasswordCredentials(alice.password),
        senderName: 'Alice',
      ),
    );
  });

  tearDownAll(() async {
    if (stalwartBinary() == null) return;
    await repo.dispose();
    await store.close();
    http.close();
    await server.stop();
  });

  Future<Mailbox> mailbox(MailboxRole role) async => (await store.mailboxByRole(account.id, role))!;

  Future<List<EmailSummary>> listOf(Mailbox m) async => [
    for (final t in await store.watchList(RealMailboxRef(m.id), threaded: false).first) t.latest,
  ];

  Future<EmailSummary?> find(Mailbox m, String subject) async =>
      (await listOf(m)).where((e) => e.subject == subject).firstOrNull;

  /// The JMAP email with [subject] as [user] sees it on the server.
  Future<Map<String, Object?>?> onServer(StalwartUser user, String subject) async {
    final accountId = await server.accountId(user);
    final r = await server.jmap(user, [
      [
        'Email/query',
        {
          'accountId': accountId,
          'filter': {'subject': subject},
        },
        'q',
      ],
      [
        'Email/get',
        {
          'accountId': accountId,
          '#ids': {'resultOf': 'q', 'name': 'Email/query', 'path': '/ids'},
          'properties': ['mailboxIds', 'keywords', 'subject'],
        },
        'g',
      ],
    ]);
    final list = ((r[1]! as List)[1] as Map)['list'] as List;
    return list.isEmpty ? null : (list.first as Map).cast();
  }

  Future<Map<String, String>> roles(StalwartUser user) async {
    final accountId = await server.accountId(user);
    final r = await server.jmap(user, [
      [
        'Mailbox/get',
        {
          'accountId': accountId,
          'properties': ['role', 'name'],
        },
        'm',
      ],
    ]);
    return {
      for (final m in ((r.first! as List)[1] as Map)['list'] as List)
        ((m as Map)['role'] as String?) ?? m['name'] as String: m['id'] as String,
    };
  }

  group('a JMAP account in the live repository', () {
    test('adds the account and syncs the Inbox', () async {
      expect(account.incoming.protocol, ServerProtocol.jmap);
      final inbox = await mailbox(MailboxRole.inbox);
      final list = await eventually(() async {
        final l = await listOf(inbox);
        return l.length >= 3 ? l : null;
      });
      expect([for (final e in list) e.subject], ['Welcome 3', 'Welcome 2', 'Welcome 1']);
      expect(inbox.path, 'Inbox');
    });

    test('flags and moves reach the server and come back as the new copies', () async {
      final inbox = await mailbox(MailboxRole.inbox);
      final first = (await eventually(() => find(inbox, 'Welcome 1')));
      await repo.setKeywords([first.id], add: {Keywords.seen, Keywords.flagged});
      await eventually(() async {
        final e = await onServer(alice, 'Welcome 1');
        final k = e?['keywords'] as Map?;
        return k != null && k[r'$seen'] == true && k[r'$flagged'] == true ? true : null;
      });
      final junk = await mailbox(MailboxRole.junk);
      await repo.move([first.id], junk.id);
      final ids = await roles(alice);
      await eventually(() async {
        final e = await onServer(alice, 'Welcome 1');
        return (e?['mailboxIds'] as Map?)?.keys.toList().join() == ids['junk'] ? true : null;
      });
      await repo.refresh();
      final moved = await eventually(() => find(junk, 'Welcome 1'));
      expect(MailIds.parseJmapEmail(moved.id)!.path, junk.path);
      expect(moved.isFlagged, isTrue);
      expect(await find(inbox, 'Welcome 1'), isNull);
    });

    test('another client’s changes arrive through push and sync', () async {
      final inbox = await mailbox(MailboxRole.inbox);
      await server.deliverSmtp('erin@example.org', [alice.email], testMessage(subject: 'Pushed to the app'));
      // The Inbox watch (EventSource) syncs without a refresh.
      final arrived = await eventually(() => find(inbox, 'Pushed to the app'));
      expect(arrived.isSeen, isFalse);
    });

    test('sends to the other user with one copy in Sent', () async {
      await repo.send(
        OutgoingMessage(
          accountId: account.id,
          identityId: account.defaultIdentity.id,
          to: [EmailAddress(bob.email, 'Bob')],
          subject: 'From the live repository',
          text: 'Through EmailSubmission.',
        ),
        undoDelay: Duration.zero,
      );
      await eventually(() => onServer(bob, 'From the live repository'));
      final sent = await mailbox(MailboxRole.sent);
      await repo.refresh();
      final copies = await eventually(() async {
        final l = [
          for (final e in await listOf(sent))
            if (e.subject == 'From the live repository') e,
        ];
        return l.isEmpty ? null : l;
      });
      // Settle any queued append, then check there is still one.
      await Future<void>.delayed(const Duration(seconds: 2));
      await repo.refresh();
      expect([
        for (final e in await listOf(sent))
          if (e.subject == 'From the live repository') e,
      ], hasLength(1));
      expect(copies.single.isSeen, isTrue);
      expect(copies.single.isDraft, isFalse);
      expect(await store.outboxEntries(), isEmpty);
    });

    test('saves drafts on the server', () async {
      final id = await repo.saveDraft(
        OutgoingMessage(
          accountId: account.id,
          identityId: account.defaultIdentity.id,
          to: [EmailAddress(bob.email)],
          subject: 'Unfinished thought',
        ),
      );
      expect(id, isNotEmpty);
      final draft = await eventually(() => onServer(alice, 'Unfinished thought'));
      expect((draft['keywords'] as Map)[r'$draft'], isTrue);
    });

    test('wakes a message another client snoozed once its time is over', () async {
      final t = JmapTransport(stalwartAccount(server, alice, id: 'other'), credentialsOf(alice), httpClient: http);
      await t.connect();
      await t.createMailbox(Snooze.folderName);
      final ids = await roles(alice);
      final past = Snooze.keyword(DateTime.now().subtract(const Duration(minutes: 5)));
      await server.importMessages(alice, [testMessage(subject: 'Snoozed elsewhere')], keywords: {Keywords.seen, past});
      final email = await onServer(alice, 'Snoozed elsewhere');
      expect(email, isNotNull);
      final accountId = await server.accountId(alice);
      final found = await server.jmap(alice, [
        [
          'Email/query',
          {
            'accountId': accountId,
            'filter': {'subject': 'Snoozed elsewhere'},
          },
          'q',
        ],
      ]);
      final jmapId = ((((found.first! as List)[1] as Map)['ids'] as List).single) as String;
      await server.jmap(alice, [
        [
          'Email/set',
          {
            'accountId': accountId,
            'update': {
              jmapId: {
                'mailboxIds': {ids[Snooze.folderName]: true},
              },
            },
          },
          's',
        ],
      ]);
      await t.disconnect();
      await repo.refresh();
      await eventually(() async {
        final e = await onServer(alice, 'Snoozed elsewhere');
        final k = e?['keywords'] as Map? ?? const {};
        return (e?['mailboxIds'] as Map?)?.containsKey(ids['inbox']) == true &&
                k[r'$seen'] != true &&
                k[r'$new'] == true &&
                !k.keys.any((key) => (key as String).startsWith(r'$snoozed-'))
            ? true
            : null;
      });
    });

    test('keeps Smart Mailboxes in the documents mailbox', () async {
      final where = await repo.writeServerDocument(account.id, ServerDocuments.smartMailboxes, '{"mailboxes":[]}');
      expect(where, ServerStorage.folder);
      final docs = await repo.readServerDocuments(account.id, ServerDocuments.smartMailboxes);
      expect(docs.single.content, '{"mailboxes":[]}');
    });

    test('server rules go to the server over JMAP and file mail as it arrives', () async {
      final t = JmapTransport(stalwartAccount(server, alice, id: 'other'), credentialsOf(alice), httpClient: http);
      await t.connect();
      await t.createMailbox('Invoices');
      await t.disconnect();
      await repo.refresh();
      final invoices = (await store.getMailboxes(accountId: account.id)).firstWhere((m) => m.path == 'Invoices');
      await repo.rules.saveRule(
        Rule(
          id: 'invoices',
          name: 'Invoices',
          condition: 'subject:invoice',
          actions: [MoveToMailboxAction(invoices.id)],
          location: RuleLocation.server,
          accountIds: {account.id},
        ),
      );
      final status = await repo.rules.serverStatus(account.id, refresh: true);
      expect(status.state, ServerRulesState.active);
      await server.deliverSmtp('shop@example.org', [alice.email], testMessage(subject: 'Your invoice 42'));
      final ids = await roles(alice);
      await eventually(() async {
        final e = await onServer(alice, 'Your invoice 42');
        return (e?['mailboxIds'] as Map?)?.containsKey(ids['Invoices']) == true ? true : null;
      });
    });

    test('server rules use ManageSieve on the JMAP host', () async {
      final connector = ManageSieveConnector(port: server.ports['sieve']!);
      Future<Credentials> credentials({bool forceRefresh = false}) async => PasswordCredentials(alice.password);
      // Stalwart offers STARTTLS with its self-signed certificate: trusted
      // the way the app does it, by its fingerprint.
      final untrusted = await connector.connect(account, credentials).then<MailException?>((s) async {
        await s.logout();
        return null;
      }, onError: (Object e) => e as MailException);
      var trusted = account;
      if (untrusted != null) {
        expect(untrusted.kind, MailErrorKind.certificate);
        trusted = account.copyWith(
          incoming: ServerConfig(
            protocol: account.incoming.protocol,
            host: account.incoming.host,
            port: account.incoming.port,
            security: account.incoming.security,
            trustedCertificateSha256: untrustedFingerprintOf(untrusted),
          ),
        );
      }
      final session = await connector.connect(trusted, credentials);
      await session.putScript(
        'loupe-test',
        'require "fileinto";\nif header :contains "subject" "x" { fileinto "Junk Mail"; }\n',
      );
      expect([for (final s in await session.listScripts()) s.name], contains('loupe-test'));
      await session.logout();
    });

    test('reported no errors', () {
      expect(errors, isEmpty);
    });
  }, skip: stalwartSkip);
}
