/// CMS (RFC 5652) as S/MIME 4.0 (RFC 8551) uses it: SignedData,
/// EnvelopedData and AuthEnvelopedData (RFC 5083), with RSA key transport
/// and ECDH key agreement (RFC 5753).
library;

import 'dart:typed_data';

import 'package:pointycastle/api.dart' show Digest;

import 'certificate.dart';
import 'der.dart';
import 'oids.dart';
import 'primitives.dart';

/// Who a message is encrypted to (or signed by): an issuer and serial
/// number, or a subject key identifier.
final class SmimeRecipientId {
  const SmimeRecipientId({this.issuer, this.serialNumber, this.subjectKeyId});

  final DistinguishedName? issuer;
  final BigInt? serialNumber;
  final Uint8List? subjectKeyId;

  static SmimeRecipientId parse(Asn1 id) {
    if (id.isSequence) {
      return SmimeRecipientId(issuer: DistinguishedName.parse(id[0]), serialNumber: id[1].integer);
    }
    // [0] IMPLICIT SubjectKeyIdentifier, or a RecipientKeyIdentifier (kari).
    if (id.constructed) return SmimeRecipientId(subjectKeyId: id[0].octets);
    return SmimeRecipientId(subjectKeyId: id.content);
  }

  bool matches(SmimeCertificate cert) {
    final ski = subjectKeyId;
    if (ski != null) return cert.subjectKeyId != null && constantEquals(cert.subjectKeyId!, ski);
    return serialNumber == cert.serialNumber && issuer != null && issuer!.matches(cert.issuer);
  }

  @override
  String toString() => subjectKeyId != null ? 'key ${hex(subjectKeyId!)}' : '${issuer?.displayName} #$serialNumber';
}

/// One signature of a SignedData, checked.
final class SmimeSignerCheck {
  const SmimeSignerCheck({
    required this.valid,
    required this.signer,
    this.certificate,
    this.signingTime,
    this.digestAlgorithm = '',
    this.capabilities = const [],
    this.problem,
    this.modified = false,
    this.weak = false,
  });

  /// The signature matches the content (and the signed attributes).
  final bool valid;

  /// Made with an algorithm that isn't safe anymore (SHA-1, MD5): not
  /// accepted, as Thunderbird doesn't accept it.
  final bool weak;

  /// The signature was checked and doesn't match: the content (or the
  /// signature) was changed after signing.
  final bool modified;

  /// Who the SignerInfo says signed.
  final SmimeRecipientId signer;

  /// The signer's certificate (from the message or the known ones); null when missing.
  final SmimeCertificate? certificate;
  final DateTime? signingTime;

  /// The digest OID.
  final String digestAlgorithm;

  /// SMIMECapabilities the signer announced (algorithm OIDs, preferred first).
  final List<String> capabilities;

  /// Why it isn't valid, in words.
  final String? problem;
}

/// A SignedData, verified.
final class SmimeSignedData {
  const SmimeSignedData({
    required this.contentType,
    this.content,
    this.certificates = const [],
    this.signers = const [],
  });

  final String contentType;

  /// The encapsulated content (opaque signing); null when detached.
  final Uint8List? content;

  /// Every certificate in the message.
  final List<SmimeCertificate> certificates;
  final List<SmimeSignerCheck> signers;
}

/// A decrypted EnvelopedData or AuthEnvelopedData.
final class SmimeDecrypted {
  const SmimeDecrypted({
    required this.content,
    required this.cipher,
    required this.recipients,
    this.authenticated = false,
  });
  final Uint8List content;

  /// "AES-256-CBC", "AES-256-GCM", "3DES"…
  final String cipher;
  final List<SmimeRecipientId> recipients;

  /// AuthEnvelopedData: the content can't have been changed.
  final bool authenticated;
}

/// How content is encrypted for sending.
enum SmimeContentCipher {
  /// EnvelopedData with AES-256-CBC: what Outlook, Apple Mail and
  /// Thunderbird all read.
  aes256Cbc,

  /// AuthEnvelopedData with AES-256-GCM (RFC 5083/5084): authenticated,
  /// but not every client reads it yet.
  aes256Gcm,
}

