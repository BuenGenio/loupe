import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart';
import '../openpgp/content_loader.dart';
import '../openpgp/pgp_status.dart' show PgpTone, pgpToneColor;
import 'smime_providers.dart';
import 'smime_revocation.dart';

/// Whether remote content in [content] loads only when the user asks for
/// this message (never by the "load remote images" setting or a sender
/// allowed always): S/MIME decrypted from EnvelopedData, whose CBC has no
/// integrity protection. Whoever has the ciphertext can turn parts of it
/// into HTML that loads a URL holding the rest of the plaintext (EFAIL's
/// CBC gadgets). Not for AES-GCM (AuthEnvelopedData), nor for content a
/// valid signature inside covers: a changed ciphertext can't keep it.
bool remoteContentNeedsConsent(EmailContent content) {
  final status = smimeStatusOf(content);
  return status != null && status.decrypted && !status.authenticated && !(status.signature?.valid ?? false);
}

/// What the header says about a message's S/MIME status.
final class SmimeStatusView {
  const SmimeStatusView({
    required this.status,
    this.encryptionLabel,
    this.signatureLabel,
    this.issuer,
    this.signatureTone = PgpTone.neutral,
    this.check = false,
    this.revocation,
  });

  final SmimeMessageStatus status;

  /// What the signer's authority said about the certificate, when revocation is checked.
  final SmimeRevocationStatus? revocation;

  /// "Encrypted (S/MIME)", "Encrypted (S/MIME) · no certificate", … Null when not encrypted.
  final String? encryptionLabel;

  /// "Signed by Alice Example", "Signature invalid: message modified", … Null when not signed.
  final String? signatureLabel;

  /// The CA that vouches for a good signature, shown after the ✓.
  final String? issuer;
  final PgpTone signatureTone;

  /// Show ✓: a valid signature by a trusted certificate of the sender.
  final bool check;

