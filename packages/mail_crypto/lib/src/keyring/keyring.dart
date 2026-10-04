/// The user's keys, their contacts' keys and per-address settings,
/// persisted in a key-value secret store (the platform keychain).
library;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import '../autocrypt.dart';
import '../pgp/types.dart';

/// Thunderbird's "acceptance" of a correspondent's key.
enum KeyAcceptance {
  /// Never use it.
  rejected,

  /// Known, not accepted yet ("Not yet, maybe later").
  undecided,

  /// Accepted without checking the fingerprint ("Yes, but I have not
  /// verified that this is the correct key").
  unverified,

  /// The fingerprint was checked with its owner ("Yes, I've verified in person").
  verified,
}

/// Where a correspondent's key came from.
enum KeySource { imported, attachment, autocrypt }

/// A correspondent's public key with its acceptance.
final class PublicKeyEntry {
  const PublicKeyEntry({
    required this.key,
    required this.acceptance,
    required this.added,
    this.source = KeySource.imported,
  });

  final PgpKey key;
  final KeyAcceptance acceptance;
  final DateTime added;
  final KeySource source;

  bool get isAccepted => acceptance == KeyAcceptance.unverified || acceptance == KeyAcceptance.verified;

  PublicKeyEntry copyWith({KeyAcceptance? acceptance, PgpKey? key}) =>
      PublicKeyEntry(key: key ?? this.key, acceptance: acceptance ?? this.acceptance, added: added, source: source);

  Map<String, Object?> toJson() => {
    'key': pgpKeyToJson(key),
    'acceptance': acceptance.name,
    'added': added.toUtc().toIso8601String(),
    'source': source.name,
  };

  static PublicKeyEntry fromJson(Map<String, Object?> j) => PublicKeyEntry(
    key: pgpKeyFromJson((j['key']! as Map).cast()),
    acceptance: KeyAcceptance.values.asNameMap()[j['acceptance']] ?? KeyAcceptance.undecided,
    added: DateTime.tryParse(j['added'] as String? ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0),
    source: KeySource.values.asNameMap()[j['source']] ?? KeySource.imported,
  );
}

/// OpenPGP settings of one sending address (Thunderbird keeps them per identity).
final class IdentityPgp {
  const IdentityPgp({
    this.keyFingerprint,
    this.encryptByDefault = false,
    this.autoEncrypt = true,
    this.signByDefault = false,
    this.attachPublicKey = false,
    this.autocrypt = true,
    this.preferEncrypt = false,
  });

  static const defaults = IdentityPgp();

  /// The user's key for this address; null picks the newest own key with
  /// the address in its user ids.
  final String? keyFingerprint;

  /// Every message is encrypted unless turned off ("Require encryption").
  final bool encryptByDefault;

  /// Encrypt automatically when every recipient has an accepted key (or
  /// Autocrypt says both sides want it).
  final bool autoEncrypt;

  /// Sign unencrypted messages too (encrypted ones are always signed).
  final bool signByDefault;

  /// Attach the public key (`OpenPGP_0x….asc`) to every message.
  final bool attachPublicKey;

  /// Send the `Autocrypt` header.
  final bool autocrypt;

  /// Autocrypt `prefer-encrypt=mutual`.
  final bool preferEncrypt;

  IdentityPgp copyWith({
    String? keyFingerprint,
    bool clearKey = false,
    bool? encryptByDefault,
    bool? autoEncrypt,
    bool? signByDefault,
    bool? attachPublicKey,
    bool? autocrypt,
    bool? preferEncrypt,
  }) => IdentityPgp(
    keyFingerprint: clearKey ? null : keyFingerprint ?? this.keyFingerprint,
    encryptByDefault: encryptByDefault ?? this.encryptByDefault,
    autoEncrypt: autoEncrypt ?? this.autoEncrypt,
    signByDefault: signByDefault ?? this.signByDefault,
    attachPublicKey: attachPublicKey ?? this.attachPublicKey,
    autocrypt: autocrypt ?? this.autocrypt,
    preferEncrypt: preferEncrypt ?? this.preferEncrypt,
  );

  Map<String, Object?> toJson() => {
    'key': ?keyFingerprint,
    'encrypt': encryptByDefault,
    'auto': autoEncrypt,
    'sign': signByDefault,
    'attach': attachPublicKey,
    'autocrypt': autocrypt,
    'mutual': preferEncrypt,
  };

