/// Revocation checking of signers' certificates (opt-in): OCSP (RFC 6960,
/// the lightweight profile of RFC 5019) where the certificate names a
/// responder, else the issuer's CRL (RFC 5280 §5).
///
/// It is a network request to the certificate authority when a signed
/// message is read, so the authority can tell who reads whose mail and
/// when: off unless the user turns it on. Answers are kept until they
/// expire (nextUpdate). Responses are hostile input: parsed by the same
/// bounded ASN.1 reader as everything else, every signature checked, the
/// responder authorised (the issuer itself, or a certificate the issuer
/// made for OCSP signing), the answer about exactly this certificate, and
/// within its validity.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'certificate.dart';
import 'cms.dart' show certificateSignedBy, verifySignature;
import 'der.dart';
import 'oids.dart';
import 'primitives.dart' show constantEquals, digest, digestFor, minRsaBits;

/// What revocation checking found.
enum SmimeRevocationState {
  /// The authority says the certificate isn't revoked.
  good,

  /// The authority revoked it.
  revoked,

  /// No answer that counts: the authority doesn't know it, couldn't be
  /// reached, or its answer wasn't valid.
  unknown,
}

/// Where the answer came from.
enum SmimeRevocationSource { ocsp, crl }

/// The answer about one certificate.
final class SmimeRevocationStatus {
  const SmimeRevocationStatus({
    required this.state,
    required this.checkedAt,
    required this.validUntil,
    this.source,
    this.revokedAt,
    this.reason,
    this.problem,
  });

  final SmimeRevocationState state;
  final DateTime checkedAt;

  /// Until when the answer is reused: the response's nextUpdate, or a short
  /// while (an hour; ten minutes for no answer).
  final DateTime validUntil;
  final SmimeRevocationSource? source;
  final DateTime? revokedAt;

  /// Why it was revoked, in words ("key compromise").
  final String? reason;

  /// Why there is no answer, in words.
  final String? problem;

  bool get revoked => state == SmimeRevocationState.revoked;

  Map<String, Object?> toJson() => {
    'state': state.name,
    'checked': checkedAt.toUtc().toIso8601String(),
    'until': validUntil.toUtc().toIso8601String(),
    'source': ?source?.name,
    'revoked': ?revokedAt?.toUtc().toIso8601String(),
    'reason': ?reason,
    'problem': ?problem,
  };

  static SmimeRevocationStatus? fromJson(Map<String, Object?> j) {
    final state = SmimeRevocationState.values.asNameMap()[j['state']];
    final checked = DateTime.tryParse(j['checked'] as String? ?? '');
    final until = DateTime.tryParse(j['until'] as String? ?? '');
    if (state == null || checked == null || until == null) return null;
    return SmimeRevocationStatus(
      state: state,
      checkedAt: checked,
      validUntil: until,
      source: SmimeRevocationSource.values.asNameMap()[j['source']],
      revokedAt: DateTime.tryParse(j['revoked'] as String? ?? ''),
      reason: j['reason'] as String?,
      problem: j['problem'] as String?,
    );
  }

  @override
  String toString() => 'SmimeRevocationStatus(${state.name}, ${source?.name}, ${problem ?? reason ?? ''})';
}

/// Clocks differ: answers from a little in the future, or just expired, still count.
const revocationClockSkew = Duration(minutes: 5);

/// How long an answer without a nextUpdate is reused.
const revocationShortLife = Duration(hours: 1);

/// How long having no answer is remembered (the authority isn't asked again sooner).
const revocationRetryAfter = Duration(minutes: 10);

/// Largest OCSP response read; real ones are a few kilobytes.
const maxOcspResponseBytes = 64 * 1024;

/// Largest CRL read: big CAs publish a few megabytes.
const maxCrlBytes = 16 * 1024 * 1024;

/// Certificates an OCSP response may carry that are looked at.
const maxOcspCertificates = 8;

SmimeException _bad(String message, [Object? cause]) => SmimeException(SmimeErrorKind.malformed, message, cause);

// OCSP ------------------------------------------------------------------------------

/// The CertID of [cert] by [issuer], hashed with [hashOid].
Uint8List _certId(SmimeCertificate cert, SmimeCertificate issuer, String hashOid) => derSequence([
  derAlgorithm(hashOid, derNull),
  derOctets(digest(hashOid, cert.issuer.der)),
  derOctets(digest(hashOid, issuer.publicKey)),
  derInteger(cert.serialNumber),
]);

