import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_crypto/mail_crypto.dart';

import '../../router.dart';
import '../../shared/grouped_list.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart';
import '../openpgp/key_import.dart' show copyToClipboard, pasteKeyProvider, pickKeyFileProvider;
import '../settings/settings_widgets.dart';
import 'device_certificates.dart';
import 'smime_import.dart';
import 'smime_providers.dart';
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
  final warning = CupertinoColors.systemOrange.resolveFrom(context);
  final c = check.certificate;
  return switch (check.problem) {
    null => ('Trusted · ${check.issuerName}', colors.success),
    SmimeProblem.untrusted => ('Not trusted · ${check.issuerName}', warning),
    SmimeProblem.expired => ('Expired ${_day(c.notAfter)}', warning),
    SmimeProblem.notYetValid => ('Valid from ${_day(c.notBefore)}', warning),
    SmimeProblem.invalidChain => ('Invalid', colors.destructive),
    SmimeProblem.wrongUsage => ('Not for mail', warning),
    SmimeProblem.wrongAddress => ('Another address', warning),
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
          header: 'My S/MIME Certificates',
          separatorIndent: 58,
          footer: state.own.isEmpty
              ? 'For S/MIME, as Outlook and many companies use it. Import your certificate with its private key '
                    '(a .p12 or .pfx file), exported from Outlook, Windows, macOS or Thunderbird'
                    '${device.supported ? ', or use one your company or you installed on this device' : ''}.'
              : null,
          children: [
            for (final o in state.own)
              GroupedRow(
                key: ValueKey('smime-own-${o.fingerprint}'),
                leading: SettingsIcon(LoupeIcons.certificate, colors.success),
                title: o.certificate.displayName,
                subtitle:
                    '${o.certificate.emails.join(', ')} · '
                    '${o.certificate.isExpiredAt(now) ? 'expired' : 'until ${_day(o.certificate.notAfter)}'}'
                    '${o.onDevice ? ' · on this device' : ''}',
                onTap: () => context.push(Routes.smimeCertificate(o.fingerprint)),
              ),
            add('smime-import-own', 'Import Certificate…', () => _importFile(context, ref)),
            if (device.supported)
              add('smime-use-device', 'Use a Certificate from This Device…', () => useDeviceCertificate(context, ref)),
          ],
        ),
        InsetGroup(
          header: 'Correspondents’ Certificates',
          separatorIndent: 58,
          footer:
              'Collected from signed mail, as Outlook and Thunderbird do. Mail is encrypted only to trusted '
              'certificates: Loupe trusts the authorities Mozilla trusts for email, and those you add.',
          children: [
            for (final c in contacts) row(c.certificate, SmimeUsage.encryption, prefix: 'smime-contact'),
            add('smime-import-contact', 'Import Certificate…', () => _importContact(context, ref)),
          ],
        ),
        if (state.authorities.isNotEmpty)
          InsetGroup(
            header: 'Trusted Authorities',
            separatorIndent: 58,
            footer: 'Trusted by you, besides the ${mozillaRoots.length} that Mozilla trusts for email.',
            children: [
              for (final a in state.authorities)
                GroupedRow(
                  key: ValueKey('smime-authority-${a.fingerprint}'),
                  leading: SettingsIcon(LoupeIcons.verified, colors.unreadDot),
                  title: a.displayName,
                  subtitle: a.isCa ? 'Certificate authority' : a.emails.join(', '),
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
    final choice = await showActionSheet<String>(
      context,
      title: 'Import a Certificate',
      message: 'A correspondent’s certificate (.cer, .crt, .pem) or a certificate authority’s.',
      actions: const [SheetAction('From Clipboard', 'paste'), SheetAction('From File', 'file')],
    );
    if (choice == null || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final data = await (choice == 'paste' ? ref.read(pasteKeyProvider) : ref.read(pickKeyFileProvider))();
    if (data == null) {
      if (choice == 'paste') showSnack(messenger, 'The clipboard is empty. Copy the certificate first.');
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
    final service = ref.watch(smimeServiceProvider).value;
    final state = ref.watch(smimeStateProvider).value;
    final own = state?.ownCertificate(fingerprint);
    final contact = state?.contact(fingerprint);
    final authority = state?.authorities.where((a) => a.fingerprint == fingerprint).firstOrNull;
    final cert = own?.certificate ?? contact?.certificate ?? authority;
    if (service == null || state == null || cert == null) {
      return const GroupedPage(title: 'Certificate', children: [SizedBox(height: 200)]);
    }
    final colors = LoupeColors.of(context);
    final check = service.check(cert, usage: cert.canEncrypt ? SmimeUsage.encryption : SmimeUsage.signing);
    final (summary, color) = trustSummary(context, check);
    final usage = [if (cert.canSign) 'Signing', if (cert.canEncrypt) 'Encryption', if (cert.isCa) 'Certificates'];
    final top = check.chain.length > 1 ? check.chain.last : null;
    final trustedByUser = state.isTrustedByUser(cert);
    final link = colors.unreadDot;
    return GroupedPage(
      title: cert.displayName,
      children: [
        InsetGroup(
          header: 'Certificate',
          separatorIndent: 16,
          footer: own?.onDevice ?? false
              ? 'Its private key stays in Android’s credential storage, where your company or you installed it: '
                    'Loupe asks Android to sign and decrypt with it. Signed mail is signed when you send it.'
              : null,
          children: [
            GroupedRow(title: cert.subject.toString(), chevron: false),
            if (cert.emails.isNotEmpty) GroupedRow(title: 'Addresses', detail: cert.emails.join(', '), chevron: false),
            GroupedRow(title: 'Issued by', detail: cert.issuer.displayName, chevron: false),
            GroupedRow(title: 'Valid', detail: '${_day(cert.notBefore)} to ${_day(cert.notAfter)}', chevron: false),
            GroupedRow(title: 'For', detail: usage.isEmpty ? 'Nothing Loupe uses' : usage.join(', '), chevron: false),
            GroupedRow(title: 'Algorithm', detail: cert.algorithm, chevron: false),
            GroupedRow(title: 'Serial number', subtitle: cert.serialHex, chevron: false),
            GroupedRow(
              key: const ValueKey('smime-fingerprint'),
              title: 'SHA-256 fingerprint',
              subtitle: _grouped(cert.fingerprint),
              chevron: false,
              onLongPress: () {
                copyToClipboard(cert.fingerprint);
                showSnack(ScaffoldMessenger.of(context), 'Fingerprint copied.');
              },
            ),
            GroupedRow(title: 'SHA-1 thumbprint', subtitle: _grouped(cert.sha1Fingerprint), chevron: false),
            if (own != null)
              GroupedRow(
                key: const ValueKey('smime-key-location'),
                title: 'Private key',
                detail: own.onDevice ? 'On this device' : 'In Loupe',
                chevron: false,
              ),
            if (contact != null)
              GroupedRow(
                title: 'From',
                detail: contact.source == SmimeCertificateSource.collected ? 'Signed mail' : 'Imported',
                chevron: false,
              ),
          ],
        ),
        InsetGroup(
          header: 'Trust',
          separatorIndent: 16,
          footer: check.trusted
              ? null
              : [for (final p in SmimeProblem.values.where(check.problems.contains)) problemText(p)].join(' '),
          children: [
            GroupedRow(
              key: const ValueKey('smime-trust-summary'),
              title: summary,
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: color),
              chevron: false,
            ),
            for (final c in check.chain.skip(1))
              GroupedRow(title: c.displayName, subtitle: c == check.anchor ? 'Trusted root' : 'Issuer', chevron: false),
            if (check.problem == SmimeProblem.untrusted && top != null && top.isCa)
              GroupedRow(
                key: const ValueKey('smime-trust-top'),
                title: 'Trust “${top.displayName}”',
                titleStyle: LoupeTextStyles.of(context).body.copyWith(color: link),
                chevron: false,
                onTap: () => _trust(context, service, top),
              ),
            if (check.problem == SmimeProblem.untrusted && !trustedByUser)
              GroupedRow(
                key: const ValueKey('smime-trust-this'),
                title: cert.isCa ? 'Trust This Authority' : 'Trust This Certificate',
                titleStyle: LoupeTextStyles.of(context).body.copyWith(color: link),
                chevron: false,
                onTap: () => _trust(context, service, cert),
              ),
            if (trustedByUser)
              GroupedRow(
                key: const ValueKey('smime-untrust'),
                title: 'Stop Trusting',
                destructive: true,
                chevron: false,
                onTap: () => service.store.untrust(cert.fingerprint),
              ),
          ],
        ),
        InsetGroup(
          separatorIndent: 16,
          children: [
            GroupedRow(
              key: const ValueKey('smime-share'),
              title: 'Share Certificate',
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
                title: own != null ? 'Delete Certificate' : 'Remove Certificate',
                destructive: true,
                onTap: () => _delete(context, service, cert, own: own != null),
              ),
            ],
          ),
      ],
    );
  }

  static String _fileName(SmimeCertificate c) => c.displayName.replaceAll(RegExp(r'[^A-Za-z0-9._@-]+'), '_');

  Future<void> _trust(BuildContext context, SmimeService service, SmimeCertificate cert) async {
    final ok = await showActionSheet<bool>(
      context,
      title: 'Trust ${cert.displayName}?',
      message:
          '${cert.isCa ? 'Every certificate it issues will be trusted for mail. ' : ''}'
          'Compare the fingerprint with its owner first:\n${_grouped(cert.fingerprint)}',
      actions: const [SheetAction('Trust', true, isDefault: true)],
    );
    if (ok == true) await service.store.trust(cert);
  }

  Future<void> _delete(BuildContext context, SmimeService service, SmimeCertificate cert, {required bool own}) async {
    final ok = await showActionSheet<bool>(
      context,
      title: own ? 'Delete your certificate ${cert.displayName}?' : 'Remove ${cert.displayName}’s certificate?',
      message: own
          ? (service.state.ownCertificate(cert.fingerprint)?.onDevice ?? false)
                ? 'Loupe stops using it: mail encrypted to it can’t be read in Loupe anymore. The certificate stays '
                      'on this device (Settings › Security › Encryption & credentials).'
                : 'Its private key is deleted from this device: mail encrypted to it can’t be read here anymore, '
                      'unless you import it again.'
          : 'It comes back with their next signed message.',
      actions: [SheetAction(own ? 'Delete Certificate' : 'Remove Certificate', true, destructive: true)],
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
    final settings = state.identity(email);
    final current = state.ownCertificateFor(email);
    final choices = [
      for (final o in state.own)
        if (o.certificate.hasEmail(email) || o.fingerprint == settings.certificateFingerprint) o,
    ];
    Future<void> update(IdentitySmime next) => service.store.setIdentity(email, next);
    if (choices.isEmpty) {
      return InsetGroup(
        header: 'S/MIME',
        separatorIndent: 16,
        footer: 'Import a certificate for this address to sign and encrypt with S/MIME, as Outlook does.',
        children: [
          GroupedRow(
            key: const ValueKey('smime-address-import'),
            title: 'Import a Certificate…',
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
      header: 'S/MIME',
      separatorIndent: 16,
      footer: hasPgpKey
          ? 'When both could protect a message, the preferred one is used, unless only the other has a key or '
                'certificate for every recipient.'
          : null,
      children: [
        for (final o in choices)
          GroupedRow(
            key: ValueKey('smime-use-${o.fingerprint}'),
            title: o.certificate.displayName,
            subtitle: '${o.certificate.issuerName} · until ${_day(o.certificate.notAfter)}',
            chevron: false,
            trailing: current?.fingerprint == o.fingerprint
                ? Icon(LoupeIcons.check, color: colors.unreadDot, size: 22)
                : const SizedBox(width: 22),
            onTap: () => update(settings.copyWith(certificateFingerprint: o.fingerprint)),
          ),
        if (hasPgpKey)
          SwitchRow(
            title: 'Prefer S/MIME',
            subtitle: 'Rather than OpenPGP',
            value: settings.preferSmime,
            onChanged: (v) => update(settings.copyWith(preferSmime: v)),
          ),
      ],
    );
  }
}
