import 'dart:convert';

import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

const _name = ServerDocuments.smartMailboxes;
final _now = DateTime.utc(2026, 10, 4, 12);

DateTime _t(int minutes) => _now.add(Duration(minutes: minutes));

SmartMailboxEntry _e(
  String id, {
  int at = 0,
  String name = '',
  String query = 'is:unread',
  Map<String, Object?>? scope,
  bool deleted = false,
}) => SmartMailboxEntry(
  id: id,
  name: name.isEmpty ? id : name,
  query: query,
  scope: scope,
  modifiedAt: _t(at),
  deleted: deleted,
);

SmartMailboxEntry _tomb(String id, {int at = 0}) => SmartMailboxEntry(id: id, modifiedAt: _t(at), deleted: true);

List<String> _describe(Iterable<SmartMailboxEntry> entries) => [
  for (final e in entries) e.deleted ? '${e.id}†' : '${e.id}:${e.name}',
];

SmartMailboxRecord _r(SmartMailboxEntry e, [String? accountId]) => SmartMailboxRecord(e, accountId: accountId);

String _doc(List<Object?> entries, {int version = 1}) =>
    jsonEncode({'format': 'loupe.smart-mailboxes', 'version': version, 'entries': entries});

void main() {
  group('format', () {
    test('round trip keeps fields other apps add', () {
      final text = _doc([
        {
          'id': 'k1',
          'name': 'Invoices',
          'query': 'subject:invoice has:attachment',
          'scope': {'mailbox': 'INBOX/Receipts'},
          'modifiedAt': '2026-10-01T08:00:00.000Z',
          'icon': 'receipt',
          'color': '#ff9500',
          'x-expression-search': {'raw': 's:invoice'},
        },
        {'id': 'k2', 'modifiedAt': '2026-10-02T08:00:00.000Z', 'deleted': true},
        {'name': 'no id or date'},
      ]);
      final doc = SmartMailboxDocument.parse(text);
      expect(doc.entries.map((e) => e.id), ['k1', 'k2']);
      final k1 = doc.entries.first;
      expect(k1.mailboxPath, 'INBOX/Receipts');
      expect(k1.isAccountScoped, isTrue);
      expect(k1.extra.keys, containsAll(['icon', 'color', 'x-expression-search']));
      expect(doc.entries.last.deleted, isTrue);
      expect(doc.unreadable, hasLength(1));

      final again = jsonDecode(doc.encode()) as Map<String, Object?>;
      expect(again['format'], 'loupe.smart-mailboxes');
      expect(again['version'], 1);
      final entries = again['entries']! as List<Object?>;
      expect(entries[0], containsPair('icon', 'receipt'));
      expect(entries[0], containsPair('modifiedAt', '2026-10-01T08:00:00.000Z'));
      expect(entries[1], {'id': 'k2', 'modifiedAt': '2026-10-02T08:00:00.000Z', 'deleted': true});
      expect(entries[2], {'name': 'no id or date'});
      expect(SmartMailboxDocument.parse(doc.encode()).sameContent(doc), isTrue);
    });

    test('a newer version is recognised; other JSON is not a document', () {
      expect(SmartMailboxDocument.parse(_doc(const [], version: 2)).isNewer, isTrue);
      expect(() => SmartMailboxDocument.parse('{"entries":[]}'), throwsFormatException);
      expect(() => SmartMailboxDocument.parse('not json'), throwsFormatException);
    });

    test('times are UTC with milliseconds; an edit never goes back in time', () {
      final e = _e('a', at: 0);
      expect(e.toJson()['modifiedAt'], '2026-10-04T12:00:00.000Z');
      expect(nextModifiedAt(null, _now), _now);
      expect(nextModifiedAt(_t(-5), _now), _now);
      // Another device's clock was ahead: still later than what it wrote.
      expect(nextModifiedAt(_t(5), _now), _t(5).add(const Duration(milliseconds: 1)));
    });
  });

  group('merge (conflict table)', () {
    final cases = <(String, List<SmartMailboxEntry>, List<SmartMailboxEntry>, List<String>)>[
      ('newer remote edit wins', [_e('a', at: 1, name: 'old')], [_e('a', at: 2, name: 'new')], ['a:new']),
      ('newer local edit wins', [_e('a', at: 2, name: 'mine')], [_e('a', at: 1, name: 'theirs')], ['a:mine']),
      ('a later deletion wins', [_e('a', at: 1)], [_tomb('a', at: 2)], ['a†']),
      ('an edit after the deletion wins', [_tomb('a', at: 1)], [_e('a', at: 2, name: 'back')], ['a:back']),
      ('same time: deletion wins', [_e('a', at: 1)], [_tomb('a', at: 1)], ['a†']),
      (
        'different entries both survive',
        [_e('a', at: 1), _e('b', at: 3)],
        [_e('c', at: 2), _e('a', at: 1)],
        ['a:a', 'b:b', 'c:c'],
      ),
      ('tombstones expire after 30 days', [_tomb('a', at: -31 * 24 * 60)], const [], const []),
      ('younger tombstones stay', [_tomb('a', at: -29 * 24 * 60)], const [], ['a†']),
    ];
    for (final (label, local, remote, expected) in cases) {
      test(label, () {
        expect(_describe(mergeSmartMailboxes([local, remote], now: _now)), expected);
        // Order doesn't change who wins.
        expect(_describe(mergeSmartMailboxes([remote, local], now: _now))..sort(), [...expected]..sort());
      });
    }

    test('a tie between two edits is decided the same way everywhere', () {
      final x = _e('a', at: 1, name: 'x');
      final y = _e('a', at: 1, name: 'y');
      final one = mergeSmartMailboxes([
        [x],
        [y],
      ], now: _now).single;
      final other = mergeSmartMailboxes([
        [y],
        [x],
      ], now: _now).single;
      expect(one.name, other.name);
    });
  });

  group('sync rounds', () {
    Future<SmartMailboxSyncReport> round(
      Harness h,
      List<SmartMailboxRecord> local,
      List<MailAccount> accounts, {
      MailAccount? home,
      DateTime? now,
    }) => syncSmartMailboxes(
      h.repo,
      local,
      accountIds: [for (final a in accounts) a.id],
      homeAccountId: (home ?? accounts.first).id,
      now: now ?? _now,
    );

    List<String> stored(FakeServer s) {
      final raw = s.annotations[ServerDocuments.metadataEntry(_name)];
      return raw == null ? const [] : _describe(SmartMailboxDocument.parse(raw).entries);
    }

    List<String> live(SmartMailboxSyncReport r) => [
      for (final rec in r.records)
        if (!rec.entry.deleted) '${rec.id}:${rec.entry.name}',
    ];

    test('first sync migrates what this device has; nothing is written again when in step', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        final local = [_r(_e('old1', at: -600)), _r(_e('old2', at: -300))];
        final first = await round(h, local, [a]);
        expect(first.synced, {a.id: ServerStorage.metadata});
        expect(stored(server), ['old1:old1', 'old2:old2']);
        server.log.clear();
        final second = await round(h, first.records, [a]);
        expect(second.synced, {a.id: ServerStorage.metadata});
        expect(server.log, ['readDocuments']);
        await h.dispose();
      });
    });

    test('nothing anywhere: nothing is written', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        server.log.clear();
        final r = await round(h, const [], [a]);
        expect(r.synced, {a.id: null});
        expect(server.log, ['readDocuments']);
        await h.dispose();
      });
    });

    test('two devices adding different Smart Mailboxes both keep both', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        var phone = [_r(_e('p', at: 1, name: 'Phone'))];
        var tablet = [_r(_e('t', at: 2, name: 'Tablet'))];
        phone = (await round(h, phone, [a])).records;
        tablet = (await round(h, tablet, [a])).records;
        phone = (await round(h, phone, [a])).records;
        expect(_describe(phone.map((r) => r.entry)), ['p:Phone', 't:Tablet']);
        expect(_describe(tablet.map((r) => r.entry)), ['t:Tablet', 'p:Phone']);
        expect(stored(server), ['t:Tablet', 'p:Phone']);
        await h.dispose();
      });
    });

    test('edits and deletions travel; the newest edit of one entry wins', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        var phone = (await round(h, [_r(_e('x', at: 0, name: 'Start')), _r(_e('y', at: 0))], [a])).records;
        var tablet = (await round(h, const [], [a])).records;
        // Offline on both: the phone renames x at 10, the tablet at 20 and
        // deletes y.
        phone = [_r(phone.first.entry.copyWith(name: 'Phone', modifiedAt: _t(10))), phone.last];
        tablet = [
          _r(tablet.first.entry.copyWith(name: 'Tablet', modifiedAt: _t(20))),
          _r(tablet.last.entry.tombstone(_t(20))),
        ];
        phone = (await round(h, phone, [a])).records;
        tablet = (await round(h, tablet, [a])).records;
        phone = (await round(h, phone, [a])).records;
        expect(live(SmartMailboxSyncReport(records: phone)), ['x:Tablet']);
        expect(live(SmartMailboxSyncReport(records: tablet)), ['x:Tablet']);
        expect(stored(server), ['x:Tablet', 'y†']);
        // A month later the deletion is forgotten everywhere.
        final later = await round(h, phone, [a], now: _now.add(const Duration(days: 31)));
        expect(stored(server), ['x:Tablet']);
        expect(_describe(later.records.map((r) => r.entry)), ['x:Tablet']);
        await h.dispose();
      });
    });

    test('offline: the change waits on this device and goes out with the next round', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        server.offline = true;
        final local = [_r(_e('n', name: 'New'))];
        final r = await round(h, local, [a]);
        expect(r.failed.keys, [a.id]);
        expect(r.failed[a.id]!.kind, MailErrorKind.connection);
        expect(live(r), ['n:New']);
        expect(stored(server), isEmpty);
        server.offline = false;
        final again = await round(h, r.records, [a]);
        expect(again.failed, isEmpty);
        expect(stored(server), ['n:New']);
        await h.dispose();
      });
    });

    test('folder fallback: copies two devices wrote at once are merged into one', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer()..metadata = false;
        final a = await h.add(server);
        server.putFolderDocument(_name, _doc([_e('a', name: 'From A').toJson()]));
        server.putFolderDocument(_name, _doc([_e('b', name: 'From B').toJson()]));
        final r = await round(h, [_r(_e('c', name: 'Mine'))], [a]);
        expect(r.synced, {a.id: ServerStorage.folder});
        expect(live(r), ['c:Mine', 'a:From A', 'b:From B']);
        final copies = server.folderDocuments(_name);
        expect(copies, hasLength(1));
        expect(_describe(SmartMailboxDocument.parse(copies.single).entries), ['c:Mine', 'a:From A', 'b:From B']);
        await h.dispose();
      });
    });

    test('each account keeps its folders’ Smart Mailboxes; the home account the unified ones', () {
      fakeTime((async) async {
        final h = Harness();
        final work = FakeServer();
        final home = FakeServer();
        final w = await h.add(work, email: 'me@work.example');
        final p = await h.add(home, email: 'me@home.example');
        final local = [
          _r(_e('all', name: 'All unread')),
          _r(_e('flag', name: 'Flagged', scope: const {'virtual': 'flagged'})),
          _r(_e('rcpt', name: 'Receipts', scope: const {'mailbox': 'INBOX/Receipts'}), w.id),
        ];
        final r = await round(h, local, [w, p], home: p);
        expect(r.failed, isEmpty);
        expect(stored(work), ['rcpt:Receipts']);
        expect(stored(home), ['all:All unread', 'flag:Flagged']);

        // Another device files a folder search of the home account and a
        // unified one on the work account (its former home).
        home.annotations[ServerDocuments.metadataEntry(_name)] = _doc([
          ...jsonDecode(home.annotations[ServerDocuments.metadataEntry(_name)]!)['entries'] as List<Object?>,
          _e('hf', name: 'Home folder', scope: const {'mailbox': 'Family'}).toJson(),
        ]);
        work.annotations[ServerDocuments.metadataEntry(_name)] = _doc([
          ...jsonDecode(work.annotations[ServerDocuments.metadataEntry(_name)]!)['entries'] as List<Object?>,
          _e('stale', name: 'Old unified').toJson(),
        ]);
        final again = await round(h, r.records, [w, p], home: p);
        final byId = {for (final rec in again.records) rec.id: rec};
        expect(byId['hf']!.accountId, p.id);
        expect(byId['rcpt']!.accountId, w.id);
        expect(byId['all']!.accountId, isNull);
        // Unified entries of a non-home account are left alone.
        expect(byId.containsKey('stale'), isFalse);
        expect(stored(work), ['rcpt:Receipts', 'stale:Old unified']);
        await h.dispose();
      });
    });

    test('a deletion of a folder search reaches the device that filed it', () {
      fakeTime((async) async {
        final h = Harness();
        final work = FakeServer();
        final home = FakeServer();
        final w = await h.add(work, email: 'me@work.example');
        final p = await h.add(home, email: 'me@home.example');
        final scoped = _e('rcpt', name: 'Receipts', scope: const {'mailbox': 'Receipts'});
        final r = await round(h, [_r(scoped, w.id)], [w, p], home: p);
        // An add-on deletes it with a bare tombstone.
        work.annotations[ServerDocuments.metadataEntry(_name)] = _doc([
          {'id': 'rcpt', 'modifiedAt': _t(5).toIso8601String(), 'deleted': true},
        ]);
        final again = await round(h, r.records, [w, p], home: p);
        final rec = again.records.single;
        expect(rec.entry.deleted, isTrue);
        expect(rec.accountId, w.id);
        expect(rec.entry.scope, {'mailbox': 'Receipts'});
        await h.dispose();
      });
    });

    test('a document from a newer Loupe is left alone', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        final newer = _doc(const [], version: 2);
        server.annotations[ServerDocuments.metadataEntry(_name)] = newer;
        final r = await round(h, [_r(_e('a'))], [a]);
        expect(r.newerFormat, {a.id});
        expect(server.annotations[ServerDocuments.metadataEntry(_name)], newer);
        expect(live(r), ['a:a']);
        await h.dispose();
      });
    });

    test('an unreadable copy is replaced by a valid one', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        server.annotations[ServerDocuments.metadataEntry(_name)] = 'garbage';
        final r = await round(h, [_r(_e('a'))], [a]);
        expect(r.synced, {a.id: ServerStorage.metadata});
        expect(stored(server), ['a:a']);
        await h.dispose();
      });
    });
  });
}
