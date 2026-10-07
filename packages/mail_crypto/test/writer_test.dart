import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_imap/mail_imap.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support.dart';

final class _Keys implements PgpSendKeys {
  _Keys(this.keyring, this.session);
  final Keyring keyring;
  final KeySession session;

  @override
  KeyringState get state => keyring.state;

  @override
  PgpKey? unlockedKey(String fingerprint) => session[fingerprint];
}

const alice = Identity(id: 'a/me', email: 'alice@openpgp.example', name: 'Alice Lovelace');
const bob = EmailAddress('bob@openpgp.example', 'Bob Babbage');
const carol = EmailAddress('carol@example.com', 'Carol');

void main() {
  late Keyring keyring;
  late KeySession session;
  late PgpMessageComposer composer;
  const reader = PgpMimeReader(pgp);

  setUp(() async {
    keyring = Keyring(MemoryKeyringStorage());
    await keyring.load();
    await keyring.addOwnKey(secret: aliceSecret, public: alicePublic);
    await keyring.addPublicKeys([bobPublic], acceptance: KeyAcceptance.verified);
    session = KeySession()..put(aliceSecret);
    composer = PgpMessageComposer(MimeMessageComposer(), _Keys(keyring, session), backend: pgp);
  });

  Uint8List compose(
    OutgoingSecurity security, {
    List<EmailAddress> to = const [bob],
    String subject = 'Secret plans',
  }) => composer.compose(
    OutgoingMessage(
      accountId: 'a',
      identityId: 'a/me',
      to: to,
      subject: subject,
      text: 'Meet at the café at noon.\n\nAlice',
      security: security,
    ),
    alice,
    messageId: 'm1@openpgp.example',
    date: DateTime.utc(2026, 10, 4, 12),
  );

  group('plain', () {
    test('adds the Autocrypt header when the sender has a key', () {
      final m = MimeEntity.parse(compose(OutgoingSecurity.none));
      expect(m.mimeType, 'text/plain');
      final h = autocryptHeaderFrom(m.headers, 'alice@openpgp.example')!;
      expect(h.preferMutual, isFalse);
      expect(pgp.readKeys(h.keydata).single.fingerprint, alicePublic.fingerprint);
      expect(m.text, contains('café'));
    });

    test('passes through unchanged without a key', () async {
      await keyring.removeOwnKey(aliceSecret.fingerprint);
      final plain = MimeMessageComposer().compose(
        const OutgoingMessage(accountId: 'a', identityId: 'a/me', to: [bob], subject: 'Hi', text: 'Hi'),
        alice,
        messageId: 'm1@x',
        date: DateTime.utc(2026),
      );
      final wrapped = composer.compose(
        const OutgoingMessage(accountId: 'a', identityId: 'a/me', to: [bob], subject: 'Hi', text: 'Hi'),
        alice,
        messageId: 'm1@x',
        date: DateTime.utc(2026),
      );
      expect(wrapped, plain);
    });
  });

  group('encrypted', () {
    test('multipart/encrypted with a hidden subject; Bob decrypts, verifies, reads the real subject', () {
      final raw = compose(const OutgoingSecurity(encrypt: true, sign: true));
      final m = MimeEntity.parse(raw);
      expect(m.mimeType, 'multipart/encrypted');
      expect(m.contentType['protocol'], 'application/pgp-encrypted');
      expect(m.header('subject'), '...');
      expect(m.parts.map((p) => p.mimeType), ['application/pgp-encrypted', 'application/octet-stream']);
      expect(utf8.decode(raw), isNot(contains('café')));
      expect(autocryptHeaderFrom(m.headers, 'alice@openpgp.example'), isNotNull);

      final r = reader.read(raw, keys: [bobSecret], verifiers: [alicePublic]);
      expect(r.status.decrypted, isTrue);
      expect(r.status.signature!.status, PgpSignatureStatus.good);
      expect(r.status.protectedSubject, 'Secret plans');
      expect(contentFromEntity(r.entity!, emailId: 'x').text, contains('Meet at the café at noon.'));
      expect(r.status.gossip, isEmpty, reason: 'one recipient: no gossip');
      // Encrypted to the sender too, so the Sent copy stays readable.
      expect(reader.read(raw, keys: [aliceSecret]).status.decrypted, isTrue);
    });

    test('several recipients get Autocrypt-Gossip inside', () async {
      await keyring.addPublicKeys([carolPublic], acceptance: KeyAcceptance.unverified);
      final raw = compose(const OutgoingSecurity(encrypt: true), to: [bob, carol]);
      final r = reader.read(raw, keys: [bobSecret]);
      expect(
        r.status.gossip.map((g) => AutocryptHeader.parse(g)!.addr),
        unorderedEquals(['bob@openpgp.example', 'carol@example.com']),
      );
    });

    test('refuses to send without a key for every recipient, or with a locked key', () {
      expect(
        () => compose(const OutgoingSecurity(encrypt: true), to: [const EmailAddress('dave@example.org')]),
        throwsA(isA<MailException>().having((e) => e.message, 'message', contains('dave@example.org'))),
      );
      session.lockAll();
      expect(
        () => compose(const OutgoingSecurity(encrypt: true, sign: true)),
        throwsA(isA<MailException>().having((e) => e.message, 'message', contains('locked'))),
      );
      expect(compose(const OutgoingSecurity(encrypt: true)), isNotEmpty, reason: 'encrypting needs no secret key');
    });

    test('drafts are encrypted to the sender only and remember the choices', () {
      final raw = compose(const OutgoingSecurity(encrypt: true, sign: true).forDraft());
      final m = MimeEntity.parse(raw);
      expect(draftSecurityFrom(m.headers), const OutgoingSecurity(encrypt: true, sign: true));
      expect(reader.read(raw, keys: [bobSecret]).status.failure, PgpDecryptFailure.noSecretKey);
      final mine = reader.read(raw, keys: [aliceSecret]);
      expect(mine.status.decrypted, isTrue);
      expect(mine.status.signature, isNull);
      final plainDraft = MimeEntity.parse(compose(const OutgoingSecurity(sign: true).forDraft()));
      expect(draftSecurityFrom(plainDraft.headers), const OutgoingSecurity(sign: true));
      expect(plainDraft.mimeType, 'text/plain');
    });
  });

  group('signed', () {
    test('multipart/signed with micalg; verifies, and a changed body does not', () {
      final raw = compose(const OutgoingSecurity(sign: true));
      final m = MimeEntity.parse(raw);
      expect(m.mimeType, 'multipart/signed');
      expect(m.contentType['micalg'], startsWith('pgp-sha'));
      expect(m.header('subject'), 'Secret plans');
      final r = reader.read(raw, verifiers: [alicePublic]);
      expect(r.status.signature!.status, PgpSignatureStatus.good);
      expect(contentFromEntity(r.entity!, emailId: 'x').text, contains('café'));
      final tampered = utf8.decode(raw).replaceFirst('noon', 'nine');
      expect(reader.read(bytes(tampered), verifiers: [alicePublic]).status.signature!.status, PgpSignatureStatus.bad);
    });

    test('attaching the public key adds an application/pgp-keys part', () {
      final raw = compose(const OutgoingSecurity(sign: true, attachPublicKey: true));
      final r = reader.read(raw, verifiers: [alicePublic]);
      final content = contentFromEntity(r.entity!, emailId: 'x');
      final key = content.attachments.single;
      expect(key.mimeType, 'application/pgp-keys');
      expect(key.filename, 'OpenPGP_0x${alicePublic.keyId}.asc');
      final data = partOf(r.entity!, key.partId)!.decodedBody;
      expect(pgp.readKeys(data).single.fingerprint, alicePublic.fingerprint);
    });
  });

  group('an invitation reply', () {
    const ics =
        'BEGIN:VCALENDAR\r\nVERSION:2.0\r\nMETHOD:REPLY\r\nBEGIN:VEVENT\r\n'
        'ATTENDEE;PARTSTAT=ACCEPTED:mailto:alice@openpgp.example\r\nORGANIZER:mailto:bob@openpgp.example\r\n'
        'UID:plans@openpgp.example\r\nSEQUENCE:0\r\nDTSTAMP:20261004T120000Z\r\nEND:VEVENT\r\nEND:VCALENDAR\r\n';

    Uint8List reply(OutgoingSecurity security) => composer.compose(
      OutgoingMessage(
        accountId: 'a',
        identityId: 'a/me',
        to: const [bob],
        subject: 'Accepted: Secret plans',
        text: 'Alice Lovelace has accepted: Secret plans',
        security: security,
        calendar: const OutgoingCalendar(method: 'REPLY', data: ics),
      ),
      alice,
      messageId: 'm2@openpgp.example',
      date: DateTime.utc(2026, 10, 4, 12),
    );

    test('keeps its text/calendar alternative, plain, signed and encrypted', () {
      final plain = MimeEntity.parse(reply(OutgoingSecurity.none));
      expect(plain.mimeType, 'multipart/alternative');
      expect(plain.parts.map((p) => p.mimeType), ['text/plain', 'text/calendar']);
      expect(plain.parts.last.contentType['method'], 'REPLY');

      for (final security in const [OutgoingSecurity(sign: true), OutgoingSecurity(encrypt: true, sign: true)]) {
        final r = reader.read(reply(security), keys: [bobSecret], verifiers: [alicePublic]);
        expect(r.status.signature!.status, PgpSignatureStatus.good, reason: '$security');
        final content = contentFromEntity(r.entity!, emailId: 'x');
        expect(content.text, contains('has accepted'));
        final calendar = content.attachments.single;
        expect(calendar.mimeType, 'text/calendar');
        expect(utf8.decode(partOf(r.entity!, calendar.partId)!.decodedBody).trimRight(), ics.trimRight());
      }
    });
  });

  test('gpg reads what we send: decrypts, verifies the signature inside and the PGP/MIME signature', () async {
    final gpg = Gpg.create();
    if (gpg == null) {
      markTestSkipped('gpg is not installed');
      return;
    }
    addTearDown(gpg.dispose);
    // Bob's secret key is unprotected (draft-bre-openpgp-samples).
    gpg.import(pgp.armor(bobSecret));
    gpg.import(pgp.armor(alicePublic));
    final encrypted = MimeEntity.parse(compose(const OutgoingSecurity(encrypt: true, sign: true)));
    final out = gpg.run([
      '--trust-model',
      'always',
      '--status-fd',
      '2',
      '--decrypt',
    ], stdin: encrypted.parts[1].decodedBody);
    expect(out.exitCode, 0, reason: '${out.stderr}');
    expect(out.stderr as String, contains('GOODSIG'));
    final inner = MimeEntity.parse(Uint8List.fromList(out.stdout as List<int>));
    expect(inner.header('subject'), 'Secret plans');
    expect(inner.contentType['protected-headers'], 'v1');

    final signed = MimeEntity.parse(compose(const OutgoingSecurity(sign: true)));
    final dir = gpg.home.createTempSync('signed-');
    final part = File('${dir.path}/part')..writeAsBytesSync(signed.parts[0].raw);
    final sig = File('${dir.path}/part.asc')..writeAsBytesSync(signed.parts[1].decodedBody);
    final verify = Process.runSync(
      'gpg',
      ['--batch', '--status-fd', '1', '--verify', sig.path, part.path],
      environment: {'GNUPGHOME': gpg.home.path},
    );
    expect(verify.stdout as String, contains('GOODSIG'), reason: '${verify.stderr}');
  });
}
