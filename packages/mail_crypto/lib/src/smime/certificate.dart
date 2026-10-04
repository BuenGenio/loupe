/// X.509 certificates (RFC 5280) as S/MIME uses them: who, which
/// addresses, valid when, for what.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/digests/sha1.dart';
import 'package:pointycastle/digests/sha256.dart';

import 'der.dart';
import 'oids.dart';

enum SmimeErrorKind {
  /// The PKCS#12 password is wrong.
  wrongPassword,

  /// None of the user's certificates can decrypt the message.
  noKey,

  /// Not S/MIME data, or damaged.
  malformed,

  /// An algorithm this backend can't handle.
  unsupported,

  /// A recipient's certificate can't be used (expired, untrusted, wrong usage).
  certificateUnusable,

  /// Anything else.
  failed,
}

/// An S/MIME failure; [message] is fit for the UI.
final class SmimeException implements Exception {
  const SmimeException(this.kind, this.message, [this.cause]);
  final SmimeErrorKind kind;
  final String message;
  final Object? cause;

  @override
  String toString() => 'SmimeException(${kind.name}): $message';
}

/// An X.501 name: `CN=Alice Example, O=Example`.
final class DistinguishedName {
  const DistinguishedName(this.der, this.attributes);

  static final empty = DistinguishedName(derSequence(const []), const []);

  /// The encoded Name, exactly as in the certificate.
  final Uint8List der;

  /// Attribute types (OIDs) and values, in order (most significant first).
  final List<(String, String)> attributes;

  static DistinguishedName parse(Asn1 name) {
    final attributes = <(String, String)>[];
    for (final rdn in name.children) {
      for (final atv in rdn.children) {
        if (atv.length < 2) continue;
        try {
          attributes.add((atv[0].oid, atv[1].string));
        } on Asn1Exception {
          // A value of an unknown type is left out of the readable name.
        }
      }
    }
    return DistinguishedName(name.encoded, attributes);
  }

  String? valueOf(String oid) => attributes.where((a) => a.$1 == oid).map((a) => a.$2).lastOrNull;

  String? get commonName => valueOf(Oid.commonName);
  String? get organization => valueOf(Oid.organization);
  String? get email => valueOf(Oid.emailAddress)?.toLowerCase();

  /// The common name, else the organisation, else the address.
  String get displayName => commonName ?? organization ?? email ?? toString();

  /// Whether this and [other] name the same entity: the same encoding, or
  /// the same attributes compared without case and extra spaces (RFC 5280 §7.1).
  bool matches(DistinguishedName other) {
    if (_bytesEqual(der, other.der)) return true;
    if (attributes.length != other.attributes.length || attributes.isEmpty) return false;
    String norm(String s) => s.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
    for (var i = 0; i < attributes.length; i++) {
      if (attributes[i].$1 != other.attributes[i].$1) return false;
      if (norm(attributes[i].$2) != norm(other.attributes[i].$2)) return false;
    }
    return true;
  }

  static const _short = {
    Oid.commonName: 'CN',
    Oid.organization: 'O',
    Oid.organizationalUnit: 'OU',
    Oid.country: 'C',
    Oid.state: 'ST',
    Oid.locality: 'L',
    Oid.emailAddress: 'E',
    Oid.domainComponent: 'DC',
    Oid.serialNumber: 'SERIALNUMBER',
    Oid.givenName: 'G',
    Oid.surname: 'SN',
  };

  /// Most specific first, as mail clients show it: `CN=…, O=…, C=…`.
  @override
  String toString() => [for (final (k, v) in attributes.reversed) '${_short[k] ?? k}=$v'].join(', ');
}

/// Key usage bits (RFC 5280 §4.2.1.3).
abstract final class KeyUsage {
  static const digitalSignature = 1 << 0;
  static const nonRepudiation = 1 << 1;
  static const keyEncipherment = 1 << 2;
  static const dataEncipherment = 1 << 3;
  static const keyAgreement = 1 << 4;
  static const keyCertSign = 1 << 5;
  static const crlSign = 1 << 6;
}

enum SmimeKeyType { rsa, ec, other }

/// An X.509 certificate, parsed. Immutable; [der] is the certificate as
/// received, and two certificates are the same when it is.
final class SmimeCertificate {
  SmimeCertificate._({
    required this.der,
    required this.tbs,
    required this.version,
    required this.serialNumber,
    required this.issuer,
    required this.subject,
    required this.notBefore,
    required this.notAfter,
    required this.publicKeyInfo,
    required this.keyType,
    required this.keyBits,
    required this.curve,
    required this.publicKey,
    required this.signatureAlgorithm,
    required this.signatureParameters,
    required this.signature,
    required this.isCa,
    required this.pathLength,
    required this.keyUsage,
    required this.extendedKeyUsage,
    required this.emails,
    required this.subjectKeyId,
    required this.authorityKeyId,
    required this.permittedEmails,
    required this.excludedEmails,
    required this.unknownCriticalExtensions,
  });

