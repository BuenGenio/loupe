import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/router.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart';

import '../../helpers.dart';
import '../account_setup/fake_oauth.dart';

/// The demo mailbox, with the live repository's sign-in renewal: "work"
/// (Microsoft) needs signing in again.
class RenewingRepository extends DemoMailRepository implements SignInRenewal {
  RenewingRepository() : super(latency: const DemoLatency(), clock: () => testNow);

  Set<String> required = {'work'};
  final _changes = StreamController<Set<String>>.broadcast();
  final renewed = <(String, Credentials)>[];

  /// Thrown by [renewSignIn], like the server refusing tokens of another account.
  MailException? refuse;

  @override
  Stream<Set<String>> watchSignInRequired() async* {
    yield required;
    yield* _changes.stream;
  }

  @override
  Future<void> renewSignIn(String accountId, Credentials credentials) async {
    if (refuse case final e?) throw e;
    renewed.add((accountId, credentials));
    required = {...required}..remove(accountId);
    _changes.add(required);
  }

  @override
  void dispose() {
    unawaited(_changes.close());
    super.dispose();
  }
}

const _banner = ValueKey('sign-in-banner-work');
const _bannerButton = ValueKey('sign-in-again-work');

void main() {
  late RenewingRepository repo;
  late FakeOAuthAgent agent;

  setUp(() {
    repo = RenewingRepository();
    agent = FakeOAuthAgent();
  });

  testWidgets('Mailboxes: a banner for the account, and signing in again clears it', (tester) async {
    await pumpLoupe(tester, repository: repo, overrides: [oauthOverride(configuredOAuth(agent))]);
    expect(find.byKey(_banner), findsOneWidget);
    expect(
      textContaining('Microsoft no longer accepts Loupe’s sign-in for sam.rivera@northwind.example'),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('sign-in-banner-personal')), findsNothing);

    await tester.tap(find.byKey(_bannerButton));
    await tester.pumpAndSettle();
    expect(agent.requests.single.provider, ProviderKind.microsoft);
    expect(agent.requests.single.loginHint, 'sam.rivera@northwind.example');
    final (id, credentials) = repo.renewed.single;
    expect(id, 'work');
    expect((credentials as OAuthCredentials).refreshToken, 'refresh');
    expect(find.byKey(_banner), findsNothing);
    expect(textContaining('Signed in again'), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('a cancelled or refused sign-in keeps the banner', (tester) async {
    await pumpLoupe(tester, repository: repo, overrides: [oauthOverride(configuredOAuth(agent))]);
    agent.errors.add(failed(OAuthFailure.cancelled));
    await tester.tap(find.byKey(_bannerButton));
    await tester.pumpAndSettle();
    expect(find.byKey(_banner), findsOneWidget);
    expect(find.byType(SnackBar), findsNothing);

    // Tokens of another account: the repository's connection check refuses them.
    repo.refuse = const MailException(MailErrorKind.authentication, 'AUTHENTICATIONFAILED');
    await tester.tap(find.byKey(_bannerButton));
    await tester.pumpAndSettle();
    expect(find.byKey(_banner), findsOneWidget);
    expect(textContaining('Choose the same account'), findsOneWidget);
    expect(repo.renewed, isEmpty);
    await drainTimers(tester);
  });

  testWidgets('Settings › account offers Sign In Again', (tester) async {
    await pumpLoupe(tester, repository: repo, overrides: [oauthOverride(configuredOAuth(agent))]);
    await goTo(tester, Routes.accountSettings('work'));
    expect(find.byKey(const Key('account-sign-in-required')), findsOneWidget);
    expect(textContaining('isn’t syncing'), findsOneWidget);
    await tester.tap(find.byKey(const Key('account-sign-in-again')));
    await tester.pumpAndSettle();
    expect(repo.renewed.single.$1, 'work');
    expect(find.byKey(const Key('account-sign-in-required')), findsNothing);
    await tester.scrollTo(find.text('Microsoft'));
    // Still offered, for a sign-in the app hasn't noticed is gone.
    await tester.scrollTo(find.byKey(const Key('account-sign-in-again')));
    await drainTimers(tester);
  });

  testWidgets('without the client id the banner explains but offers no button', (tester) async {
    await pumpLoupe(tester, repository: repo, overrides: [oauthOverride(unconfiguredOAuth())]);
    expect(find.byKey(_banner), findsOneWidget);
    expect(find.byKey(_bannerButton), findsNothing);
    await goTo(tester, Routes.accountSettings('work'));
    await tester.scrollTo(find.text('Expired'));
    expect(find.byKey(const Key('account-sign-in-again')), findsNothing);
  });

  testWidgets('the plain demo mailbox shows no banner', (tester) async {
    await pumpLoupe(tester, overrides: [oauthOverride(configuredOAuth(agent))]);
    expect(find.byKey(_banner), findsNothing);
  });
}
