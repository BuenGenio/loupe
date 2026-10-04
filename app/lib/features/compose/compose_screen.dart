import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../router.dart';
import '../../settings/app_settings.dart';
import '../../shared/format.dart';
import '../../theme/theme.dart';
import '../conversation/attachments.dart';
import '../conversation/mail_streams.dart';
import '../conversation/sheets.dart';
import 'compose_args.dart';
import 'compose_recovery.dart';
import 'compose_text.dart';
import 'recipient_field.dart';
import 'send_later.dart';
import '../../theme/loupe_icons.dart';

/// Writes a new message, reply, forward or draft. Apple-Mail-clean: Cancel,
/// the subject as title and Send; To, a collapsed "Cc/Bcc, From" row,
/// Subject and a plain-text body.
///
/// Send Later: the clock beside Send (or a long-press on Send) picks a time;
/// Send then shows it and schedules the message. Opened from the Outbox
/// ([ComposeArgs.outboxId]), sending replaces the waiting message.
///
/// Autosave: [autosaveDelay] after the last edit the message is saved to the
/// account's Drafts, replacing the previous save (the draft id is kept), and
/// a local copy is kept in [ComposeRecoveryStore] soon after every edit and
/// when the app goes to the background, so a crash loses nothing. Closing
/// still offers Delete Draft (which deletes both) and Save Draft.
class ComposeScreen extends ConsumerStatefulWidget {
  const ComposeScreen({super.key, this.args = const ComposeArgs()});

  final ComposeArgs args;

  /// Quiet time after an edit before the draft is saved to the server.
  static const autosaveDelay = Duration(seconds: 3);

  /// The same, with attachments over [largeAttachmentBytes]: each save
  /// uploads them again.
  static const autosaveDelayLarge = Duration(seconds: 30);
  static const largeAttachmentBytes = 2 * 1024 * 1024;

  /// Quiet time after an edit before the local copy is written.
  static const localCopyDelay = Duration(milliseconds: 500);

  @override
  ConsumerState<ComposeScreen> createState() => _ComposeScreenState();
}

enum _CloseChoice { delete, save, discardChanges }

class _ComposeScreenState extends ConsumerState<ComposeScreen> {
  final _to = RecipientController();
  final _cc = RecipientController();
  final _bcc = RecipientController();
  final _subject = TextEditingController();
  final _body = TextEditingController();
  final _toFocus = FocusNode();
  final _ccFocus = FocusNode();
  final _bodyFocus = FocusNode();

  final _attachments = <OutgoingAttachment>[];
  List<MailAccount> _accounts = const [];
  MailAccount? _account;
  Identity? _identity;
  bool _showCcBcc = false;
  bool _preparing = true;
  bool _busy = false;
  bool _closing = false;

  late ComposeMode _mode = widget.args.mode;
  String? _sourceEmailId;
  String? _draftId;
  String? _inReplyTo;
  List<String> _references = const [];

  /// When to send ("Send Later"); null sends now (after the undo delay).
  DateTime? _sendAt;

  /// The Outbox message being edited, if any.
  String? _outboxId;

  /// The state when the screen opened; closing an unchanged message asks nothing.
  String? _initial;

  // Autosave.
  late final String _session = widget.args.recoverySession ?? ComposeSessions.newId();
  late final ComposeRecoveryStore _recovery;
  late final AppLifecycleListener _lifecycle;

  /// The draft this screen started from (editing a draft), if any.
  String? _originalDraftId;

  /// [_snapshot] at the last save to Drafts, and of the last local copy.
  String? _lastSaved;
  String? _lastLocal;
  Timer? _serverTimer;
  Timer? _localTimer;
  Future<void>? _saving;
  bool _saveAgain = false;

  /// Bumped when a slow save is given up on (Send, Delete or Save went
  /// ahead without it): the draft that save creates is deleted again.
  int _saveGeneration = 0;