  static IdentityPgp fromJson(Map<String, Object?> j) => IdentityPgp(
    keyFingerprint: j['key'] as String?,
    encryptByDefault: j['encrypt'] == true,
    autoEncrypt: j['auto'] != false,
    signByDefault: j['sign'] == true,
    attachPublicKey: j['attach'] == true,
    autocrypt: j['autocrypt'] != false,
    preferEncrypt: j['mutual'] == true,
  );
}

Map<String, Object?> pgpKeyToJson(PgpKey k) => {
  'data': base64.encode(k.data),
  'version': k.version,
  'fingerprint': k.fingerprint,
  'keyIds': k.keyIds.toList(),
  'userIds': k.userIds,
  'created': k.created.toUtc().toIso8601String(),
  if (k.expires != null) 'expires': k.expires!.toUtc().toIso8601String(),
  if (k.revoked) 'revoked': true,
  'algorithm': k.algorithm,
  if (k.hasSecret) 'secret': true,
  if (k.isProtected) 'protected': true,
  if (k.canEncrypt) 'encrypt': true,
  if (k.canSign) 'sign': true,
};

PgpKey pgpKeyFromJson(Map<String, Object?> j) => PgpKey(
  data: base64.decode(j['data']! as String),
  version: j['version'] as int? ?? 4,
  fingerprint: j['fingerprint']! as String,
  keyIds: {for (final id in j['keyIds']! as List) id as String},
  userIds: [for (final u in j['userIds']! as List) u as String],
  created: DateTime.parse(j['created']! as String),
  expires: j['expires'] == null ? null : DateTime.parse(j['expires']! as String),
  revoked: j['revoked'] == true,
  algorithm: j['algorithm'] as String? ?? '',
  hasSecret: j['secret'] == true,
  isProtected: j['protected'] == true,
  canEncrypt: j['encrypt'] == true,
  canSign: j['sign'] == true,
);

/// Where a [Keyring] keeps its data; the app passes the platform keychain.
abstract interface class KeyringStorage {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

/// [KeyringStorage] in memory: tests and demo mode.
final class MemoryKeyringStorage implements KeyringStorage {
  MemoryKeyringStorage([Map<String, String>? values]) : values = values ?? {};
  final Map<String, String> values;

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async => values[key] = value;

  @override
  Future<void> delete(String key) async => values.remove(key);
}

/// Everything the keyring knows, immutable. Secret key material isn't
/// here: only the public part of the user's own keys ([ownKeys]).
final class KeyringState {
  const KeyringState({
    this.ownKeys = const [],
    this.publicKeys = const [],
    this.identities = const {},
    this.peers = const {},
  });

  static const empty = KeyringState();

  /// The user's keys (public parts; [PgpKey.isProtected] tells whether the
  /// secret part needs a passphrase), newest first.
  final List<PgpKey> ownKeys;

  /// Correspondents' keys.
  final List<PublicKeyEntry> publicKeys;

  /// Settings by lower-cased address.
  final Map<String, IdentityPgp> identities;

  /// Autocrypt peers by lower-cased address.
  final Map<String, AutocryptPeer> peers;

  bool get hasOwnKeys => ownKeys.isNotEmpty;

  IdentityPgp identity(String email) => identities[email.trim().toLowerCase()] ?? IdentityPgp.defaults;

  PgpKey? ownKey(String fingerprint) => ownKeys.where((k) => k.fingerprint == fingerprint).firstOrNull;

  /// The user's key for sending from [email]: the one chosen for the
  /// address, else the newest valid own key with the address.
  PgpKey? ownKeyFor(String email, {DateTime? now}) {
    final chosen = identity(email).keyFingerprint;
    if (chosen != null) return ownKey(chosen);
    final at = now ?? DateTime.now();
    return ownKeys.where((k) => k.hasEmail(email) && k.isValidAt(at)).firstOrNull;
  }

  PublicKeyEntry? publicEntry(String fingerprint) =>
      publicKeys.where((e) => e.key.fingerprint == fingerprint).firstOrNull;

  /// How far a key is trusted: own keys count as verified.
  KeyAcceptance? acceptanceOf(String fingerprint) {
    if (ownKey(fingerprint) != null) return KeyAcceptance.verified;
    return publicEntry(fingerprint)?.acceptance;
  }

  /// Keys whose signatures can be checked: own keys, every correspondent
  /// key that isn't rejected, and Autocrypt keys (parsed by the caller).
  List<PgpKey> get verificationKeys => [
    ...ownKeys,
    for (final e in publicKeys)
      if (e.acceptance != KeyAcceptance.rejected) e.key,
  ];

