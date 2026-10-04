import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loupe/features/account_setup/account_setup_screen.dart';
import 'package:loupe/features/account_setup/oauth_accounts.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart';

import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';
import 'fake_oauth.dart';

/// Discovery as mail_imap's provider rules answer for Gmail and Outlook
/// addresses (also Google Workspace and Microsoft 365 domains).
AccountDiscovery _discover(String email) {
  final gmail = email.endsWith('gmail.com') || email.endsWith('workspace.example');
  return AccountDiscovery(
    email: email,
    provider: gmail ? ProviderKind.gmail : ProviderKind.microsoft,
    authKind: AuthKind.oauth2,
    incoming: ServerConfig(
      protocol: ServerProtocol.imap,
      host: gmail ? 'imap.gmail.com' : 'outlook.office365.com',
      port: 993,
    ),
    outgoing: ServerConfig(
      protocol: ServerProtocol.smtp,
      host: gmail ? 'smtp.gmail.com' : 'smtp.office365.com',
      port: 465,
    ),
    source: 'provider',
    notes: gmail ? 'Sign in with Google.' : 'Sign in with Microsoft.',
  );
}

Future<void> _open(WidgetTester tester, FakeMailRepository repo, OAuthSignIn oauth) async {
  final router = await pumpTestApp(
    tester,
    repository: repo,
    overrides: [oauthOverride(oauth)],
    extraRoutes: [GoRoute(path: '/add-account', builder: (_, _) => const AccountSetupScreen())],
  );
  unawaited(router.push('/add-account'));
  await tester.pumpAndSettle();
}

Future<void> _enterAddress(WidgetTester tester, String email) async {
  await tester.enterText(find.byKey(const Key('setup-name')), 'Jane Doe');
  await tester.enterText(find.byKey(const Key('setup-email')), email);
  await tester.tap(find.byKey(const Key('setup-continue')));
  await tester.pumpAndSettle();
}

Future<void> _tapSignIn(WidgetTester tester) async {
  await tester.ensureVisible(find.byKey(const Key('setup-oauth')));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('setup-oauth')));
  await tester.pumpAndSettle();
}

