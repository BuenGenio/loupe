import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/der.dart';
import 'package:mail_imap/mail_imap.dart' show MimeMessageComposer;
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'smime_support.dart';

final class _Keys implements SmimeSendKeys {
  _Keys(this.smimeState, this.keys);
  @override
  final SmimeState smimeState;
  final Map<String, SmimeKeyHandle> keys;
  @override
  SmimeKeyHandle? smimeKey(String fingerprint) => keys[fingerprint];
}

void main() {
  final keystore = SoftwareSmimeKeystore({'alice-device': aliceKey, 'bob-device': bobBundle.keys.single.key});
  const aliceOnDevice = SmimePlatformKey('alice-device');
  const bobOnDevice = SmimePlatformKey('bob-device');
  const aliceId = Identity(id: 'a', email: 'alice@example.org', name: 'Alice Example');

  /// Reads [raw] with [keys], answering what the device keys are asked, as the app does.
  Future<SmimeReadResult> readAnswering(Uint8List raw, List<SmimeKeyPair> keys) async {
    var pairs = keys;
    for (var round = 0; round < 4; round++) {
      final result = const SmimeReader(smime).read(raw, keys: pairs, anchors: testAnchors, now: today);
      final request = result.status.keyRequest;
      if (request == null) return result;
      final answer = await keystore.perform(request);
      pairs = [
        for (final p in pairs)
          if (p.key case final SmimePlatformKey k when k.alias == request.alias)
            SmimeKeyPair(p.certificate, k.withAnswers({request.id: answer}))
          else
            p,
      ];
    }
    fail('Asked too often');
  }

  group('decrypting with a key on the device', () {
    for (final (file, owner, operation) in [
      ('enveloped-rsa.eml', 'alice', SmimeKeyOperation.decryptPkcs1),
      ('enveloped-oaep.eml', 'alice', SmimeKeyOperation.decryptOaep),
      ('enveloped-3des.eml', 'alice', SmimeKeyOperation.decryptPkcs1),
      ('enveloped-ec.eml', 'bob', SmimeKeyOperation.agree),
      ('enveloped-ec-sha1kdf.eml', 'bob', SmimeKeyOperation.agree),
      ('signed-enveloped.eml', 'bob', SmimeKeyOperation.agree),
    ]) {
      test('$file: asks the device to ${operation.name}, then decrypts with the answer', () async {
        final pair = owner == 'alice'
            ? SmimeKeyPair(alice.certificate, aliceOnDevice)
            : SmimeKeyPair(bob.certificate, bobOnDevice);
        final first = const SmimeReader(smime).read(smimeMail(file), keys: [pair], anchors: testAnchors, now: today);
        expect(first.status.failure, SmimeDecryptFailure.locked);
        expect(first.status.keyRequest?.operation, operation);
        expect(first.status.keyRequest?.alias, '$owner-device');

        final read = await readAnswering(smimeMail(file), [pair]);
        expect(read.status.decrypted, isTrue, reason: '${read.status}');
        expect(read.entity!.text, contains('Grüße'));
      });
    }

    test('a key in the app is used before one on the device is asked', () {
      final read = const SmimeReader(smime).read(
        smimeMail('signed-enveloped.eml'),
        keys: [SmimeKeyPair(bob.certificate, bobOnDevice), alice],
        anchors: testAnchors,
        now: today,
      );
      expect(read.status.decrypted, isTrue);
      expect(read.status.keyRequest, isNull);
    });

    test('a refused padding (an empty answer) fails like a wrong key, never as a crash', () {
      final pair = SmimeKeyPair(alice.certificate, aliceOnDevice);
      final first = const SmimeReader(smime).read(smimeMail('enveloped-rsa.eml'), keys: [pair], now: today);
      final request = first.status.keyRequest!;
      final read = const SmimeReader(smime).read(
        smimeMail('enveloped-rsa.eml'),
        keys: [
          SmimeKeyPair(alice.certificate, aliceOnDevice.withAnswers({request.id: Uint8List(0)})),
        ],
        now: today,
      );
      expect(read.status.failure, SmimeDecryptFailure.damaged);
    });

    test('an ECDH secret of the wrong length is refused', () {
      final pair = SmimeKeyPair(bob.certificate, bobOnDevice);
      final first = const SmimeReader(smime).read(smimeMail('enveloped-ec.eml'), keys: [pair], now: today);
      final request = first.status.keyRequest!;
      final read = const SmimeReader(smime).read(
        smimeMail('enveloped-ec.eml'),
        keys: [
          SmimeKeyPair(bob.certificate, bobOnDevice.withAnswers({request.id: Uint8List(31)})),
        ],
        now: today,
      );
      expect(read.status.failure, SmimeDecryptFailure.noKey);
    });

    test('the peer’s point is checked before the device is asked (invalid-curve)', () {
      final der = MimeEntity.parse(smimeMail('enveloped-ec.eml')).decodedBody;
      // The originator's public point, its last coordinate octet changed: off the curve.
      final at = hex(der).indexOf('03420004');
      expect(at, isNonNegative);
      final point = at ~/ 2 + 3;
      final bad = Uint8List.fromList(der)..[point + 64] ^= 1;
      expect(
        () => smime.decrypt(bad, [SmimeKeyPair(bob.certificate, bobOnDevice)]),
        throwsA(isA<SmimeException>().having((e) => e is SmimeKeyRequired, 'asks the device', isFalse)),
      );
    });
  });

  group('signing with a key on the device', () {
    SmimeState state() => SmimeState(
      own: [
        SmimeOwnCertificate(
          certificate: alice.certificate,
          chain: aliceBundle.chain,
          added: today,
          deviceAlias: 'alice-device',
        ),
      ],
      contacts: [
        SmimeContactCertificate(certificate: bob.certificate, chain: [testCa], added: today),
      ],
      authorities: [testRoot],
    );

    SmimeMessageComposer composer(Map<String, SmimeKeyHandle> keys) =>
        SmimeMessageComposer(MimeMessageComposer(), _Keys(state(), keys), backend: smime, clock: () => today);

    OutgoingMessage message(OutgoingSecurity security) => OutgoingMessage(
      accountId: 'a',
      identityId: 'a',
      to: const [EmailAddress('bob@example.net', 'Bob Example')],
      subject: 'From the device',
      text: 'Signed by the company certificate.',
      security: security,
    );

    for (final security in const [
      OutgoingSecurity(sign: true, technology: SecurityTechnology.smime),
      OutgoingSecurity(sign: true, encrypt: true, technology: SecurityTechnology.smime),
    ]) {
      test('${security.encrypt ? 'signed and encrypted' : 'signed'}: composed in two steps, and it verifies', () async {
        final c = composer({alice.certificate.fingerprint: aliceOnDevice});
        final step = c.begin(message(security), aliceId, messageId: '<m@x>', date: today);
        final pending = step as SmimeSignaturePending;
        expect(pending.request.operation, SmimeKeyOperation.sign);
        expect(pending.request.digest, 'SHA-256');
        expect(pending.request.keyType, SmimeKeyType.rsa);
        final raw = c.finish(pending, await keystore.perform(pending.request));

        final read = const SmimeReader(smime).read(raw, keys: [bob], anchors: testAnchors, now: today, known: [testCa]);
        expect(read.status.encrypted, security.encrypt);
        expect(read.status.signature?.good, isTrue, reason: '${read.status}');
        expect(read.entity!.text, contains('Signed by the company certificate.'));
      });
    }

    test('compose alone can’t wait for the device: it says so', () {
      final c = composer({alice.certificate.fingerprint: aliceOnDevice});
      expect(
        () => c.compose(
          message(const OutgoingSecurity(sign: true, technology: SecurityTechnology.smime)),
          aliceId,
          messageId: '<m@x>',
        ),
        throwsA(isA<MailException>().having((e) => e.message, 'message', contains('open Loupe'))),
      );
    });

    test('a signature by another key is never sent', () async {
      final c = composer({alice.certificate.fingerprint: aliceOnDevice});
      final pending = c.begin(
        message(const OutgoingSecurity(sign: true, technology: SecurityTechnology.smime)),
        aliceId,
        messageId: '<m@x>',
        date: today,
      ) as SmimeSignaturePending;
      final wrong = await keystore.perform(
        SmimeKeyRequest(
          alias: 'bob-device',
          operation: SmimeKeyOperation.sign,
          input: pending.request.input,
          keyType: SmimeKeyType.ec,
          digest: 'SHA-256',
        ),
      );
      expect(() => c.finish(pending, wrong), throwsA(isA<MailException>()));
    });

    test('an EC key on the device signs with the curve’s digest', () async {
      final bobState = SmimeState(
        own: [
          SmimeOwnCertificate(certificate: bob.certificate, chain: [testCa], added: today, deviceAlias: 'bob-device'),
        ],
        authorities: [testRoot],
      );
      final c = SmimeMessageComposer(
        MimeMessageComposer(),
        _Keys(bobState, {bob.certificate.fingerprint: bobOnDevice}),
        backend: smime,
        clock: () => today,
      );
      const bobId = Identity(id: 'b', email: 'bob@example.net', name: 'Bob Example');
      final pending = c.begin(
        message(const OutgoingSecurity(sign: true, technology: SecurityTechnology.smime)),
        bobId,
        messageId: '<m@x>',
        date: today,
      ) as SmimeSignaturePending;
      expect(pending.request.keyType, SmimeKeyType.ec);
      final raw = c.finish(pending, await keystore.perform(pending.request));
      final read = const SmimeReader(smime).read(raw, anchors: testAnchors, now: today);
      expect(read.status.signature?.good, isTrue, reason: '${read.status}');
    });

    test('the store keeps the alias, never a private key', () async {
      final storage = MemoryKeyringStorage();
      final store = SmimeStore(storage);
      await store.load();
      await store.addOwn(SmimeKeyPair(alice.certificate, aliceOnDevice), chain: aliceBundle.chain, now: today);
      final again = SmimeStore(storage);
      final loaded = await again.load();
      expect(loaded.own.single.deviceAlias, 'alice-device');
      expect(await again.privateKey(alice.certificate.fingerprint), isA<SmimePlatformKey>());
      expect(storage.values.keys.where((k) => k.contains('.key.')), isEmpty);
    });
  });
}
