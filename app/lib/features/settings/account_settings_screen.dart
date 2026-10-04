import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../shared/grouped_list.dart';
import '../../shared/sheets.dart';
import '../../theme/theme.dart';

String _security(ConnectionSecurity s) => switch (s) {
  ConnectionSecurity.tls => 'TLS',
  ConnectionSecurity.startTls => 'STARTTLS',
  ConnectionSecurity.none => 'Not encrypted',
};

String _server(ServerConfig c) => '${c.protocol.name.toUpperCase()} · ${c.host}:${c.port} · ${_security(c.security)}';

/// One account: name, colour, identities and signature, server details, and
/// Remove.
class AccountSettingsScreen extends ConsumerStatefulWidget {
  const AccountSettingsScreen({super.key, required this.accountId});

  final String accountId;

  @override
  ConsumerState<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends ConsumerState<AccountSettingsScreen> {
  late final MailRepository _repo = ref.read(repositoryProvider);
  final _name = TextEditingController();
  final _signature = TextEditingController();
  final _nameFocus = FocusNode();
  final _signatureFocus = FocusNode();
  MailAccount? _account;

  @override
  void initState() {
    super.initState();
    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) unawaited(_save());
    });
    _signatureFocus.addListener(() {
      if (!_signatureFocus.hasFocus) unawaited(_save());
    });
  }

  @override
  void dispose() {
    unawaited(_save());
    _name.dispose();
    _signature.dispose();
    _nameFocus.dispose();
    _signatureFocus.dispose();
    super.dispose();
  }

  /// Writes the edited name and signature, if they changed.
  Future<void> _save() async {
    final account = _account;
    if (account == null) return;
    final name = _name.text.trim();
    final signature = _signature.text.trimRight();
    final identity = account.defaultIdentity;
    final nameChanged = name.isNotEmpty && name != account.displayName;
    final signatureChanged = signature != (identity.signature ?? '');
    if (!nameChanged && !signatureChanged) return;
    final identities = [...account.identities];
    final updated = Identity(
      id: identity.id,
      email: identity.email,
      name: identity.name,
      replyTo: identity.replyTo,
      signature: signature.isEmpty ? null : signature,
    );
    if (identities.isEmpty) {
      identities.add(updated);
    } else {
      identities[0] = updated;
    }
    final next = account.copyWith(displayName: nameChanged ? name : null, identities: identities);
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

  Future<void> _editIdentity(MailAccount account, Identity? identity) async {
    final result = await Navigator.of(context).push<_IdentityEdit>(
      MaterialPageRoute(
        builder: (_) => _IdentityPage(account: account, identity: identity),
      ),
    );
    if (result == null) return;
    final identities = [...account.identities];
    final index = identity == null ? -1 : identities.indexWhere((i) => i.id == identity.id);
    if (result.delete) {
      if (index >= 0) identities.removeAt(index);
    } else if (index >= 0) {
      identities[index] = result.identity!;
    } else {
      identities.add(result.identity!);
    }
    await _repo.updateAccount(account.copyWith(identities: identities));
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
    if (_account?.id != account.id) {
      _name.text = account.displayName;
      _signature.text = account.defaultIdentity.signature ?? '';
    }
    _account = account;

    return GroupedPage(
      title: account.displayName,
      previousPageTitle: 'Settings',
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
                              ? const Icon(CupertinoIcons.checkmark_alt, color: Colors.white, size: 20)
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
          header: 'Identities',
          footer: 'The addresses you can send from. The first one is the default.',
          separatorIndent: 16,
          children: [
            for (final identity in account.identities)
              GroupedRow(
                title: identity.name?.isNotEmpty ?? false ? identity.name! : identity.email,
                subtitle: identity.email,
                onTap: () => _editIdentity(account, identity),
              ),
            GroupedRow(
              title: 'Add Identity',
              titleStyle: styles.body.copyWith(color: colors.unreadDot),
              chevron: false,
              onTap: () => _editIdentity(account, null),
            ),
          ],
        ),
        InsetGroup(
          header: 'Signature',
          footer: 'Added below “-- ” in messages from ${account.defaultIdentity.email}.',
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextField(
                controller: _signature,
                focusNode: _signatureFocus,
                minLines: 3,
                maxLines: 8,
                style: styles.body,
                decoration: const InputDecoration.collapsed(hintText: 'No signature'),
              ),
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
  const _FieldRow({required this.label, required this.controller, this.focusNode, this.hint, this.keyboardType});

  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hint;
  final TextInputType? keyboardType;

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
                keyboardType: keyboardType,
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

class _IdentityEdit {
  const _IdentityEdit.save(Identity this.identity) : delete = false;
  const _IdentityEdit.delete() : identity = null, delete = true;

  final Identity? identity;
  final bool delete;
}

class _IdentityPage extends StatefulWidget {
  const _IdentityPage({required this.account, this.identity});

  final MailAccount account;
  final Identity? identity;

  @override
  State<_IdentityPage> createState() => _IdentityPageState();
}

class _IdentityPageState extends State<_IdentityPage> {
  late final _name = TextEditingController(text: widget.identity?.name ?? '');
  late final _email = TextEditingController(text: widget.identity?.email ?? '');
  late final _replyTo = TextEditingController(text: widget.identity?.replyTo ?? '');
  late final _signature = TextEditingController(text: widget.identity?.signature ?? '');

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _replyTo.dispose();
    _signature.dispose();
    super.dispose();
  }

  void _done() {
    final email = _email.text.trim();
    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter an email address.')));
      return;
    }
    String? opt(TextEditingController c) => c.text.trim().isEmpty ? null : c.text.trim();
    Navigator.of(context).pop(
      _IdentityEdit.save(
        Identity(
          id: widget.identity?.id ?? '${widget.account.id}/${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}',
          email: email,
          name: opt(_name),
          replyTo: opt(_replyTo),
          signature: _signature.text.trimRight().isEmpty ? null : _signature.text.trimRight(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    final canDelete = widget.identity != null && widget.account.identities.length > 1;
    return GroupedPage(
      title: widget.identity == null ? 'New Identity' : 'Identity',
      previousPageTitle: widget.account.displayName,
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: _done,
        child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      children: [
        InsetGroup(
          separatorIndent: 16,
          children: [
            _FieldRow(label: 'Name', controller: _name, hint: 'Your name'),
            _FieldRow(
              label: 'Email',
              controller: _email,
              hint: 'name@example.com',
              keyboardType: TextInputType.emailAddress,
            ),
            _FieldRow(
              label: 'Reply-To',
              controller: _replyTo,
              hint: 'Optional',
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        InsetGroup(
          header: 'Signature',
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextField(
                controller: _signature,
                minLines: 3,
                maxLines: 8,
                style: styles.body,
                decoration: const InputDecoration.collapsed(hintText: 'No signature'),
              ),
            ),
          ],
        ),
        if (canDelete)
          InsetGroup(
            children: [
              GroupedRow(
                title: 'Delete Identity',
                destructive: true,
                onTap: () => Navigator.of(context).pop(const _IdentityEdit.delete()),
              ),
            ],
          ),
      ],
    );
  }
}
