import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loupe/data/live.dart';
import 'package:loupe/features/account_setup/account_setup_screen.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';

Future<void> openSetup(WidgetTester tester, FakeMailRepository repo) async {
  final router = await pumpTestApp(
    tester,
    repository: repo,
    extraRoutes: [GoRoute(path: '/add-account', builder: (_, _) => const AccountSetupScreen())],
  );
  unawaited(router.push('/add-account'));
  await tester.pumpAndSettle();
}

Future<void> enterAddress(WidgetTester tester, String email) async {
  await tester.enterText(find.byKey(const Key('setup-name')), 'Jane Doe');
  await tester.enterText(find.byKey(const Key('setup-email')), email);
  await tester.tap(find.byKey(const Key('setup-continue')));
  await tester.pumpAndSettle();
}

Future<void> signIn(WidgetTester tester, String password) async {
  await tester.enterText(find.byKey(const Key('setup-password')), password);
  await tester.ensureVisible(find.byKey(const Key('setup-sign-in')));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('setup-sign-in')));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('discovers, adds the account, then sets its name and colour', (tester) async {
    final repo = FakeMailRepository(accounts: [testAccount]);
    await openSetup(tester, repo);
    await enterAddress(tester, 'jane@example.com');
    expect(repo.log, contains('discover jane@example.com'));
    expect(find.text('Found via ISPDB'), findsOneWidget);

    await signIn(tester, 'secret');
    final setup = repo.setups.single;
    expect(setup.email, 'jane@example.com');
    expect(setup.senderName, 'Jane Doe');
    expect(setup.incoming.host, 'imap.example.com');
    expect(setup.outgoing?.host, 'smtp.example.com');
    expect((setup.credentials as PasswordCredentials).password, 'secret');
    expect(find.text('Account Added'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('setup-description')), 'Jane');
    await tester.tap(find.byKey(const ValueKey('setup-colour-3')));
    await tester.tap(find.byKey(const Key('setup-done')));
    await tester.pumpAndSettle();
    expect(repo.log, contains('updateAccount new Jane 3'));
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('shows "Password rejected" for authentication errors', (tester) async {
    final repo = FakeMailRepository()
      ..onAddAccount = (_) async => throw const MailException(MailErrorKind.authentication, 'LOGIN failed');
    await openSetup(tester, repo);
    await enterAddress(tester, 'jane@example.com');
    await signIn(tester, 'wrong');
    expect(find.textContaining('Password rejected'), findsOneWidget);
    expect(find.byKey(const Key('setup-sign-in')), findsOneWidget);
  });

  testWidgets('an unexpected failure ends the spinner with a message', (tester) async {
    final repo = FakeMailRepository()..onDiscover = (_) async => throw StateError('database is locked');
    await openSetup(tester, repo);
    await enterAddress(tester, 'jane@example.com');
    expect(find.textContaining('Something went wrong (StateError)'), findsOneWidget);
    expect(find.byType(CupertinoActivityIndicator), findsNothing);

    // A keychain error while adding the account, after discovery worked.
    repo
      ..onDiscover = null
      ..onAddAccount = (_) async => throw const DatabaseKeyUnavailable(missing: true);
    await tester.tap(find.byKey(const Key('setup-continue')));
    await tester.pumpAndSettle();
    await signIn(tester, 'secret');
    expect(find.textContaining('couldn’t open its mail database'), findsOneWidget);
    expect(find.byKey(const Key('setup-sign-in')), findsOneWidget);
    expect(tester.widget<FilledButton>(find.byKey(const Key('setup-sign-in'))).onPressed, isNotNull);
  });

  testWidgets('offers to trust a certificate and retries with its fingerprint', (tester) async {
    final fp = List.filled(32, 'ab').join(':');
    var attempts = 0;
    final repo = FakeMailRepository()
      ..onAddAccount = (setup) async {
        if (attempts++ == 0) {
          throw MailException(MailErrorKind.certificate, 'imap.example.com presented an unknown certificate $fp');
        }
        return testAccount;
      };
    await openSetup(tester, repo);
    await enterAddress(tester, 'jane@example.com');
    await signIn(tester, 'secret');
    expect(find.textContaining("isn't trusted"), findsOneWidget);

    await tester.tap(find.byKey(const Key('trust-certificate')));
    await tester.pumpAndSettle();
    expect(repo.setups, hasLength(2));
    expect(repo.setups.last.incoming.trustedCertificateSha256, 'ab' * 32);
    expect(repo.setups.last.outgoing?.trustedCertificateSha256, isNull);
    expect(find.text('Account Added'), findsOneWidget);
  });

  testWidgets('Gmail offers the app-password path; Microsoft explains OAuth', (tester) async {
    final repo = FakeMailRepository()
      ..onDiscover = (email) async => AccountDiscovery(
        email: email,
        provider: email.endsWith('gmail.com') ? ProviderKind.gmail : ProviderKind.microsoft,
        authKind: AuthKind.oauth2,
        incoming: const ServerConfig(protocol: ServerProtocol.imap, host: 'imap.gmail.com', port: 993),
        outgoing: const ServerConfig(protocol: ServerProtocol.smtp, host: 'smtp.gmail.com', port: 465),
        source: 'provider rules',
      );
    await openSetup(tester, repo);
    await enterAddress(tester, 'jane@gmail.com');
    expect(find.byKey(const Key('setup-password')), findsNothing);
    await tester.tap(find.byKey(const Key('use-app-password')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('setup-password')), findsOneWidget);
    expect(find.text('How to Create an App Password'), findsOneWidget);

    // Back from sign-in returns to the address step.
    unawaited(Navigator.of(tester.element(find.byKey(const Key('setup-password')))).maybePop());
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('setup-email')), findsOneWidget);
    await enterAddress(tester, 'jane@outlook.com');
    expect(find.byKey(const Key('microsoft-note')), findsOneWidget);
    expect(find.byKey(const Key('setup-password')), findsNothing);
  });

  testWidgets('manual settings: choosing no encryption needs confirmation', (tester) async {
    final repo = FakeMailRepository()
      ..onDiscover = (email) async =>
          AccountDiscovery(email: email, provider: ProviderKind.generic, authKind: AuthKind.password);
    await openSetup(tester, repo);
    await enterAddress(tester, 'jane@tiny.example');
    expect(find.textContaining("Couldn't find settings"), findsOneWidget);
    expect(find.byKey(const ValueKey('imap-host')), findsOneWidget);
    await tester.enterText(find.byKey(const Key('setup-password')), 'secret');
    await tester.enterText(find.byKey(const ValueKey('imap-host')), 'mail.tiny.example');

    await tester.ensureVisible(find.byKey(const ValueKey('imap-security')));
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byKey(const ValueKey('imap-security')), matching: find.text('None')));
    await tester.pumpAndSettle();
    expect(find.text('Connect Without Encryption?'), findsOneWidget);
    await tester.tap(find.text('Use Without Encryption'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.byKey(const Key('setup-sign-in')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byKey(const Key('setup-sign-in')));
    await tester.pumpAndSettle();
    final incoming = repo.setups.single.incoming;
    expect(incoming.host, 'mail.tiny.example');
    expect(incoming.security, ConnectionSecurity.none);
    expect(incoming.port, 143);
  });

  test('fingerprints are found with or without colons', () {
    expect(fingerprintIn('bad cert ${'AB:' * 31}AB'), 'ab' * 32);
    expect(fingerprintIn('sha256=${'0f' * 32}.'), '0f' * 32);
    expect(fingerprintIn('no fingerprint here'), isNull);
  });
}
