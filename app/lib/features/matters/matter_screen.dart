import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../shared/avatar.dart';
import '../../shared/bars.dart';
import '../../shared/format.dart';
import '../../shared/grouped_list.dart';
import '../../shared/sheets.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../attachments/attachment_cache.dart';
import '../attachments/attachment_gallery.dart';
import '../attachments/attachment_type.dart';
import '../calendar/invitation.dart' show isCalendarAlternative;
import '../conversation/attachments.dart' show attachmentIcon;
import '../conversation/mail_streams.dart';
import '../conversation/sheets.dart' show showSnack;
import '../mailing_lists/list_providers.dart' show participantsLine;
import '../openpgp/content_loader.dart';
import 'matter_candidates.dart';
import 'matter_providers.dart';
import 'matter_status.dart';
import 'matter_text.dart';

/// One conversation of a matter with its messages here (oldest first; none
/// when they are only in Trash or not on this phone).
typedef MatterConversation = ({MatterMember member, List<EmailSummary> messages});

/// The conversations of [matter], in the order they were added, each with
/// its messages (a message counts once, for the first member it is part of).
List<MatterConversation> matterConversations(Matter matter, List<EmailSummary> messages) {
  final rest = [...messages];
  final out = <MatterConversation>[];
  for (final member in matter.members) {
    final mine = rest.where(member.includes).toList();
    rest.removeWhere(member.includes);
    out.add((member: member, messages: mine));
  }
  return out;
}

/// A file attached to one of a matter's messages.
typedef MatterDocument = ({EmailSummary email, Attachment attachment, EmailContent content});

/// A matter's documents, newest first: every file attached to its messages,
/// each on its own row (two files of the same name are two documents, with
/// their dates). [incomplete] when some messages couldn't be opened.
final matterDocumentsProvider = FutureProvider.autoDispose
    .family<({List<MatterDocument> documents, bool incomplete}), String>((ref, id) async {
      final messages = await ref.watch(matterMessagesProvider(id).future);
      final loader = ref.watch(contentLoaderProvider);
      final documents = <MatterDocument>[];
      var incomplete = false;
      for (final m in messages.reversed) {
        if (!m.hasAttachment) continue;
        try {
          final content = await loader.loadContent(m.id);
          for (final a in content.visibleAttachments) {
            if (!isCalendarAlternative(a)) documents.add((email: m, attachment: a, content: content));
          }
        } on Object {
          incomplete = true;
        }
      }
      return (documents: documents, incomplete: incomplete);
    });

/// A matter: Where Things Stand (Private AI, on a tap), open actions and
/// waits, its conversations, suggested ones, documents, the people in it,
/// every message in the order they came, and what the user changed. The ⋯
/// menu renames, splits, merges and deletes; none of it touches the mail.
class MatterScreen extends ConsumerStatefulWidget {
  const MatterScreen({super.key, required this.matterId});

  final String matterId;

  @override
  ConsumerState<MatterScreen> createState() => _MatterScreenState();
}

class _MatterScreenState extends ConsumerState<MatterScreen> {
  /// Choosing conversations for Split.
  bool _splitting = false;
  final _chosen = <ConversationKey>{};

  /// Members already looked for after their thread came up empty.
  final _looked = <ConversationKey>{};

  MattersController? get _controller => ref.read(mattersControllerProvider);

  /// A member whose thread shows no messages may have moved to another
  /// thread (a late reply joined two): find its message and follow it.
  void _followMoved(Matter matter, List<MatterConversation> conversations) {
    final records = matterRecordsOf(ref.read(repositoryProvider));
    final controller = _controller;
    if (records == null || controller == null) return;
    for (final c in conversations) {
      if (c.messages.isNotEmpty || !_looked.add(c.member.key)) continue;
      unawaited(
        records.locateMessage(c.member.ref).then((found) async {
          if (found != null && conversationOf(found) != c.member.key) {
            await controller.relocate(matter.id, c.member, found);
          }
        }),
      );
    }
  }

  Future<void> _act(Future<void> Function() action) async {
    final messenger = ScaffoldMessenger.of(context);
    final failed = context.l10n.conversationSomethingWentWrong;
    try {
      await action();
    } on Object {
      showSnack(messenger, failed);
    }
  }

