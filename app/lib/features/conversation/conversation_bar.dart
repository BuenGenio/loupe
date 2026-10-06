import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import '../../shared/avatar.dart';
import '../../shared/bars.dart';
import '../../theme/theme.dart';

/// What the conversation's top bar shows, from the scroll position.
@immutable
class ConversationBarState {
  const ConversationBarState({this.scrolledUnder = false, this.reading});

  /// Content has scrolled under the bar: the glass shows.
  final bool scrolledUnder;

  /// The message being read, once the subject has scrolled under the bar:
  /// the bar shows its sender over the subject. Null while the subject is
  /// in view.
  final EmailSummary? reading;

  bool get compact => reading != null;

  @override
  bool operator ==(Object other) =>
      other is ConversationBarState &&
      other.scrolledUnder == scrolledUnder &&
      other.reading?.id == reading?.id &&
      other.reading?.sender == reading?.sender;

  @override
  int get hashCode => Object.hash(scrolledUnder, reading?.id, reading?.sender);
}

/// The conversation's top bar. It stays over the content, from under the
/// status bar down, in frosted glass once content scrolls beneath it.
///
/// At rest it is empty and clear (on iOS it holds the back chevron): the
/// large subject and the sender row are in the content below. Once the
/// subject has scrolled under it, it shows the sender of the message being
/// read over the subject, with a hairline below. Tapping them scrolls back
/// to the top.
class ConversationBar extends StatelessWidget {
  const ConversationBar({
    super.key,
    required this.state,
    required this.subject,
    required this.onTitleTap,
    this.leading,
  });

  final ValueListenable<ConversationBarState> state;

  /// The compact title's second line.
  final Widget subject;
  final VoidCallback onTitleTap;

  /// The back chevron, on iOS.
  final Widget? leading;

  static const compactTitleKey = Key('conversation-compact-title');

  /// The bar's height below the status bar: 44, like the other title
  /// bars, until large text needs more for the compact title's two lines.
  static double heightOf(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context).clamp(maxScaleFactor: barMaxTextScale);
    return math.max(44, (scaler.scale(16) * _lineHeight + scaler.scale(13) * _lineHeight + 8).ceilToDouble());
  }

  static const _lineHeight = 1.2;

  /// The bar's whole height, status bar included: where the content starts.
  static double extentOf(BuildContext context) => MediaQuery.paddingOf(context).top + heightOf(context);

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final top = MediaQuery.paddingOf(context).top;
    final height = heightOf(context);
    final motion = MediaQuery.disableAnimationsOf(context) ? Duration.zero : const Duration(milliseconds: 200);
    final lead = leading;
    return ValueListenableBuilder<ConversationBarState>(
      valueListenable: state,
      builder: (context, s, _) => ClipRect(
        child: BackdropFilter(
          enabled: s.scrolledUnder,
          filter: FrostedGlass.filter,
          child: AnimatedContainer(
            duration: motion,
            height: top + height,
            padding: EdgeInsets.only(top: top),
            color: FrostedGlass.tint(context, visibility: s.scrolledUnder ? 1 : 0),
            // In front, so the hairline takes no space from the bar.
            foregroundDecoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: s.compact ? colors.separator : colors.separator.withValues(alpha: 0),
                  width: 0.5,
                ),
              ),
            ),
            child: MediaQuery.withClampedTextScaling(
              maxScaleFactor: barMaxTextScale,
              child: Row(
                children: [
                  if (lead == null) const SizedBox(width: 16) else ...[const SizedBox(width: 4), lead],
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: motion,
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      layoutBuilder: _startAligned,
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween(begin: const Offset(0, 0.3), end: Offset.zero).animate(animation),
                          child: child,
                        ),
                      ),
                      child: switch (s.reading) {
                        final m? => _CompactTitle(
                          key: compactTitleKey,
                          message: m,
                          subject: subject,
                          motion: motion,
                          onTap: onTitleTap,
                        ),
                        null => const SizedBox.shrink(),
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// An [AnimatedSwitcher] layout that keeps its children at the start.
Widget _startAligned(Widget? current, List<Widget> previous) =>
    Stack(alignment: AlignmentDirectional.centerStart, children: [...previous, ?current]);

/// The sender of the message being read over the subject, one line each.
class _CompactTitle extends StatelessWidget {
  const _CompactTitle({
    super.key,
    required this.message,
    required this.subject,
    required this.motion,
    required this.onTap,
  });

  final EmailSummary message;
  final Widget subject;
  final Duration motion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    final sender = message.sender;
    // Line 1 follows the message being read; the subject stays.
    final reading = ValueKey(message.id);
    return Semantics(
      button: true,
      header: true,
      onTapHint: 'Scroll to the top',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Row(
          children: [
            ExcludeSemantics(
              child: AnimatedSwitcher(
                duration: motion,
                child: SenderAvatar(key: reading, address: sender, size: 28),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSwitcher(
                    duration: motion,
                    layoutBuilder: _startAligned,
                    child: Text(
                      sender?.displayName ?? '(no sender)',
                      key: reading,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: styles.navTitle.copyWith(fontSize: 16, height: ConversationBar._lineHeight),
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style: styles.footnote.copyWith(height: ConversationBar._lineHeight),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    child: subject,
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