/// The ContentInfo's type and its `[0]` content.
(String, Asn1) contentInfo(Uint8List der) {
  final ci = Asn1.parse(der);
  if (!ci.isSequence || ci.length < 2 || ci[0].tag != Tag.oid || !ci[1].isContext(0)) {
    throw const Asn1Exception('Not a CMS ContentInfo');
  }
  return (ci[0].oid, ci[1][0]);
}

Never _malformed(Object e) => throw SmimeException(SmimeErrorKind.malformed, 'The S/MIME data is damaged.', e);

// Verifying -------------------------------------------------------------------

/// Verifies a SignedData ContentInfo. [detached] is the signed content of a
/// `multipart/signed` (its first part, CRLF line ends); [known] are
/// certificates to find the signer among when the message doesn't carry it.
SmimeSignedData verifySignedData(Uint8List der, {Uint8List? detached, List<SmimeCertificate> known = const []}) {
  try {
    final (type, signed) = contentInfo(der);
    if (type != Oid.signedData) throw const SmimeException(SmimeErrorKind.malformed, 'Not a signed message.');
    var i = 1; // version
    i++; // digestAlgorithms
    final encap = signed[i++];
    final contentType = encap[0].oid;
    final eContent = encap.context(0);
    final content = eContent == null ? null : eContent[0].octets;
    final certificates = <SmimeCertificate>[];
    Asn1? signerInfos;
    for (final c in signed.children.skip(i)) {
      if (c.isContext(0)) {
        for (final cert in c.children) {
          if (!cert.isSequence) continue;
          try {
            certificates.add(SmimeCertificate.fromDer(cert.encoded));
          } on SmimeException {
            // A certificate this parser can't read is left out.
          }
        }
      } else if (c.isSet) {
        signerInfos = c;
      }
    }
    final data = detached ?? content;
    var signers = [
      for (final si in signerInfos?.children ?? const <Asn1>[])
        _checkSigner(si, data, contentType, [...certificates, ...known]),
    ];
    // A multipart/signed whose signature carries other content than the
    // signed part (Thunderbird's "mismatch-econtent"): what is shown isn't what was signed.
    if (detached != null && content != null && !constantEquals(detached, content)) {
      signers = [
        for (final s in signers)
          SmimeSignerCheck(
            valid: false,
            modified: true,
            signer: s.signer,
            certificate: s.certificate,
            signingTime: s.signingTime,
            digestAlgorithm: s.digestAlgorithm,
            capabilities: s.capabilities,
            problem: 'The signature carries other content than the message.',
          ),
      ];
    }
    return SmimeSignedData(contentType: contentType, content: content, certificates: certificates, signers: signers);
  } on Asn1Exception catch (e) {
    _malformed(e);
  } on RangeError catch (e) {
    _malformed(e);
  }
}

SmimeSignerCheck _checkSigner(Asn1 si, Uint8List? content, String contentType, List<SmimeCertificate> certs) {
  final sid = SmimeRecipientId.parse(si[1]);
  final cert = certs.where(sid.matches).firstOrNull;
  final digestOid = si[2][0].oid;
  var i = 3;
  final signedAttrs = si[i].isContext(0) ? si[i++] : null;
  final sigAlg = si[i++];
  final signature = si[i].octets;
  DateTime? signingTime;
  var capabilities = const <String>[];
  Uint8List? messageDigest;
  String? attrContentType;
  if (signedAttrs != null) {
    for (final attr in signedAttrs.children) {
      final values = attr[1].children;
      if (values.isEmpty) continue;
      switch (attr[0].oid) {
        case Oid.messageDigest:
          messageDigest = values.first.octets;
        case Oid.contentType:
          attrContentType = values.first.oid;
        case Oid.signingTime:
          try {
            signingTime = values.first.time;
          } on Asn1Exception {
            signingTime = null;
          }
        case Oid.smimeCapabilities:
          capabilities = [for (final c in values.first.children) c[0].oid];
      }
    }
  }
  SmimeSignerCheck result(bool valid, [String? problem, bool modified = false, bool weak = false]) => SmimeSignerCheck(
    valid: valid,
    modified: modified,
    weak: weak,
    signer: sid,
    certificate: cert,
    signingTime: signingTime,
    digestAlgorithm: digestOid,
    capabilities: capabilities,
    problem: problem,
  );
  if (content == null) return result(false, 'The signed content is missing.');
  if (_weak.contains(digestOid) || _weak.contains(sigAlg[0].oid)) {
    return result(false, 'It is signed with ${digestName(digestOid)}, which isn’t safe anymore.', false, true);
  }
  if (cert == null) return result(false, 'The signer’s certificate isn’t in the message.');
  final d = digestFor(digestOid);
  if (d == null) return result(false, 'The digest ${digestName(digestOid)} isn’t supported.');
  final contentHash = d.process(content);
  Uint8List signedBytes;
  if (signedAttrs != null) {
    if (messageDigest == null || !constantEquals(messageDigest, contentHash)) {
      return result(false, 'The message was changed after it was signed.', true);
    }
    if (attrContentType != contentType) return result(false, 'The signed content type doesn’t match.', true);
    signedBytes = retag(signedAttrs.encoded, Tag.set);
  } else {
    signedBytes = content;
  }
  try {
    final ok = verifySignature(
      cert,
      sigAlg[0].oid,
      sigAlg.length > 1 ? sigAlg[1] : null,
      digestOid,
      signedBytes,
      signature,
    );
    return ok ? result(true) : result(false, 'The message was changed after it was signed.', true);
  } on SmimeException catch (e) {
    return result(false, e.message);
  }
}

