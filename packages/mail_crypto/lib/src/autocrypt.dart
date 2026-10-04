/// Autocrypt Level 1: the `Autocrypt` header, peer state and the
/// encryption recommendation (https://autocrypt.org/level1.html).
library;

import 'dart:convert';
import 'dart:typed_data';

/// One `Autocrypt:` (or `Autocrypt-Gossip:`) header.
final class AutocryptHeader {
  const AutocryptHeader({required this.addr, required this.keydata, this.preferMutual = false});

  /// The address, lower-cased.
  final String addr;

  /// The binary OpenPGP key (base64-decoded `keydata`).
  final Uint8List keydata;

  /// `prefer-encrypt=mutual`.
  final bool preferMutual;

  /// Parses a header value; null when it is invalid (missing `addr` or
  /// `keydata`, bad base64, or an unknown critical attribute).
  static AutocryptHeader? parse(String value) {
    String? addr;
    String? keydata;
    var mutual = false;
    for (final raw in value.split(';')) {
      final attr = raw.trim();
      if (attr.isEmpty) continue;
      final eq = attr.indexOf('=');
      if (eq <= 0) return null;
      final name = attr.substring(0, eq).trim().toLowerCase();
      final v = attr.substring(eq + 1).trim();
      switch (name) {
        case 'addr':
          addr = v.toLowerCase();
        case 'keydata':
          keydata = v.replaceAll(RegExp(r'\s'), '');
        case 'prefer-encrypt':
          mutual = v.toLowerCase() == 'mutual';
        case 'type':
          if (v != '1') return null;
        default:
          // Unknown attributes are fine only when non-critical ("_name").
          if (!name.startsWith('_')) return null;
      }
    }
    if (addr == null || keydata == null || !addr.contains('@')) return null;
    try {
      final data = base64.decode(keydata);
      if (data.isEmpty) return null;
      return AutocryptHeader(addr: addr, keydata: data, preferMutual: mutual);
    } on FormatException {
      return null;
    }
  }

  /// The header value, folded for a header line: `addr=…; [prefer-encrypt=mutual;] keydata=…`.
  String toValue() {
    final b64 = base64.encode(keydata);
    final out = StringBuffer('addr=$addr;${preferMutual ? ' prefer-encrypt=mutual;' : ''} keydata=');
    for (var i = 0; i < b64.length; i += 76) {
      out
        ..write('\r\n ')
        ..write(b64.substring(i, i + 76 > b64.length ? b64.length : i + 76));
    }
    return out.toString();
  }
}

/// The one valid `Autocrypt` header of a message from [from], or null
/// (Level 1 §2.3: none, several, or one for another address all count as none).
AutocryptHeader? autocryptHeaderFrom(List<(String, String)> headers, String from) {
  final found = [
    for (final (k, v) in headers)
      if (k.toLowerCase() == 'autocrypt') AutocryptHeader.parse(v),
  ];
  if (found.length != 1) return null;
  final h = found.single;
  return h != null && h.addr == from.trim().toLowerCase() ? h : null;
}

/// What Autocrypt knows about one correspondent. The keys themselves live
/// in the keyring (as undecided keys from Autocrypt); the peer refers to
/// them by fingerprint.
final class AutocryptPeer {
  const AutocryptPeer({
    required this.addr,
    required this.lastSeen,
    this.timestamp,
    this.fingerprint,
    this.preferMutual = false,
    this.gossipTimestamp,
    this.gossipFingerprint,
  });

  final String addr;

  /// Date of the newest message seen from the peer.
  final DateTime lastSeen;

  /// Date of the newest message with an Autocrypt header.
  final DateTime? timestamp;

  /// The key from the peer's own Autocrypt header.
  final String? fingerprint;
  final bool preferMutual;
  final DateTime? gossipTimestamp;

  /// A key someone else gossiped for the peer.
  final String? gossipFingerprint;

  /// The key to encrypt to: the peer's own, else a gossiped one.
  String? get bestFingerprint => fingerprint ?? gossipFingerprint;

  /// Level 1 §2.4: the key from the peer's own header is "stale" when its
  /// last Autocrypt header is more than 35 days older than its last mail.
  bool get isStale => timestamp == null || lastSeen.difference(timestamp!) > const Duration(days: 35);

  AutocryptPeer copyWith({
    DateTime? lastSeen,
    DateTime? timestamp,
    String? fingerprint,
    bool? preferMutual,
    DateTime? gossipTimestamp,
    String? gossipFingerprint,
  }) => AutocryptPeer(
    addr: addr,
    lastSeen: lastSeen ?? this.lastSeen,
    timestamp: timestamp ?? this.timestamp,
    fingerprint: fingerprint ?? this.fingerprint,
    preferMutual: preferMutual ?? this.preferMutual,
    gossipTimestamp: gossipTimestamp ?? this.gossipTimestamp,
    gossipFingerprint: gossipFingerprint ?? this.gossipFingerprint,
  );

