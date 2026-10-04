import 'package:flutter/widgets.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart';

import '../account_setup/oauth_accounts.dart';
import '../account_setup/setup_text.dart';
import 'import_mapping.dart';
import 'qr_sequence.dart';
import 'thunderbird_qr.dart';

/// What happened to a scanned or pasted payload, for the scanner's status line.
sealed class ScanFeedback {
  const ScanFeedback();
}

final class ScanAccepted extends ScanFeedback {
  const ScanAccepted(this.result);
  final QrSequenceResult result;
}

final class ScanRejected extends ScanFeedback {
  const ScanRejected(this.message);
  final String message;
}

enum ImportStatus { pending, adding, added, failed }

/// One account of the review list, with its selection, password and progress.
final class ImportRow {
  ImportRow(this.candidate, {required this.alreadyAdded}) : selected = candidate.canImport && !alreadyAdded;

  final ImportCandidate candidate;

  /// An account with this address is already in Loupe.
  final bool alreadyAdded;
  bool selected;
  ImportStatus status = ImportStatus.pending;

  /// Shown under the account after a failed attempt.
  String? error;

  /// A certificate fingerprint offered for trust after a certificate error.
  String? fingerprint;

  /// Hosts whose (self-signed) certificate the user chose to trust.
  final trusted = <String, String>{};

  /// The password the user typed; it replaces the one from the code.
  final password = TextEditingController();

  /// Gmail added with an app password although Loupe could sign in with Google.
  bool useAppPassword = false;

  /// Signs in with Google or Microsoft in the browser when added.
  bool get signsIn => candidate.canSignIn && !useAppPassword;

  /// Ask for a password: none came with the code, or the server refused it.
  bool get asksPassword => candidate.canImport && !signsIn && (candidate.needsPassword || _passwordRejected);
  bool _passwordRejected = false;

  bool get canToggle => candidate.canImport && status != ImportStatus.added;
}

/// The Thunderbird import: collects codes, then adds the chosen accounts
/// one by one through [repository].
///
/// It holds the scanned settings and passwords only while the flow is
/// open: [clear] (also called by [dispose]) drops them.
class AccountImportController extends ChangeNotifier {
  AccountImportController({required this.repository, this.oauth});

  final Future<MailRepository> Function() repository;

  /// Signs in OAuth accounts (Gmail, Microsoft) whose provider this build is
  /// configured for; null signs in none.
  final OAuthSignIn? oauth;

  final sequence = QrSequence();

  List<ImportRow> get rows => _rows;
  List<ImportRow> _rows = const [];

  /// The last payload that wasn't accepted; repeats of it are ignored, so
  /// the camera doesn't flash the same message.
  String? _lastRejected;

  bool get busy => _busy;
  bool _busy = false;

  /// While [busy]: the account being added, as "[addingIndex] of [addingTotal]".
  int get addingIndex => _addingIndex;
  int _addingIndex = 0;
  int get addingTotal => _addingTotal;
  int _addingTotal = 0;

  List<ImportRow> get selected => [
    for (final r in _rows)
      if (r.selected && r.canToggle) r,
  ];
  bool get anyAdded => _rows.any((r) => r.status == ImportStatus.added);

  // Scanning ------------------------------------------------------------------

  /// Reads one scanned or pasted payload. Null when it's a repeat that
  /// changes nothing.
  ScanFeedback? addPayload(String text) {
    try {
      final code = parseThunderbirdQr(text);
      final result = sequence.add(code);
      _lastRejected = null;
      if (result != QrSequenceResult.duplicate) notifyListeners();
      return ScanAccepted(result);
    } on TbQrFormatException catch (e) {
      if (text == _lastRejected) return null;
      _lastRejected = text;
      return ScanRejected(e.message);
    }
  }

