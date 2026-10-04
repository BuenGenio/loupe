import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_test/flutter_test.dart';
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
  final authorizations = <(OAuthProviderConfig, String, String?)>[];
  final refreshes = <String>[];
  OAuthTokens next = (accessToken: 'access-1', refreshToken: 'refresh-1', expiresAt: DateTime.utc(2030));
  Object? error;

  @override
  Future<OAuthTokens> authorize(OAuthProviderConfig config, String redirectUri, {String? loginHint}) async {
    authorizations.add((config, redirectUri, loginHint));
    if (error case final e?) throw e;
    return next;
  }

  @override
  Future<OAuthTokens> refresh(OAuthProviderConfig config, String redirectUri, String refreshToken) async {
    refreshes.add(refreshToken);
    await Future<void>.delayed(const Duration(milliseconds: 10));
    if (error case final e?) throw e;
    return next;
  }
}

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
      final none = OAuthSignIn(agent: FakeAgent(), googleClientId: '', microsoftClientId: '');
      expect(none.isConfigured(ProviderKind.gmail), isFalse);
      expect(none.isConfigured(ProviderKind.microsoft), isFalse);
      final both = OAuthSignIn(agent: FakeAgent(), googleClientId: 'g', microsoftClientId: 'm');
      expect(both.isConfigured(ProviderKind.gmail), isTrue);
      expect(both.isConfigured(ProviderKind.microsoft), isTrue);
      expect(both.isConfigured(ProviderKind.icloud), isFalse);
      expect(() => none.signIn(ProviderKind.gmail), throwsA(isA<MailException>()));
    });

    test('Google and Microsoft scopes, endpoints and redirect', () async {
      final agent = FakeAgent();
      final oauth = OAuthSignIn(agent: agent, googleClientId: 'g-id', microsoftClientId: 'm-id');
      final creds = await oauth.signIn(ProviderKind.gmail, loginHint: 'me@gmail.com');
      expect(creds.accessToken, 'access-1');
      expect(creds.refreshToken, 'refresh-1');
      final (google, redirect, hint) = agent.authorizations.single;
      expect(google.clientId, 'g-id');
      expect(google.scopes, ['https://mail.google.com/']);
      expect(redirect, 'io.github.buengenio.loupe:/oauth2redirect');
      expect(hint, 'me@gmail.com');

      await oauth.signIn(ProviderKind.microsoft);
      final microsoft = agent.authorizations.last.$1;
      expect(microsoft.authorizationEndpoint, contains('/common/'));
      expect(microsoft.scopes, [
        'https://outlook.office.com/IMAP.AccessAsUser.All',
        'https://outlook.office.com/SMTP.Send',
        'offline_access',
        'openid',
        'email',
      ]);
    });

    test('cancel and failures become MailExceptions', () async {
      final agent = FakeAgent()
        ..error = FlutterAppAuthUserCancelledException(
          code: 'x',
          message: 'no',
          platformErrorDetails: FlutterAppAuthPlatformErrorDetails(),
        );
      final oauth = OAuthSignIn(agent: agent, googleClientId: 'g');
      await expectLater(
        oauth.signIn(ProviderKind.gmail),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.cancelled)),
      );
      agent.error = PlatformException(code: 'token_failed');
      await expectLater(
        oauth.refresh(ProviderKind.gmail, OAuthCredentials(accessToken: 'a', refreshToken: 'r', expiresAt: now)),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.authentication)),
      );
    });

    test('refresh keeps the old refresh token when none is returned', () async {
      final agent = FakeAgent()..next = (accessToken: 'access-2', refreshToken: null, expiresAt: null);
      final oauth = OAuthSignIn(agent: agent, googleClientId: 'g', clock: () => now);
      final fresh = await oauth.refresh(
        ProviderKind.gmail,
        OAuthCredentials(accessToken: 'old', refreshToken: 'keep', expiresAt: now),
      );
      expect(fresh.accessToken, 'access-2');
      expect(fresh.refreshToken, 'keep');
      expect(fresh.expiresAt, now.add(const Duration(hours: 1)));
    });
  });

  group('credentialsCallbackFor', () {
    late MemorySecretStorage storage;
    late SecureCredentialStore store;
    late FakeAgent agent;
    late CredentialsService service;

    setUp(() {
      storage = MemorySecretStorage();
      store = SecureCredentialStore(storage);
      agent = FakeAgent()
        ..next = (accessToken: 'new', refreshToken: 'r2', expiresAt: now.add(const Duration(hours: 1)));
      service = CredentialsService(
        store: store,
        oauth: OAuthSignIn(agent: agent, googleClientId: 'g', clock: () => now),
        clock: () => now,
      );
    });

    test('passwords pass through', () async {
      await store.write('p', const PasswordCredentials('secret'));
      final c = await service.credentialsCallbackFor('p', ProviderKind.generic)(forceRefresh: true);
      expect((c as PasswordCredentials).password, 'secret');
      expect(agent.refreshes, isEmpty);
    });

    test('valid tokens are used as is; expired or forced ones are refreshed and saved', () async {
      await store.write(
        'g',
        OAuthCredentials(accessToken: 'old', refreshToken: 'r1', expiresAt: now.add(const Duration(hours: 1))),
      );
      final callback = service.credentialsCallbackFor('g', ProviderKind.gmail);
      expect(((await callback()) as OAuthCredentials).accessToken, 'old');
      expect(agent.refreshes, isEmpty);

      final forced = (await callback(forceRefresh: true)) as OAuthCredentials;
      expect(forced.accessToken, 'new');
      expect(agent.refreshes, ['r1']);
      expect(((await store.read('g'))! as OAuthCredentials).refreshToken, 'r2');

      await store.write(
        'g',
        OAuthCredentials(accessToken: 'stale', refreshToken: 'r2', expiresAt: now.add(const Duration(seconds: 30))),
      );
      expect(((await callback()) as OAuthCredentials).accessToken, 'new');
      expect(agent.refreshes, ['r1', 'r2']);
    });

    test('concurrent refreshes share one request', () async {
      await store.write('g', OAuthCredentials(accessToken: 'old', refreshToken: 'r1', expiresAt: now));
      final callback = service.credentialsCallbackFor('g', ProviderKind.gmail);
      final results = await Future.wait([callback(), callback(), callback(forceRefresh: true)]);
      expect(results.map((c) => (c as OAuthCredentials).accessToken), ['new', 'new', 'new']);
      expect(agent.refreshes, ['r1']);
    });

    test('missing credentials are an authentication error', () async {
      await expectLater(
        service.credentialsCallbackFor('nobody', ProviderKind.generic)(),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.authentication)),
      );
    });
  });
}