/// Digests and signature algorithms that aren't accepted anymore.
const _weak = {Oid.sha1, Oid.md5, Oid.sha1WithRsa, Oid.md5WithRsa, Oid.ecdsaWithSha1};

/// Checks [signature] over [data] with [cert]'s key. [algorithm] is the
/// signature algorithm (a combined one, or just the key's with [digestOid]).
bool verifySignature(
  SmimeCertificate cert,
  String algorithm,
  Asn1? params,
  String digestOid,
  Uint8List data,
  Uint8List signature,
) {
  final hashOid = switch (algorithm) {
    Oid.sha1WithRsa || Oid.ecdsaWithSha1 => Oid.sha1,
    Oid.sha224WithRsa || Oid.ecdsaWithSha224 => Oid.sha224,
    Oid.sha256WithRsa || Oid.ecdsaWithSha256 => Oid.sha256,
    Oid.sha384WithRsa || Oid.ecdsaWithSha384 => Oid.sha384,
    Oid.sha512WithRsa || Oid.ecdsaWithSha512 => Oid.sha512,
    Oid.md5WithRsa => Oid.md5,
    _ => digestOid,
  };
  switch (algorithm) {
    case Oid.rsassaPss:
      if (cert.keyType != SmimeKeyType.rsa) return false;
      final (hash, mgf, salt) = rsaParams(params);
      final saltLength = salt == null ? 20 : salt[0].intValue;
      hash.reset();
      return rsaPssVerify(rsaPublicKey(cert), hash, mgf, saltLength, hash.process(data), signature);
    case Oid.rsaEncryption ||
        Oid.sha1WithRsa ||
        Oid.sha224WithRsa ||
        Oid.sha256WithRsa ||
        Oid.sha384WithRsa ||
        Oid.sha512WithRsa:
      if (cert.keyType != SmimeKeyType.rsa) return false;
      return rsaPkcs1Verify(rsaPublicKey(cert), hashOid, digest(hashOid, data), signature);
    case Oid.ecPublicKey ||
        Oid.ecdsaWithSha1 ||
        Oid.ecdsaWithSha224 ||
        Oid.ecdsaWithSha256 ||
        Oid.ecdsaWithSha384 ||
        Oid.ecdsaWithSha512:
      if (cert.keyType != SmimeKeyType.ec) return false;
      return ecdsaVerify(ecPublicKey(cert.curve, cert.publicKey), digest(hashOid, data), signature);
    case Oid.md5WithRsa:
      throw const SmimeException(SmimeErrorKind.unsupported, 'MD5 signatures aren’t safe and aren’t accepted.');
    default:
      throw SmimeException(SmimeErrorKind.unsupported, 'The signature algorithm $algorithm isn’t supported.');
  }
}

