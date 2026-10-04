/// Whether a certificate can be trusted for mail: a chain to a trusted
/// root (Mozilla's email roots, or one the user trusts), validity, key
/// usage and the address (RFC 5280 path validation, simplified as mail
/// clients do it: no policy processing, no revocation).
library;

import 'dart:convert';

import 'certificate.dart';
import 'mozilla_roots.dart';

/// What a certificate is checked for.
enum SmimeUsage { signing, encryption }

/// Why a certificate isn't trusted, most serious first.
enum SmimeProblem {
  /// A certificate in the chain is invalid: a bad signature, a CA that
  /// isn't one, a critical extension Loupe doesn't know, an address
  /// outside the CA's name constraints.
  invalidChain,

  /// No chain to a root Loupe trusts.
  untrusted,

  /// The certificate (or a CA above it) had expired.
  expired,

  /// The certificate (or a CA above it) wasn't valid yet.
  notYetValid,

  /// Not a certificate for signing or encrypting mail (key usage).
  wrongUsage,

  /// The address isn't one of the certificate's.
  wrongAddress,
}

/// The outcome of checking a certificate.
final class SmimeTrustCheck {
  const SmimeTrustCheck({required this.chain, this.anchor, this.problems = const {}, this.at});

  /// The certificate first, then its issuers as far as they were found
  /// (up to [anchor] when the chain is complete).
  final List<SmimeCertificate> chain;

  /// The trusted root (or user-trusted certificate) the chain ends at.
  final SmimeCertificate? anchor;
  final Set<SmimeProblem> problems;

  /// When the certificate was checked for (the signing time, or now).
  final DateTime? at;

  bool get trusted => problems.isEmpty;

  /// The most serious problem.
  SmimeProblem? get problem => SmimeProblem.values.where(problems.contains).firstOrNull;

  SmimeCertificate get certificate => chain.first;

  /// The CA that issued the certificate, by name (a trusted one or not).
  String get issuerName => chain.length > 1 ? chain[1].displayName : certificate.issuerName;
}

/// The roots Loupe trusts for mail: Mozilla's list and the user's own.
final class SmimeTrustAnchors {
  SmimeTrustAnchors(Iterable<SmimeCertificate> anchors) : anchors = List.unmodifiable(anchors);

  /// Mozilla's email roots plus [user] (CAs or single certificates the user trusts).
  factory SmimeTrustAnchors.withMozilla([Iterable<SmimeCertificate> user = const []]) =>
      SmimeTrustAnchors([...mozillaRoots, ...user]);

  final List<SmimeCertificate> anchors;

  bool isAnchor(SmimeCertificate c) => anchors.any((a) => a == c || (a.subject.matches(c.subject) && a.sameKey(c)));
}

/// Mozilla's email roots, parsed once per isolate.
final List<SmimeCertificate> mozillaRoots = () {
  final out = <SmimeCertificate>[];
  for (final (_, b64) in mozillaEmailRoots) {
    try {
      out.add(SmimeCertificate.fromDer(base64.decode(b64)));
    } on SmimeException {
      // Skipped: a root this parser can't read can't anchor anything.
    }
  }
  return List<SmimeCertificate>.unmodifiable(out);
}();

