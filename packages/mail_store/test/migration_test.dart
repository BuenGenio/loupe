import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:mail_store/src/codec.dart' show encodeOutgoing;
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

/// The schema of the database at [path] as comparable data: the version,
/// every table's columns (as `PRAGMA table_xinfo` reports them, so columns
/// added later compare equal to created ones, in any order: a column added
/// by an upgrade comes after the generated `sub_key`, a created one before
/// it), and every index and trigger.
Map<String, Object?> schemaOf(String path) {
  final db = sqlite3.open(path)..execute("PRAGMA key = 'k'");
  try {
    String normalize(String sql) =>
        sql.replaceAll('IF NOT EXISTS ', '').replaceAll('"', '').replaceAll(RegExp(r'\s+'), ' ').trim();
    final objects = db.select(
      "SELECT type, name, sql FROM sqlite_master WHERE name NOT LIKE 'sqlite_%' ORDER BY type, name",
    );
    return {
      'version': db.select('PRAGMA user_version').single.values.single,
      for (final o in objects)
        '${o['type']} ${o['name']}': switch (o['type']) {
          'table' => [
            for (final c in db.select('PRAGMA table_xinfo("${o['name']}")'))
              '${c['name']} ${c['type']} notnull=${c['notnull']} default=${c['dflt_value']} pk=${c['pk']} '
                  'hidden=${c['hidden']}',
          ]..sort(),
          _ => o['sql'] == null ? null : normalize(o['sql'] as String),
        },
    };
  } finally {
    db.close();
  }
}

void main() {
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  late Directory dir;
  setUp(() => dir = Directory.systemTemp.createTempSync('mail_store_migration'));
  tearDown(() => dir.deleteSync(recursive: true));

  /// The schema of a database this version creates.
  Future<Map<String, Object?>> freshSchema() async {
    final path = '${dir.path}/fresh.db';
    final store = await MailStore.open(path, encryptionKey: 'k', inBackground: false);
    await store.close();
    return schemaOf(path);
  }

  for (final version in [1, 2, 3, 4, 5]) {
    group('version $version upgrades to $latestSchemaVersion', () {
      late String path;
      setUp(() {
        path = '${dir.path}/v$version.db';
        createOldDatabase(path, version);
        // A message the server refused before outbox entries could be held.
        final db = sqlite3.open(path)..execute("PRAGMA key = 'k'");
        db.execute(
          'INSERT INTO outbox_items (id, account_id, message, send_after, status, attempts, last_error, created_at) '
          "VALUES ('o1', ?, ?, 1000, 'failed', 3, '554 5.7.1 Rejected', 1000)",
          [accountId, encodeOutgoing(OutgoingMessage(accountId: accountId, identityId: '$accountId/default'))],
        );
        // Two notifications of a bulk-mail service (by Message-ID).
        for (final uid in [2, 3]) {
          db.execute(
            'INSERT INTO emails (id, account_id, mailbox_id, thread_id, subject, received_at, from_json, from_email, '
            "message_id_header) VALUES (?, ?, ?, 'acc1|t:n', 'Notice', ?, ?, 'notify@service.example', ?)",
            [
              eid('INBOX', uid),
              accountId,
              mbox('INBOX'),
              base.millisecondsSinceEpoch + uid,
              '[{"e":"notify@service.example","n":"Service"}]',
              'n$uid@bounce.sendgrid.net',
            ],
          );
        }
        db.close();
      });

      test('to the schema a new database has', () async {
        final store = await MailStore.open(path, encryptionKey: 'k', inBackground: false);
        await store.close();
        expect(schemaOf(path), await freshSchema());
      });

      test('with the mail from before in Subscriptions', () async {
        final store = await MailStore.open(path, encryptionKey: 'k', inBackground: false);
        addTearDown(store.close);
        final subs = await store.watchSubscriptions(now: base).first;
        expect(subs.single.key, 'from:notify@service.example');
        expect(subs.single.name, 'Service');
        expect(subs.single.messageCount, 2);
        await store.updateKeywords([eid('INBOX', 2)], add: {Keywords.seen});
        expect((await store.watchSubscriptions(now: base).first).single.readCount, 1);
      });

      test('with protected subjects that the list and search show', () async {
        final store = await MailStore.open(path, encryptionKey: 'k', inBackground: false);
        addTearDown(store.close);
        final before = (await store.getEmail(eid('INBOX', 1)))!;
        expect((before.isEncrypted, before.hasDecryptedSubject), (false, false));
        await store.rememberProtectedSubject(eid('INBOX', 1), 'Quarterly secrets');
        final after = (await store.getEmail(eid('INBOX', 1)))!;
        expect((after.subject, after.hasDecryptedSubject), ('Quarterly secrets', true));
        expect(
          [for (final e in await store.search(const TextTerm(SearchField.subject, 'quarterly'))) e.id],
          [eid('INBOX', 1)],
        );
        // The body cached before the upgrade is still found, and decrypted text can be.
        expect(await store.search(const TextTerm(SearchField.body, 'kumquat')), hasLength(1));
        await store.putDecryptedText(eid('INBOX', 1), 'Lighthouse Lodge');
        expect(await store.search(const TextTerm(SearchField.body, 'lighthouse')), hasLength(1));
        expect(await store.search(const TextTerm(SearchField.body, 'kumquat')), isEmpty);
      });

      test('keeping the data; outbox entries are not held', () async {
        final store = await MailStore.open(path, encryptionKey: 'k', inBackground: false);
        addTearDown(store.close);
        expect((await store.getEmail(eid('INBOX', 1)))!.subject, 'Before the upgrade');
        final entry = (await store.getOutbox('o1'))!;
        expect(entry.status, OutboxStatus.failed);
        expect(entry.lastError, '554 5.7.1 Rejected');
        expect(entry.attempts, 3);
        expect(entry.held, isFalse);
        expect(await store.claimOutbox('o1', now: DateTime.fromMillisecondsSinceEpoch(2000)), isNotNull);
      });
    });
  }
}
