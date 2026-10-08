import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart';

import '../../l10n/l10n.dart';

/// Accounts that sign in with Google or Microsoft (OAuth): their servers
/// and the wording shared by account setup, the Thunderbird import and
/// "Sign In Again".

/// The servers of an account signed in with [provider]'s OAuth. The login
/// is the address itself (`username` null).
({ServerConfig incoming, ServerConfig outgoing}) oauthServers(ProviderKind provider) => switch (provider) {
  ProviderKind.gmail => (
    incoming: const ServerConfig(protocol: ServerProtocol.imap, host: 'imap.gmail.com', port: 993),
    outgoing: const ServerConfig(protocol: ServerProtocol.smtp, host: 'smtp.gmail.com', port: 465),
  ),
  ProviderKind.microsoft => (
    incoming: const ServerConfig(protocol: ServerProtocol.imap, host: 'outlook.office365.com', port: 993),
    outgoing: const ServerConfig(
      protocol: ServerProtocol.smtp,
      host: 'smtp.office365.com',
      port: 587,
      security: ConnectionSecurity.startTls,
    ),
  ),
  _ => throw ArgumentError.value(provider, 'provider', 'has no OAuth sign-in'),
};

/// "Google" or "Microsoft".
String oauthProviderName(ProviderKind provider) => OAuthSignIn.providerName(provider);

/// "Sign in with Google", "Sign in with Microsoft".
String oauthButtonLabel(AppLocalizations l10n, ProviderKind provider) =>
    l10n.accountSetupSignInWith(oauthProviderName(provider));

/// A short message for a failed OAuth sign-in, or for a server that refused
/// the tokens afterwards.
String describeOAuthError(AppLocalizations l10n, MailException e, ProviderKind provider) {
  final name = oauthProviderName(provider);
  if (e is OAuthSignInException) {
    return switch (e.failure) {
      OAuthFailure.cancelled => l10n.accountSetupOAuthCancelled(name),
      OAuthFailure.denied =>
        provider == ProviderKind.gmail ? l10n.accountSetupOAuthDeniedGmail : l10n.accountSetupOAuthDenied,
      OAuthFailure.adminApproval => l10n.accountSetupOAuthAdminApproval,
      OAuthFailure.blockedByPolicy => l10n.accountSetupOAuthBlocked,
      OAuthFailure.network => l10n.accountSetupOAuthNetwork(name),
      OAuthFailure.misconfigured => l10n.accountSetupOAuthMisconfigured(name),
      OAuthFailure.other => l10n.accountSetupOAuthFailed(name),
    };
  }
  return switch (e.kind) {
    // The browser sign-in worked, the mail server refused the tokens: most
    // often another account was picked in the browser.
    MailErrorKind.authentication =>
      provider == ProviderKind.gmail ? l10n.accountSetupOAuthRefusedGmail(name) : l10n.accountSetupOAuthRefused(name),
    MailErrorKind.connection => l10n.accountSetupOAuthServerUnreachable,
    MailErrorKind.certificate => l10n.accountSetupCertificateUntrusted(e.message),
    _ => e.message,
  };
}
