import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart';
import '../smime/smime_providers.dart';
import 'openpgp_providers.dart';

/// The Encrypt and Sign choices of the message being written, and the
/// standard that protects it: OpenPGP or S/MIME.
///
/// Until the user touches a toggle, they follow the sender's settings and
/// the recipients (Thunderbird's automatic encryption, Autocrypt): adding
/// a recipient without a key turns automatic encryption off again. A
/// toggle the user touched stays as they set it. The standard is the
/// address's preference, unless only the other one has a key or
/// certificate for every recipient (or the message replies to mail
/// encrypted with the other); the user can switch when both are set up.
class ComposeSecurityController extends ChangeNotifier {
  ComposeSecurityController({this._smimeBackend = const DartSmimeBackend()});

  final SmimeBackend _smimeBackend;
  KeyringState _state = KeyringState.empty;
  SmimeState _smime = SmimeState.empty;
  String? _from;
  List<String> _recipients = const [];
  bool _replyToEncrypted = false;
  SecurityTechnology? _replyTechnology;

  bool _encrypt = false;
  bool _sign = false;
  bool _attachKey = false;
  bool _encryptTouched = false;
  bool _signTouched = false;

  /// The standard the user picked (or a draft brought back); null follows the automatic choice.
  SecurityTechnology? _chosen;

  /// The OpenPGP plan for the current recipients; null without a sender.
  EncryptionPlan? plan;

  /// The S/MIME plan for the current recipients; null without a sender.
  SmimePlan? smimePlan;

  /// The standard the message is protected with.
  SecurityTechnology technology = SecurityTechnology.openPgp;

  /// The sender has an OpenPGP key.
  bool get pgpAvailable => plan?.ownKey != null;

  /// The sender has a valid S/MIME certificate.
  bool get smimeAvailable => smimePlan?.canSign ?? false;

  /// The sender has a key or a certificate: the toggles are offered.
  bool get available => pgpAvailable || smimeAvailable;

  /// Both are set up: the user can switch.
  bool get canSwitch => pgpAvailable && smimeAvailable;

  bool get isSmime => technology == SecurityTechnology.smime;

  bool get encrypt => available && _encrypt;
  bool get sign => available && (_sign || _encrypt);
  bool get attachKey => available && !isSmime && _attachKey;

  /// Recipients without a key (OpenPGP) or a usable certificate (S/MIME).
  List<String> get missing => (isSmime ? smimePlan?.missing : plan?.missing) ?? const [];

  /// Every recipient has a key or certificate for the chosen standard.
  bool get possible => (isSmime ? smimePlan?.possible : plan?.possible) ?? false;

  /// Choices the user made (for "is this message changed?"), not automatic ones.
  String get manualSnapshot =>
      '${_encryptTouched ? _encrypt : '-'}${_signTouched ? _sign : '-'}${_chosen?.name ?? '-'}';

  /// What goes into the [OutgoingMessage].
  OutgoingSecurity get value =>
      OutgoingSecurity(encrypt: encrypt, sign: sign, attachPublicKey: attachKey, technology: technology);

  /// Recomputes the plans after the keyring, the certificates, the sender
  /// or the recipients changed.
  void update({
    required KeyringState state,
    SmimeState? smime,
    required String? from,
    required Iterable<String> recipients,
    bool? replyToEncrypted,
    SecurityTechnology? replyTechnology,
  }) {
    _state = state;
    if (smime != null) _smime = smime;
    _from = from;
    _recipients = [for (final r in recipients) r.trim().toLowerCase()];
    if (replyToEncrypted != null) _replyToEncrypted = replyToEncrypted;
    if (replyTechnology != null) _replyTechnology = replyTechnology;
    final sender = _from;
    plan = sender == null
        ? null
        : planEncryption(_state, from: sender, recipients: _recipients, replyToEncrypted: _replyToEncrypted);
    smimePlan = sender == null
        ? null
        : planSmime(_smime, from: sender, recipients: _recipients, signedBy: _smimeBackend.certificateSignedBy);
    technology = _technology(sender);
    final settings = sender == null ? IdentityPgp.defaults : _state.identity(sender);
    if (!_encryptTouched) _encrypt = _suggested(settings);
    if (!_signTouched) _sign = settings.signByDefault;
    _attachKey = settings.attachPublicKey;
    notifyListeners();
  }

  SecurityTechnology _technology(String? sender) {
    final chosen = _chosen;
    if (chosen == SecurityTechnology.smime && smimeAvailable) return chosen!;
    if (chosen == SecurityTechnology.openPgp && pgpAvailable) return chosen!;
    final preferSmime =
        _replyTechnology == SecurityTechnology.smime ||
        (_replyTechnology == null && sender != null && _smime.identity(sender).preferSmime);
    return chooseTechnology(
      pgp: pgpAvailable,
      smime: smimeAvailable,
      preferSmime: preferSmime,
      pgpCanEncrypt: plan?.possible ?? false,
      smimeCanEncrypt: smimePlan?.possible ?? false,
    );
  }

  /// Encrypt by default: OpenPGP's plan says so; for S/MIME, the address
  /// always encrypts, or every recipient has a certificate and the address
  /// encrypts automatically (or this replies to encrypted mail).
  bool _suggested(IdentityPgp settings) {
    if (!isSmime) return plan?.suggested ?? false;
    final p = smimePlan;
    if (p == null || !p.canSign) return false;
    return settings.encryptByDefault || (p.possible && (settings.autoEncrypt || _replyToEncrypted));
  }

