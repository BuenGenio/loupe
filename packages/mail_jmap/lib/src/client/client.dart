/// A small JMAP client (RFC 8620): session discovery, authentication,
/// batched method calls, blob upload and download, and push streams.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mail_imap/mail_imap.dart' show UntrustedCertificate, normalizeFingerprint;
import 'package:mail_model/mail_model.dart';

import 'errors.dart';
import 'request.dart';
import 'session.dart';

/// An uploaded blob (RFC 8620 §6.1).
typedef JmapBlob = ({String blobId, String type, int size});

/// Talks JMAP to one server for one login.
///
/// The session is found at `https://<host>[:port]/.well-known/jmap`
/// (redirects followed, never from HTTPS to plain HTTP), or at
/// `/jmap/session` where the well-known URL is missing. Passwords go as
/// HTTP Basic credentials; when the server refuses them, once as a bearer
/// token (Fastmail's API tokens, Stalwart's API keys), which is then kept
/// for this client. OAuth access tokens go as bearer tokens and are
/// refreshed once when refused.
///
/// A certificate that fails validation is accepted only when its SHA-256
/// is [ServerConfig.trustedCertificateSha256]; otherwise requests fail with
/// a [MailErrorKind.certificate] error whose cause is the
/// [UntrustedCertificate].
final class JmapClient {
  JmapClient({
    required this.server,
    required this.login,
    required this._credentials,
    http.Client? httpClient,
    this.timeout = const Duration(seconds: 60),
    this.transferTimeout = const Duration(minutes: 10),
  }) : _injected = httpClient;

  final ServerConfig server;

  /// The user name for Basic authentication.
  final String login;
  final CredentialsCallback _credentials;
  final http.Client? _injected;

  /// Per API request.
  final Duration timeout;

  /// Per upload or download.
  final Duration transferTimeout;

  static const userAgent = 'Loupe/0.1 (+https://github.com/BuenGenio/loupe)';

  http.Client? _client;
  JmapSession? _session;
  bool _sessionStale = false;
  bool _bearerPassword = false;
  UntrustedCertificate? _rejected;

  /// The session, once fetched.
  JmapSession? get currentSession => _session;

  /// Where session discovery starts.
  Uri get wellKnownUrl {
    final plain = server.security == ConnectionSecurity.none;
    final scheme = plain ? 'http' : 'https';
    final standard = plain ? 80 : 443;
    return Uri(
      scheme: scheme,
      host: server.host,
      port: server.port == standard ? null : server.port,
      path: '/.well-known/jmap',
    );
  }

  http.Client get _http => _client ??= _injected ?? _ioClient();

  http.Client _ioClient() {
    final io = HttpClient()
      ..connectionTimeout = const Duration(seconds: 20)
      ..userAgent = userAgent
      ..badCertificateCallback = (certificate, host, port) {
        final fp = sha256.convert(certificate.der).toString();
        final trusted = server.trustedCertificateSha256;
        if (trusted != null && normalizeFingerprint(trusted) == fp) return true;
        _rejected = UntrustedCertificate(
          host: host,
          sha256: fp,
          subject: certificate.subject,
          issuer: certificate.issuer,
          validUntil: certificate.endValidity,
        );
        return false;
      };
    return IOClient(io);
  }

  /// Closes connections; the client can be used again afterwards.
  void close() {
    if (_injected == null) _client?.close();
    _client = null;
    _session = null;
  }

  // Session -------------------------------------------------------------------

  /// The session resource, fetched when there is none yet, when [refresh],
  /// or when an API response said it changed.
  Future<JmapSession> session({bool refresh = false}) async {
    final current = _session;
    if (current != null && !refresh && !_sessionStale) return current;
    final fetched = await _fetchSession();
    _session = fetched;
    _sessionStale = false;
    return fetched;
  }

  Future<JmapSession> _fetchSession() async {
    final start = wellKnownUrl;
    for (final path in const ['/.well-known/jmap', '/jmap/session']) {
      final (uri, response) = await _getFollowingRedirects(start.replace(path: path));
      final text = await _text(response);
      if (response.statusCode == 404) continue;
      if (response.statusCode != 200) throw requestError(response.statusCode, uri.host, _problem(text));
      try {
        final json = jsonDecode(text);
        if (json is Map) return JmapSession.fromJson(json.cast(), uri);
      } on FormatException {
        // Not JSON: a web page, not a JMAP server.
      }
      break;
    }
    throw MailException(MailErrorKind.server, 'No JMAP service found at ${server.host}.');
  }

