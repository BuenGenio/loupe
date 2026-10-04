import 'package:clock/clock.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

/// What background isolates do with a repository that was never started:
/// notification actions (act, then [LiveMailRepository.flushOps]) and a
/// background sync that the app interrupts.
void main() {
  test('flushOps sends a background action to the server and disconnects', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'Receipt');
      final a = await h.add(server);
      final email = await h.email(a, 'INBOX', 'Receipt');
      await h.repo.dispose();

      final background = LiveMailRepository(h.store, h.factory, h.credentials, config: fastConfig);
      await background.archive([email.id]);
      await background.setKeywords([email.id], add: {Keywords.seen});
      expect(await h.subjects(a, 'Archive'), ['Receipt']);
      expect(server.subjects('INBOX'), ['Receipt'], reason: 'nothing replays before flushOps');

      await background.flushOps();
      expect(server.subjects('INBOX'), isEmpty);
      expect(server.subjects('Archive'), ['Receipt']);
      expect(server.find('Archive', 'Receipt')!.keywords, {Keywords.seen});
      expect(await h.store.pendingOps(), isEmpty);
      expect(server.transports.where((t) => t.isConnected), isEmpty);
      await background.dispose();
      await h.store.close();
    });
  });

  test('flushOps keeps offline operations queued without counting a failure', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'Later');
      final a = await h.add(server);
      final email = await h.email(a, 'INBOX', 'Later');
      await h.repo.dispose();
      server.offline = true;

      final background = LiveMailRepository(h.store, h.factory, h.credentials, config: fastConfig);
      await background.setKeywords([email.id], add: {Keywords.seen});
      await background.flushOps();
      final op = (await h.store.pendingOps()).single;
      expect(op.attempts, 0);
      await background.dispose();
      await h.store.close();
    });
  });

  test('dispose stops a running syncOnce after the command in flight', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'Old');
      final a = await h.add(server);
      await h.repo.dispose();
      server
        ..deliver('INBOX', subject: 'New')
        ..latency = const Duration(seconds: 1)
        ..log.clear();

      final background = LiveMailRepository(h.store, h.factory, h.credentials, config: fastConfig);
      final sync = background.syncOnce();
      // connect + list + INBOX take three seconds; then the app takes over.
      await Future<void>.delayed(const Duration(milliseconds: 3500));
      final interrupted = clock.now();
      await background.dispose();
      await sync;
      expect(clock.now().difference(interrupted), lessThan(const Duration(seconds: 2)));
      expect(server.log.where((l) => l.startsWith('sync:')), hasLength(lessThan(3)));
      expect(server.transports.where((t) => t.isConnected), isEmpty);
      expect(await h.subjects(a, 'INBOX'), contains('Old'));
      await h.store.close();
    });
  });
}
