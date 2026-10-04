/// The user's S/MIME certificates (private keys apart, one keychain entry
/// each), correspondents' certificates collected from signed mail or
/// imported, the authorities the user trusts, and per-address settings.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import '../keyring/keyring.dart' show KeyringStorage;
import 'backend.dart';
import 'certificate.dart';
import 'primitives.dart';
import 'status.dart';
import 'trust.dart';

List<String> _ders(List<SmimeCertificate> certs) => [for (final c in certs) base64.encode(c.der)];

List<SmimeCertificate> _certs(Object? list) => [for (final d in (list as List?) ?? const []) ?_tryCert(d as String)];

SmimeCertificate? _tryCert(String b64) {
  try {
    return SmimeCertificate.fromDer(base64.decode(b64));
  } on Object {
    return null;
  }
}

DateTime _date(Object? v) => DateTime.tryParse(v as String? ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0);

/// One of the user's certificates (its private key is in the keychain) and its CA chain.
final class SmimeOwnCertificate {
  const SmimeOwnCertificate({required this.certificate, this.chain = const [], required this.added});

  final SmimeCertificate certificate;
  final List<SmimeCertificate> chain;
  final DateTime added;

  String get fingerprint => certificate.fingerprint;

  Map<String, Object?> toJson() => {
    'cert': base64.encode(certificate.der),
    'chain': _ders(chain),
    'added': added.toUtc().toIso8601String(),
  };

  static SmimeOwnCertificate? fromJson(Map<String, Object?> j) {
    final cert = _tryCert(j['cert'] as String? ?? '');
    if (cert == null) return null;
    return SmimeOwnCertificate(certificate: cert, chain: _certs(j['chain']), added: _date(j['added']));
  }
}

/// Where a correspondent's certificate came from.
enum SmimeCertificateSource {
  /// A signed message from them (as Outlook and Thunderbird collect them).
  collected,

  /// A file the user imported.
  imported,
}

/// A correspondent's certificate, its chain as their mail carried it, and
/// what their app can decrypt.
final class SmimeContactCertificate {
  const SmimeContactCertificate({
    required this.certificate,
    this.chain = const [],
    required this.added,
    this.source = SmimeCertificateSource.collected,
    this.capabilities = const [],
    this.lastSigned,
  });

  final SmimeCertificate certificate;
  final List<SmimeCertificate> chain;
  final DateTime added;
  final SmimeCertificateSource source;

  /// SMIMECapabilities from their newest signed message (algorithm OIDs).
  final List<String> capabilities;

  /// When their newest signed message was signed.
  final DateTime? lastSigned;

  String get fingerprint => certificate.fingerprint;

  Map<String, Object?> toJson() => {
    'cert': base64.encode(certificate.der),
    'chain': _ders(chain),
    'added': added.toUtc().toIso8601String(),
    'source': source.name,
    if (capabilities.isNotEmpty) 'caps': capabilities,
    if (lastSigned != null) 'signed': lastSigned!.toUtc().toIso8601String(),
  };

  static SmimeContactCertificate? fromJson(Map<String, Object?> j) {
    final cert = _tryCert(j['cert'] as String? ?? '');
    if (cert == null) return null;
    return SmimeContactCertificate(
      certificate: cert,
      chain: _certs(j['chain']),
      added: _date(j['added']),
      source: SmimeCertificateSource.values.asNameMap()[j['source']] ?? SmimeCertificateSource.collected,
      capabilities: [for (final c in (j['caps'] as List?) ?? const []) c as String],
      lastSigned: j['signed'] == null ? null : _date(j['signed']),
    );
  }
}

/// S/MIME settings of one sending address.
final class IdentitySmime {
  const IdentitySmime({this.certificateFingerprint, this.preferSmime = false});

  static const defaults = IdentitySmime();

  /// The certificate for this address; null picks the newest valid one with the address.
  final String? certificateFingerprint;

  /// Use S/MIME rather than OpenPGP when both could protect a message
  /// (Thunderbird's "Prefer S/MIME").
  final bool preferSmime;

