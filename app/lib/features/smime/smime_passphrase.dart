/// The passphrase of an S/MIME certificate's private key (optional, off by
/// default): unlocking it, and choosing one.
library;

import 'package:flutter/cupertino.dart';
import 'package:mail_crypto/mail_crypto.dart';

import '../../l10n/l10n.dart';
import '../../theme/theme.dart';
import '../openpgp/openpgp_providers.dart' show PassphraseError;

/// Asks for the passphrase of [certificate]'s key. Null on Cancel.
Future<String?> showSmimeUnlockDialog(
  BuildContext context, {
  required SmimeCertificate certificate,
  PassphraseError? error,
}) => showCupertinoDialog<String>(
  context: context,
  builder: (context) => SmimeUnlockDialog(certificate: certificate, error: error),
);

/// "Unlock S/MIME Certificate": whose, a secure field, and the reason when it is asked again.
class SmimeUnlockDialog extends StatefulWidget {
  const SmimeUnlockDialog({super.key, required this.certificate, this.error});

  final SmimeCertificate certificate;
  final PassphraseError? error;

  @override
  State<SmimeUnlockDialog> createState() => _SmimeUnlockDialogState();
}

class _SmimeUnlockDialogState extends State<SmimeUnlockDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_controller.text.isEmpty) return;
    Navigator.of(context).pop(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.certificate;
    final l10n = context.l10n;
    final error = switch (widget.error) {
      PassphraseError.wrong => l10n.smimeWrongPassphrase,
      null => null,
    };
    return CupertinoAlertDialog(
      key: const ValueKey('smime-unlock-dialog'),
      title: Text(l10n.smimeUnlockTitle),
      content: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.smimeEnterPassphrase(c.displayName, c.emails.join(', '))),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(error, style: TextStyle(color: LoupeColors.of(context).destructive)),
              ),
            const SizedBox(height: 12),
            CupertinoTextField(
              key: const ValueKey('smime-unlock-field'),
              controller: _controller,
              autofocus: true,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              placeholder: l10n.smimePassphrase,
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
        CupertinoDialogAction(
          key: const ValueKey('smime-unlock'),
          isDefaultAction: true,
          onPressed: _submit,
          child: Text(l10n.smimeUnlock),
        ),
      ],
    );
  }
}

/// Asks for a new passphrase, twice. Null on Cancel.
Future<String?> showNewSmimePassphraseDialog(BuildContext context) =>
    showCupertinoDialog<String>(context: context, builder: (context) => const NewSmimePassphraseDialog());

/// "Set Passphrase": the new passphrase and again, which must match.
class NewSmimePassphraseDialog extends StatefulWidget {
  const NewSmimePassphraseDialog({super.key});

  @override
  State<NewSmimePassphraseDialog> createState() => _NewSmimePassphraseDialogState();
}

class _NewSmimePassphraseDialogState extends State<NewSmimePassphraseDialog> {
  final _first = TextEditingController();
  final _second = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _first.dispose();
    _second.dispose();
    super.dispose();
  }

  void _submit() {
    final l10n = context.l10n;
    final error = _first.text.isEmpty
        ? l10n.smimeEnterAPassphrase
        : _first.text != _second.text
        ? l10n.smimePassphrasesDiffer
        : null;
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    Navigator.of(context).pop(_first.text);
  }

  @override
  Widget build(BuildContext context) {
    final error = _error;
    final l10n = context.l10n;
    return CupertinoAlertDialog(
      key: const ValueKey('smime-new-passphrase-dialog'),
      title: Text(l10n.smimeSetPassphraseTitle),
      content: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.smimeSetPassphraseText),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(error, style: TextStyle(color: LoupeColors.of(context).destructive)),
              ),
            const SizedBox(height: 12),
            CupertinoTextField(
              key: const ValueKey('smime-new-passphrase'),
              controller: _first,
              autofocus: true,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              placeholder: l10n.smimePassphrase,
            ),
            const SizedBox(height: 8),
            CupertinoTextField(
              key: const ValueKey('smime-new-passphrase-again'),
              controller: _second,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              placeholder: l10n.smimePassphraseAgain,
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
        CupertinoDialogAction(
          key: const ValueKey('smime-set-passphrase'),
          isDefaultAction: true,
          onPressed: _submit,
          child: Text(l10n.smimeSetPassphraseButton),
        ),
      ],
    );
  }
}
