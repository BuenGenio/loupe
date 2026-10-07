/// Reading S/MIME mail (RFC 8551): `application/pkcs7-mime` (enveloped,
/// authEnveloped and opaque signed data) and `multipart/signed` with
/// `application/pkcs7-signature`, nested as clients send them.
library;

import 'dart:typed_data';

import '../mime/codecs.dart';
import '../mime/entity.dart';
import '../mime/header_protection.dart';
import '../pgp/types.dart' show emailOfUserId;
import '../pgp_mime/reader.dart' show headerIn;
import 'backend.dart';
import 'certificate.dart';
import 'cms.dart';
import 'der.dart';
import 'key_handle.dart';
import 'oids.dart';
import 'status.dart';
import 'trust.dart';

const _mimeTypes = {'application/pkcs7-mime', 'application/x-pkcs7-mime'};
const _signatureTypes = {'application/pkcs7-signature', 'application/x-pkcs7-signature'};

/// Content types whose parts are S/MIME plumbing, not attachments.
const smimePlumbingTypes = {..._mimeTypes, ..._signatureTypes};

/// How a message is protected, from its top-level header fields. Cheap:
/// no crypto, no body.
SmimeProtection detectSmime(List<(String, String)> headers) {
  final ct = HeaderValue.parse(headerIn(headers, 'content-type'));
  return _protectionOf(ct, null);
}

SmimeProtection _protectionOf(HeaderValue ct, String? filename) {
  final type = ct.value;
  if (type == 'multipart/signed' && _signatureTypes.contains(ct['protocol']?.toLowerCase())) {
    return SmimeProtection.signedDetached;
  }
  final p7m = type == 'application/octet-stream' && (filename ?? ct['name'] ?? '').toLowerCase().endsWith('.p7m');
  if (!_mimeTypes.contains(type) && !p7m) return SmimeProtection.none;
  return switch (ct['smime-type']?.toLowerCase()) {
    'enveloped-data' => SmimeProtection.enveloped,
    'authenveloped-data' => SmimeProtection.authEnveloped,
    'signed-data' => SmimeProtection.signedOpaque,
    'certs-only' || 'compressed-data' => SmimeProtection.none,
    // No smime-type (older clients): the CMS content type decides when read.
    _ => SmimeProtection.enveloped,
  };
}

/// What reading a message gave.
final class SmimeReadResult {
  const SmimeReadResult({required this.status, this.entity});

  final SmimeMessageStatus status;

  /// The entity to show: the decrypted or opaque-signed content, or the
  /// signed part of a `multipart/signed`. Null when there is none.
  final MimeEntity? entity;
}

/// Reads S/MIME messages with a [SmimeBackend]. Synchronous and pure, so
/// callers can run it in an isolate.
final class SmimeReader {
  const SmimeReader(this.backend);

  final SmimeBackend backend;

  /// Layers of protection unwrapped at most (signed, encrypted, signed again…).
  static const maxLayers = 4;

  /// Who the encrypted payload of [raw] is for; empty if it isn't encrypted.
  List<SmimeRecipientId> recipientsOf(Uint8List raw) {
    final root = MimeEntity.parse(raw);
    final kind = _kind(root);
    if (kind != SmimeProtection.enveloped && kind != SmimeProtection.authEnveloped) return const [];
    try {
      return backend.recipientsOf(root.decodedBody);
    } on SmimeException {
      return const [];
    }
  }

