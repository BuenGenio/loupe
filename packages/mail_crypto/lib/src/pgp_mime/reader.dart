/// Reading OpenPGP mail: RFC 3156 PGP/MIME (`multipart/encrypted`,
/// `multipart/signed`) and inline PGP, with protected headers.
library;

import 'dart:convert';
import 'dart:typed_data';

import '../mime/codecs.dart';
import '../mime/entity.dart';
import '../pgp/armor.dart';
import '../pgp/types.dart';
import 'status.dart';

/// The first value of [name] in [headers] (case-insensitive).
String? headerIn(List<(String, String)> headers, String name) {
  final n = name.toLowerCase();
  for (final (k, v) in headers) {
    if (k.toLowerCase() == n) return v;
  }
  return null;
}

/// How a message is protected, from its top-level header fields and the
/// text body the transport already decoded. Cheap: no crypto, no parsing
/// of the body.
PgpProtection detectProtection(List<(String, String)> headers, {String? text}) {
  final ct = HeaderValue.parse(headerIn(headers, 'content-type'));
  final protocol = ct['protocol']?.toLowerCase();
  if (ct.value == 'multipart/encrypted' && protocol == 'application/pgp-encrypted') {
    return PgpProtection.pgpMimeEncrypted;
  }
  if (ct.value == 'multipart/signed' && protocol == 'application/pgp-signature') return PgpProtection.pgpMimeSigned;
  if (text != null) {
    if (_lineStarts(text, '-----BEGIN PGP MESSAGE-----')) return PgpProtection.inlineEncrypted;
    if (_lineStarts(text, '-----BEGIN PGP SIGNED MESSAGE-----')) return PgpProtection.inlineSigned;
  }
  return PgpProtection.none;
}

/// [marker] at the start of a line (not quoted with `>`).
bool _lineStarts(String text, String marker) {
  var i = text.indexOf(marker);
  while (i >= 0) {
    var j = i - 1;
    while (j >= 0 && (text[j] == ' ' || text[j] == '\t')) {
      j--;
    }
    if (j < 0 || text[j] == '\n') return true;
    i = text.indexOf(marker, i + 1);
  }
  return false;
}

/// What reading a message gave.
final class PgpReadResult {
  const PgpReadResult({required this.status, this.entity, this.text});

  final PgpMessageStatus status;

  /// The entity to show instead of the message: the decrypted content, or
  /// the signed part of a `multipart/signed`. Null when there is none.
  final MimeEntity? entity;

  /// For inline PGP: the message text with the armored block replaced by
  /// its plain text.
  final String? text;
}

/// Reads protected messages with a [PgpBackend]. Synchronous and pure, so
/// callers can run it in an isolate.
final class PgpMimeReader {
  const PgpMimeReader(this.backend);

  final PgpBackend backend;

  /// The key ids [raw]'s encrypted payload is for; empty if it isn't encrypted.
  List<String> recipientsOf(Uint8List raw) {
    final payload = _encryptedPayload(MimeEntity.parse(raw));
    if (payload == null) return const [];
    try {
      return backend.recipientKeyIds(payload);
    } on PgpException {
      return const [];
    }
  }

  /// Decrypts and verifies the whole message [raw] (RFC 822 bytes) with the
  /// unlocked secret [keys] and the public keys in [verifiers].
  PgpReadResult read(Uint8List raw, {List<PgpKey> keys = const [], List<PgpKey> verifiers = const []}) {
    final root = MimeEntity.parse(raw);
    switch (_protectionOf(root)) {
      case PgpProtection.pgpMimeEncrypted:
        return _readEncrypted(root, keys, verifiers);
      case PgpProtection.pgpMimeSigned:
        final (part, check) = _verifySigned(root, verifiers);
        return PgpReadResult(
          entity: part,
          status: PgpMessageStatus(
            protection: PgpProtection.pgpMimeSigned,
            signature: check,
            protectedHeaders: part == null ? const [] : _protectedHeaders(part),
          ),
        );
      case _:
        return _readInline(root, keys, verifiers);
    }
  }

