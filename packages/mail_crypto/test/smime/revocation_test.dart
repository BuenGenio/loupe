import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/der.dart';
import 'package:mail_crypto/src/smime/oids.dart';
import 'package:test/test.dart';

import 'cert_builder.dart';
import 'smime_support.dart';

/// The revocation vectors (make_revocation_vectors.sh): made on 2026-10-07,
/// valid for ten years.
Uint8List revocationFixture(String name) => File('test/fixtures/smime/revocation/$name').readAsBytesSync();

SmimeCertificate revocationCert(String name) => readCertificates(revocationFixture(name)).single;

final revocationCa = revocationCert('ca.crt');
final gail = revocationCert('gail.crt');
final rex = revocationCert('rex.crt');
final cleo = revocationCert('cleo.crt');
final nell = revocationCert('nell.crt');

/// When the tests read the vectors: after they were made, before they expire.
final revocationNow = DateTime.utc(2027, 1, 1);

final class FakeFetcher implements SmimeRevocationFetcher {
  FakeFetcher(this.answers);

  /// Bodies by URL; a missing one fails like a network error.
  final Map<String, Uint8List> answers;
  final asked = <String>[];
  Completer<void>? hold;

  @override
  Future<Uint8List> postOcsp(Uri url, Uint8List request, {required int maxBytes}) => _answer('POST $url');

  @override
  Future<Uint8List> getCrl(Uri url, {required int maxBytes}) => _answer('GET $url');

  Future<Uint8List> _answer(String what) async {
    asked.add(what);
    await hold?.future;
    return answers[what] ?? (throw const SocketException('unreachable'));
  }
}

const ocspUrl = 'POST http://ocsp.revocation.test/';
const crlUrl = 'GET http://crl.revocation.test/ca.crl';

