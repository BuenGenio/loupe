import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/der.dart';
import 'package:mail_crypto/src/smime/oids.dart';
import 'package:mail_crypto/src/smime/pkcs12.dart' show maxPkcs12Iterations;
import 'package:test/test.dart';

import 'smime_support.dart';

/// alice.p12 with its MAC's iteration count replaced.
Uint8List withMacIterations(int n) {
  final pfx = Asn1.parse(smimeFixture('alice.p12'));
  final mac = pfx[2];
  return derSequence([pfx[0].encoded, pfx[1].encoded, derSequence([mac[0].encoded, mac[1].encoded, derInt(n)])]);
}

/// A PFX without a MAC holding one shrouded key bag (PBES2, AES-256-CBC)
/// whose PBKDF2 parameters are [kdfParams].
Uint8List shroudedKeyWith(Uint8List kdfParams) {
  final pbes2 = derAlgorithm(
    Oid.pbes2,
    derSequence([
      derAlgorithm(Oid.pbkdf2, kdfParams),
      derAlgorithm(Oid.aes256Cbc, derOctets(Uint8List(16))),
    ]),
  );
  final bag = derSequence([
    derOid(Oid.pkcs8ShroudedKeyBag),
    derContext(0, derSequence([pbes2, derOctets(Uint8List(48))])),
  ]);
  final safe = derSequence([derOid(Oid.data), derContext(0, derOctets(derSequence([bag])))]);
  return derSequence([
    derInt(3),
    derSequence([derOid(Oid.data), derContext(0, derOctets(derSequence([safe])))]),
  ]);
}

Matcher throwsKind(SmimeErrorKind kind) => throwsA(isA<SmimeException>().having((e) => e.kind, 'kind', kind));

void main() {
  test('a MAC asking for billions of iterations is refused at once (it hung before the password was checked)', () {
    final watch = Stopwatch()..start();
    expect(() => smime.readPkcs12(withMacIterations(0x7fffffff), 'alice-pass'), throwsKind(SmimeErrorKind.unsupported));
    expect(() => smime.readPkcs12(withMacIterations(maxPkcs12Iterations + 1), 'x'), throwsKind(SmimeErrorKind.unsupported));
    expect(() => smime.readPkcs12(withMacIterations(0), 'alice-pass'), throwsKind(SmimeErrorKind.malformed));
    expect(watch.elapsed, lessThan(const Duration(seconds: 1)));
    // The file's own count still opens it.
    expect(smime.readPkcs12(withMacIterations(2048), 'alice-pass').keys, hasLength(1));
  });

  test('a file whose MAC was taken away is refused, unless its password is empty', () {
    Uint8List withoutMac(String file) {
      final pfx = Asn1.parse(smimeFixture(file));
      return derSequence([pfx[0].encoded, pfx[1].encoded]);
    }

    expect(() => smime.readPkcs12(withoutMac('alice.p12'), 'alice-pass'), throwsKind(SmimeErrorKind.unsupported));
    expect(smime.readPkcs12(withoutMac('dave-nopass.p12'), '').keys, hasLength(1));
  });

  test('PBKDF2: a key length other than the cipher’s, or a huge one, is refused (it allocated it)', () {
    final salt = derOctets(Uint8List(8));
    final iterations = derInt(2048);
    for (final params in [
      derSequence([salt, iterations, derInt(1 << 30)]),
      derSequence([salt, iterations, derInt(16)]),
      derSequence([salt, derInt(0x7fffffff)]),
    ]) {
      final watch = Stopwatch()..start();
      expect(() => smime.readPkcs12(shroudedKeyWith(params), ''), throwsA(isA<SmimeException>()));
      expect(watch.elapsed, lessThan(const Duration(seconds: 1)));
    }
  });
}