  /// Choices brought back from a draft, the Outbox or crash recovery.
  void restore(OutgoingSecurity security) {
    if (security.isPlain) return;
    _encrypt = security.encrypt;
    _sign = security.sign;
    _encryptTouched = true;
    _signTouched = true;
    _chosen = security.technology;
    technology = _technology(_from);
    notifyListeners();
  }

  /// OpenPGP ⇄ S/MIME, when both are set up. Encryption that followed the
  /// recipients follows them for the other standard.
  void switchTechnology() {
    if (!canSwitch) return;
    _chosen = isSmime ? SecurityTechnology.openPgp : SecurityTechnology.smime;
    technology = _chosen!;
    final sender = _from;
    if (!_encryptTouched && sender != null) _encrypt = _suggested(_state.identity(sender));
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
  /// passphrase) and settles recipients without a key or certificate.
  /// Returns the security to send with, or null to stay in compose.
  Future<OutgoingSecurity?> prepareToSend(BuildContext context, WidgetRef ref) async {
    var security = value;
    final plan = this.plan;
    if (security.isPlain || (plan == null && smimePlan == null)) return security;
    final l10n = context.l10n;
    if (security.encrypt && missing.isNotEmpty) {
      final required = _from != null && _state.identity(_from!).encryptByDefault;
      final names = missing.join(', ');
      final choice = await showActionSheet<bool>(
        context,
        title: l10n.openpgpCantEncrypt,
        message: switch ((isSmime, required)) {
          (false, true) => l10n.openpgpNoKeyAlwaysEncrypt(names),
          (true, true) => l10n.openpgpNoCertificateAlwaysEncrypt(names),
          (false, false) => l10n.openpgpNoKeyFor(names),
          (true, false) => l10n.openpgpNoCertificateFor(names),
        },
        actions: [if (!required) SheetAction(l10n.openpgpSendUnencrypted, false, destructive: true)],
      );
      if (choice == null) return null;
      security = OutgoingSecurity(
        sign: security.sign,
        attachPublicKey: security.attachPublicKey,
        technology: security.technology,
      );
    }
    if (isSmime) {
      // A key with a passphrase is unlocked now, while the user is here: the
      // message is signed when it is queued.
      final own = smimePlan?.own;
      if (security.sign && own != null) {
        final service = await ref.read(smimeServiceProvider.future);
        if (own.hasPassphrase) return await service.unlock(own.fingerprint) == null ? null : security;
        if (service.keys.smimeKey(own.fingerprint) == null) {
          if (context.mounted) {
            await showActionSheet<bool>(
              context,
              title: l10n.openpgpCantSign,
              message: l10n.openpgpCantSignMessage,
              actions: const [],
            );
          }
          return null;
        }
      }
      return security;
    }
    final own = plan?.ownKey;
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
        final l10n = context.l10n;
        final smime = controller.isSmime;
        final missing = controller.missing;
        final String? hint;
        Color hintColor = colors.secondaryText;
        if (controller.encrypt && missing.isNotEmpty) {
          final names = missing.join(', ');
          hint = smime ? l10n.openpgpComposeNoCertificate(names) : l10n.openpgpComposeNoKey(names);
          hintColor = CupertinoColors.systemOrange.resolveFrom(context);
        } else if (controller.encrypt) {
          final autocrypt = !smime && (controller.plan?.keys.values.any((k) => k?.viaAutocrypt ?? false) ?? false);
          hint = autocrypt ? l10n.openpgpComposeAutocryptKeys : null;
        } else if (controller.possible) {
          hint = smime ? l10n.openpgpComposeEveryoneHasCertificate : l10n.openpgpComposeEveryoneHasKey;
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
                    label: l10n.openpgpComposeEncrypt,
                    on: controller.encrypt,
                    icon: controller.encrypt ? LoupeIcons.encrypted : LoupeIcons.encryptOff,
                    onTap: controller.toggleEncrypt,
                  ),
                  const SizedBox(width: 8),
                  _Toggle(
                    key: const Key('compose-sign'),
                    label: l10n.openpgpComposeSign,
                    on: controller.sign,
                    icon: controller.sign ? LoupeIcons.signed : LoupeIcons.signOff,
                    onTap: controller.toggleSign,
                  ),
                  if (controller.canSwitch || smime) ...[
                    const SizedBox(width: 8),
                    _Technology(
                      key: const Key('compose-technology'),
                      smime: smime,
                      onTap: controller.canSwitch ? controller.switchTechnology : null,
                    ),
                  ],
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

/// "OpenPGP" or "S/MIME": which standard protects the message. A tap
/// switches when both are set up.
class _Technology extends StatelessWidget {
  const _Technology({super.key, required this.smime, this.onTap});

  final bool smime;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final label = smime ? 'S/MIME' : 'OpenPGP'; // l10n-ignore: the standards' names
    return Semantics(
      button: onTap != null,
      label: onTap == null ? label : context.l10n.openpgpComposeSwitchStandard(label),
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: colors.secondaryText),
              ),
              if (onTap != null) Icon(LoupeIcons.disclosure, size: 14, color: colors.secondaryText),
            ],
          ),
        ),
      ),
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