/// Whether [issuer]'s key signed [cert].
bool certificateSignedBy(SmimeCertificate cert, SmimeCertificate issuer) {
  // SHA-1 certificates aren't trusted anymore (as Mozilla decided in 2017).
  if (_weak.contains(cert.signatureAlgorithm)) return false;
  try {
    final params = cert.signatureParameters == null ? null : Asn1.parse(cert.signatureParameters!);
    return verifySignature(issuer, cert.signatureAlgorithm, params, Oid.sha256, cert.tbs, cert.signature);
  } on SmimeException {
    return false;
  } on Asn1Exception {
    return false;
  } on ArgumentError {
    return false;
  }
}

// Signing ---------------------------------------------------------------------

/// What S/MIME announces it can decrypt (SMIMECapabilities), preferred first.
const smimeCapabilities = [Oid.aes256Gcm, Oid.aes128Gcm, Oid.aes256Cbc, Oid.aes192Cbc, Oid.aes128Cbc];

/// A SignedData ContentInfo over [content], by [certificate] with [key],
/// carrying [chain] (the CA certificates, roots left out). Detached unless
/// [detached] is false. [encryptionCertificate] is announced as the one
/// to encrypt to (RFC 8551 §2.5.3, and Outlook's attribute).
(Uint8List, String) createSignedData(
  Uint8List content, {
  required SmimeCertificate certificate,
  required SmimePrivateKey key,
  List<SmimeCertificate> chain = const [],
  bool detached = true,
  DateTime? signingTime,
  SmimeCertificate? encryptionCertificate,
}) {
  final material = PrivateKeyMaterial.parse(key);
  if (!material.matches(certificate)) {
    throw const SmimeException(SmimeErrorKind.failed, 'The private key doesn’t belong to the certificate.');
  }
  final (digestOid, sigAlg) = switch (material) {
    RsaKeyMaterial() => (Oid.sha256, derAlgorithm(Oid.rsaEncryption, derNull)),
    EcKeyMaterial(:final curve) => (
      digestForCurve(curve),
      derAlgorithm(switch (digestForCurve(curve)) {
        Oid.sha384 => Oid.ecdsaWithSha384,
        Oid.sha512 => Oid.ecdsaWithSha512,
        _ => Oid.ecdsaWithSha256,
      }),
    ),
  };
  final issuerAndSerial = derSequence([certificate.issuer.der, derInteger(certificate.serialNumber)]);
  Uint8List attr(String oid, List<int> value) => derSequence([
    derOid(oid),
    derSet([value]),
  ]);
  final encryptTo = encryptionCertificate;
  final attrs = [
    attr(Oid.contentType, derOid(Oid.data)),
    attr(Oid.signingTime, derTime(signingTime ?? DateTime.now())),
    attr(Oid.messageDigest, derOctets(digest(digestOid, content))),
    attr(
      Oid.smimeCapabilities,
      derSequence([
        for (final c in smimeCapabilities) derSequence([derOid(c)]),
      ]),
    ),
    if (encryptTo != null) ...[
      // SMIMEEncryptionKeyPreference: [0] IMPLICIT IssuerAndSerialNumber.
      attr(
        Oid.encryptionKeyPreference,
        retag(derSequence([encryptTo.issuer.der, derInteger(encryptTo.serialNumber)]), 0xa0),
      ),
      attr(Oid.msEncryptionKeyPreference, derSequence([encryptTo.issuer.der, derInteger(encryptTo.serialNumber)])),
    ],
  ];
  final signedAttrs = derSet(attrs);
  final hash = digest(digestOid, signedAttrs);
  final signature = switch (material) {
    RsaKeyMaterial() => rsaPkcs1Sign(material, digestOid, hash),
    EcKeyMaterial() => ecdsaSign(material, digestOid, hash),
  };
  final signerInfo = derSequence([
    derInt(1),
    issuerAndSerial,
    derAlgorithm(digestOid),
    retag(signedAttrs, 0xa0),
    sigAlg,
    derOctets(signature),
  ]);
  final certs = [
    certificate,
    for (final c in chain)
      if (!c.isSelfIssued && c != certificate) c,
  ];
  final signedData = derSequence([
    derInt(1),
    derSet([derAlgorithm(digestOid)]),
    derSequence([derOid(Oid.data), if (!detached) derContext(0, derOctets(content))]),
    derContext(0, [for (final c in certs) ...c.der]),
    derSet([signerInfo]),
  ]);
  return (derSequence([derOid(Oid.signedData), derContext(0, signedData)]), micalgOf(digestOid));
}

