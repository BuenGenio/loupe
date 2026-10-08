import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/oauth.dart';
import '../../data/repositories.dart';
import '../../l10n/l10n.dart';
import '../../router.dart';
import '../../settings/app_mode.dart';
import '../../shared/bars.dart';
import '../../shared/grouped_list.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../account_setup/oauth_accounts.dart' show oauthProviderName;
import '../account_setup/server_settings.dart' show FormRow, NoteCard, confirmNoEncryption;
import '../account_setup/setup_text.dart' show gmailAppPasswordHelp, secretLabel;
import '../conversation/sheets.dart' show showSnack;
import 'import_controller.dart';
import 'import_mapping.dart';
import 'qr_scanner.dart';
import 'qr_sequence.dart';
import 'thunderbird_qr.dart';

/// Imports accounts from Thunderbird desktop's "Export for Mobile" QR codes:
/// scan (or paste) every code, choose the accounts, add them one by one.
///
/// Works with any repository [setupRepositoryProvider] gives (demo mode
/// adds demo accounts). Scanned settings and passwords live only in this
/// screen's state, never in route arguments, and are dropped when it closes.
class AccountImportScreen extends ConsumerStatefulWidget {
  const AccountImportScreen({super.key});

  @override
  ConsumerState<AccountImportScreen> createState() => _AccountImportScreenState();
}

class _AccountImportScreenState extends ConsumerState<AccountImportScreen> with WidgetsBindingObserver {
  late final _import = AccountImportController(
    repository: () => ref.read(setupRepositoryProvider.future),
    oauth: ref.read(oauthSignInProvider),
  );

  bool _reviewing = false;
  bool _opening = false;

  /// Under the camera: what happened to the last code, when it needs saying.
  String? _note;
  bool _noteIsProblem = false;

