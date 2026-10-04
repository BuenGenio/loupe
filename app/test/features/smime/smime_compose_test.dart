import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/compose/compose_args.dart';
import 'package:loupe/features/compose/compose_screen.dart';
import 'package:loupe/features/openpgp/compose_security.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';
import '../openpgp/openpgp_test_support.dart';
import 'smime_test_support.dart';

final encryptToggle = find.byKey(const Key('compose-encrypt'));
final signToggle = find.byKey(const Key('compose-sign'));
final technology = find.byKey(const Key('compose-technology'));
final sendButton = find.byKey(const Key('compose-send'));

bool isOn(WidgetTester tester, Finder toggle) =>
    tester.widget<Semantics>(find.descendant(of: toggle, matching: find.byType(Semantics)).first).properties.toggled ??
    false;

String technologyLabel(WidgetTester tester) =>
    tester.widget<Text>(find.descendant(of: technology, matching: find.byType(Text))).data!;

const aliceAccount = MailAccount(
  id: 'acc',
  email: 'alice@example.org',
  displayName: 'Work',
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: ServerConfig(protocol: ServerProtocol.imap, host: 'imap.example.org', port: 993),
  outgoing: ServerConfig(protocol: ServerProtocol.smtp, host: 'smtp.example.org', port: 465),
  identities: [Identity(id: 'acc/alice', email: 'alice@example.org', name: 'Alice Example')],
);

final bobCertificate = bobBundle.keys.single.certificate;

