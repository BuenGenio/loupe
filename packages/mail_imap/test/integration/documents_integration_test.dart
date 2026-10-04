@Tags(['integration'])
library;

import 'package:mail_imap/mail_imap.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'server_env.dart';

/// Server documents against a real server: METADATA where it works (Dovecot
/// with a mail_attribute_dict), the Loupe Settings folder elsewhere
/// (GreenMail).
void main() {
  final server = TestServer.fromEnvironment();
  if (server == null) {
    test('documents integration (set LOUPE_TEST_IMAP_HOST to run)', () {}, skip: 'LOUPE_TEST_IMAP_HOST is not set');
    return;
  }

  final name = 'it-${DateTime.now().millisecondsSinceEpoch}';
  late ImapTransport transport;

  setUpAll(() async {
    transport = ImapTransport(server.account('docs-$name'), server.credentials);
    await transport.connect();
  });

  // Each run uses its own document name, so leftovers don't matter.
  tearDownAll(() => transport.disconnect());

  test('write, read back, replace: one copy remains', () async {
    expect(await transport.readDocuments(name), isEmpty);
    const first = '{"format":"loupe.smart-mailboxes","version":1,"entries":[{"id":"a","name":"Grüße"}]}';
    final where = await transport.writeDocument(name, first);
    final read = await transport.readDocuments(name);
    expect(read.single.content, first);
    expect(read.single.storage, where);

    const second = '{"format":"loupe.smart-mailboxes","version":1,"entries":[]}';
    expect(await transport.writeDocument(name, second, replaces: read), where);
    final again = await transport.readDocuments(name);
    expect(again.map((d) => d.content), [second]);
    if (where == ServerStorage.folder) {
      final folders = await transport.listMailboxes();
      final folder = folders.singleWhere((m) => ServerDocuments.isFolderName(m.name, m.parentPath));
      expect(folder.isSubscribed, isFalse);
    }
  });
}
