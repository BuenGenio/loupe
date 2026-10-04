import 'dart:io';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:test/test.dart';

import 'smime_support.dart';

/// Thunderbird's S/MIME test data, made by NSS (see fixtures/README.md).
Uint8List tb(String name) => File('test/fixtures/thunderbird-smime/$name').readAsBytesSync();

final tbCa = readCertificates(tb('TestCA.pem')).single;

SmimeKeyPair tbKey(String name) {
  final k = smime.readPkcs12(tb('$name.p12'), 'nss').keys.single;
  return SmimeKeyPair(k.certificate, k.key);
}

/// While the NSS test certificates are valid (until 2031-07-08).
final tbNow = DateTime.utc(2026, 10, 4);

void main() {
  final keys = [tbKey('Alice'), tbKey('Bob'), tbKey('Dave')];

  SmimeMessageStatus read(String name) =>
      const SmimeReader(smime).read(tb(name), keys: keys, anchors: SmimeTrustAnchors([tbCa]), now: tbNow).status;

  // Thunderbird's expectations (mailnews/mime/test/unit/test_smime_decrypt.js).
  for (final (file, encrypted, signed, good, signer) in [
    ('alice.env.eml', true, false, false, null),
    ('alice.dsig.SHA256.multipart.eml', false, true, true, 'Alice'),
    ('alice.dsig.SHA256.multipart.bad.eml', false, true, false, 'Alice'),
    ('alice.dsig.SHA256.multipart.mismatch-econtent.eml', false, true, false, 'Alice'),
    ('alice.dsig.SHA1.multipart.eml', false, true, false, 'Alice'),
    ('alice.future.dsig.SHA256.multipart.eml', false, true, false, 'Alice'),
    ('alice.dsig.SHA256.multipart.env.eml', true, true, true, 'Alice'),
    ('alice.sig.SHA256.opaque.eml', false, true, true, 'Alice'),
    ('alice.sig.SHA256.opaque.env.eml', true, true, true, 'Alice'),
    // Signed around the encryption: the signature only covers ciphertext, so it doesn't count.
    ('alice.env.sig.SHA256.opaque.eml', true, false, false, null),
    ('alice.env.dsig.SHA256.multipart.eml', true, false, false, null),
    ('alice.plain.sig.SHA256.opaque.dave.sig.SHA256.opaque.eml', false, true, true, 'Dave'),
    // Thunderbird reports this one bad: it checks Alice's inner certificate against Dave's From
    // (but not in the opaque-in-opaque one above). Loupe reports the outer signer, Dave, unless
    // an inner signature is broken.
    ('alice.plain.dsig.SHA256.multipart.dave.sig.SHA256.opaque.eml', false, true, true, 'Dave'),
  ]) {
    test(
      '$file: ${encrypted ? 'encrypted, ' : ''}${signed ? (good ? 'good signature' : 'bad signature') : 'not signed'}',
      () {
        final status = read(file);
        expect(status.encrypted, encrypted);
        if (encrypted) expect(status.decrypted, isTrue);
        expect(status.signature != null, signed);
        if (signed) {
          expect(status.signature!.good, good);
          expect(status.signature!.certificate?.displayName, signer);
        }
      },
    );
  }

  test('why the bad ones are bad', () {
    expect(read('alice.dsig.SHA256.multipart.bad.eml').signature!.modified, isTrue);
    expect(read('alice.dsig.SHA256.multipart.mismatch-econtent.eml').signature!.modified, isTrue);
    expect(read('alice.dsig.SHA1.multipart.eml').signature!.weak, isTrue);
    final future = read('alice.future.dsig.SHA256.multipart.eml').signature!;
    expect((future.valid, future.dateMismatch, future.trust!.trusted), (true, true, true));
  });

  test('the decrypted text', () {
    for (final f in ['alice.env.eml', 'alice.dsig.SHA256.multipart.env.eml', 'alice.sig.SHA256.opaque.env.eml']) {
      final r = const SmimeReader(smime).read(tb(f), keys: keys, anchors: SmimeTrustAnchors([tbCa]), now: tbNow);
      expect(r.entity?.text, contains('This is a test message from Alice to Bob.'), reason: f);
    }
  });

  test('parseMailDate', () {
    expect(parseMailDate('Wed, 08 Jul 2026 17:36:38 +0000'), DateTime.utc(2026, 7, 8, 17, 36, 38));
    expect(parseMailDate('8 Jul 2026 19:36 +0200 (CEST)'), DateTime.utc(2026, 7, 8, 17, 36));
    expect(parseMailDate('Wed, 8 Jul 26 13:36:38 EDT'), DateTime.utc(2026, 7, 8, 17, 36, 38));
    expect(parseMailDate('yesterday'), isNull);
  });
}
