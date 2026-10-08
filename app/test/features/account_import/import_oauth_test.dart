import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/account_import/import_controller.dart';
import 'package:loupe/features/account_import/import_mapping.dart';
import 'package:loupe/features/account_import/thunderbird_qr.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart';

import '../account_setup/fake_oauth.dart';
import '../conversation/fake_mail_repository.dart';
import 'account_import_screen_test.dart' show FakeScanner, pumpImport, scan, tapKey;
import 'tb_payloads.dart';

/// What the row says about its failure, in English.
String? errorOf(ImportRow row) =>
    row.failure == null ? null : describeImportFailure(lookupAppLocalizations(const Locale('en')), row);

/// Thunderbird's OAuth (auth 6) accounts at Gmail and Microsoft 365, and a
/// password account.
final _gmail = tbAccount(
  incoming: tbIncoming(host: 'imap.gmail.com', auth: 6, username: 'jane@gmail.com', name: 'jane@gmail.com'),
  smtpHost: 'smtp.gmail.com',
  smtpAuth: 6,
  identities: [
    ['jane@gmail.com', 'Jane'],
  ],
);
final _microsoft = tbAccount(
  incoming: tbIncoming(host: 'outlook.office365.com', auth: 6, username: 'jane@contoso.com', name: 'Work'),
  smtpHost: 'smtp.office365.com',
  smtpPort: 587,
  smtpSecurity: 2,
  smtpAuth: 6,
  identities: [
    ['jane@contoso.com', 'Jane Doe'],
  ],
);
final _password = tbAccount(incoming: tbIncoming(password: 'secret'));

