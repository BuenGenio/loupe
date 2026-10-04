import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../features/compose/compose_args.dart';
import '../features/compose/send_later.dart' show formatSendTimeFor, wakeUpAt;
import '../features/conversation/sheets.dart' show showSnack;
import '../features/snooze/snooze_sheet.dart';
import '../providers.dart';
import '../settings/app_settings.dart';
import '../theme/theme.dart';
import 'sheets.dart';
import 'swipe_row.dart';
import '../theme/loupe_icons.dart';
import '../settings/ui_state.dart';

/// Message actions shared by lists, search results, smart mailboxes and the
/// conversation view: optimistic, and with Undo.
///
/// Archive, Trash, Move, Junk / Not Junk, Snooze and Wake Now show a snack
/// bar whose Undo puts every message back in the mailbox it came from (and
/// restores the keywords the action changed: junk, snooze times, unread).
/// The row methods work on whole conversations; the `…Emails` methods on
/// the given messages (the conversation view).
///
/// Deleting permanently (Trash in the Trash mailbox) can't be undone, so it
/// asks first instead: the server expunges at once, and an expunge delayed
/// until the snack bar is gone would be lost if the app were closed meanwhile.
class MailActions {
  MailActions(this.context, this.ref, {required this.scope, required this.threaded, this._mailboxes});

  final BuildContext context;
  final WidgetRef ref;

  /// What the list shows; decides which messages of a conversation an action
  /// touches.
  final MailboxRef? scope;
  final bool threaded;

  MailRepository get _repo => ref.read(repositoryProvider);

  /// The mailboxes the messages acted on are in, when the caller has them
  /// at hand; otherwise every account's.
  final List<Mailbox>? _mailboxes;

  Map<String, Mailbox> get _boxes => {
    for (final m in _mailboxes ?? ref.read(mailboxesProvider).value ?? const <Mailbox>[]) m.id: m,
  };

  /// The messages an action on [row] applies to: in a real mailbox, the
  /// conversation's messages in that mailbox; elsewhere, those outside Sent,
  /// Drafts, Trash and Junk.
  Future<List<EmailSummary>> members(ThreadSummary row) async {
    if (!threaded || row.messageCount <= 1) return [row.latest];
    final all = await _repo.watchConversation(row.latest.id).first;
    final boxes = _boxes;
    final kept = all.where((e) {
      if (scope case RealMailboxRef(:final mailboxId)) return e.mailboxId == mailboxId;
      final role = boxes[e.mailboxId]?.role;
      return role != MailboxRole.sent &&
          role != MailboxRole.drafts &&
          role != MailboxRole.trash &&
          role != MailboxRole.junk;
    }).toList();
    return kept.isEmpty ? [row.latest] : kept;
  }

  Future<List<EmailSummary>> _membersOf(Iterable<ThreadSummary> rows) async => [
    for (final r in rows) ...await members(r),
  ];

  Future<void> setRead(Iterable<ThreadSummary> rows, {required bool read}) async {
    // Reading state covers the whole conversation, including your replies.
    final emails = <EmailSummary>[];
    for (final r in rows) {
      if (threaded && r.messageCount > 1) {
        emails.addAll(await _repo.watchConversation(r.latest.id).first);
      } else {
        emails.add(r.latest);
      }
    }
    // Read, a message that woke from snooze is ordinary again.
    final woken = read && emails.any((e) => e.keywords.contains(Keywords.newAgain));
    await _repo.setKeywords(
      [for (final e in emails) e.id],
      add: read ? const {Keywords.seen} : const {},
      remove: read ? (woken ? const {Keywords.newAgain} : const {}) : const {Keywords.seen},
    );
  }

  /// Flags only the newest message, as Apple Mail does.
  Future<void> setFlag(Iterable<ThreadSummary> rows, {required bool flagged}) => _repo.setKeywords(
    [for (final r in rows) r.latest.id],
    add: flagged ? const {Keywords.flagged} : const {},
    remove: flagged ? const {} : const {Keywords.flagged},
  );