// Decrypting ------------------------------------------------------------------

/// The recipients of an EnvelopedData or AuthEnvelopedData ContentInfo.
List<SmimeRecipientId> recipientsOf(Uint8List der) {
  try {
    final (_, envelope) = contentInfo(der);
    return [for (final ri in _recipientInfos(envelope).children) ..._ridsOf(ri)];
  } on Asn1Exception catch (e) {
    _malformed(e);
  }
}

Asn1 _recipientInfos(Asn1 envelope) {
  var i = 1;
  if (envelope[i].isContext(0)) i++; // originatorInfo
  return envelope[i]..expect(Tag.set, 'RecipientInfos');
}

List<SmimeRecipientId> _ridsOf(Asn1 ri) {
  if (ri.isSequence) return [SmimeRecipientId.parse(ri[1])];
  if (ri.isContext(1)) {
    final keys = ri.children.last;
    return [for (final rek in keys.children) SmimeRecipientId.parse(rek[0])];
  }
  return const [];
}

/// Decrypts an EnvelopedData or AuthEnvelopedData ContentInfo with one of
/// [keys] (the user's certificates with their private keys).
SmimeDecrypted decryptEnveloped(Uint8List der, List<(SmimeCertificate, SmimePrivateKey)> keys) {
  try {
    final (type, envelope) = contentInfo(der);
    final authenticated = type == Oid.authEnvelopedData;
    if (type != Oid.envelopedData && !authenticated) {
      throw const SmimeException(SmimeErrorKind.malformed, 'Not an encrypted message.');
    }
    final infos = _recipientInfos(envelope);
    final recipients = [for (final ri in infos.children) ..._ridsOf(ri)];
    var i = 1;
    if (envelope[i].isContext(0)) i++;
    i++; // recipientInfos
    final eci = envelope[i++];
    final cipherAlg = eci[1];
    final cipherOid = cipherAlg[0].oid;
    final encrypted = eci.context(0);
    final ciphertext = encrypted == null
        ? Uint8List(0)
        : encrypted.constructed
        ? encrypted.octets
        : encrypted.content;
    final keyLength = switch (cipherOid) {
      Oid.aes128Cbc || Oid.aes128Gcm => 16,
      Oid.aes192Cbc || Oid.aes192Gcm => 24,
      Oid.aes256Cbc || Oid.aes256Gcm => 32,
      Oid.desEde3Cbc => 24,
      Oid.rc2Cbc => null,
      _ => throw SmimeException(SmimeErrorKind.unsupported, 'The encryption algorithm $cipherOid isn’t supported.'),
    };
    Uint8List? cek;
    var matched = false;
    for (final ri in infos.children) {
      for (final (cert, key) in keys) {
        if (!_ridsOf(ri).any((r) => r.matches(cert))) continue;
        matched = true;
        cek = _unwrapKey(ri, cert, key, keyLength);
        if (cek != null) break;
      }
      if (cek != null) break;
    }
    if (!matched || cek == null) {
      throw const SmimeException(SmimeErrorKind.noKey, 'This message isn’t encrypted to any of your certificates.');
    }
    Uint8List plain;
    String cipher;
    if (authenticated) {
      Asn1? authAttrs;
      Uint8List? mac;
      for (final c in envelope.children.skip(i)) {
        if (c.isContext(1)) authAttrs = c;
        // The mac: an OCTET STRING, primitive or (BER) constructed.
        if (c.tag == Tag.octetString || c.tag == 0x24) mac = c.octets;
      }
      if (mac == null) throw const SmimeException(SmimeErrorKind.malformed, 'The integrity check is missing.');
      final params = cipherAlg[1];
      final nonce = params[0].octets;
      final tagLength = params.length > 1 ? params[1].intValue : 12;
      if (mac.length != tagLength) {
        throw const SmimeException(SmimeErrorKind.malformed, 'The integrity check is damaged.');
      }
      final aad = authAttrs == null ? null : retag(authAttrs.encoded, Tag.set);
      plain = aesGcm(false, cek, nonce, tagLength, Uint8List.fromList([...ciphertext, ...mac]), aad);
      cipher = 'AES-${cek.length * 8}-GCM';
    } else {
      switch (cipherOid) {
        case Oid.aes128Cbc || Oid.aes192Cbc || Oid.aes256Cbc:
          plain = aesCbc(false, cek, cipherAlg[1].octets, ciphertext);
          cipher = 'AES-${cek.length * 8}-CBC';
        case Oid.desEde3Cbc:
          plain = desEde3CbcDecrypt(cek, cipherAlg[1].octets, ciphertext);
          cipher = '3DES';
        case Oid.rc2Cbc:
          final p = cipherAlg[1];
          final (bits, iv) = p.isSequence ? (_rc2Bits(p[0].intValue), p[1].octets) : (32, p.octets);
          plain = rc2CbcDecrypt(cek, bits, iv, ciphertext);
          cipher = 'RC2-$bits';
        default:
          throw SmimeException(SmimeErrorKind.unsupported, 'The encryption algorithm $cipherOid isn’t supported.');
      }
    }
    return SmimeDecrypted(content: plain, cipher: cipher, recipients: recipients, authenticated: authenticated);
  } on Asn1Exception catch (e) {
    _malformed(e);
  } on RangeError catch (e) {
    _malformed(e);
  }
}