  /// Parses a DER certificate. Throws [SmimeException] ([SmimeErrorKind.malformed]).
  factory SmimeCertificate.fromDer(List<int> bytes) {
    final der = Uint8List.fromList(bytes);
    try {
      return _parse(der);
    } on Asn1Exception catch (e) {
      throw SmimeException(SmimeErrorKind.malformed, 'This certificate is damaged.', e);
    } on FormatException catch (e) {
      throw SmimeException(SmimeErrorKind.malformed, 'This certificate is damaged.', e);
    } on RangeError catch (e) {
      throw SmimeException(SmimeErrorKind.malformed, 'This certificate is damaged.', e);
    }
  }

  final Uint8List der;

  /// The signed part (TBSCertificate), exactly as encoded.
  final Uint8List tbs;
  final int version;
  final BigInt serialNumber;
  final DistinguishedName issuer;
  final DistinguishedName subject;
  final DateTime notBefore;
  final DateTime notAfter;

  /// SubjectPublicKeyInfo, DER.
  final Uint8List publicKeyInfo;
  final SmimeKeyType keyType;

  /// RSA modulus or EC field size in bits.
  final int keyBits;

  /// The named curve's OID for EC keys.
  final String? curve;

  /// The subjectPublicKey bits: an RSAPublicKey (RSA) or an EC point.
  final Uint8List publicKey;

  /// The algorithm the issuer signed with (OID), and its parameters (DER) if any.
  final String signatureAlgorithm;
  final Uint8List? signatureParameters;
  final Uint8List signature;

  /// basicConstraints cA.
  final bool isCa;
  final int? pathLength;

  /// [KeyUsage] bits; null without the extension (any use).
  final int? keyUsage;

  /// Extended key usage OIDs; null without the extension (any use).
  final List<String>? extendedKeyUsage;

  /// Lower-cased addresses: subjectAltName rfc822Name and the subject's emailAddress.
  final List<String> emails;
  final Uint8List? subjectKeyId;
  final Uint8List? authorityKeyId;

  /// Name constraints on addresses (a CA's): permitted and excluded rfc822Name subtrees.
  final List<String> permittedEmails;
  final List<String> excludedEmails;

  /// Critical extensions this parser doesn't know; such a certificate is
  /// not valid (RFC 5280 §4.2).
  final List<String> unknownCriticalExtensions;

  /// SHA-256 of [der], upper-case hex.
  late final String fingerprint = hex(SHA256Digest().process(der));

  /// SHA-1 of [der], upper-case hex (what Windows and Outlook show as the thumbprint).
  late final String sha1Fingerprint = hex(SHA1Digest().process(der));

  String get serialHex {
    final h = serialNumber.toRadixString(16).toUpperCase();
    return h.length.isOdd ? '0$h' : h;
  }

  /// The subject's common name, else its first address, else the subject.
  String get displayName => subject.commonName ?? emails.firstOrNull ?? subject.displayName;

  /// The issuing CA as people know it: its organisation, else its common name.
  String get issuerName => issuer.organization ?? issuer.commonName ?? issuer.toString();

  /// "RSA 2048", "EC P-256".
  String get algorithm => switch (keyType) {
    SmimeKeyType.rsa => 'RSA $keyBits',
    SmimeKeyType.ec => 'EC ${curveName(curve)}',
    SmimeKeyType.other => 'Unknown',
  };

  bool get isSelfIssued => subject.matches(issuer);

  bool hasEmail(String email) => emails.contains(email.trim().toLowerCase());

  bool isExpiredAt(DateTime at) => at.isAfter(notAfter);
  bool isValidAt(DateTime at) => !at.isBefore(notBefore) && !at.isAfter(notAfter);

  bool _usage(int bits) => keyUsage == null || keyUsage! & bits != 0;

  bool get _forEmail =>
      extendedKeyUsage == null ||
      extendedKeyUsage!.contains(Oid.emailProtection) ||
      extendedKeyUsage!.contains(Oid.anyExtendedKeyUsage);

  /// It may sign mail: digitalSignature (or nonRepudiation) and emailProtection.
  bool get canSign => _forEmail && _usage(KeyUsage.digitalSignature | KeyUsage.nonRepudiation);