  Future<void> setTags(ThreadSummary row, Set<String> tags) async {
    final current = row.latest.tags.toSet();
    await _repo.setKeywords([row.latest.id], add: tags.difference(current), remove: current.difference(tags));
  }

  Future<void> archive(Iterable<ThreadSummary> rows) async => archiveEmails(await _membersOf(rows));

  Future<void> trash(Iterable<ThreadSummary> rows) async => trashEmails(await _membersOf(rows));

  Future<void> junk(Iterable<ThreadSummary> rows, {required bool junk}) async =>
      junkEmails(await _membersOf(rows), junk: junk);

  /// Moves archived conversations back to their account's inbox.
  Future<void> toInbox(Iterable<ThreadSummary> rows) async {
    final emails = await _membersOf(rows);
    final boxes = _boxes.values;
    await _withUndo(emails, _label(emails.length, (n) => 'Moved $n to Inbox'), () async {
      final byAccount = <String, List<String>>{};
      for (final e in emails) {
        byAccount.putIfAbsent(e.accountId, () => []).add(e.id);
      }
      for (final MapEntry(key: account, value: ids) in byAccount.entries) {
        final inbox = boxes.where((b) => b.accountId == account && b.role == MailboxRole.inbox).firstOrNull;
        if (inbox != null) await _repo.move(ids, inbox.id);
      }
    });
  }

  /// Asks for a target mailbox, then moves.
  Future<void> moveWithPicker(Iterable<ThreadSummary> rows) async {
    final list = rows.toList();
    if (list.isEmpty) return;
    final accounts = {for (final r in list) r.latest.accountId};
    final messenger = ScaffoldMessenger.of(context);
    if (accounts.length > 1) {
      showSnack(messenger, 'Select messages from one account to move them.');
      return;
    }
    final accountId = accounts.single;
    final account = (ref.read(accountsProvider).value ?? const <MailAccount>[])
        .where((a) => a.id == accountId)
        .firstOrNull;
    final target = await showMailboxPicker(
      context,
      mailboxes: ref.read(mailboxesProvider).value ?? const [],
      accountId: accountId,
      accountName: account?.displayName,
      disabled: {for (final r in list) r.latest.mailboxId},
      showAllFolders: ref.read(showAllFoldersProvider).contains(accountId),
    );
    if (target == null) return;
    await moveEmails(await _membersOf(list), target);
  }

  /// Whether [email] waits in its account's Snoozed folder.
  bool isSnoozed(EmailSummary email) {
    final box = _boxes[email.mailboxId];
    return box != null && Snooze.isFolder(box);
  }

  /// The Snooze sheet; [current] is the time of a snoozed message.
  Future<DateTime?> askSnoozeTime({DateTime? current}) => showSnoozeSheet(
    context,
    now: clock.now(),
    current: current,
    title: current == null ? 'Snooze' : 'Change Snooze Time',
  );

  /// Asks when, then snoozes the conversations of [rows] (or gives snoozed
  /// ones a new time). Returns whether it happened.
  Future<bool> snooze(Iterable<ThreadSummary> rows) async {
    final list = rows.toList();
    if (list.isEmpty) return false;
    final at = await askSnoozeTime(current: list.length == 1 ? list.single.latest.snoozedUntil : null);
    if (at == null || !context.mounted) return false;
    return snoozeEmails(await _membersOf(list), at);
  }

  /// Wakes the snoozed conversations of [rows] now.
  Future<bool> wake(Iterable<ThreadSummary> rows) async => wakeEmails(await _membersOf(rows));

  // Messages ----------------------------------------------------------------------------

  /// Archives [emails]. Returns whether it happened.
  Future<bool> archiveEmails(List<EmailSummary> emails) =>
      _withUndo(emails, _label(emails.length, (n) => 'Archived $n'), () => _repo.archive(_ids(emails)));

