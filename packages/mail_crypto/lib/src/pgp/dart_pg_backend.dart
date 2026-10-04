// dart_pg's public API hides the enums and interfaces needed to generate
// Thunderbird-compatible keys (features, preferences), to verify signatures
// made by subkeys and to decrypt with any matching subkey. This is the only
// file that reaches into dart_pg internals; pubspec pins dart_pg to an exact
// version because of it.
// ignore_for_file: implementation_imports

/// [PgpBackend] on dart_pg (pure Dart, BSD-3-Clause).
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_pg/dart_pg.dart'
    show
        BaseKey,
        Ecc,
        EncryptedMessage,
        LiteralMessage,
        PacketList,
        PrivateKey,
        PublicKey,
        PublicKeyEncryptedSessionKeyPacket,
        PublicSubkeyPacket,
        SecretKeyPacket,
        SecretSubkeyPacket,
        SignaturePacket,
        SymmetricAlgorithm,
        UserIDPacket,
        KeyFlags,
        Features,
        KeyExpirationTime,
        PreferredSymmetricAlgorithms,
        PreferredHashAlgorithms,
        PreferredCompressionAlgorithms,
        PrimaryUserID;
import 'package:dart_pg/src/enum/packet_type.dart';
import 'package:dart_pg/src/enum/signature_type.dart';
import 'package:dart_pg/src/type/encrypted_data_packet.dart';
import 'package:dart_pg/src/type/key_packet.dart';
import 'package:dart_pg/src/type/packet.dart';
import 'package:dart_pg/src/type/signature_packet.dart';

import 'armor.dart';
import 'types.dart';

/// The default backend: dart_pg.
final class DartPgBackend implements PgpBackend {
  const DartPgBackend();

  // Keys -----------------------------------------------------------------------

  @override
  List<PgpKey> readKeys(Uint8List input) {
    final binaries = <Uint8List>[];
    if (_looksArmored(input)) {
      final List<ArmorBlock> blocks;
      try {
        blocks = dearmorAll(utf8.decode(input, allowMalformed: true));
      } on FormatException catch (e) {
        throw PgpException(PgpErrorKind.malformed, e.message);
      }
      binaries.addAll([
        for (final b in blocks)
          if (b.label == 'PGP PUBLIC KEY BLOCK' || b.label == 'PGP PRIVATE KEY BLOCK') b.data,
      ]);
    } else {
      binaries.add(input);
    }
    final keys = <PgpKey>[];
    for (final binary in binaries) {
      for (final key in _splitKeys(_decode(binary))) {
        keys.add(_describe(key));
      }
    }
    if (keys.isEmpty) throw const PgpException(PgpErrorKind.malformed, 'No OpenPGP key found.');
    return keys;
  }

  @override
  PgpKey generate({required String userId, String passphrase = '', Duration? validity, DateTime? now}) {
    final time = (now ?? DateTime.now()).toUtc();
    final expiry = validity?.inSeconds ?? 0;
    final primary = SecretKeyPacket.generate(KeyAlgorithm.eddsaLegacy, curve: Ecc.ed25519, time: time);
    final uid = UserIDPacket(userId);
    final certification = SignaturePacket.createSignature(
      primary,
      SignatureType.certPositive,
      Uint8List.fromList([...primary.signBytes, ...uid.signBytes]),
      time: time,
      subpackets: [
        KeyFlags.fromFlags(KeyFlag.certifyKeys.value | KeyFlag.signData.value),
        // As Thunderbird: AES-256 first, SHA-512 first, no AEAD and only
        // SEIPD v1 in the features, so every OpenPGP mail client can write to it.
        PreferredSymmetricAlgorithms(Uint8List.fromList([9, 8, 7])),
        PreferredHashAlgorithms(Uint8List.fromList([10, 9, 8, 11])),
        PreferredCompressionAlgorithms(Uint8List.fromList([2, 1, 0])),
        Features.fromFeatures(0x01),
        PrimaryUserID(Uint8List.fromList([1])),
        if (expiry > 0) KeyExpirationTime.fromTime(expiry),
      ],
    );
    final subkey = SecretSubkeyPacket.generate(KeyAlgorithm.ecdh, curve: Ecc.curve25519, time: time);
    final binding = SignaturePacket.createSubkeyBinding(primary, subkey, keyExpiry: expiry, time: time);
    final protect = passphrase.isNotEmpty;
    final key = PrivateKey(
      PacketList([
        if (protect) primary.encrypt(passphrase, SymmetricAlgorithm.aes256) else primary,
        uid,
        certification,
        if (protect) subkey.encrypt(passphrase, SymmetricAlgorithm.aes256) else subkey,
        binding,
      ]),
    );
    return _describe(key);
  }

