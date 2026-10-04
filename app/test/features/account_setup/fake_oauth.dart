import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:loupe/data/oauth.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart';

/// The browser half of OAuth, scripted: [authorize] records the request and
/// answers with [next], or throws. mail_platform's tests cover how
/// flutter_appauth's errors become [OAuthSignInException]s; these fakes
/// throw the result.
final class FakeOAuthAgent implements OAuthAgent {
  final requests = <({ProviderKind provider, String? loginHint, String redirectUri})>[];
  OAuthTokens next = (accessToken: 'access', refreshToken: 'refresh', expiresAt: DateTime.utc(2030), scopes: null);

  /// Thrown by the next sign-ins until cleared.
  Object? error;

  /// Errors for the next sign-ins, one each, before [error] and [next].
  final errors = <Object>[];

  @override
  Future<OAuthTokens> authorize(OAuthProviderConfig config, {String? loginHint}) async {
    requests.add((provider: config.provider, loginHint: loginHint, redirectUri: config.redirectUri));
    if (errors.isNotEmpty) throw errors.removeAt(0);
    if (error case final e?) throw e;
    return next;
  }
}

/// Sign-in with both providers configured, through [agent].
OAuthSignIn configuredOAuth(FakeOAuthAgent agent) =>
    OAuthSignIn(agent: agent, googleClientId: 'google-client', microsoftClientId: 'microsoft-client');

/// Sign-in in a build without client ids.
OAuthSignIn unconfiguredOAuth() => OAuthSignIn(agent: FakeOAuthAgent(), googleClientId: '', microsoftClientId: '');

/// The override tests pass to the app.
Override oauthOverride(OAuthSignIn oauth) => oauthSignInProvider.overrideWithValue(oauth);

/// A sign-in that failed for [failure].
OAuthSignInException failed(OAuthFailure failure) => OAuthSignInException(failure, failure.name);