  /// Mail may be encrypted to it: keyEncipherment (RSA) or keyAgreement (EC), and emailProtection.
  bool get canEncrypt =>
      _forEmail &&
      switch (keyType) {
        SmimeKeyType.rsa => _usage(KeyUsage.keyEncipherment),
        SmimeKeyType.ec => _usage(KeyUsage.keyAgreement),
        SmimeKeyType.other => false,
      };

  /// The same key as [other] (a certificate renewed with its key).
  bool sameKey(SmimeCertificate other) => _bytesEqual(publicKey, other.publicKey);

  /// PEM, `-----BEGIN CERTIFICATE-----`.
  String get pem {
    final b64 = base64.encode(der);
    final lines = [
      for (var i = 0; i < b64.length; i += 64) b64.substring(i, i + 64 > b64.length ? b64.length : i + 64),
    ];
    return '-----BEGIN CERTIFICATE-----\n${lines.join('\n')}\n-----END CERTIFICATE-----\n';
  }

  @override
  bool operator ==(Object other) => other is SmimeCertificate && _bytesEqual(other.der, der);

  @override
  int get hashCode => Object.hash(der.length, serialNumber);

  @override
  String toString() => 'SmimeCertificate($subject, issuer: $issuer, serial $serialHex)';
}

String curveName(String? oid) => switch (oid) {
  Oid.secp256r1 => 'P-256',
  Oid.secp384r1 => 'P-384',
  Oid.secp521r1 => 'P-521',
  Oid.brainpoolP256r1 => 'brainpoolP256r1',
  Oid.brainpoolP384r1 => 'brainpoolP384r1',
  Oid.brainpoolP512r1 => 'brainpoolP512r1',
  _ => oid ?? '?',
};

int _curveBits(String? oid) => switch (oid) {
  Oid.secp256r1 || Oid.brainpoolP256r1 => 256,
  Oid.secp384r1 || Oid.brainpoolP384r1 => 384,
  Oid.secp521r1 => 521,
  Oid.brainpoolP512r1 => 512,
  _ => 0,
};