  @override
  PgpKey unlock(PgpKey key, String passphrase) {
    final parsed = _private(key);
    final packets = <PacketInterface>[];
    for (final p in parsed.packetList) {
      if (p is SecretSubkeyPacket) {
        packets.add(_unprotectedSubkey(p.isDecrypted ? p : _decrypt(() => p.decrypt(passphrase))));
      } else if (p is SecretKeyPacket) {
        packets.add(_unprotected(p.isDecrypted ? p : _decrypt(() => p.decrypt(passphrase) as SecretKeyPacket)));
      } else {
        packets.add(p);
      }
    }
    return _describe(PrivateKey(PacketList(packets)));
  }

  T _decrypt<T>(T Function() decrypt) {
    try {
      return decrypt();
    } on Object catch (e) {
      throw PgpException(PgpErrorKind.wrongPassphrase, 'Wrong passphrase.', e);
    }
  }

  SecretKeyPacket _unprotected(SecretKeyPacket p) =>
      SecretKeyPacket(p.publicKey, p.secretKeyMaterial!.toBytes, secretKeyMaterial: p.secretKeyMaterial);

  SecretSubkeyPacket _unprotectedSubkey(SecretSubkeyPacket p) => SecretSubkeyPacket(
    p.publicKey as PublicSubkeyPacket,
    p.secretKeyMaterial!.toBytes,
    secretKeyMaterial: p.secretKeyMaterial,
  );

  @override
  PgpKey publicKey(PgpKey key) => key.hasSecret ? _describe(_private(key).publicKey as BaseKey) : key;

  @override
  PgpKey minimalKey(PgpKey key, String email) {
    final full = _public(key);
    final address = email.trim().toLowerCase();
    final users = full.users.where((u) => !u.isRevoked()).toList();
    final user =
        users.where((u) => emailOfUserId(u.userID) == address).firstOrNull ??
        users.where((u) => u.isPrimary).firstOrNull ??
        users.firstOrNull;
    SignaturePacketInterface? latest(Iterable<SignaturePacketInterface> sigs) => sigs.fold<SignaturePacketInterface?>(
      null,
      (a, s) => a == null || s.creationTime.isAfter(a.creationTime) ? s : a,
    );
    final packets = <PacketInterface>[
      full.keyPacket,
      ...full.directSignatures,
      if (user != null) ...[user.userIDPacket, ?latest(user.selfSignatures)],
      for (final s in full.subkeys)
        if (s.isEncryptionKey && !s.isRevoked()) ...[s.keyPacket, ?latest(s.bindingSignatures)],
    ];
    return _describe(PublicKey(PacketList(packets)));
  }

  @override
  String armor(PgpKey key) => encodeArmor(key.hasSecret ? 'PGP PRIVATE KEY BLOCK' : 'PGP PUBLIC KEY BLOCK', key.data);

  // Messages -------------------------------------------------------------------

  @override
  List<String> recipientKeyIds(Uint8List message) => [
    for (final p in _decode(_messageBytes(message)).whereType<PublicKeyEncryptedSessionKeyPacket>()) _hex(p.keyID),
  ];

