import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../l10n/l10n.dart';
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

  /// The keys as shown on this platform: "⇧⌘R" on Apple, "Ctrl+Shift+R"
  /// elsewhere (key names in [l10n]'s words).
  List<String> keyLabels({required bool apple, required AppLocalizations l10n}) => [
    if (primary) apple ? '⌘' : l10n.keyboardKeyCtrl,
    if (shift) apple ? '⇧' : l10n.keyboardKeyShift,
    label ?? _keyLabel(key!, apple: apple, l10n: l10n),
  ];

  static String _keyLabel(LogicalKeyboardKey key, {required bool apple, required AppLocalizations l10n}) {
    if (key == LogicalKeyboardKey.enter) return apple ? '↩' : l10n.keyboardKeyEnter;
    if (key == LogicalKeyboardKey.escape) return l10n.keyboardKeyEsc;
    if (key == LogicalKeyboardKey.delete) return apple ? '⌦' : l10n.keyboardKeyDelete;
    if (key == LogicalKeyboardKey.backspace) return apple ? '⌫' : l10n.keyboardKeyBackspace;
    if (key == LogicalKeyboardKey.arrowDown) return '↓';
    if (key == LogicalKeyboardKey.arrowUp) return '↑';
    if (key == LogicalKeyboardKey.slash) return '/';
    return key.keyLabel.toUpperCase();
  }
}

/// A group of the cheat sheet.
enum ShortcutGroup {
  general,
  messages,
  compose;

  /// Its heading.
  String title(AppLocalizations l10n) => switch (this) {
    general => l10n.keyboardGroupGeneral,
    messages => l10n.keyboardGroupMessages,
    compose => l10n.keyboardGroupCompose,
  };
}

/// What a row of the cheat sheet says a shortcut does.
enum ShortcutLabel {
  newMessage,
  commandPalette,
  search,
  shortcuts,
  backClose,
  nextMessage,
  previousMessage,
  openMessage,
  reply,
  replyAll,
  forward,
  archive,
  moveToTrash,
  toggleRead,
  toggleFlag,
  send,
  closeDraft;

  /// In words.
  String text(AppLocalizations l10n) => switch (this) {
    newMessage => l10n.mailNewMessage,
    commandPalette => l10n.keyboardCommandPalette,
    search => l10n.commonSearch,
    shortcuts => l10n.keyboardShortcuts,
    backClose => l10n.keyboardBackClose,
    nextMessage => l10n.keyboardNextMessage,
    previousMessage => l10n.keyboardPreviousMessage,
    openMessage => l10n.keyboardOpenMessage,
    reply => l10n.mailReply,
    replyAll => l10n.mailReplyAll,
    forward => l10n.mailForward,
    archive => l10n.mailArchive,
    moveToTrash => l10n.keyboardMoveToTrash,
    toggleRead => l10n.keyboardToggleRead,
    toggleFlag => l10n.keyboardToggleFlag,
    send => l10n.mailSend,
    closeDraft => l10n.keyboardCloseDraft,
  };
}

/// A row of the cheat sheet: what [command] does and its keys.
@immutable
final class ShortcutEntry {
  const ShortcutEntry(this.group, this.label, this.command, this.combos);

  final ShortcutGroup group;
  final ShortcutLabel label;
  final MailCommand command;
  final List<KeyCombo> combos;
}

const _r = LogicalKeyboardKey.keyR;

