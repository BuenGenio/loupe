// Scale checks for the store: query plans of the hot queries (always) and,
// with LOUPE_SCALE=40000, timings on a mailbox the size of a real inbox:
//
//   LOUPE_SCALE=40000 dart test test/scale_test.dart --reporter expanded
//
// LOUPE_PLAN=1 prints the query plans of the message lists instead.
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

/// Records the statements a store runs and how long each took.
final class _Recorder extends QueryInterceptor {
  final statements = <({String sql, List<Object?> args, Duration took})>[];

  Future<T> _time<T>(String sql, List<Object?> args, Future<T> Function() run) async {
    final watch = Stopwatch()..start();
    final result = await run();
    statements.add((sql: sql, args: args, took: watch.elapsed));
    return result;
  }

  @override
  Future<List<Map<String, Object?>>> runSelect(QueryExecutor executor, String statement, List<Object?> args) =>
      _time(statement, args, () => executor.runSelect(statement, args));

  @override
  Future<int> runUpdate(QueryExecutor executor, String statement, List<Object?> args) =>
      _time(statement, args, () => executor.runUpdate(statement, args));

  @override
  Future<int> runInsert(QueryExecutor executor, String statement, List<Object?> args) =>
      _time(statement, args, () => executor.runInsert(statement, args));

  @override
  Future<int> runDelete(QueryExecutor executor, String statement, List<Object?> args) =>
      _time(statement, args, () => executor.runDelete(statement, args));
}

final int _scale = int.tryParse(Platform.environment['LOUPE_SCALE'] ?? '') ?? 1500;
final bool _benchmark = _scale >= 10000;

void _report(String line) {
  if (_benchmark) stdout.writeln(line);
}

const _words = [
  'invoice', 'meeting', 'project', 'update', 'report', 'review', 'budget', 'release', 'schedule', 'travel', //
  'contract', 'design', 'feedback', 'question', 'payment', 'order', 'delivery', 'support', 'account', 'team',
  'weekly', 'notes', 'draft', 'proposal', 'launch', 'roadmap', 'hiring', 'offsite', 'migration', 'security',
];

/// A synthetic account: an inbox of [_scale] messages (most unread, every
/// fifth a reply in a thread), 20 folders, Sent and Archive.
Future<({MailStore store, _Recorder recorder, QueryExecutor executor, Map<String, Duration> applyTimes})>
_bigStore() async {
  final recorder = _Recorder();
  final executor = NativeDatabase.memory(setup: (db) => db.execute('PRAGMA foreign_keys = ON')).interceptWith(recorder);
  final store = MailStore.forExecutor(executor);
  await store.saveAccount(account());
  await store.replaceMailboxes(accountId, [
    ...standardMailboxes,
    for (var i = 0; i < 20; i++) RemoteMailbox(path: 'Folder$i', name: 'Folder $i'),
  ]);
  await store.setVip('sender7@example.com', vip: true);
  await store.setVip('sender42@example.com', vip: true);

  final random = Random(7);
  String sentence(int n) => [for (var i = 0; i < n; i++) _words[random.nextInt(_words.length)]].join(' ');
  var uid = 0;
  final inboxMessageIds = <String>[];
  final inboxSubjects = <String>[];

  EmailSummary message(String path, int minutes) {
    uid++;
    final isReply = path == 'INBOX' && inboxMessageIds.length > 50 && uid % 5 == 0;
    final parent = isReply ? inboxMessageIds.length - 1 - random.nextInt(50) : -1;
    final subject = isReply ? 'Re: ${inboxSubjects[parent]}' : sentence(4);
    final messageId = 'm$uid@example.com';
    if (path == 'INBOX') {
      inboxMessageIds.add(messageId);
      inboxSubjects.add(subject.replaceFirst('Re: ', ''));
    }
    final sender = random.nextInt(2000);
    // A tenth of the inbox comes from five mailing lists.
    final list = path == 'INBOX' && uid % 10 == 3 ? 'list${uid ~/ 10 % 5}.lists.example.org' : null;
    return mail(
      uid,
      path: path,
      minutes: minutes,
      subject: subject,
      from: 'sender$sender@example.com',
      fromName: 'Sender $sender',
      to: [if (random.nextInt(10) == 0) 'alias@acc1.test' else 'me@example.com'],
      cc: [if (random.nextInt(4) == 0) 'colleague${random.nextInt(50)}@example.com'],
      preview: sentence(20),
      messageId: messageId,
      inReplyTo: isReply ? inboxMessageIds[parent] : null,
      references: isReply ? [inboxMessageIds[parent]] : const [],
      keywords: {
        if (path != 'INBOX' || random.nextInt(8) == 0) Keywords.seen,
        if (random.nextInt(50) == 0) Keywords.flagged,
        if (random.nextInt(10) == 0) r'$answered',
        if (random.nextInt(30) == 0) r'$label1',
      },
      hasAttachment: random.nextInt(12) == 0,
      listId: list,
      listName: list == null ? null : 'List ${uid ~/ 10 % 5}',
    );
  }

  final applyTimes = <String, Duration>{};
  Future<void> apply(String path, int count, {required int startMinutes}) async {
    for (var done = 0; done < count; done += 2000) {
      final n = min(2000, count - done);
      final batch = [for (var i = 0; i < n; i++) message(path, startMinutes + (done + i) * 40)];
      final watch = Stopwatch()..start();
      await store.applySync(mbox(path), added(batch));
      applyTimes['$path last batch of $n'] = watch.elapsed;
    }
  }

  for (var i = 0; i < 20; i++) {
    await apply('Folder$i', _scale ~/ 80, startMinutes: 0);
  }
  await apply('Sent', _scale ~/ 20, startMinutes: 0);
  await apply('Archive', _scale ~/ 10, startMinutes: 0);
  await apply('INBOX', _scale, startMinutes: 0);
  // Copies of every 25th inbox message in Folder0 (a label, a filter's
  // copy), some arriving later there, so virtual lists must pick one copy.
  final inbox = await store.watchList(RealMailboxRef(mbox('INBOX')), threaded: false, limit: _scale).first;
  await store.applySync(
    mbox('Folder0'),
    added([
      for (final (i, t) in inbox.indexed)
        if (i % 25 == 0)
          mail(
            ++uid,
            path: 'Folder0',
            minutes: t.latest.receivedAt.difference(base).inMinutes + (i % 50 == 0 ? 90 : 0),
            subject: t.latest.subject,
            messageId: t.latest.messageIdHeader,
            keywords: t.latest.keywords,
          ),
    ]),
  );
  return (store: store, recorder: recorder, executor: executor, applyTimes: applyTimes);
}

