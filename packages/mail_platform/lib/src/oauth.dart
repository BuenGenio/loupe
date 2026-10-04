/// OAuth 2.0 sign-in for Gmail and Microsoft (authorization code + PKCE in
/// the system browser, via AppAuth).
library;

import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:mail_model/mail_model.dart';

/// Endpoints, scopes and client id of one provider.
final class OAuthProviderConfig {
  const OAuthProviderConfig({
    required this.clientId,
    required this.authorizationEndpoint,
    required this.tokenEndpoint,
    required this.scopes,
    this.additionalParameters = const {},
  });

  final String clientId;
  final String authorizationEndpoint;
  final String tokenEndpoint;
  final List<String> scopes;
  final Map<String, String> additionalParameters;
}

/// Tokens from an authorization or refresh.
typedef OAuthTokens = ({String? accessToken, String? refreshToken, DateTime? expiresAt});

/// Runs the browser flow and token refreshes. The default uses
/// flutter_appauth; tests substitute a fake.
abstract interface class OAuthAgent {
  Future<OAuthTokens> authorize(OAuthProviderConfig config, String redirectUri, {String? loginHint});
  Future<OAuthTokens> refresh(OAuthProviderConfig config, String redirectUri, String refreshToken);
}

/// [OAuthAgent] on flutter_appauth (PKCE is always on).
final class AppAuthAgent implements OAuthAgent {
  AppAuthAgent([FlutterAppAuth? appAuth]) : _appAuth = appAuth ?? const FlutterAppAuth();

  final FlutterAppAuth _appAuth;

  AuthorizationServiceConfiguration _service(OAuthProviderConfig c) =>
      AuthorizationServiceConfiguration(authorizationEndpoint: c.authorizationEndpoint, tokenEndpoint: c.tokenEndpoint);

  @override
  Future<OAuthTokens> authorize(OAuthProviderConfig config, String redirectUri, {String? loginHint}) async {
    final r = await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        config.clientId,
        redirectUri,
        serviceConfiguration: _service(config),
        scopes: config.scopes,
        loginHint: loginHint,
        promptValues: const ['select_account'],
        additionalParameters: config.additionalParameters,
      ),
    );
    return (accessToken: r.accessToken, refreshToken: r.refreshToken, expiresAt: r.accessTokenExpirationDateTime);
  }

  @override
  Future<OAuthTokens> refresh(OAuthProviderConfig config, String redirectUri, String refreshToken) async {
    final r = await _appAuth.token(
      TokenRequest(
        config.clientId,
        redirectUri,
        serviceConfiguration: _service(config),
        refreshToken: refreshToken,
        scopes: config.scopes,
      ),
    );
    return (accessToken: r.accessToken, refreshToken: r.refreshToken, expiresAt: r.accessTokenExpirationDateTime);
  }
}

/// Signs in to Gmail and Microsoft accounts and refreshes their tokens.
///
/// Client ids come from `--dart-define=LOUPE_GOOGLE_CLIENT_ID=…` and
/// `--dart-define=LOUPE_MICROSOFT_CLIENT_ID=…`; a provider without one is not
/// [isConfigured] and the UI should hide it.
final class OAuthSignIn {
  OAuthSignIn({OAuthAgent? agent, String? googleClientId, String? microsoftClientId, DateTime Function()? clock})
    : _agent = agent ?? AppAuthAgent(),
      _googleClientId = googleClientId ?? const String.fromEnvironment('LOUPE_GOOGLE_CLIENT_ID'),
      _microsoftClientId = microsoftClientId ?? const String.fromEnvironment('LOUPE_MICROSOFT_CLIENT_ID'),
      _clock = clock ?? DateTime.now;

  final OAuthAgent _agent;
  final String _googleClientId;
  final String _microsoftClientId;
  final DateTime Function() _clock;

  /// The app's custom URI scheme (Android `appAuthRedirectScheme`, iOS URL type).
  static const redirectScheme = 'io.github.buengenio.loupe';

  /// Registered with Google (Android client, custom URI scheme enabled) and
  /// Microsoft (mobile and desktop platform).
  static const redirectUri = '$redirectScheme:/oauth2redirect';

  /// Whether sign-in with [provider] is available in this build.
  bool isConfigured(ProviderKind provider) => configFor(provider) != null;

  /// Endpoints and scopes for [provider]; null if unsupported or no client id.
  OAuthProviderConfig? configFor(ProviderKind provider) => switch (provider) {
    ProviderKind.gmail when _googleClientId.isNotEmpty => OAuthProviderConfig(
      clientId: _googleClientId,
      authorizationEndpoint: 'https://accounts.google.com/o/oauth2/v2/auth',
      tokenEndpoint: 'https://oauth2.googleapis.com/token',
      scopes: const ['https://mail.google.com/'],
    ),
    ProviderKind.microsoft when _microsoftClientId.isNotEmpty => OAuthProviderConfig(
      clientId: _microsoftClientId,
      authorizationEndpoint: 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize',
      tokenEndpoint: 'https://login.microsoftonline.com/common/oauth2/v2.0/token',
      scopes: const [
        'https://outlook.office.com/IMAP.AccessAsUser.All',
        'https://outlook.office.com/SMTP.Send',
        'offline_access',
        'openid',
        'email',
      ],
    ),
    _ => null,
  };

  OAuthProviderConfig _require(ProviderKind provider) =>
      configFor(provider) ??
      (throw MailException(MailErrorKind.unsupported, 'Sign-in with ${provider.name} isn’t available in this build.'));

  /// Opens the provider's sign-in page. Throws [MailException] with kind
  /// [MailErrorKind.cancelled] when the user backs out.
  Future<OAuthCredentials> signIn(ProviderKind provider, {String? loginHint}) async {
    final config = _require(provider);
    final OAuthTokens tokens;
    try {
      tokens = await _agent.authorize(config, redirectUri, loginHint: loginHint);
    } on FlutterAppAuthUserCancelledException catch (e) {
      throw MailException(MailErrorKind.cancelled, 'Sign-in was cancelled.', e);
    } on PlatformException catch (e) {
      throw MailException(MailErrorKind.authentication, 'Sign-in failed.', e);
    }
    return _credentials(tokens, previousRefreshToken: null);
  }

  /// Exchanges the refresh token for a new access token. Throws
  /// [MailException] (authentication) when the grant was revoked, so the UI
  /// can ask the user to sign in again.
  Future<OAuthCredentials> refresh(ProviderKind provider, OAuthCredentials current) async {
    final config = _require(provider);
    final refreshToken = current.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      throw const MailException(MailErrorKind.authentication, 'The sign-in expired. Please sign in again.');
    }
    final OAuthTokens tokens;
    try {
      tokens = await _agent.refresh(config, redirectUri, refreshToken);
    } on PlatformException catch (e) {
      throw MailException(MailErrorKind.authentication, 'The sign-in expired. Please sign in again.', e);
    }
    return _credentials(tokens, previousRefreshToken: refreshToken);
  }

  OAuthCredentials _credentials(OAuthTokens tokens, {required String? previousRefreshToken}) {
    final access = tokens.accessToken;
    if (access == null || access.isEmpty) {
      throw const MailException(MailErrorKind.authentication, 'The provider returned no access token.');
    }
    return OAuthCredentials(
      accessToken: access,
      // Google omits the refresh token on refresh; Microsoft rotates it.
      refreshToken: tokens.refreshToken ?? previousRefreshToken,
      expiresAt: tokens.expiresAt ?? _clock().add(const Duration(hours: 1)),
    );
  }
}
