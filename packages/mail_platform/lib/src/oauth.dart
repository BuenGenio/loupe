/// OAuth 2.0 sign-in for Gmail and Microsoft: authorization code + PKCE in
/// the system browser (AppAuth), refreshes with a plain HTTPS POST.
library;

import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:mail_model/mail_model.dart';

import 'token_endpoint.dart';

/// Endpoints, scopes, client id and redirect URI of one provider.
final class OAuthProviderConfig {
  const OAuthProviderConfig({
    required this.provider,
    required this.clientId,
    required this.redirectUri,
    required this.authorizationEndpoint,
    required this.tokenEndpoint,
    required this.scopes,
    this.scopesOnRefresh = false,
    this.additionalParameters = const {},
  });

  final ProviderKind provider;
  final String clientId;
  final String redirectUri;
  final String authorizationEndpoint;
  final String tokenEndpoint;
  final List<String> scopes;

  /// Send [scopes] with refresh requests (Microsoft asks for them; Google
  /// doesn't take them).
  final bool scopesOnRefresh;
  final Map<String, String> additionalParameters;
}

/// Tokens from an authorization or refresh. [scopes] are the granted ones,
/// when the provider says.
typedef OAuthTokens = ({String? accessToken, String? refreshToken, DateTime? expiresAt, List<String>? scopes});

/// Runs the browser flow. The default uses flutter_appauth; tests
/// substitute a fake.
abstract interface class OAuthAgent {
  Future<OAuthTokens> authorize(OAuthProviderConfig config, {String? loginHint});
}

/// [OAuthAgent] on flutter_appauth (PKCE is always on). Only for sign-in,
/// which needs an activity and a browser; refreshes go through
/// [TokenEndpointClient] instead, which also works in background isolates.
final class AppAuthAgent implements OAuthAgent {
  AppAuthAgent([FlutterAppAuth? appAuth]) : _appAuth = appAuth ?? const FlutterAppAuth();

  final FlutterAppAuth _appAuth;

  @override
  Future<OAuthTokens> authorize(OAuthProviderConfig config, {String? loginHint}) async {
    final r = await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        config.clientId,
        config.redirectUri,
        serviceConfiguration: AuthorizationServiceConfiguration(
          authorizationEndpoint: config.authorizationEndpoint,
          tokenEndpoint: config.tokenEndpoint,
        ),
        scopes: config.scopes,
        loginHint: loginHint,
        promptValues: const ['select_account'],
        additionalParameters: config.additionalParameters,
      ),
    );
    return (
      accessToken: r.accessToken,
      refreshToken: r.refreshToken,
      expiresAt: r.accessTokenExpirationDateTime,
      scopes: r.scopes,
    );
  }
}

/// Why a browser sign-in didn't give tokens.
enum OAuthFailure {
  /// The user closed the browser or went back.
  cancelled,

  /// The user declined the permissions (or unticked Gmail access).
  denied,

  /// The organisation must approve Loupe first (Microsoft work and school
  /// accounts: admin consent, user assignment, app disabled).
  adminApproval,

  /// The organisation's Conditional Access rules block the sign-in.
  blockedByPolicy,

  /// No network, or the provider couldn't be reached.
  network,

  /// The build's client registration doesn't match (wrong client id or
  /// redirect URI, missing platform), or no browser is available.
  misconfigured,

  /// Anything else.
  other,
}

/// A failed browser sign-in, with the [failure] the UI words.
final class OAuthSignInException extends MailException {
  OAuthSignInException(this.failure, String message, [Object? cause]) : super(_kindOf(failure), message, cause);

  final OAuthFailure failure;

  static MailErrorKind _kindOf(OAuthFailure f) => switch (f) {
    OAuthFailure.cancelled => MailErrorKind.cancelled,
    OAuthFailure.network => MailErrorKind.connection,
    OAuthFailure.misconfigured => MailErrorKind.unsupported,
    _ => MailErrorKind.authentication,
  };

  @override
  String toString() => 'OAuthSignInException(${failure.name}): $message';
}

/// Microsoft Entra error codes (AADSTS…) in an error description that mean
/// the organisation has to act: consent by an admin (65001, 90094, 90095,
/// 900941), assignment of users to the app (50105), or the app being
/// disabled in the tenant (7000112).
final _adminApprovalCodes = RegExp(r'AADSTS(65001|90094|90095|900941|50105|7000112)\b');

/// Conditional Access blocks (compliant or joined device needed, policy).
final _policyCodes = RegExp(r'AADSTS(53000|53001|53002|53003|53004|530003|530035)\b');

/// The user declined consent (Microsoft).
final _declinedCodes = RegExp(r'AADSTS65004\b');