/// The message lists computed in Dart from every row: what [MailStore.watchList]
/// must return (thread ids and latest message ids, newest first).
Future<List<(String, String, int, int)>> _expectedList(
  QueryExecutor executor,
  bool Function(Map<String, Object?> row) inScope, {
  required bool dedup,
  required bool threaded,
  required int limit,
}) async {
  final rows = await executor.runSelect('SELECT e.*, m.role FROM emails e JOIN mailboxes m ON m.id = e.mailbox_id', []);
  int rank(Map<String, Object?> r) => switch (r['role']) {
    'inbox' => 0,
    'all' => 3,
    'flagged' || 'important' => 2,
    _ => 1,
  };
  int newer(Map<String, Object?> a, Map<String, Object?> b) {
    final c = (b['received_at']! as int).compareTo(a['received_at']! as int);
    return c != 0 ? c : (b['seq']! as int).compareTo(a['seq']! as int);
  }

  var scoped = rows.where(inScope).toList();
  if (dedup) {
    final best = <String, Map<String, Object?>>{};
    for (final r in scoped) {
      final key = '${r['account_id']}|${r['message_id_header'] ?? r['id']}';
      final prev = best[key];
      if (prev == null ||
          rank(r) < rank(prev) ||
          (rank(r) == rank(prev) && (r['seq']! as int) < (prev['seq']! as int))) {
        best[key] = r;
      }
    }
    scoped = best.values.toList();
  }
  if (!threaded) {
    scoped.sort(newer);
    return [for (final r in scoped.take(limit)) (r['thread_id']! as String, r['id']! as String, 1, 0)];
  }
  final threads = <String, List<Map<String, Object?>>>{};
  for (final r in scoped) {
    (threads['${r['account_id']}|${r['thread_id']}'] ??= []).add(r);
  }
  final heads = [
    for (final members in threads.values)
      (members..sort(newer)).first
        ..['_count'] = members.length
        ..['_unread'] = members.where((m) => m['is_seen'] == 0).length,
  ]..sort(newer);
  return [
    for (final h in heads.take(limit))
      (h['thread_id']! as String, h['id']! as String, h['_count']! as int, h['_unread']! as int),
  ];
}