void main() {
  group('mapping', () {
    ImportCandidate candidate(List<Object?> account, Set<ProviderKind> providers) => ImportCandidate.fromThunderbird(
      parseThunderbirdQr(tbPayload(accounts: [account])).accounts.single,
      signInProviders: providers,
    );

    test('OAuth accounts sign in when the build can; otherwise as before', () {
      final ms = candidate(_microsoft, {ProviderKind.microsoft});
      expect(ms.canSignIn, isTrue);
      expect(ms.block, isNull);
      expect(ms.canImport, isTrue);
      final setup = ms.toSetup(
        credentials: OAuthCredentials(accessToken: 'a', refreshToken: 'r', expiresAt: DateTime.utc(2030)),
      );
      expect(setup.credentials, isA<OAuthCredentials>());
      expect(
        (setup.incoming.host, setup.outgoing!.host, setup.outgoing!.port),
        ('outlook.office365.com', 'smtp.office365.com', 587),
      );

      expect(candidate(_microsoft, {ProviderKind.gmail}).block, ImportBlock.microsoftSignIn);
      expect(candidate(_gmail, {}).canSignIn, isFalse);
      expect(candidate(_gmail, {ProviderKind.gmail}).canSignIn, isTrue);
      // Accounts with passwords keep them.
      expect(candidate(_password, {ProviderKind.gmail, ProviderKind.microsoft}).canSignIn, isFalse);
    });
  });

  group('controller', () {
    late FakeMailRepository repo;
    late FakeOAuthAgent agent;
    late AccountImportController controller;

    setUp(() {
      repo = FakeMailRepository(accounts: []);
      agent = FakeOAuthAgent();
      controller = AccountImportController(repository: () async => repo, oauth: configuredOAuth(agent));
    });

    tearDown(() => controller.dispose());

    void review(List<List<Object?>> accounts) => controller
      ..addPayload(tbPayload(accounts: accounts))
      ..review();

    test('signs in each OAuth account in turn while adding', () async {
      review([_gmail, _microsoft, _password]);
      expect(controller.selected, hasLength(3));
      expect(controller.rows.map((r) => (r.signsIn, r.asksPassword)), [(true, false), (true, false), (false, false)]);

      await controller.importSelected();
      expect(
        [for (final r in agent.requests) (r.provider, r.loginHint)],
        [(ProviderKind.gmail, 'jane@gmail.com'), (ProviderKind.microsoft, 'jane@contoso.com')],
      );
      expect(repo.setups.map((s) => s.credentials.runtimeType), [
        OAuthCredentials,
        OAuthCredentials,
        PasswordCredentials,
      ]);
      expect(controller.rows.every((r) => r.status == ImportStatus.added), isTrue);
    });

    test('a cancelled or refused sign-in fails that account only; a retry asks again', () async {
      review([_gmail, _microsoft]);
      agent.errors
        ..add(failed(OAuthFailure.cancelled))
        ..add(failed(OAuthFailure.adminApproval));
      await controller.importSelected();
      expect(repo.setups, isEmpty);
      expect(controller.rows.map((r) => r.status), [ImportStatus.failed, ImportStatus.failed]);
      expect(errorOf(controller.rows[0]), contains('Sign-in was cancelled'));
      expect(errorOf(controller.rows[1]), contains('Your organisation must approve Loupe'));
      // Signing in is not a password: no password field appears.
      expect(controller.rows.any((r) => r.asksPassword), isFalse);

      await controller.importSelected();
      expect(agent.requests, hasLength(4));
      expect(controller.rows.map((r) => r.status), [ImportStatus.added, ImportStatus.added]);
    });

    test('Gmail can still go with an app password', () async {
      review([_gmail]);
      final row = controller.rows.single;
      controller.useAppPassword(row);
      expect((row.signsIn, row.asksPassword), (false, true));
      await controller.importSelected();
      expect(errorOf(row), contains('app password'));
      row.password.text = 'abcd efgh';
      await controller.importSelected();
      expect(agent.requests, isEmpty);
      expect((repo.setups.single.credentials as PasswordCredentials).password, 'abcd efgh');
    });

    test('without client ids nothing signs in', () {
      final plain = AccountImportController(repository: () async => repo, oauth: unconfiguredOAuth())
        ..addPayload(tbPayload(accounts: [_gmail, _microsoft]))
        ..review();
      addTearDown(plain.dispose);
      expect(plain.rows.map((r) => (r.signsIn, r.candidate.canImport, r.asksPassword)), [
        (false, true, true),
        (false, false, false),
      ]);
    });
  });

  testWidgets('the review says each OAuth account signs in, and adding does', (tester) async {
    final repo = FakeMailRepository(accounts: []);
    final agent = FakeOAuthAgent();
    final scanner = FakeScanner();
    await pumpImport(tester, repo, scanner, overrides: [oauthOverride(configuredOAuth(agent))]);
    await scan(tester, scanner, tbPayload(accounts: [_gmail, _microsoft]));
    expect(find.text('Found 2 Accounts'), findsOneWidget);
    expect(find.textContaining('You’ll sign in with Google'), findsOneWidget);
    expect(find.textContaining('You’ll sign in with Microsoft'), findsOneWidget);
    expect(find.byKey(const ValueKey('import-app-password-0')), findsOneWidget);
    expect(find.byKey(const ValueKey('import-app-password-1')), findsNothing);
    expect(find.byKey(const ValueKey('import-password-0')), findsNothing);
    expect(find.text('Add 2 Accounts'), findsOneWidget);

    await tapKey(tester, 'import-add');
    expect(agent.requests, hasLength(2));
    expect(repo.setups.map((s) => s.email), ['jane@gmail.com', 'jane@contoso.com']);
    expect(find.text('Added'), findsNWidgets(2));
  });

  testWidgets('choosing an app password for Gmail shows the password field', (tester) async {
    final repo = FakeMailRepository(accounts: []);
    final scanner = FakeScanner();
    await pumpImport(tester, repo, scanner, overrides: [oauthOverride(configuredOAuth(FakeOAuthAgent()))]);
    await scan(tester, scanner, tbPayload(accounts: [_gmail]));
    await tapKey(tester, 'import-app-password-0');
    expect(find.byKey(const ValueKey('import-password-0')), findsOneWidget);
    expect(find.textContaining('You’ll sign in with Google'), findsNothing);
    expect(find.textContaining('arrives in a later build'), findsNothing);
  });
}
