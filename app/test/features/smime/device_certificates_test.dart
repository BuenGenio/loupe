import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/data/isolate_composer.dart';
import 'package:loupe/features/openpgp/openpgp_keys.dart';
import 'package:loupe/features/smime/device_certificates.dart';
import 'package:loupe/features/smime/smime_providers.dart';
import 'package:loupe/router.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';
import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';
import '../openpgp/openpgp_test_support.dart';
import 'smime_test_support.dart';

Future<SmimeState> smimeOf(WidgetTester tester) async {
  final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
  return (await container.read(smimeKeysProvider.future)).store.state;
}

const _channel = MethodChannel(KeyChainCertificates.channelName);

/// Android's side of the channel, faked: KeyChain holds Alice's certificate
/// (with the test CAs) under `alice-device` and Bob's EC one under
/// `bob-device`; the keys do what Java's Signature, Cipher and KeyAgreement
/// would (mail_crypto's SoftwareSmimeKeystore).
final class FakeKeyChain {
  FakeKeyChain({this.chosen = 'alice-device'});

  String? chosen;
  final calls = <MethodCall>[];

  /// A PlatformException code to fail `perform` with.
  String? failWith;

  final keystore = SoftwareSmimeKeystore({
    'alice-device': aliceBundle.keys.single.key,
    'bob-device': bobBundle.keys.single.key,
  });

  late final chains = <String, List<Uint8List>>{
    'alice-device': [aliceBundle.keys.single.certificate.der, for (final c in aliceBundle.chain) c.der],
    'bob-device': [bobBundle.keys.single.certificate.der, fixtureCert('intermediate.crt').der],
  };

  void install() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(_channel, handle);
    addTearDown(
      () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(_channel, null),
    );
  }

  Future<Object?> handle(MethodCall call) async {
    calls.add(call);
    final args = (call.arguments as Map).cast<String, Object?>();
    switch (call.method) {
      case 'choose':
        return chosen;
      case 'chain':
        final chain = chains[args['alias']];
        if (chain == null) throw PlatformException(code: 'unavailable');
        return chain;
      case 'perform':
        if (failWith case final code?) throw PlatformException(code: code, message: 'refused');
        final request = SmimeKeyRequest(
          alias: args['alias']! as String,
          operation: SmimeKeyOperation.values.byName(args['operation']! as String),
          input: args['input']! as Uint8List,
          keyType: SmimeKeyType.values.byName(args['keyType']! as String),
          digest: args['digest'] as String?,
          mgfDigest: args['mgfDigest'] as String?,
        );
        try {
          return await keystore.perform(request);
        } on SmimeException {
          throw PlatformException(code: 'unavailable');
        }
    }
    throw MissingPluginException();
  }
}