  @override
  PgpDecryption decrypt(Uint8List message, {required List<PgpKey> keys, List<PgpKey> verifiers = const []}) {
    final packets = _decode(_messageBytes(message));
    final recipients = [for (final p in packets.whereType<PublicKeyEncryptedSessionKeyPacket>()) _hex(p.keyID)];
    final LiteralMessage literal;
    if (packets.whereType<EncryptedDataPacketInterface>().isEmpty) {
      // Signed but not encrypted (`gpg --sign --armor`).
      try {
        literal = LiteralMessage(packets);
      } on Object catch (e) {
        throw PgpException(PgpErrorKind.malformed, 'This isn’t an OpenPGP message.', e);
      }
    } else {
      final candidates = [
        for (final k in keys)
          if (k.hasSecret) _private(k),
      ];
      final encrypted = EncryptedMessage(packets);
      ({Uint8List key, SymmetricAlgorithm symmetric})? session;
      for (final pkesk in packets.whereType<PublicKeyEncryptedSessionKeyPacket>()) {
        final wildcard = pkesk.keyID.every((b) => b == 0);
        for (final key in candidates) {
          for (final kp in _decryptionPackets(key)) {
            if (!wildcard && !_bytesEqual(kp.keyID, pkesk.keyID)) continue;
            if (!kp.isDecrypted) {
              throw const PgpException(PgpErrorKind.locked, 'The secret key is locked.');
            }
            try {
              final s = pkesk.decrypt(kp).sessionKey!;
              session = (key: s.encryptionKey, symmetric: s.symmetric);
              break;
            } on Object {
              // Wrong key for a wildcard recipient, or a damaged packet.
            }
          }
          if (session != null) break;
        }
        if (session != null) break;
      }
      if (session == null) {
        throw const PgpException(PgpErrorKind.noSecretKey, 'None of your keys can decrypt this message.');
      }
      try {
        literal = LiteralMessage(encrypted.encryptedPacket.decrypt(session.key, session.symmetric).packets!);
      } on Object catch (e) {
        throw PgpException(PgpErrorKind.malformed, 'The encrypted message is damaged.', e);
      }
    }
    try {
      final data = literal.literalData;
      final signatures = literal.signature.packets.toList();
      return PgpDecryption(
        data: Uint8List.fromList(data.binary),
        filename: data.filename,
        recipientKeyIds: recipients,
        signatures: _verifyAll(signatures, data.binary, verifiers),
      );
    } on PgpException {
      rethrow;
    } on Object catch (e) {
      throw PgpException(PgpErrorKind.malformed, 'The encrypted message is damaged.', e);
    }
  }

  Iterable<SecretKeyPacketInterface> _decryptionPackets(BaseKey key) sync* {
    for (final s in key.subkeys) {
      if (s.isEncryptionKey && s.keyPacket is SecretKeyPacketInterface) yield s.keyPacket as SecretKeyPacketInterface;
    }
    final primary = key.keyPacket;
    if ((primary.keyAlgorithm == KeyAlgorithm.rsaEncryptSign || primary.keyAlgorithm == KeyAlgorithm.elgamal) &&
        primary is SecretKeyPacketInterface) {
      yield primary;
    }
  }

  @override
  String encrypt(Uint8List data, {required List<PgpKey> recipients, PgpKey? signer, DateTime? now}) {
    if (recipients.isEmpty) throw const PgpException(PgpErrorKind.keyUnusable, 'No recipients to encrypt to.');
    final time = now ?? DateTime.now();
    final keys = <BaseKey>[];
    for (final r in recipients) {
      final key = _public(r);
      if (!_canEncryptAt(key, time)) {
        throw PgpException(PgpErrorKind.keyUnusable, 'The key of ${r.displayName} can’t encrypt (expired or revoked).');
      }
      keys.add(key);
    }
    try {
      var message = LiteralMessage.fromLiteralData(data, time: time);
      if (signer != null) {
        message = message.sign([_unlocked(signer)], recipients: keys, time: time) as LiteralMessage;
      }
      final encrypted = message.encrypt(encryptionKeys: keys, symmetric: SymmetricAlgorithm.aes256);
      return encodeArmor('PGP MESSAGE', encrypted.packetList.encode());
    } on PgpException {
      rethrow;
    } on Object catch (e) {
      throw PgpException(PgpErrorKind.failed, 'Encryption failed.', e);
    }
  }

  bool _canEncryptAt(BaseKey key, DateTime time) {
    if (key.isRevoked()) return false;
    final expires = key.expirationTime;
    if (expires != null && !time.isBefore(expires)) return false;
    return key.subkeys.any(
      (s) => s.isEncryptionKey && !s.isRevoked() && (s.expirationTime == null || time.isBefore(s.expirationTime!)),
    );
  }

  @override
  String signDetached(Uint8List data, PgpKey signer, {DateTime? now}) {
    try {
      final time = now ?? DateTime.now();
      final signature = LiteralMessage.fromLiteralData(data, time: time).signDetached([_unlocked(signer)], time: time);
      return encodeArmor('PGP SIGNATURE', signature.packetList.encode());
    } on PgpException {
      rethrow;
    } on Object catch (e) {
      throw PgpException(PgpErrorKind.failed, 'Signing failed.', e);
    }
  }

  @override
  List<PgpSignatureCheck> verifyDetached(Uint8List data, Uint8List signature, List<PgpKey> verifiers) {
    final bytes = _looksArmored(signature) ? _dearmorFirst(signature, 'PGP SIGNATURE') : signature;
    final packets = _decode(bytes).whereType<SignaturePacketInterface>().toList();
    if (packets.isEmpty) throw const PgpException(PgpErrorKind.malformed, 'No signature found.');
    return _verifyAll(packets, data, verifiers);
  }

