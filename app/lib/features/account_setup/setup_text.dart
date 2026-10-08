import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';

/// Wording shared by account setup and the Thunderbird import.

/// A short message for a failed sign-in.
String describeSetupError(
  AppLocalizations l10n,
  MailException e,
  ProviderKind provider, {
  ServerProtocol protocol = ServerProtocol.imap,
}) => switch (e.kind) {
  MailErrorKind.authentication when provider == ProviderKind.fastmail && protocol == ServerProtocol.jmap =>
    l10n.accountSetupApiTokenRejected,
  MailErrorKind.authentication => switch (provider) {
    ProviderKind.gmail ||
    ProviderKind.icloud ||
    ProviderKind.yahoo ||
    ProviderKind.fastmail => l10n.accountSetupAppPasswordRejected,
    _ => l10n.accountSetupPasswordRejected,
  },
  MailErrorKind.connection => l10n.accountSetupServerUnreachable,
  MailErrorKind.certificate => l10n.accountSetupCertificateUntrusted(e.message),
  _ => e.message,
};

/// "Gmail", "iCloud", … or the domain's first label ("Example").
String defaultAccountDescription(ProviderKind provider, String email) {
  final e = email.trim();
  final domain = e.contains('@') ? e.substring(e.lastIndexOf('@') + 1).toLowerCase() : '';
  return switch (provider) {
    ProviderKind.gmail => 'Gmail',
    ProviderKind.microsoft => 'Outlook',
    ProviderKind.icloud => 'iCloud',
    ProviderKind.yahoo => 'Yahoo',
    ProviderKind.fastmail => 'Fastmail',
    ProviderKind.generic =>
      domain.isEmpty ? 'Mail' : '${domain[0].toUpperCase()}${domain.split('.').first.substring(1)}',
  };
}

/// What an account signs in with instead of a sign-in page.
enum SecretKind { password, appPassword, apiToken }

/// Providers that only take app passwords from mail apps; Fastmail over
/// JMAP takes an API token.
SecretKind secretKind(ProviderKind provider, {ServerProtocol protocol = ServerProtocol.imap}) => switch (provider) {
  ProviderKind.fastmail when protocol == ServerProtocol.jmap => SecretKind.apiToken,
  ProviderKind.gmail || ProviderKind.yahoo || ProviderKind.fastmail || ProviderKind.icloud => SecretKind.appPassword,
  _ => SecretKind.password,
};

/// What the password field is labelled: Password, App Password or API Token.
String secretLabel(AppLocalizations l10n, SecretKind kind) => switch (kind) {
  SecretKind.password => l10n.commonPassword,
  SecretKind.appPassword => l10n.accountSetupAppPassword,
  SecretKind.apiToken => l10n.accountSetupApiToken,
};

/// Where Fastmail explains API tokens.
const fastmailApiTokenHelp = 'https://www.fastmail.help/hc/en-us/articles/5254602856719';

/// A SHA-256 certificate fingerprint in [message] (64 hex digits, with or
/// without colons), as lower-case hex without colons.
String? fingerprintIn(String message) {
  final m = RegExp(r'([0-9A-Fa-f]{2}(?::[0-9A-Fa-f]{2}){31}|[0-9A-Fa-f]{64})').firstMatch(message);
  return m?.group(1)!.replaceAll(':', '').toLowerCase();
}

/// Where Google explains app passwords.
const gmailAppPasswordHelp = 'https://support.google.com/accounts/answer/185833';