/// An OCSP request (RFC 6960 §4.1) for [cert], issued by [issuer]: one
/// CertID with SHA-1 (what every responder knows; RFC 5019), no nonce, so
/// pre-produced responses work.
Uint8List ocspRequest(SmimeCertificate cert, SmimeCertificate issuer) => derSequence([
  derSequence([
    derSequence([
      derSequence([_certId(cert, issuer, Oid.sha1)]),
    ]),
  ]),
]);

/// Reads an OCSP response about [cert] (issued by [issuer]) at [now]: its
/// status, or [SmimeRevocationState.unknown] with the reason when the
/// responder couldn't answer. Throws [SmimeException] for a response that
/// is damaged, isn't about [cert], isn't signed by the issuer or a
/// responder it authorised, or isn't current.
SmimeRevocationStatus readOcspResponse(
  Uint8List der, {
  required SmimeCertificate cert,
  required SmimeCertificate issuer,
  required DateTime now,
}) {
  if (der.length > maxOcspResponseBytes) throw _bad('The OCSP response is too large.');
  try {
    return _readOcsp(der, cert, issuer, now);
  } on SmimeException {
    rethrow;
  } on Object catch (e) {
    throw _bad('The OCSP response is damaged.', e);
  }
}

SmimeRevocationStatus _readOcsp(Uint8List der, SmimeCertificate cert, SmimeCertificate issuer, DateTime now) {
  final response = Asn1.parse(der)..expect(Tag.sequence, 'OCSPResponse');
  final status = response[0]..expect(0x0a, 'OCSPResponseStatus');
  final code = status.intValue;
  if (code != 0) {
    return SmimeRevocationStatus(
      state: SmimeRevocationState.unknown,
      checkedAt: now,
      validUntil: now.add(revocationRetryAfter),
      source: SmimeRevocationSource.ocsp,
      problem: switch (code) {
        1 => 'The authority’s OCSP responder refused a malformed request.',
        2 => 'The authority’s OCSP responder had an internal error.',
        3 => 'The authority’s OCSP responder is busy.',
        5 => 'The authority’s OCSP responder wants a signed request.',
        6 => 'The authority’s OCSP responder doesn’t answer for this certificate.',
        _ => 'The authority’s OCSP responder gave no answer.',
      },
    );
  }
  final bytes = response.context(0)?[0];
  if (bytes == null || bytes[0].oid != Oid.ocspBasic) throw _bad('Not a basic OCSP response.');
  final basic = Asn1.parse(bytes[1].octets)..expect(Tag.sequence, 'BasicOCSPResponse');
  final tbs = basic[0]..expect(Tag.sequence, 'ResponseData');
  final sigAlg = basic[1];
  final signature = basic[2].bits;
  final carried = <SmimeCertificate>[];
  for (final c in basic.context(0)?[0].children ?? const <Asn1>[]) {
    if (carried.length >= maxOcspCertificates) break;
    try {
      carried.add(SmimeCertificate.fromDer(c.encoded));
    } on SmimeException {
      // Unreadable: it can't be the responder.
    }
  }

  var i = 0;
  if (tbs[0].isContext(0)) {
    if (tbs[0][0].intValue != 0) throw _bad('Unknown OCSP response version.');
    i++;
  }
  final responderId = tbs[i++];
  final producedAt = tbs[i++].time;
  final responses = tbs[i++]..expect(Tag.sequence, 'responses');
  final extensions = tbs.context(1);
  if (extensions != null) _checkExtensions(extensions[0], const {Oid.ocspNonce});

  // The responder: the issuer itself, or a certificate the response carries.
  bool isResponder(SmimeCertificate c) {
    if (responderId.isContext(1)) return DistinguishedName.parse(responderId[0]).matches(c.subject);
    if (responderId.isContext(2)) return constantEquals(responderId[0].octets, digest(Oid.sha1, c.publicKey));
    return false;
  }

  final issuerIsResponder = isResponder(issuer);
  final SmimeCertificate responder;
  if (issuerIsResponder) {
    responder = issuer;
  } else {
    final delegated = carried.where(isResponder).firstOrNull;
    if (delegated == null) throw _bad('The OCSP response isn’t signed by the authority.');
    // RFC 6960 §4.2.2.2: issued by the CA for OCSP signing, valid now.
    if (!delegated.issuer.matches(issuer.subject) ||
        !(delegated.extendedKeyUsage?.contains(Oid.ocspSigning) ?? false) ||
        !delegated.isValidAt(now) ||
        delegated.unknownCriticalExtensions.isNotEmpty ||
        !certificateSignedBy(delegated, issuer)) {
      throw _bad('The OCSP response is signed by a responder the authority didn’t authorise.');
    }
    responder = delegated;
  }
  if (!_signedBy(responder, sigAlg, tbs.encoded, signature)) throw _bad('The OCSP response’s signature is invalid.');
  if (producedAt.isAfter(now.add(revocationClockSkew))) throw _bad('The OCSP response is from the future.');

  // The answer about exactly this certificate.
  for (final single in responses.children.take(64)) {
    final id = single[0];
    final hashOid = id[0][0].oid;
    if (digestFor(hashOid) == null || hashOid == Oid.md5) continue;
    if (!constantEquals(id.encoded, _certId(cert, issuer, hashOid)) && !_sameCertId(id, cert, issuer, hashOid)) {
      continue;
    }
    final certStatus = single[1];
    var j = 2;
    final thisUpdate = single[j++].time;
    DateTime? nextUpdate;
    if (single.length > j && single[j].isContext(0)) nextUpdate = single[j++][0].time;
    final singleExtensions = single.context(1);
    if (singleExtensions != null) _checkExtensions(singleExtensions[0], const {});
    if (thisUpdate.isAfter(now.add(revocationClockSkew))) throw _bad('The OCSP answer is from the future.');
    if (nextUpdate != null && now.isAfter(nextUpdate.add(revocationClockSkew))) {
      throw _bad('The OCSP answer is out of date.');
    }
    if (nextUpdate == null && now.difference(thisUpdate) > const Duration(days: 4)) {
      throw _bad('The OCSP answer is out of date.');
    }
    final until = nextUpdate ?? now.add(revocationShortLife);
    if (certStatus.isContext(0) && !certStatus.constructed) {
      return SmimeRevocationStatus(
        state: SmimeRevocationState.good,
        checkedAt: now,
        validUntil: until,
        source: SmimeRevocationSource.ocsp,
      );
    }
    if (certStatus.isContext(1) && certStatus.constructed) {
      final reason = certStatus.context(0);
      return SmimeRevocationStatus(
        state: SmimeRevocationState.revoked,
        checkedAt: now,
        validUntil: until,
        source: SmimeRevocationSource.ocsp,
        revokedAt: certStatus[0].time,
        reason: reason == null ? null : revocationReason(reason[0].intValue),
      );
    }
    if (certStatus.isContext(2)) {
      return SmimeRevocationStatus(
        state: SmimeRevocationState.unknown,
        checkedAt: now,
        validUntil: nextUpdate ?? now.add(revocationRetryAfter),
        source: SmimeRevocationSource.ocsp,
        problem: 'The authority doesn’t know this certificate.',
      );
    }
    throw _bad('The OCSP answer is damaged.');
  }
  throw _bad('The OCSP response isn’t about this certificate.');
}