  MailRepository get _repo => ref.read(repositoryProvider);

  @override
  void initState() {
    super.initState();
    ComposeSessions.opened(_session);
    _recovery = ref.read(composeRecoveryProvider);
    for (final l in [_to, _cc, _bcc, _subject, _body]) {
      l.addListener(_changed);
    }
    // Swiped away from the app switcher comes after this: save what's there.
    _lifecycle = AppLifecycleListener(onHide: _saveNow, onPause: _saveNow);
    unawaited(_prepare());
  }

  @override
  void dispose() {
    _serverTimer?.cancel();
    _localTimer?.cancel();
    _lifecycle.dispose();
    ComposeSessions.closed(_session);
    for (final c in [_to, _cc, _bcc]) {
      c.dispose();
    }
    _subject.dispose();
    _body.dispose();
    _toFocus.dispose();
    _ccFocus.dispose();
    _bodyFocus.dispose();
    super.dispose();
  }

  void _changed() {
    if (!mounted) return;
    setState(() {});
    _scheduleAutosave();
  }

  String _snapshot() => [
    for (final c in [_to, _cc, _bcc]) c.withPending.map((a) => a.email).join(','),
    _subject.text,
    _body.text,
    for (final a in _attachments) '${a.filename}:${a.data.length}',
    _identity?.id,
    _sendAt?.millisecondsSinceEpoch,
  ].join('\u0000');

  bool get _dirty => _initial == null || _snapshot() != _initial;

  // Autosave ---------------------------------------------------------------------

  /// Outbox messages aren't drafts: editing one saves nothing on the side.
  bool get _autosaves => !_preparing && !_closing && _outboxId == null && _identity != null;

  /// Debounces both saves after an edit (text fields also notify on cursor moves).
  void _scheduleAutosave() {
    if (!_autosaves) return;
    final snapshot = _snapshot();
    if (snapshot != _lastLocal) {
      _localTimer?.cancel();
      _localTimer = Timer(ComposeScreen.localCopyDelay, _writeLocal);
    }
    if (snapshot != _lastSaved) {
      final size = _attachments.fold<int>(0, (n, a) => n + a.data.length);
      _serverTimer?.cancel();
      _serverTimer = Timer(
        size > ComposeScreen.largeAttachmentBytes ? ComposeScreen.autosaveDelayLarge : ComposeScreen.autosaveDelay,
        () => unawaited(_saveDraftQuietly()),
      );
    }
  }

  /// The app is going to the background: save both at once.
  void _saveNow() {
    if (!_autosaves || !_dirty) return;
    _writeLocal();
    unawaited(_saveDraftQuietly());
  }

  /// Keeps the local copy; an unchanged message needs none.
  void _writeLocal({bool force = false}) {
    _localTimer?.cancel();
    if (!_autosaves) return;
    final snapshot = _snapshot();
    if (!force && snapshot == _lastLocal) return;
    final message = _message();
    if (message == null) return;
    _lastLocal = snapshot;
    if (!_dirty && _draftId == _originalDraftId) {
      unawaited(_recovery.clear(session: _session));
      return;
    }
    unawaited(
      _recovery.write(ComposeRecord(session: _session, message: message, savedAt: DateTime.now(), sendAt: _sendAt)),
    );
  }

  /// Saves to Drafts, replacing the previous save; one save at a time.
  /// Failures are quiet: the local copy stays, and the next edit tries again.
  Future<void> _saveDraftQuietly() {
    _serverTimer?.cancel();
    if (_saving case final running?) {
      _saveAgain = true;
      return running;
    }
    return _saving = _runSaves().whenComplete(() => _saving = null);
  }

