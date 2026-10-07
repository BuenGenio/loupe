import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/oids.dart';
import 'package:mail_imap/mail_imap.dart' show MimeMessageComposer;
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'smime_support.dart';

final class Keys implements SmimeSendKeys {
  Keys(this.smimeState, [this.keys = const {}]);
  @override
  final SmimeState smimeState;
  final Map<String, SmimeKeyHandle> keys;
  @override
  SmimeKeyHandle? smimeKey(String fingerprint) => keys[fingerprint];
}

/// Alice's side: her certificate and key, Bob's certificate (collected
/// earlier), the test root trusted.
SmimeState aliceState({List<String> bobCapabilities = const []}) => SmimeState(
  own: [SmimeOwnCertificate(certificate: alice.certificate, chain: aliceBundle.chain, added: today)],
  contacts: [
    SmimeContactCertificate(certificate: bob.certificate, chain: [testCa], added: today, capabilities: bobCapabilities),
  ],
  authorities: [testRoot],
);

const aliceId = Identity(id: 'a', email: 'alice@example.org', name: 'Alice Example');
const toBob = [EmailAddress('bob@example.net', 'Bob Example')];

Uint8List compose(OutgoingSecurity security, {SmimeState? state, List<EmailAddress> to = toBob}) {
  final composer = SmimeMessageComposer(
    MimeMessageComposer(),
    Keys(state ?? aliceState(), {alice.certificate.fingerprint: alice.key}),
    backend: smime,
    clock: () => today,
  );
  return composer.compose(
    OutgoingMessage(
      accountId: 'a',
      identityId: 'a',
      to: to,
      subject: 'Quarterly numbers',
      text: 'Hi Bob,\n\nThe numbers are in. Grüße!\n\nAlice',
      attachments: [
        OutgoingAttachment(
          filename: 'q3.csv',
          mimeType: 'text/csv',
          data: Uint8List.fromList(utf8.encode('a,b\n1,2\n')),
        ),
      ],
      security: security,
    ),
    aliceId,
    messageId: 'smime-test@example.org',
    date: today,
  );
}

SmimeReadResult readAs(Uint8List raw, SmimeKeyPair who) =>
    const SmimeReader(smime).read(raw, keys: [who], anchors: testAnchors, now: today);

const sign = OutgoingSecurity(sign: true, technology: SecurityTechnology.smime);
const signEncrypt = OutgoingSecurity(sign: true, encrypt: true, technology: SecurityTechnology.smime);

