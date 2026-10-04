import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';
import 'package:share_plus/share_plus.dart';

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
  final service = await ref.read(openPgpServiceProvider.future);
  final List<PgpKey> keys;
  try {
    keys = await service.parseKeys(data);
  } on PgpException catch (e) {
    showSnack(messenger, e.kind == PgpErrorKind.malformed ? 'No OpenPGP key found.' : e.message);
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
  for (final k in secrets) {
    final imported = await service.importSecretKey(k);
    if (imported != null) added.add('your key ${imported.displayName}');
  }
  if (publics.isNotEmpty && context.mounted) {
    final names = publics.map((k) => k.displayName).join(', ');
    final fingerprints = publics.map((k) => k.formattedFingerprint).join('\n');
    final acceptance = await showActionSheet<KeyAcceptance>(
      context,
      title: publics.length == 1 ? 'Import $names’s key?' : 'Import ${publics.length} keys ($names)?',
      message: fingerprints,
      actions: const [
        SheetAction('Import and Accept', KeyAcceptance.unverified, isDefault: true),
        SheetAction('Import, Decide Later', KeyAcceptance.undecided),
      ],
    );
    if (acceptance != null) {
      await service.importPublicKeys(publics, acceptance: acceptance, source: source);
      added.addAll(publics.map((k) => '${k.displayName}’s key'));
    }
  }
  if (added.isNotEmpty) showSnack(messenger, 'Imported ${added.join(', ')}.');
}

/// Under a message's attachments: "OpenPGP key attached · Import" for
/// `application/pgp-keys` attachments (Thunderbird's "Attach my public key").
class PgpKeyAttachments extends ConsumerWidget {
  const PgpKeyAttachments({super.key, required this.content, required this.load});

  final EmailContent content;
  final Future<Uint8List> Function(Attachment attachment) load;

  static bool isKey(Attachment a) =>
      a.mimeType.toLowerCase() == 'application/pgp-keys' ||
      ((a.filename ?? '').toLowerCase().endsWith('.asc') && (a.filename ?? '').toLowerCase().contains('openpgp_0x'));

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
              keys.length == 1 ? 'An OpenPGP key is attached.' : '${keys.length} OpenPGP keys are attached.',
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
            child: const Text('Import'),
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