  /// Accepted, valid keys of [email] that can encrypt, best first
  /// (verified before unverified, newest first).
  List<PublicKeyEntry> acceptedKeysFor(String email, {DateTime? now}) {
    final at = now ?? DateTime.now();
    final list = [
      for (final e in publicKeys)
        if (e.isAccepted && e.key.hasEmail(email) && e.key.isValidAt(at) && e.key.canEncrypt) e,
    ];
    list.sort((a, b) {
      final byAcceptance = b.acceptance.index - a.acceptance.index;
      return byAcceptance != 0 ? byAcceptance : b.key.created.compareTo(a.key.created);
    });
    return list;
  }

  KeyringState copyWith({
    List<PgpKey>? ownKeys,
    List<PublicKeyEntry>? publicKeys,
    Map<String, IdentityPgp>? identities,
    Map<String, AutocryptPeer>? peers,
  }) => KeyringState(
    ownKeys: ownKeys ?? this.ownKeys,
    publicKeys: publicKeys ?? this.publicKeys,
    identities: identities ?? this.identities,
    peers: peers ?? this.peers,
  );

  Map<String, Object?> toJson() => {
    'version': 1,
    'own': [for (final k in ownKeys) pgpKeyToJson(k)],
    'public': [for (final e in publicKeys) e.toJson()],
    'identities': {for (final MapEntry(:key, :value) in identities.entries) key: value.toJson()},
    'autocrypt': {for (final MapEntry(:key, :value) in peers.entries) key: value.toJson()},
  };

  static KeyringState fromJson(Map<String, Object?> j) => KeyringState(
    ownKeys: [for (final k in j['own'] as List? ?? const []) pgpKeyFromJson((k as Map).cast())],
    publicKeys: [for (final e in j['public'] as List? ?? const []) PublicKeyEntry.fromJson((e as Map).cast())],
    identities: {
      for (final MapEntry(:key, :value) in ((j['identities'] as Map?) ?? const {}).entries)
        key as String: IdentityPgp.fromJson((value as Map).cast()),
    },
    peers: {
      for (final MapEntry(:key, :value) in ((j['autocrypt'] as Map?) ?? const {}).entries)
        key as String: AutocryptPeer.fromJson((value as Map).cast()),
    },
  );
}

/// The keyring: loads and saves [KeyringState], keeps the secret keys
/// apart (one storage entry each), serialises writes.
final class Keyring {
  Keyring(this.storage, {this.prefix = 'openpgp'});

  final KeyringStorage storage;

  /// Prefix of the storage keys: `$prefix.keyring`, `$prefix.secret.<FPR>`.
  final String prefix;

  KeyringState _state = KeyringState.empty;
  final _changes = StreamController<KeyringState>.broadcast();
  Future<void> _queue = Future.value();
  bool _loaded = false;

  KeyringState get state => _state;
  bool get isLoaded => _loaded;

  /// Emits the new state after every change.
  Stream<KeyringState> get changes => _changes.stream;

  String get _stateKey => '$prefix.keyring';
  String _secretKey(String fingerprint) => '$prefix.secret.$fingerprint';

  /// The stored state couldn't be read (the keychain failed, as Android's
  /// Keystore sometimes does): nothing is written until a [load] succeeds,
  /// so a hiccup never replaces what is stored with an empty state (things
  /// are written without the user asking: collected certificates,
  /// Autocrypt keys).
  bool get isUnreadable => _unreadable;
  bool _unreadable = false;

  /// Reads the stored state; a damaged entry starts empty rather than
  /// failing. A keychain that can't be read throws, and blocks writes.
  Future<KeyringState> load() async {
    final String? raw;
    try {
      raw = await storage.read(_stateKey);
    } on Object {
      _unreadable = true;
      rethrow;
    }
    _unreadable = false;
    if (raw != null) {
      try {
        _state = KeyringState.fromJson((jsonDecode(raw) as Map).cast());
      } on Object {
        _state = KeyringState.empty;
      }
    }
    _loaded = true;
    _changes.add(_state);
    return _state;
  }

  Future<T> _write<T>(Future<T> Function() change, {bool evenUnreadable = false}) {
    if (_unreadable && !evenUnreadable) {
      return Future.error(
        const PgpException(
          PgpErrorKind.failed,
          'The keychain couldn’t be read, so nothing was changed. Restart Loupe and try again.',
        ),
      );
    }
    final result = _queue.then((_) => change());
    _queue = result.then((_) {}, onError: (Object _) {});
    return result;
  }

  Future<void> _save(KeyringState next) async {
    _state = next;
    await storage.write(_stateKey, jsonEncode(next.toJson()));
    _changes.add(next);
  }

