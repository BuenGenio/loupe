// Two connections to one file, as the app and a background isolate (sync,
// notification actions, Instant Delivery) hold them, contending for it.
import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

const _sqliteBusy = 5;

OutboxEntry _entry(String id, {OutboxStatus status = OutboxStatus.queued}) => OutboxEntry(
  id: id,
  accountId: accountId,
  message: OutgoingMessage(accountId: accountId, identityId: '$accountId/default', subject: id),
  sendAfter: base,
  createdAt: base,
  status: status,
);

void main() {
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  late Directory dir;
  late String path;
  final open = <MailStore>[];

  /// A connection of its own, on its own isolate, like each process has.
  Future<MailStore> connect() async {
    final store = await MailStore.open(path, encryptionKey: 'k');
    open.add(store);
    return store;
  }

  /// A plain connection that never waits for a lock.
  Database raw() {
    final db = sqlite3.open(path)
      ..execute("PRAGMA key = 'k'")
      ..execute('PRAGMA busy_timeout = 0');
    addTearDown(db.close);
    return db;
  }

  setUp(() async {
    dir = Directory.systemTemp.createTempSync('mail_store_concurrency');
    path = '${dir.path}/mail.db';
    final first = await connect();
    await first.saveAccount(account());
    await first.replaceMailboxes(accountId, standardMailboxes);
  });

  tearDown(() async {
    for (final s in open) {
      await s.close();
    }
    open.clear();
    dir.deleteSync(recursive: true);
  });

  test('a transaction takes the write lock when it begins, before its first read', () async {
    final app = open.single;
    final started = Completer<void>();
    final gate = Completer<void>();
    final transaction = app.transaction(() async {
      await app.getOutbox('o1');
      started.complete();
      await gate.future;
      await app.putOutbox(_entry('o1'));
    });
    await started.future;
    // A deferred transaction would hold only a read snapshot here.
    final other = raw();
    expect(
      () => other.execute('BEGIN IMMEDIATE'),
      throwsA(isA<SqliteException>().having((e) => e.resultCode, 'resultCode', _sqliteBusy)),
    );
    gate.complete();
    await transaction;
    other
      ..execute('BEGIN IMMEDIATE')
      ..execute('ROLLBACK');
  });

  test('a read-then-write transaction and a write on another connection wait for each other', () async {
    final app = open.single;
    final background = await connect();
    await app.putOutbox(_entry('o1'));
    final started = Completer<void>();
    final gate = Completer<void>();
    // The app reads, decides, then writes (like takeOutbox or applySync).
    final transaction = app.transaction(() async {
      final seen = (await app.getOutbox('o1'))!;
      started.complete();
      await gate.future;
      await app.updateOutbox('o1', status: OutboxStatus.failed, lastError: 'saw ${seen.status.name}');
    });
    await started.future;
    // Background work writes meanwhile: it waits (busy timeout) instead of
    // committing under the app's snapshot, which would fail the app's write
    // with SQLITE_BUSY_SNAPSHOT.
    var written = false;
    final write = background.putOutbox(_entry('o2')).then((_) => written = true);
    await Future<void>.delayed(const Duration(milliseconds: 300));
    expect(written, isFalse);
    gate.complete();
    await transaction;
    await write;
    expect((await background.getOutbox('o1'))!.lastError, 'saw queued');
    expect([for (final e in await app.outboxEntries()) e.id]..sort(), ['o1', 'o2']);
  });

  test('two processes race for the outbox, new mail and the rules watermark', () async {
    final app = open.single;
    final background = await connect();
    const count = 40;
    for (var i = 0; i < count; i++) {
      await app.putOutbox(_entry('o$i'));
    }
    final inbox = mbox('INBOX');

    Future<({int claims, int advances})> work(MailStore store, int offset) async {
      var claims = 0;
      var advances = 0;
      for (var i = 0; i < count; i++) {
        // Claim: each message goes out once.
        if (await store.claimOutbox('o$i', now: base) != null) claims++;
        // Sync: new mail in a transaction that reads before it writes.
        await store.applySync(inbox, added([mail(offset + i, minutes: i)]));
        await store.updateKeywords([eid('INBOX', offset + i)], add: {Keywords.seen});
        // Rules: the watermark moves from what was read, or not at all.
        final mark = await store.ruleWatermark(inbox);
        final next = RuleWatermark(seq: (mark?.seq ?? 0) + 1);
        if (await store.advanceRuleWatermark(inbox, from: mark, to: next)) advances++;
      }
      return (claims: claims, advances: advances);
    }

    final results = await Future.wait([work(app, 1000), work(background, 2000)]);
    expect(results[0].claims + results[1].claims, count, reason: 'every message claimed exactly once');
    expect((await app.outboxEntries()).every((e) => e.status == OutboxStatus.sending), isTrue);
    expect((await app.ruleWatermark(inbox))!.seq, results[0].advances + results[1].advances);
    final stored = await app.emailIdsIn(inbox);
    expect(stored, hasLength(2 * count));
    final unread = await app.watchVirtualCounts().first;
    expect(unread[VirtualMailbox.unread] ?? 0, 0);
  });

  test('two processes opening an old file at once upgrade it once', () async {
    for (final s in open) {
      await s.close();
    }
    open.clear();
    File(path).deleteSync();
    createOldDatabase(path, 1);
    final lock = sqlite3.open(path)
      ..execute("PRAGMA key = 'k'")
      ..execute('PRAGMA journal_mode = WAL')
      // Holds the write lock while both open the file and read its version.
      ..execute('BEGIN IMMEDIATE');
    addTearDown(lock.close);
    final opening = [connect(), connect()];
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    lock.execute('ROLLBACK');
    final stores = await Future.wait(opening);
    for (final s in stores) {
      expect((await s.getEmail(eid('INBOX', 1)))!.subject, 'Before the upgrade');
      await s.putOutbox(_entry('o-${stores.indexOf(s)}'));
    }
    expect(await stores.first.outboxEntries(), hasLength(2));
    final check = raw();
    expect(check.select('PRAGMA user_version').single.values.single, latestSchemaVersion);
  });
}
