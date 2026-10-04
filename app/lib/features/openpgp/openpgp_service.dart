import 'dart:async';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import 'openpgp_providers.dart';

/// What reading a protected message gave: its status, and the content to
/// show for an encrypted one.
final class PgpReadOutcome {
  const PgpReadOutcome({required this.status, this.content, this.entity, this.text});

  final PgpMessageStatus status;

  /// The decrypted message as reader content (part ids `pgp:…`).
  final EmailContent? content;

  /// The decrypted MIME tree, to serve attachments from.
  final MimeEntity? entity;

  /// Inline PGP: the text with the armored block replaced.
  final String? text;
}

/// OpenPGP for the screens: unlocking keys (asking for passphrases),
/// reading protected mail, importing, generating and exporting keys, and
/// learning keys from Autocrypt headers.
final class OpenPgpService implements PgpSendKeys {
  OpenPgpService({
    required this.keyring,
    required this.session,
    required this.backend,
    required this.run,
    required this.prompt,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now {
    unawaited(_pinUnprotectedKeys());
  }

  final Keyring keyring;
  final KeySession session;
  final PgpBackend backend;
  final PgpRunner run;
  final PassphrasePrompt prompt;
  final DateTime Function() _clock;
  final _unlocking = <String, Future<PgpKey?>>{};

  @override
  KeyringState get state => keyring.state;

  @override
  PgpKey? unlockedKey(String fingerprint) => session[fingerprint];

  /// Keys stored without a passphrase are unlocked from the start, so
  /// sending signed mail never stops to ask.
  Future<void> _pinUnprotectedKeys() async {
    for (final k in state.ownKeys) {
      if (k.isProtected || session.isUnlocked(k.fingerprint)) continue;
      try {
        final secret = await keyring.secretKey(k.fingerprint, backend);
        if (secret != null && !secret.isProtected) session.put(secret, pin: true);
      } on Object {
        // Unreadable: it will be asked for (and fail) when needed.
      }
    }
  }

  // Unlocking -----------------------------------------------------------------

  /// The unlocked secret key of [fingerprint], asking for its passphrase
  /// when needed (once, however many callers wait). Null if cancelled.
  Future<PgpKey?> unlock(String fingerprint) async {
    final cached = session[fingerprint];
    if (cached != null) return cached;
    // The callback returns nothing: returning the removed future would make it wait for itself.
    return _unlocking[fingerprint] ??= _unlock(fingerprint).whenComplete(() {
      _unlocking.remove(fingerprint);
    });
  }

  Future<PgpKey?> _unlock(String fingerprint) async {
    final info = state.ownKey(fingerprint);
    final secret = await keyring.secretKey(fingerprint, backend);
    if (info == null || secret == null) return null;
    if (!secret.isProtected) {
      session.put(secret, pin: true);
      return secret;
    }
    final unlocked = await _askPassphrase(info, secret);
    if (unlocked != null) session.put(unlocked);
    return unlocked;
  }

  /// Asks until the passphrase unlocks [secret] or the user cancels.
  Future<PgpKey?> _askPassphrase(PgpKey info, PgpKey secret) async {
    final b = backend;
    String? error;
    while (true) {
      final passphrase = await prompt(info, error: error);
      if (passphrase == null) return null;
      try {
        return await run(() => b.unlock(secret, passphrase));
      } on PgpException catch (e) {
        if (e.kind != PgpErrorKind.wrongPassphrase) rethrow;
        error = 'That passphrase is wrong. Try again.';
      }
    }
  }

  /// The user's keys a message was encrypted to (all of them for a hidden
  /// recipient).
  List<PgpKey> ownKeysFor(List<String> recipientKeyIds) {
    final hidden = recipientKeyIds.contains('0000000000000000');
    return [
      for (final k in state.ownKeys)
        if (hidden || k.keyIds.any(recipientKeyIds.contains)) k,
    ];
  }

  /// Forgets every passphrase (Lock Keys Now).
  void lockAll() => session.lockAll();

  // Reading -------------------------------------------------------------------

  /// Decrypts and verifies the raw message of [emailId], unlocking the
  /// right key first. [encrypted] says whether decryption is needed.
  Future<PgpReadOutcome> read(String emailId, Uint8List raw, {required bool encrypted}) async {
    final b = backend;
    var keys = const <PgpKey>[];
    if (encrypted) {
      final ids = await run(() => PgpMimeReader(b).recipientsOf(raw));
      final mine = ownKeysFor(ids);
      for (final k in mine) {
        final unlocked = await unlock(k.fingerprint);
        if (unlocked != null) keys = [...keys, unlocked];
      }
      if (mine.isNotEmpty && keys.isEmpty) {
        return PgpReadOutcome(
          status: PgpMessageStatus(
            protection: PgpProtection.pgpMimeEncrypted,
            encrypted: true,
            failure: PgpDecryptFailure.locked,
            failureMessage: 'Your key is locked.',
            recipientKeyIds: ids,
          ),
        );
      }
    }
    final verifiers = state.verificationKeys;
    final unlocked = keys;
    return run(() {
      final r = PgpMimeReader(b).read(raw, keys: unlocked, verifiers: verifiers);
      final entity = r.entity;
      final content = r.status.decrypted && entity != null ? contentFromEntity(entity, emailId: emailId) : null;
      return PgpReadOutcome(
        status: r.status,
        content: content,
        entity: r.status.decrypted ? entity : null,
        text: r.text,
      );
    });
  }

  // Autocrypt -----------------------------------------------------------------

  /// Level 1 §2.3: learns from a message from [from] dated [date]: its
  /// Autocrypt header updates the peer, and a new key joins the keyring as
  /// undecided ("from Autocrypt").
  Future<void> learnAutocrypt({
    required String from,
    required DateTime date,
    required List<(String, String)> headers,
  }) async {
    final address = from.trim().toLowerCase();
    if (address.isEmpty || state.ownKeys.any((k) => k.hasEmail(address))) return;
    final header = autocryptHeaderFrom(headers, address);
    final peer = state.peers[address];
    if (header == null && peer == null) return;
    String? fingerprint;
    if (header != null) fingerprint = await _learnKey(header.keydata);
    final now = _clock();
    final effective = date.isAfter(now) ? now : date;
    final next = updatePeer(
      peer,
      address,
      effective,
      fingerprint: fingerprint,
      preferMutual: header?.preferMutual ?? false,
    );
    if (!identical(next, peer)) await keyring.putPeers([next]);
  }

  /// Autocrypt-Gossip from inside an encrypted message, for addresses it
  /// was sent to.
  Future<void> learnGossip(List<String> gossip, {required Set<String> recipients, required DateTime date}) async {
    final peers = <AutocryptPeer>[];
    for (final value in gossip) {
      final h = AutocryptHeader.parse(value);
      if (h == null || !recipients.contains(h.addr) || state.ownKeys.any((k) => k.hasEmail(h.addr))) continue;
      final fingerprint = await _learnKey(h.keydata);
      if (fingerprint == null) continue;
      final next = updateGossip(state.peers[h.addr], h.addr, date, fingerprint);
      if (!identical(next, state.peers[h.addr])) peers.add(next);
    }
    if (peers.isNotEmpty) await keyring.putPeers(peers);
  }

  Future<String?> _learnKey(Uint8List keydata) async {
    final b = backend;
    try {
      final key = (await run(() => b.readKeys(keydata))).first;
      if (key.hasSecret) return null;
      if (state.publicEntry(key.fingerprint) == null) {
        await keyring.addPublicKeys([key], source: KeySource.autocrypt);
      }
      return key.fingerprint;
    } on PgpException {
      return null;
    }
  }

  // Keys ------------------------------------------------------------------------

  /// Every key in [data]: pasted text, a file or an attachment.
  Future<List<PgpKey>> parseKeys(Uint8List data) {
    final b = backend;
    return run(() => b.readKeys(data));
  }

  /// Adds the user's secret key, asking for its passphrase first so a
  /// mistyped one shows now. Returns null if the user cancelled.
  Future<PgpKey?> importSecretKey(PgpKey secret) async {
    final public = backend.publicKey(secret);
    PgpKey? unlocked = secret;
    if (secret.isProtected) unlocked = await _askPassphrase(public, secret);
    if (unlocked == null) return null;
    await keyring.addOwnKey(secret: secret, public: public);
    session.put(unlocked, pin: !secret.isProtected);
    return state.ownKey(secret.fingerprint);
  }

  /// Adds correspondents' keys.
  Future<List<PgpKey>> importPublicKeys(
    List<PgpKey> keys, {
    KeyAcceptance acceptance = KeyAcceptance.undecided,
    KeySource source = KeySource.imported,
  }) => keyring.addPublicKeys(
    [for (final k in keys) k.hasSecret ? backend.publicKey(k) : k],
    acceptance: acceptance,
    source: source,
  );

  /// A new Curve25519 key for [email], valid for [validity] (forever when
  /// null), protected by [passphrase] unless it is empty. It becomes the
  /// address's key.
  Future<PgpKey> generateKey({
    required String name,
    required String email,
    String passphrase = '',
    Duration? validity,
  }) async {
    final b = backend;
    final userId = name.trim().isEmpty ? email.trim() : '${name.trim()} <${email.trim()}>';
    final secret = await run(() => b.generate(userId: userId, passphrase: passphrase, validity: validity));
    final unlocked = passphrase.isEmpty ? secret : await run(() => b.unlock(secret, passphrase));
    await keyring.addOwnKey(secret: secret, public: b.publicKey(secret));
    session.put(unlocked, pin: passphrase.isEmpty);
    final settings = state.identity(email);
    if (settings.keyFingerprint == null) {
      await keyring.setIdentity(email, settings.copyWith(keyFingerprint: secret.fingerprint));
    }
    return state.ownKey(secret.fingerprint)!;
  }

  /// Deletes one of the user's keys (its secret part too).
  Future<void> deleteOwnKey(String fingerprint) async {
    session.clear();
    await keyring.removeOwnKey(fingerprint);
    await _pinUnprotectedKeys();
  }

  /// The ASCII-armored public key of [fingerprint] (own or a correspondent's).
  String? armoredPublicKey(String fingerprint) {
    final key = state.ownKey(fingerprint) ?? state.publicEntry(fingerprint)?.key;
    return key == null ? null : backend.armor(key);
  }

  /// The user's secret key as stored (protected by its passphrase, if any), armored.
  Future<String?> armoredSecretKey(String fingerprint) async {
    final secret = await keyring.secretKey(fingerprint, backend);
    return secret == null ? null : backend.armor(secret);
  }
}
