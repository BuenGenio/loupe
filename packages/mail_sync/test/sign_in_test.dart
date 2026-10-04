import 'package:clock/clock.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

/// The provider's token endpoint: hands out numbered access tokens, which
/// the [server] then takes, until the grant is [revoked].
final class FakeProvider {
  FakeProvider(this.server);

  final FakeServer server;

  /// Refresh tokens presented, one per token request.
  final requests = <String>[];
  bool revoked = false;

  /// Whether the server takes the tokens issued from now on.
  bool serverTakesNewTokens = true;
  int _issued = 0;

  Future<OAuthCredentials> refresh(MailAccount account, OAuthCredentials current) async {
    requests.add(current.refreshToken!);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    if (revoked) throw const SignInRequiredException('Google no longer accepts this sign-in. Sign in again.');
    final token = 'at${++_issued}';
    if (serverTakesNewTokens) server.accessToken = token;
    return OAuthCredentials(
      accessToken: token,
      refreshToken: current.refreshToken,
      expiresAt: clock.now().add(const Duration(hours: 1)),
    );
  }
}

const _email = 'me@gmail.com';

void main() {
  late Harness h;
  late FakeServer server;
  late FakeProvider provider;

  Harness harness() {
    server = FakeServer(gmail: true)..deliver('INBOX', subject: 'Hi');
    final h = Harness(refreshOAuth: (account, current) => provider.refresh(account, current));
    provider = FakeProvider(server);
    h.factory.serve(_email, server);
    return h;
  }

  Future<MailAccount> add(OAuthCredentials credentials) async {
    final a = await h.repo.addAccount(h.setup(_email, provider: ProviderKind.gmail, credentials: credentials));
    await settle();
    return a;
  }

  OAuthCredentials stored(MailAccount a) => h.credentials.values[a.id]! as OAuthCredentials;
  Future<Set<String>> signInRequired() => h.repo.watchSignInRequired().first;
  DateTime inAnHour() => clock.now().add(const Duration(hours: 1));

  test('an expired access token is refreshed before connecting', () {
    fakeTime((async) async {
      h = harness();
      server.accessToken = 'at1';
      final a = await add(
        OAuthCredentials(accessToken: 'old', refreshToken: 'r1', expiresAt: DateTime(2026, 9, 1, 11)),
      );
      expect(provider.requests, ['r1']);
      // The stale token was never sent to the server.
      expect(server.oauthLogins, isNotEmpty);
      expect(server.oauthLogins, everyElement('at1'));
      expect(stored(a).accessToken, 'at1');
      expect(await h.subjects(a, 'INBOX'), ['Hi']);
      expect(await signInRequired(), isEmpty);
      await h.dispose();
    });
  });

  test('a token the server rejects gets one forced refresh, never a loop', () {
    fakeTime((async) async {
      h = harness();
      server.accessToken = 'at1';
      final a = await add(OAuthCredentials(accessToken: 'stale', refreshToken: 'r1', expiresAt: inAnHour()));
      expect(server.oauthLogins.take(2), ['stale', 'at1']);
      expect(provider.requests, ['r1']);
      expect(stored(a).accessToken, 'at1');

      // The server stops taking anything: one forced refresh, then the error.
      server.accessToken = 'nothing works';
      provider.serverTakesNewTokens = false;
      await server.dropConnections();
      final logins = server.oauthLogins.length;
      await h.repo.refresh();
      expect(provider.requests, hasLength(2));
      expect(server.oauthLogins.length - logins, 2);
      expect((await h.status(a)).phase, SyncPhase.error);
      await h.dispose();
    });
  });

  test('a revoked grant marks the account "Sign in again" and stops asking', () {
    fakeTime((async) async {
      h = harness();
      final a = await add(OAuthCredentials(accessToken: 'at0', refreshToken: 'r1', expiresAt: inAnHour()));
      expect(await signInRequired(), isEmpty);

      // The user removed Loupe's access in their Google account.
      provider.revoked = true;
      server.accessToken = 'revoked';
      await server.dropConnections();
      await h.repo.refresh();
      expect(await signInRequired(), {a.id});
      expect(stored(a).refreshToken, isNull);
      final status = await h.status(a);
      expect(status.phase, SyncPhase.error);
      expect(status.error, contains('Sign in again'));

      // Polls and pull-to-refresh neither ask Google nor try the server.
      final requests = provider.requests.length;
      final logins = server.oauthLogins.length;
      await settle(const Duration(hours: 1));
      await h.repo.refresh();
      expect(provider.requests, hasLength(requests));
      expect(server.oauthLogins, hasLength(logins));
      expect(await signInRequired(), {a.id});

      // Tokens of another account (picked by mistake) are refused; the old
      // state stays.
      await expectLater(
        h.repo.renewSignIn(a.id, OAuthCredentials(accessToken: 'other', refreshToken: 'x', expiresAt: inAnHour())),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.authentication)),
      );
      expect(await signInRequired(), {a.id});
      expect(stored(a).refreshToken, isNull);

      // Signing in again fixes it and syncs at once.
      server
        ..accessToken = 'at-new'
        ..deliver('INBOX', subject: 'While you were away');
      provider.revoked = false;
      await h.repo.renewSignIn(
        a.id,
        OAuthCredentials(accessToken: 'at-new', refreshToken: 'r2', expiresAt: inAnHour()),
      );
      await settle();
      expect(await signInRequired(), isEmpty);
      expect(stored(a).refreshToken, 'r2');
      expect(await h.subjects(a, 'INBOX'), ['While you were away', 'Hi']);
      expect((await h.status(a)).phase, SyncPhase.idle);
      await h.dispose();
    });
  });

  test('the mark is known after a restart, without a request', () {
    fakeTime((async) async {
      h = harness();
      final a = await add(OAuthCredentials(accessToken: 'at0', refreshToken: 'r1', expiresAt: inAnHour()));
      provider.revoked = true;
      server.accessToken = 'revoked';
      await server.dropConnections();
      await h.repo.refresh();
      await h.repo.dispose();

      final requests = provider.requests.length;
      final repo2 = LiveMailRepository(
        h.store,
        h.factory,
        h.credentials,
        config: fastConfig,
        refreshOAuth: provider.refresh,
      );
      await repo2.start();
      expect(await repo2.watchSignInRequired().first, {a.id});
      await settle();
      expect(provider.requests, hasLength(requests));

      await repo2.removeAccount(a.id);
      expect(await repo2.watchSignInRequired().first, isEmpty);
      await repo2.dispose();
      await h.store.close();
    });
  });

  test('a background sync (never started) refreshes and stores tokens', () {
    fakeTime((async) async {
      h = harness();
      final a = await add(OAuthCredentials(accessToken: 'at0', refreshToken: 'r1', expiresAt: inAnHour()));
      expect(provider.requests, isEmpty);
      await h.repo.dispose();
      server.deliver('INBOX', subject: 'Later');
      await settle(const Duration(hours: 2));

      final background = LiveMailRepository(
        h.store,
        h.factory,
        h.credentials,
        config: fastConfig,
        refreshOAuth: provider.refresh,
      );
      await background.syncOnce();
      expect(provider.requests, ['r1']);
      expect(stored(a).accessToken, 'at1');
      expect(await h.subjects(a, 'INBOX'), ['Later', 'Hi']);
      await background.dispose();
      await h.store.close();
    });
  });
}
