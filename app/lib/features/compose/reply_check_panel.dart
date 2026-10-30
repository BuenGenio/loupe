import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../ai/ai_providers.dart';
import '../conversation/sheets.dart';
import '../openpgp/content_loader.dart';
import 'compose_text.dart';
import 'reply_check.dart';

// Reading the selected files ---------------------------------------------------------

/// Reads the text of a file selected in compose, so Reply Check can look
/// inside it before saying what it is. Document text extraction plugs in
/// here. Until it does, [NoAttachmentText] reads nothing: every status rests
/// on file names, and the panel says so.
abstract interface class AttachmentTextSource {
  /// What [attachment] says: [AttachmentText.read] with its text,
  /// [AttachmentText.notRead] for a kind of file this can't read, or
  /// [AttachmentText.unreadable] when reading it failed (a password, a
  /// damaged file). Asked once per selected file; an exception counts as
  /// unreadable.
  Future<AttachmentText> textOf(OutgoingAttachment attachment);
}

/// Reads no file.
final class NoAttachmentText implements AttachmentTextSource {
  const NoAttachmentText();

  @override
  Future<AttachmentText> textOf(OutgoingAttachment attachment) async => const AttachmentText.notRead();
}

final attachmentTextSourceProvider = Provider<AttachmentTextSource>((ref) => const NoAttachmentText());

// What the original asked for -------------------------------------------------------

/// The message a reply answers (or a forward passes on), and its account.
typedef ReplyCheckSource = ({String emailId, String accountId});

/// What the original message asks the reader for, and who found it.
final class ReplyRequests {
  const ReplyRequests(this.items, {required this.partial, required this.providerId, this.model});

  /// The reader's actions and documents of the message's Brief.
  final List<BriefItem> items;

  /// Only the beginning of a long message was read.
  final bool partial;
  final String providerId;
  final String? model;
}

/// Reading the original's requests failed. [message] is for logs.
final class ReplyRequestsFailed implements Exception {
  const ReplyRequestsFailed(this.message);
  final String message;

  @override
  String toString() => 'ReplyRequestsFailed: $message';
}

/// The original's requests, from a Brief of it: [BriefTask] run through
/// [AiService.run], so the reader's Brief of the same message is reused
/// rather than asked for again, when it was made from the same input
/// ([briefInputFor]) the same day. Null when Reply Check doesn't run:
/// Private AI or the feature is off, the message is gone, or it came
/// encrypted and the provider isn't on this phone. Fails with
/// [ReplyRequestsFailed], and is not retried by itself: the panel offers
/// Retry.
final replyRequestsProvider = FutureProvider.autoDispose.family<ReplyRequests?, ReplyCheckSource>((ref, source) async {
  final service = ref.watch(aiServiceForProvider((AiFeature.replyCheck, source.accountId)));
  if (service == null) return null;
  final repo = ref.watch(repositoryProvider);
  final loader = ref.watch(contentLoaderProvider);
  final cancel = CancelToken();
  ref.onDispose(cancel.cancel);
  final (EmailSummary, EmailContent)? loaded;
  try {
    final email = await repo.getEmail(source.emailId);
    loaded = email == null ? null : (email, await loader.loadContent(email.id));
  } on MailException catch (e) {
    throw ReplyRequestsFailed(e.message);
  }
  if (loaded == null) return null;
  final (email, content) = loaded;
  // Decrypted mail doesn't leave the phone.
  if (encryptedWith(content) != null && service.provider.location != ProviderLocation.onThisPhone) return null;
  final run = await service.run(BriefTask(briefInputFor(email, content), now: clock.now()), cancel: cancel);
  return switch (run) {
    AiSuccess(:final value, :final record) => ReplyRequests(
      ReplyCheck.requestsIn(value),
      partial: value.partial,
      providerId: record.providerId,
      model: record.model,
    ),
    AiFailure(:final message) => throw ReplyRequestsFailed(message),
  };
}, retry: (_, _) => null);

/// What a Brief of [email] reads: its subject, sender, date, text and the
/// names of its attachments. The reader's Brief needs the same input for
/// [AiService] to share one result between the two.
BriefInput briefInputFor(EmailSummary email, EmailContent content) => BriefInput(
  subject: protectedSubjectIn(content) ?? email.subject,
  from: email.sender?.toString() ?? '',
  date: email.sentAt ?? email.receivedAt,
  text: ComposeText.plainTextOf(content),
  attachments: [
    for (final a in content.visibleAttachments)
      if (a.filename case final name? when name.trim().isNotEmpty) name,
  ],
);

// The panel ------------------------------------------------------------------------------

