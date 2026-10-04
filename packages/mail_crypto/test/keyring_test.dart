import 'dart:convert';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:test/test.dart';

import 'support.dart';

void main() {
  group('Autocrypt header', () {
    test('parses Thunderbird’s header and rejects broken ones', () {
      final raw = MimeEntity.parse(tbMail('unsigned-unencrypted-0x3099ff1238852b9f-autocrypt.eml'));
      final h = autocryptHeaderFrom(raw.headers, 'carol@example.com')!;
      expect(h.addr, 'carol@example.com');
      expect(h.preferMutual, isFalse);
      expect(pgp.readKeys(h.keydata).single.fingerprint, carolPublic.fingerprint);
      expect(autocryptHeaderFrom(raw.headers, 'mallory@example.com'), isNull, reason: 'addr must match From');
      expect(AutocryptHeader.parse('addr=a@b.c'), isNull);
      expect(AutocryptHeader.parse('addr=a@b.c; keydata=AAAA; critical=1'), isNull);
      expect(AutocryptHeader.parse('addr=a@b.c; _extra=1; keydata=AAAA')!.keydata, [0, 0, 0]);
      expect(
        autocryptHeaderFrom([
          ('Autocrypt', 'addr=a@b.c; keydata=AAAA'),
          ('Autocrypt', 'addr=a@b.c; keydata=AAAA'),
        ], 'a@b.c'),
        isNull,
      );
    });

    test('builds a folded header that parses back', () {
      final minimal = pgp.minimalKey(alicePublic, 'alice@openpgp.example');
      final h = AutocryptHeader(addr: 'alice@openpgp.example', keydata: minimal.data, preferMutual: true);
      final value = h.toValue();
      expect(value, startsWith('addr=alice@openpgp.example; prefer-encrypt=mutual; keydata=\r\n '));
      expect(value.split('\r\n').every((l) => l.length <= 78), isTrue);
      final back = AutocryptHeader.parse(value.replaceAll('\r\n', ''))!;
      expect(back.preferMutual, isTrue);
      expect(back.keydata, minimal.data);
    });
  });

  group('Autocrypt peer state and recommendation', () {
    final d1 = DateTime.utc(2026, 1, 1);
    final d2 = DateTime.utc(2026, 3, 1);

    test('newer headers replace older ones; older mail changes nothing', () {
      var p = updatePeer(null, 'bob@x.org', d1, fingerprint: 'AAA', preferMutual: true);
      expect((p.fingerprint, p.timestamp, p.preferMutual), ('AAA', d1, true));
      p = updatePeer(p, 'bob@x.org', d2);
      expect((p.fingerprint, p.lastSeen, p.timestamp), ('AAA', d2, d1));
      expect(p.isStale, isTrue, reason: 'two months without a header');
      expect(updatePeer(p, 'bob@x.org', d1, fingerprint: 'OLD'), same(p));
      p = updatePeer(p, 'bob@x.org', d2.add(const Duration(days: 1)), fingerprint: 'BBB');
      expect((p.fingerprint, p.isStale, p.preferMutual), ('BBB', false, false));
      final g = updateGossip(null, 'carol@x.org', d1, 'GGG');
      expect(g.bestFingerprint, 'GGG');
      expect(updateGossip(g, 'carol@x.org', d1, 'HHH').gossipFingerprint, 'GGG');
    });

    test('recommendations follow Level 1', () {
      final fresh = AutocryptPeer(addr: 'a@x', lastSeen: d1, timestamp: d1, fingerprint: 'F', preferMutual: true);
      expect(recommendFor(null, ownMutual: true), AutocryptRecommendation.disable);
      expect(recommendFor(fresh, ownMutual: true), AutocryptRecommendation.encrypt);
      expect(recommendFor(fresh, ownMutual: false), AutocryptRecommendation.available);
      final stale = AutocryptPeer(addr: 'a@x', lastSeen: d2, timestamp: d1, fingerprint: 'F', preferMutual: true);
      expect(recommendFor(stale, ownMutual: true), AutocryptRecommendation.discourage);
      expect(recommendFor(stale, ownMutual: false, replyToEncrypted: true), AutocryptRecommendation.encrypt);
      expect(
        combineRecommendations([AutocryptRecommendation.encrypt, AutocryptRecommendation.available]),
        AutocryptRecommendation.available,
      );
      expect(
        combineRecommendations([AutocryptRecommendation.encrypt, AutocryptRecommendation.disable]),
        AutocryptRecommendation.disable,
      );
    });
  });

  group('Keyring', () {
    late MemoryKeyringStorage storage;
    late Keyring keyring;

    setUp(() async {
      storage = MemoryKeyringStorage();
      keyring = Keyring(storage);
      await keyring.load();
    });

    test('own keys: the secret part is stored apart and read back', () async {
      final locked = tbKey('alice@openpgp.example-0xf231550c4f47e38e-secret-with-pp.asc');
      await keyring.addOwnKey(secret: locked, public: pgp.publicKey(locked));
      expect(keyring.state.ownKeys.single.isProtected, isTrue);
      expect(keyring.state.ownKeys.single.hasSecret, isFalse);
      expect(storage.values.keys, containsAll(['openpgp.keyring', 'openpgp.secret.${locked.fingerprint}']));
      expect(storage.values['openpgp.keyring'], isNot(contains(base64.encode(locked.data))));
      final secret = await keyring.secretKey(locked.fingerprint, pgp);
      expect(pgp.unlock(secret!, 'alice-passphrase').hasSecret, isTrue);
      final reloaded = Keyring(storage);
      await reloaded.load();
      expect(reloaded.state.ownKeys.single.fingerprint, locked.fingerprint);
      await reloaded.removeOwnKey(locked.fingerprint);
      expect(storage.values.keys, ['openpgp.keyring']);
    });

    test('public keys: acceptance, merging, lookups by address', () async {
      await keyring.addPublicKeys([bobPublic, carolPublic]);
      expect(keyring.state.publicKeys.map((e) => e.acceptance), everyElement(KeyAcceptance.undecided));
      expect(keyring.state.acceptedKeysFor('bob@openpgp.example'), isEmpty);
      await keyring.setAcceptance(bobPublic.fingerprint, KeyAcceptance.verified);
      await keyring.addPublicKeys([bobPublic]);
      expect(keyring.state.publicEntry(bobPublic.fingerprint)!.acceptance, KeyAcceptance.verified);
      expect(keyring.state.encryptionKeyFor('Bob@OpenPGP.example')!.key.fingerprint, bobPublic.fingerprint);
      expect(keyring.state.encryptionKeyFor('carol@example.com'), isNull);
      await keyring.setAcceptance(carolPublic.fingerprint, KeyAcceptance.rejected);
      expect(keyring.state.verificationKeys.map((k) => k.fingerprint), [bobPublic.fingerprint]);
    });

    test('identities: chosen key and defaults persist', () async {
      await keyring.addOwnKey(secret: aliceSecret, public: alicePublic);
      expect(keyring.state.ownKeyFor('alice@openpgp.example')!.fingerprint, aliceSecret.fingerprint);
      await keyring.setIdentity(
        'work@example.com',
        IdentityPgp(keyFingerprint: aliceSecret.fingerprint, preferEncrypt: true),
      );
      final reloaded = Keyring(storage);
      await reloaded.load();
      expect(reloaded.state.ownKeyFor('WORK@example.com')!.fingerprint, aliceSecret.fingerprint);
      expect(reloaded.state.identity('work@example.com').preferEncrypt, isTrue);
      expect(reloaded.state.identity('other@example.com').autoEncrypt, isTrue);
    });

    test('a damaged keyring entry starts empty', () async {
      storage.values['openpgp.keyring'] = '{oops';
      final k = Keyring(storage);
      expect((await k.load()).ownKeys, isEmpty);
    });
  });

  group('planEncryption (the compose toggles)', () {
    late Keyring keyring;

    setUp(() async {
      keyring = Keyring(MemoryKeyringStorage());
      await keyring.load();
      await keyring.addOwnKey(secret: aliceSecret, public: alicePublic);
    });

    test('suggests encryption when every recipient has an accepted key', () async {
      await keyring.addPublicKeys([bobPublic], acceptance: KeyAcceptance.unverified);
      var plan = planEncryption(keyring.state, from: 'alice@openpgp.example', recipients: ['bob@openpgp.example']);
      expect(plan.possible, isTrue);
      expect(plan.suggested, isTrue);
      expect(plan.recipientKeys.map((k) => k.fingerprint), [bobPublic.fingerprint, alicePublic.fingerprint]);
      plan = planEncryption(
        keyring.state,
        from: 'alice@openpgp.example',
        recipients: ['bob@openpgp.example', 'dave@example.org'],
      );
      expect(plan.possible, isFalse);
      expect(plan.missing, ['dave@example.org']);
      expect(plan.suggested, isFalse);
    });

    test('without automatic encryption only "required" turns it on', () async {
      await keyring.addPublicKeys([bobPublic], acceptance: KeyAcceptance.verified);
      await keyring.setIdentity('alice@openpgp.example', const IdentityPgp(autoEncrypt: false));
      expect(
        planEncryption(keyring.state, from: 'alice@openpgp.example', recipients: ['bob@openpgp.example']).suggested,
        isFalse,
      );
      await keyring.setIdentity('alice@openpgp.example', const IdentityPgp(autoEncrypt: false, encryptByDefault: true));
      final plan = planEncryption(keyring.state, from: 'alice@openpgp.example', recipients: ['dave@example.org']);
      expect(plan.suggested, isTrue, reason: 'required, even though Dave has no key: compose warns');
      expect(plan.possible, isFalse);
    });

    test('Autocrypt keys: usable, suggested only when both prefer mutual', () async {
      final now = DateTime.now();
      await keyring.addPublicKeys([carolPublic], source: KeySource.autocrypt);
      await keyring.putPeers([
        updatePeer(null, 'carol@example.com', now, fingerprint: carolPublic.fingerprint, preferMutual: true),
      ]);
      var plan = planEncryption(keyring.state, from: 'alice@openpgp.example', recipients: ['carol@example.com']);
      expect(plan.keys['carol@example.com']!.viaAutocrypt, isTrue);
      expect(plan.possible, isTrue);
      expect(plan.suggested, isFalse);
      await keyring.setIdentity('alice@openpgp.example', const IdentityPgp(preferEncrypt: true));
      plan = planEncryption(keyring.state, from: 'alice@openpgp.example', recipients: ['carol@example.com']);
      expect(plan.recommendation, AutocryptRecommendation.encrypt);
      expect(plan.suggested, isTrue);
      await keyring.setAcceptance(carolPublic.fingerprint, KeyAcceptance.rejected);
      expect(
        planEncryption(keyring.state, from: 'alice@openpgp.example', recipients: ['carol@example.com']).possible,
        isFalse,
      );
    });

    test('no own key: nothing is possible', () async {
      final empty = Keyring(MemoryKeyringStorage());
      await empty.load();
      final plan = planEncryption(empty.state, from: 'me@example.org', recipients: ['bob@openpgp.example']);
      expect((plan.possible, plan.suggested), (false, false));
    });
  });

  group('KeySession', () {
    test('remembers for the session, or for a grace period', () {
      var now = DateTime(2026);
      final session = KeySession(remember: false, clock: () => now);
      session.put(aliceSecret);
      expect(session[aliceSecret.fingerprint], isNotNull);
      now = now.add(const Duration(minutes: 3));
      expect(session[aliceSecret.fingerprint], isNull);
      session
        ..remember = true
        ..put(aliceSecret);
      now = now.add(const Duration(days: 1));
      expect(session.keys, hasLength(1));
      session.lockAll();
      expect(session.isUnlocked(aliceSecret.fingerprint), isFalse);
      session
        ..remember = false
        ..put(aliceSecret, pin: true);
      now = now.add(const Duration(days: 2));
      session.lockAll();
      expect(session.isUnlocked(aliceSecret.fingerprint), isTrue, reason: 'pinned');
      session.clear();
      expect(session.keys, isEmpty);
    });
  });
}
