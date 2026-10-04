import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart';

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
String oauthButtonLabel(ProviderKind provider) => 'Sign in with ${oauthProviderName(provider)}';

/// A short message for a failed OAuth sign-in, or for a server that refused
/// the tokens afterwards.
String describeOAuthError(MailException e, ProviderKind provider) {
  final name = oauthProviderName(provider);
  if (e is OAuthSignInException) {
    return switch (e.failure) {
      OAuthFailure.cancelled => 'Sign-in was cancelled. Tap “${oauthButtonLabel(provider)}” to try again.',
      OAuthFailure.denied =>
        provider == ProviderKind.gmail
            ? 'Loupe needs permission to read and send your Gmail. Sign in again and allow access, '
                  'with the Gmail box ticked.'
            : 'Loupe needs permission to read and send your mail. Sign in again and accept the permissions.',
      OAuthFailure.adminApproval =>
        'Your organisation must approve Loupe before you can use it with this account. Ask your IT '
            'administrator to grant admin consent for Loupe in Microsoft Entra ID, then try again.',
      OAuthFailure.blockedByPolicy =>
        'Your organisation’s sign-in rules don’t allow Loupe on this device. Ask your IT administrator.',
      OAuthFailure.network => 'Couldn’t reach $name. Check your internet connection and try again.',
      OAuthFailure.misconfigured =>
        'Sign-in with $name isn’t set up correctly in this version of Loupe. Please report this.',
      OAuthFailure.other => 'Sign-in with $name didn’t work. Try again.',
    };
  }
  return switch (e.kind) {
    // The browser sign-in worked, the mail server refused the tokens: most
    // often another account was picked in the browser.
    MailErrorKind.authentication =>
      provider == ProviderKind.gmail
          ? '$name signed you in, but Gmail refused access for this address. Choose the same account when '
                'signing in. Work or school accounts may have IMAP turned off by their administrator.'
          : '$name signed you in, but the mail server refused access for this address. Choose the same '
                'account when signing in. Work or school accounts may have IMAP turned off by their administrator.',
    MailErrorKind.connection => "Can't reach the mail server. Check your connection and try again.",
    MailErrorKind.certificate => "The server's certificate isn't trusted. ${e.message}",
    _ => e.message,
  };
}
