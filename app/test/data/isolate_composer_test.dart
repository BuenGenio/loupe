import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/data/isolate_composer.dart';
import 'package:loupe/features/openpgp/openpgp_keys.dart';
import 'package:loupe/features/smime/smime_keys.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../features/openpgp/openpgp_test_support.dart';
import '../features/smime/smime_test_support.dart' as sm;

final class _Smime implements SmimeSendKeys {
  _Smime(this.smimeState, this.keys);
  @override
  final SmimeState smimeState;
  final Map<String, SmimePrivateKey> keys;
  @override
  SmimePrivateKey? smimeKey(String fingerprint) => keys[fingerprint];
}

void main() {
  final mine = testKey('Me Myself <me@example.com>');
  final bobKey = testKey('Bob <bob@example.com>');
  const me = Identity(id: 'acc/me', email: 'me@example.com', name: 'Me Myself');
  late Keyring keyring;
  late KeySession session;
  late IsolateComposer composer;

  setUp(() async {
    keyring = Keyring(MemoryKeyringStorage());
    await keyring.load();
    await keyring.addOwnKey(secret: mine, public: pgp.publicKey(mine));
    await keyring.addPublicKeys([pgp.publicKey(bobKey)], acceptance: KeyAcceptance.verified);
    session = KeySession()..put(mine, pin: true);
    final alice = sm.aliceBundle.keys.single;
    final smime = _Smime(
      SmimeState(
        own: [SmimeOwnCertificate(certificate: alice.certificate, chain: sm.aliceBundle.chain, added: DateTime(2026))],
        authorities: [sm.testRoot],
      ),
      {alice.certificate.fingerprint: alice.key},
    );
    composer = IsolateComposer(SecureSendKeys(SessionSendKeys(keyring, () => session), smime));
  });

  OutgoingMessage message(OutgoingSecurity security, {String to = 'bob@example.com'}) => OutgoingMessage(
    accountId: 'acc',
    identityId: 'acc/me',
    to: [EmailAddress(to)],
    subject: 'Report',
    text: 'The numbers.',
    attachments: [
      OutgoingAttachment(filename: 'q3.csv', mimeType: 'text/csv', data: Uint8List.fromList(List.filled(300000, 65))),
    ],
    security: security,
  );

  test('composes signed and encrypted OpenPGP mail in another isolate, with the session’s keys', () async {
    final raw = await composer.composeAsync(
      message(const OutgoingSecurity(encrypt: true, sign: true)),
      me,
      messageId: 'iso@example.com',
      date: DateTime.utc(2026, 10, 5),
    );
    final r = const PgpMimeReader(pgp).read(raw, keys: [bobKey], verifiers: [pgp.publicKey(mine)]);
    expect(r.status.decrypted, isTrue);
    expect(r.status.signature!.status, PgpSignatureStatus.good);
    expect(r.status.protectedSubject, 'Report');
  });

  test('and S/MIME, whose private key crosses too', () async {
    final raw = await composer.composeAsync(
      message(const OutgoingSecurity(sign: true, technology: SecurityTechnology.smime)),
      const Identity(id: 'acc/alice', email: 'alice@example.org'),
      messageId: 'iso-smime@example.org',
      date: DateTime.utc(2026, 10, 5),
    );
    final r = const SmimeReader(sm.smime)
        .read(raw, anchors: SmimeTrustAnchors([sm.testRoot]), now: DateTime.utc(2026, 10, 5));
    expect(r.status.signature?.good, isTrue);
  });

  test('a locked key fails there as here: never in the clear', () async {
    session.clear();
    await expectLater(
      composer.composeAsync(message(const OutgoingSecurity(sign: true)), me, messageId: 'x@example.com'),
      throwsA(isA<MailException>().having((e) => e.message, 'message', contains('locked'))),
    );
    // Plain mail needs no key.
    expect(await composer.composeAsync(message(OutgoingSecurity.none), me, messageId: 'y@example.com'), isNotEmpty);
  });
}