void main() {
  late FakeOAuthAgent agent;
  late FakeMailRepository repo;

  setUp(() {
    agent = FakeOAuthAgent();
    repo = FakeMailRepository(accounts: [testAccount])..onDiscover = (email) async => _discover(email);
  });

  testWidgets('Gmail: "Sign in with Google" adds the account with Gmail’s servers', (tester) async {
    await _open(tester, repo, configuredOAuth(agent));
    await _enterAddress(tester, 'jane@gmail.com');
    expect(find.byKey(const Key('oauth-note')), findsOneWidget);
    expect(find.byKey(const Key('setup-password')), findsNothing);
    expect(find.text('Sign in with Google'), findsOneWidget);
    // Discovery's own note says the same less precisely.
    expect(find.text('Sign in with Google.'), findsNothing);

    await _tapSignIn(tester);
    final request = agent.requests.single;
    expect(request.provider, ProviderKind.gmail);
    expect(request.loginHint, 'jane@gmail.com');
    expect(request.redirectUri, 'io.github.buengenio.loupe:/oauth2redirect');

    final setup = repo.setups.single;
    expect(setup.email, 'jane@gmail.com');
    expect(setup.provider, ProviderKind.gmail);
    expect(setup.senderName, 'Jane Doe');
    expect((setup.credentials as OAuthCredentials).refreshToken, 'refresh');
    expect(
      (setup.incoming.host, setup.incoming.port, setup.incoming.security),
      ('imap.gmail.com', 993, ConnectionSecurity.tls),
    );
    expect(
      (setup.outgoing!.host, setup.outgoing!.port, setup.outgoing!.security),
      ('smtp.gmail.com', 465, ConnectionSecurity.tls),
    );
    expect(find.text('Account Added'), findsOneWidget);
  });

  testWidgets('Gmail keeps the app password as the second way, and back', (tester) async {
    await _open(tester, repo, configuredOAuth(agent));
    await _enterAddress(tester, 'jane@gmail.com');
    await tester.tap(find.byKey(const Key('use-app-password')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('setup-password')), findsOneWidget);
    expect(find.byKey(const Key('setup-oauth')), findsNothing);

    await tester.tap(find.byKey(const Key('use-oauth')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('setup-password')), findsNothing);
    expect(find.byKey(const Key('setup-oauth')), findsOneWidget);
  });

  testWidgets('Microsoft: "Sign in with Microsoft" only, with Office 365 servers', (tester) async {
    await _open(tester, repo, configuredOAuth(agent));
    await _enterAddress(tester, 'jane@outlook.com');
    expect(find.text('Sign in with Microsoft'), findsOneWidget);
    expect(find.byKey(const Key('use-app-password')), findsNothing);
    expect(find.byKey(const Key('setup-password')), findsNothing);
    expect(find.byKey(const Key('microsoft-note')), findsNothing);

    await _tapSignIn(tester);
    expect(agent.requests.single.redirectUri, 'msauth.io.github.buengenio.loupe://auth');
    final setup = repo.setups.single;
    expect(setup.provider, ProviderKind.microsoft);
    expect((setup.incoming.host, setup.incoming.port), ('outlook.office365.com', 993));
    expect(
      (setup.outgoing!.host, setup.outgoing!.port, setup.outgoing!.security),
      ('smtp.office365.com', 587, ConnectionSecurity.startTls),
    );
    // The login is the address itself.
    expect(setup.incoming.username, isNull);
    expect(setup.outgoing!.username, isNull);
    expect(find.text('Account Added'), findsOneWidget);
  });

  testWidgets('cancel, deny and admin consent explain themselves and allow another try', (tester) async {
    await _open(tester, repo, configuredOAuth(agent));
    await _enterAddress(tester, 'jane@contoso-outlook.com');

    agent.errors.add(failed(OAuthFailure.cancelled));
    await _tapSignIn(tester);
    expect(find.textContaining('Sign-in was cancelled'), findsOneWidget);
    expect(repo.setups, isEmpty);

    agent.errors.add(failed(OAuthFailure.denied));
    await _tapSignIn(tester);
    expect(find.textContaining('Loupe needs permission to read and send your mail'), findsOneWidget);

    agent.errors.add(failed(OAuthFailure.adminApproval));
    await _tapSignIn(tester);
    expect(find.textContaining('Your organisation must approve Loupe'), findsOneWidget);
    expect(find.textContaining('admin consent'), findsOneWidget);

    agent.errors.add(failed(OAuthFailure.network));
    await _tapSignIn(tester);
    expect(find.textContaining('Couldn’t reach Microsoft'), findsOneWidget);

    // The next try works.
    await _tapSignIn(tester);
    expect(repo.setups, hasLength(1));
    expect(find.text('Account Added'), findsOneWidget);
  });

  testWidgets('tokens the server refuses (another account picked) say so', (tester) async {
    repo.onAddAccount = (_) async => throw const MailException(MailErrorKind.authentication, 'AUTHENTICATIONFAILED');
    await _open(tester, repo, configuredOAuth(agent));
    await _enterAddress(tester, 'jane@gmail.com');
    await _tapSignIn(tester);
    expect(find.textContaining('Choose the same account'), findsOneWidget);
    expect(find.byKey(const Key('setup-oauth')), findsOneWidget);
  });

  testWidgets('without client ids the notes stay as before', (tester) async {
    await _open(tester, repo, unconfiguredOAuth());
    await _enterAddress(tester, 'jane@gmail.com');
    expect(find.byKey(const Key('setup-oauth')), findsNothing);
    expect(find.textContaining('isn\'t available in this build yet'), findsOneWidget);
    expect(find.byKey(const Key('use-app-password')), findsOneWidget);

    unawaited(Navigator.of(tester.element(find.byKey(const Key('use-app-password')))).maybePop());
    await tester.pumpAndSettle();
    await _enterAddress(tester, 'jane@outlook.com');
    expect(find.byKey(const Key('microsoft-note')), findsOneWidget);
    expect(find.byKey(const Key('setup-oauth')), findsNothing);
    expect(find.byKey(const Key('setup-password')), findsNothing);
  });

  test('server settings for OAuth accounts', () {
    final gmail = oauthServers(ProviderKind.gmail);
    expect(
      [gmail.incoming.protocol, gmail.incoming.host, gmail.incoming.port, gmail.incoming.security],
      [ServerProtocol.imap, 'imap.gmail.com', 993, ConnectionSecurity.tls],
    );
    expect(
      [gmail.outgoing.protocol, gmail.outgoing.host, gmail.outgoing.port, gmail.outgoing.security],
      [ServerProtocol.smtp, 'smtp.gmail.com', 465, ConnectionSecurity.tls],
    );
    final microsoft = oauthServers(ProviderKind.microsoft);
    expect(
      [microsoft.incoming.host, microsoft.incoming.port, microsoft.incoming.security],
      ['outlook.office365.com', 993, ConnectionSecurity.tls],
    );
    expect(
      [microsoft.outgoing.host, microsoft.outgoing.port, microsoft.outgoing.security],
      ['smtp.office365.com', 587, ConnectionSecurity.startTls],
    );
    for (final c in [gmail.incoming, gmail.outgoing, microsoft.incoming, microsoft.outgoing]) {
      expect(c.username, isNull, reason: 'the login is the address');
    }
    expect(() => oauthServers(ProviderKind.icloud), throwsArgumentError);
  });
}
