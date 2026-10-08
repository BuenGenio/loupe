import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';
import 'package:share_plus/share_plus.dart';

import '../../l10n/l10n.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart';
import 'openpgp_providers.dart';

/// Reads key text from the clipboard; tests replace it.
final pasteKeyProvider = Provider<Future<Uint8List?> Function()>(
  (ref) => () async {
    final text = (await Clipboard.getData(Clipboard.kTextPlain))?.text;
    return text == null || text.trim().isEmpty ? null : Uint8List.fromList(utf8.encode(text));
  },
);

/// Lets the user pick a key file (`.asc`, `.gpg`, `.pgp`, `.key`); tests replace it.
final pickKeyFileProvider = Provider<Future<Uint8List?> Function()>(
  (ref) => () async {
    final files = await FilePicker.pickFiles();
    if (files.isEmpty) return null;
    return files.first.readAsBytes();
  },
);

/// Imports every key in [data]: the user's own secret keys (asking for
/// each passphrase) and correspondents' public keys (asking whether to
/// accept them, as Thunderbird does). Tells the outcome in a snack bar.
Future<void> importKeys(
  BuildContext context,
  WidgetRef ref,
  Uint8List data, {
  KeySource source = KeySource.imported,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  final l10n = context.l10n;
  final service = await ref.read(openPgpServiceProvider.future);
  final List<PgpKey> keys;
  try {
    keys = await service.parseKeys(data);
  } on PgpException catch (e) {
    showSnack(messenger, e.kind == PgpErrorKind.malformed ? l10n.openpgpNoKeyFound : e.message);
    return;
  }
  final secrets = [
    for (final k in keys)
      if (k.hasSecret) k,
  ];
  final publics = [
    for (final k in keys)
      if (!k.hasSecret && service.state.ownKey(k.fingerprint) == null) k,
  ];
  final added = <String>[];
  // A secret key that arrived in a message: only with explicit consent (a
  // stranger's key would otherwise become "your" key for its address).
  if (secrets.isNotEmpty && source == KeySource.attachment && context.mounted) {
    final ok = await showActionSheet<bool>(
      context,
      title: l10n.openpgpImportSecretKeyTitle,
      message: l10n.openpgpImportSecretKeyMessage(secrets.map((k) => k.displayName).join(', ')),
      actions: [SheetAction(l10n.openpgpImportAsMyKey, true, destructive: true)],
    );
    if (ok != true) secrets.clear();
  }
  for (final k in secrets) {
    final imported = await service.importSecretKey(k);
    if (imported != null) added.add(l10n.openpgpImportedOwnKey(imported.displayName));
  }
  if (publics.isNotEmpty && context.mounted) {
    final names = publics.map((k) => k.displayName).join(', ');
    final fingerprints = publics.map((k) => k.formattedFingerprint).join('\n');
    final acceptance = await showActionSheet<KeyAcceptance>(
      context,
      title: l10n.openpgpImportPublicKeysTitle(publics.length, names),
      message: fingerprints,
      actions: [
        SheetAction(l10n.openpgpImportAndAccept, KeyAcceptance.unverified, isDefault: true),
        SheetAction(l10n.openpgpImportDecideLater, KeyAcceptance.undecided),
      ],
    );
    if (acceptance != null) {
      await service.importPublicKeys(publics, acceptance: acceptance, source: source);
      added.addAll(publics.map((k) => l10n.openpgpImportedPublicKey(k.displayName)));
    }
  }
  if (added.isNotEmpty) showSnack(messenger, l10n.openpgpImported(added.join(', ')));
}

/// Under a message's attachments: "OpenPGP key attached · Import" for
/// `application/pgp-keys` attachments (Thunderbird's "Attach my public key").
class PgpKeyAttachments extends ConsumerWidget {
  const PgpKeyAttachments({super.key, required this.content, required this.load});

  final EmailContent content;
  final Future<Uint8List> Function(Attachment attachment) load;

  /// `application/pgp-keys`, or an `.asc`/`.key`/`.pgp`/`.gpg` file that
  /// isn't a signature or an encrypted message (a key mailed to oneself
  /// from Thunderbird's export).
  static bool isKey(Attachment a) {
    final type = a.mimeType.toLowerCase();
    if (type == 'application/pgp-keys') return true;
    if (type == 'application/pgp-signature' || type == 'application/pgp-encrypted') return false;
    final name = (a.filename ?? '').toLowerCase();
    if (name.contains('signature') || name == 'encrypted.asc') return false;
    return a.size < 256 * 1024 && ['.asc', '.key', '.pgp', '.gpg'].any(name.endsWith);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keys = content.attachments.where(isKey).toList();
    if (keys.isEmpty) return const SizedBox.shrink();
    final colors = LoupeColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(LoupeIcons.pgpKey, size: 16, color: colors.secondaryText),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              context.l10n.openpgpKeysAttached(keys.length),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.secondaryText),
            ),
          ),
          TextButton(
            key: const ValueKey('import-attached-key'),
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              final parts = <int>[];
              try {
                for (final a in keys) {
                  parts
                    ..addAll(await load(a))
                    ..add(0x0a);
                }
              } on MailException catch (e) {
                showSnack(messenger, e.message);
                return;
              }
              if (context.mounted) {
                await importKeys(context, ref, Uint8List.fromList(parts), source: KeySource.attachment);
              }
            },
            child: Text(context.l10n.openpgpImport),
          ),
        ],
      ),
    );
  }
}

/// Hands an armored key to the share sheet as a file ([name]); tests replace it.
final keyExportProvider = Provider<Future<void> Function(String name, String armored)>(
  (ref) => (name, armored) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile.fromData(Uint8List.fromList(utf8.encode(armored)), name: name, mimeType: 'application/pgp-keys')],
        fileNameOverrides: [name],
      ),
    );
  },
);

void copyToClipboard(String text) => Clipboard.setData(ClipboardData(text: text));
