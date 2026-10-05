/// What Loupe keeps of encrypted mail on the device once decrypted, and the
/// settings for it (Settings › End-to-End Encryption › On This Device).
/// Background isolates use this too.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart';

/// Settings › End-to-End Encryption › On This Device. Persisted in
/// SharedPreferences under `e2ee.*`, where background isolates read them
/// ([DecryptedMailSettings.read]).
///
/// Protected subjects of messages the user opened are always kept (in the
/// encrypted database); these settings add more.
@immutable
final class DecryptedMailSettings {
  const DecryptedMailSettings({this.subjectsInBackground = false});

  /// Decrypt the protected subjects of new encrypted mail during sync, with
  /// keys stored without a passphrase, so the list and notifications show
  /// them before the message is opened. Off by default.
  final bool subjectsInBackground;

  static const _prefix = 'e2ee.';

  static DecryptedMailSettings read(SharedPreferences p) =>
      DecryptedMailSettings(subjectsInBackground: p.getBool('${_prefix}subjectsInBackground') ?? false);

  Future<void> write(SharedPreferences p) => p.setBool('${_prefix}subjectsInBackground', subjectsInBackground);

  DecryptedMailSettings copyWith({bool? subjectsInBackground}) =>
      DecryptedMailSettings(subjectsInBackground: subjectsInBackground ?? this.subjectsInBackground);

  @override
  bool operator ==(Object other) =>
      other is DecryptedMailSettings && other.subjectsInBackground == subjectsInBackground;

  @override
  int get hashCode => subjectsInBackground.hashCode;
}

final decryptedMailSettingsProvider = NotifierProvider<DecryptedMailSettingsController, DecryptedMailSettings>(
  DecryptedMailSettingsController.new,
);

class DecryptedMailSettingsController extends Notifier<DecryptedMailSettings> {
  @override
  DecryptedMailSettings build() {
    ref.watch(prefsEpochProvider);
    return DecryptedMailSettings.read(ref.watch(sharedPreferencesProvider));
  }

  Future<void> update(DecryptedMailSettings Function(DecryptedMailSettings current) change) async {
    final next = change(state);
    state = next;
    await next.write(ref.read(sharedPreferencesProvider));
  }
}

/// The user's secret keys stored without a passphrase, from [keyring]
/// (loaded here when it isn't): what background work may use without
/// asking anyone.
Future<List<PgpKey>> keysWithoutPassphrase(Keyring keyring, PgpBackend backend) async {
  final keys = <PgpKey>[];
  try {
    await keyring.load();
    for (final k in keyring.state.ownKeys) {
      if (k.isProtected) continue;
      final secret = await keyring.secretKey(k.fingerprint, backend);
      if (secret != null && !secret.isProtected) keys.add(secret);
    }
  } on Object {
    // A keychain that can't be read: nothing is decrypted or signed here.
  }
  return keys;
}

/// Runs decryption: in another isolate in the app, inline in background
/// isolates.
typedef DecryptRunner = Future<String?> Function(String? Function() work);

Future<String?> _inline(String? Function() work) async => work();

/// Decrypts the protected subjects of encrypted mail nobody opened yet
/// (Decrypt Subjects in the Background), and remembers them on the device
/// ([DecryptedMail]): only with [keys] (stored without a passphrase; it never
/// asks for one), only OpenPGP (S/MIME doesn't hide subjects), and only
/// messages up to [maxBytes], as the whole message has to be downloaded.
final class SubjectDecryptor {
  SubjectDecryptor({
    required this.keys,
    this.backend = const DartPgBackend(),
    DecryptRunner? run,
    this.maxBytes = defaultMaxBytes,
    DateTime Function()? clock,
  }) : _run = run ?? _inline,
       _clock = clock ?? DateTime.now;

  /// Larger messages (attachments) wait until they are opened.
  static const defaultMaxBytes = 1024 * 1024;

  final List<PgpKey> keys;
  final PgpBackend backend;
  final int maxBytes;
  final DecryptRunner _run;
  final DateTime Function() _clock;

  /// Whether [e] is one to decrypt: encrypted, its subject still a
  /// placeholder, and small enough.
  bool wants(EmailSummary e) =>
      e.isEncrypted && !e.hasDecryptedSubject && isProtectedSubjectPlaceholder(e.subject) && e.size <= maxBytes;

  /// Decrypts the subjects of those of [emails] it [wants] and remembers
  /// them in [repository]; returns them by email id. Stops starting new
  /// ones after [budget]. A message that can't be fetched or decrypted (not
  /// for these keys, damaged, offline) is left as it is.
  Future<Map<String, String>> decrypt(
    MailRepository repository,
    Iterable<EmailSummary> emails, {
    Duration? budget,
  }) async {
    final found = <String, String>{};
    if (keys.isEmpty || repository is! DecryptedMail) return found;
    final deadline = budget == null ? null : _clock().add(budget);
    for (final e in emails) {
      if (!wants(e)) continue;
      if (deadline != null && _clock().isAfter(deadline)) break;
      try {
        final raw = await repository.loadRawSource(e.id);
        final (backend, keys) = (this.backend, this.keys);
        final subject = (await _run(() => protectedSubjectOf(raw, backend: backend, keys: keys)))?.trim();
        if (subject == null || subject.isEmpty || subject == e.subject.trim()) continue;
        await (repository as DecryptedMail).rememberProtectedSubject(e.id, subject);
        found[e.id] = subject;
      } on Object {
        continue;
      }
    }
    return found;
  }
}

/// The protected subject of the PGP/MIME message [raw], decrypted with
/// those of [keys] it is encrypted to; null when it isn't for them, can't
/// be decrypted, or has none.
String? protectedSubjectOf(Uint8List raw, {required PgpBackend backend, required List<PgpKey> keys}) {
  final reader = PgpMimeReader(backend);
  final ids = reader.recipientsOf(raw);
  if (ids.isEmpty) return null;
  // A hidden recipient (gpg --throw-keyids) could be any key.
  final hidden = ids.contains('0000000000000000');
  final mine = [
    for (final k in keys)
      if (hidden || k.keyIds.any(ids.contains)) k,
  ];
  if (mine.isEmpty) return null;
  final status = reader.read(raw, keys: mine).status;
  return status.decrypted ? status.protectedSubject : null;
}