/// Whether [signer]'s key made [signature] over [data] with [algorithm]
/// (MD5 and RSA keys under 2048 bits never; SHA-1 still, as responders
/// sign what they produce themselves, which leaves no room for a collision).
bool _signedBy(SmimeCertificate signer, Asn1 algorithm, Uint8List data, Uint8List signature) {
  if (signer.keyType == SmimeKeyType.rsa && signer.keyBits < minRsaBits) return false;
  final params = algorithm.length > 1 && algorithm[1].tag != Tag.nul ? algorithm[1] : null;
  try {
    return verifySignature(signer, algorithm[0].oid, params, Oid.sha256, data, signature);
  } on Object {
    return false;
  }
}

/// The same CertID, compared field by field (a responder may encode the
/// algorithm without its NULL parameters).
bool _sameCertId(Asn1 id, SmimeCertificate cert, SmimeCertificate issuer, String hashOid) =>
    id.length == 4 &&
    constantEquals(id[1].octets, digest(hashOid, cert.issuer.der)) &&
    constantEquals(id[2].octets, digest(hashOid, issuer.publicKey)) &&
    id[3].integer == cert.serialNumber;

/// Extensions: a critical one that isn't in [known] makes the response unusable (RFC 5280 §4.2).
void _checkExtensions(Asn1 extensions, Set<String> known) {
  for (final ext in extensions.children) {
    final critical = ext.length > 2 && ext[1].tag == Tag.boolean && ext[1].boolean;
    if (critical && !known.contains(ext[0].oid)) throw _bad('The answer has a critical extension Loupe doesn’t know.');
  }
}