  Future<void> _menu(Matter matter) async {
    unawaited(HapticFeedback.selectionClick());
    final l10n = context.l10n;
    final choice = await showActionSheet<String>(
      context,
      title: matter.name,
      actions: [
        SheetAction(l10n.mattersRename, 'rename', icon: LoupeIcons.rename),
        if (matter.members.isNotEmpty) SheetAction(l10n.mattersSplit, 'split', icon: LoupeIcons.splitMatter),
        SheetAction(l10n.mattersMergeInto, 'merge', icon: LoupeIcons.mergeMatter),
        SheetAction(l10n.mattersDelete, 'delete', icon: LoupeIcons.trash, destructive: true),
      ],
    );
    if (!mounted) return;
    switch (choice) {
      case 'rename':
        await _rename(matter);
      case 'split':
        setState(() {
          _splitting = true;
          _chosen.clear();
        });
      case 'merge':
        await _merge(matter);
      case 'delete':
        await _delete(matter);
    }
  }

  Future<void> _rename(Matter matter) async {
    final name = await showTextPrompt(context, title: context.l10n.mattersRenameTitle, initial: matter.name);
    if (name == null || name.trim().isEmpty || !mounted) return;
    await _act(() async => await _controller?.rename(matter.id, name));
  }

  Future<void> _merge(Matter matter) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final others = [
      for (final m in ref.read(mattersProvider).value ?? const <Matter>[])
        if (m.id != matter.id) m,
    ];
    if (others.isEmpty) {
      showSnack(messenger, l10n.mattersNoOtherMatter);
      return;
    }
    final target = await showActionSheet<Matter>(
      context,
      title: l10n.mattersMergeTitle(matter.name),
      actions: [for (final m in others) SheetAction(m.name, m)],
    );
    if (target == null || !mounted) return;
    await _act(() async {
      await _controller?.merge(matter.id, target.id);
      showSnack(messenger, l10n.mattersMerged(target.name));
      if (mounted) context.pushReplacement(Routes.matter(target.id));
    });
  }

  Future<void> _delete(Matter matter) async {
    final l10n = context.l10n;
    final ok = await confirmDestructive(
      context,
      title: l10n.mattersDeleteTitle(matter.name),
      message: l10n.mattersDeleteMessage,
      action: l10n.mattersDelete,
    );
    if (!ok || !mounted) return;
    await _act(() async {
      await _controller?.delete(matter.id);
      if (mounted) Navigator.of(context).maybePop();
    });
  }

  Future<void> _split(Matter matter) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final name = await showTextPrompt(context, title: l10n.mattersNewMatterTitle, placeholder: l10n.mattersNameHint);
    if (name == null || name.trim().isEmpty || !mounted) return;
    final moving = {..._chosen};
    await _act(() async {
      final split = await _controller?.split(matter.id, moving, name);
      if (split == null) return;
      showSnack(messenger, l10n.mattersMovedTo(split.members.length, split.name));
      if (mounted) {
        setState(() {
          _splitting = false;
          _chosen.clear();
        });
      }
    });
  }

  Future<void> _remove(Matter matter, MatterConversation c) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final controller = _controller;
    if (controller == null) return;
    final subject = c.messages.firstOrNull?.subject ?? c.member.ref.subject;
    await _act(() async {
      final removed = await controller.remove(matter.id, c.member.key, subject: subject);
      if (removed == null) return;
      showSnack(
        messenger,
        l10n.mattersRemoved(matter.name),
        action: SnackBarAction(
          label: l10n.commonUndo,
          onPressed: () => unawaited(controller.restore(matter.id, removed, subject: subject)),
        ),
      );
    });
  }

  Future<void> _conversationMenu(Matter matter, MatterConversation c) async {
    final l10n = context.l10n;
    final remove = await showActionSheet<bool>(
      context,
      title: c.messages.lastOrNull?.subject ?? c.member.ref.subject,
      actions: [SheetAction(l10n.mattersRemove, true, icon: LoupeIcons.removeFromMatter, destructive: true)],
    );
    if (remove == true && mounted) await _remove(matter, c);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final value = ref.watch(matterProvider(widget.matterId));
    final matter = value.value;
    if (matter == null) {
      return GroupedPage(
        title: '',
        children: [
          if (!value.isLoading)
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 80, 32, 0),
              child: Text(l10n.mattersGone, style: styles.footnote, textAlign: TextAlign.center),
            ),
        ],
      );
    }
    final loaded = ref.watch(matterMessagesProvider(matter.id));
    final messages = loaded.value ?? const <EmailSummary>[];
    final conversations = matterConversations(matter, messages);
    if (loaded.hasValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _followMoved(matter, conversations);
      });
    }
    final open = ref.watch(matterOpenItemsProvider(matter.id));

    return PopScope(
      canPop: !_splitting,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _splitting) setState(() => _splitting = false);
      },
      child: Scaffold(
        backgroundColor: colors.groupedBackground,
        bottomNavigationBar: _splitting
            ? LoupeBottomBar(
                center: CupertinoButton(
                  key: const Key('matter-split-move'),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  onPressed: _chosen.isEmpty ? null : () => _split(matter),
                  child: Text(l10n.mattersSplitMove, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              )
            : null,
        body: CustomScrollView(
          slivers: [
            LoupeTitleBar(
              title: _splitting ? l10n.mattersSplitTitle : matter.name,
              trailing: [
                if (_splitting)
                  BarTextButton(
                    label: l10n.commonCancel,
                    onPressed: () => setState(() {
                      _splitting = false;
                      _chosen.clear();
                    }),
                  )
                else
                  BarIconButton(
                    key: const Key('matter-menu'),
                    icon: LoupeIcons.moreCircle,
                    tooltip: l10n.mattersMenu,
                    onPressed: () => _menu(matter),
                  ),
              ],
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            if (!_splitting) ...[
              SliverToBoxAdapter(
                child: MatterStatusCard(matter: matter, messages: messages),
              ),
              for (final (waiting, header) in [(false, l10n.mattersOpenActions), (true, l10n.mattersWaiting)])
                if (open.where((i) => i.waitingOnOthers == waiting).toList() case final items when items.isNotEmpty)
                  SliverToBoxAdapter(
                    child: InsetGroup(
                      header: header,
                      children: [for (final item in items) _OpenItemRow(item: item)],
                    ),
                  ),
            ],
            SliverToBoxAdapter(
              child: InsetGroup(
                key: const Key('matter-conversations'),
                header: l10n.mattersConversations,
                footer: conversations.isEmpty ? l10n.mattersNoConversations : null,
                children: [
                  for (final c in conversations)
                    _ConversationRow(
                      key: ValueKey(c.member.key),
                      conversation: c,
                      choosing: _splitting,
                      chosen: _chosen.contains(c.member.key),
                      onTap: _splitting
                          ? () => setState(
                              () => _chosen.contains(c.member.key)
                                  ? _chosen.remove(c.member.key)
                                  : _chosen.add(c.member.key),
                            )
                          : c.messages.isEmpty
                          ? null
                          : () => context.push(Routes.message(c.messages.last.id)),
                      onMore: _splitting ? null : () => _conversationMenu(matter, c),
                    ),
                ],
              ),
            ),
            if (!_splitting) ...[
              SliverToBoxAdapter(child: _Suggestions(matter: matter)),
              SliverToBoxAdapter(child: _Documents(matterId: matter.id)),
              SliverToBoxAdapter(child: _People(messages: messages)),
              if (messages.isNotEmpty)
                SliverToBoxAdapter(
                  child: InsetGroup(
                    key: const Key('matter-history'),
                    header: l10n.mattersHistory,
                    separatorIndent: 16,
                    children: [for (final m in messages) _HistoryRow(email: m)],
                  ),
                ),
              SliverToBoxAdapter(child: _Activity(matter: matter)),
            ],
            SliverToBoxAdapter(child: SizedBox(height: 24 + MediaQuery.paddingOf(context).bottom)),
          ],
        ),
      ),
    );
  }
}