  /// Moves [emails] to Trash; those already there are deleted permanently,
  /// after asking. Returns whether it happened (false if not confirmed).
  Future<bool> trashEmails(List<EmailSummary> emails) async {
    if (emails.isEmpty) return false;
    final boxes = _boxes;
    final inTrash = [
      for (final e in emails)
        if (boxes[e.mailboxId]?.role == MailboxRole.trash) e,
    ];
    final others = [
      for (final e in emails)
        if (boxes[e.mailboxId]?.role != MailboxRole.trash) e,
    ];
    if (inTrash.isNotEmpty) {
      final n = inTrash.length;
      final ok = await confirmDestructive(
        context,
        title: n == 1 ? 'Delete this message permanently?' : 'Delete $n messages permanently?',
        message: 'This can’t be undone.',
        action: 'Delete Permanently',
      );
      if (!ok || !context.mounted) return false;
    }
    return _withUndo(
      emails,
      others.isEmpty ? _label(emails.length, (n) => 'Deleted $n') : _label(others.length, (n) => 'Moved $n to Trash'),
      () => _repo.trash(_ids(emails)),
      undoable: others,
    );
  }

  /// Moves [emails] to Junk (or, with [junk] false, back to the inbox).
  Future<bool> junkEmails(List<EmailSummary> emails, {required bool junk}) => _withUndo(
    emails,
    _label(emails.length, (n) => junk ? 'Moved $n to Junk' : 'Moved $n to Inbox'),
    () => _repo.markJunk(_ids(emails), junk: junk),
    restoreKeywords: const {Keywords.junk, Keywords.notJunk},
  );

  /// Moves [emails] to [targetMailboxId].
  Future<bool> moveEmails(List<EmailSummary> emails, String targetMailboxId) {
    final name = _boxes[targetMailboxId]?.name ?? 'mailbox';
    return _withUndo(
      emails,
      _label(emails.length, (n) => 'Moved $n to $name'),
      () => _repo.move(_ids(emails), targetMailboxId),
    );
  }

  /// Snoozes [emails] until [at]; Undo brings them back as they were. Asks
  /// the system to wake Loupe then. Returns whether it happened.
  Future<bool> snoozeEmails(List<EmailSummary> emails, DateTime at) async {
    final when = formatSendTimeFor(context, at, now: DateTime.now());
    var storage = SnoozeStorage.server;
    final ok = await _withUndo(
      emails,
      _label(emails.length, (n) => 'Snoozed $n until $when'),
      () async => storage = await _repo.snooze(_ids(emails), at),
      restoreKeywords: {Snooze.keyword(at), for (final e in emails) ...Snooze.keywordsIn(e.keywords)},
      relabel: () => storage == SnoozeStorage.device
          ? 'Snoozed until $when on this device only: the server can’t store snooze times.'
          : null,
    );
    if (ok && context.mounted) wakeUpAt(ref, at);
    return ok;
  }

  /// Wakes snoozed [emails] now: back to the Inbox, unread.
  Future<bool> wakeEmails(List<EmailSummary> emails) => _withUndo(
    emails,
    _label(emails.length, (n) => 'Moved $n to Inbox'),
    () => _repo.unsnooze(_ids(emails)),
    restoreKeywords: {Keywords.seen, Keywords.newAgain, for (final e in emails) ...Snooze.keywordsIn(e.keywords)},
  );

  static List<String> _ids(List<EmailSummary> emails) => [for (final e in emails) e.id];

  /// "Archived 1 message", "Moved 3 messages to Junk".
  static String _label(int count, String Function(String messages) text) =>
      text(count == 1 ? '1 message' : '$count messages');

  /// Runs [action] and shows [label] (or what [relabel] says afterwards)
  /// with Undo for [undoable] (default: all of [emails]). Errors are shown
  /// instead. Returns whether it ran.
  Future<bool> _withUndo(
    List<EmailSummary> emails,
    String label,
    Future<void> Function() action, {
    List<EmailSummary>? undoable,
    Set<String> restoreKeywords = const {},
    String? Function()? relabel,
  }) async {
    if (emails.isEmpty) return false;
    final messenger = ScaffoldMessenger.maybeOf(context);
    final repo = _repo;
    final restore = undoable ?? emails;
    unawaited(HapticFeedback.lightImpact());
    try {
      await action();
    } on MailException catch (e) {
      if (messenger != null) showSnack(messenger, e.message);
      return false;
    }
    if (messenger != null) {
      showSnack(
        messenger,
        relabel?.call() ?? label,
        action: restore.isEmpty
            ? null
            : SnackBarAction(
                label: 'Undo',
                onPressed: () async {
                  try {
                    await restoreMailboxes(repo, restore, keywords: restoreKeywords);
                  } on MailException catch (e) {
                    showSnack(messenger, e.message);
                  }
                },
              ),
      );
    }
    return true;
  }