  Future<void> _runSaves() async {
    final repo = _repo;
    do {
      _saveAgain = false;
      if (!_autosaves) return;
      final snapshot = _snapshot();
      final message = _message();
      if (message == null || snapshot == _lastSaved) return;
      final generation = _saveGeneration;
      try {
        final id = await repo.saveDraft(message);
        if (generation != _saveGeneration) {
          unawaited(repo.deleteDraft(id).catchError((Object _) {}));
          return;
        }
        _draftId = id;
        _lastSaved = snapshot;
      } on MailException {
        return;
      }
      if (!mounted) return;
      setState(() {});
      // The local copy learns the draft's new id.
      _writeLocal(force: true);
    } while (_saveAgain && mounted);
  }

  /// Stops autosaving and waits for a save in progress, so [_draftId] is
  /// final. A save still hanging after [_saveWait] (a bad connection) is
  /// abandoned rather than holding up Send.
  Future<void> _stopAutosave() async {
    _serverTimer?.cancel();
    _localTimer?.cancel();
    _saveAgain = false;
    try {
      await _saving?.timeout(_saveWait);
    } on TimeoutException {
      _saveGeneration++;
    }
  }

  static const _saveWait = Duration(seconds: 5);

  /// Forgets the local copy (the message was sent, saved or deleted).
  void _forgetLocal() => unawaited(_recovery.clear(session: _session));

  // Preparing ------------------------------------------------------------------

