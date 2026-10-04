import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';
import 'package:share_plus/share_plus.dart';

import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart';
import 'smime_providers.dart';
import 'smime_service.dart';

/// File names of S/MIME certificates: PKCS #12 (with the private key) and
/// certificates alone (DER, PEM, PKCS #7 bundles).
const _pkcs12Extensions = ['.p12', '.pfx'];
const _certificateExtensions = ['.cer', '.crt', '.der', '.pem', '.p7c', '.p7b'];
const _certificateTypes = {
  'application/x-pkcs12',
  'application/pkcs12',
  'application/x-x509-ca-cert',
  'application/x-x509-user-cert',
  'application/x-x509-email-cert',
  'application/pkix-cert',
  'application/x-pem-file',
  'application/pkcs7-certificates',
  'application/x-pkcs7-certificates',
};

/// Whether [a] is a certificate file Loupe can import (not a message's own signature).
bool isCertificateAttachment(Attachment a) {
  final name = (a.filename ?? '').toLowerCase();
  if (name == 'smime.p7s' || name == 'smime.p7m') return false;
  return _certificateTypes.contains(a.mimeType.toLowerCase()) ||
      [..._pkcs12Extensions, ..._certificateExtensions].any(name.endsWith);
}

/// Asks for the password of a PKCS #12 file; null on Cancel. [error]
/// tells why it is asked again.
Future<String?> showSmimePasswordDialog(BuildContext context, {String? error}) => showCupertinoDialog<String>(
  context: context,
  builder: (context) => SmimePasswordDialog(error: error),
);

/// "Certificate Password": the password the .p12 or .pfx file was exported with.
class SmimePasswordDialog extends StatefulWidget {
  const SmimePasswordDialog({super.key, this.error});

  final String? error;

  @override
  State<SmimePasswordDialog> createState() => _SmimePasswordDialogState();
}

class _SmimePasswordDialogState extends State<SmimePasswordDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final error = widget.error;
    return CupertinoAlertDialog(
      key: const ValueKey('smime-password-dialog'),
      title: const Text('Certificate Password'),
      content: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter the password the certificate file was exported with.'),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(error, style: TextStyle(color: LoupeColors.of(context).destructive)),
              ),
            const SizedBox(height: 12),
            CupertinoTextField(
              key: const ValueKey('smime-password-field'),
              controller: _controller,
              autofocus: true,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              placeholder: 'Password',
              onSubmitted: (_) => Navigator.of(context).pop(_controller.text),
            ),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        CupertinoDialogAction(
          key: const ValueKey('smime-password-import'),
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: const Text('Import'),
        ),
      ],
    );
  }
}

/// Imports an S/MIME file: a PKCS #12 file becomes the user's certificate
/// (after its password), certificates become correspondents'. A CA that
/// Loupe doesn't trust (a company's) is offered for trust. [fromMessage]:
/// the file arrived in a message, so a private key is imported only after
/// a warning. Tells the outcome in a snack bar.
Future<void> importSmimeFile(BuildContext context, WidgetRef ref, Uint8List data, {bool fromMessage = false}) async {
  final messenger = ScaffoldMessenger.of(context);
  try {
    await _import(context, ref, data, fromMessage: fromMessage);
  } on SmimeException catch (e) {
    // The keychain refused the change (it couldn't be read): say so.
    showSnack(messenger, e.message);
  }
}

Future<void> _import(BuildContext context, WidgetRef ref, Uint8List data, {required bool fromMessage}) async {
  final messenger = ScaffoldMessenger.of(context);
  final service = await ref.read(smimeServiceProvider.future);
  if (SmimeService.isPkcs12(data)) {
    if (context.mounted) await _importPkcs12(context, service, data, fromMessage: fromMessage);
    return;
  }
  final List<SmimeCertificate> certificates;
  try {
    certificates = await service.parseCertificates(data);
  } on SmimeException {
    showSnack(messenger, 'No certificate found.');
    return;
  }
  final authorities = [
    for (final c in certificates)
      if (c.isCa) c,
  ];
  final people = [
    for (final c in certificates)
      if (!c.isCa && service.state.ownCertificate(c.fingerprint) == null) c,
  ];
  if (people.isNotEmpty) await service.importCertificates(people, chain: authorities);
  var trusted = 0;
  for (final ca in authorities) {
    if (!context.mounted) break;
    if (ca.isSelfIssued && !service.isTrustedRoot(ca) && await _askTrust(context, service, ca)) trusted++;
  }
  final done = [
    if (people.isNotEmpty) people.map((c) => '${c.displayName}’s certificate').join(', '),
    if (trusted > 0) trusted == 1 ? 'a trusted authority' : '$trusted trusted authorities',
  ];
  showSnack(messenger, done.isEmpty ? 'Nothing new to import.' : 'Imported ${done.join(' and ')}.');
}

