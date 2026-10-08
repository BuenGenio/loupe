import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../panes/mail_selection.dart';

/// Everything a keyboard shortcut or the command palette can ask for.
enum MailCommand {
  newMessage,
  send,
  reply,
  replyAll,
  forward,
  archive,
  trash,
  toggleRead,
  toggleFlag,
  snooze,
  move,
  markAllRead,

  /// Export Folder…: the list's folder as an mbox file.
  exportFolder,
  refresh,
  nextMessage,
  previousMessage,
  open,
  back,
  search,
  palette,
  shortcuts,
}

/// A screen that commands can act on: the conversation shown, a list, the
/// compose screen. It registers with [MailCommands] while mounted.
///
/// Of the scopes that [acceptsCommands] and [canRun] a command, the one with
/// the highest [priority] runs it (the newest among equals).
abstract interface class CommandScope {
  /// Compose 40, conversation 30, list 20, Mailboxes 10, the panes 0.
  int get priority;

  /// On screen and on top: its route is current (no sheet over it) and it
  /// isn't hidden (the closed sidebar, a page under another).
  bool get acceptsCommands;

  bool canRun(MailCommand command);

  void run(MailCommand command);
}

/// The scopes on screen.
class MailCommands {
  final _scopes = <CommandScope>[];

  void add(CommandScope scope) {
    _scopes
      ..remove(scope)
      ..add(scope);
  }

  void remove(CommandScope scope) => _scopes.remove(scope);

  /// Who runs [command] now, if anyone.
  CommandScope? handlerFor(MailCommand command) {
    CommandScope? best;
    for (final s in _scopes.reversed) {
      if (best != null && s.priority <= best.priority) continue;
      if (s.acceptsCommands && s.canRun(command)) best = s;
    }
    return best;
  }

  bool canRun(MailCommand command) => handlerFor(command) != null;

  /// Runs [command]; false if nobody could.
  bool run(MailCommand command) {
    final handler = handlerFor(command);
    handler?.run(command);
    return handler != null;
  }

  /// The newest scope of type [T], on top or not (the list a phone's
  /// conversation was opened from).
  T? latest<T>() {
    for (final s in _scopes.reversed) {
      if (s is T) return s as T;
    }
    return null;
  }
}

/// A message list that knows what comes before and after a conversation:
/// a phone's conversation page moves through it with J and K.
abstract interface class MessageListNeighbors {
  /// The row [delta] rows from [email]'s conversation; null at the ends or
  /// when it isn't listed.
  ThreadSummary? neighborOf(EmailSummary email, int delta);

  /// The row to show once the conversation of [selection] went away
  /// (archived, deleted): the next one, else the one before.
  ThreadSummary? replacementFor(MailSelection selection);
}

final mailCommandsProvider = Provider<MailCommands>((ref) => MailCommands());

/// Registers a [State] as a [CommandScope] from [initState] to [dispose].
mixin CommandScopeState<T extends StatefulWidget> on State<T> implements CommandScope {
  MailCommands? _commands;

  /// Call from [initState].
  void registerCommands(MailCommands commands) => _commands = commands..add(this);

  @override
  bool get acceptsCommands {
    if (!mounted) return false;
    final route = ModalRoute.of(context);
    if (route != null && !route.isCurrent) return false;
    return TickerMode.getValuesNotifier(context).value.enabled;
  }

  @override
  void dispose() {
    _commands?.remove(this);
    super.dispose();
  }
}