/// Checks [certificate] for [usage] at [at] (when it signed, or now):
/// builds a chain through [intermediates] to one of [anchors], checking
/// each signature with [signedBy], and checks validity, CA constraints,
/// key usage and, when given, that [email] is one of its addresses.
SmimeTrustCheck checkTrust(
  SmimeCertificate certificate, {
  required SmimeTrustAnchors anchors,
  Iterable<SmimeCertificate> intermediates = const [],
  required DateTime at,
  required SmimeUsage usage,
  String? email,
  required bool Function(SmimeCertificate cert, SmimeCertificate issuer) signedBy,
}) {
  // CAs first; a certificate that isn't one can still be on the path (and makes it invalid).
  final pool = [
    for (final c in intermediates)
      if (c.isCa || c.version < 3) c,
    for (final c in intermediates)
      if (!c.isCa && c.version >= 3 && c != certificate) c,
  ];
  final problems = <SmimeProblem>{};
  final path = _buildPath(certificate, anchors, pool, signedBy);
  final List<SmimeCertificate> chain;
  SmimeCertificate? anchor;
  if (path == null) {
    problems.add(SmimeProblem.untrusted);
    chain = _byName(certificate, [...anchors.anchors, ...pool]);
  } else {
    chain = path;
    anchor = path.last;
  }
  for (final (i, c) in chain.indexed) {
    if (at.isBefore(c.notBefore)) problems.add(SmimeProblem.notYetValid);
    if (at.isAfter(c.notAfter)) problems.add(SmimeProblem.expired);
    if (c.unknownCriticalExtensions.isNotEmpty) problems.add(SmimeProblem.invalidChain);
    if (i == 0 || path == null) continue;
    // An issuer must be a CA (v1 roots predate the flag), may sign
    // certificates, allows this many CAs below it, and permits the addresses.
    if (c.version >= 3 && !c.isCa) problems.add(SmimeProblem.invalidChain);
    if (c.keyUsage != null && c.keyUsage! & KeyUsage.keyCertSign == 0) problems.add(SmimeProblem.invalidChain);
    final below = chain.sublist(1, i).where((x) => !x.isSelfIssued).length;
    if (c.pathLength != null && below > c.pathLength!) problems.add(SmimeProblem.invalidChain);
    if (!_withinConstraints(certificate.emails, c)) problems.add(SmimeProblem.invalidChain);
  }
  final usable = switch (usage) {
    SmimeUsage.signing => certificate.canSign,
    SmimeUsage.encryption => certificate.canEncrypt,
  };
  if (!usable) problems.add(SmimeProblem.wrongUsage);
  if (email != null && !certificate.hasEmail(email)) problems.add(SmimeProblem.wrongAddress);
  return SmimeTrustCheck(chain: chain, anchor: anchor, problems: problems, at: at);
}

/// A chain from [leaf] to an anchor, every signature checked; null when there is none.
List<SmimeCertificate>? _buildPath(
  SmimeCertificate leaf,
  SmimeTrustAnchors anchors,
  List<SmimeCertificate> pool,
  bool Function(SmimeCertificate, SmimeCertificate) signedBy,
) {
  if (anchors.isAnchor(leaf)) return [leaf];
  List<SmimeCertificate>? walk(List<SmimeCertificate> path) {
    final cert = path.last;
    if (path.length > 8) return null;
    final candidates = [
      for (final c in anchors.anchors) (c, true),
      for (final c in pool) (c, false),
    ].where((e) => _mayHaveIssued(e.$1, cert) && !path.contains(e.$1));
    for (final (issuer, isAnchor) in candidates) {
      if (!signedBy(cert, issuer)) continue;
      final next = [...path, issuer];
      if (isAnchor || anchors.isAnchor(issuer)) return next;
      final found = walk(next);
      if (found != null) return found;
    }
    return null;
  }

  return walk([leaf]);
}

bool _mayHaveIssued(SmimeCertificate issuer, SmimeCertificate cert) {
  if (!issuer.subject.matches(cert.issuer)) return false;
  final aki = cert.authorityKeyId;
  final ski = issuer.subjectKeyId;
  if (aki == null || ski == null) return true;
  if (aki.length != ski.length) return false;
  for (var i = 0; i < aki.length; i++) {
    if (aki[i] != ski[i]) return false;
  }
  return true;
}

/// The issuers of [leaf] by name only (for showing an untrusted chain).
List<SmimeCertificate> _byName(SmimeCertificate leaf, List<SmimeCertificate> pool) {
  final chain = [leaf];
  while (chain.length < 8 && !chain.last.isSelfIssued) {
    final next = pool.where((c) => _mayHaveIssued(c, chain.last) && !chain.contains(c)).firstOrNull;
    if (next == null) break;
    chain.add(next);
  }
  return chain;
}

/// RFC 5280 §4.2.1.10 for rfc822Name constraints: a mailbox, a host, or
/// (with a leading dot) any host in a domain.
bool _withinConstraints(List<String> emails, SmimeCertificate ca) {
  if (ca.permittedEmails.isEmpty && ca.excludedEmails.isEmpty) return true;
  bool matches(String email, String constraint) {
    if (constraint.contains('@')) return email == constraint;
    final host = email.substring(email.lastIndexOf('@') + 1);
    if (constraint.startsWith('.')) return host.endsWith(constraint);
    return host == constraint;
  }

  for (final e in emails) {
    if (ca.excludedEmails.any((x) => matches(e, x))) return false;
    if (ca.permittedEmails.isNotEmpty && !ca.permittedEmails.any((x) => matches(e, x))) return false;
  }
  return true;
}
