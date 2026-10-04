/// Which kind of service an account talks to. Drives defaults and quirks
/// (Gmail labels and X-GM-RAW search, Microsoft OAuth, iCloud app passwords).
enum ProviderKind { generic, gmail, microsoft, icloud, yahoo, fastmail }

enum ConnectionSecurity {
  /// Implicit TLS (IMAPS 993, SMTPS 465).
  tls,

  /// STARTTLS upgrade (IMAP 143, submission 587). Fails if the server
  /// doesn't offer it; never falls back to plain text.
  startTls,

  /// Plain text. Only after an explicit, scary confirmation in the UI.
  none,
}

enum ServerProtocol { imap, smtp, jmap }

/// Host settings for one protocol.
final class ServerConfig {
  const ServerConfig({
    required this.protocol,
    required this.host,
    required this.port,
    this.security = ConnectionSecurity.tls,
    this.username,
    this.trustedCertificateSha256,
  });

  final ServerProtocol protocol;

  /// For JMAP: the session URL host (the session resource is discovered).
  final String host;
  final int port;
  final ConnectionSecurity security;

  /// Login name. Null means "use the account's email address".
  final String? username;

  /// SHA-256 fingerprint (hex) of a self-signed certificate the user chose to
  /// trust. Null means normal certificate validation.
  final String? trustedCertificateSha256;

  ServerConfig copyWith({String? host, int? port, ConnectionSecurity? security, String? username}) => ServerConfig(
    protocol: protocol,
    host: host ?? this.host,
    port: port ?? this.port,
    security: security ?? this.security,
    username: username ?? this.username,
    trustedCertificateSha256: trustedCertificateSha256,
  );

  Map<String, Object?> toJson() => {
    'protocol': protocol.name,
    'host': host,
    'port': port,
    'security': security.name,
    'username': username,
    'trustedCertificateSha256': trustedCertificateSha256,
  };

  factory ServerConfig.fromJson(Map<String, Object?> json) => ServerConfig(
    protocol: ServerProtocol.values.byName(json['protocol']! as String),
    host: json['host']! as String,
    port: json['port']! as int,
    security: ConnectionSecurity.values.byName(json['security']! as String),
    username: json['username'] as String?,
    trustedCertificateSha256: json['trustedCertificateSha256'] as String?,
  );
}

enum AuthKind { password, oauth2 }

/// A sending identity: the From address and its signature.
final class Identity {
  const Identity({
    required this.id,
    required this.email,
    this.name,
    this.signature,
    this.replyTo,
    this.autoCc,
    this.autoBcc,
    this.replyPatterns = const [],
  });

  final String id;
  final String email;
  final String? name;

  /// Plain-text signature, appended after "-- ".
  final String? signature;
  final String? replyTo;

  /// Added to Cc of every message from this identity (a copy to oneself).
  final String? autoCc;

  /// Added to Bcc of every message from this identity.
  final String? autoBcc;

  /// "Use for replies to": addresses or wildcards (`*@example.com`,
  /// `me+*@example.com`). A reply to a message sent to a matching address
  /// is sent from this identity.
  final List<String> replyPatterns;

  Identity copyWith({
    String? id,
    String? email,
    String? name,
    String? signature,
    String? replyTo,
    String? autoCc,
    String? autoBcc,
    List<String>? replyPatterns,
  }) => Identity(
    id: id ?? this.id,
    email: email ?? this.email,
    name: name ?? this.name,
    signature: signature ?? this.signature,
    replyTo: replyTo ?? this.replyTo,
    autoCc: autoCc ?? this.autoCc,
    autoBcc: autoBcc ?? this.autoBcc,
    replyPatterns: replyPatterns ?? this.replyPatterns,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'signature': signature,
    'replyTo': replyTo,
    if (autoCc != null) 'autoCc': autoCc,
    if (autoBcc != null) 'autoBcc': autoBcc,
    if (replyPatterns.isNotEmpty) 'replyPatterns': replyPatterns,
  };

  factory Identity.fromJson(Map<String, Object?> json) => Identity(
    id: json['id']! as String,
    email: json['email']! as String,
    name: json['name'] as String?,
    signature: json['signature'] as String?,
    replyTo: json['replyTo'] as String?,
    autoCc: json['autoCc'] as String?,
    autoBcc: json['autoBcc'] as String?,
    replyPatterns: [for (final p in (json['replyPatterns'] as List? ?? const [])) p as String],
  );
}

/// A configured account. Secrets (passwords, tokens) are never stored here;
/// they live in the platform keychain under [id].
final class MailAccount {
  const MailAccount({
    required this.id,
    required this.email,
    required this.displayName,
    required this.provider,
    required this.authKind,
    required this.incoming,
    this.outgoing,
    this.identities = const [],
    this.colorIndex = 0,
  });

  final String id;
  final String email;