/// Reply Check in one compose session: hidden or open, which request shows
/// its passage, which ones the user left out, and the text read from the
/// selected files. The compose screen owns it, so it outlives the panel
/// scrolling out of view.
final class ReplyCheckController extends ChangeNotifier {
  bool _hidden = false;
  bool _expanded = false;
  String? _open;
  final _skipped = <String>{};
  final _texts = Map<OutgoingAttachment, AttachmentText>.identity();
  final _reading = Set<OutgoingAttachment>.identity();
  bool _disposed = false;

  /// Hidden for this message: Hide was tapped.
  bool get hidden => _hidden;
  bool get expanded => _expanded;

  void hide() => _set(() => _hidden = true);
  void toggleExpanded() => _set(() => _expanded = !_expanded);

  bool isOpen(BriefItem request) => _open == _id(request);
  void toggleOpen(BriefItem request) => _set(() => _open = isOpen(request) ? null : _id(request));

  /// Left out with Don’t Check This.
  bool isSkipped(BriefItem request) => _skipped.contains(_id(request));
  void skip(BriefItem request) => _set(() => _skipped.add(_id(request)));
  void checkAll() => _set(_skipped.clear);

  /// What [attachment] says, as far as known now. The first call starts
  /// reading it; the panel updates when the text arrives.
  AttachmentText textOf(OutgoingAttachment attachment, AttachmentTextSource source) {
    if (_texts[attachment] case final known?) return known;
    if (_reading.add(attachment)) {
      unawaited(
        source.textOf(attachment).then((text) => text, onError: (Object _) => const AttachmentText.unreadable()).then((
          text,
        ) {
          _reading.remove(attachment);
          if (_disposed) return;
          _texts[attachment] = text;
          notifyListeners();
        }),
      );
    }
    return const AttachmentText.notRead();
  }

  /// Forgets the text of files no longer selected.
  void keepOnly(List<OutgoingAttachment> attachments) {
    final kept = Set<OutgoingAttachment>.identity()..addAll(attachments);
    _texts.removeWhere((a, _) => !kept.contains(a));
  }

  void _set(void Function() change) {
    change();
    notifyListeners();
  }

  static String _id(BriefItem r) => '${r.text}\u0000${r.evidence.quote}';

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// Reply Check's panel, near the attachments: a summary of what the original
/// asked for against this reply ("2 of 3 attached · 2 to do outside email"),
/// opening to the list with each request's status and the passage it comes
/// from. It only informs. It never holds up Send, never attaches anything,
/// and Hide puts it away for this message.
class ReplyCheckPanel extends ConsumerWidget {
  const ReplyCheckPanel({
    super.key,
    required this.controller,
    required this.requests,
    required this.draft,
    required this.attachments,
    required this.onRetry,
  });

  final ReplyCheckController controller;
  final AsyncValue<ReplyRequests?> requests;