  /// Adds (or replaces) an own key. [secret] is the transferable secret
  /// key as stored (protected or not); [public] its public part.
  Future<void> addOwnKey({required PgpKey secret, required PgpKey public}) => _write(() async {
    if (!secret.hasSecret) throw ArgumentError('Not a secret key');
    await storage.write(_secretKey(secret.fingerprint), base64.encode(secret.data));
    final described = PgpKey(
      data: public.data,
      version: public.version,
      fingerprint: public.fingerprint,
      keyIds: public.keyIds,
      userIds: public.userIds,
      created: public.created,
      expires: public.expires,
      revoked: public.revoked,
      algorithm: public.algorithm,
      isProtected: secret.isProtected,
      canEncrypt: public.canEncrypt,
      canSign: public.canSign,
    );
    final own = [
      described,
      for (final k in _state.ownKeys)
        if (k.fingerprint != secret.fingerprint) k,
    ]..sort((a, b) => b.created.compareTo(a.created));
    await _save(_state.copyWith(ownKeys: own));
  });

  /// The stored secret key of [fingerprint] (protected as imported), or null.
  Future<PgpKey?> secretKey(String fingerprint, PgpBackend backend) async {
    final raw = await storage.read(_secretKey(fingerprint));
    if (raw == null) return null;
    return backend.readKeys(Uint8List.fromList(base64.decode(raw))).first;
  }

  /// Forgets an own key, its secret part and its identity choices.
  Future<void> removeOwnKey(String fingerprint) => _write(() async {
    await storage.delete(_secretKey(fingerprint));
    await _save(
      _state.copyWith(
        ownKeys: [
          for (final k in _state.ownKeys)
            if (k.fingerprint != fingerprint) k,
        ],
        identities: {
          for (final MapEntry(:key, :value) in _state.identities.entries)
            key: value.keyFingerprint == fingerprint ? value.copyWith(clearKey: true) : value,
        },
      ),
    );
  });

  /// Adds correspondents' keys (merging with known ones: a newer copy of
  /// a key replaces the old one and keeps its acceptance). Own keys are skipped.
  Future<List<PgpKey>> addPublicKeys(
    List<PgpKey> keys, {
    KeyAcceptance acceptance = KeyAcceptance.undecided,
    KeySource source = KeySource.imported,
    DateTime? now,
  }) => _write(() async {
    final added = <PgpKey>[];
    final list = [..._state.publicKeys];
    for (final k in keys) {
      if (_state.ownKey(k.fingerprint) != null || k.hasSecret) continue;
      final i = list.indexWhere((e) => e.key.fingerprint == k.fingerprint);
      if (i >= 0) {
        final old = list[i];
        final keep = old.acceptance.index >= acceptance.index ? old.acceptance : acceptance;
        list[i] = old.copyWith(key: k.data.length >= old.key.data.length ? k : old.key, acceptance: keep);
      } else {
        list.add(PublicKeyEntry(key: k, acceptance: acceptance, added: now ?? DateTime.now(), source: source));
      }
      added.add(k);
    }
    await _save(_state.copyWith(publicKeys: list));
    return added;
  });

  Future<void> setAcceptance(String fingerprint, KeyAcceptance acceptance) => _write(() async {
    await _save(
      _state.copyWith(
        publicKeys: [
          for (final e in _state.publicKeys) e.key.fingerprint == fingerprint ? e.copyWith(acceptance: acceptance) : e,
        ],
      ),
    );
  });

  Future<void> removePublicKey(String fingerprint) => _write(() async {
    await _save(
      _state.copyWith(
        publicKeys: [
          for (final e in _state.publicKeys)
            if (e.key.fingerprint != fingerprint) e,
        ],
      ),
    );
  });

  Future<void> setIdentity(String email, IdentityPgp settings) => _write(() async {
    await _save(_state.copyWith(identities: {..._state.identities, email.trim().toLowerCase(): settings}));
  });

  /// Stores Autocrypt peers (after [updatePeer] / [updateGossip]).
  Future<void> putPeers(Iterable<AutocryptPeer> peers) => _write(() async {
    final next = {..._state.peers};
    for (final p in peers) {
      next[p.addr] = p;
    }
    await _save(_state.copyWith(peers: next));
  });

  /// Forgets everything (Settings › Reset).
  Future<void> clear() => _write(() async {
    for (final k in _state.ownKeys) {
      await storage.delete(_secretKey(k.fingerprint));
    }
    await storage.delete(_stateKey);
    _state = KeyringState.empty;
    _changes.add(_state);
  }, evenUnreadable: true);

  Future<void> dispose() => _changes.close();
}