  Map<String, Object?> toJson() => {
    'addr': addr,
    'lastSeen': lastSeen.toUtc().toIso8601String(),
    if (timestamp != null) 'timestamp': timestamp!.toUtc().toIso8601String(),
    'key': ?fingerprint,
    if (preferMutual) 'mutual': true,
    if (gossipTimestamp != null) 'gossipTimestamp': gossipTimestamp!.toUtc().toIso8601String(),
    'gossipKey': ?gossipFingerprint,
  };

  static AutocryptPeer fromJson(Map<String, Object?> j) {
    DateTime? date(Object? v) => v is String ? DateTime.tryParse(v) : null;
    return AutocryptPeer(
      addr: j['addr']! as String,
      lastSeen: date(j['lastSeen']) ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      timestamp: date(j['timestamp']),
      fingerprint: j['key'] as String?,
      preferMutual: j['mutual'] == true,
      gossipTimestamp: date(j['gossipTimestamp']),
      gossipFingerprint: j['gossipKey'] as String?,
    );
  }
}

/// Level 1 §2.3: [peer] after a message from [addr] dated [date] (the
/// caller clamps it to "now") with an Autocrypt header for the key
/// [fingerprint] (null when it had no valid header). A message older than
/// the last one seen changes nothing.
AutocryptPeer updatePeer(
  AutocryptPeer? peer,
  String addr,
  DateTime date, {
  String? fingerprint,
  bool preferMutual = false,
}) {
  final current = peer ?? AutocryptPeer(addr: addr.toLowerCase(), lastSeen: DateTime.fromMillisecondsSinceEpoch(0));
  if (peer != null && date.isBefore(peer.lastSeen)) return peer;
  var next = current.copyWith(lastSeen: date);
  if (fingerprint != null && (current.timestamp == null || date.isAfter(current.timestamp!))) {
    next = AutocryptPeer(
      addr: next.addr,
      lastSeen: date,
      timestamp: date,
      fingerprint: fingerprint,
      preferMutual: preferMutual,
      gossipTimestamp: next.gossipTimestamp,
      gossipFingerprint: next.gossipFingerprint,
    );
  }
  return next;
}

/// Level 1 §2.3: [peer] after an `Autocrypt-Gossip` header for the key
/// [fingerprint] in a message dated [date].
AutocryptPeer updateGossip(AutocryptPeer? peer, String addr, DateTime date, String fingerprint) {
  final current = peer ?? AutocryptPeer(addr: addr.toLowerCase(), lastSeen: DateTime.fromMillisecondsSinceEpoch(0));
  if (current.gossipTimestamp != null && !date.isAfter(current.gossipTimestamp!)) return current;
  return current.copyWith(gossipTimestamp: date, gossipFingerprint: fingerprint);
}

/// Level 1 §2.4 recommendation for one recipient or a whole message.
enum AutocryptRecommendation {
  /// No key: encryption isn't possible.
  disable,

  /// Possible, but the key may be outdated (or only gossiped).
  discourage,

  /// Possible.
  available,

  /// Both sides asked for it (prefer-encrypt=mutual), or it's a reply to
  /// an encrypted message.
  encrypt,
}

/// The recommendation for one recipient.
AutocryptRecommendation recommendFor(AutocryptPeer? peer, {required bool ownMutual, bool replyToEncrypted = false}) {
  if (peer == null || peer.bestFingerprint == null) return AutocryptRecommendation.disable;
  final AutocryptRecommendation preliminary;
  if (peer.fingerprint == null || peer.isStale) {
    preliminary = AutocryptRecommendation.discourage;
  } else {
    preliminary = AutocryptRecommendation.available;
  }
  if (preliminary == AutocryptRecommendation.available && ownMutual && peer.preferMutual) {
    return AutocryptRecommendation.encrypt;
  }
  if (replyToEncrypted) return AutocryptRecommendation.encrypt;
  return preliminary;
}

/// Combines per-recipient recommendations: any disable disables, all
/// encrypt encrypts, any discourage discourages.
AutocryptRecommendation combineRecommendations(Iterable<AutocryptRecommendation> each) {
  final list = each.toList();
  if (list.isEmpty || list.contains(AutocryptRecommendation.disable)) return AutocryptRecommendation.disable;
  if (list.every((r) => r == AutocryptRecommendation.encrypt)) return AutocryptRecommendation.encrypt;
  if (list.contains(AutocryptRecommendation.discourage)) return AutocryptRecommendation.discourage;
  return AutocryptRecommendation.available;
}