  /// Decrypts and verifies [raw] (RFC 822 bytes) with the user's [keys];
  /// signers' certificates are checked against [anchors] at their signing
  /// time, through the message's certificates and [known] ones, for
  /// [sender] (the From address unless given).
  SmimeReadResult read(
    Uint8List raw, {
    List<SmimeKeyPair> keys = const [],
    SmimeTrustAnchors? anchors,
    List<SmimeCertificate> known = const [],
    DateTime? now,
    String? sender,
  }) {
    final root = MimeEntity.parse(raw);
    final from = sender ?? _address(root.header('from'));
    final at = now ?? DateTime.now();
    final trustAnchors = anchors ?? SmimeTrustAnchors.withMozilla();
    SmimeProtection? protection;
    var encrypted = false;
    String? cipher;
    var authenticated = false;
    var recipients = const <SmimeRecipientId>[];
    SmimeSignatureStatus? signature;
    var entity = root;
    var unwrapped = false;

    SmimeMessageStatus status({
      SmimeDecryptFailure? failure,
      String? message,
      SmimeKeyRequest? request,
      List<(String, String)> protectedHeaders = const [],
    }) => SmimeMessageStatus(
      protection: protection ?? SmimeProtection.none,
      encrypted: encrypted,
      failure: failure,
      failureMessage: message,
      cipher: cipher,
      authenticated: authenticated,
      recipients: recipients,
      signature: signature,
      keyRequest: request,
      protectedHeaders: protectedHeaders,
    );

    for (var layer = 0; layer < maxLayers; layer++) {
      var kind = _kind(entity);
      if (kind == SmimeProtection.none) break;
      if (kind == SmimeProtection.signedDetached) {
        if (entity.parts.length < 2) break;
        protection ??= kind;
        // RFC 1847: the signed part, then the signature, and nothing else.
        // What is shown is exactly the signed part (the entity verified):
        // parts next to it aren't covered, so they make the signature bad.
        final signed = entity.parts[0];
        final p7s = entity.parts[1];
        var checked = _verify(p7s.decodedBody, canonicalLineEnds(signed.raw), known, trustAnchors, at, from);
        if (entity.parts.length != 2) checked = checked.notCovering(_extraParts);
        signature = _combine(signature, checked);
        entity = signed;
        unwrapped = true;
        continue;
      }
      final der = entity.decodedBody;
      kind = _sniff(der) ?? kind;
      if (kind == SmimeProtection.signedOpaque) {
        protection ??= kind;
        final checked = _verifyOpaque(der, known, trustAnchors, at, from);
        signature = _combine(signature, checked.$2);
        if (checked.$1 == null) return SmimeReadResult(status: status());
        entity = MimeEntity.parse(checked.$1!);
        unwrapped = true;
        continue;
      }
      if (kind == SmimeProtection.none) break;
      protection ??= kind;
      encrypted = true;
      // A signature around encrypted data only covers the ciphertext: anyone
      // can sign someone else's. Only signatures inside count (as Thunderbird).
      signature = null;
      try {
        recipients = backend.recipientsOf(der);
        final decrypted = backend.decrypt(der, keys);
        cipher ??= decrypted.cipher;
        authenticated = decrypted.authenticated;
        entity = MimeEntity.parse(decrypted.content);
        unwrapped = true;
      } on SmimeKeyRequired catch (e) {
        // A key on the device must decrypt the content key: the caller asks
        // it and reads again with the answer.
        return SmimeReadResult(
          status: status(failure: SmimeDecryptFailure.locked, message: e.message, request: e.request),
        );
      } on SmimeException catch (e) {
        return SmimeReadResult(
          status: status(failure: _failure(e), message: e.message),
        );
      }
    }
    if (protection == null) return const SmimeReadResult(status: SmimeMessageStatus.none);
    // The Date header isn't signed: more than an hour from the signing time
    // is an old signed message sent again, or a changed date (Thunderbird's rule).
    final signedAt = signature?.signingTime;
    final date = parseMailDate(root.header('date'));
    if (signature != null && signedAt != null && date != null && date.difference(signedAt).abs() > dateTolerance) {
      signature = signature.withDateMismatch();
    }
    // The cryptographic payload's own header fields (RFC 9788).
    final protectedHeaders = unwrapped ? protectedHeadersOf(entity) : const <(String, String)>[];
    return SmimeReadResult(
      status: status(protectedHeaders: protectedHeaders),
      entity: unwrapped ? entity : null,
    );
  }

  /// How far the signing time may be from the Date header.
  static const dateTolerance = Duration(hours: 1);

  static const _extraParts = 'The message has parts the signature doesn’t cover.';

  /// The signature to report of nested ones: the outermost, unless an
  /// inner one is bad (a bad signature is never hidden by a good one).
  static SmimeSignatureStatus? _combine(SmimeSignatureStatus? outer, SmimeSignatureStatus inner) {
    if (outer == null) return inner;
    if (outer.valid && !inner.valid) return inner;
    return outer;
  }

  SmimeProtection _kind(MimeEntity e) => _protectionOf(e.contentType, e.filename);

  /// The protection a CMS ContentInfo really is, whatever its header said.
  SmimeProtection? _sniff(Uint8List der) {
    try {
      return switch (contentInfo(der).$1) {
        Oid.envelopedData => SmimeProtection.enveloped,
        Oid.authEnvelopedData => SmimeProtection.authEnveloped,
        Oid.signedData => SmimeProtection.signedOpaque,
        _ => SmimeProtection.none,
      };
    } on Asn1Exception {
      return null;
    }
  }

