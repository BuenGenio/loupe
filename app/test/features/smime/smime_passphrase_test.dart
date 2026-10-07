import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loupe/app.dart';
import 'package:loupe/features/compose/compose_args.dart';
import 'package:loupe/features/compose/compose_screen.dart';
import 'package:loupe/features/openpgp/openpgp_keys.dart';
import 'package:loupe/features/smime/smime_passphrase.dart';
import 'package:loupe/features/smime/smime_providers.dart';
import 'package:loupe/features/smime/smime_service.dart';
import 'package:loupe/router.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_imap/mail_imap.dart' show MimeMessageComposer;
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';
import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';
import '../openpgp/openpgp_test_support.dart';
import 'smime_compose_test.dart' show aliceAccount, sendButton;
import 'smime_test_support.dart';

/// Cheap Argon2 for keys protected by the tests themselves (the entry carries its cost).
const _cheap = SmimeKdfParameters(memoryPowerOf2: 10, iterations: 1, lanes: 1);

/// A keychain whose S/MIME store holds [bundle]'s certificate, its key protected with [passphrase].
Future<MemoryKeyringStorage> protectedKeychain(SmimeBundle bundle, String passphrase) async {
  final storage = await smimeKeychain(own: [bundle], trusted: [testRoot]);
  final store = SmimeStore(storage, prefix: liveSmimePrefix);
  await store.load();
  final k = bundle.keys.single;
  await store.setKeyProtection(
    k.certificate.fingerprint,
    protectedKey: protectKey(k.key, passphrase, fingerprint: k.certificate.fingerprint, kdf: _cheap),
  );
  return storage;
}

