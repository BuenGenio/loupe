import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import 'action_text.dart';

/// One small fact with its icon, in secondary colour (or [color]).
class ActionFact extends StatelessWidget {
  const ActionFact({super.key, required this.icon, required this.text, this.color});

  final IconData icon;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    final tint = color ?? LoupeColors.of(context).secondaryText;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: tint),
        const SizedBox(width: 3),
        Flexible(
          child: Text(
            text,
            style: styles.caption.copyWith(color: tint),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// What a row says about [action] under its text: its state (when it isn't
/// plainly open), how it must be done, when it is due and its reminder.
class ActionFacts extends StatelessWidget {
  const ActionFacts({super.key, required this.action});

  final ActionRecord action;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final now = clock.now();
    final due = actionDueLabel(l10n, action.due);
    final remind = action.remindAt;
    final facts = [
      if (action.state != ActionState.needsAction)
        ActionFact(icon: actionStateIcon(action.state), text: actionStateLabel(l10n, action.state)),
      if (action.channel case final channel? when channel.trim().isNotEmpty)
        ActionFact(icon: LoupeIcons.redirect, text: channel),
      if (due != null)
        ActionFact(icon: LoupeIcons.calendar, text: due, color: actionOverdue(action, now) ? colors.destructive : null),
      if (remind != null && action.isOpen)
        ActionFact(
          icon: LoupeIcons.actionReminder,
          text: actionReminderLabel(context, remind, now: now),
          color: colors.snooze,
        ),
    ];
    if (facts.isEmpty) return const SizedBox.shrink();
    return Wrap(spacing: 10, runSpacing: 2, children: facts);
  }
}

/// How many open actions there are, for the user and waited for: the
/// conversation's Actions row and the rows of the two folders.
class ActionCounts extends StatelessWidget {
  const ActionCounts({super.key, required this.mine, required this.waiting, this.next});

  final int mine;
  final int waiting;

  /// The open action due soonest, whose timing is shown after the counts.
  final ActionRecord? next;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    final due = next == null ? null : actionDueLabel(l10n, next!.due);
    return Wrap(
      spacing: 10,
      runSpacing: 2,
      children: [
        if (mine > 0)
          ActionFact(icon: LoupeIcons.needsMyAction, text: l10n.actionsCountMine(mine), color: colors.unreadDot),
        if (waiting > 0) ActionFact(icon: LoupeIcons.waitingOnOthers, text: l10n.actionsCountWaiting(waiting)),
        if (due != null)
          ActionFact(
            icon: LoupeIcons.calendar,
            text: due,
            color: actionOverdue(next!, clock.now()) ? colors.destructive : null,
          ),
      ],
    );
  }
}

/// Under a row of Needs My Action or Waiting on Others: how many of the
/// conversation's actions are open there and when the next one is due.
class ActionFolderRowFooter extends StatelessWidget {
  const ActionFolderRowFooter({super.key, required this.folder, required this.actions});

  final VirtualMailbox folder;

  /// The conversation's open actions in [folder], the soonest due first
  /// (`openActionsByConversation`).
  final List<ActionRecord> actions;

  @override
  Widget build(BuildContext context) {
    if (actions.isEmpty) return const SizedBox.shrink();
    final dated = actions.where((a) => !a.due.isNone).firstOrNull;
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: ActionCounts(
        mine: folder == VirtualMailbox.needsMyAction ? actions.length : 0,
        waiting: folder == VirtualMailbox.waitingOnOthers ? actions.length : 0,
        next: dated,
      ),
    );
  }
}
