import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/der.dart' show hex;
import 'package:pointycastle/key_derivators/api.dart' show Argon2Parameters;
import 'package:pointycastle/key_derivators/argon2.dart';
import 'package:test/test.dart';

import 'smime_support.dart';

void main() {
  // Cheap parameters, so the tests run fast; the format carries them.
  const cheap = SmimeKdfParameters(memoryPowerOf2: 10, iterations: 1, lanes: 1);
  final fingerprint = alice.certificate.fingerprint;

  test('pointycastle’s Argon2id gives RFC 9106’s test vector (§5.3)', () {
    final generator = Argon2BytesGenerator()
      ..init(
        Argon2Parameters(
          Argon2Parameters.ARGON2_id,
          Uint8List.fromList(List.filled(16, 2)),
          desiredKeyLength: 32,
          secret: Uint8List.fromList(List.filled(8, 3)),
          additional: Uint8List.fromList(List.filled(12, 4)),
          iterations: 3,
          lanes: 4,
          memory: 32,
        ),
      );
    final tag = generator.process(Uint8List.fromList(List.filled(32, 1)));
    expect(hex(tag).toLowerCase(), '0d640df58d78766c08c037a34a8b53c9d01ef0452d75b65eb52520e96b01e659');
  });

  test('a protected key comes back with its passphrase, and only with it', () {
    final protected = protectKey(aliceKey, 'correct horse', fingerprint: fingerprint, kdf: cheap);
    final stored = protected.encode();
    expect(SmimeProtectedKey.isProtected(stored), isTrue);
    expect(stored, isNot(contains(base64.encode(aliceKey.pkcs8).substring(0, 40))));

    final again = SmimeProtectedKey.decode(stored);
    expect(unprotectKey(again, 'correct horse', fingerprint: fingerprint).pkcs8, aliceKey.pkcs8);
    expect(
      () => unprotectKey(again, 'Correct horse', fingerprint: fingerprint),
      throwsA(isA<SmimeException>().having((e) => e.kind, 'kind', SmimeErrorKind.wrongPassword)),
    );
    // Bound to its certificate: another certificate's entry doesn't open with it.
    expect(
      () => unprotectKey(again, 'correct horse', fingerprint: bob.certificate.fingerprint),
      throwsA(isA<SmimeException>().having((e) => e.kind, 'kind', SmimeErrorKind.wrongPassword)),
    );
  });

  test('each protection has its own salt and nonce', () {
    final a = protectKey(aliceKey, 'pass', fingerprint: fingerprint, kdf: cheap);
    final b = protectKey(aliceKey, 'pass', fingerprint: fingerprint, kdf: cheap);
    expect(a.salt, isNot(b.salt));
    expect(a.nonce, isNot(b.nonce));
    expect(a.ciphertext, isNot(b.ciphertext));
  });

  test('the standard cost is RFC 9106’s choice for devices with little memory', () async {
    expect(SmimeKdfParameters.standard.memoryPowerOf2, 16);
    expect(SmimeKdfParameters.standard.iterations, 3);
    expect(SmimeKdfParameters.standard.lanes, 4);
    final protected = protectKey(aliceKey, 'pass', fingerprint: fingerprint);
    expect(unprotectKey(protected, 'pass', fingerprint: fingerprint).pkcs8, aliceKey.pkcs8);
  });

  test('damaged entries are refused before any work (no gigabytes of Argon2)', () {
    final good = jsonDecode(protectKey(aliceKey, 'pass', fingerprint: fingerprint, kdf: cheap).encode()) as Map;
    for (final change in <Map<String, Object?>>[
      {'v': 2},
      {'kdf': 'pbkdf2'},
      {'m': 30},
      {'t': 1000},
      {'p': 0},
      {
        'nonce': base64.encode([1, 2, 3]),
      },
      {
        'salt': base64.encode([1]),
      },
      {'ct': 'not base64!'},
      {'m': 'big'},
    ]) {
      final bad = jsonEncode({...good, ...change});
      expect(
        () => SmimeProtectedKey.decode(bad),
        throwsA(isA<SmimeException>().having((e) => e.kind, 'kind', SmimeErrorKind.malformed)),
        reason: '$change',
      );
    }
    expect(() => SmimeProtectedKey.decode('{'), throwsA(isA<SmimeException>()));
    expect(SmimeProtectedKey.isProtected(base64.encode(aliceKey.pkcs8)), isFalse);
  });

  test('the store: a passphrase set, then removed; the key never usable while protected', () async {
    final storage = MemoryKeyringStorage();
    final store = SmimeStore(storage);
    await store.load();
    await store.addOwn(alice, chain: aliceBundle.chain, now: today);
    expect(store.state.own.single.hasPassphrase, isFalse);

    final protected = protectKey(aliceKey, 'pass', fingerprint: fingerprint, kdf: cheap);
    await store.setKeyProtection(fingerprint, protectedKey: protected);
    final again = SmimeStore(storage);
    await again.load();
    expect(again.state.own.single.hasPassphrase, isTrue);
    expect(await again.privateKey(fingerprint), isNull);
    expect(await again.keyPairs(), isEmpty);
    expect((await again.protectedKey(fingerprint))!.ciphertext, protected.ciphertext);
    expect(storage.values.values.any((v) => v.contains(base64.encode(aliceKey.pkcs8).substring(0, 40))), isFalse);

    await again.setKeyProtection(fingerprint, key: aliceKey);
    expect(again.state.own.single.hasPassphrase, isFalse);
    expect(await again.protectedKey(fingerprint), isNull);
    expect((await again.privateKey(fingerprint) as SmimePrivateKey?)?.pkcs8, aliceKey.pkcs8);
  });

  test('a certificate on the device has no passphrase of Loupe’s', () async {
    final store = SmimeStore(MemoryKeyringStorage());
    await store.load();
    await store.addOwn(SmimeKeyPair(alice.certificate, const SmimePlatformKey('a')), now: today);
    expect(
      () => store.setKeyProtection(
        fingerprint,
        protectedKey: protectKey(aliceKey, 'p', fingerprint: fingerprint, kdf: cheap),
      ),
      throwsArgumentError,
    );
  });
}
