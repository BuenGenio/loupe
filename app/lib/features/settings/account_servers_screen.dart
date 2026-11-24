import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../shared/bars.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../account_setup/account_setup_screen.dart' show setupFailureMessage;
import '../account_setup/server_settings.dart';
import '../account_setup/setup_text.dart';
import '../conversation/sheets.dart';

/// An account's password and servers: host, port, security and username of
/// the incoming and outgoing server. Save connects with them first, as
/// account setup does, and keeps the old ones if that fails. The protocol
/// (IMAP or JMAP) stays.
class AccountServersScreen extends ConsumerStatefulWidget {
  const AccountServersScreen({super.key, required this.accountId});

  final String accountId;

  @override
  ConsumerState<AccountServersScreen> createState() => _AccountServersScreenState();
}

class _AccountServersScreenState extends ConsumerState<AccountServersScreen> {
  late final MailRepository _repo = ref.read(repositoryProvider);
  final _password = TextEditingController();

  /// The account as it was when the screen opened.
  MailAccount? _account;
  ServerSettingsController? _incoming;
  ServerSettingsController? _outgoing;
  bool _obscure = true;
  bool _busy = false;
  String? _error;

  /// A certificate fingerprint from a certificate error, offered for trust.
  String? _fingerprint;

  @override
  void dispose() {
    _password.dispose();
    _incoming?.dispose();
    _outgoing?.dispose();
    super.dispose();
  }

  void _load(MailAccount account) {
    _account = account;
    _incoming = ServerSettingsController(account.incoming);
    if (account.incoming.protocol != ServerProtocol.jmap) {
      final domain = account.email.substring(account.email.lastIndexOf('@') + 1);
      _outgoing = ServerSettingsController(
        account.outgoing ?? ServerConfig(protocol: ServerProtocol.smtp, host: 'smtp.$domain', port: 465),
      );
    }
  }

  static bool _same(ServerConfig? a, ServerConfig? b) => jsonEncode(a?.toJson()) == jsonEncode(b?.toJson());

  Future<void> _save() async {
    final account = _account!;
    final incoming = _incoming!.config;
    final outgoing = _outgoing?.config;
    if (incoming == null || (_outgoing != null && outgoing == null)) {
      setState(() {
        _error = context.l10n.accountSetupCheckServers;
        _fingerprint = null;
      });
      return;
    }
    final password = _password.text;
    if (password.isEmpty && _same(incoming, account.incoming) && _same(outgoing, account.outgoing)) {
      context.pop();
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _error = null;
      _fingerprint = null;
    });
    try {
      await _repo.changeServers(
        account.id,
        incoming: incoming,
        outgoing: outgoing,
        credentials: password.isEmpty ? null : PasswordCredentials(password),
      );
      if (mounted) context.pop();
    } on MailException catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = describeSetupError(context.l10n, e, account.provider, protocol: incoming.protocol);
        _fingerprint = e.kind == MailErrorKind.certificate ? fingerprintIn(e.message) : null;
      });
    } on Object catch (e) {
      debugPrint('Changing servers failed: ${e.runtimeType}');
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = setupFailureMessage(context.l10n, e);
      });
    }
  }

  /// Pins the offered certificate on the servers it belongs to and saves again.
  Future<void> _trustCertificate() async {
    final fp = _fingerprint;
    if (fp == null) return;
    trustCertificateOn([_incoming!, ?_outgoing], fp, _error ?? '');
    await _save();
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    if (_account == null) {
      final account = (ref.watch(accountsProvider).value ?? const <MailAccount>[])
          .where((a) => a.id == widget.accountId)
          .firstOrNull;
      if (account == null) {
        return Scaffold(
          appBar: AppBar(automaticallyImplyLeading: showsBackButton(context)),
          body: Center(child: Text(l10n.settingsAccountRemoved, style: LoupeTextStyles.of(context).footnote)),
        );
      }
      _load(account);
    }
    final account = _account!;
    final incoming = _incoming!;
    final outgoing = _outgoing;
    return Scaffold(
      backgroundColor: colors.groupedBackground,
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          LoupeTitleBar(
            title: l10n.accountSetupServerSettings,
            leading: BarTextButton(label: l10n.commonCancel, onPressed: () => Navigator.of(context).maybePop()),
            trailing: [
              _busy
                  ? const Padding(padding: EdgeInsets.all(12), child: CupertinoActivityIndicator())
                  : BarTextButton(key: const Key('servers-save'), label: l10n.commonSave, bold: true, onPressed: _save),
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverSafeArea(
            top: false,
            sliver: SliverList.list(
              children: [
                if (account.authKind == AuthKind.password)
                  SheetGroup(
                    children: [
                      FormRow(
                        label: secretLabel(l10n, secretKind(account.provider, protocol: incoming.protocol)),
                        child: TextField(
                          key: const Key('servers-password'),
                          controller: _password,
                          obscureText: _obscure,
                          enabled: !_busy,
                          autocorrect: false,
                          enableSuggestions: false,
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _save(),
                          decoration: InputDecoration.collapsed(hintText: l10n.settingsPasswordUnchanged).copyWith(
                            suffixIcon: IconButton(
                              tooltip: _obscure ? l10n.accountSetupShowPassword : l10n.accountSetupHidePassword,
                              icon: Icon(_obscure ? LoupeIcons.showPassword : LoupeIcons.hidePassword, size: 20),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                            suffixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 40),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (_error case final error?)
                  ConnectionErrorNote(
                    error: error,
                    fingerprint: _fingerprint,
                    onTrust: _busy ? null : _trustCertificate,
                  ),
                ServerSettingsForm(
                  title: l10n.accountSetupIncoming(incoming.protocol.name.toUpperCase()),
                  controller: incoming,
                  enabled: !_busy,
                ),
                if (outgoing != null)
                  ServerSettingsForm(title: l10n.accountSetupOutgoing, controller: outgoing, enabled: !_busy),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
