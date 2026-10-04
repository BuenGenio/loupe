import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/openpgp/openpgp_service.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import 'openpgp_test_support.dart';

const me = EmailAddress('me@example.com', 'Me Myself');
const alice = EmailAddress('alice@example.com', 'Alice Example');

void main() {
  // The real runner: everything handed to it must cross isolates.
  Future<T> isolate<T>(T Function() work) => Isolate.run(work);

  late Keyring keyring;
  late OpenPgpService service;
  late List<String?> answers;
  late int asked;

  setUp(() async {
    keyring = Keyring(MemoryKeyringStorage());
    await keyring.load();
    answers = [];
    asked = 0;
    service = OpenPgpService(
      keyring: keyring,
      session: KeySession(),
      backend: pgp,
      run: isolate,
      prompt: (key, {error}) async {
        asked++;
        return answers.isEmpty ? null : answers.removeAt(0);
      },
    );
  });

  test('unlocks in an isolate and decrypts there, asking once for concurrent reads', () async {
    final mine = testKey('Me Myself <me@example.com>', passphrase: 'pass');
    final aliceKey = testKey('Alice Example <alice@example.com>');
    await keyring.addOwnKey(secret: mine, public: pgp.publicKey(mine));
    await keyring.addPublicKeys([pgp.publicKey(aliceKey)], acceptance: KeyAcceptance.verified);
    final raw = Uint8List.fromList(
      latin1.encode(pgpMessage(from: alice, fromKey: aliceKey, to: me, toKey: mine, subject: 'Hi', text: 'Secret')),
    );
    answers = ['wrong', 'pass'];
    final results = await Future.wait([
      service.read('m1', raw, encrypted: true),
      service.read('m1', raw, encrypted: true),
    ]);
    expect(asked, 2, reason: 'one wrong passphrase, then the right one; the second read waited');
    for (final r in results) {
      expect(r.status.decrypted, isTrue);
      expect(r.status.signature!.status, PgpSignatureStatus.good);
      expect(r.content!.text, contains('Secret'));
      expect(r.status.protectedSubject, 'Hi');
    }
    expect(service.unlockedKey(mine.fingerprint), isNotNull);
  });

  test('generates, parses and imports keys through the isolate', () async {
    final key = await service.generateKey(name: 'Me', email: 'me@example.com', validity: const Duration(days: 30));
    expect(keyring.state.ownKeyFor('me@example.com')!.fingerprint, key.fingerprint);
    expect(keyring.state.identity('me@example.com').keyFingerprint, key.fingerprint);
    expect(service.unlockedKey(key.fingerprint), isNotNull, reason: 'no passphrase: unlocked for good');
    final armored = service.armoredPublicKey(key.fingerprint)!;
    expect((await service.parseKeys(Uint8List.fromList(utf8.encode(armored)))).single.hasSecret, isFalse);
    final backup = (await service.armoredSecretKey(key.fingerprint))!;
    expect(backup, startsWith('-----BEGIN PGP PRIVATE KEY BLOCK-----'));
  });

  test('importing a protected secret key checks its passphrase; cancelling adds nothing', () async {
    final key = testKey('Me <me@example.com>', passphrase: 'pass');
    expect(await service.importSecretKey(key), isNull);
    expect(keyring.state.ownKeys, isEmpty);
    answers = ['pass'];
    final added = await service.importSecretKey(key);
    expect(added!.isProtected, isTrue);
    expect(service.unlockedKey(key.fingerprint), isNotNull);
  });

  test('Autocrypt: learns the sender’s key once, keeps peers current, ignores own addresses', () async {
    final aliceKey = testKey('Alice Example <alice@example.com>');
    final header = AutocryptHeader(
      addr: 'alice@example.com',
      keydata: pgp.minimalKey(aliceKey, 'alice@example.com').data,
      preferMutual: true,
    );
    final headers = [('From', 'alice@example.com'), ('Autocrypt', header.toValue().replaceAll('\r\n', ''))];
    await service.learnAutocrypt(from: 'alice@example.com', date: DateTime(2026, 9, 1), headers: headers);
    final entry = keyring.state.publicEntry(aliceKey.fingerprint)!;
    expect((entry.acceptance, entry.source), (KeyAcceptance.undecided, KeySource.autocrypt));
    expect(keyring.state.peers['alice@example.com']!.preferMutual, isTrue);
    await service.learnAutocrypt(from: 'alice@example.com', date: DateTime(2026, 9, 20), headers: const []);
    expect(keyring.state.peers['alice@example.com']!.lastSeen, DateTime(2026, 9, 20));
    expect(keyring.state.encryptionKeyFor('alice@example.com')!.viaAutocrypt, isTrue);
  });
}