void main() {
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  late MailStore store;
  late _Recorder recorder;
  late QueryExecutor executor;
  late Map<String, Duration> applyTimes;

  setUpAll(() async {
    final watch = Stopwatch()..start();
    (:store, :recorder, :executor, :applyTimes) = await _bigStore();
    _report('built $_scale-message inbox in ${watch.elapsed.inMilliseconds} ms');
    for (final MapEntry(:key, :value) in applyTimes.entries) {
      if (key.startsWith('INBOX')) _report('applySync $key: ${value.inMilliseconds} ms');
    }
  });
  tearDownAll(() => store.close());

  /// Runs [action] (best of three), returns the statements of the last run
  /// and reports the time.
  Future<List<({String sql, List<Object?> args, Duration took})>> measure(
    String label,
    Future<void> Function() action,
  ) async {
    var best = const Duration(days: 1);
    for (var i = 0; i < 3; i++) {
      // Let drift drop cached stream queries so each run queries again.
      await Future<void>.delayed(const Duration(milliseconds: 5));
      recorder.statements.clear();
      final watch = Stopwatch()..start();
      await action();
      if (watch.elapsed < best) best = watch.elapsed;
    }
    _report('${label.padRight(48)} ${(best.inMicroseconds / 1000).toStringAsFixed(1).padLeft(8)} ms');
    return [...recorder.statements];
  }

  /// The query plan of [sql] as text.
  Future<String> plan(String sql, List<Object?> args) async {
    final rows = await executor.runSelect('EXPLAIN QUERY PLAN $sql', args);
    return [for (final r in rows) r['detail']].join('\n');
  }

  /// Fails if [sql] scans the whole emails table.
  Future<void> expectNoFullScan(String label, String sql, List<Object?> args) async {
    final p = await plan(sql, args);
    final scans = p.split('\n').where((l) => RegExp(r'^SCAN (e|emails)\b').hasMatch(l.trim()));
    expect(scans, isEmpty, reason: '$label scans emails:\n$p');
  }

  Future<List<({String sql, List<Object?> args, Duration took})>> first<T>(String label, Stream<T> Function() s) =>
      measure(label, () => s().first);

  final inbox = RealMailboxRef(mbox('INBOX'));

  test('message lists', () async {
    final cases = <String, Stream<List<ThreadSummary>> Function()>{
      'watchList INBOX threaded': () => store.watchList(inbox),
      'watchList INBOX flat': () => store.watchList(inbox, threaded: false),
      'watchList INBOX unread filter': () => store.watchList(inbox, filters: {QuickFilter.unread}),
      'watchList INBOX to-me filter': () => store.watchList(inbox, filters: {QuickFilter.toMe}),
      'watchList Folder3 threaded': () => store.watchList(RealMailboxRef(mbox('Folder3'))),
      'watchList All Inboxes threaded': () => store.watchList(const VirtualMailboxRef(VirtualMailbox.allInboxes)),
      'watchList Unread threaded': () => store.watchList(const VirtualMailboxRef(VirtualMailbox.unread)),
      'watchList Unread flat': () => store.watchList(const VirtualMailboxRef(VirtualMailbox.unread), threaded: false),
      'watchList Flagged': () => store.watchList(const VirtualMailboxRef(VirtualMailbox.flagged)),
      'watchList VIP': () => store.watchList(const VirtualMailboxRef(VirtualMailbox.vip)),
    };
    for (final MapEntry(:key, :value) in cases.entries) {
      if (Platform.environment['LOUPE_PLAN'] != null) {
        recorder.statements.clear();
        final sub = value().listen((_) {});
        await Future<void>.delayed(const Duration(milliseconds: 200));
        final st = recorder.statements.where((s) => s.sql.startsWith('WITH me(addr)')).firstOrNull;
        stdout.writeln('== $key ${st?.took}');
        if (st != null) stdout.writeln(await plan(st.sql, st.args));
        await sub.cancel();
        continue;
      }
      final statements = await first(key, value);
      final list = statements.singleWhere((s) => s.sql.startsWith('WITH me(addr)'));
      expect((await value().first), isNotEmpty, reason: key);
      if (key.contains('INBOX') || key.contains('Folder')) {
        await expectNoFullScan(key, list.sql, list.args);
      }
    }
  });

  test('lists hold the newest threads, one copy per message', () async {
    final roles = {for (final m in await store.getMailboxes()) m.id: m.role.name};
    bool virtualOk(Map<String, Object?> r, {bool mine = true}) {
      final role = roles[r['mailbox_id']]!;
      const excluded = {'trash', 'junk', 'all', 'flagged', 'important'};
      return !excluded.contains(role) && (!mine || (role != 'sent' && role != 'drafts'));
    }

    final cases = <String, (MailboxRef, Set<QuickFilter>, bool Function(Map<String, Object?>))>{
      'INBOX': (inbox, const {}, (r) => r['mailbox_id'] == mbox('INBOX')),
      'INBOX unread': (inbox, {QuickFilter.unread}, (r) => r['mailbox_id'] == mbox('INBOX') && r['is_seen'] == 0),
      'Folder0': (RealMailboxRef(mbox('Folder0')), const {}, (r) => r['mailbox_id'] == mbox('Folder0')),
      'All Inboxes': (
        const VirtualMailboxRef(VirtualMailbox.allInboxes),
        const {},
        (r) => roles[r['mailbox_id']] == 'inbox',
      ),
      'Unread': (const VirtualMailboxRef(VirtualMailbox.unread), const {}, (r) => r['is_seen'] == 0 && virtualOk(r)),
      'Flagged': (
        const VirtualMailboxRef(VirtualMailbox.flagged),
        const {},
        (r) => r['is_flagged'] == 1 && virtualOk(r, mine: false),
      ),
    };
    for (final MapEntry(key: label, value: (ref, filters, inScope)) in cases.entries) {
      for (final threaded in [true, false]) {
        for (final limit in [30, 200]) {
          final actual = [
            for (final t in await store.watchList(ref, filters: filters, threaded: threaded, limit: limit).first)
              (t.threadId, t.latest.id, threaded ? t.messageCount : 1, threaded ? t.unreadCount : 0),
          ];
          final expected = await _expectedList(
            executor,
            inScope,
            dedup: ref is VirtualMailboxRef,
            threaded: threaded,
            limit: limit,
          );
          expect(actual, expected, reason: '$label threaded: $threaded limit: $limit');
        }
      }
    }
  });

  test('mailing lists', () async {
    final lists = await store.watchMailingLists().first;
    expect(lists, hasLength(5));
    await first('watchMailingLists', store.watchMailingLists);
    await first('watchListThreads', () => store.watchListThreads(lists.first.id));
  });

  test('virtual counts', () async {
    final statements = await first('watchVirtualCounts', store.watchVirtualCounts);
    final counts = await store.watchVirtualCounts().first;
    expect(counts[VirtualMailbox.unread], greaterThan(_scale ~/ 2));
    _report('  ${statements.length} statement(s)');
  });

  test('conversation', () async {
    final threads = await store.watchList(inbox).first;
    final thread = threads.firstWhere((t) => t.messageCount > 1);
    final statements = await first('watchConversation', () => store.watchConversation(thread.latest.id));
    expect((await store.watchConversation(thread.latest.id).first).length, thread.messageCount);
    final sql = statements.last;
    await expectNoFullScan('watchConversation', sql.sql, sql.args);
  });

  test('search while typing', () async {
    for (final text in ['i', 'in', 'inv', 'invo', 'invoice', 'invoice bud', 'f:sender42', 'sender42 invoice']) {
      final expr = parseQuery(text).expr;
      await measure('search "$text" everywhere', () => store.search(expr));
      final statements = await measure('search "$text" in INBOX', () => store.search(expr, scope: MailboxScope(inbox)));
      expect(statements, isNotEmpty);
    }
    await measure('search is:unread (Smart Mailbox)', () => store.search(parseQuery('is:unread').expr));
    await measure('search flagged with attachment', () => store.search(parseQuery('is:flagged has:attachment').expr));
  });

  test('keyword change on one message', () async {
    final threads = await store.watchList(inbox).first;
    final id = threads.first.latest.id;
    await measure('updateKeywords (1 message)', () async {
      final previous = await store.updateKeywords([id], add: {Keywords.seen});
      await store.restoreKeywords(previous);
    });
  });

  test('keyword refresh of 2000 messages', () async {
    final threads = await store.watchList(inbox, threaded: false, limit: 2000).first;
    final sets = {
      for (final t in threads) t.latest.id: {...t.latest.keywords, Keywords.flagged},
    };
    final statements = await measure('applySync 2000 keyword updates', () async {
      await store.applySync(
        mbox('INBOX'),
        MailboxSyncResult(state: const MailboxSyncState({'v': 2}), keywordUpdates: sets),
      );
      final unflag = {
        for (final MapEntry(:key, :value) in sets.entries) key: value.difference({Keywords.flagged}),
      };
      await store.applySync(
        mbox('INBOX'),
        MailboxSyncResult(state: const MailboxSyncState({'v': 3}), keywordUpdates: unflag),
      );
    });
    _report('  ${statements.length} statement(s)');
  });

  test('apply a batch of 2000 new messages', () async {
    final statements = recorder.statements;
    expect(applyTimes, isNotEmpty);
    expect(statements, isA<List<Object?>>());
  });
}