  IdentitySmime copyWith({String? certificateFingerprint, bool clearCertificate = false, bool? preferSmime}) =>
      IdentitySmime(
        certificateFingerprint: clearCertificate ? null : certificateFingerprint ?? this.certificateFingerprint,
        preferSmime: preferSmime ?? this.preferSmime,
      );

  Map<String, Object?> toJson() => {'cert': ?certificateFingerprint, if (preferSmime) 'prefer': true};

  static IdentitySmime fromJson(Map<String, Object?> j) =>
      IdentitySmime(certificateFingerprint: j['cert'] as String?, preferSmime: j['prefer'] == true);
}

/// Everything the store knows, immutable. No private keys.
final class SmimeState {
  const SmimeState({
    this.own = const [],
    this.contacts = const [],
    this.authorities = const [],
    this.identities = const {},
  });

  static const empty = SmimeState();

  /// The user's certificates, newest first.
  final List<SmimeOwnCertificate> own;
  final List<SmimeContactCertificate> contacts;

  /// Certificates the user trusts besides Mozilla's roots: their
  /// company's CA, or a single correspondent's certificate.
  final List<SmimeCertificate> authorities;

  /// Settings by lower-cased address.
  final Map<String, IdentitySmime> identities;

  bool get hasOwnCertificates => own.isNotEmpty;

  IdentitySmime identity(String email) => identities[email.trim().toLowerCase()] ?? IdentitySmime.defaults;

  SmimeOwnCertificate? ownCertificate(String fingerprint) => own.where((o) => o.fingerprint == fingerprint).firstOrNull;

  SmimeContactCertificate? contact(String fingerprint) =>
      contacts.where((c) => c.fingerprint == fingerprint).firstOrNull;

  /// The user's certificate for sending from [email]: the one chosen for
  /// the address, else the newest one with the address that is valid and can sign.
  SmimeOwnCertificate? ownCertificateFor(String email, {DateTime? now}) {
    final chosen = identity(email).certificateFingerprint;
    if (chosen != null) return ownCertificate(chosen);
    final at = now ?? DateTime.now();
    return own
        .where((o) => o.certificate.hasEmail(email) && o.certificate.isValidAt(at) && o.certificate.canSign)
        .firstOrNull;
  }

  /// Correspondents' certificates with [email], newest first.
  List<SmimeContactCertificate> contactsFor(String email) {
    final list = [
      for (final c in contacts)
        if (c.certificate.hasEmail(email)) c,
    ]..sort((a, b) => b.certificate.notBefore.compareTo(a.certificate.notBefore));
    return list;
  }

  bool isTrustedByUser(SmimeCertificate c) => authorities.contains(c);

  /// Mozilla's email roots and the user's.
  SmimeTrustAnchors get anchors => SmimeTrustAnchors.withMozilla(authorities);

  /// Every certificate known (own and correspondents', with their chains):
  /// where chains are built from.
  List<SmimeCertificate> get knownCertificates => [
    for (final o in own) ...[o.certificate, ...o.chain],
    for (final c in contacts) ...[c.certificate, ...c.chain],
  ];

  SmimeState copyWith({
    List<SmimeOwnCertificate>? own,
    List<SmimeContactCertificate>? contacts,
    List<SmimeCertificate>? authorities,
    Map<String, IdentitySmime>? identities,
  }) => SmimeState(
    own: own ?? this.own,
    contacts: contacts ?? this.contacts,
    authorities: authorities ?? this.authorities,
    identities: identities ?? this.identities,
  );

  Map<String, Object?> toJson() => {
    'version': 1,
    'own': [for (final o in own) o.toJson()],
    'contacts': [for (final c in contacts) c.toJson()],
    'authorities': _ders(authorities),
    'identities': {for (final MapEntry(:key, :value) in identities.entries) key: value.toJson()},
  };

  static SmimeState fromJson(Map<String, Object?> j) => SmimeState(
    own: [for (final o in (j['own'] as List?) ?? const []) ?SmimeOwnCertificate.fromJson((o as Map).cast())],
    contacts: [
      for (final c in (j['contacts'] as List?) ?? const []) ?SmimeContactCertificate.fromJson((c as Map).cast()),
    ],
    authorities: _certs(j['authorities']),
    identities: {
      for (final MapEntry(:key, :value) in ((j['identities'] as Map?) ?? const {}).entries)
        key as String: IdentitySmime.fromJson((value as Map).cast()),
    },
  );
}

