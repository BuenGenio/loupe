import 'dart:isolate';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_imap/mail_imap.dart';
import 'package:mail_model/mail_model.dart';

import '../features/smime/smime_keys.dart';

/// Runs composing work somewhere: another isolate in the app, inline in tests.
typedef ComposeRunner = Future<Uint8List> Function(Uint8List Function() work);

Future<Uint8List> _isolate(Uint8List Function() work) => Isolate.run(work);

/// The live composer: S/MIME around OpenPGP around MIME, writing signed and
/// encrypted mail and Autocrypt headers with [keys].
///
/// [composeAsync] composes in another isolate: signing and encrypting a
/// message with attachments takes seconds in pure Dart (about 0.4 s a
/// megabyte), which would freeze the UI when Send is tapped. It hands over
/// a snapshot of the keys ([SnapshotSendKeys]), as the session's own can't
/// cross isolates.
final class IsolateComposer implements AsyncMessageComposer {
  IsolateComposer(this.keys, {ComposeRunner? run}) : _run = run ?? _isolate;

  final SecureSendKeys keys;
  final ComposeRunner _run;

  /// The composers with these keys, made where they run.
  static MessageComposer chain(PgpSendKeys pgp, SmimeSendKeys smime) => SmimeMessageComposer(
    PgpMessageComposer(MimeMessageComposer(), pgp, backend: const DartPgBackend()),
    smime,
    backend: const DartSmimeBackend(),
  );

  @override
  Uint8List compose(OutgoingMessage message, Identity from, {required String messageId, DateTime? date}) =>
      chain(keys, keys).compose(message, from, messageId: messageId, date: date);

  @override
  Future<Uint8List> composeAsync(OutgoingMessage message, Identity from, {required String messageId, DateTime? date}) {
    final snapshot = SnapshotSendKeys.of(keys, keys);
    return _run(() => chain(snapshot, snapshot).compose(message, from, messageId: messageId, date: date));
  }
}

/// The keys of a moment, as plain values that can go to another isolate:
/// the keyring and certificate store, and the user's unlocked OpenPGP keys
/// and S/MIME private keys.
final class SnapshotSendKeys implements PgpSendKeys, SmimeSendKeys {
  SnapshotSendKeys({
    required this.state,
    required this.smimeState,
    this.unlocked = const {},
    this.smimeKeys = const {},
  });

  factory SnapshotSendKeys.of(PgpSendKeys pgp, SmimeSendKeys smime) {
    final state = pgp.state;
    final smimeState = smime.smimeState;
    return SnapshotSendKeys(
      state: state,
      smimeState: smimeState,
      unlocked: {
        for (final k in state.ownKeys)
          if (pgp.unlockedKey(k.fingerprint) case final key?) k.fingerprint: key,
      },
      smimeKeys: {
        for (final o in smimeState.own)
          if (smime.smimeKey(o.fingerprint) case final key?) o.fingerprint: key,
      },
    );
  }

  @override
  final KeyringState state;

  @override
  final SmimeState smimeState;

  /// Unlocked secret keys by fingerprint.
  final Map<String, PgpKey> unlocked;
  final Map<String, SmimePrivateKey> smimeKeys;

  @override
  PgpKey? unlockedKey(String fingerprint) => unlocked[fingerprint];

  @override
  SmimePrivateKey? smimeKey(String fingerprint) => smimeKeys[fingerprint];
}
