import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

void main() {
  ActionRecord action(String id, EmailSummary source, ActionOwner owner) => ActionRecord(
    id: id,
    owner: owner,
    kind: owner == ActionOwner.me ? ActionKind.document : ActionKind.promise,
    source: MessageRef.of(source),
    originalRequest: 'Request $id',
    currentRequest: 'Request $id',
    createdAt: DateTime.utc(2026, 10),
    updatedAt: DateTime.utc(2026, 10),
  );

  test('actions are kept on the device and make the two folders', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()
        ..deliver('INBOX', subject: 'What we need next', messageId: 'req@harbour.example')
        ..deliver('INBOX', subject: 'Something else');
      final a = await h.add(server);
      final request = await h.email(a, 'INBOX', 'What we need next');
      await h.repo.saveActions([action('a1', request, ActionOwner.me), action('a2', request, ActionOwner.them)]);
      expect((await h.repo.watchActions().first).map((r) => r.id).toSet(), {'a1', 'a2'});
      final counts = await h.repo.watchVirtualCounts().first;
      expect((counts[VirtualMailbox.needsMyAction], counts[VirtualMailbox.waitingOnOthers]), (1, 1));
      Future<List<String>> folder(VirtualMailbox kind) async => [
        for (final t in await h.repo.watchList(VirtualMailboxRef(kind)).first) t.latest.subject,
      ];
      expect(await folder(VirtualMailbox.needsMyAction), ['What we need next']);
      expect(await folder(VirtualMailbox.waitingOnOthers), ['What we need next']);
      // Nothing to page in from a server.
      expect(await h.repo.loadOlder(const VirtualMailboxRef(VirtualMailbox.needsMyAction)), isFalse);

      // Archived on the server, the action follows its message.
      await h.repo.archive([request.id]);
      await settle();
      final moved = (await h.repo.watchActions().first).firstWhere((r) => r.id == 'a1');
      expect(moved.source.emailId, isNot(request.id));
      expect((await h.repo.getEmail(moved.source.emailId))?.subject, 'What we need next');
      expect(await folder(VirtualMailbox.needsMyAction), ['What we need next']);

      await h.repo.forgetActions(['a2']);
      expect((await h.repo.watchActions(includeDeleted: true).first).map((r) => r.id), ['a1']);

      // Removing the account removes its actions.
      await h.repo.removeAccount(a.id);
      expect(await h.repo.watchActions(includeDeleted: true).first, isEmpty);
      await h.dispose();
    });
  });

  test('searching an action folder searches this device only', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..deliver('INBOX', subject: 'Invoice INV-2207', messageId: 'inv@removals.example');
      final a = await h.add(server);
      final invoice = await h.email(a, 'INBOX', 'Invoice INV-2207');
      await h.repo.saveActions([action('a1', invoice, ActionOwner.me)]);
      final results = await h.repo
          .search(
            const SearchRequest(
              expr: TextTerm(SearchField.subject, 'invoice'),
              scope: MailboxScope(VirtualMailboxRef(VirtualMailbox.needsMyAction)),
            ),
          )
          .last;
      expect([for (final e in results.items) e.subject], ['Invoice INV-2207']);
      expect(results.fromServerIds, isEmpty);
      await h.dispose();
    });
  });
}
