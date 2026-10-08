import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../shared/mailbox_display.dart';
import '../../shared/tags.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';

/// Every rule, in order.
final rulesProvider = StreamProvider<List<Rule>>((ref) => ref.watch(repositoryProvider).rules.watchRules());

/// The server-rules state of one account, asked of the server once per visit.
final serverRulesStatusProvider = FutureProvider.autoDispose.family<ServerRulesStatus, String>(
  (ref, accountId) => ref.watch(repositoryProvider).rules.serverStatus(accountId, refresh: true),
);

final _random = Random();

/// A new rule id.
String newRuleId() =>
    'rule-${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}-${_random.nextInt(1 << 30).toRadixString(36)}';

/// The folder of a move action, as the user knows it; null when its id
/// can't be read.
String? mailboxLabel(String mailboxId, Map<String, Mailbox> mailboxes) {
  final box = mailboxes[mailboxId];
  if (box != null) return mailboxDisplayName(box);
  try {
    final path = MailIds.parseMailbox(mailboxId).$2;
    return path.split('/').last;
  } on FormatException {
    return null;
  }
}

/// How an action reads ("Move to Receipts", "Tag Work").
String describeAction(AppLocalizations l10n, RuleAction action, Map<String, Mailbox> mailboxes) => switch (action) {
  MoveToMailboxAction(:final mailboxId) => switch (mailboxLabel(mailboxId, mailboxes)) {
    final folder? => l10n.rulesActionMove(folder),
    null => l10n.rulesActionMoveUnknown,
  },
  AddTagAction(:final keyword) => l10n.rulesActionTag(tagLabel(keyword)),
  RemoveTagAction(:final keyword) => l10n.rulesActionRemoveTag(tagLabel(keyword)),
  FlagAction() => l10n.mailFlag,
  MarkReadAction() => l10n.mailMarkAsRead,
  MarkJunkAction() => l10n.mailMoveToJunk,
  KeepInInboxAction() => l10n.rulesActionKeepInInbox,
  ForwardAction(:final address, :final keepCopy) =>
    keepCopy ? l10n.rulesActionForward(address) : l10n.rulesActionForwardNoCopy(address),
};

IconData actionIcon(RuleAction action) => switch (action) {
  MoveToMailboxAction() => LoupeIcons.move,
  AddTagAction() || RemoveTagAction() => LoupeIcons.tag,
  FlagAction() => LoupeIcons.flagged,
  MarkReadAction() => LoupeIcons.markRead,
  MarkJunkAction() => LoupeIcons.junk,
  KeepInInboxAction() => LoupeIcons.keepInInbox,
  ForwardAction() => LoupeIcons.forward,
};

/// One line summing up what a rule does.
String describeActions(AppLocalizations l10n, Rule rule, Map<String, Mailbox> mailboxes) {
  final parts = [for (final a in rule.actions) describeAction(l10n, a, mailboxes)];
  if (rule.stopProcessing && !rule.actions.any((a) => a is KeepInInboxAction)) parts.add(l10n.rulesActionStop);
  return parts.isEmpty ? l10n.rulesNoActions : parts.join(', ');
}

/// "Device" or "Server", as a small capsule.
class RuleLocationBadge extends StatelessWidget {
  const RuleLocationBadge(this.location, {super.key});

  final RuleLocation location;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final tint = location == RuleLocation.server ? colors.swipeArchive : colors.secondaryText;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(color: tint.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(location == RuleLocation.server ? LoupeIcons.ruleServer : LoupeIcons.ruleDevice, size: 12, color: tint),
          const SizedBox(width: 3),
          Flexible(
            child: Text(
              switch (location) {
                RuleLocation.device => context.l10n.rulesLocationDevice,
                RuleLocation.server => context.l10n.rulesLocationServer,
              },
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: tint),
            ),
          ),
        ],
      ),
    );
  }
}

/// Read-only Sieve (or any code) in monospace, selectable.
class CodeBox extends StatelessWidget {
  const CodeBox(this.text, {super.key, this.highlightLines = const {}});

  final String text;

  /// Lines shown as added (green, with a +).
  final Set<String> highlightLines;

  static const style = TextStyle(fontFamily: 'monospace', fontSize: 12, height: 1.4);

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final lines = text.endsWith('\n') ? text.substring(0, text.length - 1).split('\n') : text.split('\n');
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: colors.fill, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SelectableText.rich(
          TextSpan(
            style: style.copyWith(color: colors.label),
            children: [
              for (final (i, line) in lines.indexed)
                TextSpan(
                  text:
                      '${highlightLines.contains(line) ? '+ ' : (highlightLines.isEmpty ? '' : '  ')}$line'
                      '${i < lines.length - 1 ? '\n' : ''}',
                  style: highlightLines.contains(line)
                      ? TextStyle(color: colors.success, fontWeight: FontWeight.w600)
                      : null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A calm notice inside a grouped page: an icon, text, optional buttons.
class RuleNotice extends StatelessWidget {
  const RuleNotice({super.key, required this.text, this.icon = LoupeIcons.info, this.tint, this.actions = const []});

  final String text;
  final IconData icon;
  final Color? tint;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final color = tint ?? colors.secondaryText;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 14, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Icon(icon, size: 18, color: color),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(text, style: styles.footnote.copyWith(color: colors.label, fontSize: 14)),
              ),
            ],
          ),
          if (actions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 22, top: 4),
              child: Wrap(spacing: 4, children: actions),
            ),
        ],
      ),
    );
  }
}

/// A small accent text button for notices.
class NoticeButton extends StatelessWidget {
  const NoticeButton(this.label, {super.key, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => CupertinoButton(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    minimumSize: const Size(44, 32),
    onPressed: onPressed,
    child: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
  );
}
