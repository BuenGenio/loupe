/// Sender authentication as reported by the receiving server in the
/// `Authentication-Results` header (RFC 8601).
enum AuthVerdict {
  /// DMARC passed, or DKIM passed without a DMARC result.
  verified,

  /// DMARC failed, or every DKIM signature failed.
  failed,

  /// Nothing conclusive.
  unknown,
}

/// One method result, e.g. `dkim=pass header.d=example.com`.
final class AuthMethodResult {
  const AuthMethodResult(this.method, this.result, [this.domain]);

  /// Lower-cased method name: `dkim`, `spf`, `dmarc`, `arc`, …
  final String method;

  /// Lower-cased result: `pass`, `fail`, `softfail`, `none`, …
  final String result;

  /// The domain the result is about (header.d, header.i, smtp.mailfrom or header.from), if given.
  final String? domain;

  @override
  String toString() => '${method.toUpperCase()} $result${domain == null ? '' : ' ($domain)'}';
}

/// The parsed authentication results of a message.
final class AuthResults {
  const AuthResults(this.methods);

  /// No `Authentication-Results` header.
  static const none = AuthResults([]);

  final List<AuthMethodResult> methods;

  Iterable<AuthMethodResult> _of(String method) => methods.where((m) => m.method == method);

  AuthVerdict get verdict {
    final dmarc = _of('dmarc').map((m) => m.result).toList();
    if (dmarc.contains('pass')) return AuthVerdict.verified;
    if (dmarc.contains('fail')) return AuthVerdict.failed;
    final dkim = _of('dkim').map((m) => m.result).toList();
    if (dkim.contains('pass')) return AuthVerdict.verified;
    if (dkim.isNotEmpty && dkim.every((r) => r == 'fail' || r == 'permerror')) return AuthVerdict.failed;
    return AuthVerdict.unknown;
  }

  /// "DKIM pass · SPF pass · DMARC pass", for the expanded header.
  String get summary => [
    for (final method in const ['dkim', 'spf', 'dmarc'])
      if (_of(method).firstOrNull case final m?) '${method.toUpperCase()} ${m.result}',
  ].join(' · ');

  /// Parses the topmost `Authentication-Results` header of [headers].
  ///
  /// Only the topmost one is used: it was added by the receiving server, while
  /// lower ones could have been forged by the sender.
  static AuthResults parse(List<(String, String)> headers) {
    for (final (name, value) in headers) {
      if (name.toLowerCase() == 'authentication-results') return parseValue(value);
    }
    return none;
  }

  /// Parses one header value, e.g.
  /// `mx.example.net; dkim=pass header.d=example.com; spf=pass smtp.mailfrom=example.com; dmarc=pass header.from=example.com`.
  static AuthResults parseValue(String value) {
    final unfolded = value.replaceAll(RegExp(r'\s+'), ' ').replaceAll(RegExp(r'\([^)]*\)'), ' ');
    final clauses = unfolded.split(';').skip(1);
    final results = <AuthMethodResult>[];
    final methodRe = RegExp(r'^\s*([a-zA-Z0-9_-]+)\s*=\s*([a-zA-Z]+)');
    final propRe = RegExp(r'(header\.d|header\.i|header\.from|smtp\.mailfrom)\s*=\s*"?([^\s";]+)');
    for (final clause in clauses) {
      final m = methodRe.firstMatch(clause);
      if (m == null) continue;
      String? domain = propRe.firstMatch(clause)?.group(2);
      if (domain != null && domain.contains('@')) domain = domain.substring(domain.lastIndexOf('@') + 1);
      results.add(AuthMethodResult(m.group(1)!.toLowerCase(), m.group(2)!.toLowerCase(), domain));
    }
    return AuthResults(results);
  }
}
