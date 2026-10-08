import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_crypto/mail_crypto.dart';

import '../../l10n/l10n.dart';
import '../../router.dart';
import '../../shared/grouped_list.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart';
import '../openpgp/key_import.dart' show copyToClipboard, pasteKeyProvider, pickKeyFileProvider;
import '../settings/settings_widgets.dart';
import 'device_certificates.dart';
import 'smime_import.dart';
import 'smime_passphrase.dart';
import 'smime_providers.dart';
import 'smime_revocation.dart';
import 'smime_service.dart';
import 'smime_status.dart' show problemText;

String _day(DateTime d) {
  final l = d.toLocal();
  return '${l.year}-${l.month.toString().padLeft(2, '0')}-${l.day.toString().padLeft(2, '0')}';
}

String _grouped(String hex) => [for (var i = 0; i < hex.length; i += 4) hex.substring(i, i + 4)].join(' ');

/// In words, how far a certificate is trusted: "Trusted (Loupe Test)",
/// "Not trusted", "Expired 2021-01-01", …
(String, Color) trustSummary(BuildContext context, SmimeTrustCheck check) {
  final colors = LoupeColors.of(context);
  final l10n = context.l10n;
  final warning = CupertinoColors.systemOrange.resolveFrom(context);
  final c = check.certificate;
  return switch (check.problem) {
    null => (l10n.smimeTrustedBy(check.issuerName), colors.success),
    SmimeProblem.untrusted => (l10n.smimeNotTrustedBy(check.issuerName), warning),
    SmimeProblem.expired => (l10n.smimeExpiredOn(_day(c.notAfter)), warning),
    SmimeProblem.notYetValid => (l10n.smimeValidFrom(_day(c.notBefore)), warning),
    SmimeProblem.invalidChain => (l10n.smimeTrustInvalid, colors.destructive),
    SmimeProblem.wrongUsage => (l10n.smimeTrustNotForMail, warning),
    SmimeProblem.wrongAddress => (l10n.smimeTrustAnotherAddress, warning),
  };
}

/// Settings › End-to-End Encryption, S/MIME: the user's certificates,
/// correspondents' certificates with their trust, and the authorities the
/// user trusts besides Mozilla's.
class SmimeSettingsSection extends ConsumerWidget {
  const SmimeSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(smimeServiceProvider).value;
    final state = ref.watch(smimeStateProvider).value;
    if (service == null || state == null) return const SizedBox.shrink();
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final now = DateTime.now();
    Widget row(SmimeCertificate c, SmimeUsage usage, {required String prefix}) {
      final check = service.check(c, usage: usage);
      final (summary, color) = trustSummary(context, check);
      return GroupedRow(
        key: ValueKey('$prefix-${c.fingerprint}'),
        leading: SettingsIcon(LoupeIcons.certificate, check.trusted ? colors.success : color),
        title: c.displayName,
        subtitle: '${c.emails.join(', ')} · $summary',
        onTap: () => context.push(Routes.smimeCertificate(c.fingerprint)),
      );
    }

    Widget add(String key, String title, VoidCallback onTap) => GroupedRow(
      key: ValueKey(key),
      leading: Icon(LoupeIcons.add, color: colors.unreadDot, size: 26),
      title: title,
      titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
      chevron: false,
      onTap: onTap,
    );

