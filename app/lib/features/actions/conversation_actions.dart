import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../shared/grouped_list.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart';
import '../snooze/snooze_sheet.dart';
import 'action_changes.dart';
import 'action_providers.dart';
import 'action_text.dart';
import 'action_widgets.dart';

/// The messages of the conversation [emailId] belongs to.
final _conversationProvider = StreamProvider.autoDispose.family<List<EmailSummary>, String>(
  (ref, emailId) => ref.watch(repositoryProvider).watchConversation(emailId),
);

/// The Actions row under a conversation's subject, while it has actions:
/// how many are open for the user and waited for. Opens [ConversationActionsScreen].
class ConversationActionsRow extends ConsumerWidget {
  const ConversationActionsRow({super.key, required this.messages});

  final List<EmailSummary> messages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = actionsOf(ref.watch(actionsProvider).value ?? const [], messages);
    if (actions.isEmpty || messages.isEmpty) return const SizedBox.shrink();
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final mine = actions.where((a) => a.folder == VirtualMailbox.needsMyAction).toList()..sort(compareByDue);
    final waiting = actions.where((a) => a.folder == VirtualMailbox.waitingOnOthers).length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Material(
        color: subtleFill(context),
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: const Key('conversation-actions'),
          onTap: () => openConversationActions(context, messages.last.id),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 9, 8, 9),
            child: Row(
              children: [
                Icon(LoupeIcons.needsMyAction, size: 22, color: colors.unreadDot),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(l10n.actionsTitle, style: styles.body.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 1),
                      if (mine.isEmpty && waiting == 0)
                        Text(l10n.actionsAllSettled(actions.length), style: styles.caption)
                      else
                        ActionCounts(
                          mine: mine.length,
                          waiting: waiting,
                          next: mine.where((a) => !a.due.isNone).firstOrNull,
                        ),
                    ],
                  ),
                ),
                Icon(LoupeIcons.disclosure, size: 16, color: colors.tertiaryText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Opens the actions of the conversation [emailId] belongs to.
Future<void> openConversationActions(BuildContext context, String emailId) =>
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => ConversationActionsScreen(emailId: emailId)));

/// A conversation's actions: what the user has to do, what they wait for,
/// and what is settled, each with its state, timing and reminder. Tap the
/// mark to complete one (or reopen it); tap the row for the rest. Every
/// change has Undo.
class ConversationActionsScreen extends ConsumerWidget {
  const ConversationActionsScreen({super.key, required this.emailId});

  /// Any message of the conversation.
  final String emailId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final messages = ref.watch(_conversationProvider(emailId)).value ?? const <EmailSummary>[];
    final actions = actionsOf(ref.watch(actionsProvider).value ?? const [], messages);
    final mine = actions.where((a) => a.folder == VirtualMailbox.needsMyAction).toList()..sort(compareByDue);
    final waiting = actions.where((a) => a.folder == VirtualMailbox.waitingOnOthers).toList()..sort(compareByDue);
    final settled = actions.where((a) => !a.isOpen).toList();
    EmailSummary? sourceOf(ActionRecord a) => messages.where(a.source.matches).firstOrNull;

    Widget group(String header, List<ActionRecord> list) => InsetGroup(
      header: header,
      separatorIndent: 50,
      children: [
        for (final a in list)
          _ActionRow(
            key: ValueKey(a.id),
            action: a,
            onToggle: () => _toggle(context, ref, a),
            onTap: () => _details(context, ref, a, sourceOf(a)),
          ),
      ],
    );

    return GroupedPage(
      title: l10n.actionsTitle,
      children: [
        if (actions.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 48, 32, 0),
            child: Text(
              l10n.actionsNoneInConversation,
              style: LoupeTextStyles.of(context).footnote,
              textAlign: TextAlign.center,
            ),
          ),
        if (mine.isNotEmpty) group(l10n.actionsNeedsMyAction, mine),
        if (waiting.isNotEmpty) group(l10n.actionsWaitingOnOthers, waiting),
        if (settled.isNotEmpty) group(l10n.actionsSettledHeader, settled),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: Text(l10n.actionsFooter, style: LoupeTextStyles.of(context).footnote, textAlign: TextAlign.center),
        ),
      ],
    );
  }

  /// The mark: an open action is done; a settled one needs action again.
  Future<void> _toggle(BuildContext context, WidgetRef ref, ActionRecord a) {
    final next = a.isOpen ? ActionState.done : ActionState.needsAction;
    return changeAction(context, ref, a, a.withState(next, clock.now()), actionMarkedLabel(context.l10n, next));
  }

  Future<void> _details(BuildContext context, WidgetRef ref, ActionRecord a, EmailSummary? source) async {
    final choice = await showActionDetails(context, a, source: source);
    if (choice == null || !context.mounted) return;
    await applyActionChoice(context, ref, a, choice);
  }
}

