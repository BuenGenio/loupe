import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:test/test.dart';

import 'support.dart';

void main() {
  group('reading keys', () {
    test('Thunderbird sample keys: Ed25519 and RSA, public and secret', () {
      expect(alicePublic.fingerprint, 'EB85BB5FA33A75E15E944E63F231550C4F47E38E');
      expect(alicePublic.keyId, 'F231550C4F47E38E');
      expect(alicePublic.algorithm, 'Ed25519');
      expect(alicePublic.userIds, ['Alice Lovelace <alice@openpgp.example>']);
      expect(alicePublic.emails, {'alice@openpgp.example'});
      expect(alicePublic.displayName, 'Alice Lovelace');
      expect(alicePublic.hasSecret, isFalse);
      expect(alicePublic.canEncrypt, isTrue);
      expect(alicePublic.canSign, isTrue);
      expect(aliceSecret.hasSecret, isTrue);
      expect(aliceSecret.isProtected, isFalse);
      expect(bobPublic.algorithm, 'RSA 3072');
      expect(bobPublic.formattedFingerprint, 'D1A6 6E1A 23B1 82C9 980F  788C FBFC C82A 015E 7330');
    });

    test('gpg keys with a passphrase unlock, and a wrong one is refused', () {
      final alice = key('gpg/alice.sec.asc');
      expect(alice.isProtected, isTrue);
      expect(
        () => pgp.unlock(alice, 'nope'),
        throwsA(isA<PgpException>().having((e) => e.kind, 'kind', PgpErrorKind.wrongPassphrase)),
      );
      final unlocked = pgp.unlock(alice, 'alice-pass');
      expect(unlocked.isProtected, isFalse);
      expect(unlocked.fingerprint, alice.fingerprint);
    });

    test('a Thunderbird "Export Secret Key" backup (passphrase protected) unlocks', () {
      final backup = tbKey('alice@openpgp.example-0xf231550c4f47e38e-secret-with-pp.asc');
      expect(backup.isProtected, isTrue);
      expect(pgp.unlock(backup, 'alice-passphrase').isProtected, isFalse);
    });

    test('binary keys, several keys in one paste, and v6 keys', () {
      expect(pgp.readKeys(fixture('thunderbird/keys/key-binary.gpg')), hasLength(1));
      final both = '${utf8.decode(fixture('gpg/alice.pub.asc'))}\n${utf8.decode(fixture('gpg/bob.pub.asc'))}';
      expect(pgp.readKeys(bytes(both)).map((k) => k.emails.single), ['alice@example.org', 'bob@example.org']);
      final v6 = tbKey('pgp-v6-pub.asc');
      expect(v6.version, 6);
      expect(v6.fingerprint, hasLength(64));
    });

    test('v6 keys (RFC 9580): encrypt, decrypt, sign, verify', () {
      final secret = tbKey('pgp-v6-sec.asc');
      final public = tbKey('pgp-v6-pub.asc');
      expect(secret.isProtected, isFalse);
      final message = bytes('v6 works');
      final armored = pgp.encrypt(message, recipients: [public], signer: secret);
      final d = pgp.decrypt(bytes(armored), keys: [secret], verifiers: [public]);
      expect(d.data, message);
      expect(d.signatures.single.status, PgpSignatureStatus.good);
    });

    test('a key whose encryption subkey expired cannot encrypt', () {
      expect(tbKey('expired-enc-subkey.pub.asc').canEncrypt, isFalse);
    });

    test('garbage is reported as malformed', () {
      expect(
        () => pgp.readKeys(bytes('hello')),
        throwsA(isA<PgpException>().having((e) => e.kind, 'kind', PgpErrorKind.malformed)),
      );
    });
  });

  group('gpg messages', () {
    final alice = pgp.unlock(key('gpg/alice.sec.asc'), 'alice-pass');
    final bob = pgp.unlock(key('gpg/bob.sec.asc'), 'bob-pass');
    final alicePub = key('gpg/alice.pub.asc');
    final bobPub = key('gpg/bob.pub.asc');

    test('signed and encrypted to Curve25519 decrypts and verifies', () {
      final d = pgp.decrypt(fixture('gpg/bob_to_alice.asc'), keys: [alice], verifiers: [bobPub]);
      expect(utf8.decode(d.data), contains('Hello from gpg, Grüße!'));
      expect(d.recipientKeyIds, [alicePub.keyIds.firstWhere((id) => id != alicePub.keyId)]);
      expect(d.signatures.single.status, PgpSignatureStatus.good);
      expect(d.signatures.single.signerFingerprint, bobPub.fingerprint);
    });

    test('encrypted to RSA decrypts; an unknown signer is reported', () {
      final d = pgp.decrypt(fixture('gpg/alice_to_bob.asc'), keys: [bob]);
      expect(utf8.decode(d.data), contains('Grüße'));
      expect(d.signatures.single.status, PgpSignatureStatus.unknownKey);
      expect(d.signatures.single.issuerKeyId, alicePub.keyId);
    });

    test('without the right key, decryption says so', () {
      expect(
        () => pgp.decrypt(fixture('gpg/bob_to_alice.asc'), keys: [bob]),
        throwsA(isA<PgpException>().having((e) => e.kind, 'kind', PgpErrorKind.noSecretKey)),
      );
      expect(
        () => pgp.decrypt(fixture('gpg/bob_to_alice.asc'), keys: [key('gpg/alice.sec.asc')]),
        throwsA(isA<PgpException>().having((e) => e.kind, 'kind', PgpErrorKind.locked)),
      );
    });

    test('Ed25519 signatures whose R or S starts with a zero octet verify', () {
      for (final name in ['leading-zero-r', 'leading-zero-s']) {
        final checks = pgp.verifyDetached(fixture('gpg/$name.txt'), fixture('gpg/$name.sig'), [alicePub]);
        expect(checks.single.status, PgpSignatureStatus.good, reason: name);
      }
    });

    test('many own Ed25519 signatures all verify (leading zeros included)', () {
      final k = pgp.generate(userId: 'Zed <zed@example.net>');
      for (var i = 0; i < 300; i++) {
        final data = bytes('message $i');
        expect(
          pgp.verifyDetached(data, bytes(pgp.signDetached(data, k).armored), [k]).single.status,
          PgpSignatureStatus.good,
        );
      }
    });

    test('detached and cleartext signatures verify; changed data does not', () {
      final data = fixture('gpg/inner.txt');
      final sig = fixture('gpg/inner.sig');
      expect(pgp.verifyDetached(data, sig, [alicePub]).single.status, PgpSignatureStatus.good);
      final changed = [...data]..[data.length - 3] ^= 1;
      expect(pgp.verifyDetached(Uint8List.fromList(changed), sig, [alicePub]).single.status, PgpSignatureStatus.bad);
      final clear = pgp.verifyCleartext(utf8.decode(fixture('gpg/clear.asc')), [bobPub]);
      expect(clear.signatures.single.status, PgpSignatureStatus.good);
      expect(clear.text, contains('Grüße'));
    });
  });

  group('our own output', () {
    final carol = pgp.generate(
      userId: 'Carol <carol@example.net>',
      validity: const Duration(days: 365 * 3),
      now: DateTime.utc(2026, 10, 4),
    );

    test('generates a Thunderbird-style key: Ed25519 + Curve25519, v4, with expiry', () {
      expect(carol.version, 4);
      expect(carol.algorithm, 'Ed25519');
      expect(carol.keyIds, hasLength(2));
      expect(carol.canEncrypt, isTrue);
      expect(carol.canSign, isTrue);
      expect(carol.isProtected, isFalse);
      expect(carol.expires!.isAtSameMomentAs(DateTime.utc(2029, 10, 3)), isTrue);
      expect(carol.hasEmail('CAROL@example.net'), isTrue);
      final locked = pgp.generate(userId: 'Dan <dan@example.net>', passphrase: 'secret');
      expect(locked.isProtected, isTrue);
      expect(pgp.unlock(locked, 'secret').isProtected, isFalse);
    });

    test('round trip: encrypt and sign, decrypt and verify', () {
      final message = bytes('Content-Type: text/plain\r\n\r\nHi Alice\r\n');
      final armored = pgp.encrypt(message, recipients: [alicePublic, pgp.publicKey(carol)], signer: carol);
      expect(armored, startsWith('-----BEGIN PGP MESSAGE-----'));
      final d = pgp.decrypt(bytes(armored), keys: [aliceSecret], verifiers: [carol]);
      expect(d.data, message);
      expect(d.signatures.single.status, PgpSignatureStatus.good);
      final sig = pgp.signDetached(message, carol).armored;
      expect(pgp.verifyDetached(message, bytes(sig), [pgp.publicKey(carol)]).single.status, PgpSignatureStatus.good);
    });

    test('refuses to encrypt to a key that cannot', () {
      expect(
        () => pgp.encrypt(bytes('x'), recipients: [tbKey('expired-enc-subkey.pub.asc')]),
        throwsA(isA<PgpException>().having((e) => e.kind, 'kind', PgpErrorKind.keyUnusable)),
      );
    });

    test('the minimal key keeps one user id and the encryption subkey', () {
      final minimal = pgp.minimalKey(bobPublic, 'bob@openpgp.example');
      expect(minimal.fingerprint, bobPublic.fingerprint);
      expect(minimal.userIds, ['Bob Babbage <bob@openpgp.example>']);
      expect(minimal.canEncrypt, isTrue);
      expect(minimal.data.length, lessThanOrEqualTo(bobPublic.data.length));
      final armored = pgp.armor(minimal);
      expect(pgp.readKeys(bytes(armored)).single.fingerprint, bobPublic.fingerprint);
    });

    test('a signature by a signing subkey verifies', () {
      final secret = tbKey('sign-subkey-only-secret.asc');
      final unlocked = secret.isProtected ? null : secret;
      final public = tbKey('sign-subkey-only-pub.asc');
      expect(public.canSign, isTrue);
      if (unlocked == null) return;
      final sig = pgp.signDetached(bytes('x'), unlocked).armored;
      expect(pgp.verifyDetached(bytes('x'), bytes(sig), [public]).single.status, PgpSignatureStatus.good);
    });

    test('gpg decrypts and verifies what we write (Curve25519 and RSA), and imports our key', () {
      final gpg = Gpg.create();
      if (gpg == null) {
        markTestSkipped('gpg is not installed');
        return;
      }
      addTearDown(gpg.dispose);
      const q = ['--pinentry-mode', 'loopback', '--passphrase', ''];
      gpg.run([...q, '--quick-gen-key', 'Gina <gina@example.org>', 'ed25519', 'sign,cert', 'never']);
      gpg.run([...q, '--quick-gen-key', 'Ravi <ravi@example.org>', 'rsa2048', 'sign,cert', 'never']);
      String fingerprint(String email) => RegExp(
        r'^fpr:+([0-9A-F]+):',
        multiLine: true,
      ).firstMatch(utf8.decode(gpg.run(['--with-colons', '--list-keys', email]).stdout as List<int>))!.group(1)!;
      gpg.run([...q, '--quick-add-key', fingerprint('gina@example.org'), 'cv25519', 'encr', 'never']);
      gpg.run([...q, '--quick-add-key', fingerprint('ravi@example.org'), 'rsa2048', 'encr', 'never']);
      final exported = gpg.run(['--armor', '--export', 'gina@example.org', 'ravi@example.org']).stdout as List<int>;
      final theirs = pgp.readKeys(Uint8List.fromList(exported));
      expect(theirs.map((k) => k.algorithm), ['Ed25519', 'RSA 2048']);
      gpg.import(pgp.armor(pgp.publicKey(carol)));

      final message = bytes('Hello from Loupe, Grüße!\r\n');
      for (final recipient in theirs) {
        final encrypted = pgp.encrypt(message, recipients: [recipient], signer: carol);
        final out = gpg.run([
          '--trust-model',
          'always',
          '--status-fd',
          '2',
          '--decrypt',
        ], stdin: utf8.encode(encrypted));
        expect(out.exitCode, 0, reason: '${out.stderr}');
        expect(out.stdout, message);
        expect(out.stderr as String, contains('GOODSIG'));
      }

      final sigDir = gpg.home.createTempSync('sig-');
      final dataFile = File('${sigDir.path}/data')..writeAsBytesSync(message);
      final sigFile = File('${sigDir.path}/data.asc')..writeAsStringSync(pgp.signDetached(message, carol).armored);
      final verify = Process.runSync(
        'gpg',
        ['--batch', '--status-fd', '1', '--verify', sigFile.path, dataFile.path],
        environment: {'GNUPGHOME': gpg.home.path},
      );
      expect(verify.stdout as String, contains('GOODSIG'), reason: '${verify.stderr}');

      // And what gpg writes to our key decrypts here.
      final toCarol = gpg.run([
        '--trust-model',
        'always',
        '--armor',
        '--output',
        '-',
        '--encrypt',
        '-r',
        'carol@example.net',
      ], stdin: message);
      expect(toCarol.exitCode, 0, reason: '${toCarol.stderr}');
      expect(pgp.decrypt(Uint8List.fromList(toCarol.stdout as List<int>), keys: [carol]).data, message);
    });
  });
}
