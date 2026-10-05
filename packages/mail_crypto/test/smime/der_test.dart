import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/der.dart';
import 'package:test/test.dart';

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
}