  /// GETs [uri] with credentials, following up to five redirects.
  Future<(Uri, http.StreamedResponse)> _getFollowingRedirects(Uri uri) async {
    var current = uri;
    for (var hop = 0; ; hop++) {
      final response = await _authorized(() => http.Request('GET', current)..followRedirects = false, timeout);
      final location = response.headers['location'];
      if (!const {301, 302, 303, 307, 308}.contains(response.statusCode) || location == null) {
        return (current, response);
      }
      await _drain(response);
      if (hop >= 5) throw MailException(MailErrorKind.server, '${uri.host} redirects too often.');
      final next = current.resolve(location);
      if (current.scheme == 'https' && next.scheme != 'https') {
        throw MailException(MailErrorKind.server, '${uri.host} redirects to an unencrypted address ($next).');
      }
      current = next;
    }
  }

  // API -----------------------------------------------------------------------

  /// Sends [request] and returns its method responses. Throws a
  /// [MailException] when the request as a whole failed; method errors
  /// surface through [JmapResponse.of].
  Future<JmapResponse> call(JmapRequest request) async {
    final s = await session();
    if (request.calls.length > s.maxCallsInRequest) {
      throw ArgumentError('${request.calls.length} calls in one request; the server takes ${s.maxCallsInRequest}');
    }
    final body = utf8.encode(jsonEncode(request.toJson()));
    final response = await _authorized(
      () => http.Request('POST', s.apiUrl)
        ..headers['Content-Type'] = 'application/json'
        ..headers['Accept'] = 'application/json'
        ..bodyBytes = body,
      timeout,
    );
    final text = await _text(response);
    if (response.statusCode != 200) throw requestError(response.statusCode, s.apiUrl.host, _problem(text));
    final JmapResponse parsed;
    try {
      parsed = JmapResponse.fromJson((jsonDecode(text) as Map).cast());
    } on Object catch (e) {
      throw MailException(MailErrorKind.server, 'Unexpected response from ${s.apiUrl.host}.', e);
    }
    final state = parsed.sessionState;
    if (state != null && state.isNotEmpty && state != s.state) _sessionStale = true;
    return parsed;
  }

  /// Uploads [data] for [accountId].
  Future<JmapBlob> upload(String accountId, Uint8List data, {String type = 'application/octet-stream'}) async {
    final s = await session();
    if (data.length > s.maxSizeUpload) {
      throw PermanentMailException(
        MailErrorKind.server,
        'The message is larger than ${s.url.host} takes (${s.maxSizeUpload ~/ 1000000} MB).',
      );
    }
    final uri = s.upload(accountId);
    final response = await _authorized(
      () => http.Request('POST', uri)
        ..headers['Content-Type'] = type
        ..headers['Accept'] = 'application/json'
        ..bodyBytes = data,
      transferTimeout,
    );
    final text = await _text(response);
    if (response.statusCode != 200 && response.statusCode != 201) {
      final e = requestError(response.statusCode, uri.host, _problem(text));
      if (response.statusCode == 413) {
        throw PermanentMailException(MailErrorKind.server, 'The message is too large for ${uri.host}.', e);
      }
      throw e;
    }
    try {
      final json = (jsonDecode(text) as Map).cast<String, Object?>();
      return (
        blobId: json['blobId']! as String,
        type: json['type'] as String? ?? type,
        size: (json['size'] as num?)?.toInt() ?? data.length,
      );
    } on Object catch (e) {
      throw MailException(MailErrorKind.server, 'Unexpected upload response from ${uri.host}.', e);
    }
  }

  /// Downloads blob [blobId] of [accountId].
  Future<Uint8List> download(String accountId, String blobId, {String? type, String? name}) async {
    final s = await session();
    final uri = s.download(accountId, blobId, type: type ?? 'application/octet-stream', name: name ?? 'blob');
    final response = await _authorized(() => http.Request('GET', uri), transferTimeout);
    if (response.statusCode != 200) {
      final text = await _text(response);
      final e = requestError(response.statusCode, uri.host, _problem(text));
      if (e.kind == MailErrorKind.notFound) {
        throw JmapException('notFound', MailErrorKind.notFound, 'The server no longer has this part.', e);
      }
      throw e;
    }
    return _guard(uri, () => response.stream.toBytes().timeout(transferTimeout));
  }

