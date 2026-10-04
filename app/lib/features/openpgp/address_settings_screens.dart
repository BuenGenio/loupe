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
import 'openpgp_providers.dart';

/// The OpenPGP settings of one sending address: its key, and when mail
/// from it is encrypted and signed (Thunderbird's per-identity settings).
class AddressEncryptionScreen extends ConsumerWidget {
  const AddressEncryptionScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(keyringStateProvider).value;
    if (state == null) return GroupedPage(title: email, children: const [SizedBox(height: 200)]);
    final settings = state.identity(email);
    final key = state.ownKeyFor(email);
    final colors = LoupeColors.of(context);
    Future<void> update(IdentityPgp next) async => (await ref.read(keyringProvider.future)).setIdentity(email, next);
    final choices = [
      for (final k in state.ownKeys)
        if (k.hasEmail(email) || k.fingerprint == settings.keyFingerprint) k,
      for (final k in state.ownKeys)
        if (!k.hasEmail(email) && k.fingerprint != settings.keyFingerprint) k,
    ];
    return GroupedPage(
      title: email,
      children: [
        InsetGroup(
          header: 'Key',
          separatorIndent: 16,
          footer: key == null ? 'Add a key in End-to-End Encryption to encrypt and sign mail from this address.' : null,
          children: [
            for (final k in choices)
              GroupedRow(
                key: ValueKey('use-${k.fingerprint}'),
                title: k.displayName,
                subtitle: '${k.emails.join(', ')} · ${formatFingerprint(k.keyId)}',
                chevron: false,
                trailing: key?.fingerprint == k.fingerprint
                    ? Icon(LoupeIcons.check, color: colors.unreadDot, size: 22)
                    : const SizedBox(width: 22),
                onTap: () => update(settings.copyWith(keyFingerprint: k.fingerprint)),
              ),
            GroupedRow(
              key: const ValueKey('generate-for-address'),
              title: 'Generate a Key…',
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              chevron: false,
              onTap: () => context.push(Routes.generateKey, extra: email),
            ),
          ],
        ),
        if (key != null) ...[
          InsetGroup(
            header: 'Sending',
            separatorIndent: 16,
            footer:
                'Automatic encryption turns on when every recipient has an accepted key, or when Autocrypt '
                'says both sides want it. Encrypted mail is always signed.',
            children: [
              SwitchRow(
                title: 'Encrypt Automatically',
                value: settings.autoEncrypt,
                onChanged: (v) => update(settings.copyWith(autoEncrypt: v)),
              ),
              SwitchRow(
                title: 'Always Encrypt',
                subtitle: 'Refuses to send when a recipient has no key',
                value: settings.encryptByDefault,
                onChanged: (v) => update(settings.copyWith(encryptByDefault: v)),
              ),
              SwitchRow(
                title: 'Sign Unencrypted Mail',
                value: settings.signByDefault,
                onChanged: (v) => update(settings.copyWith(signByDefault: v)),
              ),
              SwitchRow(
                title: 'Attach My Public Key',
                value: settings.attachPublicKey,
                onChanged: (v) => update(settings.copyWith(attachPublicKey: v)),
              ),
            ],
          ),
          InsetGroup(
            header: 'Autocrypt',
            separatorIndent: 16,
            footer:
                'Autocrypt sends your public key along with every message, so other apps can encrypt to you '
                'without any setup.',
            children: [
              SwitchRow(
                title: 'Send My Key with Mail',
                value: settings.autocrypt,
                onChanged: (v) => update(settings.copyWith(autocrypt: v)),
              ),
              SwitchRow(
                title: 'Prefer Encryption',
                subtitle: 'Ask others to encrypt when they can',
                value: settings.preferEncrypt,
                onChanged: (v) => update(settings.copyWith(preferEncrypt: v)),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

/// How long a new key is valid.
enum KeyValidity {
  oneYear('1 year', Duration(days: 365)),
  twoYears('2 years', Duration(days: 730)),
  threeYears('3 years', Duration(days: 1095)),
  never('Never expires', null);

  const KeyValidity(this.label, this.duration);
  final String label;
  final Duration? duration;
}

/// "Generate New Key": a Curve25519 key (Ed25519 + X25519, as Thunderbird
/// makes them) for one address, valid three years by default, with an
/// optional passphrase.
class GenerateKeyScreen extends ConsumerStatefulWidget {
  const GenerateKeyScreen({super.key, this.email});

  /// The address to make it for; the first address when null.
  final String? email;

  @override
  ConsumerState<GenerateKeyScreen> createState() => _GenerateKeyScreenState();
}

class _GenerateKeyScreenState extends ConsumerState<GenerateKeyScreen> {
  final _name = TextEditingController();
  final _passphrase = TextEditingController();
  final _repeat = TextEditingController();
  String? _email;
  var _validity = KeyValidity.threeYears;
  var _busy = false;

  @override
  void dispose() {
    for (final c in [_name, _passphrase, _repeat]) {
      c.dispose();
    }
    super.dispose();
  }

  List<Identity> get _identities => [
    for (final a in ref.read(accountsProvider).value ?? const <MailAccount>[]) ...IdentitySelection.identitiesOf(a),
  ];

  Future<void> _generate() async {
    final email = _email;
    final messenger = ScaffoldMessenger.of(context);
    if (email == null) return;
    if (_passphrase.text != _repeat.text) {
      showSnack(messenger, 'The passphrases don’t match.');
      return;
    }
    setState(() => _busy = true);
    try {
      final service = await ref.read(openPgpServiceProvider.future);
      final key = await service.generateKey(
        name: _name.text,
        email: email,
        passphrase: _passphrase.text,
        validity: _validity.duration,
      );
      if (!mounted) return;
      context.pop();
      showSnack(messenger, 'Your key ${formatFingerprint(key.keyId)} is ready.');
    } on PgpException catch (e) {
      if (mounted) setState(() => _busy = false);
      showSnack(messenger, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final identities = _identities;
    _email ??= widget.email ?? identities.firstOrNull?.email;
    if (_name.text.isEmpty) {
      final match = identities.where((i) => i.email == _email).firstOrNull;
      _name.text = match?.name ?? '';
    }
    final colors = LoupeColors.of(context);
    return GroupedPage(
      title: 'New Key',
      children: [
        InsetGroup(
          header: 'For',
          separatorIndent: 16,
          children: [
            _Field(label: 'Name', controller: _name, hint: 'Your name'),
            GroupedRow(
              key: const ValueKey('generate-email'),
              title: 'Address',
              detail: _email ?? 'None',
              onTap: identities.length < 2 ? null : () => _pickEmail(identities),
            ),
          ],
        ),
        InsetGroup(
          header: 'Passphrase',
          separatorIndent: 16,
          footer:
              'Optional. Without one, your phone’s keychain alone protects the key and Loupe never asks. '
              'With one, Loupe asks for it when the key is needed.',
          children: [
            _Field(label: 'Passphrase', controller: _passphrase, secret: true, key: const ValueKey('generate-pass')),
            _Field(label: 'Repeat', controller: _repeat, secret: true, key: const ValueKey('generate-repeat')),
          ],
        ),
        InsetGroup(
          header: 'Expires',
          separatorIndent: 16,
          footer: 'You can make a new key before it expires. Thunderbird uses three years too.',
          children: [
            for (final v in KeyValidity.values)
              GroupedRow(
                title: v.label,
                chevron: false,
                trailing: v == _validity
                    ? Icon(LoupeIcons.check, color: colors.unreadDot, size: 22)
                    : const SizedBox(width: 22),
                onTap: () => setState(() => _validity = v),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FilledButton(
            key: const ValueKey('generate-key'),
            onPressed: _busy || _email == null ? null : _generate,
            child: _busy
                ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Generate Key'),
          ),
        ),
      ],
    );
  }

  Future<void> _pickEmail(List<Identity> identities) async {
    final emails = {for (final i in identities) i.email};
    final picked = await showActionSheet<String>(
      context,
      title: 'Key for',
      actions: [for (final e in emails) SheetAction(e, e, isDefault: e == _email)],
    );
    if (picked != null) setState(() => _email = picked);
  }
}

class _Field extends StatelessWidget {
  const _Field({super.key, required this.label, required this.controller, this.hint, this.secret = false});

  final String label;
  final TextEditingController controller;
  final String? hint;
  final bool secret;

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: LoupeMetrics.of(context).groupedRowHeight),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SizedBox(width: 110, child: Text(label, style: styles.body)),
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: secret,
                autocorrect: false,
                enableSuggestions: !secret,
                textCapitalization: secret ? TextCapitalization.none : TextCapitalization.words,
                style: styles.body,
                textAlign: TextAlign.end,
                decoration: InputDecoration.collapsed(hintText: hint),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
