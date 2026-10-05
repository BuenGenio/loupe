import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart';
import 'content_loader.dart';
import 'openpgp_providers.dart';

/// How a signature looks: Thunderbird's states in Apple Mail's words.
enum PgpTone { good, neutral, caution, bad }

/// What the header says about a message's OpenPGP status.
final class PgpStatusView {
  const PgpStatusView({
    required this.status,
    this.encryptionLabel,
    this.signatureLabel,
    this.signatureTone = PgpTone.neutral,
    this.check = false,
    this.signer,
    this.acceptance,
    this.mismatch = false,
  });

  final PgpMessageStatus status;

  /// "Encrypted", "Encrypted · locked", … Null when not encrypted.
  final String? encryptionLabel;

  /// "Signed by Dana Okafor", "Signature invalid", "Unknown key". Null when not signed.
  final String? signatureLabel;
  final PgpTone signatureTone;

  /// Show ✓ after the signature label (an accepted key).
  final bool check;

  /// The key that made a good or bad signature.
  final PgpKey? signer;
  final KeyAcceptance? acceptance;

  /// The signer's key doesn't carry the sender's address.
  final bool mismatch;

  static PgpStatusView of(PgpMessageStatus status, KeyringState keyring, {String? sender}) {
    String? encryption;
    if (status.encrypted) {
      encryption = switch (status.failure) {
        null when status.partial => 'Encrypted in part',
        null => 'Encrypted',
        PgpDecryptFailure.locked => 'Encrypted · locked',
        PgpDecryptFailure.noSecretKey => 'Encrypted · no key',
        PgpDecryptFailure.damaged => 'Encrypted · damaged',
        PgpDecryptFailure.unsupported => 'Encrypted · unsupported',
      };
    }
    final sig = status.signature;
    if (sig == null) return PgpStatusView(status: status, encryptionLabel: encryption);
    final fingerprint = sig.signerFingerprint;
    final signer = fingerprint == null ? null : keyring.ownKey(fingerprint) ?? keyring.publicEntry(fingerprint)?.key;
    final acceptance = fingerprint == null ? null : keyring.acceptanceOf(fingerprint);
    final name = signer?.displayName ?? 'unknown';
    switch (sig.status) {
      case PgpSignatureStatus.unknownKey:
        return PgpStatusView(
          status: status,
          encryptionLabel: encryption,
          signatureLabel: 'Unknown key',
          signatureTone: PgpTone.caution,
        );
      case PgpSignatureStatus.bad:
        return PgpStatusView(
          status: status,
          encryptionLabel: encryption,
          signatureLabel: 'Signature invalid',
          signatureTone: PgpTone.bad,
          signer: signer,
          acceptance: acceptance,
        );
      case PgpSignatureStatus.good:
        final mismatch = sender != null && signer != null && !signer.hasEmail(sender);
        final (label, tone, check) = switch (acceptance) {
          _ when mismatch => ('Signed by $name, not the sender', PgpTone.caution, false),
          _ when status.partial => ('Signed in part by $name', PgpTone.caution, false),
          KeyAcceptance.verified => ('Signed by $name', PgpTone.good, true),
          KeyAcceptance.unverified => ('Signed by $name', PgpTone.neutral, true),
          KeyAcceptance.rejected => ('Signed with a rejected key', PgpTone.bad, false),
          KeyAcceptance.undecided || null => ('Signed by $name · key not accepted', PgpTone.caution, false),
        };
        return PgpStatusView(
          status: status,
          encryptionLabel: encryption,
          signatureLabel: label,
          signatureTone: tone,
          check: check,
          signer: signer,
          acceptance: acceptance,
          mismatch: mismatch,
        );
    }
  }
}

Color pgpToneColor(BuildContext context, PgpTone tone) => switch (tone) {
  PgpTone.good => CupertinoColors.systemGreen.resolveFrom(context),
  PgpTone.neutral => LoupeColors.of(context).secondaryText,
  PgpTone.caution => CupertinoColors.systemOrange.resolveFrom(context),
  PgpTone.bad => CupertinoColors.systemRed.resolveFrom(context),
};

IconData _signatureIcon(PgpStatusView v) => switch (v.signatureTone) {
  PgpTone.good || PgpTone.neutral => LoupeIcons.signed,
  PgpTone.bad => LoupeIcons.signatureInvalid,
  PgpTone.caution =>
    v.status.signature?.status == PgpSignatureStatus.unknownKey ? LoupeIcons.unknownKey : LoupeIcons.signed,
};

