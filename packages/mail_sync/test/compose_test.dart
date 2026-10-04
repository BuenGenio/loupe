import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

OutgoingMessage outgoing(
  MailAccount a, {
  String subject = 'Hi',
  ComposeMode mode = ComposeMode.newMessage,
  String? sourceEmailId,
  String? draftId,
}) => OutgoingMessage(
  accountId: a.id,
  identityId: a.defaultIdentity.id,
  to: const [EmailAddress('bob@example.org', 'Bob')],
  bcc: const [EmailAddress('secret@example.org')],
  subject: subject,
  text: 'Hello Bob',
  mode: mode,
  sourceEmailId: sourceEmailId,
  draftId: draftId,
);

void main() {
  group('send', () {
    test('waits for the undo delay; cancelSend returns the message', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        final id = await h.repo.send(outgoing(a), undoDelay: const Duration(seconds: 10));
        expect((await h.repo.watchOutbox().first).single.id, id);
        await settle(const Duration(seconds: 5));
        expect(server.sent, isEmpty);
        final back = await h.repo.cancelSend(id);
        expect(back!.subject, 'Hi');
        await settle(const Duration(seconds: 20));
        expect(server.sent, isEmpty);
        expect(await h.repo.cancelSend(id), isNull);
        await h.dispose();
      });
    });

    test('sends, files a seen copy in Sent and marks the source answered', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer()..deliver('INBOX', subject: 'Question', from: 'bob@example.org');
        final a = await h.add(server);
        final source = await h.email(a, 'INBOX', 'Question');
        await h.repo.send(
          outgoing(a, subject: 'Re: Question', mode: ComposeMode.reply, sourceEmailId: source.id),
          undoDelay: const Duration(seconds: 10),
        );
        await settle(const Duration(seconds: 12));
        final mail = server.sent.single;
        expect(mail.envelopeFrom, 'me@example.com');
        expect(mail.recipients, ['bob@example.org', 'secret@example.org']);
        expect(mail.json['messageId'], endsWith('@example.com'));
        expect(mail.json.containsKey('bcc'), isFalse);
        expect(await h.store.outboxEntries(), isEmpty);
        expect(server.find('Sent', 'Re: Question')!.keywords, {Keywords.seen});
        expect(server.find('INBOX', 'Question')!.keywords, {Keywords.answered});
        expect(await h.subjects(a, 'Sent'), ['Re: Question']);
        expect((await h.repo.suggestAddresses('secret')).single.email, 'secret@example.org');
        await h.dispose();
      });
    });

    test('Gmail keeps its own sent copy', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer(gmail: true);
        final a = await h.add(server, email: 'me@gmail.com', provider: ProviderKind.gmail);
        await h.repo.send(outgoing(a), undoDelay: Duration.zero);
        await settle();
        expect(server.sent, hasLength(1));
        expect(server.log.where((l) => l.startsWith('append')), isEmpty);
        await h.dispose();
      });
    });

    test('failures stay in the outbox with an error and are retried', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        server.smtpFailure = const MailException(MailErrorKind.connection, 'SMTP server unreachable');
        await h.repo.send(outgoing(a), undoDelay: const Duration(seconds: 1));
        await settle();
        final entry = (await h.store.outboxEntries()).single;
        expect(entry.status, OutboxStatus.failed);
        expect(entry.lastError, 'SMTP server unreachable');
        expect(h.errors.single.message, contains('stays in the Outbox'));
        server.smtpFailure = null;
        await settle(const Duration(seconds: 31));
        expect(server.sent, hasLength(1));
        expect(await h.store.outboxEntries(), isEmpty);
        await h.dispose();
      });
    });

    test('overdue messages go out when the repository starts', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        await h.repo.send(outgoing(a), undoDelay: const Duration(minutes: 1));
        await h.repo.dispose();
        await settle(const Duration(minutes: 2));
        expect(server.sent, isEmpty);
        final repo2 = LiveMailRepository(h.store, h.factory, h.credentials, config: fastConfig);
        await repo2.start();
        await settle();
        expect(server.sent, hasLength(1));
        await repo2.dispose();
        await h.store.close();
      });
    });
  });

  group('drafts', () {
    test('saveDraft appends to Drafts and replaces the previous draft', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        final first = await h.repo.saveDraft(outgoing(a, subject: 'Draft 1'));
        expect(server.find('Drafts', 'Draft 1')!.keywords, {Keywords.draft, Keywords.seen});
        expect((await h.repo.getEmail(first))!.mailboxId, h.mailbox(a, 'Drafts'));
        final second = await h.repo.saveDraft(outgoing(a, subject: 'Draft 2', draftId: first));
        await settle();
        expect(server.subjects('Drafts'), ['Draft 2']);
        expect(await h.subjects(a, 'Drafts'), ['Draft 2']);
        await h.repo.deleteDraft(second);
        await settle();
        expect(server.subjects('Drafts'), isEmpty);
        expect(await h.subjects(a, 'Drafts'), isEmpty);
        await h.dispose();
      });
    });

    test('offline drafts are kept locally and uploaded later', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        server.offline = true;
        await server.dropConnections();
        final local = await h.repo.saveDraft(outgoing(a, subject: 'On the train'));
        expect(await h.subjects(a, 'Drafts'), ['On the train']);
        expect((await h.repo.loadContent(local)).text, 'Hello Bob');
        // Replacing an unsent local draft cancels its upload.
        final local2 = await h.repo.saveDraft(outgoing(a, subject: 'On the train, v2', draftId: local));
        expect(await h.subjects(a, 'Drafts'), ['On the train, v2']);
        server.offline = false;
        await settle(const Duration(minutes: 1));
        expect(server.subjects('Drafts'), ['On the train, v2']);
        expect(await h.subjects(a, 'Drafts'), ['On the train, v2']);
        final resolved = (await h.repo.getEmail(local2))!;
        expect(MailIds.parseImapEmail(resolved.id), isNotNull);
        await h.dispose();
      });
    });

    test('sending a draft deletes it', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        final draft = await h.repo.saveDraft(outgoing(a, subject: 'Almost'));
        await h.repo.send(
          outgoing(a, subject: 'Almost', draftId: draft),
          undoDelay: Duration.zero,
        );
        await settle();
        expect(server.sent, hasLength(1));
        expect(server.subjects('Drafts'), isEmpty);
        expect(server.subjects('Sent'), ['Almost']);
        await h.dispose();
      });
    });

    test('saveDraft without a Drafts folder fails clearly', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        server.mailboxes.remove('Drafts');
        final a = await h.add(server);
        await expectLater(
          h.repo.saveDraft(outgoing(a)),
          throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.notFound)),
        );
        await h.dispose();
      });
    });
  });
}
