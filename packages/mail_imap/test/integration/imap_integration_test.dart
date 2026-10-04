@Tags(['integration'])
library;

import 'dart:async';
import 'dart:convert';

import 'package:mail_imap/mail_imap.dart';
import 'package:mail_imap/src/imap/connection.dart';
import 'package:mail_imap/src/imap/parsers.dart';
import 'package:mail_imap/src/imap/protocol.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'server_env.dart';

void main() {
  final server = TestServer.fromEnvironment();
  if (server == null) {
    test('IMAP integration (set LOUPE_TEST_IMAP_HOST to run)', () {}, skip: 'LOUPE_TEST_IMAP_HOST is not set');
    return;
  }

  final runId = DateTime.now().millisecondsSinceEpoch;
  final boxPath = 'Loupe$runId';
  final otherPath = 'Loupe${runId}b';
  late ImapTransport transport;
  late ImapConnection helper;
  late RemoteMailbox box;
  late RemoteMailbox other;

  Future<int> helperUid(String subject) async {
    await helper.select(boxPath);
    final r = await helper.send(Command('UID SEARCH SUBJECT "$subject"'), SearchParser());
    return r.ids.single;
  }

  setUpAll(() async {
    transport = ImapTransport(server.account('it-$runId'), server.credentials);
    await transport.connect();
    helper = await ImapConnection.open(
      server.account('helper').incoming,
      username: server.user,
      credentials: PasswordCredentials(server.password),
    );
    await helper.send(Command('CREATE $boxPath'), GenericParser());
    await helper.send(Command('CREATE $otherPath'), GenericParser());
    final boxes = await transport.listMailboxes();
    box = boxes.firstWhere((b) => b.path == boxPath);
    other = boxes.firstWhere((b) => b.path == otherPath);
  });

  tearDownAll(() async {
    try {
      await helper.send(Command('DELETE $boxPath'), GenericParser());
      await helper.send(Command('DELETE $otherPath'), GenericParser());
    } on MailException {
      // Best effort.
    }
    await helper.logout();
    await transport.disconnect();
  });

  test('connects and reports capabilities', () {
    expect(transport.isConnected, isTrue);
    expect(transport.capabilities.raw, contains('IMAP4REV1'));
  });

  test('lists mailboxes with INBOX', () async {
    final boxes = await transport.listMailboxes();
    final inbox = boxes.firstWhere((b) => b.role == MailboxRole.inbox);
    expect(inbox.path, 'INBOX');
    expect(inbox.isSelectable, isTrue);
  });

  test('append, initial sync, older messages, incremental sync', () async {
    final appended = <String?>[];
    for (var i = 1; i <= 5; i++) {
      appended.add(
        await transport.append(
          box,
          seedMessage(subject: 'Seed $i', body: 'Body number $i'),
          keywords: {Keywords.seen},
        ),
      );
    }
    if (transport.capabilities.raw.contains('UIDPLUS')) expect(appended.nonNulls, hasLength(5));

    final first = await transport.syncMailbox(box, null, initialWindow: 3);
    expect(first.added.map((e) => e.subject), unorderedEquals(['Seed 3', 'Seed 4', 'Seed 5']));
    expect(first.hasOlder, isTrue);
    expect(first.totalCount, 5);
    expect(first.unreadCount, 0);
    expect(first.resetAll, isFalse);
    final seed5 = first.added.firstWhere((e) => e.subject == 'Seed 5');
    expect(seed5.preview, 'Body number 5');
    expect(seed5.isSeen, isTrue);
    expect(seed5.from.single.email, 'seed@example.test');

    final older = await transport.fetchOlder(box, first.state, count: 10);
    expect(older.added.map((e) => e.subject), unorderedEquals(['Seed 1', 'Seed 2']));
    expect(older.hasOlder, isFalse);

    // Changes from another client: one new, one flagged, one expunged.
    await helper.append(boxPath, seedMessage(subject: 'Seed 6'), const []);
    final flagUid = await helperUid('Seed 4');
    final goneUid = await helperUid('Seed 2');
    await helper.send(Command('UID STORE $flagUid +FLAGS.SILENT (\\Flagged)'), GenericParser());
    await helper.send(Command('UID STORE $goneUid +FLAGS.SILENT (\\Deleted)'), GenericParser());
    await helper.send(Command('EXPUNGE'), GenericParser());

    final next = await transport.syncMailbox(box, older.state);
    expect(next.added.map((e) => e.subject), ['Seed 6']);
    expect(next.unreadCount, 1);
    final flaggedId = first.added.firstWhere((e) => e.subject == 'Seed 4').id;
    expect(next.keywordUpdates[flaggedId], containsAll([Keywords.flagged, Keywords.seen]));
    expect(next.vanishedIds, [older.added.firstWhere((e) => e.subject == 'Seed 2').id]);
    expect(next.totalCount, 5);

    // Nothing changed: an incremental sync reports nothing new.
    final quiet = await transport.syncMailbox(box, next.state);
    expect(quiet.added, isEmpty);
    expect(quiet.vanishedIds, isEmpty);
    expect(quiet.keywordUpdates.values.where((k) => k.contains(Keywords.flagged)), hasLength(lessThanOrEqualTo(1)));
  });

  test('content, raw source, keywords, move and delete', () async {
    final sync = await transport.syncMailbox(box, null);
    final msg = sync.added.firstWhere((e) => e.subject == 'Seed 3');

    final content = await transport.fetchContent(msg.id);
    expect(content.text, contains('Body number 3'));
    expect(content.html, isNull);
    expect(content.headers.any((h) => h.$1 == 'Subject' && h.$2 == 'Seed 3'), isTrue);

    final raw = utf8.decode(await transport.fetchRaw(msg.id));
    expect(raw, contains('Subject: Seed 3'));

    await transport.setKeywords([msg.id], add: {Keywords.flagged, r'$label1'}, remove: {Keywords.seen});
    final summary = (await transport.fetchSummaries([msg.id])).single;
    expect(summary.keywords, containsAll([Keywords.flagged, r'$label1']));
    expect(summary.keywords, isNot(contains(Keywords.seen)));

    final moved = await transport.move([msg.id], other);
    if (transport.capabilities.raw.contains('UIDPLUS')) {
      expect(moved.keys, [msg.id]);
      expect(MailIds.parseImapEmail(moved[msg.id]!)!.path, otherPath);
    }
    final inOther = await transport.syncMailbox(other, null);
    expect(inOther.added.map((e) => e.subject), ['Seed 3']);

    await transport.deletePermanently([inOther.added.single.id]);
    final after = await transport.syncMailbox(other, inOther.state);
    expect(after.vanishedIds, [inOther.added.single.id]);
    expect(after.totalCount, 0);
  });

  test('search', () async {
    const expr = TextTerm(SearchField.subject, 'Seed 5');
    final ids = await transport.search(expr, mailbox: box);
    expect(ids, hasLength(1));
    final hit = (await transport.fetchSummaries(ids)).single;
    expect(hit.subject, 'Seed 5');
    final everywhere = await transport.search(expr);
    expect(everywhere, contains(ids.single));

    await transport.append(box, seedMessage(subject: 'Grüße aus Köln'));
    final utf8Hits = await transport.search(const TextTerm(SearchField.subject, 'grüße'), mailbox: box);
    expect((await transport.fetchSummaries(utf8Hits)).map((e) => e.subject), ['Grüße aus Köln']);

    expect(await transport.search(const SearchNot(MatchAll()), mailbox: box), isEmpty);
  });

  test('watch reports new mail via IDLE', () async {
    final events = StreamQueue(transport.watch(box));
    await Future<void>.delayed(const Duration(seconds: 1));
    await helper.append(boxPath, seedMessage(subject: 'Seed 7'), const []);
    await events.next.timeout(const Duration(seconds: 20));
    await events.cancel();
  });
}

/// Minimal stream queue (avoids a dependency on package:async).
final class StreamQueue<T> {
  StreamQueue(Stream<T> stream) {
    _sub = stream.listen(
      (e) {
        if (_waiting.isNotEmpty) {
          _waiting.removeAt(0).complete(e);
        } else {
          _buffer.add(e);
        }
      },
      onError: (Object e, StackTrace s) {
        if (_waiting.isNotEmpty) _waiting.removeAt(0).completeError(e, s);
      },
    );
  }

  late final StreamSubscription<T> _sub;
  final _buffer = <T>[];
  final _waiting = <Completer<T>>[];

  Future<T> get next {
    if (_buffer.isNotEmpty) return Future.value(_buffer.removeAt(0));
    final c = Completer<T>();
    _waiting.add(c);
    return c.future;
  }

  Future<void> cancel() => _sub.cancel();
}
