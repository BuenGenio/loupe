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
/// added later compare equal to created ones), and every index and trigger.
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
          ],
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

  for (final version in [1, 2, 3, 4]) {
    group('version $version upgrades to $latestSchemaVersion', () {
      late String path;
      setUp(() {
        path = '${dir.path}/v$version.db';
        createOldDatabase(path, version);
        // A message the server refused before outbox entries could be held.
        final db = sqlite3.open(path)..execute("PRAGMA key = 'k'");
        db
          ..execute(
            'INSERT INTO outbox_items (id, account_id, message, send_after, status, attempts, last_error, created_at) '
            "VALUES ('o1', ?, ?, 1000, 'failed', 3, '554 5.7.1 Rejected', 1000)",
            [accountId, encodeOutgoing(OutgoingMessage(accountId: accountId, identityId: '$accountId/default'))],
          )
          ..close();
      });

      test('to the schema a new database has', () async {
        final store = await MailStore.open(path, encryptionKey: 'k', inBackground: false);
        await store.close();
        expect(schemaOf(path), await freshSchema());
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
