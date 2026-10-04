import 'dart:async';
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

/// One action behind a row.
@immutable
class SwipeActionSpec {
  const SwipeActionSpec({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTriggered,
    this.removesRow = false,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTriggered;

  /// The row slides out and collapses before the action runs (archive, trash).
  final bool removesRow;
}

/// A list row with Apple Mail swipe actions: drag to reveal buttons, drag
/// past the threshold (with a haptic tick) and release to run the primary
/// action, tap a revealed button, or tap the row to close it again.
class SwipeActionRow extends StatefulWidget {
  const SwipeActionRow({
    super.key,
    required this.child,
    this.leading = const [],
    this.trailing = const [],
    this.enabled = true,
  });

  final Widget child;

  /// Revealed by swiping right, listed from the leading edge inwards. The
  /// first one runs on a full swipe.
  final List<SwipeActionSpec> leading;

  /// Revealed by swiping left, listed from the trailing edge inwards. The
  /// first one runs on a full swipe.
  final List<SwipeActionSpec> trailing;
  final bool enabled;

  @override
  State<SwipeActionRow> createState() => _SwipeActionRowState();
}

class _SwipeActionRowState extends State<SwipeActionRow> with TickerProviderStateMixin {
  /// Only one row stays open at a time.
  static final _openRow = ValueNotifier<_SwipeActionRowState?>(null);

  static const _buttonWidth = 74.0;

  /// Horizontal offset in pixels; positive reveals the leading actions.
  late final AnimationController _offset = AnimationController.unbounded(vsync: this);

  /// 1 while the full-swipe action is armed (the primary button fills the row).
  late final AnimationController _arm = AnimationController(vsync: this, duration: const Duration(milliseconds: 160));

  /// Row height factor, collapsed to 0 when the row is removed.
  late final AnimationController _size = AnimationController(
    vsync: this,
    value: 1,
    duration: const Duration(milliseconds: 220),
  );

  double _width = 0;
  bool _armed = false;
  ScrollPosition? _scroll;
  Timer? _restore;

  double get _threshold => _width * 0.55;

  @override
  void initState() {
    super.initState();
    _openRow.addListener(_onOtherOpened);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scroll?.isScrollingNotifier.removeListener(_onScroll);
    _scroll = Scrollable.maybeOf(context)?.position;
    _scroll?.isScrollingNotifier.addListener(_onScroll);
  }

  @override
  void dispose() {
    _restore?.cancel();
    _openRow.removeListener(_onOtherOpened);
    if (_openRow.value == this) _openRow.value = null;
    _scroll?.isScrollingNotifier.removeListener(_onScroll);
    _offset.dispose();
    _arm.dispose();
    _size.dispose();
    super.dispose();
  }

  void _onOtherOpened() {
    if (_openRow.value != this && _offset.value != 0) _settle(0);
  }

  void _onScroll() {
    if ((_scroll?.isScrollingNotifier.value ?? false) && _offset.value != 0) _settle(0);
  }

  void _setArmed(bool armed) {
    if (armed == _armed) return;
    _armed = armed;
    unawaited(HapticFeedback.mediumImpact());
    armed ? _arm.forward() : _arm.reverse();
  }

  void _settle(double target) {
    if (target == 0) {
      _setArmedQuietly(false);
      if (_openRow.value == this) _openRow.value = null;
    } else {
      _openRow.value = this;
    }
    unawaited(_offset.animateTo(target, duration: const Duration(milliseconds: 260), curve: Curves.easeOutCubic));
  }

  void _setArmedQuietly(bool armed) {
    _armed = armed;
    armed ? _arm.forward() : _arm.reverse();
  }

  void _onDragStart(DragStartDetails details) {
    _offset.stop();
    if (_openRow.value != this) _openRow.value = this;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    var next = _offset.value + (details.primaryDelta ?? 0);
    if (next > 0 && widget.leading.isEmpty) next = 0;
    if (next < 0 && widget.trailing.isEmpty) next = 0;
    _offset.value = next.clamp(-_width, _width);
    _setArmed(_offset.value.abs() > _threshold);
  }

  void _onDragEnd(DragEndDetails details) {
    final x = _offset.value;
    final velocity = details.primaryVelocity ?? 0;
    final actions = x > 0 ? widget.leading : widget.trailing;
    if (x == 0 || actions.isEmpty) return _settle(0);
    if (_armed) {
      unawaited(_run(actions.first, x.sign));
      return;
    }
    final open = actions.length * _buttonWidth;
    final flungOpen = velocity.sign == x.sign && velocity.abs() > 600;
    final flungClosed = velocity.sign == -x.sign && velocity.abs() > 600;
    _settle(!flungClosed && (x.abs() > open / 2 || flungOpen) ? open * x.sign : 0);
  }

  Future<void> _run(SwipeActionSpec action, double direction) async {
    if (!action.removesRow) {
      action.onTriggered();
      _settle(0);
      return;
    }
    if (_openRow.value == this) _openRow.value = null;
    _setArmedQuietly(true);
    await _offset.animateTo(direction * _width, duration: const Duration(milliseconds: 180), curve: Curves.easeOut);
    await _size.animateTo(0, curve: Curves.easeInOut);
    action.onTriggered();
    // The list normally drops this row now; bring it back if it doesn't.
    _restore = Timer(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      _offset.value = 0;
      _setArmedQuietly(false);
      _size.value = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final semanticsActions = {
      for (final a in [...widget.leading, ...widget.trailing])
        CustomSemanticsAction(label: a.label): () => _run(a, widget.leading.contains(a) ? 1 : -1),
    };
    return SizeTransition(
      sizeFactor: _size,
      alignment: Alignment.topCenter,
      child: Semantics(
        customSemanticsActions: widget.enabled ? semanticsActions : null,
        child: LayoutBuilder(
          builder: (context, constraints) {
            _width = constraints.maxWidth;
            return GestureDetector(
              onHorizontalDragStart: widget.enabled ? _onDragStart : null,
              onHorizontalDragUpdate: widget.enabled ? _onDragUpdate : null,
              onHorizontalDragEnd: widget.enabled ? _onDragEnd : null,
              child: AnimatedBuilder(
                animation: Listenable.merge([_offset, _arm]),
                child: widget.child,
                builder: (context, child) {
                  final x = _offset.value;
                  return ClipRect(
                    child: Stack(
                      children: [
                        if (x != 0) Positioned.fill(child: _buildActions(x)),
                        Transform.translate(offset: Offset(x, 0), child: child),
                        if (x != 0)
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: x > 0 ? x : 0,
                            right: x < 0 ? -x : 0,
                            child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: () => _settle(0)),
                          ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActions(double x) {
    final leading = x > 0;
    final actions = leading ? widget.leading : widget.trailing;
    if (actions.isEmpty) return const SizedBox.shrink();
    final revealed = x.abs();
    final arm = _arm.value;
    final buttons = <Widget>[
      for (final (i, a) in actions.indexed)
        SizedBox(
          width: lerpDouble(revealed / actions.length, i == 0 ? revealed : 0, arm),
          child: _ActionButton(
            action: a,
            alignment: i == 0 && arm > 0.5
                ? (leading ? Alignment.centerRight : Alignment.centerLeft)
                : Alignment.center,
            onTap: () => _run(a, leading ? 1 : -1),
          ),
        ),
    ];
    return Row(
      mainAxisAlignment: leading ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: leading ? buttons : buttons.reversed.toList(),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.action, required this.onTap, required this.alignment});

  final SwipeActionSpec action;
  final VoidCallback onTap;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(
        color: action.color,
        child: ClipRect(
          child: OverflowBox(
            maxWidth: double.infinity,
            alignment: alignment,
            child: SizedBox(
              width: _SwipeActionRowState._buttonWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(action.icon, color: Colors.white, size: 22),
                  const SizedBox(height: 4),
                  Text(
                    action.label,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