  PgpProtection _protectionOf(MimeEntity e) {
    final protocol = e.contentType['protocol']?.toLowerCase();
    if (e.mimeType == 'multipart/encrypted' && protocol == 'application/pgp-encrypted') {
      return PgpProtection.pgpMimeEncrypted;
    }
    if (e.mimeType == 'multipart/signed' && protocol == 'application/pgp-signature') {
      return PgpProtection.pgpMimeSigned;
    }
    return PgpProtection.none;
  }

  /// Part 2 of a `multipart/encrypted` (RFC 3156 §4), or an inline block.
  Uint8List? _encryptedPayload(MimeEntity root) {
    if (_protectionOf(root) == PgpProtection.pgpMimeEncrypted) {
      return root.parts.length < 2 ? null : root.parts[1].decodedBody;
    }
    final part = _inlinePart(root);
    if (part == null) return null;
    final text = latin1.decode(part.decodedBody);
    final start = text.indexOf('-----BEGIN PGP MESSAGE-----');
    if (start < 0) return null;
    return latin1.encode(text.substring(start));
  }

  PgpReadResult _readEncrypted(MimeEntity root, List<PgpKey> keys, List<PgpKey> verifiers) {
    final payload = _encryptedPayload(root);
    if (payload == null) {
      return const PgpReadResult(
        status: PgpMessageStatus(
          protection: PgpProtection.pgpMimeEncrypted,
          encrypted: true,
          failure: PgpDecryptFailure.damaged,
          failureMessage: 'The encrypted part is missing.',
        ),
      );
    }
    var recipients = const <String>[];
    try {
      recipients = backend.recipientKeyIds(payload);
      final decryption = backend.decrypt(payload, keys: keys, verifiers: verifiers);
      final inner = MimeEntity.parse(decryption.data);
      var shown = inner;
      var signature = _best(decryption.signatures);
      // Thunderbird 78+ and Enigmail sign first, then encrypt the multipart/signed.
      if (_protectionOf(inner) == PgpProtection.pgpMimeSigned) {
        final (part, check) = _verifySigned(inner, verifiers);
        if (part != null) shown = part;
        signature = check ?? signature;
      }
      final protectedHeaders = _protectedHeaders(shown);
      return PgpReadResult(
        entity: shown,
        status: PgpMessageStatus(
          protection: PgpProtection.pgpMimeEncrypted,
          encrypted: true,
          signature: signature,
          recipientKeyIds: recipients,
          protectedHeaders: protectedHeaders.isEmpty ? _protectedHeaders(inner) : protectedHeaders,
          gossip: [
            ...inner.rawHeaders('autocrypt-gossip'),
            if (!identical(shown, inner)) ...shown.rawHeaders('autocrypt-gossip'),
          ],
        ),
      );
    } on PgpException catch (e) {
      return PgpReadResult(
        status: PgpMessageStatus(
          protection: PgpProtection.pgpMimeEncrypted,
          encrypted: true,
          failure: _failure(e),
          failureMessage: e.message,
          recipientKeyIds: recipients,
        ),
      );
    }
  }

  /// Checks a `multipart/signed`: part 1's exact bytes (with CRLF line
  /// ends) against part 2's detached signature.
  (MimeEntity?, PgpSignatureCheck?) _verifySigned(MimeEntity signed, List<PgpKey> verifiers) {
    if (signed.parts.length < 2) return (signed.parts.firstOrNull, null);
    final part = signed.parts[0];
    final signature = signed.parts[1].decodedBody;
    try {
      final checks = backend.verifyDetached(canonicalLineEnds(part.raw), signature, verifiers);
      return (part, _best(checks));
    } on PgpException catch (e) {
      return (part, PgpSignatureCheck(status: PgpSignatureStatus.bad, issuerKeyId: '', detail: e.message));
    }
  }

  /// The first text/plain part, where inline PGP lives.
  MimeEntity? _inlinePart(MimeEntity root) {
    if (!root.isMultipart) return root.mimeType == 'text/plain' ? root : null;
    for (final p in root.parts) {
      final found = _inlinePart(p);
      if (found != null) return found;
    }
    return null;
  }

