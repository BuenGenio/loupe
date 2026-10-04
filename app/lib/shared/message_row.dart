import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import '../theme/theme.dart';
import 'format.dart';
import 'tags.dart';

/// One row of a message list, Apple Mail style: sender, date and chevron on
/// top, subject below, then a two-line preview. The left gutter carries the
/// unread dot (a star for VIPs) and the flag.
class MessageRow extends StatelessWidget {
  const MessageRow({
    super.key,
    required this.email,
    this.messageCount = 1,
    this.unread,
    this.isVip = false,
    this.accountColor,
    this.selected = false,
    this.editing = false,
    this.checked = false,
    this.fromServer = false,
    this.location,
    this.showRecipients = false,
    this.onTap,
    this.onLongPress,
  });

  final EmailSummary email;

  /// Messages in the conversation; a badge appears above 1.
  final int messageCount;

  /// Overrides `!email.isSeen` (a thread is unread if any message is).
  final bool? unread;
  final bool isVip;

  /// Shown as a stripe on the leading edge in unified mailboxes.
  final Color? accountColor;

  /// Highlighted (the message shown in the detail pane).
  final bool selected;

  /// Multi-select mode: a check circle replaces the gutter.
  final bool editing;
  final bool checked;

  /// Found by server search only: a small cloud.
  final bool fromServer;

  /// Mailbox and account, shown under the preview in search results.
  final String? location;

  /// Sent and draft mailboxes show who the message went to.
  final bool showRecipients;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final metrics = LoupeMetrics.of(context);
    final isUnread = unread ?? !email.isSeen;
    final people = showRecipients ? [...email.to, ...email.cc] : email.from;
    final name = people.isEmpty
        ? (showRecipients ? 'No Recipients' : 'Unknown Sender')
        : people.map((a) => a.displayName).take(3).join(', ');
    final tags = email.tags.toList();
    final subject = email.subject.trim().isEmpty ? 'No Subject' : email.subject;

    Widget gutter() {
      if (editing) {
        return Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Icon(
            checked ? CupertinoIcons.checkmark_circle_fill : CupertinoIcons.circle,
            size: 23,
            color: checked ? colors.unreadDot : colors.tertiaryText,
          ),
        );
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 22,
            child: Center(
              child: isVip
                  ? Icon(CupertinoIcons.star_fill, size: 13, color: isUnread ? colors.unreadDot : colors.tertiaryText)
                  : isUnread
                  ? Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(color: colors.unreadDot, shape: BoxShape.circle),
                    )
                  : null,
            ),
          ),
          if (email.isFlagged) Icon(CupertinoIcons.flag_fill, size: 12, color: colors.flag),
          if (email.isAnswered && !email.isFlagged)
            Icon(CupertinoIcons.arrowshape_turn_up_left_fill, size: 11, color: colors.tertiaryText),
        ],
      );
    }

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                name,
                style: isUnread ? styles.senderUnread : styles.sender,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (fromServer)
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Icon(CupertinoIcons.cloud, size: 15, color: colors.secondaryText, semanticLabel: 'On server'),
              ),
            if (email.hasAttachment)
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Icon(
                  CupertinoIcons.paperclip,
                  size: 14,
                  color: colors.secondaryText,
                  semanticLabel: 'Attachment',
                ),
              ),
            const SizedBox(width: 6),
            Text(formatListDate(email.receivedAt), style: styles.date),
            if (messageCount > 1)
              Container(
                margin: const EdgeInsets.only(left: 6),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  border: Border.all(color: colors.tertiaryText, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('$messageCount', style: styles.caption.copyWith(fontWeight: FontWeight.w600)),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(CupertinoIcons.chevron_forward, size: 14, color: colors.tertiaryText),
            ),
          ],
        ),
        const SizedBox(height: 1),
        Row(
          children: [
            Flexible(
              child: Text(
                subject,
                style: styles.subject.copyWith(fontWeight: isUnread ? FontWeight.w500 : FontWeight.w400),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            for (final t in tags.take(4))
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Tooltip(
                  message: tagLabel(t),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(color: tagColor(t), shape: BoxShape.circle),
                  ),
                ),
              ),
          ],
        ),
        if (email.preview.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text(
              email.preview,
              style: styles.preview,
              maxLines: metrics.previewLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (location != null)
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(location!, style: styles.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
      ],
    );

    // One node per row, so screen readers read sender, subject and state together.
    return MergeSemantics(
      child: Semantics(
        button: true,
        selected: selected || checked,
        label: [
          if (isUnread) 'Unread',
          if (isVip) 'VIP',
          if (email.isFlagged) 'Flagged',
          if (messageCount > 1) '$messageCount messages',
        ].join(', '),
        child: Material(
          color: selected ? colors.selectedRow : Theme.of(context).scaffoldBackgroundColor,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: metrics.rowVerticalPadding,
                    bottom: metrics.rowVerticalPadding,
                    right: 14,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        width: editing ? 44 : metrics.rowGutter,
                        child: gutter(),
                      ),
                      Expanded(child: content),
                    ],
                  ),
                ),
                if (accountColor != null)
                  Positioned(left: 0, top: 0, bottom: 0, child: Container(width: 3.5, color: accountColor)),
                Positioned(
                  left: editing ? 44 : metrics.rowGutter,
                  right: 0,
                  bottom: 0,
                  child: Divider(height: 0.5, thickness: 0.5, color: colors.separator),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