  @override
  PgpCleartext verifyCleartext(String armored, List<PgpKey> verifiers) {
    final CleartextParts? parts;
    try {
      parts = splitCleartext(armored);
    } on FormatException catch (e) {
      throw PgpException(PgpErrorKind.malformed, e.message);
    }
    if (parts == null) throw const PgpException(PgpErrorKind.malformed, 'No signed message found.');
    final packets = _decode(parts.signature).whereType<SignaturePacketInterface>().toList();
    return PgpCleartext(text: parts.text, signatures: _verifyAll(packets, parts.signedBytes, verifiers));
  }

  // Verification ---------------------------------------------------------------

  List<PgpSignatureCheck> _verifyAll(
    List<SignaturePacketInterface> signatures,
    Uint8List data,
    List<PgpKey> verifiers,
  ) {
    final keys = <BaseKey>[];
    for (final v in verifiers) {
      try {
        keys.add(_public(v));
      } on Object {
        // An unreadable key verifies nothing.
      }
    }
    return [for (final s in signatures) _verifyOne(s, data, keys)];
  }

  PgpSignatureCheck _verifyOne(SignaturePacketInterface sig, Uint8List data, List<BaseKey> keys) {
    var issuer = _hex(sig.issuerKeyID);
    final issuerFpr = sig.issuerFingerprint;
    if (issuer.isEmpty || issuer == '0000000000000000') {
      if (issuerFpr.isNotEmpty) issuer = _hex(issuerFpr.sublist(issuerFpr.length - 8));
    }
    for (final key in keys) {
      for (final kp in [key.keyPacket, for (final s in key.subkeys) s.keyPacket]) {
        if (_hex(kp.keyID) != issuer) continue;
        final fingerprint = _hex(key.fingerprint);
        String? problem;
        if (key.isRevoked()) {
          problem = 'The key was revoked.';
        } else if (key.expirationTime case final exp? when !sig.creationTime.isBefore(exp)) {
          problem = 'The key had expired when it signed.';
        }
        final canonical = sig.signatureType == SignatureType.text ? _canonicalText(data) : data;
        var ok = false;
        try {
          ok = sig.verify(kp, canonical);
        } on Object catch (e) {
          problem ??= _verifyProblem(e);
        }
        return PgpSignatureCheck(
          status: ok && problem == null ? PgpSignatureStatus.good : PgpSignatureStatus.bad,
          issuerKeyId: issuer,
          signerFingerprint: fingerprint,
          created: sig.creationTime,
          detail: ok ? problem : (problem ?? 'The signature doesn’t match the message.'),
        );
      }
    }
    return PgpSignatureCheck(status: PgpSignatureStatus.unknownKey, issuerKeyId: issuer, created: sig.creationTime);
  }

  String _verifyProblem(Object e) {
    final s = e.toString();
    if (s.contains('expired')) return 'The signature has expired.';
    return 'The signature doesn’t match the message.';
  }

  // Parsing --------------------------------------------------------------------

  PacketList _decode(Uint8List bytes) {
    try {
      return PacketList.decode(bytes);
    } on Object catch (e) {
      throw PgpException(PgpErrorKind.malformed, 'This isn’t readable OpenPGP data.', e);
    }
  }

  /// Splits a packet list holding several keys at each primary key.
  List<BaseKey> _splitKeys(PacketList packets) {
    final groups = <List<PacketInterface>>[];
    for (final p in packets) {
      if (p.type == PacketType.publicKey || p.type == PacketType.secretKey) {
        groups.add([p]);
      } else if (groups.isNotEmpty) {
        groups.last.add(p);
      }
    }
    final keys = <BaseKey>[];
    for (final g in groups) {
      try {
        keys.add(g.first.type == PacketType.secretKey ? PrivateKey(PacketList(g)) : PublicKey(PacketList(g)));
      } on Object catch (e) {
        throw PgpException(PgpErrorKind.unsupported, 'This key can’t be used: ${_short(e)}', e);
      }
    }
    return keys;
  }

  BaseKey _public(PgpKey key) {
    final k = _splitKeys(_decode(key.data)).first;
    return k is PrivateKey ? k.publicKey as BaseKey : k;
  }

  PrivateKey _private(PgpKey key) {
    final k = _splitKeys(_decode(key.data)).first;
    if (k is! PrivateKey) throw const PgpException(PgpErrorKind.noSecretKey, 'This is a public key.');
    return k;
  }

  PrivateKey _unlocked(PgpKey key) {
    final k = _private(key);
    if (!k.isDecrypted ||
        k.subkeys.any((s) => s.keyPacket is SecretSubkeyPacket && !(s.keyPacket as SecretSubkeyPacket).isDecrypted)) {
      throw const PgpException(PgpErrorKind.locked, 'The secret key is locked.');
    }
    return k;
  }