    final contacts = [...state.contacts]
      ..sort((a, b) => a.certificate.displayName.compareTo(b.certificate.displayName));
    final device = ref.watch(deviceCertificatesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InsetGroup(
          header: l10n.smimeMyCertificates,
          separatorIndent: 58,
          footer: state.own.isEmpty
              ? device.supported
                    ? l10n.smimeMyCertificatesFooterDevice
                    : l10n.smimeMyCertificatesFooter
              : null,
          children: [
            for (final o in state.own)
              GroupedRow(
                key: ValueKey('smime-own-${o.fingerprint}'),
                leading: SettingsIcon(LoupeIcons.certificate, colors.success),
                title: o.certificate.displayName,
                subtitle: [
                  o.certificate.emails.join(', '),
                  if (o.certificate.isExpiredAt(now))
                    l10n.smimeCertificateExpired
                  else
                    l10n.smimeCertificateUntil(_day(o.certificate.notAfter)),
                  if (o.onDevice) l10n.smimeCertificateOnDevice,
                ].join(' · '),
                onTap: () => context.push(Routes.smimeCertificate(o.fingerprint)),
              ),
            add('smime-import-own', l10n.smimeImportCertificateEllipsis, () => _importFile(context, ref)),
            if (device.supported)
              add('smime-use-device', l10n.smimeUseDeviceCertificate, () => useDeviceCertificate(context, ref)),
          ],
        ),
        InsetGroup(
          header: l10n.smimeCorrespondentsCertificates,
          separatorIndent: 58,
          footer: l10n.smimeCorrespondentsCertificatesFooter,
          children: [
            for (final c in contacts) row(c.certificate, SmimeUsage.encryption, prefix: 'smime-contact'),
            add('smime-import-contact', l10n.smimeImportCertificateEllipsis, () => _importContact(context, ref)),
          ],
        ),
        InsetGroup(
          header: l10n.smimeRevocation,
          separatorIndent: 16,
          footer: l10n.smimeRevocationFooter,
          children: [
            SwitchRow(
              key: const ValueKey('smime-check-revocation'),
              title: l10n.smimeCheckRevocation,
              value: ref.watch(checkRevocationProvider),
              onChanged: (v) => ref.read(checkRevocationProvider.notifier).set(v),
            ),
          ],
        ),
        if (state.authorities.isNotEmpty)
          InsetGroup(
            header: l10n.smimeTrustedAuthorities,
            separatorIndent: 58,
            footer: l10n.smimeTrustedAuthoritiesFooter(mozillaRoots.length),
            children: [
              for (final a in state.authorities)
                GroupedRow(
                  key: ValueKey('smime-authority-${a.fingerprint}'),
                  leading: SettingsIcon(LoupeIcons.verified, colors.unreadDot),
                  title: a.displayName,
                  subtitle: a.isCa ? l10n.smimeCertificateAuthority : a.emails.join(', '),
                  onTap: () => context.push(Routes.smimeCertificate(a.fingerprint)),
                ),
            ],
          ),
      ],
    );
  }

  Future<void> _importFile(BuildContext context, WidgetRef ref) async {
    final data = await ref.read(pickKeyFileProvider)();
    if (data == null || !context.mounted) return;
    await importSmimeFile(context, ref, data);
  }

  Future<void> _importContact(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final choice = await showActionSheet<String>(
      context,
      title: l10n.smimeImportACertificate,
      message: l10n.smimeImportContactMessage,
      actions: [SheetAction(l10n.smimeFromClipboard, 'paste'), SheetAction(l10n.smimeFromFile, 'file')],
    );
    if (choice == null || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final data = await (choice == 'paste' ? ref.read(pasteKeyProvider) : ref.read(pickKeyFileProvider))();
    if (data == null) {
      if (choice == 'paste') showSnack(messenger, l10n.smimeClipboardEmpty);
      return;
    }
    if (context.mounted) await importSmimeFile(context, ref, data);
  }
}

/// One certificate: who, which addresses, who issued it, how far it is
/// trusted and why, and what can be done (share, trust, remove).
class SmimeCertificateScreen extends ConsumerWidget {
  const SmimeCertificateScreen({super.key, required this.fingerprint});

