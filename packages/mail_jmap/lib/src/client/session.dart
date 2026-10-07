/// The JMAP session resource (RFC 8620 §2).
library;

/// Capability URNs Loupe uses.
abstract final class JmapCapabilities {
  static const core = 'urn:ietf:params:jmap:core';
  static const mail = 'urn:ietf:params:jmap:mail';
  static const submission = 'urn:ietf:params:jmap:submission';
  static const sieve = 'urn:ietf:params:jmap:sieve';
}

/// One account the session gives access to.
final class JmapAccount {
  const JmapAccount({
    required this.id,
    required this.name,
    this.isPersonal = true,
    this.isReadOnly = false,
    this.capabilities = const {},
  });

  final String id;
  final String name;
  final bool isPersonal;
  final bool isReadOnly;

  /// `accountCapabilities`: per capability, this account's limits (Sieve
  /// extensions and script sizes, for example).
  final Map<String, Object?> capabilities;
}

/// What the server said about itself and the user: capabilities, accounts,
/// limits and the URLs of the API, of uploads, downloads and push.
final class JmapSession {
  JmapSession._({
    required this.url,
    required this.capabilities,
    required this.accounts,
    required this.primaryAccounts,
    required this.username,
    required this.apiUrl,
    required this.downloadUrl,
    required this.uploadUrl,
    required this.eventSourceUrl,
    required this.state,
  });

  /// Parses a session resource fetched from [url] (relative URLs in it
  /// resolve against [url]). Throws [FormatException] when it isn't one.
  factory JmapSession.fromJson(Map<String, Object?> json, Uri url) {
    final caps = json['capabilities'];
    final api = json['apiUrl'];
    if (caps is! Map || !caps.containsKey(JmapCapabilities.core) || api is! String || api.isEmpty) {
      throw const FormatException('Not a JMAP session resource');
    }
    final accounts = <String, JmapAccount>{};
    if (json['accounts'] case final Map<Object?, Object?> list) {
      for (final MapEntry(:key, :value) in list.entries) {
        if (key is! String || value is! Map) continue;
        accounts[key] = JmapAccount(
          id: key,
          name: value['name'] as String? ?? key,
          isPersonal: value['isPersonal'] as bool? ?? true,
          isReadOnly: value['isReadOnly'] as bool? ?? false,
          capabilities: {
            if (value['accountCapabilities'] case final Map<Object?, Object?> caps)
              for (final MapEntry(:key, :value) in caps.entries)
                if (key is String) key: value,
          },
        );
      }
    }
    return JmapSession._(
      url: url,
      capabilities: {
        for (final MapEntry(:key, :value) in caps.entries)
          if (key is String) key: value,
      },
      accounts: accounts,
      primaryAccounts: {
        if (json['primaryAccounts'] case final Map<Object?, Object?> p)
          for (final MapEntry(:key, :value) in p.entries)
            if (key is String && value is String) key: value,
      },
      username: json['username'] as String? ?? '',
      apiUrl: url.resolve(api),
      downloadUrl: json['downloadUrl'] as String? ?? '',
      uploadUrl: json['uploadUrl'] as String? ?? '',
      eventSourceUrl: json['eventSourceUrl'] as String?,
      state: json['state']?.toString() ?? '',
    );
  }

  /// Where the session was fetched from (after redirects).
  final Uri url;
  final Map<String, Object?> capabilities;
  final Map<String, JmapAccount> accounts;
  final Map<String, String> primaryAccounts;
  final String username;
  final Uri apiUrl;

  /// URI templates (RFC 6570 level 1).
  final String downloadUrl;
  final String uploadUrl;
  final String? eventSourceUrl;

  /// Changes when anything above changes (RFC 8620 §2: `sessionState`).
  final String state;

  bool has(String capability) => capabilities.containsKey(capability);

  /// The account [capability] is used with, if the user has one.
  String? primaryAccount(String capability) => primaryAccounts[capability];

  Map<String, Object?> get _core => switch (capabilities[JmapCapabilities.core]) {
    final Map<Object?, Object?> m => m.cast<String, Object?>(),
    _ => const {},
  };

  int _limit(String name, int fallback) {
    final v = _core[name];
    return v is int && v > 0 ? v : fallback;
  }

  int get maxObjectsInGet => _limit('maxObjectsInGet', 500);
  int get maxObjectsInSet => _limit('maxObjectsInSet', 500);
  int get maxCallsInRequest => _limit('maxCallsInRequest', 16);
  int get maxSizeUpload => _limit('maxSizeUpload', 50000000);
  int get maxSizeRequest => _limit('maxSizeRequest', 10000000);
  int get maxConcurrentUpload => _limit('maxConcurrentUpload', 4);

  /// The download URL of a blob.
  Uri download(String accountId, String blobId, {String type = 'application/octet-stream', String name = 'blob'}) =>
      _expand(downloadUrl, {'accountId': accountId, 'blobId': blobId, 'type': type, 'name': name});

  /// Where to upload a blob for [accountId].
  Uri upload(String accountId) => _expand(uploadUrl, {'accountId': accountId});

  /// The push URL (RFC 8620 §7.3) for [types] (`*` for all), or null when the
  /// server has none. [ping] is the keep-alive interval in seconds.
  Uri? eventSource({String types = '*', bool closeAfterState = false, int ping = 60}) {
    final template = eventSourceUrl;
    if (template == null || template.isEmpty) return null;
    return _expand(template, {'types': types, 'closeafter': closeAfterState ? 'state' : 'no', 'ping': '$ping'});
  }

  Uri _expand(String template, Map<String, String> values) {
    final expanded = template.replaceAllMapped(RegExp(r'\{([A-Za-z]+)\}'), (m) {
      final v = values[m[1]];
      return v == null ? '' : Uri.encodeComponent(v);
    });
    return url.resolve(expanded);
  }
}
