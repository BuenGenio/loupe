import 'package:mail_model/mail_model.dart';

import '../account_setup/setup_text.dart' as setup;
import 'thunderbird_qr.dart';

/// Why an account from Thunderbird can't be added yet.
enum ImportBlock { pop3, kerberos, ntlm, clientCertificate, microsoftSignIn }

/// The provider a server belongs to, by its hostname.
ProviderKind providerForHost(String host) {
  final h = host.toLowerCase();
  bool under(String domain) => h == domain || h.endsWith('.$domain');
  if (under('gmail.com') || under('googlemail.com') || under('google.com')) return ProviderKind.gmail;
  if (under('office365.com') || under('outlook.com') || under('hotmail.com') || under('live.com')) {
    return ProviderKind.microsoft;
  }
  if (under('mail.me.com') || under('icloud.com')) return ProviderKind.icloud;
  if (under('yahoo.com') || under('aol.com')) return ProviderKind.yahoo;
  if (under('fastmail.com') || under('messagingengine.com')) return ProviderKind.fastmail;
  return ProviderKind.generic;
}

ConnectionSecurity _security(TbSecurity s) => switch (s) {
  TbSecurity.tls => ConnectionSecurity.tls,
  TbSecurity.startTls => ConnectionSecurity.startTls,
  TbSecurity.plain => ConnectionSecurity.none,
};

/// An account from Thunderbird, mapped to Loupe's settings.
final class ImportCandidate {
  ImportCandidate._({
    required this.email,
    required this.name,
    required this.senderName,
    required this.provider,
    required this.incoming,
    required this.outgoing,
    required this.otherIdentities,
    required this.includedPassword,
    required this.usesOAuth,
    required this.canSignIn,
    required this.block,
  });

  /// [signInProviders] are the providers this build can sign in with
  /// (OAuth); Thunderbird's OAuth accounts with them sign in during the
  /// import instead of asking for a password.
  factory ImportCandidate.fromThunderbird(TbAccount account, {Set<ProviderKind> signInProviders = const {}}) {
    final email = account.email;
    final provider = providerForHost(account.incoming.host);
    ServerConfig server(ServerProtocol protocol, TbServer s) {
      final user = s.username.trim();
      return ServerConfig(
        protocol: protocol,
        host: s.host,
        port: s.port,
        security: _security(s.security),
        // Null means "the account's address".
        username: user.isEmpty || user.toLowerCase() == email.toLowerCase() ? null : user,
      );
    }

    final auths = {account.incoming.auth, account.outgoing.auth};
    final oauth = auths.contains(TbAuth.oauth2);
    final canSignIn = oauth && signInProviders.contains(provider);
    final block = account.protocol == TbIncomingProtocol.pop3
        ? ImportBlock.pop3
        : auths.contains(TbAuth.gssapi)
        ? ImportBlock.kerberos
        : auths.contains(TbAuth.ntlm)
        ? ImportBlock.ntlm
        : auths.contains(TbAuth.tlsCertificate)
        ? ImportBlock.clientCertificate
        : oauth && provider == ProviderKind.microsoft && !canSignIn
        ? ImportBlock.microsoftSignIn
        : null;
    // Thunderbird names accounts after their address unless renamed;
    // Loupe's default reads better in the mailbox list.
    final tbName = account.name.trim();
    final name = tbName.isEmpty || tbName.toLowerCase() == email.toLowerCase()
        ? setup.defaultAccountDescription(provider, email)
        : tbName;
    final sender = account.identities.first.displayName.trim();
    return ImportCandidate._(
      email: email,
      name: name,
      senderName: sender.isEmpty ? null : sender,
      provider: provider,
      incoming: server(ServerProtocol.imap, account.incoming),
      outgoing: server(ServerProtocol.smtp, account.outgoing),
      otherIdentities: account.identities.skip(1).toList(growable: false),
      // Loupe keeps one password per account; Thunderbird usually has the same for both servers.
      includedPassword: oauth ? null : account.incoming.password ?? account.outgoing.password,
      usesOAuth: oauth,
      canSignIn: canSignIn,
      block: block,
    );
  }

  final String email;

  /// The account's description in Loupe ("Work", "Gmail").
  final String name;
  final String? senderName;
  final ProviderKind provider;
  final ServerConfig incoming;
  final ServerConfig outgoing;

  /// Identities after the first, added once the account exists.
  final List<TbIdentity> otherIdentities;

  /// The password from the code, if the export included it.
  final String? includedPassword;

  /// Thunderbird signs in through the browser (OAuth). Unless Loupe
  /// [canSignIn] too, it asks for an (app) password.
  final bool usesOAuth;

  /// Loupe signs in with the provider (Google, Microsoft) in the browser.
  final bool canSignIn;

  /// Set when the account can't be added.
  final ImportBlock? block;

  bool get canImport => block == null;
  bool get needsPassword => includedPassword == null;
  bool get unencrypted => incoming.security == ConnectionSecurity.none || outgoing.security == ConnectionSecurity.none;

  /// An app password for providers that need one (and those Thunderbird
  /// signed in to in the browser).
  setup.SecretKind get secretKind => usesOAuth ? setup.SecretKind.appPassword : setup.secretKind(provider);

  /// What account setup needs. [credentials] (from signing in) or
  /// [password] replace the included password; [trustedCertificates] pins
  /// self-signed certificates by host.
  AccountSetup toSetup({
    String? password,
    Credentials? credentials,
    Map<String, String> trustedCertificates = const {},
  }) {
    final secret = password ?? includedPassword;
    if (credentials == null && (secret == null || secret.isEmpty)) throw StateError('No password for the account');
    ServerConfig pinned(ServerConfig c) => switch (trustedCertificates[c.host]) {
      final fp? => ServerConfig(
        protocol: c.protocol,
        host: c.host,
        port: c.port,
        security: c.security,
        username: c.username,
        trustedCertificateSha256: fp,
      ),
      null => c,
    };
    return AccountSetup(
      email: email,
      displayName: name,
      provider: provider,
      incoming: pinned(incoming),
      outgoing: pinned(outgoing),
      credentials: credentials ?? PasswordCredentials(secret!),
      senderName: senderName,
    );
  }

  @override
  String toString() => 'ImportCandidate($email, ${provider.name}, block: ${block?.name})';
}
