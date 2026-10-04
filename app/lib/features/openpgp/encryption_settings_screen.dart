import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

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
    final state = ref.watch(keyringStateProvider).value;
    final smime = ref.watch(smimeStateProvider).value ?? SmimeState.empty;
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
    final addresses = <String>{
      for (final a in accounts)
        for (final i in IdentitySelection.identitiesOf(a)) i.email.trim().toLowerCase(),
    }.toList();
    if (state == null) {
      return const GroupedPage(title: 'End-to-End Encryption', children: [SizedBox(height: 200)]);
    }
    final now = DateTime.now();
    final accepted = [
      for (final e in state.publicKeys)
        if (e.source != KeySource.autocrypt || e.isAccepted) e,
    ];
    final collected = [
      for (final e in state.publicKeys)
        if (e.source == KeySource.autocrypt && !e.isAccepted) e,
    ];
    return GroupedPage(
      title: 'End-to-End Encryption',
      children: [
        InsetGroup(
          header: 'My OpenPGP Keys',
          separatorIndent: 58,
          footer: state.ownKeys.isEmpty
              ? 'With a key, you can read encrypted mail and sign and encrypt your own. Using Thunderbird? '
                    'Export your key there (Account Settings › End-To-End Encryption › Export Secret Key) and '
                    'import it here.'
              : null,
          children: [
            for (final k in state.ownKeys)
              GroupedRow(
                key: ValueKey('own-${k.fingerprint}'),
                leading: SettingsIcon(LoupeIcons.pgpKey, colors.success),
                title: k.displayName,
                subtitle: _keySubtitle(k, now),
                onTap: () => context.push(Routes.encryptionKey(k.fingerprint)),
              ),
            GroupedRow(
              key: const ValueKey('add-own-key'),
              leading: Icon(LoupeIcons.add, color: colors.unreadDot, size: 26),
              title: 'Add Key…',
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              chevron: false,
              onTap: () => _addKey(context, ref),
            ),
          ],
        ),
        if (addresses.isNotEmpty)
          InsetGroup(
            header: 'Addresses',
            separatorIndent: 16,
            footer: 'Which key each address uses, and when it encrypts and signs.',
            children: [
              for (final email in addresses)
                GroupedRow(
                  key: ValueKey('address-$email'),
                  title: email,
                  detail: _addressDetail(state, smime, email),
                  onTap: () => context.push(Routes.encryptionAddress(email)),
                ),
            ],
          ),
        InsetGroup(
          header: 'Correspondents’ OpenPGP Keys',
          separatorIndent: 58,
          footer:
              'Accept a key once you trust it belongs to its owner; compare the fingerprint with them to '
              'mark it verified.',
          children: [
            for (final e in accepted) _publicRow(context, e),
            GroupedRow(
              key: const ValueKey('import-public-key'),
              leading: Icon(LoupeIcons.add, color: colors.unreadDot, size: 26),
              title: 'Import Public Key…',
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              chevron: false,
              onTap: () => _importFrom(context, ref),
            ),
          ],
        ),
        if (collected.isNotEmpty)
          InsetGroup(
            header: 'Collected from Autocrypt',
            separatorIndent: 58,
            footer: 'Keys that arrived with messages. Loupe can encrypt to them when both sides ask for it.',
            children: [for (final e in collected) _publicRow(context, e)],
          ),
        const SmimeSettingsSection(),
        InsetGroup(
          header: 'Passphrases',
          separatorIndent: 16,
          footer:
              'Keys you protect with a passphrase are unlocked when needed. Without "Remember", they are '
              'locked again two minutes after each use.',
          children: [
            SwitchRow(
              title: 'Remember Passphrases',
              subtitle: 'Until Loupe closes',
              value: ref.watch(rememberPassphrasesProvider),
              onChanged: (v) => ref.read(rememberPassphrasesProvider.notifier).set(v),
            ),
            GroupedRow(
              key: const ValueKey('lock-keys'),
              title: 'Lock Keys Now',
              chevron: false,
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                (await ref.read(openPgpServiceProvider.future)).lockAll();
                showSnack(messenger, 'Keys locked.');
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _publicRow(BuildContext context, PublicKeyEntry e) {
    final colors = LoupeColors.of(context);
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
      subtitle: '${e.key.emails.join(', ')} · ${acceptanceLabel(e.acceptance)}',
      onTap: () => context.push(Routes.encryptionKey(e.key.fingerprint)),
    );
  }

  static String _keySubtitle(PgpKey k, DateTime now) {
    final state = k.revoked
        ? 'revoked'
        : k.isExpiredAt(now)
        ? 'expired'
        : k.expires == null
        ? 'never expires'
        : 'expires ${_day(k.expires!)}';
    return '${k.algorithm} · ${formatFingerprint(k.keyId)} · $state';
  }

  static String _addressDetail(KeyringState state, SmimeState smime, String email) {
    final key = state.ownKeyFor(email);
    final certificate = smime.ownCertificateFor(email);
    if (key == null && certificate == null) return 'No Key';
    final s = state.identity(email);
    if (s.encryptByDefault) return 'Always Encrypt';
    return [
      if (key != null) formatFingerprint(key.keyId).split(' ').last,
      if (certificate != null) 'S/MIME',
    ].join(' · ');
  }

  Future<void> _addKey(BuildContext context, WidgetRef ref) async {
    final choice = await showActionSheet<String>(
      context,
      title: 'Add an OpenPGP Key',
      message: 'Import the key you use in Thunderbird, or make a new one.',
      actions: const [
        SheetAction('Import from Clipboard', 'paste'),
        SheetAction('Import from File', 'file'),
        SheetAction('Generate New Key', 'generate'),
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
    final choice = await showActionSheet<String>(
      context,
      title: 'Import a Public Key',
      actions: const [SheetAction('From Clipboard', 'paste'), SheetAction('From File', 'file')],
    );
    if (choice == null || !context.mounted) return;
    await _import(context, ref, choice);
  }

  Future<void> _import(BuildContext context, WidgetRef ref, String from) async {
    final messenger = ScaffoldMessenger.of(context);
    final data = await (from == 'paste' ? ref.read(pasteKeyProvider) : ref.read(pickKeyFileProvider))();
    if (data == null) {
      if (from == 'paste') showSnack(messenger, 'The clipboard is empty. Copy the key first.');
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
    final state = ref.watch(keyringStateProvider).value;
    final own = state?.ownKey(fingerprint);
    final entry = state?.publicEntry(fingerprint);
    final key = own ?? entry?.key;
    if (state == null || key == null) {
      return const GroupedPage(title: 'Key', children: [SizedBox(height: 200)]);
    }
    final colors = LoupeColors.of(context);
    final now = DateTime.now();
    final validity = key.revoked
        ? 'Revoked'
        : key.isExpiredAt(now)
        ? 'Expired ${_day(key.expires!)}'
        : key.expires == null
        ? 'Never expires'
        : 'Valid until ${_day(key.expires!)}';
    return GroupedPage(
      title: key.displayName,
      children: [
        InsetGroup(
          header: 'Key',
          separatorIndent: 16,
          children: [
            for (final u in key.userIds) GroupedRow(title: u, chevron: false),
            GroupedRow(
              key: const ValueKey('key-fingerprint'),
              title: 'Fingerprint',
              subtitle: key.formattedFingerprint,
              chevron: false,
              onLongPress: () => _copy(context, key.fingerprint, 'Fingerprint copied.'),
            ),
            GroupedRow(title: 'Algorithm', detail: key.algorithm, chevron: false),
            GroupedRow(title: 'Created', detail: _day(key.created), chevron: false),
            GroupedRow(title: 'Validity', detail: validity, chevron: false),
            if (own != null)
              GroupedRow(title: 'Protection', detail: own.isProtected ? 'Passphrase' : 'Keychain only', chevron: false),
            if (entry != null)
              GroupedRow(
                key: const ValueKey('key-acceptance'),
                title: 'Acceptance',
                detail: acceptanceLabel(entry.acceptance),
                onTap: () => pickAcceptance(context, ref, key, entry.acceptance),
              ),
          ],
        ),
        InsetGroup(
          separatorIndent: 16,
          footer: own == null
              ? null
              : 'Share your public key so others can encrypt to you. The backup is your secret key, protected '
                    'by its passphrase if it has one: keep it private.',
          children: [
            GroupedRow(
              key: const ValueKey('share-public-key'),
              title: 'Share Public Key',
              chevron: false,
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              onTap: () => _sharePublic(context, ref, key),
            ),
            GroupedRow(
              key: const ValueKey('copy-public-key'),
              title: 'Copy Public Key',
              chevron: false,
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              onTap: () async {
                final armored = (await ref.read(openPgpServiceProvider.future)).armoredPublicKey(key.fingerprint);
                if (armored != null && context.mounted) _copy(context, armored, 'Public key copied.');
              },
            ),
            if (own != null)
              GroupedRow(
                key: const ValueKey('backup-secret-key'),
                title: 'Back Up Secret Key',
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
              title: own != null ? 'Delete Key' : 'Remove Key',
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
    final ok = await showActionSheet<bool>(
      context,
      title: 'Back Up Secret Key?',
      message: key.isProtected
          ? 'The backup is protected by your key’s passphrase. Anyone with both can read your mail.'
          : 'This key has no passphrase: anyone with the backup can read your mail and sign as you.',
      actions: const [SheetAction('Back Up', true, isDefault: true)],
    );
    if (ok != true) return;
    final armored = await (await ref.read(openPgpServiceProvider.future)).armoredSecretKey(key.fingerprint);
    if (armored == null) return;
    await ref.read(keyExportProvider)('OpenPGP_0x${key.keyId}_SECRET.asc', armored);
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, PgpKey key, {required bool own}) async {
    final ok = await showActionSheet<bool>(
      context,
      title: own ? 'Delete your key ${key.displayName}?' : 'Remove ${key.displayName}’s key?',
      message: own
          ? 'Mail encrypted to this key can’t be read on this device anymore, unless you import it again.'
          : 'You can import it again later.',
      actions: [SheetAction(own ? 'Delete Key' : 'Remove Key', true, destructive: true)],
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
