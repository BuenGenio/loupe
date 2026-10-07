/// Settings › End-to-End Encryption › Check Certificate Revocation Online
/// (off by default): signers' certificates checked with their authority
/// (OCSP, else its CRL) when signed mail is read, in the background; the
/// header updates when the answer comes. The authority learns when a
/// message from whom is read, hence opt-in.
library;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';

import '../../demo/demo_smime.dart';
import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart';
import '../openpgp/openpgp_providers.dart';
import 'smime_keys.dart';

/// "Check Certificate Revocation Online", persisted as `smime.checkRevocation`.
final checkRevocationProvider = NotifierProvider<CheckRevocation, bool>(CheckRevocation.new);

class CheckRevocation extends Notifier<bool> {
  static const key = 'smime.checkRevocation';

  @override
  bool build() {
    ref.watch(prefsEpochProvider);
    return ref.watch(sharedPreferencesProvider).getBool(key) ?? false;
  }

  Future<void> set(bool value) async {
    state = value;
    await ref.read(sharedPreferencesProvider).setBool(key, value);
  }
}

/// OCSP and CRLs over HTTP: strict timeouts, a size limit, plain requests
/// (no cookies, a generic user agent), redirects only for CRLs.
final class HttpRevocationFetcher implements SmimeRevocationFetcher {
  const HttpRevocationFetcher({
    this.connectTimeout = const Duration(seconds: 5),
    this.timeout = const Duration(seconds: 10),
  });

  final Duration connectTimeout;

  /// Longest a whole request may take.
  final Duration timeout;

  @override
  Future<Uint8List> postOcsp(Uri url, Uint8List request, {required int maxBytes}) => _fetch(
    'POST',
    url,
    maxBytes: maxBytes,
    body: request,
    contentType: 'application/ocsp-request',
    accept: 'application/ocsp-response',
  );

  @override
  Future<Uint8List> getCrl(Uri url, {required int maxBytes}) =>
      _fetch('GET', url, maxBytes: maxBytes, accept: 'application/pkix-crl, application/pkcs7-mime, */*');

  Future<Uint8List> _fetch(
    String method,
    Uri url, {
    required int maxBytes,
    required String accept,
    Uint8List? body,
    String? contentType,
  }) async {
    if (url.scheme != 'http' && url.scheme != 'https') {
      throw const SmimeException(SmimeErrorKind.unsupported, 'The authority’s address isn’t a web address.');
    }
    final client = HttpClient()
      ..connectionTimeout = connectTimeout
      ..idleTimeout = const Duration(seconds: 2)
      ..userAgent = 'Loupe';
    try {
      return await _send(client, method, url, maxBytes, accept, body, contentType).timeout(timeout);
    } on TimeoutException {
      throw const SmimeException(SmimeErrorKind.failed, 'The certificate authority didn’t answer in time.');
    } on IOException {
      throw const SmimeException(SmimeErrorKind.failed, 'The certificate authority couldn’t be reached.');
    } finally {
      client.close(force: true);
    }
  }

  static Future<Uint8List> _send(
    HttpClient client,
    String method,
    Uri url,
    int maxBytes,
    String accept,
    Uint8List? body,
    String? contentType,
  ) async {
    final request = await client.openUrl(method, url);
    request
      ..followRedirects = method == 'GET'
      ..maxRedirects = 3
      ..persistentConnection = false;
    request.headers.set(HttpHeaders.acceptHeader, accept);
    if (body != null) {
      request.headers.set(HttpHeaders.contentTypeHeader, contentType ?? 'application/octet-stream');
      request.contentLength = body.length;
      request.add(body);
    }
    final response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      await response.drain<void>();
      throw SmimeException(SmimeErrorKind.failed, 'The certificate authority answered ${response.statusCode}.');
    }
    if (response.contentLength > maxBytes) {
      throw const SmimeException(SmimeErrorKind.malformed, 'The certificate authority’s answer is too large.');
    }
    final out = BytesBuilder(copy: false);
    await for (final chunk in response) {
      out.add(chunk);
      if (out.length > maxBytes) {
        throw const SmimeException(SmimeErrorKind.malformed, 'The certificate authority’s answer is too large.');
      }
    }
    return out.takeBytes();
  }
}

/// The network side: HTTP, or the demo's answers made in advance (the demo
/// never goes online). Tests replace it.
final revocationFetcherProvider = Provider<SmimeRevocationFetcher>(
  (ref) => ref.watch(appModeProvider) == AppMode.demo ? const DemoRevocationFetcher() : const HttpRevocationFetcher(),
);

/// The checker while the setting is on (null when off). Its answers are
/// kept in the keychain until they expire, next to the certificates.
final revocationCheckerProvider = FutureProvider<SmimeRevocationChecker?>((ref) async {
  if (!ref.watch(checkRevocationProvider)) return null;
  final demo = ref.watch(appModeProvider) == AppMode.demo;
  final storage = demo ? MemoryKeyringStorage() : ref.watch(keyringStorageProvider);
  final key = '${demo ? 'demo.smime' : liveSmimePrefix}.revocation';
  SmimeRevocationCache cache;
  try {
    cache = SmimeRevocationCache.decode(await storage.read(key));
  } on Object {
    cache = SmimeRevocationCache();
  }
  final run = ref.watch(pgpRunnerProvider);
  late final SmimeRevocationChecker checker;
  checker = SmimeRevocationChecker(
    fetcher: ref.watch(revocationFetcherProvider),
    cache: cache,
    run: <T>(T Function() work) => run(work),
    onChange: () => unawaited(storage.write(key, checker.cache.encode(DateTime.now())).catchError((Object _) {})),
  );
  return checker;
});

/// The revocation status of [signature]'s certificate, checked in the
/// background; null while the setting is off, without a certificate, or
/// until the answer comes.
///
/// Only a valid signature by a certificate that chains to a trusted
/// authority is checked: the address to ask comes from the certificate, and
/// any other (one made by the sender of spam, say) could name a server of
/// its own, which would learn when the message is opened.
final signerRevocationProvider = FutureProvider.autoDispose.family<SmimeRevocationStatus?, SmimeSignatureStatus>((
  ref,
  signature,
) async {
  final checker = await ref.watch(revocationCheckerProvider.future);
  final cert = signature.certificate;
  final trust = signature.trust;
  if (checker == null || cert == null || trust == null) return null;
  // Its issuer, on the path the trust check verified up to a trusted root.
  final issuer = trust.chain.length > 1 ? trust.chain[1] : null;
  final verified = signature.valid && trust.anchor != null && !trust.problems.contains(SmimeProblem.invalidChain);
  if (!verified || issuer == null) {
    final now = DateTime.now();
    return SmimeRevocationStatus(
      state: SmimeRevocationState.unknown,
      checkedAt: now,
      validUntil: now,
      problem: 'Not checked: only certificates from an authority Loupe trusts are checked.',
    );
  }
  return checker.check(cert, issuer);
});