/// The store: loads and saves [SmimeState] in a [KeyringStorage] (the
/// platform keychain), each private key in an entry of its own, writes
/// one after the other.
final class SmimeStore {
  SmimeStore(this.storage, {this.prefix = 'smime'});

  final KeyringStorage storage;

  /// Prefix of the storage keys: `$prefix.store`, `$prefix.key.<SHA-256>`.
  final String prefix;

  SmimeState _state = SmimeState.empty;
  final _changes = StreamController<SmimeState>.broadcast();
  Future<void> _queue = Future.value();
  bool _loaded = false;

  SmimeState get state => _state;
  bool get isLoaded => _loaded;
  Stream<SmimeState> get changes => _changes.stream;

  String get _stateKey => '$prefix.store';
  String _keyKey(String fingerprint) => '$prefix.key.$fingerprint';

  /// The stored state couldn't be read (the keychain failed, as Android's
  /// Keystore sometimes does): nothing is written until a [load] succeeds,
  /// so a hiccup never replaces what is stored with an empty state (things
  /// are written without the user asking: collected certificates,
  /// Autocrypt keys).
  bool get isUnreadable => _unreadable;
  bool _unreadable = false;

  /// Reads the stored state; a damaged entry starts empty rather than
  /// failing. A keychain that can't be read throws, and blocks writes.
  Future<SmimeState> load() async {
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
        _state = SmimeState.fromJson((jsonDecode(raw) as Map).cast());
      } on Object {
        _state = SmimeState.empty;
      }
    }
    _loaded = true;
    _changes.add(_state);
    return _state;
  }

  Future<T> _write<T>(Future<T> Function() change, {bool evenUnreadable = false}) {
    if (_unreadable && !evenUnreadable) {
      return Future.error(
        const SmimeException(
          SmimeErrorKind.failed,
          'The keychain couldn’t be read, so nothing was changed. Restart Loupe and try again.',
        ),
      );
    }
    final result = _queue.then((_) => change());
    _queue = result.then((_) {}, onError: (Object _) {});
    return result;
  }

  Future<void> _save(SmimeState next) async {
    _state = next;
    await storage.write(_stateKey, jsonEncode(next.toJson()));
    _changes.add(next);
  }

  /// Adds (or replaces) one of the user's certificates with its private key.
  Future<void> addOwn(SmimeKeyPair pair, {List<SmimeCertificate> chain = const [], DateTime? now}) => _write(() async {
    final fingerprint = pair.certificate.fingerprint;
    await storage.write(_keyKey(fingerprint), base64.encode(pair.key.pkcs8));
    final entry = SmimeOwnCertificate(certificate: pair.certificate, chain: chain, added: now ?? DateTime.now());
    final own = [
      entry,
      for (final o in _state.own)
        if (o.fingerprint != fingerprint) o,
    ]..sort((a, b) => b.certificate.notBefore.compareTo(a.certificate.notBefore));
    await _save(
      _state.copyWith(
        own: own,
        contacts: [
          for (final c in _state.contacts)
            if (c.fingerprint != fingerprint) c,
        ],
      ),
    );
  });

  /// The private key of the user's certificate [fingerprint], or null.
  Future<SmimePrivateKey?> privateKey(String fingerprint) async {
    final raw = await storage.read(_keyKey(fingerprint));
    return raw == null ? null : SmimePrivateKey(Uint8List.fromList(base64.decode(raw)));
  }

  /// Every own certificate with its private key (for decrypting and signing).
  Future<List<SmimeKeyPair>> keyPairs() async => [
    for (final o in _state.own)
      if (await privateKey(o.fingerprint) case final key?) SmimeKeyPair(o.certificate, key),
  ];

  /// Forgets one of the user's certificates, its private key and the addresses' choice of it.
  Future<void> removeOwn(String fingerprint) => _write(() async {
    await storage.delete(_keyKey(fingerprint));
    await _save(
      _state.copyWith(
        own: [
          for (final o in _state.own)
            if (o.fingerprint != fingerprint) o,
        ],
        identities: {
          for (final MapEntry(:key, :value) in _state.identities.entries)
            key: value.certificateFingerprint == fingerprint ? value.copyWith(clearCertificate: true) : value,
        },
      ),
    );
  });

  /// Adds or refreshes a correspondent's certificate. A newer signing time
  /// updates the capabilities; an imported one stays imported. Own
  /// certificates are skipped. Returns whether anything changed.
  Future<bool> addContact(
    SmimeCertificate certificate, {
    List<SmimeCertificate> chain = const [],
    SmimeCertificateSource source = SmimeCertificateSource.collected,
    List<String> capabilities = const [],
    DateTime? signed,
    DateTime? now,
  }) => _write(() async {
    final fingerprint = certificate.fingerprint;
    if (_state.ownCertificate(fingerprint) != null) return false;
    final old = _state.contact(fingerprint);
    final SmimeContactCertificate next;
    if (old == null) {
      next = SmimeContactCertificate(
        certificate: certificate,
        chain: chain,
        added: now ?? DateTime.now(),
        source: source,
        capabilities: capabilities,
        lastSigned: signed,
      );
    } else {
      // Refreshed by a newer message, made "imported", or given a longer chain; else unchanged.
      final newer = signed != null && (old.lastSigned == null || signed.isAfter(old.lastSigned!));
      final imported = source == SmimeCertificateSource.imported && old.source != SmimeCertificateSource.imported;
      final longer = chain.length > old.chain.length;
      if (!newer && !imported && !longer) return false;
      next = SmimeContactCertificate(
        certificate: certificate,
        chain: longer ? chain : old.chain,
        added: old.added,
        source: imported ? source : old.source,
        capabilities: newer && capabilities.isNotEmpty ? capabilities : old.capabilities,
        lastSigned: newer ? signed : old.lastSigned,
      );
    }
    await _save(
      _state.copyWith(
        contacts: [
          for (final c in _state.contacts)
            if (c.fingerprint != fingerprint) c,
          next,
        ],
      ),
    );
    return true;
  });

  /// Collects the certificate of a signed message, as Outlook and
  /// Thunderbird do: a valid signature by a certificate of [sender] that
  /// can sign mail and hasn't expired. Returns whether it was new or newer.
  Future<bool> collect(SmimeSignatureStatus signature, {required String sender, DateTime? now}) async {
    final cert = signature.certificate;
    final at = now ?? DateTime.now();
    if (!signature.valid || cert == null || !cert.hasEmail(sender) || !cert.canSign || cert.isExpiredAt(at)) {
      return false;
    }
    return addContact(
      cert,
      chain: [
        for (final c in signature.certificates)
          if (c != cert && c.isCa) c,
      ],
      capabilities: signature.capabilities,
      signed: signature.signingTime,
      now: at,
    );
  }

  Future<void> removeContact(String fingerprint) => _write(() async {
    await _save(
      _state.copyWith(
        contacts: [
          for (final c in _state.contacts)
            if (c.fingerprint != fingerprint) c,
        ],
      ),
    );
  });

  /// Trusts [certificate] as a root: a company CA, or one person's certificate.
  Future<void> trust(SmimeCertificate certificate) => _write(() async {
    if (_state.authorities.contains(certificate)) return;
    await _save(_state.copyWith(authorities: [..._state.authorities, certificate]));
  });

  Future<void> untrust(String fingerprint) => _write(() async {
    await _save(
      _state.copyWith(
        authorities: [
          for (final a in _state.authorities)
            if (a.fingerprint != fingerprint) a,
        ],
      ),
    );
  });

  Future<void> setIdentity(String email, IdentitySmime settings) => _write(() async {
    await _save(_state.copyWith(identities: {..._state.identities, email.trim().toLowerCase(): settings}));
  });

  /// Forgets everything (Settings › Reset).
  Future<void> clear() => _write(() async {
    for (final o in _state.own) {
      await storage.delete(_keyKey(o.fingerprint));
    }
    await storage.delete(_stateKey);
    _state = SmimeState.empty;
    _changes.add(_state);
  }, evenUnreadable: true);

  Future<void> dispose() => _changes.close();
}
