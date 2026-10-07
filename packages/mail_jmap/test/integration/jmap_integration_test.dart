@Tags(['integration'])
library;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:expr_search/expr_search.dart';
import 'package:mail_imap/mail_imap.dart';
import 'package:mail_jmap/mail_jmap.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';
import 'package:test/test.dart';

import 'stalwart_env.dart';

void main() {
  late StalwartServer server;
  late StalwartHttpClient http;
  late StalwartUser alice;
  late StalwartUser bob;

  setUpAll(() async {
    final binary = stalwartBinary();
    if (binary == null) return;
    server = await StalwartServer.start(binary: binary);
    http = StalwartHttpClient(server);
    alice = server.users[0];
    bob = server.users[1];
  });

  tearDownAll(() async {
    if (stalwartBinary() == null) return;
    http.close();
    await server.stop();
  });

  JmapTransport transport(StalwartUser user, {String id = 'acc'}) =>
      JmapTransport(stalwartAccount(server, user, id: id), credentialsOf(user), httpClient: http);

  Future<JmapTransport> connected(StalwartUser user, {String id = 'acc'}) async {
    final t = transport(user, id: id);
    await t.connect();
    return t;
  }

  RemoteMailbox boxWithRole(List<RemoteMailbox> boxes, MailboxRole role) => boxes.firstWhere((b) => b.role == role);

  /// Raw JMAP as [user] (another client).
  Future<Map<String, Object?>> other(StalwartUser user, String method, Map<String, Object?> args) async {
    final account = await server.accountId(user);
    final responses = await server.jmap(user, [
      [
        method,
        {'accountId': account, ...args},
        'x',
      ],
    ]);
    return ((responses.first! as List)[1] as Map).cast();
  }

  Future<Map<String, String>> mailboxIdsByRole(StalwartUser user) async {
    final r = await other(user, 'Mailbox/get', {
      'properties': ['role', 'name'],
    });
    return {
      for (final m in r['list']! as List) ((m as Map)['role'] as String?) ?? 'name:${m['name']}': m['id'] as String,
    };
  }

  group('JMAP against Stalwart', () {
    test('connects and lists the mailboxes with their roles', () async {
      final t = await connected(alice);
      expect(t.capabilities.raw, contains(JmapCapabilities.mail));
      expect(t.capabilities.supportsIdle, isTrue);
      final boxes = await t.listMailboxes();
      expect({for (final b in boxes) b.role}, containsAll([MailboxRole.inbox, MailboxRole.sent, MailboxRole.drafts]));
      expect(boxWithRole(boxes, MailboxRole.inbox).path, 'Inbox');
      // A second listing with nothing changed comes from Mailbox/changes.
      expect([for (final b in await t.listMailboxes()) b.path], [for (final b in boxes) b.path]);
      await t.disconnect();
    });

    test('a wrong password is an authentication error', () async {
      final t = JmapTransport(
        stalwartAccount(server, alice),
        ({bool forceRefresh = false}) async => const PasswordCredentials('wrong'),
        httpClient: http,
      );
      await expectLater(
        t.connect(),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.authentication)),
      );
    });

    test('initial and incremental sync follow changes made by another client', () async {
      final t = await connected(alice);
      await t.createMailbox('Sync');
      final boxes = await t.listMailboxes();
      final sync = boxes.firstWhere((b) => b.path == 'Sync');
      final ids = await server.importMessages(
        alice,
        [for (var i = 1; i <= 5; i++) testMessage(subject: 'Sync $i')],
        receivedAt: [for (var i = 1; i <= 5; i++) DateTime.now().subtract(Duration(minutes: 10 - i))],
      );
      // Imported into the Inbox: put them in Sync only.
      final roles = await mailboxIdsByRole(alice);
      final syncId = roles['name:Sync']!;
      await other(alice, 'Email/set', {
        'update': {
          for (final id in ids)
            id: {
              'mailboxIds': {syncId: true},
            },
        },
      });

      // Initial window of 3: the newest three, more exist.
      final first = await t.syncMailbox(sync, null, initialWindow: 3);
      expect([for (final e in first.added) e.subject], unorderedEquals(['Sync 5', 'Sync 4', 'Sync 3']));
      expect(first.hasOlder, isTrue);
      expect(first.totalCount, 5);
      expect(first.added.first.mailboxId, MailIds.mailbox('acc', 'Sync'));
      expect(MailIds.parseJmapEmail(first.added.first.id)!.path, 'Sync');

      // Older page.
      final older = await t.fetchOlder(sync, first.state, count: 10);
      expect([for (final e in older.added) e.subject], unorderedEquals(['Sync 2', 'Sync 1']));
      expect(older.hasOlder, isFalse);

      // Nothing changed.
      final idle = await t.syncMailbox(sync, older.state);
      expect(idle.added, isEmpty);
      expect(idle.vanishedIds, isEmpty);

      // Another client: flags one, moves one away, destroys one, adds one.
      final byId = {
        for (final e in [...first.added, ...older.added]) MailIds.parseJmapEmail(e.id)!.jmapId: e,
      };
      final flagged = byId.entries.firstWhere((e) => e.value.subject == 'Sync 5').key;
      final movedAway = byId.entries.firstWhere((e) => e.value.subject == 'Sync 4').key;
      final destroyed = byId.entries.firstWhere((e) => e.value.subject == 'Sync 1').key;
      await other(alice, 'Email/set', {
        'update': {
          flagged: {r'keywords/$flagged': true},
          movedAway: {
            'mailboxIds': {roles['inbox']: true},
          },
        },
        'destroy': [destroyed],
      });
      final arrived = (await server.importMessages(alice, [testMessage(subject: 'Sync 6')])).single;
      await other(alice, 'Email/set', {
        'update': {
          arrived: {
            'mailboxIds': {syncId: true},
          },
        },
      });
      final next = await t.syncMailbox(sync, idle.state);
      expect([for (final e in next.added) e.subject], ['Sync 6']);
      expect(next.keywordUpdates[MailIds.jmapEmailIn('acc', 'Sync', flagged)], contains(Keywords.flagged));
      expect(
        next.vanishedIds,
        unorderedEquals([MailIds.jmapEmailIn('acc', 'Sync', movedAway), MailIds.jmapEmailIn('acc', 'Sync', destroyed)]),
      );
      expect(next.totalCount, 4);

      // A state the server doesn't know: the window is checked instead,
      // keeping what is stored.
      final stale = MailboxSyncState({...next.state.data, 'emailState': 'bogus'});
      final resync = await t.syncMailbox(sync, stale);
      expect(resync.resetAll, isFalse);
      expect(resync.added, isEmpty);
      expect(resync.vanishedIds, isEmpty);
      expect(resync.keywordUpdates, hasLength(4));
      await t.disconnect();
    });

    test('an email in two mailboxes has a copy in each', () async {
      final t = await connected(alice);
      await t.createMailbox('Labels');
      final boxes = await t.listMailboxes();
      final inbox = boxWithRole(boxes, MailboxRole.inbox);
      final labels = boxes.firstWhere((b) => b.path == 'Labels');
      final inboxState = (await t.syncMailbox(inbox, null)).state;
      final labelsState = (await t.syncMailbox(labels, null)).state;
      final id = (await server.importMessages(alice, [testMessage(subject: 'Two places')])).single;
      final roles = await mailboxIdsByRole(alice);
      await other(alice, 'Email/set', {
        'update': {
          id: {'mailboxIds/${roles['name:Labels']}': true},
        },
      });
      final inInbox = await t.syncMailbox(inbox, inboxState);
      final inLabels = await t.syncMailbox(labels, labelsState);
      expect(inInbox.added.single.id, MailIds.jmapEmailIn('acc', 'Inbox', id));
      expect(inLabels.added.single.id, MailIds.jmapEmailIn('acc', 'Labels', id));
      expect(inInbox.added.single.threadId, inLabels.added.single.threadId);

      // Moving the Labels copy to Trash leaves the Inbox copy alone.
      final trash = boxWithRole(boxes, MailboxRole.trash);
      final moved = await t.move([inLabels.added.single.id], trash);
      expect(moved, {inLabels.added.single.id: MailIds.jmapEmailIn('acc', trash.path, id)});
      final after = await other(alice, 'Email/get', {
        'ids': [id],
        'properties': ['mailboxIds'],
      });
      expect(((after['list']! as List).single as Map)['mailboxIds'], {roles['inbox']: true, roles['trash']: true});

      // Deleting the Trash copy for good keeps the email (still in the Inbox).
      await t.deletePermanently([moved.values.single]);
      final kept = await other(alice, 'Email/get', {
        'ids': [id],
        'properties': ['mailboxIds'],
      });
      expect(((kept['list']! as List).single as Map)['mailboxIds'], {roles['inbox']: true});
      // The last copy destroys it.
      await t.deletePermanently([inInbox.added.single.id]);
      final gone = await other(alice, 'Email/get', {
        'ids': [id],
        'properties': ['mailboxIds'],
      });
      expect(gone['notFound'], [id]);
      await t.disconnect();
    });

    test('keywords and moves reach the server', () async {
      final t = await connected(alice);
      final boxes = await t.listMailboxes();
      final inbox = boxWithRole(boxes, MailboxRole.inbox);
      final archive = boxes.firstWhere((b) => b.role == MailboxRole.junk);
      final id = (await server.importMessages(alice, [testMessage(subject: 'Flag me')])).single;
      final emailId = MailIds.jmapEmailIn('acc', inbox.path, id);
      await t.setKeywords([emailId], add: {Keywords.seen, Keywords.flagged, r'$label1'});
      await t.setKeywords([emailId], remove: {Keywords.flagged});
      var r = await other(alice, 'Email/get', {
        'ids': [id],
        'properties': ['keywords'],
      });
      expect(((r['list']! as List).single as Map)['keywords'], {r'$seen': true, r'$label1': true});
      final moved = await t.move([emailId], archive);
      expect(moved[emailId], MailIds.jmapEmailIn('acc', archive.path, id));
      r = await other(alice, 'Email/get', {
        'ids': [id],
        'properties': ['mailboxIds'],
      });
      expect((((r['list']! as List).single as Map)['mailboxIds'] as Map).length, 1);
      // An email that is gone: notFound.
      await other(alice, 'Email/set', {
        'destroy': [id],
      });
      await expectLater(
        t.setKeywords([moved[emailId]!], add: {Keywords.seen}),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.notFound)),
      );
      await t.disconnect();
    });

    test('searches with Email/query', () async {
      final t = await connected(alice);
      final boxes = await t.listMailboxes();
      final inbox = boxWithRole(boxes, MailboxRole.inbox);
      await server.importMessages(alice, [
        testMessage(subject: 'Quarterly invoice zebra', from: 'Billing <billing@shop.example>'),
        testMessage(subject: 'Lunch', body: 'Bring the zebra drawings'),
        testMessage(subject: 'Unrelated'),
      ]);
      final zebra = await t.search(parseQuery('zebra').expr, mailbox: inbox);
      final subjects = [for (final s in await t.fetchSummaries(zebra)) s.subject];
      expect(subjects, unorderedEquals(['Quarterly invoice zebra', 'Lunch']));
      final fromBilling = await t.search(parseQuery('from:billing subject:invoice').expr);
      expect(fromBilling, hasLength(1));
      expect(MailIds.parseJmapEmail(fromBilling.single)!.path, inbox.path);
      // Patterns go to the server widened; the caller filters.
      final widened = await t.search(parseQuery(r'subject:/^Lun/').expr, mailbox: inbox);
      expect(widened.length, greaterThanOrEqualTo(1));
      await t.disconnect();
    });

    test('content, attachments, inline images and the raw message', () async {
      final t = await connected(alice);
      final boxes = await t.listMailboxes();
      final inbox = boxWithRole(boxes, MailboxRole.inbox);
      final png = base64.encode(List<int>.generate(64, (i) => i));
      final raw = utf8.encode(
        'From: Carol <carol@example.org>\r\n'
        'To: alice@example.test\r\n'
        'Subject: With parts\r\n'
        'Date: Mon, 5 Oct 2026 10:00:00 +0000\r\n'
        'Message-ID: <parts@example.org>\r\n'
        'List-Id: Example list <dev.lists.example.org>\r\n'
        'MIME-Version: 1.0\r\n'
        'Content-Type: multipart/mixed; boundary="mix"\r\n'
        '\r\n'
        '--mix\r\n'
        'Content-Type: multipart/related; boundary="rel"\r\n'
        '\r\n'
        '--rel\r\n'
        'Content-Type: text/html; charset=iso-8859-1\r\n'
        'Content-Transfer-Encoding: quoted-printable\r\n'
        '\r\n'
        '<p>Gr=FC=DFe <img src=3D"cid:logo@x"></p>\r\n'
        '--rel\r\n'
        'Content-Type: image/png\r\n'
        'Content-ID: <logo@x>\r\n'
        'Content-Disposition: inline\r\n'
        'Content-Transfer-Encoding: base64\r\n'
        '\r\n'
        '$png\r\n'
        '--rel--\r\n'
        '--mix\r\n'
        'Content-Type: application/pdf; name="report.pdf"\r\n'
        'Content-Disposition: attachment; filename="report.pdf"\r\n'
        'Content-Transfer-Encoding: base64\r\n'
        '\r\n'
        '${base64.encode(utf8.encode('%PDF-1.4 fake'))}\r\n'
        '--mix--\r\n',
      );
      final id = (await server.importMessages(alice, [raw])).single;
      final emailId = MailIds.jmapEmailIn('acc', inbox.path, id);
      final summary = (await t.fetchSummaries([emailId])).single;
      expect(summary.hasAttachment, isTrue);
      expect(summary.listId, 'dev.lists.example.org');
      expect(summary.listName, 'Example list');
      expect(summary.from.single, const EmailAddress('carol@example.org', 'Carol'));
      final content = await t.fetchContent(emailId);
      expect(content.html, contains('Grüße'));
      final pdf = content.visibleAttachments.single;
      expect(pdf.filename, 'report.pdf');
      expect(utf8.decode(await t.fetchAttachment(emailId, pdf.partId)), '%PDF-1.4 fake');
      expect(content.inlineData['logo@x'], Uint8List.fromList(List<int>.generate(64, (i) => i)));
      expect(content.headers.any((h) => h.$1 == 'Subject' && h.$2 == 'With parts'), isTrue);
      final source = utf8.decode(await t.fetchRaw(emailId));
      expect(source, contains('Subject: With parts'));
      await t.disconnect();
    });

    test('appends drafts and sent copies', () async {
      final t = await connected(alice);
      final boxes = await t.listMailboxes();
      final drafts = boxWithRole(boxes, MailboxRole.drafts);
      final id = await t.append(drafts, testMessage(subject: 'Draft one'), keywords: {Keywords.draft, Keywords.seen});
      expect(MailIds.parseJmapEmail(id!)!.path, drafts.path);
      final summary = (await t.fetchSummaries([id])).single;
      expect(summary.subject, 'Draft one');
      expect(summary.keywords, containsAll([Keywords.draft, Keywords.seen]));
      await t.disconnect();
    });

    test('sends between the two users through EmailSubmission, filing the copy in Sent', () async {
      final sender = JmapSender(stalwartAccount(server, alice), credentialsOf(alice), httpClient: http);
      final message = MimeMessageComposer().compose(
        const OutgoingMessage(
          accountId: 'acc',
          identityId: 'acc/default',
          to: [EmailAddress('bob@example.test', 'Bob')],
          subject: 'Hello Bob over JMAP',
          text: 'Sent with EmailSubmission.',
        ),
        const Identity(id: 'acc/default', email: 'alice@example.test', name: 'Alice'),
        messageId: 'jmap-send-1@example.test',
      );
      final receipt = await sender.send(message, envelopeFrom: alice.email, recipients: [bob.email], fileInSent: true);
      expect(receipt.filed, isTrue);
      expect(receipt.refused, isEmpty);
      await sender.close();

      // Alice: in Sent, seen, not a draft; Drafts has no copy.
      final a = await connected(alice);
      final boxes = await a.listMailboxes();
      final sent = await a.syncMailbox(boxWithRole(boxes, MailboxRole.sent), null);
      final copy = sent.added.firstWhere((e) => e.subject == 'Hello Bob over JMAP');
      expect(copy.keywords, contains(Keywords.seen));
      expect(copy.keywords, isNot(contains(Keywords.draft)));
      final drafts = await a.syncMailbox(boxWithRole(boxes, MailboxRole.drafts), null);
      expect(drafts.added.where((e) => e.subject == 'Hello Bob over JMAP'), isEmpty);

      // Bob receives it.
      final b = await connected(bob, id: 'bob');
      final inbox = boxWithRole(await b.listMailboxes(), MailboxRole.inbox);
      EmailSummary? received;
      for (var i = 0; i < 50 && received == null; i++) {
        received = (await b.syncMailbox(
          inbox,
          null,
        )).added.where((e) => e.subject == 'Hello Bob over JMAP').firstOrNull;
        if (received == null) await Future<void>.delayed(const Duration(milliseconds: 200));
      }
      expect(received, isNotNull);
      expect(received!.messageIdHeader, 'jmap-send-1@example.test');
      expect(received.from.single.email, alice.email);
      await a.disconnect();
      await b.disconnect();
    });

    test('a copy not filed in Sent is destroyed after sending', () async {
      final sender = JmapSender(stalwartAccount(server, alice), credentialsOf(alice), httpClient: http);
      final receipt = await sender.send(
        testMessage(subject: 'Bcc copy', from: alice.email, to: bob.email),
        envelopeFrom: alice.email,
        recipients: [bob.email],
      );
      expect(receipt.filed, isFalse);
      final found = await other(alice, 'Email/query', {
        'filter': {'subject': 'Bcc copy'},
      });
      expect(found['ids'], isEmpty);
    });

    test('keeps documents in the Loupe Settings mailbox, readable over IMAP too', () async {
      final t = await connected(alice);
      expect(await t.readDocuments(ServerDocuments.smartMailboxes), isEmpty);
      expect(await t.writeDocument(ServerDocuments.smartMailboxes, '{"v":1}'), ServerStorage.folder);
      final first = await t.readDocuments(ServerDocuments.smartMailboxes);
      expect(first.single.content, '{"v":1}');
      await t.writeDocument(ServerDocuments.smartMailboxes, '{"v":2}', replaces: first);
      final second = await t.readDocuments(ServerDocuments.smartMailboxes);
      expect([for (final d in second) d.content], ['{"v":2}']);
      final folder = (await t.listMailboxes()).firstWhere((b) => b.name == ServerDocuments.folderName);
      expect(folder.isSubscribed, isFalse);

      final imap = ImapTransport(stalwartImapAccount(server, alice), credentialsOf(alice));
      await imap.connect();
      final viaImap = await imap.readDocuments(ServerDocuments.smartMailboxes);
      expect(viaImap.map((d) => d.content), contains('{"v":2}'));
      await imap.disconnect();
      await t.disconnect();
    });

    test('snooze: the Snoozed mailbox and wake-time keywords', () async {
      final t = await connected(alice);
      await t.createMailbox(Snooze.folderName);
      // Again: already there is fine.
      await t.createMailbox(Snooze.folderName);
      final boxes = await t.listMailboxes();
      final snoozed = boxes.firstWhere((b) => b.path == Snooze.folderName);
      expect(snoozed.isSubscribed, isTrue);
      final inbox = boxWithRole(boxes, MailboxRole.inbox);
      final id = (await server.importMessages(alice, [testMessage(subject: 'Later')])).single;
      final emailId = MailIds.jmapEmailIn('acc', inbox.path, id);
      final keyword = Snooze.keyword(DateTime.now().add(const Duration(hours: 3)));
      final moved = await t.move([emailId], snoozed);
      await t.setKeywords(moved.values.toList(), add: {keyword});
      final sync = await t.syncMailbox(snoozed, null);
      final copy = sync.added.single;
      expect(copy.snoozedUntil, isNotNull);
      expect(sync.canStoreKeywords, isTrue);
      await t.disconnect();
    });

    test('watch hears new mail through the EventSource push', () async {
      final t = await connected(alice);
      final inbox = boxWithRole(await t.listMailboxes(), MailboxRole.inbox);
      final events = StreamIterator(t.watch(inbox));
      final next = events.moveNext();
      // Give the stream time to open, then deliver.
      await Future<void>.delayed(const Duration(seconds: 1));
      await server.deliverSmtp('dave@example.org', [alice.email], testMessage(subject: 'Pushed'));
      expect(await next.timeout(const Duration(seconds: 20)), isTrue);
      await events.cancel();
      await t.disconnect();
    });

    test('server rules over JMAP (SieveScript), no ManageSieve port needed', () async {
      final connector = JmapSieveConnector(fallback: ManageSieveConnector(port: 1), httpClient: http);
      final s = await connector.connect(stalwartAccount(server, alice), credentialsOf(alice));
      expect(s, isA<JmapSieveSession>());
      expect(s.capabilities.extensions, containsAll(['fileinto', 'imap4flags']));
      expect(s.capabilities.implementation, contains('Stalwart'));
      const script = 'require ["fileinto"];\nif header :contains "subject" "invoice" { fileinto "Projects"; }\n';
      expect(await s.checkScript(script), isNull);
      await expectLater(s.checkScript('if broken {'), throwsA(isA<SieveException>()));
      expect(await s.haveSpace('loupe', script.length), isTrue);
      await s.putScript('loupe', script);
      await s.putScript('loupe', '$script# updated\n');
      expect(await s.getScript('loupe'), '$script# updated\n');
      await s.setActive('loupe');
      expect(await s.listScripts(), contains(const SieveScriptInfo('loupe', active: true)));
      await s.putScript('spare', 'keep;\n');
      await s.deleteScript('spare');
      expect([for (final i in await s.listScripts()) i.name], isNot(contains('spare')));
      await expectLater(s.getScript('spare'), throwsA(isA<SieveException>()));
      await s.setActive('');
      expect((await s.listScripts()).any((i) => i.active), isFalse);
      await s.logout();
    });

    test('flags set over JMAP show over IMAP', () async {
      final t = await connected(alice);
      final inbox = boxWithRole(await t.listMailboxes(), MailboxRole.inbox);
      final id = (await server.importMessages(alice, [testMessage(subject: 'Cross-check')])).single;
      await t.setKeywords([MailIds.jmapEmailIn('acc', inbox.path, id)], add: {Keywords.flagged});
      final imap = ImapTransport(stalwartImapAccount(server, alice), credentialsOf(alice));
      await imap.connect();
      final imapInbox = (await imap.listMailboxes()).firstWhere((b) => b.role == MailboxRole.inbox);
      final hits = await imap.search(parseQuery('subject:Cross-check').expr, mailbox: imapInbox);
      final summary = (await imap.fetchSummaries(hits)).single;
      expect(summary.keywords, contains(Keywords.flagged));
      await imap.disconnect();
      await t.disconnect();
    });
  }, skip: stalwartSkip);
}