  Future<void> _prepare() async {
    final args = widget.args;
    try {
      _accounts = await _repo.watchAccounts().first;
    } on MailException {
      _accounts = const [];
    }
    if (!mounted) return;
    String? warning;
    _sendAt = args.sendAt;
    _outboxId = args.outboxId;
    if (args.message case final m?) {
      _restore(m);
      // From the Outbox, closing without changes asks nothing.
      if (_outboxId != null) _initial = _snapshot();
      if (args.attachmentsFromDraft) warning = await _attachmentsFromDraft(m.draftId);
      if (!mounted) return;
    } else {
      switch (args.mode) {
        case ComposeMode.newMessage:
          _setIdentity(_accountById(args.accountId), null);
          args.to.forEach(_to.add);
          args.cc.forEach(_cc.add);
          args.bcc.forEach(_bcc.add);
          _subject.text = args.subject ?? '';
          _body.text = _withSignature(args.body ?? '');
        case ComposeMode.reply || ComposeMode.replyAll || ComposeMode.forward:
          warning = await _prepareFromSource(args);
        case ComposeMode.editDraft:
          warning = await _prepareDraft(args);
      }
      if (!mounted) return;
      _initial = _snapshot();
    }
    _showCcBcc = _cc.items.isNotEmpty || _bcc.items.isNotEmpty;
    _originalDraftId = _draftId;
    _lastSaved = _initial;
    _lastLocal = _initial;
    setState(() => _preparing = false);
    // A message brought back (Undo, crash recovery) is saved again soon.
    if (args.message != null) _scheduleAutosave();
    if (warning != null) showSnack(ScaffoldMessenger.of(context), warning);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_to.items.isEmpty) {
        _toFocus.requestFocus();
      } else {
        _bodyFocus.requestFocus();
        _body.selection = const TextSelection.collapsed(offset: 0);
      }
    });
  }

  MailAccount? _accountById(String? id) => _accounts.where((a) => a.id == id).firstOrNull ?? _accounts.firstOrNull;

  /// Picks the identity of [account] that [recipients] were sent to, or its default.
  void _setIdentity(MailAccount? account, Iterable<EmailAddress>? recipients) {
    _account = account;
    if (account == null) return;
    final emails = {...?recipients?.map((a) => a.email.toLowerCase())};
    _identity =
        account.identities.where((i) => emails.contains(i.email.toLowerCase())).firstOrNull ?? account.defaultIdentity;
  }

  String _withSignature(String text) {
    final sig = ComposeText.signatureBlock(_identity?.signature);
    if (sig.isEmpty) return text;
    return text.isEmpty ? '\n\n$sig' : '$text\n\n$sig';
  }

  void _restore(OutgoingMessage m) {
    _account = _accountById(m.accountId);
    _identity = _account?.identities.where((i) => i.id == m.identityId).firstOrNull ?? _account?.defaultIdentity;
    m.to.forEach(_to.add);
    m.cc.forEach(_cc.add);
    m.bcc.forEach(_bcc.add);
    _subject.text = m.subject;
    _body.text = m.text;
    _attachments.addAll(m.attachments);
    _mode = m.mode;
    _sourceEmailId = m.sourceEmailId;
    _draftId = m.draftId;
    _inReplyTo = m.inReplyTo;
    _references = m.references;
  }

  Future<String?> _prepareFromSource(ComposeArgs args) async {
    final id = args.sourceEmailId;
    final source = id == null ? null : await _repo.getEmail(id);
    if (!mounted) return null;
    if (source == null) {
      _setIdentity(_accountById(args.accountId), null);
      _body.text = _withSignature('');
      return "Couldn't find the original message.";
    }
    _sourceEmailId = source.id;
    _setIdentity(_accountById(source.accountId), [...source.to, ...source.cc, ...source.bcc]);
    String? warning;
    EmailContent? content;
    try {
      content = await _repo.loadContent(source.id);
    } on MailException catch (e) {
      warning = e.message;
    }
    if (!mounted) return null;
    final text = content == null ? source.preview : ComposeText.plainTextOf(content);
    if (args.mode == ComposeMode.forward) {
      _subject.text = ComposeText.forwardSubject(source.subject);
      _body.text = '${_withSignature('')}\n\n${ComposeText.forwardBlock(source, text)}';
      if (content != null) warning ??= await _loadAttachments(source.id, content);
    } else {
      final r = ComposeText.replyRecipients(
        source,
        all: args.mode == ComposeMode.replyAll,
        own: ownAddresses(_accounts),
      );
      r.to.forEach(_to.add);
      r.cc.forEach(_cc.add);
      _subject.text = ComposeText.replySubject(source.subject);
      _body.text = '${_withSignature('')}\n\n${ComposeText.replyBlock(source, text)}';
      _inReplyTo = source.messageIdHeader;
      _references = ComposeText.replyReferences(source);
    }
    return warning;
  }

  Future<String?> _prepareDraft(ComposeArgs args) async {
    final id = args.sourceEmailId;
    final draft = id == null ? null : await _repo.getEmail(id);
    if (!mounted) return null;
    if (draft == null) {
      _setIdentity(_accountById(args.accountId), null);
      return "Couldn't find the draft.";
    }
    _draftId = draft.id;
    _setIdentity(_accountById(draft.accountId), draft.from);
    draft.to.forEach(_to.add);
    draft.cc.forEach(_cc.add);
    draft.bcc.forEach(_bcc.add);
    _subject.text = draft.subject;
    _inReplyTo = draft.inReplyTo;
    _references = draft.references;
    try {
      final content = await _repo.loadContent(draft.id);
      if (!mounted) return null;
      _body.text = ComposeText.plainTextOf(content);
      return await _loadAttachments(draft.id, content);
    } on MailException catch (e) {
      _body.text = draft.preview;
      return e.message;
    }
  }

  /// Crash recovery without the attachments' data: they are in the draft.
  Future<String?> _attachmentsFromDraft(String? draftId) async {
    const lost = 'The attachments couldn’t be recovered. Add them again.';
    if (draftId == null) return lost;
    try {
      final content = await _repo.loadContent(draftId);
      if (!mounted) return null;
      return await _loadAttachments(draftId, content);
    } on MailException {
      return lost;
    }
  }

  Future<String?> _loadAttachments(String emailId, EmailContent content) async {
    try {
      for (final a in content.visibleAttachments) {
        final data = await _repo.loadAttachment(emailId, a.partId);
        if (!mounted) return null;
        _attachments.add(OutgoingAttachment(filename: a.filename ?? 'attachment', mimeType: a.mimeType, data: data));
      }
      return null;
    } on MailException catch (e) {
      return "Some attachments couldn't be added: ${e.message}";
    }
  }

  // Editing ---------------------------------------------------------------------

  Future<void> _pickIdentity() async {
    final choices = [
      for (final a in _accounts)
        for (final i in a.identities.isEmpty ? [a.defaultIdentity] : a.identities) (a, i),
    ];
    if (choices.length < 2) return;
    final picked = await showLoupeSheet<(MailAccount, Identity)>(
      context,
      builder: (context) => SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: SheetGroup(
            header: 'From',
            children: [
              for (final (a, i) in choices)
                ListTile(
                  key: ValueKey('identity-${i.id}'),
                  dense: true,
                  title: Text(EmailAddress(i.email, i.name).toString(), style: const TextStyle(fontSize: 15)),
                  subtitle: Text(a.displayName),
                  trailing: i.id == _identity?.id
                      ? Icon(LoupeIcons.check, color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () => Navigator.of(context).pop((a, i)),
                ),
            ],
          ),
        ),
      ),
    );
    if (picked == null || !mounted) return;
    final (account, identity) = picked;
    final oldSignature = _identity?.signature;
    setState(() {
      _account = account;
      _identity = identity;
      _body.text = ComposeText.replaceSignature(_body.text, oldSignature, identity.signature);
    });
    _scheduleAutosave();
  }

  Future<void> _attach() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final files = await FilePicker.pickFiles();
      for (final f in files) {
        final data = await f.readAsBytes();
        _attachments.add(OutgoingAttachment(filename: f.name, mimeType: mimeTypeFor(f.name), data: data));
      }
      _changed();
      final total = _attachments.fold<int>(0, (n, a) => n + a.data.length);
      if (total > 20 * 1024 * 1024) {
        showSnack(messenger, 'Attachments total ${formatBytes(total)}; some servers refuse messages this large.');
      }
    } on Exception {
      showSnack(messenger, "Couldn't attach the file.");
    }
  }

  OutgoingMessage? _message() {
    final account = _account;
    final identity = _identity;
    if (account == null || identity == null) return null;
    return OutgoingMessage(
      accountId: account.id,
      identityId: identity.id,
      to: _to.withPending,
      cc: _cc.withPending,
      bcc: _bcc.withPending,
      subject: _subject.text.trim(),
      text: _body.text,
      attachments: List.of(_attachments),
      inReplyTo: _inReplyTo,
      references: _references,
      mode: _mode,
      sourceEmailId: _sourceEmailId,
      draftId: _draftId,
    );
  }

  bool get _canSend => !_preparing && !_busy && _identity != null && (_to.hasValid || _cc.hasValid || _bcc.hasValid);

  // Sending and closing -----------------------------------------------------------

  Future<void> _pickSendLater() async {
    final choice = await showSendLaterSheet(context, now: DateTime.now(), current: _sendAt);
    if (choice == null || !mounted) return;
    _sendAt = choice.at;
    _changed();
  }

  Future<void> _send() async {
    final invalid = [..._to.invalid, ..._cc.invalid, ..._bcc.invalid];
    if (invalid.isNotEmpty) {
      await _alert('Invalid Address', '“${invalid.first.email}” isn\'t a valid email address.');
      return;
    }
    if (_subject.text.trim().isEmpty) {
      final send = await _confirm('No Subject', 'This message has no subject. Send it anyway?', confirm: 'Send');
      if (!send) return;
    }
    // The message goes out with the draft's final id; sending deletes the draft.
    setState(() => _busy = true);
    await _stopAutosave();
    if (!mounted) return;
    final message = _message();
    if (message == null) {
      setState(() => _busy = false);
      return;
    }
    final repo = _repo;
    final undoSeconds = ref.read(appSettingsProvider).undoSendSeconds;
    // A time that has passed meanwhile sends now, with the usual undo delay.
    final now = DateTime.now();
    final at = _sendAt != null && _sendAt!.isAfter(now) ? _sendAt : null;
    final when = at == null ? null : formatSendTimeFor(context, at, now: now);
    // Captured before popping: the snack bar and Undo outlive this screen.
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.maybeOf(context);
    try {
      if (_outboxId case final id?) {
        if (await repo.cancelSend(id) == null) {
          // It went out while being edited: keep the edits.
          await repo.saveDraft(message);
          _closeNow();
          showSnack(messenger, 'It was sent before your changes, which are saved in Drafts.');
          return;
        }
      }
      final outboxId = await repo.send(
        message,
        undoDelay: Duration(seconds: undoSeconds),
        sendAt: at,
      );
      if (at != null) wakeUpAt(ref, at);
      _forgetLocal();
      _closeNow();
      final undo = at != null || undoSeconds > 0;
      showSnack(
        messenger,
        at != null
            ? 'Scheduled for $when'
            : undoSeconds > 0
            ? 'Sending…'
            : 'Sent',
        duration: Duration(seconds: at == null && undoSeconds > 0 ? undoSeconds : 4),
        action: undo
            ? SnackBarAction(
                label: 'Undo',
                onPressed: () => _undoSend(repo, outboxId, messenger, router, sendAt: at),
              )
            : null,
      );
    } on MailException catch (e) {
      if (mounted) setState(() => _busy = false);
      showSnack(messenger, e.message);
    }
  }

  /// Cancels a queued or scheduled send and reopens it. Runs after this screen is gone.
  static Future<void> _undoSend(
    MailRepository repo,
    String outboxId,
    ScaffoldMessengerState messenger,
    GoRouter? router, {
    DateTime? sendAt,
  }) async {
    try {
      final message = await repo.cancelSend(outboxId);
      if (message == null) {
        showSnack(messenger, 'Already sent.');
      } else {
        await router?.push<void>(Routes.compose, extra: ComposeArgs.restore(message, sendAt: sendAt));
      }
    } on MailException catch (e) {
      showSnack(messenger, e.message);
    }
  }

  Future<void> _cancel() async {
    if (_busy) return;
    if (_preparing) return _closeNow();
    if (!_dirty) return _closeUnchanged();
    if (_outboxId != null) {
      final choice = await showActionSheet<_CloseChoice>(
        context,
        actions: const [
          SheetAction('Discard Changes', _CloseChoice.discardChanges, destructive: true),
          SheetAction('Save Changes', _CloseChoice.save),
        ],
      );
      if (choice == null || !mounted) return;
      return choice == _CloseChoice.save ? _send() : _closeNow();
    }
    final choice = await showActionSheet<_CloseChoice>(
      context,
      actions: const [
        SheetAction('Delete Draft', _CloseChoice.delete, destructive: true),
        SheetAction('Save Draft', _CloseChoice.save),
      ],
    );
    if (choice == null || !mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      switch (choice) {
        case _CloseChoice.discardChanges:
          _closeNow();
        case _CloseChoice.delete:
          // Autosave may have saved it: delete that draft and the local copy.
          await _stopAutosave();
          if (_draftId case final id?) await _repo.deleteDraft(id);
          _forgetLocal();
          _closeNow();
        case _CloseChoice.save:
          // Usually autosave has already done it.
          await _stopAutosave();
          final message = _message();
          if (message != null && _snapshot() != _lastSaved) await _repo.saveDraft(message);
          _forgetLocal();
          _closeNow();
          showSnack(messenger, 'Draft saved');
      }
    } on MailException catch (e) {
      if (mounted) setState(() => _busy = false);
      showSnack(messenger, e.message);
    }
  }

  /// Closes a message that is as it was opened. If autosave saved it
  /// meanwhile (edits that were undone), a new message's draft is deleted
  /// and an edited draft is saved back as it was.
  Future<void> _closeUnchanged() async {
    setState(() => _busy = true);
    await _stopAutosave();
    if (!mounted) return;
    final saved = _draftId;
    if (saved != null && saved != _originalDraftId) {
      try {
        if (_originalDraftId == null) {
          await _repo.deleteDraft(saved);
        } else if (_message() case final message?) {
          await _repo.saveDraft(message);
        }
      } on MailException {
        // Not worth keeping the screen open for.
      }
    }
    _forgetLocal();
    _closeNow();
  }

  void _closeNow() {
    if (!mounted || _closing) return;
    setState(() => _closing = true);
    Navigator.of(context).pop();
  }

  Future<void> _alert(String title, String message) => showCupertinoDialog<void>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );

  Future<bool> _confirm(String title, String message, {required String confirm}) async =>
      await showCupertinoDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirm),
            ),
          ],
        ),
      ) ??
      false;

  // Build ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    final noAccount = !_preparing && _identity == null;
    final title = _subject.text.trim().isEmpty ? 'New Message' : _subject.text.trim();
    return PopScope(
      // Back closes an untouched message at once; anything autosave may
      // have left behind goes through Cancel's cleanup.
      canPop: _closing || (!_dirty && _draftId == _originalDraftId),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) unawaited(_cancel());
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 88,
          leading: TextButton(
            key: const Key('compose-cancel'),
            onPressed: _cancel,
            child: const Text('Cancel', style: TextStyle(fontSize: 16)),
          ),
          title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 17)),
          actions: [
            IconButton(
              tooltip: 'Attach',
              icon: const Icon(LoupeIcons.attachment),
              onPressed: _preparing || _busy ? null : _attach,
            ),
            IconButton(
              key: const Key('compose-send-later'),
              tooltip: 'Send Later',
              isSelected: _sendAt != null,
              icon: const Icon(LoupeIcons.sendLater),
              selectedIcon: Icon(LoupeIcons.sendLaterFilled, color: theme.colorScheme.primary),
              onPressed: _preparing || _busy || _identity == null ? null : _pickSendLater,
            ),
            Padding(padding: const EdgeInsets.only(right: 8), child: _sendButton(context)),
          ],
          bottom: _preparing
              ? const PreferredSize(preferredSize: Size.fromHeight(2), child: LinearProgressIndicator(minHeight: 2))
              : null,
        ),
        body: SafeArea(
          top: false,
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            children: [
              if (noAccount)
                Container(
                  color: subtleFill(context),
                  padding: const EdgeInsets.all(16),
                  child: Text('Add an account to send mail.', style: TextStyle(color: colors.secondaryText)),
                ),
              RecipientField(
                label: 'To:',
                controller: _to,
                focusNode: _toFocus,
                suggest: (p) => _repo.suggestAddresses(p),
              ),
              if (!_showCcBcc)
                _row(
                  context,
                  key: const Key('compose-ccbcc-from'),
                  onTap: () {
                    setState(() => _showCcBcc = true);
                    WidgetsBinding.instance.addPostFrameCallback((_) => _ccFocus.requestFocus());
                  },
                  child: Text(
                    'Cc/Bcc, From: ${_identity?.email ?? ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: colors.secondaryText, fontSize: 16),
                  ),
                )
              else ...[
                RecipientField(
                  label: 'Cc:',
                  controller: _cc,
                  focusNode: _ccFocus,
                  suggest: (p) => _repo.suggestAddresses(p),
                ),
                RecipientField(label: 'Bcc:', controller: _bcc, suggest: (p) => _repo.suggestAddresses(p)),
                _row(
                  context,
                  key: const Key('compose-from'),
                  onTap: _pickIdentity,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'From: ',
                          style: TextStyle(color: colors.secondaryText),
                        ),
                        TextSpan(
                          text: _identity == null ? '' : EmailAddress(_identity!.email, _identity!.name).toString(),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
              _row(
                context,
                child: TextField(
                  key: const Key('compose-subject'),
                  controller: _subject,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => _bodyFocus.requestFocus(),
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    prefixText: 'Subject: ',
                    prefixStyle: TextStyle(color: colors.secondaryText, fontSize: 16),
                  ),
                ),
              ),
              if (_attachments.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final a in _attachments)
                        InputChip(
                          avatar: Icon(attachmentIcon(a.mimeType, a.filename), size: 18),
                          label: Text('${a.filename} · ${formatBytes(a.data.length)}'),
                          onDeleted: () {
                            _attachments.remove(a);
                            _changed();
                          },
                          deleteIcon: const Icon(LoupeIcons.clear, size: 18),
                          deleteButtonTooltipMessage: 'Remove',
                        ),
                    ],
                  ),
                ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _bodyFocus.requestFocus,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  child: TextField(
                    key: const Key('compose-body'),
                    controller: _body,
                    focusNode: _bodyFocus,
                    maxLines: null,
                    minLines: 8,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.4),
                    decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Send, or with a Send Later time a pill showing it. A long-press picks the time.
  Widget _sendButton(BuildContext context) {
    final at = _sendAt;
    final onPressed = _canSend ? _send : null;
    final spinner = SizedBox.square(
      dimension: 18,
      child: CircularProgressIndicator(strokeWidth: 2, color: Theme.of(context).colorScheme.onPrimary),
    );
    final when = at == null ? null : formatSendTimeFor(context, at, now: DateTime.now(), compact: true);
    return Semantics(
      button: true,
      label: when == null ? 'Send' : 'Send $when',
      hint: 'Long-press to send later',
      excludeSemantics: true,
      child: GestureDetector(
        onLongPress: onPressed == null ? null : _pickSendLater,
        child: when == null
            ? IconButton.filled(
                key: const Key('compose-send'),
                icon: _busy ? spinner : const Icon(LoupeIcons.send),
                onPressed: onPressed,
              )
            // The filled clock beside it says it's scheduled; the time gets the room.
            : FilledButton(
                key: const Key('compose-send'),
                onPressed: onPressed,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  minimumSize: const Size(40, 36),
                  visualDensity: VisualDensity.compact,
                  textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                child: _busy
                    ? spinner
                    : ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.3),
                        child: Text(when, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
              ),
      ),
    );
  }

  Widget _row(BuildContext context, {Key? key, required Widget child, VoidCallback? onTap}) => Column(
    key: key,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      InkWell(
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 12), child: child),
      ),
      Divider(indent: 16, color: LoupeColors.of(context).separator),
    ],
  );
}

/// A MIME type from a file name's extension.
String mimeTypeFor(String filename) {
  final ext = filename.contains('.') ? filename.split('.').last.toLowerCase() : '';
  return const {
        'pdf': 'application/pdf',
        'png': 'image/png',
        'jpg': 'image/jpeg',
        'jpeg': 'image/jpeg',
        'gif': 'image/gif',
        'webp': 'image/webp',
        'heic': 'image/heic',
        'svg': 'image/svg+xml',
        'txt': 'text/plain',
        'csv': 'text/csv',
        'html': 'text/html',
        'htm': 'text/html',
        'ics': 'text/calendar',
        'vcf': 'text/vcard',
        'json': 'application/json',
        'zip': 'application/zip',
        'doc': 'application/msword',
        'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'xls': 'application/vnd.ms-excel',
        'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        'ppt': 'application/vnd.ms-powerpoint',
        'pptx': 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
        'odt': 'application/vnd.oasis.opendocument.text',
        'mp3': 'audio/mpeg',
        'm4a': 'audio/mp4',
        'mp4': 'video/mp4',
        'mov': 'video/quicktime',
        'eml': 'message/rfc822',
      }[ext] ??
      'application/octet-stream';
}
