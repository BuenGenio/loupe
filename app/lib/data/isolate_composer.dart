import 'dart:isolate';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_imap/mail_imap.dart';
import 'package:mail_model/mail_model.dart';

import '../features/smime/smime_keys.dart';
import '../l10n/l10n.dart';

/// Runs composing work somewhere: another isolate in the app, inline in tests.
typedef ComposeRunner = Future<T> Function<T>(T Function() work);

Future<T> _isolate<T>(T Function() work) => Isolate.run(work);

/// The live composer: S/MIME around OpenPGP around MIME, writing signed and
/// encrypted mail and Autocrypt headers with [keys].
///
/// [composeAsync] composes in another isolate: signing and encrypting a
/// message with attachments takes seconds in pure Dart (about 0.4 s a
/// megabyte), which would freeze the UI when Send is tapped. It hands over
/// a snapshot of the keys ([SnapshotSendKeys]), as the session's own can't
/// cross isolates. A certificate whose key stays on the device (Android
/// KeyChain) signs in between, here, through [device]: composing stops at
/// the signature, the device signs, and composing goes on.
final class IsolateComposer implements AsyncMessageComposer {
  IsolateComposer(this.keys, {this.device, ComposeRunner? run}) : _run = run ?? _isolate;

  final SecureSendKeys keys;

  /// Keys on the device; null where the platform can't be reached (background isolates).
  final SmimePlatformKeys? device;
  final ComposeRunner _run;

  /// The composers with these keys, made where they run.
  static SmimeMessageComposer chain(PgpSendKeys pgp, SmimeSendKeys smime) => SmimeMessageComposer(
    PgpMessageComposer(MimeMessageComposer(), pgp, backend: const DartPgBackend()),
    smime,
    backend: const DartSmimeBackend(),
  );

  @override
  Uint8List compose(OutgoingMessage message, Identity from, {required String messageId, DateTime? date}) =>
      chain(keys, keys).compose(message, from, messageId: messageId, date: date);

  @override
  Future<Uint8List> composeAsync(
    OutgoingMessage message,
    Identity from, {
    required String messageId,
    DateTime? date,
  }) async {
    final snapshot = SnapshotSendKeys.of(keys, keys);
    final step = await _run(() => chain(snapshot, snapshot).begin(message, from, messageId: messageId, date: date));
    switch (step) {
      case SmimeComposed(:final bytes):
        return bytes;
      case SmimeSignaturePending(:final request):
        final device = this.device;
        // Sending can run in the background, without the app's screens:
        // the device's language.
        if (device == null) throw MailException(MailErrorKind.unsupported, deviceL10n().dataSmimeNeedsDevice);
        final Uint8List signature;
        try {
          signature = await device.perform(request);
        } on SmimeException catch (e) {
          throw MailException(MailErrorKind.unsupported, deviceL10n().dataSigningFailed(e.message), e);
        }
        return _run(() => chain(snapshot, snapshot).finish(step, signature));
    }
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
      unlocked: {for (final k in state.ownKeys) k.fingerprint: ?pgp.unlockedKey(k.fingerprint)},
      smimeKeys: {for (final o in smimeState.own) o.fingerprint: ?smime.smimeKey(o.fingerprint)},
    );
  }

  @override
  final KeyringState state;

  @override
  final SmimeState smimeState;

  /// Unlocked secret keys by fingerprint.
  final Map<String, PgpKey> unlocked;

  /// Private keys of the user's certificates (or handles of keys on the device).
  final Map<String, SmimeKeyHandle> smimeKeys;

  @override
  PgpKey? unlockedKey(String fingerprint) => unlocked[fingerprint];

  @override
  SmimeKeyHandle? smimeKey(String fingerprint) => smimeKeys[fingerprint];
}
