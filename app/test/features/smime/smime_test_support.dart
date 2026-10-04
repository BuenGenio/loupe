import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:loupe/features/smime/smime_keys.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

/// mail_crypto's OpenSSL-made vectors (test CA, users, PKCS #12, messages).
const smimeFixtures = '../packages/mail_crypto/test/fixtures/smime';

Uint8List smimeFixture(String name) => File('$smimeFixtures/$name').readAsBytesSync();

const smime = DartSmimeBackend();

SmimeCertificate fixtureCert(String name) => readCertificates(smimeFixture(name)).single;

final testRoot = fixtureCert('root.crt');
final aliceBundle = smime.readPkcs12(smimeFixture('alice.p12'), 'alice-pass');
final bobBundle = smime.readPkcs12(smimeFixture('bob-3des.p12'), 'bob-pass');

const aliceAddress = EmailAddress('alice@example.org', 'Alice Example');
const bobAddress = EmailAddress('bob@example.net', 'Bob Example');

/// A keychain whose S/MIME store holds [own] identities, [contacts] and
/// [trusted] authorities, as the live store would find it; [storage] adds
/// to an existing one (with OpenPGP keys, say).
Future<MemoryKeyringStorage> smimeKeychain({
  List<SmimeBundle> own = const [],
  List<SmimeCertificate> contacts = const [],
  List<SmimeCertificate> trusted = const [],
  Map<String, IdentitySmime> identities = const {},
  MemoryKeyringStorage? storage,
}) async {
  final s = storage ?? MemoryKeyringStorage();
  final store = SmimeStore(s, prefix: liveSmimePrefix);
  await store.load();
  for (final b in own) {
    final k = b.keys.single;
    await store.addOwn(SmimeKeyPair(k.certificate, k.key), chain: b.chain);
  }
  for (final c in contacts) {
    await store.addContact(c, chain: [fixtureCert('intermediate.crt')], source: SmimeCertificateSource.imported);
  }
  for (final t in trusted) {
    await store.trust(t);
  }
  for (final MapEntry(:key, :value) in identities.entries) {
    await store.setIdentity(key, value);
  }
  return s;
}

/// The S/MIME store in [storage], read again.
Future<SmimeState> smimeStateIn(MemoryKeyringStorage storage) => SmimeStore(storage, prefix: liveSmimePrefix).load();

/// An S/MIME test message as RFC 822 text.
String smimeMessage(String name) => latin1.decode(smimeFixture(name));

/// The content an IMAP server would give for [raw]: its headers; for a
/// multipart/signed also its text and the signature as an attachment.
EmailContent serverContent(String emailId, String raw) {
  final root = MimeEntity.parse(Uint8List.fromList(latin1.encode(raw)));
  if (root.mimeType == 'multipart/signed') {
    return EmailContent(
      emailId: emailId,
      headers: root.headers,
      text: root.parts.first.text,
      attachments: const [
        Attachment(partId: '2', mimeType: 'application/pkcs7-signature', filename: 'smime.p7s', size: 3000),
      ],
    );
  }
  return EmailContent(
    emailId: emailId,
    headers: root.headers,
    attachments: const [Attachment(partId: '1', mimeType: 'application/pkcs7-mime', filename: 'smime.p7m', size: 4000)],
  );
}