  /// The user's own text, without the quoted original and the signature.
  final String draft;
  final List<OutgoingAttachment> attachments;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final source = ref.watch(attachmentTextSourceProvider);
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (controller.hidden) return const SizedBox.shrink();
        final l10n = context.l10n;
        if (requests.isLoading) {
          return _frame(context, [_header(context, l10n.composeReplyCheckChecking, busy: true)]);
        }
        if (requests.hasError) {
          return _frame(context, [
            _header(
              context,
              l10n.composeReplyCheckFailed,
              trailing: TextButton(
                key: const Key('reply-check-retry'),
                onPressed: onRetry,
                child: Text(l10n.commonRetry),
              ),
            ),
          ]);
        }
        final found = requests.value;
        if (found == null || found.items.isEmpty) return const SizedBox.shrink();
        controller.keepOnly(attachments);
        final checked = [
          for (final r in found.items)
            if (!controller.isSkipped(r)) r,
        ];
        final items = ReplyCheck.check(
          checked,
          draft: draft,
          attachments: [
            for (final a in attachments)
              ReplyAttachment(
                filename: a.filename,
                mimeType: a.mimeType,
                size: a.data.length,
                text: controller.textOf(a, source),
              ),
          ],
        );
        final summary = ReplyCheckSummary(items);
        final skipped = found.items.length - checked.length;
        final line = _summaryLine(l10n, summary);
        return _frame(context, [
          _header(context, line.isEmpty ? l10n.composeReplyCheckSkipped(skipped) : line, expandable: true),
          if (controller.expanded) ...[
            Divider(height: 1, color: LoupeColors.of(context).separator),
            for (final (i, item) in items.indexed) ...[
              if (i > 0) Divider(height: 1, indent: 40, color: LoupeColors.of(context).separator),
              _item(context, item, i),
            ],
            _footer(context, found, summary, skipped),
          ],
        ]);
      },
    );
  }

  static String _summaryLine(AppLocalizations l10n, ReplyCheckSummary s) => [
    if (s.attachable > 0) l10n.composeReplyCheckSummaryAttached(s.included, s.attachable),
    if (s.wrongPeriod > 0) l10n.composeReplyCheckSummaryWrongPeriod(s.wrongPeriod),
    if (s.unknown > 0) l10n.composeReplyCheckSummaryUnknown(s.unknown),
    if (s.outside > 0) l10n.composeReplyCheckSummaryOutside(s.outside),
    if (s.mentioned > 0) l10n.composeReplyCheckSummaryMentioned(s.mentioned),
    if (s.toAnswer > 0) l10n.composeReplyCheckSummaryToAnswer(s.toAnswer),
  ].join(' · ');

  Widget _frame(BuildContext context, List<Widget> children) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
    child: Material(
      key: const Key('reply-check'),
      color: subtleFill(context),
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: children),
    ),
  );

  /// The title and [subtitle] (the summary, progress or failure), with Hide.
  /// Expandable, a tap opens or closes the list.
  Widget _header(
    BuildContext context,
    String subtitle, {
    bool busy = false,
    bool expandable = false,
    Widget? trailing,
  }) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final row = Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
      child: Row(
        children: [
          Icon(LoupeIcons.ask, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.composeReplyCheckTitle, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  key: const Key('reply-check-summary'),
                  style: TextStyle(fontSize: 13, color: colors.secondaryText),
                ),
              ],
            ),
          ),
          if (busy)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox.square(dimension: 16, child: CircularProgressIndicator(strokeWidth: 2)),
            ),
          ?trailing,
          if (expandable)
            Icon(controller.expanded ? LoupeIcons.collapse : LoupeIcons.expand, size: 18, color: colors.secondaryText),
          IconButton(
            key: const Key('reply-check-hide'),
            tooltip: l10n.composeReplyCheckHide,
            visualDensity: VisualDensity.compact,
            icon: Icon(LoupeIcons.close, size: 18, color: colors.secondaryText),
            onPressed: controller.hide,
          ),
        ],
      ),
    );
    if (!expandable) return row;
    return Semantics(
      button: true,
      label: controller.expanded ? l10n.composeReplyCheckHideRequests : l10n.composeReplyCheckShowRequests,
      child: InkWell(key: const Key('reply-check-toggle'), onTap: controller.toggleExpanded, child: row),
    );
  }

  /// One request: what they asked for, its status and why, and on a tap the
  /// passage of their message it comes from.
  Widget _item(BuildContext context, ReplyCheckItem item, int index) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final (icon, color, label) = _status(context, item);
    final secondary = TextStyle(fontSize: 13, color: colors.secondaryText);
    final warning = TextStyle(fontSize: 13, color: CupertinoColors.systemOrange.resolveFrom(context));
    final open = controller.isOpen(item.request);
    return InkWell(
      key: ValueKey('reply-check-item-$index'),
      onTap: () => controller.toggleOpen(item.request),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 9, 12, 9),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.request.text, style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w600),
                  ),
                  // How the message says it is done, in its own words.
                  if (item.channel case final channel?) Text(channel, style: secondary),
                  for (final line in _details(l10n, item)) Text(line, style: secondary),
                  for (final file in item.attachedAnyway)
                    Text(l10n.composeReplyCheckAttachedAnyway(file), style: warning),
                  if (open) ..._passage(context, item),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _passage(BuildContext context, ReplyCheckItem item) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final quote = item.request.evidence.quote;
    return [
      const SizedBox(height: 8),
      Text(l10n.composeReplyCheckFromMessage, style: TextStyle(fontSize: 12, color: colors.secondaryText)),
      const SizedBox(height: 4),
      Container(
        key: const Key('reply-check-passage'),
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: colors.separator, width: 3)),
        ),
        child: Text(quote, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
      ),
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: TextButton(
          key: const Key('reply-check-skip'),
          style: TextButton.styleFrom(padding: EdgeInsets.zero, visualDensity: VisualDensity.compact),
          onPressed: () => controller.skip(item.request),
          child: Text(l10n.composeReplyCheckSkip),
        ),
      ),
    ];
  }

  (IconData, Color, String) _status(BuildContext context, ReplyCheckItem item) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final primary = Theme.of(context).colorScheme.primary;
    final orange = CupertinoColors.systemOrange.resolveFrom(context);
    final app = item.channel?.toLowerCase().contains('app') ?? false;
    return switch (item.status) {
      ReplyCheckStatus.included => (LoupeIcons.selected, colors.success, l10n.composeReplyCheckStatusIncluded),
      ReplyCheckStatus.wrongPeriod => (LoupeIcons.warning, orange, l10n.composeReplyCheckStatusWrongPeriod),
      ReplyCheckStatus.unknown => (LoupeIcons.unknownKey, orange, l10n.composeReplyCheckStatusUnknown),
      ReplyCheckStatus.missing => (
        LoupeIcons.unselected,
        colors.secondaryText,
        item.way == ReplyCheckWay.answer ? l10n.composeReplyCheckStatusToAnswer : l10n.composeReplyCheckStatusMissing,
      ),
      ReplyCheckStatus.external => (
        app ? LoupeIcons.thisDevice : LoupeIcons.openDirectly,
        primary,
        l10n.composeReplyCheckStatusOutside,
      ),
      ReplyCheckStatus.mentioned => (LoupeIcons.edit, primary, l10n.composeReplyCheckStatusMentioned),
    };
  }

  /// Why a request has its status, in a line or two.
  static List<String> _details(AppLocalizations l10n, ReplyCheckItem item) {
    final file = item.file ?? '';
    final asked = item.asked ?? '';
    final found = item.found ?? '';
    return switch (item.status) {
      ReplyCheckStatus.included => [
        item.basis == ReplyCheckBasis.contents
            ? l10n.composeReplyCheckByContents(file)
            : l10n.composeReplyCheckByName(file),
        if (item.asked != null && !item.periodConfirmed) l10n.composeReplyCheckCheckPeriod(asked),
      ],
      ReplyCheckStatus.wrongPeriod => [
        item.basis == ReplyCheckBasis.contents
            ? l10n.composeReplyCheckPeriodInContents(asked, file, found)
            : l10n.composeReplyCheckPeriodInName(asked, file, found),
      ],
      ReplyCheckStatus.unknown => [l10n.composeReplyCheckUnreadable(file)],
      ReplyCheckStatus.external => [l10n.composeReplyCheckOutsideDetail],
      ReplyCheckStatus.mentioned => [if (item.wrote case final wrote?) l10n.composeReplyCheckYouWrote(_short(wrote))],
      ReplyCheckStatus.missing => const [],
    };
  }

  static String _short(String s) => s.length <= 140 ? s : '${s.substring(0, 139).trimRight()}…';

  /// What the check rests on: file names, a message read in part, which
  /// model found the requests; and the requests left out.
  Widget _footer(BuildContext context, ReplyRequests found, ReplyCheckSummary summary, int skipped) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final style = TextStyle(fontSize: 12, color: colors.secondaryText);
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 6, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (summary.byFileName) Text(l10n.composeReplyCheckByNameNote, style: style),
          if (found.partial) Text(l10n.composeReplyCheckPartial, style: style),
          Text(
            found.providerId == 'demo'
                ? l10n.composeReplyCheckDemoNote
                : l10n.composeReplyCheckFoundBy(found.model ?? found.providerId),
            style: style,
          ),
          if (skipped > 0)
            Row(
              children: [
                Expanded(child: Text(l10n.composeReplyCheckSkipped(skipped), style: style)),
                TextButton(
                  key: const Key('reply-check-check-all'),
                  onPressed: controller.checkAll,
                  child: Text(l10n.composeReplyCheckCheckAll),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// The ordinary attachment reminder: the text says something is attached
/// and nothing is. A note, not a question; Send works as always.
class AttachmentReminder extends StatelessWidget {
  const AttachmentReminder({super.key, required this.onAttach, required this.onHide});

  final VoidCallback? onAttach;
  final VoidCallback onHide;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    return Padding(
      key: const Key('compose-attachment-reminder'),
      padding: const EdgeInsets.fromLTRB(16, 6, 4, 0),
      child: Row(
        children: [
          Icon(LoupeIcons.attachment, size: 18, color: CupertinoColors.systemOrange.resolveFrom(context)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              l10n.composeReplyCheckNothingAttached,
              style: TextStyle(fontSize: 13, color: colors.secondaryText),
            ),
          ),
          TextButton(
            key: const Key('compose-attachment-reminder-attach'),
            onPressed: onAttach,
            child: Text(l10n.composeAttach),
          ),
          IconButton(
            key: const Key('compose-attachment-reminder-hide'),
            tooltip: l10n.composeReplyCheckHideReminder,
            visualDensity: VisualDensity.compact,
            icon: Icon(LoupeIcons.close, size: 18, color: colors.secondaryText),
            onPressed: onHide,
          ),
        ],
      ),
    );
  }
}
