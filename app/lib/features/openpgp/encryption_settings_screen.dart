import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../shared/grouped_list.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../compose/identity_selection.dart';
import '../conversation/sheets.dart';
import '../settings/settings_widgets.dart';
import '../smime/smime_providers.dart';
import '../smime/smime_settings.dart';
import 'decrypted_mail.dart';
import 'key_import.dart';
import 'openpgp_providers.dart';
import 'pgp_status.dart';

/// Settings › End-to-End Encryption: the user's OpenPGP keys, the
/// settings of each address, correspondents' keys, S/MIME certificates
/// and passphrases. Thunderbird's Account Settings › End-To-End
/// Encryption plus its key and certificate managers, in one place.
class EncryptionSettingsScreen extends ConsumerWidget {
  const EncryptionSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final state = ref.watch(keyringStateProvider).value;
    final smime = ref.watch(smimeStateProvider).value ?? SmimeState.empty;
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
    final addresses = <String>{
      for (final a in accounts)
        for (final i in IdentitySelection.identitiesOf(a)) i.email.trim().toLowerCase(),
    }.toList();
    if (state == null) {
      return GroupedPage(title: l10n.openpgpEncryptionTitle, children: const [SizedBox(height: 200)]);
    }
    final now = DateTime.now();
    final decrypted = ref.watch(decryptedMailSettingsProvider);
    final accepted = [
      for (final e in state.publicKeys)
        if (e.source != KeySource.autocrypt || e.isAccepted) e,
    ];
    final collected = [
      for (final e in state.publicKeys)
        if (e.source == KeySource.autocrypt && !e.isAccepted) e,
    ];
    return GroupedPage(
      title: l10n.openpgpEncryptionTitle,
      children: [
        InsetGroup(
          header: l10n.openpgpMyKeys,
          separatorIndent: 58,
          footer: state.ownKeys.isEmpty ? l10n.openpgpMyKeysFooter : null,
          children: [
            for (final k in state.ownKeys)
              GroupedRow(
                key: ValueKey('own-${k.fingerprint}'),
                leading: SettingsIcon(LoupeIcons.pgpKey, colors.success),
                title: k.displayName,
                subtitle: _keySubtitle(l10n, k, now),
                onTap: () => context.push(Routes.encryptionKey(k.fingerprint)),
              ),
            GroupedRow(
              key: const ValueKey('add-own-key'),
              leading: Icon(LoupeIcons.add, color: colors.unreadDot, size: 26),
              title: l10n.openpgpAddKey,
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              chevron: false,
              onTap: () => _addKey(context, ref),
            ),
          ],
        ),
        if (addresses.isNotEmpty)
          InsetGroup(
            header: l10n.openpgpAddresses,
            separatorIndent: 16,
            footer: l10n.openpgpAddressesFooter,
            children: [
              for (final email in addresses)
                GroupedRow(
                  key: ValueKey('address-$email'),
                  title: email,
                  detail: _addressDetail(l10n, state, smime, email),
                  onTap: () => context.push(Routes.encryptionAddress(email)),
                ),
            ],
          ),
        InsetGroup(
          header: l10n.openpgpCorrespondentsKeys,
          separatorIndent: 58,
          footer: l10n.openpgpCorrespondentsKeysFooter,
          children: [
            for (final e in accepted) _publicRow(context, e),
            GroupedRow(
              key: const ValueKey('import-public-key'),
              leading: Icon(LoupeIcons.add, color: colors.unreadDot, size: 26),
              title: l10n.openpgpImportPublicKey,
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              chevron: false,
              onTap: () => _importFrom(context, ref),
            ),
          ],
        ),
        if (collected.isNotEmpty)
          InsetGroup(
            header: l10n.openpgpCollected,
            separatorIndent: 58,
            footer: l10n.openpgpCollectedFooter,
            children: [for (final e in collected) _publicRow(context, e)],
          ),
        const SmimeSettingsSection(),
        InsetGroup(
          header: l10n.openpgpOnThisDevice,
          separatorIndent: 16,
          footer: l10n.openpgpOnThisDeviceFooter,
          children: [
            SwitchRow(
              key: const ValueKey('subjects-in-background'),
              title: l10n.openpgpDecryptSubjects,
              value: decrypted.subjectsInBackground,
              onChanged: (v) =>
                  ref.read(decryptedMailSettingsProvider.notifier).update((s) => s.copyWith(subjectsInBackground: v)),
            ),
          ],
        ),
        InsetGroup(
          separatorIndent: 16,
          footer: l10n.openpgpIndexFooter,
          children: [
            SwitchRow(
              key: const ValueKey('index-decrypted'),
              title: l10n.openpgpIndexDecrypted,
              value: decrypted.indexForSearch,
              onChanged: (v) => _setIndexing(ref, v),
            ),
          ],
        ),
        InsetGroup(
          header: l10n.openpgpPassphrases,
          separatorIndent: 16,
          footer: l10n.openpgpPassphrasesFooter,
          children: [
            SwitchRow(
              title: l10n.openpgpRememberPassphrases,
              subtitle: l10n.openpgpRememberPassphrasesDetail,
              value: ref.watch(rememberPassphrasesProvider),
              onChanged: (v) => ref.read(rememberPassphrasesProvider.notifier).set(v),
            ),
            GroupedRow(
              key: const ValueKey('lock-keys'),
              title: l10n.openpgpLockKeysNow,
              chevron: false,
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                (await ref.read(openPgpServiceProvider.future)).lockAll();
                (await ref.read(smimeServiceProvider.future)).lockAll();
                showSnack(messenger, l10n.openpgpKeysLocked);
              },
            ),
          ],
        ),
      ],
    );
  }

  /// Index Decrypted Messages for Search; off takes the text out of the index.
  static Future<void> _setIndexing(WidgetRef ref, bool on) async {
    await ref.read(decryptedMailSettingsProvider.notifier).update((s) => s.copyWith(indexForSearch: on));
    if (on) return;
    try {
      if (ref.read(repositoryProvider) case final DecryptedMail cache) await cache.forgetDecryptedText();
    } on Object catch (e) {
      debugPrint('Removing decrypted text from the index failed: ${e.runtimeType}');
    }
  }

  Widget _publicRow(BuildContext context, PublicKeyEntry e) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final (icon, color) = switch (e.acceptance) {
      KeyAcceptance.verified => (LoupeIcons.signed, colors.success),
      KeyAcceptance.unverified => (LoupeIcons.pgpKey, colors.unreadDot),
      KeyAcceptance.undecided => (LoupeIcons.unknownKey, colors.tertiaryText),
      KeyAcceptance.rejected => (LoupeIcons.close, colors.destructive),
    };
    return GroupedRow(
      key: ValueKey('public-${e.key.fingerprint}'),
      leading: SettingsIcon(icon, color),
      title: e.key.displayName,
      subtitle: '${e.key.emails.join(', ')} · ${acceptanceLabel(l10n, e.acceptance)}',
      onTap: () => context.push(Routes.encryptionKey(e.key.fingerprint)),
    );
  }

  static String _keySubtitle(AppLocalizations l10n, PgpKey k, DateTime now) {
    final state = k.revoked
        ? l10n.openpgpKeyStateRevoked
        : k.isExpiredAt(now)
        ? l10n.openpgpKeyStateExpired
        : k.expires == null
        ? l10n.openpgpKeyStateNeverExpires
        : l10n.openpgpKeyStateExpires(_day(k.expires!));
    return '${k.algorithm} · ${formatFingerprint(k.keyId)} · $state';
  }

  static String _addressDetail(AppLocalizations l10n, KeyringState state, SmimeState smime, String email) {
    final key = state.ownKeyFor(email);
    final certificate = smime.ownCertificateFor(email);
    if (key == null && certificate == null) return l10n.openpgpNoKey;
    final s = state.identity(email);
    if (s.encryptByDefault) return l10n.openpgpAlwaysEncrypt;
    return [
      if (key != null) formatFingerprint(key.keyId).split(' ').last,
      if (certificate != null) 'S/MIME', // l10n-ignore: the standard's name
    ].join(' · ');
  }

  Future<void> _addKey(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final choice = await showActionSheet<String>(
      context,
      title: l10n.openpgpAddKeyTitle,
      message: l10n.openpgpAddKeyMessage,
      actions: [
        SheetAction(l10n.openpgpImportFromClipboard, 'paste'),
        SheetAction(l10n.openpgpImportFromFile, 'file'),
        SheetAction(l10n.openpgpGenerateNewKey, 'generate'),
      ],
    );
    if (choice == null || !context.mounted) return;
    if (choice == 'generate') {
      await context.push(Routes.generateKey);
      return;
    }
    await _import(context, ref, choice);
  }

  Future<void> _importFrom(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final choice = await showActionSheet<String>(
      context,
      title: l10n.openpgpImportPublicKeyTitle,
      actions: [SheetAction(l10n.openpgpFromClipboard, 'paste'), SheetAction(l10n.openpgpFromFile, 'file')],
    );
    if (choice == null || !context.mounted) return;
    await _import(context, ref, choice);
  }

  Future<void> _import(BuildContext context, WidgetRef ref, String from) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final data = await (from == 'paste' ? ref.read(pasteKeyProvider) : ref.read(pickKeyFileProvider))();
    if (data == null) {
      if (from == 'paste') showSnack(messenger, l10n.openpgpClipboardEmpty);
      return;
    }
    if (context.mounted) await importKeys(context, ref, data);
  }
}

