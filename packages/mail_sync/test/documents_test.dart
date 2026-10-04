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
