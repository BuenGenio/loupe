import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:expr_search/expr_search.dart';
import 'package:mail_jmap/mail_jmap.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/scripted_jmap.dart';

/// Stalwart's mailboxes (recorded: Inbox `a`, Deleted Items `b`, Junk Mail
/// `c`, Drafts `d`, Sent Items `e`) and a few of the user's.
final _boxes = mailboxList([
  mailbox('h', 'Projects'),
  mailbox('i', '2026', parentId: 'h'),
  mailbox('j', ServerDocuments.folderName, subscribed: false),
]);

String _id(String path, String jmapId) => MailIds.jmapEmailIn('acc', path, jmapId);

Future<(JmapTransport, ScriptedJmap)> _connected({void Function(ScriptedJmap)? script, Json? session}) async {
  final jmap = ScriptedJmap(session: session)
    ..on('Mailbox/get', (args) => args['ids'] == null ? _boxes : _counts(args));
  script?.call(jmap);
  final t = JmapTransport(
    scriptedAccount(),
    passwordCallback(),
    httpClient: jmap.client,
    pollInterval: const Duration(milliseconds: 20),
  );
  await t.connect();
  return (t, jmap);
}

Json _counts(Json args, {int total = 3, int unread = 1}) => {
  'accountId': 'c',
  'state': 'm1',
  'list': [
    for (final id in args['ids']! as List) {'id': id, 'totalEmails': total, 'unreadEmails': unread},
  ],
  'notFound': <String>[],
};

RemoteMailbox _remote(List<RemoteMailbox> boxes, String path) => boxes.firstWhere((b) => b.path == path);

