import 'package:mail_crypto/mail_crypto.dart';
import 'package:test/test.dart';

import 'smime_support.dart';

SmimeSignatureStatus signatureOf(String name, {String? sender}) =>
    const SmimeReader(smime).read(smimeMail(name), anchors: testAnchors, now: today, sender: sender).status.signature!;

/// A keychain whose reads fail until [broken] is cleared (Android's Keystore hiccups).
final class FlakyStorage implements KeyringStorage {
  final values = <String, String>{};
  bool broken = true;

  @override
  Future<String?> read(String key) async {
    if (broken) throw StateError('Keystore unavailable');
    return values[key];
  }

  @override
  Future<void> write(String key, String value) async => values[key] = value;

  @override
  Future<void> delete(String key) async => values.remove(key);
}

void main() {
  late MemoryKeyringStorage storage;
  late SmimeStore store;

  setUp(() async {
    storage = MemoryKeyringStorage();
    store = SmimeStore(storage, prefix: 'test.smime');
    await store.load();
  });

  test('own certificates: the private key in an entry of its own, everything back after a restart', () async {
    await store.addOwn(alice, chain: aliceBundle.chain, now: today);
    final fp = alice.certificate.fingerprint;
    expect(storage.values.keys, containsAll(['test.smime.store', 'test.smime.key.$fp']));
    expect(storage.values['test.smime.store'], isNot(contains('PRIVATE')));
    await store.setIdentity('Alice@Example.org', const IdentitySmime(preferSmime: true));

    final again = SmimeStore(storage, prefix: 'test.smime');
    final state = await again.load();
    expect(state.own.single.certificate, alice.certificate);
    expect(state.own.single.chain, unorderedEquals(aliceBundle.chain));
    expect(state.identity('alice@example.org').preferSmime, isTrue);
    expect(state.ownCertificateFor('alice@example.org', now: today)?.certificate, alice.certificate);
    expect((await again.privateKey(fp))?.pkcs8, alice.key.pkcs8);
    expect((await again.keyPairs()).single.certificate, alice.certificate);

    await again.setIdentity('alice@example.org', IdentitySmime(certificateFingerprint: fp, preferSmime: true));
    await again.removeOwn(fp);
    expect(storage.values.keys, isNot(contains('test.smime.key.$fp')));
    expect(again.state.identity('alice@example.org').certificateFingerprint, isNull);
    expect(again.state.identity('alice@example.org').preferSmime, isTrue);
  });

  test('collects the certificate of a good signature, with its chain and capabilities', () async {
    expect(await store.collect(signatureOf('signed-detached.eml'), sender: 'alice@example.org', now: today), isTrue);
    final c = store.state.contacts.single;
    expect(c.certificate.displayName, 'Alice Example');
    expect(c.chain, [testCa]);
    expect(c.source, SmimeCertificateSource.collected);
    expect(c.capabilities, isNotEmpty);
    expect(c.lastSigned, isNotNull);
    // The same message again changes nothing.
    expect(await store.collect(signatureOf('signed-detached.eml'), sender: 'alice@example.org', now: today), isFalse);
  });

  test('keeps the issuers on the path, not every certificate the message carried', () async {
    final good = signatureOf('signed-detached.eml');
    final stuffed = SmimeSignatureStatus(
      valid: true,
      certificate: good.certificate,
      trust: good.trust,
      certificates: [...good.certificates, for (var i = 0; i < 200; i++) testRoot, evilRoot],
    );
    expect(await store.collect(stuffed, sender: 'alice@example.org', now: today), isTrue);
    expect(store.state.contacts.single.chain, [testCa]);
  });

  test('doesn’t collect from a modified message, another sender, an expired certificate', () async {
    expect(await store.collect(signatureOf('signed-modified.eml'), sender: 'alice@example.org', now: today), isFalse);
    expect(await store.collect(signatureOf('signed-detached.eml'), sender: 'ceo@example.org', now: today), isFalse);
    expect(await store.collect(signatureOf('signed-expired.eml'), sender: 'carol@example.org', now: today), isFalse);
    expect(store.state.contacts, isEmpty);
  });

  test('an own certificate is never a correspondent’s; imported stays imported', () async {
    await store.addOwn(alice);
    expect(await store.addContact(alice.certificate), isFalse);
    expect(await store.addContact(bob.certificate, source: SmimeCertificateSource.imported), isTrue);
    expect(await store.collect(signatureOf('signed-opaque.eml'), sender: 'bob@example.net', now: today), isTrue);
    expect(store.state.contact(bob.certificate.fingerprint)?.source, SmimeCertificateSource.imported);
    await store.removeContact(bob.certificate.fingerprint);
    expect(store.state.contacts, isEmpty);
  });

  test('trusted authorities join Mozilla’s roots', () async {
    await store.trust(testRoot);
    await store.trust(testRoot);
    expect(store.state.authorities, [testRoot]);
    expect(store.state.anchors.isAnchor(testRoot), isTrue);
    expect(store.state.anchors.anchors.length, mozillaRoots.length + 1);
    await store.untrust(testRoot.fingerprint);
    expect(store.state.anchors.isAnchor(testRoot), isFalse);
  });

  test('a damaged entry starts empty; clear forgets the keys', () async {
    await store.addOwn(alice);
    storage.values['test.smime.store'] = '{not json';
    expect((await SmimeStore(storage, prefix: 'test.smime').load()).own, isEmpty);
    await store.clear();
    expect(storage.values, isEmpty);
  });

  test('a keychain that can’t be read is never overwritten (collected certificates write by themselves)', () async {
    final flaky = FlakyStorage();
    flaky.values['test.smime.store'] = '{"version":1,"own":[],"authorities":[]}';
    final s = SmimeStore(flaky, prefix: 'test.smime');
    await expectLater(s.load(), throwsStateError);
    expect(s.isUnreadable, isTrue);
    await expectLater(
      s.collect(signatureOf('signed-detached.eml'), sender: 'alice@example.org', now: today),
      throwsA(isA<SmimeException>()),
    );
    expect(flaky.values['test.smime.store'], '{"version":1,"own":[],"authorities":[]}');
    flaky.broken = false;
    await s.load();
    expect(await s.collect(signatureOf('signed-detached.eml'), sender: 'alice@example.org', now: today), isTrue);
  });
}
