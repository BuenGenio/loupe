import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart';
import '../openpgp/content_loader.dart';
import '../openpgp/pgp_status.dart' show PgpTone, pgpToneColor;
import 'smime_providers.dart';

/// What the header says about a message's S/MIME status.
final class SmimeStatusView {
  const SmimeStatusView({
    required this.status,
    this.encryptionLabel,
    this.signatureLabel,
    this.issuer,
    this.signatureTone = PgpTone.neutral,
    this.check = false,
  });

  final SmimeMessageStatus status;

  /// "Encrypted (S/MIME)", "Encrypted (S/MIME) · no certificate", … Null when not encrypted.
  final String? encryptionLabel;

  /// "Signed by Alice Example", "Signature invalid: message modified", … Null when not signed.
  final String? signatureLabel;

  /// The CA that vouches for a good signature, shown after the ✓.
  final String? issuer;
  final PgpTone signatureTone;

  /// Show ✓: a valid signature by a trusted certificate of the sender.
  final bool check;

  static SmimeStatusView of(SmimeMessageStatus status) {
    String? encryption;
    if (status.encrypted) {
      encryption = switch (status.failure) {
        null => 'Encrypted (S/MIME)',
        SmimeDecryptFailure.noKey => 'Encrypted (S/MIME) · no certificate',
        SmimeDecryptFailure.damaged => 'Encrypted (S/MIME) · damaged',
        SmimeDecryptFailure.unsupported => 'Encrypted (S/MIME) · unsupported',
      };
    }
    final sig = status.signature;
    if (sig == null) return SmimeStatusView(status: status, encryptionLabel: encryption);
    final name = sig.certificate?.displayName ?? 'unknown';
    final trust = sig.trust;
    final (String label, PgpTone tone, bool check) = switch (sig) {
      SmimeSignatureStatus(modified: true) => ('Signature invalid: message modified', PgpTone.bad, false),
      SmimeSignatureStatus(weak: true) => ('Signature insecure: outdated algorithm', PgpTone.bad, false),
      SmimeSignatureStatus(valid: false) => ('Signature can’t be checked', PgpTone.caution, false),
      _ when trust == null => ('Signed · certificate missing', PgpTone.caution, false),
      SmimeSignatureStatus(dateMismatch: true) when trust.trusted => (
        'Signed by $name · at another date',
        PgpTone.caution,
        false,
      ),
      _ => switch (trust.problem) {
        null => ('Signed by $name', PgpTone.good, true),
        SmimeProblem.invalidChain => ('Signed by $name · invalid certificate', PgpTone.bad, false),
        SmimeProblem.untrusted => ('Signed by $name · not trusted', PgpTone.caution, false),
        SmimeProblem.expired => ('Signed by $name · certificate expired', PgpTone.caution, false),
        SmimeProblem.notYetValid => ('Signed by $name · certificate not yet valid', PgpTone.caution, false),
        SmimeProblem.wrongUsage => ('Signed by $name · certificate not for mail', PgpTone.caution, false),
        SmimeProblem.wrongAddress => ('Signed by $name, not the sender', PgpTone.caution, false),
      },
    };
    return SmimeStatusView(
      status: status,
      encryptionLabel: encryption,
      signatureLabel: label,
      signatureTone: tone,
      check: check,
      issuer: check ? trust?.issuerName : null,
    );
  }

  /// The signature as the status line reads: "Signed by Alice Example ✓ (Example CA)".
  String? get signatureText {
    final s = signatureLabel;
    if (s == null) return null;
    return '$s${check ? ' ✓' : ''}${issuer == null ? '' : ' ($issuer)'}';
  }
}

IconData _signatureIcon(SmimeStatusView v) => switch (v.signatureTone) {
  PgpTone.good || PgpTone.neutral => LoupeIcons.signed,
  PgpTone.bad => LoupeIcons.signatureInvalid,
  PgpTone.caution => v.status.signature?.certificate == null ? LoupeIcons.unknownKey : LoupeIcons.certificate,
};

SmimeStatusView? _viewOf(EmailContent? content) {
  if (content == null) return null;
  final status = smimeStatusOf(content);
  return status == null ? null : SmimeStatusView.of(status);
}

/// Next to the sender: a lock for encrypted mail and a seal for a good
/// signature (or a warning). Tapping explains.
class SmimeHeaderMark extends StatelessWidget {
  const SmimeHeaderMark({super.key, required this.message, required this.content, this.onRetry});

