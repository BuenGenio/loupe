import 'dart:convert';

import 'package:mail_imap/src/imap/connection.dart';
import 'package:mail_imap/src/imap/metadata.dart';
import 'package:mail_imap/src/imap/parsers.dart';
import 'package:mail_imap/src/imap/protocol.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/imap_fixtures.dart';
import 'support/scripted_imap_server.dart';

const _entry = '/private/vendor/loupe/smart-mailboxes';

MetadataResult _parse(String untagged, {String tagged = 'OK GETMETADATA completed'}) =>
    runParser(MetadataParser(), crlf(untagged), tagged: tagged);

void main() {
  group('commands', () {
    test('GETMETADATA asks for one server entry with MAXSIZE', () {
      expect(getMetadataCommand('""', [_entry]), 'GETMETADATA (MAXSIZE 1048576) "" $_entry');
    });

    test('GETMETADATA lists several entries and can drop MAXSIZE', () {
      expect(
        getMetadataCommand('INBOX', ['/private/comment', '/shared/comment'], maxSize: null),
        'GETMETADATA INBOX (/private/comment /shared/comment)',
      );
    });

    test('entry names are atoms unless they need quoting', () {
      expect(astringArg(_entry), _entry);
      expect(astringArg('/private/with space'), '"/private/with space"');
      expect(astringArg('/private/a*b'), '"/private/a*b"');
      expect(astringArg('NIL'), '"NIL"');
      expect(astringArg(''), '""');
    });

    test('SETMETADATA removes an entry with NIL', () {
      final c = setMetadataCommand('""', _entry, null);
      expect(c.head, 'SETMETADATA "" ($_entry NIL)');
      expect(c.literal, isNull);
    });

    test('SETMETADATA quotes a short plain value', () {
      expect(setMetadataCommand('""', _entry, 'hello world').head, 'SETMETADATA "" ($_entry "hello world")');
    });

    test('SETMETADATA sends JSON as a literal counted in bytes', () {
      const json = '{"name":"Rechnungen für März","query":"subject:\\"Rechnung\\""}';
      final c = setMetadataCommand('""', _entry, json);
      final bytes = utf8.encode(json).length;
      expect(bytes, greaterThan(json.length));
      expect(c.head, 'SETMETADATA "" ($_entry {$bytes}');
      expect(utf8.decode(c.literal!), json);
      expect(c.tail, ')');
      expect(c.wire, 'SETMETADATA "" ($_entry {$bytes}\r\n$json)');
    });

    test('long ASCII values go as literals too', () {
      final value = 'x' * 2000;
      expect(setMetadataCommand('""', _entry, value).literal, hasLength(2000));
    });
  });

  group('GETMETADATA responses (recorded)', () {
    test('a quoted value', () {
      final r = _parse('* METADATA "" ($_entry "hello")\n');
      expect(r[_entry], 'hello');
      expect(r.values.containsKey(_entry), isTrue);
      expect(r.longEntries, isNull);
    });

    test('NIL: the entry is not set (Dovecot)', () {
      final r = _parse('* METADATA "" ($_entry NIL)\n');
      expect(r.values.containsKey(_entry), isTrue);
      expect(r[_entry], isNull);
    });

    test('no METADATA response at all (servers that omit unset entries)', () {
      final r = _parse('');
      expect(r.values, isEmpty);
      expect(r[_entry], isNull);
    });

    test('a literal with JSON, non-ASCII text and brackets', () {
      const json = '{"version":1,"entries":[{"name":"Café (Rechnungen)","query":"subject:\\"x\\" {1}"}]}';
      final r = _parse('* METADATA "" ($_entry ${literal(json)})\n');
      expect(r[_entry], json);
      expect(jsonDecode(r[_entry]!), isA<Map<String, Object?>>());
    });

    test('an empty literal', () {
      final r = _parse('* METADATA "" ($_entry {0}\n)\n');
      expect(r[_entry], '');
    });

    test('several entries, mixed quoted and literal', () {
      final r = _parse(
        '* METADATA "INBOX" (/private/comment "My \\"own\\" \\\\ note" /shared/comment ${literal('hi')})\n',
      );
      expect(r['/private/comment'], r'My "own" \ note');
      expect(r['/shared/comment'], 'hi');
    });

    test('entry names compare case-insensitively', () {
      final r = _parse('* METADATA "" (/PRIVATE/Vendor/Loupe/Smart-Mailboxes "x")\n');
      expect(r[_entry], 'x');
    });

    test('one response per entry', () {
      final r = _parse('* METADATA "" (/private/a "1")\n* METADATA "" (/private/b ${literal('2')})\n');
      expect(r['/private/a'], '1');
      expect(r['/private/b'], '2');
    });

    test('LONGENTRIES: an entry was larger than MAXSIZE', () {
      final r = _parse('', tagged: 'OK [METADATA LONGENTRIES 2097152] GETMETADATA complete');
      expect(r.longEntries, 2097152);
      expect(r.values, isEmpty);
    });

    test('unsolicited change notifications are ignored', () {
      final r = _parse('* METADATA "" $_entry\n');
      expect(r.values, isEmpty);
    });
  });

  group('SETMETADATA refusals', () {
    test('MAXSIZE carries the limit', () {
      expect(metadataRefusal('[METADATA MAXSIZE 1024] Value too long'), (MetadataRefusal.maxSize, 1024));
    });

    test('TOOMANY and NOPRIVATE', () {
      expect(metadataRefusal('[METADATA TOOMANY] Too many entries').$1, MetadataRefusal.tooMany);
      expect(metadataRefusal('[METADATA NOPRIVATE] No private entries').$1, MetadataRefusal.noPrivate);
    });

    test('anything else, e.g. Dovecot without mail_attribute_dict', () {
      expect(metadataRefusal('[SERVERBUG] Internal error occurred.').$1, MetadataRefusal.other);
      expect(metadataRefusal('Mailbox attributes not enabled').$1, MetadataRefusal.other);
    });
  });

  group('on the wire', () {
    late ScriptedImapServer server;
    late ImapConnection conn;

    setUp(() async {
      server = await ScriptedImapServer.start();
      server.capabilities = 'IMAP4rev1 SASL-IR AUTH=PLAIN METADATA';
      conn = await ImapConnection.open(
        ServerConfig(
          protocol: ServerProtocol.imap,
          host: '127.0.0.1',
          port: server.port,
          security: ConnectionSecurity.none,
        ),
        username: 'me',
        credentials: const PasswordCredentials('pw'),
      );
    });

    tearDown(() async {
      await conn.close();
      await server.close();
    });

    test('capabilities: METADATA and METADATA-SERVER both allow server entries', () async {
      expect(conn.supportsServerMetadata, isTrue);
      conn.capabilities = {'IMAP4REV1', 'METADATA-SERVER'};
      expect(conn.supportsServerMetadata, isTrue);
      conn.capabilities = {'IMAP4REV1'};
      expect(conn.supportsServerMetadata, isFalse);
    });

    test('SETMETADATA waits for the continuation, then sends the literal', () async {
      const json = '{"name":"Grüße","query":"from:\\"a b\\""}';
      final c = setMetadataCommand('""', _entry, json);
      await conn.sendLiteral(c.head, c.literal!, c.tail, GenericParser());
      expect(server.commands.last, 'SETMETADATA "" ($_entry {${utf8.encode(json).length}})');
      expect(server.literals, [json]);
    });

    test('GETMETADATA reads a literal answer', () async {
      const json = '{"version":1,"entries":[]}';
      server.script = (command) => command.startsWith('GETMETADATA')
          ? (untagged: '* METADATA "" ($_entry ${literal(json)})\r\n', tagged: 'OK GETMETADATA completed')
          : null;
      final r = await conn.send(Command(getMetadataCommand('""', [_entry])), MetadataParser());
      expect(server.commands.last, 'GETMETADATA (MAXSIZE 1048576) "" $_entry');
      expect(r[_entry], json);
    });

    test('a refusal surfaces as a server error with the response code', () async {
      server.reply = (command) => 'NO [METADATA MAXSIZE 64] Value too long';
      final c = setMetadataCommand('""', _entry, '{"long":"${'x' * 100}"}');
      await expectLater(
        conn.sendLiteral(c.head, c.literal!, c.tail, GenericParser()),
        throwsA(
          isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.server).having(
            (e) => metadataRefusal(e.message),
            'refusal',
            (MetadataRefusal.maxSize, 64),
          ),
        ),
      );
    });
  });
}
