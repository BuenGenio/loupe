import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/der.dart';
import 'package:test/test.dart';

import 'cert_builder.dart';
import 'smime_support.dart';

Asn1 element(int tag, List<int> content) => Asn1.parse(der(tag, content));

/// [cert] with its TBSCertificate's element at [index] replaced by [by].
Uint8List withTbsElement(SmimeCertificate cert, int index, List<int> by) {
  final c = Asn1.parse(cert.der);
  final tbs = c[0];
  return derSequence([
    derSequence([for (final (i, e) in tbs.children.indexed) i == index ? by : e.encoded]),
    c[1].encoded,
    c[2].encoded,
  ]);
}

void main() {
  group('INTEGER', () {
    test('values, negative ones, and the size bound', () {
      expect(element(Tag.integer, [0x01, 0x00]).integer, BigInt.from(256));
      expect(element(Tag.integer, [0xff]).integer, BigInt.from(-1));
      expect(element(Tag.integer, [0x80, 0x00]).integer, BigInt.from(-32768));
      expect(element(Tag.integer, [0x00, ...List.filled(2048, 0xff)]).integer.bitLength, 16384);
      expect(() => element(Tag.integer, List.filled(Asn1.maxIntegerLength + 1, 1)).integer, throwsA(isA<Asn1Exception>()));
      expect(() => element(Tag.integer, const []).integer, throwsA(isA<Asn1Exception>()));
    });

    test('small integers stay small', () {
      expect(element(Tag.integer, [0x7f, 0xff, 0xff, 0xff]).intValue, 0x7fffffff);
      expect(() => element(Tag.integer, [0x01, 0x00, 0x00, 0x00, 0x00]).intValue, throwsA(isA<Asn1Exception>()));
      expect(() => element(Tag.integer, List.filled(9, 0x7f)).intValue, throwsA(isA<Asn1Exception>()));
    });

    test('a certificate with a 300 KB serial number is refused at once (it took ~20 s, quadratic)', () {
      final huge = withTbsElement(testCa, 1, der(Tag.integer, [0x7f, ...List.filled(300000, 0xab)]));
      final watch = Stopwatch()..start();
      expect(() => SmimeCertificate.fromDer(huge), throwsA(isA<SmimeException>()));
      expect(watch.elapsed, lessThan(const Duration(seconds: 1)));
    });

    test('octets to numbers and back', () {
      for (final bytes in [<int>[], [0], [1], [0x80, 0], List.filled(600, 0xee)]) {
        final v = bigIntFromBytes(bytes);
        final back = unsignedBytes(v, bytes.length);
        expect(back, bytes);
      }
      expect(unsignedBytes(BigInt.from(0x1234), 4), [0, 0, 0x12, 0x34]);
      expect(unsignedBytes(BigInt.from(0x123456), 2), [0x12, 0x34, 0x56]);
      expect(unsignedBytes(BigInt.zero), isEmpty);
    });
  });

  group('OBJECT IDENTIFIER: one encoding per OID', () {
    test('arcs, large ones, the first two', () {
      expect(Asn1.parse(derOid('1.2.840.113549.1.7.2')).oid, '1.2.840.113549.1.7.2');
      expect(Asn1.parse(derOid('2.999.4294967296')).oid, '2.999.4294967296');
      expect(element(Tag.oid, [0x2a]).oid, '1.2');
    });

    test('a leading 0x80, a last arc cut short, an arc past 56 bits, empty: damage', () {
      final sha256 = derOid('2.16.840.1.101.3.4.2.1').sublist(2);
      for (final bad in [
        [0x80, ...sha256],
        [sha256[0], 0x80, ...sha256.sublist(1)],
        [...sha256, 0x81],
        [0x60, for (var i = 0; i < 9; i++) 0xff, 0x7f],
        <int>[],
        List.filled(65, 0x01),
      ]) {
        expect(() => element(Tag.oid, bad).oid, throwsA(isA<Asn1Exception>()), reason: '$bad');
      }
    });
  });

  group('times', () {
    Asn1 utc(String s) => element(Tag.utcTime, ascii.encode(s));
    Asn1 gen(String s) => element(Tag.generalizedTime, ascii.encode(s));

    test('UTCTime: 1950–2049, seconds optional, zones', () {
      expect(utc('491231235959Z').time, DateTime.utc(2049, 12, 31, 23, 59, 59));
      expect(utc('500101000000Z').time, DateTime.utc(1950));
      expect(utc('2601011200Z').time, DateTime.utc(2026, 1, 1, 12));
      expect(utc('260101120000+0130').time, DateTime.utc(2026, 1, 1, 10, 30));
      expect(utc('260101120000-0800').time, DateTime.utc(2026, 1, 1, 20));
    });

    test('GeneralizedTime: fractions, leap seconds and leap days', () {
      expect(gen('20500101000000Z').time, DateTime.utc(2050));
      expect(gen('20261004120000.123Z').time, DateTime.utc(2026, 10, 4, 12));
      expect(gen('20161231235960Z').time, DateTime.utc(2016, 12, 31, 23, 59, 59));
      expect(gen('20240229000000Z').time, DateTime.utc(2024, 2, 29));
    });

    test('out of range, without a zone, the other type’s format, spaces: damage', () {
      for (final bad in [
        utc('261301000000Z'), // month 13 (rolled over into 2027 before)
        utc('260230000000Z'),
        utc('260101240000Z'),
        utc('260101126000Z'),
        utc('260101120000'), // local time
        utc('20260101120000Z'), // a GeneralizedTime in a UTCTime
        utc(' 260101120000Z'),
        utc('260101120000+2400'),
        gen('20230229000000Z'),
        gen('260101120000Z'),
        gen('20260101120000'),
        gen('202601011200Z'),
        element(Tag.octetString, ascii.encode('20260101120000Z')),
      ]) {
        expect(() => bad.time, throwsA(isA<Asn1Exception>()), reason: utf8.decode(bad.content, allowMalformed: true));
      }
    });
  });

  group('strings and booleans', () {
    test('BMPString and UniversalString, and their damage (a code point past Unicode threw an ArgumentError)', () {
      expect(element(Tag.bmpString, [0, 0x41, 0x00, 0xe9]).string, 'Aé');
      expect(element(Tag.universalString, [0, 1, 0xf6, 0x00]).string, '😀');
      for (final bad in [
        element(Tag.bmpString, [0, 0x41, 0]),
        element(Tag.universalString, [0, 0, 0, 0x41, 0]),
        element(Tag.universalString, [0x7f, 0xff, 0xff, 0xff]),
        element(Tag.universalString, [0, 0, 0xd8, 0]),
      ]) {
        expect(() => bad.string, throwsA(isA<Asn1Exception>()));
      }
      expect(element(Tag.utf8String, [0x41, 0xff]).string, 'A�');
    });

    test('a BOOLEAN is one octet', () {
      expect(element(Tag.boolean, [0xff]).boolean, isTrue);
      expect(element(Tag.boolean, [0]).boolean, isFalse);
      expect(() => element(Tag.boolean, []).boolean, throwsA(isA<Asn1Exception>()));
      expect(() => element(Tag.boolean, [0, 1]).boolean, throwsA(isA<Asn1Exception>()));
    });

    test('names are shown without control, bidi or zero-width characters; addresses must be printable', () {
      final key = TestKey('names');
      final cert = makeCertificate(
        key: key,
        subject: derSequence([
          derSet([derSequence([derOid('2.5.4.3'), derUtf8('Alice\u202e\u200b Example\n · trusted')])]),
          derSet([derSequence([derOid('1.2.840.113549.1.9.1'), derIa5('bob@example.org\u0000.evil')])]),
        ]),
        issuer: name('Names CA'),
        issuerKey: key,
        extensions: [subjectAltEmails(['alice@example.org', 'carol@exa mple.org'])],
      );
      expect(cert.displayName, 'Alice Example · trusted');
      expect(cert.subject.toString(), isNot(contains('\u202e')));
      expect(cert.emails, ['alice@example.org']);
      expect(shownText('x' * 300).length, 100);
    });
  });
}