  /// Several payloads at once (pasted text): the whole text, or one per line.
  ScanFeedback? addPasted(String text) {
    final whole = addPayload(text);
    if (whole is! ScanRejected) return whole;
    final lines = text.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty).toList();
    if (lines.length < 2) return whole;
    ScanFeedback? last;
    for (final line in lines) {
      final feedback = addPayload(line);
      if (feedback is ScanRejected) return feedback;
      last = feedback ?? last;
    }
    return last;
  }

  /// Turns the scanned accounts into the review list; [existing] are the
  /// addresses already in Loupe.
  void review({Set<String> existing = const {}}) {
    _disposeRows();
    final known = {for (final e in existing) e.toLowerCase()};
    final signInProviders = {
      for (final p in const [ProviderKind.gmail, ProviderKind.microsoft])
        if (oauth?.isConfigured(p) ?? false) p,
    };
    _rows = [
      for (final account in sequence.accounts)
        ImportRow(
          ImportCandidate.fromThunderbird(account, signInProviders: signInProviders),
          alreadyAdded: known.contains(account.email.toLowerCase()),
        ),
    ];
    notifyListeners();
  }

  /// Back to scanning more codes (the review list is rebuilt afterwards).
  void scanMore() {
    _disposeRows();
    _rows = const [];
    notifyListeners();
  }

  void startOver() {
    clear();
    notifyListeners();
  }

  void toggle(ImportRow row) {
    if (!row.canToggle || _busy) return;
    row.selected = !row.selected;
    notifyListeners();
  }

  /// Adds a Gmail account with an app password instead of signing in.
  void useAppPassword(ImportRow row) {
    if (_busy || !row.candidate.canSignIn) return;
    row
      ..useAppPassword = true
      ..status = ImportStatus.pending
      ..error = null;
    notifyListeners();
  }

  // Adding --------------------------------------------------------------------

  /// Adds every selected account that isn't added yet, one at a time;
  /// Gmail and Microsoft accounts sign in in the browser when their turn
  /// comes. When a selected account still needs a password, nothing is added
  /// and that row says so.
  Future<void> importSelected() async {
    if (_busy) return;
    final todo = selected;
    var missing = false;
    for (final row in todo) {
      if (row.asksPassword && row.password.text.isEmpty) {
        row
          ..status = ImportStatus.failed
          ..error = 'Enter the ${row.candidate.passwordLabel.toLowerCase()}.';
        missing = true;
      }
    }
    if (missing) {
      notifyListeners();
      return;
    }
    await _run(todo);
  }

  Future<void> _run(List<ImportRow> rows) async {
    _busy = true;
    _addingTotal = rows.length;
    notifyListeners();
    try {
      final MailRepository repo;
      try {
        repo = await repository();
      } on Object {
        for (final row in rows) {
          row
            ..status = ImportStatus.failed
            ..error = 'Loupe couldn’t open its account storage. Try again later.';
        }
        return;
      }
      for (final (i, row) in rows.indexed) {
        _addingIndex = i + 1;
        await _add(repo, row);
      }
    } finally {
      _busy = false;
      _addingIndex = _addingTotal = 0;
      notifyListeners();
    }
  }

  /// Pins the offered certificate on the servers it names and tries the
  /// account again.
  Future<void> trustCertificate(ImportRow row) async {
    final fp = row.fingerprint;
    if (fp == null || _busy) return;
    final message = row.error ?? '';
    final hosts = {row.candidate.incoming.host, row.candidate.outgoing.host};
    final named = hosts.where(message.contains);
    for (final host in named.isEmpty ? hosts : named) {
      row.trusted[host] = fp;
    }
    await _run([row]);
  }

  Future<void> _add(MailRepository repo, ImportRow row) async {
    row
      ..status = ImportStatus.adding
      ..error = null
      ..fingerprint = null;
    notifyListeners();
    final candidate = row.candidate;
    final signsIn = row.signsIn;
    try {
      final typed = row.password.text;
      final credentials = signsIn ? await oauth!.signIn(candidate.provider, loginHint: candidate.email) : null;
      final account = await repo.addAccount(
        candidate.toSetup(
          password: typed.isEmpty ? null : typed,
          credentials: credentials,
          trustedCertificates: row.trusted,
        ),
      );
      row.status = ImportStatus.added;
      if (candidate.otherIdentities.isNotEmpty) {
        try {
          await repo.updateAccount(
            account.copyWith(
              identities: [
                ...account.identities,
                for (final (i, identity) in candidate.otherIdentities.indexed)
                  Identity(
                    id: '${account.id}/tb${i + 1}',
                    email: identity.email,
                    name: identity.displayName.trim().isEmpty ? null : identity.displayName.trim(),
                  ),
              ],
            ),
          );
        } on MailException {
          // The account works; the extra addresses can be added in its settings.
        }
      }
      row.password.clear();
    } on MailException catch (e) {
      row
        ..status = ImportStatus.failed
        ..error = signsIn ? describeOAuthError(e, candidate.provider) : describeSetupError(e, candidate.provider)
        ..fingerprint = e.kind == MailErrorKind.certificate ? fingerprintIn(e.message) : null
        .._passwordRejected = row._passwordRejected || (!signsIn && e.kind == MailErrorKind.authentication);
    } on Object {
      // Not a mail error: say little, since details could include settings.
      row
        ..status = ImportStatus.failed
        ..error = 'The account couldn’t be added. Try again, or add it manually.';
    }
    notifyListeners();
  }

  // Cleanup -------------------------------------------------------------------

  /// Forgets every scanned code, account and typed password.
  void clear() {
    sequence.clear();
    _disposeRows();
    _rows = const [];
    _lastRejected = null;
  }

  void _disposeRows() {
    for (final row in _rows) {
      row.password
        ..clear()
        ..dispose();
      row.trusted.clear();
    }
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }
}
