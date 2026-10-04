/// Built-in settings for the big providers.
library;

import 'package:mail_model/mail_model.dart';

ServerConfig _imap(String host) => ServerConfig(protocol: ServerProtocol.imap, host: host, port: 993);
ServerConfig _smtpTls(String host) => ServerConfig(protocol: ServerProtocol.smtp, host: host, port: 465);
ServerConfig _smtpStartTls(String host) =>
    ServerConfig(protocol: ServerProtocol.smtp, host: host, port: 587, security: ConnectionSecurity.startTls);

/// Notes shown during setup.
abstract final class ProviderNotes {
  static const gmail =
      'Sign in with Google. If you use an app password instead, create one at myaccount.google.com/apppasswords.';
  static const microsoft = 'Sign in with Microsoft.';
  static const icloud =
      'iCloud needs an app-specific password: appleid.apple.com → Sign-In and Security → App-Specific Passwords.';
  static const yahoo = 'Yahoo and AOL need an app password: Account Security → Generate app password.';
  static const fastmail = 'Fastmail needs an app password: Settings → Privacy & Security → Manage app passwords.';
}

final _microsoft = RegExp(r'^(hotmail|outlook|live|windowslive)\.(com|[a-z]{2}|co\.[a-z]{2}|com\.[a-z]{2})$');
final _yahoo = RegExp(r'^(yahoo\.(com|[a-z]{2}|co\.[a-z]{2}|com\.[a-z]{2})|ymail\.com|rocketmail\.com)$');
final _aol = RegExp(r'^(aol\.(com|[a-z]{2}|co\.[a-z]{2})|aim\.com|love\.com|ygm\.com|games\.com|wow\.com)$');
final _fastmail = RegExp(r'^fastmail\.(com|fm|cn|co\.uk|com\.au|de|es|in|jp|mx|net|nl|org|se|to|tw|uk|us)$');
const _fastmailOther = {
  'messagingengine.com',
  'sent.com',
  'eml.cc',
  '123mail.org',
  'fastem.com',
  'fmail.co.uk',
  'imap.cc',
  'mailbolt.com',
  'airpost.net',
  'fastimap.com',
};

/// Settings for well-known providers by domain, or null.
AccountDiscovery? providerRule(String email, String domain) {
  final d = domain.toLowerCase();
  if (d == 'gmail.com' || d == 'googlemail.com') return gmailDiscovery(email);
  if (_microsoft.hasMatch(d) || d == 'msn.com' || d == 'passport.com' || d == 'office365.com') {
    return microsoftDiscovery(email);
  }
  if (d == 'icloud.com' || d == 'me.com' || d == 'mac.com') {
    return AccountDiscovery(
      email: email,
      provider: ProviderKind.icloud,
      authKind: AuthKind.password,
      incoming: _imap('imap.mail.me.com'),
      outgoing: _smtpStartTls('smtp.mail.me.com'),
      source: 'provider',
      notes: ProviderNotes.icloud,
    );
  }
  if (_yahoo.hasMatch(d)) {
    return AccountDiscovery(
      email: email,
      provider: ProviderKind.yahoo,
      authKind: AuthKind.password,
      incoming: _imap('imap.mail.yahoo.com'),
      outgoing: _smtpTls('smtp.mail.yahoo.com'),
      source: 'provider',
      notes: ProviderNotes.yahoo,
    );
  }
  if (_aol.hasMatch(d)) {
    return AccountDiscovery(
      email: email,
      provider: ProviderKind.yahoo,
      authKind: AuthKind.password,
      incoming: _imap('imap.aol.com'),
      outgoing: _smtpTls('smtp.aol.com'),
      source: 'provider',
      notes: ProviderNotes.yahoo,
    );
  }
  if (_fastmail.hasMatch(d) || _fastmailOther.contains(d)) {
    return AccountDiscovery(
      email: email,
      provider: ProviderKind.fastmail,
      authKind: AuthKind.password,
      incoming: _imap('imap.fastmail.com'),
      outgoing: _smtpTls('smtp.fastmail.com'),
      source: 'provider',
      notes: ProviderNotes.fastmail,
    );
  }
  return null;
}

AccountDiscovery gmailDiscovery(String email, {String source = 'provider'}) => AccountDiscovery(
  email: email,
  provider: ProviderKind.gmail,
  authKind: AuthKind.oauth2,
  incoming: _imap('imap.gmail.com'),
  outgoing: _smtpTls('smtp.gmail.com'),
  source: source,
  notes: ProviderNotes.gmail,
);

AccountDiscovery microsoftDiscovery(String email, {String source = 'provider'}) => AccountDiscovery(
  email: email,
  provider: ProviderKind.microsoft,
  authKind: AuthKind.oauth2,
  incoming: _imap('outlook.office365.com'),
  outgoing: _smtpStartTls('smtp.office365.com'),
  source: source,
  notes: ProviderNotes.microsoft,
);

/// The provider a server host belongs to (for domains hosted elsewhere,
/// e.g. Google Workspace found through autoconfig).
ProviderKind providerForHost(String host) {
  final h = host.toLowerCase();
  if (h.endsWith('.gmail.com') || h.endsWith('.googlemail.com') || h.endsWith('.google.com')) return ProviderKind.gmail;
  if (h.endsWith('.office365.com') || h.endsWith('.outlook.com')) return ProviderKind.microsoft;
  if (h.endsWith('.mail.me.com')) return ProviderKind.icloud;
  if (h.endsWith('.yahoo.com') || h.endsWith('.aol.com')) return ProviderKind.yahoo;
  if (h.endsWith('.fastmail.com') || h.endsWith('.messagingengine.com')) return ProviderKind.fastmail;
  return ProviderKind.generic;
}
