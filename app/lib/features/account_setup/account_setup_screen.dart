import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart' show MailStoreException;
import 'package:url_launcher/url_launcher.dart';

import '../../data/live.dart' show DatabaseKeyUnavailable;
import '../../data/oauth.dart';
import '../../data/repositories.dart';
import '../../l10n/l10n.dart';
import '../../settings/app_mode.dart';
import '../../router.dart';
import '../../shared/bars.dart';
import '../../theme/theme.dart';
import '../compose/compose_text.dart';
import '../conversation/mail_streams.dart';
import '../conversation/sheets.dart';
import 'oauth_accounts.dart';
import 'server_settings.dart';
import 'setup_text.dart';
import '../../theme/loupe_icons.dart';

export 'setup_text.dart' show fingerprintIn;

enum _Step { address, signIn, done }

/// Adds an account: email and name, then provider-specific sign-in with the
/// discovered (or manual) server settings, then a name and colour.
///
/// Gmail and Microsoft addresses sign in with Google or Microsoft in the
/// browser when this build has their client ids; Gmail can still use an
/// app password instead.
///
/// Works with any [MailRepository]: it only uses discover, addAccount and
/// updateAccount.
class AccountSetupScreen extends ConsumerStatefulWidget {
  const AccountSetupScreen({super.key});

  @override
  ConsumerState<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends ConsumerState<AccountSetupScreen> {
  _Step _step = _Step.address;
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _description = TextEditingController();

  AccountDiscovery? _discovery;
  ServerSettingsController? _incoming;
  ServerSettingsController? _outgoing;

  /// The incoming settings of the other protocol (IMAP or JMAP), kept while
  /// the user switches between them.
  ServerSettingsController? _otherIncoming;
  bool _showSettings = false;
  bool _editSettings = false;
  bool _appPassword = false;
  bool _obscure = true;

  bool _busy = false;

  /// What the primary button says while [_busy]; "Connecting…" if null.
  String? _busyLabel;
  String? _error;

  /// A certificate fingerprint from a certificate error, offered for trust.
  String? _fingerprint;

  MailAccount? _account;
  int _colorIndex = 0;

  /// The demo mailbox in demo mode, the real repository otherwise.
  Future<MailRepository> get _repo => ref.read(setupRepositoryProvider.future);

  @override
  void dispose() {
    for (final c in [_name, _email, _password, _description]) {
      c.dispose();
    }
    _incoming?.dispose();
    _outgoing?.dispose();
    _otherIncoming?.dispose();
    super.dispose();
  }

  ProviderKind get _provider => _discovery?.provider ?? ProviderKind.generic;

  String get _domain {
    final e = _email.text.trim();
    return e.contains('@') ? e.substring(e.lastIndexOf('@') + 1).toLowerCase() : '';
  }

  /// "Gmail", "iCloud", … or the domain's first label ("Example").
  String get _defaultDescription => defaultAccountDescription(_provider, _email.text);

  // Step 1: discovery -------------------------------------------------------------

  Future<void> _discover() async {
    final email = _email.text.trim();
    if (!ComposeText.isValidEmail(email)) {
      setState(() => _error = context.l10n.accountSetupInvalidEmail);
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });
    AccountDiscovery discovery;
    String? note;
    try {
      discovery = await (await _repo).discover(email);
    } on MailException catch (e) {
      discovery = AccountDiscovery(email: email, provider: ProviderKind.generic, authKind: AuthKind.password);
      note = e.message;
    } on Object catch (e) {
      // The mail database couldn't be opened, or something unexpected:
      // say so instead of spinning forever.
      if (mounted) _failed(e);
      return;
    }
    if (!mounted) return;
    _incoming?.dispose();
    _outgoing?.dispose();
    _otherIncoming?.dispose();
    _otherIncoming = null;
    final domain = _domain;
    _incoming = ServerSettingsController(
      discovery.incoming ?? ServerConfig(protocol: ServerProtocol.imap, host: 'imap.$domain', port: 993),
    );
    _outgoing = ServerSettingsController(
      discovery.outgoing ?? ServerConfig(protocol: ServerProtocol.smtp, host: 'smtp.$domain', port: 465),
    );
    setState(() {
      _discovery = discovery;
      _busy = false;
      _step = _Step.signIn;
      _editSettings = discovery.incoming == null;
      _showSettings = _editSettings;
      _appPassword = false;
      _fingerprint = null;
      _error = note == null && discovery.incoming == null ? context.l10n.accountSetupSettingsNotFoundFor(domain) : note;
    });
  }

