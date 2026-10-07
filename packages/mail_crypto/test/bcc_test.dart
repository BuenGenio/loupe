// Bcc privacy: encrypted mail with Bcc recipients goes out as one copy for
// To and Cc and one per Bcc recipient (OutgoingMessage.deliveries), and no
// copy names a Bcc recipient's key or address but their own.
import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_imap/mail_imap.dart' show MimeMessageComposer;
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'smime/smime_support.dart' as sm;
import 'support.dart';

final class _PgpKeys implements PgpSendKeys {
  _PgpKeys(this.keyring, this.session);
  final Keyring keyring;
  final KeySession session;

  @override
  KeyringState get state => keyring.state;

  @override
  PgpKey? unlockedKey(String fingerprint) => session[fingerprint];
}

final class _SmimeKeys implements SmimeSendKeys {
  _SmimeKeys(this.smimeState, this.keys);
  @override
  final SmimeState smimeState;
  final Map<String, SmimeKeyHandle> keys;
  @override
  SmimeKeyHandle? smimeKey(String fingerprint) => keys[fingerprint];
}

/// One composed copy: the envelope, the bytes, and the parsed message.
typedef Copy = ({List<String> envelope, Uint8List raw, MimeEntity mime, bool filed});

List<Copy> composeAll(MessageComposer composer, OutgoingMessage message, Identity from) => [
  for (final d in message.deliveries(sender: from.email))
    () {
      final raw = composer.compose(d.message, from, messageId: 'bcc-test@example.org', date: sm.today);
      return (envelope: d.recipients, raw: raw, mime: MimeEntity.parse(raw), filed: d.filed);
    }(),
];

/// Every header of [mime] as one lower-cased string.
String headersOf(MimeEntity mime) => [for (final (n, v) in mime.headers) '$n: $v'].join('\n').toLowerCase();