int _rc2Bits(int version) => switch (version) {
  160 => 40,
  120 => 64,
  58 => 128,
  _ => version >= 256 ? version : 32,
};

/// The content-encryption key from one RecipientInfo; null when it isn't ours.
Uint8List? _unwrapKey(Asn1 ri, SmimeCertificate cert, SmimePrivateKey key, int? keyLength) {
  final material = PrivateKeyMaterial.parse(key);
  if (ri.isSequence) {
    // KeyTransRecipientInfo.
    if (material is! RsaKeyMaterial) return null;
    final alg = ri[2];
    final encryptedKey = ri[3].octets;
    if (alg[0].oid == Oid.rsaesOaep) {
      final params = alg.length > 1 ? alg[1] : null;
      final (hash, mgf, source) = rsaParams(params);
      final label = source == null ? Uint8List(0) : source[0][1].octets;
      return rsaOaepDecrypt(material, hash, mgf, label, encryptedKey);
    }
    if (alg[0].oid != Oid.rsaEncryption) {
      throw SmimeException(SmimeErrorKind.unsupported, 'The key transport ${alg[0].oid} isn’t supported.');
    }
    return rsaPkcs1DecryptKey(material, encryptedKey, keyLength);
  }
  if (ri.isContext(1)) {
    // KeyAgreeRecipientInfo (ECDH).
    if (material is! EcKeyMaterial) return null;
    final originator = ri[1][0];
    if (!originator.isContext(1)) {
      throw const SmimeException(SmimeErrorKind.unsupported, 'Static-static ECDH isn’t supported.');
    }
    final ukmNode = ri.context(1);
    final ukm = ukmNode?[0].octets;
    final alg = ri.children.firstWhere((c) => c.isSequence && c[0].tag == Tag.oid);
    final scheme = alg[0].oid;
    final wrapOid = alg[1][0].oid;
    final kdfDigest = _kdfDigest(scheme);
    final wrapLength = switch (wrapOid) {
      Oid.aes128Wrap => 16,
      Oid.aes192Wrap => 24,
      Oid.aes256Wrap => 32,
      _ => throw SmimeException(SmimeErrorKind.unsupported, 'The key wrap $wrapOid isn’t supported.'),
    };
    final peer = ecPublicKey(material.curve, originator[1].bits);
    final z = ecdhSecret(material.key, peer);
    final kek = x963Kdf(kdfDigest, z, eccCmsSharedInfo(wrapOid, ukm, wrapLength * 8), wrapLength);
    for (final rek in ri.children.last.children) {
      if (!SmimeRecipientId.parse(rek[0]).matches(cert)) continue;
      return aesUnwrap(kek, rek[1].octets);
    }
    return null;
  }
  return null;
}

Digest _kdfDigest(String scheme) {
  final oid = switch (scheme) {
    Oid.ecdhSha1Kdf || Oid.ecdhCofactorSha1Kdf => Oid.sha1,
    Oid.ecdhSha224Kdf || Oid.ecdhCofactorSha224Kdf => Oid.sha224,
    Oid.ecdhSha256Kdf || Oid.ecdhCofactorSha256Kdf => Oid.sha256,
    Oid.ecdhSha384Kdf || Oid.ecdhCofactorSha384Kdf => Oid.sha384,
    Oid.ecdhSha512Kdf || Oid.ecdhCofactorSha512Kdf => Oid.sha512,
    _ => throw SmimeException(SmimeErrorKind.unsupported, 'The key agreement $scheme isn’t supported.'),
  };
  return digestFor(oid)!;
}

