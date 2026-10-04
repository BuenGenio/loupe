import 'dart:async';

import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

const _subjectInvoice = TextTerm(TextField.subject, 'invoice');

SearchRequest request(SearchExpr expr, {bool server = true, SearchScope scope = const AllMailboxesScope()}) =>
    SearchRequest(expr: expr, scope: scope, includeServer: server);

/// Collects every emission until the stream closes.
Future<List<SearchResults>> collect(Stream<SearchResults> s) => s.toList();

void main() {
  test('local results first, then server hits merged, stored and marked', () {
    fakeTime((async) async {
      final h = Harness(config: const SyncConfig(initialWindow: 2));
      final server = FakeServer()
        ..deliver('INBOX', subject: 'Invoice 1 (old)')
        ..deliver('INBOX', subject: 'Lunch')
        ..deliver('INBOX', subject: 'Invoice 2')
        ..deliver('INBOX', subject: 'Invoice 3');
      final a = await h.add(server);
      expect(await h.subjects(a, 'INBOX'), ['Invoice 3', 'Invoice 2']);

      server.latency = const Duration(seconds: 1);
      final results = await collect(h.repo.search(request(_subjectInvoice)));
      final first = results.first;
      expect([for (final e in first.items) e.subject], ['Invoice 3', 'Invoice 2']);
      expect(first.pendingAccountIds, {a.id});
      expect(first.isComplete, isFalse);

      final last = results.last;
      expect(last.isComplete, isTrue);
      expect([for (final e in last.items) e.subject], ['Invoice 3', 'Invoice 2', 'Invoice 1 (old)']);
      final old = last.items.last;
      expect(last.fromServerIds, {old.id});
      expect(last.failedAccountIds, isEmpty);
      // Stored, so it opens like any other message.
      expect(await h.repo.getEmail(old.id), isNotNull);
      expect((await h.repo.loadContent(old.id)).emailId, old.id);
      await h.dispose();
    });
  });

  test('server supersets are post-filtered locally', () {
    fakeTime((async) async {
      final h = Harness(config: const SyncConfig(initialWindow: 1));
      final server = FakeServer()
        ..deliver('INBOX', subject: 'Invoice A')
        ..deliver('INBOX', subject: 'Holiday')
        ..deliver('INBOX', subject: 'Something else');
      final a = await h.add(server);
      // The server answers with every message (a widened query).
      server.onSearch = (expr, path) => [
        for (final m in server.box('INBOX').messages.values) MailIds.imapEmail(a.id, 'INBOX', 1, m.uid),
      ];
      final last = (await collect(h.repo.search(request(_subjectInvoice)))).last;
      expect([for (final e in last.items) e.subject], ['Invoice A']);
      await h.dispose();
    });
  });

  test('a failing account is reported while others answer', () {
    fakeTime((async) async {
      final h = Harness();
      final good = FakeServer()..deliver('INBOX', subject: 'Invoice good');
      final bad = FakeServer()..deliver('INBOX', subject: 'Invoice bad');
      final a = await h.add(good);
      final b = await h.add(bad, email: 'b@example.com');
      bad.failAlways['search'] = const MailException(MailErrorKind.server, 'Search not supported');
      final last = (await collect(h.repo.search(request(_subjectInvoice)))).last;
      expect(last.failedAccountIds, {b.id});
      expect(last.pendingAccountIds, isEmpty);
      expect({for (final e in last.items) e.accountId}, {a.id, b.id}, reason: 'local results stay');
      await h.dispose();
    });
  });

  test('local-only searches and mailbox scopes', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()
        ..deliver('INBOX', subject: 'Invoice inbox')
        ..deliver('Sent', subject: 'Invoice sent', from: 'me@example.com');
      final a = await h.add(server);
      final searches = server.log.where((l) => l == 'search').length;
      final local = await collect(h.repo.search(request(_subjectInvoice, server: false)));
      expect(local, hasLength(1));
      expect(local.single.isComplete, isTrue);
      expect(local.single.items, hasLength(2));
      expect(server.log.where((l) => l == 'search').length, searches);

      final scoped = await collect(
        h.repo.search(request(_subjectInvoice, scope: MailboxScope(RealMailboxRef(h.mailbox(a, 'Sent'))))),
      );
      expect([for (final e in scoped.last.items) e.subject], ['Invoice sent']);
      final inboxes = await collect(
        h.repo.search(
          request(_subjectInvoice, scope: const MailboxScope(VirtualMailboxRef(VirtualMailbox.allInboxes))),
        ),
      );
      expect([for (final e in inboxes.last.items) e.subject], ['Invoice inbox']);
      await h.dispose();
    });
  });

  test('cancelling drops the search connection; the next search works', () {
    fakeTime((async) async {
      final h = Harness(config: const SyncConfig(initialWindow: 1));
      final server = FakeServer()
        ..deliver('INBOX', subject: 'Invoice old')
        ..deliver('INBOX', subject: 'Invoice new');
      await h.add(server);
      server.latency = const Duration(seconds: 5);
      final seen = <SearchResults>[];
      final sub = h.repo.search(request(_subjectInvoice)).listen(seen.add);
      await settle(const Duration(seconds: 6));
      expect(seen, hasLength(1));
      // Main and IDLE connections exist already; the search one is created lazily.
      expect(h.factory.created, hasLength(3));
      final searchTransport = h.factory.created.last;
      expect(searchTransport.isConnected, isTrue);
      unawaited(sub.cancel());
      await settle(const Duration(seconds: 30));
      expect(seen, hasLength(1), reason: 'no emissions after cancel');
      expect(searchTransport.isConnected, isFalse);
      expect(server.log, isNot(contains('fetchSummaries')));

      server.latency = Duration.zero;
      final again = await collect(h.repo.search(request(_subjectInvoice)));
      expect(again.last.isComplete, isTrue);
      expect(again.last.items, hasLength(2));
      await h.dispose();
    });
  });
}