  PgpKey _describe(BaseKey key) {
    final now = DateTime.now();
    final secret = key is PrivateKey;
    var protected = false;
    if (secret) {
      for (final p in key.packetList) {
        if (p is SecretKeyPacket && p.isEncrypted) protected = true;
      }
    }
    final primaryAlgorithm = key.keyAlgorithm;
    bool revoked;
    try {
      revoked = key.isRevoked();
    } on Object {
      revoked = false;
    }
    return PgpKey(
      data: Uint8List.fromList(key.packetList.encode()),
      version: key.version,
      fingerprint: _hex(key.fingerprint),
      keyIds: {_hex(key.keyID), for (final s in key.subkeys) _hex(s.keyID)},
      userIds: _userIds(key),
      created: key.creationTime,
      expires: key.expirationTime,
      revoked: revoked,
      algorithm: _algorithmName(primaryAlgorithm, key.keyStrength),
      hasSecret: secret,
      isProtected: protected,
      canEncrypt: _canEncryptAt(key, now),
      canSign: _signs(primaryAlgorithm) || key.subkeys.any((s) => s.isSigningKey),
    );
  }

  List<String> _userIds(BaseKey key) {
    final users = key.users.where((u) => u.userID.isNotEmpty).toList();
    users.sort((a, b) => (b.isPrimary ? 1 : 0) - (a.isPrimary ? 1 : 0));
    return [for (final u in users) u.userID];
  }

  static bool _signs(KeyAlgorithm a) => switch (a) {
    KeyAlgorithm.rsaEncryptSign ||
    KeyAlgorithm.rsaSign ||
    KeyAlgorithm.dsa ||
    KeyAlgorithm.ecdsa ||
    KeyAlgorithm.eddsaLegacy ||
    KeyAlgorithm.ed25519 ||
    KeyAlgorithm.ed448 => true,
    _ => false,
  };

  static String _algorithmName(KeyAlgorithm a, int strength) => switch (a) {
    KeyAlgorithm.rsaEncryptSign || KeyAlgorithm.rsaSign || KeyAlgorithm.rsaEncrypt => 'RSA $strength',
    KeyAlgorithm.eddsaLegacy || KeyAlgorithm.ed25519 => 'Ed25519',
    KeyAlgorithm.ed448 => 'Ed448',
    KeyAlgorithm.ecdsa => 'ECDSA $strength',
    KeyAlgorithm.ecdh || KeyAlgorithm.x25519 => 'Curve25519',
    KeyAlgorithm.x448 => 'X448',
    KeyAlgorithm.dsa => 'DSA $strength',
    _ => a.name.toUpperCase(),
  };

  Uint8List _messageBytes(Uint8List message) =>
      _looksArmored(message) ? _dearmorFirst(message, 'PGP MESSAGE') : message;

  Uint8List _dearmorFirst(Uint8List input, String label) {
    try {
      final block = dearmorAll(utf8.decode(input, allowMalformed: true)).where((b) => b.label == label).firstOrNull;
      if (block == null) throw PgpException(PgpErrorKind.malformed, 'No $label block found.');
      return block.data;
    } on FormatException catch (e) {
      throw PgpException(PgpErrorKind.malformed, e.message);
    }
  }
}

/// Armored input starts (after whitespace) with text; binary OpenPGP data
/// starts with a packet tag (high bit set).
bool _looksArmored(Uint8List input) {
  for (final b in input) {
    if (b == 0x20 || b == 0x09 || b == 0x0d || b == 0x0a) continue;
    return b & 0x80 == 0;
  }
  return false;
}

String _hex(List<int> bytes) => [for (final b in bytes) b.toRadixString(16).padLeft(2, '0')].join().toUpperCase();

bool _bytesEqual(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

/// Text signatures (type 0x01) cover the text with CRLF line ends.
Uint8List _canonicalText(Uint8List data) {
  final out = BytesBuilder(copy: false);
  for (var i = 0; i < data.length; i++) {
    final b = data[i];
    if (b == 0x0a && (i == 0 || data[i - 1] != 0x0d)) {
      out.addByte(0x0d);
    }
    out.addByte(b);
  }
  return out.takeBytes();
}

String _short(Object e) {
  final s = e.toString().replaceFirst(RegExp(r'^[A-Za-z]+(Error|Exception): '), '');
  return s.length > 120 ? '${s.substring(0, 120)}…' : s;
}