void main() {
  final aliceCert = aliceBundle.keys.single.certificate;
  final bobCert = bobBundle.keys.single.certificate;
  final device = KeyChainCertificates();

  group('the channel', () {
    test('passes what the key must do, and gives back its answer', () async {
      final fake = FakeKeyChain()..install();
      expect(await device.choose(), 'alice-device');
      final chain = await device.chain('alice-device');
      expect(SmimeCertificate.fromDer(chain.first), aliceCert);

      final request = SmimeKeyRequest(
        alias: 'alice-device',
        operation: SmimeKeyOperation.sign,
        input: Uint8List.fromList([1, 2, 3]),
        keyType: SmimeKeyType.rsa,
        digest: 'SHA-256',
      );
      final signature = await device.perform(request);
      expect(signature, hasLength(256));
      final perform = fake.calls.last;
      expect(perform.method, 'perform');
      expect(perform.arguments, {
        'alias': 'alice-device',
        'operation': 'sign',
        'input': Uint8List.fromList([1, 2, 3]),
        'keyType': 'rsa',
        'digest': 'SHA-256',
        'mgfDigest': null,
      });
    });

    test('platform errors become S/MIME errors the screens can word', () async {
      final fake = FakeKeyChain()..install();
      final request = SmimeKeyRequest(
        alias: 'alice-device',
        operation: SmimeKeyOperation.decryptPkcs1,
        input: Uint8List(256),
        keyType: SmimeKeyType.rsa,
      );
      for (final (code, kind) in [
        ('unavailable', SmimeErrorKind.locked),
        ('badPadding', SmimeErrorKind.malformed),
        ('unsupported', SmimeErrorKind.unsupported),
        ('failed', SmimeErrorKind.failed),
      ]) {
        fake.failWith = code;
        await expectLater(device.perform(request), throwsA(isA<SmimeException>().having((e) => e.kind, code, kind)));
      }
      expect(device.chain('gone'), throwsA(isA<SmimeException>().having((e) => e.kind, 'kind', SmimeErrorKind.locked)));
    });

    test('without the channel (a background isolate), the key is unavailable, not a crash', () async {
      final request = SmimeKeyRequest(
        alias: 'alice-device',
        operation: SmimeKeyOperation.sign,
        input: Uint8List(3),
        keyType: SmimeKeyType.rsa,
      );
      await expectLater(
        device.perform(request),
        throwsA(isA<SmimeException>().having((e) => e.message, 'message', contains('while Loupe is open'))),
      );
    });
  });

  group('sending with a certificate on the device', () {
    late Keyring keyring;
    late StoreSmimeKeys smime;

    setUp(() async {
      keyring = Keyring(MemoryKeyringStorage());
      await keyring.load();
      smime = StoreSmimeKeys(SmimeStore(MemoryKeyringStorage()));
      await smime.store.load();
      await smime.store.addOwn(
        SmimeKeyPair(aliceCert, const SmimePlatformKey('alice-device')),
        chain: aliceBundle.chain,
      );
      await smime.store.addContact(bobCert, chain: [fixtureCert('intermediate.crt')]);
      await smime.store.trust(testRoot);
      await smime.loadKeys();
    });

    IsolateComposer composer({SmimePlatformKeys? platform}) => IsolateComposer(
      SecureSendKeys(SessionSendKeys(keyring, KeySession.new), smime),
      device: platform,
      run: <T>(T Function() work) async => work(),
    );

    final message = OutgoingMessage(
      accountId: 'acc',
      identityId: 'acc/alice',
      to: const [bobAddress],
      subject: 'Quarterly',
      text: 'Signed on the device.',
      security: const OutgoingSecurity(sign: true, encrypt: true, technology: SecurityTechnology.smime),
    );
    const alice = Identity(id: 'acc/alice', email: 'alice@example.org', name: 'Alice Example');

    test('the device signs through the channel; Bob reads it signed by Alice ✓', () async {
      final fake = FakeKeyChain()..install();
      final raw = await composer(platform: device)
          .composeAsync(message, alice, messageId: '<q@example.org>', date: DateTime.now());
      expect(fake.calls.map((c) => c.method), ['perform']);
      expect((fake.calls.single.arguments as Map)['operation'], 'sign');

      final bob = bobBundle.keys.single;
      final read = const SmimeReader(DartSmimeBackend())
          .read(raw, keys: [SmimeKeyPair(bob.certificate, bob.key)], anchors: SmimeTrustAnchors([testRoot]));
      expect(read.status.decrypted, isTrue);
      expect(read.status.signature?.good, isTrue, reason: '${read.status}');
      expect(read.entity!.text, contains('Signed on the device.'));
    });

    test('in the background (no channel) it waits for the app, never goes out unsigned', () async {
      await expectLater(
        composer().composeAsync(message, alice, messageId: '<q@example.org>', date: DateTime.now()),
        throwsA(isA<MailException>().having((e) => e.message, 'message', contains('open Loupe'))),
      );
    });

    test('a key the device refuses: the reason, and nothing sent', () async {
      final refusing = FakeKeyChain()
        ..failWith = 'unavailable'
        ..install();
      await expectLater(
        composer(platform: device).composeAsync(message, alice, messageId: '<q@example.org>', date: DateTime.now()),
        throwsA(isA<MailException>().having((e) => e.message, 'message', contains('Choose it again'))),
      );
      expect(refusing.calls, hasLength(1));
    });
  });

  group('the app', () {
    testWidgets('Use a Certificate from This Device: picked, added with its key on the device, its CA offered', (
      tester,
    ) async {
      final fake = FakeKeyChain()..install();
      await pumpLoupe(tester, overrides: [inlinePgp]);
      await goTo(tester, Routes.encryption);
      await tester.scrollTo(find.byKey(const ValueKey('smime-use-device')));
      await tester.ensureVisible(find.byKey(const ValueKey('smime-use-device')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('smime-use-device')));
      await tester.pumpAndSettle();

      expect(find.text('Trust “Loupe Test Root CA” for Mail?'), findsOneWidget);
      await tester.tap(find.text('Trust'));
      await tester.pumpAndSettle();
      expect(
        textContaining('Added your certificate Alice Example (alice@example.org) from this device.'),
        findsOneWidget,
      );
      expect(fake.calls.map((c) => c.method), ['choose', 'chain']);

      final state = await smimeOf(tester);
      expect(state.own.single.deviceAlias, 'alice-device');
      expect(state.authorities, [testRoot]);

      await goTo(tester, Routes.smimeCertificate(aliceCert.fingerprint));
      expect(find.text('On this device'), findsOneWidget);
      await drainTimers(tester);
    });

    testWidgets('a certificate that isn’t for mail is refused', (tester) async {
      final fake = FakeKeyChain(chosen: 'tls')..install();
      fake.chains['tls'] = [fixtureCert('erin.crt').der];
      await pumpLoupe(tester, overrides: [inlinePgp]);
      await goTo(tester, Routes.encryption);
      await tester.scrollTo(find.byKey(const ValueKey('smime-use-device')));
      await tester.ensureVisible(find.byKey(const ValueKey('smime-use-device')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('smime-use-device')));
      await tester.pumpAndSettle();
      expect(textContaining('This certificate isn’t for mail'), findsOneWidget);
      expect((await smimeOf(tester)).own, isEmpty);
      await drainTimers(tester);
    });

    testWidgets('reading mail encrypted to the certificate on the device: the device decrypts the key', (tester) async {
      final fake = FakeKeyChain()..install();
      final storage = MemoryKeyringStorage();
      final store = SmimeStore(storage, prefix: liveSmimePrefix);
      await store.load();
      await store.addOwn(
        SmimeKeyPair(bobCert, const SmimePlatformKey('bob-device')),
        chain: [fixtureCert('intermediate.crt')],
      );
      await store.trust(testRoot);
      final raw = smimeMessage('signed-enveloped.eml');
      final repo = FakeMailRepository(
        emails: [
          testEmail('m1', from: aliceAddress, to: const [bobAddress], subject: 'S/MIME'),
        ],
        contents: {'m1': serverContent('m1', raw)},
      )..rawSources['m1'] = raw;
      final router = await pumpTestApp(tester, repository: repo, overrides: [inlinePgp, keychain(storage)]);
      unawaited(router.push('/message/m1'));
      await tester.pumpAndSettle();

      expect(textContaining('This message is signed with S/MIME. Grüße!'), findsWidgets);
      expect(textContaining('Encrypted (S/MIME)'), findsOneWidget);
      expect(textContaining('Signed by Alice Example ✓'), findsOneWidget);
      expect([for (final c in fake.calls) (c.arguments as Map)['operation']], ['agree']);
    });

    testWidgets('the device refuses: the message says why', (tester) async {
      final fake = FakeKeyChain()
        ..failWith = 'unavailable'
        ..install();
      final storage = MemoryKeyringStorage();
      final store = SmimeStore(storage, prefix: liveSmimePrefix);
      await store.load();
      await store.addOwn(SmimeKeyPair(aliceCert, const SmimePlatformKey('alice-device')), chain: aliceBundle.chain);
      final raw = smimeMessage('enveloped-rsa.eml');
      final repo = FakeMailRepository(
        emails: [
          testEmail('m1', from: bobAddress, to: const [aliceAddress], subject: 'S/MIME'),
        ],
        contents: {'m1': serverContent('m1', raw)},
      )..rawSources['m1'] = raw;
      final router = await pumpTestApp(tester, repository: repo, overrides: [inlinePgp, keychain(storage)]);
      unawaited(router.push('/message/m1'));
      await tester.pumpAndSettle();

      expect(textContaining('Encrypted (S/MIME) · locked'), findsOneWidget);
      expect(textContaining('Choose it again in Settings'), findsWidgets);
      expect(fake.calls, hasLength(1));
    });
  });
}
