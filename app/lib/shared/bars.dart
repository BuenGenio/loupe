import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// A translucent bottom toolbar with a hairline on top, like iOS toolbars.
class LoupeBottomBar extends StatelessWidget {
  const LoupeBottomBar({super.key, this.leading, this.center, this.trailing, this.height = 50});

  final Widget? leading;
  final Widget? center;
  final Widget? trailing;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.barBackground,
            border: Border(top: BorderSide(color: colors.separator, width: 0.5)),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  children: [
                    SizedBox(
                      width: 64,
                      child: Align(alignment: Alignment.centerLeft, child: leading),
                    ),
                    Expanded(child: Center(child: center)),
                    SizedBox(
                      width: 64,
                      child: Align(alignment: Alignment.centerRight, child: trailing),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// An icon button in a bar, tinted with the accent colour.
class BarIconButton extends StatelessWidget {
  const BarIconButton({super.key, required this.icon, required this.onPressed, required this.tooltip, this.size = 25});

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      excludeFromSemantics: true,
      child: Semantics(
        button: true,
        label: tooltip,
        child: CupertinoButton(
          padding: const EdgeInsets.all(8),
          minimumSize: const Size(44, 44),
          onPressed: onPressed,
          child: Icon(icon, size: size),
        ),
      ),
    );
  }
}

/// A text button in a navigation bar ("Edit", "Done").
class BarTextButton extends StatelessWidget {
  const BarTextButton({super.key, required this.label, required this.onPressed, this.bold = false});

  final String label;
  final VoidCallback? onPressed;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: const Size(44, 44),
      onPressed: onPressed,
      child: Text(label, style: TextStyle(fontWeight: bold ? FontWeight.w600 : FontWeight.w400, fontSize: 17)),
    );
  }
}

/// Height of the search field row of `CupertinoSliverNavigationBar.search`,
/// so a list can start scrolled past it (hidden until pulled down).
double searchBarExtent(BuildContext context) {
  final scale = MediaQuery.textScalerOf(context).scale(36) / 36;
  final damped = scale < 1 ? math.max(0.9, scale) : 1 + (scale - 1) / 1.235;
  return 36 * damped + 8;
}

/// The search field used in navigation bars.
class LoupeSearchField extends StatelessWidget {
  const LoupeSearchField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.placeholder = 'Search',
    this.autofocus = false,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String placeholder;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return CupertinoSearchTextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      placeholder: placeholder,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autocorrect: false,
      backgroundColor: colors.fill,
      style: LoupeTextStyles.of(context).body,
      placeholderStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.secondaryText),
    );
  }
}
