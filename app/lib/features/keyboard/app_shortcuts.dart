import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../router.dart';
import '../../settings/app_mode.dart';
import '../compose/compose_args.dart';
import '../palette/command_palette.dart';
import 'mail_commands.dart';
import 'shortcut_sheet.dart';
import 'shortcuts.dart';

/// Hardware keyboard shortcuts for the whole app (see [shortcutTable]).
///
/// The screen on top acts on them through [MailCommands]: the conversation,
/// the list, the compose screen. What none of them takes is handled here:
/// New Message, the command palette, the cheat sheet, the search screen and
/// Back. Plain keys never fire while a text field has focus, and Enter and
/// the arrows leave a focused button alone; Ctrl/⌘ combinations always work.
/// Nothing fires under a dialog or sheet (its route is on top), except Esc,
/// which goes to it.
class AppShortcuts extends ConsumerStatefulWidget {
  const AppShortcuts({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppShortcuts> createState() => _AppShortcutsState();
}

class _AppShortcutsState extends ConsumerState<AppShortcuts> {
  late final _shortcuts = mailShortcuts();

  /// Holds the focus at start, so keys reach the shortcuts before any
  /// route takes it.
  final _focus = FocusNode(debugLabel: 'App shortcuts');

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  MailCommands get _commands => ref.read(mailCommandsProvider);

  NavigatorState? get _navigator => ref.read(routerProvider).routerDelegate.navigatorKey.currentState;

  BuildContext? get _focusContext => FocusManager.instance.primaryFocus?.context;

  /// A text field has the focus.
  bool get _typing {
    final c = _focusContext;
    return c != null && (c.widget is EditableText || c.findAncestorWidgetOfExactType<EditableText>() != null);
  }

  /// A button, row or field has the focus (not just a route or this).
  bool get _controlFocused {
    final node = FocusManager.instance.primaryFocus;
    return node != null && node != _focus && node is! FocusScopeNode;
  }

  /// A dialog or sheet is on top.
  bool get _popupOnTop {
    final c = _focusContext;
    return c != null && ModalRoute.of(c) is PopupRoute;
  }

  /// The compose screen is on top.
  bool get _composing => _commands.handlerFor(MailCommand.send) != null;

  bool _enabled(MailIntent intent) {
    final command = intent.command;
    if (command == MailCommand.back) {
      if (_popupOnTop) return false; // its own Esc (DismissIntent) closes it
      return !_typing || _commands.canRun(command);
    }
    if (_popupOnTop) return false;
    if (!intent.modified && _typing) return false;
    final arrowOrEnter =
        command == MailCommand.open || command == MailCommand.nextMessage || command == MailCommand.previousMessage;
    if (!intent.modified && arrowOrEnter && _controlFocused && !_commands.canRun(command)) return false;
    // Before the first account (the welcome screen) there is no mail.
    final hasMail = ref.read(appModeProvider) != AppMode.none;
    return switch (command) {
      MailCommand.newMessage => hasMail && !_composing,
      MailCommand.palette || MailCommand.search => hasMail,
      MailCommand.shortcuts => true,
      _ => _commands.canRun(command),
    };
  }

  void _invoke(MailIntent intent) {
    final command = intent.command;
    if (_commands.run(command)) return;
    final router = ref.read(routerProvider);
    final navigator = _navigator;
    switch (command) {
      case MailCommand.newMessage:
        unawaited(router.push<void>(Routes.compose, extra: const ComposeArgs()));
      case MailCommand.search:
        unawaited(router.push<void>(Routes.search('')));
      case MailCommand.palette:
        if (navigator != null) unawaited(showCommandPalette(navigator.context));
      case MailCommand.shortcuts:
        if (navigator != null) unawaited(showShortcutSheet(navigator.context));
      case MailCommand.back:
        unawaited(navigator?.maybePop());
      default:
    }
  }

  @override
  Widget build(BuildContext context) => Shortcuts(
    shortcuts: _shortcuts,
    child: Actions(
      actions: {MailIntent: _MailAction(enabled: _enabled, onInvoke: _invoke)},
      child: Focus(focusNode: _focus, autofocus: true, child: widget.child),
    ),
  );
}

class _MailAction extends Action<MailIntent> {
  _MailAction({required this.enabled, required this.onInvoke});

  final bool Function(MailIntent intent) enabled;
  final void Function(MailIntent intent) onInvoke;

  @override
  bool isEnabled(MailIntent intent) => enabled(intent);

  @override
  Object? invoke(MailIntent intent) {
    onInvoke(intent);
    return null;
  }
}
