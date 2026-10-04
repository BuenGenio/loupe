import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart' hide TextField;
import 'package:url_launcher/url_launcher.dart';

import '../../data/repositories.dart';
import '../../settings/app_mode.dart';
import '../../router.dart';
import '../../theme/theme.dart';
import '../compose/compose_text.dart';
import '../conversation/mail_streams.dart';
import '../conversation/sheets.dart';
import 'server_settings.dart';

enum _Step { address, signIn, done }

/// Adds an account: email and name, then provider-specific sign-in with the
/// discovered (or manual) server settings, then a name and colour.
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
  bool _showSettings = false;
  bool _editSettings = false;
  bool _appPassword = false;
  bool _obscure = true;

  bool _busy = false;
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
    super.dispose();
  }

  ProviderKind get _provider => _discovery?.provider ?? ProviderKind.generic;

  String get _domain {
    final e = _email.text.trim();
    return e.contains('@') ? e.substring(e.lastIndexOf('@') + 1).toLowerCase() : '';
  }

  /// "Gmail", "iCloud", … or the domain's first label ("Example").
  String get _defaultDescription => switch (_provider) {
    ProviderKind.gmail => 'Gmail',
    ProviderKind.microsoft => 'Outlook',
    ProviderKind.icloud => 'iCloud',
    ProviderKind.yahoo => 'Yahoo',
    ProviderKind.fastmail => 'Fastmail',
    ProviderKind.generic =>
      _domain.isEmpty ? 'Mail' : '${_domain[0].toUpperCase()}${_domain.split('.').first.substring(1)}',
  };

  // Step 1: discovery -------------------------------------------------------------

  Future<void> _discover() async {
    final email = _email.text.trim();
    if (!ComposeText.isValidEmail(email)) {
      setState(() => _error = 'Enter a valid email address.');
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
    }
    if (!mounted) return;
    _incoming?.dispose();
    _outgoing?.dispose();
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
      _error = note == null && discovery.incoming == null
          ? "Couldn't find settings for $domain. Enter them below."
          : note;
    });
  }

  // Step 2: sign in -----------------------------------------------------------------

  bool get _needsOAuth => _provider == ProviderKind.microsoft || (_provider == ProviderKind.gmail && !_appPassword);

  Future<void> _signIn() async {
    final incoming = _incoming?.config;
    final outgoing = _outgoing?.config;
    if (incoming == null || (incoming.protocol != ServerProtocol.jmap && outgoing == null)) {
      setState(() {
        _editSettings = _showSettings = true;
        _error = 'Check the server names and ports.';
      });
      return;
    }
    if (_password.text.isEmpty) {
      setState(() => _error = 'Enter your password.');
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
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
      if (!mounted) return;
      final others = (ref.read(accountsStreamProvider).value ?? const <MailAccount>[]).where((a) => a.id != account.id);
      setState(() {
        _account = account;
        _busy = false;
        _step = _Step.done;
        _description.text = _defaultDescription;
        _colorIndex = others.length % LoupeColors.of(context).accountColors.length;
      });
    } on MailException catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = _describe(e);
        _fingerprint = e.kind == MailErrorKind.certificate ? fingerprintIn(e.message) : null;
        if (e.kind == MailErrorKind.connection) _showSettings = true;
      });
    }
  }

  String _describe(MailException e) => switch (e.kind) {
    MailErrorKind.authentication => switch (_provider) {
      ProviderKind.gmail ||
      ProviderKind.icloud ||
      ProviderKind.yahoo ||
      ProviderKind.fastmail => 'Password rejected. Use an app password, not your account password.',
      _ => 'Password rejected. Check it and try again.',
    },
    MailErrorKind.connection => "Can't reach server. Check the server settings and your connection.",
    MailErrorKind.certificate => "The server's certificate isn't trusted. ${e.message}",
    _ => e.message,
  };

  /// Pins the offered certificate on the servers it belongs to and retries.
  Future<void> _trustCertificate() async {
    final fp = _fingerprint;
    if (fp == null) return;
    final message = _error ?? '';
    final servers = [_incoming!, _outgoing!];
    final named = servers.where((s) => s.host.text.trim().isNotEmpty && message.contains(s.host.text.trim()));
    for (final s in named.isEmpty ? servers : named) {
      s.trustedCertificate = fp;
    }
    await _signIn();
  }

  Future<void> _open(String url) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView)) {
        showSnack(messenger, "Couldn't open the page.");
      }
    } on Exception {
      showSnack(messenger, "Couldn't open the page.");
    }
  }

  // Step 3: name and colour ---------------------------------------------------------

  Future<void> _finish() async {
    final account = _account!;
    final description = _description.text.trim();
    setState(() => _busy = true);
    try {
      await (await _repo).updateAccount(
        account.copyWith(displayName: description.isEmpty ? account.displayName : description, colorIndex: _colorIndex),
      );
    } on MailException catch (e) {
      if (mounted) showSnack(ScaffoldMessenger.of(context), e.message);
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
        appBar: AppBar(
          backgroundColor: colors.groupedBackground,
          title: Text(_step == _Step.done ? 'Account Added' : 'Add Account'),
          automaticallyImplyLeading: _step != _Step.done,
        ),
        body: SafeArea(
          child: AnimatedSwitcher(
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
      ),
    );
  }

  Widget _title(BuildContext context, String title, String subtitle) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 8, 32, 24),
      child: Column(
        children: [
          Icon(Icons.alternate_email, size: 48, color: theme.colorScheme.primary),
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
          icon: Icons.error_outline,
          color: CupertinoColors.systemRed.resolveFrom(context),
          actions: [
            if (_fingerprint != null)
              TextButton(
                key: const Key('trust-certificate'),
                onPressed: _busy ? null : _trustCertificate,
                child: const Text('Trust This Certificate'),
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

  Widget _addressStep(BuildContext context) => ListView(
    children: [
      _title(context, 'Add a Mail Account', 'Loupe finds the settings for most providers.'),
      SheetGroup(
        children: [
          FormRow(
            label: 'Name',
            child: TextField(
              key: const Key('setup-name'),
              controller: _name,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              decoration: const InputDecoration.collapsed(hintText: 'Your name'),
            ),
          ),
          FormRow(
            label: 'Email',
            child: TextField(
              key: const Key('setup-email'),
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textInputAction: TextInputAction.go,
              autofillHints: const [AutofillHints.email],
              onSubmitted: (_) => _discover(),
              decoration: const InputDecoration.collapsed(hintText: 'name@example.com'),
            ),
          ),
        ],
      ),
      _errorNote(),
      _primaryButton(
        key: const Key('setup-continue'),
        label: 'Continue',
        busyLabel: 'Looking up settings…',
        onTap: _discover,
      ),
    ],
  );

  Widget _signInStep(BuildContext context) {
    final discovery = _discovery!;
    final email = _email.text.trim();
    final title = switch (_provider) {
      ProviderKind.generic => _domain,
      _ => _defaultDescription,
    };
    return ListView(
      children: [
        _title(context, title, email),
        ..._providerNotes(context),
        if (discovery.notes case final notes? when notes.trim().isNotEmpty)
          NoteCard(icon: Icons.info_outline, child: Text(notes)),
        if (!_needsOAuth)
          SheetGroup(
            children: [
              FormRow(
                label: _passwordLabel,
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
                  decoration: InputDecoration.collapsed(hintText: 'Required').copyWith(
                    suffixIcon: IconButton(
                      tooltip: _obscure ? 'Show password' : 'Hide password',
                      icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 20),
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
              title: 'Incoming · ${_incoming!.protocol.name.toUpperCase()}',
              controller: _incoming!,
              enabled: !_busy,
            ),
            if (_incoming!.protocol != ServerProtocol.jmap)
              ServerSettingsForm(title: 'Outgoing · SMTP', controller: _outgoing!, enabled: !_busy),
          ],
          _primaryButton(key: const Key('setup-sign-in'), label: 'Sign In', busyLabel: 'Connecting…', onTap: _signIn),
        ] else
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton(
              onPressed: () => setState(() => _step = _Step.address),
              child: const Text('Use a Different Address'),
            ),
          ),
      ],
    );
  }

  String get _passwordLabel => switch (_provider) {
    ProviderKind.gmail || ProviderKind.yahoo || ProviderKind.fastmail => 'App Password',
    ProviderKind.icloud => 'App Password',
    _ => 'Password',
  };

  List<Widget> _providerNotes(BuildContext context) {
    Widget link(String label, String url) => TextButton(onPressed: () => _open(url), child: Text(label));
    return switch (_provider) {
      ProviderKind.gmail when !_appPassword => [
        NoteCard(
          icon: Icons.info_outline,
          actions: [
            TextButton(
              key: const Key('use-app-password'),
              onPressed: () => setState(() => _appPassword = true),
              child: const Text('Use an App Password'),
            ),
          ],
          child: const Text(
            '“Sign in with Google” isn\'t available in this build yet. You can connect with an app password '
            'instead (it needs 2-Step Verification on your Google account).',
          ),
        ),
      ],
      ProviderKind.gmail => [
        NoteCard(
          icon: Icons.key_outlined,
          actions: [link('How to Create an App Password', 'https://support.google.com/accounts/answer/185833')],
          child: const Text('Create an app password in your Google account and paste it below.'),
        ),
      ],
      ProviderKind.microsoft => [
        const NoteCard(
          key: Key('microsoft-note'),
          icon: Icons.info_outline,
          child: Text(
            'Microsoft sign-in arrives in a later build. Outlook, Hotmail and Microsoft 365 accounts need it: '
            'they no longer accept passwords from mail apps.',
          ),
        ),
      ],
      ProviderKind.icloud => [
        NoteCard(
          icon: Icons.key_outlined,
          actions: [link('How to Create One', 'https://support.apple.com/en-us/102654')],
          child: const Text('iCloud Mail needs an app-specific password, not your Apple Account password.'),
        ),
      ],
      ProviderKind.yahoo => [
        NoteCard(
          icon: Icons.key_outlined,
          actions: [link('How to Create One', 'https://help.yahoo.com/kb/SLN15241.html')],
          child: const Text('Yahoo Mail needs an app password, not your account password.'),
        ),
      ],
      ProviderKind.fastmail => [
        NoteCard(
          icon: Icons.key_outlined,
          actions: [link('How to Create One', 'https://www.fastmail.help/hc/en-us/articles/360058752854')],
          child: const Text('Fastmail needs an app password for mail apps.'),
        ),
      ],
      ProviderKind.generic => const [],
    };
  }

  Widget _settingsSummary(BuildContext context, AccountDiscovery discovery) {
    final colors = LoupeColors.of(context);
    final incoming = _incoming!.config;
    final outgoing = _outgoing!.config;
    return SheetGroup(
      children: [
        ListTile(
          key: const Key('setup-settings'),
          dense: true,
          title: const Text('Server Settings', style: TextStyle(fontSize: 16)),
          subtitle: Text(
            discovery.source == null ? 'Not found automatically' : 'Found via ${discovery.source}',
            style: TextStyle(color: colors.secondaryText),
          ),
          trailing: Icon(_showSettings ? Icons.expand_less : Icons.expand_more, color: colors.secondaryText),
          onTap: () => setState(() => _showSettings = !_showSettings),
        ),
        if (_showSettings && !_editSettings) ...[
          ListTile(
            dense: true,
            leading: const Icon(Icons.download_outlined, size: 20),
            title: Text(incoming == null ? '—' : describeServer(incoming)),
            subtitle: Text('Incoming · ${_incoming!.protocol.name.toUpperCase()}'),
          ),
          if (outgoing != null && _incoming!.protocol != ServerProtocol.jmap)
            ListTile(
              dense: true,
              leading: const Icon(Icons.upload_outlined, size: 20),
              title: Text(describeServer(outgoing)),
              subtitle: const Text('Outgoing · SMTP'),
            ),
          SheetRow(
            key: const Key('setup-edit-settings'),
            label: 'Edit Settings',
            icon: Icons.tune,
            onTap: _busy ? null : () => setState(() => _editSettings = true),
          ),
        ],
      ],
    );
  }

  Widget _doneStep(BuildContext context) {
    final colors = LoupeColors.of(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
          child: Column(
            children: [
              Icon(Icons.check_circle, size: 56, color: CupertinoColors.systemGreen.resolveFrom(context)),
              const SizedBox(height: 12),
              Text(
                _account?.email ?? '',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text('Your mail is syncing.', style: TextStyle(color: colors.secondaryText)),
            ],
          ),
        ),
        SheetGroup(
          children: [
            FormRow(
              label: 'Description',
              child: TextField(
                key: const Key('setup-description'),
                controller: _description,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration.collapsed(hintText: 'Work, Personal…'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const SizedBox(width: 96, child: Text('Colour', style: TextStyle(fontSize: 16))),
                  Expanded(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        for (final (i, c) in colors.accountColors.indexed)
                          Semantics(
                            button: true,
                            selected: i == _colorIndex,
                            label: 'Colour ${i + 1}',
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
        _primaryButton(key: const Key('setup-done'), label: 'Done', busyLabel: 'Saving…', onTap: _finish),
      ],
    );
  }
}

/// A SHA-256 certificate fingerprint in [message] (64 hex digits, with or
/// without colons), as lower-case hex without colons.
String? fingerprintIn(String message) {
  final m = RegExp(r'([0-9A-Fa-f]{2}(?::[0-9A-Fa-f]{2}){31}|[0-9A-Fa-f]{64})').firstMatch(message);
  return m?.group(1)!.replaceAll(':', '').toLowerCase();
}