void main() {
  test('signed: multipart/signed with the signer’s certificates; Loupe verifies it', () {
    final raw = compose(sign);
    final root = MimeEntity.parse(raw);
    expect(root.mimeType, 'multipart/signed');
    expect(root.contentType['protocol'], 'application/pkcs7-signature');
    expect(root.contentType['micalg'], 'sha-256');
    expect(root.header('subject'), 'Quarterly numbers');
    expect(root.parts[1].filename, 'smime.p7s');
    final r = readAs(raw, bob);
    expect(r.status.signature?.good, isTrue);
    expect(r.status.signature?.certificates, containsAll([alice.certificate, testCa]));
    expect(r.status.signature?.capabilities.first, Oid.aes256Gcm);
    expect(r.entity?.mimeType, 'multipart/mixed');
  });

  test('signed and encrypted: to Bob (EC) and to Alice herself (RSA), the signature inside', () {
    final raw = compose(signEncrypt);
    final root = MimeEntity.parse(raw);
    expect(root.mimeType, 'application/pkcs7-mime');
    expect(root.contentType['smime-type'], 'enveloped-data');
    expect(latin1.decode(raw), isNot(contains('numbers are in')));
    for (final who in [bob, alice]) {
      final r = readAs(raw, who);
      expect((r.status.decrypted, r.status.cipher), (true, 'AES-256-CBC'));
      expect(r.status.signature?.good, isTrue);
      final text = contentFromEntity(r.entity!, emailId: 'x').text;
      expect(text, contains('The numbers are in. Grüße!'));
    }
  });

  test('AuthEnvelopedData (AES-256-GCM) when Bob’s app said it reads it', () {
    final raw = compose(signEncrypt, state: aliceState(bobCapabilities: [Oid.aes256Gcm, Oid.aes256Cbc]));
    expect(MimeEntity.parse(raw).contentType['smime-type'], 'authEnveloped-data');
    final r = readAs(raw, bob);
    expect((r.status.cipher, r.status.authenticated, r.status.signature?.good), ('AES-256-GCM', true, true));
  });

  test('a draft: encrypted to Alice only, not signed, the choices kept', () {
    final raw = compose(signEncrypt.forDraft());
    final root = MimeEntity.parse(raw);
    expect(root.header('x-loupe-security'), 'smime; encrypt; sign');
    expect(draftSecurityFrom(root.headers), signEncrypt);
    expect(readAs(raw, bob).status.failure, SmimeDecryptFailure.noKey);
    final mine = readAs(raw, alice);
    expect((mine.status.decrypted, mine.status.signature), (true, null));
  });

  test('never in the clear: no certificate for a recipient, none for the sender', () {
    expect(
      () => compose(signEncrypt, to: const [EmailAddress('carol@example.org')]),
      throwsA(isA<MailException>().having((e) => e.message, 'message', contains('carol@example.org'))),
    );
    expect(
      () => compose(sign, state: const SmimeState()),
      throwsA(isA<MailException>().having((e) => e.message, 'message', contains('no valid S/MIME certificate'))),
    );
    // The OpenPGP composer refuses S/MIME rather than using OpenPGP instead.
    final pgpOnly = PgpMessageComposer(MimeMessageComposer(), _NoPgp(), backend: const DartPgBackend());
    expect(
      () => pgpOnly.compose(
        const OutgoingMessage(accountId: 'a', identityId: 'a', to: toBob, security: sign),
        aliceId,
        messageId: 'x@y',
      ),
      throwsA(isA<MailException>()),
    );
  });

  test('anything not S/MIME goes to the inner composer unchanged', () {
    final raw = compose(OutgoingSecurity.none);
    expect(MimeEntity.parse(raw).mimeType, 'multipart/mixed');
  });

  group('OpenSSL reads what Loupe sends', () {
    final openssl = Openssl.create();
    tearDownAll(() => openssl?.dispose());

    test('openssl cms -verify checks the signed message', () {
      final r = openssl!.run([
        'cms', '-verify', '-in', openssl.file('signed.eml', compose(sign)), //
        '-CAfile', 'test/fixtures/smime/root.crt', '-purpose', 'smimesign',
      ]);
      expect(r.exitCode, 0, reason: '${r.stderr}');
      expect(latin1.decode(r.stdout as List<int>), contains('The numbers are in.'));
    }, skip: openssl == null ? 'openssl is not installed' : null);

    test('openssl cms -decrypt, then -verify, for Bob (EC); also the AES-GCM variant', () {
      for (final caps in [
        const <String>[],
        [Oid.aes256Gcm],
      ]) {
        final raw = compose(signEncrypt, state: aliceState(bobCapabilities: caps));
        final decrypted = openssl!.run([
          'cms', '-decrypt', '-in', openssl.file('enc.eml', raw), //
          '-recip', 'test/fixtures/smime/bob.crt', '-inkey', 'test/fixtures/smime/bob.key',
        ]);
        expect(decrypted.exitCode, 0, reason: '${decrypted.stderr}');
        final verified = openssl.run([
          'cms', '-verify', '-in', openssl.file('inner.eml', decrypted.stdout as List<int>), //
          '-CAfile', 'test/fixtures/smime/root.crt',
        ]);
        expect(verified.exitCode, 0, reason: '${verified.stderr}');
        // Protected headers inside (RFC 9788). By default S/MIME keeps the
        // Subject readable outside, so there's no legacy display.
        final inner = MimeEntity.parse(Uint8List.fromList(verified.stdout as List<int>));
        expect(inner.contentType['hp'], 'cipher');
        expect(inner.parts.first.text, startsWith('Hi Bob,'));
        expect(inner.parts.first.text, contains('The numbers are in.'));
        expect(latin1.decode(raw), contains('Subject: Quarterly numbers'));
      }
    }, skip: openssl == null ? 'openssl is not installed' : null);
  });
}

final class _NoPgp implements PgpSendKeys {
  @override
  KeyringState get state => KeyringState.empty;
  @override
  PgpKey? unlockedKey(String fingerprint) => null;
}