void main() {
  Future<FakeMailRepository> open(
    WidgetTester tester, {
    required MemoryKeyringStorage storage,
    ComposeArgs args = const ComposeArgs(to: [bobAddress]),
  }) async {
    final repo = FakeMailRepository(accounts: [aliceAccount]);
    final router = await pumpTestApp(
      tester,
      repository: repo,
      composeBuilder: (args) => ComposeScreen(args: args),
      overrides: [inlinePgp, keychain(storage)],
    );
    unawaited(router.push('/compose', extra: args));
    await tester.pumpAndSettle();
    return repo;
  }

  Future<void> send(WidgetTester tester) async {
    await tester.enterText(find.byKey(const Key('compose-subject')), 'Numbers');
    await tester.tap(sendButton);
    await tester.pumpAndSettle();
  }

  testWidgets('only S/MIME set up: Bob has a certificate, so it encrypts and signs with S/MIME', (tester) async {
    final storage = await smimeKeychain(own: [aliceBundle], contacts: [bobCertificate], trusted: [testRoot]);
    final repo = await open(tester, storage: storage);
    expect(technologyLabel(tester), 'S/MIME');
    expect(isOn(tester, encryptToggle), isTrue);
    expect(isOn(tester, signToggle), isTrue);
    expect(find.text('Everyone has a certificate'), findsNothing, reason: 'encrypting already');

    await send(tester);
    expect(
      repo.sent.single.security,
      const OutgoingSecurity(encrypt: true, sign: true, technology: SecurityTechnology.smime),
    );
    await tester.pump(const Duration(seconds: 11));
  });

  testWidgets('a recipient without a certificate: Encrypt stays off; forcing it asks', (tester) async {
    final storage = await smimeKeychain(own: [aliceBundle], contacts: [bobCertificate], trusted: [testRoot]);
    final repo = await open(
      tester,
      storage: storage,
      args: const ComposeArgs(to: [EmailAddress('carol@example.org')]),
    );
    expect(isOn(tester, encryptToggle), isFalse);
    await tester.tap(encryptToggle);
    await tester.pumpAndSettle();
    expect(find.text('No certificate for carol@example.org'), findsOneWidget);

    await send(tester);
    expect(find.text('There is no valid S/MIME certificate for carol@example.org.'), findsOneWidget);
    await tester.tap(find.text('Send Unencrypted'));
    await tester.pumpAndSettle();
    expect(repo.sent.single.security, const OutgoingSecurity(sign: true, technology: SecurityTechnology.smime));
    await tester.pump(const Duration(seconds: 11));
  });

  testWidgets('an untrusted certificate isn’t encrypted to', (tester) async {
    final storage = await smimeKeychain(own: [aliceBundle], contacts: [bobCertificate]);
    await open(tester, storage: storage);
    expect(isOn(tester, encryptToggle), isFalse);
    expect(technologyLabel(tester), 'S/MIME');
  });

  testWidgets('OpenPGP and S/MIME both set up: automatic choice by the recipients, and a switch', (tester) async {
    final pgpKey = testKey('Alice Example <alice@example.org>');
    final storage = await smimeKeychain(
      storage: await keychainWith(own: [pgpKey]),
      own: [aliceBundle],
      contacts: [bobCertificate],
      trusted: [testRoot],
    );
    await open(tester, storage: storage);
    // OpenPGP is the default, but only S/MIME can encrypt to Bob.
    expect(technologyLabel(tester), 'S/MIME');
    expect(isOn(tester, encryptToggle), isTrue);

    await tester.tap(technology);
    await tester.pumpAndSettle();
    expect(technologyLabel(tester), 'OpenPGP');
    expect(isOn(tester, encryptToggle), isFalse, reason: 'Bob has no OpenPGP key');
  });

  testWidgets('drafts keep S/MIME', (tester) async {
    final storage = await smimeKeychain(own: [aliceBundle], contacts: [bobCertificate], trusted: [testRoot]);
    final repo = await open(tester, storage: storage);
    await tester.enterText(find.byKey(const Key('compose-subject')), 'Draft');
    await tester.pump(ComposeScreen.autosaveDelay + const Duration(milliseconds: 100));
    await tester.pumpAndSettle();
    expect(
      repo.drafts.last.security,
      const OutgoingSecurity(encrypt: true, sign: true, draft: true, technology: SecurityTechnology.smime),
    );
  });

  group('ComposeSecurityController', () {
    final pgpKey = testKey('Alice Example <alice@example.org>');
    late KeyringState keyring;
    late SmimeState smimeState;

    setUpAll(() async {
      final k = Keyring(MemoryKeyringStorage());
      await k.load();
      await k.addOwnKey(secret: pgpKey, public: pgp.publicKey(pgpKey));
      keyring = k.state;
      final store = SmimeStore(MemoryKeyringStorage());
      await store.load();
      final alice = aliceBundle.keys.single;
      await store.addOwn(SmimeKeyPair(alice.certificate, alice.key), chain: aliceBundle.chain);
      await store.addContact(bobCertificate, chain: [fixtureCert('intermediate.crt')]);
      await store.trust(testRoot);
      smimeState = store.state;
    });

    ComposeSecurityController controller({
      SmimeState? smime,
      List<String> to = const ['bob@example.net'],
      SecurityTechnology? reply,
    }) => ComposeSecurityController()
      ..update(
        state: keyring,
        smime: smime ?? smimeState,
        from: 'alice@example.org',
        recipients: to,
        replyToEncrypted: reply != null,
        replyTechnology: reply,
      );

    test('nobody has keys: OpenPGP unless the address prefers S/MIME', () {
      expect(controller(to: ['dan@example.com']).technology, SecurityTechnology.openPgp);
      final prefers = SmimeState(
        own: smimeState.own,
        contacts: smimeState.contacts,
        authorities: smimeState.authorities,
        identities: const {'alice@example.org': IdentitySmime(preferSmime: true)},
      );
      final c = controller(smime: prefers, to: ['dan@example.com']);
      expect((c.technology, c.encrypt, c.canSwitch), (SecurityTechnology.smime, false, true));
    });

    test('a reply to S/MIME encrypted mail uses S/MIME and encrypts', () {
      final c = controller(to: ['bob@example.net'], reply: SecurityTechnology.smime);
      expect((c.technology, c.encrypt), (SecurityTechnology.smime, true));
    });

    test('restored choices win; the technology is kept', () {
      final c = controller(to: ['dan@example.com'])
        ..restore(const OutgoingSecurity(sign: true, technology: SecurityTechnology.smime));
      expect(c.value, const OutgoingSecurity(sign: true, technology: SecurityTechnology.smime));
    });

    test('S/MIME never attaches an OpenPGP key', () {
      final c = controller()..restore(const OutgoingSecurity(sign: true, technology: SecurityTechnology.smime));
      expect(c.attachKey, isFalse);
    });
  });
}