Future<void> _importPkcs12(
  BuildContext context,
  SmimeService service,
  Uint8List data, {
  required bool fromMessage,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  String? error;
  SmimeBundle? bundle;
  while (bundle == null) {
    if (!context.mounted) return;
    final password = await showSmimePasswordDialog(context, error: error);
    if (password == null) return;
    try {
      bundle = await service.openPkcs12(data, password);
    } on SmimeException catch (e) {
      if (e.kind != SmimeErrorKind.wrongPassword) {
        showSnack(messenger, e.message);
        return;
      }
      error = 'That password is wrong. Try again.';
    }
  }
  if (bundle.keys.isEmpty) {
    showSnack(messenger, 'This file has no private key. Export your certificate with its private key.');
    return;
  }
  final names = bundle.keys.map((k) => '${k.certificate.displayName} (${k.certificate.emails.join(', ')})').join(', ');
  if (fromMessage && context.mounted) {
    final ok = await showActionSheet<bool>(
      context,
      title: 'Import as Your Certificate?',
      message:
          'This attachment holds a certificate with its private key: $names. Import it only if you exported it '
          'yourself, from Outlook or Thunderbird for example.',
      actions: const [SheetAction('Import as My Certificate', true, destructive: true)],
    );
    if (ok != true) return;
  }
  for (final k in bundle.keys) {
    await service.addOwn(k, chain: bundle.chain);
  }
  // The CA that issued it, when Loupe doesn't trust it yet (a company's own CA).
  for (final ca in bundle.chain) {
    if (!context.mounted) break;
    if (!ca.isCa || !ca.isSelfIssued || service.isTrustedRoot(ca)) continue;
    final mine = bundle.keys.first.certificate;
    if (service.check(mine).problem != SmimeProblem.untrusted) continue;
    await _askTrust(context, service, ca);
  }
  showSnack(messenger, 'Imported your certificate $names.');
}

Future<bool> _askTrust(BuildContext context, SmimeService service, SmimeCertificate ca) async {
  final fingerprint = [for (var i = 0; i < ca.fingerprint.length; i += 4) ca.fingerprint.substring(i, i + 4)].join(' ');
  final ok = await showActionSheet<bool>(
    context,
    title: 'Trust “${ca.displayName}” for Mail?',
    message:
        'Loupe doesn’t know this certificate authority (a company’s own, perhaps). Trust it to check the '
        'certificates it issues. Compare its fingerprint with your IT department first:\n$fingerprint',
    actions: const [SheetAction('Trust', true, isDefault: true)],
  );
  if (ok != true) return false;
  await service.store.trust(ca);
  return true;
}

/// Under a message's attachments: "A certificate is attached · Import"
/// for certificate files (a .p12 mailed to oneself, a colleague's .cer).
class SmimeCertificateAttachments extends ConsumerWidget {
  const SmimeCertificateAttachments({super.key, required this.content, required this.load});

  final EmailContent content;
  final Future<Uint8List> Function(Attachment attachment) load;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final files = content.attachments.where(isCertificateAttachment).toList();
    if (files.isEmpty) return const SizedBox.shrink();
    final colors = LoupeColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(LoupeIcons.certificate, size: 16, color: colors.secondaryText),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              files.length == 1 ? 'A certificate is attached.' : '${files.length} certificates are attached.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.secondaryText),
            ),
          ),
          TextButton(
            key: const ValueKey('import-attached-certificate'),
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              for (final a in files) {
                final Uint8List bytes;
                try {
                  bytes = await load(a);
                } on MailException catch (e) {
                  showSnack(messenger, e.message);
                  return;
                }
                if (!context.mounted) return;
                await importSmimeFile(context, ref, bytes, fromMessage: true);
              }
            },
            child: const Text('Import'),
          ),
        ],
      ),
    );
  }
}

/// "Import Certificate" on the details card of a certificate file opened
/// from a message.
class SmimeImportButton extends ConsumerWidget {
  const SmimeImportButton({super.key, required this.load});

  final Future<Uint8List> Function() load;

  @override
  Widget build(BuildContext context, WidgetRef ref) => SizedBox(
    width: 240,
    child: FilledButton.icon(
      key: const ValueKey('viewer-import-certificate'),
      onPressed: () async {
        final messenger = ScaffoldMessenger.of(context);
        final Uint8List bytes;
        try {
          bytes = await load();
        } on MailException catch (e) {
          showSnack(messenger, e.message);
          return;
        }
        if (context.mounted) await importSmimeFile(context, ref, bytes, fromMessage: true);
      },
      icon: const Icon(LoupeIcons.certificate, size: 20),
      label: const Text('Import Certificate'),
    ),
  );
}

/// Hands a certificate (PEM) to the share sheet as [name]; tests replace it.
final certificateExportProvider = Provider<Future<void> Function(String name, String pem)>(
  (ref) => (name, pem) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile.fromData(Uint8List.fromList(utf8.encode(pem)), name: name, mimeType: 'application/x-pem-file')],
        fileNameOverrides: [name],
      ),
    );
  },
);
