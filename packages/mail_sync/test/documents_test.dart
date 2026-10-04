import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

const _name = ServerDocuments.smartMailboxes;

void main() {
  test('documents go through the account’s connection', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer();
      final a = await h.add(server);
      expect(await h.repo.readServerDocuments(a.id, _name), isEmpty);
      expect(await h.repo.writeServerDocument(a.id, _name, '{"v":1}'), ServerStorage.metadata);
      final docs = await h.repo.readServerDocuments(a.id, _name);
      expect(docs.single.content, '{"v":1}');
      expect(server.annotations[ServerDocuments.metadataEntry(_name)], '{"v":1}');
      await h.dispose();
    });
  });

  test('without METADATA the folder holds them, and replaced copies go', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer()..metadata = false;
      final a = await h.add(server);
      server.putFolderDocument(_name, 'one');
      server.putFolderDocument(_name, 'two');
      final docs = await h.repo.readServerDocuments(a.id, _name);
      expect(docs.map((d) => d.content), ['one', 'two']);
      expect(docs.every((d) => d.storage == ServerStorage.folder && d.ref != null), isTrue);
      expect(await h.repo.writeServerDocument(a.id, _name, 'merged', replaces: docs), ServerStorage.folder);
      expect(server.folderDocuments(_name), ['merged']);
      await h.dispose();
    });
  });

  test('no logins for documents while the server refuses the password', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer();
      final a = await h.add(server);
      // Changed on another device.
      server.password = 'changed elsewhere';
      await server.dropConnections();
      await h.repo.refresh();
      await settle();
      expect((await h.status(a)).phase, SyncPhase.error);

      final logins = server.logins;
      for (var i = 0; i < 5; i++) {
        await expectLater(
          h.repo.readServerDocuments(a.id, _name),
          throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.authentication)),
        );
      }
      expect(server.logins, logins, reason: 'fail2ban counts every refused LOGIN');

      // The password is right again: the next sync logs in and documents work.
      server.password = 'secret';
      await h.repo.refresh();
      await settle();
      expect(await h.repo.readServerDocuments(a.id, _name), isEmpty);
      await h.dispose();
    });
  });

  test('offline: a connection error the caller can retry later', () {
    fakeTime((async) async {
      final h = Harness();
      final server = FakeServer();
      final a = await h.add(server);
      server.offline = true;
      await expectLater(
        h.repo.writeServerDocument(a.id, _name, 'x'),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.connection)),
      );
      await h.dispose();
    });
  });
}
