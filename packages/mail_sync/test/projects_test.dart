import 'dart:convert';

import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

/// Projects: the document on the home account's server, and membership by
/// keyword, which follows a conversation as new mail arrives.

final _now = DateTime.utc(2026, 11, 21, 12);
DateTime _t(int minutes) => _now.add(Duration(minutes: minutes));

ProjectEntry _p(String id, {int at = 0, String? name, bool done = false}) =>
    ProjectEntry(id: id, name: name ?? id, modifiedAt: _t(at), done: done);

List<String> _describe(Iterable<ProjectEntry> entries) => [
  for (final e in entries) e.deleted ? '${e.id}†' : '${e.id}:${e.name}${e.done ? ' (done)' : ''}',
];

String _doc(List<Object?> entries, {int version = 1}) =>
    jsonEncode({'format': 'loupe.projects', 'version': version, 'entries': entries});

void main() {
  group('format', () {
    test('round trip keeps what other apps add; entries without a usable id are kept as they are', () {
      final doc = ProjectDocument.parse(
        _doc([
          {
            'id': 'lq3k2x1a9b',
            'name': 'House move',
            'color': '#FF9500',
            'query': 'from:@removals.example',
            'modifiedAt': '2026-11-01T08:00:00.000Z',
            'x-other': {'pinned': true},
          },
          {'id': 'done1', 'name': 'Tax 2025', 'done': true, 'modifiedAt': '2026-11-02T08:00:00.000Z'},
          {'id': 'gone', 'modifiedAt': '2026-11-03T08:00:00.000Z', 'deleted': true},
          {'id': 'Not Valid!', 'name': 'x', 'modifiedAt': '2026-11-03T08:00:00.000Z'},
          {'name': 'no id'},
        ]),
      );
      expect(_describe(doc.entries), ['lq3k2x1a9b:House move', 'done1:Tax 2025 (done)', 'gone†']);
      final house = doc.entries.first;
      expect(
        (house.color, house.query, house.keyword),
        ('#ff9500', 'from:@removals.example', r'$loupe-project-lq3k2x1a9b'),
      );
      expect(doc.unreadable, hasLength(2));

      final again = jsonDecode(doc.encode()) as Map<String, Object?>;
      final entries = again['entries']! as List<Object?>;
      expect(entries[0], containsPair('x-other', {'pinned': true}));
      expect(entries[1], containsPair('done', true));
      expect(entries[2], {'id': 'gone', 'modifiedAt': '2026-11-03T08:00:00.000Z', 'deleted': true});
      expect(entries.sublist(3), [
        {'id': 'Not Valid!', 'name': 'x', 'modifiedAt': '2026-11-03T08:00:00.000Z'},
        {'name': 'no id'},
      ]);
      expect(ProjectDocument.parse(doc.encode()).sameContent(doc), isTrue);
      expect(() => ProjectDocument.parse('{"format":"loupe.smart-mailboxes"}'), throwsFormatException);
    });
  });

  group('sync rounds', () {
    Future<ProjectSyncReport> round(Harness h, List<ProjectEntry> local, MailAccount home, {DateTime? now}) =>
        syncProjects(h.repo, local, homeAccountId: home.id, now: now ?? _now);

    List<String> stored(FakeServer s) {
      final raw = s.annotations[ServerDocuments.metadataEntry(ServerDocuments.projects)];
      return raw == null ? const [] : _describe(ProjectDocument.parse(raw).entries);
    }

    test('two devices keep each other’s projects, edits and deletions; in step, nothing is written', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        var phone = (await round(h, [_p('house', name: 'House'), _p('tax')], a)).entries;
        var tablet = (await round(h, [_p('garden', at: 1)], a)).entries;
        expect(stored(server), ['garden:garden', 'house:House', 'tax:tax']);

        // The phone finishes House and deletes tax; the tablet renames House earlier.
        phone = [
          for (final p in phone)
            p.id == 'house'
                ? p.copyWith(done: true, modifiedAt: _t(20))
                : p.id == 'tax'
                ? p.tombstone(_t(20))
                : p,
        ];
        tablet = [for (final p in tablet) p.id == 'house' ? p.copyWith(name: 'Home', modifiedAt: _t(10)) : p];
        tablet = (await round(h, tablet, a)).entries;
        phone = (await round(h, phone, a)).entries;
        tablet = (await round(h, tablet, a)).entries;
        expect(_describe(tablet), ['garden:garden', 'house:House (done)', 'tax†']);
        expect(_describe(phone), ['house:House (done)', 'tax†', 'garden:garden']);

        server.log.clear();
        final quiet = await round(h, tablet, a);
        expect((quiet.synced, quiet.storage), (true, ServerStorage.metadata));
        expect(server.log, ['readDocuments']);

        // Tombstones go after 30 days.
        final later = await round(h, tablet, a, now: _now.add(const Duration(days: 31)));
        expect(_describe(later.entries), ['garden:garden', 'house:House (done)']);
        await h.dispose();
      });
    });

    test('a document a newer Loupe wrote is left alone; offline, the changes wait', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        final newer = _doc(const [], version: 2);
        server.annotations[ServerDocuments.metadataEntry(ServerDocuments.projects)] = newer;
        final r = await round(h, [_p('house')], a);
        expect((r.newerFormat, r.synced), (true, false));
        expect(_describe(r.entries), ['house:house']);
        expect(server.annotations[ServerDocuments.metadataEntry(ServerDocuments.projects)], newer);

        server.annotations.clear();
        server.offline = true;
        final offline = await round(h, [_p('house')], a);
        expect(offline.failed?.kind, MailErrorKind.connection);
        expect(_describe(offline.entries), ['house:house']);
        await h.dispose();
      });
    });
  });

  group('membership', () {
    final house = Projects.keyword('house');

    test('a reply, and the user’s own message in Sent, join the project of their conversation', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer()
          ..deliver('INBOX', subject: 'Survey', messageId: 'root@x')
          ..deliver('INBOX', subject: 'Other', messageId: 'other@x');
        final a = await h.add(server);
        final root = await h.email(a, 'INBOX', 'Survey');
        await h.repo.setKeywords([root.id], add: {house});
        await settle();
        expect(server.box('INBOX').messages.values.firstWhere((m) => m.subject == 'Survey').keywords, contains(house));

        final reply = server.deliver('INBOX', subject: 'Re: Survey', inReplyTo: 'root@x', references: ['root@x']);
        final mine = server.deliver('Sent', subject: 'Re: Re: Survey', inReplyTo: reply.messageId);
        final unrelated = server.deliver('INBOX', subject: 'Re: Other', inReplyTo: 'other@x');
        await h.repo.refresh();
        await settle();
        expect((await h.email(a, 'INBOX', 'Re: Survey')).projectIds, {'house'});
        expect((await h.email(a, 'Sent', 'Re: Re: Survey')).projectIds, {'house'});
        expect((await h.email(a, 'INBOX', 'Re: Other')).projectIds, isEmpty);
        expect(reply.keywords, contains(house), reason: 'pushed to the server');
        expect(mine.keywords, contains(house));
        expect(unrelated.keywords, isNot(contains(house)));

        final threads = await h.repo.watchList(KeywordMailboxRef(house)).first;
        expect(threads.single.messageCount, 3);
        expect(await h.repo.watchKeywordUnread({house}).first, {house: 3});
        await h.repo.setKeywords([root.id], add: {Keywords.seen});
        expect(await h.repo.watchKeywordUnread({house}).first, {house: 2});
        await h.dispose();
      });
    });

    test('older messages of a project, not stored here, come from a server search once', () {
      fakeTime((async) async {
        final h = Harness(config: const SyncConfig(initialWindow: 2));
        final server = FakeServer()
          ..deliver('INBOX', subject: 'Old offer', keywords: {house})
          ..deliver('INBOX', subject: 'Old unrelated')
          ..deliver('INBOX', subject: 'New 1')
          ..deliver('INBOX', subject: 'New 2', keywords: {house});
        await h.add(server);
        final ref = KeywordMailboxRef(house);
        Future<List<String>> subjects() async => [
          for (final t in await h.repo.watchList(ref, threaded: false).first) t.latest.subject,
        ];
        expect(await subjects(), ['New 2']);
        expect(await h.repo.loadOlder(ref), isTrue);
        expect(await subjects(), ['New 2', 'Old offer']);
        expect(await h.repo.loadOlder(ref), isFalse, reason: 'once per session');
        await h.dispose();
      });
    });
  });
}