void main() {
  final bob = bobBundle.keys.single;

  group('the session', () {
    test('without Remember, an unlocked key is locked two minutes after its last use', () async {
      var now = DateTime(2026, 10, 7, 9);
      final keys = StoreSmimeKeys(SmimeStore(MemoryKeyringStorage()), remember: false, clock: () => now);
      keys.putUnlocked('f', bob.key);
      now = now.add(const Duration(minutes: 1));
      expect(keys.smimeKey('f'), isNotNull);
      now = now.add(const Duration(minutes: 1, seconds: 59));
      expect(keys.smimeKey('f'), isNotNull, reason: 'its use a minute ago counts');
      now = now.add(const Duration(minutes: 2, seconds: 1));
      expect(keys.smimeKey('f'), isNull);
    });

    test('with Remember, until Lock Keys Now; keys without a passphrase stay', () {
      var now = DateTime(2026, 10, 7, 9);
      final keys = StoreSmimeKeys(SmimeStore(MemoryKeyringStorage()), clock: () => now);
      keys
        ..putUnlocked('f', bob.key)
        ..put('plain', bob.key);
      now = now.add(const Duration(hours: 5));
      expect(keys.smimeKey('f'), isNotNull);
      keys.lockAll();
      expect(keys.smimeKey('f'), isNull);
      expect(keys.smimeKey('plain'), isNotNull);
    });

    test('background work loads keys without a passphrase only', () async {
      final storage = await protectedKeychain(bobBundle, 'secret');
      final keys = StoreSmimeKeys(SmimeStore(storage, prefix: liveSmimePrefix));
      await keys.store.load();
      await keys.loadKeys();
      expect(keys.store.state.own.single.hasPassphrase, isTrue);
      expect(keys.smimeKey(bob.certificate.fingerprint), isNull);
      expect(keys.keyPairs, isEmpty);
    });
  });

  group('reading', () {
    Future<void> open(WidgetTester tester, MemoryKeyringStorage storage, {String file = 'signed-enveloped.eml'}) async {
      final raw = smimeMessage(file);
      final repo = FakeMailRepository(
        emails: [
          testEmail('m1', from: aliceAddress, to: const [bobAddress], subject: 'S/MIME'),
        ],
        contents: {'m1': serverContent('m1', raw)},
      )..rawSources['m1'] = raw;
      late GoRouter router;
      router = await pumpTestApp(
        tester,
        repository: repo,
        overrides: [
          inlinePgp,
          keychain(storage),
          smimePassphrasePromptProvider.overrideWithValue(
            (certificate, {error}) => showSmimeUnlockDialog(
              router.routerDelegate.navigatorKey.currentContext!,
              certificate: certificate,
              error: error,
            ),
          ),
        ],
      );
      unawaited(router.push('/message/m1'));
      await tester.pumpAndSettle();
    }

    Future<void> enter(WidgetTester tester, String passphrase) async {
      await tester.enterText(find.byKey(const ValueKey('smime-unlock-field')), passphrase);
      await tester.tap(find.byKey(const ValueKey('smime-unlock')));
      await tester.pumpAndSettle();
    }

    testWidgets('mail encrypted to a protected key asks for its passphrase, again when wrong', (tester) async {
      await open(tester, await protectedKeychain(bobBundle, 'secret'));
      expect(find.byType(SmimeUnlockDialog), findsOneWidget);
      expect(textContaining('Bob Example’s certificate (bob@example.net)'), findsOneWidget);
      await enter(tester, 'wrong');
      expect(find.text('That passphrase is wrong. Try again.'), findsOneWidget);
      await enter(tester, 'secret');

      expect(find.byType(SmimeUnlockDialog), findsNothing);
      expect(textContaining('This message is signed with S/MIME. Grüße!'), findsWidgets);
      expect(textContaining('Encrypted (S/MIME)'), findsOneWidget);
    });

    testWidgets('cancelled: the message says the certificate is locked', (tester) async {
      await open(tester, await protectedKeychain(bobBundle, 'secret'));
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(textContaining('Encrypted (S/MIME) · locked'), findsOneWidget);
      expect(textContaining('Your S/MIME certificate is locked'), findsWidgets);
    });

    testWidgets('signed-only mail never asks', (tester) async {
      await open(tester, await protectedKeychain(bobBundle, 'secret'), file: 'signed-detached.eml');
      expect(find.byType(SmimeUnlockDialog), findsNothing);
      expect(textContaining('Signed by Alice Example ✓'), findsOneWidget);
    });
  });

  group('sending', () {
    test('a locked key: the composer says so; once unlocked, it signs', () async {
      final storage = await protectedKeychain(bobBundle, 'secret');
      final keys = StoreSmimeKeys(SmimeStore(storage, prefix: liveSmimePrefix));
      await keys.store.load();
      await keys.loadKeys();
      final keyring = Keyring(MemoryKeyringStorage());
      await keyring.load();
      final composer = SmimeMessageComposer(
        PgpMessageComposer(
          MimeMessageComposer(),
          SessionSendKeys(keyring, KeySession.new),
          backend: const DartPgBackend(),
        ),
        keys,
        backend: smime,
      );
      final message = OutgoingMessage(
        accountId: 'a',
        identityId: 'a',
        to: const [aliceAddress],
        subject: 'Hi',
        text: 'Signed.',
        security: const OutgoingSecurity(sign: true, technology: SecurityTechnology.smime),
      );
      const from = Identity(id: 'a', email: 'bob@example.net', name: 'Bob Example');
      expect(
        () => composer.compose(message, from, messageId: '<m@x>'),
        throwsA(isA<MailException>().having((e) => e.message, 'message', contains('tap Retry in the Outbox'))),
      );
      final service = SmimeService(
        keys: keys,
        backend: smime,
        run: <T>(T Function() work) async => work(),
        prompt: (certificate, {error}) async => 'secret',
      );
      expect(await service.unlock(bob.certificate.fingerprint), isA<SmimePrivateKey>());
      expect(composer.compose(message, from, messageId: '<m@x>'), isNotEmpty);
    });
  });

  group('compose', () {
    testWidgets('Send asks for the passphrase first; Cancel stays in compose', (tester) async {
      final storage = await protectedKeychain(aliceBundle, 'secret');
      final store = SmimeStore(storage, prefix: liveSmimePrefix);
      await store.load();
      await store.addContact(bobBundle.keys.single.certificate, chain: [fixtureCert('intermediate.crt')]);
      final repo = FakeMailRepository(accounts: [aliceAccount]);
      late GoRouter router;
      router = await pumpTestApp(
        tester,
        repository: repo,
        composeBuilder: (args) => ComposeScreen(args: args),
        overrides: [
          inlinePgp,
          keychain(storage),
          smimePassphrasePromptProvider.overrideWithValue(
            (certificate, {error}) => showSmimeUnlockDialog(
              router.routerDelegate.navigatorKey.currentContext!,
              certificate: certificate,
              error: error,
            ),
          ),
        ],
      );
      unawaited(router.push('/compose', extra: const ComposeArgs(to: [bobAddress])));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('compose-subject')), 'Numbers');
      await tester.tap(sendButton);
      await tester.pumpAndSettle();
      expect(find.byType(SmimeUnlockDialog), findsOneWidget);
      await tester.tap(find.descendant(of: find.byType(SmimeUnlockDialog), matching: find.text('Cancel')));
      await tester.pumpAndSettle();
      expect(repo.sent, isEmpty);
      expect(find.byType(ComposeScreen), findsOneWidget);

      await tester.tap(sendButton);
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey('smime-unlock-field')), 'secret');
      await tester.tap(find.byKey(const ValueKey('smime-unlock')));
      await tester.pumpAndSettle();
      expect(
        repo.sent.single.security,
        const OutgoingSecurity(encrypt: true, sign: true, technology: SecurityTechnology.smime),
      );
      await tester.pump(const Duration(seconds: 11));
    });
  });

  group('settings', () {
    testWidgets('Set Passphrase…, then Remove Passphrase', (tester) async {
      await pumpLoupe(tester, overrides: [inlinePgp, noDemoSmime]);
      final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
      final keys = await container.read(smimeKeysProvider.future);
      await keys.store.addOwn(SmimeKeyPair(bob.certificate, bob.key), chain: bobBundle.chain);
      keys.put(bob.certificate.fingerprint, bob.key);
      await goTo(tester, Routes.smimeCertificate(bob.certificate.fingerprint));
      expect(find.text('In Loupe'), findsOneWidget);

      final set = find.byKey(const ValueKey('smime-set-passphrase-row'));
      await tester.scrollTo(set);
      await tester.ensureVisible(set);
      await tester.pumpAndSettle();
      await tester.tap(set);
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey('smime-new-passphrase')), 'one');
      await tester.enterText(find.byKey(const ValueKey('smime-new-passphrase-again')), 'two');
      await tester.tap(find.byKey(const ValueKey('smime-set-passphrase')));
      await tester.pumpAndSettle();
      expect(find.text('The two passphrases differ.'), findsOneWidget);
      await tester.enterText(find.byKey(const ValueKey('smime-new-passphrase-again')), 'one');
      await tester.tap(find.byKey(const ValueKey('smime-set-passphrase')));
      await tester.pumpAndSettle();
      expect(textContaining('Passphrase set.'), findsOneWidget);
      expect(keys.store.state.own.single.hasPassphrase, isTrue);
      expect(await keys.store.protectedKey(bob.certificate.fingerprint), isNotNull);
      // Still unlocked in this session.
      expect(keys.smimeKey(bob.certificate.fingerprint), isNotNull);

      keys.lockAll();
      final remove = find.byKey(const ValueKey('smime-remove-passphrase'));
      await tester.scrollTo(remove);
      await tester.ensureVisible(remove);
      await tester.pumpAndSettle();
      await tester.tap(remove);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Remove Passphrase').last);
      await tester.pumpAndSettle();
      // Locked: its passphrase first.
      await tester.enterText(find.byKey(const ValueKey('smime-unlock-field')), 'one');
      await tester.tap(find.byKey(const ValueKey('smime-unlock')));
      await tester.pumpAndSettle();
      expect(textContaining('Passphrase removed.'), findsOneWidget);
      expect(keys.store.state.own.single.hasPassphrase, isFalse);
      expect(await keys.store.privateKey(bob.certificate.fingerprint), isA<SmimePrivateKey>());
      await drainTimers(tester);
    });
  });
}