bool _bytesEqual(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

const _knownExtensions = {
  Oid.subjectKeyIdentifier,
  Oid.keyUsage,
  Oid.subjectAltName,
  Oid.basicConstraints,
  Oid.authorityKeyIdentifier,
  Oid.extKeyUsage,
  Oid.nameConstraints,
  // Policies aren't processed (as most mail clients); they only narrow trust.
  Oid.certificatePolicies,
  Oid.policyConstraints,
  Oid.inhibitAnyPolicy,
  Oid.crlDistributionPoints,
  Oid.authorityInfoAccess,
};

SmimeCertificate _parse(Uint8List der) {
  final cert = Asn1.parse(der)..expect(Tag.sequence, 'Certificate');
  final tbs = cert[0]..expect(Tag.sequence, 'TBSCertificate');
  var i = 0;
  var version = 1;
  if (tbs[0].isContext(0)) {
    version = tbs[0][0].intValue + 1;
    i++;
  }
  final serial = tbs[i++].integer;
  i++; // signature algorithm, repeated outside
  final issuer = DistinguishedName.parse(tbs[i++]);
  final validity = tbs[i++];
  final subject = DistinguishedName.parse(tbs[i++]);
  final spki = tbs[i++]..expect(Tag.sequence, 'SubjectPublicKeyInfo');
  final keyAlgorithm = spki[0][0].oid;
  final keyBitsRaw = spki[1].bits;
  var keyType = SmimeKeyType.other;
  var keyBits = 0;
  String? curve;
  if (keyAlgorithm == Oid.rsaEncryption || keyAlgorithm == Oid.rsassaPss) {
    keyType = SmimeKeyType.rsa;
    keyBits = Asn1.parse(keyBitsRaw)[0].integer.bitLength;
  } else if (keyAlgorithm == Oid.ecPublicKey) {
    keyType = SmimeKeyType.ec;
    final params = spki[0].length > 1 ? spki[0][1] : null;
    curve = params != null && params.tag == Tag.oid ? params.oid : null;
    keyBits = _curveBits(curve);
  }

  var isCa = false;
  int? pathLength;
  int? keyUsage;
  List<String>? eku;
  final emails = <String>[];
  Uint8List? ski;
  Uint8List? aki;
  final permitted = <String>[];
  final excluded = <String>[];
  final unknownCritical = <String>[];
  final extensions = tbs.context(3);
  if (extensions != null && version >= 3) {
    for (final ext in extensions[0].children) {
      final id = ext[0].oid;
      final critical = ext.length > 2 && ext[1].tag == Tag.boolean && ext[1].boolean;
      final value = Asn1.parse(ext[ext.length - 1].octets);
      switch (id) {
        case Oid.basicConstraints:
          for (final c in value.children) {
            if (c.tag == Tag.boolean) isCa = c.boolean;
            if (c.tag == Tag.integer) pathLength = c.intValue;
          }
        case Oid.keyUsage:
          keyUsage = value.namedBits;
        case Oid.extKeyUsage:
          eku = [for (final c in value.children) c.oid];
        case Oid.subjectAltName:
          for (final name in value.children) {
            // rfc822Name [1] IMPLICIT IA5String.
            if (name.isContext(1) && !name.constructed) emails.add(ascii.decode(name.content).trim().toLowerCase());
          }
        case Oid.subjectKeyIdentifier:
          ski = value.octets;
        case Oid.authorityKeyIdentifier:
          final keyId = value.context(0);
          if (keyId != null) aki = keyId.content;
        case Oid.nameConstraints:
          for (final (n, into) in [(0, permitted), (1, excluded)]) {
            final subtrees = value.context(n);
            if (subtrees == null) continue;
            for (final subtree in subtrees.children) {
              final base = subtree[0];
              if (base.isContext(1) && !base.constructed) into.add(ascii.decode(base.content).trim().toLowerCase());
            }
          }
        default:
          if (critical && !_knownExtensions.contains(id)) unknownCritical.add(id);
      }
    }
  }
  final subjectEmail = subject.email;
  if (subjectEmail != null && !emails.contains(subjectEmail)) emails.add(subjectEmail);

  final sigAlg = cert[1];
  return SmimeCertificate._(
    der: der,
    tbs: tbs.encoded,
    version: version,
    serialNumber: serial,
    issuer: issuer,
    subject: subject,
    notBefore: validity[0].time,
    notAfter: validity[1].time,
    publicKeyInfo: spki.encoded,
    keyType: keyType,
    keyBits: keyBits,
    curve: curve,
    publicKey: keyBitsRaw,
    signatureAlgorithm: sigAlg[0].oid,
    signatureParameters: sigAlg.length > 1 && sigAlg[1].tag != Tag.nul ? sigAlg[1].encoded : null,
    signature: cert[2].bits,
    isCa: isCa,
    pathLength: pathLength,
    keyUsage: keyUsage,
    extendedKeyUsage: eku,
    emails: emails,
    subjectKeyId: ski,
    authorityKeyId: aki,
    permittedEmails: permitted,
    excludedEmails: excluded,
    unknownCriticalExtensions: unknownCritical,
  );
}

/// Every certificate in [input]: PEM (one or several), DER, or a PKCS#7
/// "certs-only" bundle (`.p7c`, `.p7b`), PEM or DER. Throws
/// [SmimeException] ([SmimeErrorKind.malformed]) when there is none.
List<SmimeCertificate> readCertificates(Uint8List input) {
  final found = <SmimeCertificate>[];
  final text = latin1.decode(input);
  final pem = RegExp(r'-----BEGIN ([A-Z0-9 ]+)-----([\s\S]*?)-----END \1-----');
  final blocks = pem.allMatches(text).toList();
  final ders = blocks.isEmpty
      ? [input]
      : [
          for (final m in blocks)
            if (const {'CERTIFICATE', 'X509 CERTIFICATE', 'TRUSTED CERTIFICATE', 'PKCS7', 'CMS'}.contains(m.group(1)))
              base64.decode(m.group(2)!.replaceAll(RegExp(r'\s'), '')),
        ];
  for (final der in ders) {
    try {
      final root = Asn1.parse(der);
      if (root.length >= 2 && root[0].tag == Tag.oid && root[0].oid == Oid.signedData) {
        found.addAll(certificatesOfSignedData(root));
      } else {
        found.add(SmimeCertificate.fromDer(root.encoded));
      }
    } on Asn1Exception {
      continue;
    } on SmimeException {
      continue;
    }
  }
  if (found.isEmpty) throw const SmimeException(SmimeErrorKind.malformed, 'No certificate found.');
  return found;
}

/// The certificates of a SignedData ContentInfo (`[0] IMPLICIT CertificateSet`).
List<SmimeCertificate> certificatesOfSignedData(Asn1 contentInfo) {
  final signed = contentInfo[1][0];
  final set = signed.context(0);
  if (set == null) return const [];
  return [
    for (final c in set.children)
      if (c.isSequence) SmimeCertificate.fromDer(c.encoded),
  ];
}
