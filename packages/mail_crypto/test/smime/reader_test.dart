import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:test/test.dart';

import 'smime_support.dart';

SmimeReadResult read(String name, {List<SmimeKeyPair> keys = const [], String? sender}) =>
    const SmimeReader(smime).read(smimeMail(name), keys: keys, anchors: testAnchors, now: today, sender: sender);

void main() {
  test('detection from the header fields', () {
    SmimeProtection of(String name) => detectSmime(MimeEntity.parse(smimeMail(name)).headers);
    expect(of('signed-detached.eml'), SmimeProtection.signedDetached);
    expect(of('signed-opaque.eml'), SmimeProtection.signedOpaque);
    expect(of('enveloped-rsa.eml'), SmimeProtection.enveloped);
    expect(of('authenveloped.eml'), SmimeProtection.authEnveloped);
    expect(
      detectSmime(const [('Content-Type', 'multipart/signed; protocol="application/pgp-signature"')]),
      SmimeProtection.none,
    );
    expect(
      detectSmime(const [('Content-Type', 'application/x-pkcs7-mime; name=smime.p7m')]),
      SmimeProtection.enveloped,
    );
  });

  test('signed (detached): good, by a trusted certificate of the sender', () {
    final r = read('signed-detached.eml');
    final s = r.status.signature!;
    expect(
      (r.status.protection, r.status.encrypted, s.valid, s.good),
      (SmimeProtection.signedDetached, false, true, true),
    );
    expect(s.certificate?.displayName, 'Alice Example');
    expect(s.trust?.issuerName, 'Loupe Test');
    expect(r.entity?.text, contains('signed with S/MIME. Grüße!'));
  });

  test('signed (opaque, as Outlook can send): the content comes out of the signature', () {
    final r = read('signed-opaque.eml');
    expect(r.status.protection, SmimeProtection.signedOpaque);
    expect(r.status.signature!.good, isTrue);
    expect(r.entity?.mimeType, 'text/plain');
    expect(r.entity?.text, contains('Grüße!'));
  });

  test('problems: modified, expired, untrusted, wrong address', () {
    final modified = read('signed-modified.eml').status.signature!;
    expect((modified.valid, modified.modified, modified.good), (false, true, false));

    final expired = read('signed-expired.eml').status.signature!;
    expect(expired.valid, isTrue);
    expect(expired.trust?.problems, {SmimeProblem.expired});

    final untrusted = read('signed-untrusted.eml').status.signature!;
    // Mallory claims Alice's address, from a CA nobody trusts.
    expect(untrusted.valid, isTrue);
    expect(untrusted.trust?.problems, {SmimeProblem.untrusted});

    final other = read('signed-detached.eml', sender: 'ceo@example.org').status.signature!;
    expect(other.trust?.problems, {SmimeProblem.wrongAddress});
  });

  test('encrypted: decrypted with the right key; the cipher is told', () {
    final r = read('enveloped-rsa.eml', keys: [alice]);
    expect((r.status.encrypted, r.status.decrypted, r.status.cipher), (true, true, 'AES-256-CBC'));
    expect(r.status.signature, isNull);
    expect(r.entity?.text, contains('Grüße!'));

    final gcm = read('authenveloped.eml', keys: [bob]);
    expect((gcm.status.protection, gcm.status.authenticated), (SmimeProtection.authEnveloped, true));
  });

  test('encrypted without the key', () {
    final r = read('enveloped-other.eml', keys: [alice, bob]);
    expect((r.status.encrypted, r.status.failure), (true, SmimeDecryptFailure.noKey));
    expect(r.entity, isNull);
    expect(read('enveloped-rsa.eml').status.failure, SmimeDecryptFailure.noKey);
  });

  test('signed, then encrypted: multipart/signed inside (Thunderbird) and opaque inside (Outlook)', () {
    for (final name in ['signed-enveloped.eml', 'opaque-enveloped.eml']) {
      final r = read(name, keys: [bob]);
      expect(r.status.decrypted, isTrue, reason: name);
      expect(r.status.protection, SmimeProtection.enveloped);
      expect(r.status.signature?.good, isTrue, reason: name);
      expect(r.status.signature?.certificate?.displayName, 'Alice Example');
      expect(r.entity?.text, contains('Grüße!'), reason: name);
    }
  });

  group('multipart/signed wrapping: only the signed part is shown as signed', () {
    const boundary = '------95CFF1AC2FFBA83C1C8428AEF42FE630';
    const html = 'Content-Type: text/html; charset=utf-8\r\n\r\n<p>Please pay the new account: EVIL</p>\r\n';
    const pdf =
        'Content-Type: application/pdf; name="invoice.pdf"\r\n'
        'Content-Disposition: attachment; filename="invoice.pdf"\r\n\r\n%PDF-1.4\r\n';

    /// signed-detached.eml (CRLF) with [part] put before the part at [index] (1: the signature; 2: the end).
    Uint8List withPart(String part, int index) {
      final text = latin1.decode(smimeMail('signed-detached.eml')).replaceAll('\r\n', '\n').replaceAll('\n', '\r\n');
      final delimiters = RegExp('^$boundary', multiLine: true).allMatches(text).toList();
      final at = delimiters[index].start;
      return latin1.encode('${text.substring(0, at)}$boundary\r\n$part\r\n${text.substring(at)}');
    }

    test('a part added after the signature (an attachment, an HTML body)', () {
      for (final part in [pdf, html]) {
        final r = const SmimeReader(smime).read(withPart(part, 2), anchors: testAnchors, now: today);
        final s = r.status.signature!;
        expect((s.valid, s.good, s.modified), (false, false, true));
        expect(s.problem, contains('doesn’t cover'));
        // What is shown is the signed part alone.
        expect(r.entity?.mimeType, 'text/plain');
        expect(r.entity?.text, contains('signed with S/MIME'));
        expect(r.entity?.text, isNot(contains('EVIL')));
      }
    });

    test('a part put between the signed part and the signature', () {
      final r = const SmimeReader(smime).read(withPart(html, 1), anchors: testAnchors, now: today);
      expect(r.status.signature!.valid, isFalse);
      expect(r.status.signature!.good, isFalse);
      expect(r.entity?.text, isNot(contains('EVIL')));
    });
  });

  test('a boundary that isn’t ASCII: not split, never an exception', () {
    final text = latin1.decode(smimeMail('signed-detached.eml'));
    final raw = latin1.encode(
      text.replaceFirst(
        'boundary="----95CFF1AC2FFBA83C1C8428AEF42FE630"',
        'boundary="----95CFF1AC2FFBA83C1C8428AEF42FÉ630"',
      ),
    );
    final r = const SmimeReader(smime).read(raw, anchors: testAnchors, now: today);
    expect(r.status.signature, isNull);
    expect(MimeEntity.parse(raw).parts, isEmpty);
  });

  test('a header parameter name with a CR in it: read, never an exception', () {
    // Found by the fuzzer: HeaderValue.parse's name pattern didn't match it (a null check threw).
    const ct = 'multipart/signed; protocol="application/pkcs7-signature"; a\rb=1; micalg=sha-256';
    expect(HeaderValue.parse(ct)['a\rb'], '1');
    expect(detectSmime(const [('Content-Type', ct)]), SmimeProtection.signedDetached);
    final raw = latin1.encode(
      latin1.decode(smimeMail('signed-detached.eml')).replaceFirst('micalg="sha-256";', 'a\rb=1;'),
    );
    expect(const SmimeReader(smime).read(raw, anchors: testAnchors, now: today).status.signature?.good, isTrue);
  });

  test('recipients of an encrypted message', () {
    final ids = const SmimeReader(smime).recipientsOf(smimeMail('signed-enveloped.eml'));
    expect(ids.map((i) => i.serialNumber?.toInt()), unorderedEquals([101, 100]));
    expect(const SmimeReader(smime).recipientsOf(smimeMail('signed-detached.eml')), isEmpty);
  });
}
