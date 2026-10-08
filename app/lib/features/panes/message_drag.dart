import 'dart:async';

import 'package:flutter/gestures.dart' show kTouchSlop;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../shared/mail_actions.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';

/// Conversations dragged from a list towards a mailbox.
@immutable
final class MessageDrag {
  const MessageDrag({required this.rows, required this.scope, required this.threaded, this.onMoved});

  final List<ThreadSummary> rows;

  /// The list they come from: decides which messages of a conversation move
  /// (see [MailActions.members]).
  final MailboxRef scope;
  final bool threaded;

  /// After the drop moved them (the list leaves Edit mode).
  final VoidCallback? onMoved;

  Set<String> get accountIds => {for (final r in rows) r.latest.accountId};

  /// Whether they can go to [mailbox]: one account's, and not all there already.
  bool canMoveTo(Mailbox mailbox) {
    if (!mailbox.isSelectable || rows.isEmpty) return false;
    final accounts = accountIds;
    if (accounts.length != 1 || accounts.single != mailbox.accountId) return false;
    return rows.any((r) => r.latest.mailboxId != mailbox.id);
  }
}

/// Whether messages are being dragged (the split layout opens the Mailboxes
/// sidebar to drop them on).
final messageDraggingProvider = NotifierProvider<MessageDragging, bool>(MessageDragging.new);

class MessageDragging extends Notifier<bool> {
  @override
  bool build() => false;

  void set(bool dragging) => state = dragging;
}

/// A list row that a long press lifts, to drop on a mailbox; [drag] says
/// what it carries (the row, or the Edit selection it is part of). Released
/// where it was lifted, [onLongPress] runs instead (the More sheet), so the
/// long press still does what it does on a phone.
class DraggableMessageRow extends ConsumerStatefulWidget {
  const DraggableMessageRow({super.key, required this.drag, required this.child, this.onLongPress});

  final MessageDrag Function() drag;
  final Widget child;
  final VoidCallback? onLongPress;

  @override
  ConsumerState<DraggableMessageRow> createState() => _DraggableMessageRowState();
}

class _DraggableMessageRowState extends ConsumerState<DraggableMessageRow> {
  double _moved = 0;

  void _ended() {
    if (mounted) ref.read(messageDraggingProvider.notifier).set(false);
  }

  /// The card sits above and left of the finger, which stays on its corner.
  static Offset _anchor(Draggable<Object> draggable, BuildContext context, Offset position) => const Offset(24, 30);

  @override
  Widget build(BuildContext context) {
    final data = widget.drag();
    return LongPressDraggable<MessageDrag>(
      data: data,
      dragAnchorStrategy: _anchor,
      feedback: MessageDragFeedback(rows: data.rows),
      childWhenDragging: Opacity(opacity: 0.4, child: widget.child),
      hapticFeedbackOnStart: true,
      onDragStarted: () {
        _moved = 0;
        ref.read(messageDraggingProvider.notifier).set(true);
      },
      onDragUpdate: (d) => _moved += d.delta.distance,
      onDraggableCanceled: (_, _) {
        _ended();
        // Lifted and put back: the long press as on a phone.
        if (_moved < kTouchSlop) widget.onLongPress?.call();
      },
      onDragCompleted: _ended,
      child: widget.child,
    );
  }
}

/// What follows the finger: the subject, or how many conversations.
class MessageDragFeedback extends StatelessWidget {
  const MessageDragFeedback({super.key, required this.rows});

  final List<ThreadSummary> rows;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final count = rows.length;
    final subject = count == 1 ? rows.single.latest.subject.trim() : '';
    final label = count == 1
        ? (subject.isEmpty ? context.l10n.mailNoSubject : subject)
        : context.l10n.panesDragCount(count);
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 260),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: colors.cellBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.separator, width: 0.5),
              boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 18, offset: Offset(0, 6))],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(count == 1 ? LoupeIcons.email : LoupeIcons.allMail, size: 20, color: colors.unreadDot),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(label, style: styles.body, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          if (count > 1)
            Positioned(
              top: -8,
              right: -8,
              child: Container(
                key: const Key('drag-count'),
                constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: colors.destructive, borderRadius: BorderRadius.circular(11)),
                child: Text(
                  '$count',
                  style: styles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A mailbox that takes conversations dropped on it and moves them there,
/// with Undo. [builder] draws it, [hovering] while something droppable is
/// over it.
class MailboxDropTarget extends ConsumerWidget {
  const MailboxDropTarget({super.key, required this.mailbox, required this.builder});

  final Mailbox mailbox;
  final Widget Function(BuildContext context, bool hovering) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) => DragTarget<MessageDrag>(
    onWillAcceptWithDetails: (d) => d.data.canMoveTo(mailbox),
    onAcceptWithDetails: (d) {
      final data = d.data;
      unawaited(HapticFeedback.mediumImpact());
      final actions = MailActions(context, ref, scope: data.scope, threaded: data.threaded);
      unawaited(
        actions.move(data.rows, mailbox.id).then((moved) {
          if (moved) data.onMoved?.call();
        }),
      );
    },
    builder: (context, candidates, _) => builder(context, candidates.isNotEmpty),
  );
}
