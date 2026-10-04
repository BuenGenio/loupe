/// Secret keys unlocked with their passphrase during this session.
library;

import '../pgp/types.dart';

/// Unlocked secret keys by fingerprint. With [remember] they stay until
/// [lockAll] (or the app quits); without, each lasts [grace] after its
/// last use (enough to finish sending a message).
final class KeySession {
  KeySession({this.remember = true, this.grace = const Duration(minutes: 2), DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  bool remember;
  final Duration grace;
  final DateTime Function() _clock;
  final _keys = <String, (PgpKey, DateTime)>{};

  /// The unlocked key of [fingerprint], or null (locked or expired).
  PgpKey? operator [](String fingerprint) {
    final entry = _keys[fingerprint];
    if (entry == null) return null;
    final now = _clock();
    if (!remember && now.difference(entry.$2) > grace) {
      _keys.remove(fingerprint);
      return null;
    }
    _keys[fingerprint] = (entry.$1, now);
    return entry.$1;
  }

  /// Keeps an unlocked (or unprotected) key.
  void put(PgpKey unlocked) {
    assert(unlocked.hasSecret && !unlocked.isProtected);
    _keys[unlocked.fingerprint] = (unlocked, _clock());
  }

  bool isUnlocked(String fingerprint) => this[fingerprint] != null;

  /// Every key still unlocked.
  List<PgpKey> get keys => [for (final f in _keys.keys.toList()) ?this[f]];

  void lock(String fingerprint) => _keys.remove(fingerprint);

  void lockAll() => _keys.clear();
}
