import 'package:clock/clock.dart';
import 'package:drift/drift.dart' show QueryExecutor, QueryInterceptor, ApplyInterceptor;
import 'package:drift/native.dart';
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

/// Room for scheduled sends a day ahead.
const _days = Duration(days: 2);
const _step = Duration(seconds: 1);

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

    test('an unsaved alias identity sends as its address, also from a scheduled send', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        final alias = a.aliasIdentity('shop-xyz@example.com');
        final message = OutgoingMessage(
          accountId: a.id,
          identityId: alias.id,
          to: const [EmailAddress('bob@example.org')],
          subject: 'Order',
        );
        final draft = await h.repo.saveDraft(message);
        expect((await h.repo.getEmail(draft))!.from.single.email, 'shop-xyz@example.com');
        // fakeTime starts at 12:00.
        await h.repo.send(message.copyWith(draftId: draft), sendAt: DateTime(2026, 9, 1, 13));
        await settle(const Duration(hours: 2));
        final mail = server.sent.single;
        expect(mail.envelopeFrom, 'shop-xyz@example.com');
        expect(mail.json['from'], 'shop-xyz@example.com');
        await h.dispose();
      }, step: _step);
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

  group('sending once', () {
    test('a message being sent by background work is not sent again when the app starts', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer()..smtpLatency = const Duration(seconds: 30);
        final a = await h.add(server);
        await h.repo.send(outgoing(a), undoDelay: const Duration(seconds: 1));
        await settle(const Duration(seconds: 5));
        expect((await h.store.outboxEntries()).single.status, OutboxStatus.sending);

        // The app opens the same database while the send is under way.
        final app = LiveMailRepository(h.store, h.factory, h.credentials, config: fastConfig);
        await app.start();
        await settle(const Duration(minutes: 2));
        expect(server.sent, hasLength(1));
        expect(await h.store.outboxEntries(), isEmpty);
        await app.dispose();
        await h.dispose();
      });
    });

    test('a send left claimed by a process that died goes out once the claim is stale', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        await h.store.putOutbox(
          OutboxEntry(
            id: 'stuck',
            accountId: a.id,
            message: outgoing(a),
            sendAfter: clock.now(),
            createdAt: clock.now(),
            status: OutboxStatus.sending,
          ),
        );
        await h.repo.sendNow('stuck').catchError((_) {});
        await settle(const Duration(minutes: 5));
        expect(server.sent, isEmpty, reason: 'may still be sending elsewhere');
        await settle(fastConfig.sendClaimTimeout);
        expect(server.sent, hasLength(1));
        expect(await h.store.outboxEntries(), isEmpty);
        await h.dispose();
      });
    });

    test('a failure after the server took the message does not send it again', () {
      fakeTime((async) async {
        // The outbox row can't be deleted once (a busy or failing database).
        var failDelete = true;
        final executor = NativeDatabase.memory(setup: (db) => db.execute('PRAGMA foreign_keys = ON')).interceptWith(
          _FailOnce((sql) {
            if (!failDelete || !sql.startsWith('DELETE FROM "outbox_items"')) return false;
            failDelete = false;
            return true;
          }),
        );
        final h = Harness(store: MailStore.forExecutor(executor));
        final server = FakeServer();
        final a = await h.add(server);
        await h.repo.send(outgoing(a), undoDelay: const Duration(seconds: 1));
        await settle(const Duration(minutes: 10));
        expect(failDelete, isFalse);
        expect(server.sent, hasLength(1));
        expect(await h.store.outboxEntries(), isEmpty);
        expect(h.errors.single.message, isNot(contains('stays in the Outbox')));
        await h.dispose();
      });
    });

    test('a scheduled send keeps its draft until the outbox holds it', () {
      fakeTime((async) async {
        var failInsert = false;
        final executor = NativeDatabase.memory(
          setup: (db) => db.execute('PRAGMA foreign_keys = ON'),
        ).interceptWith(_FailOnce((sql) => failInsert && sql.contains('"outbox_items"') && sql.startsWith('INSERT')));
        final h = Harness(store: MailStore.forExecutor(executor));
        final server = FakeServer();
        final a = await h.add(server);
        final draft = await h.repo.saveDraft(outgoing(a, subject: 'Later'));
        await settle();
        failInsert = true;
        await expectLater(
          h.repo.send(
            outgoing(a, subject: 'Later', draftId: draft),
            sendAt: clock.now().add(const Duration(hours: 1)),
          ),
          throwsA(anything),
        );
        failInsert = false;
        await settle();
        expect(await h.subjects(a, 'Drafts'), ['Later'], reason: 'the draft survives');
        expect(await h.store.outboxEntries(), isEmpty);
        await h.dispose();
      });
    });

    test('every attempt sends the same Message-ID', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer()..smtpLoseReply = true;
        final a = await h.add(server);
        await h.repo.send(outgoing(a), undoDelay: const Duration(seconds: 1));
        await settle(const Duration(minutes: 2));
        // The reply to the first attempt was lost, so it went out twice; the
        // copies can be recognised as one message.
        expect(server.sent, hasLength(2));
        expect(server.sent[1].json['messageId'], server.sent[0].json['messageId']);
        expect(await h.store.outboxEntries(), isEmpty);
        await h.dispose();
      });
    });
  });

  group('scheduled send', () {
    // fakeTime starts at 2026-09-01 12:00.
    final tomorrow8 = DateTime(2026, 9, 2, 8);

    test('waits until the chosen time, shows as scheduled and deletes the draft at once', () {
      fakeTime(
        (async) async {
          final h = Harness();
          final server = FakeServer();
          final a = await h.add(server);
          final draft = await h.repo.saveDraft(outgoing(a, subject: 'Later'));
          await settle();
          expect(server.subjects('Drafts'), ['Later']);
          final id = await h.repo.send(
            outgoing(a, subject: 'Later', draftId: draft),
            sendAt: tomorrow8,
          );
          final item = (await h.repo.watchOutbox().first).single;
          expect(item.id, id);
          expect(item.status, OutboxStatus.scheduled);
          expect(item.sendAt, tomorrow8);
          expect(item.message.draftId, isNull);
          await settle();
          expect(server.subjects('Drafts'), isEmpty);
          await settle(const Duration(hours: 19, minutes: 59));
          expect(server.sent, isEmpty);
          await settle(const Duration(minutes: 1));
          expect(server.sent.single.json['subject'], 'Later');
          expect(await h.repo.watchOutbox().first, isEmpty);
          expect(server.subjects('Sent'), ['Later']);
          await h.dispose();
        },
        limit: _days,
        step: _step,
      );
    });

    test('survives a restart and goes out at its time', () {
      fakeTime(
        (async) async {
          final h = Harness();
          final server = FakeServer();
          final a = await h.add(server);
          await h.repo.send(outgoing(a), sendAt: tomorrow8);
          await h.repo.dispose();
          final repo2 = LiveMailRepository(h.store, h.factory, h.credentials, config: fastConfig);
          await repo2.start();
          expect((await repo2.watchOutbox().first).single.status, OutboxStatus.scheduled);
          await settle(const Duration(hours: 19));
          expect(server.sent, isEmpty);
          await settle(const Duration(hours: 1));
          expect(server.sent, hasLength(1));
          await repo2.dispose();
          await h.store.close();
        },
        limit: _days,
        step: _step,
      );
    });

    test('syncOnce sends what is due without start', () {
      fakeTime(
        (async) async {
          final h = Harness();
          final server = FakeServer();
          final a = await h.add(server);
          await h.repo.send(outgoing(a), sendAt: DateTime(2026, 9, 1, 13));
          await h.repo.dispose();
          await settle(const Duration(minutes: 30));
          // Each background task gets a fresh repository that is disposed after it.
          final early = LiveMailRepository(h.store, h.factory, h.credentials, config: fastConfig);
          await early.syncOnce();
          await early.dispose();
          expect(server.sent, isEmpty, reason: 'not due yet');
          await settle(const Duration(minutes: 31));
          expect(server.sent, isEmpty);
          final due = LiveMailRepository(h.store, h.factory, h.credentials, config: fastConfig);
          await due.syncOnce();
          expect(server.sent, hasLength(1));
          expect(await h.store.outboxEntries(), isEmpty);
          await due.dispose();
          await h.store.close();
        },
        limit: _days,
        step: _step,
      );
    });

    test('sendNow sends a scheduled message at once; rescheduleSend moves it', () {
      fakeTime(
        (async) async {
          final h = Harness();
          final server = FakeServer();
          final a = await h.add(server);
          final first = await h.repo.send(outgoing(a, subject: 'One'), sendAt: tomorrow8);
          final second = await h.repo.send(outgoing(a, subject: 'Two'), sendAt: tomorrow8);
          await h.repo.sendNow(first);
          await settle();
          expect([for (final m in server.sent) m.json['subject']], ['One']);

          final evening = DateTime(2026, 9, 1, 18);
          await h.repo.rescheduleSend(second, evening);
          final item = (await h.repo.watchOutbox().first).single;
          expect((item.status, item.sendAt), (OutboxStatus.scheduled, evening));
          await settle(const Duration(hours: 5, minutes: 59));
          expect(server.sent, hasLength(1));
          await settle(const Duration(minutes: 2));
          expect([for (final m in server.sent) m.json['subject']], ['One', 'Two']);

          await expectLater(
            h.repo.sendNow(first),
            throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.notFound)),
          );
          await expectLater(h.repo.rescheduleSend(second, tomorrow8), throwsA(isA<MailException>()));
          await h.dispose();
        },
        limit: _days,
        step: _step,
      );
    });

    test('cancelSend takes a scheduled message back', () {
      fakeTime(
        (async) async {
          final h = Harness();
          final server = FakeServer();
          final a = await h.add(server);
          final id = await h.repo.send(outgoing(a, subject: 'Maybe'), sendAt: tomorrow8);
          final back = await h.repo.cancelSend(id);
          expect(back!.subject, 'Maybe');
          expect(await h.repo.watchOutbox().first, isEmpty);
          await settle(const Duration(days: 1));
          expect(server.sent, isEmpty);
          await h.dispose();
        },
        limit: _days,
        step: _step,
      );
    });

    test('a failed scheduled send shows its error, retries later, and Retry sends at once', () {
      fakeTime(
        (async) async {
          final h = Harness();
          final server = FakeServer();
          final a = await h.add(server);
          server.smtpFailure = const MailException(MailErrorKind.server, '554 Relay access denied');
          final id = await h.repo.send(outgoing(a), sendAt: DateTime(2026, 9, 1, 13));
          await settle(const Duration(hours: 1, seconds: 1));
          final failed = (await h.repo.watchOutbox().first).single;
          expect(failed.status, OutboxStatus.failed);
          expect(failed.error, '554 Relay access denied');
          expect(failed.sendAt.isAfter(DateTime(2026, 9, 1, 13)), isTrue, reason: 'retried after a backoff');
          server.smtpFailure = null;
          await h.repo.sendNow(id);
          await settle(const Duration(milliseconds: 500));
          expect(server.sent, hasLength(1));
          expect(await h.repo.watchOutbox().first, isEmpty);
          await h.dispose();
        },
        limit: _days,
        step: _step,
      );
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

/// Fails the statements [fails] picks.
final class _FailOnce extends QueryInterceptor {
  _FailOnce(this.fails);

  final bool Function(String sql) fails;

  @override
  Future<int> runDelete(QueryExecutor executor, String statement, List<Object?> args) {
    if (fails(statement)) throw StateError('database is locked');
    return executor.runDelete(statement, args);
  }

  @override
  Future<int> runInsert(QueryExecutor executor, String statement, List<Object?> args) {
    if (fails(statement)) throw StateError('database is locked');
    return executor.runInsert(statement, args);
  }
}