void main() {
  group('certificates say where to ask', () {
    test('OCSP and CRL locations, http(s) only', () {
      expect(gail.ocspUrls, ['http://ocsp.revocation.test/']);
      expect(gail.crlUrls, ['http://crl.revocation.test/ca.crl']);
      expect(cleo.ocspUrls, isEmpty);
      expect(cleo.crlUrls, ['http://crl.revocation.test/ca.crl']);
      expect(alice.certificate.ocspUrls, isEmpty);
    });
  });

  group('OCSP', () {
    SmimeRevocationStatus read(String file, SmimeCertificate cert, {DateTime? now}) =>
        readOcspResponse(revocationFixture(file), cert: cert, issuer: revocationCa, now: now ?? revocationNow);

    test('the request is the one OpenSSL makes', () {
      expect(ocspRequest(gail, revocationCa), revocationFixture('ocsp-request-gail.der'));
    });

    test('good, signed by the CA itself; reused until its nextUpdate', () {
      final s = read('ocsp-good.der', gail);
      expect(s.state, SmimeRevocationState.good);
      expect(s.source, SmimeRevocationSource.ocsp);
      expect(s.validUntil.year, 2036);
    });

    test('revoked, signed by a responder the CA authorised', () {
      final s = read('ocsp-revoked.der', rex);
      expect(s.state, SmimeRevocationState.revoked);
      expect(s.reason, 'key compromise');
      expect(s.revokedAt, isNotNull);
      expect(s.revokedAt!.isBefore(revocationNow), isTrue);
    });

    test('unknown to the authority', () {
      final s = read('ocsp-unknown.der', nell);
      expect(s.state, SmimeRevocationState.unknown);
      expect(s.problem, contains('doesn’t know'));
    });

    test('a "good" from a certificate the CA didn’t make a responder is refused', () {
      expect(() => read('ocsp-forged.der', rex), throwsA(isA<SmimeException>()));
    });

    test('an answer about another certificate is refused', () {
      expect(() => read('ocsp-good.der', rex), throwsA(isA<SmimeException>()));
      expect(
        () => readOcspResponse(revocationFixture('ocsp-good.der'), cert: gail, issuer: testCa, now: revocationNow),
        throwsA(isA<SmimeException>()),
      );
    });

    test('from the future, or out of date', () {
      expect(() => read('ocsp-good.der', gail, now: DateTime.utc(2026, 1, 1)), throwsA(isA<SmimeException>()));
      expect(() => read('ocsp-good.der', gail, now: DateTime.utc(2037, 1, 1)), throwsA(isA<SmimeException>()));
    });

    test('a changed byte breaks the signature', () {
      final der = Uint8List.fromList(revocationFixture('ocsp-good.der'));
      // In the producedAt time: still a valid time, no longer what was signed.
      final at = hex(der).indexOf('180F32303236') ~/ 2 + 2;
      expect(at, greaterThan(2));
      der[at + 13] ^= 0x01;
      expect(
        () => readOcspResponse(der, cert: gail, issuer: revocationCa, now: revocationNow),
        throwsA(isA<SmimeException>().having((e) => e.message, 'message', contains('signature'))),
      );
    });

    test('a responder that couldn’t answer: unknown, asked again a little later', () {
      final s = readOcspResponse(
        der(Tag.sequence, der(0x0a, [3])),
        cert: gail,
        issuer: revocationCa,
        now: revocationNow,
      );
      expect(s.state, SmimeRevocationState.unknown);
      expect(s.problem, contains('busy'));
      expect(s.validUntil.difference(revocationNow), const Duration(minutes: 10));
    });
  });

  group('CRL', () {
    SmimeRevocationStatus read(SmimeCertificate cert, {Uint8List? crl, DateTime? now, SmimeCertificate? issuer}) =>
        readCrl(
          crl ?? revocationFixture('ca.crl'),
          cert: cert,
          issuer: issuer ?? revocationCa,
          now: now ?? revocationNow,
        );

    test('listed: revoked with the reason; not listed: good', () {
      final r = read(rex);
      expect(
        (r.state, r.reason, r.source),
        (SmimeRevocationState.revoked, 'key compromise', SmimeRevocationSource.crl),
      );
      expect(read(cleo).reason, 'superseded');
      expect(read(gail).state, SmimeRevocationState.good);
      expect(read(gail).validUntil.year, 2036);
    });

    test('another authority’s list, a changed one, an old one: refused', () {
      expect(() => read(alice.certificate, issuer: testCa), throwsA(isA<SmimeException>()));
      final changed = Uint8List.fromList(revocationFixture('ca.crl'));
      changed[changed.length - 300] ^= 0x01;
      expect(() => read(gail, crl: changed), throwsA(isA<SmimeException>()));
      expect(() => read(gail, now: DateTime.utc(2037)), throwsA(isA<SmimeException>()));
    });

    group('made here', () {
      final caKey = TestKey('revocation-ca');
      final ca = makeCa('Made Here CA', caKey);
      final user = makeUser(
        'user@example.org',
        TestKey('revocation-user'),
        issuerCn: 'Made Here CA',
        issuerKey: caKey,
        serial: 77,
      );

      Uint8List crl({List<int> revokedSerials = const [], List<Uint8List> extensions = const []}) {
        final alg = derAlgorithm(Oid.ecdsaWithSha256);
        final tbs = derSequence([
          derInt(1),
          alg,
          name('Made Here CA'),
          derTime(DateTime.utc(2026, 12, 1)),
          derTime(DateTime.utc(2027, 2, 1)),
          if (revokedSerials.isNotEmpty)
            derSequence([
              for (final s in revokedSerials) derSequence([derInt(s), derTime(DateTime.utc(2026, 11, 1))]),
            ]),
          if (extensions.isNotEmpty) derContext(0, derSequence(extensions)),
        ]);
        return derSequence([tbs, alg, derBitString(caKey.sign(tbs))]);
      }

      SmimeRevocationStatus check(Uint8List list) => readCrl(list, cert: user, issuer: ca, now: revocationNow);

      test('a complete list', () {
        expect(check(crl(revokedSerials: [76, 77])).state, SmimeRevocationState.revoked);
        expect(check(crl(revokedSerials: [78])).state, SmimeRevocationState.good);
        expect(check(crl()).state, SmimeRevocationState.good);
      });

      test('a delta list, or one only about CA certificates, isn’t the answer', () {
        expect(
          () => check(crl(extensions: [extension(Oid.deltaCrlIndicator, derInt(5), critical: true)])),
          throwsA(isA<SmimeException>()),
        );
        expect(
          () => check(
            crl(
              extensions: [
                extension(
                  Oid.issuingDistributionPoint,
                  derSequence([
                    derContext(2, [0xff], constructed: false),
                  ]),
                  critical: true,
                ),
              ],
            ),
          ),
          throwsA(isA<SmimeException>()),
        );
        expect(
          check(
            crl(
              revokedSerials: [77],
              extensions: [
                extension(
                  Oid.issuingDistributionPoint,
                  derSequence([
                    derContext(1, [0xff], constructed: false),
                  ]),
                  critical: true,
                ),
              ],
            ),
          ).state,
          SmimeRevocationState.revoked,
          reason: 'only users’ certificates: a signer’s is one',
        );
      });

      test('an unknown critical extension makes it unusable', () {
        expect(
          () => check(crl(extensions: [extension('1.2.3.4', derNull, critical: true)])),
          throwsA(isA<SmimeException>()),
        );
      });
    });
  });

  group('the checker', () {
    SmimeRevocationChecker checker(FakeFetcher fetcher, {Duration timeout = const Duration(seconds: 15)}) =>
        SmimeRevocationChecker(fetcher: fetcher, clock: () => revocationNow, timeout: timeout);

    test('asks the OCSP responder once; the answer is reused', () async {
      final fetcher = FakeFetcher({ocspUrl: revocationFixture('ocsp-good.der')});
      final c = checker(fetcher);
      final results = await Future.wait([c.check(gail, revocationCa), c.check(gail, revocationCa)]);
      expect(results.map((s) => s.state), everyElement(SmimeRevocationState.good));
      expect(await c.check(gail, revocationCa), same(results.first));
      expect(fetcher.asked, [ocspUrl]);
    });

    test('the CRL when there is no OCSP responder', () async {
      final fetcher = FakeFetcher({crlUrl: revocationFixture('ca.crl')});
      final s = await checker(fetcher).check(cleo, revocationCa);
      expect((s.state, s.source), (SmimeRevocationState.revoked, SmimeRevocationSource.crl));
      expect(fetcher.asked, [crlUrl]);
    });

    test('no answer: unknown with the reason, never an error', () async {
      final unreachable = await checker(FakeFetcher({})).check(gail, revocationCa);
      expect(unreachable.state, SmimeRevocationState.unknown);
      expect(unreachable.problem, isNotNull);

      final bad = await checker(FakeFetcher({ocspUrl: revocationFixture('ocsp-forged.der')})).check(rex, revocationCa);
      expect(bad.state, SmimeRevocationState.unknown);
      expect(bad.problem, contains('authorise'));

      final none = await checker(FakeFetcher({})).check(alice.certificate, testCa);
      expect(none.problem, contains('no way to check'));
    });

    test('strict timeouts', () async {
      final fetcher = FakeFetcher({ocspUrl: revocationFixture('ocsp-good.der')})..hold = Completer<void>();
      final s = await checker(fetcher, timeout: const Duration(milliseconds: 50)).check(gail, revocationCa);
      expect(s.state, SmimeRevocationState.unknown);
      expect(s.problem, contains('in time'));
    });

    test('the cache keeps answers until they expire, across restarts', () {
      final cache = SmimeRevocationCache()
        ..put(
          'a',
          SmimeRevocationStatus(
            state: SmimeRevocationState.revoked,
            checkedAt: revocationNow,
            validUntil: revocationNow.add(const Duration(days: 1)),
            source: SmimeRevocationSource.ocsp,
            reason: 'key compromise',
          ),
        )
        ..put(
          'b',
          SmimeRevocationStatus(
            state: SmimeRevocationState.good,
            checkedAt: revocationNow,
            validUntil: revocationNow.add(const Duration(hours: 1)),
          ),
        );
      final again = SmimeRevocationCache.decode(cache.encode(revocationNow));
      expect(again.lookup('a', revocationNow)?.reason, 'key compromise');
      expect(again.lookup('b', revocationNow.add(const Duration(hours: 2))), isNull);
      expect(SmimeRevocationCache.decode('{damaged').length, 0);
    });
  });
}