/// CRLReason (RFC 5280 §5.3.1) in words.
String revocationReason(int code) => switch (code) {
  1 => 'key compromise',
  2 => 'CA compromise',
  3 => 'affiliation changed',
  4 => 'superseded',
  5 => 'cessation of operation',
  6 => 'certificate hold',
  9 => 'privilege withdrawn',
  10 => 'AA compromise',
  _ => 'unspecified',
};

// CRLs ------------------------------------------------------------------------------

/// Reads [issuer]'s CRL about [cert] at [now]. Throws [SmimeException] for
/// a list that is damaged, isn't [issuer]'s complete list (a delta, a
/// partitioned or indirect one), isn't signed by it, or is out of date.
SmimeRevocationStatus readCrl(
  Uint8List der, {
  required SmimeCertificate cert,
  required SmimeCertificate issuer,
  required DateTime now,
}) {
  if (der.length > maxCrlBytes) throw _bad('The revocation list is too large.');
  try {
    return _readCrl(der, cert, issuer, now);
  } on SmimeException {
    rethrow;
  } on Object catch (e) {
    throw _bad('The revocation list is damaged.', e);
  }
}

SmimeRevocationStatus _readCrl(Uint8List der, SmimeCertificate cert, SmimeCertificate issuer, DateTime now) {
  final list = Asn1.parse(der)..expect(Tag.sequence, 'CertificateList');
  final tbs = list[0]..expect(Tag.sequence, 'TBSCertList');
  final sigAlg = list[1];
  final signature = list[2].bits;
  var i = 0;
  if (tbs[0].tag == Tag.integer) {
    if (tbs[0].intValue != 1) throw _bad('Unknown revocation list version.');
    i++;
  }
  final innerAlg = tbs[i++];
  if (!constantEquals(innerAlg.encoded, sigAlg.encoded)) throw _bad('The revocation list’s algorithms differ.');
  final name = DistinguishedName.parse(tbs[i++]);
  if (!name.matches(cert.issuer) || !name.matches(issuer.subject)) {
    throw _bad('The revocation list is another authority’s.');
  }
  if (issuer.keyUsage != null && issuer.keyUsage! & KeyUsage.crlSign == 0) {
    throw _bad('The authority’s certificate may not sign revocation lists.');
  }
  if (!_signedBy(issuer, sigAlg, tbs.encoded, signature)) throw _bad('The revocation list’s signature is invalid.');
  final thisUpdate = tbs[i++].time;
  DateTime? nextUpdate;
  if (i < tbs.length && (tbs[i].tag == Tag.utcTime || tbs[i].tag == Tag.generalizedTime)) nextUpdate = tbs[i++].time;
  if (thisUpdate.isAfter(now.add(revocationClockSkew))) throw _bad('The revocation list is from the future.');
  if (nextUpdate != null && now.isAfter(nextUpdate.add(revocationClockSkew))) {
    throw _bad('The revocation list is out of date.');
  }
  if (nextUpdate == null && now.difference(thisUpdate) > const Duration(days: 7)) {
    throw _bad('The revocation list is out of date.');
  }
  Asn1? revoked;
  if (i < tbs.length && tbs[i].isSequence) revoked = tbs[i++];
  final crlExtensions = tbs.context(0);
  if (crlExtensions != null) {
    for (final ext in crlExtensions[0].children) {
      final id = ext[0].oid;
      final critical = ext.length > 2 && ext[1].tag == Tag.boolean && ext[1].boolean;
      // A delta list, or one covering only some certificates or reasons, isn't the whole answer.
      if (id == Oid.deltaCrlIndicator) throw _bad('Only part of a revocation list (a delta).');
      if (id == Oid.issuingDistributionPoint) _checkIssuingDistributionPoint(Asn1.parse(ext[ext.length - 1].octets));
      if (critical && id != Oid.issuingDistributionPoint && id != Oid.crlNumber) {
        throw _bad('The revocation list has a critical extension Loupe doesn’t know.');
      }
    }
  }
  final until = nextUpdate ?? now.add(revocationShortLife);
  final serial = _magnitude(Asn1.parse(derInteger(cert.serialNumber)).content);
  for (final entry in revoked?.children ?? const <Asn1>[]) {
    final number = entry[0]..expect(Tag.integer, 'userCertificate');
    if (!_sameBytes(_magnitude(number.content), serial)) continue;
    String? reason;
    if (entry.length > 2) {
      for (final ext in entry[2].children) {
        final critical = ext.length > 2 && ext[1].tag == Tag.boolean && ext[1].boolean;
        if (ext[0].oid == Oid.crlReason) reason = revocationReason(Asn1.parse(ext[ext.length - 1].octets).intValue);
        if (critical && ext[0].oid != Oid.crlReason && ext[0].oid != Oid.invalidityDate) {
          throw _bad('A revocation entry has a critical extension Loupe doesn’t know.');
        }
      }
    }
    // removeFromCRL (8) belongs in delta lists only; anything else listed is revoked.
    if (reason == revocationReason(8)) continue;
    return SmimeRevocationStatus(
      state: SmimeRevocationState.revoked,
      checkedAt: now,
      validUntil: until,
      source: SmimeRevocationSource.crl,
      revokedAt: entry[1].time,
      reason: reason,
    );
  }
  return SmimeRevocationStatus(
    state: SmimeRevocationState.good,
    checkedAt: now,
    validUntil: until,
    source: SmimeRevocationSource.crl,
  );
}

