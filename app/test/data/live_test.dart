import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/data/live.dart';
import 'package:mail_platform/mail_platform.dart';
import 'package:mail_store/mail_store.dart';

/// A keychain in memory that can be made to fail like Android's Keystore.
final class _Secrets implements SecretStorage {
  final values = <String, String>{};
  Object? readError;
  var writes = 0;

  @override
  Future<String?> read(String key) async {
    if (readError case final e?) throw e;
    return values[key];
  }

  @override
  Future<void> write(String key, String value) async {
    writes++;
    values[key] = value;
  }

  @override
  Future<void> delete(String key) async => values.remove(key);
}

void main() {
  late Directory dir;
  setUp(() => dir = Directory.systemTemp.createTempSync('loupe_live_test'));
  tearDown(() => dir.deleteSync(recursive: true));

  group('databaseKey', () {
    test('creates a key once and then keeps reading it', () async {
      final secrets = _Secrets();
      final key = await databaseKey(secrets, create: true);
      expect(key, hasLength(44));
      expect(await databaseKey(secrets, create: true), key);
      expect(secrets.writes, 1);
    });

    test('a keychain that fails to read never gets a new key', () async {
      final secrets = _Secrets()
        ..values['loupe.database.key'] = 'old'
        ..readError = Exception('KeyStoreException: Failed to unwrap key');
      await expectLater(
        databaseKey(secrets, create: true),
        throwsA(isA<DatabaseKeyUnavailable>().having((e) => e.missing, 'missing', isFalse)),
      );
      expect(secrets.writes, 0);
      expect(secrets.values['loupe.database.key'], 'old');
    });

    test('a missing key is an error when none may be created', () async {
      await expectLater(
        databaseKey(_Secrets(), create: false),
        throwsA(isA<DatabaseKeyUnavailable>().having((e) => e.missing, 'missing', isTrue)),
      );
    });
  });

  group('openStoreIn', () {
    test('keeps an existing database whose key the keychain lost', () async {
      final secrets = _Secrets();
      final store = await openStoreIn(dir, secrets);
      await store.close();
      final file = File(databasePath(dir));
      final before = file.readAsBytesSync();

      // The keychain forgot the key (a restored backup, a reset Keystore).
      secrets.values.clear();
      await expectLater(
        openStoreIn(dir, secrets),
        throwsA(isA<DatabaseKeyUnavailable>().having((e) => e.missing, 'missing', isTrue)),
      );
      expect(secrets.values, isEmpty, reason: 'no new key replaces the lost one');
      expect(file.readAsBytesSync(), before);
    });

    test('a wrong key is reported, not repaired', () async {
      final secrets = _Secrets();
      await (await openStoreIn(dir, secrets)).close();
      secrets.values['loupe.database.key'] = 'another key';
      await expectLater(openStoreIn(dir, secrets), throwsA(isA<MailStoreException>()));
      expect(File(databasePath(dir)).existsSync(), isTrue);
    });
  });

  test('deleteLocalMailData removes the database and its key, then a new one opens', () async {
    final secrets = _Secrets();
    await (await openStoreIn(dir, secrets)).close();
    final oldKey = secrets.values['loupe.database.key'];
    secrets.values.clear();

    await deleteLocalMailData(directory: dir, secrets: secrets);
    expect(dir.listSync().where((f) => f.path.contains('loupe.db')), isEmpty);

    final store = await openStoreIn(dir, secrets);
    expect(await store.getAccounts(), isEmpty);
    expect(secrets.values['loupe.database.key'], isNot(oldKey));
    await store.close();
  });
}
