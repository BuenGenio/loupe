/// Reading S/MIME mail (RFC 8551): `application/pkcs7-mime` (enveloped,
/// authEnveloped and opaque signed data) and `multipart/signed` with
/// `application/pkcs7-signature`, nested as clients send them.
library;

import 'dart:typed_data';

import '../mime/codecs.dart';
import '../mime/entity.dart';
import '../pgp/types.dart' show emailOfUserId;
import '../pgp_mime/reader.dart' show headerIn;
import 'backend.dart';
import 'certificate.dart';
import 'cms.dart';
import 'der.dart';
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

    SmimeMessageStatus status({SmimeDecryptFailure? failure, String? message}) => SmimeMessageStatus(
      protection: protection ?? SmimeProtection.none,
      encrypted: encrypted,
      failure: failure,
      failureMessage: message,
      cipher: cipher,
      authenticated: authenticated,
      recipients: recipients,
      signature: signature,
    );

    for (var layer = 0; layer < maxLayers; layer++) {
      var kind = _kind(entity);
      if (kind == SmimeProtection.none) break;
      if (kind == SmimeProtection.signedDetached) {
        if (entity.parts.length < 2) break;
        protection ??= kind;
        final signed = entity.parts[0];
        final p7s = entity.parts
            .skip(1)
            .firstWhere(
              (p) => _signatureTypes.contains(p.mimeType) || (p.filename ?? '').toLowerCase().endsWith('.p7s'),
              orElse: () => entity.parts[1],
            );
        signature ??= _verify(p7s.decodedBody, canonicalLineEnds(signed.raw), known, trustAnchors, at, from);
        entity = signed;
        unwrapped = true;
        continue;
      }
      final der = entity.decodedBody;
      kind = _sniff(der) ?? kind;
      if (kind == SmimeProtection.signedOpaque) {
        protection ??= kind;
        final checked = _verifyOpaque(der, known, trustAnchors, at, from);
        signature ??= checked.$2;
        if (checked.$1 == null) return SmimeReadResult(status: status());
        entity = MimeEntity.parse(checked.$1!);
        unwrapped = true;
        continue;
      }
      if (kind == SmimeProtection.none) break;
      protection ??= kind;
      encrypted = true;
      try {
        recipients = backend.recipientsOf(der);
        final decrypted = backend.decrypt(der, keys);
        cipher ??= decrypted.cipher;
        authenticated = decrypted.authenticated;
        entity = MimeEntity.parse(decrypted.content);
        unwrapped = true;
      } on SmimeException catch (e) {
        return SmimeReadResult(
          status: status(failure: _failure(e), message: e.message),
        );
      }
    }
    if (protection == null) return const SmimeReadResult(status: SmimeMessageStatus.none);
    return SmimeReadResult(status: status(), entity: unwrapped ? entity : null);
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
      capabilities: signer.capabilities,
      certificates: signed.certificates,
    );
  }

  /// The first address of a From field (a quoted name may hold commas).
  static String? _address(String? from) => from == null ? null : emailOfUserId(from);

  static SmimeDecryptFailure _failure(SmimeException e) => switch (e.kind) {
    SmimeErrorKind.noKey => SmimeDecryptFailure.noKey,
    SmimeErrorKind.unsupported => SmimeDecryptFailure.unsupported,
    _ => SmimeDecryptFailure.damaged,
  };
}