/// issuingDistributionPoint: only a list of everything the issuer
/// revoked, or of end entities' certificates, answers for a signer's.
void _checkIssuingDistributionPoint(Asn1 idp) {
  for (final field in idp.children) {
    if (field.isContext(0)) continue; // distributionPoint
    final on = field.content.length == 1 && field.content[0] != 0;
    if (field.isContext(1)) continue; // onlyContainsUserCerts: a signer's certificate is one
    if (on || field.isContext(3)) throw _bad('Only part of a revocation list.');
  }
}

Uint8List _magnitude(Uint8List bytes) {
  var start = 0;
  while (start < bytes.length - 1 && bytes[start] == 0) {
    start++;
  }
  return Uint8List.sublistView(bytes, start);
}

bool _sameBytes(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

// Checking ----------------------------------------------------------------------------

/// The network side of revocation checking (in the app: HTTP with strict
/// timeouts). Throws on any failure; never returns more than [maxBytes].
abstract interface class SmimeRevocationFetcher {
  /// POSTs an OCSP request to [url]; the response body.
  Future<Uint8List> postOcsp(Uri url, Uint8List request, {required int maxBytes});

  /// GETs a CRL from [url]; the body.
  Future<Uint8List> getCrl(Uri url, {required int maxBytes});
}

/// Answers by certificate, kept until they expire.
final class SmimeRevocationCache {
  SmimeRevocationCache([Map<String, SmimeRevocationStatus>? entries]) : _entries = entries ?? {};

  final Map<String, SmimeRevocationStatus> _entries;

  /// Entries kept at most (the oldest go first).
  static const maxEntries = 500;

  /// The answer about the certificate [fingerprint] still valid at [now], or null.
  SmimeRevocationStatus? lookup(String fingerprint, DateTime now) {
    final s = _entries[fingerprint];
    if (s == null) return null;
    if (now.isAfter(s.validUntil)) {
      _entries.remove(fingerprint);
      return null;
    }
    return s;
  }

  void put(String fingerprint, SmimeRevocationStatus status) {
    _entries
      ..remove(fingerprint)
      ..[fingerprint] = status;
    while (_entries.length > maxEntries) {
      _entries.remove(_entries.keys.first);
    }
  }

  void clear() => _entries.clear();

  int get length => _entries.length;

  /// The entries still valid at [now], as JSON.
  String encode(DateTime now) => jsonEncode({
    for (final MapEntry(:key, :value) in _entries.entries)
      if (!now.isAfter(value.validUntil)) key: value.toJson(),
  });

  /// A cache read from [encode]'s output; empty when it can't be read.
  static SmimeRevocationCache decode(String? stored) {
    final cache = SmimeRevocationCache();
    if (stored == null) return cache;
    try {
      for (final MapEntry(:key, :value) in (jsonDecode(stored) as Map).entries) {
        final s = SmimeRevocationStatus.fromJson((value as Map).cast());
        if (s != null) cache.put(key as String, s);
      }
    } on Object {
      // Damaged: started over.
    }
    return cache;
  }
}

/// Runs parsing somewhere (another isolate in the app).
typedef RevocationRunner = Future<T> Function<T>(T Function() work);

Future<T> _inline<T>(T Function() work) async => work();

/// Checks signers' certificates: OCSP when the certificate names a
/// responder, else the issuer's CRL; an answer is reused until it
/// expires, and one check runs per certificate however many ask.
final class SmimeRevocationChecker {
  SmimeRevocationChecker({
    required this.fetcher,
    SmimeRevocationCache? cache,
    RevocationRunner? run,
    this.timeout = const Duration(seconds: 15),
    this.onChange,
    DateTime Function()? clock,
  }) : cache = cache ?? SmimeRevocationCache(),
       _run = run ?? _inline,
       _clock = clock ?? DateTime.now;

  final SmimeRevocationFetcher fetcher;
  final SmimeRevocationCache cache;
  final RevocationRunner _run;

  /// Longest a whole check may take; then the answer is "unknown".
  final Duration timeout;

  /// Called after a new answer was cached (to save the cache).
  final void Function()? onChange;
  final DateTime Function() _clock;
  final _running = <String, Future<SmimeRevocationStatus>>{};

  /// The revocation status of [cert], issued by [issuer]. Never throws.
  Future<SmimeRevocationStatus> check(SmimeCertificate cert, SmimeCertificate issuer) {
    final cached = cache.lookup(cert.fingerprint, _clock());
    if (cached != null) return Future.value(cached);
    final key = cert.fingerprint;
    return _running[key] ??= _check(cert, issuer).whenComplete(() {
      _running.remove(key);
    });
  }

  Future<SmimeRevocationStatus> _check(SmimeCertificate cert, SmimeCertificate issuer) async {
    final started = _clock();
    SmimeRevocationStatus status;
    try {
      status = await _ask(cert, issuer).timeout(timeout);
    } on TimeoutException {
      status = _unknown(started, 'The certificate authority didn’t answer in time.');
    } on SmimeException catch (e) {
      status = _unknown(started, e.message);
    } on Object {
      status = _unknown(started, 'The certificate authority couldn’t be reached.');
    }
    cache.put(cert.fingerprint, status);
    onChange?.call();
    return status;
  }

  Future<SmimeRevocationStatus> _ask(SmimeCertificate cert, SmimeCertificate issuer) async {
    if (cert.ocspUrls.isNotEmpty) {
      final request = ocspRequest(cert, issuer);
      Object? last;
      for (final url in cert.ocspUrls.take(2)) {
        try {
          final der = await fetcher.postOcsp(Uri.parse(url), request, maxBytes: maxOcspResponseBytes);
          final now = _clock();
          return await _run(() => readOcspResponse(der, cert: cert, issuer: issuer, now: now));
        } on Object catch (e) {
          last = e;
        }
      }
      throw last is SmimeException
          ? last
          : const SmimeException(SmimeErrorKind.failed, 'The OCSP responder couldn’t be reached.');
    }
    if (cert.crlUrls.isNotEmpty) {
      Object? last;
      for (final url in cert.crlUrls.take(2)) {
        try {
          final der = await fetcher.getCrl(Uri.parse(url), maxBytes: maxCrlBytes);
          final now = _clock();
          return await _run(() => readCrl(der, cert: cert, issuer: issuer, now: now));
        } on Object catch (e) {
          last = e;
        }
      }
      throw last is SmimeException
          ? last
          : const SmimeException(SmimeErrorKind.failed, 'The revocation list couldn’t be downloaded.');
    }
    throw const SmimeException(SmimeErrorKind.unsupported, 'The certificate names no way to check its revocation.');
  }

  SmimeRevocationStatus _unknown(DateTime at, String problem) => SmimeRevocationStatus(
    state: SmimeRevocationState.unknown,
    checkedAt: at,
    validUntil: at.add(revocationRetryAfter),
    problem: problem,
  );
}