  /// Shown in the mailbox list, e.g. "Work" or "Gmail".
  final String displayName;
  final ProviderKind provider;
  final AuthKind authKind;

  /// IMAP or JMAP.
  final ServerConfig incoming;

  /// SMTP. Null for JMAP accounts (they send through JMAP).
  final ServerConfig? outgoing;
  final List<Identity> identities;

  /// Index into the app's account colour palette (the stripe in lists).
  final int colorIndex;

  Identity get defaultIdentity => identities.isNotEmpty ? identities.first : Identity(id: '$id/default', email: email);

  /// An unsaved identity sending as [email]: an address of this account that
  /// isn't one of its [identities], such as a catch-all alias. It has the
  /// default identity's name and signature. Its id names the address, so a
  /// draft, the Outbox and crash recovery keep it (see [identityById]).
  Identity aliasIdentity(String email) {
    final d = defaultIdentity;
    return Identity(id: '$id$_aliasMark${email.trim()}', email: email.trim(), name: d.name, signature: d.signature);
  }

  /// Whether [identity] is an unsaved [aliasIdentity].
  bool isAliasIdentity(Identity identity) => identity.id.startsWith('$id$_aliasMark');

  /// The identity a message with [identityId] is sent as: one of
  /// [identities], an [aliasIdentity], or else the [defaultIdentity].
  Identity identityById(String identityId) {
    for (final i in identities) {
      if (i.id == identityId) return i;
    }
    final prefix = '$id$_aliasMark';
    if (identityId.startsWith(prefix) && identityId.length > prefix.length) {
      return aliasIdentity(identityId.substring(prefix.length));
    }
    return defaultIdentity;
  }

  static const _aliasMark = '/alias:';

  MailAccount copyWith({
    String? displayName,
    List<Identity>? identities,
    int? colorIndex,
    ServerConfig? incoming,
    ServerConfig? outgoing,
  }) => MailAccount(
    id: id,
    email: email,
    displayName: displayName ?? this.displayName,
    provider: provider,
    authKind: authKind,
    incoming: incoming ?? this.incoming,
    outgoing: outgoing ?? this.outgoing,
    identities: identities ?? this.identities,
    colorIndex: colorIndex ?? this.colorIndex,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'email': email,
    'displayName': displayName,
    'provider': provider.name,
    'authKind': authKind.name,
    'incoming': incoming.toJson(),
    'outgoing': outgoing?.toJson(),
    'identities': [for (final i in identities) i.toJson()],
    'colorIndex': colorIndex,
  };

  factory MailAccount.fromJson(Map<String, Object?> json) => MailAccount(
    id: json['id']! as String,
    email: json['email']! as String,
    displayName: json['displayName']! as String,
    provider: ProviderKind.values.byName(json['provider']! as String),
    authKind: AuthKind.values.byName(json['authKind']! as String),
    incoming: ServerConfig.fromJson((json['incoming']! as Map).cast()),
    outgoing: json['outgoing'] == null ? null : ServerConfig.fromJson((json['outgoing']! as Map).cast()),
    identities: [for (final i in (json['identities'] as List? ?? const [])) Identity.fromJson((i as Map).cast())],
    colorIndex: json['colorIndex'] as int? ?? 0,
  );
}

/// Credentials entered or obtained during setup.
sealed class Credentials {
  const Credentials();
}

final class PasswordCredentials extends Credentials {
  const PasswordCredentials(this.password);
  final String password;
}

final class OAuthCredentials extends Credentials {
  const OAuthCredentials({required this.accessToken, required this.refreshToken, required this.expiresAt});
  final String accessToken;
  final String? refreshToken;
  final DateTime expiresAt;
}

/// What account discovery (ISPDB autoconfig, provider detection, JMAP
/// well-known lookup) found for an email address.
final class AccountDiscovery {
  const AccountDiscovery({
    required this.email,
    required this.provider,
    required this.authKind,
    this.incoming,
    this.outgoing,
    this.source,
    this.notes,
  });

  final String email;
  final ProviderKind provider;

  /// [AuthKind.oauth2] for Gmail and Microsoft.
  final AuthKind authKind;

  /// Null when nothing was found (manual setup needed).
  final ServerConfig? incoming;
  final ServerConfig? outgoing;

  /// Where the settings came from, e.g. "ISPDB", "autoconfig.example.com", "guess".
  final String? source;

  /// Provider hint shown in the UI, e.g. "iCloud needs an app-specific password".
  final String? notes;
}

/// Everything needed to add an account.
final class AccountSetup {
  const AccountSetup({
    required this.email,
    required this.displayName,
    required this.provider,
    required this.incoming,
    required this.credentials,
    this.outgoing,
    this.senderName,
  });

  final String email;
  final String displayName;
  final ProviderKind provider;
  final ServerConfig incoming;
  final ServerConfig? outgoing;
  final Credentials credentials;

  /// The person's name for the default identity.
  final String? senderName;
}
