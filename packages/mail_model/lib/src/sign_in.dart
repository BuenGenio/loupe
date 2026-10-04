import 'account.dart';
import 'repository.dart';

/// The provider no longer accepts an account's OAuth sign-in: the refresh
/// token was revoked or has expired, consent was withdrawn, the password
/// changed, or the organisation now requires another sign-in step. Retrying
/// can't fix it; only signing in again in the browser does.
///
/// It is an authentication error, so code that only looks at
/// [MailException.kind] treats it like a rejected password.
final class SignInRequiredException extends MailException {
  const SignInRequiredException([String message = defaultMessage, Object? cause])
    : super(MailErrorKind.authentication, message, cause);

  static const defaultMessage = 'Sign in again to keep using this account.';
}

/// What to store once the provider refused [credentials]' refresh token: no
/// refresh token, and an access token that counts as expired. Later
/// attempts then fail at once with [SignInRequiredException] instead of
/// asking the provider again on every sync.
OAuthCredentials withoutSignIn(OAuthCredentials credentials, DateTime now) => OAuthCredentials(
  accessToken: credentials.accessToken,
  refreshToken: null,
  expiresAt: credentials.expiresAt.isBefore(now) ? credentials.expiresAt : now,
);

/// Whether [credentials] can no longer work without a new sign-in: OAuth
/// tokens that have expired and can't be refreshed.
bool needsSignIn(Credentials? credentials, DateTime now) => switch (credentials) {
  OAuthCredentials(:final refreshToken, :final expiresAt) =>
    (refreshToken == null || refreshToken.isEmpty) && !expiresAt.isAfter(now),
  _ => false,
};

/// A repository whose OAuth accounts can lose their sign-in and get it back.
/// Optional: the UI checks for it like for `MailingLists`.
abstract interface class SignInRenewal {
  /// Ids of the accounts that need signing in again. Emits the current set
  /// at once and again whenever it changes.
  Stream<Set<String>> watchSignInRequired();

  /// Replaces the credentials of [accountId] with those of a new browser
  /// sign-in. Connects with them first, so tokens of another account (picked
  /// by mistake in the browser) are refused with a [MailException] and the
  /// old ones are kept. On success the account syncs again at once.
  Future<void> renewSignIn(String accountId, Credentials credentials);
}
