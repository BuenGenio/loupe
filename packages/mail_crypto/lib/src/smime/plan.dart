/// Which certificates an S/MIME message would be encrypted to, and which
/// standard (OpenPGP or S/MIME) protects a message.
library;

import 'package:mail_model/mail_model.dart' show SecurityTechnology;

import 'certificate.dart';
import 'cms.dart' show SmimeContentCipher;
import 'oids.dart';
import 'store.dart';
import 'trust.dart';

typedef SignedBy = bool Function(SmimeCertificate cert, SmimeCertificate issuer);

extension SmimeLookups on SmimeState {
  /// The certificate to encrypt to [email]: the user's own for their own
  /// addresses, else a correspondent's that is valid, for encryption, and
  /// trusted (newest first). Null when there is none.
  SmimeCertificate? encryptionCertificateFor(String email, {DateTime? now, required SignedBy signedBy}) {
    final at = now ?? DateTime.now();
    final address = email.trim().toLowerCase();
    for (final o in own) {
      final c = o.certificate;
      if (c.hasEmail(address) && c.isValidAt(at) && c.canEncrypt) return c;
    }
    final anchors = this.anchors;
    final known = knownCertificates;
    for (final entry in contactsFor(address)) {
      final c = entry.certificate;
      if (!c.isValidAt(at) || !c.canEncrypt) continue;
      final check = checkTrust(
        c,
        anchors: anchors,
        intermediates: [...entry.chain, ...known],
        at: at,
        usage: SmimeUsage.encryption,
        email: address,
        signedBy: signedBy,
      );
      if (check.trusted) return c;
    }
    return null;
  }

  /// The best (newest) correspondent certificate of [email], usable or not:
  /// to tell why it can't be encrypted to.
  SmimeContactCertificate? newestContact(String email) => contactsFor(email).firstOrNull;
}

/// The S/MIME outlook of a message being written.
final class SmimePlan {
  const SmimePlan({required this.certificates, required this.own, required this.cipher});

  /// Each recipient (lower-cased) with its certificate, or null when it has no usable one.
  final Map<String, SmimeCertificate?> certificates;

  /// The sender's certificate: it signs, and is encrypted to, so the Sent copy stays readable.
  final SmimeOwnCertificate? own;

  /// AES-256-GCM (AuthEnvelopedData) when every recipient's app said it
  /// reads it; else AES-256-CBC, which every S/MIME client reads.
  final SmimeContentCipher cipher;

  List<String> get missing => [
    for (final MapEntry(:key, :value) in certificates.entries)
      if (value == null) key,
  ];

  /// The sender can sign.
  bool get canSign => own != null;

  /// Encryption is possible: an own certificate that can be encrypted to,
  /// at least one recipient, and a certificate for each.
  bool get possible => own != null && own!.certificate.canEncrypt && certificates.isNotEmpty && missing.isEmpty;

  /// Every certificate the message would be encrypted to, the sender's included.
  List<SmimeCertificate> get recipientCertificates => {
    for (final c in certificates.values) ?c,
    if (own != null && own!.certificate.canEncrypt) own!.certificate,
  }.toList();
}

/// Plans an S/MIME message from [from] to [recipients].
SmimePlan planSmime(
  SmimeState state, {
  required String from,
  required Iterable<String> recipients,
  DateTime? now,
  required SignedBy signedBy,
}) {
  final at = now ?? DateTime.now();
  final chosen = state.ownCertificateFor(from, now: at);
  final own = chosen != null && chosen.certificate.isValidAt(at) && chosen.certificate.canSign ? chosen : null;
  // Without a certificate of the sender's, S/MIME isn't offered: no need to look recipients up.
  final certificates = <String, SmimeCertificate?>{
    for (final r in recipients)
      if (r.trim().isNotEmpty)
        r.trim().toLowerCase(): own == null ? null : state.encryptionCertificateFor(r, now: at, signedBy: signedBy),
  };
  final gcm =
      certificates.isNotEmpty &&
      certificates.values.every((c) {
        if (c == null) return false;
        if (state.ownCertificate(c.fingerprint) != null) return true;
        return state.contact(c.fingerprint)?.capabilities.contains(Oid.aes256Gcm) ?? false;
      });
  return SmimePlan(
    certificates: certificates,
    own: own,
    cipher: gcm ? SmimeContentCipher.aes256Gcm : SmimeContentCipher.aes256Cbc,
  );
}

/// Which standard protects a message: the sender's preference, unless
/// only the other one can encrypt to every recipient (Thunderbird's
/// automatic selection). [pgp] and [smime] say whether the sender has a
/// usable key or certificate.
SecurityTechnology chooseTechnology({
  required bool pgp,
  required bool smime,
  required bool preferSmime,
  bool pgpCanEncrypt = false,
  bool smimeCanEncrypt = false,
}) {
  final preferred = preferSmime ? SecurityTechnology.smime : SecurityTechnology.openPgp;
  if (pgp != smime) return pgp ? SecurityTechnology.openPgp : SecurityTechnology.smime;
  if (!pgp) return preferred;
  final preferredCan = preferSmime ? smimeCanEncrypt : pgpCanEncrypt;
  final otherCan = preferSmime ? pgpCanEncrypt : smimeCanEncrypt;
  if (!preferredCan && otherCan) return preferSmime ? SecurityTechnology.openPgp : SecurityTechnology.smime;
  return preferred;
}