void main() {
  group('OpenPGP', () {
    const alice = Identity(id: 'a/me', email: 'alice@openpgp.example', name: 'Alice Lovelace');
    const bob = EmailAddress('bob@openpgp.example', 'Bob Babbage');
    const carol = EmailAddress('carol@example.com', 'Carol');
    // Thunderbird's test key; its passphrase is "x".
    final carolSecret = pgp.unlock(tbKey('carol@example.com-0x3099ff1238852b9f-secret.asc'), 'x');
    const reader = PgpMimeReader(pgp);
    late PgpMessageComposer composer;

    setUp(() async {
      final keyring = Keyring(MemoryKeyringStorage());
      await keyring.load();
      await keyring.addOwnKey(secret: aliceSecret, public: alicePublic);
      await keyring.addPublicKeys([bobPublic, carolPublic], acceptance: KeyAcceptance.verified);
      composer = PgpMessageComposer(
        MimeMessageComposer(),
        _PgpKeys(keyring, KeySession()..put(aliceSecret)),
        backend: pgp,
      );
    });

    // Alice writes to Bob, copies herself (so the To/Cc copy carries
    // Autocrypt-Gossip), and sends a blind copy to Carol.
    final message = OutgoingMessage(
      accountId: 'a',
      identityId: 'a/me',
      to: const [bob],
      cc: [EmailAddress(alice.email, alice.name)],
      bcc: const [carol],
      subject: 'Secret plans',
      text: 'Meet at the café at noon.',
      security: const OutgoingSecurity(encrypt: true, sign: true),
    );

    /// Key ids of the PKESK packets of an encrypted copy.
    Set<String> keyIdsOf(Copy c) => pgp.recipientKeyIds(c.mime.parts[1].decodedBody).toSet();

    test('To and Cc get one copy, Carol her own; each names only its own recipients’ keys', () {
      final copies = composeAll(composer, message, alice);
      expect(
        [for (final c in copies) c.envelope],
        [
          ['bob@openpgp.example', 'alice@openpgp.example'],
          ['carol@example.com'],
        ],
      );
      expect([for (final c in copies) c.filed], [true, false], reason: 'Sent keeps the To and Cc copy');

      final (main, blind) = (copies[0], copies[1]);
      for (final c in copies) {
        expect(c.mime.mimeType, 'multipart/encrypted');
        expect(c.mime.header('subject'), '...');
        expect(c.mime.header('message-id'), '<bcc-test@example.org>');
        expect(c.mime.header('to'), contains('bob@openpgp.example'), reason: 'every copy shows To and Cc');
        expect(c.mime.header('bcc'), isNull);
      }

      // The PKESK packets: the key ids anyone holding a copy can read.
      final aliceIds = alicePublic.keyIds;
      expect(keyIdsOf(main), isNotEmpty);
      expect(keyIdsOf(main).every((id) => bobPublic.keyIds.contains(id) || aliceIds.contains(id)), isTrue);
      expect(keyIdsOf(main).intersection(carolPublic.keyIds), isEmpty, reason: 'Carol’s key is not in the To/Cc copy');
      expect(keyIdsOf(main).intersection(bobPublic.keyIds), isNotEmpty);
      expect(keyIdsOf(blind).every((id) => carolPublic.keyIds.contains(id) || aliceIds.contains(id)), isTrue);
      expect(keyIdsOf(blind).intersection(carolPublic.keyIds), isNotEmpty);
      expect(keyIdsOf(blind).intersection(bobPublic.keyIds), isEmpty, reason: 'Bob’s key is not in Carol’s copy');
      expect(keyIdsOf(blind).intersection(aliceIds), isNotEmpty, reason: 'the sender can read every copy');

      // Nobody else's headers name Carol.
      expect(headersOf(main.mime), isNot(contains('carol')));

      // Bob reads his copy, and nothing inside names Carol either.
      final forBob = reader.read(main.raw, keys: [bobSecret], verifiers: [alicePublic]);
      expect(forBob.status.decrypted, isTrue);
      expect(forBob.status.signature!.status, PgpSignatureStatus.good);
      expect(forBob.status.protectedSubject, 'Secret plans');
      expect(
        forBob.status.gossip.map((g) => AutocryptHeader.parse(g)!.addr),
        unorderedEquals(['bob@openpgp.example', 'alice@openpgp.example']),
      );
      expect(headersOf(forBob.entity!), isNot(contains('carol')));
      expect(reader.read(blind.raw, keys: [bobSecret]).status.failure, PgpDecryptFailure.noSecretKey);

      // Carol reads hers; it shows the To and Cc everyone sees.
      final forCarol = reader.read(blind.raw, keys: [carolSecret], verifiers: [alicePublic]);
      expect(forCarol.status.decrypted, isTrue);
      expect(forCarol.status.signature!.status, PgpSignatureStatus.good);
      expect(forCarol.status.protectedSubject, 'Secret plans');
      expect(forCarol.status.gossip, isEmpty, reason: 'gossip would tell Carol nothing she may not know, but none');
      expect(forCarol.entity!.header('to'), contains('bob@openpgp.example'));
      expect(contentFromEntity(forCarol.entity!, emailId: 'x').text, contains('Meet at the café at noon.'));
      expect(reader.read(main.raw, keys: [carolSecret]).status.failure, PgpDecryptFailure.noSecretKey);

      // Alice reads both (Sent, and the copy she might find elsewhere).
      for (final c in copies) {
        expect(reader.read(c.raw, keys: [aliceSecret]).status.decrypted, isTrue);
      }
    });

    test('signed only: one message for everyone, as before', () {
      final copies = composeAll(composer, message.copyWith(security: const OutgoingSecurity(sign: true)), alice);
      expect(copies.single.envelope, ['bob@openpgp.example', 'alice@openpgp.example', 'carol@example.com']);
      expect(copies.single.mime.mimeType, 'multipart/signed');
      expect(headersOf(copies.single.mime), isNot(contains('carol')));
    });
  });

  group('S/MIME', () {
    const alice = Identity(id: 'a', email: 'alice@example.org', name: 'Alice Example');
    const bob = EmailAddress('bob@example.net', 'Bob Example');
    const hank = EmailAddress('hank@example.org', 'Hank Inside');
    final hankCert = sm.cert('hank.crt');
    final constrained = sm.cert('constrained.crt');

    SmimeMessageComposer composer() => SmimeMessageComposer(
      MimeMessageComposer(),
      _SmimeKeys(
        SmimeState(
          own: [SmimeOwnCertificate(certificate: sm.alice.certificate, chain: sm.aliceBundle.chain, added: sm.today)],
          contacts: [
            SmimeContactCertificate(certificate: sm.bob.certificate, chain: [sm.testCa], added: sm.today),
            SmimeContactCertificate(certificate: hankCert, chain: [constrained], added: sm.today),
          ],
          authorities: [sm.testRoot],
        ),
        {sm.alice.certificate.fingerprint: sm.alice.key},
      ),
      backend: sm.smime,
      clock: () => sm.today,
    );

    final message = OutgoingMessage(
      accountId: 'a',
      identityId: 'a',
      to: const [bob],
      bcc: const [hank],
      subject: 'Quarterly numbers',
      text: 'The numbers are in.',
      security: const OutgoingSecurity(encrypt: true, sign: true, technology: SecurityTechnology.smime),
    );

    List<SmimeCertificate> recipientsOf(Copy c) {
      final ids = sm.smime.recipientsOf(c.mime.decodedBody);
      return [
        for (final cert in [sm.alice.certificate, sm.bob.certificate, hankCert])
          if (ids.any((id) => id.matches(cert))) cert,
      ];
    }

    test('To gets one copy, Hank his own; each RecipientInfo set names only its own recipients', () {
      final copies = composeAll(composer(), message, alice);
      expect(
        [for (final c in copies) c.envelope],
        [
          ['bob@example.net'],
          ['hank@example.org'],
        ],
      );
      final (main, blind) = (copies[0], copies[1]);
      for (final c in copies) {
        expect(c.mime.mimeType, 'application/pkcs7-mime');
        expect(c.mime.header('to'), contains('bob@example.net'));
        expect(c.mime.header('bcc'), isNull);
        expect(sm.smime.recipientsOf(c.mime.decodedBody), hasLength(2));
      }
      expect(recipientsOf(main), [sm.alice.certificate, sm.bob.certificate]);
      expect(recipientsOf(blind), [sm.alice.certificate, hankCert]);
      expect(headersOf(main.mime), isNot(contains('hank')));
      expect(latin1.decode(main.raw), isNot(contains('Hank')));

      final forBob = const SmimeReader(sm.smime).read(main.raw, keys: [sm.bob], anchors: sm.testAnchors, now: sm.today);
      expect(forBob.status.decrypted, isTrue);
      expect(forBob.status.signature?.good, isTrue);
      expect(headersOf(forBob.entity!), isNot(contains('hank')));
      final notBob = const SmimeReader(sm.smime)
          .read(blind.raw, keys: [sm.bob], anchors: sm.testAnchors, now: sm.today);
      expect(notBob.status.failure, SmimeDecryptFailure.noKey);
      for (final c in copies) {
        final mine = const SmimeReader(sm.smime).read(c.raw, keys: [sm.alice], anchors: sm.testAnchors, now: sm.today);
        expect(mine.status.decrypted, isTrue);
      }
    });
  });
}