  (Uint8List?, SmimeSignatureStatus) _verifyOpaque(
    Uint8List der,
    List<SmimeCertificate> known,
    SmimeTrustAnchors anchors,
    DateTime now,
    String? sender,
  ) {
    try {
      final signed = backend.verify(der, known: known);
      return (signed.content, _status(signed, known, anchors, now, sender));
    } on SmimeException catch (e) {
      return (null, SmimeSignatureStatus(valid: false, problem: e.message));
    }
  }

  SmimeSignatureStatus _verify(
    Uint8List p7s,
    Uint8List content,
    List<SmimeCertificate> known,
    SmimeTrustAnchors anchors,
    DateTime now,
    String? sender,
  ) {
    try {
      return _status(backend.verify(p7s, content: content, known: known), known, anchors, now, sender);
    } on SmimeException catch (e) {
      return SmimeSignatureStatus(valid: false, problem: e.message);
    }
  }

  SmimeSignatureStatus _status(
    SmimeSignedData signed,
    List<SmimeCertificate> known,
    SmimeTrustAnchors anchors,
    DateTime now,
    String? sender,
  ) {
    if (signed.signers.isEmpty) {
      return SmimeSignatureStatus(valid: false, problem: 'There is no signature.', certificates: signed.certificates);
    }
    final signer = signed.signers.where((s) => s.valid).firstOrNull ?? signed.signers.first;
    final cert = signer.certificate;
    // The certificate counts when it signed; a signing time from the future counts as now.
    final signedAt = signer.signingTime;
    final at = signedAt != null && !signedAt.isAfter(now.add(const Duration(days: 1))) ? signedAt : now;
    final trust = cert == null
        ? null
        : checkTrust(
            cert,
            anchors: anchors,
            intermediates: [...signed.certificates, ...known],
            at: at,
            usage: SmimeUsage.signing,
            email: sender,
            signedBy: backend.certificateSignedBy,
          );
    return SmimeSignatureStatus(
      valid: signer.valid,
      certificate: cert,
      signingTime: signedAt,
      trust: trust,
      problem: signer.problem,
      modified: signer.modified,
      weak: signer.weak,
      capabilities: signer.capabilities,
      certificates: signed.certificates,
    );
  }

  /// The first address of a From field (a quoted name may hold commas).
  static String? _address(String? from) => from == null ? null : emailOfUserId(from);

  static SmimeDecryptFailure _failure(SmimeException e) => switch (e.kind) {
    SmimeErrorKind.noKey => SmimeDecryptFailure.noKey,
    SmimeErrorKind.unsupported => SmimeDecryptFailure.unsupported,
    SmimeErrorKind.locked => SmimeDecryptFailure.locked,
    _ => SmimeDecryptFailure.damaged,
  };
}

const _months = {
  'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6, //
  'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12,
};

const _zones = {
  'ut': 0,
  'gmt': 0,
  'z': 0,
  'edt': -4,
  'est': -5,
  'cdt': -5,
  'cst': -6,
  'mdt': -6,
  'mst': -7,
  'pdt': -7,
  'pst': -8,
};

/// An RFC 5322 date (`Wed, 08 Jul 2026 17:36:38 +0000`), in UTC; null when it can't be read.
DateTime? parseMailDate(String? value) {
  if (value == null) return null;
  final m = RegExp(
    r'(\d{1,2})\s+([A-Za-z]{3})[a-z]*\s+(\d{2,4})\s+(\d{1,2}):(\d{2})(?::(\d{2}))?\s*([+-]\d{4}|[A-Za-z]+)?',
  ).firstMatch(value);
  if (m == null) return null;
  final month = _months[m.group(2)!.toLowerCase()];
  if (month == null) return null;
  var year = int.parse(m.group(3)!);
  if (year < 100) year += year < 50 ? 2000 : 1900;
  var t = DateTime.utc(
    year,
    month,
    int.parse(m.group(1)!),
    int.parse(m.group(4)!),
    int.parse(m.group(5)!),
    int.parse(m.group(6) ?? '0'),
  );
  final zone = m.group(7);
  if (zone != null) {
    if (zone.startsWith('+') || zone.startsWith('-')) {
      final minutes = int.parse(zone.substring(1, 3)) * 60 + int.parse(zone.substring(3, 5));
      t = t.subtract(Duration(minutes: zone.startsWith('+') ? minutes : -minutes));
    } else {
      t = t.subtract(Duration(hours: _zones[zone.toLowerCase()] ?? 0));
    }
  }
  return t;
}