/// What the details of an action asked for.
sealed class ActionChoice {
  const ActionChoice();
}

final class SetActionState extends ActionChoice {
  const SetActionState(this.state);
  final ActionState state;
}

final class EditActionText extends ActionChoice {
  const EditActionText();
}

final class SetActionReminder extends ActionChoice {
  const SetActionReminder();
}

final class ClearActionReminder extends ActionChoice {
  const ClearActionReminder();
}

final class DeleteAction extends ActionChoice {
  const DeleteAction();
}

/// Carries out [choice] on [a], with Undo.
Future<void> applyActionChoice(BuildContext context, WidgetRef ref, ActionRecord a, ActionChoice choice) async {
  final l10n = context.l10n;
  final now = clock.now();
  switch (choice) {
    case SetActionState(:final state):
      await changeAction(context, ref, a, a.withState(state, now), actionMarkedLabel(l10n, state));
    case EditActionText():
      final text = await showCupertinoDialog<String>(
        context: context,
        barrierDismissible: true,
        builder: (_) => _EditTextDialog(initial: a.currentRequest),
      );
      if (text == null || !context.mounted) return;
      await changeAction(context, ref, a, a.withText(text, clock.now()), l10n.actionsEdited);
    case SetActionReminder():
      final at = await showSnoozeSheet(context, now: now, current: a.remindAt, title: l10n.actionsRemindTitle);
      if (at == null || !context.mounted) return;
      await changeAction(
        context,
        ref,
        a,
        a.withReminder(at, clock.now()),
        l10n.actionsReminderSet(actionReminderLabel(context, at, now: clock.now())),
      );
    case ClearActionReminder():
      await changeAction(context, ref, a, a.withReminder(null, now), l10n.actionsReminderCleared);
    case DeleteAction():
      await changeAction(context, ref, a, a.withDeleted(true, now), l10n.actionsDeleted);
  }
}

/// One action: its state mark (a button), its text and facts, a chevron.
class _ActionRow extends StatelessWidget {
  const _ActionRow({super.key, required this.action, required this.onToggle, required this.onTap});

  final ActionRecord action;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final open = action.isOpen;
    final markColor = switch (action.state) {
      ActionState.done || ActionState.acknowledged => colors.success,
      ActionState.dismissed || ActionState.superseded => colors.tertiaryText,
      _ => colors.unreadDot,
    };
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(6, 6, 14, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              button: true,
              label: open ? l10n.actionsMarkDone : l10n.actionsReopen,
              excludeSemantics: true,
              child: InkResponse(
                key: ValueKey('action-mark-${action.id}'),
                radius: 22,
                onTap: onToggle,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(actionStateIcon(action.state), size: 24, color: markColor),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      action.currentRequest,
                      style: styles.body.copyWith(
                        color: open ? colors.label : colors.secondaryText,
                        decoration: action.state == ActionState.done ? TextDecoration.lineThrough : null,
                        decorationColor: colors.secondaryText,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    ActionFacts(action: action),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 6),
              child: Icon(LoupeIcons.disclosure, size: 17, color: colors.tertiaryText),
            ),
          ],
        ),
      ),
    );
  }
}