String _day(DateTime d) {
  final l = d.toLocal();
  return '${l.year}-${l.month.toString().padLeft(2, '0')}-${l.day.toString().padLeft(2, '0')}';
}

/// One key: who it belongs to, its fingerprint, validity, and what can be
/// done with it (share, back up, accept, delete).
class KeyDetailsScreen extends ConsumerWidget {
  const KeyDetailsScreen({super.key, required this.fingerprint});

  final String fingerprint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(keyringStateProvider).value;
    final own = state?.ownKey(fingerprint);
    final entry = state?.publicEntry(fingerprint);
    final key = own ?? entry?.key;
    if (state == null || key == null) {
      return GroupedPage(title: l10n.openpgpKey, children: const [SizedBox(height: 200)]);
    }
    final colors = LoupeColors.of(context);
    final now = DateTime.now();
    final validity = key.revoked
        ? l10n.openpgpValidityRevoked
        : key.isExpiredAt(now)
        ? l10n.openpgpValidityExpired(_day(key.expires!))
        : key.expires == null
        ? l10n.openpgpNeverExpires
        : l10n.openpgpValidUntil(_day(key.expires!));
    return GroupedPage(
      title: key.displayName,
      children: [
        InsetGroup(
          header: l10n.openpgpKey,
          separatorIndent: 16,
          children: [
            for (final u in key.userIds) GroupedRow(title: u, chevron: false),
            GroupedRow(
              key: const ValueKey('key-fingerprint'),
              title: l10n.openpgpFingerprint,
              subtitle: key.formattedFingerprint,
              chevron: false,
              onLongPress: () => _copy(context, key.fingerprint, l10n.openpgpFingerprintCopied),
            ),
            GroupedRow(title: l10n.openpgpAlgorithm, detail: key.algorithm, chevron: false),
            GroupedRow(title: l10n.openpgpCreated, detail: _day(key.created), chevron: false),
            GroupedRow(title: l10n.openpgpValidity, detail: validity, chevron: false),
            if (own != null)
              GroupedRow(
                title: l10n.openpgpProtection,
                detail: own.isProtected ? l10n.openpgpProtectionPassphrase : l10n.openpgpProtectionKeychain,
                chevron: false,
              ),
            if (entry != null)
              GroupedRow(
                key: const ValueKey('key-acceptance'),
                title: l10n.openpgpAcceptance,
                detail: acceptanceLabel(l10n, entry.acceptance),
                onTap: () => pickAcceptance(context, ref, key, entry.acceptance),
              ),
          ],
        ),
        InsetGroup(
          separatorIndent: 16,
          footer: own == null ? null : l10n.openpgpKeyDetailsFooter,
          children: [
            GroupedRow(
              key: const ValueKey('share-public-key'),
              title: l10n.openpgpSharePublicKey,
              chevron: false,
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              onTap: () => _sharePublic(context, ref, key),
            ),
            GroupedRow(
              key: const ValueKey('copy-public-key'),
              title: l10n.openpgpCopyPublicKey,
              chevron: false,
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              onTap: () async {
                final armored = (await ref.read(openPgpServiceProvider.future)).armoredPublicKey(key.fingerprint);
                if (armored != null && context.mounted) _copy(context, armored, l10n.openpgpPublicKeyCopied);
              },
            ),
            if (own != null)
              GroupedRow(
                key: const ValueKey('backup-secret-key'),
                title: l10n.openpgpBackUpSecretKey,
                chevron: false,
                titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
                onTap: () => _backup(context, ref, own),
              ),
          ],
        ),
        InsetGroup(
          separatorIndent: 16,
          children: [
            GroupedRow(
              key: const ValueKey('delete-key'),
              title: own != null ? l10n.openpgpDeleteKey : l10n.openpgpRemoveKey,
              destructive: true,
              onTap: () => _delete(context, ref, key, own: own != null),
            ),
          ],
        ),
      ],
    );
  }

  void _copy(BuildContext context, String text, String done) {
    copyToClipboard(text);
    showSnack(ScaffoldMessenger.of(context), done);
  }

  Future<void> _sharePublic(BuildContext context, WidgetRef ref, PgpKey key) async {
    final armored = (await ref.read(openPgpServiceProvider.future)).armoredPublicKey(key.fingerprint);
    if (armored == null) return;
    await ref.read(keyExportProvider)('OpenPGP_0x${key.keyId}.asc', armored);
  }

  Future<void> _backup(BuildContext context, WidgetRef ref, PgpKey key) async {
    final l10n = context.l10n;
    final ok = await showActionSheet<bool>(
      context,
      title: l10n.openpgpBackUpTitle,
      message: key.isProtected ? l10n.openpgpBackUpProtected : l10n.openpgpBackUpUnprotected,
      actions: [SheetAction(l10n.openpgpBackUp, true, isDefault: true)],
    );
    if (ok != true) return;
    final armored = await (await ref.read(openPgpServiceProvider.future)).armoredSecretKey(key.fingerprint);
    if (armored == null) return;
    await ref.read(keyExportProvider)('OpenPGP_0x${key.keyId}_SECRET.asc', armored);
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, PgpKey key, {required bool own}) async {
    final l10n = context.l10n;
    final ok = await showActionSheet<bool>(
      context,
      title: own ? l10n.openpgpDeleteOwnKeyTitle(key.displayName) : l10n.openpgpRemoveKeyTitle(key.displayName),
      message: own ? l10n.openpgpDeleteOwnKeyMessage : l10n.openpgpRemoveKeyMessage,
      actions: [SheetAction(own ? l10n.openpgpDeleteKey : l10n.openpgpRemoveKey, true, destructive: true)],
    );
    if (ok != true || !context.mounted) return;
    final router = GoRouter.of(context);
    final service = await ref.read(openPgpServiceProvider.future);
    if (own) {
      await service.deleteOwnKey(key.fingerprint);
    } else {
      await service.keyring.removePublicKey(key.fingerprint);
    }
    router.pop();
  }
}
