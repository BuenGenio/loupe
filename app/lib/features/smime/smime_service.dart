import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../openpgp/openpgp_providers.dart' show PgpRunner;
import 'device_certificates.dart';
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

/// Asks for the passphrase of the user's [certificate]; null when they cancel.
/// [error] explains why it is asked again.
typedef SmimePassphrasePrompt = Future<String?> Function(SmimeCertificate certificate, {String? error});

/// S/MIME for the screens: reading protected mail, collecting
/// correspondents' certificates, importing PKCS #12 files and
/// certificates, certificates on the device, passphrases, trust.
final class SmimeService {
  SmimeService({
    required this.keys,
    required this.backend,
    required this.run,
    this.device,
    this.prompt,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final StoreSmimeKeys keys;
  final SmimeBackend backend;
  final PgpRunner run;

  /// Certificates whose keys stay on the device (Android KeyChain).
  final DeviceCertificates? device;

  /// Asks for a key's passphrase; null where nobody can be asked.
  final SmimePassphrasePrompt? prompt;
  final DateTime Function() _clock;
  final _unlocking = <String, Future<SmimeKeyHandle?>>{};

  SmimeStore get store => keys.store;
  SmimeState get state => store.state;

  // Reading ---------------------------------------------------------------------

  /// Decrypts and verifies the raw message of [emailId]; the signer's
  /// certificate is checked for [sender]. A key on the device is asked for
  /// what it must do (the content key, an ECDH secret), and the message
  /// read again with its answer.
  Future<SmimeReadOutcome> read(String emailId, Uint8List raw, {String? sender}) async {
    final b = backend;
    // Keys with a passphrase the message is encrypted to are unlocked first (asking once each).
    var locked = [
      for (final o in state.own)
        if (o.hasPassphrase && !keys.isAvailable(o.fingerprint)) o,
    ];
    if (locked.isNotEmpty) {
      final recipients = await run(() => SmimeReader(b).recipientsOf(raw));
      locked = [
        for (final o in locked)
          if (recipients.any((r) => r.matches(o.certificate))) o,
      ];
      for (final o in locked) {
        await unlock(o.fingerprint);
      }
    }
    var pairs = keys.keyPairs;
    final anchors = state.anchors;
    final known = state.knownCertificates;
    final now = _clock();
    for (var round = 0; ; round++) {
      final p = pairs;
      final outcome = await run(() {
        final r = SmimeReader(b).read(raw, keys: p, anchors: anchors, known: known, now: now, sender: sender);
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
      final request = outcome.status.keyRequest;
      final device = this.device;
      if (outcome.status.failure == SmimeDecryptFailure.noKey && locked.any((o) => !keys.isAvailable(o.fingerprint))) {
        return SmimeReadOutcome(
          status: _failed(outcome.status, 'Your S/MIME certificate is locked. Open the message again to unlock it.'),
        );
      }
      // A layer each round: a message encrypted twice asks twice.
      if (request == null || device == null || round >= SmimeReader.maxLayers) return outcome;
      Uint8List answer;
      try {
        answer = await device.perform(request);
      } on SmimeException catch (e) {
        // A padding the key refused fails like any wrong key (no oracle):
        // an answer of the wrong length is replaced with random bytes.
        if (e.kind != SmimeErrorKind.malformed || request.operation != SmimeKeyOperation.decryptPkcs1) {
          return SmimeReadOutcome(status: _failed(outcome.status, e.message));
        }
        answer = Uint8List(0);
      }
      pairs = [
        for (final pair in pairs)
          if (pair.key case final SmimePlatformKey k when k.alias == request.alias)
            SmimeKeyPair(pair.certificate, k.withAnswers({request.id: answer}))
          else
            pair,
      ];
    }
  }

  static SmimeMessageStatus _failed(SmimeMessageStatus s, String message) => SmimeMessageStatus(
    protection: s.protection,
    encrypted: s.encrypted,
    failure: SmimeDecryptFailure.locked,
    failureMessage: message,
    recipients: s.recipients,
  );

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

  // Passphrases ------------------------------------------------------------------

  /// The key of the user's certificate [fingerprint], asking for its
  /// passphrase when it has one and is locked (once, however many callers
  /// wait). Null when they cancel, or there is no key.
  Future<SmimeKeyHandle?> unlock(String fingerprint) {
    final ready = keys.smimeKey(fingerprint);
    if (ready != null) return Future.value(ready);
    // The callback returns nothing: returning the removed future would make it wait for itself.
    return _unlocking[fingerprint] ??= _unlock(fingerprint).whenComplete(() {
      _unlocking.remove(fingerprint);
    });
  }

  Future<SmimeKeyHandle?> _unlock(String fingerprint) async {
    final own = state.ownCertificate(fingerprint);
    if (own == null) return null;
    final protected = await store.protectedKey(fingerprint);
    if (protected == null) {
      final key = await store.privateKey(fingerprint);
      if (key != null) keys.put(fingerprint, key);
      return key;
    }
    final prompt = this.prompt;
    if (prompt == null) return null;
    String? error;
    while (true) {
      final passphrase = await prompt(own.certificate, error: error);
      if (passphrase == null) return null;
      try {
        final key = await run(() => unprotectKey(protected, passphrase, fingerprint: fingerprint));
        keys.putUnlocked(fingerprint, key);
        return key;
      } on SmimeException catch (e) {
        if (e.kind != SmimeErrorKind.wrongPassword) rethrow;
        error = 'That passphrase is wrong. Try again.';
      }
    }
  }

  /// Protects the key of [fingerprint] with [passphrase] (a new one, or
  /// another), unlocking it first. False when the user cancelled.
  Future<bool> setPassphrase(String fingerprint, String passphrase) async {
    final key = await unlock(fingerprint);
    if (key is! SmimePrivateKey) return false;
    final protected = await run(() => protectKey(key, passphrase, fingerprint: fingerprint));
    await store.setKeyProtection(fingerprint, protectedKey: protected);
    keys.putUnlocked(fingerprint, key);
    return true;
  }

  /// Stores the key of [fingerprint] without a passphrase again (the
  /// keychain protects it), unlocking it first. False when the user cancelled.
  Future<bool> removePassphrase(String fingerprint) async {
    final key = await unlock(fingerprint);
    if (key is! SmimePrivateKey) return false;
    await store.setKeyProtection(fingerprint, key: key);
    keys.put(fingerprint, key);
    return true;
  }

  /// Locks every key unlocked with its passphrase (Lock Keys Now).
  void lockAll() => keys.lockAll();

  /// Adds the certificate the user picked from the device ([alias]), its
  /// key staying there. Returns it, or throws [SmimeException] when it
  /// can't be used for mail.
  Future<SmimeOwnCertificate> addDeviceCertificate(String alias) async {
    final device = this.device;
    if (device == null || !device.supported) {
      throw const SmimeException(SmimeErrorKind.unsupported, 'This device doesn’t offer its certificates.');
    }
    final ders = await device.chain(alias);
    final List<SmimeCertificate> chain;
    try {
      chain = await run(() => [for (final d in ders) SmimeCertificate.fromDer(d)]);
    } on SmimeException {
      throw const SmimeException(SmimeErrorKind.malformed, 'Loupe can’t read this certificate.');
    }
    final certificate = chain.first;
    if (certificate.emails.isEmpty || !(certificate.canSign || certificate.canEncrypt)) {
      throw const SmimeException(
        SmimeErrorKind.certificateUnusable,
        'This certificate isn’t for mail: it has no email address, or isn’t meant for signing or encrypting.',
      );
    }
    final key = SmimePlatformKey(alias);
    await store.addOwn(SmimeKeyPair(certificate, key), chain: chain.skip(1).toList(), now: _clock());
    keys.put(certificate.fingerprint, key);
    return state.ownCertificate(certificate.fingerprint)!;
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