  PgpReadResult _readInline(MimeEntity root, List<PgpKey> keys, List<PgpKey> verifiers) {
    final part = _inlinePart(root);
    if (part == null) return const PgpReadResult(status: PgpMessageStatus.none);
    final bytes = part.decodedBody;
    final byteText = latin1.decode(bytes);
    String show(String byteString) => decodeCharset(latin1.encode(byteString), part.charset);

    final encStart = byteText.indexOf('-----BEGIN PGP MESSAGE-----');
    if (encStart >= 0) {
      const endMarker = '-----END PGP MESSAGE-----';
      final endAt = byteText.indexOf(endMarker, encStart);
      final end = endAt < 0 ? byteText.length : endAt + endMarker.length;
      final block = latin1.encode(byteText.substring(encStart, end));
      var recipients = const <String>[];
      try {
        recipients = backend.recipientKeyIds(block);
        final decryption = backend.decrypt(block, keys: keys, verifiers: verifiers);
        String plain;
        try {
          plain = utf8.decode(decryption.data);
        } on FormatException {
          plain = decodeCharset(decryption.data, part.charset);
        }
        final before = show(byteText.substring(0, encStart));
        final after = show(byteText.substring(end));
        return PgpReadResult(
          text: (before + plain + after).replaceAll('\r\n', '\n'),
          status: PgpMessageStatus(
            protection: PgpProtection.inlineEncrypted,
            encrypted: true,
            signature: _best(decryption.signatures),
            recipientKeyIds: recipients,
            partial: (before + after).trim().isNotEmpty,
          ),
        );
      } on PgpException catch (e) {
        return PgpReadResult(
          status: PgpMessageStatus(
            protection: PgpProtection.inlineEncrypted,
            encrypted: true,
            failure: _failure(e),
            failureMessage: e.message,
            recipientKeyIds: recipients,
          ),
        );
      }
    }

    final signStart = byteText.indexOf('-----BEGIN PGP SIGNED MESSAGE-----');
    if (signStart >= 0) {
      const endMarker = '-----END PGP SIGNATURE-----';
      final endAt = byteText.indexOf(endMarker, signStart);
      final end = endAt < 0 ? byteText.length : endAt + endMarker.length;
      CleartextParts? parts;
      try {
        parts = splitCleartext(byteText.substring(signStart, end), byteString: true);
      } on FormatException {
        parts = null;
      }
      if (parts == null) return const PgpReadResult(status: PgpMessageStatus.none);
      PgpSignatureCheck? check;
      try {
        check = _best(backend.verifyDetached(parts.signedBytes, parts.signature, verifiers));
      } on PgpException catch (e) {
        check = PgpSignatureCheck(status: PgpSignatureStatus.bad, issuerKeyId: '', detail: e.message);
      }
      final before = show(byteText.substring(0, signStart));
      final after = show(byteText.substring(end));
      return PgpReadResult(
        text: (before + show(parts.text) + after).replaceAll('\r\n', '\n'),
        status: PgpMessageStatus(
          protection: PgpProtection.inlineSigned,
          signature: check,
          partial: (before + after).trim().isNotEmpty,
        ),
      );
    }
    return const PgpReadResult(status: PgpMessageStatus.none);
  }

  /// Subject, From, To, Cc, Reply-To and Date of an entity marked
  /// `protected-headers="v1"` (or carrying a Subject, as older clients do).
  List<(String, String)> _protectedHeaders(MimeEntity e) {
    final marked = e.contentType['protected-headers'] != null;
    if (!marked && e.rawHeader('subject') == null) return const [];
    const names = {'subject', 'from', 'to', 'cc', 'reply-to', 'date', 'message-id', 'references', 'in-reply-to'};
    return [
      for (final (k, v) in e.headers)
        if (names.contains(k.toLowerCase())) (k, decodeEncodedWords(v)),
    ];
  }

  static PgpSignatureCheck? _best(List<PgpSignatureCheck> checks) {
    for (final status in PgpSignatureStatus.values) {
      final c = checks.where((c) => c.status == status).firstOrNull;
      if (c != null) return c;
    }
    return null;
  }

  static PgpDecryptFailure _failure(PgpException e) => switch (e.kind) {
    PgpErrorKind.noSecretKey => PgpDecryptFailure.noSecretKey,
    PgpErrorKind.locked || PgpErrorKind.wrongPassphrase => PgpDecryptFailure.locked,
    PgpErrorKind.unsupported => PgpDecryptFailure.unsupported,
    _ => PgpDecryptFailure.damaged,
  };
}
