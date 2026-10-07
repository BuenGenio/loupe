import 'package:mail_model/mail_model.dart';

/// Wording shared by account setup and the Thunderbird import.

/// A short message for a failed sign-in.
String describeSetupError(MailException e, ProviderKind provider, {ServerProtocol protocol = ServerProtocol.imap}) =>
    switch (e.kind) {
      MailErrorKind.authentication when provider == ProviderKind.fastmail && protocol == ServerProtocol.jmap =>
        'API token rejected. Create a Fastmail API token for JMAP with access to email, and paste it.',
      MailErrorKind.authentication => switch (provider) {
        ProviderKind.gmail ||
        ProviderKind.icloud ||
        ProviderKind.yahoo ||
        ProviderKind.fastmail => 'Password rejected. Use an app password, not your account password.',
        _ => 'Password rejected. Check it and try again.',
      },
      MailErrorKind.connection => "Can't reach server. Check the server settings and your connection.",
      MailErrorKind.certificate => "The server's certificate isn't trusted. ${e.message}",
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

/// Providers that only take app passwords from mail apps; Fastmail over
/// JMAP takes an API token.
String passwordLabel(ProviderKind provider, {ServerProtocol protocol = ServerProtocol.imap}) => switch (provider) {
  ProviderKind.fastmail when protocol == ServerProtocol.jmap => 'API Token',
  ProviderKind.gmail || ProviderKind.yahoo || ProviderKind.fastmail || ProviderKind.icloud => 'App Password',
  _ => 'Password',
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