  /// Bumped to start the camera afresh (back from the system settings).
  int _scannerGeneration = 0;
  bool _awaitingSettings = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _import.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _awaitingSettings) {
      setState(() {
        _awaitingSettings = false;
        _scannerGeneration++;
      });
    }
  }

  // Scanning ----------------------------------------------------------------------

  void _onPayload(String text) {
    if (!mounted || _reviewing || _opening) return;
    _show(_import.addPayload(text));
  }

  void _show(ScanFeedback? feedback, {bool pasted = false}) {
    switch (feedback) {
      case null:
        return;
      case ScanRejected(:final problem):
        final l10n = context.l10n;
        setState(() {
          _note = switch (problem) {
            TbQrProblem.notThunderbird => l10n.accountImportNotThunderbird,
            TbQrProblem.newerVersion => l10n.accountImportNewerVersion,
            TbQrProblem.damaged => l10n.accountImportDamaged,
            TbQrProblem.tooLarge => l10n.accountImportTooLarge,
          };
          _noteIsProblem = true;
        });
      case ScanAccepted(result: QrSequenceResult.duplicate):
        if (pasted) {
          setState(() {
            _note = context.l10n.accountImportDuplicateCode;
            _noteIsProblem = false;
          });
        }
      case ScanAccepted(:final result):
        unawaited(HapticFeedback.selectionClick());
        setState(() {
          _note = result == QrSequenceResult.restarted ? context.l10n.accountImportRestarted : null;
          _noteIsProblem = false;
        });
        if (_import.sequence.isComplete) unawaited(_review());
    }
  }

  Future<void> _paste() async {
    final text = await _askForPayload(context);
    if (text == null || text.trim().isEmpty || !mounted) return;
    _show(_import.addPasted(text), pasted: true);
  }

  Future<void> _openSettings() async {
    _awaitingSettings = true;
    try {
      await ref.read(openAppSettingsProvider)();
    } on Object {
      _awaitingSettings = false;
      if (mounted) showSnack(ScaffoldMessenger.of(context), context.l10n.accountImportCouldNotOpenSettings);
    }
  }

  void _restartCamera() => setState(() => _scannerGeneration++);

  void _startOver() {
    _import.startOver();
    setState(() => _note = null);
  }

  // Choosing and adding -----------------------------------------------------------

  Future<void> _review() async {
    if (_reviewing || _opening) return;
    setState(() => _opening = true);
    var existing = <String>{};
    try {
      final repo = await ref.read(setupRepositoryProvider.future);
      existing = {for (final a in await repo.watchAccounts().first) a.email};
    } on Object {
      // Without the list, nothing is marked as already added.
    }
    if (!mounted) return;
    _import.review(existing: existing);
    setState(() {
      _opening = false;
      _reviewing = true;
      _note = null;
    });
  }

  void _scanMore() {
    _import.scanMore();
    setState(() => _reviewing = false);
  }

  Future<void> _add() async {
    final selected = _import.selected;
    if (selected.isEmpty) return;
    if (selected.any((r) => r.candidate.unencrypted) && !await confirmNoEncryption(context)) return;
    FocusManager.instance.primaryFocus?.unfocus();
    await _import.importSelected();
  }

  /// Like account setup's last step: the first real account switches the app
  /// from the welcome screen to live mode. Leaving disposes the screen, which
  /// drops everything scanned.
  Future<void> _finish() async {
    if (ref.read(appModeProvider) == AppMode.none) await ref.read(appModeProvider.notifier).set(AppMode.live);
    if (mounted) context.go(Routes.mailboxes);
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

  // Build -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return ListenableBuilder(
      listenable: _import,
      builder: (context, _) => PopScope(
        canPop: !_reviewing && !_import.busy,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop || _import.busy) return;
          // Back from the list returns to the camera, unless accounts were added.
          _import.anyAdded ? unawaited(_finish()) : _scanMore();
        },
        child: Scaffold(
          backgroundColor: colors.groupedBackground,
          bottomNavigationBar: _reviewing ? _reviewButtons(context) : null,
          body: CustomScrollView(
            slivers: [
              LoupeTitleBar(title: context.l10n.accountImportTitle),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              ...(_reviewing ? _reviewStep(context) : _scanStep(context)),
              SliverToBoxAdapter(child: SizedBox(height: 24 + MediaQuery.paddingOf(context).bottom)),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _scanStep(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final sequence = _import.sequence;
    final scanner = ref.watch(qrScannerProvider);
    final accounts = sequence.accounts.length;
    return [
      SliverToBoxAdapter(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ColoredBox(
                    color: Colors.black,
                    child: KeyedSubtree(
                      key: ValueKey('scanner-$_scannerGeneration'),
                      child: scanner(context, onPayload: _onPayload, problem: _problem),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
          child: Column(
            children: [
              if (sequence.isEmpty)
                Text(
                  l10n.accountImportPointCamera,
                  textAlign: TextAlign.center,
                  style: styles.body.copyWith(color: colors.secondaryText),
                )
              else ...[
                Text(
                  l10n.accountImportProgress(sequence.scanned, sequence.total),
                  key: const Key('import-progress'),
                  style: styles.body.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                _PartDots(sequence: sequence),
                const SizedBox(height: 6),
                Text(l10n.accountImportAccountsSoFar(accounts), style: styles.footnote),
              ],
            ],
          ),
        ),
      ),
      if (_note case final note?)
        SliverToBoxAdapter(
          child: NoteCard(
            key: const Key('import-note'),
            icon: _noteIsProblem ? LoupeIcons.warning : LoupeIcons.info,
            color: _noteIsProblem ? colors.flag : null,
            child: Text(note),
          ),
        ),
      SliverToBoxAdapter(
        child: NoteCard(icon: LoupeIcons.qrCode, child: Text(l10n.accountImportInstructions)),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!sequence.isEmpty && !sequence.isComplete)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FilledButton(
                    key: const Key('import-continue'),
                    style: _buttonStyle,
                    onPressed: _opening ? null : _review,
                    child: Text(l10n.accountImportContinueWith(accounts)),
                  ),
                ),
              TextButton.icon(
                key: const Key('import-paste'),
                onPressed: _opening ? null : _paste,
                icon: const Icon(LoupeIcons.paste, size: 20),
                label: Text(l10n.accountImportPasteInstead),
              ),
              if (!sequence.isEmpty)
                TextButton(
                  key: const Key('import-start-over'),
                  onPressed: _opening ? null : _startOver,
                  child: Text(l10n.accountImportStartOver),
                ),
            ],
          ),
        ),
      ),
    ];
  }

  ButtonStyle get _buttonStyle => FilledButton.styleFrom(
    minimumSize: const Size.fromHeight(50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
  );

  /// Shown in place of the camera when it can't run.
  Widget _problem(BuildContext context, ScannerProblem problem) {
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final (title, text) = switch (problem) {
      ScannerProblem.permissionDenied => (l10n.accountImportCameraOffTitle, l10n.accountImportCameraOffText),
      ScannerProblem.unavailable => (l10n.accountImportNoCameraTitle, l10n.accountImportNoCameraText),
      ScannerProblem.failed => (l10n.accountImportCameraFailedTitle, l10n.accountImportCameraFailedText),
    };
    const light = Color(0xFFEBEBF5);
    return ColoredBox(
      key: ValueKey('scanner-problem-${problem.name}'),
      color: const Color(0xFF1C1C1E),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LoupeIcons.cameraOff, size: 40, color: light),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: styles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(
                text,
                textAlign: TextAlign.center,
                style: styles.footnote.copyWith(color: light.withValues(alpha: 0.75)),
              ),
              const SizedBox(height: 12),
              switch (problem) {
                ScannerProblem.permissionDenied => CupertinoButton.tinted(
                  key: const Key('import-open-settings'),
                  sizeStyle: CupertinoButtonSize.small,
                  onPressed: _openSettings,
                  child: Text(l10n.accountImportOpenSettings),
                ),
                ScannerProblem.failed => CupertinoButton.tinted(
                  sizeStyle: CupertinoButtonSize.small,
                  onPressed: _restartCamera,
                  child: Text(l10n.commonTryAgain),
                ),
                ScannerProblem.unavailable => const SizedBox.shrink(),
              },
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _reviewStep(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final rows = _import.rows;
    final sequence = _import.sequence;
    final missing = sequence.missing;
    final canScanMore = !_import.anyAdded && !_import.busy;
    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
          child: Column(
            children: [
              Text(l10n.accountImportFound(rows.length), style: styles.navTitle, textAlign: TextAlign.center),
              const SizedBox(height: 4),
              Text(
                rows.isEmpty ? l10n.accountImportNoneReadable : l10n.accountImportChoose,
                style: styles.body.copyWith(color: colors.secondaryText),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      if (missing.isNotEmpty)
        SliverToBoxAdapter(
          child: NoteCard(
            key: const Key('import-missing'),
            icon: LoupeIcons.info,
            actions: [
              if (canScanMore)
                TextButton(
                  key: const Key('import-scan-more'),
                  onPressed: _scanMore,
                  child: Text(l10n.accountImportScanMore),
                ),
            ],
            child: Text(l10n.accountImportMissingCodes(missing.length, _codes(l10n, missing), sequence.total)),
          ),
        ),
      if (sequence.skipped > 0)
        SliverToBoxAdapter(
          child: NoteCard(
            icon: LoupeIcons.warning,
            color: colors.flag,
            child: Text(l10n.accountImportSkipped(sequence.skipped)),
          ),
        ),
      for (final (i, row) in rows.indexed) SliverToBoxAdapter(child: _accountCard(context, i, row)),
      if (rows.isEmpty && canScanMore)
        SliverToBoxAdapter(
          child: Center(
            child: TextButton(
              key: const Key('import-scan-again'),
              onPressed: () {
                _startOver();
                _scanMore();
              },
              child: Text(l10n.accountImportScanAgain),
            ),
          ),
        ),
    ];
  }

  /// The numbers of [parts]: "2", "1 and 3", "1, 2 and 4".
  static String _codes(AppLocalizations l10n, List<int> parts) => parts.length == 1
      ? '${parts.single}'
      : l10n.accountImportCodeList(parts.sublist(0, parts.length - 1).join(', '), '${parts.last}');

  static String _blockText(AppLocalizations l10n, ImportBlock block) => switch (block) {
    ImportBlock.pop3 => l10n.accountImportPop3,
    ImportBlock.kerberos => l10n.accountImportKerberos,
    ImportBlock.ntlm => l10n.accountImportNtlm,
    ImportBlock.clientCertificate => l10n.accountImportClientCertificate,
    ImportBlock.microsoftSignIn => l10n.accountImportMicrosoftSignIn,
  };

  Widget _accountCard(BuildContext context, int index, ImportRow row) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final c = row.candidate;
    final busy = _import.busy;
    final Widget leading = switch (row.status) {
      ImportStatus.adding => const CupertinoActivityIndicator(),
      ImportStatus.added => Icon(LoupeIcons.selected, color: colors.success),
      _ when !c.canImport => Icon(LoupeIcons.unselected, color: colors.separator),
      _ when row.selected => Icon(LoupeIcons.selected, color: colors.unreadDot),
      _ => Icon(LoupeIcons.unselected, color: colors.tertiaryText),
    };
    Widget note(IconData icon, String text, {Color? color, List<Widget> actions = const []}) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 14, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 26, child: Icon(icon, size: 18, color: color ?? colors.secondaryText)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: styles.footnote.copyWith(fontSize: 14, color: color)),
                if (actions.isNotEmpty) Wrap(spacing: 4, children: actions),
              ],
            ),
          ),
        ],
      ),
    );
    final details = <Widget>[
      if (c.block case final block?)
        note(LoupeIcons.info, _blockText(l10n, block))
      else if (row.status != ImportStatus.added) ...[
        if (row.alreadyAdded) note(LoupeIcons.info, l10n.accountImportAlreadyAdded),
        if (row.signsIn)
          note(
            LoupeIcons.info,
            l10n.accountImportSignsInWith(oauthProviderName(c.provider)),
            actions: [
              if (c.provider == ProviderKind.gmail)
                TextButton(
                  key: ValueKey('import-app-password-$index'),
                  onPressed: busy ? null : () => _import.useAppPassword(row),
                  child: Text(l10n.accountSetupUseAppPasswordInstead),
                ),
            ],
          )
        else if (c.usesOAuth && c.provider == ProviderKind.gmail)
          note(
            LoupeIcons.info,
            c.canSignIn ? l10n.accountImportGmailAppPassword : l10n.accountImportGmailNoSignIn,
            actions: [
              TextButton(
                onPressed: () => _open(gmailAppPasswordHelp),
                child: Text(l10n.accountSetupHowToCreateAppPassword),
              ),
            ],
          )
        else if (c.usesOAuth)
          note(LoupeIcons.info, l10n.accountImportBrowserSignIn),
        if (c.unencrypted) note(LoupeIcons.warning, l10n.accountImportUnencrypted, color: colors.flag),
        if (row.selected && row.asksPassword)
          FormRow(
            label: secretLabel(l10n, c.secretKind),
            child: TextField(
              key: ValueKey('import-password-$index'),
              controller: row.password,
              enabled: !busy,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration.collapsed(
                hintText: c.includedPassword == null ? l10n.accountSetupPasswordRequired : l10n.accountImportEnterAgain,
              ),
            ),
          ),
        if (row.failure != null)
          note(
            LoupeIcons.error,
            describeImportFailure(l10n, row),
            color: colors.destructive,
            actions: [
              if (row.fingerprint case final fp?) ...[
                SelectableText('SHA-256 $fp', style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                TextButton(
                  key: ValueKey('import-trust-$index'),
                  onPressed: busy ? null : () => _import.trustCertificate(row),
                  child: Text(l10n.accountSetupTrustCertificate),
                ),
              ],
            ],
          ),
      ],
    ];
    return InsetGroup(
      key: ValueKey('import-account-$index'),
      separatorIndent: 54,
      children: [
        Semantics(
          checked: row.status == ImportStatus.added || (c.canImport && row.selected),
          enabled: row.canToggle && !busy,
          child: GroupedRow(
            key: ValueKey('import-toggle-$index'),
            leading: leading,
            title: c.email,
            subtitle: '${c.name} · ${c.incoming.host}',
            detail: row.status == ImportStatus.added ? l10n.accountImportAdded : null,
            // Accounts that can't be added are greyed out; their note says why.
            enabled: c.canImport,
            chevron: false,
            onTap: row.canToggle && !busy ? () => _import.toggle(row) : null,
          ),
        ),
        ...details,
      ],
    );
  }

  Widget? _reviewButtons(BuildContext context) {
    final l10n = context.l10n;
    final busy = _import.busy;
    final pending = _import.selected.length;
    final added = _import.anyAdded;
    final (label, key, onTap) = busy
        ? (l10n.accountImportAdding(_import.addingIndex, _import.addingTotal), 'import-add', null)
        : pending > 0
        ? (l10n.accountImportAddAccounts(pending), 'import-add', _add)
        : added
        ? (l10n.commonDone, 'import-done', _finish)
        : (l10n.accountImportAddAccounts(0), 'import-add', null);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              key: Key(key),
              style: _buttonStyle,
              onPressed: onTap,
              child: busy
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                        const SizedBox(width: 10),
                        Text(label),
                      ],
                    )
                  : Text(label),
            ),
            if (!busy && added && pending > 0)
              TextButton(key: const Key('import-finish'), onPressed: _finish, child: Text(l10n.commonDone)),
          ],
        ),
      ),
    );
  }
}

