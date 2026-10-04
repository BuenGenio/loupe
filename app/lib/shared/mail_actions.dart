import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../features/compose/compose_args.dart';
import '../providers.dart';
import '../settings/app_settings.dart';
import '../theme/theme.dart';
import 'sheets.dart';
import 'swipe_row.dart';

/// Message actions shared by lists, search results and smart mailboxes:
/// they work on whole conversations, are optimistic, and offer Undo.
class MailActions {
  MailActions(this.context, this.ref, {required this.scope, required this.threaded});

  final BuildContext context;
  final WidgetRef ref;

  /// What the list shows; decides which messages of a conversation an action
  /// touches.
  final MailboxRef? scope;
  final bool threaded;

  MailRepository get _repo => ref.read(repositoryProvider);

  Map<String, Mailbox> get _boxes => {for (final m in ref.read(mailboxesProvider).value ?? const <Mailbox>[]) m.id: m};

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
    final ids = <String>[];
    for (final r in rows) {
      if (threaded && r.messageCount > 1) {
        ids.addAll((await _repo.watchConversation(r.latest.id).first).map((e) => e.id));
      } else {
        ids.add(r.latest.id);
      }
    }
    await _repo.setKeywords(
      ids,
      add: read ? const {Keywords.seen} : const {},
      remove: read ? const {} : const {Keywords.seen},
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

  Future<void> archive(Iterable<ThreadSummary> rows) async {
    final emails = await _membersOf(rows);
    await _withUndo(emails, 'Archived', () => _repo.archive(_ids(emails)));
  }

  Future<void> trash(Iterable<ThreadSummary> rows) async {
    final emails = await _membersOf(rows);
    final permanent = emails.every((e) => _boxes[e.mailboxId]?.role == MailboxRole.trash);
    await _withUndo(
      emails,
      permanent ? 'Deleted' : 'Moved to Trash',
      () => _repo.trash(_ids(emails)),
      undo: !permanent,
    );
  }

  Future<void> junk(Iterable<ThreadSummary> rows, {required bool junk}) async {
    final emails = await _membersOf(rows);
    await _withUndo(emails, junk ? 'Moved to Junk' : 'Moved to Inbox', () => _repo.markJunk(_ids(emails), junk: junk));
  }

  /// Moves archived conversations back to their account's inbox.
  Future<void> toInbox(Iterable<ThreadSummary> rows) async {
    final emails = await _membersOf(rows);
    final boxes = _boxes.values;
    await _withUndo(emails, 'Moved to Inbox', () async {
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
      messenger.showSnackBar(const SnackBar(content: Text('Select messages from one account to move them.')));
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
    );
    if (target == null) return;
    final emails = await _membersOf(list);
    final name = _boxes[target]?.name ?? 'mailbox';
    await _withUndo(emails, 'Moved to $name', () => _repo.move(_ids(emails), target));
  }

  static List<String> _ids(List<EmailSummary> emails) => [for (final e in emails) e.id];

  Future<void> _withUndo(
    List<EmailSummary> emails,
    String verb,
    Future<void> Function() action, {
    bool undo = true,
  }) async {
    if (emails.isEmpty) return;
    final messenger = ScaffoldMessenger.maybeOf(context);
    final repo = _repo;
    final origins = {for (final e in emails) e.id: e.mailboxId};
    unawaited(HapticFeedback.lightImpact());
    await action();
    final count = emails.length;
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$verb ${count == 1 ? '1 message' : '$count messages'}'),
          duration: const Duration(seconds: 4),
          action: undo
              ? SnackBarAction(
                  label: 'Undo',
                  onPressed: () async {
                    final byBox = <String, List<String>>{};
                    for (final MapEntry(key: id, value: box) in origins.entries) {
                      byBox.putIfAbsent(box, () => []).add(id);
                    }
                    for (final MapEntry(key: box, value: ids) in byBox.entries) {
                      await repo.move(ids, box);
                    }
                  },
                )
              : null,
        ),
      );
  }

