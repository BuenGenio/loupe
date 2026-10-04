import 'dart:convert';

import 'package:mail_imap/mail_imap.dart';
import 'package:mail_imap/src/imap/server_documents.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/imap_fixtures.dart';
import 'support/scripted_imap_server.dart';

const _name = ServerDocuments.smartMailboxes;
const _entry = '/private/vendor/loupe/smart-mailboxes';
const _json = '{"format":"loupe.smart-mailboxes","version":1,"entries":[{"id":"a","name":"Rechnungen März"}]}';

MailAccount _account(int port) => MailAccount(
  id: 'acc',
  email: 'me@example.test',
  displayName: 'Test',
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: ServerConfig(
    protocol: ServerProtocol.imap,
    host: '127.0.0.1',
    port: port,
    security: ConnectionSecurity.none,
  ),
);

/// A folder message as another client might store it.
String _message(String content, {String name = _name, String encoding = 'base64'}) {
  final body = switch (encoding) {
    'base64' => base64.encode(utf8.encode(content)),
    _ => content,
  };
  return 'From: x@example.test\r\n${ServerDocuments.header}: $name\r\nContent-Type: text/plain; charset=utf-8\r\n'
      'Content-Transfer-Encoding: $encoding\r\n\r\n$body\r\n';
}

String _head(String message) => message.substring(0, message.indexOf('\r\n\r\n') + 4);
String _text(String message) => message.substring(message.indexOf('\r\n\r\n') + 4);

typedef _Reply = ({String untagged, String tagged});

