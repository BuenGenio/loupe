import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../router.dart';
import '../../settings/ui_state.dart';
import '../../shared/grouped_list.dart';
import '../../shared/sheets.dart';
import '../../theme/theme.dart';
import '../../theme/loupe_icons.dart';
import '../compose/identity_selection.dart';

String _security(ConnectionSecurity s) => switch (s) {
  ConnectionSecurity.tls => 'TLS',
  ConnectionSecurity.startTls => 'STARTTLS',
  ConnectionSecurity.none => 'Not encrypted',
};

String _server(ServerConfig c) => '${c.protocol.name.toUpperCase()} · ${c.host}:${c.port} · ${_security(c.security)}';

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

  Future<void> _remove(MailAccount account) async {
    final ok = await confirmDestructive(
      context,
      title: 'Remove “${account.displayName}”?',
      message: 'Its mail and settings are removed from this phone. Nothing is deleted on the server.',
      action: 'Remove Account',
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
    final account = (ref.watch(accountsProvider).value ?? const <MailAccount>[])
        .where((a) => a.id == widget.accountId)
        .firstOrNull;
    if (account == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('This account was removed.', style: styles.footnote)),
      );
    }
    if (_account?.id != account.id) _name.text = account.displayName;
    _account = account;

    return GroupedPage(
      title: account.displayName,
      children: [
        InsetGroup(
          header: 'Account',
          separatorIndent: 16,
          children: [
            _FieldRow(label: 'Description', controller: _name, focusNode: _nameFocus, hint: 'Work, Personal…'),
            GroupedRow(title: 'Email', detail: account.email, chevron: false),
          ],
        ),
        InsetGroup(
          header: 'Colour',
          footer: 'Marks this account’s messages in All Inboxes.',
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
                      label: 'Colour ${i + 1}',
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
          header: 'Sending',
          footer: 'Each identity has its own signature. Replies go out from the address a message was sent to.',
          children: [
            GroupedRow(
              key: const Key('account-identities'),
              title: 'Identities',
              subtitle: [for (final i in IdentitySelection.identitiesOf(account)) i.email].join(', '),
              onTap: () => context.push(Routes.identities(account.id)),
            ),
          ],
        ),
        InsetGroup(
          header: 'Folders',
          separatorIndent: 16,
          footer:
              'Loupe shows and syncs the folders you subscribe to, as Thunderbird does. '
              'Inbox, Drafts, Sent, Junk, Trash and Archive always show.',
          children: [
            GroupedRow(title: 'Manage Folders', onTap: () => context.push(Routes.manageFolders(account.id))),
            SwitchRow(
              title: 'Show All Folders',
              value: ref.watch(showAllFoldersProvider).contains(account.id),
              onChanged: (_) => ref.read(showAllFoldersProvider.notifier).toggle(account.id),
            ),
          ],
        ),
        InsetGroup(
          header: 'Server',
          separatorIndent: 16,
          children: [
            GroupedRow(title: 'Incoming', subtitle: _server(account.incoming), chevron: false),
            if (account.outgoing != null)
              GroupedRow(title: 'Outgoing', subtitle: _server(account.outgoing!), chevron: false),
            GroupedRow(
              title: 'Sign-in',
              detail: account.authKind == AuthKind.oauth2 ? 'OAuth' : 'Password',
              chevron: false,
            ),
          ],
        ),
        InsetGroup(
          children: [GroupedRow(title: 'Remove Account', destructive: true, onTap: () => _remove(account))],
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
