/// OAuth token refresh with a plain HTTPS POST (RFC 6749 §6).
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mail_model/mail_model.dart';

import 'oauth.dart';

/// Refreshes access tokens at the provider's token endpoint.
///
/// It needs no plugin, activity or browser, so it works wherever Dart runs:
/// the WorkManager and Instant Delivery isolates on Android, the
/// BGAppRefreshTask engine on iOS. Mobile clients (Google's Android and iOS
/// types, Entra public clients) send no client secret.
final class TokenEndpointClient {
  TokenEndpointClient({this._client, DateTime Function()? clock, this.timeout = const Duration(seconds: 30)})
    : _clock = clock ?? DateTime.now;

  /// Null: a client per request, closed afterwards.
  final http.Client? _client;
  final DateTime Function() _clock;
  final Duration timeout;

  /// OAuth error codes after which only an interactive sign-in helps:
  /// revoked or expired grants (`invalid_grant`, Microsoft's
  /// `interaction_required` for MFA or Conditional Access), and tokens of a
  /// client that no longer matches (`unauthorized_client`, `invalid_client`).
  static const signInRequiredErrors = {
    'invalid_grant',
    'interaction_required',
    'consent_required',
    'login_required',
    'unauthorized_client',
    'invalid_client',
    'invalid_scope',
  };

  /// Exchanges [refreshToken] for new tokens. Throws
  /// [SignInRequiredException] when the grant is gone, and [MailException]
  /// of kind connection (network, timeouts, 5xx, rate limits) or server
  /// (other refusals) otherwise; those are worth retrying later.
  Future<OAuthTokens> refresh(OAuthProviderConfig config, String refreshToken) async {
    final name = OAuthSignIn.providerName(config.provider);
    final client = _client ?? http.Client();
    final http.Response response;
    try {
      response = await client
          .post(
            Uri.parse(config.tokenEndpoint),
            headers: const {'Accept': 'application/json'},
            body: {
              'grant_type': 'refresh_token',
              'refresh_token': refreshToken,
              'client_id': config.clientId,
              if (config.scopesOnRefresh) 'scope': config.scopes.join(' '),
            },
          )
          .timeout(timeout);
    } on TimeoutException catch (e) {
      throw MailException(MailErrorKind.connection, '$name didn’t answer in time.', e);
    } on http.ClientException catch (e) {
      throw MailException(MailErrorKind.connection, 'Couldn’t reach $name to renew the sign-in.', e);
    } on IOException catch (e) {
      throw MailException(MailErrorKind.connection, 'Couldn’t reach $name to renew the sign-in.', e);
    } finally {
      if (_client == null) client.close();
    }
    return _parse(response, name);
  }

  OAuthTokens _parse(http.Response response, String name) {
    Map<String, Object?> json;
    try {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes, allowMalformed: true));
      json = decoded is Map<String, Object?> ? decoded : const {};
    } on FormatException {
      json = const {};
    }
    final status = response.statusCode;
    if (status == 200) {
      final access = json['access_token'];
      if (access is! String || access.isEmpty) {
        throw MailException(MailErrorKind.server, '$name returned no access token.');
      }
      final expiresIn = switch (json['expires_in']) {
        final int s => s,
        final String s => int.tryParse(s),
        _ => null,
      };
      final scope = json['scope'];
      return (
        accessToken: access,
        refreshToken: switch (json['refresh_token']) {
          final String r when r.isNotEmpty => r,
          _ => null,
        },
        expiresAt: expiresIn == null ? null : _clock().add(Duration(seconds: expiresIn)),
        scopes: scope is String ? scope.split(' ').where((s) => s.isNotEmpty).toList() : null,
      );
    }
    final error = json['error'];
    // Kept as the cause for logs; error_description can name the account.
    final detail = '$status ${error ?? ''} ${json['error_description'] ?? ''}'.trim();
    if (error is String && signInRequiredErrors.contains(error)) {
      throw SignInRequiredException('$name no longer accepts this sign-in. Sign in again.', detail);
    }
    if (status >= 500 || status == 429 || error == 'temporarily_unavailable') {
      throw MailException(MailErrorKind.connection, '$name’s sign-in service isn’t available right now.', detail);
    }
    throw MailException(MailErrorKind.server, '$name refused to renew the sign-in.', detail);
  }
}
