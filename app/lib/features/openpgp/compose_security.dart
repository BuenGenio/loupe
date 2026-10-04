import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart';
import 'openpgp_providers.dart';

/// The Encrypt and Sign choices of the message being written.
///
/// Until the user touches a toggle, they follow the sender's settings and
/// the recipients (Thunderbird's automatic encryption, Autocrypt): adding
/// a recipient without a key turns automatic encryption off again. A
/// toggle the user touched stays as they set it.
class ComposeSecurityController extends ChangeNotifier {
  KeyringState _state = KeyringState.empty;
  String? _from;
  List<String> _recipients = const [];
  bool _replyToEncrypted = false;

  bool _encrypt = false;
  bool _sign = false;
  bool _attachKey = false;
  bool _encryptTouched = false;
  bool _signTouched = false;

  /// The plan for the current recipients; null without a sender.
  EncryptionPlan? plan;

  /// The sender has a key: the toggles are offered.
  bool get available => plan?.ownKey != null;

  bool get encrypt => available && _encrypt;
  bool get sign => available && (_sign || _encrypt);
  bool get attachKey => available && _attachKey;

  /// Choices the user made (for "is this message changed?"), not automatic ones.
  String get manualSnapshot => '${_encryptTouched ? _encrypt : '-'}${_signTouched ? _sign : '-'}';

  /// What goes into the [OutgoingMessage].
  OutgoingSecurity get value => OutgoingSecurity(encrypt: encrypt, sign: sign, attachPublicKey: attachKey);

  /// Recomputes the plan after the keyring, the sender or the recipients changed.
  void update({
    required KeyringState state,
    required String? from,
    required Iterable<String> recipients,
    bool? replyToEncrypted,
  }) {
    _state = state;
    _from = from;
    _recipients = [for (final r in recipients) r.trim().toLowerCase()];
    if (replyToEncrypted != null) _replyToEncrypted = replyToEncrypted;
    final sender = _from;
    plan = sender == null
        ? null
        : planEncryption(_state, from: sender, recipients: _recipients, replyToEncrypted: _replyToEncrypted);
    final settings = sender == null ? IdentityPgp.defaults : _state.identity(sender);
    if (!_encryptTouched) _encrypt = plan?.suggested ?? false;
    if (!_signTouched) _sign = settings.signByDefault;
    _attachKey = settings.attachPublicKey;
    notifyListeners();
  }

  /// Choices brought back from a draft, the Outbox or crash recovery.
  void restore(OutgoingSecurity security) {
    if (security.isPlain) return;
    _encrypt = security.encrypt;
    _sign = security.sign;
    _encryptTouched = true;
    _signTouched = true;
    notifyListeners();
  }

  void toggleEncrypt() {
    _encrypt = !encrypt;
    _encryptTouched = true;
    notifyListeners();
  }

  void toggleSign() {
    _sign = !sign;
    _signTouched = true;
    // Encrypted mail is always signed: turning signing off turns encryption off.
    if (!_sign && _encrypt) {
      _encrypt = false;
      _encryptTouched = true;
    }
    notifyListeners();
  }

  /// Just before sending: unlocks the signing key (asking for its
  /// passphrase) and settles recipients without a key. Returns the
  /// security to send with, or null to stay in compose.
  Future<OutgoingSecurity?> prepareToSend(BuildContext context, WidgetRef ref) async {
    var security = value;
    final plan = this.plan;
    if (security.isPlain || plan == null) return security;
    if (security.encrypt && plan.missing.isNotEmpty) {
      final required = _from != null && _state.identity(_from!).encryptByDefault;
      final missing = plan.missing.join(', ');
      final choice = await showActionSheet<bool>(
        context,
        title: 'Can’t Encrypt',
        message: required
            ? 'There is no OpenPGP key for $missing, and this address always encrypts. Remove the recipient, or '
                  'import their key in Settings › End-to-End Encryption.'
            : 'There is no OpenPGP key for $missing.',
        actions: [if (!required) const SheetAction('Send Unencrypted', false, destructive: true)],
      );
      if (choice == null) return null;
      security = OutgoingSecurity(sign: security.sign, attachPublicKey: security.attachPublicKey);
    }
    final own = plan.ownKey;
    if (security.sign && own != null) {
      final service = await ref.read(openPgpServiceProvider.future);
      if (await service.unlock(own.fingerprint) == null) return null;
    }
    return security;
  }
}

/// Under the subject: the Encrypt and Sign toggles, and what encryption
/// would do (who has no key). Hidden when the sender has no key.
class ComposeSecurityBar extends StatelessWidget {
  const ComposeSecurityBar({super.key, required this.controller});

  final ComposeSecurityController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (!controller.available) return const SizedBox.shrink();
        final colors = LoupeColors.of(context);
        final plan = controller.plan!;
        final missing = plan.missing;
        final String? hint;
        Color hintColor = colors.secondaryText;
        if (controller.encrypt && missing.isNotEmpty) {
          hint = 'No key for ${missing.join(', ')}';
          hintColor = CupertinoColors.systemOrange.resolveFrom(context);
        } else if (controller.encrypt) {
          hint = plan.keys.values.any((k) => k?.viaAutocrypt ?? false) ? 'Keys from Autocrypt' : null;
        } else if (plan.possible && plan.keys.isNotEmpty) {
          hint = 'Everyone has a key';
        } else {
          hint = null;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 16, 6),
              child: Row(
                children: [
                  _Toggle(
                    key: const Key('compose-encrypt'),
                    label: 'Encrypt',
                    on: controller.encrypt,
                    icon: controller.encrypt ? LoupeIcons.encrypted : LoupeIcons.encryptOff,
                    onTap: controller.toggleEncrypt,
                  ),
                  const SizedBox(width: 8),
                  _Toggle(
                    key: const Key('compose-sign'),
                    label: 'Sign',
                    on: controller.sign,
                    icon: controller.sign ? LoupeIcons.signed : LoupeIcons.signOff,
                    onTap: controller.toggleSign,
                  ),
                  const SizedBox(width: 10),
                  if (hint != null)
                    Expanded(
                      child: Text(
                        hint,
                        key: const Key('compose-security-hint'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, color: hintColor),
                      ),
                    ),
                ],
              ),
            ),
            Divider(indent: 16, color: colors.separator),
          ],
        );
      },
    );
  }
}

class _Toggle extends StatelessWidget {
  const _Toggle({super.key, required this.label, required this.on, required this.icon, required this.onTap});

  final String label;
  final bool on;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final accent = colors.success;
    final color = on ? accent : colors.secondaryText;
    return Semantics(
      button: true,
      toggled: on,
      label: label,
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.fromLTRB(8, 4, 10, 4),
          decoration: BoxDecoration(
            color: on ? accent.withValues(alpha: 0.13) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: on ? Colors.transparent : colors.separator),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 15, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