/// One dot per code of the export, filled once scanned.
class _PartDots extends StatelessWidget {
  const _PartDots({required this.sequence});

  final QrSequence sequence;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    if (sequence.total > 12) return const SizedBox.shrink();
    return Semantics(
      label: context.l10n.accountImportProgressLabel(sequence.scanned, sequence.total),
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var part = 1; part <= sequence.total; part++)
            Container(
              width: 9,
              height: 9,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: sequence.has(part) ? colors.unreadDot : colors.separator,
              ),
            ),
        ],
      ),
    );
  }
}

/// Asks for the text of one or more codes (from another scanner app, or for
/// testing).
Future<String?> _askForPayload(BuildContext context) =>
    showCupertinoDialog<String>(context: context, barrierDismissible: true, builder: (context) => const _PasteDialog());

class _PasteDialog extends StatefulWidget {
  const _PasteDialog();

  @override
  State<_PasteDialog> createState() => _PasteDialogState();
}

class _PasteDialogState extends State<_PasteDialog> {
  final _text = TextEditingController();

  @override
  void dispose() {
    _text
      ..clear()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
    title: Text(context.l10n.accountImportPasteTitle),
    content: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: const EdgeInsets.only(bottom: 10), child: Text(context.l10n.accountImportPasteText)),
          CupertinoTextField(
            key: const Key('import-paste-field'),
            controller: _text,
            autofocus: true,
            autocorrect: false,
            enableSuggestions: false,
            minLines: 3,
            maxLines: 6,
            keyboardType: TextInputType.multiline,
            placeholder: '[1,[1,1],…]',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
          ),
        ],
      ),
    ),
    actions: [
      CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(), child: Text(context.l10n.commonCancel)),
      CupertinoDialogAction(
        key: const Key('import-paste-add'),
        isDefaultAction: true,
        onPressed: () => Navigator.of(context).pop(_text.text),
        child: Text(context.l10n.commonAdd),
      ),
    ],
  );
}