  final EmailSummary message;
  final EmailContent? content;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final view = _viewOf(content);
    if (view == null) return const SizedBox.shrink();
    final colors = LoupeColors.of(context);
    final encrypted = view.encryptionLabel != null;
    return Semantics(
      button: true,
      label: [?view.encryptionLabel, ?view.signatureText].join(', '),
      excludeSemantics: true,
      child: InkWell(
        key: ValueKey('smime-mark-${message.id}'),
        borderRadius: BorderRadius.circular(10),
        onTap: () => showSmimeStatusSheet(context, view, onRetry: onRetry),
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

/// Under the recipients: "Encrypted (S/MIME) · Signed by Alice Example ✓
/// (Example CA)" in words. Tapping explains.
class SmimeStatusLine extends StatelessWidget {
  const SmimeStatusLine({super.key, required this.message, required this.content, this.onRetry});

  final EmailSummary message;
  final EmailContent? content;

  /// Loads the message again (after trusting a certificate).
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final view = _viewOf(content);
    if (view == null) return const SizedBox.shrink();
    final colors = LoupeColors.of(context);
    final style = Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13, color: colors.secondaryText);
    final parts = <InlineSpan>[
      if (view.encryptionLabel case final e?) ...[
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Icon(LoupeIcons.encrypted, size: 13, color: colors.secondaryText),
        ),
        TextSpan(text: ' $e'),
      ],
      if (view.encryptionLabel != null && view.signatureLabel != null) const TextSpan(text: '  ·  '),
      if (view.signatureText case final s?) ...[
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Icon(_signatureIcon(view), size: 13, color: pgpToneColor(context, view.signatureTone)),
        ),
        TextSpan(
          text: ' $s',
          style: TextStyle(
            color: view.signatureTone == PgpTone.neutral ? null : pgpToneColor(context, view.signatureTone),
          ),
        ),
      ],
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 2),
      child: InkWell(
        key: ValueKey('smime-status-${message.id}'),
        onTap: () => showSmimeStatusSheet(context, view, onRetry: onRetry),
        child: Text.rich(
          TextSpan(children: parts),
          style: style,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

/// The details: the cipher, who signed with which certificate, who issued
/// it, what is wrong with it, and trusting it.
Future<void> showSmimeStatusSheet(BuildContext context, SmimeStatusView view, {VoidCallback? onRetry}) =>
    showLoupeSheet<void>(
      context,
      builder: (context) => SmimeStatusSheet(view: view, onRetry: onRetry),
    );

class SmimeStatusSheet extends ConsumerWidget {
  const SmimeStatusSheet({super.key, required this.view, this.onRetry});

  final SmimeStatusView view;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    final status = view.status;
    final sig = status.signature;
    final cert = sig?.certificate;
    final trust = sig?.trust;
    final (icon, color, title) = switch (status.failure) {
      SmimeDecryptFailure() => (
        LoupeIcons.encrypted,
        pgpToneColor(context, PgpTone.caution),
        'Can’t decrypt this message',
      ),
      null when sig != null => (_signatureIcon(view), pgpToneColor(context, view.signatureTone), view.signatureLabel!),
      null => (LoupeIcons.encrypted, colors.secondaryText, 'Encrypted with S/MIME'),
    };
    final top = trust == null || trust.chain.length < 2 ? null : trust.chain.last;
    final canTrust = trust != null && trust.problems.contains(SmimeProblem.untrusted) && !sig!.modified;
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        key: const ValueKey('smime-sheet'),
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
                    _summary(view),
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
                    value: status.decrypted
                        ? [
                            ?status.cipher,
                            if (status.authenticated) 'authenticated',
                            if (status.recipients.isNotEmpty)
                              'for ${status.recipients.length} ${status.recipients.length == 1 ? 'certificate' : 'certificates'}',
                          ].join(' · ')
                        : null,
                  ),
                ],
              ),
            if (sig != null)
              SheetGroup(
                header: 'Signature',
                children: [
                  if (cert != null) ...[
                    _Row(label: cert.displayName, value: cert.emails.join(', ')),
                    _Row(label: 'Issued by', value: trust?.issuerName ?? cert.issuerName),
                    _Row(label: 'Valid', value: '${_day(cert.notBefore)} to ${_day(cert.notAfter)}'),
                    _Row(label: 'SHA-256 fingerprint', value: _grouped(cert.fingerprint), copy: cert.fingerprint),
                  ],
                  if (sig.signingTime case final at?) _Row(label: 'Signed', value: _date(at)),
                  for (final p in trust?.problems ?? const <SmimeProblem>{})
                    _Row(label: 'Problem', value: problemText(p)),
                  if (sig.dateMismatch) const _Row(label: 'Problem', value: _dateMismatch),
                  if (!sig.valid && sig.problem != null) _Row(label: 'Problem', value: sig.problem),
                  if (canTrust && top != null && top != cert && top.isCa)
                    SheetRow(
                      key: const ValueKey('smime-trust-issuer'),
                      icon: LoupeIcons.certificate,
                      label: 'Trust “${top.displayName}”…',
                      onTap: () => _trust(context, ref, top, authority: true),
                    ),
                  if (canTrust && cert != null)
                    SheetRow(
                      key: const ValueKey('smime-trust-certificate'),
                      icon: LoupeIcons.certificate,
                      label: 'Trust This Certificate…',
                      onTap: () => _trust(context, ref, cert, authority: false),
                    ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Text(
                'Checked on this device with S/MIME, compatible with Outlook and Thunderbird. Revocation isn’t checked.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(color: colors.secondaryText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _trust(BuildContext context, WidgetRef ref, SmimeCertificate cert, {required bool authority}) async {
    final ok = await showActionSheet<bool>(
      context,
      title: authority ? 'Trust ${cert.displayName} for mail?' : 'Trust ${cert.displayName}’s certificate?',
      message:
          '${authority ? 'Every certificate this authority issues will be trusted, like your company’s CA. ' : ''}'
          'Compare the fingerprint with its owner first:\n${_grouped(cert.fingerprint)}',
      actions: const [SheetAction('Trust', true, isDefault: true)],
    );
    if (ok != true || !context.mounted) return;
    final navigator = Navigator.of(context);
    await (await ref.read(smimeServiceProvider.future)).store.trust(cert);
    navigator.pop();
    onRetry?.call();
  }

  static String _summary(SmimeStatusView view) {
    final status = view.status;
    if (status.failure case final f?) {
      return switch (f) {
        SmimeDecryptFailure.noKey => 'It was encrypted to a certificate that isn’t on this device.',
        SmimeDecryptFailure.damaged => 'The encrypted data is damaged or was changed on the way.',
        SmimeDecryptFailure.unsupported => 'It uses an algorithm Loupe doesn’t support.',
      };
    }
    final sig = status.signature;
    final encrypted = status.encrypted ? 'Only you and the other recipients can read it. ' : '';
    if (sig == null) return '${encrypted}It isn’t signed, so the sender isn’t confirmed.';
    if (sig.modified) return '${encrypted}The signature doesn’t match: the message was changed after it was signed.';
    if (!sig.valid) return '$encrypted${sig.problem ?? 'The signature can’t be checked.'}';
    final trust = sig.trust;
    if (trust == null) return '${encrypted}The signer’s certificate isn’t in the message, so it can’t be checked.';
    if (sig.dateMismatch && trust.trusted) return '$encrypted$_dateMismatch';
    return encrypted +
        switch (trust.problem) {
          null => 'The signature is valid, and ${trust.issuerName} vouches that the certificate belongs to the sender.',
          final p => problemText(p),
        };
  }

  static String _day(DateTime d) {
    final l = d.toLocal();
    return '${l.year}-${l.month.toString().padLeft(2, '0')}-${l.day.toString().padLeft(2, '0')}';
  }

  static String _date(DateTime d) {
    final l = d.toLocal();
    String two(int v) => v.toString().padLeft(2, '0');
    return '${_day(d)} ${two(l.hour)}:${two(l.minute)}';
  }
}

const _dateMismatch =
    'It was signed more than an hour away from the message’s date: it may be an old message sent again.';

/// A certificate problem in words.
String problemText(SmimeProblem p) => switch (p) {
  SmimeProblem.invalidChain => 'The certificate or one of its issuers is invalid.',
  SmimeProblem.untrusted => 'The certificate comes from an authority Loupe doesn’t trust.',
  SmimeProblem.expired => 'The certificate had expired.',
  SmimeProblem.notYetValid => 'The certificate wasn’t valid yet.',
  SmimeProblem.wrongUsage => 'The certificate isn’t meant for mail.',
  SmimeProblem.wrongAddress => 'The certificate belongs to another address than the sender’s.',
};

/// A SHA-256 fingerprint in groups of four.
String _grouped(String hex) =>
    [for (var i = 0; i < hex.length; i += 4) hex.substring(i, i + 4 > hex.length ? hex.length : i + 4)].join(' ');

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
      subtitle: value == null || value!.isEmpty
          ? null
          : Text(
              value!,
              style: TextStyle(color: colors.secondaryText, fontFeatures: const [FontFeature.tabularFigures()]),
            ),
      onLongPress: copy == null ? null : () => Clipboard.setData(ClipboardData(text: copy!)),
    );
  }
}
