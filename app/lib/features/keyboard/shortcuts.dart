import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'mail_commands.dart';

/// A shortcut's command; [modified] when it needs Ctrl or ⌘ (those work
/// while typing, plain keys don't).
class MailIntent extends Intent {
  const MailIntent(this.command, {this.modified = false});

  final MailCommand command;
  final bool modified;
}

/// One key combination. [primary] is Ctrl, or ⌘ on Apple keyboards (both
/// are accepted everywhere: a Mac keyboard on an Android tablet still has ⌘).
@immutable
final class KeyCombo {
  const KeyCombo(LogicalKeyboardKey this.key, {this.primary = false, this.shift = false, this.label})
    : character = null;

  /// A typed character, whatever key and layout produce it ("?", "/").
  const KeyCombo.char(String this.character) : key = null, primary = false, shift = false, label = character;

  final LogicalKeyboardKey? key;
  final String? character;
  final bool primary;
  final bool shift;

  /// How the cheat sheet shows the key; defaults to its key label.
  final String? label;

  bool get modified => primary;

  /// The activators; held down, they fire again only with [repeats].
  List<ShortcutActivator> activators({bool repeats = false}) {
    final key = this.key;
    if (key == null) return [CharacterActivator(character!, includeRepeats: repeats)];
    if (!primary) return [SingleActivator(key, shift: shift, includeRepeats: repeats)];
    return [
      SingleActivator(key, control: true, shift: shift, includeRepeats: repeats),
      SingleActivator(key, meta: true, shift: shift, includeRepeats: repeats),
    ];
  }

  /// The keys as shown on this platform: "⇧⌘R" on Apple, "Ctrl+Shift+R" elsewhere.
  List<String> keyLabels({required bool apple}) => [
    if (primary) apple ? '⌘' : 'Ctrl',
    if (shift) apple ? '⇧' : 'Shift',
    label ?? _keyLabel(key!, apple: apple),
  ];

  static String _keyLabel(LogicalKeyboardKey key, {required bool apple}) {
    if (key == LogicalKeyboardKey.enter) return apple ? '↩' : 'Enter';
    if (key == LogicalKeyboardKey.escape) return 'Esc';
    if (key == LogicalKeyboardKey.delete) return apple ? '⌦' : 'Delete';
    if (key == LogicalKeyboardKey.backspace) return apple ? '⌫' : 'Backspace';
    if (key == LogicalKeyboardKey.arrowDown) return '↓';
    if (key == LogicalKeyboardKey.arrowUp) return '↑';
    if (key == LogicalKeyboardKey.slash) return '/';
    return key.keyLabel.toUpperCase();
  }
}

/// A row of the cheat sheet: what [command] does and its keys.
@immutable
final class ShortcutEntry {
  const ShortcutEntry(this.group, this.label, this.command, this.combos);

  final String group;
  final String label;
  final MailCommand command;
  final List<KeyCombo> combos;
}

const _r = LogicalKeyboardKey.keyR;

