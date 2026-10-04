// Styled text of one paragraph: runs → TextSpans, links with tap and
// long-press, inline icons and sub/superscripts as WidgetSpans.

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../model/document.dart';
import 'images.dart';
import 'scope.dart';

/// Renders [inlines] with [style] as the base. Selectable when inside a
/// SelectionArea.
class InlineText extends StatefulWidget {
  const InlineText(
    this.inlines, {
    super.key,
    required this.style,
    this.align = BlockAlign.start,
    this.dir = TextDir.auto,
    this.large = false,
    this.softWrap = true,
  });

  final List<Inline> inlines;
  final TextStyle style;
  final BlockAlign align;
  final TextDir dir;

  /// Headings: the large-text contrast minimum applies.
  final bool large;
  final bool softWrap;

  @override
  State<InlineText> createState() => _InlineTextState();
}

class _InlineTextState extends State<InlineText> {
  final _recognizers = <int, LinkGestureRecognizer>{};

  @override
  void dispose() {
    for (final r in _recognizers.values) {
      r.dispose();
    }
    super.dispose();
  }

  LinkGestureRecognizer _recognizer(ReaderScope scope, int link) {
    final r = _recognizers.putIfAbsent(link, LinkGestureRecognizer.new);
    r
      ..onTap = (() => scope.onLinkTap(link))
      ..onLongPress = (() => scope.onLinkLongPress(link));
    return r;
  }

  @override
  Widget build(BuildContext context) {
    final scope = ReaderScope.of(context);
    final spans = <InlineSpan>[for (final i in widget.inlines) _span(context, scope, i)];
    final text = inlineText(widget.inlines);
    return Text.rich(
      TextSpan(children: spans, style: widget.style),
      textAlign: textAlignFor(widget.align),
      textDirection: textDirectionFor(widget.dir, text),
      softWrap: widget.softWrap,
    );
  }

  InlineSpan _span(BuildContext context, ReaderScope scope, Inline inline) {
    switch (inline) {
      case InlineImage(:final image):
        return WidgetSpan(alignment: PlaceholderAlignment.middle, child: InlineIcon(image));
      case TextRun(:final text, style: final run):
        final style = runTextStyle(scope, widget.style, run, large: widget.large);
        if (run.script != ScriptPosition.normal) {
          return WidgetSpan(
            alignment: run.script == ScriptPosition.sup ? PlaceholderAlignment.top : PlaceholderAlignment.bottom,
            child: Text(text, style: style.copyWith(fontSize: (style.fontSize ?? 16) * 0.72)),
          );
        }
        final link = run.link;
        return TextSpan(
          text: text,
          style: style,
          recognizer: link == null ? null : _recognizer(scope, link),
          mouseCursor: link == null ? null : SystemMouseCursors.click,
        );
    }
  }
}

/// The Flutter style of a run over [base].
TextStyle runTextStyle(ReaderScope scope, TextStyle base, RunStyle run, {bool large = false}) {
  final size = (base.fontSize ?? 16) * run.scale;
  final isLink = run.link != null;
  final bg = run.background;
  final color = scope.textColor(
    run.color,
    bg: bg,
    large: large || run.scale >= 1.3,
    // Fine print without a colour of its own is secondary text.
    fallback: isLink && run.color == null ? scope.styles.link : (run.fine ? scope.styles.muted : base.color),
  );
  final decorations = <TextDecoration>[
    if (run.underline) TextDecoration.underline,
    if (run.strike) TextDecoration.lineThrough,
  ];
  var style = base.copyWith(
    fontSize: size,
    color: color,
    fontWeight: run.bold ? FontWeight.w700 : null,
    fontStyle: run.italic ? FontStyle.italic : null,
    decoration: decorations.isEmpty ? null : TextDecoration.combine(decorations),
    decorationColor: decorations.isEmpty ? null : color,
    backgroundColor: bg == null ? null : scope.highlight(bg),
  );
  if (run.mono && base.fontFamily != scope.styles.mono.fontFamily) {
    style = style.copyWith(
      fontFamily: scope.styles.mono.fontFamily,
      fontFamilyFallback: scope.styles.mono.fontFamilyFallback,
      fontSize: size * 0.92,
    );
  }
  return style;
}

/// Tap and long-press on one text span (a TextSpan takes one recognizer).
///
/// A TapGestureRecognizer underneath, so semantics still expose the link's
/// tap. The long press fires slightly before the framework's and claims the
/// gesture, so a SelectionArea doesn't also start selecting the word.
class LinkGestureRecognizer extends TapGestureRecognizer {
  LinkGestureRecognizer({super.debugOwner});

  VoidCallback? onLongPress;

  Timer? _timer;
  bool _longPressed = false;

  static const longPressDelay = Duration(milliseconds: 350);

  @override
  void handleTapDown({required PointerDownEvent down}) {
    _longPressed = false;
    _timer?.cancel();
    if (onLongPress != null) {
      _timer = Timer(longPressDelay, () {
        _longPressed = true;
        resolve(GestureDisposition.accepted);
        onLongPress?.call();
      });
    }
    super.handleTapDown(down: down);
  }

  @override
  void handleTapUp({required PointerDownEvent down, required PointerUpEvent up}) {
    _timer?.cancel();
    if (_longPressed) {
      _longPressed = false;
      return;
    }
    super.handleTapUp(down: down, up: up);
  }

  @override
  void handleTapCancel({required PointerDownEvent down, PointerCancelEvent? cancel, required String reason}) {
    _timer?.cancel();
    _longPressed = false;
    super.handleTapCancel(down: down, cancel: cancel, reason: reason);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  String get debugDescription => 'link tap';
}
