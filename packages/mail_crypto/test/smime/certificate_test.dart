import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/der.dart';
import 'package:test/test.dart';

import 'smime_support.dart';

void main() {
  group('DER', () {
    test('integers, object identifiers and times round-trip', () {
      for (final v in [0, 1, 127, 128, 255, 256, 65537, -1, -128, -129]) {
        expect(Asn1.parse(derInt(v)).intValue, v, reason: '$v');
      }
      final big = BigInt.parse('123456789012345678901234567890');
      expect(Asn1.parse(derInteger(big)).integer, big);
      for (final oid in ['1.2.840.113549.1.7.2', '2.16.840.1.101.3.4.1.46', '0.9.2342.19200300.100.1.25']) {
        expect(Asn1.parse(derOid(oid)).oid, oid);
      }
      final t = DateTime.utc(2026, 10, 4, 9, 30, 5);
      expect(Asn1.parse(derTime(t)).time, t);
      expect(Asn1.parse(derTime(DateTime.utc(2051))).tag, Tag.generalizedTime);
    });

    test('a SET OF is sorted, as DER wants', () {
      final set = derSet([derInt(300), derInt(2), derInt(1)]);
      expect([for (final c in Asn1.parse(set).children) c.intValue], [1, 2, 300]);
    });

    test('BER: indefinite lengths and constructed octet strings', () {
      // SEQUENCE (indefinite) { OCTET STRING (constructed, indefinite) { "ab", "c" } }
      final ber = Uint8List.fromList([0x30, 0x80, 0x24, 0x80, 0x04, 2, 0x61, 0x62, 0x04, 1, 0x63, 0, 0, 0, 0]);
      final seq = Asn1.parse(ber);
      expect(seq.encoded.length, ber.length);
      expect(ascii.decode(seq[0].octets), 'abc');
    });

    test('hostile input is refused, not crashed on', () {
      expect(() => Asn1.parse([0x30, 0x84, 0xff, 0xff, 0xff, 0xff]), throwsA(isA<Asn1Exception>()));
      expect(() => Asn1.parse([0x30, 0x80, 0x02, 0x01, 0x00]), throwsA(isA<Asn1Exception>()));
      final deep = Uint8List.fromList([
        for (var i = 0; i < 100; i++) ...[0x30, 0x80],
      ]);
      expect(() => Asn1.parse(deep), throwsA(isA<Asn1Exception>()));
    });
  });

  group('certificates', () {
    test('Alice: RSA, her address, for signing and encrypting mail', () {
      final c = cert('alice.crt');
      expect(c.displayName, 'Alice Example');
      expect(c.emails, ['alice@example.org']);
      expect(c.algorithm, 'RSA 2048');
      expect(c.issuerName, 'Loupe Test');
      expect(c.issuer.commonName, 'Loupe Test Mail CA');
      expect(c.serialNumber, BigInt.from(100));
      expect((c.notBefore, c.notAfter), (DateTime.utc(2026), DateTime.utc(2036)));
      expect((c.canSign, c.canEncrypt, c.isCa), (true, true, false));
      expect(c.subject.toString(), 'E=alice@example.org, CN=Alice Example, O=Loupe Test');
      expect(c.fingerprint, hasLength(64));
      expect(c.hasEmail(' Alice@Example.ORG '), isTrue);
    });

    test('Bob: EC P-256 with key agreement; Dave signs only; Erin is a TLS certificate', () {
      final b = cert('bob.crt');
      expect((b.algorithm, b.canSign, b.canEncrypt), ('EC P-256', true, true));
      expect(b.emails, ['bob@example.net']);
      final d = cert('dave.crt');
      expect((d.canSign, d.canEncrypt), (true, false));
      final e = cert('erin.crt');
      expect((e.canSign, e.canEncrypt), (false, false));
      expect((testCa.isCa, testCa.pathLength, testRoot.isSelfIssued), (true, 0, true));
    });

    test('PEM (several), DER and a PKCS #7 certs-only bundle', () {
      final pem = utf8.encode('${testRoot.pem}junk between\n${testCa.pem}');
      expect(readCertificates(Uint8List.fromList(pem)), [testRoot, testCa]);
      expect(readCertificates(testCa.der), [testCa]);
      // The certificates of a signed message, as a .p7c file would hold them.
      final signature = MimeEntity.parse(smimeMail('signed-detached.eml')).parts[1].decodedBody;
      expect(
        readCertificates(signature).map((c) => c.displayName),
        unorderedEquals(['Alice Example', 'Loupe Test Mail CA']),
      );
      expect(() => readCertificates(Uint8List.fromList(utf8.encode('nothing'))), throwsA(isA<SmimeException>()));
    });

    test('Mozilla’s email roots all parse', () {
      expect(mozillaRoots.length, greaterThan(50));
      expect(mozillaRoots.every((c) => c.isCa && c.isSelfIssued), isTrue);
    });
  });

  group('PKCS #12', () {
    test('OpenSSL 3 defaults: PBES2, AES-256-CBC, HMAC-SHA256', () {
      final b = smime.readPkcs12(smimeFixture('alice.p12'), 'alice-pass');
      expect(b.keys.single.certificate, cert('alice.crt'));
      expect(b.keys.single.friendlyName, 'Alice Example');
      expect(b.chain, unorderedEquals([testCa, testRoot]));
    });

    test('legacy algorithms as older Windows exports: RC2-40, 3DES, SHA-1 MAC', () {
      final b = smime.readPkcs12(smimeFixture('alice-legacy.p12'), 'alice-pass');
      expect(b.keys.single.certificate, cert('alice.crt'));
      expect(b.certificates, hasLength(3));
    });

    test('an EC key, 3DES throughout; PBMAC1 (RFC 9579); no password', () {
      expect(smime.readPkcs12(smimeFixture('bob-3des.p12'), 'bob-pass').keys.single.certificate, cert('bob.crt'));
      expect(smime.readPkcs12(smimeFixture('bob-pbmac1.p12'), 'bob-pass').keys.single.certificate, cert('bob.crt'));
      expect(smime.readPkcs12(smimeFixture('dave-nopass.p12'), '').keys.single.certificate, cert('dave.crt'));
    });

    test('a wrong password, or not a PKCS #12 file', () {
      for (final f in ['alice.p12', 'alice-legacy.p12', 'bob-pbmac1.p12']) {
        expect(
          () => smime.readPkcs12(smimeFixture(f), 'wrong'),
          throwsA(isA<SmimeException>().having((e) => e.kind, 'kind', SmimeErrorKind.wrongPassword)),
          reason: f,
        );
      }
      expect(
        () => smime.readPkcs12(smimeFixture('alice.crt'), 'x'),
        throwsA(isA<SmimeException>().having((e) => e.kind, 'kind', SmimeErrorKind.malformed)),
      );
    });
  });

  test('PEM: many BEGIN lines without an END are read in linear time (a regex took 43 s for 1 MB)', () {
    for (final line in ['-----BEGIN CERTIFICATE-----\n', '-----BEGIN A-----\n']) {
      final input = Uint8List.fromList(utf8.encode(line * 40000));
      final watch = Stopwatch()..start();
      expect(() => readCertificates(input), throwsA(isA<SmimeException>()));
      expect(watch.elapsed, lessThan(const Duration(seconds: 2)));
    }
    // Blocks of other labels around certificates, in their order.
    final pem = '-----BEGIN PRIVATE KEY-----\nAAAA\n-----END PRIVATE KEY-----\n${testCa.pem}${testRoot.pem}';
    expect(readCertificates(Uint8List.fromList(utf8.encode(pem))), [testCa, testRoot]);
  });
}