/// Classifies a flutter_appauth error from [OAuthAgent.authorize].
OAuthFailure classifyOAuthError(Object error) {
  if (error is FlutterAppAuthUserCancelledException) return OAuthFailure.cancelled;
  final FlutterAppAuthPlatformErrorDetails? details = switch (error) {
    FlutterAppAuthPlatformException(:final platformErrorDetails) => platformErrorDetails,
    _ => null,
  };
  final code = error is PlatformException ? error.code : '';
  final err = details?.error ?? '';
  final text = [
    details?.errorDescription,
    details?.errorDebugDescription,
    if (error is PlatformException) error.message,
  ].whereType<String>().join(' ');
  if (_adminApprovalCodes.hasMatch(text)) return OAuthFailure.adminApproval;
  if (_policyCodes.hasMatch(text)) return OAuthFailure.blockedByPolicy;
  if (_declinedCodes.hasMatch(text) || err == 'access_denied' || err == 'consent_required') return OAuthFailure.denied;
  // AppAuth's own codes: Android GeneralErrors.NETWORK_ERROR (type 0, code 3),
  // iOS OIDErrorCodeNetworkError (-5) in the general domain.
  final type = details?.type;
  final platformCode = details?.code;
  if ((type == '0' && platformCode == '3') ||
      (details?.domain == 'org.openid.appauth.general' && platformCode == '-5') ||
      RegExp('network|offline|unable to resolve host|timed out', caseSensitive: false).hasMatch(text)) {
    return OAuthFailure.network;
  }
  if (type == '0' && platformCode == '1') return OAuthFailure.cancelled;
  if (code == 'no_browser_available' ||
      const {'invalid_client', 'unauthorized_client', 'invalid_request', 'invalid_scope'}.contains(err) ||
      RegExp(r'redirect_uri|AADSTS(50011|700016|7000218|50020)\b').hasMatch(text)) {
    return OAuthFailure.misconfigured;
  }
  return OAuthFailure.other;
}

/// Signs in to Gmail and Microsoft accounts and refreshes their tokens.
///
/// Client ids come from `--dart-define=LOUPE_GOOGLE_CLIENT_ID=…` and
/// `--dart-define=LOUPE_MICROSOFT_CLIENT_ID=…`; a provider without one is not
/// [isConfigured] and the UI hides it. See docs/oauth-setup.md.
final class OAuthSignIn {
  OAuthSignIn({
    this._agent,
    TokenEndpointClient? tokens,
    String? googleClientId,
    String? microsoftClientId,
    DateTime Function()? clock,
  }) : _tokens = tokens ?? TokenEndpointClient(clock: clock),
       _googleClientId = (googleClientId ?? const String.fromEnvironment('LOUPE_GOOGLE_CLIENT_ID')).trim(),
       _microsoftClientId = (microsoftClientId ?? const String.fromEnvironment('LOUPE_MICROSOFT_CLIENT_ID')).trim(),
       _clock = clock ?? DateTime.now;

  /// Created on first sign-in, so background isolates never touch the plugin.
  OAuthAgent? _agent;
  final TokenEndpointClient _tokens;
  final String _googleClientId;
  final String _microsoftClientId;
  final DateTime Function() _clock;

  /// The app's own URI scheme, its Android package name and iOS bundle id.
  static const redirectScheme = 'io.github.buengenio.loupe';

  /// Google: the Android client (custom URI scheme enabled under Advanced
  /// settings) and the iOS client both accept the package/bundle id as the
  /// scheme. Android: flutter_appauth's `appAuthRedirectScheme` placeholder;
  /// iOS: a URL type in Info.plist.
  static const googleRedirectUri = '$redirectScheme:/oauth2redirect';

  /// Microsoft: the scheme of the iOS / macOS platform redirect that Entra
  /// generates from the bundle id. Entra refuses custom schemes without
  /// `//`, so Google's form can't be registered there.
  static const microsoftRedirectScheme = 'msauth.$redirectScheme';

  /// Microsoft: registered under "iOS / macOS" (bundle id
  /// io.github.buengenio.loupe). Android: an extra intent filter on AppAuth's
  /// RedirectUriReceiverActivity; iOS: a second URL scheme.
  static const microsoftRedirectUri = '$microsoftRedirectScheme://auth';

  /// The scope Gmail needs for IMAP and SMTP.
  static const gmailScope = 'https://mail.google.com/';

  /// Whether sign-in with [provider] is available in this build.
  bool isConfigured(ProviderKind provider) => configFor(provider) != null;