/// Every shortcut. Plain letters follow Gmail and the issue (R, F, E, S,
/// J/K, /, Shift+U); the Ctrl/⌘ forms beside them are Apple Mail's and
/// Thunderbird's. Where those clash with a plain letter here, the letter
/// wins and the other app's key is noted in docs/tablet-and-keyboard.md.
const shortcutTable = [
  ShortcutEntry('General', 'New Message', MailCommand.newMessage, [KeyCombo(LogicalKeyboardKey.keyN, primary: true)]),
  ShortcutEntry('General', 'Command Palette', MailCommand.palette, [KeyCombo(LogicalKeyboardKey.keyK, primary: true)]),
  ShortcutEntry('General', 'Search', MailCommand.search, [
    KeyCombo.char('/'),
    KeyCombo(LogicalKeyboardKey.keyF, primary: true),
  ]),
  ShortcutEntry('General', 'Keyboard Shortcuts', MailCommand.shortcuts, [
    KeyCombo(LogicalKeyboardKey.slash, primary: true),
    KeyCombo.char('?'),
  ]),
  ShortcutEntry('General', 'Back, Close', MailCommand.back, [KeyCombo(LogicalKeyboardKey.escape)]),
  ShortcutEntry('Messages', 'Next Message', MailCommand.nextMessage, [
    KeyCombo(LogicalKeyboardKey.keyJ),
    KeyCombo(LogicalKeyboardKey.arrowDown),
  ]),
  ShortcutEntry('Messages', 'Previous Message', MailCommand.previousMessage, [
    KeyCombo(LogicalKeyboardKey.keyK),
    KeyCombo(LogicalKeyboardKey.arrowUp),
  ]),
  ShortcutEntry('Messages', 'Open Message', MailCommand.open, [KeyCombo(LogicalKeyboardKey.enter)]),
  ShortcutEntry('Messages', 'Reply', MailCommand.reply, [KeyCombo(_r), KeyCombo(_r, primary: true)]),
  ShortcutEntry('Messages', 'Reply All', MailCommand.replyAll, [
    KeyCombo(_r, shift: true),
    KeyCombo(_r, primary: true, shift: true),
  ]),
  ShortcutEntry('Messages', 'Forward', MailCommand.forward, [
    KeyCombo(LogicalKeyboardKey.keyF),
    KeyCombo(LogicalKeyboardKey.keyF, primary: true, shift: true),
    KeyCombo(LogicalKeyboardKey.keyL, primary: true),
  ]),
  ShortcutEntry('Messages', 'Archive', MailCommand.archive, [KeyCombo(LogicalKeyboardKey.keyE)]),
  ShortcutEntry('Messages', 'Move to Trash', MailCommand.trash, [
    KeyCombo(LogicalKeyboardKey.delete),
    KeyCombo(LogicalKeyboardKey.backspace),
    KeyCombo(LogicalKeyboardKey.backspace, primary: true),
  ]),
  ShortcutEntry('Messages', 'Mark as Read or Unread', MailCommand.toggleRead, [
    KeyCombo(LogicalKeyboardKey.keyU, shift: true),
    KeyCombo(LogicalKeyboardKey.keyU, primary: true, shift: true),
  ]),
  ShortcutEntry('Messages', 'Flag or Unflag', MailCommand.toggleFlag, [
    KeyCombo(LogicalKeyboardKey.keyS),
    KeyCombo(LogicalKeyboardKey.keyL, primary: true, shift: true),
  ]),
  ShortcutEntry('Compose', 'Send', MailCommand.send, [
    KeyCombo(LogicalKeyboardKey.enter, primary: true),
    KeyCombo(LogicalKeyboardKey.keyD, primary: true, shift: true),
  ]),
  ShortcutEntry('Compose', 'Close (Save or Delete Draft)', MailCommand.back, [KeyCombo(LogicalKeyboardKey.escape)]),
];

/// The key bindings of [shortcutTable]. Only moving through the list
/// repeats while a key is held: holding E mustn't archive one conversation
/// after another.
Map<ShortcutActivator, Intent> mailShortcuts() => {
  for (final entry in shortcutTable)
    for (final combo in entry.combos)
      for (final activator in combo.activators(
        repeats: entry.command == MailCommand.nextMessage || entry.command == MailCommand.previousMessage,
      ))
        activator: MailIntent(entry.command, modified: combo.modified),
};

/// Whether keys are shown the Apple way (⌘, ⇧).
bool get appleKeyboard => switch (defaultTargetPlatform) {
  TargetPlatform.iOS || TargetPlatform.macOS => true,
  _ => false,
};

/// The keys of [command]'s first combination, as shown on this platform
/// (["E"], ["⌘", "N"]), for hints in the palette.
List<String>? shortcutKeys(MailCommand command) {
  for (final entry in shortcutTable) {
    if (entry.command == command) return entry.combos.first.keyLabels(apple: appleKeyboard);
  }
  return null;
}
