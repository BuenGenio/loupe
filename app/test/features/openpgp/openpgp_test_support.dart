import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:loupe/features/openpgp/openpgp_providers.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_imap/mail_imap.dart' show MimeMessageComposer;
import 'package:mail_model/mail_model.dart';

const pgp = DartPgBackend();

/// OpenPGP work runs inline in widget tests (no isolates under fake time).
final inlinePgp = pgpRunnerProvider.overrideWithValue(<T>(T Function() work) async => work());

/// A test key for [userId]; [passphrase] protects it when not empty.
PgpKey testKey(String userId, {String passphrase = ''}) => pgp.generate(userId: userId, passphrase: passphrase);

/// A memory keyring as the live keyring would find it in the keychain.
Future<MemoryKeyringStorage> keychainWith({
  List<PgpKey> own = const [],
  List<(PgpKey, KeyAcceptance)> others = const [],
}) async {
  final storage = MemoryKeyringStorage();
  final keyring = Keyring(storage, prefix: 'loupe.openpgp');
  await keyring.load();
  for (final k in own) {
    await keyring.addOwnKey(secret: k, public: pgp.publicKey(k));
  }
  for (final (k, a) in others) {
    await keyring.addPublicKeys([pgp.publicKey(k)], acceptance: a);
  }
  return storage;
}

Override keychain(MemoryKeyringStorage storage) => keyringStorageProvider.overrideWithValue(storage);

final class _Keys implements PgpSendKeys {
  _Keys(this.state, this.signer);
  @override
  final KeyringState state;
  final PgpKey? signer;
  @override
  PgpKey? unlockedKey(String fingerprint) => signer?.fingerprint == fingerprint ? signer : null;
}

/// A message from [from] (whose unprotected secret key is [fromKey]) to
/// [to] (public key [toKey]), as RFC 822 text.
String pgpMessage({
  required EmailAddress from,
  required PgpKey fromKey,
  required EmailAddress to,
  required PgpKey toKey,
  required String subject,
  required String text,
  OutgoingSecurity security = const OutgoingSecurity(encrypt: true, sign: true),
}) {
  final state = KeyringState(
    ownKeys: [pgp.publicKey(fromKey)],
    publicKeys: [PublicKeyEntry(key: pgp.publicKey(toKey), acceptance: KeyAcceptance.verified, added: DateTime(2026))],
  );
  final composer = PgpMessageComposer(MimeMessageComposer(), _Keys(state, fromKey), backend: pgp);
  final bytes = composer.compose(
    OutgoingMessage(accountId: 'acc', identityId: 'x', to: [to], subject: subject, text: text, security: security),
    Identity(id: 'x', email: from.email, name: from.name),
    messageId: 'pgp-test@example.com',
    date: DateTime.utc(2026, 10, 4, 9),
  );
  return latin1.decode(bytes);
}

/// The content an IMAP server would give for [raw]: its headers, no body.
EmailContent outerContent(String emailId, String raw) =>
    EmailContent(emailId: emailId, headers: MimeEntity.parse(Uint8List.fromList(latin1.encode(raw))).headers);