  /// Undo: moves each of [emails] back to the mailbox it was in when the
  /// summary was taken, and sets or clears each of [keywords] as it was.
  static Future<void> restoreMailboxes(
    MailRepository repo,
    List<EmailSummary> emails, {
    Set<String> keywords = const {},
  }) async {
    final byBox = <String, List<String>>{};
    for (final e in emails) {
      byBox.putIfAbsent(e.mailboxId, () => []).add(e.id);
    }
    for (final MapEntry(key: box, value: ids) in byBox.entries) {
      await repo.move(ids, box);
    }
    for (final k in keywords) {
      final had = [
        for (final e in emails)
          if (e.keywords.contains(k)) e.id,
      ];
      final hadNot = [
        for (final e in emails)
          if (!e.keywords.contains(k)) e.id,
      ];
      if (had.isNotEmpty) await repo.setKeywords(had, add: {k});
      if (hadNot.isNotEmpty) await repo.setKeywords(hadNot, remove: {k});
    }
  }

  // Swipes ----------------------------------------------------------------------------

  SwipeActionSpec? _swipe(SwipeAction action, ThreadSummary row, {required bool unread}) {
    final colors = LoupeColors.of(context);
    final role = _boxes[row.latest.mailboxId]?.role;
    return switch (action) {
      SwipeAction.none => null,
      SwipeAction.toggleRead => SwipeActionSpec(
        icon: unread ? LoupeIcons.swipeMarkRead : LoupeIcons.swipeMarkUnread,
        label: unread ? 'Read' : 'Unread',
        color: colors.swipeRead,
        onTriggered: () => setRead([row], read: unread),
      ),
      SwipeAction.toggleFlag => SwipeActionSpec(
        icon: LoupeIcons.swipeFlag,
        label: row.latest.isFlagged ? 'Unflag' : 'Flag',
        color: colors.swipeFlag,
        onTriggered: () => setFlag([row], flagged: !row.latest.isFlagged),
      ),
      SwipeAction.archive when role == MailboxRole.archive || role == MailboxRole.all => SwipeActionSpec(
        icon: LoupeIcons.swipeMoveToInbox,
        label: 'Inbox',
        color: colors.swipeArchive,
        removesRow: true,
        onTriggered: () => toInbox([row]),
      ),
      SwipeAction.archive => SwipeActionSpec(
        icon: LoupeIcons.swipeArchive,
        label: 'Archive',
        color: colors.swipeArchive,
        removesRow: true,
        onTriggered: () => archive([row]),
      ),
      SwipeAction.trash => SwipeActionSpec(
        icon: LoupeIcons.swipeTrash,
        label: role == MailboxRole.trash ? 'Delete' : 'Trash',
        color: colors.swipeTrash,
        // Deleting permanently asks first, so the row stays until confirmed.
        removesRow: role != MailboxRole.trash,
        onTriggered: () => trash([row]),
      ),
      SwipeAction.move => SwipeActionSpec(
        icon: LoupeIcons.swipeMove,
        label: 'Move',
        color: colors.swipeArchive,
        onTriggered: () => moveWithPicker([row]),
      ),
      SwipeAction.snooze => SwipeActionSpec(
        icon: LoupeIcons.swipeSnooze,
        label: 'Snooze',
        color: colors.snooze,
        onTriggered: () => snooze([row]),
      ),
      SwipeAction.more => SwipeActionSpec(
        icon: LoupeIcons.swipeMore,
        label: 'More',
        color: colors.swipeMore,
        onTriggered: () => showMore(row),
      ),
    };
  }

