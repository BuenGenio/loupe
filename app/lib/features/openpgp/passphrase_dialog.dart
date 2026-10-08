import 'package:flutter/cupertino.dart';
import 'package:mail_crypto/mail_crypto.dart';

import '../../l10n/l10n.dart';
import '../../theme/theme.dart';
import 'openpgp_providers.dart' show PassphraseError;

/// Asks for the passphrase of [key]. Null on Cancel.
Future<String?> showPassphraseDialog(BuildContext context, {required PgpKey key, PassphraseError? error}) =>
    showCupertinoDialog<String>(
      context: context,
      builder: (context) => PassphraseDialog(pgpKey: key, error: error),
    );

/// "Unlock OpenPGP Key": whose key, its short id, a secure field, and
/// the reason when it is asked again.
class PassphraseDialog extends StatefulWidget {
  const PassphraseDialog({super.key, required this.pgpKey, this.error});

  final PgpKey pgpKey;
  final PassphraseError? error;

  @override
  State<PassphraseDialog> createState() => _PassphraseDialogState();
}

class _PassphraseDialogState extends State<PassphraseDialog> {
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
    final key = widget.pgpKey;
    final l10n = context.l10n;
    final error = switch (widget.error) {
      PassphraseError.wrong => l10n.openpgpWrongPassphrase,
      null => null,
    };
    return CupertinoAlertDialog(
      key: const ValueKey('passphrase-dialog'),
      title: Text(l10n.openpgpUnlockKeyTitle),
      content: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.openpgpEnterPassphrase(key.displayName, formatFingerprint(key.keyId))),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(error, style: TextStyle(color: LoupeColors.of(context).destructive)),
              ),
            const SizedBox(height: 12),
            CupertinoTextField(
              key: const ValueKey('passphrase-field'),
              controller: _controller,
              autofocus: true,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              placeholder: l10n.openpgpPassphrase,
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
        CupertinoDialogAction(
          key: const ValueKey('passphrase-unlock'),
          isDefaultAction: true,
          onPressed: _submit,
          child: Text(l10n.openpgpUnlock),
        ),
      ],
    );
  }
}
