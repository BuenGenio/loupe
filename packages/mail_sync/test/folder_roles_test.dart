import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

OutgoingMessage _outgoing(MailAccount a, String subject) => OutgoingMessage(
  accountId: a.id,
  identityId: a.defaultIdentity.id,
  to: const [EmailAddress('bob@example.org', 'Bob')],
  subject: subject,
  text: 'Hello Bob',
);

/// A server that flags the wrong folders, or none (Settings › account ›
/// Special Folders): the folders picked instead get sent mail, drafts and
/// deleted mail, keep them through syncs and restarts, and give them back to
/// the server's choice on Automatic.
void main() {
  Future<Map<String, MailboxRole>> roles(Harness h, MailAccount a) async => {
    for (final m in await h.repo.watchMailboxes(accountId: a.id).first)
      if (m.role != MailboxRole.none) m.path: m.role,
  };

  FakeServer server() => FakeServer()
    ..addMailbox('INBOX.Sent Items')
    ..addMailbox('INBOX.Drafts')
    ..addMailbox('INBOX.Deleted Items')
    ..deliver('INBOX', subject: 'Bin');

  MailAccount picked(MailAccount a) => a
      .withFolderRole(MailboxRole.sent, 'INBOX.Sent Items')
      .withFolderRole(MailboxRole.drafts, 'INBOX.Drafts')
      .withFolderRole(MailboxRole.trash, 'INBOX.Deleted Items');

  test('sent mail, drafts and deleted mail go to the picked folders', () {
    fakeTime((async) async {
      final h = Harness();
      final s = server();
      final a = picked(await h.add(s));
      await h.repo.updateAccount(a);
      expect(await roles(h, a), {
        'INBOX': MailboxRole.inbox,
        'INBOX.Drafts': MailboxRole.drafts,
        'INBOX.Sent Items': MailboxRole.sent,
        'Archive': MailboxRole.archive,
        'Junk': MailboxRole.junk,
        'INBOX.Deleted Items': MailboxRole.trash,
      });

      await h.repo.send(_outgoing(a, 'Out'), undoDelay: Duration.zero);
      await h.repo.saveDraft(_outgoing(a, 'Later'));
      await h.repo.trash([(await h.email(a, 'INBOX', 'Bin')).id]);
      await settle(const Duration(seconds: 10));

      expect(s.subjects('INBOX.Sent Items'), ['Out']);
      expect(s.subjects('INBOX.Drafts'), ['Later']);
      expect(s.subjects('INBOX.Deleted Items'), ['Bin']);
      expect(s.subjects('Sent'), isEmpty);
      expect(s.subjects('Drafts'), isEmpty);
      expect(s.subjects('Trash'), isEmpty);
      // The picked folders never synced before; they show what was filed in them without waiting for a poll.
      expect(await h.subjects(a, 'INBOX.Sent Items'), ['Out']);
      expect(await h.subjects(a, 'INBOX.Deleted Items'), ['Bin']);
      expect(await h.repo.watchList(const VirtualMailboxRef(VirtualMailbox.allSent)).first, hasLength(1));
      await h.dispose();
    });
  });

  test('the picks hold through a full sync and a restart; Automatic gives the server’s folders back at once', () {
    fakeTime((async) async {
      final h = Harness();
      final s = server();
      final a = picked(await h.add(s));
      await h.repo.updateAccount(a);
      await h.repo.refresh();
      await settle();
      expect((await roles(h, a))['INBOX.Sent Items'], MailboxRole.sent);

      await h.repo.dispose();
      final repo2 = LiveMailRepository(h.store, h.factory, h.credentials, config: fastConfig);
      await repo2.start();
      await settle();
      final stored = (await repo2.watchAccounts().first).single;
      expect(stored.folderRoles, a.folderRoles);
      expect((await roles(h, a))['INBOX.Deleted Items'], MailboxRole.trash);

      await repo2.updateAccount(stored.withFolderRole(MailboxRole.trash, null));
      final now = await roles(h, a);
      expect(now['Trash'], MailboxRole.trash);
      expect(now.containsKey('INBOX.Deleted Items'), isFalse);
      expect(now['INBOX.Sent Items'], MailboxRole.sent);
      await repo2.dispose();
      await h.store.close();
    });
  });
}