PgpStatusView? _viewOf(WidgetRef ref, EmailContent? content, EmailSummary message) {
  if (content == null) return null;
  final status = pgpStatusOf(content);
  if (status == null) return null;
  final keyring = ref.watch(keyringStateProvider).value ?? KeyringState.empty;
  return PgpStatusView.of(status, keyring, sender: message.sender?.email);
}

/// Next to the sender, beside the security badge: a lock for encrypted
/// mail and a seal for a good signature (or a warning). Tapping explains.
class PgpHeaderMark extends ConsumerWidget {
  const PgpHeaderMark({super.key, required this.message, required this.content, this.onRetry});

  final EmailSummary message;
  final EmailContent? content;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = _viewOf(ref, content, message);
    if (view == null) return const SizedBox.shrink();
    final colors = LoupeColors.of(context);
    final encrypted = view.encryptionLabel != null;
    return Semantics(
      button: true,
      label: [?view.encryptionLabel, ?view.signatureLabel].join(', '),
      excludeSemantics: true,
      child: InkWell(
        key: ValueKey('pgp-mark-${message.id}'),
        borderRadius: BorderRadius.circular(10),
        onTap: () => showPgpStatusSheet(context, view, onRetry: onRetry),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (encrypted)
                Icon(
                  LoupeIcons.encrypted,
                  size: 15,
                  color: view.status.decrypted ? colors.secondaryText : pgpToneColor(context, PgpTone.caution),
                ),
              if (encrypted && view.signatureLabel != null) const SizedBox(width: 3),
              if (view.signatureLabel != null)
                Icon(_signatureIcon(view), size: 15, color: pgpToneColor(context, view.signatureTone)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Under the recipients: "Encrypted · Signed by Dana Okafor ✓" in words,
/// with Unlock when the key is locked. Tapping explains.
class PgpStatusLine extends ConsumerWidget {
  const PgpStatusLine({super.key, required this.message, required this.content, this.onRetry});

  final EmailSummary message;
  final EmailContent? content;

  /// Loads the message again (after unlocking the key).
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = _viewOf(ref, content, message);
    if (view == null) return const SizedBox.shrink();
    final colors = LoupeColors.of(context);
    final style = Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13, color: colors.secondaryText);
    final locked = view.status.failure == PgpDecryptFailure.locked;
    final parts = <InlineSpan>[
      if (view.encryptionLabel case final e?) ...[
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Icon(LoupeIcons.encrypted, size: 13, color: colors.secondaryText),
        ),
        TextSpan(text: ' $e'),
      ],
      if (view.encryptionLabel != null && view.signatureLabel != null) const TextSpan(text: '  ·  '),
      if (view.signatureLabel case final s?) ...[
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Icon(_signatureIcon(view), size: 13, color: pgpToneColor(context, view.signatureTone)),
        ),
        TextSpan(
          text: ' $s${view.check ? ' ✓' : ''}',
          style: TextStyle(
            color: view.signatureTone == PgpTone.neutral ? null : pgpToneColor(context, view.signatureTone),
          ),
        ),
      ],
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 2),
      child: Row(
        children: [
          Flexible(
            child: InkWell(
              key: ValueKey('pgp-status-${message.id}'),
              onTap: () => showPgpStatusSheet(context, view, onRetry: onRetry),
              child: Text.rich(
                TextSpan(children: parts),
                style: style,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (locked && onRetry != null)
            TextButton(
              key: ValueKey('pgp-unlock-${message.id}'),
              style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
              onPressed: () => _unlockAndRetry(context, ref, view, onRetry!),
              child: const Text('Unlock'),
            ),
        ],
      ),
    );
  }
}

Future<void> _unlockAndRetry(BuildContext context, WidgetRef ref, PgpStatusView view, VoidCallback retry) async {
  final service = await ref.read(openPgpServiceProvider.future);
  for (final key in service.ownKeysFor(view.status.recipientKeyIds)) {
    if (await service.unlock(key.fingerprint) != null) {
      retry();
      return;
    }
  }
}

/// The details: what was encrypted to whom, who signed with which key,
/// and the key's acceptance, which can be changed here.
Future<void> showPgpStatusSheet(BuildContext context, PgpStatusView view, {VoidCallback? onRetry}) =>
    showLoupeSheet<void>(
      context,
      builder: (context) => PgpStatusSheet(view: view, onRetry: onRetry),
    );

class PgpStatusSheet extends ConsumerWidget {
  const PgpStatusSheet({super.key, required this.view, this.onRetry});

  final PgpStatusView view;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    final status = view.status;
    final sig = status.signature;
    final keyring = ref.watch(keyringStateProvider).value ?? KeyringState.empty;
    final signer = view.signer;
    final acceptance = signer == null ? null : keyring.acceptanceOf(signer.fingerprint);
    final own = signer != null && keyring.ownKey(signer.fingerprint) != null;
    final (icon, color, title) = switch (status.failure) {
      PgpDecryptFailure() => (
        LoupeIcons.encrypted,
        pgpToneColor(context, PgpTone.caution),
        'Can’t decrypt this message',
      ),
      null when sig != null => (_signatureIcon(view), pgpToneColor(context, view.signatureTone), view.signatureLabel!),
      null => (LoupeIcons.encrypted, colors.secondaryText, 'Encrypted with OpenPGP'),
    };
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        key: const ValueKey('pgp-sheet'),
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 18),
              child: Column(
                children: [
                  Icon(icon, size: 40, color: color),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _summary(view, acceptance, own),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(color: colors.secondaryText),
                  ),
                ],
              ),
            ),
            if (status.encrypted)
              SheetGroup(
                header: 'Encryption',
                children: [
                  _Row(
                    label: status.decrypted ? 'Decrypted on this device' : status.failureMessage ?? 'Not decrypted',
                    value: status.recipientKeyIds.isEmpty
                        ? null
                        : 'For ${status.recipientKeyIds.length == 1 ? 'key' : 'keys'} '
                              '${status.recipientKeyIds.map(formatFingerprint).join(', ')}',
                  ),
                  if (status.protectedSubject case final s?) _Row(label: 'Protected subject', value: s),
                  if (status.failure == PgpDecryptFailure.locked && onRetry != null)
                    SheetRow(
                      icon: LoupeIcons.pgpKey,
                      label: 'Unlock Key',
                      onTap: () async {
                        Navigator.of(context).pop();
                        await _unlockAndRetry(context, ref, view, onRetry!);
                      },
                    ),
                ],
              ),
            if (sig != null)
              SheetGroup(
                header: 'Signature',
                children: [
                  if (signer != null) _Row(label: signer.userIds.firstOrNull ?? signer.displayName, value: null),
                  _Row(
                    label: 'Fingerprint',
                    value: signer == null
                        ? 'Key id ${formatFingerprint(sig.issuerKeyId)}'
                        : signer.formattedFingerprint,
                    copy: signer?.fingerprint ?? sig.issuerKeyId,
                  ),
                  if (sig.created case final at?) _Row(label: 'Signed', value: _date(at)),
                  if (sig.detail case final d?) _Row(label: 'Problem', value: d),
                  if (signer != null && !own)
                    _Row(label: 'Acceptance', value: acceptanceLabel(acceptance ?? KeyAcceptance.undecided)),
                  if (signer != null && !own)
                    SheetRow(
                      key: const ValueKey('pgp-change-acceptance'),
                      icon: LoupeIcons.pgpKey,
                      label: 'Change Acceptance…',
                      onTap: () => pickAcceptance(context, ref, signer, acceptance ?? KeyAcceptance.undecided),
                    ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Text(
                'Checked on this device with OpenPGP, compatible with Thunderbird.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(color: colors.secondaryText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _summary(PgpStatusView view, KeyAcceptance? acceptance, bool own) {
    final status = view.status;
    if (status.failure case final f?) {
      return switch (f) {
        PgpDecryptFailure.locked => 'Your key is locked. Unlock it with its passphrase to read this message.',
        PgpDecryptFailure.noSecretKey => 'It was encrypted to a key that isn’t on this device.',
        PgpDecryptFailure.damaged => 'The encrypted data is damaged or was changed on the way.',
        PgpDecryptFailure.unsupported => 'It uses an algorithm Loupe doesn’t support.',
      };
    }
    final sig = status.signature;
    final encrypted = status.encrypted ? 'Only you and the other recipients can read it. ' : '';
    if (sig == null) return '${encrypted}It isn’t signed, so the sender isn’t confirmed.';
    return encrypted +
        switch (sig.status) {
          PgpSignatureStatus.unknownKey =>
            'It is signed, but with a key you don’t have, so the signature can’t be checked.',
          PgpSignatureStatus.bad => 'The signature doesn’t match: the message may have been changed.',
          PgpSignatureStatus.good when view.mismatch =>
            'The signature is valid, but the key belongs to another address than the sender’s.',
          PgpSignatureStatus.good when status.partial =>
            'Only part of the message is signed. Text outside the signature (a mailing list footer, for example) '
                'is shown below the “Unsigned content” line, and other parts of the message, such as attachments, '
                'aren’t covered either.',
          PgpSignatureStatus.good when own => 'Signed with your own key.',
          PgpSignatureStatus.good => switch (acceptance) {
            KeyAcceptance.verified => 'The signature is valid, and you verified the key’s fingerprint.',
            KeyAcceptance.unverified =>
              'The signature is valid. You accepted the key without checking its fingerprint.',
            KeyAcceptance.rejected => 'The signature is valid, but you rejected this key.',
            _ =>
              'The signature is valid, but you haven’t accepted this key yet. Compare its fingerprint with the sender.',
          },
        };
  }

  static String _date(DateTime d) {
    final l = d.toLocal();
    String two(int v) => v.toString().padLeft(2, '0');
    return '${l.year}-${two(l.month)}-${two(l.day)} ${two(l.hour)}:${two(l.minute)}';
  }
}

String acceptanceLabel(KeyAcceptance a) => switch (a) {
  KeyAcceptance.rejected => 'Rejected',
  KeyAcceptance.undecided => 'Not accepted',
  KeyAcceptance.unverified => 'Accepted',
  KeyAcceptance.verified => 'Accepted and verified',
};

/// Thunderbird's "Your acceptance" choice for [key].
Future<void> pickAcceptance(BuildContext context, WidgetRef ref, PgpKey key, KeyAcceptance current) async {
  final choice = await showActionSheet<KeyAcceptance>(
    context,
    title: 'Accept ${key.displayName}’s key?',
    message: 'Fingerprint ${key.formattedFingerprint}',
    actions: [
      SheetAction(
        'Yes, I verified the fingerprint',
        KeyAcceptance.verified,
        isDefault: current == KeyAcceptance.verified,
      ),
      SheetAction('Yes, without checking', KeyAcceptance.unverified, isDefault: current == KeyAcceptance.unverified),
      SheetAction('Not yet', KeyAcceptance.undecided, isDefault: current == KeyAcceptance.undecided),
      const SheetAction('Reject this key', KeyAcceptance.rejected, destructive: true),
    ],
  );
  if (choice == null) return;
  final keyring = await ref.read(keyringProvider.future);
  if (keyring.state.publicEntry(key.fingerprint) == null) {
    await keyring.addPublicKeys([key], acceptance: choice);
  } else {
    await keyring.setAcceptance(key.fingerprint, choice);
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.copy});

  final String label;
  final String? value;
  final String? copy;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return ListTile(
      dense: true,
      title: Text(label, style: const TextStyle(fontSize: 15)),
      subtitle: value == null
          ? null
          : Text(
              value!,
              style: TextStyle(color: colors.secondaryText, fontFeatures: const [FontFeature.tabularFigures()]),
            ),
      onLongPress: copy == null ? null : () => Clipboard.setData(ClipboardData(text: copy!)),
    );
  }
}

/// The conversation's subject: the protected one of an encrypted message
/// (whose outer subject is "..."), once [content] has loaded; [trailing]
/// spans follow it (the muted mark).
class ProtectedSubject extends StatelessWidget {
  const ProtectedSubject({
    super.key,
    required this.subject,
    required this.content,
    this.style,
    this.trailing = const [],
  });

  final String subject;
  final Future<EmailContent>? content;
  final TextStyle? style;
  final List<InlineSpan> trailing;

  @override
  Widget build(BuildContext context) {
    String shown(String s) => s.trim().isEmpty ? '(no subject)' : s;
    return FutureBuilder<EmailContent>(
      future: content,
      builder: (context, snapshot) {
        final data = snapshot.data;
        final protected = data == null ? null : pgpStatusOf(data)?.protectedSubject;
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(text: shown(protected ?? subject)),
              ...trailing,
            ],
          ),
          style: style,
        );
      },
    );
  }
}
