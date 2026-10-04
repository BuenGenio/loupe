import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart';

final class MemorySecretStorage implements SecretStorage {
  final values = <String, String>{};

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async => values[key] = value;

  @override
  Future<void> delete(String key) async => values.remove(key);
}

final class FakeAgent implements OAuthAgent {
  final authorizations = <(OAuthProviderConfig, String?)>[];
  OAuthTokens next = (accessToken: 'access-1', refreshToken: 'refresh-1', expiresAt: DateTime.utc(2030), scopes: null);
  Object? error;

  @override
  Future<OAuthTokens> authorize(OAuthProviderConfig config, {String? loginHint}) async {
    authorizations.add((config, loginHint));
    if (error case final e?) throw e;
    return next;
  }
}

/// Fails the test if the browser flow (the plugin) is used.
final class NoBrowserAgent implements OAuthAgent {
  @override
  Future<OAuthTokens> authorize(OAuthProviderConfig config, {String? loginHint}) =>
      throw StateError('flutter_appauth must not be used here');
}

/// A token endpoint: records the form posts and answers with [respond].
final class FakeTokenEndpoint {
  final requests = <Map<String, String>>[];
  final urls = <Uri>[];
  http.Response Function(Map<String, String> form) respond = (form) => ok();
  Duration delay = const Duration(milliseconds: 10);

  static http.Response ok({String access = 'new', String? refresh = 'r2', int expiresIn = 3600, String? scope}) =>
      http.Response(
        jsonEncode({
          'access_token': access,
          'refresh_token': ?refresh,
          'expires_in': expiresIn,
          'scope': ?scope,
          'token_type': 'Bearer',
        }),
        200,
        headers: {'content-type': 'application/json'},
      );

  static http.Response error(int status, String error, [String description = '']) => http.Response(
    jsonEncode({'error': error, 'error_description': description}),
    status,
    headers: {'content-type': 'application/json'},
  );

  late final client = MockClient((request) async {
    urls.add(request.url);
    final form = Uri.splitQueryString(request.body);
    requests.add(form);
    await Future<void>.delayed(delay);
    return respond(form);
  });
}

FlutterAppAuthPlatformException appAuthError({
  String? error,
  String? description,
  String? type,
  String? code,
  String? domain,
}) => FlutterAppAuthPlatformException(
  code: 'authorize_and_exchange_code_failed',
  message: 'Failed to authorize: [error: $error, description: $description]',
  platformErrorDetails: FlutterAppAuthPlatformErrorDetails(
    error: error,
    errorDescription: description,
    type: type,
    code: code,
    domain: domain,
  ),
);

Matcher failsWith(OAuthFailure failure) =>
    throwsA(isA<OAuthSignInException>().having((e) => e.failure, 'failure', failure));

final Matcher signInRequired = throwsA(isA<SignInRequiredException>());

Matcher mailError(MailErrorKind kind) =>
    throwsA(allOf(isA<MailException>().having((e) => e.kind, 'kind', kind), isNot(isA<SignInRequiredException>())));