  static SmimeStatusView of(AppLocalizations l10n, SmimeMessageStatus status, {SmimeRevocationStatus? revocation}) {
    String? encryption;
    if (status.encrypted) {
      encryption = switch (status.failure) {
        null => l10n.smimeEncrypted,
        SmimeDecryptFailure.noKey => l10n.smimeEncryptedNoCertificate,
        SmimeDecryptFailure.damaged => l10n.smimeEncryptedDamaged,
        SmimeDecryptFailure.unsupported => l10n.smimeEncryptedUnsupported,
        SmimeDecryptFailure.locked => l10n.smimeEncryptedLocked,
      };
    }
    final sig = status.signature;
    if (sig == null) return SmimeStatusView(status: status, encryptionLabel: encryption);
    final name = sig.certificate?.displayName ?? l10n.smimeUnknownSigner;
    final trust = sig.trust;
    final (String label, PgpTone tone, bool check) = switch (sig) {
      SmimeSignatureStatus(modified: true) => (l10n.smimeSignatureModified, PgpTone.bad, false),
      SmimeSignatureStatus(weak: true) => (l10n.smimeSignatureWeak, PgpTone.bad, false),
      SmimeSignatureStatus(valid: false) => (l10n.smimeSignatureUncheckable, PgpTone.caution, false),
      _ when trust == null => (l10n.smimeSignedCertificateMissing, PgpTone.caution, false),
      _ when revocation?.revoked ?? false => (l10n.smimeSignedByRevoked(name), PgpTone.bad, false),
      SmimeSignatureStatus(dateMismatch: true) when trust.trusted => (
        l10n.smimeSignedByOtherDate(name),
        PgpTone.caution,
        false,
      ),
      _ => switch (trust.problem) {
        null => (l10n.smimeSignedBy(name), PgpTone.good, true),
        SmimeProblem.invalidChain => (l10n.smimeSignedByInvalid(name), PgpTone.bad, false),
        SmimeProblem.untrusted => (l10n.smimeSignedByUntrusted(name), PgpTone.caution, false),
        SmimeProblem.expired => (l10n.smimeSignedByExpired(name), PgpTone.caution, false),
        SmimeProblem.notYetValid => (l10n.smimeSignedByNotYetValid(name), PgpTone.caution, false),
        SmimeProblem.wrongUsage => (l10n.smimeSignedByNotForMail(name), PgpTone.caution, false),
        SmimeProblem.wrongAddress => (l10n.smimeSignedByNotSender(name), PgpTone.caution, false),
      },
    };
    return SmimeStatusView(
      status: status,
      encryptionLabel: encryption,
      signatureLabel: label,
      signatureTone: tone,
      check: check,
      issuer: check ? trust?.issuerName : null,
      revocation: revocation,
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

/// The header's view of [content]'s S/MIME status, with the signer's
/// revocation status as it comes in (when it is checked).
SmimeStatusView? _viewOf(BuildContext context, WidgetRef ref, EmailContent? content) {
  if (content == null) return null;
  final status = smimeStatusOf(content);
  if (status == null) return null;
  final signature = status.signature;
  final revocation = signature == null ? null : ref.watch(signerRevocationProvider(signature)).value;
  return SmimeStatusView.of(context.l10n, status, revocation: revocation);
}

/// Next to the sender: a lock for encrypted mail and a seal for a good
/// signature (or a warning). Tapping explains.
class SmimeHeaderMark extends ConsumerWidget {
  const SmimeHeaderMark({super.key, required this.message, required this.content, this.onRetry});

  final EmailSummary message;
  final EmailContent? content;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = _viewOf(context, ref, content);
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
class SmimeStatusLine extends ConsumerWidget {
  const SmimeStatusLine({super.key, required this.message, required this.content, this.onRetry});

  final EmailSummary message;
  final EmailContent? content;

  /// Loads the message again (after trusting a certificate).
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = _viewOf(context, ref, content);
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
    final l10n = context.l10n;
    final status = this.view.status;
    final sig = status.signature;
    // The revocation answer may come while the sheet is open.
    final checking = ref.watch(checkRevocationProvider) && sig?.certificate != null;
    final revocationAsync = sig == null || !checking ? null : ref.watch(signerRevocationProvider(sig));
    final revocation = revocationAsync?.value ?? this.view.revocation;
    final view = SmimeStatusView.of(l10n, status, revocation: revocation);
    final cert = sig?.certificate;
    final trust = sig?.trust;
    final (icon, color, title) = switch (status.failure) {
      SmimeDecryptFailure() => (LoupeIcons.encrypted, pgpToneColor(context, PgpTone.caution), l10n.smimeCantDecrypt),
      null when sig != null => (_signatureIcon(view), pgpToneColor(context, view.signatureTone), view.signatureLabel!),
      null => (LoupeIcons.encrypted, colors.secondaryText, l10n.smimeEncryptedWithSmime),
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
                    _summary(l10n, view),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(color: colors.secondaryText),
                  ),
                ],
              ),
            ),
            if (status.encrypted)
              SheetGroup(
                header: l10n.smimeEncryption,
                children: [
                  _Row(
                    label: status.decrypted ? l10n.smimeDecryptedHere : status.failureMessage ?? l10n.smimeNotDecrypted,
                    value: status.decrypted
                        ? [
                            ?status.cipher,
                            if (status.authenticated) l10n.smimeAuthenticated,
                            if (status.recipients.isNotEmpty) l10n.smimeForCertificates(status.recipients.length),
                          ].join(' · ')
                        : null,
                  ),
                ],
              ),
            if (sig != null)
              SheetGroup(
                header: l10n.smimeSignature,
                children: [
                  if (cert != null) ...[
                    _Row(label: cert.displayName, value: cert.emails.join(', ')),
                    _Row(label: l10n.smimeIssuedBy, value: trust?.issuerName ?? cert.issuerName),
                    _Row(
                      label: l10n.smimeValid,
                      value: l10n.smimeValidRange(_day(cert.notBefore), _day(cert.notAfter)),
                    ),
                    _Row(label: l10n.smimeSha256Fingerprint, value: _grouped(cert.fingerprint), copy: cert.fingerprint),
                  ],
                  if (sig.signingTime case final at?) _Row(label: l10n.smimeSigned, value: _date(at)),
                  for (final p in trust?.problems ?? const <SmimeProblem>{})
                    _Row(label: l10n.smimeProblem, value: problemText(l10n, p)),
                  if (sig.dateMismatch) _Row(label: l10n.smimeProblem, value: l10n.smimeDateMismatch),
                  if (!sig.valid && sig.problem != null) _Row(label: l10n.smimeProblem, value: sig.problem),
                  if (checking)
                    _Row(
                      key: const ValueKey('smime-revocation'),
                      label: switch (revocation?.state) {
                        null => l10n.smimeCheckingRevocation,
                        SmimeRevocationState.good => l10n.smimeNotRevoked,
                        SmimeRevocationState.revoked => l10n.smimeRevoked,
                        SmimeRevocationState.unknown => l10n.smimeRevocationUnknown,
                      },
                      value: switch (revocation) {
                        null => null,
                        SmimeRevocationStatus(state: SmimeRevocationState.revoked, :final revokedAt, :final reason) => [
                          if (revokedAt != null) l10n.smimeRevokedSince(_date(revokedAt)),
                          ?reason,
                        ].join(' · '),
                        SmimeRevocationStatus(state: SmimeRevocationState.unknown, :final problem) => problem,
                        SmimeRevocationStatus(:final source, :final checkedAt) =>
                          source == SmimeRevocationSource.crl
                              ? l10n.smimeAskedAuthorityCrl(_date(checkedAt))
                              : l10n.smimeAskedAuthorityOcsp(_date(checkedAt)),
                      },
                    ),
                  if (canTrust && top != null && top != cert && top.isCa)
                    SheetRow(
                      key: const ValueKey('smime-trust-issuer'),
                      icon: LoupeIcons.certificate,
                      label: l10n.smimeTrustIssuer(top.displayName),
                      onTap: () => _trust(context, ref, top, authority: true),
                    ),
                  if (canTrust && cert != null)
                    SheetRow(
                      key: const ValueKey('smime-trust-certificate'),
                      icon: LoupeIcons.certificate,
                      label: l10n.smimeTrustThisCertificateEllipsis,
                      onTap: () => _trust(context, ref, cert, authority: false),
                    ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Text(
                checking ? l10n.smimeCheckedFooterRevocation : l10n.smimeCheckedFooter,
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
    final l10n = context.l10n;
    final fingerprint = _grouped(cert.fingerprint);
    final ok = await showActionSheet<bool>(
      context,
      title: authority
          ? l10n.smimeTrustAuthorityTitle(cert.displayName)
          : l10n.smimeTrustCertificateTitle(cert.displayName),
      message: authority ? l10n.smimeTrustAuthorityMessage(fingerprint) : l10n.smimeTrustMessage(fingerprint),
      actions: [SheetAction(l10n.smimeTrust, true, isDefault: true)],
    );
    if (ok != true || !context.mounted) return;
    final navigator = Navigator.of(context);
    await (await ref.read(smimeServiceProvider.future)).store.trust(cert);
    navigator.pop();
    onRetry?.call();
  }

  static String _summary(AppLocalizations l10n, SmimeStatusView view) {
    final status = view.status;
    if (status.failure case final f?) {
      return switch (f) {
        SmimeDecryptFailure.noKey => l10n.smimeSummaryNoKey,
        SmimeDecryptFailure.damaged => l10n.smimeSummaryDamaged,
        SmimeDecryptFailure.unsupported => l10n.smimeSummaryUnsupported,
        SmimeDecryptFailure.locked => status.failureMessage ?? l10n.smimeSummaryLocked,
      };
    }
    // Two sentences: who can read it, then what the signature says.
    return [if (status.encrypted) l10n.smimeSummaryEncrypted, _signatureSummary(l10n, view)].join(' ');
  }

  static String _signatureSummary(AppLocalizations l10n, SmimeStatusView view) {
    final sig = view.status.signature;
    if (sig == null) return l10n.smimeSummaryNotSigned;
    if (sig.modified) return l10n.smimeSummaryModified;
    if (!sig.valid) return sig.problem ?? l10n.smimeSummaryUncheckable;
    final trust = sig.trust;
    if (trust == null) return l10n.smimeSummaryNoCertificate;
    if (view.revocation case SmimeRevocationStatus(revoked: true, :final reason)) {
      return reason == null ? l10n.smimeSummaryRevoked : l10n.smimeSummaryRevokedReason(reason);
    }
    if (sig.dateMismatch && trust.trusted) return l10n.smimeDateMismatch;
    return switch (trust.problem) {
      null => l10n.smimeSummaryValid(trust.issuerName),
      final p => problemText(l10n, p),
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

/// A certificate problem in words.
String problemText(AppLocalizations l10n, SmimeProblem p) => switch (p) {
  SmimeProblem.invalidChain => l10n.smimeProblemInvalidChain,
  SmimeProblem.untrusted => l10n.smimeProblemUntrusted,
  SmimeProblem.expired => l10n.smimeProblemExpired,
  SmimeProblem.notYetValid => l10n.smimeProblemNotYetValid,
  SmimeProblem.wrongUsage => l10n.smimeProblemWrongUsage,
  SmimeProblem.wrongAddress => l10n.smimeProblemWrongAddress,
};

/// A SHA-256 fingerprint in groups of four.
String _grouped(String hex) =>
    [for (var i = 0; i < hex.length; i += 4) hex.substring(i, i + 4 > hex.length ? hex.length : i + 4)].join(' ');

class _Row extends StatelessWidget {
  const _Row({super.key, required this.label, required this.value, this.copy});

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