/// Every shortcut. Plain letters follow Gmail and the issue (R, F, E, S,
/// J/K, /, Shift+U); the Ctrl/⌘ forms beside them are Apple Mail's and
/// Thunderbird's. Where those clash with a plain letter here, the letter
/// wins and the other app's key is noted in docs/tablet-and-keyboard.md.
const shortcutTable = [
  ShortcutEntry(ShortcutGroup.general, ShortcutLabel.newMessage, MailCommand.newMessage, [
    KeyCombo(LogicalKeyboardKey.keyN, primary: true),
  ]),
  ShortcutEntry(ShortcutGroup.general, ShortcutLabel.commandPalette, MailCommand.palette, [
    KeyCombo(LogicalKeyboardKey.keyK, primary: true),
  ]),
  ShortcutEntry(ShortcutGroup.general, ShortcutLabel.search, MailCommand.search, [
    KeyCombo.char('/'),
    KeyCombo(LogicalKeyboardKey.keyF, primary: true),
  ]),
  ShortcutEntry(ShortcutGroup.general, ShortcutLabel.shortcuts, MailCommand.shortcuts, [
    KeyCombo(LogicalKeyboardKey.slash, primary: true),
    KeyCombo.char('?'),
  ]),
  ShortcutEntry(ShortcutGroup.general, ShortcutLabel.backClose, MailCommand.back, [
    KeyCombo(LogicalKeyboardKey.escape),
  ]),
  ShortcutEntry(ShortcutGroup.messages, ShortcutLabel.nextMessage, MailCommand.nextMessage, [
    KeyCombo(LogicalKeyboardKey.keyJ),
    KeyCombo(LogicalKeyboardKey.arrowDown),
  ]),
  ShortcutEntry(ShortcutGroup.messages, ShortcutLabel.previousMessage, MailCommand.previousMessage, [
    KeyCombo(LogicalKeyboardKey.keyK),
    KeyCombo(LogicalKeyboardKey.arrowUp),
  ]),
  ShortcutEntry(ShortcutGroup.messages, ShortcutLabel.openMessage, MailCommand.open, [
    KeyCombo(LogicalKeyboardKey.enter),
  ]),
  ShortcutEntry(ShortcutGroup.messages, ShortcutLabel.reply, MailCommand.reply, [
    KeyCombo(_r),
    KeyCombo(_r, primary: true),
  ]),
  ShortcutEntry(ShortcutGroup.messages, ShortcutLabel.replyAll, MailCommand.replyAll, [
    KeyCombo(_r, shift: true),
    KeyCombo(_r, primary: true, shift: true),
  ]),
  ShortcutEntry(ShortcutGroup.messages, ShortcutLabel.forward, MailCommand.forward, [
    KeyCombo(LogicalKeyboardKey.keyF),
    KeyCombo(LogicalKeyboardKey.keyF, primary: true, shift: true),
    KeyCombo(LogicalKeyboardKey.keyL, primary: true),
  ]),
  ShortcutEntry(ShortcutGroup.messages, ShortcutLabel.archive, MailCommand.archive, [
    KeyCombo(LogicalKeyboardKey.keyE),
  ]),
  ShortcutEntry(ShortcutGroup.messages, ShortcutLabel.moveToTrash, MailCommand.trash, [
    KeyCombo(LogicalKeyboardKey.delete),
    KeyCombo(LogicalKeyboardKey.backspace),
    KeyCombo(LogicalKeyboardKey.backspace, primary: true),
  ]),
  ShortcutEntry(ShortcutGroup.messages, ShortcutLabel.toggleRead, MailCommand.toggleRead, [
    KeyCombo(LogicalKeyboardKey.keyU, shift: true),
    KeyCombo(LogicalKeyboardKey.keyU, primary: true, shift: true),
  ]),
  ShortcutEntry(ShortcutGroup.messages, ShortcutLabel.toggleFlag, MailCommand.toggleFlag, [
    KeyCombo(LogicalKeyboardKey.keyS),
    KeyCombo(LogicalKeyboardKey.keyL, primary: true, shift: true),
  ]),
  ShortcutEntry(ShortcutGroup.compose, ShortcutLabel.send, MailCommand.send, [
    KeyCombo(LogicalKeyboardKey.enter, primary: true),
    KeyCombo(LogicalKeyboardKey.keyD, primary: true, shift: true),
  ]),
  ShortcutEntry(ShortcutGroup.compose, ShortcutLabel.closeDraft, MailCommand.back, [
    KeyCombo(LogicalKeyboardKey.escape),
  ]),
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
List<String>? shortcutKeys(MailCommand command, AppLocalizations l10n) {
  for (final entry in shortcutTable) {
    if (entry.command == command) return entry.combos.first.keyLabels(apple: appleKeyboard, l10n: l10n);
  }
  return null;
}
