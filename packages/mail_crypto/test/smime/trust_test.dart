import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/oids.dart';
import 'package:test/test.dart';

import 'cert_builder.dart';
import 'smime_support.dart';

SmimeTrustCheck check(
  SmimeCertificate c, {
  SmimeTrustAnchors? anchors,
  List<SmimeCertificate> intermediates = const [],
  DateTime? at,
  SmimeUsage usage = SmimeUsage.signing,
  String? email,
}) => checkTrust(
  c,
  anchors: anchors ?? testAnchors,
  intermediates: intermediates,
  at: at ?? today,
  usage: usage,
  email: email,
  signedBy: smime.certificateSignedBy,
);

void main() {
  final aliceCert = cert('alice.crt');
  final bobCert = cert('bob.crt');

  test('trusted: through the intermediate to the test root', () {
    final c = check(aliceCert, intermediates: [testCa], email: 'alice@example.org');
    expect(c.trusted, isTrue);
    expect(c.chain, [aliceCert, testCa, testRoot]);
    expect(c.anchor, testRoot);
    expect(c.issuerName, 'Loupe Test');
    expect(check(bobCert, intermediates: [testCa], usage: SmimeUsage.encryption).trusted, isTrue);
  });

  test('untrusted: no intermediate, an unknown root, or Mozilla’s roots only', () {
    expect(check(aliceCert).problems, {SmimeProblem.untrusted});
    final mallory = check(cert('mallory.crt'), intermediates: [evilRoot], email: 'alice@example.org');
    expect(mallory.problems, {SmimeProblem.untrusted});
    expect(mallory.chain.map((c) => c.displayName), ['Mallory', 'Evil Root CA']);
    final mozilla = check(aliceCert, anchors: SmimeTrustAnchors.withMozilla(), intermediates: [testCa]);
    expect(mozilla.problem, SmimeProblem.untrusted);
  });

  test('a certificate the user trusts is an anchor of its own', () {
    final c = check(cert('mallory.crt'), anchors: SmimeTrustAnchors([cert('mallory.crt')]));
    expect(c.trusted, isTrue);
    expect(c.chain, hasLength(1));
  });

  test('expired: Carol’s certificate now, but not in 2020 when it was valid', () {
    final carol = cert('carol.crt');
    expect(check(carol, intermediates: [testCa]).problems, {SmimeProblem.expired});
    expect(check(carol, intermediates: [testCa], at: DateTime.utc(2020, 6)).trusted, isTrue);
    expect(check(aliceCert, intermediates: [testCa], at: DateTime.utc(2025, 6)).problems, {SmimeProblem.notYetValid});
  });

  test('wrong address', () {
    final c = check(aliceCert, intermediates: [testCa], email: 'ceo@example.org');
    expect(c.problems, {SmimeProblem.wrongAddress});
  });

  test('key usage: Dave can’t be encrypted to; Erin’s TLS certificate can’t sign mail', () {
    expect(check(cert('dave.crt'), intermediates: [testCa]).trusted, isTrue);
    expect(check(cert('dave.crt'), intermediates: [testCa], usage: SmimeUsage.encryption).problems, {
      SmimeProblem.wrongUsage,
    });
    expect(check(cert('erin.crt'), intermediates: [testCa]).problems, {SmimeProblem.wrongUsage});
  });

  test('invalid chains: issued by a certificate that isn’t a CA; outside a CA’s name constraints', () {
    final frank = check(cert('frank.crt'), intermediates: [testCa, aliceCert]);
    expect(frank.problems, {SmimeProblem.invalidChain});
    expect(frank.chain, [cert('frank.crt'), aliceCert, testCa, testRoot]);

    final constrained = cert('constrained.crt');
    expect(check(cert('hank.crt'), intermediates: [constrained], email: 'hank@example.org').trusted, isTrue);
    expect(check(cert('gina.crt'), intermediates: [constrained]).problems, {SmimeProblem.invalidChain});
  });

  test('a forged signature in the chain: no path', () {
    // Bob's certificate checked against the root directly: the root didn't sign it.
    expect(smime.certificateSignedBy(bobCert, testRoot), isFalse);
    expect(smime.certificateSignedBy(bobCert, testCa), isTrue);
    expect(check(bobCert, intermediates: [evilRoot]).problems, {SmimeProblem.untrusted});
  });

  test('a web of cross-signed CAs of one name: the path search stops after a bounded number of checks', () {
    // Twelve CAs all called "Loop CA" (each could have signed each other):
    // without a bound, searching every path up to eight deep is 12^8 checks.
    final loopKey = TestKey('loop');
    final cas = [for (var i = 0; i < 12; i++) makeCa('Loop CA', loopKey, serial: 1000 + i, extensions: [basicConstraints()])];
    final leaf = makeUser('alice@example.org', TestKey('leaf'), issuerCn: 'Loop CA', issuerKey: loopKey);
    var checks = 0;
    final watch = Stopwatch()..start();
    final c = checkTrust(
      leaf,
      anchors: testAnchors,
      intermediates: cas,
      at: today,
      usage: SmimeUsage.signing,
      signedBy: (cert, issuer) {
        checks++;
        return true;
      },
    );
    expect(c.problems, contains(SmimeProblem.untrusted));
    expect(checks, lessThanOrEqualTo(maxPathChecks));
    expect(watch.elapsed, lessThan(const Duration(seconds: 2)));
  }, timeout: const Timeout(Duration(seconds: 30)));

  group('issuers', () {
    final rootKey = TestKey('issuers-root');
    final root = makeCa('Issuers Root', rootKey);
    final anchors = SmimeTrustAnchors([root]);
    final caKey = TestKey('issuers-ca');
    final userKey = TestKey('issuers-user');
    SmimeTrustCheck through(SmimeCertificate ca, {SmimeTrustAnchors? over}) => checkTrust(
      makeUser('alice@example.org', userKey, issuerCn: 'Sub CA', issuerKey: caKey),
      anchors: over ?? anchors,
      intermediates: [ca],
      at: today,
      usage: SmimeUsage.signing,
      email: 'alice@example.org',
      signedBy: smime.certificateSignedBy,
    );
    SmimeCertificate subCa({int version = 3, List<Uint8List>? extensions}) => makeCa(
      'Sub CA',
      caKey,
      issuerKey: rootKey,
      issuer: name('Issuers Root'),
      serial: 2,
      version: version,
      extensions: extensions,
    );
    final caExtensions = [basicConstraints(), keyUsage(KeyUsage.keyCertSign)];

    test('an intermediate for mail, or for any purpose, vouches for a mail certificate', () {
      expect(through(subCa(extensions: caExtensions)).trusted, isTrue);
      for (final eku in [Oid.emailProtection, Oid.anyExtendedKeyUsage]) {
        expect(through(subCa(extensions: [...caExtensions, extendedKeyUsage([eku])])).trusted, isTrue);
      }
    });

    test('an intermediate limited to TLS doesn’t', () {
      final tls = subCa(extensions: [...caExtensions, extendedKeyUsage(['1.3.6.1.5.5.7.3.1'])]);
      expect(through(tls).problems, {SmimeProblem.invalidChain});
    });

    test('a v1 certificate is a CA only as a trust anchor', () {
      expect(through(subCa(version: 1)).problems, {SmimeProblem.invalidChain});
      final v1Root = makeCa('Sub CA', caKey, version: 1);
      expect(through(v1Root, over: SmimeTrustAnchors([v1Root])).trusted, isTrue);
    });
  });
}