  final String fingerprint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final service = ref.watch(smimeServiceProvider).value;
    final state = ref.watch(smimeStateProvider).value;
    final own = state?.ownCertificate(fingerprint);
    final contact = state?.contact(fingerprint);
    final authority = state?.authorities.where((a) => a.fingerprint == fingerprint).firstOrNull;
    final cert = own?.certificate ?? contact?.certificate ?? authority;
    if (service == null || state == null || cert == null) {
      return GroupedPage(title: l10n.smimeCertificate, children: const [SizedBox(height: 200)]);
    }
    final colors = LoupeColors.of(context);
    final check = service.check(cert, usage: cert.canEncrypt ? SmimeUsage.encryption : SmimeUsage.signing);
    final (summary, color) = trustSummary(context, check);
    final usage = [
      if (cert.canSign) l10n.smimeUsageSigning,
      if (cert.canEncrypt) l10n.smimeUsageEncryption,
      if (cert.isCa) l10n.smimeUsageCertificates,
    ];
    final top = check.chain.length > 1 ? check.chain.last : null;
    final trustedByUser = state.isTrustedByUser(cert);
    final link = colors.unreadDot;
    return GroupedPage(
      title: cert.displayName,
      children: [
        InsetGroup(
          header: l10n.smimeCertificate,
          separatorIndent: 16,
          footer: own?.onDevice ?? false ? l10n.smimeOnDeviceFooter : null,
          children: [
            GroupedRow(title: cert.subject.toString(), chevron: false),
            if (cert.emails.isNotEmpty)
              GroupedRow(title: l10n.smimeAddresses, detail: cert.emails.join(', '), chevron: false),
            GroupedRow(title: l10n.smimeIssuedBy, detail: cert.issuer.displayName, chevron: false),
            GroupedRow(
              title: l10n.smimeValid,
              detail: l10n.smimeValidRange(_day(cert.notBefore), _day(cert.notAfter)),
              chevron: false,
            ),
            GroupedRow(
              title: l10n.smimeUsage,
              detail: usage.isEmpty ? l10n.smimeUsageNone : usage.join(', '),
              chevron: false,
            ),
            GroupedRow(title: l10n.smimeAlgorithm, detail: cert.algorithm, chevron: false),
            GroupedRow(title: l10n.smimeSerialNumber, subtitle: cert.serialHex, chevron: false),
            GroupedRow(
              key: const ValueKey('smime-fingerprint'),
              title: l10n.smimeSha256Fingerprint,
              subtitle: _grouped(cert.fingerprint),
              chevron: false,
              onLongPress: () {
                copyToClipboard(cert.fingerprint);
                showSnack(ScaffoldMessenger.of(context), l10n.smimeFingerprintCopied);
              },
            ),
            GroupedRow(title: l10n.smimeSha1Thumbprint, subtitle: _grouped(cert.sha1Fingerprint), chevron: false),
            if (own != null)
              GroupedRow(
                key: const ValueKey('smime-key-location'),
                title: l10n.smimePrivateKey,
                detail: own.onDevice
                    ? l10n.smimeKeyOnDevice
                    : own.hasPassphrase
                    ? l10n.smimeKeyInLoupeWithPassphrase
                    : l10n.smimeKeyInLoupe,
                chevron: false,
              ),
            if (contact != null)
              GroupedRow(
                title: l10n.smimeSource,
                detail: contact.source == SmimeCertificateSource.collected
                    ? l10n.smimeSourceSignedMail
                    : l10n.smimeSourceImported,
                chevron: false,
              ),
          ],
        ),
        InsetGroup(
          header: l10n.smimeTrustHeader,
          separatorIndent: 16,
          footer: check.trusted
              ? null
              : [for (final p in SmimeProblem.values.where(check.problems.contains)) problemText(l10n, p)].join(' '),
          children: [
            GroupedRow(
              key: const ValueKey('smime-trust-summary'),
              title: summary,
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: color),
              chevron: false,
            ),
            for (final c in check.chain.skip(1))
              GroupedRow(
                title: c.displayName,
                subtitle: c == check.anchor ? l10n.smimeTrustedRoot : l10n.smimeIssuer,
                chevron: false,
              ),
            if (check.problem == SmimeProblem.untrusted && top != null && top.isCa)
              GroupedRow(
                key: const ValueKey('smime-trust-top'),
                title: l10n.smimeTrustNamed(top.displayName),
                titleStyle: LoupeTextStyles.of(context).body.copyWith(color: link),
                chevron: false,
                onTap: () => _trust(context, service, top),
              ),
            if (check.problem == SmimeProblem.untrusted && !trustedByUser)
              GroupedRow(
                key: const ValueKey('smime-trust-this'),
                title: cert.isCa ? l10n.smimeTrustThisAuthority : l10n.smimeTrustThisCertificate,
                titleStyle: LoupeTextStyles.of(context).body.copyWith(color: link),
                chevron: false,
                onTap: () => _trust(context, service, cert),
              ),
            if (trustedByUser)
              GroupedRow(
                key: const ValueKey('smime-untrust'),
                title: l10n.smimeStopTrusting,
                destructive: true,
                chevron: false,
                onTap: () => service.store.untrust(cert.fingerprint),
              ),
          ],
        ),
        if (own != null && !own.onDevice)
          InsetGroup(
            header: l10n.smimePassphrase,
            separatorIndent: 16,
            footer: l10n.smimePassphraseFooter,
            children: [
              GroupedRow(
                key: const ValueKey('smime-set-passphrase-row'),
                title: own.hasPassphrase ? l10n.smimeChangePassphrase : l10n.smimeSetPassphraseEllipsis,
                titleStyle: LoupeTextStyles.of(context).body.copyWith(color: link),
                chevron: false,
                onTap: () => _setPassphrase(context, service, own),
              ),
              if (own.hasPassphrase)
                GroupedRow(
                  key: const ValueKey('smime-remove-passphrase'),
                  title: l10n.smimeRemovePassphrase,
                  titleStyle: LoupeTextStyles.of(context).body.copyWith(color: link),
                  chevron: false,
                  onTap: () => _removePassphrase(context, service, own),
                ),
            ],
          ),
        InsetGroup(
          separatorIndent: 16,
          children: [
            GroupedRow(
              key: const ValueKey('smime-share'),
              title: l10n.smimeShareCertificate,
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: link),
              chevron: false,
              onTap: () => ref.read(certificateExportProvider)('${_fileName(cert)}.pem', cert.pem),
            ),
          ],
        ),
        if (own != null || contact != null)
          InsetGroup(
            separatorIndent: 16,
            children: [
              GroupedRow(
                key: const ValueKey('smime-delete'),
                title: own != null ? l10n.smimeDeleteCertificate : l10n.smimeRemoveCertificate,
                destructive: true,
                onTap: () => _delete(context, service, cert, own: own != null),
              ),
            ],
          ),
      ],
    );
  }

  Future<void> _setPassphrase(BuildContext context, SmimeService service, SmimeOwnCertificate own) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    try {
      // The current passphrase first, when there is one.
      if (await service.unlock(own.fingerprint) == null || !context.mounted) return;
      final passphrase = await showNewSmimePassphraseDialog(context);
      if (passphrase == null) return;
      if (await service.setPassphrase(own.fingerprint, passphrase)) {
        showSnack(messenger, own.hasPassphrase ? l10n.smimePassphraseChanged : l10n.smimePassphraseSet);
      }
    } on SmimeException catch (e) {
      showSnack(messenger, e.message);
    }
  }

  Future<void> _removePassphrase(BuildContext context, SmimeService service, SmimeOwnCertificate own) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final ok = await showActionSheet<bool>(
      context,
      title: l10n.smimeRemovePassphraseTitle,
      message: l10n.smimeRemovePassphraseMessage,
      actions: [SheetAction(l10n.smimeRemovePassphrase, true, destructive: true)],
    );
    if (ok != true) return;
    try {
      if (await service.removePassphrase(own.fingerprint)) showSnack(messenger, l10n.smimePassphraseRemoved);
    } on SmimeException catch (e) {
      showSnack(messenger, e.message);
    }
  }

  static String _fileName(SmimeCertificate c) => c.displayName.replaceAll(RegExp(r'[^A-Za-z0-9._@-]+'), '_');

  Future<void> _trust(BuildContext context, SmimeService service, SmimeCertificate cert) async {
    final l10n = context.l10n;
    final fingerprint = _grouped(cert.fingerprint);
    final ok = await showActionSheet<bool>(
      context,
      title: l10n.smimeTrustTitle(cert.displayName),
      message: cert.isCa ? l10n.smimeTrustCaMessage(fingerprint) : l10n.smimeTrustMessage(fingerprint),
      actions: [SheetAction(l10n.smimeTrust, true, isDefault: true)],
    );
    if (ok == true) await service.store.trust(cert);
  }

  Future<void> _delete(BuildContext context, SmimeService service, SmimeCertificate cert, {required bool own}) async {
    final l10n = context.l10n;
    final ok = await showActionSheet<bool>(
      context,
      title: own ? l10n.smimeDeleteOwnTitle(cert.displayName) : l10n.smimeRemoveContactTitle(cert.displayName),
      message: own
          ? (service.state.ownCertificate(cert.fingerprint)?.onDevice ?? false)
                ? l10n.smimeDeleteDeviceMessage
                : l10n.smimeDeleteOwnMessage
          : l10n.smimeRemoveContactMessage,
      actions: [SheetAction(own ? l10n.smimeDeleteCertificate : l10n.smimeRemoveCertificate, true, destructive: true)],
    );
    if (ok != true || !context.mounted) return;
    final router = GoRouter.of(context);
    if (own) {
      await service.deleteOwn(cert.fingerprint);
    } else {
      await service.store.removeContact(cert.fingerprint);
    }
    router.pop();
  }
}