void main() {
  final now = DateTime.utc(2026, 10, 4, 12);

  group('SecureCredentialStore', () {
    test('round-trips password and OAuth credentials per account', () async {
      final storage = MemorySecretStorage();
      final store = SecureCredentialStore(storage);
      await store.write('a', const PasswordCredentials('pä"ss'));
      await store.write('b', OAuthCredentials(accessToken: 'at', refreshToken: null, expiresAt: now));
      expect(storage.values.keys, {'loupe.credentials.a', 'loupe.credentials.b'});

      final a = await store.read('a');
      expect((a! as PasswordCredentials).password, 'pä"ss');
      final b = (await store.read('b'))! as OAuthCredentials;
      expect(b.accessToken, 'at');
      expect(b.refreshToken, isNull);
      expect(b.expiresAt, now);

      await store.delete('a');
      expect(await store.read('a'), isNull);
      expect(await store.read('missing'), isNull);
    });

    test('ignores corrupt entries', () async {
      final storage = MemorySecretStorage()..values['loupe.credentials.x'] = '{"type":"magic"}';
      expect(await SecureCredentialStore(storage).read('x'), isNull);
      storage.values['loupe.credentials.x'] = 'not json';
      expect(await SecureCredentialStore(storage).read('x'), isNull);
    });
  });

  group('OAuthSignIn', () {
    test('providers without a client id are not configured', () {
      final none = OAuthSignIn(agent: FakeAgent(), googleClientId: '', microsoftClientId: ' ');
      expect(none.isConfigured(ProviderKind.gmail), isFalse);
      expect(none.isConfigured(ProviderKind.microsoft), isFalse);
      final both = OAuthSignIn(agent: FakeAgent(), googleClientId: 'g', microsoftClientId: 'm');
      expect(both.isConfigured(ProviderKind.gmail), isTrue);
      expect(both.isConfigured(ProviderKind.microsoft), isTrue);
      expect(both.isConfigured(ProviderKind.icloud), isFalse);
      expect(none.signIn(ProviderKind.gmail), failsWith(OAuthFailure.misconfigured));
    });

    test('Google and Microsoft scopes, endpoints and redirects', () async {
      final agent = FakeAgent();
      final oauth = OAuthSignIn(agent: agent, googleClientId: 'g-id', microsoftClientId: 'm-id');
      final creds = await oauth.signIn(ProviderKind.gmail, loginHint: 'me@gmail.com');
      expect(creds.accessToken, 'access-1');
      expect(creds.refreshToken, 'refresh-1');
      final (google, hint) = agent.authorizations.single;
      expect(google.clientId, 'g-id');
      expect(google.scopes, ['https://mail.google.com/']);
      expect(google.redirectUri, 'io.github.buengenio.loupe:/oauth2redirect');
      expect(google.scopesOnRefresh, isFalse);
      expect(hint, 'me@gmail.com');

      await oauth.signIn(ProviderKind.microsoft, loginHint: 'me@contoso.com');
      final microsoft = agent.authorizations.last.$1;
      expect(microsoft.clientId, 'm-id');
      expect(microsoft.authorizationEndpoint, 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize');
      expect(microsoft.tokenEndpoint, 'https://login.microsoftonline.com/common/oauth2/v2.0/token');
      expect(microsoft.redirectUri, 'msauth.io.github.buengenio.loupe://auth');
      expect(microsoft.scopes, [
        'https://outlook.office.com/IMAP.AccessAsUser.All',
        'https://outlook.office.com/SMTP.Send',
        'offline_access',
        'openid',
        'email',
      ]);
      expect(microsoft.scopesOnRefresh, isTrue);
    });

    test('browser errors are classified', () async {
      final agent = FakeAgent();
      final oauth = OAuthSignIn(agent: agent, googleClientId: 'g', microsoftClientId: 'm');
      Future<OAuthCredentials> attempt(Object error, [ProviderKind provider = ProviderKind.microsoft]) {
        agent.error = error;
        return oauth.signIn(provider);
      }

      await expectLater(
        attempt(
          FlutterAppAuthUserCancelledException(
            code: 'x',
            message: 'no',
            platformErrorDetails: FlutterAppAuthPlatformErrorDetails(),
          ),
        ),
        throwsA(
          isA<OAuthSignInException>()
              .having((e) => e.failure, 'failure', OAuthFailure.cancelled)
              .having((e) => e.kind, 'kind', MailErrorKind.cancelled),
        ),
      );
      await expectLater(
        attempt(appAuthError(error: 'access_denied', description: 'The user denied access'), ProviderKind.gmail),
        failsWith(OAuthFailure.denied),
      );
      await expectLater(
        attempt(appAuthError(error: 'access_denied', description: 'AADSTS65004: User declined to consent.')),
        failsWith(OAuthFailure.denied),
      );
      await expectLater(
        attempt(
          appAuthError(
            error: 'access_denied',
            description: 'AADSTS65001: The user or administrator has not consented to use the application.',
          ),
        ),
        failsWith(OAuthFailure.adminApproval),
      );
      await expectLater(
        attempt(
          appAuthError(error: 'invalid_request', description: 'AADSTS90094: The grant requires admin permission.'),
        ),
        failsWith(OAuthFailure.adminApproval),
      );
      await expectLater(
        attempt(appAuthError(error: 'access_denied', description: 'AADSTS53003: Access has been blocked by CA.')),
        failsWith(OAuthFailure.blockedByPolicy),
      );
      await expectLater(
        attempt(appAuthError(type: '0', code: '3', description: 'Network error')),
        throwsA(
          isA<OAuthSignInException>()
              .having((e) => e.failure, 'failure', OAuthFailure.network)
              .having((e) => e.kind, 'kind', MailErrorKind.connection),
        ),
      );
      await expectLater(
        attempt(appAuthError(domain: 'org.openid.appauth.general', code: '-5')),
        failsWith(OAuthFailure.network),
      );
      await expectLater(
        attempt(appAuthError(error: 'invalid_client', description: 'AADSTS700016: Application not found')),
        failsWith(OAuthFailure.misconfigured),
      );
      await expectLater(
        attempt(PlatformException(code: 'no_browser_available')),
        failsWith(OAuthFailure.misconfigured),
      );
      await expectLater(attempt(PlatformException(code: 'odd')), failsWith(OAuthFailure.other));
    });

    test('a Google grant without Gmail access counts as denied', () async {
      final agent = FakeAgent()
        ..next = (
          accessToken: 'a',
          refreshToken: 'r',
          expiresAt: null,
          scopes: ['openid', 'https://www.googleapis.com/auth/userinfo.email'],
        );
      final oauth = OAuthSignIn(agent: agent, googleClientId: 'g');
      await expectLater(oauth.signIn(ProviderKind.gmail), failsWith(OAuthFailure.denied));
      agent.next = (accessToken: 'a', refreshToken: 'r', expiresAt: null, scopes: ['https://mail.google.com/']);
      expect((await oauth.signIn(ProviderKind.gmail)).accessToken, 'a');
    });
  });

  group('token refresh over HTTPS', () {
    late FakeTokenEndpoint endpoint;
    late OAuthSignIn oauth;

    setUp(() {
      endpoint = FakeTokenEndpoint();
      oauth = OAuthSignIn(
        // Refreshes never open the browser: the plugin isn't needed in
        // background isolates.
        agent: NoBrowserAgent(),
        tokens: TokenEndpointClient(client: endpoint.client, clock: () => now),
        googleClientId: 'g-id',
        microsoftClientId: 'm-id',
        clock: () => now,
      );
    });

    OAuthCredentials current([String? refresh = 'r1']) =>
        OAuthCredentials(accessToken: 'old', refreshToken: refresh, expiresAt: now);

    test('Google: form post without secret or scope, keeps the refresh token', () async {
      endpoint.respond = (_) => FakeTokenEndpoint.ok(refresh: null, expiresIn: 3599);
      final fresh = await oauth.refresh(ProviderKind.gmail, current());
      expect(endpoint.urls.single, Uri.parse('https://oauth2.googleapis.com/token'));
      expect(endpoint.requests.single, {'grant_type': 'refresh_token', 'refresh_token': 'r1', 'client_id': 'g-id'});
      expect(fresh.accessToken, 'new');
      expect(fresh.refreshToken, 'r1');
      expect(fresh.expiresAt, now.add(const Duration(seconds: 3599)));
    });

    test('Microsoft: sends the scopes and takes the rotated refresh token', () async {
      final fresh = await oauth.refresh(ProviderKind.microsoft, current());
      expect(endpoint.urls.single.path, '/common/oauth2/v2.0/token');
      expect(endpoint.requests.single['client_id'], 'm-id');
      expect(
        endpoint.requests.single['scope'],
        'https://outlook.office.com/IMAP.AccessAsUser.All https://outlook.office.com/SMTP.Send offline_access openid email',
      );
      expect(fresh.refreshToken, 'r2');
    });

    test('a revoked or expired grant needs a new sign-in', () async {
      endpoint.respond = (_) => FakeTokenEndpoint.error(400, 'invalid_grant', 'Token has been expired or revoked.');
      await expectLater(oauth.refresh(ProviderKind.gmail, current()), signInRequired);
      endpoint.respond = (_) =>
          FakeTokenEndpoint.error(400, 'interaction_required', 'AADSTS50076: you must use multi-factor authentication');
      await expectLater(oauth.refresh(ProviderKind.microsoft, current()), signInRequired);
      endpoint.respond = (_) => FakeTokenEndpoint.error(401, 'unauthorized_client', 'Unauthorized');
      await expectLater(oauth.refresh(ProviderKind.gmail, current()), signInRequired);
      // Without a refresh token nothing is asked.
      final asked = endpoint.requests.length;
      await expectLater(oauth.refresh(ProviderKind.gmail, current(null)), signInRequired);
      expect(endpoint.requests, hasLength(asked));
    });

    test('outages and network failures are worth retrying', () async {
      endpoint.respond = (_) => FakeTokenEndpoint.error(503, 'temporarily_unavailable');
      await expectLater(oauth.refresh(ProviderKind.gmail, current()), mailError(MailErrorKind.connection));
      endpoint.respond = (_) => http.Response('<html>Too many requests</html>', 429);
      await expectLater(oauth.refresh(ProviderKind.gmail, current()), mailError(MailErrorKind.connection));
      endpoint.respond = (_) => throw http.ClientException('Failed host lookup');
      await expectLater(oauth.refresh(ProviderKind.gmail, current()), mailError(MailErrorKind.connection));
      endpoint.respond = (_) => FakeTokenEndpoint.error(400, 'invalid_request', 'Missing parameter');
      await expectLater(oauth.refresh(ProviderKind.gmail, current()), mailError(MailErrorKind.server));
      endpoint.respond = (_) => http.Response('{}', 200);
      await expectLater(oauth.refresh(ProviderKind.gmail, current()), mailError(MailErrorKind.server));
    });

    test('a slow token endpoint times out', () async {
      final slow = FakeTokenEndpoint()..delay = const Duration(seconds: 5);
      final client = TokenEndpointClient(client: slow.client, timeout: const Duration(milliseconds: 50));
      await expectLater(
        client.refresh(oauth.configFor(ProviderKind.gmail)!, 'r1'),
        mailError(MailErrorKind.connection),
      );
    });

    test('a build without the client id can’t refresh, but doesn’t give the grant up', () async {
      final unconfigured = OAuthSignIn(
        agent: NoBrowserAgent(),
        tokens: TokenEndpointClient(client: endpoint.client),
      );
      await expectLater(unconfigured.refresh(ProviderKind.microsoft, current()), mailError(MailErrorKind.unsupported));
      expect(endpoint.requests, isEmpty);
    });
  });

  group('credentialsCallbackFor', () {
    late MemorySecretStorage storage;
    late SecureCredentialStore store;
    late FakeTokenEndpoint endpoint;
    late CredentialsService service;

    setUp(() {
      storage = MemorySecretStorage();
      store = SecureCredentialStore(storage);
      endpoint = FakeTokenEndpoint();
      service = CredentialsService(
        store: store,
        oauth: OAuthSignIn(
          agent: NoBrowserAgent(),
          tokens: TokenEndpointClient(client: endpoint.client, clock: () => now),
          googleClientId: 'g',
          clock: () => now,
        ),
        clock: () => now,
      );
    });

    test('passwords pass through', () async {
      await store.write('p', const PasswordCredentials('secret'));
      final c = await service.credentialsCallbackFor('p', ProviderKind.generic)(forceRefresh: true);
      expect((c as PasswordCredentials).password, 'secret');
      expect(endpoint.requests, isEmpty);
    });

    test('valid tokens are used as is; expired or forced ones are refreshed and saved', () async {
      await store.write(
        'g',
        OAuthCredentials(accessToken: 'old', refreshToken: 'r1', expiresAt: now.add(const Duration(hours: 1))),
      );
      final callback = service.credentialsCallbackFor('g', ProviderKind.gmail);
      expect(((await callback()) as OAuthCredentials).accessToken, 'old');
      expect(endpoint.requests, isEmpty);

      final forced = (await callback(forceRefresh: true)) as OAuthCredentials;
      expect(forced.accessToken, 'new');
      expect(endpoint.requests.map((r) => r['refresh_token']), ['r1']);
      expect(((await store.read('g'))! as OAuthCredentials).refreshToken, 'r2');

      await store.write(
        'g',
        OAuthCredentials(accessToken: 'stale', refreshToken: 'r2', expiresAt: now.add(const Duration(seconds: 30))),
      );
      expect(((await callback()) as OAuthCredentials).accessToken, 'new');
      expect(endpoint.requests.map((r) => r['refresh_token']), ['r1', 'r2']);
    });

    test('concurrent refreshes share one request', () async {
      await store.write('g', OAuthCredentials(accessToken: 'old', refreshToken: 'r1', expiresAt: now));
      final callback = service.credentialsCallbackFor('g', ProviderKind.gmail);
      final results = await Future.wait([callback(), callback(), callback(forceRefresh: true)]);
      expect(results.map((c) => (c as OAuthCredentials).accessToken), ['new', 'new', 'new']);
      expect(endpoint.requests, hasLength(1));
    });

    test('a revoked grant is forgotten: later calls fail without asking again', () async {
      await store.write('g', OAuthCredentials(accessToken: 'old', refreshToken: 'r1', expiresAt: now));
      endpoint.respond = (_) => FakeTokenEndpoint.error(400, 'invalid_grant');
      final callback = service.credentialsCallbackFor('g', ProviderKind.gmail);
      await expectLater(callback(), signInRequired);
      final stored = (await store.read('g'))! as OAuthCredentials;
      expect(stored.refreshToken, isNull);
      expect(needsSignIn(stored, now), isTrue);
      await expectLater(callback(), signInRequired);
      await expectLater(callback(forceRefresh: true), signInRequired);
      expect(endpoint.requests, hasLength(1));
    });

    test('an outage keeps the refresh token for the next try', () async {
      await store.write('g', OAuthCredentials(accessToken: 'old', refreshToken: 'r1', expiresAt: now));
      endpoint.respond = (_) => FakeTokenEndpoint.error(500, 'server_error');
      final callback = service.credentialsCallbackFor('g', ProviderKind.gmail);
      await expectLater(callback(), mailError(MailErrorKind.connection));
      expect(((await store.read('g'))! as OAuthCredentials).refreshToken, 'r1');
      endpoint.respond = (_) => FakeTokenEndpoint.ok();
      expect(((await callback()) as OAuthCredentials).accessToken, 'new');
    });

    test('missing credentials are an authentication error', () async {
      await expectLater(
        service.credentialsCallbackFor('nobody', ProviderKind.generic)(),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.authentication)),
      );
    });
  });

  test('needsSignIn: only expired OAuth tokens without a refresh token', () {
    final later = now.add(const Duration(hours: 1));
    expect(needsSignIn(null, now), isFalse);
    expect(needsSignIn(const PasswordCredentials('x'), now), isFalse);
    expect(needsSignIn(OAuthCredentials(accessToken: 'a', refreshToken: 'r', expiresAt: now), now), isFalse);
    expect(needsSignIn(OAuthCredentials(accessToken: 'a', refreshToken: null, expiresAt: later), now), isFalse);
    expect(needsSignIn(OAuthCredentials(accessToken: 'a', refreshToken: null, expiresAt: now), now), isTrue);
    final dropped = withoutSignIn(OAuthCredentials(accessToken: 'a', refreshToken: 'r', expiresAt: later), now);
    expect((dropped.accessToken, dropped.refreshToken, dropped.expiresAt), ('a', null, now));
  });
}