void main() {
  group('folder messages', () {
    test('round trip, with non-ASCII text and long lines', () {
      final content = jsonEncode({'name': 'Grüße', 'query': 'x' * 500});
      final bytes = buildDocumentMessage(
        _name,
        content,
        address: 'me@example.test',
        date: DateTime.utc(2026, 10, 4, 9),
        messageId: 'id@loupe.invalid',
      );
      final raw = utf8.decode(bytes);
      expect(raw, contains('X-Loupe-Document: smart-mailboxes\r\n'));
      expect(raw, contains('Content-Type: text/plain; charset=utf-8\r\n'));
      expect(raw.split('\r\n').every((l) => l.length <= 998), isTrue);
      expect(readDocumentMessage(_name, utf8.encode(_head(raw)), utf8.encode(_text(raw))), content);
    });

    test('other clients may use any transfer encoding', () {
      for (final encoding in ['base64', '8bit', '7bit']) {
        final m = _message(_json, encoding: encoding);
        expect(readDocumentMessage(_name, utf8.encode(_head(m)), utf8.encode(_text(m))), _json, reason: encoding);
      }
    });

    test('messages of other documents are not ours', () {
      final m = _message(_json, name: 'filters');
      expect(readDocumentMessage(_name, utf8.encode(_head(m)), utf8.encode(_text(m))), isNull);
    });

    test('the folder sits at the top level or right under INBOX', () {
      const top = RemoteMailbox(path: 'Loupe Settings', name: 'Loupe Settings');
      const inbox = RemoteMailbox(path: 'INBOX.Loupe Settings', name: 'Loupe Settings', parentPath: 'INBOX');
      const nested = RemoteMailbox(path: 'Work/Loupe Settings', name: 'Loupe Settings', parentPath: 'Work');
      expect(findDocumentsFolder([nested, top]), same(top));
      expect(findDocumentsFolder([inbox]), same(inbox));
      expect(findDocumentsFolder([nested]), isNull);
      expect(
        ServerDocuments.isFolder(
          const Mailbox(id: 'a|x', accountId: 'a', name: 'Loupe Settings', path: 'INBOX/Loupe Settings'),
        ),
        isTrue,
      );
      expect(
        ServerDocuments.isFolder(
          const Mailbox(id: 'a|x', accountId: 'a', name: 'Loupe Settings', path: 'Work/Loupe Settings'),
        ),
        isFalse,
      );
    });
  });

  group('ImapTransport documents', () {
    late ScriptedImapServer server;
    late ImapTransport transport;

    /// Answers SELECT, FETCH and UID FETCH of the folder with [messages]
    /// (uid → raw message); [more] answers anything else.
    void serveFolder(Map<int, String> messages, {_Reply? Function(String command)? more}) {
      server.script = (command) {
        if (command.startsWith('SELECT')) {
          return (
            untagged: '* ${messages.length} EXISTS\r\n* OK [UIDVALIDITY 7] UIDs valid\r\n* OK [UIDNEXT 20] Next\r\n',
            tagged: 'OK [READ-WRITE] Select completed',
          );
        }
        if (command.startsWith('FETCH')) {
          final lines = StringBuffer();
          var seq = 0;
          for (final MapEntry(key: uid, value: m) in messages.entries) {
            final header = RegExp(r'^X-Loupe-Document:.*\r\n', multiLine: true).firstMatch(m)?[0] ?? '';
            lines.write(
              '* ${++seq} FETCH (UID $uid BODY[HEADER.FIELDS (X-LOUPE-DOCUMENT)] ${literal('$header\r\n')})\r\n',
            );
          }
          return (untagged: lines.toString(), tagged: 'OK Fetch completed');
        }
        if (command.startsWith('UID FETCH')) {
          final lines = StringBuffer();
          var seq = 0;
          for (final MapEntry(key: uid, value: m) in messages.entries) {
            seq++;
            lines.write(
              '* $seq FETCH (UID $uid BODY[HEADER] ${literal(_head(m))} BODY[TEXT] ${literal(_text(m))})\r\n',
            );
          }
          return (untagged: lines.toString(), tagged: 'OK Fetch completed');
        }
        return more?.call(command);
      };
    }

    Future<void> connect(String capabilities, {List<String>? list}) async {
      server.capabilities = 'IMAP4rev1 SASL-IR AUTH=PLAIN LIST-EXTENDED SPECIAL-USE UIDPLUS $capabilities';
      if (list != null) server.listLines = list;
      await transport.connect();
      server.commands.clear();
    }

    setUp(() async {
      server = await ScriptedImapServer.start();
      transport = ImapTransport(
        _account(server.port),
        ({forceRefresh = false}) async => const PasswordCredentials('pw'),
      );
    });

    tearDown(() async {
      await transport.disconnect();
      await server.close();
    });

    test('METADATA: reads the server annotation', () async {
      await connect('METADATA');
      server.script = (command) => command.startsWith('GETMETADATA')
          ? (untagged: '* METADATA "" ($_entry ${literal(_json)})\r\n', tagged: 'OK GETMETADATA complete')
          : null;
      final docs = await transport.readDocuments(_name);
      expect(docs.single.content, _json);
      expect(docs.single.storage, ServerStorage.metadata);
      expect(server.commands, [
        'GETMETADATA (MAXSIZE 1048576) "" $_entry',
        r'LIST "" "*" RETURN (SUBSCRIBED SPECIAL-USE)',
      ]);
    });

    test('METADATA-SERVER: an unset entry (NIL) means no document', () async {
      await connect('METADATA-SERVER');
      server.script = (command) => command.startsWith('GETMETADATA')
          ? (untagged: '* METADATA "" ($_entry NIL)\r\n', tagged: 'OK GETMETADATA complete')
          : null;
      expect(await transport.readDocuments(_name), isEmpty);
    });

    test('METADATA: LONGENTRIES asks again with the size the server reported', () async {
      await connect('METADATA');
      server.script = (command) {
        if (command == 'GETMETADATA (MAXSIZE 1048576) "" $_entry') {
          return (untagged: '', tagged: 'OK [METADATA LONGENTRIES 1100000] GETMETADATA complete');
        }
        if (command.startsWith('GETMETADATA (MAXSIZE 1100000)')) {
          return (untagged: '* METADATA "" ($_entry ${literal(_json)})\r\n', tagged: 'OK done');
        }
        return null;
      };
      expect((await transport.readDocuments(_name)).single.content, _json);
    });

    test('METADATA: writes a literal and removes the folder copies it replaces', () async {
      await connect(
        'METADATA',
        list: [r'LIST (\HasNoChildren) "/" INBOX', r'LIST (\HasNoChildren) "/" "Loupe Settings"'],
      );
      serveFolder({4: _message(_json)});
      final old = await transport.readDocuments(_name);
      expect(old.single.storage, ServerStorage.folder);
      expect(old.single.ref, MailIds.imapEmail('acc', 'Loupe Settings', 7, 4));
      server.commands.clear();
      server.literals.clear();
      const next = '{"format":"loupe.smart-mailboxes","version":1,"entries":[]}';
      final where = await transport.writeDocument(_name, next, replaces: old);
      expect(where, ServerStorage.metadata);
      expect(server.literals, [next]);
      expect(server.commands, [
        'SETMETADATA "" ($_entry {${next.length}})',
        // Still selected from the read.
        r'UID STORE 4 +FLAGS.SILENT (\Deleted)',
        'UID EXPUNGE 4',
      ]);
    });

    test('Dovecot without mail_attribute_dict: falls back to the folder', () async {
      await connect(
        'METADATA',
        list: [r'LIST (\HasNoChildren) "/" INBOX', r'LIST (\HasNoChildren) "/" "Loupe Settings"'],
      );
      serveFolder(
        {3: _message(_json), 5: _message('{}', name: 'other'), 9: _message(_json.replaceAll('März', 'April'))},
        more: (command) => command.startsWith('GETMETADATA') || command.startsWith('SETMETADATA')
            ? (untagged: '', tagged: 'NO Mailbox attributes not enabled.')
            : command.startsWith('APPEND')
            ? (untagged: '', tagged: 'OK [APPENDUID 7 10] Append completed')
            : null,
      );
      final docs = await transport.readDocuments(_name);
      expect(docs.map((d) => d.storage), [ServerStorage.folder, ServerStorage.folder]);
      expect(docs.map((d) => d.content), [_json, _json.replaceAll('März', 'April')]);
      expect(server.commands, [
        'GETMETADATA (MAXSIZE 1048576) "" $_entry',
        r'LIST "" "*" RETURN (SUBSCRIBED SPECIAL-USE)',
        'SELECT "Loupe Settings"',
        'FETCH 1:3 (UID BODY.PEEK[HEADER.FIELDS (X-LOUPE-DOCUMENT)])',
        'UID FETCH 3,9 (UID BODY.PEEK[HEADER] BODY.PEEK[TEXT])',
      ]);

      // METADATA isn't tried again on this connection.
      server.commands.clear();
      server.literals.clear();
      expect(await transport.writeDocument(_name, _json, replaces: docs), ServerStorage.folder);
      expect(server.commands.first, startsWith(r'APPEND "Loupe Settings" (\Seen) {'));
      expect(server.commands.skip(1), [r'UID STORE 3,9 +FLAGS.SILENT (\Deleted)', 'UID EXPUNGE 3,9']);
      final appended = server.literals.single;
      expect(appended, contains('X-Loupe-Document: smart-mailboxes\r\n'));
      expect(readDocumentMessage(_name, utf8.encode(_head(appended)), utf8.encode(_text(appended))), _json);
    });

    test('no METADATA: creates the folder at the top level', () async {
      await connect('');
      server.script = (command) {
        if (command == 'LIST "" ""') return (untagged: '* LIST (\\Noselect) "/" ""\r\n', tagged: 'OK List done');
        if (command.startsWith('CREATE')) {
          server.listLines = [...server.listLines, r'LIST (\HasNoChildren) "/" "Loupe Settings"'];
        }
        return null;
      };
      expect(await transport.readDocuments(_name), isEmpty);
      expect(await transport.writeDocument(_name, _json), ServerStorage.folder);
      expect(server.commands, [
        r'LIST "" "*" RETURN (SUBSCRIBED SPECIAL-USE)',
        r'LIST "" "*" RETURN (SUBSCRIBED SPECIAL-USE)',
        'LIST "" ""',
        'CREATE "Loupe Settings"',
        r'LIST "" "*" RETURN (SUBSCRIBED SPECIAL-USE)',
        startsWith(r'APPEND "Loupe Settings" (\Seen) {'),
      ]);
    });

    test('no METADATA: servers with every folder under INBOX', () async {
      await connect('', list: [r'LIST (\HasChildren) "." INBOX']);
      server.script = (command) {
        if (command == 'LIST "" ""') return (untagged: '* LIST (\\Noselect) "." ""\r\n', tagged: 'OK List done');
        if (command == 'CREATE "Loupe Settings"') return (untagged: '', tagged: 'NO [CANNOT] Invalid mailbox name');
        if (command == 'CREATE "INBOX.Loupe Settings"') {
          server.listLines = [...server.listLines, r'LIST (\HasNoChildren) "." "INBOX.Loupe Settings"'];
        }
        return null;
      };
      expect(await transport.writeDocument(_name, _json), ServerStorage.folder);
      expect(server.commands, contains('CREATE "INBOX.Loupe Settings"'));
      expect(server.commands.last, startsWith(r'APPEND "INBOX.Loupe Settings" (\Seen) {'));
    });

    test('Gmail: not supported (no METADATA, and copies would pile up in All Mail)', () async {
      await connect('X-GM-EXT-1');
      final unsupported = throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.unsupported));
      await expectLater(transport.readDocuments(_name), unsupported);
      await expectLater(transport.writeDocument(_name, _json), unsupported);
      expect(server.commands, isEmpty);
    });

    test('a value over MAXSIZE goes to the folder and clears the METADATA copy', () async {
      await connect(
        'METADATA',
        list: [r'LIST (\HasNoChildren) "/" INBOX', r'LIST (\HasNoChildren) "/" "Loupe Settings"'],
      );
      server.script = (command) {
        if (command.startsWith('SETMETADATA') && command.contains('{')) {
          return (untagged: '', tagged: 'NO [METADATA MAXSIZE 64] Value too long');
        }
        return null;
      };
      const old = ServerDocument(content: '{}', storage: ServerStorage.metadata);
      expect(await transport.writeDocument(_name, _json, replaces: const [old]), ServerStorage.folder);
      expect(server.commands, [
        startsWith('SETMETADATA "" ($_entry {'),
        r'LIST "" "*" RETURN (SUBSCRIBED SPECIAL-USE)',
        startsWith(r'APPEND "Loupe Settings" (\Seen) {'),
        'SETMETADATA "" ($_entry NIL)',
      ]);
    });
  });
}