/// The details of [a]: its words (and how they first read), the passage of
/// [source] it comes from, where it came from, its state, reminder and
/// history. Resolves to what the user picked.
Future<ActionChoice?> showActionDetails(BuildContext context, ActionRecord a, {EmailSummary? source}) =>
    showLoupeSheet<ActionChoice>(
      context,
      builder: (context) {
        final colors = LoupeColors.of(context);
        final styles = LoupeTextStyles.of(context);
        final l10n = context.l10n;
        final now = clock.now();
        void pick(ActionChoice c) => Navigator.of(context).pop(c);
        final checked = Icon(LoupeIcons.check, color: Theme.of(context).colorScheme.primary);
        final remind = a.remindAt;
        final stamp = DateFormat.yMMMd().add_Hm();
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 16 + MediaQuery.paddingOf(context).bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(actionOwnerLabel(l10n, a.owner), style: styles.footnote),
                    const SizedBox(height: 2),
                    Text(a.currentRequest, style: styles.navTitle),
                    if (a.currentRequest != a.originalRequest && a.originalRequest.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(l10n.actionsOriginally(a.originalRequest), style: styles.footnote),
                      ),
                    const SizedBox(height: 6),
                    ActionFacts(action: a),
                    if (a.quote.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(LoupeIcons.actionQuote, size: 18, color: colors.secondaryText),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n.actionsQuote(a.quote),
                              key: const Key('action-quote'),
                              style: styles.body.copyWith(fontStyle: FontStyle.italic, color: colors.secondaryText),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (source != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          l10n.actionsFromMessage(
                            source.sender?.displayName ?? l10n.sharedUnknownSender,
                            DateFormat.MMMd().format(source.receivedAt),
                          ),
                          style: styles.caption,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(actionOriginLabel(l10n, a.origin), style: styles.caption),
                    ),
                  ],
                ),
              ),
              SheetGroup(
                header: l10n.actionsStatusHeader,
                children: [
                  for (final s in actionStatesFor(a.owner))
                    SheetRow(
                      key: ValueKey('action-state-${s.name}'),
                      label: actionStateLabel(l10n, s),
                      icon: actionStateIcon(s),
                      trailing: s == a.state ? checked : null,
                      onTap: s == a.state ? () => Navigator.of(context).pop() : () => pick(SetActionState(s)),
                    ),
                ],
              ),
              SheetGroup(
                children: [
                  SheetRow(
                    key: const ValueKey('action-edit'),
                    label: l10n.actionsEditText,
                    icon: LoupeIcons.edit,
                    onTap: () => pick(const EditActionText()),
                  ),
                  SheetRow(
                    key: const ValueKey('action-remind'),
                    label: remind == null ? l10n.actionsRemindMe : l10n.actionsChangeReminder,
                    subtitle: remind == null ? null : actionReminderLabel(context, remind, now: now),
                    icon: LoupeIcons.actionReminder,
                    onTap: () => pick(const SetActionReminder()),
                  ),
                  if (remind != null)
                    SheetRow(
                      key: const ValueKey('action-clear-reminder'),
                      label: l10n.actionsClearReminder,
                      icon: LoupeIcons.close,
                      onTap: () => pick(const ClearActionReminder()),
                    ),
                  SheetRow(
                    key: const ValueKey('action-delete'),
                    label: l10n.actionsDelete,
                    icon: LoupeIcons.trash,
                    destructive: true,
                    onTap: () => pick(const DeleteAction()),
                  ),
                ],
              ),
              SheetGroup(
                header: l10n.actionsHistoryHeader,
                children: [
                  for (final e in a.history.reversed)
                    ListTile(
                      dense: true,
                      minLeadingWidth: 24,
                      leading: Icon(LoupeIcons.actionHistory, size: 20, color: colors.secondaryText),
                      title: Text(actionHistoryLabel(l10n, e), style: const TextStyle(fontSize: 15)),
                      subtitle: e.change == ActionChange.edited || e.change == ActionChange.revised
                          ? Text(e.detail ?? '', maxLines: 2, overflow: TextOverflow.ellipsis)
                          : null,
                      trailing: Text(stamp.format(e.at.toLocal()), style: styles.caption),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );

/// Edit Text…: the action's words, changed.
class _EditTextDialog extends StatefulWidget {
  const _EditTextDialog({required this.initial});

  final String initial;

  @override
  State<_EditTextDialog> createState() => _EditTextDialogState();
}

class _EditTextDialogState extends State<_EditTextDialog> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    unawaited(HapticFeedback.selectionClick());
    Navigator.of(context).pop(text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return CupertinoAlertDialog(
      title: Text(l10n.actionsEditTitle),
      content: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: CupertinoTextField(
          key: const ValueKey('action-text-field'),
          controller: _controller,
          autofocus: true,
          minLines: 1,
          maxLines: 4,
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: (_) => _save(),
        ),
      ),
      actions: [
        CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
        CupertinoDialogAction(isDefaultAction: true, onPressed: _save, child: Text(l10n.commonSave)),
      ],
    );
  }
}