  // Swipes ----------------------------------------------------------------------------

  SwipeActionSpec? _swipe(SwipeAction action, ThreadSummary row, {required bool unread}) {
    final colors = LoupeColors.of(context);
    final role = _boxes[row.latest.mailboxId]?.role;
    return switch (action) {
      SwipeAction.none => null,
      SwipeAction.toggleRead => SwipeActionSpec(
        icon: unread ? CupertinoIcons.envelope_open_fill : CupertinoIcons.envelope_badge_fill,
        label: unread ? 'Read' : 'Unread',
        color: colors.swipeRead,
        onTriggered: () => setRead([row], read: unread),
      ),
      SwipeAction.toggleFlag => SwipeActionSpec(
        icon: CupertinoIcons.flag_fill,
        label: row.latest.isFlagged ? 'Unflag' : 'Flag',
        color: colors.swipeFlag,
        onTriggered: () => setFlag([row], flagged: !row.latest.isFlagged),
      ),
      SwipeAction.archive when role == MailboxRole.archive || role == MailboxRole.all => SwipeActionSpec(
        icon: CupertinoIcons.tray_arrow_down_fill,
        label: 'Inbox',
        color: colors.swipeArchive,
        removesRow: true,
        onTriggered: () => toInbox([row]),
      ),
      SwipeAction.archive => SwipeActionSpec(
        icon: CupertinoIcons.archivebox_fill,
        label: 'Archive',
        color: colors.swipeArchive,
        removesRow: true,
        onTriggered: () => archive([row]),
      ),
      SwipeAction.trash => SwipeActionSpec(
        icon: CupertinoIcons.trash_fill,
        label: role == MailboxRole.trash ? 'Delete' : 'Trash',
        color: colors.swipeTrash,
        removesRow: true,
        onTriggered: () => trash([row]),
      ),
      SwipeAction.move => SwipeActionSpec(
        icon: CupertinoIcons.folder_fill,
        label: 'Move',
        color: colors.swipeArchive,
        onTriggered: () => moveWithPicker([row]),
      ),
      SwipeAction.more => SwipeActionSpec(
        icon: CupertinoIcons.ellipsis_circle_fill,
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
    final recipients = {...latest.to, ...latest.cc}.length;
    final choice = await showActionSheet<String>(
      context,
      title: latest.subject.isEmpty ? null : latest.subject,
      actions: [
        const SheetAction('Reply', 'reply', icon: CupertinoIcons.arrowshape_turn_up_left),
        if (recipients > 1) const SheetAction('Reply All', 'replyAll', icon: CupertinoIcons.arrowshape_turn_up_left_2),
        const SheetAction('Forward', 'forward', icon: CupertinoIcons.arrowshape_turn_up_right),
        SheetAction(latest.isFlagged ? 'Unflag' : 'Flag', 'flag', icon: CupertinoIcons.flag),
        SheetAction(
          unread ? 'Mark as Read' : 'Mark as Unread',
          'read',
          icon: unread ? CupertinoIcons.envelope_open : CupertinoIcons.envelope_badge,
        ),
        const SheetAction('Tag…', 'tag', icon: CupertinoIcons.tag),
        const SheetAction('Move Message…', 'move', icon: CupertinoIcons.folder),
        if (role == MailboxRole.junk)
          const SheetAction('Not Junk', 'notJunk', icon: CupertinoIcons.tray_arrow_up)
        else
          const SheetAction('Move to Junk', 'junk', icon: CupertinoIcons.bin_xmark),
        if (role != MailboxRole.archive && role != MailboxRole.all)
          const SheetAction('Archive', 'archive', icon: CupertinoIcons.archivebox),
        SheetAction(
          role == MailboxRole.trash ? 'Delete Permanently' : 'Trash',
          'trash',
          icon: CupertinoIcons.trash,
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
