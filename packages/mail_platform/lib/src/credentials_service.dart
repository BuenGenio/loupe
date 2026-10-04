/// Credentials for transports: from the keychain, refreshed when needed.
library;

import 'package:mail_model/mail_model.dart';

import 'oauth.dart';
import 'secure_credential_store.dart';

/// Builds [CredentialsCallback]s over a [CredentialStore] and [OAuthSignIn].
final class CredentialsService {
  CredentialsService({CredentialStore? store, OAuthSignIn? oauth, DateTime Function()? clock})
    : store = store ?? SecureCredentialStore(),
      oauth = oauth ?? OAuthSignIn(),
      _clock = clock ?? DateTime.now;

  final CredentialStore store;
  final OAuthSignIn oauth;
  final DateTime Function() _clock;

  /// Refresh this long before the token expires.
  static const expirySkew = Duration(minutes: 2);

  final _refreshing = <String, Future<OAuthCredentials>>{};

  /// The callback a transport for [accountId] uses: reads the stored
  /// credentials and, for OAuth, refreshes them when they are about to
  /// expire or when [CredentialsCallback]'s `forceRefresh` is set (the
  /// server rejected the token), writing the new tokens back. Concurrent
  /// refreshes of one account share a single request.
  CredentialsCallback credentialsCallbackFor(String accountId, ProviderKind provider) =>
      ({bool forceRefresh = false}) async {
        final stored = await store.read(accountId);
        switch (stored) {
          case null:
            throw const MailException(MailErrorKind.authentication, 'No saved password or sign-in for this account.');
          case PasswordCredentials():
            return stored;
          case OAuthCredentials():
            if (!forceRefresh && stored.expiresAt.isAfter(_clock().add(expirySkew))) return stored;
            final pending = _refreshing[accountId] ??= _refresh(accountId, provider, stored);
            return pending;
        }
      };

  Future<OAuthCredentials> _refresh(String accountId, ProviderKind provider, OAuthCredentials current) async {
    try {
      final fresh = await oauth.refresh(provider, current);
      await store.write(accountId, fresh);
      return fresh;
    } on SignInRequiredException {
      // Forget the dead grant, so later calls fail without a request.
      if (current.refreshToken != null) await store.write(accountId, withoutSignIn(current, _clock()));
      rethrow;
    } finally {
      _refreshing.removeWhere((id, _) => id == accountId);
    }
  }
}