/// On an address's encryption settings: its S/MIME certificate, and
/// whether to prefer S/MIME to OpenPGP.
class SmimeAddressGroup extends ConsumerWidget {
  const SmimeAddressGroup({super.key, required this.email, required this.hasPgpKey});

  final String email;
  final bool hasPgpKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(smimeServiceProvider).value;
    final state = ref.watch(smimeStateProvider).value;
    if (service == null || state == null) return const SizedBox.shrink();
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final settings = state.identity(email);
    final current = state.ownCertificateFor(email);
    final choices = [
      for (final o in state.own)
        if (o.certificate.hasEmail(email) || o.fingerprint == settings.certificateFingerprint) o,
    ];
    Future<void> update(IdentitySmime next) => service.store.setIdentity(email, next);
    if (choices.isEmpty) {
      return InsetGroup(
        header: 'S/MIME', // l10n-ignore: the standard's name
        separatorIndent: 16,
        footer: l10n.smimeAddressImportFooter,
        children: [
          GroupedRow(
            key: const ValueKey('smime-address-import'),
            title: l10n.smimeImportACertificateEllipsis,
            titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
            chevron: false,
            onTap: () async {
              final data = await ref.read(pickKeyFileProvider)();
              if (data != null && context.mounted) await importSmimeFile(context, ref, data);
            },
          ),
        ],
      );
    }
    return InsetGroup(
      header: 'S/MIME', // l10n-ignore: the standard's name
      separatorIndent: 16,
      footer: hasPgpKey ? l10n.smimePreferFooter : null,
      children: [
        for (final o in choices)
          GroupedRow(
            key: ValueKey('smime-use-${o.fingerprint}'),
            title: o.certificate.displayName,
            subtitle: '${o.certificate.issuerName} · ${l10n.smimeCertificateUntil(_day(o.certificate.notAfter))}',
            chevron: false,
            trailing: current?.fingerprint == o.fingerprint
                ? Icon(LoupeIcons.check, color: colors.unreadDot, size: 22)
                : const SizedBox(width: 22),
            onTap: () => update(settings.copyWith(certificateFingerprint: o.fingerprint)),
          ),
        if (hasPgpKey)
          SwitchRow(
            title: l10n.smimePreferSmime,
            subtitle: l10n.smimePreferSmimeDetail,
            value: settings.preferSmime,
            onChanged: (v) => update(settings.copyWith(preferSmime: v)),
          ),
      ],
    );
  }
}