  /// Opens a push stream (`text/event-stream`, RFC 8620 §7.3) at [uri].
  /// Completing [abort] ends it.
  Future<http.StreamedResponse> openStream(Uri uri, {required Future<void> abort}) async {
    final response = await _authorized(
      () => http.AbortableRequest('GET', uri, abortTrigger: abort)
        ..headers['Accept'] = 'text/event-stream'
        ..headers['Cache-Control'] = 'no-cache',
      timeout,
    );
    if (response.statusCode != 200) {
      final text = await _text(response);
      throw requestError(response.statusCode, uri.host, _problem(text));
    }
    return response;
  }

  // HTTP ----------------------------------------------------------------------

  /// Sends a request built by [build] with credentials; on 401, once more
  /// with refreshed OAuth credentials, or with the password as a bearer
  /// token.
  Future<http.StreamedResponse> _authorized(http.BaseRequest Function() build, Duration timeout) async {
    var credentials = await _credentials();
    var response = await _exchange(build(), credentials, timeout);
    if (response.statusCode != 401) return response;
    switch (credentials) {
      case OAuthCredentials():
        await _drain(response);
        credentials = await _credentials(forceRefresh: true);
        response = await _exchange(build(), credentials, timeout);
      case PasswordCredentials() when !_bearerPassword:
        await _drain(response);
        _bearerPassword = true;
        response = await _exchange(build(), credentials, timeout);
        if (response.statusCode == 401) _bearerPassword = false;
      case PasswordCredentials():
        break;
    }
    return response;
  }

  Future<http.StreamedResponse> _exchange(http.BaseRequest request, Credentials credentials, Duration timeout) {
    request.headers['Authorization'] = _authorization(credentials);
    request.headers['User-Agent'] = userAgent;
    return _guard(request.url, () => _http.send(request).timeout(timeout));
  }

  String _authorization(Credentials credentials) => switch (credentials) {
    OAuthCredentials(:final accessToken) => 'Bearer $accessToken',
    PasswordCredentials(:final password) when _bearerPassword || looksLikeApiToken(password) => 'Bearer $password',
    PasswordCredentials(:final password) => 'Basic ${base64.encode(utf8.encode('$login:$password'))}',
  };

  /// Turns network failures into [MailException]s.
  Future<T> _guard<T>(Uri uri, Future<T> Function() body) async {
    _rejected = null;
    try {
      return await body();
    } on MailException {
      rethrow;
    } on Object catch (e) {
      final rejected = _rejected;
      if (rejected != null) {
        throw MailException(
          MailErrorKind.certificate,
          'The security certificate of ${rejected.host} is not trusted (SHA-256 ${rejected.sha256}).',
          rejected,
        );
      }
      if (e is TimeoutException) {
        throw MailException(MailErrorKind.connection, 'Connecting to ${uri.host} timed out.', e);
      }
      if (e is IOException || e is http.ClientException) {
        throw MailException(MailErrorKind.connection, 'Couldn’t reach ${uri.host}.', e);
      }
      throw MailException(MailErrorKind.unknown, 'Unexpected error talking to ${uri.host}.', e);
    }
  }

  Future<String> _text(http.StreamedResponse response) async =>
      utf8.decode(await _guard(response.request?.url ?? wellKnownUrl, response.stream.toBytes), allowMalformed: true);

  static Future<void> _drain(http.StreamedResponse response) async {
    try {
      await response.stream.drain<void>();
    } on Object {
      // Only freeing the connection.
    }
  }

  static Map<String, Object?>? _problem(String text) {
    try {
      final json = jsonDecode(text);
      return json is Map ? json.cast() : null;
    } on FormatException {
      return null;
    }
  }
}

/// Secrets that are API tokens rather than passwords: they go as bearer
/// tokens straight away (Fastmail's start with `fmu1-`).
bool looksLikeApiToken(String secret) => secret.startsWith('fmu1-');
