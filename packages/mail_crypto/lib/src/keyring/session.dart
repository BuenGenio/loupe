/// Secret keys unlocked with their passphrase during this session.
library;

import '../pgp/types.dart';

/// Unlocked secret keys by fingerprint. With [remember] they stay until
/// [lockAll] (or the app quits); without, each lasts [grace] after its
/// last use (enough to finish sending a message). Keys without a
/// passphrase are pinned: there is nothing to forget.
final class KeySession {
  KeySession({this.remember = true, this.grace = const Duration(minutes: 2), DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  bool remember;
  final Duration grace;
  final DateTime Function() _clock;
  final _keys = <String, (PgpKey, DateTime)>{};
  final _pinned = <String>{};

  /// The unlocked key of [fingerprint], or null (locked or expired).
  PgpKey? operator [](String fingerprint) {
    final entry = _keys[fingerprint];
    if (entry == null) return null;
    final now = _clock();
    if (!remember && !_pinned.contains(fingerprint) && now.difference(entry.$2) > grace) {
      _keys.remove(fingerprint);
      return null;
    }
    _keys[fingerprint] = (entry.$1, now);
    return entry.$1;
  }

  /// Keeps an unlocked key; [pin] keeps it whatever [remember] says (a
  /// key stored without a passphrase).
  void put(PgpKey unlocked, {bool pin = false}) {
    assert(unlocked.hasSecret && !unlocked.isProtected);
    _keys[unlocked.fingerprint] = (unlocked, _clock());
    if (pin) _pinned.add(unlocked.fingerprint);
  }

  bool isUnlocked(String fingerprint) => this[fingerprint] != null;

  /// Every key still unlocked.
  List<PgpKey> get keys => [for (final f in _keys.keys.toList()) ?this[f]];

  void lock(String fingerprint) {
    if (!_pinned.contains(fingerprint)) _keys.remove(fingerprint);
  }

  /// Forgets every unlocked key except the pinned ones.
  void lockAll() => _keys.removeWhere((f, _) => !_pinned.contains(f));

  /// Forgets everything, pinned keys too (the key was deleted, the mode changed).
  void clear() {
    _keys.clear();
    _pinned.clear();
  }

  /// Whether [fingerprint] is unlocked for good (stored without a passphrase).
  bool isPinned(String fingerprint) => _pinned.contains(fingerprint);
}