void main() {
  group('mailboxes', () {
    test('get paths from their parents, roles and subscriptions', () async {
      final (t, _) = await _connected();
      final boxes = await t.listMailboxes();
      final byPath = {for (final b in boxes) b.path: b};
      expect(byPath['Inbox']!.role, MailboxRole.inbox);
      expect(byPath['Deleted Items']!.role, MailboxRole.trash);
      expect(byPath['Sent Items']!.role, MailboxRole.sent);
      expect(byPath['Junk Mail']!.role, MailboxRole.junk);
      expect(byPath['Projects/2026']!.parentPath, 'Projects');
      expect(byPath['Projects/2026']!.name, '2026');
      expect(byPath[ServerDocuments.folderName]!.isSubscribed, isFalse);
    });

    test('are listed again only when Mailbox/changes says more than the counts changed', () async {
      final (t, jmap) = await _connected(
        script: (j) => j
          ..on(
            'Mailbox/changes',
            (_) => {
              'oldState': 'sai',
              'newState': 'sak',
              'hasMoreChanges': false,
              'created': <String>[],
              'updated': ['a'],
              'destroyed': <String>[],
              'updatedProperties': ['totalEmails', 'unreadEmails'],
            },
          )
          ..on(
            'Mailbox/changes',
            (_) => {
              'oldState': 'sak',
              'newState': 'sam',
              'hasMoreChanges': false,
              'created': ['k'],
              'updated': <String>[],
              'destroyed': <String>[],
              'updatedProperties': null,
            },
          ),
      );
      await t.listMailboxes();
      await t.listMailboxes();
      expect(jmap.callsOf('Mailbox/get'), hasLength(1));
      await t.listMailboxes();
      expect(jmap.callsOf('Mailbox/get'), hasLength(2));
    });

    test('creating one that exists already is fine; subscribing goes to the server', () async {
      final (t, jmap) = await _connected(
        script: (j) => j.on('Mailbox/set', (args) {
          if (args['create'] != null) {
            return {
              'notCreated': {
                'm': {'type': 'alreadyExists', 'existingId': 'h'},
              },
            };
          }
          return {
            'updated': {'h': null},
          };
        }),
      );
      await t.createMailbox('Snoozed');
      expect(jmap.callsOf('Mailbox/set').single['create'], {
        'm': {'name': 'Snoozed', 'parentId': null, 'isSubscribed': true},
      });
      await t.setSubscribed(const RemoteMailbox(path: 'Projects', name: 'Projects'), false);
      expect(jmap.callsOf('Mailbox/set').last['update'], {
        'h': {'isSubscribed': false},
      });
      await expectLater(
        t.setSubscribed(const RemoteMailbox(path: 'Gone', name: 'Gone'), true),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.notFound)),
      );
    });
  });

  group('sync', () {
    test('first sync: the newest emails of the mailbox, from the state before the query', () async {
      final (t, jmap) = await _connected(
        script: (j) => j
          ..on('Email/get', (args) {
            final ids = (args['ids']! as List).cast<String>();
            if (ids.isEmpty) return {'state': 's1', 'list': <Object>[], 'notFound': <String>[]};
            return emailGet({
              'e1': emailJson('e1', subject: 'One'),
              'e2': emailJson('e2', subject: 'Two', keywords: {r'$seen': true}),
              // Moved elsewhere between the query and the get.
              'e3': emailJson('e3', mailboxIds: {'h': true}),
            })(args);
          })
          ..on(
            'Email/query',
            (args) => {
              'ids': ['e1', 'e2', 'e3'],
              'position': 0,
              'total': 5,
              'queryState': 'q1',
            },
          ),
      );
      final inbox = _remote(await t.listMailboxes(), 'Inbox');
      final r = await t.syncMailbox(inbox, null, initialWindow: 3);
      final query = jmap.callsOf('Email/query').single;
      expect(query['filter'], {'inMailbox': 'a'});
      expect(query['sort'], [
        {'property': 'receivedAt', 'isAscending': false},
      ]);
      expect(query['limit'], 3);
      expect([for (final e in r.added) e.id], [_id('Inbox', 'e1'), _id('Inbox', 'e2')]);
      expect(r.added.first.mailboxId, MailIds.mailbox('acc', 'Inbox'));
      expect(r.added[1].isSeen, isTrue);
      expect(r.totalCount, 3);
      expect(r.unreadCount, 1);
      expect(r.hasOlder, isTrue);
      expect(r.canStoreKeywords, isTrue);
      expect(r.state.data['emailState'], 's1');
      expect(r.state.data['ids'], ['e1', 'e2']);
    });

    test('maps a recorded Stalwart email to a list row', () async {
      final recorded = recordedArgs('email_get_summary');
      final (t, _) = await _connected(script: (j) => j.on('Email/get', (_) => recorded));
      await t.listMailboxes();
      final s = (await t.fetchSummaries([_id('Inbox', 'eaaaaab')])).single;
      expect(s.subject, 'Quarterly report – draft');
      expect(s.from.single, const EmailAddress('carol@example.org', 'Carol Example'));
      expect(s.to, [const EmailAddress('alice@example.test', 'Alice'), const EmailAddress('bob@example.test')]);
      expect(s.cc.single.name, 'Jürgen');
      expect(s.threadId, 'acc|jmthread|b');
      expect(s.messageIdHeader, 'report-1@example.org');
      expect(s.inReplyTo, 'earlier@example.org');
      expect(s.references, ['first@example.org', 'earlier@example.org']);
      expect(s.receivedAt, DateTime.utc(2026, 10, 5, 8, 0, 5));
      expect(s.sentAt, DateTime.utc(2026, 10, 5, 8));
      expect(s.keywords, {Keywords.seen});
      expect(s.size, 1417);
      expect(s.preview, 'Hello Alice, here is the draft.');
      expect(s.hasAttachment, isTrue);
      expect(s.isEncrypted, isFalse);
      expect(s.listId, 'dev.lists.example.org');
      expect(s.listName, 'Example developers');
      expect(s.listPost, '<mailto:dev@lists.example.org>');
      expect(s.listUnsubscribe, '<https://lists.example.org/u?x=1>, <mailto:dev-leave@lists.example.org>');
      expect(s.listUnsubscribePost, 'List-Unsubscribe=One-Click');
    });

    test('incremental sync follows Email/changes over several rounds', () async {
      final emails = {
        'e1': emailJson('e1', keywords: {r'$flagged': true}),
        'e2': emailJson('e2', mailboxIds: {'h': true}),
        'e3': emailJson('e3', subject: 'New', receivedAt: '2026-10-06T08:00:00Z'),
      };
      final (t, jmap) = await _connected(
        script: (j) => j
          ..on(
            'Email/changes',
            (args) => {
              'oldState': 's1',
              'newState': 's2',
              'hasMoreChanges': true,
              'created': ['e3'],
              'updated': ['e1'],
              'destroyed': <String>[],
            },
          )
          ..on(
            'Email/changes',
            (args) => {
              'oldState': 's2',
              'newState': 's3',
              'hasMoreChanges': false,
              'created': <String>[],
              'updated': ['e2'],
              'destroyed': ['e9'],
            },
          )
          ..on('Email/get', emailGet(emails)),
      );
      final inbox = _remote(await t.listMailboxes(), 'Inbox');
      final previous = MailboxSyncState({
        'jmap': 1,
        'account': 'c',
        'mailbox': 'a',
        'emailState': 's1',
        'ids': ['e1', 'e2', 'e9'],
        'total': 3,
      });
      final r = await t.syncMailbox(inbox, previous);
      expect([for (final c in jmap.callsOf('Email/changes')) c['sinceState']], ['s1', 's2']);
      expect(jmap.callsOf('Email/changes').first['maxChanges'], 500);
      expect([for (final e in r.added) e.subject], ['New']);
      expect(r.keywordUpdates, {
        _id('Inbox', 'e1'): {Keywords.flagged},
      });
      expect(r.vanishedIds, unorderedEquals([_id('Inbox', 'e2'), _id('Inbox', 'e9')]));
      expect(r.resetAll, isFalse);
      expect(r.state.data['emailState'], 's3');
      expect(r.state.data['ids'], ['e3', 'e1']);
    });

    test('cannotCalculateChanges checks the window instead, keeping what is stored', () async {
      final (t, jmap) = await _connected(
        script: (j) => j
          ..fail('Email/changes', 'cannotCalculateChanges')
          ..on(
            'Email/query',
            (args) => {
              'ids': ['e5', 'e1'],
              'position': 0,
              'total': 2,
            },
          )
          ..on('Email/get', (args) {
            final ids = (args['ids']! as List).cast<String>();
            if (ids.isEmpty) return {'state': 's9', 'list': <Object>[], 'notFound': <String>[]};
            return emailGet({
              'e1': emailJson('e1', keywords: {r'$seen': true}),
              'e5': emailJson('e5', subject: 'Missed'),
            })(args);
          }),
      );
      final inbox = _remote(await t.listMailboxes(), 'Inbox');
      final previous = MailboxSyncState({
        'jmap': 1,
        'account': 'c',
        'mailbox': 'a',
        'emailState': 'old',
        'ids': ['e1', 'e2'],
        'total': 2,
      });
      final r = await t.syncMailbox(inbox, previous);
      expect(r.resetAll, isFalse);
      expect([for (final e in r.added) e.subject], ['Missed']);
      expect(r.vanishedIds, [_id('Inbox', 'e2')]);
      expect(r.keywordUpdates, {
        _id('Inbox', 'e1'): {Keywords.seen},
      });
      expect(r.state.data['emailState'], 's9');
      expect(r.state.data['ids'], ['e5', 'e1']);
      expect(jmap.callsOf('Email/query').single['filter'], {'inMailbox': 'a'});
    });

    test('a state of another mailbox at the same path starts over', () async {
      final (t, _) = await _connected(
        script: (j) => j
          ..on('Email/get', (args) => {'state': 's1', 'list': <Object>[], 'notFound': <String>[]})
          ..on('Email/query', (args) => {'ids': <String>[], 'position': 0, 'total': 0}),
      );
      final inbox = _remote(await t.listMailboxes(), 'Inbox');
      final r = await t.syncMailbox(
        inbox,
        const MailboxSyncState({'jmap': 1, 'account': 'c', 'mailbox': 'zz', 'emailState': 's0', 'ids': <String>[]}),
      );
      expect(r.resetAll, isTrue);
    });

    test('older emails page after the oldest known one', () async {
      final (t, jmap) = await _connected(
        script: (j) => j
          ..on(
            'Email/query',
            (args) => {
              'ids': ['e7', 'e8'],
              'position': 2,
              'total': 4,
            },
          )
          ..on('Email/get', emailGet({'e7': emailJson('e7'), 'e8': emailJson('e8')})),
      );
      final inbox = _remote(await t.listMailboxes(), 'Inbox');
      final r = await t.fetchOlder(
        inbox,
        const MailboxSyncState({
          'jmap': 1,
          'account': 'c',
          'mailbox': 'a',
          'emailState': 's1',
          'ids': ['e1', 'e2'],
          'total': 4,
        }),
        count: 2,
      );
      final query = jmap.callsOf('Email/query').single;
      expect(query['anchor'], 'e2');
      expect(query['anchorOffset'], 1);
      expect(r.added, hasLength(2));
      expect(r.hasOlder, isFalse);
      expect(r.state.data['ids'], ['e1', 'e2', 'e7', 'e8']);
    });
  });

  group('copies in several mailboxes', () {
    test('moving a copy takes it out of its mailbox only', () async {
      final (t, jmap) = await _connected(
        script: (j) => j.on(
          'Email/set',
          (args) => {
            'updated': {for (final id in (args['update']! as Map).keys) id: null},
          },
        ),
      );
      final boxes = await t.listMailboxes();
      final trash = _remote(boxes, 'Deleted Items');
      final moved = await t.move([_id('Inbox', 'e1'), _id('Projects', 'e1'), _id('Projects', 'e2')], trash);
      expect(jmap.callsOf('Email/set').single['update'], {
        'e1': {'mailboxIds/b': true, 'mailboxIds/a': null, 'mailboxIds/h': null},
        'e2': {'mailboxIds/b': true, 'mailboxIds/h': null},
      });
      expect(moved, {
        _id('Inbox', 'e1'): _id('Deleted Items', 'e1'),
        _id('Projects', 'e1'): _id('Deleted Items', 'e1'),
        _id('Projects', 'e2'): _id('Deleted Items', 'e2'),
      });
    });

    test('deleting a copy for good destroys the email only when no other mailbox has it', () async {
      final (t, jmap) = await _connected(
        script: (j) => j
          ..on(
            'Email/get',
            emailGet({
              'e1': emailJson('e1', mailboxIds: {'b': true, 'a': true}),
              'e2': emailJson('e2', mailboxIds: {'b': true}),
            }),
          )
          ..on(
            'Email/set',
            (args) => {
              'updated': {for (final id in (args['update'] as Map? ?? const {}).keys) id: null},
              'destroyed': args['destroy'],
            },
          ),
      );
      await t.listMailboxes();
      await t.deletePermanently([_id('Deleted Items', 'e1'), _id('Deleted Items', 'e2')]);
      final set = jmap.callsOf('Email/set').single;
      expect(set['update'], {
        'e1': {'mailboxIds/b': null},
      });
      expect(set['destroy'], ['e2']);
    });

    test('keywords are patched with escaped names; a gone email is notFound', () async {
      final (t, jmap) = await _connected(
        script: (j) => j
          ..on(
            'Email/set',
            (args) => {
              'updated': {'e1': null},
            },
          )
          ..on(
            'Email/set',
            (args) => {
              'notUpdated': {
                'e1': {'type': 'notFound'},
              },
            },
          ),
      );
      await t.listMailboxes();
      await t.setKeywords([_id('Inbox', 'e1')], add: {r'$Seen', 'a/b~c'}, remove: {r'$flagged', r'$seen'});
      expect(jmap.callsOf('Email/set').single['update'], {
        'e1': {r'keywords/$seen': true, 'keywords/a~1b~0c': true, r'keywords/$flagged': null},
      });
      await expectLater(
        t.setKeywords([_id('Inbox', 'e1')], add: {Keywords.seen}),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.notFound)),
      );
      expect(() => t.setKeywords(['acc|INBOX|1|2'], add: {Keywords.seen}), throwsA(isA<MailException>()));
    });
  });

  group('search', () {
    test('compiles the query with compileJmapFilter, widened, inside the mailbox', () async {
      final (t, jmap) = await _connected(
        script: (j) => j
          ..on(
            'Email/query',
            (args) => {
              'ids': ['e1'],
              'position': 0,
            },
          )
          ..on('Email/get', emailGet({'e1': emailJson('e1')})),
      );
      final inbox = _remote(await t.listMailboxes(), 'Inbox');
      final expr = parseQuery(r'from:carol subject:/^Re/ is:unread').expr;
      final ids = await t.search(expr, mailbox: inbox);
      expect(ids, [_id('Inbox', 'e1')]);
      final filter = jmap.callsOf('Email/query').single['filter']! as Map;
      expect(filter['operator'], 'AND');
      expect((filter['conditions']! as List).first, {'inMailbox': 'a'});
      expect((filter['conditions']! as List)[1], compileJmapFilter(widenForServer(expr, jmapSupports)));
      final text = jsonEncode(filter);
      expect(text, contains('"from":"carol"'));
      expect(text, contains(r'"notKeyword":"$seen"'));
      expect(text, isNot(contains('^Re')));
    });

    test('in all mailboxes leaves out the documents mailbox and shows each hit’s best copy', () async {
      final (t, jmap) = await _connected(
        script: (j) => j
          ..on(
            'Email/query',
            (args) => {
              'ids': ['e1', 'e2', 'e3'],
              'position': 0,
            },
          )
          ..on(
            'Email/get',
            emailGet({
              'e1': emailJson('e1', mailboxIds: {'h': true, 'a': true}),
              'e2': emailJson('e2', mailboxIds: {'b': true, 'i': true}),
              'e3': emailJson('e3', mailboxIds: {'j': true}),
            }),
          ),
      );
      await t.listMailboxes();
      final ids = await t.search(parseQuery('report').expr);
      expect(ids, [_id('Inbox', 'e1'), _id('Projects/2026', 'e2')]);
      expect(jmap.callsOf('Email/query').single['filter'], {
        'operator': 'AND',
        'conditions': [
          {
            'inMailboxOtherThan': ['j'],
          },
          {'text': 'report'},
        ],
      });
    });

    test('a query that can’t match this account never reaches the server', () async {
      final (t, jmap) = await _connected();
      await t.listMailboxes();
      expect(await t.search(parseQuery('account:nowhere').expr), isEmpty);
      expect(jmap.callsOf('Email/query'), isEmpty);
    });
  });

  group('messages', () {
    test('content from the recorded body values, inline images and attachments by blob', () async {
      final recorded = recordedArgs('email_get_content');
      final (t, jmap) = await _connected(script: (j) => j.on('Email/get', (_) => recorded));
      final email = (recorded['list']! as List).single as Map;
      String blobOf(String type) {
        String? find(Map<Object?, Object?> part) {
          if (part['type'] == type) return part['blobId'] as String?;
          for (final p in part['subParts'] as List? ?? const []) {
            if (find(p as Map<Object?, Object?>) case final b?) return b;
          }
          return null;
        }

        return find(email['bodyStructure'] as Map<Object?, Object?>)!;
      }

      jmap.blobs[blobOf('image/png')] = Uint8List.fromList(base64.decode('iVBORw0KGgo='));
      jmap.blobs[blobOf('application/pdf')] = Uint8List.fromList(utf8.encode('%PDF-1.4 fake'));
      await t.listMailboxes();
      final id = _id('Inbox', 'eaaaaab');
      final c = await t.fetchContent(id);
      expect(c.text, 'Hello Alice,\nhere is the draft.');
      expect(c.isFlowed, isTrue);
      expect(c.html, contains('Grüße'));
      expect(c.inlineData['chart@example.org'], base64.decode('iVBORw0KGgo='));
      final pdf = c.visibleAttachments.single;
      expect(pdf.filename, 'report.pdf');
      expect(pdf.mimeType, 'application/pdf');
      expect(pdf.partId, blobOf('application/pdf'));
      expect(utf8.decode(await t.fetchAttachment(id, pdf.partId)), '%PDF-1.4 fake');
      expect(c.headers, contains(('Subject', 'Quarterly report – draft')));
      expect(c.headers, contains(('Cc', 'Jürgen <juergen@example.org>')));
    });

    test('a text part without a body value is downloaded and decoded', () async {
      final (t, jmap) = await _connected(
        script: (j) => j.on(
          'Email/get',
          (_) => {
            'list': [
              {
                'id': 'e1',
                'headers': <Object>[],
                'bodyValues': <String, Object>{},
                'bodyStructure': {
                  'partId': '1',
                  'blobId': 'latin',
                  'size': 5,
                  'type': 'text/plain',
                  'charset': 'iso-8859-1',
                  'header:Content-Type': ' text/plain; charset=iso-8859-1',
                },
              },
            ],
          },
        ),
      );
      jmap.blobs['latin'] = Uint8List.fromList(latin1.encode('Grüße'));
      await t.listMailboxes();
      expect((await t.fetchContent(_id('Inbox', 'e1'))).text, 'Grüße');
    });

    test('appends by upload and Email/import, also when the server knows the message', () async {
      final (t, jmap) = await _connected(
        script: (j) => j
          ..on(
            'Email/import',
            (args) => {
              'created': {
                'm': {'id': 'e10', 'blobId': 'x', 'threadId': 't', 'size': 3},
              },
            },
          )
          ..on(
            'Email/import',
            (args) => {
              'notCreated': {
                'm': {'type': 'alreadyExists', 'existingId': 'e4'},
              },
            },
          )
          ..on(
            'Email/set',
            (args) => {
              'updated': {'e4': null},
            },
          ),
      );
      final drafts = _remote(await t.listMailboxes(), 'Drafts');
      final id = await t.append(
        drafts,
        Uint8List.fromList(utf8.encode('Subject: d\r\n\r\nx')),
        keywords: {Keywords.draft},
      );
      expect(id, _id('Drafts', 'e10'));
      final import = (jmap.callsOf('Email/import').single['emails']! as Map)['m'] as Map;
      expect(import['mailboxIds'], {'d': true});
      expect(import['keywords'], {Keywords.draft: true});
      expect(utf8.decode(jmap.blobs[import['blobId']]!), 'Subject: d\r\n\r\nx');
      expect(await t.append(drafts, Uint8List(1)), _id('Drafts', 'e4'));
      expect(jmap.callsOf('Email/set').single['update'], {
        'e4': {'mailboxIds/d': true},
      });
    });
  });

  group('documents', () {
    test('are read from the Loupe Settings mailbox and replaced there', () async {
      final (t, jmap) = await _connected(
        script: (j) => j
          ..on(
            'Email/query',
            (args) => {
              'ids': ['d2', 'd1', 'd3'],
              'position': 0,
            },
          )
          ..on(
            'Email/get',
            (args) => {
              'list': [
                for (final (id, name, value) in [
                  ('d2', ServerDocuments.smartMailboxes, '{"v":2}'),
                  ('d1', ServerDocuments.smartMailboxes, '{"v":1}'),
                  ('d3', 'other', '{}'),
                ])
                  {
                    'id': id,
                    'header:${ServerDocuments.header}': ' $name',
                    'textBody': [
                      {'partId': '1'},
                    ],
                    'bodyValues': {
                      '1': {'value': '$value\n'},
                    },
                  },
              ],
            },
          )
          ..on(
            'Email/import',
            (args) => {
              'created': {
                'm': {'id': 'd4'},
              },
            },
          )
          ..on('Email/set', (args) => {'destroyed': args['destroy']}),
      );
      final docs = await t.readDocuments(ServerDocuments.smartMailboxes);
      expect([for (final d in docs) d.content], ['{"v":1}', '{"v":2}']);
      expect(docs.first.ref, _id(ServerDocuments.folderName, 'd1'));
      expect(jmap.callsOf('Email/query').single['filter'], {'inMailbox': 'j'});
      expect(await t.writeDocument(ServerDocuments.smartMailboxes, '{"v":3}', replaces: docs), ServerStorage.folder);
      final import = (jmap.callsOf('Email/import').single['emails']! as Map)['m'] as Map;
      expect(import['mailboxIds'], {'j': true});
      final message = utf8.decode(jmap.blobs[import['blobId']]!);
      expect(message, contains('${ServerDocuments.header}: ${ServerDocuments.smartMailboxes}'));
      expect(jmap.callsOf('Email/set').single['destroy'], ['d1', 'd2']);
    });
  });

  group('watch', () {
    test('without push, polls the Email state and reports changes', () async {
      final session = fixture('session')..remove('eventSourceUrl');
      final states = ['s1', 's1', 's2', 's2'];
      final (t, _) = await _connected(
        session: session,
        script: (j) => j.on(
          'Email/get',
          (_) => {'state': states.length > 1 ? states.removeAt(0) : states.first, 'list': <Object>[]},
        ),
      );
      final inbox = _remote(await t.listMailboxes(), 'Inbox');
      final events = StreamIterator(t.watch(inbox));
      expect(await events.moveNext().timeout(const Duration(seconds: 5)), isTrue);
      await events.cancel();
    });
  });
}
