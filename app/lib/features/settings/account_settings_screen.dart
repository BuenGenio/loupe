import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../data/oauth.dart';
import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../settings/ui_state.dart';
import '../../shared/bars.dart';
import '../../shared/grouped_list.dart';
import '../../shared/sheets.dart';
import '../../theme/theme.dart';
import '../../theme/loupe_icons.dart';
import '../account_setup/oauth_accounts.dart' show oauthProviderName;
import '../account_setup/sign_in_again.dart';
import '../compose/identity_selection.dart';

String _security(AppLocalizations l10n, ConnectionSecurity s) => switch (s) {
  ConnectionSecurity.tls => 'TLS',
  ConnectionSecurity.startTls => 'STARTTLS',
  ConnectionSecurity.none => l10n.settingsConnectionNotEncrypted,
};

String _server(AppLocalizations l10n, ServerConfig c) =>
    '${c.protocol.name.toUpperCase()} · ${c.host}:${c.port} · ${_security(l10n, c.security)}';

/// One account: name, colour, identities, server details, and Remove.
class AccountSettingsScreen extends ConsumerStatefulWidget {
  const AccountSettingsScreen({super.key, required this.accountId});

  final String accountId;

  @override
  ConsumerState<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends ConsumerState<AccountSettingsScreen> {
  late final MailRepository _repo = ref.read(repositoryProvider);
  final _name = TextEditingController();
  final _nameFocus = FocusNode();
  MailAccount? _account;
  bool _signingIn = false;

  @override
  void initState() {
    super.initState();
    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) unawaited(_save());
    });
  }

  @override
  void dispose() {
    unawaited(_save());
    _name.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  /// Writes the edited name, if it changed.
  Future<void> _save() async {
    final account = _account;
    if (account == null) return;
    final name = _name.text.trim();
    if (name.isEmpty || name == account.displayName) return;
    final next = account.copyWith(displayName: name);
    _account = next;
    await _repo.updateAccount(next);
  }

  Future<void> _signInAgain(MailAccount account) async {
    setState(() => _signingIn = true);
    await signInAgain(context, ref, account);
    if (mounted) setState(() => _signingIn = false);
  }

  Future<void> _remove(MailAccount account) async {
    final l10n = context.l10n;
    final ok = await confirmDestructive(
      context,
      title: l10n.settingsRemoveAccountTitle(account.displayName),
      message: l10n.settingsRemoveAccountMessage,
      action: l10n.settingsRemoveAccount,
    );
    if (!ok || !mounted) return;
    _account = null;
    await _repo.removeAccount(account.id);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final account = (ref.watch(accountsProvider).value ?? const <MailAccount>[])
        .where((a) => a.id == widget.accountId)
        .firstOrNull;
    if (account == null) {
      return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: showsBackButton(context)),
        body: Center(child: Text(l10n.settingsAccountRemoved, style: styles.footnote)),
      );
    }
    if (_account?.id != account.id) _name.text = account.displayName;
    _account = account;
    final needsSignIn = ref.watch(signInRequiredProvider).value?.contains(account.id) ?? false;
    final signInAgainRow = canSignInAgain(ref, account)
        ? GroupedRow(
            key: const Key('account-sign-in-again'),
            title: _signingIn ? l10n.settingsSigningIn : l10n.settingsSignInAgain,
            onTap: _signingIn ? null : () => _signInAgain(account),
          )
        : null;

    return GroupedPage(
      title: account.displayName,
      children: [
        if (needsSignIn)
          InsetGroup(
            key: const Key('account-sign-in-required'),
            header: l10n.settingsSignIn,
            footer: l10n.settingsSignInExpiredFooter(oauthProviderName(account.provider)),
            children: [?signInAgainRow],
          ),
        InsetGroup(
          header: l10n.settingsAccountHeader,
          separatorIndent: 16,
          children: [
            _FieldRow(
              label: l10n.settingsAccountDescription,
              controller: _name,
              focusNode: _nameFocus,
              hint: l10n.settingsAccountDescriptionHint,
            ),
            GroupedRow(title: l10n.settingsEmail, detail: account.email, chevron: false),
          ],
        ),
        InsetGroup(
          header: l10n.settingsColour,
          footer: l10n.settingsColourFooter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Wrap(
                spacing: 14,
                runSpacing: 10,
                children: [
                  for (var i = 0; i < colors.accountColors.length; i++)
                    Semantics(
                      button: true,
                      selected: account.colorIndex == i,
                      label: l10n.settingsColourNumber(i + 1),
                      child: GestureDetector(
                        onTap: () => _repo.updateAccount(account.copyWith(colorIndex: i)),
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: colors.accountColors[i],
                            shape: BoxShape.circle,
                            border: account.colorIndex == i ? Border.all(color: colors.label, width: 2.5) : null,
                          ),
                          child: account.colorIndex == i
                              ? const Icon(LoupeIcons.check, color: Colors.white, size: 20)
                              : null,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        InsetGroup(
          header: l10n.settingsSendingHeader,
          footer: l10n.settingsSendingFooter,
          children: [
            GroupedRow(
              key: const Key('account-identities'),
              title: l10n.settingsIdentities,
              subtitle: [for (final i in IdentitySelection.identitiesOf(account)) i.email].join(', '),
              onTap: () => context.push(Routes.identities(account.id)),
            ),
          ],
        ),
        InsetGroup(
          header: l10n.settingsFoldersHeader,
          separatorIndent: 16,
          footer: l10n.settingsFoldersFooter,
          children: [
            GroupedRow(title: l10n.settingsManageFolders, onTap: () => context.push(Routes.manageFolders(account.id))),
            SwitchRow(
              title: l10n.settingsShowAllFolders,
              value: ref.watch(showAllFoldersProvider).contains(account.id),
              onChanged: (_) => ref.read(showAllFoldersProvider.notifier).toggle(account.id),
            ),
          ],
        ),
        InsetGroup(
          header: l10n.commonServer,
          separatorIndent: 16,
          children: [
            GroupedRow(title: l10n.settingsIncoming, subtitle: _server(l10n, account.incoming), chevron: false),
            if (account.outgoing != null)
              GroupedRow(title: l10n.settingsOutgoing, subtitle: _server(l10n, account.outgoing!), chevron: false),
            GroupedRow(
              title: l10n.settingsSignIn,
              detail: account.authKind == AuthKind.oauth2
                  ? (needsSignIn ? l10n.settingsSignInExpired : oauthProviderName(account.provider))
                  : l10n.commonPassword,
              chevron: false,
            ),
            if (!needsSignIn) ?signInAgainRow,
          ],
        ),
        InsetGroup(
          children: [GroupedRow(title: l10n.settingsRemoveAccount, destructive: true, onTap: () => _remove(account))],
        ),
      ],
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({required this.label, required this.controller, this.focusNode, this.hint});

  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hint;

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
                focusNode: focusNode,
                autocorrect: false,
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
