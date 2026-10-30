import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

void main() {
  final at = DateTime(2026, 10, 20, 9);

  test('a matter keeps its conversation when another client files it and after a UIDVALIDITY reset', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()
        ..deliver('INBOX', subject: 'Your application', from: 'rhea@harbour.example', messageId: 'a1@harbour.example')
        ..deliver('INBOX', subject: 'Client care letter', from: 'owen@marsh.example', messageId: 's1@marsh.example');
      final a = await h.add(server);
      final adviser = await h.email(a, 'INBOX', 'Your application');
      final matter = Matter.create(
        id: 'm1',
        name: 'Buying 14 Quay Street',
        at: at,
      ).adding(MatterMember.of(adviser, at: at), subject: adviser.subject);
      await h.repo.writeMatters(save: [matter]);
      Future<List<String>> subjects() async => [
        for (final e in await h.repo.watchMatterMessages('m1').first) e.subject,
      ];
      expect(await subjects(), ['Your application']);

      // Filed into Archive from another client: a new UID in another folder.
      final original = server.find('INBOX', 'Your application')!;
      server
        ..expunge('INBOX', original.uid)
        ..deliver(
          'Archive',
          subject: 'Your application',
          from: 'rhea@harbour.example',
          messageId: 'a1@harbour.example',
        );
      await h.repo.refresh();
      expect(await subjects(), ['Your application'], reason: 'filing doesn’t take it out of the matter');
      final ref = (await h.repo.watchMatters().first).single.members.single.ref;
      final filed = (await h.repo.locateMessage(ref))!;
      expect(filed.mailboxId, h.mailbox(a, 'Archive'));
      expect(filed.id, isNot(adviser.id));

      server.resetUidValidity('Archive');
      await h.repo.refresh(ref: RealMailboxRef(h.mailbox(a, 'Archive')));
      expect(await subjects(), ['Your application']);
      final reset = (await h.repo.locateMessage(ref))!;
      expect(MailIds.parseImapEmail(reset.id)!.uidValidity, 2);
      expect(reset.threadId, adviser.threadId);

      // The mail is the user's: removing the account removes the conversation, not the matter.
      await h.repo.removeAccount(a.id);
      final after = (await h.repo.watchMatters().first).single;
      expect(after.name, 'Buying 14 Quay Street');
      expect(after.members, isEmpty);
      await h.dispose();
    });
  });
}