  // Step 2: sign in -----------------------------------------------------------------

  bool get _needsOAuth => _provider == ProviderKind.microsoft || (_provider == ProviderKind.gmail && !_appPassword);

  /// Whether this build can sign in with the provider's OAuth.
  bool get _oauthAvailable => ref.read(oauthSignInProvider).isConfigured(_provider);

  Future<void> _signIn() async {
    final incoming = _incoming?.config;
    final outgoing = _outgoing?.config;
    if (incoming == null || (incoming.protocol != ServerProtocol.jmap && outgoing == null)) {
      setState(() {
        _editSettings = _showSettings = true;
        _error = context.l10n.accountSetupCheckServers;
      });
      return;
    }
    if (_password.text.isEmpty) {
      setState(() => _error = context.l10n.accountSetupEnterPassword);
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _busyLabel = null;
      _error = null;
      _fingerprint = null;
    });
    final name = _name.text.trim();
    try {
      final account = await (await _repo).addAccount(
        AccountSetup(
          email: _email.text.trim(),
          displayName: _defaultDescription,
          provider: _provider,
          incoming: incoming,
          outgoing: incoming.protocol == ServerProtocol.jmap ? null : outgoing,
          credentials: PasswordCredentials(_password.text),
          senderName: name.isEmpty ? null : name,
        ),
      );
      if (mounted) _added(account);
    } on MailException catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = _describe(e);
        _fingerprint = e.kind == MailErrorKind.certificate ? fingerprintIn(e.message) : null;
        if (e.kind == MailErrorKind.connection) _showSettings = true;
      });
    } on Object catch (e) {
      if (mounted) _failed(e);
    }
  }

  /// An error that isn't the server's: the busy state ends with a message.
  void _failed(Object e) {
    debugPrint('Account setup failed: ${e.runtimeType}');
    setState(() {
      _busy = false;
      _error = setupFailureMessage(context.l10n, e);
    });
  }

  String _describe(MailException e) => describeSetupError(context.l10n, e, _provider, protocol: _protocol);

  ServerProtocol get _protocol => _incoming?.protocol ?? ServerProtocol.imap;

  /// Switches the incoming server between IMAP and JMAP (manual settings).
  /// JMAP starts on the IMAP server's host: Stalwart and Cyrus serve both.
  void _switchProtocol(ServerProtocol protocol) {
    final current = _incoming;
    if (current == null || current.protocol == protocol) return;
    final other = _otherIncoming;
    final host = current.host.text.trim();
    final next = other != null && other.protocol == protocol
        ? other
        : ServerSettingsController(
            protocol == ServerProtocol.jmap
                ? ServerConfig(
                    protocol: ServerProtocol.jmap,
                    host: host.isEmpty ? 'mail.$_domain' : host,
                    port: 443,
                    username: current.config?.username,
                  )
                : ServerConfig(protocol: ServerProtocol.imap, host: 'imap.$_domain', port: 993),
          );
    setState(() {
      _otherIncoming = current;
      _incoming = next;
      _error = null;
    });
  }

  /// Signs in with Google or Microsoft in the browser, then adds the account
  /// with the provider's servers.
  Future<void> _signInWithOAuth() async {
    final provider = _provider;
    final email = _email.text.trim();
    final name = _name.text.trim();
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _busyLabel = context.l10n.accountSetupWaitingFor(oauthProviderName(provider));
      _error = null;
      _fingerprint = null;
    });
    try {
      final credentials = await ref.read(oauthSignInProvider).signIn(provider, loginHint: email);
      if (!mounted) return;
      setState(() => _busyLabel = null);
      final servers = oauthServers(provider);
      final account = await (await _repo).addAccount(
        AccountSetup(
          email: email,
          displayName: _defaultDescription,
          provider: provider,
          incoming: servers.incoming,
          outgoing: servers.outgoing,
          credentials: credentials,
          senderName: name.isEmpty ? null : name,
        ),
      );
      if (mounted) _added(account);
    } on MailException catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = describeOAuthError(context.l10n, e, provider);
      });
    } on Object catch (e) {
      if (mounted) _failed(e);
    }
  }

  void _added(MailAccount account) {
    final others = (ref.read(accountsStreamProvider).value ?? const <MailAccount>[]).where((a) => a.id != account.id);
    setState(() {
      _account = account;
      _busy = false;
      _step = _Step.done;
      _description.text = _defaultDescription;
      _colorIndex = others.length % LoupeColors.of(context).accountColors.length;
    });
  }

  /// Pins the offered certificate on the servers it belongs to and retries.
  Future<void> _trustCertificate() async {
    final fp = _fingerprint;
    if (fp == null) return;
    final message = _error ?? '';
    final servers = [_incoming!, if (_protocol != ServerProtocol.jmap) _outgoing!];
    final named = servers.where((s) => s.host.text.trim().isNotEmpty && message.contains(s.host.text.trim()));
    for (final s in named.isEmpty ? servers : named) {
      s.trustedCertificate = fp;
    }
    await _signIn();
  }

  Future<void> _open(String url) async {
    final messenger = ScaffoldMessenger.of(context);
    final failed = context.l10n.accountSetupCouldNotOpenPage;
    try {
      if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView)) {
        showSnack(messenger, failed);
      }
    } on Exception {
      showSnack(messenger, failed);
    }
  }

  // Step 3: name and colour ---------------------------------------------------------

  Future<void> _finish() async {
    final account = _account!;
    final description = _description.text.trim();
    final l10n = context.l10n;
    setState(() => _busy = true);
    try {
      await (await _repo).updateAccount(
        account.copyWith(displayName: description.isEmpty ? account.displayName : description, colorIndex: _colorIndex),
      );
    } on Object catch (e) {
      // The account is added; only its name or colour didn't stick.
      if (mounted) {
        showSnack(ScaffoldMessenger.of(context), e is MailException ? e.message : l10n.accountSetupCouldNotSaveName);
      }
    }
    // The first real account switches the app from the welcome screen to live mode.
    if (ref.read(appModeProvider) == AppMode.none) await ref.read(appModeProvider.notifier).set(AppMode.live);
    if (mounted) context.go(Routes.mailboxes);
  }

  // Build ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    // Keeps the account list alive for the default colour of the new account.
    ref.watch(accountsStreamProvider);
    return PopScope(
      canPop: _step != _Step.signIn || _busy,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _step == _Step.signIn) setState(() => _step = _Step.address);
      },
      child: Scaffold(
        backgroundColor: colors.groupedBackground,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: KeyedSubtree(
            key: ValueKey(_step),
            child: switch (_step) {
              _Step.address => _addressStep(context),
              _Step.signIn => _signInStep(context),
              _Step.done => _doneStep(context),
            },
          ),
        ),
      ),
    );
  }

  /// One step: the title on the top line, then [children].
  Widget _page(BuildContext context, {required List<Widget> children}) => CustomScrollView(
    slivers: [
      LoupeTitleBar(
        title: _step == _Step.done ? context.l10n.accountSetupTitleDone : context.l10n.accountSetupTitle,
        automaticallyImplyLeading: _step != _Step.done,
      ),
      SliverSafeArea(top: false, sliver: SliverList.list(children: children)),
    ],
  );

  Widget _title(BuildContext context, String title, String subtitle) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 8, 32, 24),
      child: Column(
        children: [
          Icon(LoupeIcons.emailAddress, size: 48, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: LoupeColors.of(context).secondaryText, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _errorNote() => _error == null
      ? const SizedBox.shrink()
      : NoteCard(
          key: const Key('setup-error'),
          icon: LoupeIcons.error,
          color: CupertinoColors.systemRed.resolveFrom(context),
          actions: [
            if (_fingerprint != null)
              TextButton(
                key: const Key('trust-certificate'),
                onPressed: _busy ? null : _trustCertificate,
                child: Text(context.l10n.accountSetupTrustCertificate),
              ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_error!),
              if (_fingerprint != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: SelectableText(
                    'SHA-256 $_fingerprint',
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
            ],
          ),
        );

  Widget _primaryButton({required Key key, required String label, required String busyLabel, VoidCallback? onTap}) =>
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: FilledButton(
          key: key,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: _busy ? null : onTap,
          child: _busy
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                    const SizedBox(width: 10),
                    Text(busyLabel),
                  ],
                )
              : Text(label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        ),
      );

  Widget _addressStep(BuildContext context) {
    final l10n = context.l10n;
    return _page(
      context,
      children: [
        _title(context, l10n.accountSetupAddressTitle, l10n.accountSetupAddressText),
        SheetGroup(
          children: [
            FormRow(
              label: l10n.commonName,
              child: TextField(
                key: const Key('setup-name'),
                controller: _name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                decoration: InputDecoration.collapsed(hintText: l10n.accountSetupNameHint),
              ),
            ),
            FormRow(
              label: l10n.accountSetupEmail,
              child: TextField(
                key: const Key('setup-email'),
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                textInputAction: TextInputAction.go,
                autofillHints: const [AutofillHints.email],
                onSubmitted: (_) => _discover(),
                decoration: InputDecoration.collapsed(hintText: l10n.accountSetupEmailHint),
              ),
            ),
          ],
        ),
        _errorNote(),
        _primaryButton(
          key: const Key('setup-continue'),
          label: l10n.accountSetupContinue,
          busyLabel: l10n.accountSetupLookingUp,
          onTap: _discover,
        ),
        Center(
          child: TextButton.icon(
            key: const Key('setup-import-thunderbird'),
            onPressed: _busy ? null : () => context.push(Routes.importAccounts),
            icon: const Icon(LoupeIcons.qrCode, size: 20),
            label: Text(l10n.accountSetupImport),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _signInStep(BuildContext context) {
    final l10n = context.l10n;
    final busyLabel = _busyLabel ?? l10n.accountSetupConnecting;
    final discovery = _discovery!;
    final email = _email.text.trim();
    final title = switch (_provider) {
      ProviderKind.generic => _domain,
      _ => _defaultDescription,
    };
    return _page(
      context,
      children: [
        _title(context, title, email),
        ..._providerNotes(context),
        // Gmail's, Microsoft's and Fastmail's notes above say it better than discovery's.
        if (discovery.notes case final notes?
            when notes.trim().isNotEmpty &&
                _provider != ProviderKind.gmail &&
                _provider != ProviderKind.microsoft &&
                _provider != ProviderKind.fastmail)
          NoteCard(icon: LoupeIcons.info, child: Text(notes)),
        if (!_needsOAuth)
          SheetGroup(
            children: [
              FormRow(
                label: secretLabel(l10n, secretKind(_provider, protocol: _protocol)),
                child: TextField(
                  key: const Key('setup-password'),
                  controller: _password,
                  obscureText: _obscure,
                  enabled: !_busy,
                  autocorrect: false,
                  enableSuggestions: false,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.go,
                  onSubmitted: (_) => _signIn(),
                  decoration: InputDecoration.collapsed(hintText: l10n.accountSetupPasswordRequired).copyWith(
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
        _errorNote(),
        if (!_needsOAuth) ...[
          _settingsSummary(context, discovery),
          if (_editSettings) ...[
            ServerSettingsForm(
              key: ValueKey('incoming-${_incoming!.protocol.name}'),
              title: l10n.accountSetupIncoming(_incoming!.protocol.name.toUpperCase()),
              controller: _incoming!,
              enabled: !_busy,
              onProtocol: _switchProtocol,
            ),
            if (_incoming!.protocol != ServerProtocol.jmap)
              ServerSettingsForm(title: l10n.accountSetupOutgoing, controller: _outgoing!, enabled: !_busy),
          ],
          _primaryButton(
            key: const Key('setup-sign-in'),
            label: l10n.accountSetupSignIn,
            busyLabel: busyLabel,
            onTap: _signIn,
          ),
        ] else if (_oauthAvailable) ...[
          _primaryButton(
            key: const Key('setup-oauth'),
            label: oauthButtonLabel(l10n, _provider),
            busyLabel: busyLabel,
            onTap: _signInWithOAuth,
          ),
          if (_provider == ProviderKind.gmail)
            Center(
              child: TextButton(
                key: const Key('use-app-password'),
                onPressed: _busy
                    ? null
                    : () => setState(() {
                        _appPassword = true;
                        _error = null;
                      }),
                child: Text(l10n.accountSetupUseAppPasswordInstead),
              ),
            ),
        ] else
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton(
              onPressed: () => setState(() => _step = _Step.address),
              child: Text(l10n.accountSetupUseDifferentAddress),
            ),
          ),
      ],
    );
  }

  List<Widget> _providerNotes(BuildContext context) {
    final l10n = context.l10n;
    Widget link(String label, String url) => TextButton(onPressed: () => _open(url), child: Text(label));
    return switch (_provider) {
      ProviderKind.gmail when !_appPassword && _oauthAvailable => [
        NoteCard(key: const Key('oauth-note'), icon: LoupeIcons.info, child: Text(l10n.accountSetupGoogleNote)),
      ],
      ProviderKind.gmail when !_appPassword => [
        NoteCard(
          icon: LoupeIcons.info,
          actions: [
            TextButton(
              key: const Key('use-app-password'),
              onPressed: () => setState(() => _appPassword = true),
              child: Text(l10n.accountSetupUseAppPassword),
            ),
          ],
          child: Text(l10n.accountSetupGmailAppPasswordOnlyNote),
        ),
      ],
      ProviderKind.gmail => [
        NoteCard(
          icon: LoupeIcons.password,
          actions: [
            link(l10n.accountSetupHowToCreateAppPassword, gmailAppPasswordHelp),
            if (_oauthAvailable)
              TextButton(
                key: const Key('use-oauth'),
                onPressed: _busy
                    ? null
                    : () => setState(() {
                        _appPassword = false;
                        _error = null;
                      }),
                child: Text(oauthButtonLabel(l10n, _provider)),
              ),
          ],
          child: Text(l10n.accountSetupGmailAppPasswordNote),
        ),
      ],
      ProviderKind.microsoft when _oauthAvailable => [
        NoteCard(key: const Key('oauth-note'), icon: LoupeIcons.info, child: Text(l10n.accountSetupMicrosoftNote)),
      ],
      ProviderKind.microsoft => [
        NoteCard(
          key: const Key('microsoft-note'),
          icon: LoupeIcons.info,
          child: Text(l10n.accountSetupMicrosoftUnavailableNote),
        ),
      ],
      ProviderKind.icloud => [
        NoteCard(
          icon: LoupeIcons.password,
          actions: [link(l10n.accountSetupHowToCreateOne, 'https://support.apple.com/en-us/102654')],
          child: Text(l10n.accountSetupICloudNote),
        ),
      ],
      ProviderKind.yahoo => [
        NoteCard(
          icon: LoupeIcons.password,
          actions: [link(l10n.accountSetupHowToCreateOne, 'https://help.yahoo.com/kb/SLN15241.html')],
          child: Text(l10n.accountSetupYahooNote),
        ),
      ],
      ProviderKind.fastmail when _protocol == ServerProtocol.jmap => [
        NoteCard(
          key: const Key('fastmail-jmap-note'),
          icon: LoupeIcons.password,
          actions: [link(l10n.accountSetupHowToCreateOne, fastmailApiTokenHelp)],
          child: Text(l10n.accountSetupFastmailJmapNote),
        ),
      ],
      ProviderKind.fastmail => [
        NoteCard(
          icon: LoupeIcons.password,
          actions: [link(l10n.accountSetupHowToCreateOne, 'https://www.fastmail.help/hc/en-us/articles/360058752854')],
          child: Text(l10n.accountSetupFastmailNote),
        ),
      ],
      ProviderKind.generic => const [],
    };
  }

  Widget _settingsSummary(BuildContext context, AccountDiscovery discovery) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final incoming = _incoming!.config;
    final outgoing = _outgoing!.config;
    return SheetGroup(
      children: [
        ListTile(
          key: const Key('setup-settings'),
          dense: true,
          title: Text(l10n.accountSetupServerSettings, style: const TextStyle(fontSize: 16)),
          subtitle: Text(switch (discovery.source) {
            null => l10n.accountSetupSettingsNotFound,
            final source => l10n.accountSetupSettingsFoundVia(source),
          }, style: TextStyle(color: colors.secondaryText)),
          trailing: Icon(_showSettings ? LoupeIcons.collapse : LoupeIcons.expand, color: colors.secondaryText),
          onTap: () => setState(() => _showSettings = !_showSettings),
        ),
        if (_showSettings && !_editSettings) ...[
          ListTile(
            dense: true,
            leading: const Icon(LoupeIcons.download, size: 20),
            title: Text(incoming == null ? '—' : describeServer(l10n, incoming)),
            subtitle: Text(l10n.accountSetupIncoming(_incoming!.protocol.name.toUpperCase())),
          ),
          if (outgoing != null && _incoming!.protocol != ServerProtocol.jmap)
            ListTile(
              dense: true,
              leading: const Icon(LoupeIcons.upload, size: 20),
              title: Text(describeServer(l10n, outgoing)),
              subtitle: Text(l10n.accountSetupOutgoing),
            ),
          SheetRow(
            key: const Key('setup-edit-settings'),
            label: l10n.accountSetupEditSettings,
            icon: LoupeIcons.serverSettings,
            onTap: _busy ? null : () => setState(() => _editSettings = true),
          ),
        ],
      ],
    );
  }

  Widget _doneStep(BuildContext context) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    return _page(
      context,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
          child: Column(
            children: [
              Icon(LoupeIcons.selected, size: 56, color: CupertinoColors.systemGreen.resolveFrom(context)),
              const SizedBox(height: 12),
              Text(
                _account?.email ?? '',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(l10n.accountSetupSyncing, style: TextStyle(color: colors.secondaryText)),
            ],
          ),
        ),
        SheetGroup(
          children: [
            FormRow(
              label: l10n.accountSetupDescription,
              child: TextField(
                key: const Key('setup-description'),
                controller: _description,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration.collapsed(hintText: l10n.accountSetupDescriptionHint),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  SizedBox(width: 96, child: Text(l10n.accountSetupColour, style: const TextStyle(fontSize: 16))),
                  Expanded(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        for (final (i, c) in colors.accountColors.indexed)
                          Semantics(
                            button: true,
                            selected: i == _colorIndex,
                            label: l10n.accountSetupColourNumber(i + 1),
                            child: GestureDetector(
                              key: ValueKey('setup-colour-$i'),
                              onTap: () => setState(() => _colorIndex = i),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: CupertinoDynamicColor.resolve(c, context),
                                  shape: BoxShape.circle,
                                  border: i == _colorIndex
                                      ? Border.all(color: Theme.of(context).colorScheme.onSurface, width: 2.5)
                                      : null,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        _primaryButton(
          key: const Key('setup-done'),
          label: l10n.commonDone,
          busyLabel: l10n.accountSetupSaving,
          onTap: _finish,
        ),
      ],
    );
  }
}

/// What account setup says about a failure that isn't the server's.
String setupFailureMessage(AppLocalizations l10n, Object e) => switch (e) {
  DatabaseKeyUnavailable() || MailStoreException() => l10n.accountSetupDatabaseUnavailable,
  _ => l10n.accountSetupUnexpectedError('${e.runtimeType}'),
};
