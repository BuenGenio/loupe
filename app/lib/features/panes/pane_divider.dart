import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../theme/theme.dart';

/// The handle over the hairline between two panes: an invisible strip that
/// moves the hairline when dragged, and a double tap puts it back. It shows
/// as an accent line while hovered or dragged; with a mouse it has the
/// column-resize cursor; screen readers get increase and decrease actions.
class PaneDivider extends StatefulWidget {
  const PaneDivider({
    super.key,
    required this.label,
    required this.onDrag,
    required this.onDragEnd,
    this.onReset,
    this.step = 24,
  });

  /// What it resizes, for screen readers ("Mailboxes width").
  final String label;

  /// Called with the horizontal movement while dragging.
  final ValueChanged<double> onDrag;
  final VoidCallback onDragEnd;
  final VoidCallback? onReset;

  /// How far the accessibility actions move it.
  final double step;

  /// Width of the touch target around the hairline.
  static const handleWidth = 12.0;

  @override
  State<PaneDivider> createState() => _PaneDividerState();
}

class _PaneDividerState extends State<PaneDivider> {
  bool _active = false;

  void _nudge(double dx) {
    widget.onDrag(dx);
    widget.onDragEnd();
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return Semantics(
      label: widget.label,
      onIncrease: () => _nudge(widget.step),
      onDecrease: () => _nudge(-widget.step),
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeColumn,
        onEnter: (_) => setState(() => _active = true),
        onExit: (_) => setState(() => _active = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          dragStartBehavior: DragStartBehavior.down,
          onHorizontalDragStart: (_) => setState(() => _active = true),
          onHorizontalDragUpdate: (d) => widget.onDrag(d.delta.dx),
          onHorizontalDragEnd: (_) {
            setState(() => _active = false);
            widget.onDragEnd();
          },
          onHorizontalDragCancel: () => setState(() => _active = false),
          onDoubleTap: widget.onReset,
          child: SizedBox(
            width: PaneDivider.handleWidth,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                width: _active ? 2 : 0,
                color: colors.unreadDot,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
