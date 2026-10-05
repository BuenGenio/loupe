import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../openpgp/openpgp_providers.dart' show PgpRunner;
import 'smime_keys.dart';

/// What reading an S/MIME message gave: its status, and for encrypted or
/// opaque-signed mail the content inside.
final class SmimeReadOutcome {
  const SmimeReadOutcome({required this.status, this.content, this.entity});

  final SmimeMessageStatus status;

  /// The unwrapped message as reader content (part ids `pgp:…`, as for OpenPGP).
  final EmailContent? content;

  /// The unwrapped MIME tree, to serve attachments from.
  final MimeEntity? entity;
}

/// S/MIME for the screens: reading protected mail, collecting
/// correspondents' certificates, importing PKCS #12 files and
/// certificates, trust.
final class SmimeService {
  SmimeService({required this.keys, required this.backend, required this.run, DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final StoreSmimeKeys keys;
  final SmimeBackend backend;
  final PgpRunner run;
  final DateTime Function() _clock;

  SmimeStore get store => keys.store;
  SmimeState get state => store.state;

  // Reading ---------------------------------------------------------------------

  /// Decrypts and verifies the raw message of [emailId]; the signer's
  /// certificate is checked for [sender].
  Future<SmimeReadOutcome> read(String emailId, Uint8List raw, {String? sender}) {
    final b = backend;
    final pairs = keys.keyPairs;
    final anchors = state.anchors;
    final known = state.knownCertificates;
    final now = _clock();
    return run(() {
      final r = SmimeReader(b).read(raw, keys: pairs, anchors: anchors, known: known, now: now, sender: sender);
      final entity = r.entity;
      // What is shown is what was verified or decrypted: for a
      // multipart/signed, its signed part from these very bytes, never the
      // server's view of the whole message (parts outside the signature, or
      // a MIME parser that splits the message differently, would show as signed).
      return SmimeReadOutcome(
        status: r.status,
        content: entity == null ? null : contentFromEntity(entity, emailId: emailId),
        entity: entity,
      );
    });
  }

  /// Keeps the certificate of a good signature by [sender] (as Outlook and Thunderbird do).
  Future<bool> collect(SmimeSignatureStatus signature, {required String sender}) async {
    if (state.own.any((o) => o.certificate.hasEmail(sender))) return false;
    return store.collect(signature, sender: sender, now: _clock());
  }

  /// [certificate] checked now for [usage] (and [email]), through the known chains.
  SmimeTrustCheck check(SmimeCertificate certificate, {SmimeUsage usage = SmimeUsage.signing, String? email}) =>
      checkTrust(
        certificate,
        anchors: state.anchors,
        intermediates: state.knownCertificates,
        at: _clock(),
        usage: usage,
        email: email,
        signedBy: backend.certificateSignedBy,
      );

  // Importing -------------------------------------------------------------------

  /// Whether [data] looks like a PKCS #12 file (a SEQUENCE starting with version 3).
  static bool isPkcs12(Uint8List data) =>
      data.length > 8 && data[0] == 0x30 && _versionThreeAt(data, data[1] < 0x80 ? 2 : 2 + (data[1] & 0x7f));

  static bool _versionThreeAt(Uint8List d, int i) => i + 2 < d.length && d[i] == 0x02 && d[i + 1] == 1 && d[i + 2] == 3;

  /// The keys and certificates of a PKCS #12 file. Throws [SmimeException]
  /// ([SmimeErrorKind.wrongPassword] when [password] is wrong).
  Future<SmimeBundle> openPkcs12(Uint8List data, String password) {
    final b = backend;
    return run(() => b.readPkcs12(data, password));
  }

  /// Every certificate in [data] (PEM, DER, `.p7c`).
  Future<List<SmimeCertificate>> parseCertificates(Uint8List data) => run(() => readCertificates(data));

  /// Adds the user's certificate with its key and chain.
  Future<void> addOwn(SmimeKeyEntry entry, {List<SmimeCertificate> chain = const []}) async {
    await store.addOwn(SmimeKeyPair(entry.certificate, entry.key), chain: chain, now: _clock());
    keys.put(entry.certificate.fingerprint, entry.key);
  }

  /// Deletes one of the user's certificates and its private key.
  Future<void> deleteOwn(String fingerprint) async {
    await store.removeOwn(fingerprint);
    keys.forget(fingerprint);
  }

  /// Adds correspondents' certificates (from a file).
  Future<void> importCertificates(
    List<SmimeCertificate> certificates, {
    List<SmimeCertificate> chain = const [],
  }) async {
    for (final c in certificates) {
      await store.addContact(c, chain: chain, source: SmimeCertificateSource.imported, now: _clock());
    }
  }

  /// Whether [certificate] is a root Loupe already trusts (Mozilla's or the user's).
  bool isTrustedRoot(SmimeCertificate certificate) => state.anchors.isAnchor(certificate);

  /// Whether [certificate] chains to [root] through [chain], every signature
  /// checked: the only CA worth offering to trust along with it.
  bool chainsTo(SmimeCertificate certificate, SmimeCertificate root, {List<SmimeCertificate> chain = const []}) =>
      checkTrust(
        certificate,
        anchors: SmimeTrustAnchors([root]),
        intermediates: chain,
        at: _clock(),
        usage: SmimeUsage.signing,
        signedBy: backend.certificateSignedBy,
      ).anchor ==
      root;
}