  /// Endpoints and scopes for [provider]; null if unsupported or no client id.
  OAuthProviderConfig? configFor(ProviderKind provider) => switch (provider) {
    ProviderKind.gmail when _googleClientId.isNotEmpty => OAuthProviderConfig(
      provider: provider,
      clientId: _googleClientId,
      redirectUri: googleRedirectUri,
      authorizationEndpoint: 'https://accounts.google.com/o/oauth2/v2/auth',
      tokenEndpoint: 'https://oauth2.googleapis.com/token',
      scopes: const [gmailScope],
    ),
    // The common endpoint takes personal and work or school accounts, so
    // the user never has to choose.
    ProviderKind.microsoft when _microsoftClientId.isNotEmpty => OAuthProviderConfig(
      provider: provider,
      clientId: _microsoftClientId,
      redirectUri: microsoftRedirectUri,
      authorizationEndpoint: 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize',
      tokenEndpoint: 'https://login.microsoftonline.com/common/oauth2/v2.0/token',
      scopes: const [
        'https://outlook.office.com/IMAP.AccessAsUser.All',
        'https://outlook.office.com/SMTP.Send',
        'offline_access',
        'openid',
        'email',
      ],
      scopesOnRefresh: true,
    ),
    _ => null,
  };

  OAuthProviderConfig _require(ProviderKind provider) =>
      configFor(provider) ??
      (throw OAuthSignInException(
        OAuthFailure.misconfigured,
        'Sign-in with ${providerName(provider)} isn’t available.',
      ));

  /// "Google" or "Microsoft".
  static String providerName(ProviderKind provider) => switch (provider) {
    ProviderKind.gmail => 'Google',
    ProviderKind.microsoft => 'Microsoft',
    _ => provider.name,
  };

  /// Opens the provider's sign-in page. Throws [OAuthSignInException]; its
  /// [OAuthSignInException.failure] says why.
  Future<OAuthCredentials> signIn(ProviderKind provider, {String? loginHint}) async {
    final config = _require(provider);
    final name = providerName(provider);
    final OAuthTokens tokens;
    try {
      tokens = await (_agent ??= AppAuthAgent()).authorize(config, loginHint: loginHint);
    } on PlatformException catch (e) {
      final failure = classifyOAuthError(e);
      throw OAuthSignInException(failure, switch (failure) {
        OAuthFailure.cancelled => 'Sign-in was cancelled.',
        OAuthFailure.denied => 'Loupe wasn’t given access to your mail.',
        OAuthFailure.adminApproval => 'Your organisation must approve Loupe first.',
        OAuthFailure.blockedByPolicy => 'Your organisation’s sign-in rules blocked Loupe.',
        OAuthFailure.network => 'Couldn’t reach $name. Check your connection.',
        OAuthFailure.misconfigured => 'Sign-in with $name isn’t set up correctly in this build.',
        OAuthFailure.other => 'Sign-in with $name failed.',
      }, e);
    }
    // Google's consent screen lets the user untick Gmail access.
    final granted = tokens.scopes;
    if (provider == ProviderKind.gmail && granted != null && granted.isNotEmpty && !granted.contains(gmailScope)) {
      throw OAuthSignInException(OAuthFailure.denied, 'Loupe wasn’t given access to Gmail.');
    }
    final access = tokens.accessToken;
    if (access == null || access.isEmpty) {
      throw OAuthSignInException(OAuthFailure.other, '$name returned no access token.');
    }
    return _credentials(tokens, previousRefreshToken: null);
  }

  /// Exchanges the refresh token for a new access token with an HTTPS POST
  /// (no plugin, so it works in background isolates). Throws
  /// [SignInRequiredException] when the grant is gone (revoked, expired, no
  /// refresh token), and a [MailException] of kind connection or server for
  /// failures worth retrying.
  Future<OAuthCredentials> refresh(ProviderKind provider, OAuthCredentials current) async {
    final config = configFor(provider);
    if (config == null) {
      // A build without this provider's client id (a local debug build) can't
      // refresh. The grant may still be good: not a SignInRequiredException,
      // which would make the repository forget it.
      throw MailException(
        MailErrorKind.unsupported,
        'Sign-in with ${providerName(provider)} isn’t available in this build of Loupe.',
      );
    }
    final refreshToken = current.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) throw const SignInRequiredException();
    final tokens = await _tokens.refresh(config, refreshToken);
    return _credentials(tokens, previousRefreshToken: refreshToken);
  }

  OAuthCredentials _credentials(OAuthTokens tokens, {required String? previousRefreshToken}) => OAuthCredentials(
    accessToken: tokens.accessToken!,
    // Google omits the refresh token on refresh; Microsoft rotates it.
    refreshToken: tokens.refreshToken ?? previousRefreshToken,
    expiresAt: tokens.expiresAt ?? _clock().add(const Duration(hours: 1)),
  );
}