  /// Leading swipes: the configured action.
  List<SwipeActionSpec> leadingSwipes(ThreadSummary row, AppSettings settings) => [
    ?_swipe(settings.swipeLeading, row, unread: row.unreadCount > 0),
  ];

  /// Trailing swipes, from the edge inwards: the configured action, Flag (as
  /// Apple Mail does, unless already there) and More.
  List<SwipeActionSpec> trailingSwipes(ThreadSummary row, AppSettings settings) {
    final unread = row.unreadCount > 0;
    final primary = settings.swipeTrailing;
    return [
      ?_swipe(primary, row, unread: unread),
      if (primary != SwipeAction.toggleFlag && settings.swipeLeading != SwipeAction.toggleFlag)
        ?_swipe(SwipeAction.toggleFlag, row, unread: unread),
      if (primary != SwipeAction.more) ?_swipe(SwipeAction.more, row, unread: unread),
    ];
  }

  // More sheet ------------------------------------------------------------------------

  Future<void> showMore(ThreadSummary row) async {
    final latest = row.latest;
    final role = _boxes[latest.mailboxId]?.role;
    final unread = row.unreadCount > 0;
    final snoozed = isSnoozed(latest);
    final recipients = {...latest.to, ...latest.cc}.length;
    final choice = await showActionSheet<String>(
      context,
      title: latest.subject.isEmpty ? null : latest.subject,
      actions: [
        const SheetAction('Reply', 'reply', icon: LoupeIcons.reply),
        if (recipients > 1) const SheetAction('Reply All', 'replyAll', icon: LoupeIcons.replyAll),
        const SheetAction('Forward', 'forward', icon: LoupeIcons.forward),
        SheetAction(latest.isFlagged ? 'Unflag' : 'Flag', 'flag', icon: LoupeIcons.flagged),
        SheetAction(
          unread ? 'Mark as Read' : 'Mark as Unread',
          'read',
          icon: unread ? LoupeIcons.markRead : LoupeIcons.markUnread,
        ),
        if (snoozed) ...[
          const SheetAction('Wake Now', 'wake', icon: LoupeIcons.wakeNow),
          const SheetAction('Change Snooze Time…', 'snooze', icon: LoupeIcons.snooze),
        ] else
          const SheetAction('Snooze…', 'snooze', icon: LoupeIcons.snooze),
        const SheetAction('Tag…', 'tag', icon: LoupeIcons.tag),
        const SheetAction('Move Message…', 'move', icon: LoupeIcons.move),
        if (role == MailboxRole.junk)
          const SheetAction('Not Junk', 'notJunk', icon: LoupeIcons.notJunk)
        else
          const SheetAction('Move to Junk', 'junk', icon: LoupeIcons.junk),
        if (role != MailboxRole.archive && role != MailboxRole.all)
          const SheetAction('Archive', 'archive', icon: LoupeIcons.archive),
        SheetAction(
          role == MailboxRole.trash ? 'Delete Permanently' : 'Trash',
          'trash',
          icon: LoupeIcons.trash,
          destructive: true,
        ),
      ],
    );
    if (choice == null || !context.mounted) return;
    switch (choice) {
      case 'reply':
        await openCompose(context, ComposeArgs(mode: ComposeMode.reply, sourceEmailId: latest.id));
      case 'replyAll':
        await openCompose(context, ComposeArgs(mode: ComposeMode.replyAll, sourceEmailId: latest.id));
      case 'forward':
        await openCompose(context, ComposeArgs(mode: ComposeMode.forward, sourceEmailId: latest.id));
      case 'flag':
        await setFlag([row], flagged: !latest.isFlagged);
      case 'read':
        await setRead([row], read: unread);
      case 'snooze':
        await snooze([row]);
      case 'wake':
        await wake([row]);
      case 'tag':
        final tags = await showTagPicker(context, current: latest.tags.toSet());
        if (tags != null) await setTags(row, tags);
      case 'move':
        await moveWithPicker([row]);
      case 'junk':
        await junk([row], junk: true);
      case 'notJunk':
        await junk([row], junk: false);
      case 'archive':
        await archive([row]);
      case 'trash':
        await trash([row]);
    }
  }
}