/// A conversation of the matter: its subject, who wrote and how many
/// messages, and the newest date; ⋯ takes it out. While splitting, a check
/// circle chooses it.
class _ConversationRow extends StatelessWidget {
  const _ConversationRow({
    super.key,
    required this.conversation,
    required this.choosing,
    required this.chosen,
    required this.onTap,
    required this.onMore,
  });

  final MatterConversation conversation;
  final bool choosing;
  final bool chosen;
  final VoidCallback? onTap;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final messages = conversation.messages;
    final latest = messages.lastOrNull;
    final subject = latest?.subject ?? conversation.member.ref.subject;
    final people = <EmailAddress>[];
    for (final m in messages) {
      for (final f in m.from) {
        if (!people.any((p) => p.email.toLowerCase() == f.email.toLowerCase())) people.add(f);
      }
    }
    return GroupedRow(
      leading: choosing
          ? Icon(
              chosen ? LoupeIcons.selected : LoupeIcons.unselected,
              color: chosen ? colors.unreadDot : colors.tertiaryText,
            )
          : Icon(LoupeIcons.conversations, color: colors.unreadDot),
      title: subject.trim().isEmpty ? l10n.mailNoSubject : subject,
      subtitle: messages.isEmpty
          ? l10n.mattersConversationGone
          : l10n.mattersConversationDetail(participantsLine(people), messages.length),
      detail: latest == null ? null : formatListDate(latest.receivedAt, l10n: l10n),
      chevron: false,
      onTap: onTap,
      onLongPress: onMore,
      trailing: onMore == null
          ? null
          : Tooltip(
              message: l10n.commonMore,
              excludeFromSemantics: true,
              child: Semantics(
                button: true,
                label: l10n.mattersRemove,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(36, 36),
                  onPressed: onMore,
                  child: Icon(LoupeIcons.more, size: 20, color: colors.secondaryText),
                ),
              ),
            ),
    );
  }
}