/// ECC-CMS-SharedInfo (RFC 5753 §7.2).
Uint8List eccCmsSharedInfo(String wrapOid, Uint8List? ukm, int keyBits) => derSequence([
  derAlgorithm(wrapOid),
  if (ukm != null) derContext(0, derOctets(ukm)),
  derContext(2, derOctets([(keyBits >> 24) & 0xff, (keyBits >> 16) & 0xff, (keyBits >> 8) & 0xff, keyBits & 0xff])),
]);

// Encrypting ------------------------------------------------------------------

/// An EnvelopedData (AES-256-CBC) or AuthEnvelopedData (AES-256-GCM)
/// ContentInfo of [content] for [recipients]: RSA certificates get the key
/// with RSAES-PKCS1-v1_5 (what every client reads), EC certificates with
/// ephemeral-static ECDH, the SHA-256 KDF and AES-256 key wrap.
Uint8List createEnveloped(
  Uint8List content,
  List<SmimeCertificate> recipients, {
  SmimeContentCipher cipher = SmimeContentCipher.aes256Cbc,
}) {
  if (recipients.isEmpty) throw ArgumentError('No recipients');
  final cek = randomBytes(32);
  final infos = <Uint8List>[];
  var kari = false;
  for (final r in recipients) {
    final rid = derSequence([r.issuer.der, derInteger(r.serialNumber)]);
    switch (r.keyType) {
      case SmimeKeyType.rsa:
        infos.add(
          derSequence([
            derInt(0),
            rid,
            derAlgorithm(Oid.rsaEncryption, derNull),
            derOctets(rsaPkcs1Encrypt(rsaPublicKey(r), cek)),
          ]),
        );
      case SmimeKeyType.ec:
        kari = true;
        final peer = ecPublicKey(r.curve, r.publicKey);
        final (ephemeral, point) = ecdhEphemeral(r.curve);
        final z = ecdhSecret(ephemeral, peer);
        final kek = x963Kdf(digestFor(Oid.sha256)!, z, eccCmsSharedInfo(Oid.aes256Wrap, null, 256), 32);
        infos.add(
          derContext(1, [
            ...derInt(3),
            ...derContext(0, derContext(1, [...derAlgorithm(Oid.ecPublicKey), ...derBitString(point)])),
            ...derAlgorithm(Oid.ecdhSha256Kdf, derAlgorithm(Oid.aes256Wrap)),
            ...derSequence([
              derSequence([rid, derOctets(aesWrap(kek, cek))]),
            ]),
          ]),
        );
      case SmimeKeyType.other:
        throw SmimeException(SmimeErrorKind.certificateUnusable, 'The certificate of ${r.displayName} can’t encrypt.');
    }
  }
  if (cipher == SmimeContentCipher.aes256Gcm) {
    final nonce = randomBytes(12);
    final sealed = aesGcm(true, cek, nonce, 16, content);
    final body = Uint8List.sublistView(sealed, 0, sealed.length - 16);
    final tag = Uint8List.sublistView(sealed, sealed.length - 16);
    final auth = derSequence([
      derInt(0),
      derSet(infos),
      derSequence([
        derOid(Oid.data),
        derAlgorithm(Oid.aes256Gcm, derSequence([derOctets(nonce), derInt(16)])),
        derContext(0, body, constructed: false),
      ]),
      derOctets(tag),
    ]);
    return derSequence([derOid(Oid.authEnvelopedData), derContext(0, auth)]);
  }
  final iv = randomBytes(16);
  final enveloped = derSequence([
    derInt(kari ? 2 : 0),
    derSet(infos),
    derSequence([
      derOid(Oid.data),
      derAlgorithm(Oid.aes256Cbc, derOctets(iv)),
      derContext(0, aesCbc(true, cek, iv, content), constructed: false),
    ]),
  ]);
  return derSequence([derOid(Oid.envelopedData), derContext(0, enveloped)]);
}