/// An open action or wait; a tap opens the message it comes from.
class _OpenItemRow extends ConsumerWidget {
  const _OpenItemRow({required this.item});

  final MatterOpenItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return GroupedRow(
      leading: Icon(item.waitingOnOthers ? LoupeIcons.time : LoupeIcons.check),
      title: item.text,
      detail: item.due == null ? null : formatListDate(item.due!, l10n: l10n),
      onTap: () async {
        final found = await matterRecordsOf(ref.read(repositoryProvider))?.locateMessage(item.source);
        if (found != null && context.mounted) await context.push(Routes.message(found.id));
      },
    );
  }
}

/// Conversations that may belong, with why; Add or Not This One. Nothing is
/// added without a tap.
class _Suggestions extends ConsumerWidget {
  const _Suggestions({required this.matter});

  final Matter matter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final candidates = ref.watch(matterCandidatesProvider(matter.id)).value ?? const <MatterCandidate>[];
    if (candidates.isEmpty) return const SizedBox.shrink();
    final l10n = context.l10n;
    final controller = ref.read(mattersControllerProvider);
    return InsetGroup(
      key: const Key('matter-suggestions'),
      header: l10n.mattersSuggestions,
      footer: l10n.mattersSuggestionsFooter,
      separatorIndent: 16,
      children: [
        for (final c in candidates)
          _SuggestionRow(
            key: ValueKey(conversationOf(c.email)),
            candidate: c,
            onAdd: controller == null ? null : () => unawaited(controller.add(matter.id, c.email, reason: c.reason)),
            onDecline: controller == null ? null : () => unawaited(controller.decline(matter.id, c.email)),
          ),
      ],
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({super.key, required this.candidate, required this.onAdd, required this.onDecline});

  final MatterCandidate candidate;
  final VoidCallback? onAdd;
  final VoidCallback? onDecline;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final e = candidate.email;
    final weak = candidate.reason.isWeak;
    return InkWell(
      onTap: () => context.push(Routes.message(e.id)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 8, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    e.sender?.displayName ?? l10n.sharedUnknownSender,
                    style: styles.sender,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(formatListDate(e.receivedAt, l10n: l10n), style: styles.date),
              ],
            ),
            Text(
              e.subject.trim().isEmpty ? l10n.mailNoSubject : e.subject,
              style: styles.subject,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1, right: 6),
                    child: Icon(
                      weak ? LoupeIcons.info : LoupeIcons.suggestion,
                      size: 15,
                      color: weak ? colors.secondaryText : colors.unreadDot,
                    ),
                  ),
                  Expanded(child: Text(matterReasonText(candidate.reason, l10n), style: styles.footnote)),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Wrap(
                alignment: WrapAlignment.end,
                children: [
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    minimumSize: const Size(44, 36),
                    onPressed: onDecline,
                    child: Text(l10n.mattersNotThisOne, style: TextStyle(color: colors.secondaryText)),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    minimumSize: const Size(44, 36),
                    onPressed: onAdd,
                    child: Text(l10n.commonAdd, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The files attached to the matter's messages, newest first.
class _Documents extends ConsumerWidget {
  const _Documents({required this.matterId});

  final String matterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(matterDocumentsProvider(matterId)).value;
    if (value == null || (value.documents.isEmpty && !value.incomplete)) return const SizedBox.shrink();
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    return InsetGroup(
      key: const Key('matter-documents'),
      header: l10n.mattersDocuments,
      footer: value.incomplete ? l10n.mattersDocumentsIncomplete : null,
      children: [
        for (final d in value.documents)
          GroupedRow(
            leading: Icon(attachmentIcon(d.attachment.mimeType, d.attachment.filename), color: colors.unreadDot),
            title: d.attachment.filename?.isNotEmpty == true
                ? d.attachment.filename!
                : l10n.conversationAttachmentUntitled,
            subtitle: l10n.mattersDocumentDetail(
              d.email.sender?.displayName ?? l10n.sharedUnknownSender,
              formatListDate(d.email.receivedAt, l10n: l10n),
            ),
            onTap: () => _open(context, ref, d),
          ),
      ],
    );
  }

  Future<void> _open(BuildContext context, WidgetRef ref, MatterDocument d) async {
    if (attachmentKindOf(d.attachment.mimeType, d.attachment.filename) == AttachmentKind.image) {
      await openAttachmentGallery(
        context,
        content: d.content,
        current: d.attachment,
        cache: ref.read(attachmentCacheProvider),
        download: (a) => ref.read(contentLoaderProvider).loadAttachment(d.email.id, a.partId),
      );
    } else {
      await context.push(Routes.attachment(d.email.id, d.attachment.partId));
    }
  }
}

/// Who wrote in the matter or was written to, the most involved first; the
/// user's own addresses are left out. A tap searches their mail.
class _People extends ConsumerWidget {
  const _People({required this.messages});

  final List<EmailSummary> messages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final own = ownAddresses(ref.watch(accountsProvider).value ?? const <MailAccount>[]);
    final people = <String, ({EmailAddress address, int count})>{};
    for (final m in messages) {
      final involved = {
        for (final a in [...m.from, ...m.to, ...m.cc]) a.email.toLowerCase(): a,
      };
      for (final MapEntry(key: email, value: a) in involved.entries) {
        if (own.contains(email)) continue;
        final known = people[email];
        people[email] = (address: known?.address ?? a, count: (known?.count ?? 0) + 1);
      }
    }
    if (people.isEmpty) return const SizedBox.shrink();
    final sorted = people.values.toList()
      ..sort((a, b) {
        final byCount = b.count.compareTo(a.count);
        return byCount != 0 ? byCount : a.address.displayName.compareTo(b.address.displayName);
      });
    final l10n = context.l10n;
    return InsetGroup(
      key: const Key('matter-people'),
      header: l10n.mattersPeople,
      separatorIndent: 54,
      children: [
        for (final p in sorted)
          GroupedRow(
            leading: SenderAvatar(address: p.address, size: 28),
            title: p.address.displayName,
            subtitle: p.address.email,
            detail: l10n.commonMessageCount(p.count),
            onTap: () => context.push(Routes.search('f:"${p.address.email}"')),
          ),
      ],
    );
  }
}

/// One message of the matter's history: sender and date, subject, a line of
/// its text. A tap opens its conversation.
class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.email});

  final EmailSummary email;

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    return InkWell(
      onTap: () => context.push(Routes.message(email.id)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 9, 14, 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    email.sender?.displayName ?? l10n.sharedUnknownSender,
                    style: styles.sender,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (email.hasAttachment)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(LoupeIcons.attachment, size: 14, semanticLabel: l10n.sharedAttachment),
                  ),
                Text(formatListDate(email.receivedAt, l10n: l10n), style: styles.date),
              ],
            ),
            Text(
              email.subject.trim().isEmpty ? l10n.mailNoSubject : email.subject,
              style: styles.subject,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (email.preview.isNotEmpty)
              Text(email.preview, style: styles.preview, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

/// What the user changed, newest first.
class _Activity extends StatelessWidget {
  const _Activity({required this.matter});

  final Matter matter;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return InsetGroup(
      key: const Key('matter-activity'),
      header: l10n.mattersActivity,
      separatorIndent: 16,
      children: [
        for (final e in matter.history.reversed)
          GroupedRow(
            title: matterEventText(e, l10n),
            subtitle: formatFullDate(e.at, l10n: l10n),
            chevron: false,
          ),
      ],
    );
  }
}
